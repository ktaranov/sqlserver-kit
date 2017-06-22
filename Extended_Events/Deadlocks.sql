/*
Original link: http://blog.waynesheffield.com/wayne/archive/2017/04/weaning-yourself-off-sql-profiler/
Author: Wayne Sheffield
*/
IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'Deadlocks')
    DROP EVENT SESSION [Deadlocks] ON SERVER;
GO

EXECUTE xp_create_subdir 'C:\SQL\XE_Out';
GO

CREATE EVENT SESSION [Deadlocks]
ON SERVER
ADD EVENT sqlserver.lock_deadlock(
    SET collect_database_name=(1),collect_resource_description=(1)
    ACTION 
    (
          sqlserver.client_app_name         -- ApplicationName from SQLTrace
        , sqlserver.client_pid              -- ClientProcessID from SQLTrace
        , sqlserver.nt_username             -- NTUserName from SQLTrace
        , sqlserver.server_principal_name   -- LoginName from SQLTrace
        , sqlserver.session_id              -- SPID from SQLTrace
    )
),
ADD EVENT sqlserver.lock_deadlock_chain(
    SET collect_database_name=(1),collect_resource_description=(1)
    ACTION 
    (
          sqlserver.session_id  -- SPID from SQLTrace
    )
),
ADD EVENT sqlserver.xml_deadlock_report(
    ACTION 
    (
          sqlserver.server_principal_name   -- LoginName from SQLTrace
        , sqlserver.session_id              -- SPID from SQLTrace
    )
)
ADD TARGET package0.event_file
(
    SET filename = 'C:\SQL\XE_Out\Deadlocks.xel',
        max_file_size = 250,
        max_rollover_files = 5
)
WITH (STARTUP_STATE=OFF)
;