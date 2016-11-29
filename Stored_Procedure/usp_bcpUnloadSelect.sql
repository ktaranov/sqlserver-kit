IF OBJECT_ID('dbo.usp_bcpUnloadSelect', 'P') IS NULL EXECUTE('CREATE PROCEDURE dbo.usp_bcpUnloadSelect AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_bcpUnloadSelect(
      @outputFilePath  VARCHAR(255)  -- The path can have from 1 through 255 characters, see documentation
    , @serverName      SYSNAME      = @@SERVERNAME
    , @sqlCommand      VARCHAR(MAX)
    , @fileName        VARCHAR(300) = ''
    , @field_term      VARCHAR( 10) = '|'
    , @fileExtension   VARCHAR( 10) = 'txt'
    , @codePage        VARCHAR( 10) = 'C1251'
    , @row_term        VARCHAR( 10) = '\n'
    , @debug           BIT          = 0
)
AS
/*--
Official bcp documentation: http://technet.microsoft.com/en-us/library/ms162802.aspx
In select statement use full table names: DATABASENAME.SCHEMANAME.TABLENAME
EXECUTE [NIIGAZ].[dbo].[usp_bcpUnloadSelect]
      @outputFilePath = 'd:\'
    , @serverName     = ''
    , @sqlCommand     = 'SELECT * FROM DATABASENAME.SCHEMANAME.TABLENAME1 AS t1 INNER JOIN DATABASENAME.SCHEMANAME.TABLENAME2 AS t2 ON t1.Column1 = t2.Column1'
    , @fileName       = 'file_name.txt'
    , @field_term     = '|'
    , @row_term       = '\n'
    , @fileExtension  = 'txt'
    , @debug = 0;
--*/
BEGIN
    BEGIN TRY
        DECLARE @filePath    VARCHAR(2000) = @outputFilePath + 
                                             CASE WHEN @fileName = '' THEN 'bcp_export_' ELSE @fileName END +
                                             QUOTENAME(REPLACE(CONVERT(VARCHAR, GETDATE(), 126 ), ':', '_')) +
                                             '.' + @fileExtension;
        DECLARE @tsqlCommand VARCHAR(8000) = '';
        DECLARE @crlf        VARCHAR(10)   = CHAR(13) + CHAR(10);

        IF @debug = 0 SET NOCOUNT ON ELSE PRINT '/******* Start Debug' + @crlf;

        /* remove break lines from select statement */
        SET @sqlCommand = REPLACE(REPLACE(@sqlCommand, CHAR(13), ' '), CHAR(10), ' ');
        /* remove duplicate spaces from select statement */
        SET @sqlCommand = REPLACE(REPLACE(REPLACE(@sqlCommand,' ','<>'),'><',''),'<>',' ');

        IF @debug = 1
        PRINT ISNULL('@filePath = {' + @crlf + @filePath + @crlf + '}', '@filePath = {Null}' + @crlf)
        PRINT'@sqlCommand = {' + @crlf + @sqlCommand + @crlf + '}';

        SET @tsqlCommand = 'bcp "' + REPLACE(@sqlCommand, @crlf, ' ') + '" queryout "' + @filePath + 
                           '" -T -S ' + @serverName + ' -c -' + @codePage + ' -t"' + @field_term + '"' + 
                           ' -r"' + @row_term + '"' + @crlf;

        IF @debug = 1
        PRINT ISNULL( '@tsqlCommand = {' + @crlf + @tsqlCommand + '}' + @crlf, '@tsqlCommand = {Null}');
        ELSE
        EXECUTE xp_cmdshell @tsqlCommand;

        IF @debug = 0 SET NOCOUNT OFF ELSE PRINT @crlf + '--End Deubg*********/';
    END TRY

    BEGIN CATCH
        EXECUTE dbo.usp_LogError;
        EXECUTE dbo.usp_PrintError;
    END CATCH
END
go
