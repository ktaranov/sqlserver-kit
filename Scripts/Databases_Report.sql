/*
<documentation>
  <summary>Get all databases meta data using TSQL</summary>
  <returns>1 data set: temp table #DatabaseInfo.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2018-03-01</created>
  <modified>2019-08-05 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Databases_Report.sql</sourceLink>
</documentation>
*/

SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#DatabaseInfo','U') IS NOT NULL DROP TABLE #DatabaseInfo;

CREATE TABLE #DatabaseInfo(
     DBName            sysname NOT NULL
   , TableCount        int     NOT NULL
   , TableColumnsCount int     NOT NULL
   , ViewCount         int     NOT NULL
   , ProcedureCount    int     NOT NULL
   , TriggerCount      int     NOT NULL
   , FullTextCatalog   int     NOT NULL
   , XmlIndexes        int     NOT NULL
   , SpatialIndexes    int     NOT NULL
   , DataTotalSizeMb   int     NOT NULL
   , DataSpaceUtilMb   int     NOT NULL
   , LogTotalSizeMb    int     NOT NULL
   , LogSpaceUtilMb    int     NOT NULL
);

DECLARE @tsql NVARCHAR(MAX);

SELECT @tsql = COALESCE(@tsql, N'') + N'
    USE ' + QUOTENAME(name) + N';
    INSERT INTO #DatabaseInfo
    SELECT N' + QUOTENAME(name,'''') + N' AS DBName,
    (SELECT COUNT(*) AS TableCount      FROM ' + QUOTENAME(name) + N'.sys.tables),
    (SELECT ISNULL(SUM(max_column_id_used), 0) AS TableColumnsCount FROM ' + QUOTENAME(name) + N'.sys.tables),
    (SELECT COUNT(*) AS ViewCount       FROM ' + QUOTENAME(name) + N'.sys.views),
    (SELECT COUNT(*) AS ProcedureCount  FROM ' + QUOTENAME(name) + N'.sys.procedures),
    (SELECT COUNT(*) AS TriggerCount    FROM ' + QUOTENAME(name) + N'.sys.triggers),
    (SELECT COUNT(*) AS FullTextCatalog FROM ' + QUOTENAME(name) + N'.sys.fulltext_catalogs),
    (SELECT COUNT(*) AS XmlIndexes      FROM ' + QUOTENAME(name) + N'.sys.xml_indexes),
    (SELECT COUNT(*) AS SpatialIndexes  FROM ' + QUOTENAME(name) + N'.sys.spatial_indexes),
    (SELECT SUM(size * 8 / 1024) AS DataTotalSizeMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 0),
    (SELECT SUM(FILEPROPERTY(name, ''SpaceUsed'') * 8 / 1024) AS DataSpaceUtilMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 0),
    (SELECT SUM(size * 8 / 1024) AS LogTotalSizeMb  FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 1),
    (SELECT SUM(FILEPROPERTY(name, ''SpaceUsed'') * 8 / 1024) AS LogSpaceUtilMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 1);
'
FROM sys.databases
ORDER BY name;

--PRINT(@tsql);
EXEC sp_executesql @tsql;

SELECT DBName
     , TableCount
     , TableColumnsCount
     , ViewCount
     , ProcedureCount
     , TriggerCount
     , FullTextCatalog
     , XmlIndexes
     , SpatialIndexes
     , DataTotalSizeMb
     , DataSpaceUtilMb
     , LogTotalSizeMb
     , LogSpaceUtilMb
  FROM #DatabaseInfo AS t;
