/*
<documentation>
  <summary>Dynamically generate GRANTs.</summary>
  <returns>PRINT dynamically generated GRANTs for user.</returns>
  <created>?</created>
  <modified>2020-02-08 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Dynamic_GRANT_Generation.sql</sourceLink>
</documentation>
*/


SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @userName sysname = QUOTENAME(N'user_name');
DECLARE @tsql nvarchar(max) = N'';

SELECT @tsql = @tsql + 'GRANT SELECT, INSERT, UPDATE, DELETE ON ' +
                       QUOTENAME(SCHEMA_NAME("schema_id")) + N'.' +
                       QUOTENAME("name") + N' TO ' + @userName + N';' + CHAR(13) + CHAR(10)
FROM sys.tables
/*
WHERE "name" NOT IN ('')
--*/
;

IF LEN(@tsql) <= 8000
BEGIN
   PRINT(@tsql);
END;
ELSE
BEGIN
    SELECT @tsql;
END;
