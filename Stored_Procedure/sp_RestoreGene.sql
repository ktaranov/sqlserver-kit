USE [master] 
GO 
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_RestoreGene') 
EXEC ('CREATE PROC dbo.sp_RestoreGene AS SELECT 1') 
GO 
     
/*********************************************************************************************
Restore Generator v4.3 (2014-10-03)
(C) 2012, Paul Brewer
     
Feedback: paulbrewer@yahoo.co.uk
Updates: https://paulbrewer.wordpress.com/
     
This procedure queries msdb database backup history and database file details in master.
It builds and returns RESTORE DATABASE commands as it's result set, it does not execute the commands.
     
CHANGE LOG:
December 23, 2012   - V1.01 - Release
January 4,2013      - V1.02 - LSN Checks + Bug fix to STOPAT date format
January 11,2013     - V1.03 - SQL Server 2005 compatibility (backup compression problem) & @StandbyMode
January 14, 2013    - V1.04 - WITH COPY and up to 10 striped backup files
January 15, 2013    - V1.05 - Format of constructed restore script, enclose database name in [ ]
February 7, 2013    - V1.06 - Modified WHERE device_type IN (7,102,2)
May 26, 2013        - V1.07 - Various changes for PoSh Driver Script compatibility
October 14, 2013    - V1.08 - Rename parameters, more meaningful names
October 15, 2013    - V2.00 - Add 2nd CTE for striped backup files and remove repeating calls to CTE
November 5, 2013    - V2.01 - Secondary .ndf files only included if @WithMoveDataFiles NOT NULL
                            - Extended artificial LSN used for sequencing WITH RECOVERY/CHECKDB to 21 characters
                            - Include database name in results for logging in PoSh
May 23, 2014        - V3.0  - Improved logging and error handling, add 'LogShippingVariableDeclare' parameter
                                Default is Yes when called from query analysier, set to No when called by PoSh
May 30, 2014        - V3.1  - Restructured CTE, all predicates moved to the CTE
June 6, 2014        - V3.2  - Add 'LogShippingStartTime' parameter for PowerShell script.
                                To skip subsequent full and diff backups when restoring Logs in PoSh log shipping mode
                            - Add 'Target Restore Database Name' parameter, Manuj Bahl suggestion
                                If restoring a specific database, allows overriding restored name
                                Probably used in conjunction with a @WithMove override of data and log files to a different folder.
                            - Add LogShippingLastLSN parameter, used to filter results sent to ps_LogShippingLight
June 10, 2014       - V3.3  - Standardize Log Shipping Parameter Names & make &msg variable declare unique
June 27, 2014       - V3.31 - Diff restore bug fix
July 13, 2014       - V3.32 - Feedback from Tony Davis
                                Rename framework to memorable name 'RestoreGene'
                                Paramater for WITH REPLACE
August 5, 2014      - V3.4  - Remove TRY CATCH blocks from log restores and checkdb
                            - Remove CTE's,use #temp tables, suggested by S.Stresser
August 25, 2014     - V3.5  - goestock suggestion - Include device type 7 for AWS EC2 backups
August 29th, 2014   - V3.6  - Richard found and fixed a problem with variable declare where database name has a space or full stop.
July 28, 2015       - V3.7  - Luke Sarro, modifications for case sensitivity & parameter sniffing
August 28, 2015     - V3.8  - Luke Sarro modifications, recovery fork management. supports forking in recovery plans when constructing a restore script. 
                              Only tested where a single fork exists, IE a restore was done to a historic point in time, with recovery, then subsequent log backups are taken. 
                              When a fork exists the restore script will follow the new path for subsequent differential and log backups taken after the forking point.
                              If no rbackup forks exist, the procedure works as before.
September 02 2015   - V3.9  - SQLMongo modification to replace hyphens in database name        
September 04, 2015  - V4.0  - Domingo modification, check for default backup path = '' 
September 29, 2015  - V4.2  - Fixes bug identifying full backups taken after a recovery fork, has introduced code duplication to be removed later but fixes problem 
October 3, 2015     - V4.3  - Remove code duplication introduced in V4.2           
********************************************************************************************/ 
  
    
ALTER PROC dbo.sp_RestoreGene
(
    @Database SYSNAME = NULL,
    @TargetDatabase SYSNAME = NULL,
    @WithMoveDataFiles VARCHAR(2000) = NULL,
    @WithMoveLogFile  VARCHAR(2000) = NULL,
    @FromFileFullUNC VARCHAR(2000) = NULL,
    @FromFileDiffUNC VARCHAR(2000) = NULL,
    @FromFileLogUNC VARCHAR(2000) = NULL,
    @StopAt DATETIME = NULL,
    @StandbyMode BIT = 0,
    @IncludeSystemDBs BIT = 0,
    @WithRecovery BIT = 0,
    @WithCHECKDB BIT = 0,
    @WithReplace BIT = 0,
    @UseDefaultDatabaseBackupPath BIT = 0,
    @Log_Reference VARCHAR (250) = NULL,
    @LogShippingVariableDeclare BIT = 1,
    @LogShippingStartTime DATETIME = NULL,
    @LogShippingLastLSN VARCHAR(25) = NULL
)
AS
BEGIN
      
SET NOCOUNT ON; 
 
-- Avoid Parameter Sniffing Problems    
DECLARE @Database_ SYSNAME = @Database,
    @TargetDatabase_ SYSNAME = @TargetDatabase,
    @WithMoveDataFiles_ VARCHAR(2000) = @WithMoveDataFiles,
    @WithMoveLogFile_  VARCHAR(2000) = @WithMoveLogFile,
    @FromFileFullUNC_ VARCHAR(2000) = @FromFileFullUNC,
    @FromFileDiffUNC_ VARCHAR(2000) = @FromFileDiffUNC,
    @FromFileLogUNC_ VARCHAR(2000) = @FromFileLogUNC,
    @StopAt_ DATETIME = @StopAt,
    @StandbyMode_ BIT = @StandbyMode,
    @IncludeSystemDBs_ BIT = @IncludeSystemDBs,
    @WithRecovery_ BIT = @WithRecovery,
    @WithCHECKDB_ BIT = @WithCHECKDB,
    @WithReplace_ BIT = @WithReplace,
    @UseDefaultDatabaseBackupPath_ BIT = @UseDefaultDatabaseBackupPath,
    @Log_Reference_ VARCHAR (250) = @Log_Reference,
    @LogShippingVariableDeclare_ BIT = @LogShippingVariableDeclare,
    @LogShippingStartTime_ DATETIME = @LogShippingStartTime,
    @LogShippingLastLSN_ VARCHAR(25) = @LogShippingLastLSN
 
-- Defaults Recovery Point Times
IF ISNULL(@StopAt_,'') = ''
    SET @StopAt_ = GETDATE(); 
      
IF ISNULL(@LogShippingStartTime_,'') = ''
    SET @LogShippingStartTime_ = @StopAt_;
      
-- Default written to the SQL Server Error Log
IF ISNULL(@Log_Reference_,'') = ''
    SET @Log_Reference_ = 'sp_RestoreGene - Recovery in Progress';     
      
-- Allow override of restored database name only if working with a specific database
IF @TargetDatabase_ IS NOT NULL AND @Database_ IS NULL
    SET @TargetDatabase_ = NULL;
      
-- ps_LogShippingLight - Filtered Results
IF ISNULL(@LogShippingLastLSN_,'') = ''
    SET @LogShippingLastLSN_ = '-1';
 
-- Backup file locations defaulted to '' by ps_RestoreGene 
IF @FromFileFullUNC_ = ''
    SET @FromFileFullUNC_ = NULL;
 
IF @FromFileDiffUNC_ = ''
    SET @FromFileDiffUNC_ = NULL;
 
IF @FromFileLogUNC_ = ''
    SET @FromFileLogUNC_ = NULL;
 
-- Environment Preparation
IF OBJECT_ID('tempdb..#CTE') IS NOT NULL
    DROP TABLE #CTE;
 
IF OBJECT_ID('tempdb..#Stripes') IS NOT NULL
    DROP TABLE #Stripes;
 
-- Backup forking
IF OBJECT_ID('tempdb..#BackupFork') IS NOT NULL
    DROP TABLE #BackupFork;
 
SELECT rf1.database_name, MAX(database_backup_lsn) database_backup_lsn, MAX(fork_point_lsn) fork_point_lsn, MAX(last_lsn) last_lsn
INTO #BackupFork
FROM msdb.dbo.backupset rf1
INNER JOIN
(
    SELECT database_name, MAX(backup_finish_date) AS backup_finish_date
    FROM msdb.dbo.backupset
    WHERE backup_start_date <= @LogShippingStartTime_
    AND fork_point_lsn IS NULL
    GROUP BY database_name
) rf2
    ON rf1.database_name = rf2.database_name
 
WHERE fork_point_lsn IS NOT NULL
AND rf1.backup_start_date <= @LogShippingStartTime_
AND rf1.backup_finish_date > rf2.backup_finish_date
GROUP BY rf1.database_name;
 
CREATE INDEX IDX_BackupFork ON #BackupFork(database_name);
 
      
--------------------------------------------------------------
-- CTE1 Full Backup UNION Differential Backup UNION Log Backup
--------------------------------------------------------------
WITH CTE
(
     database_name
    ,current_compatibility_level
    ,last_lsn
    ,current_is_read_only
    ,current_state_desc
    ,current_recovery_model_desc
    ,has_backup_checksums
    ,backup_size
    ,[type]
    ,backupmediasetid
    ,family_sequence_number
    ,backupstartdate
    ,physical_device_name
    ,position
)
AS
( 
      
--------------------------------------------------------------
-- Full backup - Most current immediately before @LogShippingStartTime_
SELECT
    bs.database_name
    ,d.[compatibility_level] AS current_compatibility_level
    ,bs.last_lsn
    ,d.[is_read_only] AS current_is_read_only
    ,d.[state_desc] AS current_state_desc
    ,d.[recovery_model_desc] current_recovery_model_desc
    ,bs.has_backup_checksums
    ,bs.backup_size AS backup_size
    ,'D' AS [type]
    ,bs.media_set_id AS backupmediasetid
    ,mf.family_sequence_number
    ,x.backup_start_date AS backupstartdate
    ,mf.physical_device_name
    ,bs.position
FROM msdb.dbo.backupset bs 
      
INNER JOIN sys.databases d
    ON bs.database_name = d.name
      
INNER JOIN
(
    SELECT
        a.database_name
        ,MAX(a.backup_start_date) backup_start_date
    FROM msdb.dbo.backupset a
    JOIN msdb.dbo.backupmediafamily b
        ON a.media_set_id = b.media_set_id
 
    LEFT OUTER JOIN #BackupFork c
        ON c.database_name = a.database_name
 
    WHERE a.[type] = 'D'
    AND device_type IN (7,102,2)
    AND a.is_copy_only = 0
    AND a.backup_start_date <= @LogShippingStartTime_
 
    -- Recovery Forking
    AND ISNULL(c.fork_point_lsn,a.database_backup_lsn) >= a.database_backup_lsn
    AND ((c.fork_point_lsn IS NOT NULL AND a.database_backup_lsn < c.database_backup_lsn) OR c.fork_point_lsn IS NULL) 
 
    GROUP BY a.database_name
 
) x
    ON x.database_name = bs.database_name
    AND x.backup_start_date = bs.backup_start_date 
      
JOIN msdb.dbo.backupmediafamily mf
    ON mf.media_set_id = bs.media_set_id
    AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number      
      
WHERE bs.type = 'D'
AND mf.physical_device_name NOT IN ('Nul', 'Nul:') 
      
UNION
      
--------------------------------------------------------------
-- Differential backup, most current immediately before @StopAt_
SELECT
    bs.database_name
    ,d.[compatibility_level] AS current_compatibility_level
    ,bs.last_lsn
    ,d.[is_read_only] AS current_is_read_only
    ,d.[state_desc] AS current_state_desc
    ,d.[recovery_model_desc] current_recovery_model_desc
    ,bs.has_backup_checksums
    ,bs.backup_size AS backup_size
    ,'I' AS [type]
    ,bs.media_set_id AS backupmediasetid
    ,mf.family_sequence_number
    ,x.backup_start_date AS backupstartdate
    ,mf.physical_device_name
    ,bs.position
FROM msdb.dbo.backupset bs 
      
INNER JOIN sys.databases d
    ON bs.database_name = d.name
      
     
INNER JOIN  -- Last Full in recovery fork before STOPAT
(
--------------------------------------------
    SELECT
        a.database_name
        ,MAX(a.backup_start_date) backup_start_date
    FROM msdb.dbo.backupset a
    JOIN msdb.dbo.backupmediafamily b
        ON a.media_set_id = b.media_set_id
 
    LEFT OUTER JOIN #BackupFork c
        ON c.database_name = a.database_name
 
    WHERE a.[type] = 'D'
    AND device_type IN (7,102,2)
    AND a.is_copy_only = 0
    AND a.backup_start_date <= @LogShippingStartTime_
 
    -- Recovery Forking
    AND ISNULL(c.fork_point_lsn,a.database_backup_lsn) >= a.database_backup_lsn
    AND ((c.fork_point_lsn IS NOT NULL AND a.database_backup_lsn < c.database_backup_lsn) OR c.fork_point_lsn IS NULL) 
 
    GROUP BY a.database_name
--------------------------------------------
) y
    ON y.database_name = bs.database_name 
 
INNER JOIN -- Last Diff before STOPAT
(
    SELECT
        a.database_name
        ,MAX(backup_start_date) backup_start_date
    FROM msdb.dbo.backupset a
    JOIN msdb.dbo.backupmediafamily b
        ON a.media_set_id = b.media_set_id
 
    LEFT OUTER JOIN #BackupFork c
        ON c.database_name = a.database_name
 
    WHERE a.[type] = 'I'
    AND device_type IN (7,102,2)
    AND a.is_copy_only = 0
    AND a.backup_start_date <= ISNULL(@StopAt_,GETDATE())
    AND a.database_backup_lsn = ISNULL(c.database_backup_lsn,a.database_backup_lsn )
    AND a.last_lsn <= ISNULL(c.fork_point_lsn, a.last_lsn)
    GROUP BY a.database_name
 
) x
    ON x.database_name = bs.database_name
    AND x.backup_start_date = bs.backup_start_date 
 
 
INNER JOIN msdb.dbo.backupmediafamily mf
    ON mf.media_set_id = bs.media_set_id
    AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number 
      
WHERE bs.type = 'I'
AND mf.physical_device_name NOT IN ('Nul', 'Nul:')
AND x.backup_start_date > y.backup_start_date
AND @StopAt_ = @LogShippingStartTime_
      
UNION
      
--------------------------------------------------------------
-- Log file backups - after 1st full / before @StopAt_
SELECT
    bs.database_name
    ,d.[compatibility_level] AS current_compatibility_level
    ,bs.last_lsn
    ,d.[is_read_only] AS current_is_read_only
    ,d.[state_desc] AS current_state_desc
    ,d.[recovery_model_desc] current_recovery_model_desc
    ,bs.has_backup_checksums
    ,bs.backup_size AS backup_size
    ,'L' AS [type]
    ,bs.media_set_id AS backupmediasetid
    ,mf.family_sequence_number
    ,bs.backup_start_date as backupstartdate
    ,mf.physical_device_name
    ,bs.position
      
FROM msdb.dbo.backupset bs 
      
INNER JOIN sys.databases d
    ON bs.database_name = d.name
      
INNER JOIN msdb.dbo.backupmediafamily mf
    ON mf.media_set_id = bs.media_set_id
    AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number 
 
INNER JOIN -- After the selected full backup
(
    SELECT
        a.database_name
        ,MAX(a.backup_start_date) backup_start_date
    FROM msdb.dbo.backupset a
    JOIN msdb.dbo.backupmediafamily b
        ON a.media_set_id = b.media_set_id
 
    LEFT OUTER JOIN #BackupFork c
        ON c.database_name = a.database_name
 
    WHERE a.[type] = 'D'
    AND device_type IN (7,102,2)
    AND a.is_copy_only = 0
    AND a.backup_start_date <= @LogShippingStartTime_
 
    -- Recovery Forking
    AND ISNULL(c.fork_point_lsn,a.database_backup_lsn) >= a.database_backup_lsn
    AND ((c.fork_point_lsn IS NOT NULL AND a.database_backup_lsn < c.database_backup_lsn) OR c.fork_point_lsn IS NULL) 
 
    GROUP BY a.database_name
) y
    ON bs.database_name = y.database_name 
 
LEFT OUTER JOIN #BackupFork r
    ON r.database_name = bs.database_name
 
LEFT OUTER JOIN -- Select the first log file after STOPAT
(
    SELECT DISTINCT x.database_name, database_backup_lsn, 
    CASE WHEN y.last_Log_After_StopAt IS NULL THEN CONVERT(datetime, '31 Dec 2050') ELSE y.last_Log_After_StopAt END AS last_Log_After_StopAt
    FROM msdb.dbo.backupset x
    LEFT JOIN
    (
        SELECT
            database_name
            ,MIN(backup_start_date) last_Log_After_StopAt
        FROM msdb.dbo.backupset a
        JOIN msdb.dbo.backupmediafamily b
        ON a.media_set_id = b.media_set_id
        WHERE a.[type] = 'L'
        AND device_type IN (7,102,2)
        AND a.backup_start_date > ISNULL(@StopAt_,'1 Jan, 1900')
        GROUP BY database_name
    ) y
    ON x.database_name = y.database_name
) x
    ON bs.database_name = x.database_name
    AND bs.database_backup_lsn = ISNULL(r.database_backup_lsn,bs.database_backup_lsn)
 
WHERE bs.backup_start_date <= x.last_Log_After_StopAt -- Include 1st log after stop at
AND bs.backup_start_date >= y.backup_start_date -- After last full backup start date
AND bs.database_backup_lsn = ISNULL(r.database_backup_lsn,bs.database_backup_lsn) -- Recovery Fork
AND NOT (bs.first_lsn < ISNULL(r.fork_point_lsn,'99999999999999999') AND bs.last_lsn > ISNULL(r.fork_point_lsn,'00000000000000000') AND bs.last_lsn <> ISNULL(r.last_lsn,bs.last_lsn))
 
 
AND mf.physical_device_name NOT IN ('Nul', 'Nul:')
AND bs.type = 'L'
AND device_type IN (7,102,2)
)
      
SELECT * INTO #CTE FROM CTE; 
CREATE INDEX IDX_CTE ON #CTE(database_name);
      
--------------------------------------------------------------
-- CTE2 Optionally, striped backup file details
--------------------------------------------------------------
WITH Stripes
(
    database_name,
    backupmediasetid,
    family_sequence_number,
    last_lsn,
    S2_pdn,
    S3_pdn,
    S4_pdn,
    S5_pdn,
    S6_pdn,
    S7_pdn,
    S8_pdn,
    S9_pdn,
    S10_pdn
)
AS
(
SELECT
    Stripe1.database_name,
    Stripe1.backupmediasetid,
    Stripe1.family_sequence_number,
    Stripe1.last_lsn,
    Stripe2.physical_device_name AS S2_pdn,
    Stripe3.physical_device_name AS S3_pdn,
    Stripe4.physical_device_name AS S4_pdn,
    Stripe5.physical_device_name AS S5_pdn,
    Stripe6.physical_device_name AS S6_pdn,
    Stripe7.physical_device_name AS S7_pdn,
    Stripe8.physical_device_name AS S8_pdn,
    Stripe9.physical_device_name AS S9_pdn,
    Stripe10.physical_device_name  AS S10_pdn
FROM #CTE AS Stripe1 
      
LEFT OUTER JOIN #CTE AS Stripe2
    ON Stripe2.database_name = Stripe1.database_name
    AND Stripe2.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe2.family_sequence_number = 2 
      
LEFT OUTER JOIN #CTE AS Stripe3
    ON Stripe3.database_name = Stripe1.database_name
    AND Stripe3.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe3.family_sequence_number = 3 
      
LEFT OUTER JOIN #CTE AS Stripe4
    ON Stripe4.database_name = Stripe1.database_name
    AND Stripe4.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe4.family_sequence_number = 4 
      
LEFT OUTER JOIN #CTE AS Stripe5
    ON Stripe5.database_name = Stripe1.database_name
    AND Stripe5.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe5.family_sequence_number = 5 
      
LEFT OUTER JOIN #CTE AS Stripe6
    ON Stripe6.database_name = Stripe1.database_name
    AND Stripe6.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe6.family_sequence_number = 6 
      
LEFT OUTER JOIN #CTE AS Stripe7
    ON Stripe7.database_name = Stripe1.database_name
    AND Stripe7.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe7.family_sequence_number = 7 
      
LEFT OUTER JOIN #CTE AS Stripe8
    ON Stripe8.database_name = Stripe1.database_name
    AND Stripe8.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe8.family_sequence_number = 8 
      
LEFT OUTER JOIN #CTE AS Stripe9
    ON Stripe9.database_name = Stripe1.database_name
    AND Stripe9.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe9.family_sequence_number = 9 
      
LEFT OUTER JOIN #CTE AS Stripe10
    ON Stripe10.database_name = Stripe1.database_name
    AND Stripe10.backupmediasetid = Stripe1.backupmediasetid
    AND Stripe10.family_sequence_number = 10
) 
      
SELECT * INTO #Stripes FROM Stripes;  
 
CREATE INDEX IDX_Stripes ON #Stripes(database_name);
      
--------------------------------------------------------------
-- Results, T-SQL RESTORE commands, below are based on CTE's above
-------------------------------------------------------------- 
      
SELECT
    a.Command AS TSQL,
    CONVERT(nvarchar(30), a.backupstartdate, 126)
    AS BackupDate,
    a.BackupDevice,
    a.last_lsn,
    a.database_name ,
    --ROW_NUMBER() OVER(ORDER BY database_name, Sequence, last_lsn) AS SortSequence
    ROW_NUMBER() OVER(ORDER BY database_name, Sequence, a.backupstartdate) AS SortSequence
FROM
( 
      
--------------------------------------------------------------
-- Most recent full backup
-------------------------------------------------------------- 
      
SELECT
     ';RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) +
    'FROM DISK = N' + '''' +
    CASE ISNULL(@FromFileFullUNC_,'Actual')
    WHEN 'Actual' THEN #CTE.physical_device_name
    ELSE @FromFileFullUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
    END + '''' + SPACE(1) + 
      
    -- Striped backup files
    CASE ISNULL(#Stripes.S2_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S3_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S4_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S5_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S6_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S7_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S8_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S9_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S10_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
    END + 
      
    ' WITH ' + CASE ISNULL(@WithReplace_,0) WHEN 1 THEN 'REPLACE, ' ELSE '' END   + 'FILE = ' + CAST(#CTE.position AS VARCHAR(5)) + ',' +
    CASE #CTE.has_backup_checksums WHEN 1 THEN 'CHECKSUM, ' ELSE ' ' END + 
      
    CASE @StandbyMode_ WHEN 0 THEN 'NORECOVERY,' ELSE 'STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_ROLLBACK_UNDO.bak ' + '''' + ',' END + SPACE(1) + 
      
    'STATS=10,' + SPACE(1) +
    'MOVE N' + '''' + x.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveDataFiles_,'Actual')
    WHEN 'Actual' THEN x.PhysicalName
    ELSE @WithMoveDataFiles_ + SUBSTRING(x.PhysicalName,LEN(x.PhysicalName) - CHARINDEX('\',REVERSE(x.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(x.PhysicalName),1) + 1)
    END + '''' + ',' + SPACE(1) + 
      
    'MOVE N' + '''' + y.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveLogFile_ ,'Actual')
    WHEN 'Actual' THEN y.PhysicalName
    ELSE @WithMoveLogFile_  + SUBSTRING(y.PhysicalName,LEN(y.PhysicalName) - CHARINDEX('\',REVERSE(y.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(y.PhysicalName),1) + 1)
    END + '''' AS Command,
    1 AS Sequence,
    d.name AS database_name,
    #CTE.physical_device_name AS BackupDevice,
    #CTE.backupstartdate,
    #CTE.backup_size,
    #CTE.last_lsn 
      
FROM sys.databases d 
      
JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name
        ,mf.Physical_Name AS PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'ROWS'
    AND mf.file_id = 1
) x
    ON d.name = x.name 
      
JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name, type_desc
        ,mf.Physical_Name PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'LOG'
) y
    ON d.name = y.name 
      
LEFT OUTER JOIN #CTE
    ON #CTE.database_name = d.name
    AND #CTE.family_sequence_number = 1 
      
JOIN #Stripes
    ON #Stripes.database_name = d.name
    AND #Stripes.backupmediasetid = #CTE.backupmediasetid
    AND #Stripes.last_lsn = #CTE.last_lsn 
      
WHERE #CTE.[type] = 'D'
AND #CTE.family_sequence_number = 1 
      
--------------------------------------------------------------
-- Most recent differential backup
--------------------------------------------------------------
UNION 
      
SELECT
    ';RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) +
    'FROM DISK = N' + '''' +
    CASE ISNULL(@FromFileDiffUNC_,'Actual')
    WHEN 'Actual' THEN #CTE.physical_device_name
    ELSE @FromFileDiffUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
    END + '''' + SPACE(1) + 
      
    -- Striped backup files
    CASE ISNULL(#Stripes.S2_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S3_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S4_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S5_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S6_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S7_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S8_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S9_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S10_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
    END + 
      
    ' WITH FILE = ' + CAST(#CTE.position AS VARCHAR(5)) + ',' +
    CASE #CTE.has_backup_checksums WHEN 1 THEN 'CHECKSUM, ' ELSE ' ' END + 
      
    CASE @StandbyMode_ WHEN 0 THEN 'NORECOVERY,' ELSE 'STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_ROLLBACK_UNDO.bak ' + ''''  + ',' END + SPACE(1) + 
      
    'STATS=10,' + SPACE(1) +
    'MOVE N' + '''' + x.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveDataFiles_,'Actual')
    WHEN 'Actual' THEN x.PhysicalName
    ELSE @WithMoveDataFiles_ + SUBSTRING(x.PhysicalName,LEN(x.PhysicalName) - CHARINDEX('\',REVERSE(x.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(x.PhysicalName),1) + 1)
    END + '''' + ',' + SPACE(1) + 
      
    'MOVE N' + '''' + y.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveLogFile_ ,'Actual')
    WHEN 'Actual' THEN y.PhysicalName
    ELSE @WithMoveLogFile_  + SUBSTRING(y.PhysicalName,LEN(y.PhysicalName) - CHARINDEX('\',REVERSE(y.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(y.PhysicalName),1) + 1)
    END + '''' AS Command,
    32769/2 AS Sequence,
    d.name AS database_name,
    #CTE.physical_device_name AS BackupDevice,
    #CTE.backupstartdate,
    #CTE.backup_size,
    #CTE.last_lsn 
      
FROM sys.databases d 
      
JOIN #CTE
ON #CTE.database_name = d.name
AND #CTE.family_sequence_number = 1 
      
LEFT OUTER JOIN #Stripes
ON #Stripes.database_name = d.name
AND #Stripes.backupmediasetid = #CTE.backupmediasetid
AND #Stripes.last_lsn = #CTE.last_lsn 
      
INNER JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name
        ,mf.Physical_Name AS PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'ROWS'
    AND mf.file_id = 1
) x
    ON d.name = x.name 
      
JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name, type_desc
        ,mf.Physical_Name PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'LOG'
) y
    ON d.name = y.name 
      
WHERE #CTE.[type] = 'I'
AND #CTE.family_sequence_number = 1 
      
--------------------------------------------------------------
UNION -- Log backups taken since most recent full or diff
-------------------------------------------------------------- 
      
SELECT
    ';BEGIN TRY RESTORE LOG [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) +
    'FROM DISK = N' + '''' + --#CTE.physical_device_name + '''' + SPACE(1) +
    CASE ISNULL(@FromFileLogUNC_,'Actual')
    WHEN 'Actual' THEN #CTE.physical_device_name
    ELSE @FromFileLogUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
    END + '''' + 
      
    -- Striped backup files
    CASE ISNULL(#Stripes.S2_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S3_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S4_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S5_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S6_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S7_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S8_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S9_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
    END + 
      
    CASE ISNULL(#Stripes.S10_pdn,'')
    WHEN '' THEN ''
    ELSE  ', DISK = N' + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
    END + 
      
    CASE @StandbyMode_ WHEN 0 THEN ' WITH NORECOVERY,' ELSE ' WITH STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_ROLLBACK_UNDO.bak ' + ''''  + ',' END + SPACE(1) + 
      
    CASE #CTE.has_backup_checksums WHEN 1 THEN ' CHECKSUM, ' ELSE ' ' END + 
      
    + 'FILE = ' + CAST(#CTE.position AS VARCHAR(5)) +
    ' ,STOPAT = ' + '''' + CONVERT(VARCHAR(21),@StopAt_,120) + '''' +
    ' ,MOVE N' + '''' + x2.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveDataFiles_,'Actual')
    WHEN 'Actual' THEN x2.PhysicalName
    ELSE @WithMoveDataFiles_ + SUBSTRING(x2.PhysicalName,LEN(x2.PhysicalName) - CHARINDEX('\',REVERSE(x2.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(x2.PhysicalName),1) + 1)
    END + '''' + ',' + SPACE(1) + 
      
    ' MOVE N' + '''' + y1.LogicalName + '''' + ' TO ' +
    '''' +
    CASE ISNULL(@WithMoveLogFile_ ,'Actual')
    WHEN 'Actual' THEN y1.PhysicalName
    ELSE @WithMoveLogFile_  + SUBSTRING(y1.PhysicalName,LEN(y1.PhysicalName) - CHARINDEX('\',REVERSE(y1.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(y1.PhysicalName),1) + 1)
    END + '''' +  'END TRY BEGIN CATCH PRINT ' +  '''' + 'Transaction Log File Restore Exclusion - Check Recovery Sequence.' + '''' + ' END CATCH;' AS Command,
    32769 AS Sequence,
    d.name AS database_name,
    #CTE.physical_device_name AS BackupDevice,
    #CTE.backupstartdate,
    #CTE.backup_size,
    #CTE.last_lsn 
      
FROM sys.databases d 
      
INNER JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name
        ,mf.Physical_Name AS PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'ROWS'
    AND mf.file_id = 1
) x2
ON d.name = x2.name 
      
INNER JOIN
(
    SELECT
        DB_NAME(mf.database_id) AS name, type_desc
        ,mf.Physical_Name PhysicalName
        ,mf.Name AS LogicalName
    FROM sys.master_files mf
    WHERE type_desc = 'LOG'
) y1
    ON d.name = y1.name 
      
INNER JOIN #CTE
    ON #CTE.database_name = d.name
    AND #CTE.family_sequence_number = 1 
      
LEFT OUTER JOIN #Stripes
    ON #Stripes.database_name = d.name
    AND #Stripes.backupmediasetid = #CTE.backupmediasetid
    AND #Stripes.last_lsn = #CTE.last_lsn 
 
LEFT OUTER JOIN
(
    SELECT database_name, MAX(last_lsn) last_lsn
    FROM #CTE
    WHERE [type] = 'I'
    GROUP BY database_name
) after_diff
    ON after_diff.database_name = #CTE.database_name
     
      
WHERE #CTE.[type] = 'L'
AND #CTE.family_sequence_number = 1 
AND #CTE.last_lsn > ISNULL(after_diff.last_lsn,'0')
      
--------------------------------------------------------------
UNION -- Declare @msg_ variable
--------------------------------------------------------------
SELECT
--   '; DECLARE @msg_' + d.name + ' VARCHAR(1000)' AS Command,
   ';DECLARE @msg_' + REPLACE(REPLACE(REPLACE(d.name,' ','_'),'.','_'),'-','_') + ' VARCHAR(1000)' AS Command,
    0 AS Sequence,
    d.name AS database_name,
    '' AS BackupDevice,
    GETDATE() AS backupstartdate,
    #CTE.backup_size,
    '0' AS last_lsn 
      
FROM sys.databases d 
      
JOIN #CTE
ON #CTE.database_name = d.name 
      
WHERE #CTE.[type] = 'D'
AND @LogShippingVariableDeclare_ = 1 
      
--------------------------------------------------------------
UNION -- Restore WITH RECOVERY
--------------------------------------------------------------
SELECT
   ';SET @msg_' + REPLACE(REPLACE(REPLACE(d.name,' ','_'),'.','_'),'-','_') + ' = ' + '''' + @Log_Reference_  + '''' + ';  RAISERROR (@msg_' + REPLACE(REPLACE(REPLACE(d.name,' ','_'),'.','_'),'-','_') + ',0,0) WITH LOG' + ';RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) + 'WITH RECOVERY' AS Command,
    32771 AS Sequence,
    d.name AS database_name,
    '' AS BackupDevice,
    GETDATE() AS backupstartdate,
    #CTE.backup_size,
    '999999999999999999998' AS last_lsn 
      
FROM sys.databases d 
      
JOIN #CTE
ON #CTE.database_name = d.name 
      
WHERE #CTE.[type] = 'D'
AND @WithRecovery_ = 1 
      
--------------------------------------------------------------
UNION -- CHECKDB
--------------------------------------------------------------
SELECT
    ';SET @msg_' + REPLACE(REPLACE(REPLACE(d.name,' ','_'),'.','_'),'-','_') + ' = ' + '''' + @Log_Reference_  + '''' + ';  RAISERROR (@msg_' + REPLACE(REPLACE(REPLACE(d.name,' ','_'),'.','_'),'-','_') + ',0,0) WITH LOG' + ';DBCC CHECKDB(' + '''' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + '''' + ') WITH NO_INFOMSGS, ALL_ERRORMSGS' AS Command,
    32772 AS Sequence,
    d.name AS database_name,
    '' AS BackupDevice,
    DATEADD(minute,1,GETDATE()) AS backupstartdate,
    #CTE.backup_size,
    '999999999999999999999' AS last_lsn 
      
FROM sys.databases d 
      
JOIN #CTE
ON #CTE.database_name = d.name 
      
WHERE #CTE.[type] = 'D'
AND @WithCHECKDB_ = 1
AND @WithRecovery_ = 1 
      
--------------------------------------------------------------
UNION -- WITH MOVE secondary data files, allows for up to 32769/2 file groups
--------------------------------------------------------------
SELECT
    ', MOVE N' + '''' + b.name + '''' + ' TO N' + '''' +
    CASE ISNULL(@WithMoveDataFiles_,'Actual')
    WHEN 'Actual' THEN b.physical_name
    ELSE @WithMoveDataFiles_ + SUBSTRING(b.Physical_Name,LEN(b.Physical_Name) - CHARINDEX('\',REVERSE(b.Physical_Name),1) + 2,CHARINDEX('\',REVERSE(b.Physical_Name),1) + 1)
    END + '''',
    b.file_id AS Sequence,
    DB_NAME(b.database_id) AS database_name,
    'SECONDARY FULL' AS BackupDevice,
    #CTE.backupstartdate,
    #CTE.backup_size,
    #CTE.last_lsn 
      
FROM sys.master_files b
INNER JOIN #CTE
ON #CTE.database_name = DB_NAME(b.database_id) 
      
WHERE #CTE.[type] = 'D'
AND b.type_desc = 'ROWS'
AND b.file_id > 2
AND @WithMoveDataFiles_ IS NOT NULL
--------------------------------------------------------------
) a
-------------------------------------------------------------- 
      
WHERE a.database_name = ISNULL(@Database_,a.database_name)
AND (@IncludeSystemDBs_ = 1 OR a.database_name NOT IN('master','model','msdb'))
AND a.last_lsn > @LogShippingLastLSN_
      
ORDER BY
    database_name,
    Sequence,
    --last_lsn  
    backupstartdate
      
END;
GO
