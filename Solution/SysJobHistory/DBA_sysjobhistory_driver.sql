if exists (select * from sysobjects where id = object_id('DBA_sysjobhistory_driver') and sysstat & 0xf = 4)
DROP procedure dbo.DBA_sysjobhistory_driver
GO


CREATE PROCEDURE DBA_sysjobhistory_driver  
AS  
BEGIN  
	SET DEADLOCK_PRIORITY LOW
	DECLARE @job_id uniqueidentifier

  SET NOCOUNT ON  
  
--first, blindly set SQLAgent sysjobhistory to unlimited.  This shuts off sp_jobhistory_row_limiter
--which cuts down on waits and job blocking for larger customers.  
EXEC msdb.dbo.sp_set_sqlagent_properties @jobhistory_max_rows=-1, 
	@jobhistory_max_rows_per_job=-1
	
  
  DECLARE CURSER CURSOR FOR
	SELECT job_id 
	FROM v_sysjobs
  OPEN CURSER
  FETCH NEXT FROM CURSER INTO @job_id
  WHILE (@@FETCH_STATUS = 0)
  BEGIN
	--PRINT 'Running DBA_PM_sp_jobhistory_row_limiter for @job_id:  ' + convert(varchar(200),@job_id)
	EXEC DBA_sp_jobhistory_row_limiter @job_id = @job_id
	FETCH NEXT FROM CURSER INTO @job_id
  END
  CLOSE CURSER
  DEALLOCATE CURSER

  

END  