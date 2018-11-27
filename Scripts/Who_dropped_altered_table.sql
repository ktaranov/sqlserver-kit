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
SELECT CASE t.EventClass
           WHEN 164 THEN 'Object:Altered'
           WHEN 47  THEN 'Object:Dropped'
       END [Action]
     , t.DatabaseName
     , t.ObjectName
     , t.HostName
     , t.ApplicationName
     , t.LoginName
     , t.SPID
     , t.StartTime
FROM::fn_trace_gettable(@start, DEFAULT) AS t
WHERE EventClass IN (164,47)
AND t.EventSubClass = 0
AND t.DatabaseID <> 2
ORDER BY t.StartTime;
