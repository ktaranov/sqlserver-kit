/*
Author: Eric Russell
Original link: http://www.sqlservercentral.com/scripts/tempdb/151252/
*/
-- Query details about objects allocated in TEMPDB. This must be run in context of TEMPDB database.
SET LOCK_TIMEOUT 10000;
SET DEADLOCK_PRIORITY LOW;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

USE tempdb;

SELECT * FROM
(
SELECT DISTINCT
 DB_NAME() AS DatabaseName
, ps.object_id AS ObjectID
, o.type_desc AS ObjectType
, o.name AS ObjectName
, o.create_date AS ObjectCreated
, si.name AS IndexName
, CASE si.index_id
   WHEN 0 THEN 'HEAP'
   WHEN 1 THEN 'CLUSTERED'
   ELSE 'NONCLUSTERED'
   END AS IndexType
, ps.row_count AS RowsCount
, ((ps.reserved_page_count * 8024) / 1024 / 1024) AS ReservedMB
, trace.SPID
, er.start_time AS RequestStartTime
, trace.ApplicationName
, OBJECT_NAME( qt.objectid, qt.dbid ) AS ProcedureName
, SUBSTRING(CHAR(13) + SUBSTRING (qt.text,(er.statement_start_offset/2) + 1
   ,((CASE WHEN er.statement_end_offset = -1
   THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
   ELSE er.statement_end_offset
   END - er.statement_start_offset)/2) + 1)
   ,1,8000) AS StatementText
, trace.HostName
, trace.LoginName
FROM sys.dm_db_partition_stats ps
JOIN sys.tables  AS o ON o.object_id = ps.OBJECT_ID AND o.is_ms_shipped = 0
LEFT JOIN sys.indexes si ON si.object_id = o.object_id AND si.index_id = ps.index_id
LEFT JOIN
(
SELECT HostName, LoginName, SPID, ApplicationName, DatabaseName, ObjectID
   , ROW_NUMBER() OVER (PARTITION BY ObjectID ORDER BY StartTime DESC) MostRecentObjectReference
FROM fn_trace_gettable(
   (
   SELECT LEFT(path, LEN(path)-CHARINDEX('\', REVERSE(path))) + '\Log.trc'
   FROM    sys.traces
   WHERE   is_default = 1
   ), DEFAULT)
WHERE ObjectID IS NOT NULL
) trace
   ON trace.ObjectID = ps.object_id
   AND trace.DatabaseName = 'tempdb'
   AND MostRecentObjectReference = 1
LEFT JOIN sys.dm_exec_requests AS er
       ON er.session_id = trace.SPID
OUTER APPLY sys.dm_exec_sql_text( er.sql_handle) AS qt
) AS T
--WHERE ReservedMB > 0
ORDER BY ReservedMB DESC;
