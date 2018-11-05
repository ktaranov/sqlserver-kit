IF OBJECT_ID('[dbo].[usp_PrintError]', 'P') IS NULL
EXECUTE('CREATE PROCEDURE [dbo].[usp_PrintError] AS SELECT 1');
go


ALTER PROCEDURE [dbo].[usp_PrintError] 
AS
BEGIN
    SET NOCOUNT ON;

    -- Print error information. 
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
          ', User name: ' + CONVERT(sysname, CURRENT_USER);
    PRINT ERROR_MESSAGE();
END;
go
