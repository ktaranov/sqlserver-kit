/*
https://www.sqlshack.com/understanding-sql-server-proportional-fill-algorithm/
*/

DBCC TRACEON (1165, 3605);
GO

EXEC sp_cycle_errorlog;
GO

CREATE DATABASE PropFillDemo
ON PRIMARY
( NAME = N'PropFillDemo',             FILENAME = N'g:\MSSQL19\MSSQL15.MSSQL19\MSSQL\DATA\PropFillDemo2.mdf',   SIZE = 10MB , MAXSIZE = 1GB, FILEGROWTH = 10MB),
( NAME = N'PropFillDemo_1',           FILENAME = N'g:\MSSQL19\MSSQL15.MSSQL19\MSSQL\DATA\PropFillDemo2_1.ndf', SIZE = 10MB , MAXSIZE = 1GB, FILEGROWTH = 10MB),
( NAME = N'PropFillDemo_2',           FILENAME = N'g:\MSSQL19\MSSQL15.MSSQL19\MSSQL\DATA\PropFillDemo2_2.ndf', SIZE = 10MB , MAXSIZE = 1GB, FILEGROWTH = 10MB),
( NAME = N'PropFillDemo_3',           FILENAME = N'g:\MSSQL19\MSSQL15.MSSQL19\MSSQL\DATA\PropFillDemo2_3.ndf', SIZE = 10MB , MAXSIZE = 1GB, FILEGROWTH = 10MB)
 LOG ON ( NAME = N'PropFillDemo_log', FILENAME = N'g:\MSSQL19\MSSQL15.MSSQL19\MSSQL\DATA\PropFillDemo_log.ldf',SIZE = 10MB , MAXSIZE = 2GB , FILEGROWTH = 10%);

EXEC xp_readerrorlog;
GO

USE PropFillDemo;
GO

SELECT [name]            AS DBFileName
     , [file_id]         AS DBFileID
     , [physical_name]   AS PathAndPhysicalName
     , (size * 8.0/1024) AS FileSizeMB
     , ((size * 8.0/1024) - (FILEPROPERTY(name, 'SpaceUsed') * 8.0/1024)) AS FileFreeSpaceMB
     , CAST((((size * 8.0/1024) - (FILEPROPERTY(name, 'SpaceUsed') * 8.0/1024))/(size * 8.0/1024))*100 AS decimal(6,2)) AS FreeSpacePercent
  FROM sys.database_files;


DBCC showfilestats;

CREATE TABLE PropFillTest(
    ID          int IDENTITY (1,1)
  , First_Name  nvarchar(50) NOT NULL
  , Last_Name   nvarchar(50) NOT NULL
);

INSERT INTO PropFillTest VALUES('Ahmad', 'Yaseen'), ('John', 'Mikel');
GO 500


INSERT INTO PropFillTest VALUES('Ahmad', 'Yaseen'), ('John', 'Mikel');
GO 15000

DBCC showfilestats;

DBCC IND ('PropFillDemo', 'PropFillTest', -1);


INSERT INTO [PropFillTest] VALUES('Ahmad','Yaseen'),('John','Mikel')
GO 15000000

USE [master]
GO
ALTER DATABASE [PropFillDemo] ADD FILE ( NAME = N'PropFillDemo_4', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PropFillDemo_4.ndf' , SIZE = 15360KB , FILEGROWTH = 10240KB ) TO FILEGROUP [PRIMARY];
GO

EXEC xp_readerrorlog;
GO
