SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Procedure Already Exists And Create Shell If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'dbo.usp_who5', N'P') IS NULL
BEGIN

	EXECUTE ('CREATE PROCEDURE dbo.usp_who5 AS SELECT 1 AS shell')

END
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Return Information Regarding Current Users / Sessions / Processes On A SQL Server Instance
--	Create Date (MM/DD/YYYY): 10/27/2009
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: Converted Script To Dynamic-SQL
--	           : Minor Changes To Code Style
--	           : Added "@Database" Filter Variable
--	           : Added "Last_Wait_Type", "Query_Plan_XML", And "Wait_Type" Fields To Output
--	Date (MM/DD/YYYY): 08/08/2011
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Renamed Input Variables
--	           : Added "Plan_Cache_Object_Type", "Plan_Object_Type", "Plan_Times_Used", And "Plan_Size_MB" Fields To Output
--	           : Changed Help Output From RAISERROR To PRINT
--	           : Merged "I?" And "O?" Help Parameters Into "?"
--	           : Added "C" Type "@Filter" Option
--	           : Rewrote Time Calculation Logic
--	Date (MM/DD/YYYY): 11/09/2011
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Expanded "Running" Type Indicators
--	           : Added System Reserved SPID Indicator To "SPECID"
--	           : Added "SQL_Statement_Current" And "End_Of_Batch" Fields To Output
--	Date (MM/DD/YYYY): 02/01/2012
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Minor Code Formatting Changes
--	           : Bug Fixes
--	           : Changes To Date Calculation Method
--	Date (MM/DD/YYYY): 08/19/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Added "Batch_Pct", "Command_Completion", "Command_Pct", "Command_Time_Left", "Deadlock_Priority", "Isolation_Level", "Last_Row_Count", "Lock_Details", "Lock_Timeout_Seconds", And "Previous_Error" Fields To Output
--	Date (MM/DD/YYYY): 11/24/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.usp_who5

	 @Filter AS VARCHAR (5) = NULL
	,@SPID AS SMALLINT = NULL
	,@Login AS NVARCHAR (128) = NULL
	,@Database AS NVARCHAR (512) = NULL
	,@SQL_Text AS NVARCHAR (MAX) = NULL

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If "@Filter" Parameter Is An Input / Output Help Request
-----------------------------------------------------------------------------------------------------------------------------

IF @Filter = '?'
BEGIN

	PRINT

		N'
Optional Input Parameters:

	@Filter   : Limit the result set by passing one or more values listed below (can be combined in any order)

		A - Active sessions only
		B - Blocked sessions only
		C - Exclude "SQL_Statement_Batch", "SQL_Statement_Current", "Batch_Pct", and "Query_Plan_XML" columns from the output (less resource-intensive)
		X - Exclude system reserved SPIDs (1-50)

	@SPID     : Limit the result set to a specific session
	@Login    : Limit the result set to a specific Windows user name (if populated, otherwise by SQL Server login name)
	@Database : Limit the result set to a specific database
	@SQL_Text : Limit the result set to SQL statements containing specific text (ignored when "@Filter" parameter contains "C")


Notes:

	Blocked sessions will be displayed first in the result set (when applicable)
		 '


	PRINT

		N'
Output:

	SPECID                  : System Process ID with Execution Context ID
	Blocked                 : Blocking indicator (includes type of block and blocking SPID)
	Running                 : Indicates if the session is executing (X), waiting (*), inactive (blank), has open transactions (•), or is a background task (--)
	Login_ID                : Windows user name (or login name if user name is unavailable)
	Login_Name              : Full name of the user associated to the "Login_ID" (if available)
	Elapsed_Time            : Elapsed time since the request began (DAYS HH:MM:SS)
	CPU_Total               : CPU time used since login (DAYS HH:MM:SS)
	CPU_Current             : CPU time used for the current process (DAYS HH:MM:SS)
	Logical_Reads           : Logical reads performed by the current process
	Physical_Reads          : Physical reads performed by the current process
	Writes                  : Writes performed by the current process
	Pages_Used              : Pages in the procedure cache allocated to the process
	Nesting_Level           : Nesting level of the statement currently executing
	Open_Trans              : Open transactions for the process
	Last_Row_Count          : Row count produced by the last statement executed in the batch
	Wait_Time               : Current wait time (DAYS HH:MM:SS)
	Wait_Type               : Current wait type
	Last_Wait_Type          : Previous wait type
	Status                  : Status of the current process
	Command                 : Command currently being executed
	Isolation_Level         : Isolation level of the session
	SQL_Statement_Batch     : Batch statement of the session
	SQL_Statement_Current   : Current statement of the session
	Batch_Pct               : Percentage of the batch which has been processed
	End_Of_Batch            : Indicates if the current statement is the last of the entire batch
	Command_Pct             : Percentage of work completed (applicable to a limited set of commands)
	Command_Time_Left       : Time left before the command completes (DAYS HH:MM:SS)
	Command_Completion      : Estimated completion time for the command
	Previous_Error          : Previous error returned by the session
	Lock_Details            : Lock details of the session (in XML format)
	Lock_Timeout_Seconds    : Lock timeout of the session
	Deadlock_Priority       : Deadlock priority of the session
	Plan_Handle             : Identifier for the in-memory plan
	Query_Plan_XML          : Execution plan of the session (in XML format)
	Plan_Cache_Object_Type  : Displays which mechanism is being used for the cached plan (used in conjunction with "Plan_Object_Type")
	Plan_Object_Type        : Displays which mechanism is being used for the cached plan (used in conjunction with "Plan_Cache_Object_Type")
	Plan_Times_Used         : Number of times the plan has been utilized since its creation
	Plan_Size_MB            : Size consumed by the plan in megabytes
	Since_SPID_Login        : Elapsed time since the client logged in (DAYS HH:MM:SS)
	Since_Last_Batch        : Elapsed time since the client last completed a batch request (DAYS HH:MM:SS)
	Workstation_Name        : Workstation name
	Database_Name           : Database context of the session
	Application_Description : Application accessing SQL Server
	SPECID                  : System Process ID with Execution Context ID
		 '


	RETURN

END


-----------------------------------------------------------------------------------------------------------------------------
--	Declarations / Sets: Declare And Set Variables
-----------------------------------------------------------------------------------------------------------------------------

DECLARE
	 @Filter_Active AS BIT
	,@Filter_Blocked AS BIT
	,@Filter_Column AS BIT
	,@Filter_System AS BIT
	,@SQL_String AS VARCHAR (MAX)


SET @Login = NULLIF (@Login, N'')
SET @Database = NULLIF (@Database, N'')
SET @SQL_Text = NULLIF (REPLACE (@SQL_Text, N'''', N''''''), N'')
SET @Filter_Active = (CASE
						WHEN @Filter LIKE '%A%' THEN 1
						ELSE 0
						END)
SET @Filter_Blocked = (CASE
						WHEN @Filter LIKE '%B%' THEN 1
						ELSE 0
						END)
SET @Filter_Column = (CASE
						WHEN @Filter LIKE '%C%' THEN 1
						ELSE 0
						END)
SET @Filter_System = (CASE
						WHEN @Filter LIKE '%X%' THEN 1
						ELSE 0
						END)


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SET @SQL_String =

	'
		SELECT
			 CONVERT (VARCHAR (6), SP.spid) + ''.'' + CONVERT (VARCHAR (6), SP.ecid) + (CASE
																							WHEN SP.spid = @@SPID THEN '' ••''
																							WHEN SP.spid <= 50 THEN '' •''
																							ELSE ''''
																							END) AS SPECID
			,(CASE
				WHEN SP.blocked = 0 AND sqBLKD.blocked IS NULL THEN ''·············''
				WHEN SP.blocked = SP.spid THEN ''> Parallelism <''
				WHEN SP.blocked = 0 AND sqBLKD.blocked IS NOT NULL THEN ''>> BLOCKING <<''
				ELSE ''SPID: '' + CONVERT (VARCHAR (6), sqBLKR.spid) + ''  •  '' + (CASE
																						WHEN sqBLKR.Login_ID_Blocking = ''sa'' THEN ''<< System Administrator >>''
																						ELSE ISNULL (sqBLKR.Login_ID_Blocking, ''N/A'')
																						END)
				END) AS Blocked
			,(CASE
				WHEN SP.[status] = ''background'' THEN ''     --''
				WHEN SP.[status] IN (''dormant'', ''sleeping'') AND SP.open_tran = 0 THEN ''''
				WHEN SP.[status] IN (''dormant'', ''sleeping'') THEN ''     •''
				WHEN SP.[status] IN (''defwakeup'', ''pending'', ''spinloop'', ''suspended'') THEN ''     *''
				ELSE ''     X''
				END) AS Running
			,ISNULL (NULLIF (SP.nt_username, ''''), SP.loginame) AS Login_ID
			,ISNULL ((CASE
						WHEN SP.loginame = ''sa'' THEN ''<< System Administrator >>''
						ELSE SP.loginame
						END), '''') AS Login_Name
			,ISNULL ((CASE
						WHEN oaDHMS.total_elapsed_time_days <= 0 THEN REPLICATE (''_'', cjMAX.total_elapsed_time_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.total_elapsed_time_days_length_max - LEN (oaDHMS.total_elapsed_time_days)) + oaDHMS.total_elapsed_time_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.total_elapsed_time_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.total_elapsed_time_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.total_elapsed_time_hhmmss, 2)
													WHEN LEFT (oaDHMS.total_elapsed_time_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.total_elapsed_time_hhmmss, 5)
													ELSE oaDHMS.total_elapsed_time_hhmmss
													END), '''') AS Elapsed_Time
			,ISNULL ((CASE
						WHEN oaDHMS.cpu_days <= 0 THEN REPLICATE (''_'', cjMAX.cpu_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.cpu_days_length_max - LEN (oaDHMS.cpu_days)) + oaDHMS.cpu_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.cpu_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.cpu_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.cpu_hhmmss, 2)
													WHEN LEFT (oaDHMS.cpu_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.cpu_hhmmss, 5)
													ELSE oaDHMS.cpu_hhmmss
													END), '''') AS CPU_Total
			,ISNULL ((CASE
						WHEN oaDHMS.cpu_time_days <= 0 THEN REPLICATE (''_'', cjMAX.cpu_time_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.cpu_time_days_length_max - LEN (oaDHMS.cpu_time_days)) + oaDHMS.cpu_time_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.cpu_time_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.cpu_time_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.cpu_time_hhmmss, 2)
													WHEN LEFT (oaDHMS.cpu_time_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.cpu_time_hhmmss, 5)
													ELSE oaDHMS.cpu_time_hhmmss
													END), '''') AS CPU_Current
			,ISNULL (CONVERT (VARCHAR (20), DER.logical_reads), '''') AS Logical_Reads
			,ISNULL (CONVERT (VARCHAR (20), DER.reads), '''') AS Physical_Reads
			,ISNULL (CONVERT (VARCHAR (20), DER.writes), '''') AS Writes
			,(CASE
				WHEN SP.memusage = 0 THEN ''''
				ELSE CONVERT (VARCHAR (10), SP.memusage)
				END) AS Pages_Used
			,ISNULL (CONVERT (VARCHAR (15), DER.nest_level), '''') AS Nesting_Level
			,(CASE
				WHEN SP.open_tran = 0 THEN ''''
				ELSE CONVERT (VARCHAR (10), SP.open_tran)
				END) AS Open_Trans
			,ISNULL (CONVERT (VARCHAR (20), NULLIF (DXS.row_count, 0)), '''') AS Last_Row_Count
			,ISNULL ((CASE
						WHEN oaDHMS.waittime_days <= 0 THEN REPLICATE (''_'', cjMAX.waittime_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.waittime_days_length_max - LEN (oaDHMS.waittime_days)) + oaDHMS.waittime_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.waittime_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.waittime_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.waittime_hhmmss, 2)
													WHEN LEFT (oaDHMS.waittime_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.waittime_hhmmss, 5)
													ELSE oaDHMS.waittime_hhmmss
													END), '''') AS Wait_Time
			,ISNULL (DER.wait_type, '''') AS Wait_Type
			,ISNULL (DER.last_wait_type, '''') AS Last_Wait_Type
			,RTRIM ((CASE
						WHEN SP.[status] NOT IN (''dormant'', ''sleeping'') THEN UPPER (SP.[status])
						ELSE LOWER (SP.[status])
						END)) AS [Status]
			,RTRIM ((CASE
						WHEN SP.cmd = ''awaiting command'' THEN LOWER (SP.cmd)
						ELSE UPPER (SP.cmd)
						END)) AS Command
			,(CASE DXS.transaction_isolation_level
				WHEN 0 THEN ''UNSPECIFIED''
				WHEN 1 THEN ''READ UNCOMMITTED''
				WHEN 2 THEN ''READ COMMITTED''
				WHEN 3 THEN ''REPEATABLE READ''
				WHEN 4 THEN ''SERIALIZABLE''
				WHEN 5 THEN ''SNAPSHOT''
				ELSE ''ERROR''
				END) AS Isolation_Level
	'


IF @Filter_Column = 0
BEGIN

	SET @SQL_String = @SQL_String +

		'
			,ISNULL (DEST.[text], '''') AS SQL_Statement_Batch
			,ISNULL ((CASE
						WHEN SP.stmt_start = 0 AND SP.stmt_end = -1 THEN N''<< Single Statement >>''
						WHEN SP.stmt_end = -1 THEN SUBSTRING (DEST.[text], SP.stmt_start / 2, (DATALENGTH (DEST.[text]) - SP.stmt_start) / 2)
						ELSE SUBSTRING (DEST.[text], SP.stmt_start / 2, (SP.stmt_end - SP.stmt_start) / 2)
						END), '''') AS SQL_Statement_Current
			,ISNULL ((CASE
						WHEN SP.[status] IN (''dormant'', ''sleeping'') AND SP.open_tran <> 0 THEN ''100.00''
						WHEN SP.stmt_start = 0 AND SP.stmt_end = 0 THEN ''''
						WHEN SP.stmt_start = 0 THEN ''0.00''
						ELSE CONVERT (VARCHAR (20), CONVERT (DECIMAL (20, 2), ROUND (((SP.stmt_start - 2.0) / DATALENGTH (DEST.[text])) * 100, 2)))
						END), '''') AS Batch_Pct
		'

END


SET @SQL_String = @SQL_String +

	'
		,(CASE
			WHEN SP.stmt_end = -1 THEN ''Yes''
			WHEN SP.stmt_end > 0 THEN ''No''
			ELSE ''''
			END) AS End_Of_Batch
		,ISNULL ((CASE DER.percent_complete
					WHEN 0 THEN ''''
					ELSE CONVERT (VARCHAR (6), CONVERT (DECIMAL (5,2), DER.percent_complete))
					END), '''') AS Command_Pct
		,ISNULL ((CASE
					WHEN oaDHMS.estimated_completion_time_days <= 0 THEN REPLICATE (''_'', cjMAX.estimated_completion_time_days_length_max)
					ELSE REPLICATE (''0'', cjMAX.estimated_completion_time_days_length_max - LEN (oaDHMS.estimated_completion_time_days)) + oaDHMS.estimated_completion_time_days
					END) + '' Day(s) '' + (CASE
												WHEN oaDHMS.estimated_completion_time_hhmmss = ''00:00:00'' THEN ''__:__:__''
												WHEN LEFT (oaDHMS.estimated_completion_time_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.estimated_completion_time_hhmmss, 2)
												WHEN LEFT (oaDHMS.estimated_completion_time_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.estimated_completion_time_hhmmss, 5)
												ELSE oaDHMS.estimated_completion_time_hhmmss
												END), '''') AS Command_Time_Left
		,ISNULL ((CASE DER.percent_complete
					WHEN 0 THEN ''''
					ELSE CONVERT (VARCHAR (19), DATEADD (MILLISECOND, DER.estimated_completion_time, GETDATE()), 120)
					END), '''') AS Command_Completion
		,ISNULL (CONVERT (NVARCHAR (11), NULLIF (DXS.prev_error, 0))
		 + N'': ''
		 + M.[text]
		 + N'' (Severity ''
		 + CONVERT (NVARCHAR (3), M.severity)
		 + N'', ''
		 + (CASE
				WHEN M.is_event_logged = 0 THEN N''Not Logged''
				WHEN M.is_event_logged = 1 THEN N''Logged''
				END)
		 + N'')'', N'''') AS Previous_Error
		,ISNULL ((
					SELECT DISTINCT
						(CASE
							WHEN SLI.rsc_type = 2 THEN DB_NAME (SLI.rsc_dbid)
							WHEN SLI.rsc_type = 5 AND SLI.req_mode IN (1, 2) THEN N''LOCKED''
							ELSE ISNULL (OBJECT_NAME (SLI.rsc_objid, SLI.rsc_dbid), N''N/A'')
							END)
						+ N'': ''
						+ (CASE SLI.rsc_type
								WHEN 1 THEN N''NULL Resource''
								WHEN 2 THEN N''Database''
								WHEN 3 THEN N''File''
								WHEN 4 THEN N''Index''
								WHEN 5 THEN N''Object''
								WHEN 6 THEN N''Page''
								WHEN 7 THEN N''Key''
								WHEN 8 THEN N''Extent''
								WHEN 9 THEN N''Row ID (RID)''
								WHEN 10 THEN N''Application''
								WHEN 11 THEN N''Metadata''
								WHEN 12 THEN N''HoBt''
								WHEN 13 THEN N''Allocation Unit''
								ELSE N''N/A''
								END)
						+ ISNULL (N'' ['' + CONVERT (NVARCHAR (11), NULLIF (SLI.rsc_indid, 0)) + N'']'', N'''')
						+ N'' - ''
						+ (CASE SLI.req_mode
								WHEN 0 THEN N''NULL Resource''
								WHEN 1 THEN N''Sch-S: Schema Stability''
								WHEN 2 THEN N''Sch-M: Schema Modification''
								WHEN 3 THEN N''S: Shared''
								WHEN 4 THEN N''U: Update''
								WHEN 5 THEN N''X: Exclusive''
								WHEN 6 THEN N''IS: Intent Shared''
								WHEN 7 THEN N''IU: Intent Update''
								WHEN 8 THEN N''IX: Intent Exclusive''
								WHEN 9 THEN N''SIU: Shared Intent Update''
								WHEN 10 THEN N''SIX: Shared Intent Exclusive''
								WHEN 11 THEN N''UIX: Update Intent Exclusive''
								WHEN 12 THEN N''BU: Bulk Update''
								WHEN 13 THEN N''RangeS-S: Serializable Range Scan''
								WHEN 14 THEN N''RangeS-U: Serializable Update Scan''
								WHEN 15 THEN N''RangeI-N: Insert Key-Range / Null Resource Lock''
								WHEN 16 THEN N''RangeI-S: Overlap Of RangeI-N / S Locks''
								WHEN 17 THEN N''RangeI-U: Overlap Of RangeI-N / U Locks''
								WHEN 18 THEN N''RangeI-X: Overlap Of RangeI-N / X Locks''
								WHEN 19 THEN N''RangeX-S: Overlap Of RangeI-N / RangeS-S Locks''
								WHEN 20 THEN N''RangeX-U: Overlap Of RangeI-N / RangeS-U Locks''
								WHEN 21 THEN N''RangeX-X: Exclusive Key-Range / Exclusive Resource Lock''
								ELSE N''N/A''
								END)
						+ N'' (''
						+ (CASE SLI.req_status
								WHEN 1 THEN N''Granted''
								WHEN 2 THEN N''Convert''
								WHEN 3 THEN N''Wait''
								WHEN 4 THEN N''RELN''
								WHEN 5 THEN N''BLCKN''
								ELSE N''N/A''
								END)
						+ N'' / ''
						+ (CASE SLI.req_ownertype
								WHEN 1 THEN N''Transaction''
								WHEN 2 THEN N''Cursor''
								WHEN 3 THEN N''User Session''
								WHEN 4 THEN N''Shared Transaction Workspace''
								WHEN 5 THEN N''Exclusive Transaction Workspace''
								WHEN 6 THEN N''WFR''
								ELSE N''N/A''
								END)
						+ N'')''
						+ NCHAR (13)
						+ NCHAR (10) AS [text()]
					FROM
						master.dbo.syslockinfo SLI
					WHERE
						SLI.req_mode <= 6
						AND SLI.req_spid = SP.spid
						AND SLI.req_ecid = SP.ecid
					FOR
						 XML PATH ('''')
						,TYPE
		 ), N'''') AS Lock_Details
		,(CASE DXS.[lock_timeout]
			WHEN -1 THEN ''Wait Forever''
			WHEN 0 THEN ''Immediately''
			ELSE CONVERT (VARCHAR (11), CONVERT (DECIMAL (18,2), ROUND (DXS.[lock_timeout] / 1000.0, 2)))
			END) AS Lock_Timeout_Seconds
		,(CASE
			WHEN DXS.[deadlock_priority] <= -5 THEN ''Low''
			WHEN DXS.[deadlock_priority] >= 5 THEN ''High''
			ELSE ''Normal''
			END) + '': '' + CONVERT (VARCHAR (3), DXS.[deadlock_priority]) AS [Deadlock_Priority]
		,ISNULL (CONVERT (VARCHAR (130), DECP.plan_handle, 1), '''') AS Plan_Handle
	'


IF @Filter_Column = 0
BEGIN

	SET @SQL_String = @SQL_String +

		'
			,ISNULL (DEQP.query_plan, '''') AS Query_Plan_XML
		'

END


SET @SQL_String = @SQL_String +

	'
			,ISNULL (DECP.cacheobjtype, '''') AS Plan_Cache_Object_Type
			,ISNULL ((CASE
						WHEN DECP.objtype = ''Adhoc'' THEN ''Ad Hoc Query''
						WHEN DECP.objtype = ''Check'' THEN ''CHECK Constraint''
						WHEN DECP.objtype = ''Prepared'' THEN ''Prepared Statement''
						WHEN DECP.objtype = ''Proc'' THEN ''Stored Procedure''
						WHEN DECP.objtype = ''ReplProc'' THEN ''Replication Filter Procedure''
						WHEN DECP.objtype = ''SysTab'' THEN ''System Table''
						WHEN DECP.objtype = ''UsrTab'' THEN ''User Table''
						ELSE DECP.objtype
						END), '''') AS Plan_Object_Type
			,ISNULL (CONVERT (VARCHAR (10), DECP.usecounts), '''') AS Plan_Times_Used
			,ISNULL (CONVERT (VARCHAR (10), CONVERT (DECIMAL (18,2), ROUND (DECP.size_in_bytes / 1048576.0, 2))), '''') AS Plan_Size_MB
			,ISNULL ((CASE
						WHEN oaDHMS.login_time_days <= 0 THEN REPLICATE (''_'', cjMAX.login_time_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.login_time_days_length_max - LEN (oaDHMS.login_time_days)) + oaDHMS.login_time_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.login_time_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.login_time_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.login_time_hhmmss, 2)
													WHEN LEFT (oaDHMS.login_time_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.login_time_hhmmss, 5)
													ELSE oaDHMS.login_time_hhmmss
													END), '''') AS Since_SPID_Login
			,ISNULL ((CASE
						WHEN oaDHMS.last_batch_days <= 0 THEN REPLICATE (''_'', cjMAX.last_batch_days_length_max)
						ELSE REPLICATE (''0'', cjMAX.last_batch_days_length_max - LEN (oaDHMS.last_batch_days)) + oaDHMS.last_batch_days
						END) + '' Day(s) '' + (CASE
													WHEN oaDHMS.last_batch_hhmmss = ''00:00:00'' THEN ''__:__:__''
													WHEN LEFT (oaDHMS.last_batch_hhmmss, 5) = ''00:00'' THEN ''__:__:'' + RIGHT (oaDHMS.last_batch_hhmmss, 2)
													WHEN LEFT (oaDHMS.last_batch_hhmmss, 2) = ''00'' THEN ''__:'' + RIGHT (oaDHMS.last_batch_hhmmss, 5)
													ELSE oaDHMS.last_batch_hhmmss
													END), '''') AS Since_Last_Batch
			,RTRIM (SP.hostname) AS Workstation_Name
			,DB_NAME (SP.[dbid]) AS Database_Name
			,CONVERT (NVARCHAR (128), RTRIM (REPLACE (REPLACE (SP.[program_name], ''Microsoft® Windows® Operating System'', ''Windows OS''), ''Microsoft'', ''MS''))) AS Application_Description
			,CONVERT (VARCHAR (6), SP.spid) + ''.'' + CONVERT (VARCHAR (6), SP.ecid) + (CASE
																							WHEN SP.spid = @@SPID THEN '' ••''
																							WHEN SP.spid <= 50 THEN '' •''
																							ELSE ''''
																							END) AS SPECID
		FROM
			master.sys.sysprocesses SP
			INNER JOIN master.sys.dm_exec_sessions DXS ON DXS.session_id = SP.spid
			CROSS JOIN

				(
					SELECT
						 MAX (LEN (CONVERT (VARCHAR (5), XDER.total_elapsed_time / 1000 / 86400))) AS total_elapsed_time_days_length_max
						,MAX (LEN (CONVERT (VARCHAR (5), XSP.cpu / 1000 / 86400))) AS cpu_days_length_max
						,MAX (LEN (CONVERT (VARCHAR (5), XDER.cpu_time / 1000 / 86400))) AS cpu_time_days_length_max
						,MAX (LEN (CONVERT (VARCHAR (5), XDER.estimated_completion_time / 1000 / 86400))) AS estimated_completion_time_days_length_max
						,MAX (LEN (CONVERT (VARCHAR (5), XSP.waittime / 1000 / 86400))) AS waittime_days_length_max
						,MAX (LEN (FLOOR ((FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), XSP.login_time)) * 24) * 60) * 60)) / 86400))) AS login_time_days_length_max
						,MAX (LEN (FLOOR ((FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), XSP.last_batch)) * 24) * 60) * 60)) / 86400))) AS last_batch_days_length_max
					FROM
						master.sys.sysprocesses XSP
						LEFT JOIN master.sys.dm_exec_requests XDER ON XDER.session_id = XSP.spid
				) cjMAX

			LEFT JOIN

				(
					SELECT
						 YSP.spid
						,ISNULL (NULLIF (YSP.nt_username, ''''), YSP.loginame) AS Login_ID_Blocking
						,ROW_NUMBER () OVER
											(
												PARTITION BY
													YSP.spid
												ORDER BY
													 (CASE
														WHEN ISNULL (NULLIF (YSP.nt_username, ''''), YSP.loginame) = '''' THEN 2
														ELSE 1
														END)
													,YSP.ecid
											) AS sort_id
					FROM
						master.sys.sysprocesses YSP
				) sqBLKR ON sqBLKR.spid = SP.blocked AND sqBLKR.sort_id = 1

			LEFT JOIN

				(
					SELECT DISTINCT
						ZSP.blocked
					FROM
						master.sys.sysprocesses ZSP
				) sqBLKD ON sqBLKD.blocked = SP.spid

			LEFT JOIN master.sys.dm_exec_requests DER ON DER.session_id = SP.spid
			LEFT JOIN master.sys.dm_exec_cached_plans DECP ON DECP.plan_handle = DER.plan_handle
			LEFT JOIN master.sys.messages M ON M.message_id = DXS.prev_error
				AND M.language_id = SERVERPROPERTY (N''LCID'')
	'


IF @Filter_Column = 0
BEGIN

	SET @SQL_String = @SQL_String +

		'
			OUTER APPLY master.sys.dm_exec_sql_text (SP.[sql_handle]) DEST
			OUTER APPLY master.sys.dm_exec_query_plan (DER.plan_handle) DEQP
		'

END


SET @SQL_String = @SQL_String +

	'
			OUTER APPLY

				(
					SELECT
						 NULLIF (DER.total_elapsed_time, 0) / 1000 AS total_elapsed_time_seconds
						,NULLIF (SP.cpu, 0) / 1000 AS cpu_seconds
						,NULLIF (DER.cpu_time, 0) / 1000 AS cpu_time_seconds
						,NULLIF (DER.estimated_completion_time, 0) / 1000 AS estimated_completion_time_seconds
						,NULLIF (SP.waittime, 0) / 1000 AS waittime_seconds
						,FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), SP.login_time)) * 24) * 60) * 60) AS login_time_seconds
						,FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), SP.last_batch)) * 24) * 60) * 60) AS last_batch_seconds
				) oaSEC

			OUTER APPLY

				(
					SELECT
						 CONVERT (VARCHAR (5), oaSEC.total_elapsed_time_seconds / 86400) AS total_elapsed_time_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.total_elapsed_time_seconds % 86400, 0), 108) AS total_elapsed_time_hhmmss
						,CONVERT (VARCHAR (5), oaSEC.cpu_seconds / 86400) AS cpu_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.cpu_seconds % 86400, 0), 108) AS cpu_hhmmss
						,CONVERT (VARCHAR (5), oaSEC.cpu_time_seconds / 86400) AS cpu_time_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.cpu_time_seconds % 86400, 0), 108) AS cpu_time_hhmmss
						,CONVERT (VARCHAR (5), oaSEC.estimated_completion_time_seconds / 86400) AS estimated_completion_time_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.estimated_completion_time_seconds % 86400, 0), 108) AS estimated_completion_time_hhmmss
						,CONVERT (VARCHAR (5), oaSEC.waittime_seconds / 86400) AS waittime_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.waittime_seconds % 86400, 0), 108) AS waittime_hhmmss
						,CONVERT (VARCHAR (7), FLOOR (oaSEC.login_time_seconds / 86400)) AS login_time_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.login_time_seconds % 86400, 0), 108) AS login_time_hhmmss
						,CONVERT (VARCHAR (7), FLOOR (oaSEC.last_batch_seconds / 86400)) AS last_batch_days
						,CONVERT (CHAR (8), DATEADD (SECOND, oaSEC.last_batch_seconds % 86400, 0), 108) AS last_batch_hhmmss
				) oaDHMS

		WHERE
			1 = 1
	'


IF @Filter_Active = 1
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND (CASE
					WHEN SP.open_tran <> 0 THEN ''''
					ELSE SP.[status]
					END) NOT IN (''dormant'', ''sleeping'')
		'

END


IF @Filter_Blocked = 1
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND SP.blocked <> 0
		'

END


IF @Filter_System = 1
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND SP.spid >= 51
		'

END


IF @SPID IS NOT NULL
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND SP.spid = ' + CONVERT (VARCHAR (10), @SPID) + '
		'

END


IF @Login IS NOT NULL
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND CONVERT (NVARCHAR (128), ISNULL (NULLIF (SP.nt_username, ''''), SP.loginame)) = N''' + @Login + '''
		'

END


IF @Database IS NOT NULL
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND DB_NAME (SP.[dbid]) = N''' + @Database + '''
		'

END


IF @SQL_Text IS NOT NULL AND @Filter_Column = 0
BEGIN

	SET @SQL_String = @SQL_String +

		'
			AND DEST.[text] LIKE N''%'' + REPLACE (REPLACE (REPLACE (''' + @SQL_Text + ''', N''['', N''[[]''), N''%'', N''[%]''), N''_'', N''[_]'') + ''%''
		'

END


SET @SQL_String = @SQL_String +

	'
			OR
			(
				SP.blocked <> 0
				OR sqBLKD.blocked IS NOT NULL
			)
		ORDER BY
			 (CASE
				WHEN SP.blocked = 0 AND sqBLKD.blocked IS NULL THEN 999
				WHEN SP.blocked = SP.spid THEN 30
				WHEN SP.blocked = 0 AND sqBLKD.blocked IS NOT NULL THEN 20
				ELSE 10
				END)
			,SP.spid
			,SP.ecid
	'


EXECUTE (@SQL_String)
GO