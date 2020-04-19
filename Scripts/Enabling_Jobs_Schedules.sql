/*
<documentation>
  <summary>Enabling Jobs Shedules.</summary>
  <returns>None.</returns>
  <created>2018-12-11 by Jon Shaulis</created>
  <modified>2020-04-19 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Enabling_Jobs_Schedules.sql.sql</sourceLink>
  <originalLink>https://jonshaulis.com/index.php/2018/12/11/how-to-stop-the-sql-scheduler-with-t-sql/</originalLink>
</documentation>
*/


USE MSDB;
GO

/*******************************************************************************
 Check for history table. This physical table tells us what jobs we are going to
 enable the scheduler for.
*******************************************************************************/

IF OBJECT_ID('dbo.JobsEnabledTracker', 'U') IS NOT NULL
BEGIN
	IF EXISTS
	(
		SELECT 1
		FROM [dbo].[JobsEnabledTracker]
		WHERE [enabled] = 0
	)
	BEGIN
		PRINT 'Jobs disabled in history table: dbo.JobsEnabledTracker found.';

/**********************************************************************************
 Table variable to hold schedules and jobs enabled. This is important for the loop.
**********************************************************************************/

		DECLARE @JobsEnabled TABLE
		( 
		[Id] int PRIMARY KEY IDENTITY(1, 1)
		, [job_id] uniqueidentifier
		, [schedule_id] bigint
		, [enabled] bit
		);

/*******************************************************************************
 Insert schedules that we had disabled that we need to go back in and re-enable.
*******************************************************************************/

		INSERT INTO @JobsEnabled( [job_id], [schedule_id], [enabled] )
			   SELECT [job_id], [schedule_id], [enabled]
			   FROM [dbo].[JobsEnabledTracker];

/********************************
 Holds the job id and schedule id
********************************/

		DECLARE @jobid uniqueidentifier;
		DECLARE @scheduleid bigint;

/***********************************
 Holds the ID of the row in the loop
***********************************/

		DECLARE @ID int= 0;

/**********************
 Check if records exist
**********************/

		IF EXISTS
		(
			SELECT [Id]
			FROM @JobsEnabled
		)
		BEGIN
			PRINT 'Loop mode, jobs found disabled.';

/**********
 Begin loop
**********/

			WHILE 1 = 1
			BEGIN

/***************************************
 Grab jobid, scheduleid, and id of rows.
***************************************/

				SELECT @jobid =
				(
					SELECT TOP 1 [job_id]
					FROM @JobsEnabled
					ORDER BY [job_id]
				);
				SELECT @scheduleid =
				(
					SELECT TOP 1 [schedule_id]
					FROM @JobsEnabled
					ORDER BY [job_id]
				);
				SELECT @ID =
				(
					SELECT TOP 1 [Id]
					FROM @JobsEnabled
					ORDER BY [job_id]
				);

/***************************************
 Re-enable schedule associated to job			
***************************************/

				PRINT 'Enabling schedule_id: '+CAST(@scheduleid AS varchar(255))+' paired to job_id: '+CAST(@jobid AS varchar(255));
				EXEC [sp_update_schedule] @schedule_id = @scheduleid, @enabled = 1;

/*********************
 Removes row from loop
*********************/

				DELETE FROM @JobsEnabled
				WHERE [Id] = @ID;

/***********************
 Set job back to enabled
***********************/

				UPDATE [dbo].[JobsEnabledTracker]
				  SET [enabled] = 1
				WHERE [job_id] = @jobid AND 
					  [schedule_id] = @scheduleid;

/****************************
 No more rows, stops deleting
****************************/

				IF
				(
					SELECT COUNT(*)
					FROM @JobsEnabled
				) <= 0
				BEGIN
					BREAK;
				END;

/********
 End Loop
********/
			END;
			PRINT 'Exiting loop, enabling schedules paired to jobs complete.';

/**********
 End elseif
**********/
		END;
		ELSE
		BEGIN
			PRINT 'All done';
		END;
	END;
	ELSE
	BEGIN
		PRINT 'dbo.JobsEnabledTracker has no disabled jobs currently.';
	END;
END;
ELSE
BEGIN
	PRINT 'dbo.JobsEnabledTracker is NULL, you may need to run the first script to create and populate this table.';
END;
