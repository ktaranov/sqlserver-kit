IF  EXISTS (SELECT * FROM sys.triggers WHERE parent_class_desc = 'DATABASE' AND name = N'tr_DDL_SchemaChangeLog')
BEGIN
DROP TRIGGER [tr_DDL_SchemaChangeLog] ON DATABASE
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_JobStats' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_JobStats
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_PerfStats' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_PerfStats
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_MemoryUsageStats' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_MemoryUsageStats
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_CPUStats' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_CPUStats
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_CPUProcessAlert' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_CPUProcessAlert
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_LongRunningJobs' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_LongRunningJobs
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_LongRunningQueries' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_LongRunningQueries
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_CheckBlocking' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_CheckBlocking
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_FileStats' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_FileStats
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_CheckFilesWork' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_CheckFilesWork
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_CheckFiles' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_CheckFiles
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_PopulateDataDictionary' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_PopulateDataDictionary
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_UpdateDataDictionaryTable' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_UpdateDataDictionaryTable
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_UpdateDataDictionaryField' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_UpdateDataDictionaryField
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_TestDataDictionaryTables' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_TestDataDictionaryTables
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_TestDataDictionaryFields' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_TestDataDictionaryFields
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_ApplyDataDictionary' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_ApplyDataDictionary
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_ScavengeDataDictionaryTables' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_ScavengeDataDictionaryTables
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'dd_ScavengeDataDictionaryFields' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.dd_ScavengeDataDictionaryFields
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_ViewTableExtendedProperties' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.sp_ViewTableExtendedProperties
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'usp_TodaysDeadlocks' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.usp_TodaysDeadlocks
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'rpt_Queries' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.rpt_Queries
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'rpt_Blocking' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.rpt_Blocking
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'rpt_JobHistory' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.rpt_JobHistory
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'rpt_HealthReport' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.rpt_HealthReport
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'gen_GetHealthReportHTML' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.gen_GetHealthReportHTML
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'gen_GetHealthReportToEmail' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.gen_GetHealthReportToEmail
END
GO
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'gen_GetHealthReportToFile' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_TYPE = 'PROCEDURE')
BEGIN
DROP PROC dbo.gen_GetHealthReportToFile
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DataDictionary_Fields' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.DataDictionary_Fields
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DataDictionary_Tables' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.DataDictionary_Tables
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CPUStatsHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.CPUStatsHistory
END
GO
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ti_blockinghistory]'))
DROP TRIGGER [dbo].[ti_blockinghistory]
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BlockingHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.BlockingHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HealthReport' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.HealthReport
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'FileStatsHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.FileStatsHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'JobStatsHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.JobStatsHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MemoryUsageHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.MemoryUsageHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PerfStatsHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.PerfStatsHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'QueryHistory' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.QueryHistory
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SchemaChangeLog' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.SchemaChangeLog
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AlertSettings' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.AlertSettings
END
GO
IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DatabaseSettings' AND TABLE_SCHEMA = 'dbo')
BEGIN
DROP TABLE dbo.DatabaseSettings
END
GO

DECLARE @USER VARCHAR(50),
		@droploginsql VARCHAR(100),
		@sqlexec VARCHAR(max),
		@dbname VARCHAR(200)

SELECT name, 0 as status 
INTO #databases
FROM sys.databases
WHERE database_id > 4

WHILE EXISTS (SELECT name FROM #databases WHERE status = 0)
BEGIN 

SET @dbname = (SELECT top 1 name FROM #databases WHERE status = 0)

SELECT @sqlexec =  'USE '+ char(13) + '[' + name + ']'  + CHAR(13)+ CHAR(10) + 
		+ 'IF  EXISTS (SELECT * FROM sys.triggers WHERE [name] = ''tr_DDL_SchemaChangeLog'') DROP TRIGGER tr_DDL_SchemaChangeLog ON DATABASE'
	 + CHAR(13) + 'IF EXISTS (SELECT *	FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = ''SchemaChangeLog'' AND TABLE_SCHEMA = ''dbo'') DROP TABLE dbo.SchemaChangeLog'
FROM #databases
WHERE name = @dbname

UPDATE #databases 
SET status = 1 
WHERE name = @dbname

EXEC (@sqlexec)

END

print 'done'

DROP TABLE #databases


USE [msdb]
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_BlockingAlert')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_BlockingAlert', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_CheckFiles')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_CheckFiles', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_CPUAlert')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_CPUAlert', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_HealthReport')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_HealthReport', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_LongRunningJobsAlert')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_LongRunningJobsAlert', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_LongRunningQueriesAlert')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_LongRunningQueriesAlert', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_MemoryUsageStats')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_MemoryUsageStats', @delete_unused_schedule=1
GO

/****** Object:  Job [dbWarden_BlockingAlert]    Script Date: 04/15/2013 09:22:26 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'dbWarden_PerfStats')
EXEC msdb.dbo.sp_delete_job @job_name=N'dbWarden_PerfStats', @delete_unused_schedule=1
GO

IF  EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'SQL_DBA')
EXEC msdb.dbo.sp_delete_operator @name=N'SQL_DBA'
GO

IF  EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'SQL_DBA_vtext')
EXEC msdb.dbo.sp_delete_operator @name=N'SQL_DBA_vtext'
GO

DROP DATABASE dbWarden;
GO