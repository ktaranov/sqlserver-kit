/*
Author: @DBA_ANDY
Original link: http://nebraskasql.blogspot.ru/2017/07/toolbox-which-tables-are-using-all-of.html
Desctiption: Which Tables are Using All of My Space? 
*/

/*
Object Sizes
Modified from http://stackoverflow.com/questions/15896564/get-table-and-index-storage-size-in-sql-server
*/
SELECT TOP 50
 @@SERVERNAME as InstanceName
 , DB_NAME() as DatabaseName
 , s.NAME AS SchemaName
 , t.NAME  AS TableName
 , SUM(p.rows) AS RowCounts
 --, SUM(a.total_pages) * 8 AS TotalSpaceKB
 , SUM(a.total_pages) * 8/1024.0 AS TotalSpaceMB
 , SUM(a.total_pages) * 8/1024.0/1024.0 AS TotalSpaceGB
 , SUM(a.used_pages) * 8/1024.0 AS UsedSpaceMB
 , (SUM(a.total_pages) - SUM(a.used_pages)) * 8/1024.0 AS UnusedSpaceMB
FROM sys.tables t
INNER JOIN sys.schemas s
ON s.schema_id = t.schema_id
INNER JOIN sys.indexes i
ON t.OBJECT_ID = i.object_id
INNER JOIN sys.partitions p
ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a
ON p.partition_id = a.container_id
WHERE t.NAME NOT LIKE 'dt%'    -- filter out system tables for diagramming
AND t.is_ms_shipped = 0
AND i.OBJECT_ID > 255
GROUP BY t.Name
, s.Name
ORDER BY TotalSpaceMB DESC
