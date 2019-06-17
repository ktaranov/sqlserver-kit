/*
Author: Taiob Ali
Original link: http://sqlworldwide.com/tsql-to-find-status-of-sql-server-statistics/

This code is a modified or extended version of a script from here:
--http://www.sqlskills.com/blogs/erin/new-statistics-dmf-in-sql-server-2008r2-sp2/

This script will give all metadata related to statistics for a single database.
You can also uncomment a line and add an object name for a single table.

Final challenge was to get one row per statistics with all column names. Used the tips from
https://www.mssqltips.com/sqlservertip/2914/rolling-up-multiple-rows-into-a-single-row-and-column-for-sql-server-data/

Suneel Mundlapudi who is a Sr. SQL Server Database Consultant at Fresenius Medical Care helped me implementing STUFF function
*/

/* Change on your database name */
USE master;
GO

IF Object_id('tempdb..#StatsInfo') IS NOT NULL
  DROP TABLE #StatsInfo;
GO

IF Object_id('tempdb..#ColumnList') IS NOT NULL
  DROP TABLE #ColumnList;
GO

DECLARE @object_id INT = NULL;

--By default you get statistics status for whole database
--Uncomment below line if you are only looking at one table
--SET @object_id = OBJECT_ID(N'Sales.Invoices');
SELECT ss.[name]                 AS SchemaName,
       obj.[name]                AS TableName,
       stat.[stats_id],
       stat.[name]               AS StatisticsName,
       CASE
         WHEN stat.[auto_created] = 0
              AND stat.[user_created] = 0 THEN 'Index Statistic'
         WHEN stat.[auto_created] = 0
          AND stat.[user_created] = 1 THEN 'User Created'
         WHEN stat.[auto_created] = 1
          AND stat.[user_created] = 0 THEN 'Auto Created'
         WHEN stat.[auto_created] = 1
          AND stat.[user_created] = 1 THEN 'Updated stats available in Secondary'
       END                       AS StatisticType,
       CASE
         WHEN stat.[is_temporary] = 0 THEN 'Stats in DB'
         WHEN stat.[is_temporary] = 1 THEN 'Stats in Tempdb'
       END                       AS IsTemporary,
       CASE
         WHEN stat.[has_filter] = 1 THEN 'Filtered Index'
         WHEN stat.[has_filter] = 0 THEN 'No Filter'
       END                       AS IsFiltered,
       c.[name]                  AS ColumnName,
       stat.[filter_definition],
       sp.[last_updated],
       sp.[rows],
       sp.[rows_sampled],
       sp.[steps]                AS HistorgramSteps,
       sp.[unfiltered_rows],
       sp.[modification_counter] AS RowsModified
INTO   #StatsInfo
FROM   sys.[objects] AS obj
       INNER JOIN sys.[schemas] ss
               ON obj.[schema_id] = ss.[schema_id]
       INNER JOIN sys.[stats] stat
               ON stat.[object_id] = obj.[object_id]
       JOIN sys.[stats_columns] sc
         ON sc.[object_id] = stat.[object_id]
            AND sc.[stats_id] = stat.[stats_id]
       JOIN sys.columns c
         ON c.[object_id] = sc.[object_id]
            AND c.[column_id] = sc.[column_id]
       CROSS apply sys.dm_db_stats_properties(stat.[object_id], stat.stats_id) AS
                   sp
WHERE  ( obj.[is_ms_shipped] = 0
         AND obj.[object_id] = @object_id )
        OR ( obj.[is_ms_shipped] = 0 )
ORDER  BY ss.[name],
          obj.[name],
          stat.[name];

SELECT t.SchemaName,
       t.TableName,
       t.[stats_id],
       STUFF((SELECT ',' + s.ColumnName
              FROM   #StatsInfo s
              WHERE  s.SchemaName = t.SchemaName
                 AND s.TableName  = t.TableName
                 AND s.stats_id   = t.stats_id
              FOR xml path('')), 1, 1, '')
         AS ColumnList
INTO   #ColumnList
FROM   #StatsInfo AS t
GROUP  BY t.SchemaName,
          t.TableName,
          t.stats_id;

SELECT DISTINCT SI.SchemaName,
                SI.TableName,
                SI.stats_id,
                SI.StatisticsName,
                SI.StatisticType,
                SI.IsTemporary,
                CL.ColumnList AS ColumnName,
                SI.IsFiltered,
                SI.filter_definition,
                SI.last_updated,
                SI.[rows],
                SI.rows_sampled,
                SI.HistorgramSteps,
                SI.unfiltered_rows,
                SI.RowsModified
FROM   #StatsInfo SI
       INNER JOIN #ColumnList CL
               ON SI.SchemaName = CL.SchemaName
                  AND SI.TableName = CL.TableName
                  AND SI.stats_id = CL.stats_id
ORDER  BY SI.SchemaName,
          SI.TableName,
          SI.StatisticsName;
GO
