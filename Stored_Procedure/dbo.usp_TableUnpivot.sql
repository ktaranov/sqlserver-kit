IF OBJECT_ID('dbo.usp_TableUnpivot', 'P') IS NULL
EXEC ('CREATE PROCEDURE dbo.usp_TableUnpivot AS SELECT 1');
go

ALTER PROCEDURE dbo.usp_TableUnpivot (
    @databaseName    sysname       = '',
    @schemaName      sysname       = 'dbo',
    @tableName       sysname,
    @unpivotColumns  nvarchar(max) = '',
    @constantColumns nvarchar(max) = '',
    @excludeColumns  nvarchar(max) = '',
    @orderBYColumns  nvarchar(max) = '',
    @debug           bit           = 0
)
AS

/*
CREATE TABLE dbo.CustomerPhones
(
  CustomerID INT PRIMARY KEY, -- FK
  Phone1 VARCHAR(32),
  PhoneType1 CHAR(4),
  Phone2 VARCHAR(32),
  PhoneType2 CHAR(4),
  Phone3 VARCHAR(32),
  PhoneType3 CHAR(4)
);
INSERT INTO dbo.CustomerPhones (CustomerID, Phone1, PhoneType1, Phone2, PhoneType2, Phone3, PhoneType3)
VALUES
  (1,'705-491-1111', 'cell', '705-491-1110', 'home', NULL,NULL),
  (2,'613-492-2222', 'home', NULL, NULL, NULL, NULL),
  (3,'416-493-3333', 'work', '416-493-3330', 'cell', '416-493-3339', 'home');

EXECUTE [usp_TableUnpivot] @databaseName    = '',
                           @schemaName      = 'dbo',
                           @tableName       = 'CustomerPhones',
                           @unpivotColumns  = 'CustomerID',  /*!!! table columns list for unpivot with comma separator without spaces !!!*/
                           @excludeColumns  = 'TableNameID',        /*!!! table columns list for excluding with comma separator without spaces !!!*/
                           @constantColumns = ', ''Constant1'' AS ConstantColumnName1, ''Constant2'' AS ConstantColumnName2', /*!!! constant values !!!*/
                           @oderByColumns   = '',
                           @debug           = 1;                    /*!!! only generate sql statement without executing it !!!*/
*/

BEGIN

BEGIN TRY

    DECLARE @tableColumns    nvarchar(max) = '';
    DECLARE @tableNameFull   nvarchar(400) = CASE WHEN @databaseName = '' THEN '' ELSE QUOTENAME(@databaseName) + '.' END + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName);
    DECLARE @object_id       integer       = OBJECT_ID(@tableNameFull);
    DECLARE @sqlCommand      nvarchar(max) = '';
    DECLARE @ParmDefinition  nvarchar(500) = '@object_idIN INTEGER, @ColumnsOUT VARCHAR(MAX) OUTPUT';
    DECLARE @crlf            nvarchar(5)   = CHAR(13);

    IF @debug = 0 SET NOCOUNT ON ELSE PRINT '/******* Start Debug' + @crlf;

    IF @debug = 1 PRINT ISNULL('@tableNameFull = {' + CAST(@tableNameFull AS VARCHAR) + '}', '@tableNameFull = Null');
    IF @debug = 1 PRINT ISNULL('@object_id = {' + CAST(@object_id AS VARCHAR) + '}', '@object_id = Null');

    SET @sqlCommand = CASE WHEN @databaseName = '' THEN '' ELSE N'USE ' + QUOTENAME(@databaseName) + N';' END + @crlf +
                      N'SELECT @ColumnsOUT  = @ColumnsOUT + QUOTENAME(Name) + '','''                          + @crlf +
                      N'FROM sys.columns sac '                                                                + @crlf +
                      N'WHERE sac.object_id = @object_idIN'                                                   + @crlf +
                      N'      AND Name NOT IN (''' + REPLACE(@unpivotColumns, N',', N''',''') + N''','''
                                                   + REPLACE(@excludeColumns, N',', N''',''') + N''')'        + @crlf +
                      N'ORDER BY Name;';

    IF @debug = 1 PRINT ISNULL(N'@sqlCommand = {' + @crlf + @sqlCommand + @crlf + N'}', N'@sqlCommand = Null');

    EXECUTE sp_executesql @sqlCommand, @ParmDefinition, @object_idIN = @object_id, @ColumnsOUT = @tableColumns OUTPUT SELECT @tableColumns;

    IF @debug = 1 PRINT ISNULL('@tableColumns = {' + @crlf + @tableColumns + @crlf + '}', '@tableColumns = Null');

    SET @tableColumns = CASE WHEN LEN(@tableColumns) > 0 THEN LEFT(@tableColumns, LEN(@tableColumns) - 1) END;

    SET @sqlCommand = N'SELECT ' + @unpivotColumns  + N', val, columns' + @constantColumns + @crlf +
                      N'  FROM '                                                           + @crlf +
                      N'      ('                                                           + @crlf +
                      N'        SELECT *'                                                  + @crlf +
                      N'          FROM ' + @schemaName + '.' + @tableName                  + @crlf +
                      N') s'                                                               + @crlf +
                      N'UNPIVOT'                                                           + @crlf +
                      N' ('                                                                + @crlf +
                      N'   val FOR columns IN (' + @tableColumns + ' )'                    + @crlf +
                      N' ) p'                                                              + @crlf +
                      CASE WHEN @orderBYColumns != '' THEN N'ORDER BY ' + @orderBYColumns ELSE '' END;
    
    IF @debug = 1 PRINT CAST(ISNULL('@sqlCommand = {' + @crlf + @sqlCommand + @crlf + '}' + @crlf, '@sqlCommand = Null' + @crlf) AS TEXT);
    
    IF @debug = 0 EXECUTE sp_executesql @sqlCommand;
    
    IF @debug = 0 SET NOCOUNT OFF ELSE PRINT 'End Debug *******/';
    END TRY

    BEGIN CATCH
        PRINT(@crlf +
            'Error: '     + CONVERT(varchar(50), ERROR_NUMBER())  +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE())    +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-')        +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE())     +
          ', User name: ' + CONVERT(sysname, ORIGINAL_LOGIN())
          );
        PRINT(ERROR_MESSAGE() + @crlf + @crlf);
    END CATCH;

END
GO
