/*
<documentation>
  <summary>Create job to resume AG database data movement for suspended databases.
           Create alert to catch when data movement has been suspended, and run the job
  </summary>
  <returns>Create job to resume AG database data movement for suspended databases.</returns>
  <created>2020-08-06 by Wayne Sheffield</created>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Job_AG_Resume_Data_Movement.sql</sourceLink>
  <originalLink>https://blog.waynesheffield.com/wayne/archive/2020/08/availability-group-issues-fixed-with-alerts/</originalLink>
</documentation>
*/

USE msdb;
GO

BEGIN TRANSACTION;
DECLARE @ReturnCode INT;
SELECT @ReturnCode = 0;DECLARE @jobname sysname = N'AG - Resume Data Movement';
DECLARE @categoryname sysname = 'HADR-Availability Group';

IF EXISTS (SELECT name FROM dbo.sysjobs where name = @jobname)
BEGIN
EXECUTE msdb.dbo.sp_delete_job @job_name = @jobname;
END;

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=@categoryname AND category_class=1)
BEGIN
EXECUTE @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=@categoryname;
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
END;


EXECUTE @ReturnCode = msdb.dbo.sp_add_job
@job_name=@jobname,
@enabled=1,
@notify_level_eventlog=0,
@notify_level_email=2,
@notify_level_netsend=2,
@notify_level_page=2,
@delete_level=0,
@description=N'Resume data movement on suspended Availability Group databases.

This job can be run manually, or from an alert',
@category_name=N'HADR-Availability Group',
@owner_login_name=N'sa';
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_name=@jobname, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep
@job_name=@jobname,
@step_name=N'Resume data movement in AG databases',
@step_id=1,
@cmdexec_success_code=0,
@on_success_action=1,
@on_fail_action=2,
@retry_attempts=0,
@retry_interval=0,
@os_run_priority=0,
@subsystem=N'TSQL',
@command=N'DECLARE @SQLCMD VARCHAR(1000);
DECLARE cDBSuspended CURSOR FOR
SELECT ''ALTER DATABASE ['' + DB_NAME(database_id) + ''] SET HADR RESUME;''
FROM sys.dm_hadr_database_replica_states drs
JOIN sys.availability_replicas ar ON ar.replica_id = drs.replica_id
WHERE ar.replica_server_name = @@SERVERNAME
AND drs.is_suspended = 1;

OPEN cDBSuspended;
FETCH NEXT FROM cDBSuspended INTO @SQLCMD;
WHILE @@FETCH_STATUS = 0
BEGIN
EXECUTE (@SQLCMD);
FETCH NEXT FROM cDBSuspended INTO @SQLCMD;
END;
CLOSE cDBSuspended;
DEALLOCATE cDBSuspended;
',
@database_name=N'master',
@flags=0;
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;


EXECUTE @ReturnCode = msdb.dbo.sp_update_job
@job_name=@jobname,
@enabled=1,
@start_step_id=1,
@notify_level_eventlog=0,
@notify_level_email=2,
@notify_level_netsend=2,
@notify_level_page=2,
@delete_level=0,
@description=N'Resume data movement on suspended Availability Group databases.',
@category_name=N'HADR-Availability Group',
@owner_login_name=N'sa',
@notify_email_operator_name=N'',
@notify_netsend_operator_name=N'',
@notify_page_operator_name=N'';
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

DECLARE @alertname sysname = N'AG Data Movement suspended';
IF EXISTS (SELECT * FROM msdb.dbo.sysalerts WHERE name = @alertname)
BEGIN
EXECUTE @ReturnCode = msdb.dbo.sp_delete_alert @alertname;
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;
END;

/*
Alert text:
AlwaysOn Availability Groups data movement for database '%.*ls' has been suspended for the following reason: "%S_MSG" (Source ID %d; Source string: '%.*ls'). To resume data movement on the database, you will need to resume the database manually. For information about how to resume an availability database, see SQL Server Books Online.
*/
EXECUTE @ReturnCode = msdb.dbo.sp_add_alert
@name=@alertname,
@message_id=35264,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=0,
@job_name = @jobname;
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback;

COMMIT TRANSACTION;
GOTO EndSave
QuitWithRollback:
IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
EndSave:
GO
