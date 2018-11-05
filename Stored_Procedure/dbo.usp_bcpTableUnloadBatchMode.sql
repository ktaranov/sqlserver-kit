IF OBJECT_ID('dbo.usp_bcpTableUnloadBatchMode', 'P') IS NULL EXECUTE ('CREATE PROCEDURE dbo.usp_bcpTableUnloadBatchMode as select 1');
go

ALTER PROCEDURE dbo.usp_bcpTableUnloadBatchMode (
                                                  @path                NVARCHAR(900),
                                                  @databaseName        SYSNAME,
                                                  @includeSchemaNames  NVARCHAR(MAX) = '',
                                                  @excludeSchemaNames  NVARCHAR(MAX) = '',
                                                  @includeTableNames   NVARCHAR(MAX) = '',
                                                  @excludeTableNames   NVARCHAR(MAX) = '',
                                                  @fieldTerminator     NVARCHAR(10)  = '|',
                                                  @fileExtension       NVARCHAR(10)  = 'txt',
                                                  @codePage            NVARCHAR(10)  = 'C1251',
                                                  @excludeColumns      NVARCHAR(MAX) = '''''',
                                                  @outputColumnHeaders BIT           = 1,
                                                  @minRowCount         INTEGER       = 1,
                                                  @debug               BIT           = 0
                                                )
AS

/*
EXECUTE [dbo].[usp_bcpTableUnloadBatchMode] @path                = 'd:\',
                                            @databaseName        = 'DatabaseName',
                                            @excludeSchemaNames  = 'dbo',
                                            @tableName           = 'TableName',
                                            @fieldTerminator     = '|',
                                            @fileExtension       = 'txt',
                                            @excludeColumns      = '[CreatedDate],[ModifiedDate],[UserID]',
                                            @outputColumnHeaders = 1,
                                            @minRowCount         = 1,
                                            @debug               = 0;
*/

BEGIN

IF @debug = 0 SET NOCOUNT ON;
IF @debug = 1 PRINT '/******* Start Debug';

DECLARE @tsqlCommand NVARCHAR(MAX) = '';
DECLARE @tableNames NVARCHAR(MAX) = '';
DECLARE @crlf       NVARCHAR(10)  = CHAR(13);

SELECT @tableNames = @tableNames + QUOTENAME(@databaseName) + '.' + QUOTENAME(ist.TABLE_SCHEMA) + '.' + QUOTENAME(ist.TABLE_NAME) + ','
  FROM SYS.SYSINDEXES AS sind WITH (NOLOCK)
 INNER JOIN INFORMATION_SCHEMA.TABLES AS ist ON OBJECT_NAME(sind.id) = ist.TABLE_NAME
 WHERE sind.indid IN (0, 1)
       AND sind.rowcnt > @minRowCount
       AND QUOTENAME(ist.TABLE_NAME) NOT IN ('''' + REPLACE(@excludeTableNames, ',', ''',''') + '''')
       AND QUOTENAME(ist.TABLE_SCHEMA) NOT IN ('''' + REPLACE(@excludeSchemaNames, ',', ''',''') + '''')
       AND ist.TABLE_NAME NOT LIKE '%tmp%'
       ;
IF @debug = 1 PRINT CAST(ISNULL('@excludeTableNames = {' + @crlf + '''' + REPLACE(@excludeTableNames, ',', ''',''') + '''' + @crlf + '}', '@tableNames = {Null}' + @crlf) AS TEXT);

IF @debug = 1 PRINT CAST(ISNULL('@tableNames = {' + @crlf + @tableNames + @crlf + '}', '@tableNames = {Null}' + @crlf) AS TEXT);

SET @tsqlCommand = '';

IF @debug = 1 PRINT CAST(ISNULL('@tsqlCommand = {' + @crlf + @tsqlCommand + @crlf + '}', '@tsqlCommand = {Null}' + @crlf) AS TEXT);

IF @debug = 1 PRINT '--End Deubg*********/'
IF @debug = 0 SET NOCOUNT OFF;

END
