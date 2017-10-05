/*
Author: Allen McGuire
Source link: http://allen-mcguire.blogspot.ru/2017/08/monitor-and-stop-long-running-sql.html
*/

DECLARE @Duration_secs INT;
DECLARE @JobName SYSNAME;

DECLARE @LongRunningJobs TABLE(
      DurationSecs  INT     NOT NULL
    , JobName       SYSNAME NOT NULL
    , TSQLStatement NVARCHAR(300) NOT NULL
);

INSERT INTO @LongRunningJobs(DurationSecs, JobName, TSQLStatement)
SELECT DATEDIFF(ss, ja.start_execution_date, GETDATE()) AS Duration_secs
     , jobs.name AS JobName
     , 'EXEC msdb.dbo.sp_stop_job N''' + jobs.name + '''' AS TSQLStatement
FROM   msdb.dbo.sysjobs jobs
       LEFT JOIN msdb.dbo.sysjobactivity ja ON ja.job_id = jobs.job_id
            AND ja.start_execution_date IS NOT NULL
WHERE  -- jobs.name = 'Distribution clean up: distribution'
       -- AND
       stop_execution_date IS NULL;

SELECT * FROM @LongRunningJobs;

/*
USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'Test', 
        @enabled=1, 
        @notify_level_eventlog=0, 
        @notify_level_email=2, 
        @notify_level_page=2, 
        @delete_level=0, 
        @category_name=N'[Uncategorized (Local)]', 
        @owner_login_name=N'sa', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'Test', @server_name = @@SERVERNAME;
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'Test', @step_name=N'wait_20_seconds', 
        @step_id=1, 
        @cmdexec_success_code=0, 
        @on_success_action=1, 
        @on_fail_action=2, 
        @retry_attempts=0, 
        @retry_interval=0, 
        @os_run_priority=0, @subsystem=N'TSQL', 
        @command=N'WAITFOR DELAY ''00:00:59'';', 
        @database_name=N'master', 
        @flags=0
GO

DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_id=N'f0cc44dc-4718-4b66-8d47-bd6f86c9c513', @name=N'Test_schedule_every_minute', 
        @enabled=1, 
        @freq_type=4, 
        @freq_interval=1, 
        @freq_subday_type=4, 
        @freq_subday_interval=1, 
        @freq_relative_interval=0, 
        @freq_recurrence_factor=1, 
        @active_start_date=20170904, 
        @active_end_date=99991231, 
        @active_start_time=0, 
        @active_end_time=235959, @schedule_id = @schedule_id OUTPUT
SELECT @schedule_id;
GO

EXEC msdb.dbo.sp_delete_job @job_name = N'Test';
*/