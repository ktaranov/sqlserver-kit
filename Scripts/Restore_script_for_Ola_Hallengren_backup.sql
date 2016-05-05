/*
Author: Joe O'Connor
Original link: http://www.sqlservercentral.com/scripts/Restore/140540/
*/

/*
Description:
T-SQL Script to generate a restore script for a database backed up to disk using Ola Hallengren's
maintenance solution.  The script is based solely on the contents of a directory, taking into 
account the order of full backups, differential backups and transaction log backups.

Maintenance Script Credit: Ola Hallengren
https://ola.hallengren.com/

Original Restore Script Credit: Greg Robidoux
https://www.mssqltips.com/sqlservertip/1584/auto-generate-sql-server-restore-script-from-backup-files-in-a-directory/

Modified Restore Script Credit: Jason Carter
http://jason-carter.net/professional/restore-script-from-backup-directory-modified.html

Reason for change:
Ola's script uses a .BAK extension for differentials, and stores FULL, DIFF and LOG backups in a sub-folder
heirarchy that matches @backupPath\@@SERVERNAME\@dbName\[FULL|DIFF|LOG]\ and the filename also contains what
type of backup file it is within the filename, making filename comparison for order of restore impossible.

ChangeLog: 
	2/24/2016 - Joe O'Connor (thirtybird@gmail.com)
Allow backup paths to have spaces in them by encapsulating path in the command in quotes
Fixed DIR command - /O D to /O:D to guarantee order by date to ensure transaction logs are restored in proper order
Added wrapper to enable and disable xp_cmdshell and re-set the "show advanced options" setting to whatever it was
	If you have xp_cmdshell enabled in your environment, take this part out or it will get disabled!
Took out extra @backupPath in each RESTORE command - the full path is output into the file list and was duplicated in the output
Added backupTime to the local table variable to be used for comparison as comparing filenames doesn't work with Ola's filenames
	This involves substring parsing (and is ugly).  

	2/25/2016 - Joe O'Connor (thirtybird@gmail.com)
Added logic to check to see if xp_cmdshell needs to be enabled or not.  Only enables and disables if it needs to.
Verified it does not disable xp_cmdshell if it was enabled to start with.

	3/16/2016 - Joe O'Connor (thirtybird@gmail.com)
Added a RESTORE FILELISTONLY as the first output command.

	4/20/2016 - Joe O'Connor (thirtybird@gmail.com)
Converted code to utilize xp_dirtree instead of xp_cmdshell
Re-ordered some code to get the variables that need to be set closer to the top of the script
Fixed problem with compatibility with named instances (replacing '\' with '$' in @@SERVERNAME)

Tested against: SQL 2005 - 2014
*/

USE Master;
GO 
SET NOCOUNT ON

/**
	Variable declaration
**/
DECLARE @dbName sysname
DECLARE @backupPath NVARCHAR(500)

/**
	Initialize variables
**/
SET @dbName = 'Test'
SET @backupPath = 'Y:\Microsoft SQL Server\Backup'


/**
	Convert the variables to match that of Olas maintenance script
**/
IF RIGHT (@backupPath,1) = '\' SET @backupPath = SUBSTRING (@backupPath, 1, LEN (@backupPath)-1)
SET @backupPath = @backupPath + '\' + REPLACE(@@SERVERNAME,'\','$') + '\' + @dbName + '\'


/**
	Get List of Files
**/
IF OBJECT_ID('tempdb..#DirectoryTree')IS NOT NULL
	  DROP TABLE #DirectoryTree;

CREATE TABLE #DirectoryTree (
	    backupFile nvarchar(255) NOT NULL
	  , depth int
	  , isfile bit
	  , backupTime NVARCHAR(20));


/**
	Create a clustered index to keep everything in order by filename.
**/
ALTER TABLE #DirectoryTree
ADD CONSTRAINT PK_DirectoryTree PRIMARY KEY CLUSTERED (backupFile);

INSERT #DirectoryTree (backupFile,depth,isfile)
EXEC xp_dirtree @backupPath,2,1;


/**
	Get rid of the directories
**/
DELETE FROM #DirectoryTree WHERE isfile=0


/**
    Figure out the backup time for comparison since file names cannot be compare as all DIFF and LOG backups will be > the full
    Also append the @backupPath to the backup File name in the table as well
**/
-- Update the FULL's
UPDATE #DirectoryTree
SET backupTime = 
SUBSTRING(backupfile, CHARINDEX (@dbName+'_FULL_',backupFile) +LEN(@dbName+'_FULL_'), (LEN(backupfile) - CHARINDEX ('.',REVERSE(backupFile))) + 1 - (CHARINDEX (@dbName+'_FULL_',backupFile) +LEN(@dbName+'_FULL_')))
, backupfile = @backupPath + 'FULL\' + backupfile
FROM #DirectoryTree
WHERE CHARINDEX (@dbName+'_FULL_',backupFile) > 0

-- Update the DIFF's
UPDATE #DirectoryTree
SET backupTime = 
SUBSTRING(backupfile, CHARINDEX (@dbName+'_DIFF_',backupFile) +LEN(@dbName+'_DIFF_'), (LEN(backupfile) - CHARINDEX ('.',REVERSE(backupFile))) + 1 - (CHARINDEX (@dbName+'_DIFF_',backupFile) +LEN(@dbName+'_DIFF_')))
, backupfile = @backupPath + 'DIFF\' + backupfile
FROM #DirectoryTree
WHERE CHARINDEX (@dbName+'_DIFF_',backupFile) > 0

-- Update the LOGs
UPDATE #DirectoryTree
SET backupTime = 
SUBSTRING(backupfile, CHARINDEX (@dbName+'_LOG_',backupFile) +LEN(@dbName+'_LOG_'), (LEN(backupfile) - CHARINDEX ('.',REVERSE(backupFile))) + 1 - (CHARINDEX (@dbName+'_LOG_',backupFile) +LEN(@dbName+'_LOG_')))
, backupfile = @backupPath + 'LOG\' + backupfile
FROM #DirectoryTree
WHERE CHARINDEX (@dbName+'_LOG_',backupFile) > 0

/**
	Find latest full backup
**/
DECLARE           @cmd NVARCHAR(500)
		, @lastFullBackup NVARCHAR(500)
		, @lastDiffBackup NVARCHAR(500)
		, @backupFile NVARCHAR(500)
		, @lastFullBackupTime NVARCHAR(20)
		, @lastDiffBackupTime NVARCHAR(20)

SELECT TOP 1 @lastFullBackup = backupFile
, @lastFullBackupTime = backupTime
FROM #DirectoryTree 
WHERE backupFile LIKE '%' + REPLACE(@@SERVERNAME,'\','$') + '_' + @dbName + '_FULL_%.bak'
ORDER BY backupTime DESC

SET @cmd = 'RESTORE FILELISTONLY FROM DISK = '''  
       + @lastFullBackup + ''' WITH FILE = 1' 
PRINT @cmd 

SET @cmd = 'RESTORE DATABASE [' + @dbName + '] FROM DISK = ''' 
       + @lastFullBackup + ''' WITH NORECOVERY, REPLACE'
PRINT @cmd

/**
	Find latest diff backup
**/
SELECT TOP 1 @lastDiffBackup = backupFile
, @lastDiffBackupTime = backupTime
FROM #DirectoryTree 
WHERE 
	backupFile  LIKE '%' + REPLACE(@@SERVERNAME,'\','$') + '_' + @dbName + '_DIFF_%.bak'
	AND backupTime > @lastFullBackupTime
	ORDER BY backupTime DESC

/**
	check to make sure there is a diff backup
**/
IF @lastDiffBackup IS NOT NULL
	BEGIN
	   SET @cmd = 'RESTORE DATABASE [' + @dbName + '] FROM DISK = ''' 
		   + @lastDiffBackup + ''' WITH NORECOVERY'
	   PRINT @cmd
	   SET @lastFullBackupTime = @lastDiffBackupTime
	END

/**
	check for log backups
**/
DECLARE backupFiles CURSOR FOR 
   SELECT backupFile 
   FROM #DirectoryTree
   WHERE 
	backupFile LIKE  '%' + REPLACE(@@SERVERNAME,'\','$') + '_' + @dbName + '_LOG_%.trn'
	AND backupTime > @lastFullBackupTime

OPEN backupFiles 

/**
	Loop through all the files for the database 
**/
FETCH NEXT FROM backupFiles INTO @backupFile 

WHILE @@FETCH_STATUS = 0 
	BEGIN 
	   SET @cmd = 'RESTORE LOG [' + @dbName + '] FROM DISK = ''' 
		   + @backupFile + ''' WITH NORECOVERY'
	   PRINT @cmd
	   FETCH NEXT FROM backupFiles INTO @backupFile 
	END

CLOSE backupFiles 
DEALLOCATE backupFiles 

/**
	put database in a useable state
**/
SET @cmd = 'RESTORE DATABASE [' + @dbName + '] WITH RECOVERY'
PRINT @cmd


/**
    Cleanup our temp table
**/
IF OBJECT_ID('tempdb..#DirectoryTree')IS NOT NULL
      DROP TABLE #DirectoryTree;
GO
