/*
Author: Phill Factor
Created date: 2018-10-04
Modified date: 2019-03-12 by Konstantin Taranov
Original link: https://www.red-gate.com/hub/product-learning/sql-monitor/monitoring-changes-permissions-users-roles-logins
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Simulate_SQL_Server_Users_Hack.sql
*/

USE master;
--create a user
CREATE LOGIN HenryTheGreenEngine WITH PASSWORD = 'ePaCqshha7m4iyhj';
GO
CREATE LOGIN PercyTheSmallEngine WITH PASSWORD = 'tRoUbl3som3Eng1n3s';
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
CREATE SERVER ROLE Pirates AUTHORIZATION sysadmin;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
ALTER SERVER ROLE Pirates ADD MEMBER PercyTheSmallEngine;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
ALTER SERVER ROLE serveradmin ADD MEMBER Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
ALTER SERVER ROLE setupadmin ADD MEMBER Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT ALTER ON LOGIN::[NT Service\MSSQLSERVER] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT CONTROL ON LOGIN::[NT Service\MSSQLSERVER] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT IMPERSONATE ON LOGIN::[NT Service\MSSQLSERVER] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT VIEW DEFINITION ON LOGIN::[NT Service\MSSQLSERVER] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT ALTER ON LOGIN::[NT SERVICE\SQLWriter] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT CONTROL ON LOGIN::[NT SERVICE\SQLWriter] TO Pirates;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT IMPERSONATE ON LOGIN::[NT SERVICE\SQLWriter] TO Pirates;


/* Create users in any not system database */
USE AdventureWorks2016;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
--greate user in adventureworks
CREATE USER dodgy FOR LOGIN HenryTheGreenEngine WITH DEFAULT_SCHEMA = dbo;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
ALTER ROLE db_owner ADD MEMBER dodgy;
GO
CREATE TABLE silly (TheKey INT IDENTITY);
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
GRANT SELECT ON silly TO dodgy WITH GRANT OPTION;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
REVOKE SELECT ON silly FROM dodgy CASCADE;
GO
CREATE USER TankEngineThomas WITHOUT LOGIN WITH DEFAULT_SCHEMA = dbo;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
ALTER ROLE db_owner ADD MEMBER TankEngineThomas;
DROP USER TankEngineThomas;
GO
DECLARE @delay varchar(8)= '00:00:'+Right('0'+convert(varchar(2),convert(int,RAND()*60)),2);WAITFOR DELAY @delay;
DROP USER dodgy;
DROP TABLE silly;
DROP LOGIN HenryTheGreenEngine;
DROP LOGIN PercyTheSmallEngine
GO
DECLARE @RoleName sysname;
SET @RoleName = N'Pirates';
IF @RoleName <> N'public'
  AND
    (
    SELECT server_principals.is_fixed_role
        FROM sys.server_principals
        WHERE server_principals.name = @RoleName
    ) = 0
  BEGIN
    DECLARE @RoleMemberName sysname;
    DECLARE Member_Cursor CURSOR FOR
    SELECT server_principals.name
      FROM sys.server_principals
      WHERE server_principals.principal_id IN
              (
              SELECT server_role_members.member_principal_id
                FROM sys.server_role_members
                WHERE server_role_members.role_principal_id IN
                        (
                        SELECT principal_id FROM sys.server_principals WHERE name = @RoleName
AND type = 'R'
                        )
              );
    OPEN Member_Cursor;
    FETCH NEXT FROM Member_Cursor
    INTO @RoleMemberName;
    DECLARE @SQL NVARCHAR(4000);
    WHILE @@Fetch_Status = 0
      BEGIN
        SET @SQL =
          N'ALTER SERVER ROLE ' + QuoteName(@RoleName, '[') + N' DROP MEMBER '
          + QuoteName(@RoleMemberName, '[');
        EXEC (@SQL);
        FETCH NEXT FROM Member_Cursor
        INTO @RoleMemberName;
      END;
    CLOSE Member_Cursor;
    DEALLOCATE Member_Cursor;
  END;
DROP SERVER ROLE Pirates;
GO

