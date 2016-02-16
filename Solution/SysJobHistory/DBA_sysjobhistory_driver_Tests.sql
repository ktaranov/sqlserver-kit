/*

 shut down SFU or at least remove DBA_PM_Addin_sysjobhistory_purge from DBA_PM_CONFIG before executing these tests.  Otherwise
 who knows what will happen!!
	 
*/

EXEC tSQLt.DropClass 'DBA_PM_sysjobhistory_driver_Tests';
GO
CREATE SCHEMA DBA_PM_sysjobhistory_driver_Tests;
GO

CREATE PROC DBA_PM_sysjobhistory_driver_Tests.Arrange AS 
BEGIN	
	--fake out my views and tables
	EXEC tsqlt.FakeTable 'dbo','v_sysjobhistory'
	EXEC tsqlt.FakeTable 'dbo','v_sysjobs'
	EXEC tsqlt.FakeTable 'dbo','DBA_PM_sysjobhistory_config'
	
	--remove the identity column 
	--EXEC ('ALTER TABLE v_sysjobhistory DROP COLUMN instance_id')
	--EXEC ('ALTER TABLE v_sysjobhistory ADD instance_id INT NOT NULL;')
	
	--load up the config table
	INSERT INTO DBA_PM_sysjobhistory_config	VALUES (NULL,'Cat:30/90 days',30,90)
	INSERT INTO DBA_PM_sysjobhistory_config	VALUES ('(default)','(default)',180,360)
	INSERT INTO DBA_PM_sysjobhistory_config	VALUES ('SomeJob With Rapid Purging',NULL,1,3)
	
	--load up the rows into the faked "system" views
	EXEC DBA_PM_sysjobhistory_driver_Tests.ArrangeHistoryRows
	
END
GO
CREATE PROC DBA_PM_sysjobhistory_driver_Tests.ArrangeHistoryRows AS
BEGIN
	--load up v_sysjobs
	--do this in dynamic sql due to compile-time/run-time issues with TSQLT
		--Some Random Job/Whatever...we should get default purging since nothing is in the config table
		INSERT INTO v_sysjobs (CategoryName,job_id,JobName) VALUES ('Whatever','447F2E4D-8ADD-4341-95AB-1A1A42240701', 'Some Random Job')
		--Job To Test the Category/'Cat:30/90 days'...we should get category's purge params in this case
		INSERT INTO v_sysjobs (CategoryName,job_id,JobName) VALUES ('Cat:30/90 days','447F2E4D-8ADD-4341-95AB-1A1A42240702', 'Job To Test the Category')
		--'SomeJob With Rapid Purging'/'Cat:30/90 days'...we should get Job's purge params in this case...it will override the category
		INSERT INTO v_sysjobs (CategoryName,job_id,JobName) VALUES ('Cat:30/90 days','447F2E4D-8ADD-4341-95AB-1A1A42240703', 'SomeJob With Rapid Purging')
		--Job With Lots of History/Whatever...we should get default purging since nothing is in the config table.  This tests the DELETEs are occuring in "chunks" correctly.  
		INSERT INTO v_sysjobs (CategoryName,job_id,JobName) VALUES ('Whatever','447F2E4D-8ADD-4341-95AB-1A1A42240704', 'Job With Lots of History')

	--load up v_sysjobhistory	
		--Some Random Job
			--SUCCESS rows 
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1001,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-480),112),180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1002,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-181),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1003,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-182),112) ,180001,2)  --retry
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1004,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-183),112) ,180001,3)  --canceled
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1011,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-179),112) ,180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1012,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-2),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1013,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-1),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1014,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1015,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()+1),112),180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1016,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-200),112) ,180001,4) --In Progress 
			--FAILURE rows
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1021,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-361),112),180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1022,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-480),112) ,180001,0)
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1031,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-359),112) ,180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1032,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-180),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1033,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()-1),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1034,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (1035,'447F2E4D-8ADD-4341-95AB-1A1A42240701',convert(varchar(200),(getdate()+1),112),180001,0)
		--Job To Test the Category  (30/90)
			--SUCCESS rows 
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2001,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-480),112),180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2002,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-31),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2003,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-40),112) ,180001,2)  --retry
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2004,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-32),112) ,180001,3)  --canceled
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2011,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-29),112) ,180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2012,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-2),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2013,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-1),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2014,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2015,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()+1),112),180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2016,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-200),112) ,180001,4) --In Progress 
			--FAILURE rows
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2021,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-361),112),180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2022,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-91),112) ,180001,0)
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2031,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-89),112) ,180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2032,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-30),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2033,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()-1),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2034,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (2035,'447F2E4D-8ADD-4341-95AB-1A1A42240702',convert(varchar(200),(getdate()+1),112),180001,0)
		--SomeJob With Rapid Purging  (1,3)
			--SUCCESS rows 
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3001,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-480),112),180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3002,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-2),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3003,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-2),112) ,180001,2)  --retry
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3004,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-2),112) ,180001,3)  --canceled
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3011,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()),112) ,180001,1)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3012,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3013,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3014,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()),112) ,180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3015,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()+1),112),180001,1)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3016,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-200),112) ,180001,4) --In Progress 
			--FAILURE rows
				--should be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3021,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-361),112),180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3022,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-4),112) ,180001,0)
				--should not be purged
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3031,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-2),112) ,180001,0)  
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3032,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-2),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3033,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()-1),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3034,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()),112) ,180001,0)
				INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status) VALUES (3035,'447F2E4D-8ADD-4341-95AB-1A1A42240703',convert(varchar(200),(getdate()+1),112),180001,0)
		--Job With Lots of History (180/360)
			--SUCCESS rows 
				--should be purged
					INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status)
					SELECT 
						4001 + nums.number  --4001 to 6048
						,'447F2E4D-8ADD-4341-95AB-1A1A42240704'
						,convert(varchar(200),(getdate()-(182+ nums.number)),112)
						,180001
						,1  
					FROM master..spt_values nums
					WHERE nums.type = 'P' 
					AND nums.number < 2048
					ORDER BY nums.number	
				--should not be purged
					INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status)
					SELECT 
						7001 + nums.number  --7001 to 9048
						,'447F2E4D-8ADD-4341-95AB-1A1A42240704'
						,convert(varchar(200),(getdate()-(3)),112)
						,180001
						,1  
					FROM master..spt_values nums
					WHERE nums.type = 'P' 
					AND nums.number < 2048
					ORDER BY nums.number					
			--FAILURE rows
				--should be purged	
					INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status)
					SELECT 
						10001 + nums.number  --10001 to 12048
						,'447F2E4D-8ADD-4341-95AB-1A1A42240704'
						,convert(varchar(200),(getdate()-(361 + nums.number)),112)
						,180001
						,0  
					FROM master..spt_values nums
					WHERE nums.type = 'P' 
					AND nums.number < 2048
					ORDER BY nums.number					
				--should not be purged
					INSERT INTO v_sysjobhistory (instance_id,job_id,run_date,run_time,run_status)
					SELECT 
						13001 + nums.number  --13001 to 15048
						,'447F2E4D-8ADD-4341-95AB-1A1A42240704'
						,convert(varchar(200),(getdate()-(3)),112)
						,180001
						,0 
					FROM master..spt_values nums
					WHERE nums.type = 'P' 
					AND nums.number < 2048
					ORDER BY nums.number					

END;
GO

--TESTS
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_00 Set my sysjobhistory to unlimited if it is not already set that way]
AS 
BEGIN
	--ARRANGE
	
	--can't use tsqlt transaction handling due to blind COMMITs done in ms system procedures
	COMMIT TRAN 
	
	DECLARE @max_total_rows INT , @max_rows_per_job INT
	--EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--first set me up so I'm maintaining 100k/10k rows
	EXEC msdb.dbo.sp_set_sqlagent_properties @jobhistory_max_rows=100000, @jobhistory_max_rows_per_job=10000

	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--get my properties
	--Get max-job-history-rows from the registry  
	EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',  
										 N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',  
										 N'JobHistoryMaxRows',  
										 @max_total_rows OUTPUT,  
										 N'no_output'  
  
	--Get the per-job maximum number of rows to keep  
	EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',  
										 N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',  
										 N'JobHistoryMaxRowsPerJob',  
										 @max_rows_per_job OUTPUT,  
										 N'no_output'  
  
	--ASSERT
	-- Check if we are limiting sysjobhistory rows  
	EXEC tSQLt.AssertEquals -1 , @max_total_rows
	
	-- Check if we are limiting sysjobhistory job rows  
	EXEC tSQLt.AssertEquals 0 , @max_rows_per_job
	
	BEGIN TRAN
	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_01 Keeps my sysjobhistory at unlimited if so set]
AS 
BEGIN
	--ARRANGE
	
	--can't use tsqlt transaction handling due to blind COMMITs done in ms system procedures
	COMMIT TRAN 
	
	DECLARE @max_total_rows INT , @max_rows_per_job INT
	
	EXEC msdb.dbo.sp_set_sqlagent_properties @jobhistory_max_rows=-1, @jobhistory_max_rows_per_job=-1
	
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--get my properties
	--Get max-job-history-rows from the registry  
	EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',  
										 N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',  
										 N'JobHistoryMaxRows',  
										 @max_total_rows OUTPUT,  
										 N'no_output'  
  
	--Get the per-job maximum number of rows to keep  
	EXECUTE master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',  
										 N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',  
										 N'JobHistoryMaxRowsPerJob',  
										 @max_rows_per_job OUTPUT,  
										 N'no_output'  
										 
	--ASSERT
	-- Check if we are limiting sysjobhistory rows  
	EXEC tSQLt.AssertEquals -1 , @max_total_rows
	
	-- Check if we are limiting sysjobhistory job rows  
	EXEC tSQLt.AssertEquals 0 , @max_rows_per_job
	
	BEGIN TRAN 
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_11 (default) purging purges SUCCESS rows 1001-1004 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 1001 AND 1004)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_12 (default) purging leaves SUCCESS rows 1011-1016 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 1011 AND 1016)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_13 (default) purging purges FAILURE rows 1021-1022 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 1021 AND 1022)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_14 (default) purging leaves FAILURE rows 1031-1035 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 1031 AND 1035)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_21  category purging purges SUCCESS rows 2001-2004 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 2001 AND 2004)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_22  category purging leaves SUCCESS rows 2011-2016 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 2011 AND 2016)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_23  category purging purges FAILURE rows 2021-2022 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 2021 AND 2022)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_24  category purging leaves FAILURE rows 2031-2035 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 2031 AND 2035)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_31  job purging purges SUCCESS rows 3001-3004 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 3001 AND 3004)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_32  job purging leaves SUCCESS rows 3011-3016 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 3011 AND 3016)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_33  job purging purges FAILURE rows 3021-3022 that are too old]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 3021 AND 3022)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_34  job purging leaves FAILURE rows 3031-3035 that are too new]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 3031 AND 3035)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_41  BIG job purging purges SUCCESS rows 4001-6048 that are too old, this tests the DELETE with TOP loops]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 4001 AND 6048)
	BEGIN
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_42  BIG job purging leaves SUCCESS rows 7001-9048 that are too new, this tests the DELETE with TOP loops]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 7001 AND 9048)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_43  BIG job purging purges FAILURE rows 10001-12048 that are too old, this tests the DELETE with TOP loops]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 10001 AND 12048)
	BEGIN
		select * from v_sysjobhistory WHERE instance_id BETWEEN 10001 AND 12048
		EXEC tSQLt.Fail 'We have rows that should have been purged.  Oops.'
	END;	
END;
GO
CREATE PROCEDURE DBA_PM_sysjobhistory_driver_Tests.[test_44  BIG job purging leaves FAILURE rows 13001-15048 that are too new, this tests the DELETE with TOP loops]
AS 
BEGIN
	--ARRANGE
	EXEC DBA_PM_sysjobhistory_driver_Tests.Arrange
	
	--ACT
	EXEC DBA_PM_sysjobhistory_driver
	
	--ASSERT
	-- Check that the rows that should be deleted due to Config table settings are, in fact, being purged
	IF NOT EXISTS (select * from v_sysjobhistory WHERE instance_id BETWEEN 13001 AND 15048)
	BEGIN
		EXEC tSQLt.Fail 'We are missing rows that should not have been purged.  Oops.'
	END;	
END;
GO


EXEC tsqlt.RunTestClass 'DBA_PM_sysjobhistory_driver_Tests' 
GO
EXEC tSQLt.DropClass 'DBA_PM_sysjobhistory_driver_Tests';
GO
