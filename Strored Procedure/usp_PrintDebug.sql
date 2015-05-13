IF OBJECT_ID('dbo.usp_PrintDebug', 'P') IS NULL
EXECUTE('CREATE PROCEDURE dbo.usp_PrintDebug AS SELECT 1') ;
GO


ALTER PROCEDURE dbo.usp_PrintDebug
(
    @variableName  NVARCHAR(MAX) = '',
    @variableValue NVARCHAR(MAX) = '',
    @printMessage  NVARCHAR(MAX) = ''
)
/*
EXECUTE dbo.usp_PrintDebug @variableName = 'maxDate', @variableValue = ''
EXECUTE dbo.usp_PrintDebug @printMessage = 'start_debug'
EXECUTE dbo.usp_PrintDebug @printMessage = 'end_debug'
EXECUTE dbo.usp_PrintDebug @printMessage = 'Test debug'
*/
AS
BEGIN
    DECLARE @Crlf NVARCHAR(10) = CHAR(13) ;
    BEGIN TRY
        IF @printMessage = ''
        IF @variableValue IS NOT NULL AND CAST(@variableValue AS NVARCHAR) != ''
        PRINT '@' + @variableName + ' = {' + CAST(@variableValue AS NVARCHAR) + '}'
        ELSE
        IF CAST(@variableValue AS NVARCHAR) = ''
        PRINT @variableName + ' = {Empty String}'
        ELSE
        IF @variableValue IS NULL
        PRINT @variableName + ' = {NULL}';

        IF @printMessage LIKE 'start_debug %'
        PRINT '/******* Start Debug' + REPLACE(@printMessage, 'start_debug' , ' ')  + @Crlf;

        IF @printMessage LIKE 'end_debug %'
        PRINT @Crlf + '--End Deubg ' + REPLACE(@printMessage, 'end_debug' , '') + ' *********/';

        IF @printMessage NOT LIKE '%_debug%'
        PRINT @printMessage;
    END TRY

    BEGIN CATCH
        EXECUTE usp_LogError;
    END CATCH
END;
go
