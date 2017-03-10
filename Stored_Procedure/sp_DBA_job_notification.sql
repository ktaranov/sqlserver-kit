GO
/****** Object:  StoredProcedure [dbo].[spDBA_job_notification]    Script Date: 2/3/2017 7:50:51 AM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[spDBA_job_notification]
    @jobid UNIQUEIDENTIFIER
AS /*********************************************************************************************************
 Purpose: SQL Job Agent does not send the error messages on failure, 
           so this procedure queries msdb to for the error message and sends an email.
 
    usage: EXEC spDBA_job_notification $(ESCAPE_NONE(JOBID))		SQL2005 SP1 + 
********************************************************************************************************/
    SET  NOCOUNT ON;
    DECLARE @Today DATETIME
       ,@CrLf VARCHAR(10)
       ,@stat_Failed TINYINT
       ,@stat_Succeeded TINYINT
       ,@stat_Retry TINYINT
       ,@stat_Canceled TINYINT
       ,@stat_In_progress TINYINT;
    DECLARE @Email_To NVARCHAR(100) = 'You@youremailhost.ext'
       ,@Email_From NVARCHAR(50)
       ,@subject VARCHAR(200)
       ,@Body VARCHAR(8000);
    DECLARE @jobname sysname
       ,@stepname sysname
       ,@Err_severity INT
       ,@run_datetime DATETIME
       ,@DBname sysname
       ,@command VARCHAR(3200)
       ,@ErrMessage VARCHAR(1024)
       ,@retry BIT = 0;
    SET @Body = '';
    SET @CrLf = CHAR(10);
--constants for Job Status execution: 
    SET @stat_Failed = 0;
    SET @stat_Succeeded = 1;
    SET @stat_Retry = 2;
    SET @stat_Canceled = 3; 
    SET @stat_In_progress = 4; 
    SET @Today = GETDATE();
 
    DECLARE curFailedJobs CURSOR READ_ONLY FAST_FORWARD
    FOR
        SELECT  sj.name
               ,sjh.step_name
               ,sjh.sql_severity
               ,sjs.database_name
               ,run_datetime = CONVERT(DATETIME, LEFT(run_date, 4) + '/'
                + SUBSTRING(run_date, 5, 2) + '/' + RIGHT(run_date, 2) + ' '
                + LEFT(run_time, 2) + ':' + SUBSTRING(run_time, 3, 2) + ':'
                + RIGHT(run_time, 2))
               ,sjs.command
               ,sjh.message
        FROM    msdb..sysjobs sj
                JOIN ( SELECT   instance_id
                               ,job_id
                               ,step_id
                               ,step_name
                               ,sql_message_id
                               ,sql_severity
                               ,message
                               ,run_status
                               ,run_duration
                               ,operator_id_emailed
                               ,operator_id_netsent
                               ,operator_id_paged
                               ,retries_attempted
                               ,server
                               ,run_date = CONVERT(VARCHAR(8), run_date)
                               ,run_time = CASE WHEN LEN(CONVERT(VARCHAR(8), run_time)) = 5
                                                THEN '0'
                                                     + CONVERT(VARCHAR(8), run_time)
                                                ELSE CONVERT(VARCHAR(8), run_time)
                                           END
                       FROM     msdb..sysjobhistory
                     ) sjh ON sj.job_id = sjh.job_id
                JOIN msdb..sysjobsteps sjs ON sjs.job_id = sjh.job_id
                                              AND sjs.step_id = sjh.step_id 
	
			-- sjh_Min contains the most recent instance_id (an identity column) from where we should start checking for any failed status records.
                JOIN (  
			-- to account for when there is are multiple log history
                       SELECT   job_id
                               ,instance_id = MAX(instance_id)
                       FROM     msdb..sysjobhistory
                       WHERE    job_id = @jobid
                                AND step_id = 0
                       GROUP BY job_id
                       UNION  
           -- to account for when you run the job for the first time, there is no history, there will not be any records where the step_id=0.
                       SELECT   job_id
                               ,instance_id = MIN(instance_id)
                       FROM     msdb..sysjobhistory
                       WHERE    job_id = @jobid
                                AND NOT EXISTS ( SELECT *
                                                 FROM   msdb..sysjobhistory
                                                 WHERE  job_id = @jobid
                                                        AND step_id = 0 )
                       GROUP BY job_id
                     ) sjh_Min ON sjh_Min.job_id = sj.job_id
                                  AND sjh.instance_id > sjh_Min.instance_id -- we only want the most recent error message(s).
        WHERE   sj.job_id = @jobid
                AND sjh.step_id <> 0					 --exclude the job outcome step
                AND sjh.run_status IN ( @stat_Failed )  --filter for only failed status
        ORDER BY sjh.instance_id;
 
    OPEN curFailedJobs;
    FETCH NEXT FROM curFailedJobs INTO @jobname, @stepname, @Err_severity,
        @DBname, @run_datetime, @command, @ErrMessage; 
    WHILE @@fetch_status = 0
        BEGIN
	   -- Build the Email Body
            SET @Body = @Body + 'Step name= ' + @stepname + @CrLf
                + 'DB Name  = ' + CONVERT(VARCHAR(50), ISNULL(@DBname, ''))
                + @CrLf + 'Run Date = ' + CONVERT(VARCHAR(50), @run_datetime)
                + @CrLf; 
       			 
            IF ( @Err_severity <> 0 )
                SET @Body = @Body + 'Severity = '
                    + CONVERT(VARCHAR(10), @Err_severity) + @CrLf; 
 
            SET @Body = @Body + 'Error    = ' + ISNULL(@ErrMessage, '')
                + @CrLf + @CrLf + 'Command  = ' + ISNULL(@command, '') + @CrLf;  
 
            FETCH NEXT FROM curFailedJobs INTO @jobname, @stepname,
                @Err_severity, @DBname, @run_datetime, @command, @ErrMessage; 
        END;
    CLOSE curFailedJobs;
    DEALLOCATE curFailedJobs;
 
-- Send the Email
    IF ( RTRIM(@Body) <> '' )
        BEGIN 
            SET @subject = 'ALERT: ' + @jobname + ' FAILED on \\'
                + @@servername;
            SET @Body = -- 'Server= ' + @@servername + @CrLf  +
                'Job_name = ' + @jobname + @CrLf
                + '--------------------------------------' + @CrLf + @Body;
 
 
            EXEC msdb.dbo.sp_send_dbmail @profile_name = 'DBMAILPROFILE',
                @recipients = @Email_To, @subject = @subject, @body = @Body;  
   
        END;