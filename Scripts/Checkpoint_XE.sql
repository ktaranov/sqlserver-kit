<documentation>
  <summary>Analyze checkpoint extended events result</summary>
  <returns>1 data set: checploints info.</returns>
  <issues>No</issues>
  <author>Aaron Bertrand</author>
  <created>2020-02-17</created>
  <modified>2021-09-30 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Checkpoint_XE.sql</sourceLink>
  <originalLink>https://www.mssqltips.com/sqlservertip/6319/sql-server-checkpoint-monitoring-with-extended-events/</originalLink>
</documentation>

DROP TABLE IF EXISTS #xml;
GO
SELECT ev = SUBSTRING([object_name],12,5), ed = CONVERT(xml, event_data)
 INTO #xml
 FROM sys.fn_xe_file_target_read_file('L:\XE_Out\CheckPoint*.xel', NULL, NULL, NULL);
;WITH Events(ev,ts,db,id) AS
(
  SELECT ev,
    ed.value(N'(event/@timestamp)[1]', N'datetime'),
    ed.value(N'(event/data[@name="database_id"]/value)[1]', N'int'),
    ed.value(N'(event/action[@name="attach_activity_id"]/value)[1]', N'uniqueidentifier')
  FROM #xml
), 
EventPairs AS
(
  SELECT db, ev, 
    checkpoint_ended = ts, 
    checkpoint_began = LAG(ts, 1) OVER (PARTITION BY id, db ORDER BY ts)
  FROM Events
),
Timings AS
(
  SELECT 
    dbname = DB_NAME(db), 
    checkpoint_began, 
    checkpoint_ended,
    duration_milliseconds = DATEDIFF(MILLISECOND, checkpoint_began, checkpoint_ended) 
  FROM EventPairs WHERE ev = 'end' AND checkpoint_began IS NOT NULL
)
SELECT 
  dbname,
  checkpoint_count    = COUNT(*),
  avg_seconds         = CONVERT(decimal(18,2),AVG(1.0*duration_milliseconds)/1000),
  max_seconds         = CONVERT(decimal(18,2),MAX(1.0*duration_milliseconds)/1000),
  total_seconds_spent = CONVERT(decimal(18,2),SUM(1.0*duration_milliseconds)/1000)
FROM Timings
GROUP BY dbname
ORDER BY total_seconds_spent DESC;
