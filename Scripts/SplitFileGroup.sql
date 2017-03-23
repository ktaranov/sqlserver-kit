/*=====================================================================
AUTHOR:    trayce@seekwellandprosper.com
FILENAME:  SplitFileGroup.sql
VERSION:	 1.1

  THIS SCRIPT USES the CTRL-SHIFT-M macro substitution technique to set several variables:

	DBName				-- The database in which the filegroup exists that should be split.
	FileGroupName		-- The name of the filegroup to be split  (default = Primary)
	FileCountAfterSplit	-- The total number of files in the filegroup after the split (default = 4)
	MaxFileSize			-- The maximum filesize of the files after the split (default=NULL which equals "UNLIMITED")
	AutoGrowthSize		-- The size for autogrowth after the split is complete (default NULL = 100MB)


OBJECTS CREATED
================
	Additional data files added to the specified filegroup.
	The number of data files added will be  ("FileCountAfterSplit" - 1)
	The additional data files are added to same path where the existing data file resides.


DESCRIPTION OF ALGORITHM
=========================
1) use the same path as the existing file.
2) get the size of the current file
3) set the filesize for each of the new files as:  (CurrentFileSize/FileCountAfterSplit) + 1MB
4) add  (FileCountAfterSplit-1) new files to filegroup
	set the Autogrowth value to 0 (so the files cannot autogrow)
	set the MAXSIZE = to the value supplied in template variable, or UNLIMITED if "NULL" was used
    the "logical" name of each new file is the original file's logical name with an "_x" added to it, where
	       x = the number of the added file -- starting with "2"
	the "physical" name of each new file in the original file's phyical name with an "_x" appended to the filename
	       where x = the number of the added file -- starting with "2".
	the "extension" for the physical files added will be "ndf"
5) issue a DBCC SHRINKFILE  with the EMPTYFILE option
    Ignore the error "2556".   This is expected because not everything can be emptied from the origianl data file.
	This is done intentionally so that after the original file is shrunk, all data files will be the same size.
6) iterate through all data files in the filegroup, setting MAXSIZE and FILEGROWTH to the values
    provided in the template variables.  Defaults being   UNLIMITED  and 100MB respectively
7) issue a DBCC SHRINKFILE, specifying the new filesize



NOTES:
======
This script is an example script only.  It is designed to show one technique on how
to modify a filegroup with a single data to have multiple datafiles and move the
data from the original file into the new files, so that the result is a filegroup balanced
fairly evenly among all of the data files.

This script should not be run in production environments.  It is provided for illustrative purposes only
and is provided "AS IS" with no warranties.

This script is designed to split a filegroup that only contains a single datafile.
This script DOES NOT split the PRIMARY filegroup (since some objects can't be moved)
   (note--- If you really "need" to split the primary filegroup original datafile
	you can do it with the technique in this script/article.  Just realize
    that because some objects can't be moved, the space allocation afterward my not be
	exactly even or uniform).

This script DOES NOT check for adquate file space.
This script DOES NOT do any significant error checking.
This script DOES NOT attempt to handle any "undo" or "rollback" process should an error occur.
If the MaxFileSize specified is less than the calculated new size, the MaxFileSize will be set
  to the calculated new size + 10MB.
Depending on the exact amount of used space in the original file, and the number of files
  specified to split into, the amount of used space in the original file may be somewhat
  less or more than the other files.   This script is not designed to ensure that every
  file is of exact equal size and used space amounts.   All files should be close in 
  used space though -- if not, please send me an email - I would like to discuss.
     

REVISION HISTORY:
=================
20170208	1.1	Initial Release
======================================================================*/

SET NOCOUNT ON
USE [<DBName, sysname, SplitFileGroupDB>]
GO

DECLARE @FileGroupName sysname ='<FileGroupName, sysname, Primary>';
DECLARE @numfiles INT = <FileCountAfterSplit, smallint, 4>;
DECLARE @maxsizeMB INT = <MaxFileSize (NULL = unlimited), smallint, NULL>;
DECLARE @maxgrowthMB INT= <AutoGrowthSize (MB) (NULL = 100), smallint, NULL>;

DECLARE @maxsizeMBText VARCHAR(max) = 'UNLIMITED';
DECLARE @maxgrowthMBText VARCHAR(max) = '100MB';
DECLARE @crlf CHAR(2) = CHAR(13)+CHAR(10);
DECLARE @sql VARCHAR(max);
DECLARE @loopcntr INT;
DECLARE @FGFileCount INT;
DECLARE @FSizeMB DECIMAL(19,2), @LogicalName sysname, @PhysicalName sysname, @MaxSize INT;
DECLARE @NewFSizeMB INT, @NewLogicalName sysname, @NewPhysicalName sysname;

IF @maxgrowthMB IS NOT NULL
	SELECT @maxgrowthMBText = CAST(@maxgrowthMB as varchar(max)) + 'MB'

SELECT @FGFileCount = COUNT(*) FROM sys.database_files df
	INNER JOIN sys.filegroups fg on df.data_space_id = fg.data_space_id
	WHERE fg.name = @FileGroupName

IF ((@FileGroupName = 'Primary')) BEGIN
	RAISERROR('SplitFileGroup.sql message:  This script does not split the primary filegroup.    Aborting.', 10,1)
	RETURN
END
IF ((@FGFileCount IS NULL) or @FGFileCount = 0) BEGIN
	RAISERROR('SplitFileGroup.sql message:  Filegroup [%s] does not exist.    Aborting.', 10,1, @FileGroupName)
	RETURN
END ELSE IF (@FGFileCount > 1) BEGIN
	RAISERROR('SplitFileGroup.sql message:  The procedure is designed for splitting a filegroup with only 1 file in it.  Filegroup [%s] contains <%d> files.    Aborting.', 10,1, @FileGroupName, @FGFileCount)
	RETURN
END

--if we get here, we have only 1 file in the filegroup --we will proceed

--get the used amount of space and other info from current file in filegroup
SELECT @FSizeMB = (SUM(au.[total_pages])/(1024.*1024))*8192, 
	@NewFSizeMB = CAST(1+((SUM(au.[total_pages])/(1024.*1024))*8192)/@numfiles as INT)
	FROM sys.allocation_units au 
	INNER JOIN sys.filegroups fg on fg.data_space_id = au.data_space_id
	WHERE fg.name = @FileGroupName

IF @maxsizeMB IS NOT NULL BEGIN
	IF @maxSizeMB < @NewFSizeMB  BEGIN
		SELECT @maxSizeMB = @NewFSizeMB + 10
	END
	SELECT @maxsizeMBText = CAST(@maxsizeMB as varchar(max)) + 'MB'
END

SELECT 
	@LogicalName = df.[name], 
	@PhysicalName = df.[physical_name]
	FROM sys.database_files df
	INNER JOIN sys.filegroups fg on df.data_space_id = fg.data_space_id
		WHERE fg.name = @FileGroupName

--add (@numfiles-1) files to file group
SELECT @loopcntr = 2;
WHILE @loopcntr <= @numfiles BEGIN
	SELECT @NewLogicalName = @LogicalName + '_' + CAST(@loopcntr as varchar(5))
	SELECT @NewPhysicalName = REPLACE(@PhysicalName , RIGHT(@PhysicalName,4), '_' + CAST(@loopcntr as varchar(5))+'.ndf')
	SELECT @sql = 'ALTER DATABASE [' + DB_NAME() + '] ADD FILE ('+ @crlf	+
			'NAME = ' + @NewLogicalName + ',' + @crlf + 
			'FILENAME = ' + QUOTENAME(@NewPhysicalName, '''') + ',' + @crlf + 
			'SIZE = ' + CAST(@NewFSizeMB as VARCHAR(max)) + 'MB,' + @crlf +
			'MAXSIZE = ' + CAST(@NewFSizeMB as VARCHAR(max)) + 'MB,' + @crlf + 
			'FILEGROWTH = 0MB) TO FILEGROUP ' + QUOTENAME(@FileGroupName) +';' + @crlf + @crlf
	PRINT @sql
	exec (@sql)
	SELECT @loopcntr += 1
END

--empty the original file -- which will move data into the new files
SELECT @sql = 'BEGIN TRY' + @crlf +
		'DBCC SHRINKFILE (' + @LogicalName + ', EMPTYFILE)' + @crlf +
		'END TRY' + @crlf + 
		'BEGIN CATCH' + @crlf + 
		'   IF ERROR_NUMBER() <> 2556 BEGIN' + @crlf + 
        '      SELECT ERROR_NUMBER(), ERROR_MESSAGE()' + @crlf + 
        '      RAISERROR (''Severe error moving data into new files.  MANUAL cleanup necessary.  Terminating connection...'', 19, 1) WITH LOG' + @crlf +
		'	END' + @crlf + 
		'END CATCH' + @crlf + @crlf
PRINT @SQL
exec (@sql)

--set all files to have a MAXSIZE and enable autogrowth
SELECT @loopcntr = 1;
WHILE @loopcntr <= @numfiles BEGIN
	SELECT @NewLogicalName = CASE @loopcntr WHEN 1 then @LogicalName ELSE @LogicalName + '_' + CAST(@loopcntr as varchar(5)) END
	SELECT @sql = 'ALTER DATABASE [' + DB_NAME() + '] MODIFY FILE ('+ @crlf	+
			'NAME = ' + @NewLogicalName + ',' + @crlf + 
			'MAXSIZE = ' + @maxsizeMBText + ',' + @crlf + 
			'FILEGROWTH = ' +  @maxgrowthMBText + ');' + @crlf + @crlf
	PRINT @sql
	exec (@sql)
	SELECT @loopcntr += 1
END

--shrink the original file to match the new files size
SELECT @sql = 'BEGIN TRY' + @crlf +
		'DBCC SHRINKFILE (' + @LogicalName + ', ' + CAST(@NewFSizeMB as varchar(max))+ ')' + @crlf +
		'END TRY' + @crlf + 
		'BEGIN CATCH' + @crlf + 
		'   IF ERROR_NUMBER() <> 2556 BEGIN' + @crlf + 
        '      SELECT ERROR_NUMBER(), ERROR_MESSAGE()' + @crlf + 
        '      RAISERROR (''Severe error moving data into new files.  MANUAL cleanup necessary.  Terminating connection...'', 19, 1) WITH LOG' + @crlf +
		'	END' + @crlf + 
		'END CATCH' + @crlf
PRINT @SQL
exec (@sql)

