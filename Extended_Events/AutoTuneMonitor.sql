/*
https://jasonbrimhall.info/2019/01/04/automatic-tuning-monitoring-and-diagnostics/
Author: Jason Brimhall
*/

USE master;
GO
-- Create the Event Session
IF EXISTS
(
    SELECT *
    FROM sys.server_event_sessions
    WHERE name = 'AutoTuneMonitor'
)
    DROP EVENT SESSION AutoTuneMonitor ON SERVER;
GO

CREATE EVENT SESSION [AutoTuneMonitor]
ON SERVER
    ADD EVENT qds.automatic_tuning_config_change
    (ACTION
     (
         sqlserver.database_id,
         sqlserver.nt_username,
         sqlserver.sql_text,
         sqlserver.username,
         sqlserver.session_nt_username,
         sqlserver.client_app_name,
         sqlserver.session_id,
         sqlserver.client_hostname
     )
    ),
    ADD EVENT qds.automatic_tuning_diagnostics
    (ACTION
     (
         sqlserver.database_id,
         sqlserver.nt_username,
         sqlserver.sql_text,
         sqlserver.username,
         sqlserver.session_nt_username,
         sqlserver.client_app_name,
         sqlserver.session_id,
         sqlserver.client_hostname
     )
    ),
    ADD EVENT qds.automatic_tuning_state_change
    (ACTION
     (
         sqlserver.database_id,
         sqlserver.nt_username,
         sqlserver.sql_text,
         sqlserver.username,
         sqlserver.session_nt_username,
         sqlserver.client_app_name,
         sqlserver.session_id,
         sqlserver.client_hostname
     )
    ),
    ADD EVENT qds.automatic_tuning_error
    (ACTION
     (
         sqlserver.database_id,
         sqlserver.nt_username,
         sqlserver.sql_text,
         sqlserver.username,
         sqlserver.session_nt_username,
         sqlserver.client_app_name,
         sqlserver.session_id,
         sqlserver.client_hostname
     )
    )
    ADD TARGET package0.event_file
    (SET filename = N'C:\XE\AutoTuneMonitor.xel'),
    ADD TARGET package0.ring_buffer
WITH
(
    MAX_DISPATCH_LATENCY = 5 SECONDS,
    TRACK_CAUSALITY = ON,
    STARTUP_STATE = OFF
);
GO

ALTER EVENT SESSION [AutoTuneMonitor] ON SERVER STATE = START;
GO