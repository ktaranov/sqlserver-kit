SET NOEXEC OFF;

DECLARE @msg NVARCHAR(MAX) = N'';
DECLARE @productMajorVersion INT;
SET @productMajorVersion = CAST(SERVERPROPERTY('ProductMajorVersion') AS INT);

IF @productMajorVersion < 14 OR (@productMajorVersion = 14 AND SERVERPROPERTY('ProductBuild') < 3045)
BEGIN
    RAISERROR(N'Sorry, Trace flag 460 only works for SQL Server 2019 and SQL Server >= 2017 CU12 on this moment.', 16, 1);
    SET NOEXEC ON;
END;

USE tempdb;
GO

IF OBJECT_ID(N'dbo.WorldSeries', 'U') IS NOT NULL DROP TABLE dbo.WorldSeries;
GO

CREATE TABLE dbo.WorldSeries (TeamName VARCHAR(200), Championships VARCHAR(3));
GO

DBCC TRACEOFF(460); /* if this flag alredy activated */
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES ('Texas Rangers', null);
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES
     ('Houston Astros',     'one')
   , ('Atlanta Braves',     'two')
   , ('Pittsburgh Pirates', 'five');  /* too long Championships value */
GO

DBCC TRACEON(460);
INSERT INTO dbo.WorldSeries (TeamName, Championships) VALUES
     ('Houston Astros',     'one')
   , ('Atlanta Braves',     'two')
   , ('Pittsburgh Pirates', 'five');  /* too long Championships value */
GO

IF OBJECT_ID(N'dbo.WorldSeries', 'U') IS NOT NULL DROP TABLE dbo.WorldSeries;
GO
