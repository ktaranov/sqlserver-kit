SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Procedure Already Exists And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'[dbo].[usp_String_Search]', N'P') IS NOT NULL
BEGIN

	DROP PROCEDURE [dbo].[usp_String_Search]

END
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Search For A String Value Within Columns Of Data Types CHAR, NCHAR, NTEXT, NVARCHAR, TEXT, VARCHAR, XML
--	Create Date (MM/DD/YYYY): 03/20/2012
--	Developer: Sean Smith (s(DOT)smith(DOT)sql(AT)gmail(DOT)com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: No Modifications To Date
--	Date (MM/DD/YYYY): N/A
--	Developer: N/A
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_String_Search]

	 @v_Search_String AS NVARCHAR (500)
	,@v_Database_Name AS NVARCHAR (300)
	,@v_Object_Types AS NVARCHAR (10) = NULL
	,@v_Data_Types AS NVARCHAR (100) = NULL
	,@v_Table_Max_Rows AS BIGINT = NULL
	,@v_Column_Max_Length AS SMALLINT = NULL

WITH RECOMPILE

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


DECLARE @v_Loop_Column_Number AS BIGINT
DECLARE @v_Loop_Column_Number_First AS BIGINT
DECLARE @v_Loop_Object_Number AS BIGINT
DECLARE @v_Object_Name AS SYSNAME
DECLARE @v_Schema_Name AS SYSNAME
DECLARE @v_SQL_String_Full AS NVARCHAR (MAX)
DECLARE @v_SQL_String_IN_Column_Name AS NVARCHAR (MAX)
DECLARE @v_SQL_String_SELECT AS NVARCHAR (MAX)
DECLARE @v_SQL_String_WHERE AS NVARCHAR (MAX)


SET @v_Object_Types = N''''+REPLACE (REPLACE (NULLIF (@v_Object_Types, N''), N' ', N''), N',', N''',''')+N''''
SET @v_Data_Types = N''''+REPLACE (REPLACE (NULLIF (@v_Data_Types, N''), N' ', N''), N',', N''',''')+N''''


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping I: Validate "@v_Search_String" And "@v_Database_Name" Input Parameter Values
-----------------------------------------------------------------------------------------------------------------------------

IF NULLIF (@v_Search_String, N'') IS NOT NULL
BEGIN

	SET @v_Search_String = REPLACE (REPLACE (REPLACE (REPLACE (@v_Search_String, N'[', N'[[]'), N'%', N'[%]'), N'_', N'[_]'), N'''', N'''''')

END
ELSE BEGIN

	RAISERROR

		(
			 N'ERROR: @v_Search_String input parameter cannot be blank or NULL.'
			,16
			,1
		)


	GOTO Skip_Query

END


IF EXISTS (SELECT * FROM [master].[sys].[databases] DB WHERE DB.name = @v_Database_Name)
BEGIN

	SET @v_Database_Name = QUOTENAME (@v_Database_Name)

END
ELSE IF EXISTS (SELECT * FROM [master].[sys].[databases] DB WHERE QUOTENAME (DB.name) = @v_Database_Name+N']')
BEGIN

	SET @v_Database_Name = @v_Database_Name+N']'

END
ELSE IF NOT EXISTS (SELECT * FROM [master].[sys].[databases] DB WHERE QUOTENAME (DB.name) = @v_Database_Name)
BEGIN

	RAISERROR

		(
			 N'ERROR: Database (''%s'') does not exist. Make sure that the name is entered correctly.'
			,16
			,1
			,@v_Database_Name
		)


	GOTO Skip_Query

END


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping II: Check If Temp Table(s) Already Exist(s) And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_string_search_objects_columns', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_string_search_objects_columns

END


IF OBJECT_ID (N'tempdb.dbo.#temp_string_search_results', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_string_search_results

END


-----------------------------------------------------------------------------------------------------------------------------
--	Table Creation: Create Temp Tables To Temporarily Store Searchable Objects / Columns And Output Results
-----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.#temp_string_search_objects_columns

	(
		 object_type VARCHAR (2) NOT NULL
		,data_type SYSNAME NOT NULL
		,max_length SMALLINT NOT NULL
		,[schema_name] SYSNAME NOT NULL
		,[object_name] SYSNAME NOT NULL
		,column_name SYSNAME NOT NULL
		,schema_object_dense_rank BIGINT NOT NULL
		,column_row_number BIGINT UNIQUE NOT NULL
		,PRIMARY KEY CLUSTERED
			(
				 schema_object_dense_rank
				,column_row_number
			)
	)


CREATE TABLE dbo.#temp_string_search_results

	(
		 [schema_name] SYSNAME NOT NULL
		,[object_name] SYSNAME NOT NULL
		,column_name SYSNAME NOT NULL
		,column_data NVARCHAR (MAX) NOT NULL
		,occurrences INT NOT NULL
	)


-----------------------------------------------------------------------------------------------------------------------------
--	Table Update I: Insert Searchable Objects / Columns Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------

SET @v_SQL_String_Full =

	N'
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		SET NOCOUNT ON
		SET ANSI_WARNINGS OFF
		SET ARITHABORT OFF
		SET ARITHIGNORE ON


		SELECT
			 O.[type] AS object_type
			,T.name AS data_type
			,C.max_length
			,S.name AS [schema_name]
			,O.name AS [object_name]
			,C.name AS column_name
			,DENSE_RANK () OVER
							(
								ORDER BY
									 S.name
									,O.name
							) AS schema_object_dense_rank
			,ROW_NUMBER () OVER
							(
								ORDER BY
									C.name
							) AS column_row_number
		FROM
			'+@v_Database_Name+N'.[sys].[schemas] S
			INNER JOIN '+@v_Database_Name+N'.[sys].[objects] O ON O.[schema_id] = S.[schema_id]
				AND O.[type] IN ('+(CASE
										WHEN @v_Object_Types IS NOT NULL THEN @v_Object_Types
										ELSE N'''U'', ''V'''
										END)+N')
			INNER JOIN '+@v_Database_Name+N'.[sys].[columns] C ON C.[object_id] = O.[object_id]
	 '


IF @v_Column_Max_Length > 0
BEGIN

	SET @v_SQL_String_Full = @v_SQL_String_Full+

		N'
			'+NCHAR (9)+N'AND C.system_type_id IN (167, 175, 231, 239)
			'+NCHAR (9)+N'AND C.max_length BETWEEN 1 AND '+CONVERT (NVARCHAR (6), @v_Column_Max_Length)+N'
		 '

END
ELSE BEGIN

	SET @v_SQL_String_Full = @v_SQL_String_Full+

		N'
			'+NCHAR (9)+N'AND C.system_type_id IN (35, 99, 167, 175, 231, 239, 241)
		 '

END


SET @v_SQL_String_Full = @v_SQL_String_Full+

	N'
			INNER JOIN '+@v_Database_Name+N'.[sys].[types] T ON T.system_type_id = C.system_type_id
				AND T.user_type_id = C.user_type_id
	 '+(CASE
			WHEN @v_Data_Types IS NOT NULL THEN REPLICATE (NCHAR (9), 3)+N'AND T.name IN ('+@v_Data_Types+N')'
			ELSE N''
			END)


IF @v_Table_Max_Rows > 0
BEGIN

	SET @v_SQL_String_Full = @v_SQL_String_Full+

		N'
			INNER JOIN

				(
					SELECT
						DDPS.[object_id]
					FROM
						'+@v_Database_Name+N'.[sys].[dm_db_partition_stats] DDPS
					WHERE
						DDPS.index_id < 2
					GROUP BY
						DDPS.[object_id]
					HAVING
						SUM (DDPS.row_count) <= '+CONVERT (NVARCHAR (20), @v_Table_Max_Rows)+N'
				) SQ1 ON SQ1.[object_id] = O.[object_id]
		 '

END


INSERT INTO #temp_string_search_objects_columns

EXECUTE (@v_SQL_String_Full)


-----------------------------------------------------------------------------------------------------------------------------
--	Table Update II: Insert Matched Results Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------

SELECT TOP (1)
	 @v_Loop_Object_Number = X.schema_object_dense_rank
	,@v_Schema_Name = X.[schema_name]
	,@v_Object_Name = X.[object_name]
FROM
	#temp_string_search_objects_columns X
ORDER BY
	X.schema_object_dense_rank


WHILE @v_Loop_Object_Number IS NOT NULL
BEGIN

	SET @v_SQL_String_SELECT = N''
	SET @v_SQL_String_IN_Column_Name = N''
	SET @v_SQL_String_WHERE = N''
	SET @v_Loop_Column_Number = (SELECT MIN (X.column_row_number) FROM #temp_string_search_objects_columns X WHERE X.schema_object_dense_rank = @v_Loop_Object_Number)
	SET @v_Loop_Column_Number_First = @v_Loop_Column_Number


	WHILE @v_Loop_Column_Number IS NOT NULL
	BEGIN

		SELECT
			 @v_SQL_String_SELECT = @v_SQL_String_SELECT+(CASE
															WHEN @v_Loop_Column_Number = @v_Loop_Column_Number_First THEN N'SELECT'+NCHAR (13)+REPLICATE (NCHAR (9), 7)+N' '
															ELSE NCHAR (13)+REPLICATE (NCHAR (9), 7)+N','
															END)+N'CONVERT (NVARCHAR (MAX), (CASE
																								WHEN '+(CASE
																											WHEN X.data_type = N'XML' THEN N'CONVERT (NVARCHAR (MAX), '
																											ELSE N''
																											END)+QUOTENAME (X.column_name)+(CASE
																																				WHEN X.data_type = N'XML' THEN N')'
																																				ELSE N''
																																				END)+N' LIKE ''%'+@v_Search_String+N'%'' THEN '+QUOTENAME (X.column_name)+N'
																								ELSE NULL
																								END)) AS '+QUOTENAME (X.column_name)
			,@v_SQL_String_IN_Column_Name = @v_SQL_String_IN_Column_Name+(CASE
																			WHEN @v_Loop_Column_Number = @v_Loop_Column_Number_First THEN N''
																			ELSE N', '
																			END)+QUOTENAME (X.column_name)
			,@v_SQL_String_WHERE = @v_SQL_String_WHERE+(CASE
															WHEN @v_Loop_Column_Number = @v_Loop_Column_Number_First THEN NCHAR (13)+REPLICATE (NCHAR (9), 6)+N'WHERE'+NCHAR (13)+REPLICATE (NCHAR (9), 7)
															ELSE NCHAR (13)+REPLICATE (NCHAR (9), 7)+N'OR '
															END)+(CASE
																	WHEN X.data_type = N'XML' THEN N'CONVERT (NVARCHAR (MAX), '
																	ELSE N''
																	END)+QUOTENAME (X.column_name)+(CASE
																										WHEN X.data_type = N'XML' THEN N')'
																										ELSE N''
																										END)+N' LIKE ''%'+@v_Search_String+N'%'''
		FROM
			#temp_string_search_objects_columns X
		WHERE
			X.schema_object_dense_rank = @v_Loop_Object_Number
			AND X.column_row_number = @v_Loop_Column_Number


		SET @v_Loop_Column_Number = (SELECT MIN (X.column_row_number) FROM #temp_string_search_objects_columns X WHERE X.schema_object_dense_rank = @v_Loop_Object_Number AND X.column_row_number > @v_Loop_Column_Number)

	END


	SET @v_SQL_String_Full =

		(
			N'
				SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
				SET NOCOUNT ON
				SET ANSI_WARNINGS OFF
				SET ARITHABORT OFF
				SET ARITHIGNORE ON


				SELECT
					 '''+@v_Schema_Name+N''' AS [schema_name]
					,'''+@v_Object_Name+N''' AS [object_name]
					,UNPV.column_name
					,UNPV.column_data
					,COUNT (*) AS occurrences
				FROM

					(
						'
							+@v_SQL_String_SELECT
							+NCHAR (13)+REPLICATE (NCHAR (9), 6)+N'FROM'+NCHAR (13)
							+REPLICATE (NCHAR (9), 7)+@v_Database_Name
							+N'.'
							+QUOTENAME (@v_Schema_Name)
							+N'.'
							+QUOTENAME (@v_Object_Name)
							+@v_SQL_String_WHERE
						+N'
					) SQ1

				UNPIVOT

					(
						column_data
						FOR
							column_name IN ('+@v_SQL_String_IN_Column_Name+N')
					) UNPV

				GROUP BY
					 UNPV.column_name
					,UNPV.column_data
			 '
		)


	BEGIN TRY

		INSERT INTO #temp_string_search_results

		EXECUTE (@v_SQL_String_Full)

	END TRY
	BEGIN CATCH

	END CATCH


	SELECT TOP (1)
		 @v_Loop_Object_Number = X.schema_object_dense_rank
		,@v_Schema_Name = X.[schema_name]
		,@v_Object_Name = X.[object_name]
	FROM
		#temp_string_search_objects_columns X
	WHERE
		X.schema_object_dense_rank = @v_Loop_Object_Number+1
	ORDER BY
		X.schema_object_dense_rank


	IF @@ROWCOUNT = 0
	BEGIN

		SET @v_Loop_Object_Number = NULL

	END

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SELECT
	 (CASE Y.object_type
		WHEN 'U' THEN 'TABLE'
		WHEN 'V' THEN 'VIEW'
		ELSE 'ERROR'
		END) AS object_type
	,UPPER (Y.data_type) AS data_type
	,Y.max_length AS data_length
	,DB_NAME (DB_ID (SUBSTRING (@v_Database_Name, 2, LEN (@v_Database_Name)-2))) AS database_name
	,Y.[schema_name]
	,Y.[object_name]
	,Y.column_name
	,Z.column_data
	,CONVERT (XML, (CASE Y.data_type
						WHEN N'XML' THEN Z.column_data
						ELSE N''
						END)) AS column_data_xml
	,Z.occurrences
FROM
	#temp_string_search_objects_columns Y
	INNER JOIN #temp_string_search_results Z ON Z.[schema_name] = Y.[schema_name]
		AND Z.[object_name] = Y.[object_name]
		AND Z.column_name = Y.column_name
ORDER BY
	 Y.[schema_name]
	,Y.[object_name]
	,Y.column_name
	,Z.column_data


-----------------------------------------------------------------------------------------------------------------------------
--	Cleanup: Drop Any Remaining Temp Tables
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_string_search_objects_columns', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_string_search_objects_columns

END


IF OBJECT_ID (N'tempdb.dbo.#temp_string_search_results', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_string_search_results

END


Skip_Query:
GO