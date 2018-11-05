/**********************************************************************************************
* PURPOSE  : This procedure set minimal File growth values for every datafiles and logfiles (SQL 2005 and above)
*            usp_SetFileGrowth _job is executed every 6h daily 
*            Create usp_SetFileGrowth stored procedure and usp_SetFileGrowth_job job. 
***********************************************************************************************/
IF OBJECT_ID('dbo.usp_SetFileGrowth', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.usp_SetFileGrowth AS SELECT 1');
GO

ALTER PROCEDURE usp_SetFileGrowth
(
    @datafilesize_lowerlimit INT,
    @datafilesize_upperlimit INT,
    @datafile_growth_target_lower INT,
    @datafile_growth_target_medium INT,
    @datafile_growth_target_upper INT,
    @logfilesize_lowerlimit INT,
    @logfilesize_upperlimit INT,
    @logfile_growth_target_lower INT,
    @logfile_growth_target_medium INT,
    @logfile_growth_target_upper INT
)
AS 
/*
*************************************************************************************************************
   Name           : dbo.usp_SetFileGrowth
   Purpose        : Set minimal autogrow values for datafiles and logfiles depending on the file size 
                    If autogrow is already set with higher value, nothing is done
                    If autogrow is disable, nothing is done
                    If autogrow is in percent, autogrow is set in MB
   Author         : Samuel HERVOUET
   Prerequisite   : None
   How to use it  : EXEC DBM_Toolbox.dbo.usp_SetFileGrowth @datafilesize_lowerlimit
                                                            ,@datafilesize_upperlimit
                                                            ,@datafile_growth_target_lower
                                                            ,@datafile_growth_target_medium
                                                            ,@datafile_growth_target_upper
                                                            ,@logfilesize_lowerlimit
                                                            ,@logfilesize_upperlimit
                                                            ,@logfile_growth_target_lower
                                                            ,@logfile_growth_target_medium
                                                            ,@logfile_growth_target_upper
   Examples       : EXEC DBM_Toolbox.dbo.usp_SetFileGrowth 400,2000,100,200,500,null,null,null,null,null
                        For Datafiles less than 400 MB, set 100 MB autogrow
                        For Datafiles between 400 MB and 2000 MB set 200 MB autogrow
                        For Datafiles greater than 2000 MB set 500 MB autogrow
                        
                    EXEC DBM_Toolbox.dbo.usp_SetFileGrowth null,null,null,null,null,1000,5000,200,500,1000
                        For Logfiles less than 1000 MB, set 200 MB autogrow
                        For Logfiles between 1000 MB and 5000 MB set 500 MB autogrow
                        For Logfiles greater than 5000 MB set 1000 MB autogrow
                        
                    EXEC DBM_Toolbox.dbo.usp_SetFileGrowth 400,2000,100,200,500,1000,5000,200,500,1000
                        Set autogrow for Datafiles AND Logfiles as explained in the 2 previous examples
                        
 Version          : 1.0
************************************************************************************************************
*/

/* -- For test only
DECLARE @datafilesize_lowerlimit INT
DECLARE @datafilesize_upperlimit INT
DECLARE @datafile_growth_target_lower INT
DECLARE @datafile_growth_target_medium INT
DECLARE @datafile_growth_target_upper INT
-----------
DECLARE @logfilesize_lowerlimit INT
DECLARE @logfilesize_upperlimit INT
DECLARE @logfile_growth_target_lower INT
DECLARE @logfile_growth_target_medium INT
DECLARE @logfile_growth_target_upper int

-------------------------------------------------
SET @datafilesize_lowerlimit = 400
SET @datafilesize_upperlimit = 2000
SET @datafile_growth_target_lower = 100
SET @datafile_growth_target_medium = 200
SET @datafile_growth_target_upper = 500
----------
SET @logfilesize_lowerlimit = 500
SET @logfilesize_upperlimit = 1000
SET @logfile_growth_target_lower = 200
SET @logfile_growth_target_medium = 500
SET @logfile_growth_target_upper = 1000
*/

SET NOCOUNT ON

PRINT '*********** Parameters ******************'
PRINT 'Datafiles size lower limit     : ' + convert(varchar(20), @datafilesize_lowerlimit) + ' MB'
PRINT 'Datafiles size upper limit     : ' + convert(varchar(20), @datafilesize_upperlimit) + ' MB'
PRINT 'Datafiles growth lower target  : ' + convert(varchar(20), @datafile_growth_target_lower) + ' MB'
PRINT 'Datafiles growth medium target : ' + convert(varchar(20), @datafile_growth_target_medium) + ' MB'
PRINT 'Datafiles growth upper target  : ' + convert(varchar(20), @datafile_growth_target_upper) + ' MB'
PRINT ' '
PRINT 'Logfiles size lower limit      : ' + convert(varchar(20), @logfilesize_lowerlimit) + ' MB'
PRINT 'Logfiles size upper limit      : ' + convert(varchar(20), @logfilesize_upperlimit) + ' MB'
PRINT 'Logfiles growth lower target   : ' + convert(varchar(20), @logfile_growth_target_lower) + ' MB'
PRINT 'Logfiles growth medium target  : ' + convert(varchar(20), @logfile_growth_target_medium) + ' MB'
PRINT 'Logfiles growth upper target   : ' + convert(varchar(20), @logfile_growth_target_upper) + ' MB'
PRINT '*****************************************'

-- Retrieve files informations
DECLARE @sql VARCHAR(8000)
SET @sql=' USE [?]
    SELECT ''?'' [Dbname]
        ,[name] [Filename]
        ,type_desc [Type]
        ,physical_name [FilePath]
        ,CONVERT(INT,[size]/128.0) [TotalSize_MB]
        ,CONVERT(INT,FILEPROPERTY(name, ''SpaceUsed''))/128.0 AS [Space_Used_MB]
        ,CASE is_percent_growth
        WHEN 1 THEN CONVERT(VARCHAR(5),growth)
        ELSE CONVERT(VARCHAR(20),(growth/128))
        END [Autogrow_Value]
        ,CASE is_percent_growth
        WHEN 1 THEN ''Pct''
        ELSE ''MB''
        END [Unit]
        ,CASE max_size
        WHEN -1 THEN CASE growth
        WHEN 0 THEN CONVERT(VARCHAR(30),''Restricted'')
        ELSE CONVERT(VARCHAR(30),''Unlimited'') END
        ELSE CONVERT(VARCHAR(25),max_size/128)
        END [Max_Size]
    FROM [?].sys.database_files'

-- Create temp table to store Files informations
IF EXISTS(SELECT 1 FROM tempdb..sysobjects WHERE name='##AutogrowthDetails') 
    DROP TABLE ##AutogrowthDetails
CREATE TABLE  ##AutogrowthDetails (
    Dbname VARCHAR(128)
    ,Filename VARCHAR(128)
    ,Type VARCHAR(10)
    ,Filepath VARCHAR(2000)
    ,TotalSize_MB INT
    ,Space_Used_MB INT
    ,Autogrow_Value VARCHAR(15)
    ,Unit VARCHAR(15)
    ,Max_Size VARCHAR(30)
)

INSERT INTO ##AutogrowthDetails EXEC sp_msforeachdb @sql

DECLARE @dbname varchar(8000)
DECLARE @file varchar(8000)
DECLARE @filename varchar(8000)
DECLARE @type varchar(20)
DECLARE @totalsizemb int
DECLARE @autogrowthvalue varchar(20)
DECLARE @filegrowth_target varchar(20)
DECLARE @sql2 varchar(8000)

-- Set file autogrow value depending on thresholds
DECLARE SetAutogrowthSize cursor for 
    SELECT dbname, filename, type, TotalSize_MB, Autogrow_Value 
    FROM ##AutogrowthDetails  
    WHERE dbname not in ('master','msdb','tempdb','model')
        AND dbname IN (select name from sys.databases where state_desc = 'ONLINE')
        AND Autogrow_Value <> 0
        AND (
                (
                    (TotalSize_MB < @datafilesize_lowerlimit AND Autogrow_Value < @datafile_growth_target_lower and type = 'ROWS') 
                    OR 
                    ((TotalSize_MB BETWEEN @datafilesize_lowerlimit AND @datafilesize_upperlimit) AND Autogrow_Value < @datafile_growth_target_medium AND type = 'ROWS')
                    OR
                    (TotalSize_MB > @datafilesize_upperlimit  AND Autogrow_Value < @datafile_growth_target_upper AND type = 'ROWS')
                ) 
                OR 
                (
                    (TotalSize_MB < @logfilesize_lowerlimit AND Autogrow_Value < @logfile_growth_target_lower and type = 'LOG') 
                    OR 
                    ((TotalSize_MB BETWEEN @logfilesize_lowerlimit AND @logfilesize_upperlimit) AND Autogrow_Value < @logfile_growth_target_medium AND type = 'LOG')
                    OR
                    (TotalSize_MB > @logfilesize_upperlimit AND Autogrow_Value < @logfile_growth_target_upper AND type = 'LOG')
                ) 
            )
        ORDER BY dbname, filename

OPEN SetAutogrowthSize
FETCH NEXT FROM SetAutogrowthSize INTO @dbname, @file, @type, @totalsizemb, @autogrowthvalue
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @type = 'ROWS' AND (@totalsizemb < @datafilesize_lowerlimit  AND @autogrowthvalue < @datafile_growth_target_lower) 
        SET @filegrowth_target = @datafile_growth_target_lower
    IF @type = 'ROWS' AND ((@totalsizemb between @datafilesize_lowerlimit AND @datafilesize_upperlimit) AND @autogrowthvalue < @datafile_growth_target_medium)
        SET @filegrowth_target = @datafile_growth_target_medium
    IF @type = 'ROWS' AND ((@totalsizemb = @datafilesize_upperlimit OR @totalsizemb > @datafilesize_upperlimit) AND @autogrowthvalue < @datafile_growth_target_upper)
        SET @filegrowth_target = @datafile_growth_target_upper
    IF @type = 'LOG'  AND (@totalsizemb < @logfilesize_lowerlimit  AND @autogrowthvalue < @logfile_growth_target_lower)
        SET @filegrowth_target = @logfile_growth_target_lower
    IF @type = 'LOG'  AND ((@totalsizemb between @logfilesize_lowerlimit AND @logfilesize_upperlimit) AND @autogrowthvalue < @logfile_growth_target_medium)
        SET @filegrowth_target = @logfile_growth_target_medium
    IF @type = 'LOG'  AND ((@totalsizemb = @logfilesize_upperlimit OR @totalsizemb > @logfilesize_upperlimit) AND @autogrowthvalue < @logfile_growth_target_upper)
        SET @filegrowth_target = @logfile_growth_target_upper

    SET @sql2 = 'ALTER DATABASE ['+ @dbname + '] MODIFY FILE (NAME = '''+@file+''', FILEGROWTH =' +@filegrowth_target + ')'
     
    Print '********************************************************************************************************************************************'
    Print '| Database Name: ' + @dbname + ' | Logical File Name: ' +  @file + ' | File Type: ' +   @type + ' | Current Size: ' +   convert(varchar(20), @totalsizemb) + ' MB | Current Growth increment: ' +  @autogrowthvalue
    Print '| Process will update filegrowth size from ' + convert(varchar(20), @autogrowthvalue) + ' to ' + convert(varchar(20), @filegrowth_target) + ' MB'
    Print '| Executing following ALTER command: '
    Print '| '+ @sql2
    Print '********************************************************************************************************************************************'
    Print ' '
    exec (@sql2)
     
    FETCH NEXT FROM SetAutogrowthSize INTO @dbname, @file, @type, @totalsizemb, @autogrowthvalue
END

CLOSE SetAutogrowthSize
DEALLOCATE SetAutogrowthSize
GO


-------------------------------------
-- Job creation (scheduled every 6h)
-------------------------------------
PRINT 'usp_SetFileGrowth_job job creation'
USE [msdb]
GO

IF EXISTS (SELECT name FROM  [msdb].[dbo].[sysjobs] WHERE name = 'usp_SetFileGrowth_job')
BEGIN
    PRINT 'Replace usp_SetFileGrowth_job'
    EXEC msdb.dbo.sp_delete_job @job_name = N'usp_SetFileGrowth_job' ;
END
GO

DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'usp_SetFileGrowth_job',
        @enabled=1,
        @notify_level_eventlog=0,
        @notify_level_email=2,
        @notify_level_netsend=2,
        @notify_level_page=2,
        @delete_level=0,
        @category_name=N'Database Maintenance',
        @owner_login_name=N'sa', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'usp_SetFileGrowth_job', @server_name = N'(LOCAL)'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'usp_SetFileGrowth_job', @step_name=N'usp_SetFileGrowth_job - Step 1',
        @step_id=1,
        @cmdexec_success_code=0,
        @on_success_action=1,
        @on_fail_action=2,
        @retry_attempts=0,
        @retry_interval=0,
        @os_run_priority=0, @subsystem=N'TSQL',
        @command=N'EXEC DBM_Toolbox.dbo.usp_SetFileGrowth 400,2000,100,200,500,1000,5000,100,500,1000
GO',
        @database_name=N'DBM_Toolbox',
        @flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'usp_SetFileGrowth_job',
        @enabled=1,
        @start_step_id=1,
        @notify_level_eventlog=0,
        @notify_level_email=2,
        @notify_level_netsend=2,
        @notify_level_page=2,
        @delete_level=0,
        @description=N'DISTRIBUTED-DB',
        @category_name=N'Database Maintenance',
        @owner_login_name=N'sa',
        @notify_email_operator_name=N'',
        @notify_netsend_operator_name=N'',
        @notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'usp_SetFileGrowth_job', @name=N'Every6h',
        @enabled=1,
        @freq_type=4,
        @freq_interval=1,
        @freq_subday_type=8,
        @freq_subday_interval=6,
        @freq_relative_interval=0,
        @freq_recurrence_factor=1,
        @active_start_date=20131125,
        @active_end_date=99991231,
        @active_start_time=0,
        @active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
