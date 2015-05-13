DECLARE @procedureName SYSNAME = 'dbo.usp_PrintDebug';
DECLARE @tsqlCommand VARCHAR(MAX) = '';

SET @tsqlCommand = 'IF OBJECT_ID(''' + @procedureName + ''', ''P'') IS NULL EXECUTE (''CREATE PROCEDURE ' + @procedureName + ' as select 1'');
GO

ALTER PROCEDURE ' + @procedureName + '

AS

BEGIN

SELECT 1

END;'

PRINT @tsqlCommand;