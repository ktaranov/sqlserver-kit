/*
Original link: https://jasonbrimhall.info/2018/11/27/auditing-when-database-files-change/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Extended_Events/TrackDBFileChange.sql
Author: Jason Brimhall

SELECT
    event_data.value('(event/@name)[1]', 'varchar(50)') AS event_name
    ,event_data.value('(event/@timestamp)[1]','varchar(max)') as timestamp
    ,event_data.value('(event/data[@name="count"]/value)[1]', 'bigint') AS DbSizeChangeTo_KB
    ,event_data.value('(event/action[@name="sql_text"]/value)[1]', 'varchar(max)') AS sql_text
    ,db_name(event_data.value('(event/action[@name="database_id"]/value)[1]', 'int')) AS DBQueryExecutedFrom
    ,db_name(event_data.value('(event/data[@name="database_id"]/value)[1]','int')) as AffectedDB
    ,event_data.value('(event/action[@name="client_hostname"]/value)[1]', 'varchar(max)') AS ClientHost
    ,event_data.value('(event/action[@name="session_id"]/value)[1]', 'varchar(max)') AS session_id
FROM(    
        SELECT CAST(event_data AS xml) AS TargetData
            FROM sys.fn_xe_file_target_read_file('C:\XE\DBFileSizeChange*.xel','C:\XE\DBFileSizeChange*.xem',NULL, NULL)
        
    ) AS evts(event_data)
WHERE event_data.value('(event/@name)[1]', 'varchar(50)') = 'databases_log_file_size_changed'
    or event_data.value('(event/@name)[1]', 'varchar(50)') = 'databases_data_file_size_changed'
    --or event_data.value('(event/@name)[1]', 'varchar(50)') = 'databases_log_growth'
ORDER BY timestamp;
*/

USE master;
GO

IF EXISTS(SELECT 1 FROM sys.server_event_sessions WHERE name = N'TrackDBFileChange')
    DROP EVENT SESSION TrackDBFileChange ON SERVER;
GO

CREATE EVENT SESSION TrackDBFileChange ON SERVER
ADD EVENT sqlserver.databases_data_file_size_changed(
    ACTION(sqlserver.session_id,sqlserver.database_id,sqlserver.client_hostname,
            sqlserver.sql_text)
    )
,ADD EVENT sqlserver.databases_log_file_size_changed(
    ACTION(sqlserver.session_id,sqlserver.database_id,sqlserver.client_hostname,
            sqlserver.sql_text)
    )
ADD TARGET  package0.asynchronous_file_target(
     SET filename='C:\XE\TrackDBFileChange.xel'
     , max_file_size = 5
     , max_rollover_files = 4
     , metadatafile='C:\XE\TrackDBFileChange.xem'
     ) --if the path does not exist, a nasty error will be thrown
,
ADD TARGET package0.ring_buffer  -- Store events in the ring buffer target
    (SET max_memory = 4096)
WITH (MAX_MEMORY = 4MB, EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS, TRACK_CAUSALITY = ON, MAX_DISPATCH_LATENCY = 1 SECONDS,startup_state = ON);
GO

ALTER EVENT SESSION TrackDBFileChange ON SERVER STATE = START;
GO
