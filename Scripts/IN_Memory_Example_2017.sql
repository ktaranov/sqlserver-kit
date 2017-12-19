-- https://docs.microsoft.com/en-us/sql/relational-databases/in-memory-oltp/overview-and-usage-scenarios
USE master;

IF DB_ID(N'ಠ ಠ 17 Test') IS NOT NULL DROP DATABASE [ಠ ಠ 17 Test];

CREATE DATABASE [ಠ ಠ 17 Test]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ಠ ಠ 17 Test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ಠ ಠ 17 Test.mdf', SIZE = 64MB, MAXSIZE = UNLIMITED, FILEGROWTH = 64MB), 
FILEGROUP [ಠ ಠ 17 Test] CONTAINS MEMORY_OPTIMIZED_DATA DEFAULT
( NAME = N'TESTDB_mod',  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ಠ ಠ 17 Test_mod', MAXSIZE = UNLIMITED)
 LOG ON                  
( NAME = N'TESTDB_log',  FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ಠ ಠ 17 Test_log.ldf', SIZE = 64MB, MAXSIZE = 2048MB, FILEGROWTH = 64MB)
GO

USE [ಠ ಠ 17 Test];
GO

-- configure recommended DB option
 ALTER DATABASE CURRENT SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON;
 GO
 -- memory-optimized table
 CREATE TABLE dbo.table1
 ( c1 INT IDENTITY PRIMARY KEY NONCLUSTERED,
   c2 NVARCHAR(MAX))
 WITH (MEMORY_OPTIMIZED=ON)
 GO
 -- non-durable table
 CREATE TABLE dbo.temp_table1
 ( c1 INT IDENTITY PRIMARY KEY NONCLUSTERED,
   c2 NVARCHAR(MAX))
 WITH (MEMORY_OPTIMIZED=ON,
       DURABILITY=SCHEMA_ONLY)
 GO
 -- memory-optimized table type
 CREATE TYPE dbo.tt_table1 AS TABLE
 ( c1 INT IDENTITY,
   c2 NVARCHAR(MAX),
   is_transient BIT NOT NULL DEFAULT (0),
   INDEX ix_c1 HASH (c1) WITH (BUCKET_COUNT=1024))
 WITH (MEMORY_OPTIMIZED=ON)
 GO
 -- natively compiled stored procedure
 CREATE PROCEDURE dbo.usp_ingest_table1
   @table1 dbo.tt_table1 READONLY
 WITH NATIVE_COMPILATION, SCHEMABINDING
 AS
 BEGIN ATOMIC
     WITH (TRANSACTION ISOLATION LEVEL=SNAPSHOT,
           LANGUAGE=N'us_english')

   DECLARE @i INT = 1

   WHILE @i > 0
   BEGIN
     INSERT dbo.table1
     SELECT c2
     FROM @table1
     WHERE c1 = @i AND is_transient=0

     IF @@ROWCOUNT > 0
       SET @i += 1
     ELSE
     BEGIN
       INSERT dbo.temp_table1
       SELECT c2
       FROM @table1
       WHERE c1 = @i AND is_transient=1

       IF @@ROWCOUNT > 0
         SET @i += 1
       ELSE
         SET @i = 0
     END
   END

 END
 GO
 -- sample execution of the proc
DECLARE @table1 dbo.tt_table1
INSERT @table1 (c2, is_transient) VALUES (N'sample durable', 0)
INSERT @table1 (c2, is_transient) VALUES (N'sample non-durable', 1)
EXECUTE dbo.usp_ingest_table1 @table1=@table1
SELECT c1, c2 from dbo.table1
SELECT c1, c2 from dbo.temp_table1
GO

 CREATE TABLE dbo.InMemTable1
(
keyColumn INT IDENTITY PRIMARY KEY NONCLUSTERED
,description CHAR(100) NOT NULL
)
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)

INSERT dbo.InMemTable1
(
description
)
VALUES
 (REPLICATE('A', 100))
,(REPLICATE('B', 100))
,(REPLICATE('C', 100))
,(REPLICATE('D', 100))
,(REPLICATE('E', 100))
,(REPLICATE('F', 100))
GO

CREATE OR ALTER PROCEDURE dbo.native_sp
WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english')
SELECT keyColumn
,description
FROM dbo.InMemTable1;
END;
GO
EXECUTE dbo.native_sp;
