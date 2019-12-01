IF OBJECT_ID('dbo.sp_PerfSQ', 'P') IS NULL EXECUTE('CREATE PROCEDURE dbo.sp_PerfSQ AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_PerfSQ(
    @ParamSniff   float = NULL
  , @SessionLocks bit   = NULL
)
AS
/*
-----------------------------------------------------------------------------------------
https://www.sqlservercentral.com/articles/query-performance-diagnostics-with-sp_perfsq
-- sp_PerfSQ: Query Shaping tool identifying Performance features of active SQL Queries
-- Copyright (C) 2018, 2019 Edward Haynes
-- 
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Lesser General Public License as published
--    by the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
-- 
--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU Lesser General Public License for more details.
-- 
--    You should have received a copy of the GNU Lesser General Public License
--    along with this program.  If not, see <https://www.gnu.org/licenses/>.
-- 
-- 
-- Stored procedure designed to work with SQL Server 2008 R2 and higher
-- providing on-demand performance detail from DMVs for queries with executing requests
-- 
-- Optional Parameters:
--    @ParamSniff   = Parameter Sniffing sensitivity multiplier
--                    < 1.0 (more hits);  1 or NULL (DEFAULT);  > 1.0 (less hits)
--                    Must be within the range of 0 to 2.0 otherwise will default to 1.0
-- 
--    @SessionLocks = 0 or NULL -- No locking detail (DEFAULT)
--                  = 1         -- Detailed locking  (performance overhead)
-- 
-- Example Usage:
--    EXEC dbo.sp_PerfSQ
--    GO
-- 
--    EXEC dbo.sp_PerfSQ @ParamSniff=0.75, @SessionLocks=1
--    GO
-- 
-- Email: QueryShape@gmail.com
-- 
*/
BEGIN
SET NOCOUNT ON;

DECLARE @Version nvarchar(20);
SET @Version = N'4.5.17';

DECLARE @tmpSchedulers TABLE (RunnableCountAvg int NULL, PendingIOCountAvg int NULL, ThreadShortageAvg int NULL, CPUAllocation nvarchar(50) NULL);

DECLARE @ProcessMemLow     int,
        @SystemMemLow      int,
        @MaxServerMemory   int,
        @PhysicalMemory    bigint,
        @PhysicalMemInUse  bigint,
        @KernelNonPaged    bigint,
        @RunnableCountAvg  int,
        @PendingIOCountAvg int,
        @ThreadShortageAvg int,
        @CPUAllocation     nvarchar(50),
        @VerCleanupRatio   float,
        @Runtime           datetime,
        @CmdLine           nvarchar(100),
        @SQLVersion        nvarchar(500) ;

SET @ParamSniff   = (CASE WHEN @ParamSniff < CONVERT(float,0.0) OR @ParamSniff > CONVERT(float,2.0) THEN CONVERT(float,1.0) ELSE ISNULL(@ParamSniff,CONVERT(float,1.0)) END);
SET @SessionLocks = ISNULL(@SessionLocks,CONVERT(bit,0)) ;
SET @CmdLine      = N'EXEC sp_PerfSQ ' + N'@ParamSniff=' + CONVERT(nvarchar(20),@ParamSniff) + N', @SessionLocks=' + CONVERT(nvarchar(1),@SessionLocks) + N'  --v' + @Version;
SET @Runtime      = GETDATE();

SET @SQLVersion = CONVERT(nvarchar(500),@@Version);
SET @SQLVersion = LEFT(@SQLVersion,CHARINDEX(N'COPY',UPPER(@SQLVersion)) - 1);

SET @ProcessMemLow =
    (SELECT COUNT(1)
       FROM sys.dm_os_process_memory WITH (NOLOCK)
      WHERE process_physical_memory_low = CONVERT(bit,1)) ;

SET @SystemMemLow =
    (SELECT COUNT(1)
       FROM sys.dm_os_sys_memory WITH (NOLOCK)
      WHERE system_high_memory_signal_state = CONVERT(bit,0)
        AND system_low_memory_signal_state  = CONVERT(bit,1)) ;

SET @MaxServerMemory =
    (SELECT top 1 CONVERT(int,value_in_use)
       FROM sys.configurations WITH (NOLOCK)
      WHERE [name] = 'max server memory (MB)') ;

SET @PhysicalMemory =
    (SELECT top 1 total_physical_memory_kb / 1024
       FROM sys.dm_os_sys_memory WITH (NOLOCK)) ;

SET @PhysicalMemInUse =
    (SELECT top 1 physical_memory_in_use_kb / 1024
       FROM sys.dm_os_process_memory WITH (NOLOCK)) ;

SET @KernelNonPaged =
    (SELECT top 1 kernel_nonpaged_pool_kb / 1024
       FROM sys.dm_os_sys_memory WITH (NOLOCK)) ;

INSERT INTO @tmpSchedulers (RunnableCountAvg, PendingIOCountAvg, ThreadShortageAvg, CPUAllocation)
SELECT AVG(os.runnable_tasks_count)   as RunnableCountAvg,
       AVG(os.pending_disk_io_count)  as PendingIOCountAvg,
       AVG(os.work_queue_count)       as ThreadShortageAvg,
       CONVERT(nvarchar(20),COUNT(1)) + N' of ' + CONVERT(nvarchar(20),SUM(CONVERT(int,os.is_online)))
                                      as CPUAllocation
  FROM sys.dm_os_schedulers os WITH (NOLOCK)
 WHERE os.scheduler_id < 1048576 ;

SET @RunnableCountAvg =
    (SELECT top 1 RunnableCountAvg
       FROM @tmpSchedulers) ;

SET @PendingIOCountAvg =
    (SELECT top 1 PendingIOCountAvg
       FROM @tmpSchedulers) ;

SET @ThreadShortageAvg =
    (SELECT top 1 ThreadShortageAvg
       FROM @tmpSchedulers) ;

SET @CPUAllocation =
    (SELECT top 1 CPUAllocation
       FROM @tmpSchedulers) ;

SET @VerCleanupRatio =
    (SELECT top 1 CONVERT(float,(cntr_value/1024.0) * 100.0)
       FROM sys.dm_os_performance_counters WITH (NOLOCK)
      WHERE counter_name = N'Version Cleanup rate (KB/s)'
        AND 0 < CHARINDEX(N'Transactions',[object_name])) / (SELECT top 1 CONVERT(float,cntr_value/1024.0)
                                                               FROM sys.dm_os_performance_counters WITH (NOLOCK)
                                                              WHERE counter_name = N'Version Generation rate (KB/s)'
                                                                AND 0 < CONVERT(float,cntr_value/1024.0)
                                                                AND 0 < CHARINDEX(N'Transactions',[object_name])) ;

PRINT @CmdLine ;
PRINT N''
PRINT @SQLVersion
PRINT N'Memory'
PRINT N'    Total Physical Memory : ' + CONVERT(nvarchar(20),@PhysicalMemory)   + N' MB'
PRINT N'    Max SQL Server Memory : ' + CONVERT(nvarchar(20),@MaxServerMemory)  + N' MB'
PRINT N'    Physical Memory In Use: ' + CONVERT(nvarchar(20),@PhysicalMemInUse) + N' MB' + (CASE WHEN (@ProcessMemLow + @SystemMemLow) > 0 THEN N' (memory pressure)' ELSE N'' END)
PRINT N'    Kernel Non-Paged Pool : ' + CONVERT(nvarchar(20),@KernelNonPaged)   + N' MB'
PRINT N'Schedulers'
PRINT N'    Avg CPU Queue Length  : ' + CONVERT(nvarchar(20),@RunnableCountAvg)
PRINT N'    Avg IO Pending Count  : ' + CONVERT(nvarchar(20),@PendingIOCountAvg)
PRINT N'    Avg Thread Shortage   : ' + CONVERT(nvarchar(20),@ThreadShortageAvg)
PRINT N'    CPU Allocation        : ' + @CPUAllocation
PRINT N'Version Store'
PRINT N'    Version Cleanup Ratio : ' + ISNULL(CONVERT(nvarchar(20),CONVERT(numeric(16,2),@VerCleanupRatio)) + N'%',N'NA')
PRINT N''

;WITH XMLNAMESPACES(DEFAULT N'http://schemas.microsoft.com/sqlserver/2004/07/showplan'),
      cteQRequests (SPID,DatabaseName,[Status],RuntimeSec,BlockedBy,DatabaseMaint,EstFinishTime,MemRequestMB,MemGrantMB,MemGrantWait,DOP,query_cost,PAGEIOLATCHms,PAGELATCHms,RunnableCount,SpinLoopFlag,ThreadShortageFlag,ProgramName,OriginalLogin,sql_handle,statement_start_offset,statement_end_offset,plan_handle)
   AS (SELECT r.session_id                   as SPID,
              DB_NAME(s.database_id)         as DatabaseName,
              (CASE UPPER(r.[status])
                    WHEN N'BACKGROUND' THEN CONVERT(int,1)
                    WHEN N'RUNNING'    THEN CONVERT(int,2)
                    WHEN N'RUNNABLE'   THEN CONVERT(int,3)
                    WHEN N'SLEEPING'   THEN CONVERT(int,4)
                    WHEN N'SUSPENDED'  THEN CONVERT(int,5)
                    ELSE CONVERT(int,NULL)
                END)                         as [Status],
              CONVERT(int,r.total_elapsed_time / 1000)
                                             as RuntimeSec,
              (CASE WHEN r.blocking_session_id = 0 THEN CONVERT(smallint,NULL) ELSE r.blocking_session_id END)
                                             as BlockedBy,
              r.command                      as DatabaseMaint,
              r.estimated_completion_time    as EstFinishTime,
              CONVERT(float,m.requested_memory_kb / 1024.0)
                                             as MemRequestMB,
              CONVERT(float,m.granted_memory_kb / 1024.0)
                                             as MemGrantMB,
              (CASE WHEN m.session_id = r.session_id AND m.request_id = r.request_id AND m.grant_time IS NULL THEN CONVERT(int,1) ELSE CONVERT(int,0) END)
                                             as MemGrantWait,
              m.dop                          as DOP,
              m.query_cost                   as query_cost,
              (CASE WHEN r.wait_type LIKE N'PAGEIOLATCH_%' THEN r.wait_time ELSE CONVERT(int,NULL) END)
                                             as PAGEIOLATCHms,
              (CASE WHEN r.wait_type LIKE N'PAGELATCH_%' THEN r.wait_time ELSE CONVERT(int,NULL) END)
                                             as PAGELATCHms,
              st.RunnableCount               as RunnableCount,
              st.SpinLoopFlag                as SpinLoopFlag,
              st.ThreadShortageFlag          as ThreadShortageFlag,
              s.[program_name]               as ProgramName,
              s.original_login_name          as OriginalLogin,
              r.sql_handle,
              r.statement_start_offset,
              r.statement_end_offset,
              r.plan_handle
         FROM sys.dm_exec_requests r
               LEFT JOIN sys.dm_exec_sessions s WITH (NOLOCK)
                      ON s.session_id  = r.session_id
               LEFT JOIN sys.dm_exec_query_memory_grants m WITH (NOLOCK)
                      ON m.session_id  = r.session_id
                     AND m.request_id  = r.request_id
               LEFT JOIN (SELECT ot.session_id,
                                 MAX((CASE WHEN ot.task_state = N'RUNNABLE'
                                           THEN os.runnable_tasks_count
                                           ELSE CONVERT(int,0)
                                       END))                  as RunnableCount,
                                 MAX((CASE WHEN ot.task_state = N'SPINLOOP'
                                           THEN CONVERT(int,1)
                                           ELSE CONVERT(int,0)
                                       END))                  as SpinLoopFlag,
                                 MAX((CASE WHEN ot.task_state = N'PENDING'
                                           THEN CONVERT(int,1)
                                           ELSE CONVERT(int,0)
                                       END))                  as ThreadShortageFlag
                            FROM sys.dm_os_schedulers os WITH (NOLOCK)
                                 INNER JOIN sys.dm_os_tasks ot WITH (NOLOCK)
                                         ON ot.scheduler_id = os.scheduler_id
                                        AND ot.task_state IN (N'RUNNABLE',N'SPINLOOP',N'PENDING')
                                        AND ot.scheduler_id < 1048576
                           GROUP BY ot.session_id) st
                      ON st.session_id = r.session_id
        WHERE r.database_id <> 32767
          AND r.session_id > 0
          AND r.session_id <> @@SPID
          AND r.sql_handle = (SELECT top 1 r2.sql_handle
                                FROM sys.dm_exec_requests r2 WITH (NOLOCK)
                               WHERE r2.session_id = r.session_id
                               ORDER BY r2.start_time DESC)
          AND r.statement_start_offset = (SELECT top 1 r3.statement_start_offset
                                            FROM sys.dm_exec_requests r3 WITH (NOLOCK)
                                           WHERE r3.session_id = r.session_id
                                             AND r3.sql_handle = r.sql_handle
                                           ORDER BY r3.start_time DESC)
      ),
      cteSLocks (SPID,SessionLocks)
   AS (SELECT qr.SPID,
              CONVERT(nvarchar(max),ISNULL(
              STUFF((SELECT N',' + ISNULL(CONVERT(nvarchar(200),tl.request_mode + N' (' + tl.request_status + N':' + tl.resource_type
                                       + (CASE tl.resource_type
                                               WHEN N'DATABASE' THEN N':' + ISNULL(DB_NAME(tl.resource_database_id),N'')
                                               WHEN N'OBJECT'   THEN N':' + ISNULL(OBJECT_NAME(tl.resource_associated_entity_id,tl.resource_database_id),N'') + ISNULL(N'[' + CONVERT(nvarchar(10),i.UnusedIndexCount) + N']',N'')
                                               ELSE N''
                                           END) + N')') + N'x' + CONVERT(nvarchar(10),COUNT(1)),N'')
                       FROM sys.dm_tran_locks tl WITH (NOLOCK)
                            OUTER APPLY (SELECT ius.database_id,
                                                ius.[object_id],
                                                COUNT(1) as UnusedIndexCount
                                           FROM sys.dm_db_index_usage_stats ius WITH (NOLOCK)
                                          WHERE ius.database_id  = tl.resource_database_id
                                            AND ius.[object_id]  = tl.resource_associated_entity_id
                                            AND ius.user_updates > (ius.user_seeks + ius.user_lookups + ius.user_scans)
                                            AND tl.resource_type = N'OBJECT'
                                          GROUP BY ius.database_id,
                                                   ius.[object_id]) i
                      WHERE tl.request_session_id = qr.SPID
                        AND N'NULL' <> ISNULL(tl.request_mode,N'NULL')
                      GROUP BY CONVERT(nvarchar(200),tl.request_mode + N' (' + tl.request_status + N':' + tl.resource_type
                                       + (CASE tl.resource_type
                                               WHEN N'DATABASE' THEN N':' + ISNULL(DB_NAME(tl.resource_database_id),N'')
                                               WHEN N'OBJECT'   THEN N':' + ISNULL(OBJECT_NAME(tl.resource_associated_entity_id,tl.resource_database_id),N'') + ISNULL(N'[' + CONVERT(nvarchar(10),i.UnusedIndexCount) + N']',N'')
                                               ELSE N''
                                           END) + N')')
                     FOR XML PATH('')),1,1,N''),N''))
                                             as SessionLocks
         FROM (SELECT SPID FROM cteQRequests WHERE @SessionLocks = CONVERT(bit,1) GROUP BY SPID) qr
      ),
      cteTempdb (SPID,TempdbWaitms,CursorOpen,CursorDormantms,TempdbDeallocMB,TempdbAllocMB,VerActive,VerDuration)
   AS (SELECT qr.SPID,
              (SELECT MAX(wt.wait_duration_ms)
                 FROM sys.dm_os_waiting_tasks wt WITH (NOLOCK)
                WHERE wt.session_id = qr.SPID
                  AND wt.wait_type LIKE 'PAGE%LATCH_%'
                  AND wt.resource_description LIKE CONVERT(nvarchar(10),DB_ID(N'tempdb')) + N':%')
                                             as TempdbWaitms,
              (SELECT COUNT(1)
                 FROM sys.dm_exec_cursors (qr.SPID)
                WHERE is_open = CONVERT(bit,1))
                                             as CursorOpen,
              (SELECT MAX(dormant_duration)
                 FROM sys.dm_exec_cursors (qr.SPID)
                WHERE is_open = CONVERT(bit,1))
                                             as CursorDormantms,
              (SELECT CONVERT(float,SUM(tsu.internal_objects_dealloc_page_count + tsu.user_objects_dealloc_page_count) / 128.0)
                 FROM tempdb.sys.dm_db_task_space_usage tsu WITH (NOLOCK)
                WHERE tsu.session_id = qr.SPID)
                                             as TempdbDeallocMB,
              (SELECT CONVERT(float,SUM(tsu.internal_objects_alloc_page_count + tsu.user_objects_alloc_page_count) / 128.0)
                 FROM tempdb.sys.dm_db_task_space_usage tsu WITH (NOLOCK)
                WHERE tsu.session_id = qr.SPID)
                                             as TempdbAllocMB,
              (SELECT COUNT(1)
                 FROM sys.dm_tran_active_snapshot_database_transactions v WITH (NOLOCK)
                WHERE v.session_id = qr.SPID
                  AND v.commit_sequence_num IS NULL)
                                             as VerActive,
              (SELECT MAX(v.elapsed_time_seconds)
                 FROM sys.dm_tran_active_snapshot_database_transactions v WITH (NOLOCK)
                WHERE v.session_id = qr.SPID
                  AND v.commit_sequence_num IS NULL)
                                             as VerDuration
         FROM cteQRequests qr
        GROUP BY qr.SPID
      ),
      cteQPlan (plan_handle,PlanType,ObjectName,ParameterList,Cardinality,[AvgMissingIndex%],SortRows,TableScanRows,MissingJoin)
   AS (SELECT qr.plan_handle,
              (SELECT top 1 RTRIM(cp.objtype)
                 FROM sys.dm_exec_cached_plans cp WITH (NOLOCK)
                WHERE cp.plan_handle = qr.plan_handle)
                                             as PlanType,
              CONVERT(nvarchar(129),ISNULL(N':' + OBJECT_NAME(qp.objectid,qp.dbid),N''))
                                             as ObjectName,
              CONVERT(nvarchar(max),
              STUFF((SELECT N',' + l.value('@Column', 'nvarchar(128)') + N'=' + l.value('@ParameterCompiledValue', 'nvarchar(4000)')
                       FROM qp.query_plan.nodes('//ParameterList/ColumnReference') AS prm(l)
                     FOR XML PATH('')),1,1,N''))
                                             as ParameterList,
              (SELECT CONVERT(float,MAX(s.value('@StatementEstRows', 'float')))
                 FROM qp.query_plan.nodes('//StmtSimple') stmt(s))
                                             as Cardinality,
              (SELECT CONVERT(float,AVG(i.value('@Impact', 'float')))
                 FROM qp.query_plan.nodes('.//MissingIndexGroup') midx(i))
                                             as [AvgMissingIndex%],
              (SELECT CONVERT(float,SUM(op.value('@EstimateRows', 'float')))
                 FROM qp.query_plan.nodes('//RelOp') rel(op)
                WHERE N'Sort' = op.value('@PhysicalOp','nvarchar(60)'))
                                             as SortRows,
              (SELECT CONVERT(float,SUM(op.value('@EstimateRows', 'float')))
                 FROM qp.query_plan.nodes('//RelOp') rel(op)
                WHERE N'Table Scan' = op.value('@PhysicalOp','nvarchar(60)'))
                                             as TableScanRows,
              (SELECT COUNT(1)
                 FROM qp.query_plan.nodes('//Warnings[(@NoJoinPredicate[.="1"])]') nojoin(p))
                                             as MissingJoin
         FROM (SELECT plan_handle FROM cteQRequests WHERE plan_handle IS NOT NULL GROUP BY plan_handle) qr
              CROSS APPLY sys.dm_exec_query_plan(qr.plan_handle) qp
      ),
      cteQStats (sql_handle,plan_handle,RunCount,MinTimeSec,MaxTimeSec,MinRows,MaxRows,AvgCpuLowms,CpuHighms,AvgLogicalReadsMB,[PhyReads%])
   AS (SELECT qr.sql_handle,
              qr.plan_handle,
              MAX(qs.execution_count)        as RunCount,
              CONVERT(bigint,(MIN(qs.min_elapsed_time) / 1000) / 1000)
                                             as MinTimeSec,
              CONVERT(bigint,(MAX(qs.max_elapsed_time) / 1000) / 1000)
                                             as MaxTimeSec,
              MIN(qs.min_rows)               as MinRows,
              MAX(qs.max_rows)               as MaxRows,
              CONVERT(bigint,AVG(qs.min_worker_time) / 1000)
                                             as AvgCpuLowms,
              CONVERT(bigint,MAX(qs.max_worker_time) / 1000)
                                             as CpuHighms,
              CONVERT(float,(MAX(qs.total_logical_reads) / MAX(qs.execution_count)) / 128.0)
                                             as AvgLogicalReadsMB,
              (CASE WHEN MAX(qs.total_logical_reads) >= CONVERT(bigint,1)
                    THEN CONVERT(float,MAX(qs.total_physical_reads) * 100.0) / CONVERT(float,MAX(qs.total_logical_reads))
                    ELSE CONVERT(float,0.0)
                END)                         as [PhyReads%]
         FROM (SELECT sql_handle, plan_handle FROM cteQRequests GROUP BY sql_handle, plan_handle) qr
               LEFT JOIN sys.dm_exec_query_stats qs WITH (NOLOCK)
                      ON qs.sql_handle  = qr.sql_handle
                     AND qs.plan_handle = qr.plan_handle
        GROUP BY qr.sql_handle,
                 qr.plan_handle
      )
SELECT qr.SPID,
       MAX(qr.DatabaseName)                  as DatabaseName,
       (CASE MIN(qr.[Status])
             WHEN 1 THEN CONVERT(nvarchar(10),N'Background')
             WHEN 2 THEN CONVERT(nvarchar(10),N'Running')
             WHEN 3 THEN CONVERT(nvarchar(10),N'Runnable')
             WHEN 4 THEN CONVERT(nvarchar(10),N'Sleeping')
             WHEN 5 THEN CONVERT(nvarchar(10),N'Suspended')
             ELSE CONVERT(nvarchar(10),NULL)
         END)                                as [Status],
       (CASE WHEN UPPER(MAX(qp.PlanType)) = N'PROC'
                  THEN CONVERT(nvarchar(133),N'Proc' + MAX(qp.ObjectName))
                  ELSE CONVERT(nvarchar(133),MAX(qp.PlanType))
         END)                                as PlanType,
       (CASE WHEN MAX(qr.query_cost) <     10 THEN CONVERT(nvarchar(10),N'Low')
             WHEN MAX(qr.query_cost) <    100 THEN CONVERT(nvarchar(10),N'Medium')
             WHEN MAX(qr.query_cost) <   1000 THEN CONVERT(nvarchar(10),N'Med-High')
             WHEN MAX(qr.query_cost) <  10000 THEN CONVERT(nvarchar(10),N'High')
             WHEN MAX(qr.query_cost) >= 10000 THEN CONVERT(nvarchar(10),N'VHigh')
             ELSE CONVERT(nvarchar(10),NULL)
         END)                                as QueryCost,
       CONVERT(nvarchar(200),REPLACE(REPLACE(RTRIM(
       (CASE WHEN MIN(qr.[Status]) <> 2 AND MAX(qr.RunnableCount) > 2 AND @RunnableCountAvg > 1
                  THEN CONVERT(nvarchar(8),N'CPUWait ')
                  ELSE N'' END +
        CASE WHEN MAX(t.CursorOpen) > 0 AND MAX(t.CursorDormantms) >= 1
                  THEN CONVERT(nvarchar(27),N'Cursor(' + CONVERT(nvarchar(16),MAX(t.CursorDormantms)) + N'ms) ')
                  ELSE N'' END +
        CASE WHEN MAX(qr.EstFinishTime) >= 1
                  THEN CONVERT(nvarchar(41),REPLACE(MAX(qr.DatabaseMaint),N' ',N'~')) + N'('
                        + (CASE WHEN (MAX(qr.EstFinishTime) / 60000) > 600
                                     THEN N'>10hr) '
                                     ELSE CONVERT(nvarchar(3),MAX(qr.EstFinishTime) / 60000) + N'min) '
                            END)
                  ELSE N'' END +
        CASE WHEN MAX(qr.query_cost) >= 10 AND MAX(qp.[AvgMissingIndex%]) > 20
                  THEN CONVERT(nvarchar(7),N'IdxGap ')
                  ELSE N'' END +
        CASE WHEN CHARINDEX(N'[',MAX(sl.SessionLocks)) > 0
                  THEN CONVERT(nvarchar(8),N'IdxIdle ')
                  ELSE N'' END +
        CASE WHEN SUM(qr.MemGrantMB) > CONVERT(float,SUM(qr.MemRequestMB) + 0.00001)
                  THEN CONVERT(nvarchar(32),N'InitialMem(') + CONVERT(nvarchar(17),CONVERT(numeric(16,2),SUM(qr.MemRequestMB))) + N'MB) '
                  ELSE N'' END +
        CASE WHEN MAX([PhyReads%]) > CONVERT(float,20.0)
                    OR (MAX(qr.query_cost) >= 10 AND @PendingIOCountAvg > 1 AND (MAX([PhyReads%]) > CONVERT(float,5.0) OR MAX(qr.PAGEIOLATCHms) > 50))
                  THEN (CASE WHEN (@ProcessMemLow + @SystemMemLow) > 0
                                  THEN CONVERT(nvarchar(9),N'IO(MemP) ')
                                  ELSE CONVERT(nvarchar(9),N'IO ')
                         END)
                  ELSE N'' END +
        CASE WHEN 0 < CHARINDEX(N'(WAIT',MAX(sl.SessionLocks))
                  THEN CONVERT(nvarchar(9),N'LockWait ')
                  ELSE N'' END +
        CASE WHEN MAX(qr.MemGrantWait) = 1
                  THEN CONVERT(nvarchar(8),N'MemWait ')
                  ELSE N'' END +
        CASE WHEN MAX(qp.MissingJoin) > 0
                  THEN CONVERT(nvarchar(9),N'MissJoin ')
                  ELSE N'' END +
        CASE WHEN MAX(qr.PAGELATCHms) >= 1
                  THEN CONVERT(nvarchar(23),N'PageWait(' + CONVERT(nvarchar(10),MAX(qr.PAGELATCHms)) + N'ms) ')
                  ELSE N'' END +
        CASE WHEN MAX(qp.ParameterList) <> N'' AND UPPER(MAX(qp.PlanType)) IN (N'PROC',N'ADHOC') AND MAX(qs.RunCount) > 1
                   AND (  CONVERT(float,MAX(qs.MaxRows) / 10.0) > CONVERT(float,((MAX(qs.MinRows) / 10.0) * (4.0 * @ParamSniff)) + POWER(CONVERT(float,10.0),@ParamSniff))
                       OR (MAX([PhyReads%]) > CONVERT(float,20.0)
                          OR (MAX(qr.query_cost) >= 10 AND @PendingIOCountAvg > 1 AND (MAX([PhyReads%]) > CONVERT(float,5.0) OR MAX(qr.PAGEIOLATCHms) > 50)))
                       OR ((MAX(t.TempdbAllocMB) - MAX(t.TempdbDeallocMB))
                              > (CASE WHEN CONVERT(int,(SUM(qr.MemGrantMB) / 10) * ((100 - ISNULL(MAX(qp.[AvgMissingIndex%]),0)) / 100)) > 49
                                      THEN CONVERT(int,50)
                                      ELSE 1 + CONVERT(int,(SUM(qr.MemGrantMB) / 10) * ((100 - ISNULL(MAX(qp.[AvgMissingIndex%]),0)) / 100))
                                  END)))
                   AND CONVERT(float,MAX(qs.CpuHighms) / 10.0) > CONVERT(float,((MAX(qs.AvgCpuLowms) / 10.0) * (4.0 * @ParamSniff)) + POWER(CONVERT(float,10.0),@ParamSniff))
                   AND ((CASE WHEN MAX(qr.RuntimeSec) > MAX(qs.MaxTimeSec) THEN MAX(qr.RuntimeSec) ELSE MAX(qs.MaxTimeSec) END) - MAX(qs.MinTimeSec))
                            > ((MAX(qs.MinTimeSec) / 10) + POWER(CONVERT(bigint,10),@ParamSniff))
                  THEN CONVERT(nvarchar(37),N'ParamSniff(') + CONVERT(nvarchar(10),MAX(qs.MinTimeSec)) + N'-'
                                                            + CONVERT(nvarchar(10),(CASE WHEN MAX(qr.RuntimeSec) > MAX(qs.MaxTimeSec) THEN MAX(qr.RuntimeSec) ELSE MAX(qs.MaxTimeSec) END)) + N'Sec) '
                  ELSE N'' END +
        CASE WHEN MAX(qr.SpinLoopFlag) = 1
                  THEN CONVERT(nvarchar(9),N'SpinLoop ')
                  ELSE N'' END +
        CASE WHEN (MAX(t.TempdbAllocMB) - MAX(t.TempdbDeallocMB))
                     > (CASE WHEN CONVERT(int,(SUM(qr.MemGrantMB) / 10) * ((100 - ISNULL(MAX(qp.[AvgMissingIndex%]),0)) / 100)) > 49
                                  THEN CONVERT(int,50)
                                  ELSE 1 + CONVERT(int,(SUM(qr.MemGrantMB) / 10) * ((100 - ISNULL(MAX(qp.[AvgMissingIndex%]),0)) / 100))
                         END)
                  THEN CONVERT(nvarchar(27),N'Tempdb')
                        + (CASE WHEN MAX(t.TempdbWaitms) >= 1 THEN N'(' + CONVERT(nvarchar(16),MAX(t.TempdbWaitms)) + N'ms) ' ELSE N' ' END)
                  ELSE N'' END +
        CASE WHEN MAX(qr.ThreadShortageFlag) = 1 AND @ThreadShortageAvg > 0
                  THEN CONVERT(nvarchar(15),N'ThreadShortage ')
                  ELSE N'' END +
        CASE WHEN @VerCleanupRatio < CONVERT(float,80.0) AND MAX(t.VerDuration) >= 1
                  THEN CONVERT(nvarchar(25),N'Ver(') + CONVERT(nvarchar(16),MAX(t.VerDuration)) + N'sec) '
                  ELSE N'' END
       )),N' ',N','),N'~',N' '))             as ThrottlePotential,
       MAX(qr.RuntimeSec)                    as RuntimeSec,
       CONVERT(nvarchar(50),
               STUFF((SELECT N',' + CONVERT(nvarchar(50),qr2.BlockedBy)
                        FROM cteQRequests qr2
                       WHERE qr2.SPID = qr.SPID
                         AND qr2.BlockedBy IS NOT NULL
                       GROUP BY CONVERT(nvarchar(50),qr2.BlockedBy)
                      FOR XML PATH('')),1,1,N''))
                                             as BlockedBy,
       (SELECT CONVERT(nvarchar(max),
                       SUBSTRING(qt.text+' ',(MAX(qr.statement_start_offset) / 2) + 1,
                                             ((CASE WHEN MAX(qr.statement_end_offset) = -1
                                                    THEN DATALENGTH(qt.text)
                                                    ELSE MAX(qr.statement_end_offset)
                                                END - MAX(qr.statement_start_offset)) / 2) + 1))
          FROM sys.dm_exec_sql_text(qr.sql_handle) qt)
                                             as Query,
       MAX(qr.MemGrantMB)                    as MemGrantMB,
       MAX(qs.RunCount)                      as RunCount,
       MAX(qs.MinRows)                       as MinRows,
       MAX(qs.MaxRows)                       as MaxRows,
       MAX(qs.AvgCpuLowms)                   as AvgCpuLowms,
       MAX(qs.CpuHighms)                     as CpuHighms,
       MAX(qr.DOP)                           as DOP,
       MAX(qs.AvgLogicalReadsMB)             as AvgLogicalReadsMB,
       (CASE WHEN MAX(qs.RunCount) IS NOT NULL THEN MAX(qs.[PhyReads%]) ELSE CONVERT(float,NULL) END)
                                             as [PhyReads%],
       MAX(qr.PAGEIOLATCHms)                 as PAGEIOLATCHms,
       MAX(sl.SessionLocks)                  as SessionLocks,
       MAX(t.VerActive)                      as VerActive,
       MAX(t.TempdbAllocMB)                  as TempdbAllocMB,
       MAX(t.TempdbDeallocMB)                as TempdbDeallocMB,
       MAX(qp.Cardinality)                   as Cardinality,
       MAX(qp.[AvgMissingIndex%])            as [AvgMissingIndex%],
       MAX(qp.SortRows)                      as SortRows,
       MAX(qp.TableScanRows)                 as TableScanRows,
       MAX(qp.ParameterList)                 as CachedParam,
       (SELECT top 1 query_plan FROM sys.dm_exec_query_plan(qr.plan_handle))
                                             as CachedPlan,
       MAX(qr.ProgramName)                   as ProgramName,
       MAX(qr.OriginalLogin)                 as OriginalLogin,
       @Runtime                              as LogDateTime
  FROM cteQRequests qr
        LEFT JOIN cteQPlan qp
               ON qp.plan_handle = qr.plan_handle
        LEFT JOIN cteQStats qs
               ON qs.sql_handle  = qr.sql_handle
              AND qs.plan_handle = qr.plan_handle
        LEFT JOIN cteSLocks sl
               ON sl.SPID        = qr.SPID
        LEFT JOIN cteTempdb t
               ON t.SPID         = qr.SPID
 GROUP BY qr.SPID,
          qr.sql_handle,
          qr.plan_handle
HAVING (SELECT CONVERT(nvarchar(max),
                       SUBSTRING(qt.text+' ',(MAX(qr.statement_start_offset) / 2) + 1,
                                             ((CASE WHEN MAX(qr.statement_end_offset) = -1
                                                    THEN DATALENGTH(qt.text)
                                                    ELSE MAX(qr.statement_end_offset)
                                                END - MAX(qr.statement_start_offset)) / 2) + 1))
          FROM sys.dm_exec_sql_text(qr.sql_handle) qt) IS NOT NULL
 ORDER BY qr.SPID
END;

GO