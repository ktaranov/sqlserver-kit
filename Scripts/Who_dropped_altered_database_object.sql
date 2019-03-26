/*
Created: 2018-10-31 by Rebecca Lewis
Modified: 2019-03-26 by Konstantin Taranov
Original link: http://www.sqlfingers.com/2018/10/who-dropped-that-table.html
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Who_dropped_altered_database_object.sql
*/

SET NOCOUNT ON;

DECLARE @current NVARCHAR(255);
DECLARE @start   NVARCHAR(255);
DECLARE @index   INT;

/* find your trace path */
SELECT @current = path FROM sys.traces WHERE is_default = 1;

SET @current = REVERSE(@current);
SET @index   = PATINDEX('%\%', @current);
SET @current = REVERSE(@current);
SET @start   = LEFT(@current, LEN(@current) - @index) + N'\log.trc';

/* query on the eventclasses for delete and alter */
SELECT te.name AS EventName
     , gt.DatabaseName
     , gt.ObjectName
     , gt.StartTime
     , gt.EndTime
     , gt.HostName
     , gt.ApplicationName
     , gt.NTUserName
     , gt.NTDomainName
     , gt.LoginName
     , gt.SPID
     , gt.EventClass
     , gt.EventSubClass
     , gt.TextData
     , gt.FileName
     , gt.IsSystem
FROM fn_trace_gettable(@start, DEFAULT) AS gt
LEFT JOIN sys.trace_events AS te ON gt.EventClass = te.trace_event_id
WHERE gt.EventSubClass = 0
  AND gt.DatabaseID   <> 2 /* tempdb */
  /*
  AND EventClass IN ( 164 /* Object:Deleted */
                     , 47 /* Object:Altered */
                     , 46 /* Object:Created */
                       )
  */
ORDER BY gt.StartTime;
