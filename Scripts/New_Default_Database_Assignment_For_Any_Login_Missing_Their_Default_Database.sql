/*
Author: Tim Ford
Original link: http://sqlmag.com/database-security/identifying-logins-default-database-connectivity-issues-sql-server
*/
--============================================================
--IDENTIFY ALL LOGINS WITH NO ASSOCIATED DEFAULT DATABASE USER
--============================================================
---------------------------------------------------
/*
DYNAMICALLY SCRIPT NEW DEFAULT DATABASE ASSIGNMENT
FOR ANY LOGIN MISSING THEIR DEFAULT DATABASE
*/
---------------------------------------------------
SET NOCOUNT ON;
DECLARE @sql_text nvarchar(max);
DECLARE @database_name sysname;

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#existing_db_users_table%')
        BEGIN
                DROP TABLE #existing_db_users_table;
        END

CREATE TABLE #existing_db_users_table 
        (
                server_login_name sysname NOT NULL
                , database_user_name sysname NOT NULL
                , default_database_name sysname NOT NULL
        );      

DECLARE cur_default_databases CURSOR FORWARD_ONLY STATIC FOR
        SELECT name 
        FROM sys.databases 
        ORDER BY name

OPEN cur_default_databases

FETCH NEXT FROM cur_default_databases INTO @database_name

WHILE @@FETCH_STATUS = 0
        BEGIN

                SELECT @sql_text = 
                'INSERT INTO #existing_db_users_table(server_login_name, database_user_name, default_database_name)
                SELECT SP.name AS [server_login_name], DP.name AS [database_user_name], ' + '''' + @database_name + '''' 
                + ' FROM sys.server_principals AS SP
                        INNER JOIN ' + @database_name + '.sys.database_principals AS DP
                                ON SP.sid = DP.sid
                WHERE SP.default_database_name != ''' + @database_name + ''';'

                EXEC sys.sp_sqlexec @sql_text;

                FETCH NEXT FROM cur_default_databases INTO @database_name
        END 

CLOSE cur_default_databases;
DEALLOCATE cur_default_databases;

--===================================================
-- LISTING OF POTENTIAL DEFAULT DATABASE ASSIGNMENTS
--===================================================
SELECT SP.name AS login_name
        , SP.default_database_name
        , DDUT.default_database_name AS potential_default_database_name
        , CASE 
                WHEN DDUT.default_database_name IS NULL THEN 'Login has no other DB user associations.'
                ELSE 'ALTER LOGIN [' + SP.name + '] WITH DEFAULT_DATABASE=[' + DDUT.default_database_name + '];'
        END AS potential_default_database_command
FROM sys.server_principals AS SP
        LEFT JOIN #existing_db_users_table AS DDUT
                ON SP.name = DDUT.server_login_name
        LEFT JOIN sys.databases AS D
                ON SP.default_database_name = D.name
WHERE SP.type_desc IN ('SQL_LOGIN', 'WINDOWS_LOGIN')
        AND SP.name NOT LIKE 'NT %'
        AND SP.name NOT LIKE '##%'
        AND SP.default_database_name IS NOT NULL
        --AND DDUT.server_login_name IS NOT NULL
        AND D.name IS NULL
ORDER BY SP.name, DDUT.default_database_name;


--===================================================
-- CLEANUP
--===================================================
IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#missing_existing_db_users_table%')
        BEGIN
                DROP TABLE #missing_existing_db_users_table;
        END
GO
