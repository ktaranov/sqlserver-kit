-- https://stackoverflow.com/a/42508688/2298061

IF OBJECT_ID('tempdb..#AllTables','U') IS NOT NULL DROP TABLE #AllTables;

CREATE TABLE #AllTables(
     DBName            SYSNAME
   , TableCount        INT
   , ViewCount         INT
   , ProcedureCount    INT
   , TriggerCount      INT
   , FullTextCatalog   INT
   , XmlIndexes        INT
   , SpatialIndexes    INT
   , TableColumnsCount INT
);

DECLARE @SQL NVARCHAR(MAX);

SELECT @SQL = COALESCE(@SQL, N'') + N'USE ' + quotename(name) + N';
    INSERT INTO #AllTables
    SELECT N' + QUOTENAME(name,'''') + N' AS DBName,
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.tables),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.views),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.procedures),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.triggers),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.fulltext_catalogs),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.xml_indexes),
    (SELECT COUNT(*) FROM ' + QUOTENAME(name) + N'.sys.spatial_indexes),
    (SELECT SUM(max_column_id_used) FROM ' + QUOTENAME(name) + N'.sys.tables);
'
FROM sys.databases
ORDER BY name;

EXECUTE sp_executesql @SQL;

SELECT DBName
     , TableCount
     , ViewCount
     , ProcedureCount
     , TriggerCount
     , FullTextCatalog
     , XmlIndexes
     , SpatialIndexes
     , TableColumnsCount
  FROM #AllTables;
