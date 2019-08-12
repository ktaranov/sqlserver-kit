/*
Original link: https://jasonbrimhall.info/2019/06/25/database-file-changes/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Extended_Events/AuditFileSize.sql
Author: Phil Factor

*/

USE master;
GO
-- Create the Event Session
IF EXISTS ( SELECT *
                FROM sys.server_event_sessions
                WHERE name = 'AuditFileSize' )
    DROP EVENT SESSION AuditFileSize
    ON SERVER;
GO

CREATE EVENT SESSION AuditFileSize ON SERVER
ADD EVENT sqlserver.database_file_size_change ( --good
    ACTION ( sqlserver.database_id, sqlserver.session_id,
    sqlserver.database_name, sqlserver.client_hostname, sqlserver.sql_text,
    sqlserver.nt_username, sqlserver.username, sqlserver.session_nt_username,
    sqlserver.client_app_name, sqlserver.context_info,
    sqlserver.client_connection_id )
    ),
ADD EVENT sqlserver.databases_shrink_data_movement ( --good
    ACTION ( sqlserver.database_id, sqlserver.session_id,
    sqlserver.database_name, sqlserver.client_hostname, sqlserver.sql_text,
    sqlserver.nt_username, sqlserver.username, sqlserver.session_nt_username,
    sqlserver.client_app_name, sqlserver.context_info,
    sqlserver.client_connection_id )
    ),
ADD EVENT sqlserver.databases_log_file_used_size_changed ( --good --this is a very chatty event and may be left off
    ACTION ( sqlserver.database_id, sqlserver.session_id,
    sqlserver.database_name, sqlserver.client_hostname, sqlserver.sql_text,
    sqlserver.nt_username, sqlserver.username, sqlserver.session_nt_username,
    sqlserver.client_app_name, sqlserver.context_info,
    sqlserver.client_connection_id )
    ),
ADD EVENT sqlserver.databases_log_shrink ( --good
    ACTION ( sqlserver.database_id, sqlserver.session_id,
    sqlserver.database_name, sqlserver.client_hostname, sqlserver.sql_text,
    sqlserver.nt_username, sqlserver.username, sqlserver.session_nt_username,
    sqlserver.client_app_name, sqlserver.context_info,
    sqlserver.client_connection_id )
    )
ADD TARGET package0.event_file (
    SET filename = 'c:\XE\AuditFileSize.xel'
  , max_file_size = 5
  , max_rollover_files = 4 )
WITH ( MAX_MEMORY = 4 MB
        , EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
        , TRACK_CAUSALITY = ON
        , MAX_DISPATCH_LATENCY = 1 SECONDS
        , STARTUP_STATE = ON );
GO
