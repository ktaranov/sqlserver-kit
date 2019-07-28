/*
https://docs.microsoft.com/en-us/sql/sql-server/maximum-capacity-specifications-for-sql-server?view=sql-server-2017
Database objects include objects such as tables, views, stored procedures, user-defined functions, triggers, rules, defaults, and constraints.
The sum of the number of all objects in a database cannot exceed 2,147,483,647.
*/

CREATE DATABASE TwoMillions;
GO

ALTER DATABASE TwoMillions SET RECOVERY SIMPLE WITH NO_WAIT;

USE TwoMillions;
GO


SET NOCOUNT ON;

DECLARE @tsql         nvarchar(max) = N'';
DECLARE @tsqlTemplate nvarchar(max) = N'CREATE TABLE t_i_ (c_i_ int); INSERT INTO t_i_ VALUES(_i_);';
DECLARE @i            int = 1;

SELECT @i = COUNT(*) + 1 FROM TwoMillions.sys.tables;

WHILE @i < 2147483648
BEGIN
   SET @tsql = REPLACE(@tsqlTemplate, N'_i_', CAST(@i AS nvarchar(max)));
   --RAISERROR(@tsql, 0, 1) WITH NOWAIT;

   EXEC sp_executesql @tsql;
   SET @i = @i +1;

   IF (@i % 10000) = 0 RAISERROR(@i, 0, 1) WITH NOWAIT;;
END;

/*
ALTER DATABASE TwoMillions SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

USE master;
GO

DROP DATABASE TwoMillions;
*/
