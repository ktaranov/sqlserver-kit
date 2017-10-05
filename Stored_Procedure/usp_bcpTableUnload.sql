IF OBJECT_ID('dbo.usp_bcpTableUnload', 'P') IS NULL EXECUTE ('CREATE PROCEDURE dbo.usp_bcpTableUnload AS SELECT 1');
GO

ALTER PROCEDURE [dbo].[usp_bcpTableUnload](
      @path                NVARCHAR(900)
    , @serverName          SYSNAME       = @@SERVERNAME
    , @databaseName        SYSNAME
    , @schemaName          SYSNAME
    , @tableName           SYSNAME
    , @field_term          NVARCHAR(10)  = N'|'
    , @row_term            NVARCHAR(10)  = N'\n'
    , @fileExtension       NVARCHAR(10)  = N'txt'
    , @codePage            NVARCHAR(10)  = N'C65001'
    , @excludeColumns      NVARCHAR(MAX) = N''
    , @orderByColumns      NVARCHAR(MAX) = N''
    , @outputColumnHeaders BIT           = 1
    , @savePhysicalOrder   BIT           = 1     -- 0 - Alphabet column order type; 1 - physical column order type
    , @formatFile          VARCHAR(4)    = 'xml' -- formatfile = @schemaName.@tableName.fmt, -x formatfile = @schemaName.@tableName.xml, blank string without generation format file
    , @collation           VARCHAR(128)  = ''    -- blank for keep blank value in formatfile (formatfile value 1 needed)
    , @debug               BIT           = 0
)
AS
/*
bcp docs: https://docs.microsoft.com/en-us/sql/tools/bcp-utility
-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1;
GO
-- To update the currently configured value for advanced options.
RECONFIGURE;
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1;
GO
-- To update the currently configured value for this feature.
RECONFIGURE;
GO
EXECUTE [dbo].[usp_bcpTableUnload]
      @path                = N'd:\'
    , @databaseName        = N'DatabaseName'
    , @schemaName          = N'dbo'
    , @tableName           = N'TableName'
    , @field_term          = N'|'
    , @row_term            = N'\n'
    , @fileExtension       = N'txt'
    , @excludeColumns      = N'[CreatedDate],[ModifiedDate],[UserID]'
    , @orderByColumns      = N'TableNameID'
    , @outputColumnHeaders = 1
    , @formatFile          = N'xml'
    , @debug               = 0;
*/
BEGIN

    BEGIN TRY
    IF @debug = 0 SET NOCOUNT ON;

    DECLARE @tsqlCommand         NVARCHAR(MAX) = '';
    DECLARE @cmdCommand          VARCHAR(8000)  = '';
    DECLARE @ParmDefinition      NVARCHAR(500) = '@object_idIN INTEGER, @ColumnsOUT VARCHAR(MAX) OUTPUT';
    DECLARE @tableFullName       SYSNAME       = QUOTENAME(@databaseName) + '.' + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName);
    DECLARE @object_id           INTEGER       = OBJECT_ID(@tableFullName);
    DECLARE @Columns             NVARCHAR(MAX) = '';
    DECLARE @collation_count     INTEGER;
    DECLARE @current_collation   VARCHAR(128)  = '';
    DECLARE @CollParmDefinition  NVARCHAR(500) = '@OUT VARCHAR(128) OUTPUT';
    DECLARE @filePath            NVARCHAR(900) = @path + @tableFullName + '.' + @fileExtension;
    DECLARE @crlf                NVARCHAR(10)  = CHAR(13);
    DECLARE @orderByColumns_term NVARCHAR(10)  = ',';
    DECLARE @TROW50000           NVARCHAR(MAX) = 'Table ' + @tableFullName + ' is not exists in database ' + QUOTENAME(@databaseName) + '!!!';
    DECLARE @TROW50001           NVARCHAR(MAX) = 'Some columns in @orderByColumns = {' + @orderByColumns + '} not exists in table ' + @tableFullName + '!!!';

    IF @debug = 1 PRINT ISNULL('/******* Start Debug' + @crlf + '@tableFullName = {' + CAST(@tableFullName AS NVARCHAR(MAX)) + '}', '@tableFullName = {Null}');
    IF @debug = 1 PRINT ISNULL('@object_id = {' + CAST(@object_id AS NVARCHAR(MAX)) + '}', '@object_id = {Null}');

    IF @formatFile NOT IN ('', 'xml', 'fmt') THROW 50002, 'Allowed values for parameter @formatFile is xml, fmt or blank value', 1;
    --IF @formatFile IN ('xml', 'fmt') AND @savePhysicalOrder <> 1 THROW 50003, 'Creating format file without @savePhysicalOrder = 1 parameter not allowed', 1;
    IF @formatFile = '' AND @collation <> '' THROW 50004, 'Using collation parameter not allowed without formatile', 1;
    IF @collation <> ''
    BEGIN
        SET @tsqlCommand = N'select @OUT=COUNT(*) 
                            from sys.fn_helpcollations() 
                            WHERE name = ''' + @collation+ ''';';
        IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);
        EXECUTE sp_executesql @tsqlCommand, @CollParmDefinition, @OUT=@collation_count OUTPUT;
        IF @collation_count=0 THROW 50004, 'Defined collation not found in server collations list', 1;
    END;

    IF @object_id IS NULL THROW 50000, @TROW50000, 1
    IF @orderByColumns <> ''
    BEGIN
        SET @tsqlCommand = N'USE ' + @databaseName + ';'                                                             + @crlf +
                           N'SELECT @ColumnsOUT = COUNT(*)'                                                          + @crlf +
                           N'FROM sys.columns sac '                                                                  + @crlf +
                           N'WHERE sac.object_id = @object_idIN'                                                     + @crlf +
                           N'      AND QUOTENAME(Name) IN (''[' + REPLACE(@orderByColumns, ',', ']'',''[') + ']'');' + @crlf;

        IF @debug = 1 PRINT ISNULL(N'@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + N'}', N'@tsqlCommand = {Null}');
        EXECUTE sp_executesql @tsqlCommand, @ParmDefinition, @object_idIN = @object_id, @ColumnsOUT = @Columns OUTPUT SELECT @Columns;
        IF @Columns <> (DATALENGTH(@orderByColumns) - DATALENGTH(Replace(@orderByColumns, @orderByColumns_term, ''))) / DATALENGTH(@orderByColumns_term) + 1
        THROW 50001, @TROW50001, 1;
        SET @Columns = '';
    END;

    SET @tsqlCommand = N'USE ' + @databaseName + ';'                                                            + @crlf +
                       N'SELECT @ColumnsOUT = @ColumnsOUT + QUOTENAME(Name) + '','''                            + @crlf +
                       N'FROM sys.columns sac '                                                                 + @crlf +
                       N'WHERE sac.object_id = @object_idIN'                                                    + @crlf +
                       N'      AND QUOTENAME(Name) NOT IN (''' + REPLACE(@excludeColumns, ',', ''',''') + ''')
                       __row_order__;';

    IF @savePhysicalOrder = 1 SET @tsqlCommand = REPLACE(@tsqlCommand, '__row_order__', '');
    ELSE SET @tsqlCommand = REPLACE(@tsqlCommand, '__row_order__', 'ORDER BY Name');

    IF @debug = 1 PRINT ISNULL(N'@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + N'}', N'@tsqlCommand = {Null}');
    EXECUTE sp_executesql @tsqlCommand, @ParmDefinition, @object_idIN = @object_id, @ColumnsOUT = @Columns OUTPUT SELECT @Columns;

    IF @debug = 1 PRINT ISNULL('@Columns = {' + @crlf + @Columns + @crlf + '}', '@Columns = {Null}');

    SET @Columns = CASE WHEN LEN(@Columns) > 0 THEN LEFT(@Columns, LEN(@Columns) - 1) END;

    IF @debug = 1 PRINT CAST(ISNULL('@Columns = {' + @Columns + '}', '@Columns = {Null}') AS TEXT);

    SET @tsqlCommand = 'EXECUTE xp_cmdshell ' +  '''bcp "SELECT ' + @Columns + '  FROM ' + @tableFullName +
                        CASE WHEN @orderByColumns <> '' THEN ' ORDER BY ' + @orderByColumns ELSE '' END +
                        '" queryout "' +  @filePath + '" -T -S ' + @serverName +' -c -' + @codePage +
                        ' -t"' +  @field_term + '"' + ' -r"' +  @row_term + '"''' + @crlf;

    IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);
    ELSE EXECUTE sp_executesql @tsqlCommand;

    IF @outputColumnHeaders = 1
        BEGIN
             SET @tsqlCommand = 'EXECUTE xp_cmdshell ' +  '''bcp "SELECT ''''' + REPLACE(@Columns, ',',  @field_term) +
                                '''''" queryout "' + @path + @tableFullName + '_headers.' + @fileExtension + '" -T -S ' +
                                @serverName + ' -c -' + @codePage + ' -t"' +  @field_term + '"' +
                                ' -r"' +  @row_term + '"''' + @crlf;
             IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}',
                                      '@tsqlCommand = {Null}' + @crlf) AS TEXT);
             ELSE EXECUTE sp_executesql @tsqlCommand;
        
             SET @cmdCommand = 'copy /b "' + @path + @tableFullName + '_headers.' + @fileExtension + '" + "' +
                               @filePath + '" "' + @path + @tableFullName + '_headers.' + @fileExtension 
                               + '" && ' + 'del "' + @filePath + '"'
                               + ' && ' + 'ren "' + @path + @tableFullName + '_headers.'+ @fileExtension + '" ' + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName) + '.' + @fileExtension;
             IF @debug = 1 PRINT CAST(ISNULL('@cmdCommand = {' + @crlf + @cmdCommand + @crlf + '}', '@cmdCommand = {Null}' + @crlf) AS TEXT);
             ELSE EXECUTE xp_cmdshell @cmdCommand;
        
        END

    IF @formatFile IN ('xml', 'fmt')
    BEGIN
        IF @savePhysicalOrder = 1 SET @tsqlCommand = 'EXECUTE xp_cmdshell ''bcp __full_table_name__ format nul -c -f "__path____filename__del.__format_file__ -t"|" -T''';
        ELSE SET @tsqlCommand =
'IF OBJECT_ID(''__databaseName__.__schemaTableName__'') IS NOT NULL DROP TABLE __schemaTableName__; SELECT __Columns__ INTO __schemaTableName__ FROM __full_table_name__ WHERE 1=2; EXECUTE xp_cmdshell ''bcp __databaseName__.__schemaTableName__ format nul -c -f "__path____filename__del.__format_file__ -t"|" -T'';DROP TABLE __schemaTableName__;'
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', QUOTENAME(@databaseName));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__Columns__', @Columns);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__schemaTableName__', QUOTENAME(@schemaName) + '.' + QUOTENAME(CASE WHEN @savePhysicalOrder = 1 THEN @tableName WHEN @savePhysicalOrder = 0 THEN 'tmp' + @tableName  END));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__filename__', QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__path__', @path);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__format_file__', CASE WHEN @formatFile = 'xml' THEN 'xml" -x' WHEN @formatFile = 'fmt' THEN 'fmt"' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__full_table_name__', @tableFullName);
        IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);
        ELSE EXECUTE sp_executesql @tsqlCommand; 
    END

    IF @formatFile in ('xml', 'fmt')
    BEGIN

        SET @tsqlCommand = N'select @OUT=CONVERT(VARCHAR(128), DATABASEPROPERTYEX(''__database_name__'', ''collation''));';
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__database_name__', @databaseName);
        IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);
        EXECUTE sp_executesql @tsqlCommand, @CollParmDefinition, @OUT=@current_collation OUTPUT;

        SET @tsqlCommand = N'EXECUTE xp_cmdshell ''bcp "SELECT REPLACE(BulkColumn, ''''__replace__'''', ''''__collation__'''') AS BulkColumn FROM OPENROWSET(BULK ''''__path____filename__del.__formatFile__'''', __LOB__) as x" queryout "__path____filename__.__formatFile__" -c -T''';
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__LOB__', CASE WHEN @formatFile = 'xml' THEN 'SINGLE_NCLOB' WHEN @formatFile = 'fmt' THEN 'SINGLE_CLOB' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__replace__', @current_collation); --'Cyrillic_General_CS_AS'
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__filename__', QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__formatFile__', @formatFile);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__path__', @path);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__collation__', CASE WHEN @collation = '' AND @formatFile='fmt' THEN '""""' WHEN @collation = '' AND @formatFile = 'xml' THEN '' ELSE @collation END);
        IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);
        ELSE EXECUTE sp_executesql @tsqlCommand;

        SET @cmdCommand = 'del "' + @path + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName) + 'del.' + @formatFile;
        IF @debug = 1 PRINT CAST(ISNULL('@cmdCommand = {' + @crlf + @cmdCommand + @crlf + '}', '@cmdCommand = {Null}' + @crlf) AS TEXT);
        ELSE EXECUTE xp_cmdshell @cmdCommand;
    END

    IF @debug = 1 PRINT '--End Deubg*********/';
    ELSE SET NOCOUNT OFF;
    END TRY

    BEGIN CATCH
        --EXECUTE dbo.usp_LogError;
        PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
              ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
              ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
              ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
              ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
              ', User name: ' + CONVERT(sysname, CURRENT_USER);
        PRINT ERROR_MESSAGE();
    END CATCH
END;
GO
