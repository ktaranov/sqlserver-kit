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
--	           : Added "@Database_Name" Filter Variable
--	           : Added "Last_Wait_Type", "Query_Plan", And "Wait_Type" Fields To Output
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


--	Description: Massive Rewrite Of Entire Stored Procedure
--	Date (MM/DD/YYYY): 11/28/2015
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.usp_who5

	 @Filter AS NVARCHAR (5) = NULL
	,@Database_Name AS NVARCHAR (512) = NULL
	,@Exclude_Lock AS BIT = 1
	,@Exclude_Plan AS BIT = 1
	,@Exclude_SQL AS BIT = 0
	,@Exclude_SQL_XML AS BIT = 1
	,@Login AS NVARCHAR (128) = NULL
	,@SPID AS SMALLINT = NULL
	,@SQL_Text AS NVARCHAR (MAX) = NULL

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


DECLARE
	 @Ampersand AS NVARCHAR (1)
	,@Print AS NVARCHAR (MAX)


SET @Ampersand = N'&'


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If "@Filter" Parameter Is An Input / Output Help Request
-----------------------------------------------------------------------------------------------------------------------------

IF @Filter = N'?'
BEGIN

	SET @Print =

		N'
Optional input parameters:

	@Filter          : Limit the result set by passing one or more values listed below (can be combined in any order)

		A - Active sessions only (includes sleeping SPIDs with open transactions)
		B - Blocked sessions only
		S - Exclude sleeping SPIDs with open transactions
		X - Exclude system processes

	@Database_Name   : Limit the result set to a specific database (use ---------- for NULL database names)
	@Exclude_Lock    : Suppress locking details from the output (can increases procedure performance on busy servers; defaulted to 1)
	@Exclude_Plan    : Suppress execution plan details from the output (can increases procedure performance on busy servers; defaulted to 1)
	@Exclude_SQL     : Suppress SQL statement details from the output (can increases procedure performance on busy servers; defaulted to 0)
	@Exclude_SQL_XML : Suppress SQL statement XML details from the output (can increases procedure performance on busy servers; defaulted to 1)
	@Login           : Limit the result set to a specific Windows user name (if populated, otherwise by SQL Server login name)
	@SPID            : Limit the result set to a specific session
	@SQL_Text        : Limit the result set to SQL statements containing specific text


Notes:

	Blocking / blocked sessions will always be displayed first in the result set (when applicable)


Output:

	SPECID                    : System Process ID with Execution Context ID
	Database_Name             : Database context of the session
	Running                   : Indicates if the session is executing (X), waiting ([]), inactive (blank), inactive with open transactions (•), a background task (--), or not defined (N/A)
	Blocking                  : Blocking indicator (includes type of block and SPID list)
	Status                    : Status of the session -> request -> task
	Object_Name               : Object being referenced (blank for ad hoc and prepared statements)
	Command                   : Command executed
	SQL_Statement_Batch       : Batch statement of the session
	SQL_Statement_Current     : Current statement of the session
	Open_Trans                : Open transactions for the process
	Isolation_Level           : Isolation level of the session
	Wait_Time                 : Current wait time (DAYS HH:MM:SS)
	Wait_Type                 : Current wait type
	Last_Wait_Type            : Previous wait type
	SQL_Statement_Batch_XML   : Same as "SQL_Statement_Batch" but in XML format
	SQL_Statement_Current_XML : Same as "SQL_Statement_Current" but in XML format
	SQL_Handle                : Identifier for the executing batch or object
	Elapsed_Time              : Elapsed time since the request began (DAYS HH:MM:SS)
	CPU_Total                 : CPU time used since login (DAYS HH:MM:SS)
	CPU_Current               : CPU time used for the current process (DAYS HH:MM:SS)
	Logical_Reads_Total       : Logical reads performed since login
	Logical_Reads_Current     : Logical reads performed by the current process
	Physical_Reads_Total      : Physical reads performed since login
	Physical_Reads_Current    : Physical reads performed by the current process
	Writes_Total              : Writes performed since login
	Writes_Current            : Writes performed by the current process
	Nesting_Level             : Nesting level of the statement currently executing
	Last_Row_Count            : Row count produced by the last statement executed
	Allocated_Memory_MB       : Memory allocated to the query in megabytes
	Pages_Used                : Pages in the procedure cache allocated to the process
	Since_SPID_Login          : Elapsed time since the client logged in (DAYS HH:MM:SS)
	Since_Last_Batch_Start    : Elapsed time since the last request began (DAYS HH:MM:SS)
	Since_Last_Batch_End      : Elapsed time since the last completion of a request (DAYS HH:MM:SS)
	Query_Plan                : Execution plan of the session (in XML format)
	Plan_Cache_Object_Type    : Type of object in the cache
	Plan_Object_Type          : Plan object type
	Plan_Times_Used           : Times the plan has been utilized since its creation
	Plan_Size_MB              : Size consumed by the plan in megabytes
	Plan_Handle               : Identifier for the in-memory plan
	Batch_Pct                 : Percentage of the batch which has been processed
	End_Of_Batch              : Indicates if the current statement is the last of the entire batch
	Command_Pct               : Percentage of work completed (applies to a limited set of commands)
	Command_Completion        : Estimated completion time for the command
	Command_Time_Left         : Time left before the command completes (DAYS HH:MM:SS)
	Lock_Details              : Lock details of the session (in XML format)
	Lock_Timeout_Seconds      : Lock timeout of the session
	Deadlock_Priority         : Deadlock priority of the session
	Host_Name                 : Name of the client workstation specific to a session
	Login_ID                  : Windows user name (or "Login_Name" if user name is unavailable)
	Login_Name                : Full name of the user associated to the "Login_ID"
	Application_Description   : Application accessing SQL Server
	Previous_Error            : Previous error returned by the session
	System_Process            : Indicates if the session is a system process
	SPECID                    : System Process ID with Execution Context ID
		 '


	PRINT SUBSTRING (@Print, 1, 3989)


	PRINT SUBSTRING (@Print, 3992, 4000)


	RETURN

END


-----------------------------------------------------------------------------------------------------------------------------
--	Declarations / Sets: Declare And Set Variables
-----------------------------------------------------------------------------------------------------------------------------

DECLARE
	 @Filter_Active AS BIT
	,@Filter_Blocked AS BIT
	,@Filter_Sleeping AS BIT
	,@Filter_System AS BIT


SET @Database_Name = NULLIF (@Database_Name, N'')


SET @Filter_Active = (CASE
						WHEN @Filter LIKE N'%A%' THEN 1
						ELSE 0
						END)


SET @Filter_Blocked = (CASE
							WHEN @Filter LIKE N'%B%' THEN 1
							ELSE 0
							END)


SET @Filter_Sleeping = (CASE
							WHEN @Filter LIKE N'%S%' THEN 1
							ELSE 0
							END)


SET @Filter_System = (CASE
						WHEN @Filter LIKE N'%X%' THEN 1
						ELSE 0
						END)


SET @Login = NULLIF (@Login, N'')


SET @SQL_Text = NULLIF (REPLACE (@SQL_Text, N'''', N''''''), N'')


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SELECT
	 caCV.SPECID
	,ISNULL (DB.name, N'----------') AS Database_Name
	,REPLICATE (N' ', 5) + (CASE
								WHEN caCV.status_session = N'BACKGROUND' THEN N'---'
								WHEN caCV.status_session IN (N'dormant', N'sleeping') AND SP.open_tran = 0 THEN N''
								WHEN caCV.status_session IN (N'dormant', N'sleeping') AND SP.open_tran > 0 THEN N'•'
								WHEN caCV.status_session IN (N'PENDING', N'PRECONNECT', N'RUNNABLE', N'SPINLOOP', N'SUSPENDED') THEN N'[]'
								WHEN caCV.status_session IN (N'ROLLBACK', N'RUNNING') THEN N'X'
								ELSE N'N/A'
								END) AS Running
	,(CASE
		WHEN caCV.blocking IS NULL AND NULLIF (DER.blocking_session_id, 0) IS NULL THEN N''
		WHEN DER.blocking_session_id = DXS.session_id THEN N'> Parallelism <'
		ELSE ISNULL (N'[ Blocking ] : ' + caCV.blocking, N'') + (CASE
																	WHEN caCV.blocking IS NOT NULL AND DER.blocking_session_id <> 0 THEN N' •• '
																	ELSE N''
																	END) + ISNULL (N'< Blocked By > : ' + CONVERT (NVARCHAR (6), NULLIF (DER.blocking_session_id, 0)), N'')
		END) AS Blocking
	,caCV.status_session + N' -> ' + ISNULL (caCV.status_request, N'N/A') + N' -> ' + ISNULL (caCV.status_task, N'N/A') AS [Status]
	,COALESCE (OBJECT_NAME (DEST.objectid, DEST.[dbid]), OBJECT_NAME (DEQP.objectid, DEQP.[dbid]), N'') AS [Object_Name]
	,(CASE
		WHEN ISNULL (DER.command, SP.cmd) = N'AWAITING COMMAND' THEN LOWER (ISNULL (DER.command, SP.cmd))
		ELSE ISNULL (DER.command, SP.cmd)
		END) AS Command
	,ISNULL (DEST.[text], N'') AS SQL_Statement_Batch
	,ISNULL ((CASE
				WHEN DEST.[text] IS NULL THEN N''
				WHEN caCV.status_session = N'sleeping' AND caCV.status_request IS NULL AND caCV.status_task IS NULL THEN N''
				WHEN caCV.statement_start_offset < 1 AND caCV.statement_end_offset = -1 THEN N'<< Single Statement >>'
				WHEN (DATALENGTH (DEST.[text]) - caCV.statement_start_offset) / 2 < 0 AND caCV.statement_end_offset = -1 THEN N'<< Derived Statement >>'
				WHEN caCV.statement_end_offset = -1 THEN SUBSTRING (DEST.[text], (caCV.statement_start_offset / 2) + 1, ((DATALENGTH (DEST.[text]) - caCV.statement_start_offset) / 2) + 1)
				ELSE SUBSTRING (DEST.[text], (caCV.statement_start_offset / 2) + 1, ((caCV.statement_end_offset - caCV.statement_start_offset) / 2) + 1)
				END), N'') AS SQL_Statement_Current
	,(CASE
		WHEN SP.open_tran = 0 THEN N''
		ELSE CONVERT (NVARCHAR (6), SP.open_tran)
		END) AS Open_Trans
	,(CASE DXS.transaction_isolation_level
		WHEN 0 THEN N'UNSPECIFIED'
		WHEN 1 THEN N'READ UNCOMMITTED'
		WHEN 2 THEN N'READ COMMITTED'
		WHEN 3 THEN N'REPEATABLE READ'
		WHEN 4 THEN N'SERIALIZABLE'
		WHEN 5 THEN N'SNAPSHOT'
		ELSE N'N/A'
		END) AS Isolation_Level
	,ISNULL ((CASE
				WHEN oaDHMS.wait_time_days <= 0 THEN REPLICATE (N'_', cjMAX.wait_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.wait_time_days_length_max - LEN (oaDHMS.wait_time_days)) + oaDHMS.wait_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.wait_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.wait_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.wait_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.wait_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.wait_time_hhmmss, 5)
										ELSE oaDHMS.wait_time_hhmmss
										END), N'') AS Wait_Time
	,ISNULL (DER.wait_type, N'') AS Wait_Type
	,ISNULL (DER.last_wait_type, N'') AS Last_Wait_Type
	,CONVERT (XML, ISNULL ((CASE
								WHEN (@Exclude_SQL = 1 OR @Exclude_SQL_XML = 1) THEN N''
								ELSE REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (DEST.[text], N'&', @Ampersand + N'amp;'), N'<', @Ampersand + N'lt;'), N'>', @Ampersand + N'gt;'), N'"', @Ampersand + N'quot;'), N'''', @Ampersand + N'#39;')
								END), N'')) AS SQL_Statement_Batch_XML
	,CONVERT (XML, (CASE
						WHEN (@Exclude_SQL = 1 OR @Exclude_SQL_XML = 1) THEN N''
						ELSE REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (ISNULL (NULLIF (NULLIF (oaSSC.SQL_Statement_Current, N'<< Derived Statement >>'), N'<< Single Statement >>'), DEST.[text]), N'&', @Ampersand + N'amp;'), N'<', @Ampersand + N'lt;'), N'>', @Ampersand + N'gt;'), N'"', @Ampersand + N'quot;'), N'''', @Ampersand + N'#39;')
						END)) AS SQL_Statement_Current_XML
	,ISNULL (CONVERT (NVARCHAR (130), (CASE
											WHEN SP.[sql_handle] <> 0x0000000000000000000000000000000000000000 THEN SP.[sql_handle]
											END), 1), N'') AS [SQL_Handle]
	,ISNULL ((CASE
				WHEN oaDHMS.total_elapsed_time_days <= 0 THEN REPLICATE (N'_', cjMAX.total_elapsed_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.total_elapsed_time_days_length_max - LEN (oaDHMS.total_elapsed_time_days)) + oaDHMS.total_elapsed_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.total_elapsed_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.total_elapsed_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.total_elapsed_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.total_elapsed_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.total_elapsed_time_hhmmss, 5)
										ELSE oaDHMS.total_elapsed_time_hhmmss
										END), N'') AS Elapsed_Time
	,ISNULL ((CASE
				WHEN oaDHMS.cpu_days <= 0 THEN REPLICATE (N'_', cjMAX.cpu_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.cpu_days_length_max - LEN (oaDHMS.cpu_days)) + oaDHMS.cpu_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.cpu_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.cpu_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.cpu_hhmmss, 2)
										WHEN LEFT (oaDHMS.cpu_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.cpu_hhmmss, 5)
										ELSE oaDHMS.cpu_hhmmss
										END), N'') AS CPU_Total
	,ISNULL ((CASE
				WHEN oaDHMS.cpu_time_days <= 0 THEN REPLICATE (N'_', cjMAX.cpu_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.cpu_time_days_length_max - LEN (oaDHMS.cpu_time_days)) + oaDHMS.cpu_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.cpu_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.cpu_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.cpu_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.cpu_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.cpu_time_hhmmss, 5)
										ELSE oaDHMS.cpu_time_hhmmss
										END), N'') AS CPU_Current
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DXS.logical_reads, 0)), 1)), 4, 23)), N'') AS Logical_Reads_Total
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DER.logical_reads, 0)), 1)), 4, 23)), N'') AS Logical_Reads_Current
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DXS.reads, 0)), 1)), 4, 23)), N'') AS Physical_Reads_Total
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DER.reads, 0)), 1)), 4, 23)), N'') AS Physical_Reads_Current
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DXS.writes, 0)), 1)), 4, 23)), N'') AS Writes_Total
	,ISNULL (REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DER.writes, 0)), 1)), 4, 23)), N'') AS Writes_Current
	,ISNULL (CONVERT (NVARCHAR (11), DER.nest_level), N'') AS Nesting_Level
	,(CASE
		WHEN DXS.row_count = 0 THEN N''
		ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (NVARCHAR (23), CONVERT (MONEY, NULLIF (DXS.row_count, 0)), 1)), 4, 23))
		END) AS Last_Row_Count
	,ISNULL ((CASE
				WHEN ISNULL (DOT.exec_context_id, 0) = 0 THEN CONVERT (NVARCHAR (23), CONVERT (MONEY, (NULLIF (DER.granted_query_memory, 0) * 8) / 1024.0), 1)
				END), N'') AS Allocated_Memory_MB
	,(CASE
		WHEN DXS.memory_usage = 0 THEN N''
		ELSE CONVERT (NVARCHAR (11), DXS.memory_usage)
		END) AS Pages_Used
	,ISNULL ((CASE
				WHEN oaDHMS.login_time_days <= 0 THEN REPLICATE (N'_', cjMAX.login_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.login_time_days_length_max - LEN (oaDHMS.login_time_days)) + oaDHMS.login_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.login_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.login_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.login_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.login_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.login_time_hhmmss, 5)
										ELSE oaDHMS.login_time_hhmmss
										END), N'') AS Since_SPID_Login
	,ISNULL ((CASE
				WHEN oaDHMS.last_request_start_time_days <= 0 THEN REPLICATE (N'_', cjMAX.last_request_start_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.last_request_start_time_days_length_max - LEN (oaDHMS.last_request_start_time_days)) + oaDHMS.last_request_start_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.last_request_start_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.last_request_start_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.last_request_start_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.last_request_start_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.last_request_start_time_hhmmss, 5)
										ELSE oaDHMS.last_request_start_time_hhmmss
										END), N'') AS Since_Last_Batch_Start
	,ISNULL ((CASE
				WHEN oaDHMS.last_request_end_time_days <= 0 THEN REPLICATE (N'_', cjMAX.last_request_end_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.last_request_end_time_days_length_max - LEN (oaDHMS.last_request_end_time_days)) + oaDHMS.last_request_end_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.last_request_end_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.last_request_end_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.last_request_end_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.last_request_end_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.last_request_end_time_hhmmss, 5)
										ELSE oaDHMS.last_request_end_time_hhmmss
										END), N'') AS Since_Last_Batch_End
	,ISNULL (DEQP.query_plan, N'') AS Query_Plan
	,ISNULL (DECP.cacheobjtype, N'') AS Plan_Cache_Object_Type
	,ISNULL ((CASE
				WHEN DECP.objtype = N'Adhoc' THEN N'Ad Hoc Query'
				WHEN DECP.objtype = N'Check' THEN N'CHECK Constraint'
				WHEN DECP.objtype = N'Prepared' THEN N'Prepared Statement'
				WHEN DECP.objtype = N'Proc' THEN N'Stored Procedure'
				WHEN DECP.objtype = N'ReplProc' THEN N'Replication Filter Procedure'
				WHEN DECP.objtype = N'SysTab' THEN N'System Table'
				WHEN DECP.objtype = N'UsrTab' THEN N'User Table'
				ELSE DECP.objtype
				END), N'') AS Plan_Object_Type
	,ISNULL (CONVERT (NVARCHAR (11), DECP.usecounts), N'') AS Plan_Times_Used
	,ISNULL (CONVERT (NVARCHAR (11), CONVERT (DECIMAL (18, 2), ROUND (DECP.size_in_bytes / 1048576.0, 2))), N'') AS Plan_Size_MB
	,ISNULL (CONVERT (NVARCHAR (130), DER.plan_handle, 1), N'') AS Plan_Handle
	,ISNULL ((CASE
				WHEN caCV.statement_start_offset = -1 AND caCV.statement_end_offset = -1 AND SP.open_tran = 0 THEN N''
				WHEN caCV.statement_start_offset = -1 AND caCV.statement_end_offset = -1 AND SP.open_tran > 0 THEN N'100.00'
				WHEN caCV.statement_start_offset = 0 THEN N'0.00'
				WHEN (DATALENGTH (DEST.[text]) - caCV.statement_start_offset) / 2 < 0 AND caCV.statement_end_offset = -1 THEN N'N/A'
				ELSE CONVERT (NVARCHAR (23), CONVERT (DECIMAL (20, 2), ROUND (((caCV.statement_start_offset - 2.0) / DATALENGTH (DEST.[text])) * 100, 2)))
				END), N'') AS Batch_Pct
	,(CASE
		WHEN caCV.statement_end_offset = -1 AND DEST.[text] IS NOT NULL THEN N'Yes'
		WHEN caCV.statement_end_offset > 0 THEN N'No'
		ELSE N''
		END) AS End_Of_Batch
	,ISNULL ((CASE
				WHEN DER.percent_complete = 0 THEN N''
				ELSE CONVERT (NVARCHAR (7), CONVERT (DECIMAL (5, 2), DER.percent_complete))
				END), N'') AS Command_Pct
	,ISNULL ((CASE
				WHEN DER.percent_complete = 0 THEN N''
				ELSE CONVERT (NVARCHAR (19), DATEADD (MILLISECOND, DER.estimated_completion_time, GETDATE ()), 120)
				END), N'') AS Command_Completion
	,ISNULL ((CASE
				WHEN oaDHMS.estimated_completion_time_days <= 0 THEN REPLICATE (N'_', cjMAX.estimated_completion_time_days_length_max)
				ELSE REPLICATE (N'0', cjMAX.estimated_completion_time_days_length_max - LEN (oaDHMS.estimated_completion_time_days)) + oaDHMS.estimated_completion_time_days
				END) + N' Day(s) ' + (CASE
										WHEN oaDHMS.estimated_completion_time_hhmmss = N'00:00:00' THEN N'__:__:__'
										WHEN LEFT (oaDHMS.estimated_completion_time_hhmmss, 5) = N'00:00' THEN N'__:__:' + RIGHT (oaDHMS.estimated_completion_time_hhmmss, 2)
										WHEN LEFT (oaDHMS.estimated_completion_time_hhmmss, 2) = N'00' THEN N'__:' + RIGHT (oaDHMS.estimated_completion_time_hhmmss, 5)
										ELSE oaDHMS.estimated_completion_time_hhmmss
										END), N'') AS Command_Time_Left
	,ISNULL ((
				SELECT DISTINCT
					(CASE
						WHEN SLI.rsc_type = 2 THEN ISNULL (DB.name, N'----------')
						WHEN SLI.rsc_type = 5 AND SLI.req_mode = 2 THEN N'LOCKED'
						ELSE ISNULL (OBJECT_NAME (SLI.rsc_objid, SLI.rsc_dbid), N'N/A')
						END)
					+ N': '
					+ (CASE SLI.rsc_type
							WHEN 1 THEN N'NULL Resource'
							WHEN 2 THEN N'Database'
							WHEN 3 THEN N'File'
							WHEN 4 THEN N'Index'
							WHEN 5 THEN N'Object'
							WHEN 6 THEN N'Page'
							WHEN 7 THEN N'Key'
							WHEN 8 THEN N'Extent'
							WHEN 9 THEN N'Row ID (RID)'
							WHEN 10 THEN N'Application'
							WHEN 11 THEN N'Metadata'
							WHEN 12 THEN N'Heap Or B-Tree (HoBt)'
							WHEN 13 THEN N'Allocation Unit'
							ELSE N'N/A'
							END)
					+ ISNULL (N' [' + CONVERT (NVARCHAR (11), NULLIF (SLI.rsc_indid, 0)) + N']', N'')
					+ N' - '
					+ (CASE SLI.req_mode
							WHEN 0 THEN N'NULL Resource'
							WHEN 1 THEN N'Sch-S: Schema Stability'
							WHEN 2 THEN N'Sch-M: Schema Modification'
							WHEN 3 THEN N'S: Shared'
							WHEN 4 THEN N'U: Update'
							WHEN 5 THEN N'X: Exclusive'
							WHEN 6 THEN N'IS: Intent Shared'
							WHEN 7 THEN N'IU: Intent Update'
							WHEN 8 THEN N'IX: Intent Exclusive'
							WHEN 9 THEN N'SIU: Shared Intent Update'
							WHEN 10 THEN N'SIX: Shared Intent Exclusive'
							WHEN 11 THEN N'UIX: Update Intent Exclusive'
							WHEN 12 THEN N'BU: Bulk Update'
							WHEN 13 THEN N'RangeS-S: Serializable Range Scan'
							WHEN 14 THEN N'RangeS-U: Serializable Update Scan'
							WHEN 15 THEN N'RangeI-N: Insert Key-Range / Null Resource Lock'
							WHEN 16 THEN N'RangeI-S: Overlap Of RangeI-N / S Locks'
							WHEN 17 THEN N'RangeI-U: Overlap Of RangeI-N / U Locks'
							WHEN 18 THEN N'RangeI-X: Overlap Of RangeI-N / X Locks'
							WHEN 19 THEN N'RangeX-S: Overlap Of RangeI-N / RangeS-S Locks'
							WHEN 20 THEN N'RangeX-U: Overlap Of RangeI-N / RangeS-U Locks'
							WHEN 21 THEN N'RangeX-X: Exclusive Key-Range / Exclusive Resource Lock'
							ELSE N'N/A'
							END)
					+ N' ('
					+ (CASE SLI.req_status
							WHEN 1 THEN N'Granted'
							WHEN 2 THEN N'Convert'
							WHEN 3 THEN N'Wait'
							WHEN 4 THEN N'RELN'
							WHEN 5 THEN N'BLCKN'
							ELSE N'N/A'
							END)
					+ N' / '
					+ (CASE SLI.req_ownertype
							WHEN 1 THEN N'Transaction'
							WHEN 2 THEN N'Cursor'
							WHEN 3 THEN N'User Session'
							WHEN 4 THEN N'Shared Transaction Workspace'
							WHEN 5 THEN N'Exclusive Transaction Workspace'
							WHEN 6 THEN N'WFR'
							ELSE N'N/A'
							END)
					+ N')'
					+ NCHAR (13)
					+ NCHAR (10) AS [text()]
				FROM
					master.sys.syslockinfo SLI
					LEFT JOIN master.sys.databases DB ON DB.database_id = SLI.rsc_dbid
				WHERE
					@Exclude_Lock = 0
					AND SLI.req_spid = DXS.session_id
					AND SLI.req_ecid = ISNULL (DOT.exec_context_id, 0)
				FOR
					 XML PATH ('')
					,TYPE
		), N'') AS Lock_Details
	,(CASE
		WHEN DXS.[lock_timeout] = -1 THEN N'Wait Forever'
		WHEN DXS.[lock_timeout] = 0 THEN N'Immediately'
		ELSE CONVERT (NVARCHAR (11), CONVERT (DECIMAL (18, 2), ROUND (DXS.[lock_timeout] / 1000.0, 2)))
		END) AS Lock_Timeout_Seconds
	,(CASE
		WHEN DXS.[deadlock_priority] <= -5 THEN N'Low'
		WHEN DXS.[deadlock_priority] >= 5 THEN N'High'
		ELSE N'Normal'
		END) + N': ' + CONVERT (NVARCHAR (3), DXS.[deadlock_priority]) AS [Deadlock_Priority]
	,ISNULL (DXS.[host_name], N'') AS [Host_Name]
	,caCV.login_id AS Login_ID
	,(CASE
		WHEN DXS.login_name = N'sa' THEN N'<< System Administrator >>'
		ELSE DXS.login_name
		END) AS Login_Name
	,ISNULL (REPLACE (REPLACE (DXS.[program_name], N'Microsoft® Windows® Operating System', N'Windows OS'), N'Microsoft', N'MS'), N'') AS Application_Description
	,ISNULL (CONVERT (NVARCHAR (11), NULLIF (DXS.prev_error, 0))
	 + N': '
	 + M.[text]
	 + N' (Severity '
	 + CONVERT (NVARCHAR (3), M.severity)
	 + N', '
	 + (CASE M.is_event_logged
			WHEN 0 THEN N'Not Logged'
			WHEN 1 THEN N'Logged'
			END)
	 + N')', N'') AS Previous_Error
	,(CASE DXS.is_user_process
		WHEN 1 THEN N''
		ELSE N'Yes'
		END) AS System_Process
	,caCV.SPECID
FROM
	master.sys.sysprocesses SP
	INNER JOIN master.sys.dm_exec_sessions DXS ON DXS.session_id = SP.spid
	LEFT JOIN master.sys.dm_exec_requests DER ON DER.session_id = DXS.session_id
	LEFT JOIN master.sys.dm_os_tasks DOT ON DOT.session_id = DXS.session_id
		AND ISNULL (DOT.exec_context_id, 0) = SP.ecid
	LEFT JOIN master.sys.dm_exec_cached_plans DECP ON DECP.plan_handle = DER.plan_handle
	LEFT JOIN master.sys.messages M ON M.message_id = DXS.prev_error
		AND M.language_id = CONVERT (SMALLINT, SERVERPROPERTY (N'LCID'))
	LEFT JOIN master.sys.databases DB ON DB.database_id = SP.[dbid]
	CROSS APPLY

		(
			SELECT
				 CONVERT (NVARCHAR (6), DXS.session_id) + N'.' + CONVERT (NVARCHAR (11), ISNULL (DOT.exec_context_id, 0)) + N' ' + (CASE
																																		WHEN DXS.session_id = @@SPID THEN N'••'
																																		WHEN DXS.is_user_process = 0 THEN N'•'
																																		ELSE N''
																																		END) AS SPECID
				,STUFF ((
							SELECT
								N', ' + CONVERT (NVARCHAR (MAX), XDER.session_id) AS [text()]
							FROM
								master.sys.dm_exec_requests XDER
							WHERE
								XDER.blocking_session_id <> 0
								AND XDER.blocking_session_id = DXS.session_id
							ORDER BY
								XDER.session_id
							FOR
								XML PATH ('')
						), 1, 2, N'') AS blocking
				,(CASE
					WHEN DXS.[status] NOT IN (N'dormant', N'sleeping') THEN UPPER (DXS.[status])
					ELSE DXS.[status]
					END) AS status_session
				,(CASE
					WHEN DER.[status] <> N'sleeping' THEN UPPER (DER.[status])
					ELSE DER.[status]
					END) AS status_request
				,(CASE
					WHEN DOT.task_state <> N'sleeping' THEN UPPER (DOT.task_state)
					ELSE DOT.task_state
					END) AS status_task
				,ISNULL (NULLIF (DXS.nt_user_name, N''), DXS.login_name) AS login_id
				,ISNULL (DER.statement_start_offset, -1) AS statement_start_offset
				,ISNULL (DER.statement_end_offset, -1) AS statement_end_offset
		) caCV

	CROSS JOIN

		(
			SELECT
				 MAX (LEN (CONVERT (NVARCHAR (5), YDER.total_elapsed_time / 1000 / 86400))) AS total_elapsed_time_days_length_max
				,MAX (LEN (CONVERT (NVARCHAR (5), XSP.cpu / 1000 / 86400))) AS cpu_days_length_max
				,MAX (LEN (CONVERT (NVARCHAR (5), YDER.cpu_time / 1000 / 86400))) AS cpu_time_days_length_max
				,MAX (LEN (CONVERT (NVARCHAR (5), YDER.estimated_completion_time / 1000 / 86400))) AS estimated_completion_time_days_length_max
				,MAX (LEN (CONVERT (NVARCHAR (5), YDER.wait_time / 1000 / 86400))) AS wait_time_days_length_max
				,MAX (LEN (FLOOR ((FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), XDXS.login_time)) * 24) * 60) * 60)) / 86400))) AS login_time_days_length_max
				,MAX (LEN (FLOOR ((FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), XDXS.last_request_start_time)) * 24) * 60) * 60)) / 86400))) AS last_request_start_time_days_length_max
				,MAX (LEN (FLOOR ((FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), XDXS.last_request_end_time)) * 24) * 60) * 60)) / 86400))) AS last_request_end_time_days_length_max
			FROM
				master.sys.sysprocesses XSP
				INNER JOIN master.sys.dm_exec_sessions XDXS ON XDXS.session_id = XSP.spid
				LEFT JOIN master.sys.dm_exec_requests YDER ON YDER.session_id = XDXS.session_id
		) cjMAX

	OUTER APPLY master.sys.dm_exec_sql_text (CASE
												WHEN @Exclude_SQL = 1 THEN NULL
												ELSE SP.[sql_handle]
												END) DEST
	OUTER APPLY master.sys.dm_exec_query_plan (CASE
													WHEN @Exclude_Plan = 1 THEN NULL
													ELSE DER.plan_handle
													END) DEQP
	OUTER APPLY

		(
			SELECT
				ISNULL ((CASE
							WHEN DEST.[text] IS NULL THEN N''
							WHEN caCV.status_session = N'sleeping' AND caCV.status_request IS NULL AND caCV.status_task IS NULL THEN N''
							WHEN caCV.statement_start_offset < 1 AND caCV.statement_end_offset = -1 THEN N'<< Single Statement >>'
							WHEN (DATALENGTH (DEST.[text]) - caCV.statement_start_offset) / 2 < 0 AND caCV.statement_end_offset = -1 THEN N'<< Derived Statement >>'
							WHEN caCV.statement_end_offset = -1 THEN SUBSTRING (DEST.[text], (caCV.statement_start_offset / 2) + 1, ((DATALENGTH (DEST.[text]) - caCV.statement_start_offset) / 2) + 1)
							ELSE SUBSTRING (DEST.[text], (caCV.statement_start_offset / 2) + 1, ((caCV.statement_end_offset - caCV.statement_start_offset) / 2) + 1)
							END), N'') AS SQL_Statement_Current
		) oaSSC

	OUTER APPLY

		(
			SELECT
				 NULLIF (DER.total_elapsed_time, 0) / 1000 AS total_elapsed_time_seconds
				,NULLIF (SP.cpu, 0) / 1000 AS cpu_seconds
				,NULLIF (DER.cpu_time, 0) / 1000 AS cpu_time_seconds
				,NULLIF (DER.estimated_completion_time, 0) / 1000 AS estimated_completion_time_seconds
				,NULLIF (DER.wait_time, 0) / 1000 AS wait_time_seconds
				,FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), DXS.login_time)) * 24) * 60) * 60) AS login_time_seconds
				,FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), DXS.last_request_start_time)) * 24) * 60) * 60) AS last_request_start_time_seconds
				,FLOOR ((((CONVERT (DECIMAL (38, 20), GETDATE ()) - CONVERT (DECIMAL (38, 20), DXS.last_request_end_time)) * 24) * 60) * 60) AS last_request_end_time_seconds
		) oaSEC

	OUTER APPLY

		(
			SELECT
				 CONVERT (NVARCHAR (5), oaSEC.total_elapsed_time_seconds / 86400) AS total_elapsed_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.total_elapsed_time_seconds % 86400, 0), 108) AS total_elapsed_time_hhmmss
				,CONVERT (NVARCHAR (5), oaSEC.cpu_seconds / 86400) AS cpu_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.cpu_seconds % 86400, 0), 108) AS cpu_hhmmss
				,CONVERT (NVARCHAR (5), oaSEC.cpu_time_seconds / 86400) AS cpu_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.cpu_time_seconds % 86400, 0), 108) AS cpu_time_hhmmss
				,CONVERT (NVARCHAR (5), oaSEC.estimated_completion_time_seconds / 86400) AS estimated_completion_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.estimated_completion_time_seconds % 86400, 0), 108) AS estimated_completion_time_hhmmss
				,CONVERT (NVARCHAR (5), oaSEC.wait_time_seconds / 86400) AS wait_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.wait_time_seconds % 86400, 0), 108) AS wait_time_hhmmss
				,CONVERT (NVARCHAR (7), FLOOR (oaSEC.login_time_seconds / 86400)) AS login_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.login_time_seconds % 86400, 0), 108) AS login_time_hhmmss
				,CONVERT (NVARCHAR (7), FLOOR (oaSEC.last_request_start_time_seconds / 86400)) AS last_request_start_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.last_request_start_time_seconds % 86400, 0), 108) AS last_request_start_time_hhmmss
				,CONVERT (NVARCHAR (7), FLOOR (oaSEC.last_request_end_time_seconds / 86400)) AS last_request_end_time_days
				,CONVERT (NCHAR (8), DATEADD (SECOND, oaSEC.last_request_end_time_seconds % 86400, 0), 108) AS last_request_end_time_hhmmss
		) oaDHMS

WHERE
	(
		(
			@Filter_Active = 0
			OR (CASE
					WHEN @Filter_Sleeping = 0 AND SP.open_tran > 0 THEN N''
					ELSE caCV.status_session
					END) NOT IN (N'dormant', N'sleeping')
		)
		AND
		(
			@Filter_Blocked = 0
			OR DER.blocking_session_id <> 0
		)
		AND
		(
			@Filter_System = 0
			OR DXS.is_user_process = 1
		)
		AND
		(
			@Database_Name IS NULL
			OR ISNULL (DB.name, N'----------') = @Database_Name
		)
		AND
		(
			@Login IS NULL
			OR caCV.login_id = @Login
		)
		AND
		(
			@SPID IS NULL
			OR DXS.session_id = @SPID
		)
		AND
		(
			@SQL_Text IS NULL
			OR DEST.[text] LIKE N'%' + REPLACE (REPLACE (REPLACE (@SQL_Text, N'[', N'[[]'), N'%', N'[%]'), N'_', N'[_]') + N'%'
		)
	)
	OR
	(
		caCV.blocking IS NOT NULL
		OR NULLIF (DER.blocking_session_id, 0) IS NOT NULL
	)
ORDER BY
	 (CASE
		WHEN caCV.blocking IS NOT NULL AND NULLIF (DER.blocking_session_id, 0) IS NULL THEN 10
		WHEN caCV.blocking IS NOT NULL AND NULLIF (DER.blocking_session_id, 0) IS NOT NULL THEN 20
		WHEN caCV.blocking IS NULL AND NULLIF (DER.blocking_session_id, 0) IS NOT NULL THEN 30
		WHEN DER.blocking_session_id = DXS.session_id THEN 40
		ELSE 999
		END)
	,DXS.session_id
	,DOT.exec_context_id
GO
