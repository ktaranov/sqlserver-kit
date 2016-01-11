SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Procedure Already Exists And Create Shell If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'dbo.usp_SQL_Server_System_Report', N'P') IS NULL
BEGIN

	EXECUTE ('CREATE PROCEDURE dbo.usp_SQL_Server_System_Report AS SELECT 1 AS shell')

END
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: SQL Server System Report
--	Create Date (MM/DD/YYYY): 05/12/2010
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: Added "@Output_Mode" And "@Unused_Index_Days" Input Parameters
--	           : Code Restructuring For Better Query Performance
--	           : Minor Changes To Code Style
--	           : Added "connections""first_day_of_week", "is_clustered", And "windows_version" To "Instance Information" Section
--	Date (MM/DD/YYYY): 12/22/2011
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Added "create_date" And "file_name" To "Database Details" Section
--	           : Added "backup_finish_date", "database_version", "machine_name", And "server_name" To "Last Backup Set Details" Section
--	           : "Last Backup Set Details" Section Now Only Shows Information For Databases Currently On The Instance
--	           : Added "schema_name" To "Unused Indexes" Section
--	           : Extended "CONVERT" Character Length To Deal With "Msg 234" Error
--	           : Rewrote Time Calculation Logic
--	Date (MM/DD/YYYY): 01/18/2012
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Added Additional Input Parameters
--	           : Reformatted Code
--	           : Bug Fixes
--	           : Added "Instance Settings", "Index Fragmentation", "Missing Indexes" Sections
--	Date (MM/DD/YYYY): 09/20/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Renamed Some Headings / Variables / Temp Tables
--	           : Bug Fixes
--	           : Enhanced HTML Output
--	           : "Index" Ouputs Now Include Indexed Views
--	           : Added "instance_name", "product_name", And "server_memory_mb" To "Instance Information" Section
--	           : Added "authentication", "date_format", "fill_factor_percentage", "is_compressed_backups_enabled", "is_optimize_for_ad_hoc_workloads_enabled""is_scan_for_startup_procs_enabled", "is_sql_mail_enabled", "language", And "locale_id" To "Instance Settings" Section
--	           : Added "cached_mb" To "Database Summary" Section
--	           : Added "database_owner", "drive_letter", "file_name", "file_path", "file_read_mb", "file_reads", "file_writes", "file_written_mb", "io_wait_time_reads", And "io_wait_time_writes" To "Database Details" Section
--	           : Added "physical_device_name" To "Last Backup Set Details" Section
--	           : Added "category", "class", "date_created", "date_modified", "job_owner", "type", And "version" To "SQL Server Agent Jobs (Last 24 Hours)" Section
--	           : Added "filter_definition", "include_key", "object_type", And "row_count" To "Index Fragmentation" Section
--	           : Added "object_type" And "row_count" To "Missing Indexes" Section
--	           : Added "filter_definition", "include_key", "object_type", And "row_count" To "Unused Indexes" Section
--	Date (MM/DD/YYYY): 12/11/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Major Revamp Of "Database Summary" And "Database Details" Sections
--	Date (MM/DD/YYYY): 07/11/2014
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.usp_SQL_Server_System_Report

	 @Output_Mode AS CHAR (1) = NULL
	,@Unused_Index_Days AS INT = 7
	,@Recipients AS VARCHAR (MAX) = NULL
	,@Copy_Recipients AS VARCHAR (MAX) = NULL
	,@Instance_Information AS BIT = 1
	,@Instance_Settings AS BIT = 1
	,@Drives_Space AS BIT = 1
	,@Database_Summary AS BIT = 1
	,@Database_Details AS BIT = 1
	,@Last_Backup AS BIT = 1
	,@Agent_Jobs AS BIT = 1
	,@Fragmentation AS BIT = 1
	,@Missing_Indexes AS BIT = 1
	,@Unused_Indexes AS BIT = 1

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


DECLARE
	 @Avoid_Truncation AS NVARCHAR (MAX)
	,@Body AS NVARCHAR (MAX)
	,@Database_ID AS INT
	,@Database_Name_Loop AS NVARCHAR (500)
	,@Date_24_Hours_Ago AS DATETIME
	,@Date_Now AS DATETIME
	,@Filter_Definition_String AS NVARCHAR (50)
	,@Server_Memory_MB AS BIGINT
	,@SQL_Server_Start_Time AS DATETIME
	,@SQL_String AS NVARCHAR (MAX)
	,@Subject AS NVARCHAR (255)
	,@XML_String AS NVARCHAR (MAX)


DECLARE @Fixed_Drives_Free_Space AS TABLE

	(
		 drive_letter VARCHAR (5) PRIMARY KEY CLUSTERED
		,free_space_mb BIGINT
	)


SET @Avoid_Truncation = N''
SET @Body = N''
SET @Date_24_Hours_Ago = GETDATE () - 1
SET @Date_Now = @Date_24_Hours_Ago + 1
SET @Subject = N'SQL Server System Report: ' + @@SERVERNAME
SET @XML_String = N''


IF EXISTS (SELECT * FROM master.sys.all_columns AC WHERE AC.[object_id] = OBJECT_ID (N'master.sys.dm_os_sys_info', N'V') AND AC.name = N'sqlserver_start_time')
BEGIN

	SET @SQL_String =

		N'
			SELECT
				@SQL_Server_Start_Time = DOSI.sqlserver_start_time
			FROM
				master.sys.dm_os_sys_info DOSI
		 '


	EXECUTE sys.sp_executesql

		 @SQL_String
		,N'
			@SQL_Server_Start_Time AS DATETIME OUTPUT
		  '
		,@SQL_Server_Start_Time OUTPUT

END
ELSE BEGIN

	SET @SQL_Server_Start_Time =

		(
			SELECT
				DB.create_date
			FROM
				master.sys.databases DB
			WHERE
				DB.name = N'tempdb'
		)

END


IF DATEDIFF (SECOND, @SQL_Server_Start_Time, GETDATE ()) < (@Unused_Index_Days * 86400)
BEGIN

	SET @Unused_Indexes = 0

END


IF EXISTS (SELECT * FROM master.sys.all_columns AC WHERE AC.[object_id] = OBJECT_ID (N'master.sys.dm_os_sys_info', N'V') AND AC.name = N'physical_memory_kb')
BEGIN

	SET @SQL_String =

		N'
			SELECT
				@Server_Memory_MB = DOSI.physical_memory_kb / 1024
			FROM
				master.sys.dm_os_sys_info DOSI
		 '

END
ELSE BEGIN

	SET @SQL_String =

		N'
			SELECT
				@Server_Memory_MB = DOSI.physical_memory_in_bytes / 1048576
			FROM
				master.sys.dm_os_sys_info DOSI
		 '

END


EXECUTE sys.sp_executesql

	 @SQL_String
	,N'
		@Server_Memory_MB AS BIGINT OUTPUT
	  '
	,@Server_Memory_MB OUTPUT


IF EXISTS (SELECT * FROM master.sys.all_columns AC WHERE AC.[object_id] = OBJECT_ID (N'master.sys.indexes', N'V') AND AC.name = N'filter_definition')
BEGIN

	SET @Filter_Definition_String = N'ISNULL (I.filter_definition, N'''')'

END
ELSE BEGIN

	SET @Filter_Definition_String = N''''''

END


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Temp Table(s) Already Exist(s) And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_databases', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_databases

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_row_counts', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_row_counts

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_instance_information', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_instance_information

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_instance_settings', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_instance_settings

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_database_summary', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_database_summary

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_database_details', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_database_details

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_last_backup_set', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_last_backup_set

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_agent_jobs', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_agent_jobs

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_index_fragmentation', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_index_fragmentation

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_missing_indexes', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_missing_indexes

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_unused_indexes', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_unused_indexes

END


-----------------------------------------------------------------------------------------------------------------------------
--	Temp Table: Database List
-----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.#temp_sssr_databases

	(
		 database_name NVARCHAR (128) PRIMARY KEY CLUSTERED
		,database_owner NVARCHAR (128)
		,recovery_model NVARCHAR (60)
		,[compatibility_level] VARCHAR (3)
		,create_date DATETIME
		,collation_name NVARCHAR (128)
	)


INSERT INTO dbo.#temp_sssr_databases

	(
		 database_name
		,database_owner
		,recovery_model
		,[compatibility_level]
		,create_date
		,collation_name
	)

SELECT
	 DB.name AS database_name
	,SUSER_SNAME (DB.owner_sid) AS database_owner
	,DB.recovery_model_desc AS recovery_model
	,DB.[compatibility_level]
	,DB.create_date
	,DB.collation_name
FROM
	master.sys.databases DB
WHERE
	DB.[state] = 0
	AND DB.is_read_only = 0
	AND DB.is_in_standby = 0
	AND DB.source_database_id IS NULL


-----------------------------------------------------------------------------------------------------------------------------
--	Temp Table: Row Counts Per Table Per Database
-----------------------------------------------------------------------------------------------------------------------------

IF (@Fragmentation = 1 OR @Missing_Indexes = 1 OR @Unused_Indexes = 1)
BEGIN

	CREATE TABLE dbo.#temp_sssr_row_counts

		(
			 database_id INT NOT NULL
			,[object_id] INT NOT NULL
			,[rows] BIGINT
		)


	SET @Database_Name_Loop =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				dbo.#temp_sssr_databases X
			ORDER BY
				X.database_name
		)


	WHILE @Database_Name_Loop IS NOT NULL
	BEGIN

		SET @SQL_String = @Avoid_Truncation +

			N'
				USE [' + @Database_Name_Loop + N']


				INSERT INTO dbo.#temp_sssr_row_counts

					(
						 database_id
						,[object_id]
						,[rows]
					)

				SELECT
					 DB_ID () AS database_id
					,P.[object_id]
					,SUM (P.[rows]) AS total_rows
				FROM
					sys.partitions P
				WHERE
					P.index_id IN (0, 1)
				GROUP BY
					P.[object_id]
			 '


		EXECUTE (@SQL_String)


		SET @Database_Name_Loop =

			(
				SELECT TOP (1)
					X.database_name
				FROM
					dbo.#temp_sssr_databases X
				WHERE
					X.database_name > @Database_Name_Loop
				ORDER BY
					X.database_name
			)

	END


	ALTER TABLE dbo.#temp_sssr_row_counts ADD PRIMARY KEY CLUSTERED (database_id, [object_id])

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query I: Instance Information
-----------------------------------------------------------------------------------------------------------------------------

IF @Instance_Information = 0
BEGIN

	GOTO Skip_Instance_Information

END


SELECT
	 SERVERPROPERTY (N'ComputerNamePhysicalNetBIOS') AS netbios_name
	,@@SERVERNAME AS server_name
	,ISNULL (SERVERPROPERTY (N'InstanceName'), N'Default Instance') AS instance_name
	,REPLACE (REPLACE (cjPNL.product_name, N' (' + cjPNL.[level] + N')', N''), N'Microsoft ', N'') AS product_name
	,REPLACE (CONVERT (NVARCHAR (128), SERVERPROPERTY (N'Edition')), N' Edition', N'') AS edition
	,SERVERPROPERTY (N'ProductVersion') AS [version]
	,cjPNL.[level]
	,(CASE SERVERPROPERTY (N'IsClustered')
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_clustered
	,CONVERT (NVARCHAR (19), @SQL_Server_Start_Time, 120) AS online_since
	,(CASE
		WHEN oaDSR.total_days = '0' THEN '_'
		ELSE oaDSR.total_days
		END) + ' Day(s) ' + (CASE
								WHEN oaDSR.seconds_remaining = 0 THEN '__:__:__'
								WHEN oaDSR.seconds_remaining < 60 THEN '__:__:' + RIGHT (oaDSR.total_seconds, 2)
								WHEN oaDSR.seconds_remaining < 3600 THEN '__:' + RIGHT (oaDSR.total_seconds, 5)
								ELSE oaDSR.total_seconds
								END) AS uptime
	,SERVERPROPERTY (N'ProcessID') AS process_id
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, @@CONNECTIONS), 1)), 4, 23)) AS connections
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, @@TOTAL_READ), 1)), 4, 23)) AS reads
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, @@TOTAL_WRITE), 1)), 4, 23)) AS writes
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DOSI.cpu_count), 1)), 4, 23)) AS logical_cpu_count
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DOSI.cpu_count / DOSI.hyperthread_ratio), 1)), 4, 23)) AS physical_cpu_count
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, @Server_Memory_MB), 1)), 4, 23)) AS server_memory_mb
	,REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (RIGHT (@@VERSION, CHARINDEX (REVERSE (N' on Windows '), REVERSE (@@VERSION)) - 1), N'Service Pack ', N'SP'), N'(', N''), N')', N''), N'<', N'('), N'>', N')') AS windows_version
INTO
	dbo.#temp_sssr_instance_information
FROM
	master.sys.dm_os_sys_info DOSI
	CROSS JOIN

		(
			SELECT
				 LEFT (@@VERSION, CHARINDEX (N' - ', @@VERSION) - 1) AS product_name
				,CONVERT (NVARCHAR (128), SERVERPROPERTY (N'ProductLevel')) AS [level]
		) cjPNL

	CROSS JOIN

		(
			SELECT
				DATEDIFF (SECOND, @SQL_Server_Start_Time, GETDATE ()) AS uptime_seconds
		) sqUTS

	OUTER APPLY

		(
			SELECT
				 CONVERT (VARCHAR (5), sqUTS.uptime_seconds / 86400) AS total_days
				,CONVERT (CHAR (8), DATEADD (SECOND, sqUTS.uptime_seconds % 86400, 0), 108) AS total_seconds
				,sqUTS.uptime_seconds % 86400 AS seconds_remaining
		) oaDSR


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Instance_Information

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.netbios_name AS 'td'
					,'',X.server_name AS 'td'
					,'',X.instance_name AS 'td'
					,'',X.product_name AS 'td'
					,'',X.edition AS 'td'
					,'',X.[version] AS 'td'
					,'',X.[level] AS 'td'
					,'',X.is_clustered AS 'td'
					,'',X.online_since AS 'td'
					,'',X.uptime AS 'td'
					,'',X.process_id AS 'td'
					,'','right_align' + X.connections AS 'td'
					,'','right_align' + X.reads AS 'td'
					,'','right_align' + X.writes AS 'td'
					,'','right_align' + X.logical_cpu_count AS 'td'
					,'','right_align' + X.physical_cpu_count AS 'td'
					,'','right_align' + X.server_memory_mb AS 'td'
					,'',X.windows_version AS 'td'
				FROM
					dbo.#temp_sssr_instance_information X
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Instance Information</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>NetBIOS Name</th>
						<th nowrap>Server Name</th>
						<th nowrap>Instance Name</th>
						<th nowrap>Product Name</th>
						<th nowrap>Edition</th>
						<th nowrap>Version</th>
						<th nowrap>Level</th>
						<th nowrap>Clustered</th>
						<th nowrap>Online Since</th>
						<th nowrap>Uptime</th>
						<th nowrap>Process ID</th>
						<th nowrap>Connections</th>
						<th nowrap>Reads</th>
						<th nowrap>Writes</th>
						<th nowrap>Logical CPU Count</th>
						<th nowrap>Physical CPU Count</th>
						<th nowrap>Server Memory (MB)</th>
						<th nowrap>Windows Version</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.netbios_name
		,X.server_name
		,X.instance_name
		,X.product_name
		,X.edition
		,X.[version]
		,X.[level]
		,X.is_clustered AS [clustered]
		,X.online_since
		,X.uptime
		,X.process_id
		,X.connections
		,X.reads
		,X.writes
		,X.logical_cpu_count
		,X.physical_cpu_count
		,X.server_memory_mb
		,X.windows_version
	FROM
		dbo.#temp_sssr_instance_information X

END


Skip_Instance_Information:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_instance_information', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_instance_information

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query II: Instance Settings
-----------------------------------------------------------------------------------------------------------------------------

IF @Instance_Settings = 0
BEGIN

	GOTO Skip_Instance_Settings

END


SELECT
	 (CASE SERVERPROPERTY (N'IsIntegratedSecurityOnly')
		WHEN 0 THEN 'Mixed Mode'
		WHEN 1 THEN 'Windows'
		ELSE 'N/A'
		END) AS [authentication]
	,SL.alias + N': ' + SL.name AS [language]
	,SL.lcid AS locale_id
	,SERVERPROPERTY (N'Collation') AS collation
	,SL.[dateformat] AS date_format
	,(CASE SL.[datefirst]
		WHEN 1 THEN 'Monday'
		WHEN 2 THEN 'Tuesday'
		WHEN 3 THEN 'Wednesday'
		WHEN 4 THEN 'Thursday'
		WHEN 5 THEN 'Friday'
		WHEN 6 THEN 'Saturday'
		WHEN 7 THEN 'Sunday'
		ELSE 'N/A'
		END) AS first_day_of_week
	,(CASE SERVERPROPERTY (N'IsFullTextInstalled')
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_full_text_installed
	,(CASE cjCFG.is_show_advanced_options_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_show_advanced_options_enabled
	,(CASE cjCFG.is_clr_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_clr_enabled
	,(CASE cjCFG.is_compressed_backups_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_compressed_backups_enabled
	,(CASE cjCFG.is_scan_for_startup_procs_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_scan_for_startup_procs_enabled
	,(CASE cjCFG.is_optimize_for_ad_hoc_workloads_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_optimize_for_ad_hoc_workloads_enabled
	,(CASE cjCFG.is_xp_cmdshell_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_xp_cmdshell_enabled
	,(CASE cjCFG.is_sql_mail_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_sql_mail_enabled
	,(CASE cjCFG.is_database_mail_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_database_mail_enabled
	,(CASE cjCFG.is_default_trace_enabled
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
		ELSE 'N/A'
		END) AS is_default_trace_enabled
	,CONVERT (VARCHAR (3), (CASE
								WHEN cjCFG.fill_factor_percentage = 0 THEN 100
								ELSE cjCFG.fill_factor_percentage
								END)) AS fill_factor_percentage
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, cjCFG.min_server_memory_mb), 1)), 4, 23)) AS min_server_memory_mb
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, cjCFG.max_server_memory_mb), 1)), 4, 23)) AS max_server_memory_mb
INTO
	#temp_sssr_instance_settings
FROM
	master.sys.syslanguages SL
	CROSS JOIN

		(
			SELECT
				 MAX (CASE
						WHEN CFG.configuration_id = 518 THEN CFG.value
						END) AS is_show_advanced_options_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 1562 THEN CFG.value
						END) AS is_clr_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 1579 THEN CFG.value
						END) AS is_compressed_backups_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 1547 THEN CFG.value
						END) AS is_scan_for_startup_procs_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 1581 THEN CFG.value
						END) AS is_optimize_for_ad_hoc_workloads_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 16390 THEN CFG.value
						END) AS is_xp_cmdshell_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 16385 THEN CFG.value
						END) AS is_sql_mail_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 16386 THEN CFG.value
						END) AS is_database_mail_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 1568 THEN CFG.value
						END) AS is_default_trace_enabled
				,MAX (CASE
						WHEN CFG.configuration_id = 109 THEN CFG.value
						END) AS fill_factor_percentage
				,MAX (CASE
						WHEN CFG.configuration_id = 1543 THEN CFG.value
						END) AS min_server_memory_mb
				,MAX (CASE
						WHEN CFG.configuration_id = 1544 THEN CFG.value
						END) AS max_server_memory_mb
			FROM
				master.sys.configurations CFG
			WHERE
				CFG.configuration_id IN (109, 518, 1543, 1544, 1547, 1562, 1568, 1579, 1581, 16385, 16386, 16390)
		) cjCFG

WHERE
	SL.lcid = SERVERPROPERTY (N'LCID')


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Instance_Settings

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.[authentication] AS 'td'
					,'',X.[language] AS 'td'
					,'',X.locale_id AS 'td'
					,'',X.collation AS 'td'
					,'',X.date_format AS 'td'
					,'',X.first_day_of_week AS 'td'
					,'',X.is_full_text_installed AS 'td'
					,'',X.is_show_advanced_options_enabled AS 'td'
					,'',X.is_clr_enabled AS 'td'
					,'',X.is_compressed_backups_enabled AS 'td'
					,'',X.is_scan_for_startup_procs_enabled AS 'td'
					,'',X.is_optimize_for_ad_hoc_workloads_enabled AS 'td'
					,'',X.is_xp_cmdshell_enabled AS 'td'
					,'',X.is_sql_mail_enabled AS 'td'
					,'',X.is_database_mail_enabled AS 'td'
					,'',X.is_default_trace_enabled AS 'td'
					,'','right_align' + X.fill_factor_percentage AS 'td'
					,'','right_align' + X.min_server_memory_mb AS 'td'
					,'','right_align' + X.max_server_memory_mb AS 'td'
				FROM
					dbo.#temp_sssr_instance_settings X
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Instance Settings</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Authentication</th>
						<th nowrap>Language</th>
						<th nowrap>Locale ID</th>
						<th nowrap>Collation</th>
						<th nowrap>Date Format</th>
						<th nowrap>First Day Of Week</th>
						<th nowrap>Full-Text Installed</th>
						<th nowrap>Advanced Options Enabled</th>
						<th nowrap>CLR Enabled</th>
						<th nowrap>Compress Backups</th>
						<th nowrap>Scan For Startup Procs</th>
						<th nowrap>Optimize For Ad Hocs</th>
						<th nowrap>Command Shell Enabled</th>
						<th nowrap>SQL Mail Enabled</th>
						<th nowrap>Database Mail Enabled</th>
						<th nowrap>Default Trace Enabled</th>
						<th nowrap>Fill Factor %</th>
						<th nowrap>Minimum Memory (MB)</th>
						<th nowrap>Maximum Memory (MB)</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.[authentication]
		,X.[language]
		,X.locale_id
		,X.collation
		,X.date_format
		,X.first_day_of_week
		,X.is_full_text_installed AS full_text_installed
		,X.is_show_advanced_options_enabled AS advanced_options_enabled
		,X.is_clr_enabled AS clr_enabled
		,X.is_compressed_backups_enabled AS compress_backups
		,X.is_scan_for_startup_procs_enabled AS scan_for_startup_procs
		,X.is_optimize_for_ad_hoc_workloads_enabled AS optimize_for_ad_hocs
		,X.is_xp_cmdshell_enabled AS command_shell_enabled
		,X.is_sql_mail_enabled AS sql_mail_enabled
		,X.is_database_mail_enabled AS database_mail_enabled
		,X.is_default_trace_enabled AS default_trace_enabled
		,X.fill_factor_percentage AS fill_factor_pct
		,X.min_server_memory_mb AS minimum_memory_mb
		,X.max_server_memory_mb AS maximum_memory_mb
	FROM
		dbo.#temp_sssr_instance_settings X

END


Skip_Instance_Settings:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_instance_settings', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_instance_settings

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query III: Fixed Drives Free Space
-----------------------------------------------------------------------------------------------------------------------------

IF @Drives_Space = 0
BEGIN

	GOTO Skip_Fixed_Drives_Free_Space

END


INSERT INTO @Fixed_Drives_Free_Space

	(
		 drive_letter
		,free_space_mb
	)

EXECUTE master.dbo.xp_fixeddrives


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Fixed_Drives_Free_Space

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.drive_letter + ':' AS 'td'
					,'','right_align' + REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, X.free_space_mb), 1)), 4, 23)) AS 'td'
				FROM
					@Fixed_Drives_Free_Space X
				ORDER BY
					X.drive_letter
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Fixed Drives Free Space</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Drive Letter</th>
						<th nowrap>Free Space (MB)</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.drive_letter + ':' AS drive_letter
		,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, X.free_space_mb), 1)), 4, 23)) AS free_space_mb
	FROM
		@Fixed_Drives_Free_Space X
	ORDER BY
		X.drive_letter

END


Skip_Fixed_Drives_Free_Space:


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query IV: Database Summary
-----------------------------------------------------------------------------------------------------------------------------

IF @Database_Summary = 0
BEGIN

	GOTO Skip_Database_Summary

END


CREATE TABLE dbo.#temp_sssr_database_summary

	(
		 database_name NVARCHAR (128)
		,database_owner NVARCHAR (128)
		,recovery_model NVARCHAR (60)
		,[compatibility_level] VARCHAR (3)
		,create_date NVARCHAR (19)
		,collation_name NVARCHAR (128)
		,is_case_sensitive VARCHAR (3)
		,total_size_mb VARCHAR (23)
		,unallocated_mb VARCHAR (23)
		,reserved_mb VARCHAR (23)
		,data_mb VARCHAR (23)
		,index_mb VARCHAR (23)
		,unused_mb VARCHAR (23)
		,cached_mb VARCHAR (23)
	)


SET @Database_Name_Loop =

	(
		SELECT TOP (1)
			X.database_name
		FROM
			dbo.#temp_sssr_databases X
		ORDER BY
			X.database_name
	)


WHILE @Database_Name_Loop IS NOT NULL
BEGIN

	SET @SQL_String = @Avoid_Truncation +

		N'
			USE [' + @Database_Name_Loop + N']


			INSERT INTO dbo.#temp_sssr_database_summary

				(
					 database_name
					,database_owner
					,recovery_model
					,[compatibility_level]
					,create_date
					,collation_name
					,is_case_sensitive
					,total_size_mb
					,unallocated_mb
					,reserved_mb
					,data_mb
					,index_mb
					,unused_mb
				)

			SELECT
				 X.database_name
				,ISNULL (X.database_owner, N''???'') AS database_owner
				,X.recovery_model
				,ISNULL (CONVERT (VARCHAR (3), X.[compatibility_level]), ''N/A'') AS [compatibility_level]
				,CONVERT (NVARCHAR (19), X.create_date, 120) AS create_date
				,X.collation_name
				,(CASE
					WHEN ''a'' = ''A'' THEN ''No''
					ELSE ''Yes''
					END) AS is_case_sensitive
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((sqDBF.total_size * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS total_size_mb
				,(CASE
					WHEN sqDBF.database_size >= cjPGS.total_pages THEN REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (((sqDBF.database_size - cjPGS.total_pages) * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23))
					ELSE ''0''
					END) AS unallocated_mb
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((cjPGS.total_pages * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS reserved_mb
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((cjPGS.pages * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS data_mb
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (((cjPGS.used_pages - cjPGS.pages) * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS index_mb
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (((cjPGS.total_pages - cjPGS.used_pages) * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS unused_mb
			FROM
				dbo.#temp_sssr_databases X
				CROSS JOIN

					(
						SELECT
							 SUM (CASE
									WHEN DBF.[type] = 0 THEN DBF.size
									ELSE 0
									END) AS database_size
							,SUM (DBF.size) AS total_size
						FROM
							sys.database_files AS DBF
						WHERE
							DBF.[type] IN (0, 1)
					) sqDBF

				CROSS JOIN

					(
						SELECT
							 SUM (AU.total_pages) AS total_pages
							,SUM (AU.used_pages) AS used_pages
							,SUM (CASE
									WHEN IT.internal_type IN (202, 204) THEN 0
									WHEN AU.[type] <> 1 THEN AU.used_pages
									WHEN P.index_id <= 1 THEN AU.data_pages
									ELSE 0
									END) AS pages
						FROM
							sys.partitions P
							INNER JOIN sys.allocation_units AU ON AU.container_id = P.partition_id
							LEFT JOIN sys.internal_tables IT ON IT.[object_id] = P.[object_id]
					) cjPGS

			WHERE
				X.database_name = ''' + @Database_Name_Loop + N'''
		 '


	EXECUTE (@SQL_String)


	SET @Database_Name_Loop =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				dbo.#temp_sssr_databases X
			WHERE
				X.database_name > @Database_Name_Loop
			ORDER BY
				X.database_name
		)

END


IF NOT EXISTS (SELECT * FROM dbo.#temp_sssr_database_summary X)
BEGIN

	GOTO Skip_Database_Summary

END


UPDATE
	X
SET
	X.cached_mb = sqCM.cached_mb
FROM
	dbo.#temp_sssr_database_summary X
	LEFT JOIN

		(
			SELECT
				 DB_NAME (DOBD.database_id) AS database_name
				,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, (COUNT (*) * 8) / 1024.0), 1)), 4, 23)), '0.00') AS cached_mb
			FROM
				master.sys.dm_os_buffer_descriptors DOBD
			GROUP BY
				DB_NAME (DOBD.database_id)
		) sqCM ON sqCM.database_name = X.database_name


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.database_name AS 'td'
					,'',X.database_owner AS 'td'
					,'',X.recovery_model AS 'td'
					,'',X.[compatibility_level] AS 'td'
					,'',X.create_date AS 'td'
					,'',X.collation_name AS 'td'
					,'',X.is_case_sensitive AS 'td'
					,'','right_align' + X.total_size_mb AS 'td'
					,'','right_align' + X.unallocated_mb AS 'td'
					,'','right_align' + X.reserved_mb AS 'td'
					,'','right_align' + X.data_mb AS 'td'
					,'','right_align' + X.index_mb AS 'td'
					,'','right_align' + X.unused_mb AS 'td'
					,'','right_align' + X.cached_mb AS 'td'
				FROM
					dbo.#temp_sssr_database_summary X
				ORDER BY
					X.database_name
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Database Summary</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Database Name</th>
						<th nowrap>Database Owner</th>
						<th nowrap>Recovery Model</th>
						<th nowrap>Compatibility</th>
						<th nowrap>Create Date</th>
						<th nowrap>Collation</th>
						<th nowrap>Case Sensitive</th>
						<th nowrap>Total Size (MB)</th>
						<th nowrap>Unallocated (MB)</th>
						<th nowrap>Reserved (MB)</th>
						<th nowrap>Data (MB)</th>
						<th nowrap>Index (MB)</th>
						<th nowrap>Unused (MB)</th>
						<th nowrap>Cached (MB)</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.database_name
		,X.database_owner
		,X.recovery_model
		,X.[compatibility_level]
		,X.create_date
		,X.collation_name AS collation
		,X.is_case_sensitive AS case_sensitive
		,X.total_size_mb
		,X.unallocated_mb
		,X.reserved_mb
		,X.data_mb
		,X.index_mb
		,X.unused_mb
		,X.cached_mb
	FROM
		dbo.#temp_sssr_database_summary X
	ORDER BY
		X.database_name

END


Skip_Database_Summary:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_database_summary', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_database_summary

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query V: Database Details
-----------------------------------------------------------------------------------------------------------------------------

IF @Database_Details = 0
BEGIN

	GOTO Skip_Database_Details

END


SELECT
	 DB_NAME (MF.database_id) AS database_name
	,CONVERT (NVARCHAR (10), LEFT (UPPER (MF.type_desc), 1) + LOWER (SUBSTRING (MF.type_desc, 2, 250))) AS file_type
	,MF.name AS logical_name
	,UPPER (LEFT (MF.physical_name, 2)) AS drive_letter
	,(CASE
		WHEN LEN (MF.physical_name) - LEN (REPLACE (MF.physical_name, N'\', N'')) < 2 THEN N'<Drive Root>'
		ELSE SUBSTRING (MF.physical_name, 4, LEN (MF.physical_name) - CHARINDEX (N'\', REVERSE (MF.physical_name)) - 3)
		END) AS file_path
	,RIGHT (MF.physical_name, CHARINDEX (N'\', REVERSE (MF.physical_name)) - 1) AS [file_name]
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((MF.size * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) AS file_size_mb
	,RIGHT ((CASE
				WHEN MF.growth = 0 THEN 'Fixed Size'
				WHEN MF.max_size = -1 THEN 'Unrestricted'
				WHEN MF.max_size = 0 THEN 'None'
				WHEN MF.max_size = 268435456 THEN '2 TB'
				ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((MF.max_size * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) + ' MB'
				END), 15) AS max_size
	,RIGHT ((CASE
				WHEN MF.growth = 0 THEN 'N/A'
				WHEN MF.is_percent_growth = 1 THEN REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, MF.growth), 1)), 4, 23)) + ' %'
				ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND ((MF.growth * CONVERT (BIGINT, 8192)) / 1048576.0, 0)), 1)), 4, 23)) + ' MB'
				END), 15) AS growth_increment
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DIVFS.num_of_reads), 1)), 4, 23)), '0') AS file_reads
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DIVFS.num_of_writes), 1)), 4, 23)), '0') AS file_writes
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (DIVFS.num_of_bytes_read / 1048576.0, 0)), 1)), 4, 23)), '0.00') AS file_read_mb
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (DIVFS.num_of_bytes_written / 1048576.0, 0)), 1)), 4, 23)), '0.00') AS file_written_mb
	,ISNULL ((CASE
				WHEN oaDSR.total_days_reads = '0' THEN REPLICATE ('_', cjDLM.day_length_max_reads)
				ELSE REPLICATE ('0', cjDLM.day_length_max_reads - LEN (oaDSR.total_days_reads)) + oaDSR.total_days_reads
				END) + ' Day(s) ' + (CASE
										WHEN oaDSR.seconds_remaining_reads = 0 THEN '__:__:__'
										WHEN oaDSR.seconds_remaining_reads < 60 THEN '__:__:' + RIGHT (oaDSR.total_seconds_reads, 2)
										WHEN oaDSR.seconds_remaining_reads < 3600 THEN '__:' + RIGHT (oaDSR.total_seconds_reads, 5)
										ELSE oaDSR.total_seconds_reads
										END), REPLICATE ('_', cjDLM.day_length_max_reads) + ' Day(s) ' + '__:__:__') AS io_wait_time_reads
	,ISNULL ((CASE
				WHEN oaDSR.total_days_writes = '0' THEN REPLICATE ('_', cjDLM.day_length_max_writes)
				ELSE REPLICATE ('0', cjDLM.day_length_max_writes - LEN (oaDSR.total_days_writes)) + oaDSR.total_days_writes
				END) + ' Day(s) ' + (CASE
										WHEN oaDSR.seconds_remaining_writes = 0 THEN '__:__:__'
										WHEN oaDSR.seconds_remaining_writes < 60 THEN '__:__:' + RIGHT (oaDSR.total_seconds_writes, 2)
										WHEN oaDSR.seconds_remaining_writes < 3600 THEN '__:' + RIGHT (oaDSR.total_seconds_writes, 5)
										ELSE oaDSR.total_seconds_writes
										END), REPLICATE ('_', cjDLM.day_length_max_writes) + ' Day(s) ' + '__:__:__') AS io_wait_time_writes
	,ROW_NUMBER () OVER
						(
							PARTITION BY
								MF.database_id
							ORDER BY
								 MF.[type]
								,(CASE
									WHEN MF.[file_id] = 1 THEN 10
									ELSE 99
									END)
								,MF.name
						) AS database_filter_id
INTO
	dbo.#temp_sssr_database_details
FROM
	master.sys.master_files MF
	LEFT JOIN master.sys.dm_io_virtual_file_stats (NULL, NULL) DIVFS ON DIVFS.database_id = MF.database_id
		AND DIVFS.[file_id] = MF.[file_id]
	CROSS JOIN

		(
			SELECT
				 MAX (LEN ((XDIVFS.io_stall_read_ms / 1000) / 86400)) AS day_length_max_reads
				,MAX (LEN ((XDIVFS.io_stall_write_ms / 1000) / 86400)) AS day_length_max_writes
			FROM
				master.sys.dm_io_virtual_file_stats (NULL, NULL) XDIVFS
		) cjDLM

	OUTER APPLY

		(
			SELECT
				 CONVERT (VARCHAR (5), (DIVFS.io_stall_read_ms / 1000) / 86400) AS total_days_reads
				,CONVERT (CHAR (8), DATEADD (SECOND, (DIVFS.io_stall_read_ms / 1000) % 86400, 0), 108) AS total_seconds_reads
				,(DIVFS.io_stall_read_ms / 1000) % 86400 AS seconds_remaining_reads
				,CONVERT (VARCHAR (5), (DIVFS.io_stall_write_ms / 1000) / 86400) AS total_days_writes
				,CONVERT (CHAR (8), DATEADD (SECOND, (DIVFS.io_stall_write_ms / 1000) % 86400, 0), 108) AS total_seconds_writes
				,(DIVFS.io_stall_write_ms / 1000) % 86400 AS seconds_remaining_writes
		) oaDSR


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Database_Details

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',(CASE
							WHEN X.database_filter_id = 1 THEN X.database_name
							ELSE ''
							END) AS 'td'
					,'',X.file_type AS 'td'
					,'',X.logical_name AS 'td'
					,'',X.drive_letter AS 'td'
					,'',X.file_path AS 'td'
					,'',X.[file_name] AS 'td'
					,'','right_align' + X.file_size_mb AS 'td'
					,'','right_align' + X.max_size AS 'td'
					,'','right_align' + X.growth_increment AS 'td'
					,'','right_align' + X.file_reads AS 'td'
					,'','right_align' + X.file_writes AS 'td'
					,'','right_align' + X.file_read_mb AS 'td'
					,'','right_align' + X.file_written_mb AS 'td'
					,'',X.io_wait_time_reads AS 'td'
					,'',X.io_wait_time_writes AS 'td'
				FROM
					dbo.#temp_sssr_database_details X
				ORDER BY
					 X.database_name
					,X.database_filter_id
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Database Details</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Database Name</th>
						<th nowrap>File Type</th>
						<th nowrap>Logical Name</th>
						<th nowrap>Drive Letter</th>
						<th nowrap>File Path</th>
						<th nowrap>File Name</th>
						<th nowrap>File Size (MB)</th>
						<th nowrap>Max Size</th>
						<th nowrap>Growth Increment</th>
						<th nowrap>File Reads</th>
						<th nowrap>File Writes</th>
						<th nowrap>File Read (MB)</th>
						<th nowrap>File Written (MB)</th>
						<th nowrap>I/O Wait Time Reads</th>
						<th nowrap>I/O Wait Time Writes</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 (CASE
			WHEN X.database_filter_id = 1 THEN X.database_name
			ELSE ''
			END) AS database_name
		,X.file_type
		,X.logical_name
		,X.drive_letter
		,X.file_path
		,X.[file_name]
		,X.file_size_mb
		,X.max_size
		,X.growth_increment
		,X.file_reads
		,X.file_writes
		,X.file_read_mb
		,X.file_written_mb
		,X.io_wait_time_reads
		,X.io_wait_time_writes
	FROM
		dbo.#temp_sssr_database_details X
	ORDER BY
		 X.database_name
		,X.database_filter_id

END


Skip_Database_Details:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_database_details', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_database_details

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query VI: Last Backup Set Details
-----------------------------------------------------------------------------------------------------------------------------

IF @Last_Backup = 0
BEGIN

	GOTO Skip_Last_Backup_Set

END


SELECT
	 X.database_name
	,ISNULL (CONVERT (VARCHAR (10), sqBS.backup_set_id), 'NONE') AS backup_set_id
	,(CASE sqBS.[type]
		WHEN 'D' THEN 'Database'
		WHEN 'F' THEN 'File Or Filegroup'
		WHEN 'G' THEN 'Differential File'
		WHEN 'I' THEN 'Differential Database'
		WHEN 'L' THEN 'Log'
		WHEN 'P' THEN 'Partial'
		WHEN 'Q' THEN 'Differential Partial'
		ELSE 'N/A'
		END) AS backup_type
	,ISNULL (CONVERT (VARCHAR (3), sqBS.software_major_version) + '.' + CONVERT (VARCHAR (3), sqBS.software_minor_version) + '.' + CONVERT (VARCHAR (6), sqBS.software_build_version), 'N/A') AS software_version
	,ISNULL (CONVERT (VARCHAR (10), sqBS.database_version), 'N/A') AS database_version
	,ISNULL (CONVERT (VARCHAR (3), sqBS.[compatibility_level]), 'N/A') AS [compatibility_level]
	,ISNULL (sqBS.server_name, 'N/A') AS server_name
	,ISNULL (sqBS.machine_name, 'N/A') AS machine_name
	,ISNULL (sqBS.physical_device_name, 'N/A') AS physical_device_name
	,ISNULL (CONVERT (VARCHAR (34), sqBS.backup_start_date, 120), 'N/A') AS backup_start_date
	,ISNULL (CONVERT (VARCHAR (34), sqBS.backup_finish_date, 120), 'N/A') AS backup_finish_date
	,ISNULL ((CASE
				WHEN sqBS.total_days = '0' THEN REPLICATE ('_', sqBS.day_length_max)
				ELSE REPLICATE ('0', sqBS.day_length_max - LEN (sqBS.total_days)) + sqBS.total_days
				END) + ' Day(s) ' + (CASE
										WHEN sqBS.seconds_remaining = 0 THEN '__:__:__'
										WHEN sqBS.seconds_remaining < 60 THEN '__:__:' + RIGHT (sqBS.total_seconds, 2)
										WHEN sqBS.seconds_remaining < 3600 THEN '__:' + RIGHT (sqBS.total_seconds, 5)
										ELSE sqBS.total_seconds
										END), 'N/A') AS duration
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (sqBS.backup_size / 1048576.0, 0)), 1)), 4, 23)), 'N/A') AS backup_size_mb
	,CONVERT (VARCHAR (23), 'N/A') AS compressed_size_mb
	,CONVERT (VARCHAR (23), 'N/A') AS compression_pct
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DATEDIFF (DAY, sqBS.backup_start_date, GETDATE ())), 1)), 4, 23)), 'N/A') AS days_ago
	,ROW_NUMBER () OVER
						(
							PARTITION BY
								X.database_name
							ORDER BY
								sqBS.[type]
						) AS database_filter_id
INTO
	dbo.#temp_sssr_last_backup_set
FROM
	dbo.#temp_sssr_databases X
	LEFT JOIN

		(
			SELECT
				 BS.database_name
				,BS.backup_set_id
				,BS.[type]
				,BS.software_major_version
				,BS.software_minor_version
				,BS.software_build_version
				,BS.database_version
				,BS.[compatibility_level]
				,BS.server_name
				,BS.machine_name
				,BMF.physical_device_name
				,BS.backup_start_date
				,BS.backup_finish_date
				,BS.backup_size
				,cjDLM.day_length_max
				,oaDSR.seconds_remaining
				,oaDSR.total_days
				,oaDSR.total_seconds
			FROM
				msdb.dbo.backupset BS
				INNER JOIN msdb.dbo.backupmediafamily BMF ON BMF.media_set_id = BS.media_set_id
				INNER JOIN

					(
						SELECT
							MAX (XBS.backup_set_id) AS backup_set_id_max
						FROM
							msdb.dbo.backupset XBS
						GROUP BY
							 XBS.database_name
							,XBS.[type]
					) sqMBS ON sqMBS.backup_set_id_max = BS.backup_set_id

				CROSS JOIN

					(
						SELECT
							MAX (LEN (DATEDIFF (DAY, YBS.backup_start_date, YBS.backup_finish_date))) AS day_length_max
						FROM
							msdb.dbo.backupset YBS
					) cjDLM

				OUTER APPLY

					(
						SELECT
							DATEDIFF (SECOND, BS.backup_start_date, BS.backup_finish_date) AS duration_seconds
					) oaDS

				OUTER APPLY

					(
						SELECT
							 CONVERT (VARCHAR (5), oaDS.duration_seconds / 86400) AS total_days
							,CONVERT (CHAR (8), DATEADD (SECOND, oaDS.duration_seconds % 86400, 0), 108) AS total_seconds
							,oaDS.duration_seconds % 86400 AS seconds_remaining
					) oaDSR

		) sqBS ON sqBS.database_name = X.database_name

WHERE
	X.database_name <> N'tempdb'


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Last_Backup_Set

END


IF EXISTS (SELECT * FROM msdb.sys.all_columns AC WHERE AC.[object_id] = OBJECT_ID (N'msdb.dbo.backupset', N'U') AND AC.name = N'compressed_backup_size')
BEGIN

	EXECUTE

		(
			N'
				UPDATE
					X
				SET
					 X.compressed_size_mb = REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (BS.compressed_backup_size / 1048576.0, 0)), 1)), 4, 23))
					,X.compression_pct = CONVERT (VARCHAR (23), CONVERT (MONEY, ROUND (((BS.backup_size - BS.compressed_backup_size + .0) / BS.backup_size) * 100, 2)), 1)
				FROM
					dbo.#temp_sssr_last_backup_set X
					INNER JOIN msdb.dbo.backupset BS ON BS.backup_set_id = X.backup_set_id
						AND BS.compressed_backup_size < BS.backup_size
				WHERE
					X.backup_set_id <> ''NONE''
			 '
		)

END


IF EXISTS (SELECT * FROM dbo.#temp_sssr_last_backup_set X WHERE X.backup_set_id = 'NONE')
BEGIN

	UPDATE
		dbo.#temp_sssr_last_backup_set
	SET
		 backup_type = REPLICATE ('.', backup_type_length_max * 2)
		,software_version = REPLICATE ('.', software_version_length_max * 2)
		,database_version = REPLICATE ('.', database_version_length_max * 2)
		,[compatibility_level] = REPLICATE ('.', compatibility_level_length_max * 2)
		,server_name = REPLICATE ('.', server_name_length_max * 2)
		,machine_name = REPLICATE ('.', machine_name_length_max * 2)
		,physical_device_name = REPLICATE ('.', physical_device_name_length_max * 2)
		,backup_start_date = REPLICATE ('.', 34)
		,backup_finish_date = REPLICATE ('.', 34)
		,duration = REPLICATE ('.', (duration_length_max * 2) - 4)
		,backup_size_mb = REPLICATE ('.', backup_size_mb_length_max * 2)
		,compressed_size_mb = REPLICATE ('.', compressed_size_mb_length_max * 2)
		,compression_pct = REPLICATE ('.', compression_pct_length_max * 2)
		,days_ago = REPLICATE ('.', days_ago_length_max * 2)
	FROM

		(
			SELECT
				 MAX (LEN (X.backup_type)) AS backup_type_length_max
				,MAX (LEN (X.software_version)) AS software_version_length_max
				,MAX (LEN (X.database_version)) AS database_version_length_max
				,MAX (LEN (X.[compatibility_level])) AS compatibility_level_length_max
				,MAX (LEN (X.server_name)) AS server_name_length_max
				,MAX (LEN (X.machine_name)) AS machine_name_length_max
				,MAX (LEN (X.physical_device_name)) AS physical_device_name_length_max
				,MAX (LEN (X.duration)) AS duration_length_max
				,MAX (LEN (X.backup_size_mb)) AS backup_size_mb_length_max
				,MAX (LEN (X.compressed_size_mb)) AS compressed_size_mb_length_max
				,MAX (LEN (X.compression_pct)) AS compression_pct_length_max
				,MAX (LEN (X.days_ago)) AS days_ago_length_max
			FROM
				dbo.#temp_sssr_last_backup_set X
		) sqX

	WHERE
		dbo.#temp_sssr_last_backup_set.backup_set_id = 'NONE'

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',(CASE
							WHEN X.database_filter_id = 1 THEN X.database_name
							ELSE ''
							END) AS 'td'
					,'',X.backup_set_id AS 'td'
					,'',X.backup_type AS 'td'
					,'',X.software_version AS 'td'
					,'',X.database_version AS 'td'
					,'',X.[compatibility_level] AS 'td'
					,'',X.server_name AS 'td'
					,'',X.machine_name AS 'td'
					,'',X.physical_device_name AS 'td'
					,'',X.backup_start_date AS 'td'
					,'',X.backup_finish_date AS 'td'
					,'',X.duration AS 'td'
					,'','right_align' + X.backup_size_mb AS 'td'
					,'','right_align' + X.compressed_size_mb AS 'td'
					,'','right_align' + X.compression_pct AS 'td'
					,'','right_align' + X.days_ago AS 'td'
				FROM
					dbo.#temp_sssr_last_backup_set X
				ORDER BY
					 X.database_name
					,X.database_filter_id
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Last Backup Set Details</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Database Name</th>
						<th nowrap>Backup Set ID</th>
						<th nowrap>Backup Type</th>
						<th nowrap>Software Version</th>
						<th nowrap>Database Version</th>
						<th nowrap>Compatibility</th>
						<th nowrap>Server Name</th>
						<th nowrap>Machine Name</th>
						<th nowrap>Physical Device Name</th>
						<th nowrap>Backup Start Date</th>
						<th nowrap>Backup Finish Date</th>
						<th nowrap>Duration</th>
						<th nowrap>Backup Size (MB)</th>
						<th nowrap>Compressed Size (MB)</th>
						<th nowrap>Compression %</th>
						<th nowrap>Days Ago</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 (CASE
			WHEN X.database_filter_id = 1 THEN X.database_name
			ELSE ''
			END) AS database_name
		,X.backup_set_id
		,X.backup_type
		,X.software_version
		,X.database_version
		,X.[compatibility_level]
		,X.server_name
		,X.machine_name
		,X.physical_device_name
		,X.backup_start_date
		,X.backup_finish_date
		,X.duration
		,X.backup_size_mb
		,X.compressed_size_mb
		,X.compression_pct
		,X.days_ago
	FROM
		dbo.#temp_sssr_last_backup_set X
	ORDER BY
		 X.database_name
		,X.database_filter_id

END


Skip_Last_Backup_Set:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_last_backup_set', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_last_backup_set

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query VII: SQL Server Agent Jobs (Last 24 Hours)
-----------------------------------------------------------------------------------------------------------------------------

IF @Agent_Jobs = 0
BEGIN

	GOTO Skip_Agent_Jobs

END


SELECT
	 SJ.name AS job_name
	,SUSER_SNAME (SJ.owner_sid) AS job_owner
	,CONVERT (VARCHAR (19), SJ.date_created, 120) AS date_created
	,CONVERT (VARCHAR (19), SJ.date_modified, 120) AS date_modified
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, SJ.version_number), 1)), 4, 23)) AS [version]
	,SC.name AS category
	,(CASE SC.category_class
		WHEN 1 THEN 'Job'
		WHEN 2 THEN 'Alert'
		WHEN 3 THEN 'Operator'
		ELSE 'N/A'
		END) AS class
	,(CASE SC.category_type
		WHEN 1 THEN 'Local'
		WHEN 2 THEN 'Multiserver'
		WHEN 3 THEN 'None'
		ELSE 'N/A'
		END) AS [type]
	,CONVERT (VARCHAR (19), caLRDT.last_run_date_time, 120) AS last_run_date_time
	,(CASE SJH.run_status
		WHEN 0 THEN 'Failed'
		WHEN 1 THEN 'Succeeded'
		WHEN 2 THEN 'Retry'
		WHEN 3 THEN 'Canceled'
		WHEN 4 THEN 'In Progress'
		END) AS last_status
	,(CASE
		WHEN SJH.run_duration = 0 THEN '__:__:__'
		WHEN LEN (SJH.run_duration) <= 2 THEN '__:__:' + RIGHT ('0' + CONVERT (VARCHAR (2), SJH.run_duration), 2)
		WHEN LEN (SJH.run_duration) <= 4 THEN '__:' + STUFF (RIGHT ('0' + CONVERT (VARCHAR (4), SJH.run_duration), 4), 3, 0, ':')
		ELSE STUFF (STUFF (RIGHT ('0' + CONVERT (VARCHAR (6), SJH.run_duration), 6), 5, 0, ':'), 3, 0, ':')
		END) AS duration
	,ISNULL ((CASE
				WHEN SJ.[enabled] = 1 THEN CONVERT (VARCHAR (19), sqNRDT.next_run_date_time, 120)
				END), '___________________') AS next_run_date_time
	,ISNULL ((CASE
				WHEN SJ.[enabled] = 1 THEN REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DATEDIFF (DAY, GETDATE (), sqNRDT.next_run_date_time)), 1)), 4, 23))
				END), 'N/A') AS days_away
INTO
	dbo.#temp_sssr_agent_jobs
FROM
	msdb.dbo.sysjobs SJ
	INNER JOIN msdb.dbo.sysjobhistory SJH ON SJH.job_id = SJ.job_id
	INNER JOIN msdb.dbo.syscategories SC ON SC.category_id = SJ.category_id
	INNER JOIN

		(
			SELECT
				MAX (XSJ.instance_id) AS instance_id_max
			FROM
				msdb.dbo.sysjobhistory XSJ
			GROUP BY
				XSJ.job_id
		) sqIIM ON sqIIM.instance_id_max = SJH.instance_id

	LEFT JOIN

		(
			SELECT
				 SJS.job_id
				,MIN (CONVERT (DATETIME, CONVERT (VARCHAR (8), SJS.next_run_date) + ' ' + STUFF (STUFF (RIGHT ('000000' + CONVERT (VARCHAR (6), SJS.next_run_time), 6), 5, 0, ':'), 3, 0, ':'))) AS next_run_date_time
			FROM
				msdb.dbo.sysjobschedules SJS
				INNER JOIN msdb.dbo.sysschedules SS ON SS.schedule_id = SJS.schedule_id
					AND SS.[enabled] = 1
			WHERE
				SJS.next_run_date > 0
			GROUP BY
				SJS.job_id
		) sqNRDT ON sqNRDT.job_id = SJ.job_id

	CROSS APPLY

		(
			SELECT
				CONVERT (DATETIME, CONVERT (VARCHAR (8), SJH.run_date) + ' ' + STUFF (STUFF (RIGHT ('000000' + CONVERT (VARCHAR (6), SJH.run_time), 6), 5, 0, ':'), 3, 0, ':')) AS last_run_date_time
		) caLRDT

WHERE
	caLRDT.last_run_date_time >= @Date_24_Hours_Ago


IF @@ROWCOUNT = 0
BEGIN

	GOTO Skip_Agent_Jobs

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.job_name AS 'td'
					,'',X.job_owner AS 'td'
					,'',X.date_created AS 'td'
					,'',X.date_modified AS 'td'
					,'','right_align' + X.[version] AS 'td'
					,'',X.category AS 'td'
					,'',X.class AS 'td'
					,'',X.[type] AS 'td'
					,'',X.last_run_date_time AS 'td'
					,'',X.last_status AS 'td'
					,'',X.duration AS 'td'
					,'',X.next_run_date_time AS 'td'
					,'','right_align' + X.days_away AS 'td'
				FROM
					dbo.#temp_sssr_agent_jobs X
				ORDER BY
					X.job_name
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>SQL Server Agent Jobs (Last 24 Hours)</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Job Name</th>
						<th nowrap>Job Owner</th>
						<th nowrap>Date Created</th>
						<th nowrap>Date Modified</th>
						<th nowrap>Version</th>
						<th nowrap>Category</th>
						<th nowrap>Class</th>
						<th nowrap>Type</th>
						<th nowrap>Last Run Date / Time</th>
						<th nowrap>Last Status</th>
						<th nowrap>Duration</th>
						<th nowrap>Next Run Date / Time</th>
						<th nowrap>Days Away</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.job_name
		,X.job_owner
		,X.date_created
		,X.date_modified
		,X.[version]
		,X.category
		,X.class
		,X.[type]
		,X.last_run_date_time
		,X.last_status
		,X.duration
		,X.next_run_date_time
		,X.days_away
	FROM
		dbo.#temp_sssr_agent_jobs X
	ORDER BY
		X.job_name

END


Skip_Agent_Jobs:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_agent_jobs', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_agent_jobs

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query VIII: Index Fragmentation
-----------------------------------------------------------------------------------------------------------------------------

IF @Fragmentation = 0
BEGIN

	GOTO Skip_Index_Fragmentation

END


CREATE TABLE dbo.#temp_sssr_index_fragmentation

	(
		 object_type CHAR (2)
		,database_name NVARCHAR (128)
		,[schema_name] SYSNAME
		,[object_name] SYSNAME
		,index_name SYSNAME
		,index_key NVARCHAR (MAX)
		,include_key NVARCHAR (MAX)
		,filter_definition NVARCHAR (MAX)
		,fragmentation VARCHAR (23)
		,index_type NVARCHAR (120)
		,is_pk VARCHAR (3)
		,is_unique VARCHAR (3)
		,recommendation VARCHAR (10)
		,row_count VARCHAR (23)
		,alter_index_statement NVARCHAR (4000)
	)


SET @Database_Name_Loop =

	(
		SELECT TOP (1)
			X.database_name
		FROM
			dbo.#temp_sssr_databases X
		WHERE
			X.database_name <> N'tempdb'
		ORDER BY
			X.database_name
	)


WHILE @Database_Name_Loop IS NOT NULL
BEGIN

	SET @Database_ID = DB_ID (@Database_Name_Loop)


	SET @SQL_String = @Avoid_Truncation +

		N'
			USE [' + @Database_Name_Loop + N']


			INSERT INTO dbo.#temp_sssr_index_fragmentation

				(
					 object_type
					,database_name
					,[schema_name]
					,[object_name]
					,index_name
					,index_key
					,include_key
					,filter_definition
					,fragmentation
					,index_type
					,is_pk
					,is_unique
					,recommendation
					,row_count
					,alter_index_statement
				)

			SELECT
				 sqIF.[type] AS object_type
				,DB_NAME () AS database_name
				,SCHEMA_NAME (sqIF.[schema_id]) AS [schema_name]
				,sqIF.[object_name]
				,sqIF.index_name
				,sqIF.index_key
				,sqIF.include_key
				,sqIF.filter_definition
				,CONVERT (VARCHAR (23), CONVERT (MONEY, sqIF.avg_fragmentation_in_percent), 1) AS fragmentation
				,sqIF.type_desc AS index_type
				,(CASE sqIF.is_primary_key
					WHEN 0 THEN ''No''
					WHEN 1 THEN ''Yes''
					ELSE ''N/A''
					END) AS is_pk
				,(CASE sqIF.is_unique
					WHEN 0 THEN ''No''
					WHEN 1 THEN ''Yes''
					ELSE ''N/A''
					END) AS is_unique
				,caREC.recommendation
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, sqIF.[rows]), 1)), 4, 23)) AS row_count
				,N''USE [''
				 + DB_NAME ()
				 + N'']; ALTER INDEX [''
				 + sqIF.index_name
				 + N''] ON [''
				 + SCHEMA_NAME (sqIF.[schema_id])
				 + N''].[''
				 + sqIF.[object_name]
				 + N''] ''
				 + caREC.recommendation
				 + (CASE caREC.recommendation
						WHEN ''REBUILD'' THEN N'' WITH (MAXDOP = 1)''
						ELSE N''''
						END)
				 + N'';'' AS alter_index_statement
			FROM

				(
					SELECT
						 O.[type]
						,O.[schema_id]
						,O.name AS [object_name]
						,I.name AS index_name
						,STUFF (CONVERT (NVARCHAR (MAX), (caIIF.index_key)), 1, 2, N'''') AS index_key
						,ISNULL (STUFF (CONVERT (NVARCHAR (MAX), (caIIF.include_key)), 1, 2, N''''), N'''') AS include_key
						,' + @Filter_Definition_String + N' AS filter_definition
						,DDIPS.avg_fragmentation_in_percent
						,I.type_desc
						,I.is_primary_key
						,I.is_unique
						,ttSRC.[rows]
						,ROW_NUMBER () OVER
										(
											PARTITION BY
												I.name
											ORDER BY
												DDIPS.avg_fragmentation_in_percent DESC
										) AS row_number_id
					FROM
						sys.dm_db_index_physical_stats (' + CONVERT (NVARCHAR (11), @Database_ID) + N', NULL, NULL, NULL, N''LIMITED'') DDIPS
						INNER JOIN sys.objects O ON O.[object_id] = DDIPS.[object_id]
							AND O.[type] IN (''U'', ''V'')
							AND O.is_ms_shipped = 0
							AND NOT

								(
									SCHEMA_NAME (O.[schema_id]) = N''dbo''
									AND O.name = N''sysdiagrams''
									AND O.[type] = ''U''
								)

						INNER JOIN sys.indexes I ON I.[object_id] = DDIPS.[object_id]
							AND I.index_id = DDIPS.index_id
							AND I.is_disabled <> 1
							AND I.is_hypothetical <> 1
						INNER JOIN dbo.#temp_sssr_row_counts ttSRC ON ttSRC.[object_id] = DDIPS.[object_id]
							AND ttSRC.database_id = DB_ID ()
						CROSS APPLY

							(
								SELECT
									 (
										SELECT
											  N'', ''
											+ C.name AS [text()]
										FROM
											sys.index_columns IC
											INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
												AND C.column_id = IC.column_id
										WHERE
											IC.is_included_column = 0
											AND IC.[object_id] = I.[object_id]
											AND IC.index_id = I.index_id
										ORDER BY
											IC.key_ordinal
										FOR
											 XML PATH ('''')
											,TYPE
									 ) AS index_key
									,(
										SELECT
											  N'', ''
											+ C.name AS [text()]
										FROM
											sys.index_columns IC
											INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
												AND C.column_id = IC.column_id
										WHERE
											IC.is_included_column = 1
											AND IC.[object_id] = I.[object_id]
											AND IC.index_id = I.index_id
										ORDER BY
											IC.key_ordinal
										FOR
											 XML PATH ('''')
											,TYPE
									 ) AS include_key
							) caIIF

					WHERE
						DDIPS.index_id <> 0
						AND DDIPS.avg_fragmentation_in_percent > 5
				) sqIF

				CROSS APPLY

					(
						SELECT
							(CASE
								WHEN sqIF.avg_fragmentation_in_percent <= 30.0 THEN ''REORGANIZE''
								ELSE ''REBUILD''
								END) AS recommendation
					) caREC

			WHERE
				sqIF.row_number_id = 1
		 '


	EXECUTE (@SQL_String)


	SET @Database_Name_Loop =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				dbo.#temp_sssr_databases X
			WHERE
				X.database_name <> N'tempdb'
				AND X.database_name > @Database_Name_Loop
			ORDER BY
				X.database_name
		)

END


IF NOT EXISTS (SELECT * FROM dbo.#temp_sssr_index_fragmentation X)
BEGIN

	GOTO Skip_Index_Fragmentation

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.object_type AS 'td'
					,'',X.database_name AS 'td'
					,'',X.[schema_name] AS 'td'
					,'',X.[object_name] AS 'td'
					,'',X.index_name AS 'td'
					,'',X.index_key AS 'td'
					,'',X.include_key AS 'td'
					,'',X.filter_definition AS 'td'
					,'','right_align' + X.fragmentation AS 'td'
					,'',X.index_type AS 'td'
					,'',X.is_pk AS 'td'
					,'',X.is_unique AS 'td'
					,'',X.recommendation AS 'td'
					,'','right_align' + X.row_count AS 'td'
					,'',X.alter_index_statement AS 'td'
				FROM
					dbo.#temp_sssr_index_fragmentation X
				ORDER BY
					 X.object_type
					,X.database_name
					,X.[schema_name]
					,X.[object_name]
					,X.index_name
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Index Fragmentation</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Object Type</th>
						<th nowrap>Database Name</th>
						<th nowrap>Schema Name</th>
						<th nowrap>Object Name</th>
						<th nowrap>Index Name</th>
						<th nowrap>Index Key</th>
						<th nowrap>Include Key</th>
						<th nowrap>Filter Definition</th>
						<th nowrap>Fragmentation</th>
						<th nowrap>Index Type</th>
						<th nowrap>PK</th>
						<th nowrap>Unique</th>
						<th nowrap>Recommendation</th>
						<th nowrap>Row Count</th>
						<th nowrap>Alter Index Statement</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.index_name
		,X.index_key
		,X.include_key
		,X.filter_definition
		,X.fragmentation
		,X.index_type
		,X.is_pk AS pk
		,X.is_unique AS [unique]
		,X.recommendation
		,X.row_count
		,X.alter_index_statement
	FROM
		dbo.#temp_sssr_index_fragmentation X
	ORDER BY
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.index_name

END


Skip_Index_Fragmentation:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_index_fragmentation', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_index_fragmentation

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query IX: Missing Indexes
-----------------------------------------------------------------------------------------------------------------------------

IF @Missing_Indexes = 0
BEGIN

	GOTO Skip_Missing_Indexes

END


CREATE TABLE dbo.#temp_sssr_missing_indexes

	(
		 object_type CHAR (2)
		,database_name NVARCHAR (128)
		,[schema_name] SYSNAME
		,[object_name] SYSNAME
		,unique_compiles VARCHAR (23)
		,user_seeks VARCHAR (23)
		,user_scans VARCHAR (23)
		,avg_total_user_cost VARCHAR (23)
		,avg_user_impact VARCHAR (23)
		,overall_impact VARCHAR (23)
		,impact_rank VARCHAR (23)
		,index_key NVARCHAR (MAX)
		,include_key NVARCHAR (MAX)
		,table_column_count VARCHAR (23)
		,index_column_count VARCHAR (23)
		,include_column_count VARCHAR (23)
		,index_pct_of_columns VARCHAR (23)
		,include_pct_of_columns VARCHAR (23)
		,total_pct_of_columns VARCHAR (23)
		,row_count VARCHAR (23)
		,create_index_statement NVARCHAR (MAX)
	)


SET @Database_Name_Loop =

	(
		SELECT TOP (1)
			X.database_name
		FROM
			dbo.#temp_sssr_databases X
		WHERE
			X.database_name <> N'tempdb'
		ORDER BY
			X.database_name
	)


WHILE @Database_Name_Loop IS NOT NULL
BEGIN

	SET @SQL_String = @Avoid_Truncation +

		N'
			USE [' + @Database_Name_Loop + N']


			INSERT INTO dbo.#temp_sssr_missing_indexes

				(
					 object_type
					,database_name
					,[schema_name]
					,[object_name]
					,unique_compiles
					,user_seeks
					,user_scans
					,avg_total_user_cost
					,avg_user_impact
					,overall_impact
					,impact_rank
					,index_key
					,include_key
					,table_column_count
					,index_column_count
					,include_column_count
					,index_pct_of_columns
					,include_pct_of_columns
					,total_pct_of_columns
					,row_count
					,create_index_statement
				)


			SELECT
				 O.[type] AS object_type
				,DB_NAME () AS database_name
				,SCHEMA_NAME (O.[schema_id]) AS [schema_name]
				,O.name AS [object_name]
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DDMIGS.unique_compiles), 1)), 4, 23)) AS unique_compiles
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DDMIGS.user_seeks), 1)), 4, 23)) AS user_seeks
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DDMIGS.user_scans), 1)), 4, 23)) AS user_scans
				,CONVERT (VARCHAR (23), CONVERT (MONEY, DDMIGS.avg_total_user_cost), 1) AS avg_total_user_cost
				,CONVERT (VARCHAR (23), CONVERT (MONEY, DDMIGS.avg_user_impact), 1) AS avg_user_impact
				,CONVERT (VARCHAR (23), CONVERT (MONEY, caIC.overall_impact), 1) AS overall_impact
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, DENSE_RANK () OVER
																										(
																											ORDER BY
																												caIC.overall_impact DESC
																										)), 1)), 4, 23)) AS impact_rank
				,ISNULL (DDMID.equality_columns + caIC.comma_or_not, N'''') + ISNULL (DDMID.inequality_columns, N'''') AS index_key
				,ISNULL (DDMID.included_columns, N'''') AS include_key
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, sqCC.table_column_count), 1)), 4, 23)) AS table_column_count
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, caIC.index_column_count), 1)), 4, 23)) AS index_column_count
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, caIC.include_column_count), 1)), 4, 23)) AS include_column_count
				,CONVERT (VARCHAR (23), CONVERT (MONEY, (caIC.index_column_count / sqCC.table_column_count) * 100), 1) AS index_pct_of_columns
				,CONVERT (VARCHAR (23), CONVERT (MONEY, (caIC.include_column_count / sqCC.table_column_count) * 100), 1) AS include_pct_of_columns
				,CONVERT (VARCHAR (23), CONVERT (MONEY, ((caIC.index_column_count + caIC.include_column_count) / sqCC.table_column_count) * 100), 1) AS total_pct_of_columns
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ttSRC.[rows]), 1)), 4, 23)) AS row_count
				,caCIS.create_index_statement
			FROM
				sys.objects O
				INNER JOIN sys.dm_db_missing_index_details DDMID ON DDMID.[object_id] = O.[object_id]
					AND DDMID.database_id = DB_ID ()
				INNER JOIN sys.dm_db_missing_index_groups DDMIG ON DDMIG.index_handle = DDMID.index_handle
				INNER JOIN sys.dm_db_missing_index_group_stats DDMIGS ON DDMIGS.group_handle = DDMIG.index_group_handle
				INNER JOIN

					(
						SELECT
							 C.[object_id]
							,COUNT (*) + .0 AS table_column_count
						FROM
							sys.columns C
						GROUP BY
							C.[object_id]
					) sqCC ON sqCC.[object_id] = O.[object_id]

				INNER JOIN dbo.#temp_sssr_row_counts ttSRC ON ttSRC.[object_id] = O.[object_id]
					AND ttSRC.database_id = DB_ID ()
				CROSS APPLY

					(
						SELECT
							 CONVERT (DECIMAL (18, 2), (DDMIGS.user_seeks + DDMIGS.user_scans) * (DDMIGS.avg_total_user_cost * DDMIGS.avg_user_impact)) AS overall_impact
							,ISNULL ((LEN (DDMID.equality_columns) - LEN (REPLACE (DDMID.equality_columns, N'','', N''''))) + 1, 0) + ISNULL ((LEN (DDMID.inequality_columns) - LEN (REPLACE (DDMID.inequality_columns, N'','', N''''))) + 1, 0) AS index_column_count
							,ISNULL ((LEN (DDMID.included_columns) - LEN (REPLACE (DDMID.included_columns, N'','', N''''))) + 1, 0) AS include_column_count
							,(CASE
								WHEN DDMID.inequality_columns IS NOT NULL THEN N'', ''
								ELSE N''''
								END) AS comma_or_not
							,N''IX_''
							 + O.name
							 + N''_''
							 + ISNULL (REPLACE (SUBSTRING (SUBSTRING (DDMID.equality_columns, 1, LEN (DDMID.equality_columns) - 1), 2, LEN (DDMID.equality_columns) - 1), N''], ['', N''_'')
							 + (CASE
									WHEN DDMID.inequality_columns IS NOT NULL THEN N''_''
									ELSE N''''
									END), N'''')
							 + ISNULL (REPLACE (SUBSTRING (SUBSTRING (DDMID.inequality_columns, 1, LEN (DDMID.inequality_columns) - 1), 2, LEN (DDMID.inequality_columns) - 1), N''], ['', N''_''), N'''')
							 + ISNULL (N''_i_'' + REPLACE (SUBSTRING (SUBSTRING (DDMID.included_columns, 1, LEN (DDMID.included_columns) - 1), 2, LEN (DDMID.included_columns) - 1), N''], ['', N''_''), N'''') AS index_base_string
					) caIC

				CROSS APPLY

					(
						SELECT
							N''CREATE NONCLUSTERED INDEX ''
							+ (CASE
									WHEN LEN (caIC.index_base_string COLLATE DATABASE_DEFAULT) > 128 THEN N''<INDEX NAME>''
									ELSE N''['' + caIC.index_base_string + N'']''
									END)
							+ N'' ON ''
							+ N''[''
							+ DB_NAME ()
							+ N'']''
							+ N''.''
							+ N''[''
							+ SCHEMA_NAME (O.[schema_id])
							+ N'']''
							+ N''.''
							+ N''[''
							+ O.name
							+ N'']''
							+ N'' (''
							+ ISNULL (DDMID.equality_columns + caIC.comma_or_not, N'''')
							+ ISNULL (DDMID.inequality_columns, N'''')
							+ N'')''
							+ ISNULL (N'' INCLUDE ('' + DDMID.included_columns + N'')'', N'''')
							+ N'';'' AS create_index_statement
					) caCIS

			WHERE
				O.[type] IN (''U'', ''V'')
				AND O.is_ms_shipped = 0
				AND NOT

					(
						SCHEMA_NAME (O.[schema_id]) = N''dbo''
						AND O.name = N''sysdiagrams''
						AND O.[type] = ''U''
					)
		 '


	EXECUTE (@SQL_String)


	SET @Database_Name_Loop =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				dbo.#temp_sssr_databases X
			WHERE
				X.database_name <> N'tempdb'
				AND X.database_name > @Database_Name_Loop
			ORDER BY
				X.database_name
		)

END


IF NOT EXISTS (SELECT * FROM dbo.#temp_sssr_missing_indexes X)
BEGIN

	GOTO Skip_Missing_Indexes

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.object_type AS 'td'
					,'',X.database_name AS 'td'
					,'',X.[schema_name] AS 'td'
					,'',X.[object_name] AS 'td'
					,'','right_align' + X.unique_compiles AS 'td'
					,'','right_align' + X.user_seeks AS 'td'
					,'','right_align' + X.user_scans AS 'td'
					,'','right_align' + X.avg_total_user_cost AS 'td'
					,'','right_align' + X.avg_user_impact AS 'td'
					,'','right_align' + X.overall_impact AS 'td'
					,'','right_align' + X.impact_rank AS 'td'
					,'',X.index_key AS 'td'
					,'',X.include_key AS 'td'
					,'','right_align' + X.table_column_count AS 'td'
					,'','right_align' + X.index_column_count AS 'td'
					,'','right_align' + X.include_column_count AS 'td'
					,'','right_align' + X.index_pct_of_columns AS 'td'
					,'','right_align' + X.include_pct_of_columns AS 'td'
					,'','right_align' + X.total_pct_of_columns AS 'td'
					,'','right_align' + X.row_count AS 'td'
					,'',X.create_index_statement AS 'td'
				FROM
					dbo.#temp_sssr_missing_indexes X
				ORDER BY
					 X.object_type
					,X.database_name
					,X.[schema_name]
					,X.[object_name]
					,X.impact_rank
					,X.index_key
					,X.include_key
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Missing Indexes</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Object Type</th>
						<th nowrap>Database Name</th>
						<th nowrap>Schema Name</th>
						<th nowrap>Object Name</th>
						<th nowrap>Unique Compiles</th>
						<th nowrap>User Seeks</th>
						<th nowrap>User Scans</th>
						<th nowrap>Avg User Cost</th>
						<th nowrap>Avg User Impact</th>
						<th nowrap>Overall Impact</th>
						<th nowrap>Impact Rank</th>
						<th nowrap>Index Key</th>
						<th nowrap>Include Key</th>
						<th nowrap>Table Column Count</th>
						<th nowrap>Index Column Count</th>
						<th nowrap>Include Column Count</th>
						<th nowrap>Index % Of Columns</th>
						<th nowrap>Include % Of Columns</th>
						<th nowrap>Total % Of Columns</th>
						<th nowrap>Row Count</th>
						<th nowrap>Create Index Statement</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.unique_compiles
		,X.user_seeks
		,X.user_scans
		,X.avg_total_user_cost AS avg_user_cost
		,X.avg_user_impact
		,X.overall_impact
		,X.impact_rank
		,X.index_key
		,X.include_key
		,X.table_column_count
		,X.index_column_count
		,X.include_column_count
		,X.index_pct_of_columns
		,X.include_pct_of_columns
		,X.total_pct_of_columns
		,X.row_count
		,X.create_index_statement
	FROM
		dbo.#temp_sssr_missing_indexes X
	ORDER BY
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.impact_rank
		,X.index_key
		,X.include_key

END


Skip_Missing_Indexes:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_missing_indexes', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_missing_indexes

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query X: Unused Indexes
-----------------------------------------------------------------------------------------------------------------------------

IF @Unused_Indexes = 0
BEGIN

	GOTO Skip_Unused_Indexes

END


CREATE TABLE dbo.#temp_sssr_unused_indexes

	(
		 object_type CHAR (2)
		,database_name NVARCHAR (128)
		,[schema_name] SYSNAME
		,[object_name] SYSNAME
		,index_name SYSNAME
		,index_key NVARCHAR (MAX)
		,include_key NVARCHAR (MAX)
		,filter_definition NVARCHAR (MAX)
		,[disabled] VARCHAR (3)
		,hypothetical VARCHAR (3)
		,row_count VARCHAR (23)
		,drop_index_statement NVARCHAR (4000)
	)


SET @Database_Name_Loop =

	(
		SELECT TOP (1)
			X.database_name
		FROM
			dbo.#temp_sssr_databases X
		WHERE
			X.database_name <> N'tempdb'
		ORDER BY
			X.database_name
	)


WHILE @Database_Name_Loop IS NOT NULL
BEGIN

	SET @SQL_String = @Avoid_Truncation +

		N'
			USE [' + @Database_Name_Loop + N']


			INSERT INTO dbo.#temp_sssr_unused_indexes

				(
					 object_type
					,database_name
					,[schema_name]
					,[object_name]
					,index_name
					,index_key
					,include_key
					,filter_definition
					,[disabled]
					,hypothetical
					,row_count
					,drop_index_statement
				)

			SELECT
				 O.[type] AS object_type
				,DB_NAME () AS database_name
				,SCHEMA_NAME (O.schema_id) AS [schema_name]
				,O.name AS [object_name]
				,I.name AS index_name
				,STUFF (CONVERT (NVARCHAR (MAX), (caIIF.index_key)), 1, 2, N'''') AS index_key
				,ISNULL (STUFF (CONVERT (NVARCHAR (MAX), (caIIF.include_key)), 1, 2, N''''), N'''') AS include_key
				,' + @Filter_Definition_String + N' AS filter_definition
				,(CASE
					WHEN I.is_disabled = 1 THEN ''Yes''
					ELSE ''No''
					END) AS [disabled]
				,(CASE
					WHEN I.is_hypothetical = 1 THEN ''Yes''
					ELSE ''No''
					END) AS hypothetical
				,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, ttSRC.[rows]), 1)), 4, 23)) AS row_count
				,N''USE [''
				 + DB_NAME ()
				 + N'']; IF EXISTS (SELECT * FROM sys.indexes I WHERE I.[object_id] = ''
				 + CONVERT (VARCHAR (11), I.[object_id])
				 + N'' AND I.index_id = ''
				 + CONVERT (VARCHAR (11), I.index_id)
				 + N'') BEGIN DROP INDEX [''
				 + I.name
				 + N''] ON [''
				 + SCHEMA_NAME (O.schema_id)
				 + N''].[''
				 + O.name
				 + N''] END;'' AS drop_index_statement
			FROM
				sys.indexes I
				INNER JOIN sys.objects O ON O.[object_id] = I.[object_id]
					AND O.[type] IN (''U'', ''V'')
					AND O.is_ms_shipped = 0
					AND NOT

						(
							SCHEMA_NAME (O.[schema_id]) = N''dbo''
							AND O.name = N''sysdiagrams''
							AND O.[type] = ''U''
						)

				INNER JOIN dbo.#temp_sssr_row_counts ttSRC ON ttSRC.[object_id] = I.[object_id]
					AND ttSRC.database_id = DB_ID ()
				CROSS APPLY

					(
						SELECT
							 (
								SELECT
									  N'', ''
									+ C.name AS [text()]
								FROM
									sys.index_columns IC
									INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
										AND C.column_id = IC.column_id
								WHERE
									IC.is_included_column = 0
									AND IC.[object_id] = I.[object_id]
									AND IC.index_id = I.index_id
								ORDER BY
									IC.key_ordinal
								FOR
									 XML PATH ('''')
									,TYPE
							 ) AS index_key
							,(
								SELECT
									  N'', ''
									+ C.name AS [text()]
								FROM
									sys.index_columns IC
									INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
										AND C.column_id = IC.column_id
								WHERE
									IC.is_included_column = 1
									AND IC.[object_id] = I.[object_id]
									AND IC.index_id = I.index_id
								ORDER BY
									IC.key_ordinal
								FOR
									 XML PATH ('''')
									,TYPE
							 ) AS include_key
					) caIIF

			WHERE
				I.[type] = 2
				AND I.is_primary_key = 0
				AND I.is_unique = 0
				AND NOT EXISTS

					(
						SELECT
							*
						FROM
							sys.index_columns XIC
							INNER JOIN sys.foreign_key_columns FKC ON FKC.parent_object_id = XIC.[object_id]
								AND FKC.parent_column_id = XIC.column_id
						WHERE
							XIC.[object_id] = I.[object_id]
							AND XIC.index_id = I.index_id
					)

				AND NOT EXISTS

					(
						SELECT
							*
						FROM
							master.sys.dm_db_index_usage_stats DDIUS
						WHERE
							DDIUS.database_id = DB_ID ()
							AND DDIUS.[object_id] = I.[object_id]
							AND DDIUS.index_id = I.index_id
					)
		 '


	EXECUTE (@SQL_String)


	SET @Database_Name_Loop =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				dbo.#temp_sssr_databases X
			WHERE
				X.database_name <> N'tempdb'
				AND X.database_name > @Database_Name_Loop
			ORDER BY
				X.database_name
		)

END


IF NOT EXISTS (SELECT * FROM dbo.#temp_sssr_unused_indexes X)
BEGIN

	GOTO Skip_Unused_Indexes

END


IF @Output_Mode = 'E'
BEGIN

	SET @XML_String =

		CONVERT (NVARCHAR (MAX),
			(
				SELECT
					 '',X.object_type AS 'td'
					,'',X.database_name AS 'td'
					,'',X.[schema_name] AS 'td'
					,'',X.[object_name] AS 'td'
					,'',X.index_name AS 'td'
					,'',X.index_key AS 'td'
					,'',X.include_key AS 'td'
					,'',X.filter_definition AS 'td'
					,'',X.[disabled] AS 'td'
					,'',X.hypothetical AS 'td'
					,'','right_align' + X.row_count AS 'td'
					,'',X.drop_index_statement AS 'td'
				FROM
					dbo.#temp_sssr_unused_indexes X
				ORDER BY
					 X.object_type
					,X.database_name
					,X.[schema_name]
					,X.[object_name]
					,X.index_name
				FOR
					XML PATH ('tr')
			)
		)


	SET @Body = @Body +

		N'
			<br>
			<h3><center>Unused Indexes</center></h3>
			<center>
				<table frame=box border=1 cellpadding=2>
					<tr style="color: white; background-color: black">
						<th nowrap>Object Type</th>
						<th nowrap>Database Name</th>
						<th nowrap>Schema Name</th>
						<th nowrap>Object Name</th>
						<th nowrap>Index Name</th>
						<th nowrap>Index Key</th>
						<th nowrap>Include Key</th>
						<th nowrap>Filter Definition</th>
						<th nowrap>Disabled</th>
						<th nowrap>Hypothetical</th>
						<th nowrap>Row Count</th>
						<th nowrap>Drop Index Statement</th>
					</tr>
		 '


	SET @Body = @Body + @XML_String +

		N'
				</table>
			</center>
		 '

END
ELSE BEGIN

	SELECT
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.index_name
		,X.index_key
		,X.include_key
		,X.filter_definition
		,X.[disabled]
		,X.hypothetical
		,X.row_count
		,X.drop_index_statement
	FROM
		dbo.#temp_sssr_unused_indexes X
	ORDER BY
		 X.object_type
		,X.database_name
		,X.[schema_name]
		,X.[object_name]
		,X.index_name

END


Skip_Unused_Indexes:


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_unused_indexes', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_unused_indexes

END


-----------------------------------------------------------------------------------------------------------------------------
--	Variable Update: Finalize "@Body" Variable Contents
-----------------------------------------------------------------------------------------------------------------------------

IF @Output_Mode = 'E'
BEGIN

	SET @Body =

		N'
			<html>
				<body>
				<style type="text/css">
					table {font-size: 8.0pt; font-family: Arial; text-align: left; white-space: nowrap; empty-cells: show}
					tbody tr:nth-child(odd) {background-color: #ccc;}
					tr {text-align: left;}
				</style>
		 '

		+ SUBSTRING (@Body, 10, LEN (@Body) - 10) +

		N'
				</body>
			</html>
		 '


	SET @Body = REPLACE (REPLACE (@Body, N'<td>', N'<td nowrap>'), N'<td nowrap>right_align', N'<td nowrap align="right">')

END


-----------------------------------------------------------------------------------------------------------------------------
--	sp_send_dbmail: Deliver Results / Notification To End User(s)
-----------------------------------------------------------------------------------------------------------------------------

IF @Output_Mode = 'E'
BEGIN

	EXECUTE msdb.dbo.sp_send_dbmail

		 @recipients = @Recipients
		,@copy_recipients = @Copy_Recipients
		,@subject = @Subject
		,@body = @Body
		,@body_format = 'HTML'

END


-----------------------------------------------------------------------------------------------------------------------------
--	Cleanup: Drop Any Remaining Temp Tables
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_databases', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_databases

END


IF OBJECT_ID (N'tempdb.dbo.#temp_sssr_row_counts', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_sssr_row_counts

END
GO
