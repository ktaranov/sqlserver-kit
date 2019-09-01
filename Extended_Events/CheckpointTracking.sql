/*
Original link: https://www.sqlserverscience.com/extended-events/checkpoint-tracking-via-extended-events/
Author: Max Vernon
*/

IF NOT EXISTS ( /* only create this session if one doesn't already exist
                   to prevent inadvertant loss of events.
                */
    SELECT 1
    FROM sys.server_event_sessions ss
    WHERE ss.name = N'CheckpointTracking'
    )
BEGIN
    CREATE EVENT SESSION CheckpointTracking 
    ON SERVER 
    ADD EVENT sqlserver.checkpoint_begin
    (
        ACTION
        (
              package0.callstack
            , package0.collect_system_time
            , package0.event_sequence
            , sqlserver.client_app_name
            , sqlserver.client_hostname
            , sqlserver.database_id
            , sqlserver.database_name
            , sqlserver.is_system
            , sqlserver.session_id
            , sqlserver.session_nt_username
            , sqlserver.sql_text
        )
    )
    , ADD EVENT sqlserver.checkpoint_end
    (
        ACTION
        (
              package0.callstack
            , package0.collect_system_time
            , package0.event_sequence
            , sqlserver.client_app_name
            , sqlserver.client_hostname
            , sqlserver.database_id
            , sqlserver.database_name
            , sqlserver.is_system
            , sqlserver.session_id
            , sqlserver.session_nt_username
            , sqlserver.sql_text
        )
    )
    ADD TARGET package0.ring_buffer
    (
        SET max_memory = 10240
    )
    WITH (STARTUP_STATE=OFF);
END
GO
ALTER EVENT SESSION CheckpointTracking 
ON SERVER 
STATE = START;
