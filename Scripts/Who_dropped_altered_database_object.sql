/*
Author: Rebecca Lewis
Original link: http://www.sqlfingers.com/2018/10/who-dropped-that-table.html
*/

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
     , gt.HostName
     , gt.ApplicationName
     , gt.NTUserName
     , gt.NTDomainName
     , gt.LoginName
     , gt.SPID
     , gt.EventClass
     , gt.EventSubClass
     , gt.TextData
     , gt.StartTime
     , gt.EndTime
     , gt.ObjectName
     , gt.DatabaseName
     , gt.FileName
     , gt.IsSystem
FROM fn_trace_gettable(@start, DEFAULT) gt
LEFT JOIN sys.trace_events te ON gt.EventClass = te.trace_event_id
WHERE EventClass IN (164, 47)
AND gt.EventSubClass = 0
AND gt.DatabaseID <> 2
ORDER BY gt.StartTime;
