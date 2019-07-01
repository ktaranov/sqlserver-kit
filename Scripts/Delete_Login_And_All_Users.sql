/*
<documentation>
  <summary>Delete login and all its users.</summary>
  <returns>Generate script for deleting login and associated users from SQL Server.</returns>
  <issues>No</issues>
  <author>Max Vernon</author>
  <created>2019-01-31</created>
  <modified>2019-07-01 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Delete_Login_And_All_Users.sql</sourceLink>
  <originalLink>https://www.sqlserverscience.com/tools/delete-login-server-database/</originalLink>
</documentation>
*/

SET NOCOUNT ON;
DECLARE @DebugOnly bit = 1; --switch to 0 to actually drop the login and user(s); 1 displays the generated script.
DECLARE @cmd nvarchar(max);
DECLARE @ServerPrincipalName sysname;
DECLARE @DatabasePrincipalName sysname;

SET @ServerPrincipalName = N'sa'; --the name of the LOGIN to be dropped from the SERVER.
SET @DatabasePrincipalName = N'DeleteMeUser'; --the name of the USER to be dropped from each DATABASE.

SET @cmd = '';

SELECT @cmd = @cmd + CASE WHEN @cmd = N'' THEN N'' ELSE N'
UNION ALL
' END + N'SELECT ''' + d.name + N'''
    , sp.name COLLATE SQL_Latin1_General_CP1_CI_AS
    , dp.name COLLATE SQL_Latin1_General_CP1_CI_AS
FROM ' + QUOTENAME(d.name) + N'.sys.database_principals dp
    LEFT JOIN master.sys.server_principals sp ON dp.sid = sp.sid
WHERE sp.name = ''' + @ServerPrincipalName + N'''
    OR dp.name = ''' + @DatabasePrincipalName + N''''
FROM sys.databases d
WHERE d.state_desc = N'ONLINE';

SET @cmd = @cmd + N';'

DECLARE @Results TABLE
(
    database_name SYSNAME NOT NULL
    , server_principal_name SYSNAME NULL
    , database_principal_name SYSNAME NULL
    , PRIMARY KEY CLUSTERED (database_name)
);

INSERT INTO @Results (database_name, server_principal_name, database_principal_name)
EXEC (@cmd);

SET @cmd = N'';

SELECT @cmd = @cmd + CASE WHEN @cmd = N'' THEN N'' ELSE N'
' END + N'  USE ' + QUOTENAME(r.database_name) + N';
    PRINT (N''Dropping user ' + QUOTENAME(r.database_principal_name) + N' in ' + r.database_name + N''');

    SET @msg = N'''';

    SELECT @msg = @msg + CASE WHEN @msg = N'''' THEN N'''' ELSE CHAR(13) + CHAR(11) END + N''User [' + @DatabasePrincipalName + N'] owns '' + o.type_desc + N'' '' + QUOTENAME(s.name) + N''.'' + QUOTENAME(o.name) + N'' and cannot be dropped''
    FROM sys.objects o
        INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE s.principal_id = (SELECT sp.principal_id FROM sys.database_principals sp WHERE sp.name = N''' + @DatabasePrincipalName + N''')
    PRINT (@msg);

    IF @msg <> N''''
    BEGIN
        SET @errCount = @errCount + 1;
    END
    ELSE
    BEGIN
        IF (
            SELECT (COUNT(1))
            FROM sys.schemas s
            WHERE s.principal_id = (SELECT sp.principal_id FROM sys.database_principals sp WHERE sp.name = N''' + r.database_principal_name + N''')
            ) > 0
        BEGIN
            PRINT (N''User ' + r.database_principal_name + N' owns a schema and cannot be dropped'');
            SET @errCount = @errCount + 1;
        END
        ELSE
        BEGIN
            DROP USER ' + QUOTENAME(r.database_principal_name) + ';
        END;
    END;
'
FROM @Results r;

SET @cmd = N'SET NOCOUNT ON;
DECLARE @msg nvarchar(MAX);
DECLARE @errCount int;
SET @errCount = 0;
BEGIN TRY
' + CASE WHEN @cmd = N'' THEN N'    PRINT (N''User ' + @DatabasePrincipalName + N' does not exist in any database.'');' ELSE @cmd END + N'
END TRY
BEGIN CATCH
    PRINT (ERROR_MESSAGE());
    SET @errCount = @errCount + 1;
END CATCH

IF @errCount = 0
BEGIN
';

IF (
    SELECT COUNT(1)
    FROM @Results r
    WHERE r.server_principal_name IS NOT NULL
    ) > 0
BEGIN
    SELECT TOP(1) @cmd = @cmd + N'  USE master;
    PRINT (N''Dropping LOGIN ' + QUOTENAME(r.database_principal_name) + N''');
    DROP LOGIN ' + QUOTENAME(r.server_principal_name) + N';'
    FROM @Results r;
END
ELSE
BEGIN
    SET @cmd = @cmd + N'    PRINT (N''Login ' + @ServerPrincipalName + N' does not exist.'');';
END

SET @cmd = @cmd + N'
END
ELSE
BEGIN
    PRINT (N''Errors occurred dropping users; login has NOT been dropped'');
END';

IF @DebugOnly = 1
BEGIN
    RAISERROR (@cmd, 0, 1);
END
ELSE
BEGIN
    EXEC sys.sp_executesql @cmd;
END;
