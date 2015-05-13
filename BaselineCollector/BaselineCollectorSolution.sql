/*********************************************************************************************
Written by Robert Virag

Comprehensive Baseline Collecting Solution V1.1

Change History

Changes in V1.1 - 2015.04

	<>Collectors
		() New collector: sp_CollectInstanceInfo
	<>New Schedules added
		() marked with '*' below
	<>BugFix
		() sp_CollectDatabaseInfo - SQL2014
		() @Retention = NULL
		() CollectingInterval/SampleInterval/MeasuringInterval type, possible value range
		() AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP
		() Job output file name (@OutputFile0X)
		() sp_CollectWaitStats - @ResetWaitStats = 0 If @MeasuringInterval is specified

V1 Original Release - 2014.09 

---//---

Collectors:
	sp_CollectConfigData 
	sp_CollectDatabaseInfo 
	sp_CollectFileInfo 
	sp_CollectIOVFStats 
	sp_CollectPerfmonData 
	sp_CollectTempDBUsage 
	sp_CollectWaitStats
	*sp_CollectInstanceInfo

Schedules:
	baseline - daily - at 2359PM
	baseline - daily - at 2357PM
	baseline - daily - at 2355PM
	*baseline - daily - at 2353PM
	*baseline - daily - at 2351PM

	*baseline - daily - every 5 mins
	*baseline - daily - every 5 mins - BT/6AM-7PM/
	baseline - daily - every 10 mins
	baseline - daily - every 10 mins - BT/6AM-7PM/
	baseline - daily - every 15 mins
	baseline - daily - every 15 mins - BT/6AM-7PM/
	*baseline - daily - every 30 mins
	*baseline - daily - every 30 mins - BT/6AM-7PM/
	baseline - daily - every 1 hour
	baseline - daily - every 1 hour - BT/6AM-7PM/
	*baseline - daily - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/
	baseline - daily - every 8 hours /6AM/2PM/10PM/
	baseline - daily - evey 12 hours /6AM/6PM/

	*baseline - weekday - every 5 mins
	*baseline - weekday - every 5 mins - BT/6AM-7PM/
	baseline - weekday - every 10 mins
	baseline - weekday - every 10 mins - BT/6AM-7PM/
	baseline - weekday - every 15 mins
	baseline - weekday - every 15 mins - BT/6AM-7PM/
	*baseline - weekday - every 30 mins
	*baseline - weekday - every 30 mins - BT/6AM-7PM/
	baseline - weekday - every 1 hour
	baseline - weekday - every 1 hour - BT/6AM-7PM/
	*baseline - weekday - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	baseline - weekday - every 6 hours /6AM/12PM/6PM/12AM/
	baseline - weekday - every 8 hours /6AM/2PM/10PM/
	baseline - weekday - evey 12 hours /6AM/6PM/

	*baseline - weekend - every 5 mins
	baseline - weekend - every 10 mins
	baseline - weekend - every 15 mins
	baseline - weekend - every 30 mins
	baseline - weekend - every 1 hour
	baseline - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	baseline - weekend - every 6 hours /6AM/12PM/6PM/12AM/
	baseline - weekend - every 8 hours /6AM/2PM/10PM/
	baseline - weekend - evey 12 hours /6AM/6PM/

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014

Summary:
Collect SQL Server Baseline (Raw) Data

----

For scheduling the collectors with agent jobs, Ola Hallengren's code is used
with his permission.

http://ola.hallengren.com/license.html

License:

Copyright (c) 2014 Robert Virag | SQLApprentice.net

Permission is hereby granted, free of charge, to any person 
obtaining a copy of this software and associated documentation 
files (the “Software”), to deal in the Software without 
restriction, including without limitation the rights to use, 
copy, modify, merge, publish, distribute, sublicense, and/or 
sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*********************************************************************************************/

IF(NOT EXISTS (SELECT [name] FROM [sys].[databases] WHERE [name] = 'BaselineDB'))
BEGIN
	CREATE DATABASE [BaselineDB]
END
GO

IF OBJECT_ID (N'tempdb..#TempConfiguration' ) IS NOT NULL
BEGIN
	DROP TABLE #TempConfiguration
END

CREATE TABLE #TempConfiguration
	(
		[variable] NVARCHAR(128),
		[value] NVARCHAR(max)
	)

USE [BaselineDB]	---------------------------------------------------- modify
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET NOCOUNT ON
GO

/*--------------------------------------------
-- Settings variables
--------------------------------------------*/
DECLARE @CreateJobs TINYINT
DECLARE @CreateSchedules TINYINT
DECLARE @OutputFileDirectory nvarchar(max)

DECLARE @SQLCommand NVARCHAR(max)
DECLARE @TableName NVARCHAR(255)
DECLARE @DataCompression BIT
DECLARE @DropTableIfExist BIT
DECLARE @DropJobsIfExist TINYINT
DECLARE @DropScheduleIfExist TINYINT

SET @CreateJobs = 1	---------------------------------------------------- modify
/* Schedules will be DISABLED and will not be mapped to jobs!!! */
SET @CreateSchedules = 1 ----------------------------------------------- modify
/* One log file per day per job will be created */
SET @OutputFileDirectory = N'E:\BaselineLogs'	------------------------ modify

SET @DropJobsIfExist = 1 ----------------------------------------------- modify
SET @DropScheduleIfExist = 1 ------------------------------------------- modify
SET @DropTableIfExist = 1	-------------------------------------------- modify
SET @DataCompression = 1	-------------------------------------------- modify

INSERT INTO #TempConfiguration ([variable], [value]) VALUES 
(N'@CreateJobs', CAST(@CreateJobs AS nvarchar))
INSERT INTO #TempConfiguration ([variable], [value]) VALUES 
(N'@DropJobsIfExist', CAST(@DropJobsIfExist AS nvarchar))

INSERT INTO #TempConfiguration ([variable], [value]) VALUES 
(N'@OutputFileDirectory', @OutputFileDirectory)

INSERT INTO #TempConfiguration ([variable], [value]) VALUES 
(N'@CreateSchedules', CAST(@CreateSchedules AS nvarchar))
INSERT INTO #TempConfiguration ([variable], [value]) VALUES 
(N'@DropScheduleIfExist', CAST(@DropScheduleIfExist AS nvarchar))

/************************************START*************************************
******************************** CREATE SCHEMA ********************************
******************************************************************************/

/*--------------------------------------------
-- Create Table for Instance Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[instance_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[instance_info]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[instance_info]
	(
		[capture_date] DATETIME NOT NULL,
		[name] NVARCHAR(50) NOT NULL,
		[value] SQL_VARIANT NULL,
		[is_initial] BIT NOT NULL, 
		[is_pre] BIT NOT NULL 
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_instance_info] ON [dbo].[instance_info] ([capture_date],[name])


/*--------------------------------------------
-- Create Table for Server Configuration 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[configuration_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[configuration_data]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[configuration_data]
	(
		[capture_date] DATETIME NOT NULL,
		[configuration_id] INT NOT NULL,
		[value] SQL_VARIANT NULL,
		[value_in_use] SQL_VARIANT NULL,
		[is_initial] BIT, 
		[is_pre] BIT 
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_configuration_data] ON [dbo].[configuration_data] ([capture_date],[configuration_id])

/*--------------------------------------------
-- Create Table for Database Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[database_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[database_info]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[database_info]
	(
		[capture_date] DATETIME,
		[database_name] SYSNAME,
		[database_id] INT,
		[source_database_id] INT,
		[owner_sid] VARBINARY(85),
		[create_date] DATETIME,
		[compatibility_level] TINYINT,
		[collation_name] SYSNAME,
		[user_access] TINYINT,
		[is_read_only] BIT,
		[is_auto_close_on] BIT,
		[is_auto_shrink_on] BIT,
		[state] TINYINT,
		[is_in_standby] BIT,
		[is_supplemental_logging_enabled] BIT,
		[snapshot_isolation_state] TINYINT,
		[is_read_committed_snapshot_on] BIT,
		[recovery_model] TINYINT,
		[page_verify_option] TINYINT,
		[is_auto_create_stats_on] BIT,
		[is_auto_update_stats_on] BIT,
		[is_auto_update_stats_async_on] BIT,
		[is_ansi_null_default_on] BIT,
		[is_ansi_nulls_on] BIT,
		[is_ansi_padding_on] BIT,
		[is_ansi_warnings_on] BIT,
		[is_arithabort_on] BIT,
		[is_concat_null_yields_null_on] BIT,
		[is_numeric_roundabort_on] BIT,
		[is_quoted_identifier_on] BIT,
		[is_recursive_triggers_on] BIT,
		[is_cursor_close_on_commit_on] BIT,
		[is_local_cursor_default] BIT,
		[is_fulltext_enabled] BIT,
		[is_trustworthy_on] BIT,
		[is_db_chaining_on] BIT,
		[is_parameterization_forced] BIT,
		[is_master_key_encrypted_by_server] BIT,
		[is_published] BIT,
		[is_merge_published] BIT,
		[is_distributor] BIT,
		[is_sync_with_backup] BIT,
		[service_broker_guid] UNIQUEIDENTIFIER,
		[is_broker_enabled] BIT,
		[is_date_correlation_on] BIT '

IF(@@VERSION LIKE N'%Microsoft SQL Server 2005%')
BEGIN
	SET @SQLCommand = @SQLCommand + N',
	[is_initial] BIT, 
	[is_pre] BIT 
	) '
END

IF(@@VERSION LIKE N'%Microsoft SQL Server 2008%')
BEGIN
	SET @SQLCommand = @SQLCommand + N',
	/*2008*/
	[is_cdc_enabled] BIT, 
	[is_encrypted] BIT, 
	[is_honor_broker_priority_on] BIT, 
	[is_initial] BIT, 
	[is_pre] BIT
	) '
END

IF(@@VERSION LIKE N'%Microsoft SQL Server 2012%')
BEGIN
	SET @SQLCommand = @SQLCommand + N',
	/*2008*/
	[is_cdc_enabled] BIT,
	[is_encrypted] BIT,
	[is_honor_broker_priority_on] BIT,
	/*2012*/
	[replica_id] UNIQUEIDENTIFIER,
	[group_database_id] UNIQUEIDENTIFIER,
	[default_language_lcid] SMALLINT, 
	[default_fulltext_language_lcid] INT, 
	[is_nested_triggers_on] BIT, 
	[is_transform_noise_words_on] BIT,
	[two_digit_year_cutoff] SMALLINT, 
	[containment] TINYINT,  
	[target_recovery_time_in_seconds] INT, 
	[is_initial] BIT, 
	[is_pre] BIT
	) '
END

IF(@@VERSION LIKE N'%Microsoft SQL Server 2014%')
BEGIN
	SET @SQLCommand = @SQLCommand + N',
	/*2008*/
	[is_cdc_enabled] BIT,
	[is_encrypted] BIT,
	[is_honor_broker_priority_on] BIT,
	/*2012*/
	[replica_id] UNIQUEIDENTIFIER,
	[group_database_id] UNIQUEIDENTIFIER,
	[default_language_lcid] SMALLINT, 
	[default_fulltext_language_lcid] INT, 
	[is_nested_triggers_on] BIT, 
	[is_transform_noise_words_on] BIT,
	[two_digit_year_cutoff] SMALLINT, 
	[containment] TINYINT,  
	[target_recovery_time_in_seconds] INT,
	/*2014*/
	[is_auto_create_stats_incremental_on] BIT, 
	[is_query_store_on] BIT, 
	[resource_pool_id] INT, 
	[delayed_durability] INT,
	[is_memory_optimized_elevate_to_snapshot_on] BIT,
	[is_initial] BIT, 
	[is_pre] BIT 
	) '
END

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'	
END

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_database_info] ON [dbo].[database_info] ([capture_date], [database_name])

/*--------------------------------------------
-- Create Table for File Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[file_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[file_info]
END
IF(OBJECT_ID('[dbo].[ts_file_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_file_info]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[file_info]
	(
		[capture_date] DATETIME,
		[database_name] SYSNAME,
		[physical_name] NVARCHAR(260),
		[type] TINYINT,
		[size_pages] INT,
		[space_used_pages] INT,
		[max_size_pages] INT,
		[growth_pages_percent] INT,
		[is_percent_growth] BIT
	) '
IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'	
END

EXEC sp_executesql @SQLCommand

SET @SQLCommand = REPLACE(@SQLCommand, N'[file_info]', N'[ts_file_info]')

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_file_info] ON [dbo].[file_info] ([capture_date],[physical_name])

CREATE UNIQUE CLUSTERED INDEX [CI_ts_file_info] ON [dbo].[ts_file_info] ([capture_date],[physical_name])

/*--------------------------------------------
-- Create Table for IO Virtual File Stats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[iovf_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[iovf_stats]
END
IF(OBJECT_ID('[dbo].[ts_iovf_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_iovf_stats]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[iovf_stats]
	(
		[capture_date] DATETIME,
		[database_name] SYSNAME,
		[type] TINYINT,
		[physical_name] NVARCHAR(260),
		[sample_ms] INT,
		[num_of_reads] BIGINT,
		[num_of_bytes_read] BIGINT,
		[io_stall_read_ms] BIGINT,
		[num_of_writes] BIGINT,
		[num_of_bytes_written] BIGINT,
		[io_stall_write_ms] BIGINT
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

SET @SQLCommand = REPLACE(@SQLCommand, N'[iovf_stats]', N'[ts_iovf_stats]')

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_iovf_stats] ON [dbo].[iovf_stats] ([capture_date],[physical_name])

CREATE UNIQUE CLUSTERED INDEX [CI_ts_iovf_stats] ON [dbo].[ts_iovf_stats] ([capture_date],[physical_name])

/*-------------------------------------------------------
-- Table for Filtering Database's Files
-------------------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_database_file]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_database_file]
END
CREATE TABLE [dbo].[filter_database_file]
(
	[id] INT IDENTITY(1,1),
	[database_name] SYSNAME,
	[logical_file_name] SYSNAME,
	[is_excluded_file_info] BIT, 
	[ts_is_included_file_info] BIT,
	[is_excluded_iovf] BIT,
	[ts_is_included_iovf] BIT
)

/*--------------------------------------------
-- Insert all databases
--------------------------------------------*/
INSERT INTO [dbo].[filter_database_file]
( [database_name], [logical_file_name], [is_excluded_file_info], [ts_is_included_file_info], [is_excluded_iovf], [ts_is_included_iovf] )
SELECT DB_NAME(database_id), name, 0, 0, 0, 0 FROM sys.master_files


/*--------------------------------------------
-- Create Table for TempDB Usage
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[tempdb_usage]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[tempdb_usage]
END
IF(OBJECT_ID('[dbo].[ts_tempdb_usage]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_tempdb_usage]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[tempdb_usage]
	( 
		[capture_date] DATETIME,
		[file_id] SMALLINT,
		[drive] NCHAR(1),
		[unallocated_extent_page_count] BIGINT,
		[version_store_reserved_page_count] BIGINT,
		[user_object_reserved_page_count] BIGINT,
		[internal_object_reserved_page_count] BIGINT,
		[mixed_extent_page_count] BIGINT
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

SET @SQLCommand = REPLACE(@SQLCommand, N'[tempdb_usage]', N'[ts_tempdb_usage]')

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_tempdb_usage] ON [dbo].[tempdb_usage] ([capture_date],[file_id])

CREATE UNIQUE CLUSTERED INDEX [CI_ts_tempdb_usage] ON [dbo].[ts_tempdb_usage] ([capture_date],[file_id])
		
/*--------------------------------------------
-- Create Table for PerfMon Data
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[perfmon_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[perfmon_data]
END
IF(OBJECT_ID('[dbo].[ts_perfmon_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_perfmon_data]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[perfmon_data]
	(
		[capture_date] DATETIME,
		[counter] NVARCHAR(255),
		[value] DECIMAL(32,2)
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

SET @SQLCommand = REPLACE(@SQLCommand, N'[perfmon_data]', N'[ts_perfmon_data]')

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_perfmon_data] ON [dbo].[perfmon_data] ([capture_date],[counter])

CREATE UNIQUE CLUSTERED INDEX [CI_ts_perfmon_data] ON [dbo].[ts_perfmon_data] ([capture_date],[counter])

/*--------------------------------------------
-- Create Table for Wait Stats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[wait_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[wait_stats]
END
IF(OBJECT_ID('[dbo].[ts_wait_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_wait_stats]
END
SET @SQLCommand = N'CREATE TABLE [dbo].[wait_stats]
	(
		[capture_date] DATETIME,
		[wait_type] NVARCHAR(60),
		[waiting_tasks_count] BIGINT,
		[wait_time_ms] BIGINT,
		[max_wait_time_ms] BIGINT,
		[signal_wait_time_ms] BIGINT
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

EXEC sp_executesql @SQLCommand

SET @SQLCommand = REPLACE(@SQLCommand, N'[wait_stats]', N'[ts_wait_stats]')

EXEC sp_executesql @SQLCommand

CREATE UNIQUE CLUSTERED INDEX [CI_wait_stats] ON [dbo].[wait_stats] ([capture_date],[wait_type])

CREATE UNIQUE CLUSTERED INDEX [CI_ts_wait_stats] ON [dbo].[ts_wait_stats] ([capture_date],[wait_type])

/*--------------------------------------------
-- Table for Filtering WaitStats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_wait_types]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_wait_types]
END
CREATE TABLE [dbo].[filter_wait_types]
(
	[id] INT IDENTITY(1,1),
	[wait_type] NVARCHAR(60),
	[is_excluded] BIT,
	[ts_is_excluded] BIT
)

IF (@@VERSION LIKE N'%Microsoft SQL Server 2005%' 
	OR (@@VERSION LIKE N'%Microsoft SQL Server 2008%' 
		AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2008 R2%')) 
BEGIN
	INSERT INTO [dbo].[filter_wait_types]
	( [wait_type], [is_excluded], [ts_is_excluded] )
	VALUES ('AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP', 0, 0)
END

INSERT INTO [dbo].[filter_wait_types]
( [wait_type], [is_excluded], [ts_is_excluded] )
SELECT [wait_type], 0, 0 FROM sys.dm_os_wait_stats

---------------------------------------------------------------------------------------------------------------------------------------
-- Set exclude list if no list provided by user then it uses Paul Randal's code
-- (2014 marc) - http://www.sqlskills.com/blogs/paul/wait-statistics-or-please-tell-me-where-it-hurts/
---------------------------------------------------------------------------------------------------------------------------------------	
UPDATE [dbo].[filter_wait_types]
SET [is_excluded] =  1,
[ts_is_excluded] = 1 WHERE [wait_type] IN (
			N'BROKER_EVENTHANDLER',
			N'BROKER_RECEIVE_WAITFOR',
			N'BROKER_TASK_STOP',
			N'BROKER_TO_FLUSH',
			N'BROKER_TRANSMITTER',
			N'CHECKPOINT_QUEUE',
			N'CHKPT',
			N'CLR_AUTO_EVENT',
			N'CLR_MANUAL_EVENT',
			N'CLR_SEMAPHORE',
			N'DBMIRROR_DBM_EVENT',
			N'DBMIRROR_EVENTS_QUEUE',
			N'DBMIRROR_WORKER_QUEUE',
			N'DBMIRRORING_CMD',
			N'DIRTY_PAGE_POLL',
			N'DISPATCHER_QUEUE_SEMAPHORE',
			N'EXECSYNC',
			N'FSAGENT',
			N'FT_IFTS_SCHEDULER_IDLE_WAIT',
			N'FT_IFTSHC_MUTEX',
			N'HADR_CLUSAPI_CALL',
			N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
			N'HADR_LOGCAPTURE_WAIT',
			N'HADR_NOTIFICATION_DEQUEUE',
			N'HADR_TIMER_TASK',
			N'HADR_WORK_QUEUE',
			N'KSOURCE_WAKEUP',
			N'LAZYWRITER_SLEEP',
			N'LOGMGR_QUEUE',
			N'ONDEMAND_TASK_QUEUE',
			N'PWAIT_ALL_COMPONENTS_INITIALIZED',
			N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
			N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP',
			N'REQUEST_FOR_DEADLOCK_SEARCH',
			N'RESOURCE_QUEUE',
			N'SERVER_IDLE_CHECK',
			N'SLEEP_BPOOL_FLUSH',
			N'SLEEP_DBSTARTUP',
			N'SLEEP_DCOMSTARTUP',
			N'SLEEP_MASTERDBREADY',
			N'SLEEP_MASTERMDREADY',
			N'SLEEP_MASTERUPGRADED',
			N'SLEEP_MSDBSTARTUP',
			N'SLEEP_SYSTEMTASK',
			N'SLEEP_TASK',
			N'SLEEP_TEMPDBSTARTUP',
			N'SNI_HTTP_ACCEPT',
			N'SP_SERVER_DIAGNOSTICS_SLEEP',
			N'SQLTRACE_BUFFER_FLUSH',
			--N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
			N'SQLTRACE_WAIT_ENTRIES',
			N'WAIT_FOR_RESULTS',
			N'WAITFOR',
			N'WAITFOR_TASKSHUTDOWN',
			N'WAIT_XTP_HOST_WAIT',
			N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG',
			N'WAIT_XTP_CKPT_CLOSE',
			N'XE_DISPATCHER_JOIN',
			N'XE_DISPATCHER_WAIT',
			N'XE_TIMER_EVENT' )

/*--------------------------------------------
-- Table for Filtering PerfMon Counters
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_performance_counters]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_performance_counters]
END
CREATE TABLE [dbo].[filter_performance_counters]
(
	[id] INT IDENTITY(1,1),
	[counter_name] NVARCHAR(60),
	[is_included] BIT,
	[ts_is_included] BIT
)

/*--------------------------------------------
-- Insert all supported counters
--------------------------------------------*/
INSERT INTO [dbo].[filter_performance_counters]
( [counter_name], [is_included], [ts_is_included] )
SELECT DISTINCT [counter_name], 0, 0 FROM sys.dm_os_performance_counters WHERE cntr_type IN (272696576, 65792)

/*------------------------------------------------------------------------------------
-- My preferred list of counters mixed up from different source 
-- Use this poster to interpret the counters: 
-- http://www.quest.com/backstage/images/promotions/SQLServer-Perfmonance-Poster.pdf
------------------------------------------------------------------------------------*/
/*
	http://blogs.msdn.com/b/sqlosteam/archive/2012/07/11/memory-manager-surface-area-changes-in-sql-server-2012.aspx
	N'Free Pages' /-2008r2/		=>	N'Free Memory (KB)' /2012+/
	N'Target Pages'	/-2014/		=>	N'Target Server Memory (KB)' /-2014/
	N'Total Pages' /-2008r2/	=>	N'Total Server Memory (KB)' /-2014/
	N'Stolen Pages'	/-2008r2/	=>	N'Stolen Server Memory (KB)' /2012+/
	N'Database Pages' /-2014/	=>	N'Database Cache Memory (KB)' /2012+/
*/
IF(@@VERSION LIKE N'%Microsoft SQL Server 2012%' OR @@VERSION  LIKE N'%Microsoft SQL Server 2014%')
BEGIN
	UPDATE [dbo].[filter_performance_counters]
	SET [is_included] =  1, 
	[ts_is_included] = 1 WHERE [counter_name] IN (
			/* Data Access Performance Counters */
			N'Forwarded Records/sec',
			N'Index Searches/sec',
			N'Full Scans/sec',
			N'Page Splits/sec',
			/* Memory Manager Counters */
			/* "How is My Memory Being Used" Performance Counters */
			N'Total Server Memory (KB)', --*
			N'Target Server Memory (KB)', --*
			N'Free Memory (KB)', --*
			N'Stolen Server Memory (KB)', --*
			N'Database Cache Memory (KB)', --*
			N'Memory Grants Pending',			
			/* Buffer Manager and Memory Performance Counters */
			N'Free list stalls/sec',
			N'Lazy writes/sec',
			N'Checkpoint Pages/sec',
			N'Page life expectancy',
			N'Page reads/sec',
			N'Page writes/sec',			
			/* Workload Performance Counters */
			N'Batch Requests/sec',
			N'SQL Compilations/sec',
			N'SQL Re-Compilations/sec',
			/* Users and Locks Performance Counters */
			N'User Connections',
			N'Latch Waits/sec',
			N'Number of Deadlocks/sec',
			N'Transactions/sec',
			N'Lock Waits/sec' )
END
ELSE
BEGIN
UPDATE [dbo].[filter_performance_counters]
	SET [is_included] =  1, 
	[ts_is_included] = 1 WHERE [counter_name] IN (
			/* Data Access Performance Counters */
			N'Forwarded Records/sec',
			N'Index Searches/sec',
			N'Full Scans/sec',
			N'Page Splits/sec',
			/* Memory Manager Counters */
			/* "How is My Memory Being Used" Performance Counters */
			N'Total Server Memory (KB)', --*
			N'Total Pages', --*
			N'Target Server Memory (KB)', --*
			N'Target Pages', --*
			N'Free Memory (KB)', --*
			N'Free Pages', --*
			N'Stolen Server Memory (KB)', --*
			N'Stolen Pages', --*
			N'Database Cache Memory (KB)', --*
			N'Database Pages',--*
			N'Memory Grants Pending',			
			/* Buffer Manager and Memory Performance Counters */
			N'Free list stalls/sec',
			N'Lazy writes/sec',
			N'Checkpoint Pages/sec',
			N'Page life expectancy',
			N'Page reads/sec',
			N'Page writes/sec',			
			/* Workload Performance Counters */
			N'Batch Requests/sec',
			N'SQL Compilations/sec',
			N'SQL Re-Compilations/sec',
			/* Users and Locks Performance Counters */
			N'User Connections',
			N'Latch Waits/sec',
			N'Number of Deadlocks/sec',
			N'Transactions/sec',
			N'Lock Waits/sec' )
END
GO

/******************************************************************************
******************************** CREATE SCHEMA ********************************
**************************************END*************************************/

/************************************START*************************************
****************************** CREATE COLLECTORS ******************************
******************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectConfigData')
	EXEC ('CREATE PROC dbo.sp_CollectConfigData AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectConfigData]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectConfigData.sql

Example: 
EXEC sp_CollectConfigData
@Retention = 90,
@BypassNonActiveSrvConfError = 0,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014  

Summary:
Collecting SQL Server Server Configuration Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = 90,
@BypassNonActiveSrvConfError BIT = 0,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'

	UNION ALL
	SELECT N'@BypassNonActiveSrvConfError', N'BIT', N'0', N'The collector checks if there is any non-active server configuration and generates an ERROR if it finds any. If this option is enabled it bypasses the ERROR and generates a WARNING instead.'

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @row_count INT
DECLARE @non_active_server_config_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @Retention < 0  
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @BypassNonActiveSrvConfError IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @BypassNonActiveSrvConfError is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID))
		+ N' @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), 'NULL')
		+ N', @BypassNonActiveSrvConfError = ' + CAST(@BypassNonActiveSrvConfError AS nvarchar)
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		+ N', @help = ' + CAST(@help AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(N'[dbo].[configuration_data]') IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table [dbo].[configuration_data] does not exist!'
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
		
	SET @row_count = 0;

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Pre-Initial Data: insert data which have no initial state (e.g.: table is empty or data were deleted manually since the last check)
	---------------------------------------------------------------------------------------------------------------------------------------
	WITH most_recent_config as ( 
	SELECT [capture_date], [configuration_id]--, [Value], [value_in_use], [is_initial], [is_pre]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	) 
	INSERT INTO [dbo].[configuration_data]
    ( [capture_date], [configuration_id], [Value], [value_in_use], [is_initial], [is_pre] ) 
	SELECT  GETDATE(),[configuration_id], [value], [value_in_use], 1, 1 
	FROM [sys].[configurations] WHERE [configuration_id] NOT IN (SELECT [configuration_id] FROM most_recent_config) 
	
	SET @row_count = @@ROWCOUNT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as pre-initial config data.'
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END;

	---------------------------------------------------------------------------------------------------------
	-- Check and collect changed configuration data
	---------------------------------------------------------------------------------------------------------
	WITH [most_recent_config] AS ( 
	SELECT [capture_date], [configuration_id], [Value], [value_in_use]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	)
	INSERT  INTO [dbo].[configuration_data] ( [capture_date], [configuration_id], [Value], [value_in_use], [is_initial], [is_pre] )
	SELECT GETDATE(), [c].[configuration_id], [c].[value], [c].[value_in_use], 0, 0 FROM [most_recent_config] AS [mrc] INNER JOIN [sys].[configurations] AS [c] ON [mrc].[configuration_id] = [c].[configuration_id] WHERE [mrc].[value] <> [c].[value] OR [mrc].[value_in_use] <> [c].[value_in_use] 

	SET @row_count = @@ROWCOUNT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as changed config data.'
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		DELETE FROM [dbo].[configuration_data] WHERE [capture_date] < DATEADD(dd, -1*CAST(@retention AS nvarchar) , GETDATE())

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.'				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		---------------------------------------------------------------------------------------------------------
		-- Post-Initial Data: insert data which have no initial state because of the previous expired-deletion
		---------------------------------------------------------------------------------------------------------
		INSERT INTO [dbo].[configuration_data]
		( [capture_date], [configuration_id], [Value], [value_in_use], [is_initial], [is_pre]  )
		SELECT GETDATE(), [configuration_id], [value], [value_in_use], 1, 0 
		FROM [sys].[configurations] 
		WHERE [configuration_id] NOT IN ( 
		SELECT [configuration_id] FROM [dbo].[configuration_data] 
		WHERE [capture_date] >= DATEADD(dd, -1*@retention, GETDATE())
		)

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as post-initial config data.'				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END;

	---------------------------------------------------------------------------------------------------------
	-- Check Non-Active Server Configurations
	---------------------------------------------------------------------------------------------------------
	WITH [most_recent_config] AS (
	SELECT [capture_date], [configuration_id], [Value], [value_in_use], [is_initial]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	)
	SELECT @non_active_server_config_count = COUNT(*) FROM [most_recent_config] WHERE [Value] <> [value_in_use]
	
	IF(@non_active_server_config_count > 0)
	BEGIN
		SET @InfoMessage = N'WARNING - Non-Active Server Configuration: ' + CAST(@non_active_server_config_count AS NVARCHAR) 

		IF(@BypassNonActiveSrvConfError = 1)
		BEGIN
			SET @Severity = 10
		END
		ELSE
		BEGIN
			SET @Severity = 16
		END

		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()

	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectDatabaseInfo -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectDatabaseInfo')
	EXEC ('CREATE PROC dbo.sp_CollectDatabaseInfo AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectDatabaseInfo]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectDatabaseInfo.sql

Example: 
EXEC sp_CollectDatabaseInfo
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014  

Summary:
Collecting Database Info

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = 90,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @SQLCommand NVARCHAR(max)
DECLARE @version_column_list NVARCHAR(max)
DECLARE @version_column_list_with_table_prefix NVARCHAR(max)
DECLARE @version_where_predicates NVARCHAR(max)

DECLARE @row_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @Retention < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID))
		+ N' @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		+ N', @help = ' + CAST(@help AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(N'[dbo].[database_info]') IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table [dbo].[database_info] does not exist!' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
		
	SET @row_count = 0;
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Setting variables based on versions
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@@VERSION LIKE N'%Microsoft SQL Server 2005%')
	BEGIN
		SET @version_column_list = N''
		SET @version_column_list_with_table_prefix = N''
		SET @version_where_predicates = N''
	END
	IF(@@VERSION LIKE N'%Microsoft SQL Server 2008%')
	BEGIN
		SET @version_column_list = N', /* sql 2008+ */ [is_cdc_enabled], [is_encrypted], [is_honor_broker_priority_on] '
		SET @version_column_list_with_table_prefix  = N', /* sql 2008+ */ [sd].[is_cdc_enabled], [sd].[is_encrypted], [sd].[is_honor_broker_priority_on] '
		SET @version_where_predicates = N' OR
		 /* sql 2008+ */ [mrdbi].[is_cdc_enabled] <> [sd].[is_cdc_enabled] OR 
		 [mrdbi].[is_encrypted] <> [sd].[is_encrypted] OR 
		 [mrdbi].[is_honor_broker_priority_on] <> [sd].[is_honor_broker_priority_on] '
	END
	IF(@@VERSION LIKE N'%Microsoft SQL Server 2012%')
	BEGIN
		SET @version_column_list = N', /* sql 2008+ */ [is_cdc_enabled], [is_encrypted], [is_honor_broker_priority_on], /* sql 2012+ */ [replica_id], [group_database_id], [default_language_lcid], [default_fulltext_language_lcid], [is_nested_triggers_on], [is_transform_noise_words_on], [two_digit_year_cutoff], [containment], [target_recovery_time_in_seconds] '
		SET @version_column_list_with_table_prefix  = N', /* sql 2008+ */ [sd].[is_cdc_enabled], [sd].[is_encrypted], [sd].[is_honor_broker_priority_on], /* sql 2012+ */ [sd].[replica_id], [sd].[group_database_id], [sd].[default_language_lcid], [sd].[default_fulltext_language_lcid], [sd].[is_nested_triggers_on], [sd].[is_transform_noise_words_on], [sd].[two_digit_year_cutoff], [sd].[containment], [sd].[target_recovery_time_in_seconds] '
		SET @version_where_predicates = N' OR
		 /* sql 2008+ */ [mrdbi].[is_cdc_enabled] <> [sd].[is_cdc_enabled] OR 
		 [mrdbi].[is_encrypted] <> [sd].[is_encrypted] OR 
		 [mrdbi].[is_honor_broker_priority_on] <> [sd].[is_honor_broker_priority_on] OR 
		 /* sql 2012+ */ [sd].[replica_id] <> [sd].[replica_id] OR 
		 [mrdbi].[group_database_id] <> [sd].[group_database_id] OR 
		 [mrdbi].[default_language_lcid] <> [sd].[default_language_lcid] OR 
		 [mrdbi].[default_fulltext_language_lcid] <> [sd].[default_fulltext_language_lcid] OR 
		 [mrdbi].[is_nested_triggers_on] <> [sd].[is_nested_triggers_on] OR 
		 [mrdbi].[is_transform_noise_words_on] <> [sd].[is_transform_noise_words_on] OR 
		 [mrdbi].[two_digit_year_cutoff] <> [sd].[two_digit_year_cutoff] OR 
		 [mrdbi].[containment] <> [sd].[containment] OR 
		 [mrdbi].[target_recovery_time_in_seconds] <> [sd].[target_recovery_time_in_seconds] '
	END
	IF(@@VERSION LIKE N'%Microsoft SQL Server 2014%')
	BEGIN
		SET @version_column_list = N', /* sql 2008+ */ [is_cdc_enabled], [is_encrypted], [is_honor_broker_priority_on], /* sql 2012+ */ [replica_id], [group_database_id], [default_language_lcid], [default_fulltext_language_lcid], [is_nested_triggers_on], [is_transform_noise_words_on], [two_digit_year_cutoff], [containment], [target_recovery_time_in_seconds], /* sql 2014 */ [is_auto_create_stats_incremental_on], [is_query_store_on], [resource_pool_id], [delayed_durability], [is_memory_optimized_elevate_to_snapshot_on] '
		SET @version_column_list_with_table_prefix  = N', /* sql 2008+ */ [sd].[is_cdc_enabled], [sd].[is_encrypted], [sd].[is_honor_broker_priority_on], /* sql 2012+ */ [sd].[replica_id], [sd].[group_database_id], [sd].[default_language_lcid], [sd].[default_fulltext_language_lcid], [sd].[is_nested_triggers_on], [sd].[is_transform_noise_words_on], [sd].[two_digit_year_cutoff], [sd].[containment], [sd].[target_recovery_time_in_seconds], /* sql 2014 */ [sd].[is_auto_create_stats_incremental_on], [sd].[is_query_store_on], [sd].[resource_pool_id], [sd].[delayed_durability], [sd].[is_memory_optimized_elevate_to_snapshot_on] '
		SET @version_where_predicates = N' OR
		 /* sql 2008+ */ [mrdbi].[is_cdc_enabled] <> [sd].[is_cdc_enabled] OR 
		 [mrdbi].[is_encrypted] <> [sd].[is_encrypted] OR 
		 [mrdbi].[is_honor_broker_priority_on] <> [sd].[is_honor_broker_priority_on] OR 
		 /* sql 2012+ */ [mrdbi].[replica_id] <> [sd].[replica_id] OR 
		 [mrdbi].[group_database_id] <> [sd].[group_database_id] OR 
		 [mrdbi].[default_language_lcid] <> [sd].[default_language_lcid] OR 
		 [mrdbi].[default_fulltext_language_lcid] <> [sd].[default_fulltext_language_lcid] OR 
		 [mrdbi].[is_nested_triggers_on] <> [sd].[is_nested_triggers_on] OR 
		 [mrdbi].[is_transform_noise_words_on] <> [sd].[is_transform_noise_words_on] OR 
		 [mrdbi].[two_digit_year_cutoff] <> [sd].[two_digit_year_cutoff] OR 
		 [mrdbi].[containment] <> [sd].[containment] OR 
		 [mrdbi].[target_recovery_time_in_seconds] <> [sd].[target_recovery_time_in_seconds] OR
		 /* sql 2014 */ [mrdbi].[is_auto_create_stats_incremental_on] <> [sd].[is_auto_create_stats_incremental_on] OR
		 [mrdbi].[is_query_store_on] <> [sd].[is_query_store_on] OR
		 [mrdbi].[resource_pool_id] <> [sd].[resource_pool_id] OR
		 [mrdbi].[delayed_durability] <> [sd].[delayed_durability] OR
		 [mrdbi].[is_memory_optimized_elevate_to_snapshot_on] <> [sd].[is_memory_optimized_elevate_to_snapshot_on] '
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Pre-Initial Data: insert data which have no initial state (e.g.: table is empty or data were deleted manually since the last check)
	---------------------------------------------------------------------------------------------------------------------------------------
	SET @SQLCommand = N'WITH most_recent_db_info as ( 
		 SELECT [capture_date], [database_name] 
		 FROM [dbo].[database_info] AS [di] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[database_info] AS [di2] WHERE [di].[database_name] = [di2].[database_name]) 
		 ) 
		 INSERT INTO [dbo].[database_info] 
		 ( [capture_date], [database_name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', [is_initial], [is_pre] ) 
		 SELECT  GETDATE(),[name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', 1, 1  
		 FROM [sys].[databases] WHERE [name] NOT IN (SELECT [database_name] FROM most_recent_db_info) '
	EXEC sp_executesql @SQLCommand

	SET @row_count = @@ROWCOUNT

	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as pre-initial config data.' 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END;

	---------------------------------------------------------------------------------------------------------
	-- Check and collect changed configuration data
	---------------------------------------------------------------------------------------------------------
	SET @SQLCommand = N'WITH most_recent_db_info as ( 
		SELECT [capture_date], [database_name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N' 
		FROM [dbo].[database_info] AS [di] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[database_info] AS [di2] WHERE [di].[database_name] = [di2].[database_name])
		) 
		INSERT  INTO [dbo].[database_info] ( [capture_date], [database_name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', [is_initial], [is_pre] )
		SELECT GETDATE(), [sd].[name], [sd].[database_id], [sd].[source_database_id], [sd].[owner_sid], [sd].[create_date], [sd].[compatibility_level], [sd].[collation_name], [sd].[user_access], [sd].[is_read_only], [sd].[is_auto_close_on], [sd].[is_auto_shrink_on], [sd].[state], [sd].[is_in_standby], [sd].[is_supplemental_logging_enabled], [sd].[snapshot_isolation_state], [sd].[is_read_committed_snapshot_on], [sd].[recovery_model], [sd].[page_verify_option], [sd].[is_auto_create_stats_on], [sd].[is_auto_update_stats_on], [sd].[is_auto_update_stats_async_on], [sd].[is_ansi_null_default_on], [sd].[is_ansi_nulls_on], [sd].[is_ansi_padding_on], [sd].[is_ansi_warnings_on], [sd].[is_arithabort_on], [sd].[is_concat_null_yields_null_on], [sd].[is_numeric_roundabort_on], [sd].[is_quoted_identifier_on], [sd].[is_recursive_triggers_on], [sd].[is_cursor_close_on_commit_on], [sd].[is_local_cursor_default], [sd].[is_fulltext_enabled], [sd].[is_trustworthy_on], [sd].[is_db_chaining_on], [sd].[is_parameterization_forced], [sd].[is_master_key_encrypted_by_server], [sd].[is_published], [sd].[is_merge_published], [sd].[is_distributor], [sd].[is_sync_with_backup], [sd].[service_broker_guid], [sd].[is_broker_enabled], [sd].[is_date_correlation_on] ' + @version_column_list_with_table_prefix + N', 0, 0 
		FROM [most_recent_db_info] AS [mrdbi] INNER JOIN [sys].[databases] AS [sd] ON [mrdbi].[database_name] = [sd].[name] 
		WHERE [mrdbi].[database_id] <> [sd].[database_id] OR  
		 [mrdbi].[source_database_id] <> [sd].[source_database_id] OR 
		 [mrdbi].[owner_sid] <> [sd].[owner_sid] OR 
		 [mrdbi].[create_date] <> [sd].[create_date] OR 
		 [mrdbi].[compatibility_level] <> [sd].[compatibility_level] OR 
		 [mrdbi].[collation_name] <> [sd].[collation_name] OR 
		 [mrdbi].[user_access] <> [sd].[user_access] OR 
		 [mrdbi].[is_read_only] <> [sd].[is_read_only] OR 
		 [mrdbi].[is_auto_close_on] <> [sd].[is_auto_close_on] OR 
		 [mrdbi].[is_auto_shrink_on] <> [sd].[is_auto_shrink_on] OR 
		 [mrdbi].[state] <> [sd].[state] OR 
		 [mrdbi].[is_in_standby] <> [sd].[is_in_standby] OR 
		 [mrdbi].[is_supplemental_logging_enabled] <> [sd].[is_supplemental_logging_enabled] OR 
		 [mrdbi].[snapshot_isolation_state] <> [sd].[snapshot_isolation_state] OR 
		 [mrdbi].[is_read_committed_snapshot_on] <> [sd].[is_read_committed_snapshot_on] OR 
		 [mrdbi].[recovery_model] <> [sd].[recovery_model] OR 
		 [mrdbi].[page_verify_option] <> [sd].[page_verify_option] OR 
		 [mrdbi].[is_auto_create_stats_on] <> [sd].[is_auto_create_stats_on] OR 
		 [mrdbi].[is_auto_update_stats_on] <> [sd].[is_auto_update_stats_on] OR 
		 [mrdbi].[is_auto_update_stats_async_on] <> [sd].[is_auto_update_stats_async_on] OR 
		 [mrdbi].[is_ansi_null_default_on] <> [sd].[is_ansi_null_default_on] OR 
		 [mrdbi].[is_ansi_nulls_on] <> [sd].[is_ansi_nulls_on] OR 
		 [mrdbi].[is_ansi_padding_on] <> [sd].[is_ansi_padding_on] OR 
		 [mrdbi].[is_ansi_warnings_on] <> [sd].[is_ansi_warnings_on] OR 
		 [mrdbi].[is_arithabort_on] <> [sd].[is_arithabort_on] OR 
		 [mrdbi].[is_concat_null_yields_null_on] <> [sd].[is_concat_null_yields_null_on] OR 
		 [mrdbi].[is_numeric_roundabort_on] <> [sd].[is_numeric_roundabort_on] OR 
		 [mrdbi].[is_quoted_identifier_on] <> [sd].[is_quoted_identifier_on] OR 
		 [mrdbi].[is_recursive_triggers_on] <> [sd].[is_recursive_triggers_on] OR 
		 [mrdbi].[is_cursor_close_on_commit_on] <> [sd].[is_cursor_close_on_commit_on] OR 
		 [mrdbi].[is_local_cursor_default] <> [sd].[is_local_cursor_default] OR 
		 [mrdbi].[is_fulltext_enabled] <> [sd].[is_fulltext_enabled] OR 
		 [mrdbi].[is_trustworthy_on] <> [sd].[is_trustworthy_on] OR 
		 [mrdbi].[is_db_chaining_on] <> [sd].[is_db_chaining_on] OR 
		 [mrdbi].[is_parameterization_forced] <> [sd].[is_parameterization_forced] OR 
		 [mrdbi].[is_master_key_encrypted_by_server] <> [sd].[is_master_key_encrypted_by_server] OR 
		 [mrdbi].[is_published] <> [sd].[is_published] OR 
		 [mrdbi].[is_merge_published] <> [sd].[is_merge_published] OR 
		 [mrdbi].[is_distributor] <> [sd].[is_distributor] OR 
		 [mrdbi].[is_sync_with_backup] <> [sd].[is_sync_with_backup] OR 
		 [mrdbi].[service_broker_guid] <> [sd].[service_broker_guid] OR 
		 [mrdbi].[is_broker_enabled] <> [sd].[is_broker_enabled] OR 
		 [mrdbi].[is_date_correlation_on] <> [sd].[is_date_correlation_on] ' + @version_where_predicates
		 EXEC sp_executesql @SQLCommand

		 SET @row_count = @@ROWCOUNT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as changed config data.' 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		DELETE FROM [dbo].[database_info] WHERE [capture_date] < DATEADD(dd, -1*CAST(@retention AS nvarchar) , GETDATE())

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		---------------------------------------------------------------------------------------------------------
		-- Post-Initial Data: insert data which have no initial state because of the previous expired-deletion
		---------------------------------------------------------------------------------------------------------
		SET @SQLCommand = N'INSERT INTO [dbo].[database_info] 
		( [capture_date], [database_name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', [is_initial], [is_pre] ) 
		 SELECT GETDATE(), [name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', 1, 0  
		 FROM [sys].[databases] 
		 WHERE [name] NOT IN ( 
		 SELECT [database_name] FROM [dbo].[database_info] 
		 WHERE [capture_date] >= DATEADD(dd, -1*'+CAST(@retention AS nvarchar)+N', GETDATE()) 
		 ) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as post-initial config data.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END;


	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()

	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectFileInfo ---------------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectFileInfo')
	EXEC ('CREATE PROC dbo.sp_CollectFileInfo AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectFileInfo]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectFileInfo.sql

Example:
EXEC sp_CollectFileInfo
@DestTable = NULL,
@DestSchema = NULL,
@TSMode = 0,
@EmptyTSTable = 0,
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Database File Information Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = NULL,
@DestSchema NVARCHAR(25) = NULL,
@TSMode BIT = 0,
@EmptyTSTable BIT = 0,
@Retention SMALLINT = 90,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN

SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'NVARCHAR(128)', N'NULL', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'NVARCHAR(25)', N'NULL', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'BIT', N'0', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'BIT', N'0', N'Empty the table used for troubleshooting before the data collection.'

	SELECT N'Standard' AS [Running Mode], N'[dbo].[file_info]' AS [Default Table]
	UNION ALL
	SELECT N'Troubleshooting', N'[dbo].[ts_file_info]'

	SELECT N'Filtering table' AS [Filtering], N'[dbo].[filter_database_file]' AS [Info]
    UNION ALL
	SELECT N'Type of Filtering', N'Exclude - Include (see the columns)'
	UNION ALL
	SELECT N'Column used in Standardmode (exclude)', N'[is_excluded_file_info]'
	UNION ALL
	SELECT N'Column used in TSMode (include)', N'[ts_is_included_file_info]'  

	SELECT [database_name], [logical_file_name], [is_excluded_file_info], [ts_is_included_file_info] FROM [dbo].[filter_database_file] ORDER BY [database_name]

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @data_compression NVARCHAR(35)
DECLARE @SQLCommand NVARCHAR(max)

DECLARE @row_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @TSMode IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @TSMode is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @EmptyTSTable IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @EmptyTSTable is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @Retention < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	--------------
	-- TSMode = 0
	--------------
	IF(@TSMode = 0)
	BEGIN
		SET @DestTable = N'file_info'
		SET @DestSchema = N'dbo'
	END
	--------------
	-- TSMode = 1
	--------------
	ELSE
	BEGIN
		IF(@DestTable IS NOT NULL)
		BEGIN
			SET @DestTable = REPLACE(REPLACE(RTRIM(LTRIM(@DestTable)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestTAble = N'ts_file_info'
		END
		
		IF(@DestSchema IS NOT NULL)
		BEGIN
			SET @DestSchema = REPLACE(REPLACE(RTRIM(LTRIM(@DestSchema)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestSchema = N'dbo'
		END
	END
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
		+ N' @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@Retention > 0 AND @TSMode = 1)
	BEGIN
		SET @Retention = 0
		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'Parameter @Retention has been changed to 0. Reason: @TSMode is enabled. Tables for troubleshooting have to be maintained manually.' 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable)) IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' does not exist!'
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@TSMode = 1 AND @EmptyTSTable = 1)
	BEGIN
		SET @SQLCommand = N'TRUNCATE TABLE ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) 
		EXEC sp_executesql @SQLCommand
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Collect File Info Data 
	---------------------------------------------------------------------------------------------------------------------------------------
	CREATE TABLE #temp_filter
		(
		[database_id] INT, 
		[logical_file_id] INT, 
		)
		
	---------------------------------------------------------
	-- Filtering | TSMode - include | StandardMode - exclude
	---------------------------------------------------------
	IF(@TSMode = 1) /* INCLUDE */
	BEGIN
		INSERT INTO #temp_filter ( [database_id], [logical_file_id] )
		SELECT [sd].[database_id], [mf].[file_id] FROM [sys].[databases] AS [sd]
		INNER JOIN [sys].[master_files] AS [mf] ON [mf].[database_id] = [sd].[database_id]
		INNER JOIN [dbo].[filter_database_file] AS [ft] ON [ft].[database_name] = [sd].[name] AND [ft].[logical_file_name] = [mf].[name]
		WHERE [sd].[state] = 0 AND [ft].[ts_is_included_file_info] = 1

	END
	ELSE /* EXCLUDE */
	BEGIN
		INSERT INTO #temp_filter ( [database_id], [logical_file_id] )
		SELECT [sd].[database_id], [mf].[file_id] FROM [sys].[databases] AS [sd]
		INNER JOIN [sys].[master_files] AS [mf] ON [mf].[database_id] = [sd].[database_id]
		LEFT OUTER JOIN [dbo].[filter_database_file] AS [ft] ON [ft].[database_name] = [sd].[name] AND [ft].[logical_file_name] = [mf].[name]
		WHERE [sd].[state] = 0 AND ([ft].[is_excluded_file_info] = 0 OR [ft].[is_excluded_file_info] IS NULL)
	END

	DECLARE @object NVARCHAR (300)
	DECLARE c CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY
	FOR SELECT DISTINCT QUOTENAME(DB_NAME([database_id])) FROM #temp_filter
	OPEN c;
	
	FETCH NEXT FROM c INTO @object
	WHILE @@FETCH_STATUS = 0
	BEGIN
	SET @sqlcommand = N'USE ' + @object + N' INSERT INTO ' + QUOTENAME(DB_NAME(DB_ID()))+N'.'+QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
		 ( [capture_date], [database_name], [physical_name], [type], [size_pages], [space_used_pages], [max_size_pages], [growth_pages_percent], [is_percent_growth] ) 
		 SELECT GETDATE() AS [capture_date], DB_NAME() AS [database_name], [df].[physical_name], [df].[type], [df].[size] AS [size_pages], FILEPROPERTY([df].[name], ''SpaceUsed'') AS [space_used_pages], [df].[max_size], [df].[growth] AS [growth_pages_percent], [df].[is_percent_growth] FROM [sys].[database_files] AS [df] 
		 INNER JOIN #temp_filter AS [f] ON DB_ID() = [f].[database_id] AND [df].[file_id] = [f].[logical_file_id] '
	EXEC sp_executesql @sqlcommand
	FETCH NEXT FROM c INTO @object;
	END
	CLOSE c;
	DEALLOCATE c;

	DROP TABLE #temp_filter

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@retention AS nvarchar) + N', GETDATE()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = 'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()
	
	IF OBJECT_ID ('tempdb..#temp_filter') IS NOT NULL
	BEGIN
		DROP TABLE #temp_filter
	END

	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectInstanceInfo -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectInstanceInfo')
	EXEC ('CREATE PROC dbo.sp_CollectInstanceInfo AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectInstanceInfo]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectInstanceInfo.sql

Example: 
EXEC sp_CollectInstanceInfo
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Server Instace Related Info

License: Copyright (c) 2015 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = 90,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @row_count INT
DECLARE @config_name NVARCHAR(35)

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
		
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @Retention < 0  
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.'
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID))
		+ N' @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		+ N', @help = ' + CAST(@help AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(N'[dbo].[instance_info]') IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table [dbo].[instance_info] does not exist!'
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
		
	SET @row_count = 0;
	--
	DECLARE @instance_info TABLE
	(
		[name] NVARCHAR(50) NOT NULL,
		[value] SQL_VARIANT NULL 
	)
	INSERT INTO @instance_info ([name], [value]) SELECT 'ComputerNamePhysicalNetBIOS', SERVERPROPERTY('ComputerNamePhysicalNetBIOS')
	INSERT INTO @instance_info ([name], [value]) SELECT 'MachineName', SERVERPROPERTY('MachineName')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ServerName', SERVERPROPERTY('ServerName')
	INSERT INTO @instance_info ([name], [value]) SELECT 'InstanceName', SERVERPROPERTY('InstanceName')
	INSERT INTO @instance_info ([name], [value]) SELECT 'IsClustered', SERVERPROPERTY('IsClustered')
	INSERT INTO @instance_info ([name], [value]) SELECT 'Edition', SERVERPROPERTY('Edition')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ProductLevel', SERVERPROPERTY('ProductLevel')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ProductVersion', SERVERPROPERTY('ProductVersion')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ResourceLastUpdateDateTime', SERVERPROPERTY('ResourceLastUpdateDateTime')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ResourceVersion', SERVERPROPERTY('ResourceVersion')
	INSERT INTO @instance_info ([name], [value]) SELECT 'LicenseType', SERVERPROPERTY('LicenseType')
	INSERT INTO @instance_info ([name], [value]) SELECT 'NumLicenses', SERVERPROPERTY('NumLicenses')
	INSERT INTO @instance_info ([name], [value]) SELECT 'ProcessID', SERVERPROPERTY('ProcessID')
	INSERT INTO @instance_info ([name], [value]) SELECT 'Collation', SERVERPROPERTY('Collation')
	INSERT INTO @instance_info ([name], [value]) SELECT 'IsFullTextInstalled', SERVERPROPERTY('IsFullTextInstalled')
	INSERT INTO @instance_info ([name], [value]) SELECT 'IsIntegratedSecurityOnly', SERVERPROPERTY('IsIntegratedSecurityOnly')
	INSERT INTO @instance_info ([name], [value]) SELECT [type_desc], COUNT([type]) FROM sys .server_principals GROUP BY [type_desc]
	INSERT INTO @instance_info ([name], [value]) SELECT 'NumDatabases: ' + [state_desc] , COUNT([name]) FROM sys.databases GROUP BY [state_desc]

	--select * from @instance_info
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Pre-Initial Data: insert data which have no initial state (e.g.: table is empty or data were deleted manually since the last check)
	---------------------------------------------------------------------------------------------------------------------------------------
	;WITH most_recent_config as ( 
	SELECT [capture_date], [name]--, [Value], [value_in_use], [is_initial], [is_pre]
	FROM [dbo].[instance_info] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[instance_info] AS [cc] WHERE [c].[name] = [cc].[name])
	) 
	INSERT INTO [dbo].[instance_info]
    ( [capture_date], [name], [Value], [is_initial], [is_pre] ) 
	SELECT  GETDATE(),[name], [value], 1, 1 
	FROM @instance_info WHERE [name] NOT IN (SELECT [name] FROM most_recent_config) 
	
	--select * from [dbo].[instance_info]

	SET @row_count = @@ROWCOUNT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as pre-initial instance info data.'
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END;

	---------------------------------------------------------------------------------------------------------
	-- Check and collect changed configuration data
	---------------------------------------------------------------------------------------------------------
	WITH [most_recent_config] AS ( 
	SELECT [capture_date], [name], [Value]
	FROM [dbo].[instance_info] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[instance_info] AS [cc] WHERE [c].[name] = [cc].[name])
	)
	INSERT  INTO [dbo].[instance_info] ( [capture_date], [name], [Value], [is_initial], [is_pre] )
	SELECT GETDATE(), [c].[name], [c].[value], 0, 0 FROM [most_recent_config] AS [mrc] INNER JOIN @instance_info AS [c] ON [mrc].[name] = [c].[name] WHERE [mrc].[value] <> [c].[value]

	SET @row_count = @@ROWCOUNT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as changed instance info data.'
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		DELETE FROM [dbo].[instance_info] WHERE [capture_date] < DATEADD(dd, -1*CAST(@retention AS nvarchar) , GETDATE())

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.'				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		---------------------------------------------------------------------------------------------------------
		-- Post-Initial Data: insert data which have no initial state because of the previous expired-deletion
		---------------------------------------------------------------------------------------------------------
		INSERT INTO [dbo].[instance_info]
		( [capture_date], [name], [Value], [is_initial], [is_pre]  )
		SELECT GETDATE(), [name], [value], 1, 0 
		FROM @instance_info 
		WHERE [name] NOT IN ( 
		SELECT [name] FROM [dbo].[instance_info] 
		WHERE [capture_date] >= DATEADD(dd, -1*@retention, GETDATE())
		)

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added as post-initial instance info data.'				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END;

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()

	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END

/*- sp_CollectIOVFStats --------------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectIOVFStats')
	EXEC ('CREATE PROC dbo.sp_CollectIOVFStats AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectIOVFStats]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectIOVFStats.sql

Example:
EXEC sp_CollectIOVFStats
@DestTable = NULL,
@DestSchema  = NULL,
@TSMode = 1,
@EmptyTSTable = 1,
@CollectingInterval  = NULL,
@SampleInterval = 10,
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server IO Virtual File Statistics Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = NULL,
@DestSchema NVARCHAR(25) = NULL,
@TSMode BIT = 0,
@EmptyTSTable BIT = 0,
@Retention SMALLINT = 90,
@CollectingInterval SMALLINT = NULL,
@SampleInterval SMALLINT = 10,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
    SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'NVARCHAR(128)', N'NULL', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'NVARCHAR(25)', N'NULL', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'BIT', N'0', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'BIT', N'0', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'SMALLINT', N'NULL', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'SMALLINT', N'10', N'Times in seconds between taking two samples.'
	
	SELECT N'Standard' AS [Running Mode], N'[dbo].[iovf_stats]' AS [Default Table]
	UNION ALL
	SELECT N'Troubleshooting', N'[dbo].[ts_iovf_stats]'

	SELECT N'Filtering table' AS [Filtering], N'[dbo].[filter_database_file]' AS [Info]
    UNION ALL
	SELECT N'Type of Filtering', N'Exclude - Include (see the columns)'
	UNION ALL
	SELECT N'Column used in Standardmode (exclude)', N'[is_excluded_iovf]'
	UNION ALL
	SELECT N'Column used in TSMode (include)', N'[ts_is_included_iovf]'  

	SELECT [database_name], [logical_file_name], [is_excluded_iovf], [ts_is_included_iovf] FROM [dbo].[filter_database_file] ORDER BY [database_name]

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @SQLCommand NVARCHAR(max)
DECLARE @CollectSQLCommand NVARCHAR(max)
DECLARE @sample_interval NVARCHAR(12)

DECLARE @start_loop DATETIME
DECLARE @max_loop INT
DECLARE @loop_count INT

DECLARE @LockResult INT
DECLARE @RequiredAppLock NVARCHAR(25)

DECLARE @row_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF((@SampleInterval NOT BETWEEN 1 AND 300) OR @SampleInterval IS NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @SampleInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@CollectingInterval NOT BETWEEN 1 AND 1440 AND @CollectingInterval IS NOT NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @CollectingInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
	ELSE 
	BEGIN
		IF(@CollectingInterval IS NOT NULL AND @SampleInterval > @CollectingInterval*60 )
		BEGIN
			SET @ErrorMessage = N'The time interval of sampling is larger than the collecting time interval!'
			SET @Severity=16
			RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF @TSMode IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @TSMode is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @EmptyTSTable IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @EmptyTSTable is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @Retention < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	--------------
	-- TSMode = 0
	--------------
	IF(@TSMode = 0)
	BEGIN
		SET @DestTable = N'iovf_stats'
		SET @DestSchema = N'dbo'
	END
	--------------
	-- TSMode = 1
	--------------
	ELSE
	BEGIN
		IF(@DestTable IS NOT NULL)
		BEGIN
			SET @DestTable = REPLACE(REPLACE(RTRIM(LTRIM(@DestTable)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestTAble = N'ts_iovf_stats'
		END
		
		IF(@DestSchema IS NOT NULL)
		BEGIN
			SET @DestSchema = REPLACE(REPLACE(RTRIM(LTRIM(@DestSchema)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestSchema = N'dbo'
		END
	END
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
		+ N' @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		+ N', @SampleInterval = ' + CAST(@SampleInterval AS nvarchar)
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = ' + CAST(@LogInfo AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@Retention > 0 AND @TSMode = 1)
	BEGIN
		SET @Retention = 0
		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'Parameter @Retention has been changed to 0. Reason: @TSMode is enabled. Tables for troubleshooting have to be maintained manually.' 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable)) IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' does not exist!' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@TSMode = 1 AND @EmptyTSTable = 1)
	BEGIN
		SET @SQLCommand = N'TRUNCATE TABLE ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) 
		EXEC sp_executesql @SQLCommand
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Create temp tables and set variables
	---------------------------------------------------------------------------------------------------------------------------------------
	SET @CollectSQLCommand = N'INSERT INTO '+ QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
		 ([capture_date], [database_name], [type], [physical_name], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms]) 
		 SELECT [tio2].[capture_date], DB_NAME([tio2].[database_id]), [mf].[type], [mf].[physical_name], [tio2].[sample_ms]-[tio1].[sample_ms], [tio2].[num_of_reads]-[tio1].[num_of_reads], [tio2].[num_of_bytes_read]-[tio1].[num_of_bytes_read], [tio2].[io_stall_read_ms]-[tio1].[io_stall_read_ms], [tio2].[num_of_writes]-[tio1].[num_of_writes], [tio2].[num_of_bytes_written]-[tio1].[num_of_bytes_written], [tio2].[io_stall_write_ms]-[tio1].[io_stall_write_ms] 
		 FROM #temp_IOVFStats1 AS [tio1] INNER JOIN #temp_IOVFStats2 AS [tio2] 
		 ON [tio1].[database_id] = [tio2].[database_id] AND [tio1].[file_id] = [tio2].[file_id] 
		 INNER JOIN sys.master_files AS [mf] 
		 ON [tio2].[database_id] = [mf].[database_id] AND [tio2].[file_id] = [mf].[file_id] 
		 INNER JOIN #temp_filter AS [tf] ON [tf].[database_id] = [tio2].[database_id] AND [tf].[logical_file_id] = [tio2].[file_id] '

	CREATE TABLE #temp_IOVFStats1
		(
		[database_id] SMALLINT, 
		[file_id] SMALLINT, 
		[sample_ms] INT, 
		[num_of_reads] BIGINT,
		[num_of_bytes_read] BIGINT,
		[io_stall_read_ms] BIGINT,
		[num_of_writes] BIGINT,
		[num_of_bytes_written] BIGINT,
		[io_stall_write_ms] BIGINT
		)
	
	CREATE TABLE #temp_IOVFStats2
		(
		[capture_date] DATETIME DEFAULT GETDATE(),
		[database_id] SMALLINT, 
		[file_id] SMALLINT, 
		[sample_ms] INT, 
		[num_of_reads] BIGINT,
		[num_of_bytes_read] BIGINT,
		[io_stall_read_ms] BIGINT,
		[num_of_writes] BIGINT,
		[num_of_bytes_written] BIGINT,
		[io_stall_write_ms] BIGINT
		)

	CREATE TABLE #temp_filter
		(
		[database_id] INT, 
		[logical_file_id] INT, 
		)
	---------------------------------------------------------
	-- Filtering | TSMode - include | StandardMode - exclude
	---------------------------------------------------------
	IF(@TSMode = 1) /* INCLUDE */
	BEGIN
		INSERT INTO #temp_filter ( [database_id], [logical_file_id] )
		SELECT [iovfs].[database_id], [iovfs].[file_id] FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS [iovfs]
		INNER JOIN sys.master_files AS [mf] ON [iovfs].[database_id] = [mf].[database_id] AND [iovfs].[file_id] = [mf].[file_id] 
		INNER JOIN [dbo].[filter_database_file] AS [ft] ON [ft].[database_name] = DB_NAME([iovfs].[database_id]) AND [ft].[logical_file_name] = [mf].[name]
		WHERE [ft].[ts_is_included_iovf] = 1
	END
	ELSE /* EXCLUDE */ 
	BEGIN
		INSERT INTO #temp_filter ( [database_id], [logical_file_id] )
		SELECT [iovfs].[database_id], [iovfs].[file_id] FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS [iovfs]
		INNER JOIN sys.master_files AS [mf] ON [iovfs].[database_id] = [mf].[database_id] AND [iovfs].[file_id] = [mf].[file_id] 
		LEFT OUTER JOIN [dbo].[filter_database_file] AS [ft] ON [ft].[database_name] = DB_NAME([iovfs].[database_id]) AND [ft].[logical_file_name] = [mf].[name]
		WHERE [ft].[is_excluded_iovf] = 0 OR [ft].[is_excluded_iovf] IS NULL
		
	END

	

	IF(@CollectingInterval IS NULL)
	BEGIN
		SET @max_loop = 1
	END
	ELSE
	BEGIN
		SET @max_loop = @CollectingInterval*60/@SampleInterval
	END

	IF(@debug > 0)
	BEGIN
		SET @InfoMessage = N'Number of loops - @max_loop: ' + CAST(@max_loop AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Sample interval - @SampleInterval: ' + CAST(@SampleInterval AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	SET @loop_count = 0
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Collect IO Virtual File Stats Data 
	---------------------------------------------------------------------------------------------------------------------------------------
	-----------------------------------------
	-- initial measurement
	-----------------------------------------
	INSERT INTO #temp_IOVFStats1
		([database_id], [file_id], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms])
		SELECT [database_id], [file_id], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms]
		FROM sys.dm_io_virtual_file_stats(NULL, NULL)
	
	IF(@debug > 1)
	BEGIN
		SELECT '#temp_IOVFStats1'
		SELECT * FROM #temp_IOVFStats1
	END

	SET @start_loop = GETDATE()

	WHILE(@loop_count < @max_loop)
	BEGIN
		SET @sample_interval = CONVERT(nvarchar, DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, GETDATE()) AS INT), 0), 114)

		WAITFOR DELAY @sample_interval;

		-----------------------------------------
		-- 2nd measurement
		-----------------------------------------
		INSERT INTO #temp_IOVFStats2
		([database_id], [file_id], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms])
		SELECT [database_id], [file_id], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms]
		FROM sys.dm_io_virtual_file_stats(NULL, NULL)
		
		IF(@debug > 1)
		BEGIN
			SELECT '#temp_IOVFStats2'
			SELECT * FROM #temp_IOVFStats2
		END

		SET @start_loop = GETDATE()
		
		------------------------------------------------------------------------------------------------
		-- Count and store the differences of the 1st and the 2nd measurement, prepare #temp_IOVFStats1
		------------------------------------------------------------------------------------------------
		EXEC sp_executesql @CollectSQLCommand

		TRUNCATE TABLE #temp_IOVFStats1

		INSERT INTO #temp_IOVFStats1 
		SELECT [database_id], [file_id], [sample_ms], [num_of_reads], [num_of_bytes_read], [io_stall_read_ms], [num_of_writes], [num_of_bytes_written], [io_stall_write_ms] 
		FROM #temp_IOVFStats2

		TRUNCATE TABLE #temp_IOVFStats2

		SET @loop_count = @loop_count + 1

	END

	DROP TABLE #temp_IOVFStats1
	
	DROP TABLE #temp_IOVFStats2

	DROP TABLE #temp_filter

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@retention AS nvarchar) + N', GETDATE()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = 'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END



END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()

	IF OBJECT_ID ('tempdb..#temp_IOVFStats1') IS NOT NULL
	BEGIN
		DROP TABLE #temp_IOVFStats1
	END

	IF OBJECT_ID ('tempdb..#temp_IOVFStats2') IS NOT NULL
	BEGIN
		DROP TABLE #temp_IOVFStats2
	END

	IF OBJECT_ID ('tempdb..#temp_filter') IS NOT NULL
	BEGIN
		DROP TABLE #temp_filter
	END
	
	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectPerfmonData ------------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectPerfmonData')
	EXEC ('CREATE PROC dbo.sp_CollectPerfmonData AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectPerfmonData]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectPerfmonData.sql

Example:
EXEC sp_CollectPerfmonData
@DestTable = NULL,
@DestSchema = NULL,
@TSMode = 0,
@EmptyTSTable = 0,
@CollectingInterval = NULL,
@SampleInterval = 10,
@MeasuringInterval = 3,
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Instance Related Performance Counters

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = NULL,
@DestSchema NVARCHAR(25) = NULL,
@TSMode BIT = 0,
@EmptyTSTable BIT = 0,
@CollectingInterval SMALLINT = NULL,
@SampleInterval SMALLINT = 10,
@MeasuringInterval TINYINT = 3,
@Retention SMALLINT = 90,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help =1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'NVARCHAR(128)', N'NULL', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'NVARCHAR(25)', N'NULL', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'BIT', N'0', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'BIT', N'0', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'SMALLINT', N'NULL', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'SMALLINT', N'10', N'Times in seconds between taking two samples.'
	
	UNION ALL
	SELECT N'@MeasuringInterval', N'TINYINT', N'3', N'Time in seconds between the 1st and 2nd measurement of the data sampling for measuring data during the collecting interval.'
	
	SELECT N'Standard' AS [Running Mode], N'[dbo].[perfmon_data]' AS [Default Table]
	UNION ALL
	SELECT N'Troubleshooting', N'[dbo].[ts_perfmon_data]'

	SELECT N'Filtering table' AS [Filtering], N'[dbo].[filter_performance_counters]' AS [Info]
    UNION ALL
	SELECT N'Type of Filtering', N'Include'
	UNION ALL
	SELECT N'Column used in Standardmode', N'[is_included]'
	UNION ALL
	SELECT N'Column used in TSMode', N'[ts_is_included]'  

	SELECT [counter_name], [is_included], [ts_is_included] FROM [dbo].[filter_performance_counters] ORDER BY [counter_name]

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @FirstMeasurementSQLCommand NVARCHAR(max)
DECLARE @SecondMeasurementSQLCommand NVARCHAR(max)
DECLARE @CollectSQLCommand NVARCHAR(max)
DECLARE @SQLCommand NVARCHAR(max)
DECLARE @waitfor_delay NVARCHAR (8)
DECLARE @sample_interval NVARCHAR(12)

DECLARE @start_loop DATETIME
DECLARE @max_loop INT
DECLARE @loop_count INT

DECLARE @row_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
			+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF((@MeasuringInterval NOT BETWEEN 1 AND 60) OR @MeasuringInterval IS NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @MeasuringInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF((@SampleInterval NOT BETWEEN 1 AND 300) OR @SampleInterval IS NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @SampleInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@CollectingInterval NOT BETWEEN 1 AND 1440 AND @CollectingInterval IS NOT NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @CollectingInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
	ELSE
	BEGIN
		IF(@MeasuringInterval >= @SampleInterval)
		BEGIN
			SET @ErrorMessage = N'Parameter @SampleInterval MUST be larger than @MeasuringInterval!'
			SET @Severity=16
			RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF @TSMode IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @TSMode is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @EmptyTSTable IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @EmptyTSTable is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @Retention < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	--------------
	-- TSMode = 0
	--------------
	IF(@TSMode = 0)
	BEGIN
		SET @DestTable = N'perfmon_data'
		SET @DestSchema = N'dbo'
	END
	--------------
	-- TSMode = 1
	--------------
	ELSE
	BEGIN
		IF(@DestTable IS NOT NULL)
		BEGIN
			SET @DestTable = REPLACE(REPLACE(RTRIM(LTRIM(@DestTable)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestTAble = N'ts_perfmon_data'
		END
		
		IF(@DestSchema IS NOT NULL)
		BEGIN
			SET @DestSchema = REPLACE(REPLACE(RTRIM(LTRIM(@DestSchema)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestSchema = N'dbo'
		END
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
			+ N' @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
			+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
			+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
			+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
			+ N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
			+ N', @SampleInterval = ' + CAST(@SampleInterval AS nvarchar)
			+ N', @MeasuringInterval = ' + CAST(@MeasuringInterval AS nvarchar)
			+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
			+ N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@Retention > 0 AND @TSMode = 1)
	BEGIN
		SET @Retention = NULL
		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'Parameter @Retention has been changed to 0. Reason: @TSMode is enabled. Tables for troubleshooting have to be maintained manually.' 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable)) IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' does not exist!' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@TSMode = 1 AND @EmptyTSTable = 1)
	BEGIN
		SET @SQLCommand = N'TRUNCATE TABLE ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) 
		EXEC sp_executesql @SQLCommand
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Create temp table and set variables
	---------------------------------------------------------------------------------------------------------------------------------------
	SET @FirstMeasurementSQLCommand = N'INSERT INTO #temp_perfcounters 
			( [Counter], [CounterType], [FirstValue], [FirstDateTime] ) 
			 SELECT 
			 RIGHT(RTRIM(object_name),CHARINDEX('':'',REVERSE(RTRIM(object_name)))-1) + N'':'' + RTRIM([counter_name]) + N'':'' + RTRIM([instance_name]), 
			 [cntr_type], [cntr_value], GETDATE() 
			 FROM sys.dm_os_performance_counters '
	
	IF(@TSMode = 0)
	BEGIN
		SET @FirstMeasurementSQLCommand = @FirstMeasurementSQLCommand + N' WHERE [counter_name] IN ( SELECT [counter_name] FROM [dbo].[filter_performance_counters] WHERE [is_included] = 1 ) '
	END
	ELSE
	BEGIN
		SET @FirstMeasurementSQLCommand = @FirstMeasurementSQLCommand + N' WHERE [counter_name] IN ( SELECT [counter_name] FROM [dbo].[filter_performance_counters] WHERE [ts_is_included] = 1 ) '
	END

	SET @SecondMeasurementSQLCommand = N'UPDATE #temp_perfcounters 
			 SET [SecondValue] = [cntr_value], 
			 [SecondDateTime] = GETDATE() 
			 FROM #temp_perfcounters INNER JOIN sys.dm_os_performance_counters 
			 ON [Counter] = RIGHT(RTRIM(object_name),CHARINDEX('':'',REVERSE(RTRIM(object_name)))-1) + N'':'' + RTRIM([counter_name]) + N'':'' + RTRIM([instance_name]) ' 
	
	IF(@TSMode = 0)
	BEGIN
		SET @SecondMeasurementSQLCommand = @SecondMeasurementSQLCommand + N' WHERE [counter_name] IN ( SELECT [counter_name] FROM [dbo].[filter_performance_counters] WHERE [is_included] = 1 ) '
	END
	ELSE
	BEGIN
		SET @SecondMeasurementSQLCommand = @SecondMeasurementSQLCommand + N' WHERE [counter_name] IN ( SELECT [counter_name] FROM [dbo].[filter_performance_counters] WHERE [ts_is_included] = 1 ) '
	END
		
	SET @CollectSQLCommand = N'INSERT INTO '+ QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
			 ([counter], [value], [capture_date] ) 
			 SELECT [Counter], [CounterValue], [SecondDateTime] 
			 FROM #temp_perfcounters '

	CREATE TABLE #temp_perfcounters
		(
		[Counter] NVARCHAR(770), 
		[CounterType] INT, 
		[FirstValue] DECIMAL(38, 2), 
		[FirstDateTime] DATETIME, 
		[SecondValue] DECIMAL(38, 2), 
		[SecondDateTime] DATETIME, 
		[ValueDiff] AS ( [SecondValue] - [FirstValue] ), 
		[TimeDiff] AS ( DATEDIFF(SS, FirstDateTime, SecondDateTime) ), 
		[CounterValue] DECIMAL(38, 2)
		)

	IF(@CollectingInterval IS NULL)
	BEGIN
		SET @max_loop = 1
		SET @SampleInterval = NULL
	END
	ELSE
	BEGIN
		SET @max_loop = @CollectingInterval*60/@SampleInterval
	END

	SET @waitfor_delay = CONVERT(NVARCHAR(8), DATEADD(ss, @MeasuringInterval, 0), 114)

	IF(@debug > 0)
	BEGIN
		SET @InfoMessage = N'Number of loops - @max_loop: ' + CAST(@max_loop AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Time between the 1st and 2nd measurement - @waitfor_delay: ' + @waitfor_delay 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	SET @loop_count = 0

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Collect performance counters
	---------------------------------------------------------------------------------------------------------------------------------------
	WHILE(@loop_count < @max_loop)
	BEGIN
		SET @start_loop = GETDATE()
		-----------------------------------------
		-- 1st measurement
		-----------------------------------------
		IF(@debug > 0)
		BEGIN
			SET @InfoMessage = N'FirstMeasurement~' + CONVERT(nvarchar, @start_loop,21) 
			IF(@debug > 1)
			BEGIN
				IF(@debug > 2)
				BEGIN
					SELECT @InfoMessage
					SELECT * FROM  #temp_perfcounters
				END
				SET @InfoMessage = @InfoMessage + CHAR(13) + CHAR(10) + @FirstMeasurementSQLCommand
			END
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		EXEC sp_executesql @FirstMeasurementSQLCommand

		WAITFOR DELAY @waitfor_delay;

		-----------------------------------------
		-- 2nd measurement
		-----------------------------------------
		IF(@debug > 0)
		BEGIN
			SET @InfoMessage = N'SecondMeasurement~' + CONVERT(nvarchar, GETDATE(),21) + N' /'+ CONVERT(nvarchar, DATEADD(ms, CAST(DATEDIFF(ms,@start_loop,GETDATE()) AS INT), 0), 114) + N'/' 
			IF(@debug > 1)
			BEGIN
				IF(@debug > 2)
				BEGIN
					SELECT @InfoMessage
					SELECT * FROM #temp_perfcounters
				END
				SET @InfoMessage = @InfoMessage + CHAR(13) + CHAR(10) + @SecondMeasurementSQLCommand 
			END
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		EXEC sp_executesql @SecondMeasurementSQLCommand
		
		-----------------------------------------
		-- Update cntr type 272696576
		-----------------------------------------
		UPDATE  #temp_perfcounters 
			SET [CounterValue] = [ValueDiff] / [TimeDiff]
			WHERE [CounterType] = 272696576

		IF(@debug > 1)
		BEGIN
			SET @InfoMessage = N'After updating cntr_type(272696576)' 
			IF(@debug > 2)
			BEGIN
				SELECT @InfoMessage
				SELECT * FROM #temp_perfcounters
			END
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		-----------------------------------------
		-- Update cntr type 65792
		-----------------------------------------
		UPDATE #temp_perfcounters 
			SET [CounterValue] = [SecondValue]
			WHERE [CounterType] = 65792

		IF(@debug > 1)
		BEGIN
			SET @InfoMessage = N'After updating cntr_type(65792)'  
			IF(@debug > 2)
			BEGIN
				SELECT @InfoMessage
				SELECT * FROM #temp_perfcounters
			END
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		----------------------------------------------------------------------
		-- Insert collected data to table 
		----------------------------------------------------------------------
		IF(@debug > 1)
		BEGIN
			SET @InfoMessage = N'Insert Command' + CHAR(13) + CHAR(10) + @CollectSQLCommand 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		EXEC sp_executesql @CollectSQLCommand

		TRUNCATE TABLE #temp_perfcounters

		SET @loop_count = @loop_count + 1

		SET @sample_interval = CONVERT(nvarchar, ISNULL(DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, GETDATE()) AS INT), 0), N'00:00:00'), 114)

		IF(@debug > 0)
		BEGIN
			SET @InfoMessage = N'Sample interval (inside the loop): ' + @sample_interval 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		WAITFOR DELAY @sample_interval;
	END

	DROP TABLE #temp_perfcounters
	
	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@retention AS nvarchar) + N', GETDATE()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()
	
	IF OBJECT_ID ('tempdb..#temp_perfcounters') IS NOT NULL
	BEGIN
		DROP TABLE #temp_perfcounters
	END

	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT
	
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectTempDBUsage ------------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectTempDBUsage')
	EXEC ('CREATE PROC dbo.sp_CollectTempDBUsage AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectTempDBUsage]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectTempDBUsage.sql

Example:
EXEC sp_CollectTempDBUsage
@DestTable = NULL,
@DestSchema = NULL,
@TSMode = 0,
@EmptyTSTable = 0,
@Retention = 90,
@CollectingInterval = NULL,
@SampleInterval = 60,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server TempDB usage raw data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = NULL,
@DestSchema NVARCHAR(25) = NULL,
@TSMode BIT = 0,
@EmptyTSTable BIT = 0,
@Retention SMALLINT = 90,
@CollectingInterval SMALLINT = NULL,
@SampleInterval SMALLINT = 60,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN

SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'
	
	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'NVARCHAR(128)', N'NULL', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'NVARCHAR(25)', N'NULL', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'BIT', N'0', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'BIT', N'0', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'SMALLINT', N'NULL', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'SMALLINT', N'60', N'Times in seconds between taking two samples.'
	
	SELECT N'Standard' AS [Running Mode], N'[dbo].[tempdb_usage]' AS [Default Table]
	UNION ALL
	SELECT N'Troubleshooting', N'[dbo].[ts_tempdb_usage]'

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @CollectSQLCommand NVARCHAR(max)
DECLARE @SQLCommand NVARCHAR(max)

DECLARE @row_count INT

DECLARE @start_loop DATETIME
DECLARE @max_loop INT
DECLARE @loop_count INT
DECLARE @sample_interval NVARCHAR(12)

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF((@SampleInterval NOT BETWEEN 1 AND 3600) OR @SampleInterval IS NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @SampleInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@CollectingInterval NOT BETWEEN 1 AND 1440 AND @CollectingInterval IS NOT NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @CollectingInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
	ELSE 
	BEGIN
		IF(@CollectingInterval IS NOT NULL AND @SampleInterval > @CollectingInterval*60 )
		BEGIN
			SET @ErrorMessage = N'The time interval of sampling is larger than the collecting time interval!'
			SET @Severity=16
			RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF @TSMode IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @TSMode is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @EmptyTSTable IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @EmptyTSTable is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @Retention < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	--------------
	-- TSMode = 0
	--------------
	IF(@TSMode = 0)
	BEGIN
		SET @DestTable = N'tempdb_usage'
		SET @DestSchema = N'dbo'
	END
	--------------
	-- TSMode = 1
	--------------
	ELSE
	BEGIN
		IF(@DestTable IS NOT NULL)
		BEGIN
			SET @DestTable = REPLACE(REPLACE(RTRIM(LTRIM(@DestTable)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestTAble = N'ts_tempdb_usage'
		END
		
		IF(@DestSchema IS NOT NULL)
		BEGIN
			SET @DestSchema = REPLACE(REPLACE(RTRIM(LTRIM(@DestSchema)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestSchema = N'dbo'
		END
	END
				
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
		+ N' @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		+ N', @SampleInterval = ' + CAST(@SampleInterval AS nvarchar)
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = ' + CAST(@LogInfo AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@Retention > 0 AND @TSMode = 1)
	BEGIN
		SET @Retention = 0
		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'Parameter @Retention has been changed to 0. Reason: @TSMode is enabled. Tables for troubleshooting have to be maintained manually.' 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable)) IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' does not exist!' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@TSMode = 1 AND @EmptyTSTable = 1)
	BEGIN
		SET @SQLCommand = N'TRUNCATE TABLE ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) 
		EXEC sp_executesql @SQLCommand
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set variables
	---------------------------------------------------------------------------------------------------------------------------------------
	SET @CollectSQLCommand = N'INSERT INTO ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N'
			 ( [capture_date], [file_id], [drive], [unallocated_extent_page_count], [version_store_reserved_page_count], [user_object_reserved_page_count], [internal_object_reserved_page_count], [mixed_extent_page_count]  ) 
			 SELECT GETDATE() AS [capture_date], [tfsu].[file_id], LEFT([mf].[physical_name],1) AS [drive], [unallocated_extent_page_count], [version_store_reserved_page_count], [user_object_reserved_page_count], [internal_object_reserved_page_count], [mixed_extent_page_count] 
			 FROM sys.dm_db_file_space_usage AS [tfsu] INNER JOIN sys.master_files AS [mf] 
			 ON [tfsu].[file_id]=[mf].[file_id] AND [tfsu].[database_id] = [mf].[database_id] 
			 WHERE [tfsu].[database_id] = 2 '

	IF(@CollectingInterval IS NULL)
	BEGIN
		SET @max_loop = 1
		SET @SampleInterval = NULL
	END
	ELSE
	BEGIN
		SET @max_loop = @CollectingInterval*60/@SampleInterval
	END

	IF(@debug > 0)
	BEGIN
		SET @InfoMessage = N'Number of loops - @max_loop: ' + CAST(@max_loop AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	SET @loop_count = 0
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Collect TempDB Usage Data 
	---------------------------------------------------------------------------------------------------------------------------------------
	WHILE(@loop_count < @max_loop)
	BEGIN
		SET @start_loop = GETDATE()
		
		EXEC sp_executesql @CollectSQLCommand

		SET @loop_count = @loop_count + 1

		SET @sample_interval = CONVERT(nvarchar, ISNULL(DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, GETDATE()) AS INT), 0), N'00:00:00'), 114)

		IF(@debug > 0)
		BEGIN
			SET @InfoMessage = N'Sample interval (inside the loop): ' + @sample_interval 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		WAITFOR DELAY @sample_interval;
	END

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@retention AS nvarchar) + N', GETDATE()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()
	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/*- sp_CollectWaitStats --------------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_CollectWaitStats')
	EXEC ('CREATE PROC dbo.sp_CollectWaitStats AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_CollectWaitStats]

/*********************************************************************************************
Written by Robert Virag

File: sp_CollectWaitStats.sql

Example:
EXEC sp_CollectWaitStats
@DestTable = NULL,
@DestSchema = NULL,
@MeasuringInterval = NULL,
@ResetWaitStats = 0,
@TSMode = 0,
@EmptyTSTable = 0,
@Retention = 90,
@help = 0,
@LogInfo = 1

Version: V1.1 - 2015.04

Tested: SQL Server 2005 / 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collect SQL Server Wait Statistics Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = NULL,
@DestSchema NVARCHAR(25) = NULL,
@MeasuringInterval SMALLINT = NULL,
@ResetWaitStats BIT = 0,
@TSMode BIT = 0,
@EmptyTSTable BIT = 0,
@Retention SMALLINT = 90,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = 1

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	SELECT N'@help' AS [Parameter Name],
           N'BIT' AS [Data Type],
		   N'0' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'BIT', N'1', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'SMALLINT', N'90', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'NVARCHAR(128)', N'NULL', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'NVARCHAR(25)', N'NULL', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'BIT', N'0', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'BIT', N'0', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@MeasuringInterval', N'SMALLINT', N'NULL', N'Time in minutes between the 1st and 2nd measurement of the data sampling for measuring data.'

	UNION ALL
	SELECT N'@ResetWaitStats', N'BIT', N'0', N'Clear the sys.dm_os_wait_stats after the data collection.'

	SELECT N'Standard' AS [Running Mode], N'[dbo].[wait_stats]' AS [Default Table]
	UNION ALL
	SELECT N'Troubleshooting', N'[dbo].[ts_wait_stats]'

	SELECT N'Filtering table' AS [Filtering], N'[dbo].[filter_wait_types]' AS [Info]
    UNION ALL
	SELECT N'Type of Filtering', N'Exclude'
	UNION ALL
	SELECT N'Column used in Standardmode', N'[is_excluded]'
	UNION ALL
	SELECT N'Column used in TSMode', N'[ts_is_excluded]'  

	SELECT [wait_type], [is_excluded], [ts_is_excluded] FROM [dbo].[filter_wait_types] ORDER BY [wait_type]

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @data_compression NVARCHAR(35)
DECLARE @SQLCommand NVARCHAR(max)
DECLARE @waitfor_delay NVARCHAR (8)

DECLARE @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP NVARCHAR(max)

DECLARE @LockResult INT
DECLARE @RequiredAppLock NVARCHAR(25)

DECLARE @row_count INT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	
	IF(@MeasuringInterval NOT BETWEEN 1 AND 1440 AND @MeasuringInterval IS NOT NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @MeasuringInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF @ResetWaitStats IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @ResetWaitStats is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @TSMode IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @TSMode is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @EmptyTSTable IS NULL 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @EmptyTSTable is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @Retention < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @Retention is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	
	IF @help IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @help is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @LogInfo IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @LogInfo is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @debug IS NULL OR @debug < 0
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @debug is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	--------------
	-- TSMode = 0
	--------------
	IF(@TSMode = 0)
	BEGIN
		SET @DestTable = N'wait_stats'
		SET @DestSchema = N'dbo'
	END
	--------------
	-- TSMode = 1
	--------------
	ELSE
	BEGIN
		IF(@DestTable IS NOT NULL)
		BEGIN
			SET @DestTable = REPLACE(REPLACE(RTRIM(LTRIM(@DestTable)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestTAble = N'ts_wait_stats'
		END
		
		IF(@DestSchema IS NOT NULL)
		BEGIN
			SET @DestSchema = REPLACE(REPLACE(RTRIM(LTRIM(@DestSchema)), N'[',N''), N']',N'')
		END
		ELSE
		BEGIN
			SET @DestSchema = N'dbo'
		END
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
		+ N' @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @MeasuringInterval = ' + ISNULL(CAST(@MeasuringInterval as nvarchar), N'NULL')
		+ N', @ResetWaitStats  = ' + CAST(@ResetWaitStats AS nvarchar)
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	IF(@MeasuringInterval BETWEEN 1 AND 1440 AND @MeasuringInterval IS NOT NULL)
	BEGIN
		IF(@ResetWaitStats = 1)
		BEGIN
			SET @ResetWaitStats = 0
			IF(@LogInfo = 1)
			BEGIN
				SET @InfoMessage = N'Parameter @ResetWaitStats has been changed from 1 to 0. Reason: @MeasuringInterval is specified.' 
				SET @Severity = 10
				RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
			END
		END
	END

	IF(@TSMode = 1)
		BEGIN
		IF(@Retention > 0)
		BEGIN
			SET @Retention = 0
			IF(@LogInfo = 1)
			BEGIN
				SET @InfoMessage = N'Parameter @Retention has been changed to 0. Reason: @TSMode is enabled. Tables for troubleshooting have to be maintained manually.' 
				SET @Severity = 10
				RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
			END
		END
	END
		
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Schema check
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(OBJECT_ID(QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable)) IS NULL)
	BEGIN
		SET @ErrorMessage = N'Table ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' does not exist!' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Handle concurrent running
	---------------------------------------------------------------------------------------------------------------------------------------	
	IF(@ResetWaitStats = 1)
	BEGIN
		SET @RequiredAppLock = N'Exclusive'
		EXEC @LockResult = sp_getapplock @Resource= N'WaitStatsData', 
			@LockMode=@RequiredAppLock, 
			@LockOwner = N'Session',
			@LockTimeout=500
		IF(@LockResult NOT IN (0,1))
		BEGIN
			SET @ErrorMessage = N'Unable to acquire the appropriate Application Lock(' + @RequiredAppLock + '). Possible cause: Another instance of sp_CollectWaitStatsData is running. sp_CollectWaitStatsData can not run parralel itself with parameter @ResetWaitStats = 1.'
			SET @Severity = 16
			RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
		END
	END
	ELSE
	BEGIN
		SET @RequiredAppLock = N'Shared'
		EXEC @LockResult = sp_getapplock @Resource= N'WaitStatsData', 
			@LockMode=@RequiredAppLock, 
			@LockOwner = N'Session',
			@LockTimeout=500
		IF(@LockResult NOT IN (0,1))
		BEGIN
			SET @ErrorMessage = N'Unable to acquire the appropriate Application Lock(' + @RequiredAppLock + '). Possible cause: Another instance of sp_CollectWaitStatsData is running with parameter @ResetWaitStats = 1. sp_CollectWaitStatsData can not run parralel itself with @ResetWaitStats = 1.'
			SET @Severity = 16
			RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
			RETURN
		END
	END

	IF(@debug >1)
	BEGIN
		SET @InfoMessage = N'Acquired AppLock: ' + APPLOCK_MODE(N'public', N'WaitStatsData', N'Session') + N' | LockResult: '+ CAST(@LockResult AS NVARCHAR(5)) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Collect waitstats
	---------------------------------------------------------------------------------------------------------------------------------------	
	------------------------------------------
	-- One time measurement
	------------------------------------------
	IF(@MeasuringInterval IS NULL)
	BEGIN
		SET @SQLCommand = N'INSERT INTO ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
				 ([capture_date], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms])  
				 SELECT GETDATE(), [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
				 FROM sys.dm_os_wait_stats '
		------------------------------------------
		-- Standard Mode
		------------------------------------------
		IF(@TSMode = 0)
		BEGIN
			SET @SQLCommand = @SQLCommand + N' WHERE [wait_type] NOT IN( SELECT [wait_type] FROM [filter_wait_types] WHERE [is_excluded] = 1 ) AND [waiting_tasks_count] <> 0'
		END
		----------------------------------------------
		-- Troubleshooting Mode
		----------------------------------------------
		ELSE
		BEGIN
			SET @SQLCommand = @SQLCommand + N' WHERE [wait_type] NOT IN( SELECT [wait_type] FROM [filter_wait_types] WHERE [ts_is_excluded] = 1 ) AND [waiting_tasks_count] <> 0 '
		END

		EXEC sp_executesql @SQLCommand
	END
	------------------------------------------
	-- Interval measurement
	------------------------------------------
	ELSE
	BEGIN
		IF(@MeasuringInterval = 1440)
		BEGIN
			SET @waitfor_delay = CONVERT(varchar, DATEADD(ss, @MeasuringInterval*60-1, 0), 114)
		END
		ELSE
		BEGIN
			SET @waitfor_delay = CONVERT(NVARCHAR(8), DATEADD(ss, @MeasuringInterval*60, 0), 114)
		END
		
		------------------------------------------
		-- 1st measurement of the interval
		------------------------------------------
		SELECT GETDATE() AS [first_measurement], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
			INTO #temp_stats1 FROM sys.dm_os_wait_stats
	
		IF(@debug > 0)
		BEGIN
			SET @InfoMessage = N'@MeasuringInterval: ' + CAST(@MeasuringInterval AS NVARCHAR(10))+ CHAR(13) + CHAR(10)
				+N'@waitfor_delay: ' + @waitfor_delay 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		WAITFOR DELAY @waitfor_delay

		------------------------------------------
		-- 2nd measurement of the interval
		------------------------------------------
		SELECT GETDATE() AS [second_measurement], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
			INTO #temp_stats2 FROM sys.dm_os_wait_stats
		
		----------------------------------------------------------------------
		-- Count and store the differences of the 1st and the 2nd measurement 
		----------------------------------------------------------------------
		IF (@@VERSION LIKE N'%Microsoft SQL Server 2005%' 
			OR (@@VERSION LIKE N'%Microsoft SQL Server 2008%' 
				AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2008 R2%')) 
			AND (
			(@TSMode = 0 AND (SELECT [is_excluded] FROM [dbo].[filter_wait_types] WHERE [wait_type] = 'AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP') = 0) 
			OR
			(@TSMode = 1 AND (SELECT [ts_is_excluded] FROM [dbo].[filter_wait_types] WHERE [wait_type] = 'AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP') = 0) )
		BEGIN
			SET @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP = N' UNION
				 SELECT GETDATE(), ''AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP'' AS [wait_type], 
				 1 AS [waiting_tasks_count], 
				 DATEDIFF(ms,(SELECT TOP 1 [first_measurement] FROM #temp_stats1),(SELECT TOP 1 [second_measurement] FROM #temp_stats2)) AS [wait_time_ms], 
				 1 AS [max_wait_time_ms], 
				 0 AS [signal_wait_time_ms] '
		END
		ELSE
		BEGIN
			SET @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP = N''
		END

		SET @SQLCommand = N'WITH [DiffWaits] AS	(  
			/* Waits that werent in the first snapshot */
				 SELECT [ts2].[wait_type], [ts2].[waiting_tasks_count], [ts2].[wait_time_ms], [ts2].[max_wait_time_ms], [ts2].[signal_wait_time_ms] 
				 FROM #temp_stats2 AS [ts2] LEFT OUTER JOIN #temp_stats1 AS [ts1] 
				 ON [ts2].[wait_type] = [ts1].[wait_type] 
				 WHERE [ts1].[wait_type] IS NULL AND [ts2].[wait_time_ms] > 0 
				 UNION 
			/* Diff of waits in both snapshots */
				 SELECT [ts2].[wait_type], [ts2].[waiting_tasks_count] - [ts1].[waiting_tasks_count] AS [waiting_tasks_count], [ts2].[wait_time_ms] - [ts1].[wait_time_ms] AS [wait_time_ms], ts2.[max_wait_time_ms], [ts2].[signal_wait_time_ms] - [ts1].[signal_wait_time_ms] AS [signal_wait_time_ms] 
				 FROM #temp_stats2 AS [ts2] LEFT OUTER JOIN #temp_stats1 AS [ts1] 
				 ON [ts2].[wait_type] = [ts1].[wait_type] 
				 WHERE [ts1].[wait_type] IS NOT NULL AND [ts2].[waiting_tasks_count] - [ts1].[waiting_tasks_count] > 0 AND [ts2].[wait_time_ms] - [ts1].[wait_time_ms] > 0 
				 ) 
				 INSERT INTO ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
				 ([capture_date], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms])  
				 SELECT GETDATE(), [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
				 FROM DiffWaits '
		------------------------------------------
		-- Standard Mode
		------------------------------------------
		IF(@TSMode = 0)
		BEGIN
			SET @SQLCommand = @SQLCommand + N' WHERE [wait_type] NOT IN( SELECT [wait_type] FROM [filter_wait_types] WHERE [is_excluded] = 1 ) AND [waiting_tasks_count] <> 0 ' + @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP
		END
		----------------------------------------------
		-- Troubleshooting Mode
		----------------------------------------------
		ELSE
		BEGIN
			SET @SQLCommand = @SQLCommand + N' WHERE [wait_type] NOT IN( SELECT [wait_type] FROM [filter_wait_types] WHERE [ts_is_excluded] = 1 ) AND [waiting_tasks_count] <> 0 ' + @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP
		END 

		IF(@debug > 2)
		BEGIN
			SELECT N'#temp_stats1 Table'
			SELECT * FROM #temp_stats1

			SELECT N'#temp_stats2 Table'
			SELECT * FROM #temp_stats2

			SET @InfoMessage = N'WaitStats collector command: ' + CHAR(13) + CHAR(10) + @SQLCommand 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

		EXEC sp_executesql @SQLCommand

		DROP TABLE #temp_stats1
		DROP TABLE #temp_stats2

	END

	------------------------------------------
	-- Reset WaitStats
	------------------------------------------
	IF(@ResetWaitStats = 1)
	BEGIN
		DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR)

		If(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'DMV [sys].[dm_os_wait_stats] has been reseted.' 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	EXEC @LockResult = sp_releaseapplock 
			@Resource= N'WaitStatsData',
			@LockOwner = N'Session'

	IF(@debug > 1)
		BEGIN
			SET @InfoMessage = N'AppLock released: ' + APPLOCK_MODE(N'public', N'WaitStatsData', N'Session') + N' | LockResult: '+ CAST(@LockResult AS NVARCHAR(5)) 
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@retention AS nvarchar) + N', GETDATE()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

END TRY
---------------------------------------------------------------------------------------------------------------------------------------
-- Handle Errors
---------------------------------------------------------------------------------------------------------------------------------------
BEGIN CATCH
	DECLARE @ErrMsg NVARCHAR(4000)
	DECLARE @ErrSev INT
	SET @ErrSev = ERROR_SEVERITY()
	SET @ErrMsg = ERROR_MESSAGE()

	IF OBJECT_ID (N'tempdb..#temp_stats1' ) IS NOT NULL
	BEGIN
		DROP TABLE #temp_stats1
	END

	IF OBJECT_ID (N'tempdb..#temp_stats2' ) IS NOT NULL
	BEGIN
		DROP TABLE #temp_stats2
	END
		
	RAISERROR(@ErrMsg, @ErrSev, 1) WITH NOWAIT

	IF(@LockResult IN (0,1))
	BEGIN
		IF(@debug > 1)
		BEGIN
			SET @InfoMessage = N'ERROR: Release AppLock: ' + APPLOCK_MODE(N'public', N'WaitStatsData', N'Session')  
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		EXEC @LockResult = sp_releaseapplock 
			@Resource= N'WaitStatsData',
			@LockOwner = N'Session'
	END

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Outcome: Failed' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,GETDATE(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

/******************************************************************************
****************************** CREATE COLLECTORS ******************************
**************************************END*************************************/

/************************************START*************************************
********************************* CREATE JOBS *********************************
******************************************************************************/

/*********************************************************************************************
Create Jobs for the collectors

For scheduling the collectors with agent jobs, Ola Hallengren's code is used
with his permission.

http://ola.hallengren.com/license.html

*********************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DECLARE @CreateJobs TINYINT
DECLARE @OutputFileDirectory nvarchar(max)
DECLARE @drop_jobs_if_exist TINYINT

SELECT @CreateJobs = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@CreateJobs'

SELECT @OutputFileDirectory = value FROM #TempConfiguration WHERE [variable] = N'@OutputFileDirectory'

SELECT @drop_jobs_if_exist = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@DropJobsIfExist'
	

IF RIGHT(@OutputFileDirectory, 1) = N'\'
BEGIN
	SET @OutputFileDirectory = LEFT(@OutputFileDirectory, LEN(@OutputFileDirectory)-1)
END

IF SERVERPROPERTY('EngineEdition') <> 4
BEGIN
	DECLARE @JobCategory nvarchar(max)
	SET @JobCategory = N'Baseline Collector'

	IF NOT EXISTS (SELECT * FROM [msdb].[dbo].[syscategories] WHERE [category_class] = 1 AND [category_type] = 1 AND [name] = @JobCategory)
	BEGIN
		EXEC [msdb].[dbo].sp_add_category @class = N'JOB', @type = 'LOCAL', @name = @JobCategory
	END
		
	DECLARE @Version numeric(18,10)

	DECLARE @TokenServer nvarchar(max)
	DECLARE @TokenJobID nvarchar(max)
	DECLARE @TokenStepID nvarchar(max)
	DECLARE @TokenDate nvarchar(max)
	DECLARE @TokenTime nvarchar(max)
	DECLARE @TokenLogDirectory nvarchar(max)

	DECLARE @JobDescription nvarchar(max)
	DECLARE @JobOwner nvarchar(max)

	DECLARE @JobName01 nvarchar(max)
	DECLARE @JobName02 nvarchar(max)
	DECLARE @JobName03 nvarchar(max)
	DECLARE @JobName04 nvarchar(max)
	DECLARE @JobName05 nvarchar(max)
	DECLARE @JobName06 nvarchar(max)
	DECLARE @JobName07 nvarchar(max)
	DECLARE @JobName08 nvarchar(max)

	DECLARE @JobCommand01 nvarchar(max)
	DECLARE @JobCommand02 nvarchar(max)
	DECLARE @JobCommand03 nvarchar(max)
	DECLARE @JobCommand04 nvarchar(max)
	DECLARE @JobCommand05 nvarchar(max)
	DECLARE @JobCommand06 nvarchar(max)
	DECLARE @JobCommand07 nvarchar(max)
	DECLARE @JobCommand08 nvarchar(max)

	DECLARE @OutputFile01 nvarchar(max)
	DECLARE @OutputFile02 nvarchar(max)
	DECLARE @OutputFile03 nvarchar(max)
	DECLARE @OutputFile04 nvarchar(max)
	DECLARE @OutputFile05 nvarchar(max)
	DECLARE @OutputFile06 nvarchar(max)
	DECLARE @OutputFile07 nvarchar(max)
	DECLARE @OutputFile08 nvarchar(max)

	SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

	IF @Version >= 9.002047
	BEGIN
	SET @TokenServer = '$' + '(ESCAPE_SQUOTE(SRVR))'
	SET @TokenJobID = '$' + '(ESCAPE_SQUOTE(JOBID))'
	SET @TokenStepID = '$' + '(ESCAPE_SQUOTE(STEPID))'
	SET @TokenDate = '$' + '(ESCAPE_SQUOTE(STRTDT))'
	SET @TokenTime = '$' + '(ESCAPE_SQUOTE(STRTTM))'
	END
	ELSE
	BEGIN
	SET @TokenServer = '$' + '(SRVR)'
	SET @TokenJobID = '$' + '(JOBID)'
	SET @TokenStepID = '$' + '(STEPID)'
	SET @TokenDate = '$' + '(STRTDT)'
	SET @TokenTime = '$' + '(STRTTM)'
	END

	IF @Version >= 12
	BEGIN
	SET @TokenLogDirectory = '$' + '(ESCAPE_SQUOTE(SQLLOGDIR))'
	END

	SET @JobDescription = 'Source: http://sqlapprentice.net'

	SET @JobOwner = SUSER_SNAME(0x01)

	SET @JobName01 = N'Baseline - CollectConfigData'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName01) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName01, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectConfigData] @Retention = 90, @BypassNonActiveSrvConfError = 1, @LogInfo = 1 */
		SET @JobCommand01 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectConfigData] @Retention = 90, @BypassNonActiveSrvConfError = 1, @LogInfo = 1" -b'
		SET @OutputFile01 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_ConfigData_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile01) > 200 SET @OutputFile01 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile01) > 200 SET @OutputFile01 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName01, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName01, @step_name = @JobName01, @subsystem = 'CMDEXEC', @command = @JobCommand01, @output_file_name = @OutputFile01, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName01
	END

	SET @JobName02 = N'Baseline - CollectDatabaseInfo'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName02) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName02, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectDatabaseInfo] @Retention = 90, @LogInfo = 1 */
		SET @JobCommand02 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectDatabaseInfo] @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile02 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_DatabaseInfo_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile02) > 200 SET @OutputFile02 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile02) > 200 SET @OutputFile02 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName02, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName02, @step_name = @JobName02, @subsystem = 'CMDEXEC', @command = @JobCommand02, @output_file_name = @OutputFile02, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName02
	END

	SET @JobName03 = N'Baseline - CollectFileInfo'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName03) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName03, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectFileInfo] @Retention = 90, @LogInfo = 1 */
		SET @JobCommand03 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectFileInfo] @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile03 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_FileInfo_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile03) > 200 SET @OutputFile03 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile03) > 200 SET @OutputFile03 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName03, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName03, @step_name = @JobName03, @subsystem = 'CMDEXEC', @command = @JobCommand03, @output_file_name = @OutputFile03, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName03
	END

	SET @JobName04 = N'Baseline - CollectIOVFStats'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName04) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName04, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectIOVFStats] @CollectingInterval  = NULL, @SampleInterval = 30, @Retention = 90, @LogInfo = 1 */
		SET @JobCommand04 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectIOVFStats] @CollectingInterval  = NULL, @SampleInterval = 30, @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile04 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_IOVFStats_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile04) > 200 SET @OutputFile04 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile04) > 200 SET @OutputFile04 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName04, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName04, @step_name = @JobName04, @subsystem = 'CMDEXEC', @command = @JobCommand04, @output_file_name = @OutputFile04, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName04
	END
	
	SET @JobName05 = N'Baseline - CollectPerfmonData'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName05) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName05, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectPerfmonData] @CollectingInterval = NULL, @SampleInterval = 15, @MeasuringInterval = 5, @Retention = 90, @LogInfo = 1 */
		SET @JobCommand05 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectPerfmonData] @CollectingInterval = NULL, @SampleInterval = 15, @MeasuringInterval = 5, @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile05 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_PerfmonData_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile05) > 200 SET @OutputFile05 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile05) > 200 SET @OutputFile05 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName05, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName05, @step_name = @JobName05, @subsystem = 'CMDEXEC', @command = @JobCommand05, @output_file_name = @OutputFile05, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName05
	END

	SET @JobName06 = N'Baseline - CollectTempDBUsage'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName06) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName06, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectTempDBUsage] @CollectingInterval = NULL, @SampleInterval = 10, @Retention = 90, @LogInfo = 1 */
		SET @JobCommand06 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectTempDBUsage] @CollectingInterval = NULL, @SampleInterval = 10, @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile06 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_TempDBUsage_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile06) > 200 SET @OutputFile06 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile06) > 200 SET @OutputFile06 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName06, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName06, @step_name = @JobName06, @subsystem = 'CMDEXEC', @command = @JobCommand06, @output_file_name = @OutputFile06, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName06
	END
	
	SET @JobName07 = N'Baseline - CollectWaitStats'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName07) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName07, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectWaitStats] @ResetWaitStats = 0, @MeasuringInterval = NULL, @Retention = 90, @LogInfo = 1 */
		SET @JobCommand07 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectWaitStats] @ResetWaitStats = 0, @MeasuringInterval = NULL, @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile07 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_WaitStats_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile07) > 200 SET @OutputFile07 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile07) > 200 SET @OutputFile07 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName07, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName07, @step_name = @JobName07, @subsystem = 'CMDEXEC', @command = @JobCommand07, @output_file_name = @OutputFile07, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName07
	END

	SET @JobName08 = N'Baseline - CollectInstanceInfo'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName08) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName08, @delete_unused_schedule=1
	END
	IF @CreateJobs = 1
	BEGIN
		/* [sp_CollectInstanceInfo] @Retention = 90, @LogInfo = 1 */
		SET @JobCommand08 = 'sqlcmd -E -S ' + @TokenServer + ' -d ' + DB_NAME() + ' -Q "EXECUTE [dbo].[sp_CollectInstanceInfo] @Retention = 90, @LogInfo = 1" -b'
		SET @OutputFile08 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + 'Baseline_InstanceInfo_' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile08) > 200 SET @OutputFile08 = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + '\' + @TokenJobID + '_' + @TokenStepID + '_' + @TokenDate + '.txt'
		IF LEN(@OutputFile08) > 200 SET @OutputFile08 = NULL

		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName08, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName08, @step_name = @JobName08, @subsystem = 'CMDEXEC', @command = @JobCommand08, @output_file_name = @OutputFile08, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName08
	END
END
GO

/******************************************************************************
********************************* CREATE JOBS *********************************
**************************************END*************************************/

/************************************START************************************
****************************** CREATE SCHEDULES ******************************
******************************************************************************/

/*********************************************************************************************
Create Schedules
*********************************************************************************************/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF SERVERPROPERTY('EngineEdition') <> 4
BEGIN
	DECLARE @create_schedules TINYINT
	DECLARE @schedule_name SYSNAME
	DECLARE @sa_name SYSNAME
	DECLARE @drop_schedule_if_exist TINYINT

	SELECT @sa_name = [name] FROM sys.server_principals WHERE [sid] = 0x01
	SELECT @create_schedules = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@CreateSchedules'
	SELECT @drop_schedule_if_exist = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@DropScheduleIfExist'
	

	SET @schedule_name = 'baseline - daily - at 2359PM'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=235900, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - at 2357PM'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=235700, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - at 2355PM'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=235500, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - at 2353PM'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=235300, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - at 2351PM'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=235100, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 5 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=5, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 5 mins - BT/6AM-7PM/' 
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=5, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - daily - every 10 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=10, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

		
	SET @schedule_name = 'baseline - daily - every 10 mins - BT/6AM-7PM/' 
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=10, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 15 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=15, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 15 mins - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=15, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 30 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=30, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 30 mins - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=4, 
			@freq_subday_interval=30, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - daily - every 1 hour'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,		 
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=1, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 1 hour - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=1, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - daily - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=3, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=6, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - daily - every 8 hours /6AM/2PM/10PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=8, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	
	SET @schedule_name = 'baseline - daily - evey 12 hours /6AM/6PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=8, 
			@freq_subday_interval=12, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 5 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=5, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 5 mins - BT/6AM-7PM/' 
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=5, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 10 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=10, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 10 mins - BT/6AM-7PM/' 
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=10, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 15 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=15, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 15 mins - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=15, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 30 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=30, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 30 mins - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=4, 
			@freq_subday_interval=30, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekday - every 1 hour'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,		 
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=1, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 1 hour - BT/6AM-7PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=1, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=190000,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - evey 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=3, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 6 hours /6AM/12PM/6PM/12AM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=6, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - every 8 hours /6AM/2PM/10PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=8, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekday - evey 12 hours /6AM/6PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=62, 
			@freq_subday_type=8, 
			@freq_subday_interval=12, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekend - every 5 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=4, 
			@freq_subday_interval=5, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END


	SET @schedule_name = 'baseline - weekend - every 10 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=4, 
			@freq_subday_interval=10, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 15 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=4, 
			@freq_subday_interval=15, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 30 mins'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=4, 
			@freq_subday_interval=30, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 1 hour'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,		 
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=8, 
			@freq_subday_interval=1, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,		 
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=8, 
			@freq_subday_interval=3, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 6 hours /6AM/12PM/6PM/12AM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=8, 
			@freq_subday_interval=6, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - every 8 hours /6AM/2PM/10PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=8, 
			@freq_subday_interval=8, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END

	SET @schedule_name = 'baseline - weekend - evey 12 hours /6AM/6PM/'
	IF @drop_schedule_if_exist = 1 AND EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
		END
	IF(@create_schedules = 1)
	BEGIN
		EXEC msdb.dbo.sp_add_schedule
			@schedule_name = @schedule_name,
			@enabled=0, 
			@freq_type=8, 
			@freq_interval=65, 
			@freq_subday_type=8, 
			@freq_subday_interval=12, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140915, 
			@active_end_date=99991231, 
			@active_start_time=60000, 
			@active_end_time=55959,
			@owner_login_name = @sa_name
	END
END
GO

DROP TABLE #TempConfiguration

/*****************************************************************************
****************************** CREATE SCHEDULES ******************************
**************************************END*************************************/