IF OBJECT_ID('dbo.usp_TableUnpivot', 'P') IS NULL EXECUTE ('CREATE PROCEDURE dbo.usp_TableUnpivot as select 1');
go

ALTER PROCEDURE dbo.usp_TableUnpivot (
                                       @databaseName    SYSNAME       = '',
                                       @schemaName      SYSNAME       = 'dbo',
                                       @tableName       SYSNAME,
                                       @unpivotColumns  NVARCHAR(MAX) = '',
                                       @constantColumns NVARCHAR(MAX) = '',
                                       @excludeColumns  NVARCHAR(MAX) = '',
                                       @orderBYColumns  NVARCHAR(MAX) = '',
                                       @debug BIT                     = 0
                                     )
AS

/*
EXECUTE [usp_TableUnpivot] @databaseName    = '',
                           @schemaName      = 'dbo',
                           @tableName       = 'TableName',
                           @unpivotColumns  = 'UnpivotColumnName',  /*!!! table columns list for unpivot with comma separator without spaces !!!*/
                           @excludeColumns  = 'TableNameID',        /*!!! table columns list for excluding with comma separator without spaces !!!*/
                           @constantColumns = ', ''Constant1'' AS ConstantColumnName1, ''Constant2'' AS ConstantColumnName2', /*!!! constant values !!!*/
                           @oderByColumns   = '',
                           @debug           = 1;                    /*!!! only generate sql statement without executing it !!!*/         
*/

BEGIN

DECLARE @tableColumns    NVARCHAR(MAX) = '';
DECLARE @tableNameFull   NVARCHAR(400) = CASE WHEN @databaseName = '' THEN '' ELSE QUOTENAME(@databaseName) + '.' END + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName);
DECLARE @object_id       INTEGER       = OBJECT_ID(@tableNameFull);
DECLARE @sqlCommand      NVARCHAR(MAX) = '';
DECLARE @ParmDefinition  NVARCHAR(500) = '@object_idIN INTEGER, @ColumnsOUT VARCHAR(MAX) OUTPUT';
DECLARE @crlf            NVARCHAR(5)   = CHAR(13);

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

END
go
