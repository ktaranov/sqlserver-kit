IF OBJECT_ID('dbo.usp_bcpUnloadSelect', 'P') IS NULL EXECUTE('CREATE PROCEDURE dbo.usp_bcpUnloadSelect AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_bcpUnloadSelect(
      @outputFilePath  VARCHAR(255)  /* The path can have from 1 through 255 characters, see documentation */
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
EXECUTE dbo.usp_bcpUnloadSelect
      @outputFilePath = 'd:\'
    , @serverName     = ''
    , @sqlCommand     = 'SELECT TOP(1000) CHECKSUM(NEWID()) % 10000 FROM master.sys.objects AS s1 CROSS JOIN master.sys.objects AS s2'
    , @fileName       = 'file_name'
    , @field_term     = '|'
    , @row_term       = '\n'
    , @fileExtension  = 'txt'
    , @debug = 0;
--*/
BEGIN
    BEGIN TRY

        SET NOCOUNT ON;

        IF @debug = 1 PRINT '/******* Start Debug';

        DECLARE @filePath    VARCHAR(1000) = @outputFilePath +
                                             CASE WHEN @fileName = '' THEN 'bcp_export_' + QUOTENAME(REPLACE(CONVERT(VARCHAR, GETDATE(), 126 ), ':', '_'))
                                                  ELSE @fileName END +
                                             '.' + @fileExtension;
        DECLARE @tsqlCommand VARCHAR(8000)  = '';
        DECLARE @crlf        VARCHAR(10)    = CHAR(13) + CHAR(10);

        /* remove break lines from select statement */
        SET @sqlCommand = REPLACE(REPLACE(@sqlCommand, CHAR(13), ' '), CHAR(10), ' ');
        /* remove duplicate spaces from select statement */
        SET @sqlCommand = REPLACE(REPLACE(REPLACE(@sqlCommand,' ','<>'), '><', ''), '<>', ' ');

        IF @debug = 1
        BEGIN
            PRINT ISNULL('@filePath = {' + @crlf + @filePath + @crlf + '}', '@filePath = {Null}' + @crlf);
            PRINT'@sqlCommand = {' + @crlf + @sqlCommand + @crlf + '}';
        END

        SET @tsqlCommand = 'bcp "' + REPLACE(@sqlCommand, @crlf, ' ') + '" queryout "' + @filePath + 
                           '" -T -S ' + @serverName + ' -c -' + @codePage + ' -t"' + @field_term + '"' + 
                           ' -r"' + @row_term + '"' + @crlf;

        IF @debug = 1
        PRINT ISNULL( '@tsqlCommand = {' + @crlf + @tsqlCommand + '}' + @crlf, '@tsqlCommand = {Null}');
        ELSE
        EXECUTE xp_cmdshell @tsqlCommand;

        IF @debug = 1 PRINT @crlf + '--End Deubg*********/';
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
END;
GO
