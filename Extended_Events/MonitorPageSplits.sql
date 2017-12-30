/*
Original link: http://sqlblog.com/blogs/jonathan_kehayias/archive/2010/10/17/tracking-page-splits-in-sql-server-denali-ctp1.aspx
Author: Jonathan Kehayias
*/

IF (SELECT 1 FROM sys.server_event_sessions WHERE name = 'MonitorPageSplits') IS NOT NULL
   DROP EVENT SESSION MonitorPageSplits ON SERVER 
GO

CREATE EVENT SESSION MonitorPageSplits ON SERVER 
ADD EVENT sqlserver.page_split 
( 
    ACTION (sqlserver.database_id, sqlserver.sql_text)   
    WHERE sqlserver.database_id = 2 
) 
ADD TARGET package0.ring_buffer 
WITH (MAX_DISPATCH_LATENCY = 1 SECONDS)
GO

ALTER EVENT SESSION MonitorPageSplits ON SERVER STATE = start;
GO

/*
SELECT 
    event_time         = XEvent.value('(@timestamp)[1]','datetime') 
  , orig_file_id      = XEvent.value('(data[@name=''file_id'']/value)[1]','int') 
  , orig_page_id      = XEvent.value('(data[@name=''page_id'']/value)[1]','int') 
  , database_id           = XEvent.value('(data[@name=''database_id'']/value)[1]','int') 
  , OBJECT_ID         = p.OBJECT_ID
  , index_id          = p.index_id
  , OBJECT_NAME           = OBJECT_NAME(p.OBJECT_ID)
  , index_name            = i.name
  , rowset_id         = XEvent.value('(data[@name=''rowset_id'']/value)[1]','bigint') 
  , splitOperation        = XEvent.value('(data[@name=''splitOperation'']/text)[1]','varchar(255)') 
  , new_page_file_id  = XEvent.value('(data[@name=''new_page_file_id'']/value)[1]','int') 
  , new_page_page_id  = XEvent.value('(data[@name=''new_page_page_id'']/value)[1]','int') 
  , sql_text          = XEvent.value('(action[@name=''sql_text'']/value)[1]','varchar(max)') 
FROM 
( 
   SELECT CAST(target_data AS XML) AS target_data 
   FROM sys.dm_xe_session_targets xst 
   JOIN sys.dm_xe_sessions xs ON xs.address = xst.event_session_address 
   WHERE xs.name = 'MonitorPageSplits' 
) AS tab (target_data) 
CROSS APPLY target_data.nodes('/RingBufferTarget/event') AS EventNodes(XEvent) 
LEFT JOIN sys.allocation_units au
   ON au.container_id = XEvent.value('(data[@name=''rowset_id'']/value)[1]','bigint') 
LEFT JOIN sys.partitions p 
   ON p.partition_id = au.container_id  
LEFT JOIN sys.indexes i
   ON p.OBJECT_ID = i.OBJECT_ID
       AND p.index_id = i.index_id

-- View the Page allocations 
DBCC IND(tempdb, split_page, -1);
*/
