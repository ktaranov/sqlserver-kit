-- Original LInk: http://www.sqlservercentral.com/scripts/renaming/155059

-- =============================================
-- Author:		Darren Thompson
-- Create date: 3/23/2017
-- Description:	rename database
-- =============================================

CREATE PROCEDURE [dbo].[usp_DBA_Rename_Database] 
	@DatabaseName varchar(100), @NewName varchar(100)
AS
BEGIN
	DECLARE @sql varchar(1000)
	DECLARE @physLoc varchar(1000), @physLoc_log varchar(1000)
	DECLARE @physLocNew varchar(1000), @physLoc_logNew varchar(1000)

	IF (@DatabaseName NOT IN ('master','DBA','msdb','tempdb'))
	BEGIN
		IF EXISTS(SELECT * FROM sys.databases WHERE Name = @DatabaseName)
		BEGIN
			SELECT @physLoc = physical_name FROM sys.master_files WHERE name = @DatabaseName and type_desc = 'ROWS'
			SELECT @physLoc_log = physical_name FROM sys.master_files WHERE name = @DatabaseName + '_log' and type_desc = 'LOG'

			--// SET TO SINGLE USER
			SET @sql = 'ALTER DATABASE ' + @DatabaseName + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE'
			EXECUTE (@sql)

			--// RENAME DATABASE: LOGICAL NAME
			SET @sql = '
				ALTER DATABASE [' + @DatabaseName + ']
				MODIFY FILE  (NAME=N''' + @DatabaseName + ''', NEWNAME=N''' + @NewName + ''')
				ALTER DATABASE [' + @DatabaseName + ']
				MODIFY FILE  (NAME=N''' + @DatabaseName + '_log'', NEWNAME=N''' + @NewName + '_log'')'
			EXECUTE(@sql)
		

			SET @sql = 'ALTER DATABASE ' + @DatabaseName + ' SET OFFLINE'
			EXECUTE (@sql)

			EXEC sp_configure 'xp_cmdshell', 1				--// 0 = Disabled , 1 = Enabled 
			RECONFIGURE WITH OVERRIDE

			--// RENAME DATABASE: PHYSICAL FILE NAME
			SET @sql = 'EXEC xp_cmdshell ''RENAME "' + @physLoc + '", "' + @newName + '.mdf"'''			-- CurrentPath&Name, NewName
			EXECUTE (@sql)
			
			SET @sql = 'EXEC xp_cmdshell ''RENAME "' + @physLoc_log + '", "' + @newName + '_log.ldf"'''		-- CurrentPath&Name, NewName
			EXECUTE (@sql)

			EXEC sp_configure 'xp_cmdshell', 0				--// 0 = Disabled , 1 = Enabled 
			RECONFIGURE WITH OVERRIDE


			----// ATTACH (CREATE) DATABASE
			SELECT @physLocNew = REPLACE(@physLoc,@DatabaseName,@newName)
			SELECT @physLoc_logNew = REPLACE(@physLoc_log,@DatabaseName,@newName)

			SET @sql = '
			CREATE DATABASE [' + @NewName + '] ON 
			( FILENAME = N''' + @physLocNew + ''' ),
			( FILENAME = N''' + @physLoc_logNew + ''' )
			FOR ATTACH '
			EXECUTE (@sql)

			--// DETACH DATABASE
			SET @sql = 'EXEC master.dbo.sp_detach_db @dbname = N''' + @DatabaseName + ''''
			EXECUTE (@sql)
		END
	END

END
