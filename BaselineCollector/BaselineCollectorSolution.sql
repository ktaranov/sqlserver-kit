/*********************************************************************************************
Written by Robert Virag

Comprehensive Baseline Collecting Solution

Change History

Changes in V2.0.4 - 2015.09.25
	<>BugFixes
		() Correcting the SetupScript to run when SQLCMD mode is enabled
		() Baseline - Output File Cleanup job's step is not empty anymore when @OutputFileDirectory is NULL
		() Minor fixes (correcting typos)
	<>Improvements
		() New option added for trying to locate the Instance Error Log Directory and configure it for @OutputFileDirectory
		() Additional instuctions added to the SetupScript

V2.0.3 - 2015.09.22
	<>BugFixes
		() SetupScript: Edition check added before Configuring schedules for jobs
		() Correction for supporting case sensitivity instances
		() [dbo].[sp_CollectFileInfo]: QUOTENAME() added to dynamic statements calling databases

V2.0.2 - 2015.09.19
	<>BugFixes
		() SetupLog: Instancename 'MSSQLSERVER' in case of Default install
		() [dbo].[sp_CollectFileInfo]: #most_recent_file_info - TSMode table was not used in TSMode

V2.0.1 - 2015.09.09
	<>BugFixes
		() SetupLog: missing 'GO' after sp_CollectInstanceInfo code
	<>Improvements
		() SetupLog: BCS Version Info, Basic Environment Info and Executer Info added

V2 - 2015.08.14
	<>Features
		() Central Configuration
			- Schema: Table [dbo].[bcs_config]
			- Collectors: @CustomConfig parameter
			- Procedures: [dbo].[sp_ConfiugreBCS]

	<>Improvements
		() Version compatibility: 2008+ 
			- 2005 is not supported anymore; DATETIME => DATETIME2)
		() [dbo].[sp_CollectFileInfo]: Redesigned - Semi-Dynamic Collector
			- Switches: 
				- @ChangedSizeThreshold 
				- @ChangedSpaceUsedThreshold /@CSUTExcludeLog/
				- @CollectionTimeThreshold
				- built-in: ChangedPhysicalLocation
		() [dbo].[sp_CollectInstanceInfo]: collects trace flag status info
		() [dbo].[sp_CollectPerfmonData]: skip 'WAITFOR DELAY @sample_interval' for the last loop
		() [dbo].[sp_CollectTempDBUsage]: skip 'WAITFOR DELAY @sample_interval' for the last loop
		() Help info: Dynamic type and default values (Default CustomConfig)!
		() New Jobs
			- Baseline - Collect InstanceInfo/ConfigData/DatabaseInfo/FileInfo/WaitStats
				- based on the collected data type /static-dynamic/
			- Baseline - Output File Cleanup
			- with recommended schedules
		() Setup logging

	<>New Schedules added
		() baseline - weekend - every 30 mins
		() baseline - weekend - every 30 mins - BT/6AM-7PM/
		() baseline - weekend - every 1 hour - BT/6AM-7PM/
		
		() baseline - every 4 weeks - 1week - every 30 mins
		() baseline - every 4 weeks - 1week - every 30 mins - BT/6AM-7PM/
		() baseline - every 4 weeks - 1week - every 1 hour
		() baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/
		() baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 4 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 4 weeks - 1week - every 8 hours /6AM/2PM/10PM/
		() baseline - every 4 weeks - 1week - evey 12 hours /6AM/6PM/
		
		() baseline - every 4 weeks - weekdays - every 30 mins
		() baseline - every 4 weeks - weekdays - every 30 mins - BT/6AM-7PM/
		() baseline - every 4 weeks - weekdays - every 1 hour
		() baseline - every 4 weeks - weekdays - every 1 hour - BT/6AM-7PM/
		() baseline - every 4 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 4 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 4 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
		() baseline - every 4 weeks - weekdays - evey 12 hours /6AM/6PM/
		
		() baseline - every 4 weeks - weekend - every 30 mins
		() baseline - every 4 weeks - weekend - every 30 mins - BT/6AM-7PM/
		() baseline - every 4 weeks - weekend - every 1 hour
		() baseline - every 4 weeks - weekend - every 1 hour - BT/6AM-7PM/
		() baseline - every 4 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 4 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 4 weeks - weekend - every 8 hours /6AM/2PM/10PM/
		() baseline - every 4 weeks - weekend - evey 12 hours /6AM/6PM/
		
		() baseline - every 12 weeks - 1week - every 30 mins
		() baseline - every 12 weeks - 1week - every 30 mins - BT/6AM-7PM/
		() baseline - every 12 weeks - 1week - every 1 hour
		() baseline - every 12 weeks - 1week - every 1 hour - BT/6AM-7PM/
		() baseline - every 12 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 12 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 12 weeks - 1week - every 8 hours /6AM/2PM/10PM/
		() baseline - every 12 weeks - 1week - evey 12 hours /6AM/6PM/
		
		() baseline - every 12 weeks - weekdays - every 30 mins
		() baseline - every 12 weeks - weekdays - every 30 mins - BT/6AM-7PM/
		() baseline - every 12 weeks - weekdays - every 1 hour
		() baseline - every 12 weeks - weekdays - every 1 hour - BT/6AM-7PM/
		() baseline - every 12 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 12 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 12 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
		() baseline - every 12 weeks - weekdays - evey 12 hours /6AM/6PM/
		
		() baseline - every 12 weeks - weekend - every 30 mins
		() baseline - every 12 weeks - weekend - every 30 mins - BT/6AM-7PM/
		() baseline - every 12 weeks - weekend - every 1 hour
		() baseline - every 12 weeks - weekend - every 1 hour - BT/6AM-7PM/
		() baseline - every 12 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 12 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 12 weeks - weekend - every 8 hours /6AM/2PM/10PM/
		() baseline - every 12 weeks - weekend - evey 12 hours /6AM/6PM/
		
		() baseline - every 24 weeks - 1week - every 30 mins
		() baseline - every 24 weeks - 1week - every 30 mins - BT/6AM-7PM/
		() baseline - every 24 weeks - 1week - every 1 hour
		() baseline - every 24 weeks - 1week - every 1 hour - BT/6AM-7PM/
		() baseline - every 24 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 24 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 24 weeks - 1week - every 8 hours /6AM/2PM/10PM/
		() baseline - every 24 weeks - 1week - evey 12 hours /6AM/6PM/
		
		() baseline - every 24 weeks - weekdays - every 30 mins
		() baseline - every 24 weeks - weekdays - every 30 mins - BT/6AM-7PM/
		() baseline - every 24 weeks - weekdays - every 1 hour
		() baseline - every 24 weeks - weekdays - every 1 hour - BT/6AM-7PM/
		() baseline - every 24 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 24 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 24 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
		() baseline - every 24 weeks - weekdays - evey 12 hours /6AM/6PM/
		
		() baseline - every 24 weeks - weekend - every 30 mins
		() baseline - every 24 weeks - weekend - every 30 mins - BT/6AM-7PM/
		() baseline - every 24 weeks - weekend - every 1 hour
		() baseline - every 24 weeks - weekend - every 1 hour - BT/6AM-7PM/
		() baseline - every 24 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
		() baseline - every 24 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
		() baseline - every 24 weeks - weekend - every 8 hours /6AM/2PM/10PM/
		() baseline - every 24 weeks - weekend - evey 12 hours /6AM/6PM/

V1.2 - 2015.05
	- Bug Fixes

V1.1 - 2015.04
	- Bug Fixes
	- New Collector: sp_CollectInstanceInfo
	- Additional Schedules*

V1 Original Release - 2014.09.13 

-----------------------------------

*  - Added in V1.1
** - Added in V2

Tables:
	* [dbo].[instance_info]
	 [dbo].[configuration_data]
	 [dbo].[database_info]
	 [dbo].[file_info]
	 [dbo].[iovf_stats]
	 [dbo].[perfmon_data]
	 [dbo].[tempdb_usage]
	 [dbo].[wait_stats]

	 [dbo].[ts_file_info]
	 [dbo].[ts_iovf_stats]
	 [dbo].[ts_perfmon_data]
	 [dbo].[ts_tempdb_usage]
	 [dbo].[ts_wait_stats]

	 [dbo].[filter_database_file]
	 [dbo].[filter_performance_counters]
	 [dbo].[filter_wait_types]

	** [dbo].[bcs_config]

Collectors:
	* sp_CollectInstanceInfo
	 sp_CollectConfigData 
	 sp_CollectDatabaseInfo 
	 sp_CollectFileInfo 
	 sp_CollectIOVFStats 
	 sp_CollectPerfmonData 
	 sp_CollectTempDBUsage 
	 sp_CollectWaitStats
	

Functions/Procedures:
	** sp_ConfigureBCS

Jobs:
	** Baseline - Collect InstanceInfo/ConfigData/DatabaseInfo/FileInfo/WaitStats
		+ SCHEDULE[baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/]
		+ STEPS:
			- Collect InstanceInfo
			- Collect ConfigData
			- Collect DatabaseInfo
			- Collect FileInfo
			- Collect WaitStats with @ResetWaitStats=1
			- JobCheck
	 Baseline - CollectIOVFStats
		+ SCHEDULE[baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/]
	 Baseline - CollectPerfmonData 
		+ SCHEDULE[baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/]
	 Baseline - CollectTempDBUsage
		+ SCHEDULE[baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/]
	 ** Baseline - Output File Cleanup
		+ SCHEDULE[baseline - daily - at 2351PM]

Schedules:
	   baseline - daily - at 2359PM
	   baseline - daily - at 2355PM
	 * baseline - daily - at 2351PM


	 * baseline - daily - every 30 mins
	 * baseline - daily - every 30 mins - BT/6AM-7PM/
	   baseline - daily - every 1 hour
	   baseline - daily - every 1 hour - BT/6AM-7PM/
	 * baseline - daily - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	   baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/
	   baseline - daily - every 8 hours /6AM/2PM/10PM/
	   baseline - daily - evey 12 hours /6AM/6PM/

	 * baseline - weekday - every 30 mins
	 * baseline - weekday - every 30 mins - BT/6AM-7PM/
	   baseline - weekday - every 1 hour
	   baseline - weekday - every 1 hour - BT/6AM-7PM/
	 * baseline - weekday - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	   baseline - weekday - every 6 hours /6AM/12PM/6PM/12AM/
	   baseline - weekday - every 8 hours /6AM/2PM/10PM/
	   baseline - weekday - evey 12 hours /6AM/6PM/

	** baseline - weekend - every 30 mins
	** baseline - weekend - every 30 mins - BT/6AM-7PM/
	   baseline - weekend - every 1 hour
	** baseline - weekend - every 1 hour - BT/6AM-7PM/
	   baseline - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	   baseline - weekend - every 6 hours /6AM/12PM/6PM/12AM/
	   baseline - weekend - every 8 hours /6AM/2PM/10PM/
	   baseline - weekend - evey 12 hours /6AM/6PM/
	
	** baseline - every 4 weeks - 1week - every 30 mins
	** baseline - every 4 weeks - 1week - every 30 mins - BT/6AM-7PM/
	** baseline - every 4 weeks - 1week - every 1 hour
	** baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/
	** baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 4 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 4 weeks - 1week - every 8 hours /6AM/2PM/10PM/
	** baseline - every 4 weeks - 1week - evey 12 hours /6AM/6PM/

	** baseline - every 4 weeks - weekdays - every 30 mins
	** baseline - every 4 weeks - weekdays - every 30 mins - BT/6AM-7PM/
	** baseline - every 4 weeks - weekdays - every 1 hour
	** baseline - every 4 weeks - weekdays - every 1 hour - BT/6AM-7PM/
	** baseline - every 4 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 4 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 4 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
	** baseline - every 4 weeks - weekdays - evey 12 hours /6AM/6PM/

	** baseline - every 4 weeks - weekend - every 30 mins
	** baseline - every 4 weeks - weekend - every 30 mins - BT/6AM-7PM/
	** baseline - every 4 weeks - weekend - every 1 hour
	** baseline - every 4 weeks - weekend - every 1 hour - BT/6AM-7PM/
	** baseline - every 4 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 4 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 4 weeks - weekend - every 8 hours /6AM/2PM/10PM/
	** baseline - every 4 weeks - weekend - evey 12 hours /6AM/6PM/

	** baseline - every 12 weeks - 1week - every 30 mins
	** baseline - every 12 weeks - 1week - every 30 mins - BT/6AM-7PM/
	** baseline - every 12 weeks - 1week - every 1 hour
	** baseline - every 12 weeks - 1week - every 1 hour - BT/6AM-7PM/
	** baseline - every 12 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 12 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 12 weeks - 1week - every 8 hours /6AM/2PM/10PM/
	** baseline - every 12 weeks - 1week - evey 12 hours /6AM/6PM/

	** baseline - every 12 weeks - weekdays - every 30 mins
	** baseline - every 12 weeks - weekdays - every 30 mins - BT/6AM-7PM/
	** baseline - every 12 weeks - weekdays - every 1 hour
	** baseline - every 12 weeks - weekdays - every 1 hour - BT/6AM-7PM/
	** baseline - every 12 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 12 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 12 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
	** baseline - every 12 weeks - weekdays - evey 12 hours /6AM/6PM/

	** baseline - every 12 weeks - weekend - every 30 mins
	** baseline - every 12 weeks - weekend - every 30 mins - BT/6AM-7PM/
	** baseline - every 12 weeks - weekend - every 1 hour
	** baseline - every 12 weeks - weekend - every 1 hour - BT/6AM-7PM/
	** baseline - every 12 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 12 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 12 weeks - weekend - every 8 hours /6AM/2PM/10PM/
	** baseline - every 12 weeks - weekend - evey 12 hours /6AM/6PM/

	** baseline - every 24 weeks - 1week - every 30 mins
	** baseline - every 24 weeks - 1week - every 30 mins - BT/6AM-7PM/
	** baseline - every 24 weeks - 1week - every 1 hour
	** baseline - every 24 weeks - 1week - every 1 hour - BT/6AM-7PM/
	** baseline - every 24 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 24 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 24 weeks - 1week - every 8 hours /6AM/2PM/10PM/
	** baseline - every 24 weeks - 1week - evey 12 hours /6AM/6PM/

	** baseline - every 24 weeks - weekdays - every 30 mins
	** baseline - every 24 weeks - weekdays - every 30 mins - BT/6AM-7PM/
	** baseline - every 24 weeks - weekdays - every 1 hour
	** baseline - every 24 weeks - weekdays - every 1 hour - BT/6AM-7PM/
	** baseline - every 24 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 24 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 24 weeks - weekdays - every 8 hours /6AM/2PM/10PM/
	** baseline - every 24 weeks - weekdays - evey 12 hours /6AM/6PM/

	** baseline - every 24 weeks - weekend - every 30 mins
	** baseline - every 24 weeks - weekend - every 30 mins - BT/6AM-7PM/
	** baseline - every 24 weeks - weekend - every 1 hour
	** baseline - every 24 weeks - weekend - every 1 hour - BT/6AM-7PM/
	** baseline - every 24 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/
	** baseline - every 24 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/
	** baseline - every 24 weeks - weekend - every 8 hours /6AM/2PM/10PM/
	** baseline - every 24 weeks - weekend - evey 12 hours /6AM/6PM/

Tested: 2008 / 2008 R2 / 2012 / 2014

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
/*
Please find the following lines in the script below and modify/configure them as you need:
USE [BaselineDB]	---------------------------------------------------- modify
SET @CreateJobs = 1	---------------------------------------------------- modify
SET @CreateSchedules = 1 ----------------------------------------------- modify
SET @LocateSQLErrorLogDirectoryFromRegistry = 1 --------------------------------- modify
SET @OutputFileDirectory = NULL -- N'...\BaselineLogs\...'	------------ modify
SET @DropJobsIfExist = 1 ----------------------------------------------- modify
SET @DropScheduleIfExist = 1 ------------------------------------------- modify
SET @DropTableIfExist = 1	-------------------------------------------- modify
SET @DataCompression = 1	-------------------------------------------- modify
*/

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Implementation of Baseline Collector Solution is started... /' + CONVERT(nvarchar(24), SYSDATETIME(), 113) + '/'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Please report every error you get (copy the SetupLog into the message): http://www.sqlapprentice.net/contact/'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Baseline Collector Solution Version: 2.0.4'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' MachineName: ' + CAST(SERVERPROPERTY('MachineName') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' InstanceName: ' + CAST(ISNULL(SERVERPROPERTY('InstanceName'), N'MSSQLSERVER') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ServerName: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ProductVersion: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Current Database: ' + QUOTENAME(DB_NAME())
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Instance Collation: ' + CAST(ISNULL(SERVERPROPERTY('Collation'), N'UNKNOWN') AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Login name: ' + SYSTEM_USER
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' User name: ' + CURRENT_USER

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
/*----------------------------------------------------------------------------\
--     THERE ARE STILL SOME SETTINGS TO BE CONFIGURED! PLEASE SCROLL DOWN!   --
--									_____									 --
--								   |*****|									 --
--								   |*****|									 --
--								   |*****|									 --
--								 __|*****|__								 --
--								|***********|								 --
--								 \*********/								 --
--								  \*******/									 --
--								   \*****/									 --
--								    \***/									 --
--									 \*/									 --
--									  *										 --
--																			 --
-----------------------------------------------------------------------------*/

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
DECLARE @OutputFileDirectory NVARCHAR(max)
DECLARE @LocateSQLErrorLogDirectoryFromRegistry BIT
DECLARE @SQLErrorLogDirectory NVARCHAR(4000)

DECLARE @SQLCommand NVARCHAR(max)
DECLARE @TableName NVARCHAR(255)
DECLARE @DataCompression BIT
DECLARE @DropTableIfExist BIT
DECLARE @DropJobsIfExist TINYINT
DECLARE @DropScheduleIfExist TINYINT

SET @DropTableIfExist = 1	-------------------------------------------- modify
SET @DataCompression = 1	-------------------------------------------- modify

SET @CreateJobs = 1	---------------------------------------------------- modify
SET @DropJobsIfExist = 1 ----------------------------------------------- modify

/* Schedules will be DISABLED and will not be mapped to jobs!!! */
SET @CreateSchedules = 1 ----------------------------------------------- modify
SET @DropScheduleIfExist = 1 ------------------------------------------- modify

/* 
	Leave @OutputFileDirectoy = NULL and set @LocateSQLErrorLogDirectoryFromRegistry = 1
	if you would like to try to locate the SQL Server Error Log directory from 
	Registry and use is as OutputFileDirectory. 
	The setting is ignored in SQL Server 2014 and above.
	Please be noticed that xp_instance_regread will be used! You need to take care
	of the necessary permissions!
*/

SET @LocateSQLErrorLogDirectoryFromRegistry = 1 ------------------------ modify
/* 
	Specify the output file directory. The directory MUST exists! 
	SQL Server 2014: If no directory is specified, then the SQL Server error log directory is used.
	SQL Server 2012/2008R2/2008: If no directory is specified, there will be no output files 
	configured for the steps in the jobs!!!
	One log file per day per job will be generated. 
*/
SET @OutputFileDirectory = NULL	-- N'...\BaselineLogs\...'-------------- modify

/*----------------------------------------------------------------------------\
!      THERE IS NO MORE SETTINGS TO BE CONFIGURED! YOU CAN RUN THE SCRIPT!    !
\----------------------------------------------------------------------------*/
-- DDDDDDDDDDDD            OOOOOOOO    NNNNNNN        NNNNNNNEEEEEEEEEEEEEEEEEEE
-- D:::::::::::DDD        O::::::::O   N::::::N       N:::::NE:::::::::::::::::E
-- D::::::::::::::DD    OO::::::::::OO N:::::::N      N:::::NE:::::::::::::::::E
-- DDD::::DDDDD:::::D  O::::::OO::::::ON::::::::N     N:::::NEE:::::EEEEEEEE:::E
--   D::::D    D:::::D O:::::O  O:::::ON:::::::::N    N:::::N  E::::E      EEEEE
--   D::::D     D:::::DO::::O    O::::ON::::::::::N   N:::::N  E::::E             
--   D::::D     D:::::DO::::O    O::::ON::::::N::::N  N:::::N  E:::::EEEEEEEE   
--   D::::D     D:::::DO::::O    O::::ON:::::N N::::N N:::::N  E::::::::::::E   
--   D::::D     D:::::DO::::O    O::::ON:::::N  N::::N::::::N  E::::::::::::E   
--   D::::D     D:::::DO::::O    O::::ON:::::N   N::::::::::N  E:::::EEEEEEEE   
--   D::::D     D:::::DO::::O    O::::ON:::::N    N:::::::::N  E::::E             
--   D::::D    D:::::D O:::::O  O:::::ON:::::N     N::::::::N  E::::E      EEEEE
-- DDD::::DDDDD:::::D  O::::::OO::::::ON:::::N      N:::::::NEE:::::EEEEEEE::::E
-- D::::::::::::::DD    OO::::::::::OO N:::::N       N::::::NE:::::::::::::::::E
-- D:::::::::::DDD        O::::::::O   N:::::N        N:::::NE:::::::::::::::::E
-- DDDDDDDDDDDD            OOOOOOOO    NNNNNNN         NNNNNNEEEEEEEEEEEEEEEEEEE


DECLARE @Version numeric(18,10)
SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

IF @LocateSQLErrorLogDirectoryFromRegistry = 1
BEGIN
	IF @CreateJobs = 1 AND @OutputFileDirectory IS NULL AND @Version < 12 
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Trying to locate the Instance Error Log Directory from registry...'
		EXEC xp_instance_regread 
		N'HKEY_LOCAL_MACHINE', 
		N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer\Parameters', 
		N'SQLArg1',
		@SQLErrorLogDirectory output
		IF LEFT(@SQLErrorLogDirectory, 2) = N'-e'
		BEGIN
			SET @OutputFileDirectory = LEFT(RIGHT(@SQLErrorLogDirectory, LEN(@SQLErrorLogDirectory)-2),LEN(@SQLErrorLogDirectory)-2-CHARINDEX('\',REVERSE(RIGHT(@SQLErrorLogDirectory, LEN(@SQLErrorLogDirectory)-2))))
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Locating the Instance Error Log Directory...SUCCEED'
		END
		ELSE
		BEGIN
			SET @OutputFileDirectory = NULL
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Locating the Instance Error Log Directory...FAILED'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Locating the Instance Error Log Directory from registry ('+ CASE WHEN @CreateJobs = 0 THEN '1' ELSE '0' END +'|'+ CASE WHEN @Version >= 12 THEN '1' ELSE '0' END +'|'+ CASE WHEN @OutputFileDirectory IS NULL THEN '0' ELSE '1' END +')...SKIPPED'
	END
END

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

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Target Baseline Database: ' + QUOTENAME(DB_NAME())
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Configuration of the implementation script:'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @CreateJobs: ' + CAST(@CreateJobs AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @CreateSchedules: ' + CAST(@CreateSchedules AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @LocateSQLErrorLogDirectoryFromRegistry: ' + CAST(@LocateSQLErrorLogDirectoryFromRegistry AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @OutputFileDirectory: ' + ISNULL(@OutputFileDirectory, 'NULL')
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @DropJobsIfExist: ' + CAST(@DropJobsIfExist AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @DropScheduleIfExist: ' + CAST(@DropScheduleIfExist AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @DropTableIfExist: ' + CAST(@DropTableIfExist AS nvarchar)
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Parameter @DataCompression: ' + CAST(@DataCompression AS nvarchar)

/************************************START*************************************
******************************** CREATE SCHEMA ********************************
******************************************************************************/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' START: CREATE SCHEMA'

/*--------------------------------------------
-- Create Table for BCS Configurations
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[bcs_config]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[bcs_config]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[bcs_config] is deleted.'
END

IF OBJECT_ID('[dbo].[bcs_config]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[bcs_config]...'
	SET @SQLCommand = N'CREATE TABLE [dbo].[bcs_config]
		(
			[config_name] NVARCHAR(35) NOT NULL,
			[config_type] TINYINT DEFAULT 0 NOT NULL,
			[retention] SMALLINT,
			[loginfo] BIT,
			[dest_table] NVARCHAR(128),
			[dest_schema] NVARCHAR(25),
			[ts_mode] BIT,
			[empty_ts_table] BIT,
			[collecting_interval] SMALLINT,
			[sample_interval] SMALLINT,
			[measuring_interval] TINYINT,
			[reset_wait_stats] BIT,
			[bypass_nonactive_srv_conf_error] BIT,
			[collection_time_threshold] SMALLINT,
			[changed_size_threshold] INT,
			[changed_space_used_threshold] INT,
			[csut_exclude_log] BIT,
			[config_description] NVARCHAR(max),
			CONSTRAINT chk_config_type_columns CHECK(
			(config_type = 1 
			AND dest_table IS NULL 
			AND dest_schema IS NULL
			AND ts_mode IS NULL
			AND empty_ts_table IS NULL
			AND collecting_interval IS NULL 
			AND sample_interval IS NULL
			AND measuring_interval IS NULL 
			AND reset_wait_stats IS NULL 
			AND bypass_nonactive_srv_conf_error IS NULL 
			AND collection_time_threshold IS NULL
			AND changed_size_threshold IS NULL
			AND changed_space_used_threshold IS NULL
			AND csut_exclude_log IS NULL
			)
			OR (config_type = 2
			AND dest_table IS NULL 
			AND dest_schema IS NULL
			AND ts_mode IS NULL
			AND empty_ts_table IS NULL
			AND collecting_interval IS NULL
			AND sample_interval IS NULL
			AND measuring_interval IS NULL
			AND reset_wait_stats IS NULL
			AND collection_time_threshold IS NULL
			AND changed_size_threshold IS NULL
			AND changed_space_used_threshold IS NULL
			AND csut_exclude_log IS NULL
			)
			OR (config_type = 3
			AND collecting_interval IS NULL
			AND sample_interval IS NULL
			AND measuring_interval IS NULL
			AND reset_wait_stats IS NULL
			AND bypass_nonactive_srv_conf_error IS NULL
			)
			OR (config_type = 4
			AND measuring_interval IS NULL
			AND reset_wait_stats IS NULL
			AND bypass_nonactive_srv_conf_error IS NULL
			AND collection_time_threshold IS NULL
			AND changed_size_threshold IS NULL
			AND changed_space_used_threshold IS NULL
			AND csut_exclude_log IS NULL
			)
			OR (config_type = 5
			AND reset_wait_stats IS NULL
			AND bypass_nonactive_srv_conf_error IS NULL
			AND collection_time_threshold IS NULL
			AND changed_size_threshold IS NULL
			AND changed_space_used_threshold IS NULL
			AND csut_exclude_log IS NULL
			)
			OR (config_type = 6
			AND collecting_interval IS NULL
			AND sample_interval IS NULL
			AND bypass_nonactive_srv_conf_error IS NULL
			AND collection_time_threshold IS NULL
			AND changed_size_threshold IS NULL
			AND changed_space_used_threshold IS NULL
			AND csut_exclude_log IS NULL
			)
			OR (config_type = 0)
			)
		) '

	IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
	BEGIN
		SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
	END

	EXEC sp_executesql @SQLCommand

	CREATE UNIQUE CLUSTERED INDEX [CI_bcs_config] ON [dbo].[bcs_config] ([config_name])

	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectInstanceInfo', 
								/*[config_type]*/1, 
								/*[retention]*/NULL, 
								/*[loginfo]*/1, 
								/*[config_description]*/'Default config for sp_collectinstanceinfo') --1
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectDatabaseInfo', 
								/*[config_type]*/1, 
								/*[retention]*/NULL, 
								/*[loginfo]*/1, 
								/*[config_description]*/'Default config for sp_collectdatabaseinfo') --1
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [bypass_nonactive_srv_conf_error], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectConfigData', 
								/*[config_type]*/2, 
								/*[retention]*/NULL, 
								/*[loginfo]*/1, 
								/*[bypass_nonactive_srv_conf_error]*/0, 
								/*[config_description]*/'Default config for sp_collectconfigdata') --2
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collection_time_threshold], [changed_size_threshold], [changed_space_used_threshold], [csut_exclude_log], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectFileInfo', 
								/*[config_type]*/3, 
								/*[retention]*/null, 
								/*[loginfo]*/1, 
								/*[dest_table]*/NULL, 
								/*[dest_schema]*/NULL, 
								/*[ts_mode]*/0, 
								/*[empty_ts_table]*/0, 
								/*[collection_time_threshold]*/71, 
								/*[changed_size_threshold]*/10, 
								/*[changed_space_used_threshold]*/10, 
								/*[csut_exclude_log]*/1, 
								/*[config_description]*/'Default config for sp_collectfileinfo') --3
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collecting_interval], [sample_interval], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectTempDBUsage', 
								/*[config_type]*/4, 
								/*[retention]*/365, 
								/*[loginfo]*/1, 
								/*[dest_table]*/NULL, 
								/*[dest_schema]*/NULL, 
								/*[ts_mode]*/0, 
								/*[empty_ts_table]*/0, 
								/*[collecting_interval]*/null, 
								/*[sample_interval]*/300, 
								/*[config_description]*/'Default config for sp_collecttempdbusage') --4
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collecting_interval], [sample_interval], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectIOVFStats', 
								/*[config_type]*/4, 
								/*[retention]*/1095, 
								/*[loginfo]*/1, 
								/*[dest_table]*/NULL, 
								/*[dest_schema]*/NULL, 
								/*[ts_mode]*/0, 
								/*[empty_ts_table]*/0, 
								/*[collecting_interval]*/null, 
								/*[sample_interval]*/1798, 
								/*[config_description]*/'Default config for sp_collectiovfstats') --4
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collecting_interval], [sample_interval], [measuring_interval], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectPerfmonData', 
								/*[config_type]*/5, 
								/*[retention]*/365, 
								/*[loginfo]*/1, 
								/*[dest_table]*/NULL, 
								/*[dest_schema]*/NULL, 
								/*[ts_mode]*/0, 
								/*[empty_ts_table]*/0, 
								/*[collecting_interval]*/null, 
								/*[sample_interval]*/300, 
								/*[measuring_interval]*/5, 
								/*[config_description]*/'Default config for sp_collectperfmondata') --5
	INSERT INTO [dbo].[bcs_config] ([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [measuring_interval], [reset_wait_stats], [config_description]) 
							VALUES (/*[config_name]*/'sp_CollectWaitStats', 
								/*[config_type]*/6, 
								/*[retention]*/365, 
								/*[loginfo]*/1, 
								/*[dest_table]*/NULL, 
								/*[dest_schema]*/NULL, 
								/*[ts_mode]*/0, 
								/*[empty_ts_table]*/0, 
								/*[measuring_interval]*/NULL, 
								/*[reset_wait_stats]*/0, 
								/*[config_description]*/'Default config for sp_collectwaitstats') --6

	SET @SQLCommand = N'CREATE TRIGGER control_update_bcs_config ON [dbo].[bcs_config]
	--INSTEAD OF UPDATE AS
	FOR UPDATE AS
	BEGIN
		IF (UPDATE(config_name) OR UPDATE(config_type)) AND (SELECT config_name FROM DELETED) IN (''sp_CollectInstanceInfo'',''sp_CollectConfigData'',''sp_CollectDatabaseInfo'',''sp_CollectFileInfo'',''sp_CollectIOVFStats'',''sp_CollectPerfmonData'',''sp_CollectTempDBUsage'',''sp_CollectWaitStats'')
		BEGIN
			ROLLBACK TRAN
			RAISERROR(''Cannot modify config name or type which were predefined for the collectors'', 16, -1)
		END
		IF (SELECT config_type FROM INSERTED)  = 1
		BEGIN
			IF UPDATE(dest_table) OR UPDATE(dest_schema) OR UPDATE(ts_mode) OR UPDATE(empty_ts_table) OR UPDATE(collecting_interval) OR UPDATE(sample_interval) OR UPDATE(measuring_interval) OR UPDATE(reset_wait_stats) OR UPDATE(bypass_nonactive_srv_conf_error) OR UPDATE(collection_time_threshold) OR UPDATE(changed_size_threshold) OR UPDATE(changed_space_used_threshold) OR UPDATE(csut_exclude_log)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (1)'', 16, -1)
			END
		END
		IF (SELECT config_type FROM INSERTED)  = 2
		BEGIN
			IF UPDATE(dest_table) OR UPDATE(dest_schema) OR UPDATE(ts_mode) OR UPDATE(empty_ts_table) OR UPDATE(collecting_interval) OR UPDATE(sample_interval) OR UPDATE(measuring_interval) OR UPDATE(reset_wait_stats) OR UPDATE(collection_time_threshold) OR UPDATE(changed_size_threshold) OR UPDATE(changed_space_used_threshold) OR UPDATE(csut_exclude_log)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (2)'', 16, -1)
			END
		END
	
		IF (SELECT config_type FROM INSERTED)  = 3
		BEGIN
			IF UPDATE(collecting_interval) OR UPDATE(sample_interval) OR UPDATE(measuring_interval) OR UPDATE(reset_wait_stats) OR UPDATE(bypass_nonactive_srv_conf_error)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (3)'', 16, -1)
			END
		END
		IF (SELECT config_type FROM INSERTED)  = 4
		BEGIN
			IF UPDATE(measuring_interval) OR UPDATE(reset_wait_stats) OR UPDATE(bypass_nonactive_srv_conf_error) OR UPDATE(collection_time_threshold) OR UPDATE(changed_size_threshold) OR UPDATE(changed_space_used_threshold) OR UPDATE(csut_exclude_log)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (4)'', 16, -1)
			END
		END
		IF (SELECT config_type FROM INSERTED)  = 5
		BEGIN
			IF UPDATE(reset_wait_stats) OR UPDATE(bypass_nonactive_srv_conf_error) OR UPDATE(collection_time_threshold) OR UPDATE(changed_size_threshold) OR UPDATE(changed_space_used_threshold) OR UPDATE(csut_exclude_log)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (5)'', 16, -1)
			END
		END
		IF (SELECT config_type FROM INSERTED)  = 6
		BEGIN
			IF UPDATE(collecting_interval) OR UPDATE(sample_interval) OR UPDATE(bypass_nonactive_srv_conf_error) OR UPDATE(collection_time_threshold) OR UPDATE(changed_size_threshold) OR UPDATE(changed_space_used_threshold) OR UPDATE(csut_exclude_log)
			BEGIN
				ROLLBACK TRAN
				RAISERROR(''Cannot update column, parameter is not supported for that collector (6)'', 16, -1)
			END
		END
	END'

	EXEC sp_executesql @SQLCommand

	SET @SQLCommand = N'CREATE TRIGGER control_delete_bcs_config ON [dbo].[bcs_config]
	--INSTEAD OF UPDATE AS
	FOR DELETE AS
	BEGIN
		IF EXISTS (SELECT config_name FROM DELETED WHERE config_name IN (''sp_CollectInstanceInfo'',''sp_CollectConfigData'',''sp_CollectDatabaseInfo'',''sp_CollectFileInfo'',''sp_CollectIOVFStats'',''sp_CollectPerfmonData'',''sp_CollectTempDBUsage'',''sp_CollectWaitStats''))
		BEGIN
			ROLLBACK TRAN
			RAISERROR(''Cannot delete rows which were predefined for the collectors'', 16, -1)
		END
	END'

	EXEC sp_executesql @SQLCommand
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[bcs_config]...DONE'

END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[bcs_config] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for Instance Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[instance_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[instance_info]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[instance_info] is deleted.'
END
SET @SQLCommand = N'CREATE TABLE [dbo].[instance_info]
	(
		[capture_date] DATETIME2(2) NOT NULL,
		[name] NVARCHAR(50) NOT NULL,
		[value] SQL_VARIANT NULL,
		[is_initial] BIT NOT NULL, 
		[is_pre] BIT NOT NULL 
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END


IF OBJECT_ID('[dbo].[instance_info]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[instance_info]...'
	
	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_instance_info] ON [dbo].[instance_info] ([capture_date],[name])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[instance_info]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[instance_info] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for Server Configuration 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[configuration_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[configuration_data]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[configuration_data] is deleted.'

END
SET @SQLCommand = N'CREATE TABLE [dbo].[configuration_data]
	(
		[capture_date] DATETIME2(2) NOT NULL,
		[configuration_id] INT NOT NULL,
		[value] SQL_VARIANT,
		[value_in_use] SQL_VARIANT,
		[is_initial] BIT NOT NULL, 
		[is_pre] BIT NOT NULL 
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END


IF OBJECT_ID('[dbo].[configuration_data]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[configuration_data]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_configuration_data] ON [dbo].[configuration_data] ([capture_date],[configuration_id])
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[configuration_data]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[configuration_data] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for Database Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[database_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[database_info]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[database_info] is deleted.'

END
SET @SQLCommand = N'CREATE TABLE [dbo].[database_info]
	(
		[capture_date] DATETIME2(2) NOT NULL,
		[database_name] SYSNAME NOT NULL,
		[database_id] INT NOT NULL,
		[source_database_id] INT,
		[owner_sid] VARBINARY(85),
		[create_date] DATETIME,
		[compatibility_level] TINYINT,
		[collation_name] NVARCHAR(128),
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
		[is_date_correlation_on] BIT,
		/*2008*/
		[is_cdc_enabled] BIT, 
		[is_encrypted] BIT, 
		[is_honor_broker_priority_on] BIT,
		/*2012*/
		[replica_id] UNIQUEIDENTIFIER NULL,
		[group_database_id] UNIQUEIDENTIFIER,
		[default_language_lcid] SMALLINT, 
		[default_fulltext_language_lcid] INT, 
		[is_nested_triggers_on] BIT, 
		[is_transform_noise_words_on] BIT,
		[two_digit_year_cutoff] SMALLINT, 
		[containment] TINYINT NULL,  
		[target_recovery_time_in_seconds] INT,
		/*2014*/
		[is_auto_create_stats_incremental_on] BIT, 
		[is_query_store_on] BIT, 
		[resource_pool_id] INT, 
		[delayed_durability] INT,
		[is_memory_optimized_elevate_to_snapshot_on] BIT,
		[is_initial] BIT NOT NULL, 
		[is_pre] BIT NOT NULL
		) '


IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'	
END

IF OBJECT_ID('[dbo].[database_info]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[database_info]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_database_info] ON [dbo].[database_info] ([capture_date], [database_name])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[database_info]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[database_info] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for File Info 
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[file_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[file_info]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[file_info] is deleted.'


END

IF(OBJECT_ID('[dbo].[ts_file_info]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_file_info]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_file_info] is deleted.'


END

SET @SQLCommand = N'CREATE TABLE [dbo].[file_info]
	(
		[capture_date] DATETIME2(2) NOT NULL,
		[database_name] SYSNAME,
		[logical_name] SYSNAME,
		[physical_name] NVARCHAR(260) NOT NULL,
		[type] TINYINT,
		[size_pages] INT,
		[space_used_pages] INT,
		[max_size_pages] INT,
		[growth_pages_percent] INT,
		[is_percent_growth] BIT,
		[ic_cst] BIT,
		[ic_csut] BIT,
		[ic_ctt] BIT,
		[ic_path] BIT
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'	
END

IF OBJECT_ID('[dbo].[file_info]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[file_info]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_file_info] ON [dbo].[file_info] ([capture_date],[physical_name])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[file_info]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[file_info] is skipped...DONE'
END

SET @SQLCommand = REPLACE(@SQLCommand, N'[file_info]', N'[ts_file_info]')

IF OBJECT_ID('[dbo].[ts_file_info]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[ts_file_info]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_ts_file_info] ON [dbo].[ts_file_info] ([capture_date],[physical_name])
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[ts_file_info]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_file_info] is skipped...DONE'
END


/*--------------------------------------------
-- Create Table for IO Virtual File Stats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[iovf_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[iovf_stats]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[iovf_stats] is deleted.'
END

IF(OBJECT_ID('[dbo].[ts_iovf_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_iovf_stats]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_iovf_stats] is deleted.'
END

SET @SQLCommand = N'CREATE TABLE [dbo].[iovf_stats]
	(
		[capture_date] DATETIME2(7) NOT NULL,
		[database_name] SYSNAME NOT NULL,
		[type] TINYINT,
		[physical_name] NVARCHAR(260) NOT NULL,
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

IF OBJECT_ID('[dbo].[iovf_stats]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[iovf_stats]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_iovf_stats] ON [dbo].[iovf_stats] ([capture_date],[physical_name])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[iovf_stats]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[iovf_stats] is skipped...DONE'
END

SET @SQLCommand = REPLACE(@SQLCommand, N'[iovf_stats]', N'[ts_iovf_stats]')

IF OBJECT_ID('[dbo].[ts_iovf_stats]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[ts_iovf_stats]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_ts_iovf_stats] ON [dbo].[ts_iovf_stats] ([capture_date],[physical_name])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[ts_iovf_stats]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_iovf_stats] is skipped...DONE'
END
/*-------------------------------------------------------
-- Table for Filtering Database's Files
-------------------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_database_file]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_database_file]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_database_file] is deleted.'

END

IF OBJECT_ID('[dbo].[filter_database_file]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[filter_database_file]...'

	CREATE TABLE [dbo].[filter_database_file]
	(
		[id] INT IDENTITY(1,1),
		[database_name] SYSNAME NOT NULL,
		[logical_file_name] SYSNAME NOT NULL,
		[is_excluded_file_info] BIT CONSTRAINT DF_fdf_is_excluded_file_info DEFAULT(0), 
		[ts_is_included_file_info] BIT CONSTRAINT DF_fdf_ts_is_included_file_info DEFAULT(0),
		[is_excluded_iovf] BIT CONSTRAINT DF_fdf_is_excluded_iovf DEFAULT(0),
		[ts_is_included_iovf] BIT CONSTRAINT DF_fdf_ts_is_included_iovf DEFAULT(0)
	)


	/*--------------------------------------------
	-- Insert all databases
	--------------------------------------------*/
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Loading database filtering data into filter table [dbo].[filter_wait_types]...'
	INSERT INTO [dbo].[filter_database_file]
	( [database_name], [logical_file_name] /*, [is_excluded_file_info], [ts_is_included_file_info], [is_excluded_iovf], [ts_is_included_iovf] */ )
	SELECT DB_NAME(database_id), name /*, 0, 0, 0, 0*/ FROM sys.master_files
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[filter_database_file]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_database_file] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for TempDB Usage
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[tempdb_usage]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[tempdb_usage]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[tempdb_usage] is deleted.'
END

IF(OBJECT_ID('[dbo].[ts_tempdb_usage]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_tempdb_usage]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_tempdb_usage] is deleted.'
END

SET @SQLCommand = N'CREATE TABLE [dbo].[tempdb_usage]
	( 
		[capture_date] DATETIME2(7) NOT NULL,
		[file_id] SMALLINT NOT NULL,
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

IF OBJECT_ID('[dbo].[tempdb_usage]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[tempdb_usage]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_tempdb_usage] ON [dbo].[tempdb_usage] ([capture_date],[file_id])
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[tempdb_usage]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[tempdb_usage] is skipped...DONE'
END

SET @SQLCommand = REPLACE(@SQLCommand, N'[tempdb_usage]', N'[ts_tempdb_usage]')

IF OBJECT_ID('[dbo].[ts_tempdb_usage]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[ts_tempdb_usage]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_ts_tempdb_usage] ON [dbo].[ts_tempdb_usage] ([capture_date],[file_id])
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[ts_tempdb_usage]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_tempdb_usage] is skipped...DONE'
END		
/*--------------------------------------------
-- Create Table for PerfMon Data
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[perfmon_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[perfmon_data]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[perfmon_data] is deleted.'
END

IF(OBJECT_ID('[dbo].[ts_perfmon_data]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_perfmon_data]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_perfmon_data] is deleted.'
END

SET @SQLCommand = N'CREATE TABLE [dbo].[perfmon_data]
	(
		[capture_date] DATETIME2(7) NOT NULL,
		[counter] NVARCHAR(255),
		[value] DECIMAL(32,2)
	) '

IF(@@VERSION NOT LIKE N'%Microsoft SQL Server 2000%' AND @@VERSION NOT LIKE N'%Microsoft SQL Server 2005%' AND @DataCompression = 1 AND (CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Enterprise%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Developer%' OR CAST(SERVERPROPERTY(N'edition') AS NVARCHAR(100)) LIKE N'%Data Center%'))
BEGIN
	SET @SQLCommand = @SQLCommand + N' WITH (DATA_COMPRESSION = PAGE)'
END

IF OBJECT_ID('[dbo].[perfmon_data]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[perfmon_data]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_perfmon_data] ON [dbo].[perfmon_data] ([capture_date],[counter])
	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[perfmon_data]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[perfmon_data] is skipped...DONE'
END

SET @SQLCommand = REPLACE(@SQLCommand, N'[perfmon_data]', N'[ts_perfmon_data]')

IF OBJECT_ID('[dbo].[ts_perfmon_data]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[ts_perfmon_data]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_ts_perfmon_data] ON [dbo].[ts_perfmon_data] ([capture_date],[counter])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[ts_perfmon_data]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_perfmon_data] is skipped...DONE'
END
/*--------------------------------------------
-- Create Table for Wait Stats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[wait_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[wait_stats]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[wait_stats] is deleted.'
END

IF(OBJECT_ID('[dbo].[ts_wait_stats]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[ts_wait_stats]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_wait_stats] is deleted.'
END

SET @SQLCommand = N'CREATE TABLE [dbo].[wait_stats]
	(
		[capture_date] DATETIME2(7) NOT NULL,
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

IF OBJECT_ID('[dbo].[wait_stats]') IS NULL 
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[wait_stats]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_wait_stats] ON [dbo].[wait_stats] ([capture_date],[wait_type])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[wait_stats]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[wait_stats] is skipped...DONE'
END

SET @SQLCommand = REPLACE(@SQLCommand, N'[wait_stats]', N'[ts_wait_stats]')

IF OBJECT_ID('[dbo].[ts_wait_stats]') IS NULL 
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[ts_wait_stats]...'

	EXEC sp_executesql @SQLCommand
	CREATE UNIQUE CLUSTERED INDEX [CI_ts_wait_stats] ON [dbo].[ts_wait_stats] ([capture_date],[wait_type])

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[ts_wait_stats]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[ts_wait_stats] is skipped...DONE'
END
/*--------------------------------------------
-- Table for Filtering WaitStats
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_wait_types]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_wait_types]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_wait_types] is deleted.'
END

IF OBJECT_ID('[dbo].[filter_wait_types]') IS NULL 
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[filter_wait_types]...'

	CREATE TABLE [dbo].[filter_wait_types]
	(
		[id] INT IDENTITY(1,1),
		[wait_type] NVARCHAR(60) NOT NULL,
		[is_excluded] BIT CONSTRAINT DF_fwt_is_excluded DEFAULT(0),
		[ts_is_excluded] BIT CONSTRAINT DF_fwt_ts_is_excluded DEFAULT(0)
	)

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Loading wait type data into filter table [dbo].[filter_wait_types]...'
	INSERT INTO [dbo].[filter_wait_types]
	( [wait_type] /*, [is_excluded], [ts_is_excluded]*/ )
	SELECT [wait_type] /*, 0, 0*/ FROM sys.dm_os_wait_stats

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set exclude list if no list provided by user then it uses Paul Randal's code
	-- (2014 marc) - http://www.sqlskills.com/blogs/paul/wait-statistics-or-please-tell-me-where-it-hurts/
	---------------------------------------------------------------------------------------------------------------------------------------	
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' WaitType filtering data configuration...'
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

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[filter_wait_types]...DONE'

END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_wait_types] is skipped...DONE'
END

/*--------------------------------------------
-- Table for Filtering PerfMon Counters
--------------------------------------------*/
IF(OBJECT_ID('[dbo].[filter_performance_counters]') IS NOT NULL AND @DropTableIfExist = 1)
BEGIN
	DROP TABLE [dbo].[filter_performance_counters]
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_performance_counters] is deleted.'
END

IF OBJECT_ID('[dbo].[filter_performance_counters]') IS NULL
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating table [dbo].[filter_performance_counters]...'

	CREATE TABLE [dbo].[filter_performance_counters]
	(
		[id] INT IDENTITY(1,1),
		[counter_name] NVARCHAR(60) NOT NULL,
		[is_included] BIT CONSTRAINT DF_fpc_is_included DEFAULT(0),
		[ts_is_included] BIT CONSTRAINT DF_fpc_ts_is_included DEFAULT(0)
	)

	/*--------------------------------------------
	-- Insert all supported counters
	--------------------------------------------*/
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Loading supported performance counters into filter table [dbo].[filter_wait_types]...'
	INSERT INTO [dbo].[filter_performance_counters]
	( [counter_name] /*, [is_included], [ts_is_included]*/ )
	SELECT DISTINCT [counter_name] /*, 0, 0 */ FROM sys.dm_os_performance_counters 
	WHERE cntr_type IN (272696576, 65792)

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
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Performance counter filtering data configuration for SQL Server 2012/2014...'
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
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Performance counter filtering data configuration for SQL Server 2008/2008R2...'
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

	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[filter_performance_counters]...DONE'
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Table [dbo].[filter_performance_counters] is skipped...DONE'
END

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' END: CREATE SCHEMA'
/******************************************************************************
******************************** CREATE SCHEMA ********************************
**************************************END*************************************/

/************************************START*************************************
************************ CREATE CENTRAL CONFIGURATION *************************
******************************************************************************/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' START: CENTRAL CONFIGURATION'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_ConfigureBCS]...'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_ConfigureBCS')
	EXEC ('CREATE PROC dbo.sp_ConfigureBCS AS SELECT ''stub version, to be replaced''')
GO

ALTER PROC [dbo].[sp_ConfigureBCS]

/*********************************************************************************************
Written by Robert Virag

File: sp_ConfigureBCS.sql

Syntax:
Creating a new custom config
sp_ConfigureBCS @Action = {'new' | 'create' | 'insert'}
,@NewConfigName = 'config_name'
[ ,<config_parameter_specifications> ]
[ ,<collector_parameter_specifications> ] 


Duplicating an existing custom config
sp_ConfigureBCS @Action = {'clone' | 'duplicate' | 'copy'}
,@ConfigName = 'existing_config_name'
[, @NewConfigName = 'new_config_name']
[ ,<config_parameter_specifications> ]
[ ,<collector_parameter_specifications> ]


Modifying custom config
sp_ConfigureBCS @Action = {'update' | 'modify'}
,@ConfigName = 'existing_config_name'
[ ,@NewConfigName = 'new_config_name' ]
[ ,<config_parameter_specification> ]
[ ,<collector_parameter_specifications> ]


Deleting custom config
sp_ConfigureBCS @Action = {'delete' | 'del' | 'remove' | 'drop'}
,@ConfigName = 'existing_config_name'


Listing custom configs
sp_ConfigureBCS @Action = 'list'


Getting help
sp_ConfigureBCS @Action = 'help'


<config_parameter_specifications>::=
[ ,@ConfigType = {0 | 1 | 2 | 3 | 4 | 5 | 6} ]
[ ,@ConfigDescription = 'config_description' ]

<collector_parameter_specifications>::=
[ ,@Retention = retention ]
[ ,@LogInfo =  loginfo ]
[ ,@DestTable =  'desttable' ]
[ ,@DestSchema =  'destschema' ]
[ ,@TSMode =  tsmode ]
[ ,@EmptyTSTable =  emptytstable ]
[ ,@CollectingInterval = collectinginterval ]
[ ,@Sampleinterval =  sampleinterval ]
[ ,@MeasuringInterval = measuringinterval ]
[ ,@ResetWaitStats = resetwaitstats ]
[ ,@BypassNonActiveSrvConfError = bypassnonactivesrvconferror ]
[ ,@CollectionTimeThreshold = collectiontimethreshold ]
[ ,@ChangedSizeThreshold = changedsizethreshold ]
[ ,@ChangedSpaceUsedThreshold = changedspaceusedthreshold ]
[ ,@CSUTExcludeLog = csutexcludelog ]

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary: Configuring, managing Custom Configuration settings for Baseline Collector Solution V2

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/
@help BIT = 0,

@ConfigName NVARCHAR(35) = NULL,
@ConfigType TINYINT = NULL,
@NewConfigName NVARCHAR(35) = NULL,
@Action NVARCHAR(10) = NULL,
@ConfigDescription NVARCHAR(max) = '_-*-_',

@Retention SMALLINT = -32767,
@LogInfo BIT = NULL,
@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@CollectingInterval INT = -2147483647,
@SampleInterval SMALLINT = -32767,
@MeasuringInterval TINYINT = NULL,
@ResetWaitStats BIT = NULL,
@BypassNonActiveSrvConfError BIT = NULL,
@CollectionTimeThreshold SMALLINT = -32767,
@ChangedSizeThreshold INT = -2147483647,
@ChangedSpaceUsedThreshold INT = -2147483647,
@CSUTExcludeLog BIT = NULL

AS
BEGIN
SET NOCOUNT ON

DECLARE @SQLCommand NVARCHAR(max)
DECLARE @FakeUpdate BIT

DECLARE @OldConfigName NVARCHAR(35)
DECLARE @OldRetention SMALLINT 
DECLARE @OldLogInfo BIT 
DECLARE @OldDestTable NVARCHAR(128) 
DECLARE @OldDestSchema NVARCHAR(25) 
DECLARE @OldTSMode BIT 
DECLARE @OldEmptyTSTable BIT 
DECLARE @OldCollectingInterval INT 
DECLARE @OldSampleInterval SMALLINT 
DECLARE @OldMeasuringInterval TINYINT 
DECLARE @OldResetWaitStats BIT 
DECLARE @OldBypassNonActiveSrvConfError BIT
DECLARE @OldCollectionTimeThreshold SMALLINT 
DECLARE @OldChangedSizeThreshold INT 
DECLARE @OldChangedSpaceUsedThreshold INT  
DECLARE @OldCSUTExcludeLog BIT
DECLARE @OldConfigDescription NVARCHAR(max)
DECLARE @OldConfigType TINYINT

DECLARE @DefRetention SMALLINT 
DECLARE @DefLogInfo BIT 
DECLARE @DefDestTable NVARCHAR(128) 
DECLARE @DefDestSchema NVARCHAR(25) 
DECLARE @DefTSMode BIT 
DECLARE @DefEmptyTSTable BIT 
DECLARE @DefCollectingInterval INT 
DECLARE @DefSampleInterval SMALLINT 
DECLARE @DefMeasuringInterval TINYINT 
DECLARE @DefResetWaitStats BIT 
DECLARE @DefBypassNonActiveSrvConfError BIT
DECLARE @DefCollectionTimeThreshold SMALLINT 
DECLARE @DefChangedSizeThreshold INT 
DECLARE @DefChangedSpaceUsedThreshold INT  
DECLARE @DefCSUTExcludeLog BIT
DECLARE @DefConfigDescription NVARCHAR(max)
DECLARE @DefConfigType TINYINT

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

BEGIN TRY
IF @help = 1 SET @Action = 'help'
IF @Action IS NULL OR @Action NOT IN ('help', 'list', 'new', 'create', 'insert', 'update', 'modify', 'delete', 'del', 'remove', 'drop', 'clone', 'duplicate', 'copy')
BEGIN
	SET @ErrorMessage = 'Unsupported action! Use EXEC sp_ConfigureBCS @Action = ''help'' to list supported actions!' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
END

IF @Action IN ('new', 'create', 'insert')
BEGIN
	IF @NewConfigName IS NULL AND @ConfigName IS NULL
	BEGIN
		SET @ErrorMessage = 'One of the parameters: @ConfigName or @NewConfigName must be provided! Evaluation: ISNULL(@ConfigName, @NewConfigName)' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END
	SELECT N'Insert new config: ' + ISNULL(@ConfigName, @NewConfigName)

	SET @ConfigType = ISNULL(@ConfigType,0)
	--SET @DefConfigType = ISNULL(@ConfigType,0)
	

	SET @DefRetention = CASE WHEN @ConfigType = 1 OR @ConfigType = 2 THEN NULL
						ELSE 90	END
	
	SET @DefLogInfo = 1
	SET @DefDestTable = NULL
	SET @DefDestSchema = NULL 

	SET @DefTSMode = CASE WHEN @ConfigType = 1 OR @ConfigType = 2 THEN NULL
						  ELSE 0 END
	SET @DefEmptyTSTable = CASE WHEN @ConfigType = 1 OR @ConfigType = 2 THEN NULL
								ELSE 0 END
								 
	SET @DefCollectingInterval = NULL 

	SET @DefSampleInterval = CASE WHEN @ConfigType = 4 OR @ConfigType = 5  OR @ConfigType = 0 THEN 10
								ELSE NULL END

	SET @DefMeasuringInterval = CASE WHEN @ConfigType = 5 OR @ConfigType = 0 THEN 3 
									 WHEN @ConfigType = 6 THEN NULL
									 ELSE NULL END
	
	
	SET @DefResetWaitStats = CASE WHEN @ConfigType = 6 OR @ConfigType = 0 THEN 0
								  ELSE NULL END 

	SET @DefBypassNonActiveSrvConfError = CASE WHEN @ConfigType = 2 OR @ConfigType = 0 THEN 0
								  ELSE NULL END 

	SET @DefCollectionTimeThreshold = NULL 
	SET @DefChangedSizeThreshold = NULL
	SET @DefChangedSpaceUsedThreshold = NULL 
	SET @DefCSUTExcludeLog = CASE 
						  WHEN @ConfigType = 3 OR @ConfigType = 0 THEN 1
						  ELSE NULL END
	 
	SET @DefConfigDescription = CASE @ConfigType 
								WHEN 0 THEN 'Default for type 0'
								WHEN 1 THEN 'Default for type 1'
								WHEN 2 THEN 'Default for type 2'
								WHEN 3 THEN 'Default for type 3'
								WHEN 4 THEN 'Default for type 4'
								WHEN 5 THEN 'Default for type 5'
								ELSE 'Default for type 6' END
	
	
	INSERT INTO [dbo].[bcs_config] 
			([config_name], [config_type],
				[retention], [loginfo], 
				[dest_table], [dest_schema], 
				[ts_mode], [empty_ts_table], 
				[collecting_interval], [sample_interval], [measuring_interval], 
				[reset_wait_stats], [bypass_nonactive_srv_conf_error],
				[collection_time_threshold], 
				[changed_size_threshold], 
				[changed_space_used_threshold], [csut_exclude_log],
				[config_description])
		VALUES (
			ISNULL(@ConfigName, @NewConfigName), 
			@ConfigType, --ISNULL(@ConfigType, @DefConfigType),
			CASE @Retention
				WHEN -32767 THEN @DefRetention
				ELSE @Retention
				END, 
			ISNULL(@LogInfo, @DefLogInfo), 
			CASE @DestTable
				WHEN '-' THEN @DefDestTable
				ELSE @DestTable
				END, 
			CASE @DestSchema
				WHEN '-' THEN @DefDestSchema
				ELSE @DestSchema
				END, 
			ISNULL(@TSMode, @DefTSMode), 
			ISNULL(@EmptyTSTable, @DefEmptyTSTable), 
			CASE @CollectingInterval
				WHEN -2147483647 THEN @DefCollectingInterval
				ELSE @CollectingInterval
				END, 
			CASE @SampleInterval
				WHEN -32767 THEN @DefSampleInterval
				ELSE @SampleInterval
				END, 
			CASE @MeasuringInterval
				WHEN -32767 THEN @DefMeasuringInterval
				ELSE @MeasuringInterval
				END,
			ISNULL(@ResetWaitStats, @DefResetWaitStats), 
			ISNULL(@BypassNonActiveSrvConfError, @DefBypassNonActiveSrvConfError),
			CASE @CollectionTimeThreshold
				WHEN -32767 THEN @DefCollectionTimeThreshold
				ELSE @CollectionTimeThreshold
				END,
			CASE @ChangedSizeThreshold
				WHEN -2147483647 THEN @DefChangedSizeThreshold
				ELSE @ChangedSizeThreshold
				END,
			CASE @ChangedSpaceUsedThreshold
				WHEN -2147483647 THEN @DefChangedSpaceUsedThreshold
				ELSE @ChangedSpaceUsedThreshold
				END,
			ISNULL(@CSUTExcludeLog, @DefCSUTExcludeLog),
			CASE @ConfigDescription
				WHEN '_-*-_' THEN @DefConfigDescription
				ELSE @ConfigDescription
				END
			)

			SELECT  [config_name] AS [New config details],
			[config_type],
			[retention],
			[loginfo],
			[dest_table], 
			[dest_schema], 
			[ts_mode], 
			[empty_ts_table], 
			[collecting_interval], 
			[sample_interval], 
			[measuring_interval], 
			[reset_wait_stats], 
			[bypass_nonactive_srv_conf_error],
			[collection_time_threshold], 
			[changed_size_threshold], 
			[changed_space_used_threshold],
			[csut_exclude_log],
			[config_description]
		FROM [dbo].[bcs_config]
			WHERE [config_name] = ISNULL(@ConfigName, @NewConfigName)
END

IF @Action IN ('update', 'modify')
BEGIN
	SELECT N'Update config: ' + @ConfigName AS [Action Desc]
	SELECT  [config_name] AS [State before update],
			[config_type],
			[retention],
			[loginfo],
			[dest_table], 
			[dest_schema], 
			[ts_mode], 
			[empty_ts_table], 
			[collecting_interval], 
			[sample_interval], 
			[measuring_interval], 
			[reset_wait_stats], 
			[bypass_nonactive_srv_conf_error],
			[collection_time_threshold], 
			[changed_size_threshold], 
			[changed_space_used_threshold],
			[csut_exclude_log],
			[config_description]			
		FROM [dbo].[bcs_config]
			WHERE [config_name] = @ConfigName 

	SELECT  @OldConfigName = [config_name],
			@OldRetention = [retention],
			@OldLogInfo = [loginfo],
			@OldDestTable = [dest_table], 
			@OldDestSchema = [dest_schema], 
			@OldTSMode = [ts_mode], 
			@OldEmptyTSTable = [empty_ts_table], 
			@OldCollectingInterval = [collecting_interval], 
			@OldSampleInterval = [sample_interval], 
			@OldMeasuringInterval = [measuring_interval], 
			@OldResetWaitStats = [reset_wait_stats], 
			@OldBypassNonActiveSrvConfError = [bypass_nonactive_srv_conf_error],
			@OldCollectionTimeThreshold = [collection_time_threshold], 
			@OldChangedSizeThreshold = [changed_size_threshold], 
			@OldChangedSpaceUsedThreshold = [changed_space_used_threshold],
			@OldCSUTExcludeLog = [csut_exclude_log],
			@OldConfigDescription = [config_description],
			@OldConfigType = [config_type]
		FROM [dbo].[bcs_config]
			WHERE [config_name] = @ConfigName

	--SET @ConfigType = ISNULL(@ConfigType, @OldConfigType)
	
	SET @SQLCommand = N'UPDATE [dbo].[bcs_config] SET @FakeUpdate = 1'

	IF @NewConfigName IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [config_name] = ''' + @NewConfigName + N''''
	END
	IF @Retention <> -32767
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [retention] = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
	END
	IF @LogInfo IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [loginfo] = ' + CAST(@LogInfo AS nvarchar)
	END
	IF @DestTable <> '-'
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [dest_table] = ''' + ISNULL(@DestTable, N'NULL') + N''''
	END
	IF @DestSchema <> '-'
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [dest_schema] = ''' + ISNULL(@DestSchema, N'NULL') + N''''
	END
	IF @TSMode IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [ts_mode] = ' + CAST(@TSMode AS nvarchar)
	END
	IF @EmptyTSTable IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [empty_ts_table] = ' + CAST(@EmptyTSTable AS nvarchar)
	END
	IF @CollectingInterval <> -2147483647
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [collecting_interval] = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
	END
	IF @SampleInterval <> -32767
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [sample_interval] = ' + ISNULL(CAST(@SampleInterval AS nvarchar), N'NULL')
	END
	IF @MeasuringInterval IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [measuring_interval] = ' + CAST(@MeasuringInterval AS nvarchar)
	END
	IF @ResetWaitStats IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [reset_wait_stats] = ' + CAST(@ResetWaitStats AS nvarchar)
	END
	IF @BypassNonActiveSrvConfError IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [bypass_nonactive_srv_conf_error] = ' + CAST(@BypassNonActiveSrvConfError AS nvarchar)
	END
	IF @CollectionTimeThreshold <> -32767
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [collection_time_threshold] = ' + ISNULL(CAST(@CollectionTimeThreshold AS nvarchar), N'NULL')
	END
	IF @ChangedSizeThreshold <> -2147483647
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [changed_size_threshold] = ' + ISNULL(CAST(@ChangedSizeThreshold AS nvarchar), N'NULL')
	END
	IF @ChangedSpaceUsedThreshold <> -2147483647
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [changed_space_used_threshold] = ' + ISNULL(CAST(@ChangedSpaceUsedThreshold AS nvarchar), N'NULL')
	END
	IF @CSUTExcludeLog IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [csut_exclude_log] = ' + CAST(@CSUTExcludeLog AS nvarchar)
	END
	IF @ConfigDescription <> '_-*-_'
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [config_description] = ''' + ISNULL(@ConfigDescription, N'NULL') + N''''
	END
	IF @ConfigType IS NOT NULL
	BEGIN
		SET @SQLCommand = @SQLCommand + N', [config_type] = ' + CAST(@ConfigType AS nvarchar)
	END

	SET @SQLCommand = @SQLCommand + N' WHERE [config_name] = ''' + ISNULL(@ConfigName, N'NULL') + N''''

	PRINT @SQLCommand

	EXEC sp_executesql @SQLCommand, N'@FakeUpdate BIT', @FakeUpdate = @FakeUpdate 
	
	SELECT  [config_name] AS [State after update],
			[config_type],
			[retention],
			[loginfo],
			[dest_table], 
			[dest_schema], 
			[ts_mode], 
			[empty_ts_table], 
			[collecting_interval], 
			[sample_interval], 
			[measuring_interval], 
			[reset_wait_stats], 
			[bypass_nonactive_srv_conf_error],
			[collection_time_threshold], 
			[changed_size_threshold], 
			[changed_space_used_threshold],
			[csut_exclude_log],
			[config_description]			
		FROM [dbo].[bcs_config]
			WHERE [config_name] = @ConfigName 
END

IF @Action IN ('delete', 'del', 'remove', 'drop')
BEGIN
	SELECT N'Delete config: ' + @ConfigName AS [Action Desc]
	SELECT  [config_name] AS [Deleted config(s)],
			[config_type],
			[retention],
			[loginfo],
			[dest_table], 
			[dest_schema], 
			[ts_mode], 
			[empty_ts_table], 
			[collecting_interval], 
			[sample_interval], 
			[measuring_interval], 
			[reset_wait_stats], 
			[bypass_nonactive_srv_conf_error],
			[collection_time_threshold], 
			[changed_size_threshold], 
			[changed_space_used_threshold],
			[csut_exclude_log],
			[config_description]			
		FROM [dbo].[bcs_config]
			WHERE [config_name] LIKE @ConfigName  
	DELETE FROM [dbo].[bcs_config] WHERE [config_name] LIKE @ConfigName
END

IF @Action IN ('clone', 'duplicate', 'copy')
BEGIN
	IF @NewConfigName IS NULL
	BEGIN
		SET @NewConfigName = 'c_'+@ConfigName
	END

	INSERT INTO [dbo].[bcs_config] 			
			([config_name], [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collecting_interval], [sample_interval], [measuring_interval], [reset_wait_stats], [bypass_nonactive_srv_conf_error], [collection_time_threshold], [changed_size_threshold], [changed_space_used_threshold], [csut_exclude_log], [config_description])
		SELECT @NewConfigName, [config_type], [retention], [loginfo], [dest_table], [dest_schema], [ts_mode], [empty_ts_table], [collecting_interval], [sample_interval], [measuring_interval], [reset_wait_stats], [bypass_nonactive_srv_conf_error], [collection_time_threshold], [changed_size_threshold], [changed_space_used_threshold], [csut_exclude_log]
		,CASE @ConfigDescription
			WHEN '_-*-_' THEN 'Clone of ' + @ConfigName
			ELSE @ConfigDescription
			END
			FROM [dbo].[bcs_config]
				WHERE [config_name] = @ConfigName
	SELECT N'Clone config ' + @ConfigName + N' | New config name: ' + @NewConfigName AS [Action Desc]
END

IF @Action = 'help'
BEGIN
SELECT N'help' AS [Supported Actions]
UNION
SELECT N'list'
UNION
SELECT N'new, create, insert'
UNION
SELECT N'update, modify'
UNION
SELECT N'delete, del, remove, drop'
UNION 
SELECT N'clone, duplicate, copy' 

SELECT [config_name], [config_type] FROM [dbo].[bcs_config]


SELECT 0 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'yes' AS [bypass_nonactive_srv_conf_error], 'yes' AS [dest_table], 'yes' AS [dest_schema], 'yes' AS [ts_mode], 'yes' AS [empty_ts_table], 'yes' AS [collecting_interval], 'yes' AS [sample_interval], 'yes' AS [measuring_interval], 'yes' AS [reset_wait_stats], 'yes' AS [collection_time_threshold], 'yes' AS [changed_size_threshold], 'yes' AS [changed_space_used_threshold], 'yes' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 1 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'no' AS [bypass_nonactive_srv_conf_error], 'no' AS [dest_table], 'no' AS [dest_schema], 'no' AS [ts_mode], 'no' AS [empty_ts_table], 'no' AS [collecting_interval], 'no' AS [sample_interval], 'no' AS [measuring_interval], 'no' AS [reset_wait_stats], 'no' AS [collection_time_threshold], 'no' AS [changed_size_threshold], 'no' AS [changed_space_used_threshold], 'no' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 2 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'yes' AS [bypass_nonactive_srv_conf_error], 'no' AS [dest_table], 'no' AS [dest_schema], 'no' AS [ts_mode], 'no' AS [empty_ts_table],'no' AS [collecting_interval], 'no' AS [sample_interval], 'no' AS [measuring_interval], 'no' AS [reset_wait_stats], 'no' AS [collection_time_threshold], 'no' AS [changed_size_threshold], 'no' AS [changed_space_used_threshold], 'no' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 3 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'no' AS [bypass_nonactive_srv_conf_error], 'yes' AS [dest_table], 'yes' AS [dest_schema], 'yes' AS [ts_mode], 'yes' AS [empty_ts_table], 'no' AS [collecting_interval], 'no' AS [sample_interval], 'no' AS [measuring_interval], 'no' AS [reset_wait_stats], 'yes' AS [collection_time_threshold], 'yes' AS [changed_size_threshold], 'yes' AS  [changed_space_used_threshold], 'yes' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 4 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'no' AS [bypass_nonactive_srv_conf_error], 'yes' AS [dest_table], 'yes' AS [dest_schema], 'yes' AS [ts_mode], 'yes' AS [empty_ts_table], 'yes' AS [collecting_interval], 'yes' AS [sample_interval], 'no' AS [measuring_interval], 'no' AS [reset_wait_stats], 'no' AS [collection_time_threshold], 'no' AS [changed_size_threshold], 'no' AS [changed_space_used_threshold], 'no' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 5 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'no' AS [bypass_nonactive_srv_conf_error], 'yes' AS [dest_table], 'yes' AS [dest_schema], 'yes' AS [ts_mode], 'yes' AS [empty_ts_table], 'yes' AS [collecting_interval], 'yes' AS [sample_interval], 'yes' AS [measuring_interval], 'no' AS [reset_wait_stats], 'no' AS [collection_time_threshold], 'no' AS [changed_size_threshold], 'no' AS [changed_space_used_threshold], 'no' AS [csut_exclude_log], 'yes' AS [config_description]
UNION
SELECT 6 AS [config_type], 'yes' AS [retention], 'yes' AS [loginfo], 'no' AS [bypass_nonactive_srv_conf_error], 'yes' AS [dest_table], 'yes' AS [dest_schema], 'yes' AS [ts_mode], 'yes' AS [empty_ts_table], 'no' AS [collecting_interval], 'no' AS [sample_interval], 'yes' AS [measuring_interval], 'yes' AS [reset_wait_stats], 'no' AS [collection_time_threshold], 'no' AS [changed_size_threshold], 'no' AS [changed_space_used_threshold], 'no' AS [csut_exclude_log], 'yes' AS [config_description]

SELECT N'/* Actions: help | list | new | create | insert | update | modify | delete | del | remove | drop | clone | duplicate | copy */' + CHAR(13) + CHAR(10)
+ N'EXEC sp_ConfigureBCS @Action = N'''''+ CHAR(13) + CHAR(10)
+ N'-- ,@ConfigName = N'''''+ CHAR(13) + CHAR(10)
+ N'-- ,@NewConfigName = N'''''+ CHAR(13) + CHAR(10)
+ N'-- ,@ConfigType = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@ConfigDescription = N'''''+ CHAR(13) + CHAR(10)
+ N'/* ALL Collector */'+ CHAR(13) + CHAR(10)
+ N'-- ,@Retention = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@LogInfo = ?'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectFileInfo(3), sp_CollectIOVFStats(4), sp_CollectPerfmonData(5), sp_CollectTempDBUsage(4), sp_CollectWaitStats(6) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@DestTable = N'''''+ CHAR(13) + CHAR(10)
+ N'-- ,@DestSchema = N'''''+ CHAR(13) + CHAR(10)
+ N'-- ,@TSMode = NULL'+ CHAR(13) + CHAR(10)
+ N'-- ,@EmptyTSTable = NULL'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectIOVFStats(4), sp_CollectPerfmonData(5), sp_CollectTempDBUsage(4) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@CollectingInterval = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@SampleInterval = ?'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectPerfmonData(5), sp_CollectWaitStats(6) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@MeasuringInterval = ?'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectWaitStats(6) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@ResetWaitStats = ?'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectConfigData(2) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@BypassNonActiveSrvConfError = ?'+ CHAR(13) + CHAR(10)
+ N'/* sp_CollectFileInfo(3) */'+ CHAR(13) + CHAR(10)
+ N'-- ,@CollectionTimeThreshold = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@ChangedSizeThreshold = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@ChangedSpaceUsedThreshold = ?'+ CHAR(13) + CHAR(10)
+ N'-- ,@CSUTExcludeLog = ?'+ CHAR(13) + CHAR(10) AS [Command /Copy-Paste/]

END

IF @Action = 'list'
BEGIN
SELECT * FROM [dbo].[bcs_config]
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
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_ConfigureBCS]...DONE'
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' END: CENTRAL CONFIGURATION'
/******************************************************************************
************************ CREATE CENTRAL CONFIGURATION *************************
**************************************END*************************************/
GO
/************************************START*************************************
****************************** CREATE COLLECTORS ******************************
******************************************************************************/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' START: CREATE COLLECTORS'
GO
/*- sp_CollectInstanceInfo -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectInstanceInfo]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Server Instace Related Info

License: Copyright (c) 2015 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 1)
			ORDER BY [Config Info] DESC


	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @row_count INT
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	SELECT 
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END,
		@LogInfo = ISNULL(@LogInfo, [loginfo]) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL') 
		END
		+ CASE @i_loginfo 
		WHEN 0 THEN N''
		ELSE N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		END
		--+ N', @help = ' + CAST(@help AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL') 
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
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
	DECLARE @TRACESTATUS TABLE
    (
      [TraceFlag] SMALLINT,
      [Status] BIT,
      [Global] BIT,
      [Session] BIT
    )
	DECLARE @enabled_trace_flags INT
	SET @enabled_trace_flags = 0

	INSERT  INTO @TRACESTATUS
        EXEC ( 'DBCC TRACESTATUS (-1)')

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

	SELECT @enabled_trace_flags = COUNT(*) FROM @TRACESTATUS 
								WHERE [Global] = 1 AND [Status] = 1

	IF (@enabled_trace_flags) > 0 
    BEGIN
		INSERT INTO @instance_info ([name], [value])
		SELECT N'TF' + CAST([TraceFlag] AS NVARCHAR(5)),
			CAST([Status] AS VARCHAR(1)) 
			+ N'/' + CAST([Global] AS NVARCHAR(1))
			+ N'/' + CAST([Session] AS NVARCHAR(1))
		FROM @TRACESTATUS WHERE [Global] = 1 AND [Status] = 1
		UNION
		SELECT N'EnabledTraceFlags', CAST(@enabled_trace_flags AS NVARCHAR(1))
    END
	ELSE
	BEGIN
		INSERT INTO @instance_info ([name], [value])
		SELECT  N'EnabledTraceFlags', N'0'
	END

	

	--select * from @instance_info
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Pre-Initial Data: insert data which have no initial state (e.g.: table is empty or data were deleted manually since the last check)
	---------------------------------------------------------------------------------------------------------------------------------------
	;WITH most_recent_config as ( 
	SELECT [capture_date], [name]--, [value], [value_in_use], [is_initial], [is_pre]
	FROM [dbo].[instance_info] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[instance_info] AS [cc] WHERE [c].[name] = [cc].[name])
	) 
	INSERT INTO [dbo].[instance_info]
    ( [capture_date], [name], [value], [is_initial], [is_pre] ) 
	SELECT  SYSDATETIME(),[name], [value], 1, 1 
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
	-- Insert disabled traceflags
	;WITH most_recent_config as ( 
	SELECT [capture_date], [name]--, [value], [value_in_use], [is_initial], [is_pre]
	FROM [dbo].[instance_info] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[instance_info] AS [cc] WHERE [c].[name] = [cc].[name])
	), disabled_tfs AS (SELECT [mrc].[name] 
			FROM [most_recent_config] AS [mrc] 
			EXCEPT SELECT [ii].[name] FROM @instance_info AS [ii]
	) INSERT INTO @instance_info ([name], [value])
	SELECT [name], N'0/0/0' FROM disabled_tfs

	;WITH [most_recent_config] AS ( 
	SELECT [capture_date], [name], [value]
	FROM [dbo].[instance_info] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[instance_info] AS [cc] WHERE [c].[name] = [cc].[name])
	)
	INSERT  INTO [dbo].[instance_info] ( [capture_date], [name], [value], [is_initial], [is_pre] )
	SELECT SYSDATETIME(), [c].[name], [c].[value], 0, 0 FROM [most_recent_config] AS [mrc] INNER JOIN @instance_info AS [c] ON [mrc].[name] = [c].[name] WHERE [mrc].[value] <> [c].[value]

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
		DELETE FROM [dbo].[instance_info] WHERE [capture_date] < DATEADD(dd, -1*CAST(@Retention AS nvarchar) , SYSDATETIME())

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
		( [capture_date], [name], [value], [is_initial], [is_pre]  )
		SELECT SYSDATETIME(), [name], [value], 1, 0 
		FROM @instance_info 
		WHERE [name] NOT IN ( 
		SELECT [name] FROM [dbo].[instance_info] 
		WHERE [capture_date] >= DATEADD(dd, -1*@Retention, SYSDATETIME())
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectInstanceInfo]...DONE'
GO
/*- sp_CollectConfigData -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectConfigData]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Server Configuration Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = -32768,
@BypassNonActiveSrvConfError BIT = NULL,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'

	UNION ALL
	SELECT N'@BypassNonActiveSrvConfError', N'See the default config info below.', N'The collector checks if there is any non-active server configuration and generates an ERROR if it finds any. If this option is enabled it bypasses the ERROR and generates a WARNING instead.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 2)
			ORDER BY [Config Info] DESC

	RETURN
END

DECLARE @ErrorMessage NVARCHAR(max)
DECLARE @InfoMessage NVARCHAR(max)
DECLARE @Severity INT

DECLARE @row_count INT
DECLARE @non_active_server_config_count INT
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_bypass_non_active_srv_conf_error BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE LOWER([config_name]) = LOWER(@CustomConfig))
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	SELECT
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END, 
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END, 
		@LogInfo = ISNULL(@LogInfo, [loginfo]),
		@i_bypass_non_active_srv_conf_error = CASE 
			WHEN @BypassNonActiveSrvConfError IS NULL THEN 0
			ELSE 1
			END,
		@BypassNonActiveSrvConfError = ISNULL(@BypassNonActiveSrvConfError, [bypass_nonactive_srv_conf_error])
		FROM [dbo].[bcs_config] WITH (NOLOCK)
		WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), 'NULL')
		END
		+ CASE @i_bypass_non_active_srv_conf_error
		WHEN 0 THEN N''
		ELSE N', @BypassNonActiveSrvConfError = ' + CAST(@BypassNonActiveSrvConfError AS nvarchar)
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		END
		--+ N', @help = ' + CAST(@help AS nvarchar) 
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), 'NULL')
		+ N', @BypassNonActiveSrvConfError = ' + CAST(@BypassNonActiveSrvConfError AS nvarchar)
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
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
	SELECT [capture_date], [configuration_id]--, [value], [value_in_use], [is_initial], [is_pre]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	) 
	INSERT INTO [dbo].[configuration_data]
    ( [capture_date], [configuration_id], [value], [value_in_use], [is_initial], [is_pre] ) 
	SELECT  SYSDATETIME(),[configuration_id], [value], [value_in_use], 1, 1 
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
	SELECT [capture_date], [configuration_id], [value], [value_in_use]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	)
	INSERT  INTO [dbo].[configuration_data] ( [capture_date], [configuration_id], [value], [value_in_use], [is_initial], [is_pre] )
	SELECT SYSDATETIME(), [c].[configuration_id], [c].[value], [c].[value_in_use], 0, 0 FROM [most_recent_config] AS [mrc] INNER JOIN [sys].[configurations] AS [c] ON [mrc].[configuration_id] = [c].[configuration_id] WHERE [mrc].[value] <> [c].[value] OR [mrc].[value_in_use] <> [c].[value_in_use] 

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
		DELETE FROM [dbo].[configuration_data] WHERE [capture_date] < DATEADD(dd, -1*CAST(@Retention AS nvarchar) , SYSDATETIME())

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
		( [capture_date], [configuration_id], [value], [value_in_use], [is_initial], [is_pre]  )
		SELECT SYSDATETIME(), [configuration_id], [value], [value_in_use], 1, 0 
		FROM [sys].[configurations] 
		WHERE [configuration_id] NOT IN ( 
		SELECT [configuration_id] FROM [dbo].[configuration_data] 
		WHERE [capture_date] >= DATEADD(dd, -1*@Retention, SYSDATETIME())
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
	SELECT [capture_date], [configuration_id], [value], [value_in_use], [is_initial]
	FROM [dbo].[configuration_data] AS [c] WHERE [capture_date] = (SELECT MAX([capture_date]) FROM [dbo].[configuration_data] AS [cc] WHERE [c].[configuration_id] = [cc].[configuration_id])
	)
	SELECT @non_active_server_config_count = COUNT(*) FROM [most_recent_config] WHERE [value] <> [value_in_use]
	
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectConfigData]...DONE'
GO
/*- sp_CollectDatabaseInfo -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectDatabaseInfo]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting Database Info

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@Retention SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help messages.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 1)
			ORDER BY [Config Info] DESC

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
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END
	
	SELECT
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END, 
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END, 
		@LogInfo = ISNULL(@LogInfo, [loginfo]) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo 
		WHEN 0 THEN N''
		ELSE N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
		END
		--+ N', @help = ' + CAST(@help AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		+ N', @LogInfo = '+ CAST(@LogInfo AS nvarchar)
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
		 SELECT  SYSDATETIME(),[name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', 1, 1  
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
		SELECT SYSDATETIME(), [sd].[name], [sd].[database_id], [sd].[source_database_id], [sd].[owner_sid], [sd].[create_date], [sd].[compatibility_level], [sd].[collation_name], [sd].[user_access], [sd].[is_read_only], [sd].[is_auto_close_on], [sd].[is_auto_shrink_on], [sd].[state], [sd].[is_in_standby], [sd].[is_supplemental_logging_enabled], [sd].[snapshot_isolation_state], [sd].[is_read_committed_snapshot_on], [sd].[recovery_model], [sd].[page_verify_option], [sd].[is_auto_create_stats_on], [sd].[is_auto_update_stats_on], [sd].[is_auto_update_stats_async_on], [sd].[is_ansi_null_default_on], [sd].[is_ansi_nulls_on], [sd].[is_ansi_padding_on], [sd].[is_ansi_warnings_on], [sd].[is_arithabort_on], [sd].[is_concat_null_yields_null_on], [sd].[is_numeric_roundabort_on], [sd].[is_quoted_identifier_on], [sd].[is_recursive_triggers_on], [sd].[is_cursor_close_on_commit_on], [sd].[is_local_cursor_default], [sd].[is_fulltext_enabled], [sd].[is_trustworthy_on], [sd].[is_db_chaining_on], [sd].[is_parameterization_forced], [sd].[is_master_key_encrypted_by_server], [sd].[is_published], [sd].[is_merge_published], [sd].[is_distributor], [sd].[is_sync_with_backup], [sd].[service_broker_guid], [sd].[is_broker_enabled], [sd].[is_date_correlation_on] ' + @version_column_list_with_table_prefix + N', 0, 0 
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
		DELETE FROM [dbo].[database_info] WHERE [capture_date] < DATEADD(dd, -1*CAST(@Retention AS nvarchar) , SYSDATETIME())

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
		 SELECT SYSDATETIME(), [name], [database_id], [source_database_id], [owner_sid], [create_date], [compatibility_level], [collation_name], [user_access], [is_read_only], [is_auto_close_on], [is_auto_shrink_on], [state], [is_in_standby], [is_supplemental_logging_enabled], [snapshot_isolation_state], [is_read_committed_snapshot_on], [recovery_model], [page_verify_option], [is_auto_create_stats_on], [is_auto_update_stats_on], [is_auto_update_stats_async_on], [is_ansi_null_default_on], [is_ansi_nulls_on], [is_ansi_padding_on], [is_ansi_warnings_on], [is_arithabort_on], [is_concat_null_yields_null_on], [is_numeric_roundabort_on], [is_quoted_identifier_on], [is_recursive_triggers_on], [is_cursor_close_on_commit_on], [is_local_cursor_default], [is_fulltext_enabled], [is_trustworthy_on], [is_db_chaining_on], [is_parameterization_forced], [is_master_key_encrypted_by_server], [is_published], [is_merge_published], [is_distributor], [is_sync_with_backup], [service_broker_guid], [is_broker_enabled], [is_date_correlation_on] ' + @version_column_list + N', 1, 0  
		 FROM [sys].[databases] 
		 WHERE [name] NOT IN ( 
		 SELECT [database_name] FROM [dbo].[database_info] 
		 WHERE [capture_date] >= DATEADD(dd, -1*'+CAST(@Retention AS nvarchar)+N', SYSDATETIME()) 
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectDatabaseInfo]...DONE'
GO
/*- sp_CollectFileInfo -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectFileInfo]...'
GO
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
@CollectionTimeThreshold  = NULL,
@ChangedSizeThreshold  = NULL,
@ChangedSpaceUsedThreshold  = NULL,
@CSUTExcludeLog = 1,
@TSMode = 0,
@EmptyTSTable = 0,
@Retention = 90,
@help = 0,
@LogInfo = 1,
@CustomConfig = NULL

Change Log  
Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server File Information Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@CollectionTimeThreshold SMALLINT = -32768,
@ChangedSizeThreshold INT = -2147483648,
@ChangedSpaceUsedThreshold INT = -2147483648,
@CSUTExcludeLog BIT = NULL,
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@Retention SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN

SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'See the default config info below.', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'See the default config info below.', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@CollectionTimeThreshold', N'See the default config info below.', N'If used data collection only performs in case of the time of the last collection date reach the threshold provided (in hours).'

	UNION ALL
	SELECT N'@ChangedSizeThreshold', N'See the default config info below.', N'If used data collection only performs in case of the changes of the size of the data files reach the threshold provided.'
	
	UNION ALL
	SELECT N'@ChangedSpaceUsedThreshold', N'See the default config info below.', N'If used data collection only performs in case of the changes of the size of the used space reach the threshold provided.'
	
	UNION ALL
	SELECT N'@CSUTExcludeLog', N'See the default config info below.', N'It works only in conjunction with the @ChangedSpaceUsedThreshold parameter. If enabled log files will be excluded.'
	
	UNION ALL
	SELECT N'@TSMode', N'See the default config info below.', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'See the default config info below.', N'Empty the table used for troubleshooting before the data collection.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 3)
			ORDER BY [Config Info] DESC

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

DECLARE @collate_string NVARCHAR(256)
DECLARE @data_compression NVARCHAR(35)
DECLARE @insert_string NVARCHAR(max)
DECLARE @SQLCommand NVARCHAR(max)

DECLARE @filter NVARCHAR(max)
DECLARE @where_string NVARCHAR(max)
DECLARE @icq_cst NVARCHAR(max)
DECLARE @icq_csut NVARCHAR(max)
DECLARE @icq_ctt NVARCHAR(max)

DECLARE @row_count INT
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_dest_table BIT
DECLARE @i_dest_schema BIT
DECLARE @i_collection_time_threshold BIT
DECLARE @i_changed_size_threshold BIT
DECLARE @i_changed_space_used_threshold BIT
DECLARE @i_csut_excludeLog BIT
DECLARE @i_ts_mode BIT
DECLARE @i_empty_ts_table BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END
	
	
	SELECT 
		@i_dest_table = CASE @DestTable
			WHEN '-' THEN 0
			ELSE 1
			END,
		@DestTable = CASE @DestTable
			WHEN '-' THEN [dest_table]
			ELSE @DestTable
			END,
		@i_dest_schema = CASE @DestSchema
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestSchema = CASE @DestSchema
			WHEN '-' THEN [dest_schema]
			ELSE @DestSchema
			END,
		@i_collection_time_threshold = CASE @CollectionTimeThreshold
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@CollectionTimeThreshold = CASE @CollectionTimeThreshold
			WHEN -32768 THEN [collection_time_threshold]
			ELSE @CollectionTimeThreshold
			END,
		@i_changed_size_threshold = CASE @ChangedSizeThreshold
			WHEN -2147483648 THEN 0
			ELSE 1
			END,
		@ChangedSizeThreshold = CASE @ChangedSizeThreshold
			WHEN -2147483648 THEN [changed_size_threshold]
			ELSE @ChangedSizeThreshold
			END,
		@i_changed_space_used_threshold = CASE @ChangedSpaceUsedThreshold
			WHEN -2147483648 THEN 0
			ELSE 1
			END,
		@ChangedSpaceUsedThreshold = CASE @ChangedSpaceUsedThreshold
			WHEN -2147483648 THEN [changed_size_threshold]
			ELSE @ChangedSpaceUsedThreshold
			END,
		@i_csut_excludeLog = CASE 
			WHEN @CSUTExcludeLog IS NULL THEN 0
			ELSE 1
			END,
		@CSUTExcludeLog = ISNULL(@CSUTExcludeLog, [csut_exclude_log]),			 
		@i_ts_mode = CASE 
			WHEN @TSMode IS NULL THEN 0
			ELSE 1
			END,
		@TSMode = ISNULL(@TSMode, [ts_mode]),
		@i_empty_ts_table = CASE 
			WHEN @EmptyTSTable IS NULL THEN 0
			ELSE 1
			END,
		@EmptyTSTable = ISNULL(@EmptyTSTable, [empty_ts_table]),
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END, 
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END,  
		@LogInfo = ISNULL(@LogInfo, [loginfo])
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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

	IF @CollectionTimeThreshold < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @CollectionTimeThreshold is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @ChangedSizeThreshold < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @ChangedSizeThreshold is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @ChangedSpaceUsedThreshold < 0 
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @ChangedSizeThreshold is not supported.' 
		RAISERROR(@ErrorMessage,16,1) WITH NOWAIT
	END

	IF @CSUTExcludeLog IS NULL
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @CSUTExcludeLog is not supported.' 
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
			SET @DestTable = N'ts_file_info'
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
	
	SET @row_count = 0

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Command
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Command Executed: EXEC ' + (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) 
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_dest_table
		WHEN 0 THEN N''
		ELSE N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		END
		+ CASE @i_dest_schema
		WHEN 0 THEN N''
		ELSE N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		END
		+ CASE @i_collection_time_threshold
		WHEN 0 THEN N''
		ELSE N', @CollectionTimeThreshold = ' + ISNULL(CAST(@CollectionTimeThreshold AS nvarchar), N'NULL')
		END
		+ CASE @i_changed_size_threshold
		WHEN 0 THEN N''
		ELSE N', @ChangedSizeThreshold = ' + ISNULL(CAST(@ChangedSizeThreshold AS nvarchar), N'NULL')
		END
		+ CASE @i_changed_space_used_threshold
		WHEN 0 THEN N''
		ELSE N', @ChangedSpaceUsedThreshold = ' + ISNULL(CAST(@ChangedSpaceUsedThreshold AS nvarchar), N'NULL')
		END
		+ CASE @i_csut_excludeLog
		WHEN 0 THEN N''
		ELSE N', @CSUTExcludeLog = ' + CAST(@CSUTExcludeLog AS nvarchar)
		END
		+ CASE @i_ts_mode
		WHEN 0 THEN N''
		ELSE N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		END
		+ CASE @i_empty_ts_table
		WHEN 0 THEN N''
		ELSE N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		END
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		END
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @CollectionTimeThreshold = ' + ISNULL(CAST(@CollectionTimeThreshold AS nvarchar), N'NULL')
		+ N', @ChangedSizeThreshold = ' + ISNULL(CAST(@ChangedSizeThreshold AS nvarchar), N'NULL')
		+ N', @ChangedSpaceUsedThreshold = ' + ISNULL(CAST(@ChangedSpaceUsedThreshold AS nvarchar), N'NULL')
		+ N', @CSUTExcludeLog = ' + CAST(@CSUTExcludeLog AS nvarchar)
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
	CREATE TABLE #most_recent_file_info
	(
		[mr_capture_date] DATETIME2(2) NOT NULL,
		[mr_database_name] SYSNAME,
		[mr_logical_name] SYSNAME,
		[mr_physical_name] NVARCHAR(260) NOT NULL,
		[mr_size_pages] INT,
		[mr_space_used_pages] INT
	)

	SET @SQLCommand = N'INSERT INTO #most_recent_file_info ([mr_capture_date], [mr_database_name], [mr_logical_name], [mr_physical_name], [mr_size_pages], [mr_space_used_pages])
	SELECT [capture_date] as [mr_capture_date], 
		[database_name] as [mr_database_name], 
		[logical_name] as [mr_logical_name],
		[physical_name] as [mr_physical_name], 
		[size_pages] as [mr_size_pages], 
		[space_used_pages] as [mr_space_used_pages]
	FROM ' + QUOTENAME(DB_NAME(DB_ID()))+N'.'+QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' AS [fi]
		WHERE [capture_date] = (SELECT MAX([capture_date]) 
								FROM ' + QUOTENAME(DB_NAME(DB_ID()))+N'.'+QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' AS [fi2] 
									WHERE [fi].[database_name] = [fi2].[database_name]
									AND [fi].[logical_name] =  [fi2].[logical_name])'
	
	IF @debug > 0 
	BEGIN
		SELECT len(@SQLCommand) AS [command_lenght]
		PRINT @SQLCommand
	END

	EXEC sp_executesql @SQLCommand
	
	---------------------------------------------------------
	-- Filtering | TSMode - include | StandardMode - exclude
	---------------------------------------------------------
	SET @filter = N''	
	SET @icq_cst = N'NULL'
	SET @icq_csut = N'NULL'
	SET @icq_ctt = N'NULL'
	IF (@ChangedSizeThreshold IS NOT NULL)
	BEGIN
		SET @filter = N' ((abs(mr_size_pages-size)*1.00/mr_size_pages*100.00) > @ChangedSizeThreshold) '
		SET @icq_cst = N'CASE WHEN ((abs(mr_size_pages-size)*1.00/mr_size_pages*100.00) > @ChangedSizeThreshold) THEN 1	ELSE 0 END'
	END

	IF (@CollectionTimeThreshold IS NOT NULL)
	BEGIN
		SET @where_string = N' (DATEDIFF(HOUR,[mrfi].[mr_capture_date],SYSDATETIME()) > @CollectionTimeThreshold) '
		IF(LEN(@filter) = 0)
		BEGIN
			SET @filter = @where_string
		END
		ELSE
		BEGIN
			SET @filter = @filter + CHAR(13) + CHAR(10) + N' OR ' + @where_string
		END
		SET @icq_ctt = N'CASE WHEN (DATEDIFF(HOUR,[mrfi].[mr_capture_date],SYSDATETIME()) > @CollectionTimeThreshold) THEN 1 ELSE 0 END'
	END

	IF (@ChangedSpaceUsedThreshold IS NOT NULL) 
	BEGIN
		SET @where_string = N' (	
								((abs([mr_space_used_pages]-FILEPROPERTY([df].[name], ''SpaceUsed''))*1.00/[mr_space_used_pages]*100.00) > @ChangedSpaceUsedThreshold
								AND [df].[type] <> 1 AND @CSUTExcludeLog = 1
								) OR (
								(abs([mr_space_used_pages]-FILEPROPERTY([df].[name], ''SpaceUsed''))*1.00/[mr_space_used_pages]*100.00) > @ChangedSpaceUsedThreshold
								AND @CSUTExcludeLog = 0
								)
							) '
		IF(LEN(@filter) = 0)
		BEGIN
			SET @filter = @where_string
		END
		ELSE
		BEGIN
			SET @filter = @filter + CHAR(13) + CHAR(10) + N' OR ' + @where_string
		END
		SET @icq_csut = N'CASE WHEN (((abs([mr_space_used_pages]-FILEPROPERTY([df].[name], ''SpaceUsed''))*1.00/[mr_space_used_pages]*100.00) > @ChangedSpaceUsedThreshold AND [df].[type] <> 1 AND @CSUTExcludeLog = 1) 
			OR ((abs([mr_space_used_pages]-FILEPROPERTY([df].[name], ''SpaceUsed''))*1.00/[mr_space_used_pages]*100.00) > @ChangedSpaceUsedThreshold AND @CSUTExcludeLog = 0)) THEN 1 ELSE 0 END'
	END

IF (@ChangedSizeThreshold IS NULL 
	AND @ChangedSpaceUsedThreshold IS NULL 
	AND @CollectionTimeThreshold IS NULL)
	BEGIN
		SET @filter = N' 1=1 '
	END
	
	DECLARE @object NVARCHAR (300)
	DECLARE c CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY
	FOR SELECT DISTINCT [sd].[name]
	FROM [sys].[databases] AS [sd]
	INNER JOIN [sys].[master_files] AS [mf] ON [mf].[database_id] = [sd].[database_id]
	INNER JOIN [dbo].[filter_database_file] AS [ft] ON [ft].[database_name] = [sd].[name] AND [ft].[logical_file_name] = [mf].[name]
		WHERE [sd].[state] = 0 
		AND ( 
		/* INCLUDE */
		(@TSMode = 1 AND  [ft].[ts_is_included_file_info] = 1)
		OR
		/* EXCLUDE */
		(@TSMode = 0 AND ([ft].[is_excluded_file_info] = 0 OR [ft].[is_excluded_file_info] IS NULL))
		)
	
	IF @debug > 0
	BEGIN
		SET @insert_string = N' '
	END
	ELSE
	BEGIN
		SET @insert_string = N' INSERT INTO ' + QUOTENAME(DB_NAME(DB_ID()))+N'.'+QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' 
		 ( [capture_date], [database_name], [logical_name], [physical_name], [type], [size_pages], [space_used_pages], [max_size_pages], [growth_pages_percent], [is_percent_growth], [ic_cst], [ic_csut], [ic_ctt], [ic_path]) '
	END
						
	OPEN c;
	
	FETCH NEXT FROM c INTO @object
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
	IF DATABASEPROPERTYEX(@object ,'collation') = DATABASEPROPERTYEX(DB_NAME() ,'collation')
	BEGIN	
		SET @collate_string = N''
	END
	ELSE
	BEGIN
		SET @collate_string = N' COLLATE ' + CONVERT(NVARCHAR, DATABASEPROPERTYEX(DB_NAME() ,'collation')) + N' '
		
		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = N'Collation conflict was resolved with' + @collate_string + N'clause. Database: ' + QUOTENAME(@object)  + N' /'+ISNULL(CONVERT(NVARCHAR,DATABASEPROPERTYEX(@object ,'collation')), N'NULL')+N'/'
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		
	END
	
	 
	SET @SQLCommand = N'USE ' + QUOTENAME(@object) + CHAR(13) + CHAR(10) + @insert_string +
	N' SELECT SYSDATETIME() AS [capture_date],
			DB_NAME() AS [database_name], 
			[df].[name] AS [logical_name], 
			[df].[physical_name], 
			[df].[type], 
			[df].[size] AS [size_pages], 
			FILEPROPERTY([df].[name], ''SpaceUsed'') AS [space_used_pages], 
			[df].[max_size] AS [max_size_pages], 
			[df].[growth] AS [growth_pages_percent], 
			[df].[is_percent_growth],
			' + @icq_cst + N' AS [ic_cst],
			' + @icq_csut + N' AS [ic_csut],
			' + @icq_ctt + N' AS [ic_ctt],
			CASE WHEN [mrfi].[mr_physical_name] <> [df].[physical_name] ' + @collate_string + N' THEN 1
			ELSE 0 END AS [ic_path]
		FROM [sys].[database_files] AS [df]
		INNER JOIN #most_recent_file_info AS [mrfi] ON DB_NAME() = [mrfi].[mr_database_name] AND [df].[name] ' + @collate_string + N' = [mrfi].[mr_logical_name]
		INNER JOIN [sys].[databases] AS [sd] ON [sd].[name] = [mrfi].[mr_database_name]
		INNER JOIN ' + QUOTENAME(DB_NAME(DB_ID())) + N'.[dbo].[filter_database_file] AS [fdf] ON [fdf].[database_name] = [sd].[name] AND [fdf].[logical_file_name] = [df].[name] ' + @collate_string + N'
			WHERE (	(@TSMode = 1 AND [fdf].[ts_is_included_file_info] = 1  )
					OR
					(@TSMode = 0 AND ( [fdf].[is_excluded_file_info] = 0 OR [fdf].[is_excluded_file_info] IS NULL) )
					) 
				AND ([mrfi].[mr_physical_name] <> [df].[physical_name] ' + @collate_string + N' OR (' + @filter + N'))'


	IF @debug > 0 
	BEGIN
		SELECT '1-'+ @object
		SELECT len(@SQLCommand) AS [command_lenght]
		PRINT @SQLCommand
	END
	
	EXEC sp_executesql @SQLCommand, N'@CollectionTimeThreshold SMALLINT, @ChangedSizeThreshold INT, @ChangedSpaceUsedThreshold INT, @TSMode BIT, @CSUTExcludeLog BIT', @CollectionTimeThreshold = @CollectionTimeThreshold, @ChangedSizeThreshold = @ChangedSizeThreshold, @ChangedSpaceUsedThreshold = @ChangedSpaceUsedThreshold, @TSMode = @TSMode, @CSUTExcludeLog = @CSUTExcludeLog
	
	SET @row_count = @row_count + @@ROWCOUNT

	SET @SQLCommand = N'USE ' + QUOTENAME(@object) + N'
	;WITH not_collected_db_files AS(
	SELECT DB_NAME() AS [database_name], [name] ' + @collate_string + N' AS [logical_file_name] 
	FROM [sys].[database_files] AS [idf]
	INNER JOIN ' + QUOTENAME(DB_NAME(DB_ID())) + N'.[dbo].[filter_database_file] AS [fdf] ON [fdf].[database_name] = DB_NAME() AND [fdf].[logical_file_name] = [idf].[name] ' + @collate_string + N'
		 WHERE (
			(@TSMode = 1 AND [fdf].[ts_is_included_file_info] = 1  )
			OR
			(@TSMode = 0 AND ( [fdf].[is_excluded_file_info] = 0 OR [fdf].[is_excluded_file_info] IS NULL) ) 
			)
	EXCEPT
	SELECT mr_database_name AS [database_name], mr_logical_name AS [logical_file_name] 
	FROM #most_recent_file_info
	) ' + @insert_string + N'SELECT GETDATE() AS [capture_date], DB_NAME() AS [database_name], [df].[name] AS [logical_name], [df].[physical_name], [df].[type], [df].[size] AS [size_pages], FILEPROPERTY([df].[name], ''SpaceUsed'') AS [space_used_pages], [df].[max_size], [df].[growth] AS [growth_pages_percent], [df].[is_percent_growth], NULL, NULL, NULL, NULL 
	FROM [sys].[database_files] AS [df]
	INNER JOIN not_collected_db_files AS [ncdbf] ON [ncdbf].[database_name] = DB_NAME() AND [ncdbf].[logical_file_name] = [df].[name] ' + @collate_string

	IF @debug > 1 
	BEGIN
		SELECT '2-' + @object
		SELECT len(@SQLCommand) AS [command_lenght]
		PRINT @SQLCommand
	END

	EXEC sp_executesql @SQLCommand, N'@TSMode BIT', @TSMode = @TSMode

	SET @row_count = @row_count + @@ROWCOUNT

	FETCH NEXT FROM c INTO @object;
	END
	CLOSE c;
	DEALLOCATE c;

	DROP TABLE #most_recent_file_info

	IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) added.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END

	

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @row_count = 0
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + N' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@Retention AS nvarchar) + N', SYSDATETIME()) '
		EXEC sp_executesql @SQLCommand

		SET @row_count = @@ROWCOUNT

		IF(@LogInfo = 1)
		BEGIN
			SET @InfoMessage = CAST(@row_count AS NVARCHAR) +  N'row(s) deleted due to expired retention.' 				
			SET @Severity = 10
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
	END

	---------------------------------------------------------------------------------------------------------
	-- Get Initial Data
	---------------------------------------------------------------------------------------------------------
	
	
	

	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = 'Outcome: Succeeded' + CHAR(13) + CHAR(10)
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectFileInfo]...DONE'
GO
/*- sp_CollectIOVFStats -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectIOVFStats]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server IO Virtual File Statistics Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@Retention SMALLINT = -32768,
@CollectingInterval SMALLINT = -32768,
@SampleInterval SMALLINT = NULL,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
    SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'See the default config info below.', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'See the default config info below.', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'See the default config info below.', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'See the default config info below.', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'See the default config info below.', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'See the default config info below.', N'Times in seconds between taking two samples. (1-3600)'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 4)
			ORDER BY [Config Info] DESC

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
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_dest_table BIT
DECLARE @i_dest_schema BIT
DECLARE @i_ts_mode BIT
DECLARE @i_empty_ts_table BIT
DECLARE @i_collecting_interval BIT
DECLARE @i_sample_interval BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	
	SELECT
		@i_dest_table = CASE @DestTable
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestTable = CASE @DestTable
			WHEN '-' THEN [dest_table]
			ELSE @DestTable
			END,
		@i_dest_schema = CASE @DestSchema
			WHEN '-' THEN 0
			ELSE 1
			END,
		@DestSchema = CASE @DestSchema
			WHEN '-' THEN [dest_schema]
			ELSE @DestSchema
			END,
		@i_ts_mode = CASE 
			WHEN @TSMode IS NULL THEN 0
			ELSE 1
			END, 
		@TSMode = ISNULL(@TSMode, [ts_mode]),
		@i_empty_ts_table = CASE 
			WHEN @EmptyTSTable IS NULL THEN 0
			ELSE 1
			END,
		@EmptyTSTable = ISNULL(@EmptyTSTable, [empty_ts_table]),
		@i_collecting_interval = CASE @CollectingInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@CollectingInterval = CASE @CollectingInterval
			WHEN -32768 THEN [collecting_interval]
			ELSE @CollectingInterval
			END,
		@i_sample_interval = CASE 
			WHEN @SampleInterval IS NULL THEN 0
			ELSE 1
			END,
		@SampleInterval = ISNULL(@SampleInterval, [sample_interval]),
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END,  
		@LogInfo = ISNULL(@LogInfo, [loginfo]) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@SampleInterval NOT BETWEEN 1 AND 3600 OR @SampleInterval IS NULL)
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
			SET @DestTable = N'ts_iovf_stats'
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_dest_table
		WHEN 0 THEN N''
		ELSE N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		END
		+ CASE @i_dest_schema
		WHEN 0 THEN N''
		ELSE N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		END
		+ CASE @i_ts_mode
		WHEN 0 THEN N''
		ELSE N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		END
		+ CASE @i_empty_ts_table
		WHEN 0 THEN N''
		ELSE N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		END
		+ CASE @i_collecting_interval
		WHEN 0 THEN N''
		ELSE N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		END
		+ CASE @i_sample_interval
		WHEN 0 THEN N''
		ELSE N', @SampleInterval = ' + CAST(@SampleInterval AS nvarchar)
		END
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		END
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
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
		[capture_date] DATETIME DEFAULT SYSDATETIME(),
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

	SET @start_loop = SYSDATETIME()

	WHILE(@loop_count < @max_loop)
	BEGIN
		SET @sample_interval = CONVERT(nvarchar, DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, SYSDATETIME()) AS INT), 0), 114)

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

		SET @start_loop = SYSDATETIME()
		
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
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@Retention AS nvarchar) + N', SYSDATETIME()) '
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectIOVFStats]...DONE'
GO
/*- sp_CollectPerfmonData -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectPerfmonData]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server Instance Related Performance Counters

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@CollectingInterval SMALLINT = -32768,
@SampleInterval SMALLINT = -32768,
@MeasuringInterval TINYINT = NULL,
@Retention SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help =1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'See the default config info below.', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'See the default config info below.', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'See the default config info below.', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'See the default config info below.', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'See the default config info below.', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'See the default config info below.', N'Times in seconds between taking two samples. (1-300)'
	
	UNION ALL
	SELECT N'@MeasuringInterval', N'See the default config info below.', N'Time in seconds between the 1st and 2nd measurement of the data sampling for measuring data during the collecting interval.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 5)
			ORDER BY [Config Info] DESC

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

DECLARE @start_loop DATETIME2
DECLARE @max_loop INT
DECLARE @loop_count INT

DECLARE @row_count INT
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_dest_table BIT
DECLARE @i_dest_schema BIT
DECLARE @i_ts_mode BIT
DECLARE @i_empty_ts_table BIT
DECLARE @i_collecting_interval BIT
DECLARE @i_sample_interval BIT
DECLARE @i_measuring_interval BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	SELECT
		@i_dest_table = CASE @DestTable
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestTable = CASE @DestTable
			WHEN '-' THEN [dest_table]
			ELSE @DestTable
			END,
		@i_dest_schema = CASE @DestSchema
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestSchema = CASE @DestSchema
			WHEN '-' THEN [dest_schema]
			ELSE @DestSchema
			END,
		@i_ts_mode = CASE 
			WHEN @TSMode IS NULL THEN 0
			ELSE 1
			END, 
		@TSMode = ISNULL(@TSMode, [ts_mode]),
		@i_empty_ts_table = CASE 
			WHEN @EmptyTSTable IS NULL THEN 0
			ELSE 1
			END,
		@EmptyTSTable = ISNULL(@EmptyTSTable, [empty_ts_table]),
		@i_collecting_interval = CASE @CollectingInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@CollectingInterval = CASE @CollectingInterval
			WHEN -32768 THEN [collecting_interval]
			ELSE @CollectingInterval
			END,
		@i_sample_interval = CASE @SampleInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@SampleInterval = CASE @SampleInterval
			WHEN -32768 THEN [sample_interval]
			ELSE @SampleInterval
			END,
		@i_measuring_interval = CASE 
			WHEN @MeasuringInterval IS NULL THEN 0
			ELSE 1
			END,
		@MeasuringInterval = ISNULL(@MeasuringInterval, [measuring_interval]),
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END,   
		@LogInfo = ISNULL(@LogInfo, [loginfo]) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
			+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
			+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@MeasuringInterval NOT BETWEEN 1 AND 60 OR @MeasuringInterval IS NULL)
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @MeasuringInterval is not supported.' 
		SET @Severity=16
		RAISERROR(@ErrorMessage, @Severity, 1) WITH NOWAIT
	END

	IF((@CollectingInterval IS NULL AND @SampleInterval NOT BETWEEN 1 AND 300) 
		OR (@CollectingInterval IS NOT NULL AND (@SampleInterval NOT BETWEEN 1 AND 300 OR @SampleInterval IS NULL)))
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @SampleInterval is not supported or it is incorrect.' 
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
		IF(@MeasuringInterval >= @SampleInterval AND @CollectingInterval IS NOT NULL)
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
			SET @DestTable = N'ts_perfmon_data'
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_dest_table
		WHEN 0 THEN N''
		ELSE N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		END
		+ CASE @i_dest_schema
		WHEN 0 THEN N''
		ELSE N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		END
		+ CASE @i_ts_mode
		WHEN 0 THEN N''
		ELSE N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		END
		+ CASE @i_empty_ts_table
		WHEN 0 THEN N''
		ELSE N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		END
		+ CASE @i_collecting_interval
		WHEN 0 THEN N''
		ELSE N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		END
		+ CASE @i_sample_interval
		WHEN 0 THEN N''
		ELSE N', @SampleInterval = ' + ISNULL(CAST(@SampleInterval AS nvarchar), N'NULL')
		END
		+ CASE @i_measuring_interval
		WHEN 0 THEN N''
		ELSE N', @MeasuringInterval = ' + CAST(@MeasuringInterval AS nvarchar)
		END
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		END
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		+ N', @SampleInterval = ' + ISNULL(CAST(@SampleInterval AS nvarchar), N'NULL')
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
			 [cntr_type], [cntr_value], SYSDATETIME() 
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
			 [SecondDateTime] = SYSDATETIME() 
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
		[FirstDateTime] DATETIME2, 
		[SecondValue] DECIMAL(38, 2), 
		[SecondDateTime] DATETIME2, 
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
		SET @start_loop = SYSDATETIME()
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
			SET @InfoMessage = N'SecondMeasurement~' + CONVERT(nvarchar, SYSDATETIME(),21) + N' /'+ CONVERT(nvarchar, DATEADD(ms, CAST(DATEDIFF(ms,@start_loop,SYSDATETIME()) AS INT), 0), 114) + N'/' 
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

		-- <> 0 because we increase the @loop_count just right before
		IF  (@max_loop - @loop_count) <> 0
		BEGIN
			SET @sample_interval = CONVERT(nvarchar, ISNULL(DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, SYSDATETIME()) AS INT), 0), N'00:00:00'), 114)

			IF(@debug > 0)
			BEGIN
				SET @InfoMessage = N'Sample interval (inside the loop): ' + @sample_interval + N' | Current loop: ' + CAST(@loop_count AS nvarchar)
				SET @Severity = 10
				RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
			END

			WAITFOR DELAY @sample_interval;
		END
	END

	DROP TABLE #temp_perfcounters
	
	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@Retention AS nvarchar) + N', SYSDATETIME()) '
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectPerfmonData]...DONE'
GO
/*- sp_CollectTempDBUsage -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectTempDBUsage]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collecting SQL Server TempDB usage raw data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@Retention SMALLINT = -32768,
@CollectingInterval SMALLINT = -32768,
@SampleInterval SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN

SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'
	
	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'See the default config info below.', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'See the default config info below.', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'See the default config info below.', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'See the default config info below.', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@CollectingInterval', N'See the default config info below.', N'Duration of the data collection in minutes. Maximum 1440 (1 day), so value has to be between 1 and 1440. It can be NULL. In that case the collector only takes one sample, the actual state of the data collected by the collector.'

	UNION ALL
	SELECT N'@SampleInterval', N'See the default config info below.', N'Times in seconds between taking two samples.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 4)
			ORDER BY [Config Info] DESC

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

DECLARE @start_loop DATETIME2
DECLARE @max_loop INT
DECLARE @loop_count INT
DECLARE @sample_interval NVARCHAR(12)
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_dest_table BIT
DECLARE @i_dest_schema BIT
DECLARE @i_ts_mode BIT
DECLARE @i_empty_ts_table BIT
DECLARE @i_collecting_interval BIT
DECLARE @i_sample_interval BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	SELECT
		@i_dest_table = CASE @DestTable
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestTable = CASE @DestTable
			WHEN '-' THEN [dest_table]
			ELSE @DestTable
			END,
		@i_dest_schema = CASE @DestSchema
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestSchema = CASE @DestSchema
			WHEN '-' THEN [dest_schema]
			ELSE @DestSchema
			END,
		@i_ts_mode = CASE 
			WHEN @TSMode IS NULL THEN 0
			ELSE 1
			END, 
		@TSMode = ISNULL(@TSMode, [ts_mode]),
		@i_empty_ts_table = CASE 
			WHEN @EmptyTSTable IS NULL THEN 0
			ELSE 1
			END,
		@EmptyTSTable = ISNULL(@EmptyTSTable, [empty_ts_table]),
		@i_collecting_interval = CASE @CollectingInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@CollectingInterval = CASE @CollectingInterval
			WHEN -32768 THEN [collecting_interval]
			ELSE @CollectingInterval
			END,
		@i_sample_interval = CASE @SampleInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@SampleInterval = CASE @SampleInterval
			WHEN -32768 THEN [sample_interval]
			ELSE @SampleInterval
			END,
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END,
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END, 
		@LogInfo = ISNULL(@LogInfo, [loginfo]) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
		SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		+ N'Server: ' + CAST(SERVERPROPERTY('ServerName') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Version: ' + CAST(SERVERPROPERTY('ProductVersion') AS nvarchar) + CHAR(13) + CHAR(10)
		+ N'Edition: ' + CAST(SERVERPROPERTY('Edition') AS nvarchar)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END

	---------------------------------------------------------------------------------------------------------------------------------------
	-- Check input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF((@CollectingInterval IS NULL AND @SampleInterval NOT BETWEEN 1 AND 3600) 
		OR (@CollectingInterval IS NOT NULL AND (@SampleInterval NOT BETWEEN 1 AND 3600 OR @SampleInterval IS NULL)))
	BEGIN
		SET @ErrorMessage = 'The value for the parameter @SampleInterval is not supported or it is incorrect.'  
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
			SET @DestTable = N'ts_tempdb_usage'
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_dest_table
		WHEN 0 THEN N''
		ELSE N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		END
		+ CASE @i_dest_schema
		WHEN 0 THEN N''
		ELSE N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		END
		+ CASE @i_ts_mode
		WHEN 0 THEN N''
		ELSE N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		END
		+ CASE @i_empty_ts_table
		WHEN 0 THEN N''
		ELSE N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		END
		+ CASE @i_collecting_interval
		WHEN 0 THEN N''
		ELSE N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		END
		+ CASE @i_sample_interval
		WHEN 0 THEN N''
		ELSE N', @SampleInterval = ' + ISNULL(CAST(@SampleInterval AS nvarchar), N'NULL')
		END
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = ' + CAST(@LogInfo AS nvarchar) 
		END
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		+ N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		+ N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		+ N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		+ N', @CollectingInterval  = ' + ISNULL(CAST(@CollectingInterval AS nvarchar), N'NULL')
		+ N', @SampleInterval = ' + ISNULL(CAST(@SampleInterval AS nvarchar), N'NULL')
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
			 SELECT SYSDATETIME() AS [capture_date], [tfsu].[file_id], LEFT([mf].[physical_name],1) AS [drive], [unallocated_extent_page_count], [version_store_reserved_page_count], [user_object_reserved_page_count], [internal_object_reserved_page_count], [mixed_extent_page_count] 
			 FROM tempdb.sys.dm_db_file_space_usage AS [tfsu] INNER JOIN sys.master_files AS [mf] 
			 ON [tfsu].[file_id]=[mf].[file_id] AND [tfsu].[database_id] = [mf].[database_id] '
	
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
		SET @start_loop = SYSDATETIME()
		
		EXEC sp_executesql @CollectSQLCommand

		SET @loop_count = @loop_count + 1

		-- <> 0 because we increase the @loop_count just right before
		IF (@max_loop - @loop_count) <> 0
		BEGIN
			SET @sample_interval = CONVERT(nvarchar, ISNULL(DATEADD(ms, @SampleInterval*1000-CAST(DATEDIFF(ms,@start_loop, SYSDATETIME()) AS INT), 0), N'00:00:00'), 114)

			IF(@debug > 0)
			BEGIN
				SET @InfoMessage = N'Sample interval (inside the loop): ' + @sample_interval + N' | Current loop: ' + CAST(@loop_count AS nvarchar)
				SET @Severity = 10
				RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
			END

			WAITFOR DELAY @sample_interval;
		END
	END

	---------------------------------------------------------------------------------------------------------
	-- Delete expired data
	---------------------------------------------------------------------------------------------------------
	IF(@Retention > 0)
	BEGIN
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@Retention AS nvarchar) + N', SYSDATETIME()) '
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectTempDBUsage]...DONE'
GO
/*- sp_CollectWaitStats -----------------------------------------------------------------
-------------------------------------------------------------------------------------------*/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating collector [dbo].[sp_CollectWaitStats]...'
GO
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
@LogInfo = 1,
@CustomConfig = NULL

Version: V2 - 2015.08

Tested: SQL Server 2008 / 2008 R2 / 2012 / 2014 

Summary:
Collect SQL Server Wait Statistics Raw Data

License: Copyright (c) 2014 Robert Virag | SQLApprentice.net

The solution is free: http://www.sqlapprentice.net/license/

*********************************************************************************************/

@DestTable NVARCHAR(128) = '-',
@DestSchema NVARCHAR(25) = '-',
@MeasuringInterval SMALLINT = -32768,
@ResetWaitStats BIT = NULL,
@TSMode BIT = NULL,
@EmptyTSTable BIT = NULL,
@Retention SMALLINT = -32768,
@debug TINYINT = 0,
@help BIT = 0,
@LogInfo BIT = NULL,
@CustomConfig NVARCHAR(35) = NULL

AS
BEGIN
SET NOCOUNT ON

IF(@help = 1)
BEGIN
	SELECT (SELECT QUOTENAME(schemas.name) FROM sys.schemas schemas INNER JOIN sys.objects objects ON schemas.[schema_id] = objects.[schema_id] WHERE [object_id] = @@PROCID) + N'.' + QUOTENAME(OBJECT_NAME(@@PROCID)) AS [Collector]
	
	;WITH help_info AS (
	SELECT N'@help' AS [Parameter Name],
		   N'See the default config info below.' AS [Default Value],
           N'Display help message.' AS [Parameter Description]

    UNION ALL
	SELECT N'@LogInfo', N'See the default config info below.', N'Generate Log Information'

	UNION ALL
	SELECT N'@Retention', N'See the default config info below.', N'Specify the time, in days, after which the data collected are deleted. If no time is specified, then no data are deleted.'
	
	UNION ALL
	SELECT N'@DestTable', N'See the default config info below.', N'In troubleshooting mode it specifies the output table. Table must exist. Can be NULL.'

	UNION ALL
	SELECT N'@DestSchema', N'See the default config info below.', N'In troubleshooting mode it specifies the schema of the output table. Schema must exist. Can be NULL.'

	UNION ALL
	SELECT N'@TSMode', N'See the default config info below.', N'Enable troubleshooting mode'

	UNION ALL
	SELECT N'@EmptyTSTable', N'See the default config info below.', N'Empty the table used for troubleshooting before the data collection.'

	UNION ALL
	SELECT N'@MeasuringInterval', N'See the default config info below.', N'Time in minutes between the 1st and 2nd measurement of the data sampling for measuring data.'

	UNION ALL
	SELECT N'@ResetWaitStats', N'See the default config info below.', N'Clear the sys.dm_os_wait_stats after the data collection.'
	) SELECT [p].[name] AS [Parameter Name], 
		UPPER([t].[name]) AS [Data Type],
		[h].[Default Value],
		[h].[Parameter Description] 
		FROM sys.parameters AS [p]
			JOIN sys.types AS [t] ON [p].[system_type_id] = [t].[system_type_id]
			JOIN help_info AS [h] ON [h].[Parameter Name] = [p].[name]
				WHERE [object_id] = @@PROCID
				ORDER BY [Parameter Name]

	SELECT CASE 
		WHEN [config_name] = OBJECT_NAME(@@PROCID) THEN 'Default Config'
		ELSE 'Compatible Config'
		END AS [Config Info],* FROM [dbo].[bcs_config]
			WHERE [config_type] IN (0, 6)
			ORDER BY [Config Info] DESC

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
DECLARE @config_name NVARCHAR(35)

DECLARE @i_retention BIT
DECLARE @i_loginfo BIT
DECLARE @i_dest_table BIT
DECLARE @i_dest_schema BIT
DECLARE @i_ts_mode BIT
DECLARE @i_empty_ts_table BIT
DECLARE @i_measuring_interval BIT
DECLARE @i_reset_wait_stats BIT

BEGIN TRY
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Set input parameters
	---------------------------------------------------------------------------------------------------------------------------------------
	IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
	BEGIN
		SET @config_name = @CustomConfig
	END
	ELSE
	BEGIN
		SET @config_name = OBJECT_NAME(@@PROCID)
	END

	SELECT 
		@i_dest_table = CASE @DestTable
			WHEN '-' THEN 0
			ELSE 1
			END, 
		@DestTable = case @DestTable
			WHEN '-' THEN dest_table
			ELSE @DestTable
			END,
		@i_dest_schema = CASE @DestSchema
			WHEN '-' THEN 0
			ELSE 1
			END,  
		@DestSchema = case @DestSchema
			WHEN '-' THEN dest_schema
			ELSE @DestSchema
			END,
		@i_ts_mode = CASE 
			WHEN @TSMode IS NULL THEN 0
			ELSE 1
			END, 
		@TSMode = ISNULL(@TSMode, ts_mode),
		@i_empty_ts_table = CASE 
			WHEN @EmptyTSTable IS NULL THEN 0
			ELSE 1
			END,
		@EmptyTSTable = ISNULL(@EmptyTSTable, empty_ts_table),
		@i_reset_wait_stats = CASE 
			WHEN @ResetWaitStats IS NULL THEN 0
			ELSE 1
			END,
		@ResetWaitStats = ISNULL(@ResetWaitStats, reset_wait_stats),
		@i_measuring_interval = CASE @MeasuringInterval
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@MeasuringInterval = CASE @MeasuringInterval
			WHEN -32768 THEN measuring_interval
			ELSE @MeasuringInterval
			END,
		@i_retention = CASE @Retention
			WHEN -32768 THEN 0
			ELSE 1
			END,
		@Retention = CASE @Retention
			WHEN -32768 THEN [retention]
			ELSE @Retention
			END, 
		@i_loginfo = CASE 
			WHEN @LogInfo IS NULL THEN 0
			ELSE 1
			END, 
		@LogInfo = ISNULL(@LogInfo, loginfo) 
			FROM [dbo].[bcs_config] WITH (NOLOCK)
			WHERE [config_name] = @config_name
	
	---------------------------------------------------------------------------------------------------------------------------------------
	-- Log Info - Start
	---------------------------------------------------------------------------------------------------------------------------------------
	IF(@LogInfo = 1)
	BEGIN
	SET @InfoMessage = N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
			SET @DestTable = N'ts_wait_stats'
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
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ CASE @i_dest_table
		WHEN 0 THEN N''
		ELSE N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
		END
		+ CASE @i_dest_schema
		WHEN 0 THEN N''
		ELSE N', @DestSchema  = ' + ISNULL(N''''+@DestSchema+N'''', N'NULL')
		END
		+ CASE @i_ts_mode
		WHEN 0 THEN N''
		ELSE N', @TSMode = ' + CAST(@TSMode AS nvarchar)
		END
		+ CASE @i_empty_ts_table
		WHEN 0 THEN N''
		ELSE N', @EmptyTSTable = ' + CAST(@EmptyTSTable AS nvarchar)
		END
		+ CASE @i_measuring_interval
		WHEN 0 THEN N''
		ELSE N', @MeasuringInterval = ' + ISNULL(CAST(@MeasuringInterval as nvarchar), N'NULL')
		END
		+ CASE @i_reset_wait_stats
		WHEN 0 THEN N''
		ELSE N', @ResetWaitStats  = ' + CAST(@ResetWaitStats AS nvarchar)
		END
		+ CASE @i_retention
		WHEN 0 THEN N''
		ELSE N', @Retention = ' + ISNULL(CAST(@Retention AS nvarchar), N'NULL')
		END
		+ CASE @i_loginfo
		WHEN 0 THEN N''
		ELSE N', @LogInfo = ' + CAST(@LogInfo AS nvarchar)
		END
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		/*
		IF @CustomConfig IS NOT NULL AND EXISTS (SELECT 1 FROM [dbo].[bcs_config] WITH (NOLOCK) WHERE [config_name] = @CustomConfig)
		BEGIN
			SET @InfoMessage = N'Custom configuration is used: ' + @CustomConfig
			RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
		END
		*/
		SET @InfoMessage = N'Parameters: '
		+ N' @CustomConfig = ' + ISNULL(N''''+@config_name+N'''', N'NULL')
		+ N', @DestTable = ' + ISNULL(N''''+@DestTable+N'''', N'NULL')
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

	IF(@TSMode = 1)
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
				 SELECT SYSDATETIME(), [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
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
		SELECT SYSDATETIME() AS [first_measurement], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
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
		SELECT SYSDATETIME() AS [second_measurement], [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
			INTO #temp_stats2 FROM sys.dm_os_wait_stats
		
		----------------------------------------------------------------------
		-- Count and store the differences of the 1st and the 2nd measurement 
		----------------------------------------------------------------------
		IF @@VERSION LIKE N'%Microsoft SQL Server 2005%' AND
		( (@TSMode = 0 AND (SELECT [is_excluded] FROM [dbo].[filter_wait_types] WHERE [wait_type] = 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP') = 1) OR
		(@TSMode = 1 AND (SELECT [ts_is_excluded] FROM [dbo].[filter_wait_types] WHERE [wait_type] = 'SQLTRACE_INCREMENTAL_FLUSH_SLEEP') = 1) )
		BEGIN
			SET @AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP = N' UNION
				 SELECT SYSDATETIME(), ''AI_SQLTRACE_INCREMENTAL_FLUSH_SLEEP'' AS [wait_type], 
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
				 SELECT SYSDATETIME(), [wait_type], [waiting_tasks_count], [wait_time_ms], [max_wait_time_ms], [signal_wait_time_ms] 
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
		SET @SQLCommand = N'DELETE FROM ' + QUOTENAME(@DestSchema)+N'.'+QUOTENAME(@DestTable) + ' WHERE [capture_date] < DATEADD(dd, -1*' + CAST(@Retention AS nvarchar) + N', SYSDATETIME()) '
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
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
		+ N'Date and time: ' + CONVERT(nvarchar,SYSDATETIME(),120) + CHAR(13) + CHAR(10)
		SET @Severity = 10
		RAISERROR(@InfoMessage, @Severity, 1) WITH NOWAIT
	END
END CATCH
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' ...[dbo].[sp_CollectWaitStats]...DONE'
GO
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' END: CREATE COLLECTORS'
GO
/******************************************************************************
****************************** CREATE COLLECTORS ******************************
**************************************END*************************************/

/************************************START*************************************
********************************* CREATE JOBS *********************************
******************************************************************************/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' START: CREATE JOBS'
GO
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
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' SQL Server Instance (' + @@SERVERNAME + ') edition is appropriate for creating jobs...'
	 
	DECLARE @JobCategory nvarchar(max)
	SET @JobCategory = N'Baseline Collector'

	IF NOT EXISTS (SELECT * FROM [msdb].[dbo].[syscategories] WHERE [category_class] = 1 AND [category_type] = 1 AND [name] = @JobCategory)
	BEGIN
		EXEC [msdb].[dbo].sp_add_category @class = N'JOB', @type = 'LOCAL', @name = @JobCategory
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Job category ''Baseline Collector'' is created...DONE'
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

	DECLARE @JobName nvarchar(max)
	DECLARE @JobName01Step1Command nvarchar(max)
	DECLARE @JobName01Step2Command nvarchar(max)
	DECLARE @JobName01Step3Command nvarchar(max)
	DECLARE @JobName01Step4Command nvarchar(max)
	DECLARE @JobName01Step5Command nvarchar(max)
	DECLARE @JobCheckStepCommand nvarchar(max)

	DECLARE @JobCommand nvarchar(max)

	DECLARE @OutputFile nvarchar(max)

	SET @Version = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1) + '.' + REPLACE(RIGHT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)), LEN(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))),'.','') AS numeric(18,10))

	IF @Version >= 9.002047
	BEGIN
	SET @TokenServer = N'$' + N'(ESCAPE_SQUOTE(SRVR))'
	SET @TokenJobID = N'$' + N'(ESCAPE_SQUOTE(JOBID))'
	SET @TokenStepID = N'$' + N'(ESCAPE_SQUOTE(STEPID))'
	SET @TokenDate = N'$' + N'(ESCAPE_SQUOTE(STRTDT))'
	SET @TokenTime = N'$' + N'(ESCAPE_SQUOTE(STRTTM))'
	END
	
	IF @Version >= 12
	BEGIN
	SET @TokenLogDirectory = N'$' + N'(ESCAPE_SQUOTE(SQLLOGDIR))'
	END

	SET @JobDescription = N'Source: http://sqlapprentice.net'

	SET @JobOwner = SUSER_SNAME(0x01)
	
	SET @JobName = N'Baseline - Collect InstanceInfo/ConfigData/DatabaseInfo/FileInfo/WaitStats'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule=1
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ' +@JobName + N' is deleted.'
	END
	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @CreateJobs = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating job ' +@JobName+ N'...'
		SET @JobName01Step1Command = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectInstanceInfo]" -b'
		SET @JobName01Step2Command = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectConfigData] @BypassNonActiveSrvConfError = 1" -b'
		SET @JobName01Step3Command = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectDatabaseInfo]" -b'
		SET @JobName01Step4Command = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectFileInfo]" -b'
		SET @JobName01Step5Command = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectWaitStats] @ResetWaitStats = 1" -b' 
		SET @JobCheckStepCommand = N'SELECT step_name, message FROM msdb.dbo.sysjobhistory
						WHERE instance_id > COALESCE((SELECT MAX(instance_id) FROM msdb.dbo.sysjobhistory
												        WHERE job_id = ' + @TokenJobID + N' AND step_id = 0), 0)
						AND job_id = ' + @TokenJobID + N'
						AND run_status <> 1 -- success

					IF @@ROWCOUNT <> 0 RAISERROR(''Failed step(s)'', 16, 1)'
		
		SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + N'BCS_II_CD_DI_FI_WS_Log_' + @TokenJobID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + @TokenJobID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = NULL

		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Configuring job ' +@JobName+ N'...'
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner, @enabled=0
		EXECUTE msdb.dbo.sp_add_jobstep @step_id=1, @job_name = @JobName, @step_name = N'Collect InstanceInfo', @subsystem = N'CMDEXEC', @command = @JobName01Step1Command, @output_file_name = @OutputFile, @flags=2, @on_success_action=3, @on_fail_action=3
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (Collect InstanceInfo)...DONE'

		EXECUTE msdb.dbo.sp_add_jobstep @step_id=2, @job_name = @JobName, @step_name = N'Collect ConfigData', @subsystem = N'CMDEXEC', @command = @JobName01Step2Command, @output_file_name = @OutputFile, @flags=2, @on_success_action=3, @on_fail_action=3
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (Collect ConfigData)...DONE'

		EXECUTE msdb.dbo.sp_add_jobstep @step_id=3, @job_name = @JobName, @step_name = N'Collect DatabaseInfo', @subsystem = N'CMDEXEC', @command = @JobName01Step3Command, @output_file_name = @OutputFile, @flags=2, @on_success_action=3, @on_fail_action=3
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (Collect DatabaseInfo)...DONE'

		EXECUTE msdb.dbo.sp_add_jobstep @step_id=4, @job_name = @JobName, @step_name = N'Collect FileInfo', @subsystem = N'CMDEXEC', @command = @JobName01Step4Command, @output_file_name = @OutputFile, @flags=2, @on_success_action=3, @on_fail_action=3
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (Collect FileInfo)...DONE'

		EXECUTE msdb.dbo.sp_add_jobstep @step_id=5, @job_name = @JobName, @step_name = N'Collect WaitStats', @subsystem = N'CMDEXEC', @command = @JobName01Step5Command, @output_file_name = @OutputFile, @flags=2, @on_success_action=3, @on_fail_action=3
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (Collect WaitStats)...DONE'

		EXECUTE msdb.dbo.sp_add_jobstep @step_id=6, @job_name = @JobName, @step_name = N'JobCheck', @subsystem = N'TSQL', @database_name=N'msdb',	@command = @JobCheckStepCommand
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job step (JobCheck)...DONE'

		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' ...' + @JobName + N'...DONE'
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @JobName + N''' is skipped...DONE'
	END

	SET @JobName = N'Baseline - CollectIOVFStats'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule=1
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ' +@JobName + N' is deleted.'
	END
	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @CreateJobs = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job ' +@JobName + N'...'
		SET @JobCommand = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectIOVFStats] @CollectingInterval = 180" -b'
		SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + N'BCS_IOVFStats_Log_' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = NULL

		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Configuring job ' + @JobName + N'...'
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner, @enabled=0
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName, @step_name = @JobName, @subsystem = N'CMDEXEC', @command = @JobCommand, @output_file_name = @OutputFile, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' ...' + @JobName + N'...DONE'
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ''' + @JobName + N''' is skipped...DONE'
	END

	SET @JobName = N'Baseline - CollectPerfmonData'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule=1
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ' +@JobName + N' is deleted.'	
	END
	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @CreateJobs = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job ' + @JobName + N'...'
		SET @JobCommand = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectPerfmonData] @CollectingInterval = 60" -b'
		SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + N'BCS_PerfmonData_Log_' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = NULL

		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Configuring job ' +@JobName+ N'...'
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner, @enabled=0
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName, @step_name = @JobName, @subsystem = N'CMDEXEC', @command = @JobCommand, @output_file_name = @OutputFile, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' ...' + @JobName + N'...DONE'
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ''' + @JobName + N''' is skipped...DONE'
	END

	SET @JobName = N'Baseline - CollectTempDBUsage'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule=1
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ' +@JobName + N' is deleted.'
	END
	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @CreateJobs = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job ' + @JobName + N'...'
		SET @JobCommand = N'sqlcmd -E -S ' + @TokenServer + N' -d ' + DB_NAME() + N' -Q "EXECUTE [dbo].[sp_CollectTempDBUsage] @CollectingInterval = 60" -b'
		SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + N'BCS_TempDBUsage_Log_' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = NULL

		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Configuring job ' +@JobName + N'...'
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner, @enabled=0
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName, @step_name = @JobName, @subsystem = N'CMDEXEC', @command = @JobCommand, @output_file_name = @OutputFile, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' ...' + @JobName + N'...DONE'
	END	
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ''' + @JobName + N''' is skipped...DONE'
	END
	
	SET @JobName = N'Baseline - Output File Cleanup'
	IF EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @drop_jobs_if_exist = 1
	BEGIN
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName, @delete_unused_schedule=1
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ' +@JobName + N' is deleted.'
	END
	IF NOT EXISTS (SELECT * FROM msdb.dbo.sysjobs WHERE [name] = @JobName) AND @CreateJobs = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Creating job ' + @JobName + N'...'
		IF @OutputFileDirectory IS NULL
		BEGIN
			SET @JobCommand = N'REM Cleanup command is commented out.' + CHAR(13) + CHAR(10)
			+ N'REM @OutputFileDirectory is not specified. No outputfiles are generated by the jobs.' + CHAR(13) + CHAR(10) 
			+ N'REM cmd /q /c "For /F "tokens=1 delims=" %v In (''ForFiles /P "<DRIVE>:\OUTPUT_DIRECTORY" /m BCS_*.txt /d -365 2^>^&1'') do if EXIST "<DRIVE>:\OUTPUT_DIRECTORY"\%v echo del "<DRIVE>:\OUTPUT_DIRECTORY"\%v& del "<DRIVE>:\OUTPUT_DIRECTORY"\%v"'
		END
		ELSE
		BEGIN
			SET @JobCommand = N'cmd /q /c "For /F "tokens=1 delims=" %v In (''ForFiles /P "' + COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'" /m BCS_*.txt /d -365 2^>^&1'') do if EXIST "' + COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'"\%v echo del "' + COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'"\%v& del "' + COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'"\%v"'
		END
		
		SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + N'BCSOutputFileCleanup_' + @TokenJobID + N'_' + @TokenStepID + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = COALESCE(@OutputFileDirectory,@TokenLogDirectory) + N'\' + @TokenJobID + N'_' + @TokenStepID + N'_' + @TokenDate + N'.txt'
		IF LEN(@OutputFile) > 200 SET @OutputFile = NULL

		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Configuring job ' +@JobName + N'...'
		EXECUTE msdb.dbo.sp_add_job @job_name = @JobName, @description = @JobDescription, @category_name = @JobCategory, @owner_login_name = @JobOwner, @enabled=0
		EXECUTE msdb.dbo.sp_add_jobstep @job_name = @JobName, @step_name = @JobName, @subsystem = N'CMDEXEC', @command = @JobCommand, @output_file_name = @OutputFile, @flags=2 
		EXECUTE msdb.dbo.sp_add_jobserver @job_name = @JobName
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' ...'+ @JobName + N'...DONE'
	END	
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114) + N' Job ''' + @JobName + N''' is skipped...DONE'
	END
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' SQL Server Instance (' + @@SERVERNAME + ') edition does not support jobs...'
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating jobs is skipped...DONE.'
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' END: CREATE JOBS'
/******************************************************************************
********************************* CREATE JOBS *********************************
**************************************END*************************************/

/************************************START************************************
****************************** CREATE SCHEDULES ******************************
******************************************************************************/
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' START: CREATE SCHEDULES'

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
	
	/***********************************************************************************************************
	*--------------------- baseline - daily -------------------------------------------------------------------*
	***********************************************************************************************************/
	/*******************************
	* baseline - daily - at 2359PM *
	*******************************/
	SET @schedule_name = N'baseline - daily - at 2359PM'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=235900, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************
	* baseline - daily - at 2355PM *
	*******************************/
	SET @schedule_name = N'baseline - daily - at 2355PM'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=235500, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************
	* baseline - daily - at 2351PM *
	*******************************/
	SET @schedule_name = N'baseline - daily - at 2351PM'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=235100, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***********************************
	* baseline - daily - every 30 mins *
	***********************************/
	SET @schedule_name = N'baseline - daily - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*************************************************
	* baseline - daily - every 30 mins - BT/6AM-7PM/ *
	*************************************************/
	SET @schedule_name = N'baseline - daily - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**********************************
	* baseline - daily - every 1 hour *
	**********************************/
	SET @schedule_name = N'baseline - daily - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/************************************************
	* baseline - daily - every 1 hour - BT/6AM-7PM/ *
	************************************************/
	SET @schedule_name = N'baseline - daily - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***********************************************************************
	* baseline - daily - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	***********************************************************************/
	SET @schedule_name = N'baseline - daily - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************
	* baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/ *
	*******************************************************/
	SET @schedule_name = N'baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************
	* baseline - daily - every 8 hours /6AM/2PM/10PM/ *
	**************************************************/
	SET @schedule_name = N'baseline - daily - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************
	* baseline - daily - evey 12 hours /6AM/6PM/ *
	*********************************************/
	SET @schedule_name = N'baseline - daily - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/***********************************************************************************************************
	*--------------------- baseline - weekday -----------------------------------------------------------------*
	***********************************************************************************************************/
	/*************************************
	* baseline - weekday - every 30 mins *
	*************************************/
	SET @schedule_name = N'baseline - weekday - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************
	* baseline - weekday - every 30 mins - BT/6AM-7PM/ *
	***************************************************/
	SET @schedule_name = N'baseline - weekday - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/************************************
	* baseline - weekday - every 1 hour *
	************************************/
	SET @schedule_name = N'baseline - weekday - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************
	* baseline - weekday - every 1 hour - BT/6AM-7PM/ *
	**************************************************/
	SET @schedule_name = N'baseline - weekday - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*************************************************************************
	* baseline - weekday - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	*************************************************************************/
	SET @schedule_name = N'baseline - weekday - evey 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************
	* baseline - weekday - every 6 hours /6AM/12PM/6PM/12AM/ *
	*********************************************************/
	SET @schedule_name = N'baseline - weekday - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************
	* baseline - weekday - every 8 hours /6AM/2PM/10PM/ *
	****************************************************/
	SET @schedule_name = N'baseline - weekday - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***********************************************
	* baseline - weekday - evey 12 hours /6AM/6PM/ *
	***********************************************/
	SET @schedule_name = N'baseline - weekday - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/***********************************************************************************************************
	*--------------------- baseline - weekend -----------------------------------------------------------------*
	***********************************************************************************************************/
	/*************************************
	* baseline - weekend - every 30 mins *
	*************************************/
	SET @schedule_name = N'baseline - weekend - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************
	* baseline - weekend - every 30 mins - BT/6AM-7PM/ *
	***************************************************/
	SET @schedule_name = N'baseline - weekend - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/************************************
	* baseline - weekend - every 1 hour *
	************************************/
	SET @schedule_name = N'baseline - weekend - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************
	* baseline - weekend - every 1 hour - BT/6AM-7PM/ *
	**************************************************/
	SET @schedule_name = N'baseline - weekend - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*************************************************************************
	* baseline - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	*************************************************************************/
	SET @schedule_name = N'baseline - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************
	* baseline - weekend - every 6 hours /6AM/12PM/6PM/12AM/ *
	*********************************************************/
	SET @schedule_name = N'baseline - weekend - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************
	* baseline - weekend - every 8 hours /6AM/2PM/10PM/ *
	****************************************************/
	SET @schedule_name = N'baseline - weekend - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***********************************************
	* baseline - weekend - evey 12 hours /6AM/6PM/ *
	***********************************************/
	SET @schedule_name = N'baseline - weekend - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
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
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/***********************************************************************************************************
	*--------------------- baseline - every 4 weeks - 1week ---------------------------------------------------*
	***********************************************************************************************************/
	/***************************************************
	* baseline - every 4 weeks - 1week - every 30 mins *
	***************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************
	* baseline - every 4 weeks - 1week - every 30 mins - BT/6AM-7PM/ *
	*****************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************
	* baseline - every 4 weeks - 1week - every 1 hour *
	**************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************
	* baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/ *
	****************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************************************************
	* baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	***************************************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***********************************************************************
	* baseline - every 4 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/ *
	***********************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************
	* baseline - every 4 weeks - 1week - every 8 hours /6AM/2PM/10PM/ *
	******************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*************************************************************
	* baseline - every 4 weeks - 1week - evey 12 hours /6AM/6PM/ *
	*************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - 1week - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/***********************************************************************************************************
	*--------------------- baseline - every 4 weeks - weekdays ------------------------------------------------*
	***********************************************************************************************************/
	/******************************************************
	* baseline - every 4 weeks - weekdays - every 30 mins *
	******************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 4 weeks - weekdays - every 30 mins - BT/6AM-7PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************
	* baseline - every 4 weeks - weekdays - every 1 hour *
	*****************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 4 weeks - weekdays - every 1 hour - BT/6AM-7PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************************************
	* baseline - every 4 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	******************************************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************************************
	* baseline - every 4 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/ *
	**************************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************************
	* baseline - every 4 weeks - weekdays - every 8 hours /6AM/2PM/10PM/ *
	*********************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************
	* baseline - every 4 weeks - weekdays - evey 12 hours /6AM/6PM/ *
	****************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekdays - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/***********************************************************************************************************
	*--------------------- baseline - every 4 weeks - weekend -------------------------------------------------*
	***********************************************************************************************************/
	/*****************************************************
	* baseline - every 4 weeks - weekend - every 30 mins *
	*****************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 4 weeks - weekend - every 30 mins - BT/6AM-7PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************
	* baseline - every 4 weeks - weekend - every 1 hour *
	****************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************
	* baseline - every 4 weeks - weekend - every 1 hour - BT/6AM-7PM/ *
	******************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************************************
	* baseline - every 4 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	*****************************************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*************************************************************************
	* baseline - every 4 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/ *
	*************************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 4 weeks - weekend - every 8 hours /6AM/2PM/10PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************************
	* baseline - every 4 weeks - weekend - evey 12 hours /6AM/6PM/ *
	***************************************************************/
	SET @schedule_name = N'baseline - every 4 weeks - weekend - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=4, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/************************************************************************************************************
	*--------------------- baseline - every 12 weeks - 1week ---------------------------------------------------*
	************************************************************************************************************/
	/****************************************************
	* baseline - every 12 weeks - 1week - every 30 mins *
	****************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************
	* baseline - every 12 weeks - 1week - every 30 mins - BT/6AM-7PM/ *
	******************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************
	* baseline - every 12 weeks - 1week - every 1 hour *
	***************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************
	* baseline - every 12 weeks - 1week - every 1 hour - BT/6AM-7PM/ *
	*****************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************************************
	* baseline - every 12 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	****************************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/************************************************************************
	* baseline - every 12 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/ *
	************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 12 weeks - 1week - every 8 hours /6AM/2PM/10PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************************
	* baseline - every 12 weeks - 1week - evey 12 hours /6AM/6PM/ *
	**************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - 1week - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/************************************************************************************************************
	*--------------------- baseline - every 12 weeks - weekdays ------------------------------------------------*
	************************************************************************************************************/
	/*******************************************************
	* baseline - every 12 weeks - weekdays - every 30 mins *
	*******************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************************
	* baseline - every 12 weeks - weekdays - every 30 mins - BT/6AM-7PM/ *
	*********************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************
	* baseline - every 12 weeks - weekdays - every 1 hour *
	******************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 12 weeks - weekdays - every 1 hour - BT/6AM-7PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************************************
	* baseline - every 12 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	*******************************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************************************
	* baseline - every 12 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/ *
	***************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**********************************************************************
	* baseline - every 12 weeks - weekdays - every 8 hours /6AM/2PM/10PM/ *
	**********************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************
	* baseline - every 12 weeks - weekdays - evey 12 hours /6AM/6PM/ *
	*****************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekdays - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/************************************************************************************************************
	*--------------------- baseline - every 12 weeks - weekend -------------------------------------------------*
	************************************************************************************************************/
	/******************************************************
	* baseline - every 12 weeks - weekend - every 30 mins *
	******************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 12 weeks - weekend - every 30 mins - BT/6AM-7PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************
	* baseline - every 12 weeks - weekend - every 1 hour *
	*****************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 12 weeks - weekend - every 1 hour - BT/6AM-7PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************************************
	* baseline - every 12 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	******************************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************************************
	* baseline - every 12 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/ *
	**************************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************************
	* baseline - every 12 weeks - weekend - every 8 hours /6AM/2PM/10PM/ *
	*********************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************
	* baseline - every 12 weeks - weekend - evey 12 hours /6AM/6PM/ *
	****************************************************************/
	SET @schedule_name = N'baseline - every 12 weeks - weekend - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=12, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/************************************************************************************************************
	*--------------------- baseline - every 24 weeks - 1week ---------------------------------------------------*
	************************************************************************************************************/
	/****************************************************
	* baseline - every 24 weeks - 1week - every 30 mins *
	****************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************
	* baseline - every 24 weeks - 1week - every 30 mins - BT/6AM-7PM/ *
	******************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************
	* baseline - every 24 weeks - 1week - every 1 hour *
	***************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************
	* baseline - every 24 weeks - 1week - every 1 hour - BT/6AM-7PM/ *
	*****************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************************************
	* baseline - every 24 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	****************************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/************************************************************************
	* baseline - every 24 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/ *
	************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 24 weeks - 1week - every 8 hours /6AM/2PM/10PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************************
	* baseline - every 24 weeks - 1week - evey 12 hours /6AM/6PM/ *
	**************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - 1week - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=127, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	
	/************************************************************************************************************
	*--------------------- baseline - every 24 weeks - weekdays ------------------------------------------------*
	************************************************************************************************************/
	/*******************************************************
	* baseline - every 24 weeks - weekdays - every 30 mins *
	*******************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************************
	* baseline - every 24 weeks - weekdays - every 30 mins - BT/6AM-7PM/ *
	*********************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************
	* baseline - every 24 weeks - weekdays - every 1 hour *
	******************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 24 weeks - weekdays - every 1 hour - BT/6AM-7PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************************************
	* baseline - every 24 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	*******************************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/***************************************************************************
	* baseline - every 24 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/ *
	***************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**********************************************************************
	* baseline - every 24 weeks - weekdays - every 8 hours /6AM/2PM/10PM/ *
	**********************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************************
	* baseline - every 24 weeks - weekdays - evey 12 hours /6AM/6PM/ *
	*****************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekdays - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=62, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END


	/************************************************************************************************************
	*--------------------- baseline - every 24 weeks - weekend -------------------------------------------------*
	************************************************************************************************************/
	/******************************************************
	* baseline - every 24 weeks - weekend - every 30 mins *
	******************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 30 mins'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/********************************************************************
	* baseline - every 24 weeks - weekend - every 30 mins - BT/6AM-7PM/ *
	********************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 30 mins - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=4, 
				@freq_subday_interval=30, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*****************************************************
	* baseline - every 24 weeks - weekend - every 1 hour *
	*****************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 1 hour'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,		 
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*******************************************************************
	* baseline - every 24 weeks - weekend - every 1 hour - BT/6AM-7PM/ *
	*******************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 1 hour - BT/6AM-7PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=1, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=190000,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/******************************************************************************************
	* baseline - every 24 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/ *
	******************************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=3, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=0, 
				@active_end_time=235959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/**************************************************************************
	* baseline - every 24 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/ *
	**************************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 6 hours /6AM/12PM/6PM/12AM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=6, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/*********************************************************************
	* baseline - every 24 weeks - weekend - every 8 hours /6AM/2PM/10PM/ *
	*********************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - every 8 hours /6AM/2PM/10PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=8, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END

	/****************************************************************
	* baseline - every 24 weeks - weekend - evey 12 hours /6AM/6PM/ *
	****************************************************************/
	SET @schedule_name = N'baseline - every 24 weeks - weekend - evey 12 hours /6AM/6PM/'

	IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @drop_schedule_if_exist = 1) OR
		(NOT EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
		AND @create_schedules = 1)
	BEGIN
		IF (EXISTS (SELECT * FROM [msdb].[dbo].[sysschedules] WHERE [name] = @schedule_name)
			AND @drop_schedule_if_exist = 1)
		BEGIN
			EXEC msdb.dbo.sp_delete_schedule  @schedule_name = @schedule_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ''' +@schedule_name+ N''' is deleted.'
		END
		IF @create_schedules = 1
		BEGIN
			EXEC msdb.dbo.sp_add_schedule
				@schedule_name = @schedule_name,
				@enabled=0, 
				@freq_type=8, 
				@freq_interval=65, 
				@freq_subday_type=8, 
				@freq_subday_interval=12, 
				@freq_relative_interval=0, 
				@freq_recurrence_factor=24, 
				@active_start_date=NULL, 
				@active_end_date=99991231, 
				@active_start_time=60000, 
				@active_end_time=55959,
				@owner_login_name = @sa_name
			PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Creating schedule ('+@schedule_name+N')...DONE'
		END
	END
	ELSE
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Schedule ('+@schedule_name+N') is skipped...DONE'
	END	


END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' SQL Server Instance (' + @@SERVERNAME + ') edition does not support jobs...'
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Creating schedules is skipped...DONE.'
END
GO

PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' END: CREATE SCHEDULES'
/*****************************************************************************
****************************** CREATE SCHEDULES ******************************
**************************************END*************************************/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF SERVERPROPERTY('EngineEdition') <> 4
BEGIN

	DECLARE @CreateJobs TINYINT
	DECLARE @CreateSchedules TINYINT

	DECLARE @job_name NVARCHAR(max)
	DECLARE @schedule_name NVARCHAR(max)


	SELECT @CreateJobs = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@CreateJobs'
	SELECT @CreateSchedules = CAST(value AS TINYINT) FROM #TempConfiguration WHERE [variable] = N'@CreateSchedules'

	IF @CreateJobs = 1 AND @CreateSchedules = 1
	BEGIN
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+ N' Configuring schedules for jobs...'	

		SET @job_name=N'Baseline - Collect InstanceInfo/ConfigData/DatabaseInfo/FileInfo/WaitStats'
		SET @schedule_name=N'baseline - daily - every 6 hours /6AM/12PM/6PM/12AM/'
		EXEC msdb.dbo.sp_attach_schedule 
			@job_name=@job_name,
			@schedule_name=@schedule_name
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @job_name + ''' is scheduled ('+@schedule_name+')...DONE'
	
		SET @job_name=N'Baseline - CollectIOVFStats'
		SET @schedule_name=N'baseline - every 4 weeks - 1week - every 3 hours /12AM/3AM/6AM/9AM/12PM/3PM/6PM/9PM/'
		EXEC msdb.dbo.sp_attach_schedule 
			@job_name=@job_name,
			@schedule_name=@schedule_name
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @job_name + ''' is scheduled ('+@schedule_name+')...DONE'

		SET @job_name=N'Baseline - CollectPerfmonData'
		SET @schedule_name=N'baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/'
		EXEC msdb.dbo.sp_attach_schedule 
			@job_name=@job_name,
			@schedule_name=@schedule_name
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @job_name + ''' is scheduled ('+@schedule_name+')...DONE'

		SET @job_name=N'Baseline - CollectTempDBUsage'
		SET @schedule_name=N'baseline - every 4 weeks - 1week - every 1 hour - BT/6AM-7PM/'
		EXEC msdb.dbo.sp_attach_schedule 
			@job_name=@job_name,
			@schedule_name=@schedule_name
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @job_name + ''' is scheduled ('+@schedule_name+')...DONE'
	
		SET @job_name=N'Baseline - Output File Cleanup'
		SET @schedule_name=N'baseline - daily - at 2351PM'
		EXEC msdb.dbo.sp_attach_schedule 
			@job_name=@job_name,
			@schedule_name=@schedule_name
		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Job ''' + @job_name + ''' is scheduled ('+@schedule_name+')...DONE'


		PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+ N' Configuring schedules for jobs...DONE'
	END
END
ELSE
BEGIN
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' SQL Server Instance (' + @@SERVERNAME + ') edition does not support jobs...'
	PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+' Configuring schedules for jobs is skipped...DONE.'
END
GO


DROP TABLE #TempConfiguration
PRINT CONVERT(nvarchar(13), SYSDATETIME(), 114)+N' Implementation of Baseline Collector Solution is finished.'
