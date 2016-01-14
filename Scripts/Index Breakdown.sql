SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


-----------------------------------------------------------------------------------------------------------------------------
--	Script Details: Listing Of Standard Details Related To The Script
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Breakdown Of All Indexes Contained Within A Database
--	Create Date (MM/DD/YYYY): 12/23/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: Added "@Report_Style" Variable
--	Date (MM/DD/YYYY): 11/09/2015
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Declarations / Sets: Declare And Set Variables
-----------------------------------------------------------------------------------------------------------------------------

DECLARE
	 @Database_ID AS SMALLINT
	,@Report_Style AS BIT


DECLARE @Index_Filters AS TABLE

	(
		 [object_id] INT NOT NULL
		,index_id INT NOT NULL
		,filter_definition NVARCHAR (MAX) NOT NULL
	)


SET @Database_ID = DB_ID ()


SET @Report_Style = 1


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Temp Table(s) Already Exist(s) And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_index_breakdown_keys_filters', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_index_breakdown_keys_filters

END


IF OBJECT_ID (N'tempdb.dbo.#temp_index_breakdown_size_info', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_index_breakdown_size_info

END


-----------------------------------------------------------------------------------------------------------------------------
--	Table Insert: Insert Filtered Index Data Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sys.all_columns AC WHERE AC.[object_id] = OBJECT_ID (N'sys.indexes', N'V') AND AC.name = N'has_filter')
BEGIN

	INSERT INTO @Index_Filters

		(
			 [object_id]
			,index_id
			,filter_definition
		)

	EXECUTE

		(
			N'
				SELECT
					 I.[object_id]
					,I.index_id
					,I.filter_definition
				FROM
					sys.indexes I
				WHERE
					I.has_filter = 1
			 '
		)

END


-----------------------------------------------------------------------------------------------------------------------------
--	Table Insert: Insert Index Key, Include Key, And Filter Definition Values Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------

SELECT
	 sqI.[object_id]
	,sqI.index_id
	,STUFF (CONVERT (NVARCHAR (MAX), sqI.index_key), 1, 2, N'') AS index_key
	,STUFF (CONVERT (NVARCHAR (MAX), sqI.include_key), 1, 2, N'') AS include_key
	,sqI.filter_definition
	,RANK () OVER
				(
					ORDER BY
						 sqI.[object_id]
						,CONVERT (NVARCHAR (MAX), sqI.index_key)
						,sqI.filter_definition
				) AS dupe_rank
INTO
	dbo.#temp_index_breakdown_keys_filters
FROM

	(
		SELECT
			 I.[object_id]
			,I.index_id
			,(
				SELECT
					  N', '
					+ C.name
					+ N' • '
					+ LOWER (TYPE_NAME (C.user_type_id)
					+ ISNULL ((N': [ ' + (CASE
											WHEN C.system_type_id <> C.user_type_id THEN TYPE_NAME (C.system_type_id)
											END) + N' ]'), N''))
					+ N' '
					+ (CASE
							WHEN LOWER (TYPE_NAME (C.system_type_id)) IN (N'nchar', N'ntext', N'nvarchar') THEN CONVERT (VARCHAR (6), C.max_length / 2)
							WHEN LOWER (TYPE_NAME (C.system_type_id)) NOT IN (N'bigint', N'bit', N'date', N'datetime', N'datetime2', N'datetimeoffset', N'decimal', N'float', N'int', N'money', N'numeric', N'real', N'smalldatetime', N'smallint', N'smallmoney', N'time', N'tinyint') THEN CONVERT (VARCHAR (6), C.max_length)
							ELSE CONVERT (VARCHAR (6), C.max_length) + ' (' + CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, 'Precision')) + ',' + ISNULL (CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, 'Scale')), 0) + ')'
							END)
					+ N' '
					+ (CASE
							WHEN IC.is_descending_key = 0 THEN N'[A]'
							WHEN IC.is_descending_key = 1 THEN N'[D]'
							ELSE N'[N/A]'
							END) AS [text()]
				FROM
					sys.index_columns IC
					INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
						AND C.column_id = IC.column_id
					INNER JOIN sys.types TY ON TY.user_type_id = C.user_type_id
				WHERE
					IC.is_included_column = 0
					AND IC.[object_id] = I.[object_id]
					AND IC.index_id = I.index_id
				ORDER BY
					IC.key_ordinal
				FOR
					 XML PATH ('')
					,TYPE
			 ) AS index_key
			,(
				SELECT
					  N', '
					+ C.name
					+ N' • '
					+ TYPE_NAME (C.user_type_id)
					+ ISNULL ((N': [ ' + (CASE
											WHEN C.system_type_id <> C.user_type_id THEN LOWER (TYPE_NAME (C.system_type_id))
											END) + N' ]'), N'')
					+ N' '
					+ (CASE
							WHEN TY.name NOT IN (N'bigint', N'bit', N'date', N'datetime', N'datetime2', N'datetimeoffset', N'decimal', N'float', N'int', N'money', N'numeric', N'real', N'smalldatetime', N'smallint', N'smallmoney', N'time', N'tinyint') THEN CONVERT (NVARCHAR (30), C.max_length)
							ELSE CONVERT (NVARCHAR (30), C.max_length) + N' (' + CONVERT (NVARCHAR (30), COLUMNPROPERTY (C.[object_id], C.name, 'Precision')) + N',' + ISNULL (CONVERT (NVARCHAR (30), COLUMNPROPERTY (C.[object_id], C.name, 'Scale')), 0) + N')'
							END) AS [text()]
				FROM
					sys.index_columns IC
					INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
						AND C.column_id = IC.column_id
					INNER JOIN sys.types TY ON TY.user_type_id = C.user_type_id
				WHERE
					IC.is_included_column = 1
					AND IC.[object_id] = I.[object_id]
					AND IC.index_id = I.index_id
				ORDER BY
					IC.key_ordinal
				FOR
					 XML PATH ('')
					,TYPE
			 ) AS include_key
			,tvIF.filter_definition
		FROM
			sys.indexes I
			LEFT JOIN @Index_Filters tvIF ON tvIF.[object_id] = I.[object_id]
				AND tvIF.index_id = I.index_id
	) sqI


-----------------------------------------------------------------------------------------------------------------------------
--	Table Insert: Insert Size Values Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------

SELECT
	 DDPS.[object_id]
	,DDPS.index_id
	,SUM (CASE
			WHEN DDPS.index_id < 2 THEN DDPS.row_count
			END) AS [rows]
	,SUM (DDPS.reserved_page_count) AS total_pages
	,SUM (DDPS.used_page_count) AS used_pages
	,SUM (CASE
			WHEN DDPS.index_id < 2 THEN DDPS.in_row_data_page_count + DDPS.lob_used_page_count + DDPS.row_overflow_used_page_count
			ELSE DDPS.lob_used_page_count + DDPS.row_overflow_used_page_count
			END) AS data_pages
INTO
	dbo.#temp_index_breakdown_size_info
FROM
	sys.dm_db_partition_stats DDPS
GROUP BY
	 DDPS.[object_id]
	,DDPS.index_id


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SELECT
	 (CASE
		WHEN sqBAQ.row_filter = 1 THEN sqBAQ.[type]
		ELSE ''
		END) AS object_type
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN DB_NAME ()
		ELSE ''
		END) AS [database_name]
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN SCHEMA_NAME (sqBAQ.[schema_id])
		ELSE ''
		END) AS [schema_name]
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN OBJECT_NAME (sqBAQ.[object_id])
		ELSE ''
		END) AS [object_name]
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN sqBAQ.create_date
		ELSE ''
		END) AS create_date
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN caMDKL.modify_date
		ELSE ''
		END) AS modify_date
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, sqBAQ.[rows]), 1)), 4, 23))
		ELSE ''
		END) AS [rows]
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (23), CONVERT (MONEY, (sqBAQ.total_pages * 8) / 1024.0), 1)
		ELSE ''
		END) AS total_mb
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (23), CONVERT (MONEY, (sqBAQ.used_pages * 8) / 1024.0), 1)
		ELSE ''
		END) AS used_mb
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (23), CONVERT (MONEY, (sqBAQ.unused_pages * 8) / 1024.0), 1)
		ELSE ''
		END) AS unused_mb
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (23), CONVERT (MONEY, (sqBAQ.data_pages * 8) / 1024.0), 1)
		ELSE ''
		END) AS data_mb
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (23), CONVERT (MONEY, (sqBAQ.index_pages * 8) / 1024.0), 1)
		ELSE ''
		END) AS index_mb
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (6), CONVERT (DECIMAL (5, 2), ISNULL (((sqBAQ.data_pages + .0) / sqBAQ.used_pages) * 100, 0)))
		ELSE ''
		END) AS pct_data
	,(CASE
		WHEN sqBAQ.row_filter = 1 THEN CONVERT (VARCHAR (6), CONVERT (DECIMAL (5, 2), ISNULL (((sqBAQ.index_pages + .0) / sqBAQ.used_pages) * 100, 0)))
		ELSE ''
		END) AS pct_index
	,sqBAQ.type_desc AS index_type
	,ISNULL (sqBAQ.index_name, '') AS index_name
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		WHEN sqBAQ.is_primary_key = 0 AND sqBAQ.is_unique = 0 THEN REPLICATE ('.', 6)
		WHEN sqBAQ.is_system_named = 0 THEN 'No'
		WHEN sqBAQ.is_system_named = 1 THEN 'Yes'
		ELSE ''
		END) AS system_named
	,(CASE
		WHEN sqBAQ.is_primary_key = 1 THEN 'Yes'
		ELSE ''
		END) AS is_pk
	,(CASE
		WHEN sqBAQ.is_unique_constraint = 1 THEN 'C'
		WHEN sqBAQ.is_unique = 1 THEN 'I'
		ELSE ''
		END) AS [unique]
	,(CASE
		WHEN sqBAQ.is_disabled = 1 THEN 'Yes'
		ELSE ''
		END) AS [disabled]
	,(CASE
		WHEN sqBAQ.is_hypothetical = 1 THEN 'Yes'
		ELSE ''
		END) AS hypothetical
	,REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, sqCC.total_columns), 1)), 4, 23)) AS total_columns
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, caMDKL.[index_columns]), 1)), 4, 23))
		END) AS [index_columns]
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, caMDKL.include_columns), 1)), 4, 23))
		END) AS include_columns
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE CONVERT (VARCHAR (23), CONVERT (MONEY, (caMDKL.[index_columns] / sqCC.total_columns) * 100), 1)
		END) AS index_pct_of_columns
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE CONVERT (VARCHAR (23), CONVERT (MONEY, (caMDKL.include_columns / sqCC.total_columns) * 100), 1)
		END) AS include_pct_of_columns
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE CONVERT (VARCHAR (23), CONVERT (MONEY, ((caMDKL.[index_columns] + caMDKL.include_columns) / sqCC.total_columns) * 100), 1)
		END) AS total_pct_of_columns
	,CONVERT (VARCHAR (23), CONVERT (MONEY, (ISNULL (sqBAQ.individual_index_pages, 0) * 8) / 1024.0), 1) AS key_mb
	,CONVERT (VARCHAR (6), CONVERT (DECIMAL (5, 2), ISNULL (((sqBAQ.individual_index_pages + .0) / sqBAQ.index_pages) * 100, 0))) AS key_mb_pct
	,(CASE
		WHEN sqBAQ.type_desc = N'HEAP' THEN ''
		ELSE REVERSE (SUBSTRING (REVERSE (CONVERT (VARCHAR (23), CONVERT (MONEY, sqKL.total_max_length), 1)), 4, 23))
		END) AS max_key_size_bytes
	,(CASE
		WHEN sqKL.total_max_length > 900 THEN 'Yes'
		ELSE ''
		END) AS over_key_size_limit
	,ISNULL (ttIBKF.index_key, N'') AS index_key
	,ISNULL (ttIBKF.include_key, N'') AS include_key
	,ISNULL (ttIBKF.filter_definition, N'') AS filter_definition
	,(CASE
		WHEN sqED02.dupe_id IS NOT NULL THEN CONVERT (VARCHAR (20), sqED02.dupe_id) + ' - [' + CONVERT (VARCHAR (11), sqED02.total_dupes) + ']'
		ELSE ''
		END) AS dupe_id
	,sqBAQ.is_unused AS unused
	,ISNULL (CONVERT (VARCHAR (10), STATS_DATE (sqBAQ.[object_id], sqBAQ.index_id), 23), '') AS statistics_date
	,(CASE
		WHEN sqBAQ.[allow_row_locks] = 0 THEN 'No'
		WHEN sqBAQ.[allow_row_locks] = 1 THEN 'Yes'
		ELSE ''
		END) AS row_locks
	,(CASE
		WHEN sqBAQ.[allow_page_locks] = 0 THEN 'No'
		WHEN sqBAQ.[allow_page_locks] = 1 THEN 'Yes'
		ELSE ''
		END) AS page_locks
	,(CASE
		WHEN sqBAQ.[ignore_dup_key] = 0 THEN 'No'
		WHEN sqBAQ.[ignore_dup_key] = 1 THEN 'Yes'
		ELSE ''
		END) AS ignore_dupes
	,(CASE
		WHEN sqBAQ.no_recompute = 0 THEN 'Yes'
		WHEN sqBAQ.no_recompute = 1 THEN 'No'
		ELSE ''
		END) AS auto_stats
	,(CASE
		WHEN sqBAQ.is_padded = 0 THEN 'No'
		WHEN sqBAQ.is_padded = 1 THEN 'Yes'
		ELSE ''
		END) AS padded
	,(CASE
		WHEN sqBAQ.fill_factor = 0 THEN 100
		ELSE sqBAQ.fill_factor
		END) AS fill_factor
	,(CASE
		WHEN sqBAQ.user_seeks > 0 THEN CONVERT (VARCHAR (20), sqBAQ.user_seeks)
		ELSE ''
		END) AS user_seeks
	,(CASE
		WHEN sqBAQ.user_scans > 0 THEN CONVERT (VARCHAR (20), sqBAQ.user_scans)
		ELSE ''
		END) AS user_scans
	,(CASE
		WHEN sqBAQ.user_lookups > 0 THEN CONVERT (VARCHAR (20), sqBAQ.user_lookups)
		ELSE ''
		END) AS user_lookups
	,(CASE
		WHEN sqBAQ.user_updates > 0 THEN CONVERT (VARCHAR (20), sqBAQ.user_updates)
		ELSE ''
		END) AS user_updates
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_user_seek, 23), '') AS last_user_seek
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_user_scan, 23), '') AS last_user_scan
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_user_lookup, 23), '') AS last_user_lookup
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_user_update, 23), '') AS last_user_update
	,(CASE
		WHEN sqBAQ.system_seeks > 0 THEN CONVERT (VARCHAR (20), sqBAQ.system_seeks)
		ELSE ''
		END) AS system_seeks
	,(CASE
		WHEN sqBAQ.system_scans > 0 THEN CONVERT (VARCHAR (20), sqBAQ.system_scans)
		ELSE ''
		END) AS system_scans
	,(CASE
		WHEN sqBAQ.system_lookups > 0 THEN CONVERT (VARCHAR (20), sqBAQ.system_lookups)
		ELSE ''
		END) AS system_lookups
	,(CASE
		WHEN sqBAQ.system_updates > 0 THEN CONVERT (VARCHAR (20), sqBAQ.system_updates)
		ELSE ''
		END) AS system_updates
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_system_seek, 23), '') AS last_system_seek
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_system_scan, 23), '') AS last_system_scan
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_system_lookup, 23), '') AS last_system_lookup
	,ISNULL (CONVERT (VARCHAR (10), sqBAQ.last_system_update, 23), '') AS last_system_update
FROM

	(
		SELECT
			 O.[type]
			,O.[schema_id]
			,O.[object_id]
			,CONVERT (VARCHAR (10), O.create_date, 23) AS create_date
			,CONVERT (VARCHAR (10), O.modify_date, 23) AS modify_date
			,sqDDPS.[rows]
			,sqDDPS.total_pages
			,sqDDPS.used_pages
			,(CASE
				WHEN sqDDPS.total_pages > sqDDPS.used_pages THEN sqDDPS.total_pages - sqDDPS.used_pages
				ELSE 0
				END) AS unused_pages
			,sqDDPS.data_pages
			,(CASE
				WHEN sqDDPS.used_pages > sqDDPS.data_pages THEN sqDDPS.used_pages - sqDDPS.data_pages
				ELSE 0
				END) AS index_pages
			,sqI.type_desc
			,sqI.name AS index_name
			,sqI.is_system_named
			,sqI.is_primary_key
			,sqI.is_unique
			,sqI.is_disabled
			,sqI.is_hypothetical
			,sqI.individual_index_pages
			,sqI.is_unused
			,sqI.[allow_row_locks]
			,sqI.[allow_page_locks]
			,sqI.[ignore_dup_key]
			,sqI.no_recompute
			,sqI.is_padded
			,sqI.fill_factor
			,sqI.user_seeks
			,sqI.user_scans
			,sqI.user_lookups
			,sqI.user_updates
			,sqI.last_user_seek
			,sqI.last_user_scan
			,sqI.last_user_lookup
			,sqI.last_user_update
			,sqI.system_seeks
			,sqI.system_scans
			,sqI.system_lookups
			,sqI.system_updates
			,sqI.last_system_seek
			,sqI.last_system_scan
			,sqI.last_system_lookup
			,sqI.last_system_update
			,sqI.is_unique_constraint
			,sqI.index_id
			,sqI.row_filter
		FROM
			sys.objects O
			INNER JOIN

				(
					SELECT
						 ttIBSI.[object_id]
						,SUM (ttIBSI.[rows]) AS [rows]
						,SUM (ttIBSI.total_pages) AS total_pages
						,SUM (ttIBSI.used_pages) AS used_pages
						,SUM (ttIBSI.data_pages) AS data_pages
					FROM
						dbo.#temp_index_breakdown_size_info ttIBSI
					GROUP BY
						ttIBSI.[object_id]
				) sqDDPS ON sqDDPS.[object_id] = O.[object_id]

			INNER JOIN

				(
					SELECT
						 I.[object_id]
						,I.type_desc
						,I.name
						,KC.is_system_named
						,I.is_primary_key
						,I.is_unique
						,I.is_disabled
						,I.is_hypothetical
						,(CASE
							WHEN ttIBSI.used_pages > ttIBSI.data_pages THEN ttIBSI.used_pages - ttIBSI.data_pages
							END) AS individual_index_pages
						,(CASE
							WHEN I.[type] = 0 THEN ''
							WHEN I.[type] = 1 THEN REPLICATE ('.', 6)
							WHEN I.is_primary_key = 1 THEN REPLICATE ('.', 6)
							WHEN I.is_unique = 1 THEN REPLICATE ('.', 6)
							WHEN EXISTS

								(
									SELECT
										*
									FROM
										sys.index_columns IC
										INNER JOIN sys.foreign_key_columns FKC ON FKC.parent_object_id = IC.[object_id]
											AND FKC.parent_column_id = IC.column_id
									WHERE
										IC.[object_id] = I.[object_id]
										AND IC.index_id = I.index_id
								) THEN REPLICATE ('.', 6)

							WHEN DDIUS.[object_id] IS NOT NULL THEN (CASE
																		WHEN DDIUS.user_seeks + DDIUS.user_scans + DDIUS.user_lookups + DDIUS.user_updates = 0 THEN 'Y/N'
																		ELSE 'No'
																		END)
							ELSE 'Yes'
							END) AS is_unused
						,I.[allow_row_locks]
						,I.[allow_page_locks]
						,I.[ignore_dup_key]
						,S.no_recompute
						,I.is_padded
						,I.fill_factor
						,DDIUS.user_seeks
						,DDIUS.user_scans
						,DDIUS.user_lookups
						,DDIUS.user_updates
						,DDIUS.last_user_seek
						,DDIUS.last_user_scan
						,DDIUS.last_user_lookup
						,DDIUS.last_user_update
						,DDIUS.system_seeks
						,DDIUS.system_scans
						,DDIUS.system_lookups
						,DDIUS.system_updates
						,DDIUS.last_system_seek
						,DDIUS.last_system_scan
						,DDIUS.last_system_lookup
						,DDIUS.last_system_update
						,I.is_unique_constraint
						,I.index_id
						,(CASE
							WHEN @Report_Style = 0 THEN 1
							ELSE ROW_NUMBER () OVER
													(
														PARTITION BY
															I.[object_id]
														ORDER BY
															 I.is_primary_key DESC
															,(CASE
																WHEN I.[type] = 0 THEN 'Z'
																ELSE 'A'
																END)
															,I.[type]
															,I.name
													)
							END) AS row_filter
					FROM
						sys.indexes I
						LEFT JOIN dbo.#temp_index_breakdown_size_info ttIBSI ON ttIBSI.[object_id] = I.[object_id]
							AND ttIBSI.index_id = I.index_id
						LEFT JOIN sys.key_constraints KC ON KC.parent_object_id = I.[object_id]
							AND KC.unique_index_id = I.index_id
						LEFT JOIN sys.stats S ON S.[object_id] = I.[object_id]
							AND S.stats_id = I.index_id
						LEFT JOIN master.sys.dm_db_index_usage_stats DDIUS ON DDIUS.[object_id] = I.[object_id]
							AND DDIUS.index_id = I.index_id
							AND DDIUS.database_id = @Database_ID
				) sqI ON sqI.[object_id] = O.[object_id]

		WHERE
			O.[type] IN ('U', 'V')
			AND O.is_ms_shipped = 0
			AND NOT

				(
					SCHEMA_NAME (O.[schema_id]) = N'dbo'
					AND O.name = N'sysdiagrams'
					AND O.[type] = 'U'
				)

	) sqBAQ

	INNER JOIN

		(
			SELECT
				 C.[object_id]
				,COUNT (*) + .0 AS total_columns
			FROM
				sys.columns C
			GROUP BY
				C.[object_id]
		) sqCC ON sqCC.[object_id] = sqBAQ.[object_id]

	LEFT JOIN dbo.#temp_index_breakdown_keys_filters ttIBKF ON ttIBKF.[object_id] = sqBAQ.[object_id]
		AND ttIBKF.index_id = sqBAQ.index_id
	LEFT JOIN

		(
			SELECT
				 IC.[object_id]
				,IC.index_id
				,SUM (C.max_length) AS total_max_length
			FROM
				sys.index_columns IC
				INNER JOIN sys.columns C ON C.[object_id] = IC.[object_id]
					AND C.column_id = IC.column_id
			WHERE
				IC.is_included_column = 0
			GROUP BY
				 IC.[object_id]
				,IC.index_id
		) sqKL ON sqKL.[object_id] = sqBAQ.[object_id] AND sqKL.index_id = sqBAQ.index_id

	LEFT JOIN

		(
			SELECT
				 sqED01.dupe_rank
				,sqED01.total_dupes
				,ROW_NUMBER () OVER
									(
										ORDER BY
											(SELECT NULL)
									) AS dupe_id
			FROM

				(
					SELECT
						 ttIBKF.dupe_rank
						,COUNT (*) AS total_dupes
					FROM
						dbo.#temp_index_breakdown_keys_filters ttIBKF
					GROUP BY
						ttIBKF.dupe_rank
					HAVING
						COUNT (*) > 1
				) sqED01

		) sqED02 ON sqED02.dupe_rank = ttIBKF.dupe_rank

	CROSS APPLY

		(
			SELECT
				 (CASE
					WHEN sqBAQ.modify_date = sqBAQ.create_date THEN REPLICATE ('.', 18)
					ELSE sqBAQ.modify_date
					END) AS modify_date
				,LEN (ttIBKF.index_key) - LEN (REPLACE (ttIBKF.index_key, '•', '')) AS [index_columns]
				,ISNULL (LEN (ttIBKF.include_key) - LEN (REPLACE (ttIBKF.include_key, '•', '')), 0) AS include_columns
		) caMDKL

ORDER BY
	 sqBAQ.[type]
	,SCHEMA_NAME (sqBAQ.[schema_id])
	,OBJECT_NAME (sqBAQ.[object_id])
	,sqBAQ.row_filter


-----------------------------------------------------------------------------------------------------------------------------
--	Cleanup: Drop Any Remaining Temp Tables
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_index_breakdown_keys_filters', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_index_breakdown_keys_filters

END


IF OBJECT_ID (N'tempdb.dbo.#temp_index_breakdown_size_info', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_index_breakdown_size_info

END