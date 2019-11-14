/*
<documentation>
  <summary>Get all databases meta data using dynamic T-SQL</summary>
  <returns>1 data set: temp table #DatabaseInfo.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2018-03-01</created>
  <modified>2019-11-14 by Konstantin Taranov</modified>
  <version>1.2</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Databases_Report.sql</sourceLink>
</documentation>
*/

SET NOCOUNT ON;

DECLARE @tsql  nvarchar(max);
DECLARE @crlf  nvarchar(10) = NCHAR(13) + NCHAR(10);
DECLARE @debug bit          = 0;

IF OBJECT_ID('tempdb..#DatabaseInfo', 'U') IS NOT NULL DROP TABLE #DatabaseInfo;

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

SELECT @tsql = COALESCE(@tsql, N'') + @crlf +
    N'USE ' + QUOTENAME(name) + N';' + @crlf +
    N'INSERT INTO #DatabaseInfo' + @crlf +
    N'SELECT' + @crlf +
    N'       N' + QUOTENAME(name,'''') + N' AS DBName' + @crlf +
    N'     , (SELECT COUNT(*) AS TableCount      FROM ' + QUOTENAME(name) + N'.sys.tables)' + @crlf +
    N'     , (SELECT ISNULL(SUM(max_column_id_used), 0) AS TableColumnsCount FROM ' + QUOTENAME(name) + N'.sys.tables)' + @crlf +
    N'     , (SELECT COUNT(*) AS ViewCount       FROM ' + QUOTENAME(name) + N'.sys.views)' + @crlf +
    N'     , (SELECT COUNT(*) AS ProcedureCount  FROM ' + QUOTENAME(name) + N'.sys.procedures)' + @crlf +
    N'     , (SELECT COUNT(*) AS TriggerCount    FROM ' + QUOTENAME(name) + N'.sys.triggers)' + @crlf +
    N'     , (SELECT COUNT(*) AS FullTextCatalog FROM ' + QUOTENAME(name) + N'.sys.fulltext_catalogs)' + @crlf +
    N'     , (SELECT COUNT(*) AS XmlIndexes      FROM ' + QUOTENAME(name) + N'.sys.xml_indexes)' + @crlf +
    N'     , (SELECT COUNT(*) AS SpatialIndexes  FROM ' + QUOTENAME(name) + N'.sys.spatial_indexes)' + @crlf +
    N'     , (SELECT SUM(size * 8 / 1024) AS DataTotalSizeMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 0)' + @crlf +
    N'     , (SELECT SUM(FILEPROPERTY(name, ''SpaceUsed'') * 8 / 1024) AS DataSpaceUtilMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 0)' + @crlf +
    N'     , (SELECT SUM(size * 8 / 1024) AS LogTotalSizeMb  FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 1)' + @crlf +
    N'     , (SELECT SUM(FILEPROPERTY(name, ''SpaceUsed'') * 8 / 1024) AS LogSpaceUtilMb FROM ' + QUOTENAME(name) + N'.sys.master_files WHERE database_id = DB_ID(DB_NAME()) AND type = 1);' + @crlf
FROM sys.databases
ORDER BY name;

IF @debug = 1 SELECT @tsql ELSE EXEC sp_executesql @tsql;

SELECT
       DBName
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
FROM   #DatabaseInfo;
