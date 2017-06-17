/*
Original link: https://blogs.msdn.microsoft.com/sql_server_team/sql-server-mysteries-the-case-of-the-not-100-restore/
Author: Bob Ward
*/
IF EXISTS (
    SELECT * FROM sys.server_event_sessions
        WHERE [name] = N'BackupRestoreTrace')
    DROP EVENT SESSION BackupRestoreTrace ON SERVER
GO


CREATE EVENT SESSION BackupRestoreTrace ON SERVER
ADD EVENT sqlos.async_io_completed(
    ACTION(package0.event_sequence,sqlos.task_address,sqlserver.session_id)),
ADD EVENT sqlos.async_io_requested(
    ACTION(package0.event_sequence,sqlos.task_address,sqlserver.session_id)),
ADD EVENT sqlos.task_completed(
    ACTION(package0.event_sequence,sqlserver.session_id)),
ADD EVENT sqlos.task_started(
    ACTION(package0.event_sequence,sqlserver.session_id)),
ADD EVENT sqlserver.backup_restore_progress_trace(
    ACTION(package0.event_sequence,sqlos.task_address,sqlserver.session_id)),
ADD EVENT sqlserver.file_write_completed(SET collect_path=(1)
    ACTION(package0.event_sequence,sqlos.task_address,sqlserver.session_id))
ADD TARGET package0.event_file(SET filename=N'BackupRestoreTrace')
WITH (
    MAX_MEMORY=4096 KB,
    EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,
    MAX_DISPATCH_LATENCY=5 SECONDS,
    MAX_EVENT_SIZE=0 KB,
    MEMORY_PARTITION_MODE=NONE,
    TRACK_CAUSALITY=OFF,
    STARTUP_STATE=OFF
);
