use master
GO
CREATE DATABASE AdventureWorks2012
GO
--	Make sure, the db is in full recovery mode
ALTER DATABASE AdventureWorks2012 SET RECOVERY FULL;
GO
BACKUP DATABASE AdventureWorks2012 TO DISK = 'NUL'
GO
USE AdventureWorks2012;
GO
-- Adds four new filegroups to the AdventureWorks2012 database
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test1fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test2fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test3fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILEGROUP test4fg;

-- Adds one file for each filegroup.
ALTER DATABASE AdventureWorks2012
ADD FILE
(
    NAME = test1dat1,
    FILENAME = 'X:\MSSQL\DATA\t1dat1.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test1fg;
ALTER DATABASE AdventureWorks2012
ADD FILE
(
    NAME = test2dat2,
    FILENAME = 'X:\MSSQL\DATA\t2dat2.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test2fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILE
(
    NAME = test3dat3,
    FILENAME = 'X:\MSSQL\DATA\t3dat3.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test3fg;
GO
ALTER DATABASE AdventureWorks2012
ADD FILE
(
    NAME = test4dat4,
    FILENAME = 'X:\MSSQL\DATA\t4dat4.ndf',
    SIZE = 5MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
TO FILEGROUP test4fg;
GO
-- Creates a partition function called myRangePF1 that will partition a table into four partitions
CREATE PARTITION FUNCTION myRangePF1 (int)
    AS RANGE LEFT FOR VALUES (1, 100, 1000) ;
GO
-- Creates a partition scheme called myRangePS1 that applies myRangePF1 to the four filegroups created above
CREATE PARTITION SCHEME myRangePS1
    AS PARTITION myRangePF1
    TO (test1fg, test2fg, test3fg, test4fg) ;
GO
-- Creates a partitioned table called PartitionTable that uses myRangePS1 to partition col1
CREATE TABLE PartitionTable (col1 int PRIMARY KEY, col2 char(10))
    ON myRangePS1 (col1) ;
GO

-- Insert some values into each partition
insert into PartitionTable
values (0, 'ska'),(50, 'pop'),(150, 'rap'),(1050, 'rock')
GO

--Backup of Primary filegroup
BACKUP DATABASE [AdventureWorks2012] FILEGROUP = N'PRIMARY'
TO  DISK = N'X:\MSSQL\backup\primary.bak' WITH NOFORMAT, NOINIT,
NAME = N'PrimaryFG Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Backup of FG1 filegroup
BACKUP DATABASE [AdventureWorks2012] FILEGROUP = N'test1fg'
TO  DISK = N'X:\MSSQL\backup\test1fg.bak' WITH NOFORMAT, NOINIT,
NAME = N'FG1 Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Backup of FG2 filegroup
BACKUP DATABASE [AdventureWorks2012] FILEGROUP = N'test2fg'
TO  DISK = N'X:\MSSQL\backup\test2fg.bak' WITH NOFORMAT, NOINIT,
NAME = N'FG2 Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Backup of FG3 filegroup
BACKUP DATABASE [AdventureWorks2012] FILEGROUP = N'test3fg'
TO  DISK = N'X:\MSSQL\backup\test3fg.bak' WITH NOFORMAT, NOINIT,
NAME = N'FG3 Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Backup of FG4 filegroup
BACKUP DATABASE [AdventureWorks2012] FILEGROUP = N'test4fg'
TO  DISK = N'X:\MSSQL\backup\test4fg.bak' WITH NOFORMAT, NOINIT,
NAME = N'FG4 Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--	We have to take log backup, or else we will not be able to finish restore
BACKUP LOG [AdventureWorks2012] TO  DISK = N'X:\MSSQL\backup\aw2012_log.trn' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2012-Transaction Log  Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- Restore our backups of only primary FG into new database with NORECOVERY
RESTORE DATABASE TestDB FILEGROUP='Primary' FROM DISK = N'X:\MSSQL\backup\primary.bak'
WITH
MOVE 'AdventureWorks2012' TO 'X:\MSSQL\DATA\AdventureWorks2012Copy_Data.mdf',
MOVE 'AdventureWorks2012_Log' TO 'X:\MSSQL\DATA\AdventureWorks2012Copy_Log.ldf',  NORECOVERY,
PARTIAL
GO

--	Restore additional FG with NORECOVERY
RESTORE DATABASE TestDB FILEGROUP='test1fg' FROM DISK = N'X:\MSSQL\backup\test1fg.bak'
WITH
MOVE 'test1dat1' TO 'X:\MSSQL\DATA\test1dat1_copy.ndf',  NORECOVERY
GO

--	After restoring all required FGs, restore the log backup WITH RECOVERY
restore log TestDB FROM DISK = 'X:\MSSQL\backup\aw2012_log.trn'
GO


-- Lets have a look at the cintents of partially restored table. It gives an error, but still shows the rows from range residing in FG we have restored.
use TestDB
GO
select * from PartitionTable

-- This select doesn't cause any errors, because we have limited output to the boundary of our partition.
select * from PartitionTable where col1 <= 1