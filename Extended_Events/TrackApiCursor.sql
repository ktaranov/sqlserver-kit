/*
https://blog.pythian.com/extended-events-fetching-api-cursors/
by Shawn Melton January 3, 2017
*/

DROP EVENT SESSION TrackApiCursor ON SERVER;
GO

CREATE EVENT SESSION TrackApiCursor ON SERVER
ADD EVENT sqlserver.cursor_close(
    ACTION(
        sqlserver.client_app_name,
        sqlserver.database_name,
        sqlserver.is_system,
        sqlserver.session_id,
        sqlserver.sql_text)
    WHERE (
        [sqlserver].[is_system]<>(0)
        -- AND [sqlserver].[client_app_name]=N'Steely-Eyed-Missle-Man'
        )
),
ADD EVENT sqlserver.cursor_open(
    ACTION(
        sqlserver.client_app_name,
        sqlserver.database_name,
        sqlserver.is_system,
        sqlserver.query_hash,
        sqlserver.session_id,
        sqlserver.sql_text)
    WHERE (
        [sqlserver].[is_system]<>(0)
        -- AND [sqlserver].[client_app_name]=N'Steely-Eyed-Missle-Man'
    )
),
ADD EVENT sqlserver.rpc_completed(
    ACTION(
        sqlserver.client_app_name,
        sqlserver.database_name,
        sqlserver.is_system,
        sqlserver.query_hash,
        sqlserver.session_id,
        sqlserver.sql_text)
    WHERE (
        [sqlserver].[is_system]<>(0)
        -- AND [sqlserver].[client_app_name]=N'Steely-Eyed-Missle-Man'
    )
)
ADD TARGET package0.event_file(SET filename=N'Track_api_cursor.xel')
WITH (
    MAX_DISPATCH_LATENCY=12 SECONDS,
    TRACK_CAUSALITY=ON
);
GO

ALTER EVENT SESSION TrackApiCursor ON SERVER STATE = START;
GO

/* Read the data */
IF OBJECT_ID('tempdb..#XEResults') IS NOT NULL 
    DROP TABLE #XEResults ;
GO
IF OBJECT_ID('tempdb..#XEResultsParsed') IS NOT NULL 
    DROP TABLE #XEResultsParsed ;
GO

-- Create results table to load data from XE files
CREATE TABLE #XEResults
(
 [RowID] INT IDENTITY
             PRIMARY KEY,
 [event_data] XML
);

-- Load the event data from the file target
INSERT  INTO #XEResults
        ([event_data])
SELECT  CAST([event_data] AS XML) AS event_data
FROM    [sys].[fn_xe_file_target_read_file](N'Track_api_cursor*xel',NULL,NULL,NULL) ;

--SELECT * FROM #XEResults

-- Query the Event data from the Target.
SELECT  [event].[value]('(@name)[1]', 'varchar(50)') AS event_name
--    ,    DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP), [event].[value]('(@timestamp)[1]', 'datetime2')) AS [timestamp]
    ,[event].[value]('(action[@name="session_id"]/value)[1]', 'int') AS [session_id]
    ,[event].[value]('(action[@name="database_name"]/value)[1]','varchar(128)') AS [database_name]
    ,[event].[value]('(action[@name="client_app_name"]/value)[1]','varchar(500)') AS [client_app_name]
    ,[event].[value]('(data[@name="object_name"]/value)[1]', 'varchar(50)') AS [object_name]
    ,[event].[value]('(action[@name="sql_text"]/value)[1]','varchar(max)') AS [sql_text]
    ,[event].[value]('(data[@name="statement"]/value)[1]', 'varchar(1000)') AS [statement]
    ,[event].[value]('(action[@name="attach_activity_id_xfer"]/value)[1]', 'varchar(200)') AS [attach_activity_id_xfer]
    ,[event].[value]('(action[@name="attach_activity_id"]/value)[1]', 'varchar(200)') AS [attach_activity_id]
FROM #XEResults
CROSS APPLY [event_data].[nodes]('event') AS [q] ([event]) 
ORDER BY DATEADD(hh, DATEDIFF(hh, GETUTCDATE(), CURRENT_TIMESTAMP),[event].[value]('(@timestamp)[1]', 'datetime2'))
        ,[event].[value]('(action[@name="attach_activity_id"]/value)[1]', 'varchar(200)');

