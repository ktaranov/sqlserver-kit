/*
<documentation>
  <summary>dump the previous 8 hours of data from Query Store</summary>
  <returns>1 query set</returns>
  <issues>No</issues>
  <created>2020-01-24 by Greg Gonzalez</created>
  <version>1.0</version>
  <originalLink>https://sqlperformance.com/2020/01/sql-performance/why-waits-alone-are-not-enough</originalLink>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Query_Store_Export.sql</sourceLink>
</documentation>
*/

DECLARE @HoursBack smallint = 8;
DECLARE @StartDate datetime2 = DATEADD(hour, -@HoursBack, GETUTCDATE());

WITH QueryRuntimeStats AS (
    SELECT
         p.plan_id
        ,q.query_id
        ,q.query_hash
        ,SUM(rs.count_executions) AS total_executions
        ,SUM(rs.count_executions * rs.avg_duration) / 1000 AS total_duration_ms
        ,SUM(rs.count_executions * rs.avg_cpu_time) / 1000 AS total_cpu_ms
        ,SUM(rs.count_executions * rs.avg_clr_time) / 1000 AS total_clr_time_ms
        ,SUM(rs.count_executions * rs.avg_query_max_used_memory) AS total_query_max_used_memory
        ,SUM(rs.count_executions * rs.avg_logical_io_reads) AS total_logi_reads
        ,SUM(rs.count_executions * rs.avg_logical_io_writes) AS total_logi_writes
        ,SUM(rs.count_executions * rs.avg_physical_io_reads) AS total_phys_reads
        ,SUM(rs.count_executions * rs.avg_rowcount) AS total_rowcount
        ,SUM(rs.count_executions * rs.avg_log_bytes_used) AS total_log_bytes_used
        ,SUM(rs.count_executions * rs.avg_tempdb_space_used) AS total_tempdb_space_used
    from sys.query_store_plan p
    join sys.query_store_query q
      on q.query_id = p.query_id
    join sys.query_store_runtime_stats rs
      on rs.plan_id = p.plan_id
    join sys.query_store_runtime_stats_interval rsi
      on rsi.runtime_stats_interval_id = rs.runtime_stats_interval_id
    where rsi.start_time > @StartDate
    group by
         p.plan_id
        ,q.query_id
        ,q.query_hash
)
,QueryWaitStats AS (
    SELECT
         p.plan_id
        ,q.query_id
        ,q.query_hash
        ,ws.wait_category_desc
        ,SUM(ws.total_query_wait_time_ms) AS total_wait_time_ms
    FROM sys.query_store_plan p
    JOIN sys.query_store_query q
      ON q.query_id = p.query_id
    JOIN sys.query_store_wait_stats	ws
      ON ws.plan_id = p.plan_id
    JOIN sys.query_store_runtime_stats_interval rsi
     ON rsi.runtime_stats_interval_id = ws.runtime_stats_interval_id
    WHERE rsi.start_time > @StartDate
    GROUP BY
         p.plan_id
        ,q.query_id
        ,q.query_hash
        ,ws.wait_category_desc
)
,QueryWaitStatsByCategory
AS
(
    SELECT *
    FROM QueryWaitStats
    PIVOT
    (
        SUM(total_wait_time_ms)
        FOR wait_category_desc IN
        (
             [Unknown]
            ,[CPU]
            ,[Worker Thread]
            ,[Lock]
            ,[Latch]
            ,[Buffer Latch]
            ,[Buffer IO]
            ,[Compilation]
            ,[SQL CLR]
            ,[Mirroring]
            ,[Transaction]
            ,[Idle]
            ,[Preemptive]
            ,[Service Broker]
            ,[Tran Log IO]
            ,[Network IO]
            ,[Parallelism]
            ,[Memory]
            ,[User Wait]
            ,[Tracing]
            ,[Full Text Search]
            ,[Other Disk IO]
            ,[Replication]
            ,[Log Rate Governor]
        )
    ) AS pvt
)
,QueryWaitStatsTotals
AS
(
    SELECT
         plan_id
        ,query_id
        ,query_hash
        ,SUM(total_wait_time_ms) AS total_wait_time_ms
    FROM QueryWaitStats
    GROUP BY
         plan_id
        ,query_id
        ,query_hash
)
SELECT
       rs.plan_id
     , rs.query_id
     , rs.query_hash
     , rs.total_executions
     , rs.total_duration_ms
     , rs.total_cpu_ms
     , rs.total_clr_time_ms
     , rs.total_query_max_used_memory
     , rs.total_logi_reads
     , rs.total_logi_writes
     , rs.total_phys_reads
     , rs.total_rowcount
     , rs.total_log_bytes_used
     , rs.total_tempdb_space_used
     , ws.total_wait_time_ms
     , wsc.[CPU]
     , wsc.[Lock]
     , wsc.[Latch]
     , wsc.[Buffer Latch]
     , wsc.[Buffer IO]
     , wsc.[Memory]
     , wsc.[Tran Log IO]
     , wsc.[Network IO]
     , wsc.[Worker Thread]
     , wsc.[Unknown]
     , wsc.[Compilation]
     , wsc.[SQL CLR]
     , wsc.[Mirroring]
     , wsc.[Transaction]
     , wsc.[Idle]
     , wsc.[Preemptive]
     , wsc.[Service Broker]
     , wsc.[Parallelism]
     , wsc.[User Wait]
     , wsc.[Tracing]
     , wsc.[Full Text Search]
     , wsc.[Other Disk IO]
     , wsc.[Replication]
     , wsc.[Log Rate Governor]
FROM QueryRuntimeStats rs
LEFT JOIN QueryWaitStatsTotals AS ws
  ON rs.plan_id = ws.plan_id
 AND rs.query_id = ws.query_id
LEFT JOIN QueryWaitStatsByCategory AS wsc
  ON rs.plan_id = wsc.plan_id
 AND rs.query_id = wsc.query_id;
