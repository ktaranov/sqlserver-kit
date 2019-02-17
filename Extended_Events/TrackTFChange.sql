/*
Original link: http://jasonbrimhall.info/2018/12/06/capture-the-flag-the-trace-flag/
Author: Jason Brimhall
*/
-- If the Event Session exists DROP it
IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = N'TrackTFChange')
    DROP EVENT SESSION TrackTFChange ON SERVER;

CREATE EVENT SESSION TrackTFChange ON SERVER 
ADD EVENT sqlserver.trace_flag_changed(
    ACTION (sqlserver.database_name,sqlserver.client_hostname,sqlserver.client_app_name,
            sqlserver.sql_text,
            sqlserver.session_id)
    -- WHERE sqlserver.client_app_name <> 'Microsoft SQL Server Management Studio - Transact-SQL IntelliSense'
    )
ADD TARGET package0.ring_buffer
WITH (MAX_DISPATCH_LATENCY=5SECONDS, TRACK_CAUSALITY=ON);
GO

ALTER EVENT SESSION TrackTFChange ON SERVER STATE = START;
GO


SELECT event_data.value('(event/@name)[1]', 'varchar(50)') AS event_name
     , event_data.value('(event/@timestamp)[1]','varchar(max)') as timestamp
     , event_data.value('(event/data[@name="flag"]/value)[1]', 'bigint') AS TraceFlag
     , event_data.value('(event/data[@name="type"]/text)[1]', 'varchar(max)') AS FlagType
     , CASE event_data.value('(event/data[@name="new_value"]/value)[1]','int') 
          WHEN 0 then 'Enabled'
          WHEN 1 then 'Disabled'
       END as NewValue
     , event_data.value('(event/action[@name="sql_text"]/value)[1]', 'varchar(max)') AS sql_text
     , event_data.value('(event/action[@name="database_name"]/value)[1]', 'varchar(max)') AS DBQueryExecutedFrom
     , event_data.value('(event/action[@name="client_hostname"]/value)[1]', 'varchar(max)') AS ClientHost
     , event_data.value('(event/action[@name="client_app_name"]/value)[1]', 'varchar(max)') AS appname
     , event_data.value('(event/action[@name="session_id"]/value)[1]', 'varchar(max)') AS session_id
FROM(SELECT evnt.query('.') AS event_data
    FROM
        (    SELECT CAST(target_data AS xml) AS TargetData
        FROM sys.dm_xe_sessions AS s
            INNER JOIN sys.dm_xe_session_targets AS t
            ON s.address = t.event_session_address
        WHERE s.name = 'TrackTFChange'
            AND t.target_name = 'ring_buffer'
     ) AS tab
     CROSS APPLY TargetData.nodes ('RingBufferTarget/event') AS split(evnt) 
    ) AS evts(event_data)
WHERE event_data.value('(event/@name)[1]', 'varchar(50)') = 'trace_flag_changed'
ORDER BY timestamp ASC;
