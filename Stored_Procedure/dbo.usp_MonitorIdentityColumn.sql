IF OBJECT_ID('dbo.usp_MonitorIdentityColumn', 'P') IS NULL
EXECUTE('CREATE PROCEDURE dbo.usp_MonitorIdentityColumn as SELECT 1');
GO


ALTER PROCEDURE dbo.usp_MonitorIdentityColumn (
                @databaseName SYSNAME
              , @schemaMask SYSNAME = NULL
              , @tableMask  SYSNAME = NULL
              , @debug      BIT     = 0
)
AS
/*
EXECUTE dbo.usp_MonitorIdentityColumn
        @databaseName = 'YourDatabase'
      , @schemaMask    = '%YourMask%'
      , @tableMask     = '%YourMask%'
*/
SET NOCOUNT ON;

BEGIN TRY
DECLARE @tsqlCommand NVARCHAR(MAX) = N'';
DECLARE @ParamDefinitionIndentity NVARCHAR(500) = N'@DabataseNameIN SYSNAME';

SET @tsqlCommand = N'
USE ' + @databaseName + ';

DECLARE @DataTypeValue AS TABLE (DataType VARCHAR(50), MinValue BIGINT, MaxValue BIGINT);

INSERT INTO @DataTypeValue VALUES
   (''tinyint'',  0,                    255),
   (''smallint'', -32768,               32767),
   (''int'',      -2147483648,          2147483647),
   (''bigint'',   -9223372036854775808, 9223372036854775807);

SELECT DISTINCT SS.name AS SchemaName
     , TN.name AS TableName
     , IC.name AS ColumnName
     , TYPE_NAME(IC.system_type_id) AS ColumnDataType
     , DTM.MinValue AS MinDataTypeValue
     , DTM.MaxValue AS MaxDataTypeValue
     , IC.seed_value IdentitySeed
     , IC.increment_value AS IdentityIncrement
     , IC.last_value AS LastIdentityValue
     , DBPS.row_count AS NumberOfRows
     , (CONVERT(decimal(9,7), CONVERT(bigint,IC.last_value) * 100 / DTM.MaxValue)) AS ReachMaxValuePercent
  FROM sys.identity_columns IC
 INNER JOIN sys.tables TN ON IC.object_id = TN.object_id
 INNER JOIN sys.schemas SS ON TN.schema_id = SS.schema_id
 INNER JOIN @DataTypeValue DTM ON TYPE_NAME(IC.system_type_id)=DTM.DataType
 INNER JOIN sys.dm_db_partition_stats DBPS ON DBPS.object_id =IC.object_id
 INNER JOIN sys.indexes as IDX ON DBPS.index_id =IDX.index_id
WHERE DBPS.row_count > 0 AND TN.name LIKE ''' + ISNULL(@tableMask, '%') + '''
      AND SS.name LIKE ''' + ISNULL(@schemaMask, '%') + '''
ORDER BY ReachMaxValuePercent DESC;
';

IF @debug = 1 PRINT @tsqlCommand
ELSE
EXECUTE sp_executesql @tsqlCommand;

END TRY

BEGIN CATCH
    EXECUTE dbo.usp_LogError;
    EXECUTE dbo.usp_PrintError;
END CATCH;
GO
