USE [master] 
GO 
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_RestoreGene') 
EXEC ('CREATE PROC dbo.sp_RestoreGene AS SELECT ''stub version, to be replaced''') 
GO 
                           
/*********************************************************************************************
Restore Generator v8.3 (2022-04-11)
(C) 2012, Paul Brewer
                          
Feedback: paulbrewer@yahoo.co.uk
User Guide: https://restoregene.com
                     
This procedure queries msdb database backup history and database file details in master.
It builds and returns RESTORE DATABASE commands as its result set, it does not execute the commands.
   
----------------------------------------------------------------------------------------------
PARAMETERS:
   
@Database                   - Default NULL, Restore a specific database or a list of comma seperated database names, NULL which restores all user databases.
@TargetDatabase             - Defaults to NULL, override restored database name, only possible if restoring one specific database, if supplied will rename database files and log file too.
@WithMoveDataFiles          - Defaults to the actual data file paths, overrides WITH MOVE for data file folder
@WithMoveLogFile            - Defaults to the actual log file path, overrides WITH MOVE for log file folder
@WithMoveFileStreamFile     - Defaults to the actual file stream file path, overrides WITH MOVE for file stream file folder
@FromFileFullUNC            - Defaults to actual backup file drive and folder, UNC path to full backup file
@FromFileDiffUNC            - Defaults to actual drive and folder, UNC path to differential backup file
@FromFileLogUNC             - Defaults to actual drive and folder, UNC path to log backup files
@StopAt                     - Defaults to current (datetime2), Stop At a specific date time
@StandbyMode                - Defaults to 0, Leave database in standby mode
@IncludeSystemDBs           - Defaults to 0, include master, model and msdb database restores
@WithRecovery               - Defaults to 0, Recover database(s) after restore
@WithCHECKDB                - Defaults to 0, Include a CHECKDB after recovery
@WithReplace                - Defaults to 0, replace existing database when no tail log backup exists
@LogShippingStartTime       - Only used by ps_RestoreGene
@LogShippingLastLSN         - Only used by ps_RestoreGene
@BlobCredential             - Defaults to NULL, SQL Credential for Azure Blog Storage Account
@RestoreScriptReplaceThis   - Defaults to NULL, Restore Script String Find
@RestoreScriptWithThis      - Defaults to NULL, Restore Script String Replace
@SuppressWithMove           - Default 1, Exclude WITH MOVE statements from the Restore Script
@PivotWithMove              - Default 0, If SuppressWithMove = 0, pivot secondary files to new rows in the result set
@RestoreScriptOnly          - Default 0, Return just the RESTORE DATABASE commands
@DropDatabaseAfterRestore   - Default 0, Drops the database after the restore, use with check db
@SetSingleUser              - Default 0, Adds ALTER DATABASE @database SET SINGLE_USER WITH ROLLBACK IMMEDIATE
@ExcludeDiffAndLogBackups   - Default 0, 0=full+diff+ log, 1=full only, 2-full+diff, 3=full+log, 4=diff+log
@IncludeDeviceType7         - Defaults to 1, Include device type 7 backups in restore script
@IncludeDeviceType102       - Defaults to 1, Include device type 102 backups in restore script
@IncludeDeviceType2         - Defaults to 1, Include device type 2 backups in restore script
@IncludeDeviceType9         - Defaults to 1, Include device type 9 backups in restore script
   
----------------------------------------------------------------------------------------------
CHANGE LOG:
   
December 23, 2012   - V1.01 - Release
January 4, 2013     - V1.02 - LSN Checks + Bug fix to STOPAT date format
January 11, 2013    - V1.03 - SQL Server 2005 compatibility (backup compression problem) & @StandbyMode
January 14, 2013    - V1.04 - WITH COPY and up to 10 striped backup files
January 15, 2013    - V1.05 - Format of constructed restore script, enclose database name in [ ]
February 7, 2013    - V1.06 - Modified WHERE device_type IN (7,102,2,9)
May 26, 2013        - V1.07 - Various changes for PoSh Driver Script compatibility
October 14, 2013    - V1.08 - Rename parameters, more meaningful names
October 15, 2013    - V2.00 - Add 2nd CTE for striped backup files and remove repeating calls to CTE
November 5, 2013    - V2.01 - Secondary .ndf files only included if @WithMoveDataFiles NOT NULL
                            - Extended artificial LSN used for sequencing WITH RECOVERY/CHECKDB to 21 characters
                            - Include database name in results for logging in PoSh
May 23, 2014        - V3.0  - Improved logging and error handling, add 'LogShippingVariableDeclare' parameter
                                Default is Yes when called from query analyser, set to No when called by PoSh
May 30, 2014        - V3.1  - Restructured CTE, all predicates moved to the CTE
June 6, 2014        - V3.2  - Add 'LogShippingStartTime' parameter for PowerShell script.
                                To skip subsequent full and diff backups when restoring Logs in PoSh log shipping mode
                            - Add 'Target Restore Database Name' parameter
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
July 28, 2015       - V3.7  - Luke Sarro, modifications for case sensitivity & parameter sniffing, a massive amount of work done.
August 28, 2015     - V3.8  - Luke Sarro modifications, recovery fork management. supports forking in recovery plans when constructing a restore script. 
                              Only tested where a single fork exists, IE a restore was done to a historic point in time, with recovery, then subsequent log backups are taken. 
                              When a fork exists the restore script will follow the new path for subsequent differential and log backups taken after the forking point.
                              If no rbackup forks exist, the procedure works as before.
September 02 2015   - V3.9  - SQLMongo modification to replace hyphens in database name
September 04, 2015  - V4.0  - Domingo modification, check for default backup path = ''
September 29, 2015  - V4.2  - Fixes bug identifying full backups taken after a recovery fork, has introduced code duplication to be removed later but fixes problem 
October 3, 2015     - V4.3  - Remove code duplication introduced in V4.2      
*
June 3rd, 2016      - V5.0  - Feedback from Brent Ozar related viewing spike:
                    - V5.0  - Reintroduce SQL Server 2005 compatibility - Bob McLaren - Declaring and assigning variables on same line doesn't work with SQL Server 2005.
                    - V5.0  - Override data and log file paths if overriding restored database name
                     
June 11th, 2016     - V5.1  - Azure http url restore support, mick@sqlfairy.com
                    - V5.1  - Restore Script find and replacement variables, mick@sqlfairy.com
                   
June 17th, 2016     - V5.2 - Removed TRY CATCH block in log restore commands
June 26th, 2016     - V5.3 - Include FILESTREAM files in WITH MOVE, jgkiran
July 3rd, 2016      - V5.4 - New parameter for FILESTREAM files, for WITH MOVE parameter, jgkiran
July 14rd, 2016     - V5.5 - Rename rollback files when standby = 1 to allow multiple concurrent ps_RestoreGene invocations, jgkiran
            
August 8th, 2016    - V5.6 - Accepts a comma separated variable list of databases to restore, suggested Stephen T 
                            - Got permission to reuse the 'SELECT DATABASES' code snippet from ola hallengren - https://ola.hallengren.com/
August 8th, 2016    - V5.7 - Make restore to new database, secondary file names, more meaningful 
August 9th, 2016    - V5.8 - Include the WITH MOVE statements on the same results line as the corresponding RESTORE DATABASE statement, flatten the result set to simplify the PoSh driver 
August 9th, 2016    - V5.9 - New Parameter, suppress WITH MOVE statements is default, parameter allows override to include them in the script. 
         
August 13th, 2016    - V6.0
                            - Add parameter option to pivot WITH MOVE secondary files to a new result set line. Not compatible with PoSh driver, useful with large, complex databases. 
                            - Add a parameter option to include just the restore script in the result set. Not compatible with PoSh driver, useful as SQL Agent Job step output.
        
August 14th, 2016    - V6.1 - Remove parameter @UseDefaultDatabaseBackupPath , no longer used  
August 15th, 2016    - V6.2 - @TargetDatabase parameter, file rename tidy  
August 17th, 2016    - V6.3 - Edge case fix to fork point LSN
August 19th, 2016    - V6.4 - Publish SQL Server Central
September 4th, 2016  - V6.41 - PoSh Driver Last LSN minor fix. - Published SQL Server Central
September 9th, 2016  - V6.42 - Fix for multiple log files with move, J.Peablles 
September 9th, 2016  - V6.43 - Fix for mirrored backups, C.Richardson
September 9th, 2016  - V6.44 - Mod to log file LSN selection, include if matches diff, R.Devries 
September 30th, 2016 - V6.45 - Improvements to the output generated when @RestoreScriptOnly = 1, John Lee
September 30th, 2016 - V6.5  - New 'Drop Database After Restore' parameter for use with CHECKDB and automated backup verification, John Lee
      
November 5th, 2016  - V6.51  - Increase length of @Database parameter to allow for more comma seperated database names
November 5th, 2016  - V6.52  - Edge case log exclusion criteria mod, R.Devries 
November 5th, 2016  - V6.53  - New parameter option to include ALTER DATABASE @database SET SINGLE_USER WITH ROLLBACK IMMEDIATE, Hakan Ekman
November 5th, 2016  - V6.54  - New parameter option to exclude differential and log backups (presumaby for development environment refreshes), Mehedi Amin
      
November 19th, 2016 - V6.55  - Remove semi colon from start of T-SQL restore command strings, serves no purpose
November 19th, 2016 - V6.56  - Remove variable declare, log reference and RAISERROR, serves no purpose and generates an error in edge cases ( my_database and my-database ), Lars Rasmussen
November 19th, 2016 - V6.57  - Parameters options for device types to include, Lars Rasmussen 
      
December 3rd, 2016  - V6.58  - Remove TIME function from STANDBY mode file name construct, for SQL Server 2005 compatibility, Erwin Louwerse
March 26th, 2017    - V6.59  - Significant performance improvements where an instance has many databases, Simone Bizzotto
      
June 24th, 2017     - V6.70   - Case Sensitive Collation Database Compatibility - M.Pollock 
September 9th, 2017 - V6.71   - Device Type filter fix, LostInEurope01
November 11th, 2017 - V6.72   - Mod to log file selection, R.Devries
                              - Increase @Databases variable length, Bob
Febuary 14th, 2018  - V6.73   - Add escape characters to database name in SET SINGLE_USER, Rod
Febuary 16th, 2018  - V7.0    - Increase support for stripped backup files from 10 to 15, Mehedi 
Febuary 17th, 2018  - V8.0    - Extensive changes to the backup fork handling, Mike 
March 30th, 2018    - V8.04   - Code refactor
May 25th, 2018      - V8.05   - Missing exclusion of copy only backups reintroduced - Andy
August 25th, 2018   - V8.10   - Enhancements to the @ExcludeDiffAndLogBackups parameters, Bob and Chris F
                              - Change from parameter data type from bit to int
                              - 0 (default) = full, diff and logs, 1 = full only, 2 = full and diff, 3 = full and logs 
                              - Existing BIT data type functionality retained and extended by new values 2 and 3.
November 8th, 2018  - V8.11   - Bug fix to last log file - Mike
December 6th, 2018  - V8.12   - Optimisation and environment setup fix - Adam
January 12th, 2019  - V8.13   - Sequence of FROM DISK = 'Stripe' files in RESTORE command
January 3rd, 2021   - V8.14   - Restore from Azure blog storage using FROM DISK instead of FROM URL for backup stripes - Aaron  
January 9rd, 2021   - V8.15   - Change parameter @ExcludeDiffAndLogBackups, new option 4 to exclude full restore, return incremental diff & log restores - Mehedi Amin
July 11th, 2021     - V8.16   - Add support for an additional 5 stripes bring the total supported to 20, Steven Dannen  
April 5th, 2023     - V8.2    - Masood : Bug fix restoring striped backups   
April 11th, 2023    - V8.3    - Aaron : Result Set Columns fix   
 
     
*     
********************************************************************************************/ 
                                     
ALTER PROC [dbo].[sp_RestoreGene]
(
    @Database VARCHAR(MAX) = NULL,
    @TargetDatabase SYSNAME = NULL,
    @WithMoveDataFiles VARCHAR(2000) = NULL,
    @WithMoveLogFile  VARCHAR(2000) = NULL,
    @WithMoveFileStreamFile VARCHAR(2000) = NULL,
    @FromFileFullUNC VARCHAR(2000) = NULL,
    @FromFileDiffUNC VARCHAR(2000) = NULL,
    @FromFileLogUNC VARCHAR(2000) = NULL,
    @StopAt DATETIME = NULL,
    @StandbyMode BIT = 0,
    @IncludeSystemDBs BIT = 0,
    @WithRecovery BIT = 0,
    @WithCHECKDB BIT = 0,
    @WithReplace BIT = 0,
       
    -- Parameters for PowerShell script use only
    @LogShippingStartTime DATETIME = NULL,
    @LogShippingLastLSN VARCHAR(25) = NULL,
    -- Parameters for PowerShell script use only
       
    @BlobCredential VARCHAR(255) = NULL, --Credential used for Azure blob access
    @RestoreScriptReplaceThis NVARCHAR(255) = NULL,
    @RestoreScriptWithThis NVARCHAR(255) = NULL,
    @SuppressWithMove BIT = 1,
    @PivotWithMove BIT = 0,
    @RestoreScriptOnly BIT = 0,
    @DropDatabaseAfterRestore BIT = 0,
    @SetSingleUser BIT = 0,
    @ExcludeDiffAndLogBackups INT = 0,
      
    -- Options to exclude device types
    @IncludeDeviceType7 BIT = 0, --virtual device
    @IncludeDeviceType102 BIT = 1,
    @IncludeDeviceType2 BIT = 1,
    @IncludeDeviceType9 BIT = 1
)
AS
BEGIN
       
    SET NOCOUNT ON; 
       
    -- Avoid Parameter Sniffing Problems
    DECLARE @Database_ VARCHAR(MAX);
    SET @Database_ = @Database;
    DECLARE @TargetDatabase_ SYSNAME;
    SET @TargetDatabase_ = @TargetDatabase;
       
    -- Special handling for PoSh Driver
    DECLARE @WithMoveDataFiles_ VARCHAR(2000);
    IF @WithMoveDataFiles <> '' SET @WithMoveDataFiles_= @WithMoveDataFiles;
    DECLARE @WithMoveLogFile_  VARCHAR(2000);
    IF @WithMoveLogFile <> '' SET @WithMoveLogFile_= @WithMoveLogFile;
    DECLARE @WithMoveFileStreamFile_  VARCHAR(2000);
    IF @WithMoveFileStreamFile <> '' SET @WithMoveFileStreamFile_= @WithMoveFileStreamFile;
       
    DECLARE @FromFileFullUNC_ VARCHAR(2000);
    SET @FromFileFullUNC_ = @FromFileFullUNC;
    DECLARE @FromFileDiffUNC_ VARCHAR(2000);
    SET @FromFileDiffUNC_ = @FromFileDiffUNC;
    DECLARE @FromFileLogUNC_ VARCHAR(2000);
    SET @FromFileLogUNC_ = @FromFileLogUNC;
    DECLARE @StopAt_ DATETIME;
    SET @StopAt_ = @StopAt;
    DECLARE @StandbyMode_ BIT;
    SET @StandbyMode_ = @StandbyMode;
    DECLARE @IncludeSystemDBs_ BIT;
    SET @IncludeSystemDBs_ = @IncludeSystemDBs;
    DECLARE @WithRecovery_ BIT;
    SET @WithRecovery_ = @WithRecovery;
    DECLARE @WithCHECKDB_ BIT;
    SET @WithCHECKDB_ = @WithCHECKDB;
    DECLARE @WithReplace_ BIT;
    SET @WithReplace_ = @WithReplace;
    DECLARE @LogShippingStartTime_ DATETIME;
    SET @LogShippingStartTime_ = @LogShippingStartTime;
    DECLARE @LogShippingLastLSN_ VARCHAR(25);
    SET @LogShippingLastLSN_ = @LogShippingLastLSN;
    DECLARE @BlobCredential_ VARCHAR(255);
    SET @BlobCredential_ = @BlobCredential;
    DECLARE @RestoreScriptReplaceThis_ NVARCHAR(255);
    SET @RestoreScriptReplaceThis_ = @RestoreScriptReplaceThis;
    DECLARE @RestoreScriptWithThis_ NVARCHAR(255);
    SET @RestoreScriptWithThis_ = @RestoreScriptWithThis;
    DECLARE @SuppressWithMove_ BIT;
    SET @SuppressWithMove_ = @SuppressWithMove;
    DECLARE @PivotWithMove_ BIT
    SET @PivotWithMove_ = @PivotWithMove;
    DECLARE @RestoreScriptOnly_ BIT;
    SET @RestoreScriptOnly_ = @RestoreScriptOnly;
    DECLARE @DropDatabaseAfterRestore_ BIT;
    SET @DropDatabaseAfterRestore_ = @DropDatabaseAfterRestore;
    DECLARE @SetSingleUser_ BIT;
    SET @SetSingleUser_ = @SetSingleUser;
    DECLARE @ExcludeDiffAndLogBackups_ INT;
    SET @ExcludeDiffAndLogBackups_ = @ExcludeDiffAndLogBackups;
       
    -- Defaults Recovery Point Times
    IF ISNULL(@StopAt_,'') = ''
        SET @StopAt_ = GETDATE(); 
       
    IF ISNULL(@LogShippingStartTime_,'') = ''
        SET @LogShippingStartTime_ = @StopAt_;
       
    -- Allow override of restored database name only if working with a specific database
    IF @TargetDatabase_ IS NOT NULL AND @Database_ IS NULL
        SET @TargetDatabase_ = NULL;
       
    IF CHARINDEX(',',@Database_, 1) > 0
        SET @TargetDatabase_ = NULL;
       
    -- ps_LogShippingLight - Filtered Results
    IF ISNULL(@LogShippingLastLSN_,'') = ''
        SET @LogShippingLastLSN_ = '-1';
       
    -- Present WITH MOVE if override paths are supplied
    IF ISNULL(@WithMoveDataFiles,'') <> '' OR ISNULL(@WithMoveLogFile_,'') <> '' OR ISNULL(@WithMoveFileStreamFile_,'') <> '' OR ISNULL(@TargetDatabase_,'') <> ''
        SET @SuppressWithMove_ = 0
       
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
       
    IF OBJECT_ID('tempdb..#BackupFork') IS NOT NULL
        DROP TABLE #BackupFork;
      
    IF OBJECT_ID('tempdb..#ForkPointsCount') IS NOT NULL
        DROP TABLE #ForkPointsCount;
              
    IF OBJECT_ID('tempdb..#RestoreGeneResults') IS NOT NULL
        DROP TABLE #RestoreGeneResults;
       
    IF OBJECT_ID('tempdb..#tmpDatabases') IS NOT NULL
        DROP TABLE #tmpDatabases;
       
    IF OBJECT_ID('tempdb..#DeviceTypes') IS NOT NULL
        DROP TABLE #DeviceTypes;
     
    IF OBJECT_ID('tempdb..#FullBackups') IS NOT NULL
        DROP TABLE #FullBackups;
               
    CREATE TABLE #DeviceTypes (device_type tinyint);
    IF @IncludeDeviceType7 = 1 INSERT INTO #DeviceTypes (device_type) SELECT 7;
    IF @IncludeDeviceType102 = 1 INSERT INTO #DeviceTypes (device_type) SELECT 102;
    IF @IncludeDeviceType2 = 1 INSERT INTO #DeviceTypes (device_type) SELECT 2;
    IF @IncludeDeviceType9 = 1 INSERT INTO #DeviceTypes (device_type) SELECT 9;
       
    --=======================================================================================================================================
    -- 'SELECT DATABASES' code snippet used below with permission from the ola hallengren - https://ola.hallengren.com/
    -----------------------------------------------------------------------------------------------------------------------------------------
    CREATE TABLE #tmpDatabases
    (
        ID int IDENTITY,
        DatabaseName nvarchar(450),
        DatabaseNameFS nvarchar(max),
        DatabaseType nvarchar(max),
        Selected bit,
        Completed bit
    );
    CREATE CLUSTERED INDEX IDX_tmpDatabases ON #tmpDatabases(DatabaseName);
       
    IF CHARINDEX(',',@Database_,1) > 0
    BEGIN
       
        DECLARE @SelectedDatabases TABLE
        (
        DatabaseName nvarchar(max),
        DatabaseType nvarchar(max),
        Selected bit
        );
       
        DECLARE @ErrorMessage nvarchar(max);
        DECLARE @Error int;
       
        ----------------------------------------------------------------------------------------------------
        --// Select databases                                                                           //--
        ----------------------------------------------------------------------------------------------------
       
        SET @Database_ = REPLACE(@Database_, ', ', ',');
       
        WITH Databases1 (StartPosition, EndPosition, DatabaseItem) AS
        (
        SELECT 1 AS StartPosition,
                ISNULL(NULLIF(CHARINDEX(',', @Database_, 1), 0), LEN(@Database_) + 1) AS EndPosition,
                SUBSTRING(@Database_, 1, ISNULL(NULLIF(CHARINDEX(',', @Database_, 1), 0), LEN(@Database_) + 1) - 1) AS DatabaseItem
        WHERE @Database_ IS NOT NULL
        UNION ALL
        SELECT CAST(EndPosition AS int) + 1 AS StartPosition,
                ISNULL(NULLIF(CHARINDEX(',', @Database_, EndPosition + 1), 0), LEN(@Database_) + 1) AS EndPosition,
                SUBSTRING(@Database_, EndPosition + 1, ISNULL(NULLIF(CHARINDEX(',', @Database_, EndPosition + 1), 0), LEN(@Database_) + 1) - EndPosition - 1) AS DatabaseItem
        FROM Databases1
        WHERE EndPosition < LEN(@Database_) + 1
        ),
        Databases2 (DatabaseItem, Selected) AS
        (
        SELECT CASE WHEN DatabaseItem LIKE '-%' THEN RIGHT(DatabaseItem,LEN(DatabaseItem) - 1) ELSE DatabaseItem END AS DatabaseItem,
                CASE WHEN DatabaseItem LIKE '-%' THEN 0 ELSE 1 END AS Selected
        FROM Databases1
        ),
        Databases3 (DatabaseItem, DatabaseType, Selected) AS
        (
        SELECT CASE WHEN DatabaseItem IN('ALL_DATABASES','SYSTEM_DATABASES','USER_DATABASES') THEN '%' ELSE DatabaseItem END AS DatabaseItem,
                CASE WHEN DatabaseItem = 'SYSTEM_DATABASES' THEN 'S' WHEN DatabaseItem = 'USER_DATABASES' THEN 'U' ELSE NULL END AS DatabaseType,
                Selected
        FROM Databases2
        ),
        Databases4 (DatabaseName, DatabaseType, Selected) AS
        (
        SELECT CASE WHEN LEFT(DatabaseItem,1) = '[' AND RIGHT(DatabaseItem,1) = ']' THEN PARSENAME(DatabaseItem,1) ELSE DatabaseItem END AS DatabaseItem,
                DatabaseType,
                Selected
        FROM Databases3
        )
        INSERT INTO @SelectedDatabases (DatabaseName, DatabaseType, Selected)
        SELECT DatabaseName,
                DatabaseType,
                Selected
        FROM Databases4
        OPTION (MAXRECURSION 0)
       
        INSERT INTO #tmpDatabases (DatabaseName, DatabaseNameFS, DatabaseType, Selected, Completed)
        SELECT [name] AS DatabaseName,
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE([name],'\',''),'/',''),':',''),'*',''),'?',''),'"',''),'<',''),'>',''),'|',''),' ','') AS DatabaseNameFS,
                CASE WHEN name IN('master','msdb','model') THEN 'S' ELSE 'U' END AS DatabaseType,
                0 AS Selected,
                0 AS Completed
        FROM sys.databases
        WHERE [name] <> 'tempdb'
        AND source_database_id IS NULL
        ORDER BY [name] ASC
       
        UPDATE tmpDatabases
        SET tmpDatabases.Selected = SelectedDatabases.Selected
        FROM #tmpDatabases tmpDatabases
        INNER JOIN @SelectedDatabases SelectedDatabases
        ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
        AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
        WHERE SelectedDatabases.Selected = 1
       
        UPDATE tmpDatabases
        SET tmpDatabases.Selected = SelectedDatabases.Selected
        FROM #tmpDatabases tmpDatabases
        INNER JOIN @SelectedDatabases SelectedDatabases
        ON tmpDatabases.DatabaseName LIKE REPLACE(SelectedDatabases.DatabaseName,'_','[_]')
        AND (tmpDatabases.DatabaseType = SelectedDatabases.DatabaseType OR SelectedDatabases.DatabaseType IS NULL)
        WHERE SelectedDatabases.Selected = 0
       
        IF @Database_ IS NULL OR NOT EXISTS(SELECT * FROM @SelectedDatabases) OR EXISTS(SELECT * FROM @SelectedDatabases WHERE DatabaseName IS NULL OR DatabaseName = '')
            BEGIN
            SET @ErrorMessage = 'The value for the parameter @Databases is not supported.' + CHAR(13) + CHAR(10) + ' '
            RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
            SET @Error = @@ERROR
        END
       
    END
     
    --=======================================================================================================================================
    -- Full Backups - Last before stop at for each database 
    SELECT
       a.database_name
      ,MAX(a.backup_finish_date) AS backup_finish_date
    INTO #FullBackups
    FROM msdb.dbo.backupset a
    JOIN msdb.dbo.backupmediafamily b
       ON a.media_set_id = b.media_set_id
       
    WHERE a.[type] = 'D'
    AND (a.database_name IN (SELECT DatabaseName FROM #tmpDatabases WHERE Selected = 1) OR @Database_ IS NULL OR a.database_name = @Database_)
    AND device_type IN (SELECT device_type FROM #DeviceTypes)
    AND a.is_copy_only = 0
    AND b.mirror = 0
    AND a.backup_start_date <= @LogShippingStartTime_
    GROUP BY a.database_name;
     
    CREATE INDEX IDX_FullBackups ON #FullBackups(database_name);
     
    --=======================================================================================================================================
    -- Backup forking (suppress differential, log file select criteria)
    SELECT bs.database_name, first_recovery_fork_guid, MIN(fork_point_lsn) AS fork_point_lsn
    INTO #BackupFork 
    FROM msdb.dbo.backupset bs
    JOIN msdb.dbo.backupmediafamily b
       ON bs.media_set_id = b.media_set_id  
    JOIN #FullBackups fb
      ON fb.database_name = bs.database_name
    WHERE fb.backup_finish_date < bs.backup_start_date
    AND bs.backup_finish_date < @LogShippingStartTime_
    AND bs.first_recovery_fork_guid <> bs.last_recovery_fork_guid
    GROUP BY bs.database_name, first_recovery_fork_guid;
     
    -- Only one fork point between the selected full backup and the stop at time supported
    SELECT database_name, COUNT(*) AS ForkPoints
    INTO #ForkPointsCount
    FROM #BackupFork rh
    GROUP BY database_name;
     
    --=======================================================================================================================================
    --------------------------------------------------------------
    -- CTE1 Full Backup 
    --------------------------------------------------------------
    WITH CTE
    (
         database_name
        ,current_compatibility_level
        ,first_lsn
        ,last_lsn
        ,fork_point_lsn
        ,current_is_read_only
        ,current_state_desc
        ,current_recovery_model_desc
        ,has_backup_checksums
        ,backup_size
        ,[type]
        ,backupmediasetid
        ,family_sequence_number
        ,backupfinishdate
        ,physical_device_name
        ,position
        ,first_recovery_fork_guid
        ,last_recovery_fork_guid
    )
    AS
    ( 
        --------------------------------------------------------------
        -- Full backup - Most recent before @LogShippingStartTime_
        SELECT
            bs.database_name
            ,d.[compatibility_level] AS current_compatibility_level
            ,bs.first_lsn
            ,bs.last_lsn
            ,bs.fork_point_lsn
            ,d.[is_read_only] AS current_is_read_only
            ,d.[state_desc] AS current_state_desc
            ,d.[recovery_model_desc] current_recovery_model_desc
            ,bs.has_backup_checksums
            ,bs.backup_size AS backup_size
            ,'D' AS [type]
            ,bs.media_set_id AS backupmediasetid
            ,mf.family_sequence_number
            ,bs.backup_finish_date AS backupfinishdate
            ,mf.physical_device_name
            ,bs.position
            ,bs.first_recovery_fork_guid
            ,bs.last_recovery_fork_guid
    
        FROM msdb.dbo.backupset bs 
       
        INNER JOIN sys.databases d
            ON bs.database_name = d.name
       
        INNER JOIN #FullBackups fb
            ON fb.database_name = bs.database_name
            AND fb.backup_finish_date = bs.backup_finish_date
       
        JOIN msdb.dbo.backupmediafamily mf
            ON mf.media_set_id = bs.media_set_id
            AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number      
       
        WHERE bs.type = 'D'
        AND mf.mirror = 0
        AND mf.physical_device_name NOT IN ('Nul', 'Nul:') 
        AND bs.is_copy_only = 0
       
        UNION
       
        --------------------------------------------------------------
        -- Differential backup, most current immediately before @StopAt_, suppress if backup fork points exist
        SELECT
            bs.database_name
            ,d.[compatibility_level] AS current_compatibility_level
            ,bs.first_lsn
            ,bs.last_lsn
            ,bs.fork_point_lsn
            ,d.[is_read_only] AS current_is_read_only
            ,d.[state_desc] AS current_state_desc
            ,d.[recovery_model_desc] current_recovery_model_desc
            ,bs.has_backup_checksums
            ,bs.backup_size AS backup_size
            ,'I' AS [type]
            ,bs.media_set_id AS backupmediasetid
            ,mf.family_sequence_number
            ,bs.backup_finish_date AS backupfinishdate
            ,mf.physical_device_name
            ,bs.position
            ,bs.first_recovery_fork_guid
            ,bs.last_recovery_fork_guid
        FROM msdb.dbo.backupset bs 
       
        INNER JOIN sys.databases d
          ON bs.database_name = d.name
       
        INNER JOIN #FullBackups fb
            ON fb.database_name = bs.database_name
            AND fb.backup_finish_date < bs.backup_finish_date
     
        INNER JOIN -- Last Diff before STOPAT / Suppress if backup forkpoints exist
        (
            SELECT
                a.database_name
                ,MAX(backup_start_date) backup_start_date
            FROM msdb.dbo.backupset a
            JOIN msdb.dbo.backupmediafamily b
                ON a.media_set_id = b.media_set_id
       
            WHERE a.[type] = 'I'
            AND (a.database_name IN (SELECT DatabaseName FROM #tmpDatabases WHERE Selected = 1) OR @Database_ IS NULL OR a.database_name = @Database_)
            AND device_type IN (SELECT device_type FROM #DeviceTypes)
            AND a.is_copy_only = 0
            AND b.mirror = 0
            AND a.backup_start_date <= ISNULL(@StopAt_,GETDATE())
            GROUP BY a.database_name  
        ) x
            ON x.database_name = bs.database_name
            AND x.backup_start_date = bs.backup_start_date 
       
        INNER JOIN msdb.dbo.backupmediafamily mf
            ON mf.media_set_id = bs.media_set_id
            AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number 
     
        LEFT OUTER JOIN #BackupFork bf
            ON bf.database_name = bs.database_name
     
        WHERE bs.type = 'I'
        AND mf.physical_device_name NOT IN ('Nul', 'Nul:')
        AND mf.mirror = 0
        AND @StopAt_ = @LogShippingStartTime_
        AND bf.fork_point_lsn IS NULL
       
        UNION
       
        --------------------------------------------------------------
        -- Log file backups - after 1st full / before @StopAt_
        SELECT
            bs.database_name
            ,d.[compatibility_level] AS current_compatibility_level
            ,bs.first_lsn
            ,bs.last_lsn
            ,bs.fork_point_lsn
            ,d.[is_read_only] AS current_is_read_only
            ,d.[state_desc] AS current_state_desc
            ,d.[recovery_model_desc] current_recovery_model_desc
            ,bs.has_backup_checksums
            ,bs.backup_size AS backup_size
            ,'L' AS [type]
            ,bs.media_set_id AS backupmediasetid
            ,mf.family_sequence_number
            ,bs.backup_finish_date as backupfinishdate
            ,mf.physical_device_name
            ,bs.position
            ,bs.first_recovery_fork_guid
            ,bs.last_recovery_fork_guid 
        FROM msdb.dbo.backupset bs 
       
        INNER JOIN sys.databases d
            ON bs.database_name = d.name
       
        INNER JOIN msdb.dbo.backupmediafamily mf
            ON mf.media_set_id = bs.media_set_id
            AND mf.family_sequence_number Between bs.first_family_number And bs.last_family_number 
       
        INNER JOIN #FullBackups fb
            ON bs.database_name = fb.database_name 
       
        LEFT OUTER JOIN -- Select the first log file after STOPAT
        (
            SELECT DISTINCT x.database_name, CASE WHEN y.last_Log_After_StopAt IS NULL THEN CONVERT(datetime, '31 Dec 2050') ELSE y.last_Log_After_StopAt END AS last_Log_After_StopAt
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
                AND (a.database_name IN (SELECT DatabaseName FROM #tmpDatabases WHERE Selected = 1) OR @Database_ IS NULL OR a.database_name = @Database_)
                AND b.mirror = 0
                AND device_type IN (SELECT device_type FROM #DeviceTypes)
                AND a.backup_start_date > ISNULL(@StopAt_,'1 Jan, 1900')
                GROUP BY database_name
            ) y
                ON x.database_name = y.database_name
        ) x
            ON bs.database_name = x.database_name
      
        LEFT OUTER JOIN #BackupFork bf
            ON bf.database_name = bs.database_name
            AND bf.first_recovery_fork_guid = bs.first_recovery_fork_guid
       
        WHERE bs.backup_start_date <= x.last_Log_After_StopAt -- Include 1st log after stop at
        AND bs.backup_start_date >= fb.backup_finish_date -- Full backup finish
        --AND bs.backup_finish_date <= @StopAt_
        AND (bs.database_name IN (SELECT DatabaseName FROM #tmpDatabases WHERE Selected = 1) OR @Database_ IS NULL OR bs.database_name = @Database_)
        AND mf.physical_device_name NOT IN ('Nul', 'Nul:')
        AND mf.mirror = 0
        AND bs.type = 'L'
        AND device_type IN (SELECT device_type FROM #DeviceTypes)
        AND (bf.fork_point_lsn > bs.first_lsn OR bf.first_recovery_fork_guid IS NULL OR bs.first_recovery_fork_guid <> bs.last_recovery_fork_guid)
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
        S10_pdn,
        S11_pdn,
        S12_pdn,
        S13_pdn,
        S14_pdn,
        S15_pdn,
        --************************
        S16_pdn,
        S17_pdn,
        S18_pdn,
        S19_pdn,
        S20_pdn
        --************************
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
            Stripe10.physical_device_name AS S10_pdn,
            Stripe11.physical_device_name AS S11_pdn,
            Stripe12.physical_device_name AS S12_pdn,
            Stripe13.physical_device_name AS S13_pdn,
            Stripe14.physical_device_name AS S14_pdn,
            Stripe15.physical_device_name AS S15_pdn
            --************************
            ,Stripe16.physical_device_name AS S16_pdn
            ,Stripe17.physical_device_name AS S17_pdn
            ,Stripe18.physical_device_name AS S18_pdn
            ,Stripe19.physical_device_name AS S19_pdn
            ,Stripe20.physical_device_name AS S20_pdn
            --************************
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
      
        LEFT OUTER JOIN #CTE AS Stripe11
            ON Stripe11.database_name = Stripe1.database_name
            AND Stripe11.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe11.family_sequence_number = 11
      
        LEFT OUTER JOIN #CTE AS Stripe12
            ON Stripe12.database_name = Stripe1.database_name
            AND Stripe12.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe12.family_sequence_number = 12
      
        LEFT OUTER JOIN #CTE AS Stripe13
            ON Stripe13.database_name = Stripe1.database_name
            AND Stripe13.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe13.family_sequence_number = 13
      
        LEFT OUTER JOIN #CTE AS Stripe14
            ON Stripe14.database_name = Stripe1.database_name
            AND Stripe14.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe14.family_sequence_number = 14
      
        LEFT OUTER JOIN #CTE AS Stripe15
            ON Stripe15.database_name = Stripe1.database_name
            AND Stripe15.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe15.family_sequence_number = 15
 
        --************************
        LEFT OUTER JOIN #CTE AS Stripe16
            ON Stripe16.database_name = Stripe1.database_name
            AND Stripe16.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe16.family_sequence_number = 16
  
        LEFT OUTER JOIN #CTE AS Stripe17
            ON Stripe17.database_name = Stripe1.database_name
            AND Stripe17.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe17.family_sequence_number = 17
  
        LEFT OUTER JOIN #CTE AS Stripe18
            ON Stripe18.database_name = Stripe1.database_name
            AND Stripe18.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe18.family_sequence_number = 18
  
        LEFT OUTER JOIN #CTE AS Stripe19
            ON Stripe19.database_name = Stripe1.database_name
            AND Stripe19.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe19.family_sequence_number = 19
  
        LEFT OUTER JOIN #CTE AS Stripe20
            ON Stripe20.database_name = Stripe1.database_name
            AND Stripe20.backupmediasetid = Stripe1.backupmediasetid
            AND Stripe20.family_sequence_number = 20
--      ************************
     
    ) 
       
    SELECT * INTO #Stripes FROM Stripes;  
       
    CREATE INDEX IDX_Stripes ON #Stripes(database_name);
       
    --------------------------------------------------------------
    -- Results, T-SQL RESTORE commands, below are based on CTE's above
    -------------------------------------------------------------- 
       
    SELECT
        CASE WHEN @RestoreScriptReplaceThis_ IS NOT NULL AND @RestoreScriptWithThis_ IS NOT NULL THEN REPLACE(a.Command, @RestoreScriptReplaceThis_, @RestoreScriptWithThis_) ELSE a.Command END AS TSQL,  --Allow substitution of a path
        CONVERT(nvarchar(30), a.backupfinishdate, 126)
        AS BackupDate,
        a.BackupDevice,
        a.first_lsn,
        a.last_lsn,
        a.fork_point_lsn,
        a.first_recovery_fork_guid,
        a.last_recovery_fork_guid,
        a.database_name ,
        ROW_NUMBER() OVER(ORDER BY database_name, Sequence, a.backupfinishdate) AS SortSequence
    INTO #RestoreGeneResults
    FROM
    ( 
       
    --------------------------------------------------------------
    -- Most recent full backup
    -------------------------------------------------------------- 
       
    SELECT
     
        'RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) + CHAR(13) + 
       
        CASE WHEN #CTE.physical_device_name LIKE 'http%' THEN  ' FROM URL = N' ELSE ' FROM DISK = N' END + '''' + --Support restore from blob storage in Azure
       
        CASE ISNULL(@FromFileFullUNC_,'Actual')
        WHEN 'Actual' THEN #CTE.physical_device_name
        ELSE @FromFileFullUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
        END + '''' + SPACE(1) + CHAR(13) + 
       
        -- Striped backup files
        CASE ISNULL(#Stripes.S2_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S2_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S3_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S3_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S4_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S4_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S5_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S5_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S6_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S6_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S7_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' +  CASE WHEN #Stripes.S7_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S8_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S8_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S9_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S9_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S10_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S10_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S11_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S11_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S11_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S11_pdn,LEN(#Stripes.S11_pdn) - CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S12_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S12_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S12_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S12_pdn,LEN(#Stripes.S12_pdn) - CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S13_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S13_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S13_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S13_pdn,LEN(#Stripes.S13_pdn) - CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S14_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S14_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S14_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S14_pdn,LEN(#Stripes.S14_pdn) - CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S15_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S15_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S15_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S15_pdn,LEN(#Stripes.S15_pdn) - CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 1) END + ''''
        END + 
  
        --*******
  
        CASE ISNULL(#Stripes.S16_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S16_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S16_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S16_pdn,LEN(#Stripes.S16_pdn) - CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 1) END + ''''
        END + 
  
        CASE ISNULL(#Stripes.S17_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S17_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S17_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S17_pdn,LEN(#Stripes.S17_pdn) - CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 1) END + ''''
        END + 
  
        CASE ISNULL(#Stripes.S18_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S18_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S18_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S18_pdn,LEN(#Stripes.S18_pdn) - CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 1) END + ''''
        END + 
  
        CASE ISNULL(#Stripes.S19_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S19_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S19_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S19_pdn,LEN(#Stripes.S19_pdn) - CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 1) END + ''''
        END + 
  
        CASE ISNULL(#Stripes.S20_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S20_pdn LIKE 'http%' THEN  ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileFullUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S20_pdn ELSE @FromFileFullUNC_ + SUBSTRING(#Stripes.S20_pdn,LEN(#Stripes.S20_pdn) - CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 1) END + ''''
        END + 
 
        --******
            
        ' WITH ' + 
        
        CASE WHEN #CTE.physical_device_name LIKE 'http%' AND @BlobCredential_ IS NOT NULL THEN ' CREDENTIAL = ''' + @BlobCredential_ + ''', ' ELSE '' END +
       
        CASE ISNULL(@WithReplace_,0) WHEN 1 THEN 'REPLACE, ' ELSE '' END   + 'FILE = ' + CAST(#CTE.position AS VARCHAR(5)) + ',' +
        CASE #CTE.has_backup_checksums WHEN 1 THEN 'CHECKSUM, ' ELSE ' ' END + 
       
        CASE @StandbyMode_ WHEN 0 THEN 'NORECOVERY,' ELSE 'STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_' + REPLACE(REPLACE(SUBSTRING(CONVERT(VARCHAR(24),GETDATE(),127),12,12),':',''),'.','') + '_ROLLBACK_UNDO.bak ' + '''' + ',' END + SPACE(1) + 
       
        'STATS=10' + SPACE(1) +
       
        CASE @SuppressWithMove_ WHEN 0 THEN
       
            ', MOVE N' + '''' + x.LogicalName + '''' + ' TO ' +
            '''' +
            CASE ISNULL(@WithMoveDataFiles_,'Actual')
            WHEN 'Actual' THEN x.PhysicalName
            ELSE @WithMoveDataFiles_ + SUBSTRING(x.PhysicalName,LEN(x.PhysicalName) - CHARINDEX('\',REVERSE(x.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(x.PhysicalName),1) + 1)
            END + '''' + SPACE(1) + 
       
            ', MOVE N' + '''' + y.LogicalName + '''' + ' TO ' +
            '''' +
            CASE ISNULL(@WithMoveLogFile_ ,'Actual')
            WHEN 'Actual' THEN y.PhysicalName
            ELSE @WithMoveLogFile_  + SUBSTRING(y.PhysicalName,LEN(y.PhysicalName) - CHARINDEX('\',REVERSE(y.PhysicalName),1) + 2,CHARINDEX('\',REVERSE(y.PhysicalName),1) + 1)
            END + ''''
        ELSE ' '
        END 
       
        AS Command,
        1 AS Sequence,
        d.name AS database_name,
        #CTE.physical_device_name AS BackupDevice,
        #CTE.backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        #CTE.last_lsn,
        #CTE.fork_point_lsn,
        #CTE.first_recovery_fork_guid,
        #CTE.last_recovery_fork_guid 
       
    FROM sys.databases d 
       
    INNER JOIN
    (
        SELECT
            DB_NAME(mf.database_id) AS name
            ,CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN mf.Physical_Name ELSE SUBSTRING(mf.Physical_Name,1,CASE CHARINDEX('.',mf.Physical_Name) WHEN 0 THEN LEN(mf.Physical_Name) ELSE CHARINDEX('.',mf.Physical_Name) - 1 END) + '_' + @TargetDatabase_ + '.mdf' END  AS PhysicalName
            ,mf.Name AS LogicalName
        FROM sys.master_files mf
        WHERE type_desc = 'ROWS'
        AND mf.file_id = 1
    ) x
        ON d.name = x.name 
       
    INNER JOIN
    (
        SELECT
            DB_NAME(mf.database_id) AS name, type_desc
            ,CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN mf.Physical_Name ELSE SUBSTRING(mf.Physical_Name,1,CASE CHARINDEX('.',mf.Physical_Name) WHEN 0 THEN LEN(mf.Physical_Name) ELSE CHARINDEX('.',mf.Physical_Name) - 1 END) +  '_' + @TargetDatabase_ + '.ldf' END  AS PhysicalName
            ,mf.Name AS LogicalName
        FROM sys.master_files mf
     
        -- Fix for multiple log files/with moves
        INNER JOIN
        (
            SELECT database_id, MIN(file_id) AS logfile_id
            FROM sys.master_files
            WHERE type_desc = 'LOG'
            GROUP BY database_id
        ) logfileid
            on logfileid.database_id = mf.database_id
            AND logfileid.logfile_id = mf.file_id
        WHERE type_desc = 'LOG'
    ) y
        ON d.name = y.name 
       
    LEFT OUTER JOIN #CTE
        ON #CTE.database_name = d.name
        AND #CTE.family_sequence_number = 1 
     
    INNER JOIN #Stripes
        ON #Stripes.database_name = d.name
        AND #Stripes.backupmediasetid = #CTE.backupmediasetid
        AND #Stripes.last_lsn = #CTE.last_lsn 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
       
    WHERE #CTE.[type] = 'D'
    AND #CTE.family_sequence_number = 1 
    AND ISNULL(fpc.ForkPoints,0) < 2
    AND @ExcludeDiffAndLogBackups_ IN (0,1,2,3)
       
    --------------------------------------------------------------
    -- Most recent differential backup
    --------------------------------------------------------------
    UNION 
       
    SELECT
     
        'RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) + CHAR(13) +
        CASE WHEN #CTE.physical_device_name LIKE 'http%' THEN ' FROM URL = N' ELSE ' FROM DISK = N' END + '''' +
       
        CASE ISNULL(@FromFileDiffUNC_,'Actual')
        WHEN 'Actual' THEN #CTE.physical_device_name
        ELSE @FromFileDiffUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
        END + '''' + SPACE(1) + CHAR(13) + 
       
        -- Striped backup files
        CASE ISNULL(#Stripes.S2_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S2_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S3_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S3_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S4_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S4_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S5_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S5_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S6_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S6_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S7_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S7_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S8_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S8_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S9_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S9_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S10_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S10_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S11_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S11_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S11_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S11_pdn,LEN(#Stripes.S11_pdn) - CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S12_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S12_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S12_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S12_pdn,LEN(#Stripes.S12_pdn) - CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S13_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S13_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S13_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S13_pdn,LEN(#Stripes.S13_pdn) - CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S14_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S14_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S14_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S14_pdn,LEN(#Stripes.S14_pdn) - CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S15_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S15_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S15_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S15_pdn,LEN(#Stripes.S15_pdn) - CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 1) END + ''''
        END + 
  
        --**************************
  
        CASE ISNULL(#Stripes.S16_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S16_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S16_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S16_pdn,LEN(#Stripes.S16_pdn) - CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 1) END + ''''
        END + 
  
  
        CASE ISNULL(#Stripes.S17_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S17_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S17_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S17_pdn,LEN(#Stripes.S17_pdn) - CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 1) END + ''''
        END + 
  
  
        CASE ISNULL(#Stripes.S18_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S18_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S18_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S18_pdn,LEN(#Stripes.S18_pdn) - CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 1) END + ''''
        END + 
  
  
        CASE ISNULL(#Stripes.S19_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S19_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S19_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S19_pdn,LEN(#Stripes.S19_pdn) - CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 1) END + ''''
        END + 
  
  
        CASE ISNULL(#Stripes.S20_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S20_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileDiffUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S20_pdn ELSE @FromFileDiffUNC_ + SUBSTRING(#Stripes.S20_pdn,LEN(#Stripes.S20_pdn) - CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 1) END + ''''
        END + 
  
        --**************************
      
        ' WITH FILE = ' + CAST(#CTE.position AS VARCHAR(5)) + ',' +
        CASE #CTE.has_backup_checksums WHEN 1 THEN 'CHECKSUM, ' ELSE ' ' END + 
       
        CASE WHEN #CTE.physical_device_name LIKE 'http%' AND @BlobCredential_ IS NOT NULL THEN ' CREDENTIAL = ''' + @BlobCredential_ + ''', ' ELSE '' END +
       
        CASE @StandbyMode_ WHEN 0 THEN 'NORECOVERY,' ELSE 'STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_' + REPLACE(REPLACE(SUBSTRING(CONVERT(VARCHAR(24),GETDATE(),127),12,12),':',''),'.','') + '_ROLLBACK_UNDO.bak ' + ''''  + ',' END + SPACE(1) + 
       
        'STATS=10' + SPACE(1) 
       
        AS Command,
        750000 AS Sequence,
        d.name AS database_name,
        #CTE.physical_device_name AS BackupDevice,
        #CTE.backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        #CTE.last_lsn,
        #CTE.fork_point_lsn, 
        #CTE.first_recovery_fork_guid,
        #CTE.last_recovery_fork_guid 
     
       
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name
      AND #CTE.family_sequence_number = 1 
     
    LEFT OUTER JOIN #Stripes
    ON #Stripes.database_name = d.name
      AND #Stripes.backupmediasetid = #CTE.backupmediasetid
      AND #Stripes.last_lsn = #CTE.last_lsn 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
       
    WHERE #CTE.[type] = 'I'
    AND #CTE.family_sequence_number = 1
    AND @ExcludeDiffAndLogBackups_ IN (0,2,4)
    AND ISNULL(fpc.ForkPoints,0) < 2
           
    --------------------------------------------------------------
    UNION -- Log backups taken since most recent full or diff
    -------------------------------------------------------------- 
       
    SELECT
     
        'RESTORE LOG [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) + CHAR(13) + 
       
        CASE WHEN #CTE.physical_device_name LIKE 'http%' THEN ' FROM URL = N' ELSE ' FROM DISK = N' END + '''' +
       
        CASE ISNULL(@FromFileLogUNC_,'Actual')
        WHEN 'Actual' THEN #CTE.physical_device_name
        ELSE @FromFileLogUNC_ + SUBSTRING(#CTE.physical_device_name,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 2,CHARINDEX('\',REVERSE(#CTE.physical_device_name),1) + 1)
        END + '''' + CHAR(13) + 
       
        -- Striped backup files
        CASE ISNULL(#Stripes.S2_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S2_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S2_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S2_pdn,LEN(#Stripes.S2_pdn) - CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S2_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S3_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S3_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S3_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S3_pdn,LEN(#Stripes.S3_pdn) - CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S3_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S4_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S4_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S4_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S4_pdn,LEN(#Stripes.S4_pdn) - CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S4_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S5_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S5_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S5_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S5_pdn,LEN(#Stripes.S5_pdn) - CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S5_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S6_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S6_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S6_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S6_pdn,LEN(#Stripes.S6_pdn) - CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S6_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S7_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S7_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S7_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S7_pdn,LEN(#Stripes.S7_pdn) - CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S7_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S8_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S8_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S8_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S8_pdn,LEN(#Stripes.S8_pdn) - CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S8_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S9_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S9_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S9_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S9_pdn,LEN(#Stripes.S9_pdn) - CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S9_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S10_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S10_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S10_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S10_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S10_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S11_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S11_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S11_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S11_pdn,LEN(#Stripes.S10_pdn) - CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S11_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S12_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S12_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S12_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S12_pdn,LEN(#Stripes.S12_pdn) - CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S12_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S13_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S13_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S13_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S13_pdn,LEN(#Stripes.S13_pdn) - CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S13_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S14_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S14_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S14_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S14_pdn,LEN(#Stripes.S14_pdn) - CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S14_pdn),1) + 1) END + ''''
        END + 
      
        CASE ISNULL(#Stripes.S15_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S15_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S15_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S15_pdn,LEN(#Stripes.S15_pdn) - CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S15_pdn),1) + 1) END + ''''
        END + 
 
       --***************
        CASE ISNULL(#Stripes.S16_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S16_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S16_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S16_pdn,LEN(#Stripes.S16_pdn) - CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S16_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S17_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S17_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S17_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S17_pdn,LEN(#Stripes.S17_pdn) - CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S17_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S18_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S18_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S18_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S18_pdn,LEN(#Stripes.S18_pdn) - CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S18_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S19_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S19_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S19_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S19_pdn,LEN(#Stripes.S19_pdn) - CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S19_pdn),1) + 1) END + ''''
        END + 
       
        CASE ISNULL(#Stripes.S20_pdn,'')
        WHEN '' THEN ''
        ELSE  ',' + CASE WHEN #Stripes.S20_pdn LIKE 'http%' THEN ' URL = N' ELSE ' DISK = N' END + '''' + CASE ISNULL(@FromFileLogUNC_,'Actual') WHEN 'Actual' THEN #Stripes.S20_pdn ELSE @FromFileLogUNC_ + SUBSTRING(#Stripes.S20_pdn,LEN(#Stripes.S20_pdn) - CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 2,CHARINDEX('\',REVERSE(#Stripes.S20_pdn),1) + 1) END + ''''
        END + 
 
        --***************** 
  
        CASE @StandbyMode_ WHEN 0 THEN ' WITH NORECOVERY,' ELSE ' WITH STANDBY =N' + '''' + ISNULL(@FromFileFullUNC_,SUBSTRING(#CTE.physical_device_name,1,LEN(#CTE.physical_device_name) - CHARINDEX('\',REVERSE(#CTE.physical_device_name)))) + '\' + d.name + '_' + REPLACE(REPLACE(SUBSTRING(CONVERT(VARCHAR(24),GETDATE(),127),12,12),':',''),'.','') + '_ROLLBACK_UNDO.bak ' + ''''  + ',' END + SPACE(1) + 
       
        CASE WHEN #CTE.physical_device_name LIKE 'http%' AND @BlobCredential_ IS NOT NULL THEN ' CREDENTIAL = ''' + @BlobCredential_ + ''', ' ELSE '' END + 
       
        CASE #CTE.has_backup_checksums WHEN 1 THEN ' CHECKSUM, ' ELSE ' ' END + 
       
        + 'FILE = ' + CAST(#CTE.position AS VARCHAR(5)) +
        ' ,STOPAT = ' + '''' + CONVERT(VARCHAR(21),@StopAt_,120) + '''' 
       
        AS Command,
        1000000 AS Sequence,
        d.name AS database_name,
        #CTE.physical_device_name AS BackupDevice,
        #CTE.backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        #CTE.last_lsn,
        #CTE.fork_point_lsn,
        #CTE.first_recovery_fork_guid,
        #CTE.last_recovery_fork_guid 
              
       
    FROM sys.databases d 
         
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
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'L'
    AND #CTE.family_sequence_number = 1
    AND #CTE.last_lsn >= CASE WHEN @ExcludeDiffAndLogBackups_ IN(0,4) THEN ISNULL(after_diff.last_lsn,'0') ELSE 0 END
    AND @ExcludeDiffAndLogBackups_ IN (0,3,4)
    
    AND ISNULL(fpc.ForkPoints,0) < 2
     
    --------------------------------------------------------------
    UNION -- SET SINGLE USER WITH ROLLBACK IMMEDIATE
    --------------------------------------------------------------
    SELECT
     
       'BEGIN TRY ALTER DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + ' SET SINGLE_USER WITH ROLLBACK IMMEDIATE END TRY BEGIN CATCH PRINT' + '''' + 'SET SINGLE USER FAILED' + '''' + ' END CATCH' AS Command,
        0 AS Sequence,
        d.name AS database_name,
        '' AS BackupDevice,
        GETDATE() AS backupfinishdate,
        #CTE.backup_size,
        '0' AS first_lsn,
        '0' AS last_lsn,
        '0' AS fork_point_lsn ,
        '00000000-0000-0000-0000-000000000000' AS first_recovery_fork_guid,
        '00000000-0000-0000-0000-000000000000' AS last_recovery_fork_guid     
     
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND @SetSingleUser_ = 1
    AND ISNULL(fpc.ForkPoints,0) < 2
       
    --------------------------------------------------------------
    UNION -- Restore WITH RECOVERY
    --------------------------------------------------------------
    SELECT
     
       'RESTORE DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) + 'WITH RECOVERY' AS Command,
        1000001 AS Sequence,
        d.name AS database_name,
        '' AS BackupDevice,
        GETDATE() AS backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        '999999999999999999997' AS last_lsn,
        #CTE.fork_point_lsn ,
        '00000000-0000-0000-0000-000000000000' AS first_recovery_fork_guid,
        '00000000-0000-0000-0000-000000000000' AS last_recovery_fork_guid                  
       
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND @WithRecovery_ = 1 
    AND ISNULL(fpc.ForkPoints,0) < 2
       
    --------------------------------------------------------------
    UNION -- CHECKDB
    --------------------------------------------------------------
    SELECT
     
        'DBCC CHECKDB(' + '''' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + '''' + ') WITH NO_INFOMSGS, ALL_ERRORMSGS' AS Command,
        1000002 AS Sequence,
        d.name AS database_name,
        '' AS BackupDevice,
        DATEADD(minute,1,GETDATE()) AS backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        '999999999999999999998' AS last_lsn,
        #CTE.fork_point_lsn,
        '00000000-0000-0000-0000-000000000000' AS first_recovery_fork_guid,
        '00000000-0000-0000-0000-000000000000' AS last_recovery_fork_guid                      
      
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND @WithCHECKDB_ = 1
    AND @WithRecovery_ = 1 
    AND ISNULL(fpc.ForkPoints,0) < 2
       
    --------------------------------------------------------------
    UNION -- Drop database after restore
    --------------------------------------------------------------
    SELECT
     
        -- Comment out all commands if multiple forking points exist 
        --CASE WHEN @CommentOut = 1 THEN '  -- Multipe backup fork points detected, command suppressed -- ' ELSE '' END +
     
       'DROP DATABASE [' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ']' + SPACE(1) AS Command,
        1000003 AS Sequence,
        d.name AS database_name,
        '' AS BackupDevice,
        GETDATE() AS backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        '999999999999999999999' AS last_lsn,
        #CTE.fork_point_lsn,
        '00000000-0000-0000-0000-000000000000' AS first_recovery_fork_guid,
        '00000000-0000-0000-0000-000000000000' AS last_recovery_fork_guid              
              
                       
       
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND @DropDatabaseAfterRestore_ = 1 
    AND ISNULL(fpc.ForkPoints,0) < 2
     
    --------------------------------------------------------------
    UNION -- RAISERROR suppress restore when multiple forkpoints exist
    --------------------------------------------------------------
    SELECT
     
       'RAISERROR (' + '''' + 'Multiple restores per performed between the selected full backup and stop at time for database ' + CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN d.[name] ELSE @TargetDatabase_ END + ' - Restore Gene processing aborted.' + '''' + ',0,0);' +  + SPACE(1) AS Command,
        1 AS Sequence,
        d.name AS database_name,
        '' AS BackupDevice,
        GETDATE() AS backupfinishdate,
        #CTE.backup_size,
        '000000000000000000000' AS first_lsn,
        '999999999999999999999' AS last_lsn,
        #CTE.fork_point_lsn,
        '00000000-0000-0000-0000-000000000000' AS first_recovery_fork_guid,
        '00000000-0000-0000-0000-000000000000' AS last_recovery_fork_guid              
              
    FROM sys.databases d 
       
    INNER JOIN #CTE
      ON #CTE.database_name = d.name 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND ISNULL(fpc.ForkPoints,0) > 1
     
    --------------------------------------------------------------
    UNION -- WITH MOVE secondary data files, allows for up to 32769/2 file groups
    --------------------------------------------------------------
     
    SELECT
     
        -- Comment out all commands if multiple forking points exist 
        --CASE WHEN @CommentOut = 1 THEN '  -- Multipe backup fork points detected, command suppressed -- ' ELSE '' END +
     
        '   ,MOVE N' + '''' + b.name + '''' + ' TO N' + '''' +
       
        CASE b.type_desc 
       
            WHEN 'ROWS' THEN
                CASE ISNULL(@WithMoveDataFiles_,'Actual')
                WHEN 'Actual' THEN CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN b.Physical_Name ELSE SUBSTRING(b.Physical_Name,1,CASE CHARINDEX('.',b.Physical_Name) WHEN 0 THEN LEN(b.Physical_Name) ELSE CHARINDEX('.',b.Physical_Name) - 1 END) + '_' + @TargetDatabase_ + '.ndf'  END
                ELSE CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN  @WithMoveDataFiles_ + SUBSTRING(b.Physical_Name,LEN(b.Physical_Name) - CHARINDEX('\',REVERSE(b.Physical_Name),1) + 2,CHARINDEX('\',REVERSE(b.Physical_Name),1) + 1)
                ELSE @WithMoveDataFiles_ + SUBSTRING (b.Physical_Name, (LEN(b.Physical_Name)-CHARINDEX('\',REVERSE(b.Physical_Name)) + 2),CHARINDEX('\',REVERSE(b.Physical_Name)) - 1 - CHARINDEX('.',REVERSE(b.Physical_Name))) +  '_' + @TargetDatabase_ + '.ndf'  END
            END 
       
            WHEN 'FILESTREAM' THEN
                CASE ISNULL(@WithMoveFileStreamFile_,'Actual')
                WHEN 'Actual' THEN CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN b.Physical_Name ELSE SUBSTRING(b.Physical_Name,1,CASE CHARINDEX('.',b.Physical_Name) WHEN 0 THEN LEN(b.Physical_Name) ELSE CHARINDEX('.',b.Physical_Name) - 1 END) + '_' + @TargetDatabase_ END
                ELSE CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN  @WithMoveFileStreamFile_ + SUBSTRING(b.Physical_Name,LEN(b.Physical_Name) - CHARINDEX('\',REVERSE(b.Physical_Name),1) + 2,CHARINDEX('\',REVERSE(b.Physical_Name),1) + 1)
                ELSE @WithMoveFileStreamFile_ + SUBSTRING (b.Physical_Name, (LEN(b.Physical_Name)-CHARINDEX('\',REVERSE(b.Physical_Name)) + 2),CHARINDEX('\',REVERSE(b.Physical_Name)) - 1 - CHARINDEX('.',REVERSE(b.Physical_Name))) +  '_' + @TargetDatabase_ END
            END  
       
            WHEN 'LOG' THEN
                CASE ISNULL(@WithMoveLogFile_,'Actual')
                WHEN 'Actual' THEN CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN b.Physical_Name ELSE SUBSTRING(b.Physical_Name,1,CASE CHARINDEX('.',b.Physical_Name) WHEN 0 THEN LEN(b.Physical_Name) ELSE CHARINDEX('.',b.Physical_Name) - 1 END) + '_' + @TargetDatabase_ + '.ldf' END
                ELSE CASE ISNULL(@TargetDatabase_,'') WHEN '' THEN  @WithMoveLogFile_ + SUBSTRING(b.Physical_Name,LEN(b.Physical_Name) - CHARINDEX('\',REVERSE(b.Physical_Name),1) + 2,CHARINDEX('\',REVERSE(b.Physical_Name),1) + 1)
                ELSE @WithMoveLogFile_ + SUBSTRING (b.Physical_Name, (LEN(b.Physical_Name)-CHARINDEX('\',REVERSE(b.Physical_Name)) + 2),CHARINDEX('\',REVERSE(b.Physical_Name)) - 1 - CHARINDEX('.',REVERSE(b.Physical_Name))) +  '_' + @TargetDatabase_ + '.ldf'  END 
       
            END  
       
        END
       
        + '''',
        b.file_id AS Sequence,
        DB_NAME(b.database_id) AS database_name,
        'SECONDARY FULL' AS BackupDevice,
        #CTE.backupfinishdate,
        #CTE.backup_size,
        #CTE.first_lsn,
        #CTE.last_lsn,
        #CTE.fork_point_lsn,
        #CTE.first_recovery_fork_guid,
        #CTE.last_recovery_fork_guid              
                  
    FROM sys.master_files b
    INNER JOIN #CTE
      ON #CTE.database_name = DB_NAME(b.database_id) 
     
    LEFT OUTER JOIN #ForkPointsCount fpc
        ON fpc.database_name = #CTE.database_name
     
    WHERE #CTE.[type] = 'D'
    AND b.type_desc IN ('ROWS','FILESTREAM','LOG')
    AND b.file_id > 2
    AND ISNULL(fpc.ForkPoints,0) < 2
       
    --------------------------------------------------------------
    ) a
    LEFT OUTER JOIN #tmpDatabases b
        ON a.database_name = b.DatabaseName
    -------------------------------------------------------------- 
       
    WHERE (@Database_ IS NULL OR b.Selected = 1 OR @Database_ = a.database_name)
    AND (@IncludeSystemDBs_ = 1 OR a.database_name NOT IN('master','model','msdb'))
    AND a.last_lsn >= @LogShippingLastLSN_;
       
    CREATE INDEX IDX_RestoreGeneResults ON #RestoreGeneResults (database_name,SortSequence,BackupDate);
       
    --------------------------------------------------------------
    -- Result Set
    IF @SuppressWithMove_ = 1
    BEGIN
        IF @RestoreScriptOnly_ = 0
        BEGIN
       
            SELECT x4.TSQL, x4.BackupDate, x4.BackupDevice, x4.first_lsn, x4.last_lsn, x4.fork_point_lsn, x4.first_recovery_fork_guid, x4.last_recovery_fork_guid, x4.database_name, x4.SortSequence
            FROM #RestoreGeneResults x4
            WHERE ISNULL(x4.BackupDevice,'') <> 'SECONDARY FULL'
            ORDER BY
                x4.database_name,
                x4.SortSequence,
                x4.BackupDate
        END
        ELSE
        BEGIN
            SELECT x4.TSQL AS [--TSQL]
            FROM #RestoreGeneResults x4
            WHERE ISNULL(x4.BackupDevice,'') <> 'SECONDARY FULL'
            ORDER BY
                x4.database_name,
                x4.SortSequence,
                x4.BackupDate
        END
    END
    ELSE
    BEGIN
        IF @PivotWithMove_ = 1
        BEGIN
       
            IF @RestoreScriptOnly_ = 0
            BEGIN
                SELECT
                    x4.TSQL, x4.BackupDate, x4.BackupDevice, x4.first_lsn, x4.last_lsn, x4.fork_point_lsn, x4.first_recovery_fork_guid, x4.last_recovery_fork_guid, x4.database_name, x4.SortSequence
                FROM #RestoreGeneResults x4
                ORDER BY
                    x4.database_name,
                    x4.SortSequence,
                    x4.BackupDate
            END
            ELSE
            BEGIN
                SELECT
                    x4.TSQL AS [--TSQL]
                FROM #RestoreGeneResults x4
                ORDER BY
                    x4.database_name,
                    x4.SortSequence,
                    x4.BackupDate
            END
       
        END
        ELSE
        BEGIN
            IF @RestoreScriptOnly_ = 0
            BEGIN
                WITH WithMoves AS
                (
                    SELECT
                        last_lsn,
                        STUFF((SELECT ' ' + TSQL FROM #RestoreGeneResults x3 WHERE x3.last_lsn = x2.last_lsn AND ISNULL(x3.BackupDevice,'') = 'SECONDARY FULL' ORDER BY x3.SortSequence FOR XML PATH, TYPE).value('.[1]', 'nvarchar(max)'), 1,1,'') AS WithoveCmds
                    FROM #RestoreGeneResults x2
                    GROUP BY last_lsn
                )
       
                SELECT
                    CASE @SuppressWithMove_ WHEN 0 THEN CASE ISNULL(x5.WithoveCmds,'') WHEN '' THEN x4.TSQL ELSE x4.TSQL + ' ' + x5.WithoveCmds END
                    ELSE x4.TSQL
                    END AS TSQL,
                    x4.BackupDate, x4.BackupDevice, x4.first_lsn, x4.last_lsn, x4.fork_point_lsn, x4.first_recovery_fork_guid, x4.last_recovery_fork_guid, x4.database_name, x4.SortSequence
                FROM #RestoreGeneResults x4
                LEFT OUTER JOIN WithMoves x5
                    ON x4.last_lsn = x5.last_lsn
                WHERE ISNULL(x4.BackupDevice,'') <> 'SECONDARY FULL'
                ORDER BY
                    x4.database_name,
                    x4.SortSequence,
                    x4.BackupDate
            END
            ELSE
            BEGIN
                WITH WithMoves AS
                (
                    SELECT
                        last_lsn,
                        STUFF((SELECT ' ' + TSQL FROM #RestoreGeneResults x3 WHERE x3.last_lsn = x2.last_lsn AND ISNULL(x3.BackupDevice,'') = 'SECONDARY FULL' ORDER BY x3.SortSequence FOR XML PATH, TYPE).value('.[1]', 'nvarchar(max)'), 1,1,'') AS WithoveCmds
                    FROM #RestoreGeneResults x2
                    GROUP BY last_lsn
                )
       
                SELECT
                    CASE @SuppressWithMove_ WHEN 0 THEN CASE ISNULL(x5.WithoveCmds,'') WHEN '' THEN x4.TSQL ELSE x4.TSQL + ' ' + x5.WithoveCmds END
                    ELSE x4.TSQL
                    END AS [--TSQL]
                FROM #RestoreGeneResults x4
                LEFT OUTER JOIN WithMoves x5
                    ON x4.last_lsn = x5.last_lsn
                WHERE ISNULL(x4.BackupDevice,'') <> 'SECONDARY FULL'
                ORDER BY
                    x4.database_name,
                    x4.SortSequence,
                    x4.BackupDate
            END
        END
    END
END       
GO
