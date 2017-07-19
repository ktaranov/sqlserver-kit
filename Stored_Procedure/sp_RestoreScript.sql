/*
Original link: https://sqlundercover.com/2017/06/29/undercover-toolbox-sp_restorescript-a-painless-way-to-generate-sql-server-database-restore-scripts


sp_RestoreScript 1.0
Written By David Fowler
29 June 2017
Generate a set of backup commands to restore a database(s) to a specified time                                                               
 
Parameters
==========
 
@DatabaseName -     A comma delimited list of databases to restore - DEFAULT: Current Database
 
@RestoreAsName -    A comma delimited list of name to restore databases as, the number of should correspond to the number of
                    databases in @DatabaseName.  
 
@RestoreToDate-     See @PointInTime for useage of @RestoreToDate. - DEFAULT: GETDATE()
 
@FirstLogToRestore- If 'LogsOnly' restore option has been selected, this is the date of the first log to be restored. This
                    can't be left NULL if 'LogsOnly' has been selected.  If any other option has been selected it wil be ignored
 
@RestoreOptions-    'ToLog' - Script will generate statements including full, differential and log backups - DEFAULT
                    'ToDiff'   Script will only include full and differential backups
                    'ToFull'   Script will only include a full backup
                    'LogsOnly' - Script will only include log backups between @FirstLogToRestore and @RestoreToDate
 
@PointInTime -      1 - Script will restore to a point in time specified in @RestoreToDate
                    0 - Script will to last backup before the date\time specified in @RestoreToDate - DEFAULT
 
@WithMoveDataPath - WITH MOVE Path to move data files to. - DEFAULT: original path
 
@WithMoveLogPath -  WITH MOVE Path to move log files to. - DEFAULT:@ original path
 
@Replace -          1 - Databases will be restored WITH REPLACE
                    0 - Database won't be restored WITH REPLACE - DEFAULT
 
@NoRecovery -       1 - Last file will be restored with NORECOVERY, leaving the database in 'restoring' state
                    0 - Last file will be restored with RECOVERY and the database brought online - DEFAULT
 
Full documentation and examples can be found at www.sqlundercover.com
*/
USE MASTER
GO
 
CREATE PROC sp_RestoreScript
(
@DatabaseName VARCHAR(3000) = NULL,
@RestoreAsName VARCHAR(3000) = NULL,
@RestoreToDate DATETIME = NULL,
@FirstLogToRestore DATETIME = NULL,
@RestoreOptions VARCHAR(11) = 'ToLog',
@PointInTime BIT = 0,
@WithMoveDataPath VARCHAR(3000) = NULL,
@WithMoveLogPath VARCHAR(3000) = NULL,
@Replace BIT = 0,
@NoRecovery BIT = 0
)
 
AS
 
BEGIN
 
DECLARE @WithMove VARCHAR(3000)
 
SET NOCOUNT ON
--Check that @RestoreOptions is a valid value
IF @RestoreOptions NOT IN ('ToLog','ToDiff','ToFull','LogsOnly')
RAISERROR (N'Invalid Restore Option specified, please use ToLog, ToDiff, ToFull or LogsOnly' , 15, 1)
 
--Check that both 'WithMove' parameters are either both null or both hold a value (why doens't SQL Server give us an XOR?)
IF ((@WithMoveDataPath IS NULL) AND (@WithMoveLogPath IS NOT NULL))
    OR
    ((@WithMoveDataPath IS NOT NULL) AND (@WithMoveLogPath IS NULL))
RAISERROR (N'The ''WithMove'' parameters either both must be NULL or both must hold a value', 15,1) 
 
--set compatibility mode
DECLARE @compatibility BIT
 
--set compatibility to 1 if server version includes STRING_SPLIT
SELECT  @compatibility = CASE
            WHEN SERVERPROPERTY ('productversion') >= '13.0.4001.0' AND Compatibility_Level >= 130 THEN 1
            ELSE 0
        END
FROM sys.databases
WHERE name = DB_NAME()
 
--drop temp tables
IF  OBJECT_ID('tempdb..#BackupCommands') IS NOT NULL
    DROP TABLE #BackupCommands
CREATE TABLE #BackupCommands
(backup_start_date DATETIME, DBName VARCHAR(255), command VARCHAR(1000))
 
IF OBJECT_ID('tempdb..#BackupCommandsFinal') IS NOT NULL
    DROP TABLE #BackupCommandsFinal
CREATE TABLE #BackupCommandsFinal
(backup_start_date DATETIME, DBName VARCHAR(255), command VARCHAR(1000))
 
--remove any spaces in list of databases
SET @DatabaseName = REPLACE(@DatabaseName, ' ','')
SET @RestoreAsName = REPLACE(@RestoreAsName, ' ','')
 
--@PointInTime can only be true if @RestoreOptions is either 'ToLog' or 'LogsOnly'
IF (@PointInTime = 1) AND (@RestoreOptions NOT IN ('ToLog','LogsOnly'))
BEGIN
RAISERROR (N'Point in time restore is not possible with selected restore options.  @PointInTime has been changed to 0', 15,1)
SET @PointInTime = 0
END
 
--If @RestoreOptions is 'LogsOnly', a RestoreToDate value must be specified
IF (@RestoreOptions = 'LogsOnly') AND (@FirstLogToRestore IS NULL)
RAISERROR (N'When @RestoreOptions = LogsOnly, a @FirstLogToRestore date must be specified', 15,1) 
 
--Set default value for @RestoreToDate if unspecified
IF (@RestoreToDate IS NULL)
SET @RestoreToDate = GETDATE()
 
--Set default value for @DatabaseName if unspecified
IF (@DatabaseName IS NULL)
SET @DatabaseName = DB_NAME()
 
--Declare cursor containing database names
--if compatibility mode = 1 then it's safe to use STRING_SPLIT, otherwise use fn_SplitString
IF (@Compatibility = 1)
BEGIN
    --raise an error if there's a mismatch in the number of databases in @DatabaseName and @RestoreAsName
    IF ((SELECT COUNT(*) FROM  STRING_SPLIT(@DatabaseName,','))
        != (SELECT COUNT(*) FROM  STRING_SPLIT(@RestoreAsName,',')))
        AND @RestoreAsName IS NOT NULL
    RAISERROR (N'There is a mismatch in the number of databases in @DatabaseName and @RestoreAsName', 15,1)
 
    DECLARE DatabaseCur CURSOR FOR
    SELECT SourceDatabase.value AS SourceDatabase,DestinationDatabase.value AS DestinationDatabase
    FROM
        (SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) RowNumber
        FROM STRING_SPLIT(@DatabaseName,',') ) SourceDatabase
        LEFT JOIN
        (SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) RowNumber
        FROM STRING_SPLIT(@RestoreAsName,',') ) DestinationDatabase
        ON SourceDatabase.RowNumber = DestinationDatabase.RowNumber
END
ELSE BEGIN
    --raise an error if there's a mismatch in the number of databases in @DatabaseName and @RestoreAsName
    IF ((SELECT COUNT(*) FROM  fn_SplitString(@DatabaseName,','))
        != (SELECT COUNT(*) FROM  fn_SplitString(@RestoreAsName,',')))
        AND @RestoreAsName IS NOT NULL
    RAISERROR (N'There is a mismatch in the number of databases in @DatabaseName and @RestoreAsName', 15,1)
 
    SELECT SourceDatabase.StringElement AS SourceDatabase,DestinationDatabase.StringElement AS DestinationDatabase
    FROM
        (SELECT StringElement, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) RowNumber
        FROM fn_SplitString(@DatabaseName,',') ) SourceDatabase
        LEFT JOIN
        (SELECT StringElement, ROW_NUMBER() OVER (ORDER BY (SELECT 1)) RowNumber
        FROM fn_SplitString(@RestoreAsName,',') ) DestinationDatabase
        ON SourceDatabase.RowNumber = DestinationDatabase.RowNumber
END
 
--open cursor
OPEN DatabaseCur
FETCH NEXT FROM DatabaseCur INTO @DatabaseName, @RestoreAsName
 
WHILE @@FETCH_STATUS = 0
BEGIN
 
    --Get last full backup for required timeframe
    IF (@RestoreOptions IN ('PointInTime','ToLog','ToDiff','ToFull'))
    BEGIN
        INSERT INTO #BackupCommands
        SELECT TOP 1 backupset.backup_start_date, @DatabaseName AS DBName,
                    'RESTORE DATABASE ' + COALESCE(QUOTENAME(@RestoreAsName), QUOTENAME(@DatabaseName)) + ' FROM DISK = ''' + mediafamily.physical_device_name + ''' WITH NORECOVERY, FILE = ' + CAST(position AS VARCHAR) AS Command
        FROM msdb.dbo.backupset backupset
        INNER JOIN msdb.dbo.backupmediafamily mediafamily ON backupset.media_set_id = mediafamily.media_set_id
        WHERE backupset.database_name = @DatabaseName
        AND backupset.backup_start_date < @RestoreToDate         AND backupset.type = 'D'        ORDER BY backupset.backup_start_date DESC   END     --if Replace is set, add to statement   IF @Replace = 1     BEGIN       UPDATE #BackupCommands      SET command = command + ', REPLACE'         WHERE DBName = @DatabaseName    END     --if WithMove parameters are set, create WITH MOVE statements   IF (@WithMoveDataPath IS NOT NULL) AND (@WithMoveLogPath IS NOT NULL)   BEGIN       --generate MOVE statement       DECLARE @WithMoveCmd VARCHAR(3000)      SET @WithMoveCmd = ','      SELECT @WithMoveCmd = @WithMoveCmd + STUFF((SELECT ',' + ' MOVE ''' + name + ''' TO ''' + REPLACE(physical_name,REVERSE(SUBSTRING(REVERSE(physical_name),CHARINDEX('\',REVERSE(physical_name),0), LEN(physical_name))),@WithMoveDataPath) + ''''        FROM sys.master_files       WHERE database_id = DB_ID(@DatabaseName)        AND type_desc = 'ROWS'      FOR XML PATH('')) ,1,1,'')      SET @WithMoveCmd = @WithMoveCmd + ','       SELECT @WithMoveCmd = @WithMoveCmd + STUFF((SELECT ',' +  'MOVE ''' + name + ''' TO ''' + REPLACE(physical_name,REVERSE(SUBSTRING(REVERSE(physical_name),CHARINDEX('\',REVERSE(physical_name),0), LEN(physical_name))),@WithMoveLogPath) + ''''         FROM sys.master_files       WHERE database_id = DB_ID(@DatabaseName)        AND type_desc = 'LOG'       FOR XML PATH('')) ,1,1,'')      --append MOVE statement to backup command       UPDATE #BackupCommands      SET command = command + @WithMoveCmd        WHERE DBName = @DatabaseName    END     --Get last diff for required timeframe  IF (@RestoreOptions IN ('PointInTime','ToLog','ToDiff'))    BEGIN       INSERT INTO #BackupCommands         SELECT TOP 1 backupset.backup_start_date, @DatabaseName AS DBName,              'RESTORE DATABASE ' + COALESCE(QUOTENAME(@RestoreAsName), QUOTENAME(@DatabaseName)) + ' FROM DISK = ''' + mediafamily.physical_device_name + ''' WITH NORECOVERY, FILE = ' + CAST(position AS VARCHAR)      FROM msdb.dbo.backupset backupset       INNER JOIN msdb.dbo.backupmediafamily mediafamily ON backupset.media_set_id = mediafamily.media_set_id      WHERE backupset.database_name = @DatabaseName       AND backupset.backup_start_date >
                    (SELECT backup_start_date FROM #BackupCommands)
        AND backupset.backup_start_date < @RestoreToDate         AND backupset.type = 'I'        ORDER BY backupset.backup_start_date DESC   END     --Get all log backups since last full or diff   IF (@RestoreOptions IN ('ToLog','LogsOnly'))    INSERT INTO #BackupCommands     SELECT backupset.backup_start_date, @DatabaseName AS DBName,            'RESTORE LOG ' + COALESCE(QUOTENAME(@RestoreAsName), QUOTENAME(@DatabaseName)) + ' FROM DISK = ''' + mediafamily.physical_device_name + ''' WITH NORECOVERY, FILE = ' + CAST(position AS VARCHAR)   FROM msdb.dbo.backupset backupset   INNER JOIN msdb.dbo.backupmediafamily mediafamily ON backupset.media_set_id = mediafamily.media_set_id  WHERE backupset.database_name = @DatabaseName   AND backupset.backup_start_date >
                (SELECT COALESCE(MAX(backup_start_date),@FirstLogToRestore) FROM #BackupCommands)
    AND backupset.backup_start_date < @RestoreToDate     AND backupset.type = 'L'    ORDER BY backupset.backup_start_date DESC   --Get point in time if enabled  IF (@PointInTime = 1) AND (EXISTS (SELECT * FROM #BackupCommands))  BEGIN       INSERT INTO #BackupCommands         SELECT TOP 1 backupset.backup_start_date, @DatabaseName AS DBName,              'RESTORE LOG ' + COALESCE(QUOTENAME(@RestoreAsName), QUOTENAME(@DatabaseName)) + ' FROM DISK = ''' + mediafamily.physical_device_name + ''' WITH NORECOVERY, FILE = ' + CAST(position AS VARCHAR) + ', STOPAT = ''' + CAST(@RestoreToDate AS VARCHAR) + '''' AS Command         FROM msdb.dbo.backupset backupset       INNER JOIN msdb.dbo.backupmediafamily mediafamily ON backupset.media_set_id = mediafamily.media_set_id      WHERE backupset.database_name = @DatabaseName       AND backupset.backup_start_date > @RestoreToDate
        AND backupset.type = 'L'
        ORDER BY backupset.backup_start_date
    END
 
    INSERT INTO #BackupCommandsFinal
    SELECT * FROM #BackupCommands
 
    TRUNCATE TABLE #BackupCommands
 
    FETCH NEXT FROM DatabaseCur INTO @DatabaseName, @RestoreAsName
END
 
CLOSE DatabaseCur
DEALLOCATE DatabaseCur
 
IF @NoRecovery = 0  --if restore with no recovery is off, remove NORECOVERY from the last restore command
BEGIN
    UPDATE #BackupCommandsFinal
    SET command = REPLACE(command,'NORECOVERY','RECOVERY')
    WHERE backup_start_date = (SELECT MAX(backup_start_date) FROM #BackupCommandsFinal)
END
 
SELECT backup_start_date, DBName, command
FROM #BackupCommandsFinal
ORDER BY DBName,backup_start_date
 
END
