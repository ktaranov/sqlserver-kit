/*
Created by: Eric Darling
Modified: 2019-04-08 by Konstantin Taranov
Original link: https://erikdarlingdata.com/2019/04/selects-that-cause-writes/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Selects_That_Cause_Writes.sql
*/

WITH XMLNAMESPACES ( 'http://schemas.microsoft.com/sqlserver/2004/07/showplan' AS x )
, writes AS
     (
         SELECT   TOP(100)
                  deqs.statement_start_offset,
                  deqs.statement_end_offset,
                  deqs.plan_handle,
                  deqs.creation_time,
                  deqs.last_execution_time,
                  deqs.total_logical_writes,
                  deqs.last_logical_writes,
                  deqs.min_logical_writes,
                  deqs.max_logical_writes,
                  deqs.query_hash,
                  deqs.query_plan_hash
         FROM     sys.dm_exec_query_stats AS deqs
         WHERE    deqs.min_logical_writes > 1024.
         ORDER BY deqs.min_logical_writes DESC
     ),
  plans
    AS
     (
         SELECT      DISTINCT
                     w.plan_handle,
                     w.statement_start_offset,
                     w.statement_end_offset,
                     w.creation_time,
                     w.last_execution_time,
                     w.total_logical_writes,
                     w.last_logical_writes,
                     w.min_logical_writes,
                     w.max_logical_writes
         FROM        writes AS w
         CROSS APPLY sys.dm_exec_query_plan(w.plan_handle) AS deqp
         CROSS APPLY deqp.query_plan.nodes('//x:StmtSimple') AS s(c)
         WHERE       deqp.dbid > 4
         AND         s.c.value('@StatementType', 'VARCHAR(100)') = 'SELECT'
         AND         NOT EXISTS (   SELECT      1/0 --If nothing comes up, quote out the NOT EXISTS. 
                                    FROM        writes AS w2
                                    CROSS APPLY deqp.query_plan.nodes('//x:StmtSimple') AS s2(c)
                                    WHERE       w2.query_hash = w.query_hash
                                    AND         w2.query_plan_hash = w.query_plan_hash
                                    AND         s2.c.value('@StatementType', 'VARCHAR(100)') <> 'SELECT' )
     )
SELECT      p.creation_time,
            p.last_execution_time,
            p.total_logical_writes,
            p.last_logical_writes,
            p.min_logical_writes,
            p.max_logical_writes,
            SUBSTRING(
                dest.text, ( p.statement_start_offset / 2 ) + 1,
                (( CASE p.statement_end_offset WHEN -1 THEN DATALENGTH(dest.text) ELSE p.statement_end_offset END
                   - p.statement_start_offset ) / 2 ) + 1) AS text,
            deqp.query_plan
FROM        plans AS p
CROSS APPLY sys.dm_exec_sql_text(p.plan_handle) AS dest
CROSS APPLY sys.dm_exec_query_plan(p.plan_handle) AS deqp
ORDER BY    p.min_logical_writes DESC
OPTION (RECOMPILE);
