/*
Original link: https://sqlperformance.com/2020/04/sql-performance/bandwidth-friendly-query-profiling-azure-sql-database
Author: Greg Gonzalez 
*/

ALTER EVENT SESSION [ADS_Standard_Azure] ON DATABASE 
DROP EVENT sqlserver.attention,
DROP EVENT sqlserver.existing_connection,
DROP EVENT sqlserver.login,
DROP EVENT sqlserver.logout,
DROP EVENT sqlserver.rpc_completed,
DROP EVENT sqlserver.sql_batch_completed,
DROP EVENT sqlserver.sql_batch_starting
GO
 
ALTER EVENT SESSION [ADS_Standard_Azure] ON DATABASE 
ADD EVENT sqlserver.rpc_completed(
ACTION(package0.event_sequence,sqlserver.client_app_name,sqlserver.client_pid,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id,sqlserver.username)
      WHERE (([package0].[equal_boolean]([sqlserver].[is_system],(0))) AND ([duration] >= (1000000)))),
ADD EVENT sqlserver.sql_batch_completed(
ACTION(package0.event_sequence,sqlserver.client_app_name,sqlserver.client_pid,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id,sqlserver.username)
      WHERE (([package0].[equal_boolean]([sqlserver].[is_system],(0))) AND ([duration] >= (1000000))))
GO
 
ALTER EVENT SESSION [ADS_Standard_Azure] ON DATABASE 
DROP TARGET package0.ring_buffer
GO
 
ALTER EVENT SESSION [ADS_Standard_Azure] ON DATABASE 
ADD TARGET package0.ring_buffer(SET max_events_limit=(10),max_memory=(51200))
GO
