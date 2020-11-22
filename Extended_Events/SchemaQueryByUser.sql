/*
Original link: https://gist.github.com/SQLDBAWithABeard/3a617e04de5db729e941a0fd6ebed7cc
Author: Rob Sewell
*/

/* Stop trace if started */
IF EXISTS (SELECT * FROM sys.dm_xe_sessions WHERE name = 'SchemaQueryByUser')
  ALTER EVENT SESSION SchemaQueryByUser ON SERVER STATE = STOP;

/* Delete trace if exists */
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = 'SchemaQueryByUser')
  DROP EVENT SESSION AppExecutionTimeout ON SERVER;

/* Create trace */
CREATE EVENT SESSION SchemaQueryByUser ON SERVER 
ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(sqlserver.database_name,sqlserver.session_server_principal_name)
    WHERE ((((((((NOT ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[session_server_principal_name],N'EZCORP\Y%'))) 
    AND (([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%%')) 
    OR ([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[database_name],N'')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%SELECT CASE WHEN has_dbaccess%END%')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%SELECT case when @edition = N''SQL Azure''%')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%SERVERPROPERTY(%')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%HasMemoryOptimizedObjects from master.sys.master_files mf join master.sys.databases db on mf.database_id%')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%database_query_store_options%')))) 
    AND (NOT ([sqlserver].[like_i_sql_unicode_string]([batch_text],N'%SET SHOWPLAN%')))))
GO

ALTER EVENT SESSION SchemaQueryByUser ON SERVER STATE = START;
GO
