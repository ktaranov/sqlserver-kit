/*
Original link: http://michaeljswart.com/2016/01/monitor_deadlocks/
Author: Michael J. Swart
*/

/*
Create The Session
 - has five rollover files so that a couple server restarts don’t lose any recent deadlock graphs
 - uses an asynchronous_file_target which I prefer over the ring buffer
 - and it cleans itself up over time.

*/
DECLARE @ExtendedEventsTargetPath sysname = 'Change this string to something like "D:\XEvents\Traces"';
DECLARE @SQL nvarchar(max) = N'
CREATE EVENT SESSION [capture_deadlocks] ON SERVER
ADD EVENT sqlserver.xml_deadlock_report( ACTION(sqlserver.database_name) )
ADD TARGET package0.asynchronous_file_target(
  SET filename = ''' + @ExtendedEventsTargetPath + N'\capture_deadlocks.xel'',
      max_file_size = 10,
      max_rollover_files = 5)
WITH (
    STARTUP_STATE=ON,
    EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,
    MAX_DISPATCH_LATENCY=15 SECONDS,
    TRACK_CAUSALITY=OFF
    );

ALTER EVENT SESSION [capture_deadlocks] ON SERVER
    STATE=START';

EXEC sp_executesql @SQL;


-- Query the Results
DECLARE @filenamePattern sysname;
 
SELECT @filenamePattern = REPLACE( CAST(field.value AS sysname), '.xel', '*xel' )
FROM sys.server_event_sessions AS [session]
JOIN sys.server_event_session_targets AS [target]
  ON [session].event_session_id = [target].event_session_id
JOIN sys.server_event_session_fields AS field 
  ON field.event_session_id = [target].event_session_id
  AND field.object_id = [target].target_id	
WHERE
    field.name = 'filename'
    and [session].name= N'capture_deadlocks';

SELECT deadlockData.*
FROM sys.fn_xe_file_target_read_file ( @filenamePattern, null, null, null) 
    as event_file_value
CROSS APPLY ( SELECT CAST(event_file_value.[event_data] as xml) ) 
    as event_file_value_xml ([xml])
CROSS APPLY (
    SELECT 
        event_file_value_xml.[xml].value('(event/@name)[1]', 'varchar(100)') as eventName,
        event_file_value_xml.[xml].value('(event/@timestamp)[1]', 'datetime') as eventDate,
        event_file_value_xml.[xml].query('//event/data/value/deadlock') as deadlock	
  ) as deadlockData
WHERE deadlockData.eventName = 'xml_deadlock_report'
ORDER BY eventDate;
