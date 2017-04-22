/*********************************************************************************************
sp_WhatsupQueryStore v1.2
(C) Enrico van de Laar (Twitter: @evdlaar)
https://github.com/Evdlaar/sp_WhatsupQueryStore

Feedback: mailto:enrico@dotnine.net

License:
	This script is free to download and use for personal, educational, and internal
	corporate purposes, provided that this header is preserved. Redistribution or sale
	of this script, in whole or in part, is prohibited without the author's express
	written consent.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
	OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*********************************************************************************************/

USE [master]
GO

-- Check if the sp_WhatsupQueryStore procedure is present
-- if it is, drop it first.
IF OBJECT_ID('dbo.sp_WhatsupQueryStore', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.sp_WhatsupQueryStore AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_WhatsupQueryStore
	@dbname VARCHAR(75),
	@timewindow VARCHAR(4) = 1,
	@topqueries VARCHAR(4) = 25,
	@return_store_config INT = 0,
	@return_forced_plans INT = 0,
	@return_multiple_plans INT = 0,
	@return_top_executed INT = 0,
	@return_top_duration INT = 0,
	@return_top_cpu INT = 0,
	@return_top_log_read INT = 0,
	@return_top_log_write INT = 0,
	@return_top_phys_read INT = 0,
	@return_all INT = 0,
	@show_query_hints INT = 0

AS

-- First we are going to check if the Query Store is enabled for the target database.
-- If it is we can continue, otherwise end the execution.
DECLARE @qs_enabled INT;
DECLARE @sql_detect_QS_enabled NVARCHAR(250);
DECLARE @sql_detect_QS_enabled_params NVARCHAR(100);

SET @sql_detect_QS_enabled = 
	N'SELECT @qs_enabledOut = is_query_store_on 
	FROM sys.databases
	WHERE [name] = ''' + @dbname + '''
	';
SET @sql_detect_QS_enabled_params = N'@qs_enabledOut int OUTPUT';

EXEC sp_executesql @sql_detect_QS_enabled, @sql_detect_QS_enabled_params, @qs_enabledOut = @qs_enabled OUTPUT;

IF @qs_enabled = 0
		
	BEGIN
		-- Query Store is not enabled on the target database, return an error and stop execution.
		PRINT 'Query Store is not enabled on database "' + @dbname + '" aborting execution of sp_WhatsupQueryStore.';
		RETURN;
	END

ELSE

	BEGIN

		-- Now that we detected that the Query Store is enabled on the target database
		-- we can start grabbing information from it.

		IF @return_store_config = 1 OR @return_all = 1
			
			BEGIN

				/*
				SECTION 1
				Query Store configuration
				*/

				SELECT 'Query Store Configuration' AS 'Info';

				DECLARE @sql_qs_config NVARCHAR(900);

				SET @sql_qs_config =
				N'SELECT
				  actual_state_desc AS ''Operation mode (actual)'',
				  desired_state_desc AS ''Operation mode (desired)'',
				  current_storage_size_mb AS ''Query Store current size (MB)'',
				  [max_storage_size_mb] AS ''Query Store maximum size (MB)'',
				  [max_storage_size_mb]-current_storage_size_mb AS ''Query Store free space (MB)'',
				  [flush_interval_seconds]/60 AS ''Data Flush Interval (min)'',
				  [interval_length_minutes] AS ''Statistics Collection Interval (min)'',
				  stale_query_threshold_days AS ''Stale Query Threshold (days)'',
				  query_capture_mode_desc AS ''Query Capture Mode'',
				  [max_plans_per_query] AS ''Maximum nr of plans per query'',
				  size_based_cleanup_mode_desc AS ''Size based cleanup mode''
				FROM ' + @dbname + '.sys.database_query_store_options
				';

				EXEC sp_executesql @sql_qs_config;

			END;

		/*
		SECTION 2
		Forced Query Store plans
		*/

		IF @return_forced_plans = 1 OR @return_all = 1
			BEGIN

				SELECT 'Forced Query Store Execution Plans' AS 'Info';

				DECLARE @sql_qs_forced_plans NVARCHAR(2000);

				SET @sql_qs_forced_plans = 
				N'SELECT
				  qp.query_id AS ''Query ID'',
				  qp.plan_id AS ''Plan ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qp.query_plan AS XML) AS ''Execution Plan'',
				  qp.force_failure_count AS ''Force failure count'',
				  qp.last_force_failure_reason_desc AS ''Last failure reason'',
				  CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) AS ''Last execution date/time''
				FROM ' + @dbname + '.sys.query_store_plan qp WITH (NOLOCK)
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				WHERE qp.is_forced_plan = 1
				';

				EXEC sp_executesql @sql_qs_forced_plans;

			END;

		/*
		SECTION 3
		Queries with multiple execution plans
		*/

		IF @return_multiple_plans = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Queries with multiple plans in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_multiple_plans NVARCHAR(MAX);

				IF @show_query_hints = 0

					BEGIN

						SET @sql_qs_multiple_plans =
						N'WITH CTE_QS_Multiple_Plans (query_id, plan_count)
							AS
							(
							SELECT
							  qsp.query_id,
							  COUNT(qsp.plan_id)
							FROM ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
							WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
							GROUP BY query_id HAVING COUNT(plan_id) > 1
							)

						SELECT
						  cte.query_id AS ''Query ID'',
						  qsp.plan_id AS ''Plan ID'',
						  CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) AS ''Last Execution Time'',
						  qsqt.query_sql_text AS ''Query Text'',
						  qsp.engine_version AS ''Engine Version'',
						  qsp.[compatibility_level] AS ''Compatibility Level'',
						  CAST(qsp.query_plan AS XML) AS ''Execution Plan''
						FROM CTE_QS_Multiple_Plans cte
						INNER JOIN ' + @dbname + '.sys.query_store_plan qsp
						  ON cte.query_id = qsp.query_id
						INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
						  ON qsp.query_id = qsq.query_id
						INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
						  ON qsq.query_text_id = qsqt.query_text_id
						WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
						ORDER BY cte.query_id ASC
						';

						EXEC sp_executesql @sql_qs_multiple_plans;

					END;

				IF @show_query_hints = 1

					BEGIN

						SET @sql_qs_multiple_plans =
						N'WITH CTE_QS_Multiple_Plans (query_id, plan_count)
							AS
							(
							SELECT
							  qsp.query_id,
							  COUNT(qsp.plan_id)
							FROM ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
							WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
							GROUP BY query_id HAVING COUNT(plan_id) > 1
							)

						SELECT
						  cte.query_id AS ''Query ID'',
						  qsp.plan_id AS ''Plan ID'',
						  CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) AS ''Last Execution Time'',
						  qsqt.query_sql_text AS ''Query Text'',
						  qsp.engine_version AS ''Engine Version'',
						  qsp.[compatibility_level] AS ''Compatibility Level'',
						  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
						  CAST(''-- Force Execution Plan '' + CAST(qsp.plan_id AS varchar) + '' for Query '' + CAST(cte.query_id AS varchar) + '' through the Query Store &#xD; EXEC sp_query_store_force_plan '' + CAST(cte.query_id AS varchar) + '', '' + CAST(qsp.plan_id AS varchar) + '''' AS XML) AS ''Force Plan''
						FROM CTE_QS_Multiple_Plans cte
						INNER JOIN ' + @dbname + '.sys.query_store_plan qsp
						  ON cte.query_id = qsp.query_id
						INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
						  ON qsp.query_id = qsq.query_id
						INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
						  ON qsq.query_text_id = qsqt.query_text_id
						WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsp.last_execution_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
						ORDER BY cte.query_id ASC
						';

						EXEC sp_executesql @sql_qs_multiple_plans;

					END;

			END

		/*
		SECTION 4
		Top queries based on execution amount
		*/

		IF @return_top_executed = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most executed queries in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_nr_executions NVARCHAR(MAX);

				SET @sql_qs_top_nr_executions = 
				N'WITH CTE_QS_Top_Executions (plan_id, exec_count)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  SUM(qsrs.count_executions)
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY SUM(qsrs.count_executions) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.exec_count AS ''Execution count''
				FROM CTE_QS_Top_Executions cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				';
		
				EXEC sp_executesql @sql_qs_top_nr_executions;

			END;

		/*
		SECTION 5
		Top queries based on average duration
		*/

		IF @return_top_duration = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most expensive queries based on avg. duration in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_avg_duration NVARCHAR(MAX);
	
				SET @sql_qs_top_avg_duration = 
				N'WITH CTE_QS_Top_Duration (plan_id, avg_duration, nr_executions, [max_duration], min_duration)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  AVG(qsrs.avg_duration),
					  SUM(qsrs.count_executions),
					  MAX(qsrs.[max_duration]),
					  MIN(qsrs.[min_duration])
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY AVG(qsrs.avg_duration) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.avg_duration AS ''Avg. Duration'',
				  cte.nr_executions AS ''Nr. of executions in time window'',
				  cte.min_duration AS ''Min. duration'',
				  cte.[max_duration] AS ''Max. duration''
				FROM CTE_QS_Top_Duration cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				';
	
				EXEC sp_executesql @sql_qs_top_avg_duration;

			END;
	
		/*
		SECTION 6
		Top queries based on average CPU Time
		*/

		IF @return_top_cpu = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most expensive queries based on avg. CPU Time in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_avg_cputime NVARCHAR(MAX);
	
				SET @sql_qs_top_avg_cputime =
				N'WITH CTE_QS_Top_CPUTime (plan_id, avg_cputime, nr_executions, [max_cputime], min_cputime)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  AVG(qsrs.avg_cpu_time),
					  SUM(qsrs.count_executions),
					  MAX(qsrs.[max_cpu_time]),
					  MIN(qsrs.[min_cpu_time])
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY AVG(qsrs.avg_cpu_time) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.avg_cputime AS ''Avg. CPU Time'',
				  cte.nr_executions AS ''Nr. of executions in time window'',
				  cte.min_cputime AS ''Min. CPU Time'',
				  cte.[max_cputime] AS ''Max. CPU Time''
				FROM CTE_QS_Top_CPUTime cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				';
		
				EXEC sp_executesql @sql_qs_top_avg_cputime;

			END

		/*
		SECTION 7
		Top queries based on average logical IO reads
		*/

		IF @return_top_log_read = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most expensive queries based on avg. logical read IO in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_avg_log_io_read NVARCHAR(MAX);
		
				SET @sql_qs_top_avg_log_io_read = 
				N'WITH CTE_QS_Top_Log_IO_Read (plan_id, avg_log_io_read, nr_executions, [max_log_io_read], min_log_io_read)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  AVG(qsrs.avg_logical_io_reads),
					  SUM(qsrs.count_executions),
					  MAX(qsrs.[max_logical_io_reads]),
					  MIN(qsrs.[min_logical_io_reads])
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY AVG(qsrs.avg_logical_io_reads) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.avg_log_io_read AS ''Avg. Logical Read IO'',
				  cte.nr_executions AS ''Nr. of executions in time window'',
				  cte.min_log_io_read AS ''Min. Logical Read IO'',
				  cte.[max_log_io_read] AS ''Max. Logical Read IO''
				FROM CTE_QS_Top_Log_IO_Read cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				';

				EXEC sp_executesql @sql_qs_top_avg_log_io_read;

			END;

		/*
		SECTION 8
		Top queries based on average logical IO writes
		*/

		IF @return_top_log_write = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most expensive queries based on avg. logical write IO in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_avg_log_io_write NVARCHAR(MAX);
		
				SET @sql_qs_top_avg_log_io_write = 
				N'WITH CTE_QS_Top_Log_IO_write (plan_id, avg_log_io_write, nr_executions, [max_log_io_write], min_log_io_write)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  AVG(qsrs.avg_logical_io_writes),
					  SUM(qsrs.count_executions),
					  MAX(qsrs.[max_logical_io_writes]),
					  MIN(qsrs.[min_logical_io_writes])
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY AVG(qsrs.avg_logical_io_writes) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.avg_log_io_write AS ''Avg. Logical write IO'',
				  cte.nr_executions AS ''Nr. of executions in time window'',
				  cte.min_log_io_write AS ''Min. Logical write IO'',
				  cte.[max_log_io_write] AS ''Max. Logical write IO''
				FROM CTE_QS_Top_Log_IO_write cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				';

				EXEC sp_executesql @sql_qs_top_avg_log_io_write;

			END;

		/*
		SECTION 9
		Top queries based on average physical IO reads
		*/

		IF @return_top_phys_read = 1 OR @return_all = 1
			
			BEGIN

				SELECT 'Most expensive queries based on avg. physical read IO in the last ' + @timewindow + ' hour(s)' AS 'Info';

				DECLARE @sql_qs_top_avg_phys_io_read NVARCHAR(MAX);

				SET @sql_qs_top_avg_phys_io_read =
				N'WITH CTE_QS_Top_Phys_IO_read (plan_id, avg_phys_io_read, nr_executions, [max_phys_io_read], min_phys_io_read)
					AS
					(
					SELECT TOP ' + @topqueries + '
					  qsrs.plan_id,
					  AVG(qsrs.avg_physical_io_reads),
					  SUM(qsrs.count_executions),
					  MAX(qsrs.[max_physical_io_reads]),
					  MIN(qsrs.[min_physical_io_reads])
					FROM ' + @dbname + '.sys.query_store_runtime_stats qsrs WITH (NOLOCK)
					INNER JOIN ' + @dbname + '.sys.query_store_runtime_stats_interval qsrsi WITH (NOLOCK)
					  ON qsrs.runtime_stats_interval_id = qsrsi.runtime_stats_interval_id
					WHERE CONVERT(datetime, SWITCHOFFSET(CONVERT(datetimeoffset, qsrsi.end_time), DATENAME(TzOffset, SYSDATETIMEOFFSET()))) >= DATEADD(hour, -' + @timewindow + ', getdate())
					GROUP BY qsrs.plan_id
					ORDER BY AVG(qsrs.avg_logical_io_writes) DESC
					)

				SELECT
				  cte.plan_id AS ''Plan ID'',
				  qsp.query_id AS ''Query ID'',
				  qsqt.query_sql_text AS ''Statement'',
				  CAST(qsp.query_plan AS XML) AS ''Execution Plan'',
				  cte.avg_phys_io_read AS ''Avg. Physical read IO'',
				  cte.nr_executions AS ''Nr. of executions in time window'',
				  cte.min_phys_io_read AS ''Min. Physical read IO'',
				  cte.[max_phys_io_read] AS ''Max. Physical read IO''
				FROM CTE_QS_Top_Phys_IO_read cte
				INNER JOIN ' + @dbname + '.sys.query_store_plan qsp WITH (NOLOCK)
				  ON cte.plan_id = qsp.plan_id
				INNER JOIN ' + @dbname + '.sys.query_store_query qsq WITH (NOLOCK)
				  ON qsp.query_id = qsq.query_id
				INNER JOIN ' + @dbname + '.sys.query_store_query_text qsqt WITH (NOLOCK)
				  ON qsq.query_text_id = qsqt.query_text_id
				  ';

				EXEC sp_executesql @sql_qs_top_avg_phys_io_read;

			END;

	END;
GO
