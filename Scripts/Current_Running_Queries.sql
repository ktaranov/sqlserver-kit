/*
Author: Nagaraj
Original link: http://www.sqlservercentral.com/blogs/sql-and-sql-only/2016/08/07/current-running-queries/
*/

SELECT getdate() as dt,
ss.session_id,
db_name(sysprocesses.dbid) as dbname,
er.status as req_status,
ss.login_name,
cs.client_net_address,
ss.program_name,
sysprocesses.open_tran,
er.blocking_session_id,
ss.host_name,
ss.client_interface_name,
[eqp].[query_plan] as qplan,
SUBSTRING(est.text,(er.statement_start_offset/2)+1,
CASE WHEN er.statement_end_offset=-1 OR er.statement_end_offset=0
THEN (DATALENGTH(est.Text)-er.statement_start_offset/2)+1
ELSE (er.statement_end_offset-er.statement_start_offset)/2+1
END) as req_query_text,
er.granted_query_memory,
er.logical_reads as req_logical_reads,
er.cpu_time as req_cpu_time,
er.reads as req_physical_reads,
er.row_count as req_row_count,
er.scheduler_id,
er.total_elapsed_time as req_elapsed_time,
er.start_time as req_start_time,
er.percent_complete,
er.wait_resource as wait_resource,
er.wait_type as req_waittype,
er.wait_time as req_wait_time,
wait.wait_duration_ms as blocking_time_ms,
lock.resource_associated_entity_id,
lock.request_status as lock_request_status,
lock.request_mode as lock_mode,
er.writes as req_writes,
sysprocesses.lastwaittype,
fn_sql.text as session_query,
ss.status as session_status,
ss.cpu_time as session_cpu_time,
ss.reads as session_reads,
ss.writes as session_writes,
ss.logical_reads as session_logical_reads,
ss.memory_usage as session_memory_usage,
ss.last_request_start_time,
ss.last_request_end_time,
ss.total_scheduled_time as session_scheduled_time,
ss.total_elapsed_time as session_elpased_time,
ss.row_count as session_rowcount
FROM sys.dm_exec_sessions ss
INNER JOIN sys.dm_exec_connections cs ON ss.session_id = cs.session_id
OUTER APPLY fn_get_sql(cs.most_recent_sql_handle) as fn_sql
INNER JOIN sys.sysprocesses ON sys.sysprocesses.spid = cs.session_id
LEFT OUTER JOIN sys.dm_exec_requests [er] ON er.session_id = ss.session_id
OUTER APPLY sys.dm_exec_sql_text ([er].[sql_handle]) [est]
OUTER APPLY sys.dm_exec_query_plan ([er].[plan_handle]) [eqp]
LEFT OUTER JOIN sys.dm_os_waiting_tasks wait ON er.session_id = wait.session_id
and wait.wait_type like 'LCK%' and
er.blocking_session_id = wait.blocking_session_id
LEFT OUTER JOIN sys.dm_tran_locks lock ON lock.lock_owner_address = wait.resource_address
                                      AND lock.request_session_id = er.blocking_session_id
WHERE ss.status != 'sleeping';
