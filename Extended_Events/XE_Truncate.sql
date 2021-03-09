/*
https://www.sqlservercentral.com/forums/topic/extended-events-capture-truncate-using-object_altered-event
by Evgeny Garaev 2018-06-28
*/

/* Stop trace if started */
IF EXISTS (SELECT * FROM sys.dm_xe_sessions WHERE name = N'XE_Truncate')
  ALTER EVENT SESSION XE_Truncate ON SERVER STATE = STOP;

/* Delete trace if exists */
IF EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = N'XE_Truncate')
  DROP EVENT SESSION XE_Truncate ON SERVER;


CREATE EVENT SESSION XE_Truncate ON SERVER
ADD EVENT sqlserver.sp_statement_starting(SET collect_statement=(1)
WHERE ([sqlserver].[like_i_sql_unicode_string]([statement], N'truncate table%'))),
ADD EVENT sqlserver.sql_statement_starting(SET collect_statement=(1)
WHERE ([sqlserver].[like_i_sql_unicode_string]([statement],N'truncate table%')));
GO

ALTER EVENT SESSION XE_Truncate ON SERVER STATE = START;
GO
