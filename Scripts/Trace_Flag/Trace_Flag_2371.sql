/*
https://www.sqlservergeeks.com/sql-server-trace-flag-2371/
*/

USE master;
GO

--Drop this database if alreay exist
IF DB_ID('StatsDemo2014') > 0
BEGIN
    ALTER DATABASE StatsDemo2014  SET single_user;

    DROP DATABASE StatsDemo2014;
END
GO

--Create a database for Demo at default files location
CREATE DATABASE StatsDemo2014;
GO

USE StatsDemo2014;
GO

--Create table
CREATE TABLE xtstatsdemo (
      id      int         NOT NULL
    , balance int         NOT NULL
    , name    varchar(25) NULL
    );
GO

-- Now I am inserting 50000 rows in the table.
-- Here id and balance both are having same values for demo purpose
SET NOCOUNT ON;

DECLARE @counter INT = 1;
DECLARE @balance INT = 1;

WHILE (@counter <= 50000)
BEGIN
    IF (@counter % 2 = 0)
    BEGIN
        INSERT INTO xtstatsdemo
        VALUES (
            @counter
            , @balance
            , 'data1'
            );
    END
    ELSE
    BEGIN
        INSERT INTO xtstatsdemo
        VALUES (
            @counter
            , @balance
            , 'data2'
            );
    END

    SET @counter = @counter + 1;
    SET @balance = @balance + 1;
END
GO

--You can check number of rows inside the table
SELECT count(*) FROM xtstatsdemo;
GO


/* Now run the below code, here select statement will create a statistic on id column. */
USE master
GO

DBCC TRACEON (2371, - 1)
GO

USE StatsDemo2014;
GO

SELECT * FROM xtstatsdemo WHERE id > 8000;
GO


/* Now check the auto created statistic on id column from SSMS.
Change the name of stats _WA_Sys_00000001_21B6055D as per your environment */
DBCC Show_Statistics('xtstatsdemo','_WA_Sys_00000001_21B6055D') with stat_header;


/* Now I am going to delete 8000 rows */
DELETE FROM xtstatsdemo WHERE id < 8001;
GO
/* Statement to update the stats automatically */
SELECT name FROM xtstatsdemo WHERE id > 8000;
GO

DBCC TRACEOFF(2371,-1)
GO
/* Now check the stats details and change the name of stats _WA_Sys_00000001_21B6055D as per your environment */
DBCC Show_Statistics('xtstatsdemo','_WA_Sys_00000001_21B6055D') with stat_header;


/* Now I am going to delete 8000 rows */
DELETE FROM xtstatsdemo where id < 8001;
GO
/* Statement to update the stats automatically */
SELECT name FROM xtstatsdemo WHERE id > 8000;
GO
DBCC TRACEOFF(2371,-1)
GO
/* Now check the stats details and change the name of stats _WA_Sys_00000001_21B6055D as per your environment */
DBCC Show_Statistics('xtstatsdemo','_WA_Sys_00000001_21B6055D') with stat_header;
