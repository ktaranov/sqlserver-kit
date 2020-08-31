/*
Original link: http://blog.sqlgrease.com/how-to-detect-query-timeout-errors-with-extended-events/
Author: Franklin Yamamoto

SELECT
    object_name
    , convert(xml, event_data) AS event_data
    , file_name
    , file_offset
FROM sys.fn_xe_file_target_read_file(N'AppExecutionTimeout*.xel',NULL,NULL,NULL);
GO
*/

/* Stop trace if started */
IF EXISTS (SELECT * FROM sys.dm_xe_sessions WHERE name = 'AppExecutionTimeout')
  ALTER EVENT SESSION AppExecutionTimeout ON SERVER STATE = STOP;

/* Delete trace if exists */
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = 'AppExecutionTimeout')
  DROP EVENT SESSION AppExecutionTimeout ON SERVER;

/* Create trace */
CREATE EVENT SESSION AppExecutionTimeout ON SERVER
ADD EVENT sqlserver.attention
(ACTION (sqlserver.session_id, sqlserver.database_id, sqlserver.database_name,
sqlserver.username, sqlserver.sql_text, sqlserver.client_hostname,
sqlserver.client_app_name)
WHERE ([package0].[equal_boolean]([sqlserver].[is_system],(0))))
ADD TARGET package0.event_file(SET filename=N'AppExecutionTimeout.xel',
max_file_size=(5),max_rollover_files=(2));
GO

ALTER EVENT SESSION AppExecutionTimeout ON SERVER STATE = START;
GO
