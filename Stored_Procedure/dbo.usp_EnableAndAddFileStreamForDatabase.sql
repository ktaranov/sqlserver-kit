--EXEC ('USE master; EXEC [dbo].[usp_EnableAndAddFileStreamForDatabase] ''OpalTAQ''')
USE [master];
GO
CREATE PROCEDURE [dbo].[usp_EnableAndAddFileStreamForDatabase] (@NameOfDatabase VARCHAR(100) = '') 
AS
BEGIN
	IF(COALESCE(@NameOfDatabase,'') <> '')
	BEGIN
		SET NOCOUNT ON;

		/*************************************************************/
		PRINT '1. CREATE TEMP DB FOR FILESTREAM SETUP'
		EXEC('USE [Master];');
		IF EXISTS (SELECT 1 
				   FROM master.INFORMATION_SCHEMA.TABLES 
				   WHERE TABLE_TYPE='BASE TABLE' 
				   AND TABLE_NAME='fsSetupInfo')
			DROP TABLE dbo.fsSetupInfo;

		CREATE TABLE dbo.fsSetupInfo (	DBName VARCHAR(100) NULL,
										FilePath VARCHAR(255) NULL,
										DirPath VARCHAR(255) NULL
									 );
		INSERT INTO	dbo.fsSetupInfo (DBName, FilePath, DirPath)
		VALUES (@NameOfDatabase, '', '');

		PRINT '**********     COMPLETED 1. CREATE TEMP DB FOR FILESTREAM SETUP'


		/*************************************************************/
		PRINT '2. CONFIGURE SQL INSTANCE FOR FILESTREAM'
		/*
			0 -Disables FILESTREAM
			1 -Enables FILESTREAM for T-SQL
			2 -Enables FILESTREAM for T-SQL and Win32 streaming access
		*/
		EXEC('USE master;')
		EXEC sp_configure filestream_access_level, 2;
		RECONFIGURE WITH OVERRIDE;
		PRINT '**********     COMPLETED - 2. CONFIGURE SQL INSTANCE FOR FILESTREAM'


		/*************************************************************/
		PRINT '3. GET/SET FILEPATH/FILEDIRECTORY OF DATABASE PHYSICAL FILE'
		DECLARE  @DBName VARCHAR(100) = ''
				,@DBFilePath VARCHAR(255) = ''
				,@DBDirPath VARCHAR(255) = ''

		SELECT TOP 1 @DBName = DBName 
		FROM master.dbo.fsSetupInfo;

		SELECT TOP 1 @DBFilePath = physical_name 
		FROM sys.master_files
		WHERE FILE_ID = 1 
		  AND physical_name LIKE '%' + @DBName + '.mdf';

		UPDATE master.dbo.fsSetupInfo SET FilePath = @DBFilePath;
		UPDATE master.dbo.fsSetupInfo SET DirPath = (SELECT SUBSTRING(@DBFilePath, 1, LEN(@DBFilePath) - CHARINDEX('\', REVERSE(@DBFilePath))) + '\');
		PRINT '**********     COMPLETED 3. GET/SET FILEPATH/FILEDIRECTORY OF DATABASE PHYSICAL FILE'


		/*************************************************************/
		PRINT '4. CONFIGURE SQL DATABASE FOR FILESTREAM'
		/* Add Filegroup to database*/
		SELECT TOP 1 @DBDirPath = DirPath, @DBName = DBName
		FROM master.dbo.fsSetupInfo;

		EXEC('USE ' + @DBName +'; '
			+ 'IF NOT EXISTS (SELECT * FROM sys.filegroups WHERE name = ''fs' + @DBName + ''')'
			+ '		ALTER DATABASE ' + @DBName + ' ADD FILEGROUP fs' + @DBName + ' CONTAINS FILESTREAM'
			);

		/* Add a file to the database */
		EXEC('USE ' + @DBName +'; '
			+ 'IF NOT EXISTS(SELECT physical_name FROM sys.database_files WHERE type_desc = ''FILESTREAM'')'
			+ '		ALTER DATABASE ' + @DBName + '
					ADD FILE (NAME = ''fs' + @DBName + ''', FILENAME = ''' + @DBDirPath + 'fs' + @DBName + ''')
					TO FILEGROUP fs' + @DBName);

		PRINT '**********     COMPLETED 4. CONFIGURE SQL DATABASE FOR FILESTREAM'

		/*************************************************************/
		PRINT 'CLEAN UP'
		IF EXISTS (SELECT 1 
				   FROM master.INFORMATION_SCHEMA.TABLES 
				   WHERE TABLE_TYPE='BASE TABLE' 
				   AND TABLE_NAME='fsSetupInfo')
			DROP TABLE dbo.fsSetupInfo;
		PRINT '**********     CLEANUP COMPLETED'


		SET NOCOUNT OFF;
	END
	ELSE
		PRINT 'NO DATABASE NAME PROVIDED'
END;