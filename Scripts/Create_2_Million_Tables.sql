/*
https://docs.microsoft.com/en-us/sql/sql-server/maximum-capacity-specifications-for-sql-server
Database objects include objects such as tables, views, stored procedures, user-defined functions, triggers, rules, defaults, and constraints.
The sum of the number of all objects in a database cannot exceed 2,147,483,647.
*/
CREATE DATABASE [TwoMillion];

ALTER DATABASE [TwoMillion] SET RECOVERY SIMPLE WITH NO_WAIT;
GO

USE [TwoMillion];

SET NOCOUNT ON;

DECLARE @sql nvarchar(max) = N'';
DECLARE @i int = 1;

SELECT @i = 2147483647 - COUNT(*) FROM [TwoMillion].sys.objects;
PRINT N'Creating ' + FORMAT(@i,'N0') + N' tables...';

WHILE @i > 0
BEGIN
   SET @i -= 1;
	
   SET @sql = N'CREATE TABLE [TwoMillion].dbo.t' + CONVERT(nvarchar(max),2147483648-@i) + N' (i int);';
   IF (@i % 10000) = 0 RAISERROR(@sql, 0, 1) WITH NOWAIT;

   EXEC sp_executesql @sql;
END;

/*
ALTER DATABASE [TwoMillion] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

USE master;
GO

DROP DATABASE [TwoMillion];
*/
