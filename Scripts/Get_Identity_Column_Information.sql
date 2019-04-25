/*
<documentation>
  <summary>Create JOIN query between multiple tables dynamically.</summary>
  <returns>SELECT statement from input table with INNER JOINS for all tables having foreign consttraints with input table.</returns>
  <issues>Does not properly generate alias for case with multiply foreign keys for one table</issues>
  <author>Konstantin Taranov</author>
  <created>2019-04-24</created>
  <modified>2019-04-25 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Identity_Column_Information.sql</sourceLink>
</documentation>
*/


IF OBJECT_ID('tempdb..#IdentityInfo',  'U') IS NOT NULL DROP TABLE #IdentityInfo;
IF OBJECT_ID('tempdb..#IdentityStats', 'U') IS NOT NULL DROP TABLE #IdentityStats;
GO

DECLARE @tsql nvarchar(max) = N'';

SELECT IC.object_id                 AS ObjectID
     , SS.name                      AS SchemaName
     , TN.name                      AS TableName
     , IC.name                      AS ColumnName
     , TYPE_NAME(IC.system_type_id) AS ColumnDataType
     , DTM.DataTypeMinValue
     , DTM.DataTypeMaxValue
     , IC.seed_value                AS IdentitySeed
     , IC.increment_value           AS IdentityIncrement
     , IC.last_value                AS LastIdentityValue
     , DPS.NumberOfRows
  INTO #IdentityInfo
  FROM sys.identity_columns         AS IC
 INNER JOIN sys.tables              AS TN   ON IC.object_id = TN.object_id
 INNER JOIN sys.schemas             AS SS   ON TN.schema_id = SS.schema_id
 INNER JOIN (
              VALUES
              ('tinyint',  0,                    255),
              ('smallint', -32768,               32767),
              ('int',      -2147483648,          2147483647),
              ('bigint',   -9223372036854775808, 9223372036854775807)
             )                      AS DTM(DataType, DataTypeMinValue, DataTypeMaxValue) ON TYPE_NAME(IC.system_type_id) = DTM.DataType
 INNER JOIN (
              SELECT object_id
                   , SCHEMA_NAME(object_id) AS SchemaName
                   , OBJECT_NAME(object_id) AS TableName
                   , SUM(row_count)         AS NumberOfRows
              FROM sys.dm_db_partition_stats
              WHERE index_id < 2
              GROUP BY object_id, SCHEMA_NAME(object_id), OBJECT_NAME(object_id)
              )                     AS DPS ON IC.object_id = DPS.object_id;

IF (SELECT COUNT(1) FROM #IdentityInfo) = 0
THROW 50001, 'You do not have any table with identity column in current database.', 1;

CREATE TABLE #IdentityStats(
    ObjectID         bigint
  , SchemaName       sysname
  , TableName        sysname
  , IdentityColumnMinValue bigint
  , IdentityColumnMaxValue bigint
  , IdentityColumnAvgValue bigint
);

SELECT @tsql = @tsql + N'INSERT INTO #IdentityStats SELECT ' +
       CAST(t.ObjectID AS nvarchar(30)) + N' AS ObjectID, ''' +
       t.SchemaName + N''' AS SchemaName, ''' + t.TableName + N''' AS TableName' +
       N', MIN([' + t.ColumnName +      N']) AS IdentityColumnMinValue' +
       N', MAX([' + t.ColumnName +      N']) AS IdentityColumnMaxValue' +
       N', AVG(CAST([' + t.ColumnName + N'] AS BIGINT)) AS IdentityColumnAvgValue' +
       N' FROM ' + QUOTENAME(t.SchemaName) + N'.' + QUOTENAME(t.TableName) + N' (NOLOCK);' + CHAR(13)
FROM #IdentityInfo AS t;

/*
 // PRINT truncate strings to 4000 char limit, below we using XML trick to solve this issue
*/
SELECT @tsql FOR XML PATH('');

EXEC sp_executesql @tsql;

SELECT ii.*
     , ids.IdentityColumnMaxValue
     , ids.IdentityColumnMinValue
     , ids.IdentityColumnAvgValue
     , (CONVERT(decimal(15,2), CONVERT(bigint, ii.LastIdentityValue) * 100 / ii.DataTypeMaxValue)) AS ReachMaxValuePercent
FROM #IdentityInfo AS ii
INNER JOIN #IdentityStats AS ids ON ii.ObjectID = ids.ObjectID
ORDER BY ReachMaxValuePercent DESC;
