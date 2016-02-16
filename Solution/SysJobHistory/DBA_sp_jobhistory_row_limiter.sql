/*
	this is more or less a copy of MS-provided sp_jobhistory_row_limiter.  
	we have merely changed the logic to find the config data in our config table vs the registry
	and to handle looping through deletes smartly.  
	no TABLOCKX 
	
	tests are in DBA_sysjobhistory_driver_Tests.sfu_dbo_test.sql
*/
if exists (select * from sysobjects where id = object_id('DBA_sp_jobhistory_row_limiter') and sysstat & 0xf = 4)
DROP procedure dbo.DBA_sp_jobhistory_row_limiter
GO


CREATE PROCEDURE DBA_sp_jobhistory_row_limiter  
  @job_id UNIQUEIDENTIFIER  
AS  
BEGIN  
	SET DEADLOCK_PRIORITY LOW
  DECLARE @NumDaysToRetain         INT 
  DECLARE @NumFailureDaysToRetain	INT
  DECLARE @LastDayToRetain         INT 
  DECLARE @LastFailureDayToRetain	INT
  DECLARE @RowsDeleted				INT
  
  SET NOCOUNT ON  
  
  

	-- Get the NumDaysToRetain and NumFailureDaysToRetain 
	-- FailSafe: maintain 30 days.   
	SELECT 
		--j.* , c_byJob.*, c_ByCat.* , c_Default.*
		@NumDaysToRetain = COALESCE(c_byJob.NumDaysToRetain,c_byCat.NumDaysToRetain,c_Default.NumDaysToRetain,30) ,
		@NumFailureDaysToRetain = COALESCE(c_byJob.NumFailureDaysToRetain,c_byCat.NumFailureDaysToRetain,c_Default.NumFailureDaysToRetain,30) 
	FROM v_sysjobs j
	LEFT JOIN DBA_sysjobhistory_config c_byJob     --first we prefer to JOIN first by JobName
		ON j.JobName = c_byJob.JobName
	LEFT JOIN DBA_sysjobhistory_config c_byCat     --next we prefer to JOIN first by Category
		ON j.CategoryName = c_byCat.CategoryName
	CROSS JOIN DBA_sysjobhistory_config c_Default   --last, get me the defaults.
	WHERE j.job_id = @job_id AND
	c_Default.JobName = '(default)' AND c_Default.CategoryName = '(default)'
	
	--get the actual date of the most recent rows that we wish to maintain.  
	--convert that to an INT so it works with msdb..sysjobhistory
	SELECT @LastDayToRetain = CONVERT(int,CONVERT(varchar(200),(GETDATE() - @NumDaysToRetain),112))
	SELECT @LastFailureDayToRetain = CONVERT(int,CONVERT(varchar(200),(GETDATE() - @NumFailureDaysToRetain),112))
	
	
	--DELETE sysjobhistory rows in a loop, keep going until we have nothing left to delete
	SELECT @RowsDeleted = 1
	WHILE (@RowsDeleted <> 0)
	BEGIN
		--handle SUCCESS case
		BEGIN TRAN
			DELETE TOP (1000) 
			FROM v_sysjobhistory WITH (READPAST)
			WHERE job_id = @job_id 
			AND run_status IN (1,2,3)   --Succeeded, Retry, and Canceled.  I view all of these as successes.
			AND run_date < @LastDayToRetain
			
			SELECT @RowsDeleted = @@ROWCOUNT;
			--PRINT 'SUCCESS rows deleted:  ' + convert(varchar(200),@RowsDeleted)
		COMMIT
		
		--handle FAILURE case
		BEGIN TRAN
			DELETE TOP (1000) 
			FROM v_sysjobhistory WITH (READPAST)
			WHERE job_id = @job_id 
			AND run_status IN (0)   --Failure
			AND run_date < @LastFailureDayToRetain
		COMMIT
		
		SELECT @RowsDeleted = CASE WHEN @@ROWCOUNT = 0 THEN @RowsDeleted ELSE @@ROWCOUNT END
		--PRINT 'FAILURE rows deleted (or successes from above):  ' + convert(varchar(200),@RowsDeleted)
		
		--catch your breath  
		--WAITFOR DELAY '00:00:01'
	END
	
  
  RETURN(0) -- Success  
END  