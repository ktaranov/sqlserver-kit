IF OBJECT_ID('dbo.usp_BulkUpload', 'P') IS NULL EXECUTE ('CREATE PROCEDURE dbo.usp_BulkUpload AS SELECT 1');
GO


ALTER PROCEDURE dbo.usp_BulkUpload (
     @path                 NVARCHAR(900)  --  add a slash (\) at the end of a variable @path
    ,@fileName             NVARCHAR(200) = ''
    ,@fileExtension        NVARCHAR(10) = N'txt'
    ,@databaseName         SYSNAME
    ,@schemaName           SYSNAME = N'dbo'
    ,@tableName            SYSNAME
    ,@useIdentity          TINYINT    = 1
    ,@identityColumnName   SYSNAME = ''
    ,@CODEPAGE             NVARCHAR(30) = N'1251'
    ,@DATAFILETYPE         NVARCHAR(30) = N'char'
    ,@FIELDTERMINATOR      NVARCHAR(10) = N'\t'
    ,@FIRSTROW             INTEGER = 1
    ,@KEEPNULLS            BIT = 0
    ,@LASTROW              INTEGER = 0
    ,@ROWTERMINATOR        NVARCHAR(10) = N'\n'
    ,@TABLOCK              BIT = 1
    ,@ERRORFILE            NVARCHAR(300) = ''
    ,@excludeColumns       NVARCHAR(MAX) = ''''''
    ,@rowOrder             NVARCHAR(MAX) = ''
    ,@orderColumnName      BIT = 1
    ,@databaseRecoveryMode NVARCHAR(30) = ''  --  FULL, BULK_LOGGED, SIMPLE
    ,@debug                BIT = 0  --  0, 1
)
AS
/*
Specify Field and Row Terminators (SQL Server): http://msdn.microsoft.com/en-us/library/ms191485.aspx
MSDN BULK INSERT: http://msdn.microsoft.com/ru-ru/library/ms188365.aspx

BULK INSERT
   [ database_name . [ schema_name ] . | schema_name . ] [ table_name | view_name ]
      FROM 'data_file'
     [ WITH
    (
   [ [ , ] BATCHSIZE = batch_size ]
   [ [ , ] CHECK_CONSTRAINTS ]
   [ [ , ] CODEPAGE = { 'ACP' | 'OEM' | 'RAW' | 'code_page' } ]
   [ [ , ] DATAFILETYPE =
      { 'char' | 'native'| 'widechar' | 'widenative' } ]
   [ [ , ] FIELDTERMINATOR = 'field_terminator' ]
   [ [ , ] FIRSTROW = first_row ]
   [ [ , ] FIRE_TRIGGERS ]
   [ [ , ] FORMATFILE = 'format_file_path' ]
   [ [ , ] KEEPIDENTITY ]
   [ [ , ] KEEPNULLS ]
   [ [ , ] KILOBYTES_PER_BATCH = kilobytes_per_batch ]
   [ [ , ] LASTROW = last_row ]
   [ [ , ] MAXERRORS = max_errors ]
   [ [ , ] ORDER ( { column [ ASC | DESC ] } [ ,...n ] ) ]
   [ [ , ] ROWS_PER_BATCH = rows_per_batch ]
   [ [ , ] ROWTERMINATOR = 'row_terminator' ]
   [ [ , ] TABLOCK ]
   [ [ , ] ERRORFILE = 'file_name' ]
    )]

-- For table with Identity Column ID with SET IDENTITY_INSERT ON @useIdentity  = 1 and KEEPIDENTITY property
EXECUTE [dbo].[usp_BulkUpload] @path         = 'd:\GIT\GazEco\NIIGAZ\TXT\',
                               @databaseName = 'DatabaseName',
                               @tableName    = 'TableName',
                               @useIdentity  = 1,
                               @debug        = 0;

-- For table with Identity Column ID without SET IDENTITY_INSERT ON @useIdentity  = 2
EXECUTE [dbo].[usp_BulkUpload] @path         = 'd:\GIT\GazEco\NIIGAZ\TXT\',
                               @databaseName = 'DatabaseName',
                               @tableName    = 'TableName',
                               @useIdentity  = 2,
                               @debug        = O;
-- For table without Identity Column @useIdentity  = 0
EXECUTE [dbo].[usp_BulkUpload] @path         = 'd:\GIT\GazEco\NIIGAZ\TXT\', @useIdentity  = 0
                               @databaseName = 'DatabaseName',
                               @tableName    = 'TableName',
                               @useIdentity  = 0,
                               @debug        = 0;
*/
BEGIN
    BEGIN TRY
        DECLARE @databaseRecoveryModeCurrent VARCHAR(20);
        DECLARE @tsqlCommand    NVARCHAR(MAX)  = '';
        DECLARE @ParamDefinitionIndentity NVARCHAR(500)  = N'@identityColumnNameIN NVARCHAR(200), @ColumnsOUT VARCHAR(MAX) OUTPUT';
        DECLARE @tableFullName  NVARCHAR(600)  = CASE WHEN @databaseName <> '' THEN QUOTENAME(@databaseName) + '.' ELSE '' END + QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName);
        DECLARE @#tableName     NVARCHAR(600)  = QUOTENAME('#' + @tableName);
        DECLARE @OBJECT_ID      INTEGER        = OBJECT_ID(@tableFullName);
        DECLARE @Columns        NVARCHAR(MAX) = '';
        DECLARE @filePath       NVARCHAR(MAX)  = @path + CASE WHEN @fileName = '' THEN @tableFullName ELSE @fileName END + '.' + @fileExtension;
        DECLARE @CrLf           NVARCHAR(10)   = CHAR(13);
        DECLARE @TROW50000      NVARCHAR(MAX) = '';


        IF @debug = 0 SET NOCOUNT ON ELSE PRINT '/******* Start Debug' + @Crlf;

        SET @TROW50000 = 'Table ' + @tableFullName + ' is not exists in database ' + QUOTENAME(@databaseName) + '!!!';
        IF @OBJECT_ID IS NULL THROW 50000, @TROW50000, 1;

        IF RIGHT(@path, 1) <> '\' THROW 50001, 'Please add a slash (\) at the end of a variable @path!!!', 1;

        IF @debug = 1 PRINT ISNULL(N'@filePath = {' + @filePath + N'}', '@filePath = Null');

        IF @ERRORFILE = '' SET @ERRORFILE = @path + @tableFullName + N'_error_' + REPLACE(CONVERT(NCHAR(23), GETDATE(), 126), ':', '_') + N'.txt';

        IF @databaseRecoveryMode <> ''
        BEGIN
            SELECT @databaseRecoveryModeCurrent = recovery_model_desc
             FROM sys.databases
            WHERE name = @databaseName;
            IF @debug = 1 PRINT ISNULL('@databaseRecoveryModeCurrent = {' + @databaseRecoveryModeCurrent + '}', '@databaseRecoveryModeCurrent = Null');

            SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryMode)

            IF @debug = 1 PRINT ISNULL('@tsqlCommand = {' + @Crlf + @tsqlCommand + @Crlf + '}', '@tsqlCommand = {Null}')

            IF @databaseRecoveryMode IN ('FULL', 'BULK_LOGGED', 'SIMPLE')
               AND @debug = 0
               AND @databaseRecoveryModeCurrent <> @databaseRecoveryMode
            EXECUTE sp_executesql @tsqlCommand;
        END

        IF @useIdentity = 2 AND @identityColumnName = '' SET @identityColumnName = @tableName + 'ID';
        IF @debug = 1 PRINT ISNULL('@identityColumnName = {' + @identityColumnName + '}', '@identityColumnName = Null');

        SET @tsqlCommand = N'USE ' + @databaseName + ';'                                          + @CrLf +
                           N'SELECT @ColumnsOUT  = @ColumnsOUT + QUOTENAME(Name) + '','''         + @CrLf +
                           N'FROM sys.columns sac '                                               + @CrLf +
                           N'WHERE sac.object_id = ' + CAST(@OBJECT_ID AS NVARCHAR)               + @CrLf +
                           N'      AND sac.name NOT LIKE ISNULL(@identityColumnNameIN, ''Null'')' + @CrLf +
                           N'      AND QUOTENAME(Name) NOT IN (''' + REPLACE(@excludeColumns, ',', ''',''') + ''')' + @crlf +
                           CASE WHEN @orderColumnName = 1 THEN N'ORDER BY Name;' ELSE N'ORDER BY column_id;' END
                          ;

        IF @debug = 1 PRINT ISNULL('@OBJECT_ID = {' + CAST(@OBJECT_ID AS NVARCHAR) + '}', '@OBJECT_ID = Null');
        IF @debug = 1 PRINT ISNULL(N'@tsqlCommand = {' + @CrLf + @tsqlCommand + @CrLf + N'}', N'@tsqlCommand = Null');

        EXECUTE sp_executesql @tsqlCommand, @ParamDefinitionIndentity,
                              @identityColumnNameIN = @identityColumnName,
                              @ColumnsOUT = @Columns OUTPUT SELECT @Columns;

        SET @Columns = CASE WHEN LEN(@Columns) > 0 THEN LEFT(@Columns, LEN(@Columns) - 1) END;

        IF @debug = 1 PRINT ISNULL('@Columns = {' + @CrLf + @Columns + @CrLf + '}', '@Columns = {Null}');

        SET @tsqlCommand =
'IF OBJECT_ID(''tempdb..__#tableName__'') IS NOT NULL DROP TABLE __#tableName__;

SELECT __Columns__
  INTO __#tableName__
  FROM __tableFullName__
 WHERE 1=2;

BULK INSERT __#tableName__
FROM ''__filePath__''
WITH (
       FIELDTERMINATOR = ''__FIELDTERMINATOR__''
      ,ROWTERMINATOR   = ''__ROWTERMINATOR__''
      ,CODEPAGE        = ''__CODEPAGE__''
      ,DATAFILETYPE    = ''__DATAFILETYPE__''
      __KEEPIDENTITY__
      ,FIRSTROW        = __FIRSTROW__
      ___KEEPNULLS___
      __LASTROW__
      __TABLOCK__
      ,ERRORFILE = ''__ERRORFILE__''
);

__useIdentityON__

INSERT INTO __tableFullName__ (__Columns__)
SELECT __Columns__
  FROM __#tableName__
__rowOrder__;

__useIdentityOFF__

IF OBJECT_ID(''tempdb..__#tableName__'') IS NOT NULL DROP TABLE __#tableName__;
';

        SET @tsqlCommand = REPLACE(@tsqlCommand, '__#tableName__',      @#tableName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__Columns__',         @Columns);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__tableFullName__',   @tableFullName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__filePath__',        @filePath);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FIELDTERMINATOR__', @FIELDTERMINATOR);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__ROWTERMINATOR__',   @ROWTERMINATOR);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__CODEPAGE__',        @CODEPAGE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__DATAFILETYPE__',    @DATAFILETYPE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__KEEPIDENTITY__',    CASE WHEN @useIdentity = 1 THEN ',KEEPIDENTITY' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FIRSTROW__',        @FIRSTROW);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '___KEEPNULLS___',     CASE WHEN @KEEPNULLS = 1 THEN ',KEEPNULLS' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__LASTROW__',         CASE WHEN @LASTROW > 0   THEN ',LASTROW = ' + CAST(@LASTROW AS NVARCHAR) ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__TABLOCK__',         CASE WHEN @TABLOCK = 1   THEN ',TABLOCK' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__ERRORFILE__',       @ERRORFILE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__useIdentityON__',   CASE WHEN @useIdentity = 1 THEN 'SET IDENTITY_INSERT ' + @tableFullName + ' ON;' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__rowOrder__',        CASE WHEN @rowOrder <> '' THEN 'ORDER BY ' + @rowOrder ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__useIdentityOFF__',  CASE WHEN @useIdentity = 1 THEN 'SET IDENTITY_INSERT ' + @tableFullName + ' OFF;' ELSE '' END);

        IF @debug = 1 PRINT ISNULL(CAST('@tsqlCommand = {' + @Crlf + @tsqlCommand + @Crlf + '}'  AS NTEXT), '@tsqlCommand = {Null}' + @Crlf + '--End Deubg*********/')
        ELSE
        EXECUTE sp_executesql @tsqlCommand;

        IF @databaseRecoveryMode <> '' AND @databaseRecoveryModeCurrent <> @databaseRecoveryMode
        BEGIN
            SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryModeCurrent)

            IF @debug = 1 PRINT ISNULL('@tsqlCommand = {' + @Crlf + @tsqlCommand + @Crlf + '}', '@tsqlCommand = {Null}')

            IF @debug = 0 EXECUTE sp_executesql @tsqlCommand;
        END

        IF @debug = 0 SET NOCOUNT OFF ELSE PRINT @Crlf + '--End Deubg*********/';
    END TRY

    BEGIN CATCH
        SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryModeCurrent)
        EXECUTE sp_executesql @tsqlCommand;

        EXECUTE dbo.usp_LogError;
        EXECUTE dbo.usp_PrintError;
    END CATCH
END;
GO
