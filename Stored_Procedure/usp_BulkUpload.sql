IF OBJECT_ID('dbo.usp_BulkUpload', 'P') IS NULL EXECUTE ('CREATE PROCEDURE dbo.usp_BulkUpload AS SELECT 1');
GO


ALTER PROCEDURE dbo.usp_BulkUpload (
                @path                 NVARCHAR(900)  -- add a slash (\) at the end of a variable @path
              , @fileName             NVARCHAR(200) = ''
              , @fileExtension        NVARCHAR(10)  = N'txt'
              , @databaseName         SYSNAME
              , @schemaName           SYSNAME       = N'dbo'
              , @tableName            SYSNAME
              , @useIdentity          TINYINT       = 1  -- 1 - table with identity and identity column exists in file; 2 - table with identity and identity column not exists in file; 0 - table without identity
              , @identityColumnName   SYSNAME       = ''
              , @BATCHSIZE            INTEGER       = 0  -- 0 - skip parameter value (by default, all data in the specified data file is one batch)
              , @CHECK_CONSTRAINTS    BIT           = 0  -- 0 - skip parameter value (any CHECK and FOREIGN KEY constraints are ignored, after the operation, the constraints market as not-trusted)
              , @CODEPAGE             NVARCHAR(30)  = N'65001'
              , @DATAFILETYPE         NVARCHAR(30)  = N'char'
              , @FIELDTERMINATOR      NVARCHAR(10)  = N'\t'
              , @FIRSTROW             INTEGER       = 1
              , @FIRE_TRIGGERS        BIT           = 0  -- 0 - skip parameter value (no insert triggers execute)
              , @KEEPNULLS            BIT           = 0
              , @KILOBYTES_PER_BATCH  INTEGER       = 0  -- 0 - skip parameter value (unknown by default)
              , @LASTROW              INTEGER       = 0
              , @ROWTERMINATOR        NVARCHAR(10)  = N'\n'
              , @ROWS_PER_BATCH       INTEGER       = 0
              , @TABLOCK              BIT           = 1
              , @ERRORFILE            NVARCHAR(300) = N''
              , @MAXERRORS            INTEGER       = 0  -- 0 - skip parameter value (used 10 by default)
              , @FORMATFILE           VARCHAR(4)    = ''
              , @excludeColumns       NVARCHAR(MAX) = N''''''
              , @rowOrderByColumn     NVARCHAR(MAX) = N''
              , @skipTempDB           BIT           = 0
              , @columnTypeSort       BIT           = 1    -- 0 - physical column order; 1 - alphabetical
              , @databaseRecoveryMode NVARCHAR(15)  = N''  -- FULL; BULK_LOGGED; SIMPLE
              , @debug                BIT           = 0    -- 0 - only print tsql statement; 1 - exec tsql statement
)
AS
/*
Specify Field and Row Terminators (SQL Server): https://docs.microsoft.com/en-us/sql/relational-databases/import-export/specify-field-and-row-terminators-sql-server
DOCS BULK INSERT: https://docs.microsoft.com/ru-ru/sql/t-sql/statements/bulk-insert-transact-sql

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
EXECUTE [dbo].[usp_BulkUpload] @path         = N'd:\',
                               @databaseName = N'DatabaseName',
                               @tableName    = N'TableName',
                               @useIdentity  = 1,
                               @debug        = 0;

-- For table with Identity Column ID without SET IDENTITY_INSERT ON @useIdentity  = 2
EXECUTE [dbo].[usp_BulkUpload] @path         = N'd:\',
                               @databaseName = N'DatabaseName',
                               @tableName    = N'TableName',
                               @useIdentity  = 2,
                               @debug        = O;
-- For table without Identity Column @useIdentity  = 0
EXECUTE [dbo].[usp_BulkUpload] @path         = N'd:\',
                               @databaseName = N'DatabaseName',
                               @tableName    = N'TableName',
                               @useIdentity  = 0,
                               @debug        = 0;
*/
BEGIN
    BEGIN TRY
        DECLARE @databaseRecoveryModeCurrent NVARCHAR(15);
        DECLARE @schemaTableName             NVARCHAR(600) = QUOTENAME(@schemaName) + '.' + QUOTENAME(@tableName);
        DECLARE @tsqlCommand    NVARCHAR(MAX) = '';
        DECLARE @ParamDefinitionIndentity NVARCHAR(500) = N'@identityColumnNameIN NVARCHAR(200), @ColumnsOUT VARCHAR(MAX) OUTPUT';
        DECLARE @tableFullName  NVARCHAR(600) = CASE WHEN @databaseName <> '' THEN QUOTENAME(@databaseName) + '.' ELSE '' END + @schemaTableName;
        DECLARE @#tableName     NVARCHAR(600) = QUOTENAME('#' + @tableName);
        DECLARE @OBJECT_ID      INTEGER       = OBJECT_ID(@tableFullName);
        DECLARE @Columns        NVARCHAR(MAX) = N'';
        DECLARE @filePath       NVARCHAR(MAX) = @path + CASE WHEN @fileName = '' THEN @tableFullName ELSE @fileName END + '.' + @fileExtension;
        DECLARE @crlf           NVARCHAR(10)  = CHAR(13);
        DECLARE @TROW50000      NVARCHAR(1000) = N'';


        IF @debug = 0 SET NOCOUNT ON ELSE PRINT '/******* Start Debug' + @crlf;

        IF @FORMATFILE NOT IN ('', 'xml', 'fmt') THROW 50004, 'Allowed values for parameter is xml, fmt or blank value', 1;
        IF @FORMATFILE = '' AND @skipTempDB = 1  THROW 50005, 'If @skipTempDB = 1 then @FORMATFILE must be in xml or fmt', 1;

        --IF @skipTempDB = 1 and @columnTypeSort <> 0 THROW 50003, 'Please do not use alphabetical sort with direct insert key (@skipTempDB).', 1;

        IF RIGHT(@path, 1) <> '\' THROW 50001, 'Please add a slash (\) at the end of a variable @path!!!', 1;

        IF LEFT(@databaseName, 1) =N'[' OR LEFT(@tableName, 1) = N'[' OR LEFT(@schemaName, 1) = N'['
        THROW 50002, 'Please do not use quotes in Databse, Table or Schema names! In the procedure it is alredy done with QUOTENAME function.', 1;

        SET @tableFullName = CASE WHEN @databaseName <> '' THEN QUOTENAME(@databaseName) + '.' ELSE '' END + @schemaTableName;

        SET @TROW50000 = N'Table ' + @tableFullName + N' is not exists in database ' + QUOTENAME(@databaseName) + N'!!!';
        IF @OBJECT_ID IS NULL THROW 50000, @TROW50000, 1;

        IF @debug = 1 PRINT ISNULL(N'@filePath = {' + @filePath + N'}', N'@filePath = Null');

        IF @ERRORFILE = '' SET @ERRORFILE = @path + @tableFullName + N'_error_' + REPLACE(CONVERT(NCHAR(23), GETDATE(), 126), ':', '_') + N'.txt';

        IF @databaseRecoveryMode <> ''
        BEGIN
            SELECT @databaseRecoveryModeCurrent = recovery_model_desc
            FROM   sys.databases
            WHERE name = @databaseName;
            IF @debug = 1 PRINT ISNULL('@databaseRecoveryModeCurrent = {' + @databaseRecoveryModeCurrent + '}', '@databaseRecoveryModeCurrent = Null');

            SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryMode)

            IF @debug = 1 PRINT ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}')

            IF @databaseRecoveryMode IN ('FULL', 'BULK_LOGGED', 'SIMPLE')
               AND @debug = 0
               AND @databaseRecoveryModeCurrent <> @databaseRecoveryMode
            EXECUTE sp_executesql @tsqlCommand;
        END

        IF @useIdentity = 2 AND @identityColumnName = '' SET @identityColumnName = @tableName + 'ID';
        IF @debug = 1 PRINT ISNULL('@identityColumnName = {' + @identityColumnName + '}', '@identityColumnName = Null');

        SET @tsqlCommand = 
N'USE __DBName__;
SELECT @ColumnsOUT  = @ColumnsOUT + QUOTENAME(Name) + '',''
FROM sys.columns sac
WHERE sac.object_id = __OBJ_ID__ 
    AND sac.name NOT LIKE ISNULL(@identityColumnNameIN, ''Null'')
    AND QUOTENAME(Name) NOT IN (''__excludeCol__'')
    __columTS__
';
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__DBName__',  QUOTENAME(@databaseName));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__OBJ_ID__',  CAST(@OBJECT_ID AS NVARCHAR)); 
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__excludeCol__',  REPLACE(@excludeColumns, ',', ''','''));
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__columTS__',  CASE WHEN @columnTypeSort = 1 THEN N'ORDER BY Name;' ELSE N'ORDER BY column_id;' END);


        IF @debug = 1 PRINT ISNULL('@OBJECT_ID = {' + CAST(@OBJECT_ID AS NVARCHAR) + '}', '@OBJECT_ID = Null');
        IF @debug = 1 PRINT ISNULL(N'@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + N'}', N'@tsqlCommand = Null');

        EXECUTE sp_executesql @tsqlCommand, @ParamDefinitionIndentity,
                              @identityColumnNameIN = @identityColumnName,
                              @ColumnsOUT = @Columns OUTPUT SELECT @Columns;

        SET @Columns = CASE WHEN LEN(@Columns) > 0 THEN LEFT(@Columns, LEN(@Columns) - 1) END;

        IF @debug = 1 PRINT ISNULL('@Columns = {' + @crlf + @Columns + @crlf + '}', '@Columns = {Null}');

        SET @tsqlCommand =
'IF OBJECT_ID(''tempdb..__#tableName__'') IS NOT NULL DROP TABLE __#tableName__;

SELECT __Columns__
  INTO __#tableName__
  FROM __tableFullName__
 WHERE 1=2;

BULK INSERT __#tableName__
FROM ''__filePath__''
WITH (
      __BATCHSIZE__
      FIELDTERMINATOR = ''__FIELDTERMINATOR__''
      ,ROWTERMINATOR   = ''__ROWTERMINATOR__''
      __CHECK_CONSTRAINTS__
      ,CODEPAGE        = ''__CODEPAGE__''
      ,DATAFILETYPE    = ''__DATAFILETYPE__''
      __KEEPIDENTITY__
      ,FIRSTROW        = __FIRSTROW__
      __FORMATFILE__
      __FIRE_TRIGGERS__
      __KEEPNULLS__
      __KILOBYTES_PER_BATCH__
      __LASTROW__
      __ROWS_PER_BATCH__
      __MAXERRORS__
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

        IF @skipTempDB = 1 AND @columnTypeSort = 0 SET @tsqlCommand =
'BULK INSERT __tableFullName__
FROM ''__filePath__''
WITH (
      __BATCHSIZE__
      FIELDTERMINATOR = ''__FIELDTERMINATOR__''
      ,ROWTERMINATOR   = ''__ROWTERMINATOR__''
      __CHECK_CONSTRAINTS__
      ,CODEPAGE        = ''__CODEPAGE__''
      ,DATAFILETYPE    = ''__DATAFILETYPE__''
      __KEEPIDENTITY__
      ,FIRSTROW        = __FIRSTROW__
      __FORMATFILE__
      __FIRE_TRIGGERS__
      __KEEPNULLS__
      __KILOBYTES_PER_BATCH__
      __LASTROW__
      __ROWS_PER_BATCH__
      __MAXERRORS__
      __TABLOCK__
      ,ERRORFILE = ''__ERRORFILE__''
);
'
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FORMATFILE__',          CASE WHEN @FORMATFILE = 'xml' THEN ',FORMATFILE = ''' + @path + @schemaTableName +'.xml'''
                                                                                 WHEN @FORMATFILE = 'fmt' THEN ',FORMATFILE = ''' + @path + @schemaTableName +'.fmt'''
                                                                                 ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__#tableName__',          @#tableName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__Columns__',             @Columns);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__tableFullName__',       @tableFullName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__filePath__',            @filePath);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__BATCHSIZE__',           CASE WHEN @BATCHSIZE > 0 THEN 'BATCHSIZE = ' + CAST(@BATCHSIZE AS NVARCHAR) + ',' ELSE '' END);  
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FIELDTERMINATOR__',     @FIELDTERMINATOR);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__ROWTERMINATOR__',       @ROWTERMINATOR);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__CODEPAGE__',            @CODEPAGE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__CHECK_CONSTRAINTS__',   CASE WHEN @CHECK_CONSTRAINTS = 1 THEN ',CHECK_CONSTRAINTS' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__DATAFILETYPE__',        @DATAFILETYPE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__KEEPIDENTITY__',        CASE WHEN @useIdentity = 1 THEN ',KEEPIDENTITY' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FIRSTROW__',            @FIRSTROW);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__FIRE_TRIGGERS__',       CASE WHEN @FIRE_TRIGGERS = 1 THEN ',FIRE_TRIGGERS' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__KEEPNULLS__',           CASE WHEN @KEEPNULLS = 1 THEN ',KEEPNULLS' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__KILOBYTES_PER_BATCH__', CASE WHEN @KILOBYTES_PER_BATCH > 0 THEN ',KILOBYTES_PER_BATCH = ' + CAST(@KILOBYTES_PER_BATCH AS NVARCHAR) ELSE '' END);  
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__LASTROW__',             CASE WHEN @LASTROW > 0   THEN ',LASTROW = ' + CAST(@LASTROW AS NVARCHAR) ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__TABLOCK__',             CASE WHEN @TABLOCK = 1   THEN ',TABLOCK' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__ROWS_PER_BATCH__',      CASE WHEN @ROWS_PER_BATCH > 0 THEN ',ROWS_PER_BATCH = ' + CAST(@ROWS_PER_BATCH AS NVARCHAR) ELSE '' END); 
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__MAXERRORS__',           CASE WHEN @MAXERRORS > 0 THEN ',MAXERRORS = ' + CAST(@MAXERRORS AS NVARCHAR) ELSE '' END);  
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__ERRORFILE__',           @ERRORFILE);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__useIdentityON__',       CASE WHEN @useIdentity = 1 THEN 'SET IDENTITY_INSERT ' + @tableFullName + ' ON;' ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__rowOrder__',            CASE WHEN @rowOrderByColumn <> '' THEN 'ORDER BY ' + @rowOrderByColumn ELSE '' END);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__useIdentityOFF__',      CASE WHEN @useIdentity = 1 THEN 'SET IDENTITY_INSERT ' + @tableFullName + ' OFF;' ELSE '' END);

        IF @debug = 1 PRINT ISNULL(CAST('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}'  AS NTEXT), '@tsqlCommand = {Null}' + @crlf + '--End Deubg*********/')
        ELSE
        EXECUTE sp_executesql @tsqlCommand;

        IF @databaseRecoveryMode <> '' AND @databaseRecoveryModeCurrent <> @databaseRecoveryMode
        BEGIN
            SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
            SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryModeCurrent)

            IF @debug = 1 PRINT ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}')

            IF @debug = 0 EXECUTE sp_executesql @tsqlCommand;
        END

        IF @debug = 0 SET NOCOUNT OFF ELSE PRINT @crlf + '--End Deubg*********/';
    END TRY

    BEGIN CATCH
        SET @tsqlCommand = N'ALTER DATABASE __databaseName__ SET RECOVERY __databaseRecoveryMode__ WITH NO_WAIT';
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseName__', @databaseName);
        SET @tsqlCommand = REPLACE(@tsqlCommand, '__databaseRecoveryMode__', @databaseRecoveryModeCurrent)
        EXECUTE sp_executesql @tsqlCommand;

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
