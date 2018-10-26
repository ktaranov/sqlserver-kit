SET nocount ON;

--INSERT INTO msdb.dbo.tempdb_log_usage_v2
SELECT GETDATE() AS 'collection_time',
       p.*,
       t.*
FROM   (SELECT ss.session_id                          AS 'ss_session_id',
               ss.login_time,
               ss.host_name,
               ss.program_name,
               ss.client_interface_name,
               ss.login_name,
               ss.status                              AS 'session_status',
               ss.last_request_start_time,
               ss.last_request_end_time,
               er.start_time,
               er.status                              AS 'request_status',
               er.command,
               qt.text                                AS 'parent_query',
               Substring (qt.text, er.statement_start_offset / 2, (
               CASE
                 WHEN er.statement_end_offset = -1 THEN
                 Len(CONVERT(NVARCHAR(max), qt.text)) *
                 2
                 ELSE er.statement_end_offset
               END - er.statement_start_offset ) / 2) AS 'individual_query',
               er.sql_handle,
               er.plan_handle,
               er.database_id                         AS 'er_database_id',
               er.open_transaction_count,
               er.transaction_id                      AS 'er_transaction_id',
               er.total_elapsed_time / 1000           AS'running_time_sec',
               er.reads,
               er.writes,
               er.logical_reads
        FROM   sys.dm_exec_sessions AS ss
               LEFT JOIN sys.dm_exec_requests AS er
                      ON ss.session_id = er.session_id
               CROSS apply sys.dm_exec_sql_text(er.sql_handle)AS qt
        WHERE  ss.status = 'running') AS p
       INNER JOIN (SELECT st.session_id,
                          st.transaction_id AS 'dbt_transaction_id',
                          dbt.database_id,
       dbt.database_transaction_begin_time,
       dbt.database_transaction_log_record_count,
       dbt.database_transaction_log_bytes_used,
       dbt.database_transaction_log_bytes_reserved,
       dbs.log_reuse_wait_desc,
       (SELECT cntr_value / 1024 AS 'log_usage_mb'
       FROM   sys.dm_os_performance_counters
       WHERE  object_name LIKE'%:Databases%'
       AND counter_name = 'Log File(s) Used Size (KB)'
       AND instance_name = 'tempdb') AS 'tempdb_log_usage_mb'
       FROM   sys.dm_tran_database_transactions AS dbt
       INNER JOIN sys.dm_tran_session_transactions AS st
       ON dbt.transaction_id = st.transaction_id
       INNER JOIN sys.databases AS dbs WITH (nolock)
       ON dbt.database_id = dbs.database_id
       WHERE  dbt.database_id = 2
       AND dbt.database_transaction_log_bytes_reserved > 0) AS t
               ON p.ss_session_id = t.session_id
                  AND p.er_transaction_id = t.dbt_transaction_id
WHERE  p.ss_session_id <> @@SPID
OPTION (recompile);
