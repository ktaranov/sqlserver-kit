SET NOEXEC OFF;

DECLARE @msg NVARCHAR(MAX) = N'';
DECLARE @productMajorVersion INT;
DECLARE @productBuild INT;
SET @productMajorVersion = CAST(SERVERPROPERTY('ProductMajorVersion') AS INT);
SET @productMajorVersion = CAST(SERVERPROPERTY('ProductBuild') AS INT);
PRINT('@productMajorVersion = ' + ISNULL(CAST(@productMajorVersion AS VARCHAR(30)), 'NULL'));
PRINT('@ProductBuild = ' + ISNULL(CAST(@productMajorVersion AS VARCHAR(30)), 'NULL'));

IF @productMajorVersion < 14 OR (@productMajorVersion = 14 AND SERVERPROPERTY('ProductBuild') < 3045)
BEGIN
    RAISERROR(N'Sorry, Trace flag 460 only works for SQL Server 2019 and SQL Server >= 2017 CU12 on this moment.', 16, 1);
    SET NOEXEC ON;
END;

USE tempdb;
GO

DROP TABLE IF EXISTS dbo.WorldSeries;
GO

CREATE TABLE dbo.WorldSeries (TeamName VARCHAR(200), Championships VARCHAR(3));
GO

DBCC TRACEOFF(460); /* if this flag alredy activated */
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES ('Texas Rangers', null);
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES
     ('Houston Astros',     'one')
   , ('Bavaria',        'five')      /* too long Championships value */
   , ('Spartak Moscow', 'hundred');  /* too long Championships value */
GO

DBCC TRACEON(460);
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES
     ('Real Madrid',    'one')
   , ('Chelsi Chelsi',  'two')
   , ('Bavaria',        'five')      /* too long Championships value */
   , ('Spartak Moscow', 'hundred');  /* too long Championships value */
GO

IF OBJECT_ID(N'dbo.WorldSeries', 'U') IS NOT NULL DROP TABLE dbo.WorldSeries;
GO


/*
Don’t leave this trace flag enabled on global scope for SQL Server 2017 CU12 and CU13!
https://www.brentozar.com/archive/2019/03/how-to-fix-the-error-string-or-binary-data-would-be-truncated/
*/

CREATE OR ALTER PROC dbo.Repro @BigString varchar(8000) AS
BEGIN

    DECLARE @Table TABLE (SmallString varchar(128));

    IF ( 1 = 0 )
        /* This will never run */
        INSERT INTO @Table (SmallString)
        VALUES(@BigString)
        OPTION (QUERYTRACEON 460);
END;
GO

DECLARE @BigString varchar(8000) = REPLICATE('blah', 100);
EXEC dbo.Repro @BigString;
GO

DROP PROCEDURE IF EXISTS dbo.Repro;
