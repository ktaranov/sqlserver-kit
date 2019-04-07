/*
Original link: https://www.sqlservercentral.com/blogs/database-recovery-monitoring-with-xe
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Extended_Events/DBRecoveryProgress.sql
Author: Jason Brimhall
*/

USE master;
GO
-- Create the Event Session
IF EXISTS
(
    SELECT
        *
    FROM sys.server_event_sessions
    WHERE name = 'DBRecoveryProgress'
)
    DROP EVENT SESSION DBRecoveryProgress ON SERVER;
GO

CREATE EVENT SESSION DBRecoveryProgress
    ON SERVER
    ADD EVENT sqlserver.database_recovery_progress_report
    (ACTION
     (
     /* yes this may be overkill on the actions - it is for discovery*/
         sqlserver.database_id
       , sqlserver.session_id
       , sqlserver.database_name
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.sql_text
       , sqlserver.nt_username
       , sqlserver.username
       , sqlserver.session_nt_username
       , sqlserver.client_app_name
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , package0.callstack
     )
    )
  , ADD EVENT sqlserver.database_recovery_trace
    (ACTION
     (
         sqlserver.database_id
       , sqlserver.session_id
       , sqlserver.database_name
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.sql_text
       , sqlserver.nt_username
       , sqlserver.username
       , sqlserver.session_nt_username
       , sqlserver.client_app_name
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , package0.callstack
     )
    )
  , ADD EVENT sqlserver.database_recovery_times
    (ACTION
     (
         sqlserver.database_id
       , sqlserver.session_id
       , sqlserver.database_name
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.sql_text
       , sqlserver.nt_username
       , sqlserver.username
       , sqlserver.session_nt_username
       , sqlserver.client_app_name
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , package0.callstack
     )
    )
  , ADD EVENT sqlserver.database_recovery_lsn_report
    (ACTION
     (
         sqlserver.database_id
       , sqlserver.session_id
       , sqlserver.database_name
       , sqlserver.tsql_stack
       , package0.event_sequence
       , sqlserver.sql_text
       , sqlserver.nt_username
       , sqlserver.username
       , sqlserver.session_nt_username
       , sqlserver.client_app_name
       , sqlserver.context_info
       , sqlserver.client_connection_id
       , sqlserver.query_hash
       , sqlserver.query_plan_hash
       , package0.callstack
     )
    )
    ADD TARGET package0.event_file
    (SET filename = 'c:\Windows\Temp\DatabaseXEDBRecoveryProgress.xel', max_file_size = 5, max_rollover_files = 4)
    WITH
    (
        MAX_MEMORY = 4MB
      , EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS
      , TRACK_CAUSALITY = ON
      , MAX_DISPATCH_LATENCY = 5 SECONDS
      , STARTUP_STATE = ON
    );
GO

ALTER EVENT SESSION DBRecoveryProgress ON SERVER STATE = START;
GO
