/*
Trace Flag Demo: 8602
Function: This trace flag is used to ignore all the index hints specified in query or stored procedure.
We can use this trace flag to troubleshooting the query performance without changing index hints.
SQL Server Version: 2008-2017
Information link: https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Trace%20Flag.md#8602
*/

USE master
GO

IF DB_ID(N'Trace8602') IS NOT NULL
BEGIN
    ALTER DATABASE Trace8602 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Trace8602;
END;
GO

CREATE DATABASE Trace8602;
GO

USE Trace8602;
GO

CREATE TABLE xttrace8602
    (
        id   INT identity(1, 1) PRIMARY KEY
      , bal  INT
      , name VARCHAR(100)
    );
GO
CREATE NONCLUSTERED INDEX IX_xttrace8602_bal_name ON xttrace8602
    (
        bal
      , name
    );
CREATE NONCLUSTERED INDEX IX_xttrace8602_bal ON xttrace8602(bal) ;
GO

INSERT INTO xttrace8602(bal, name)
SELECT TOP(10000) RAND() * 786 AS bal
     , 'SQLServerGeeks.com'    AS name
  FROM sys.all_objects
 CROSS JOIN sys.all_columns;
GO

CREATE PROC usp_First
AS
 SELECT id
      , name
   FROM xttrace8602 AS tf WITH(INDEX(IX_xttrace8602_bal))
  WHERE bal < 100;
GO

/*Ctrl+M Include Actual Execution Plan in SSMS*/
EXEC usp_First;
GO
/*Enable Trace flag*/
DBCC TRACEON(8602, -1);
GO
/*Clear procedure cache*/
DECLARE @planHandle VARBINARY(64);
SELECT @planHandle = cp.plan_handle
  FROM sys.dm_exec_cached_plans AS cp
 CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) AS st
 WHERE st.[text] LIKE '%CREATE PROC usp_First%' AND objtype = 'Proc';
PRINT(@planHandle);
IF @planHandle IS NOT NULL DBCC FREEPROCCACHE (@planHandle);
GO

EXEC usp_First;
GO

/*Disable Trace flag*/
DBCC TRACEOff(8602,-1)
GO
