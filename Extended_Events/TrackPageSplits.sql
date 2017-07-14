/*
Original link: https://www.sqlskills.com/blogs/jonathan/tracking-problematic-pages-splits-in-sql-server-2012-extended-events-no-really-this-time/
Author: Wayne Sheffield
*/
-- If the Event Session exists DROP it
IF EXISTS (SELECT 1 
            FROM sys.server_event_sessions 
            WHERE name = 'TrackPageSplits')
    DROP EVENT SESSION [TrackPageSplits] ON SERVER;

-- Create the Event Session to track LOP_DELETE_SPLIT transaction_log operations in the server
CREATE EVENT SESSION [TrackPageSplits]
ON    SERVER
ADD EVENT sqlserver.transaction_log(
    WHERE operation = 11  -- LOP_DELETE_SPLIT 
)
ADD TARGET package0.histogram(
    SET filtering_event_name = 'sqlserver.transaction_log',
        source_type = 0, -- Event Column
        source = 'database_id');
GO

-- Start the Event Session
ALTER EVENT SESSION [TrackPageSplits] ON SERVER STATE=START;
GO


-- Query the target data to identify the worst splitting database_id
SELECT 
    n.value('(value)[1]', 'bigint') AS database_id,
    DB_NAME(n.value('(value)[1]', 'bigint')) AS database_name,
    n.value('(@count)[1]', 'bigint') AS split_count
FROM
(SELECT CAST(target_data as XML) target_data
 FROM sys.dm_xe_sessions AS s 
 JOIN sys.dm_xe_session_targets t
     ON s.address = t.event_session_address
 WHERE s.name = 'SQLskills_TrackPageSplits'
  AND t.target_name = 'histogram' ) as tab
CROSS APPLY target_data.nodes('HistogramTarget/Slot') as q(n);


-- Query Target Data to get the top splitting objects in the database:
SELECT
    o.name AS table_name,
    i.name AS index_name,
    tab.split_count,
    i.fill_factor
FROM (    SELECT 
            n.value('(value)[1]', 'bigint') AS alloc_unit_id,
            n.value('(@count)[1]', 'bigint') AS split_count
        FROM
        (SELECT CAST(target_data as XML) target_data
         FROM sys.dm_xe_sessions AS s 
         JOIN sys.dm_xe_session_targets t
             ON s.address = t.event_session_address
         WHERE s.name = 'TrackPageSplits'
          AND t.target_name = 'histogram' ) as tab
        CROSS APPLY target_data.nodes('HistogramTarget/Slot') as q(n)
) AS tab
JOIN sys.allocation_units AS au
    ON tab.alloc_unit_id = au.allocation_unit_id
JOIN sys.partitions AS p
    ON au.container_id = p.partition_id
JOIN sys.indexes AS i
    ON p.object_id = i.object_id
        AND p.index_id = i.index_id
JOIN sys.objects AS o
    ON p.object_id = o.object_id
WHERE o.is_ms_shipped = 0;