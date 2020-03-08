/*
<documentation>
  <summary>Dynamically generate GRANTs.</summary>
  <returns>PRINT dynamically generated GRANTs for user.</returns>
  <created>2020-03-02 by Aaron Bertrand</created>
  <modified>2020-03-05 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Read_Default_Trace.sql</sourceLink>
  <originalLink>https://sqlperformance.com/2020/03/extended-events/removing-default-trace-1</originalLink>
</documentation>
*/


IF OBJECT_ID('tempdb..#t','U') IS NOT NULL DROP TABLE #t;
GO

WITH filesrc ([path]) AS
(
  SELECT REVERSE(SUBSTRING(p, CHARINDEX(N'\', p), 260)) + N'log.trc'
  FROM (SELECT REVERSE([path]) FROM sys.traces WHERE is_default = 1) s(p)
),
tracedata AS 
(
  SELECT Context = CASE 
    WHEN DDL = 1 THEN 
      CASE WHEN LEFT(ObjectName,8) = N'_WA_SYS_' 
                THEN 'AutoStat: ' + DBType
           WHEN LEFT(ObjectName,2) IN (N'PK', N'UQ', N'IX') AND ObjectName LIKE N'%[_#]%' 
                THEN UPPER(LEFT(ObjectName,2)) + ': tempdb'
           WHEN ObjectType = 17747 AND ObjectName LIKE N'TELEMETRY%' 
                THEN 'Telemetry' 
                ELSE 'Other DDL in ' + DBType END
    WHEN EventClass = 116 THEN 
      CASE WHEN TextData LIKE N'%checkdb%' THEN 'DBCC CHECKDB'
           -- several more of these ...
           ELSE UPPER(CONVERT(nchar(32), TextData)) END
    ELSE DBType END,
    EventName = CASE WHEN DDL = 1 THEN 'DDL' ELSE EventName END, 
    EventSubClass,
    EventClass, 
    StartTime
  FROM
  (
    SELECT DDL = CASE WHEN t.EventClass IN (46,47,164) THEN 1 ELSE 0 END, 
      TextData = LOWER(CONVERT(nvarchar(512), t.TextData)), 
      EventName = e.[name],
      t.EventClass, 
      t.EventSubClass, 
      ObjectName = UPPER(t.ObjectName), 
      t.ObjectType, 
      t.StartTime,
      DBType = CASE WHEN t.DatabaseID = 2 OR t.ObjectName LIKE N'#%' THEN 'tempdb'
                    WHEN t.DatabaseID IN (1,3,4)  THEN 'System database'
                    WHEN t.DatabaseID IS NOT NULL THEN 'User database' ELSE '?' END
    FROM filesrc CROSS APPLY sys.fn_trace_gettable(filesrc.[path], DEFAULT) AS t
    LEFT OUTER JOIN sys.trace_events AS e ON t.EventClass = e.trace_event_id
  ) AS src WHERE (EventSubClass IS NULL) 
           OR (EventSubClass = CASE WHEN DDL = 1 THEN 1 ELSE EventSubClass END) -- ddl_phase
)
SELECT @@SERVERNAME AS "Instance",
       EventName,
       Context,
       EventCount = COUNT(*),
       FirstSeen  = MIN(StartTime),
       LastSeen   = MAX(StartTime)
INTO #t FROM tracedata
GROUP BY GROUPING SETS ((), (EventName, Context));

SELECT * FROM #t ORDER BY EventCount DESC;
