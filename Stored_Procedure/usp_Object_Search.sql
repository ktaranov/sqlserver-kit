SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Procedure Already Exists And Create Shell If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'dbo.usp_Object_Search', N'P') IS NULL
BEGIN

	EXECUTE ('CREATE PROCEDURE dbo.usp_Object_Search AS SELECT 1 AS shell')

END
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Object Search
--	Create Date (MM/DD/YYYY): 04/28/2009
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: Added Schema Name To "object_name" Field
--	           : Added "data_type" And "data_length" Fields
--	           : Bug Fix For Available Database(s) Listing
--	           : Minor Changes To Code Style
--	Date (MM/DD/YYYY): 09/22/2011
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Reformatted Code
--	           : Bug Fixes
--	           : Replaced Deprecated System Tables
--	Date (MM/DD/YYYY): 09/24/2013
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


--	Description: Added Support For Searching A Synonym's Base Object Name
--	           : Added Option To Include System Objects In Search
--	Date (MM/DD/YYYY): 05/23/2015
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.usp_Object_Search

	 @Search_String AS NVARCHAR (4000)
	,@Database_Name AS NVARCHAR (4000)
	,@Search_Against AS SYSNAME = NULL
	,@Object_Type AS SYSNAME = NULL
	,@Exclude_String AS SYSNAME = NULL
	,@Hit_Limit AS SYSNAME = NULL
	,@Creation_Source AS NVARCHAR (1) = N'U'

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


DECLARE
	 @Creation_Filter AS NVARCHAR (30)
	,@Database_Search_Type AS INT
	,@Message AS NVARCHAR (MAX)
	,@Object_Prefix AS NVARCHAR (4)
	,@SQL_Reusable AS VARCHAR (8000)
	,@SQL_Start_Code AS VARCHAR (8000)
	,@SQL_String AS VARCHAR (MAX)
	,@Search_Against_Column_Names AS INT
	,@Search_Against_Object_Definitions AS INT
	,@Search_Against_Object_Names AS INT


DECLARE @Database_Names AS TABLE

	(
		database_name SYSNAME PRIMARY KEY CLUSTERED
	)


SET @Creation_Filter = (CASE @Creation_Source
							WHEN N'S' THEN N'AND O.is_ms_shipped = 1'
							WHEN N'U' THEN N'AND O.is_ms_shipped = 0'
							ELSE N''
							END)


SET @Database_Name = ISNULL (@Database_Name, '')


SET @Database_Search_Type = 0


SET @Exclude_String = ISNULL (REPLACE (REPLACE (REPLACE (REPLACE (@Exclude_String, '[', '[[]'), '%', '[%]'), '_', '[_]'), '''', ''''''), '')


SET @Hit_Limit = NULLIF (@Hit_Limit, '')


SET @Object_Prefix = (CASE
						WHEN @Creation_Source IN (N'B', N'S') THEN N'all_'
						ELSE N''
						END)


SET @Object_Type = ISNULL (REPLACE (REPLACE (@Object_Type, ' ', ''), ',', ''', '''), '')


SET @Search_Against = ISNULL (@Search_Against, '')


SET @Search_Against_Column_Names = (CASE
										WHEN ISNULL (NULLIF (@Search_Against, ''), 'C') LIKE '%C%' THEN 1
										ELSE 0
										END)


SET @Search_Against_Object_Definitions = (CASE
											WHEN ISNULL (NULLIF (@Search_Against, ''), 'D') LIKE '%D%' THEN 1
											ELSE 0
											END)


SET @Search_Against_Object_Names = (CASE
										WHEN ISNULL (NULLIF (@Search_Against, ''), 'N') LIKE '%N%' THEN 1
										ELSE 0
										END)


SET @Search_String = ISNULL (REPLACE (REPLACE (REPLACE (REPLACE (@Search_String, '[', '[[]'), '%', '[%]'), '_', '[_]'), '''', ''''''), '')


SET @SQL_Reusable =

	'
		,O.[type] AS object_type
		,(CASE
			WHEN O.[type] = ''AF'' THEN ''Aggregate Function''
			WHEN O.[type] = ''C'' THEN ''CHECK Constraint''
			WHEN O.[type] = ''D'' THEN ''Default Or DEFAULT Constraint''
			WHEN O.[type] = ''F'' THEN ''FOREIGN KEY Constraint''
			WHEN O.[type] = ''FN'' THEN ''Scalar Function''
			WHEN O.[type] = ''FS'' THEN ''Assembly Scalar Function''
			WHEN O.[type] = ''FT'' THEN ''Assembly Table-Valued Function''
			WHEN O.[type] = ''IF'' THEN ''Inlined Table-Valued Function''
			WHEN O.[type] = ''IT'' THEN ''Internal Table''
			WHEN O.[type] = ''L'' THEN ''Log''
			WHEN O.[type] = ''P'' THEN ''Stored Procedure''
			WHEN O.[type] = ''PC'' THEN ''Assembly Stored Procedure''
			WHEN O.[type] = ''PG'' THEN ''Plan Guide''
			WHEN O.[type] = ''PK'' THEN ''PRIMARY KEY Constraint''
			WHEN O.[type] = ''R'' THEN ''Rule''
			WHEN O.[type] = ''RF'' THEN ''Replication Filter Stored Procedure''
			WHEN O.[type] = ''S'' THEN ''System Table''
			WHEN O.[type] = ''SN'' THEN ''Synonym''
			WHEN O.[type] = ''SO'' THEN ''Sequence''
			WHEN O.[type] = ''SQ'' THEN ''Service Queue''
			WHEN O.[type] = ''TA'' THEN ''Assembly DML Trigger''
			WHEN O.[type] = ''TF'' THEN ''Table-Valued Function''
			WHEN O.[type] = ''TR'' THEN ''Trigger''
			WHEN O.[type] = ''TT'' THEN ''Table Type''
			WHEN O.[type] = ''U'' THEN ''User-Defined Table''
			WHEN O.[type] = ''UQ'' THEN ''UNIQUE Constraint''
			WHEN O.[type] = ''V'' THEN ''View''
			WHEN O.[type] = ''X'' THEN ''Extended Stored Procedure''
			END) AS object_description
		,(CASE
			WHEN O.is_ms_shipped = 1 THEN ''X''
			ELSE ''''
			END) AS is_ms_shipped
		,SCHEMA_NAME (O.[schema_id]) + N''.'' + O.name AS [object_name]
	'


IF @Database_Name = '*'
BEGIN

	SET @Database_Search_Type = 1


	INSERT INTO @Database_Names

		(
			database_name
		)

	SELECT
		DB.name AS database_name
	FROM
		master.sys.databases DB
	WHERE
		DB.[state] = 0


	SET @Database_Name = (SELECT TOP (1) X.database_name FROM @Database_Names X ORDER BY X.database_name)

END
ELSE IF @Database_Name LIKE '%,%' AND @Database_Name NOT LIKE '%,,%' AND @Database_Name NOT LIKE ',%'
BEGIN

	SET @Database_Search_Type = 2


	IF @Database_Name NOT LIKE '%,'
	BEGIN

		SET @Database_Name = @Database_Name + ','

	END


	WHILE @Database_Name <> ''
	BEGIN

		INSERT INTO @Database_Names

			(
				database_name
			)

		SELECT
			RTRIM (LTRIM (LEFT (@Database_Name, CHARINDEX (',', @Database_Name) - 1))) AS database_name


		SET @Database_Name = REPLACE (@Database_Name, LEFT (@Database_Name, CHARINDEX (',', @Database_Name)), '')

	END


	SET @Database_Name =

		(
			SELECT TOP (1)
				X.database_name
			FROM
				@Database_Names X
			WHERE
				NOT EXISTS

					(
						SELECT
							*
						FROM
							master.sys.databases DB
						WHERE
							DB.[state] = 0
							AND DB.name = X.database_name
					)

			ORDER BY
				X.database_name
		)


	IF @Database_Name IS NULL
	BEGIN

		SET @Database_Name = (SELECT TOP (1) X.database_name FROM @Database_Names X ORDER BY X.database_name)

	END

END


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping I: Check For Valid Parameters Being Passed To The Procedure
-----------------------------------------------------------------------------------------------------------------------------

IF @Search_String = ''
BEGIN

	RAISERROR

		(
			 'Search string is NULL or empty.

Usage:

	EXECUTE dbo.usp_Object_Search @Search_String, @Database_Name, @Search_Against, @Object_Type, @Exclude_String, @Hit_Limit, @Creation_Source


Input parameters (pass ''?'' for extended details):

	@Search_String (Mandatory)   : Search value
	@Database_Name (Mandatory)   : Database(s) to search
	@Search_Against (Optional)   : Search Object Name, Column Name, and / or Object Definition
	@Object_Type (Optional)      : Search Object Type(s)
	@Exclude_String (Optional)   : Exclude results which contain "@Exclude_String" value
	@Hit_Limit (Optional)        : Limit the rows returned
	@Creation_Source (Defaulted) : Search objects created by users, SQL Server, or both


Output (certain columns, indicated by an asterisk, will not be returned in the result set if they are not queried / matched against):

	database_name              : Database in which the matched object was found
	object_type                : Object type
	object_description         : Description of the object
	is_ms_shipped              : Indicates if the object was created by SQL Server
	object_name                : Name of the object in which the match was found
	column_name *              : Name of the column in which the match was found (if applicable)
	data_type *                : Data type of the "column_name" field
	data_length *              : Data length of the "data_type" field
	definition *               : Definition details in which the match was found (if applicable)
	search_criteria_matched_on : Type of match (Object, Column, Definition)
	row_count *                : Total rows (when a table object)
	total_space *              : Disk space allocated to the table object
	space_used *               : Space used by the table object (of the space allocated)
	space_data *               : Data space used by the table
	space_index *              : Index space used by the table
	space_unused *             : Unused space by the table object (of the space allocated)'
			,16
			,1
		)


	RETURN

END


IF @Database_Search_Type <> 1
BEGIN

	IF @Database_Name LIKE '%,,%'
	BEGIN

		RAISERROR

			(
				 'ERROR: Database search string contains multiple commas (''%s'').'
				,16
				,1
				,@Database_Name
			)


		RETURN

	END
	ELSE IF @Database_Name LIKE ',%'
	BEGIN

		RAISERROR

			(
				 'ERROR: Database Name string cannot begin with comma(s) (''%s'').'
				,16
				,1
				,@Database_Name
			)


		RETURN

	END
	ELSE IF NOT EXISTS (SELECT * FROM master.sys.databases DB WHERE DB.[state] = 0 AND DB.name = @Database_Name)
	BEGIN

		SELECT
			@Message = COALESCE (@Message + CHAR (13), '') + DB.name
		FROM
			master.sys.databases DB
		WHERE
			DB.[state] = 0
		ORDER BY
			DB.name


		RAISERROR

			(
				 'ERROR: Database ''%s'' not found on server.

Valid Database Names (use either a single value, multiple values separated by commas, or ''*'' for "All"):

%s'
				,16
				,1
				,@Database_Name
				,@Message
			)


		RETURN

	END

END


IF @Search_Against_Column_Names + @Search_Against_Object_Definitions + @Search_Against_Object_Names = 0
BEGIN

	RAISERROR

		(
			 'ERROR: ''%s'' is not a valid search type.

Valid Search Types (use single characters, combinations such as ''CD'', ''NC'', etc., or NULL for "ALL"):

C : Search Column Names
D : Search Object Definitions
N : Search Object Names'
			,16
			,1
			,@Search_Against
		)


	RETURN

END


IF @Object_Type NOT LIKE '%,%' AND @Object_Type NOT IN ('', 'AF', 'C', 'D', 'F', 'FN', 'FS', 'FT', 'IF', 'IT', 'L', 'P', 'PC', 'PG', 'PK', 'R', 'RF', 'S', 'SN', 'SO', 'SQ', 'TA', 'TF', 'TR', 'TT', 'U', 'UQ', 'V', 'X')
BEGIN

	RAISERROR

		(
			 'ERROR: ''%s'' is not a valid Object Type.

Valid Object Types (use either a single value, multiple values separated by commas, or NULL for "All":

AF : Aggregate Function
C  : CHECK Constraint
D  : Default Or DEFAULT Constraint
F  : FOREIGN KEY Constraint
FN : Scalar Function
FS : Assembly Scalar-Function
FT : Assembly Table-Valued Function
IF : Inlined Table-Valued Function
IT : Internal Table
L  : Log
P  : Stored Procedure
PC : Assembly Stored Procedure
PG : Plan Guide
PK : PRIMARY KEY Constraint
R  : Rule
RF : Replication Filter Stored Procedure
S  : System Table
SN : Synonym
SO : Sequence
SQ : Service Queue
TA : Assembly DML Trigger
TF : Table-Valued Function
TR : Trigger
TT : Table Type
U  : User-Defined Table
UQ : UNIQUE Constraint
V  : View
X  : Extended Stored Procedure'
			,16
			,1
			,@Object_Type
		)


	RETURN

END


IF ISNUMERIC (@Hit_Limit) = 0 AND @Hit_Limit IS NOT NULL
BEGIN

	RAISERROR

		(
			 'ERROR: @Hit_Limit value must be of type integer (''%s'').'
			,16
			,1
			,@Hit_Limit
		)


	RETURN

END
ELSE IF @Hit_Limit <= 0
BEGIN

	RAISERROR

		(
			 'ERROR: @Hit_Limit value must be greater than zero (''%s'').'
			,16
			,1
			,@Hit_Limit
		)


	RETURN

END


IF @Creation_Source NOT IN (N'B', N'S', N'U')
BEGIN

	RAISERROR

		(
			 'ERROR: ''%s'' is not a valid creation source.

Valid Creation Sources:

B : Both (User and System created objects)
S : System created objects only
U : User created objects only (Default)'
			,16
			,1
			,@Creation_Source
		)


	RETURN

END


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping II: Check If Temp Table(s) Already Exist(s) And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'tempdb.dbo.#temp_object_search', N'U') IS NOT NULL
BEGIN

	DROP TABLE dbo.#temp_object_search

END


-----------------------------------------------------------------------------------------------------------------------------
--	Soft Temp Table: Create / Modify Results Table
-----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.#temp_object_search

	(
		 database_name NVARCHAR (1000) NOT NULL
		,object_type VARCHAR (10) NOT NULL
		,object_description VARCHAR (500) NULL
		,is_ms_shipped VARCHAR (1) NULL
		,[object_name] NVARCHAR (2000) NULL
		,column_name NVARCHAR (1000) NULL
		,data_type VARCHAR (250) NULL
		,data_length VARCHAR (150) NULL
		,[definition] NVARCHAR (MAX) NULL
		,search_criteria_matched_on VARCHAR (50) NOT NULL
		,row_count VARCHAR (50) NOT NULL
		,total_space VARCHAR (50) NOT NULL
		,space_used VARCHAR (50) NOT NULL
		,space_data VARCHAR (50) NOT NULL
		,space_index VARCHAR (50) NOT NULL
		,space_unused VARCHAR (50) NOT NULL
	)


IF @Search_Against_Column_Names = 0
BEGIN

	ALTER TABLE dbo.#temp_object_search DROP COLUMN column_name
	ALTER TABLE dbo.#temp_object_search DROP COLUMN data_type
	ALTER TABLE dbo.#temp_object_search DROP COLUMN data_length

END


IF @Search_Against_Object_Definitions = 0
BEGIN

	ALTER TABLE dbo.#temp_object_search DROP COLUMN [definition]

END


IF @Search_Against_Object_Names = 0
BEGIN

	ALTER TABLE dbo.#temp_object_search DROP COLUMN row_count
	ALTER TABLE dbo.#temp_object_search DROP COLUMN total_space
	ALTER TABLE dbo.#temp_object_search DROP COLUMN space_used
	ALTER TABLE dbo.#temp_object_search DROP COLUMN space_data
	ALTER TABLE dbo.#temp_object_search DROP COLUMN space_index
	ALTER TABLE dbo.#temp_object_search DROP COLUMN space_unused

END


-----------------------------------------------------------------------------------------------------------------------------
--	Code Build I: Dynamically Construct SQL Code (Object Definitions / Object Names Portion)
-----------------------------------------------------------------------------------------------------------------------------

WHILE @Database_Name IS NOT NULL
BEGIN

	SET @SQL_Start_Code =

		'
			USE [' + @Database_Name + ']


			INSERT INTO dbo.#temp_object_search
		'


	IF @Search_Against_Column_Names = 1 AND @Search_Against_Object_Definitions + @Search_Against_Object_Names = 0
	BEGIN

		SET @SQL_String = ''


		GOTO Query_Column_Only

	END


	SET @SQL_String =

		'
			SELECT
				 ' + '''' + @Database_Name + '''' + ' AS database_name
		'


	SET @SQL_String = @SQL_String + @SQL_Reusable


	IF @Search_Against_Column_Names = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,'''' AS column_name
				,'''' AS data_type
				,'''' AS data_length
			'

	END


	IF @Search_Against_Object_Definitions = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,ISNULL (ISNULL (SQLM.[definition], SYN.base_object_name), '''') AS [definition]
			'

	END


	IF @Search_Against_Object_Definitions + @Search_Against_Object_Names = 2
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,ISNULL ((CASE
							WHEN O.name LIKE ' + '''%' + @Search_String + '%''' + ' THEN ''Object Name''
							END), '''')
				 + ISNULL ((CASE
								WHEN O.name LIKE ' + '''%' + @Search_String + '%''' + ' AND ISNULL (SQLM.[definition], SYN.base_object_name) LIKE ' + '''%' + @Search_String + '%''' + ' THEN '' / ''
								END), '''')
				 + ISNULL ((CASE
								WHEN ISNULL (SQLM.[definition], SYN.base_object_name) LIKE ' + '''%' + @Search_String + '%''' + ' THEN ''Definition''
								END), '''') AS search_criteria_matched_on
			'

	END
	ELSE BEGIN

		IF @Search_Against_Object_Definitions = 1
		BEGIN

			SET @SQL_String = @SQL_String +

				'
					,''Definition'' AS search_criteria_matched_on
				'

		END
		ELSE BEGIN

			IF @Search_Against_Object_Names = 1
			BEGIN

				SET @SQL_String = @SQL_String +

					'
						,''Object Name'' AS search_criteria_matched_on
					'

			END

		END

	END


	IF @Search_Against_Object_Names = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,ISNULL (CONVERT (VARCHAR (50), sqDDPS.row_count), '''') AS row_count
				,ISNULL (CONVERT (VARCHAR (50), CONVERT (DECIMAL (18,2), sqDDPS.reserved_pages)) + '' MB'', '''') AS total_space
				,ISNULL (CONVERT (VARCHAR (50), CONVERT (DECIMAL (18,2), sqDDPS.data_pages + ISNULL ((CASE
																										WHEN sqDDPS.used_pages > sqDDPS.data_pages THEN (sqDDPS.used_pages - sqDDPS.data_pages)
																										END), 0))) + '' MB'', '''') AS space_used
				,ISNULL (CONVERT (VARCHAR (50), CONVERT (DECIMAL (18,2), sqDDPS.data_pages)) + '' MB'', '''') AS space_data
				,ISNULL (CONVERT (VARCHAR (50), CONVERT (DECIMAL (18,2), (CASE
																			WHEN sqDDPS.used_pages > sqDDPS.data_pages THEN (sqDDPS.used_pages - sqDDPS.data_pages)
																			WHEN sqDDPS.[object_id] IS NOT NULL THEN 0
																			END))) + '' MB'', '''') AS space_index
				,ISNULL (CONVERT (VARCHAR (50), CONVERT (DECIMAL (18,2), (CASE
																			WHEN sqDDPS.reserved_pages > sqDDPS.used_pages THEN (sqDDPS.reserved_pages - sqDDPS.used_pages)
																			WHEN sqDDPS.[object_id] IS NOT NULL THEN 0
																			END))) + '' MB'', '''') AS space_unused
			'

	END


	SET @SQL_String = @SQL_String +

		'
			FROM
				sys.' + @Object_Prefix + 'objects O
		'


	IF @Search_Against_Object_Definitions = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				LEFT JOIN sys.' + @Object_Prefix + 'sql_modules SQLM ON SQLM.[object_id] = O.[object_id]
				LEFT JOIN sys.synonyms SYN ON SYN.[object_id] = O.[object_id]
			'

	END


	IF @Search_Against_Object_Names = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				LEFT JOIN

					(
						SELECT
							 DDPS.[object_id]
							,ISNULL (SUM (CASE
											WHEN (DDPS.index_id < 2) THEN DDPS.row_count
											END), 0) AS row_count
							,SUM (DDPS.reserved_page_count * 0.0078125) AS reserved_pages
							,SUM (DDPS.used_page_count * 0.0078125) AS used_pages
							,SUM (CASE
									WHEN (DDPS.index_id < 2) THEN (DDPS.in_row_data_page_count + DDPS.lob_used_page_count + DDPS.row_overflow_used_page_count) * 0.0078125
									ELSE (DDPS.lob_used_page_count + DDPS.row_overflow_used_page_count) * 0.0078125
									END) AS data_pages
						FROM
							sys.dm_db_partition_stats DDPS
						GROUP BY
							DDPS.[object_id]
					) sqDDPS ON sqDDPS.[object_id] = O.[object_id]
			'

	END


	IF @Search_Against_Object_Definitions + @Search_Against_Object_Names = 2
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				WHERE
					(
						ISNULL (SQLM.[definition], SYN.base_object_name) LIKE ' + '''%' + @Search_String + '%''' + '
						OR O.name LIKE ' + '''%' + @Search_String + '%''' + '
					)
			'

	END
	ELSE BEGIN

		IF @Search_Against_Object_Definitions = 1
		BEGIN

			SET @SQL_String = @SQL_String +

				'
					WHERE
						ISNULL (SQLM.[definition], SYN.base_object_name) LIKE ' + '''%' + @Search_String + '%''' + '
				'

		END
		ELSE BEGIN

			IF @Search_Against_Object_Names = 1
			BEGIN

				SET @SQL_String = @SQL_String +

					'
						WHERE
							O.name LIKE ' + '''%' + @Search_String + '%''' + '
					'

			END

		END

	END


	SET @SQL_String = @SQL_String + @Creation_Filter


	IF @Object_Type <> ''
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				AND O.[type] IN (''' + @Object_Type + ''')
			'

	END


	IF @Exclude_String <> ''
	BEGIN

		IF @Search_Against_Object_Definitions = 1
		BEGIN

			SET @SQL_String = @SQL_String +

				'
					AND ISNULL (ISNULL (SQLM.[definition], SYN.base_object_name), '''') NOT LIKE ' + '''%' + @Exclude_String + '%''' + '
				'

		END


		IF @Search_Against_Object_Names = 1
		BEGIN

			SET @SQL_String = @SQL_String +

				'
					AND O.name NOT LIKE ' + '''%' + @Exclude_String + '%''' + '
				'

		END

	END


	IF @Search_Against_Column_Names = 0
	BEGIN

		GOTO Definition_Name_Only

	END


	SET @SQL_String = @SQL_String +

		'
			UNION ALL
		'


-----------------------------------------------------------------------------------------------------------------------------
--	Code Build II: Dynamically Construct SQL Code (Column Names Portion)
-----------------------------------------------------------------------------------------------------------------------------

	Query_Column_Only:


	SET @SQL_String = @SQL_String +

		'
			SELECT
				 ' + '''' + @Database_Name + '''' + ' AS database_name
		'


	SET @SQL_String = @SQL_String + @SQL_Reusable


	SET @SQL_String = @SQL_String +

		'
			,C.name AS column_name
			,LOWER (TYPE_NAME (C.user_type_id) + ISNULL ((N'': [ '' + (CASE
																			WHEN C.system_type_id <> C.user_type_id THEN TYPE_NAME (C.system_type_id)
																			END) + N'' ]''), N'''')) AS data_type
			,(CASE
				WHEN LOWER (TYPE_NAME (C.system_type_id)) IN (N''nchar'', N''ntext'', N''nvarchar'') THEN CONVERT (VARCHAR (6), C.max_length / 2)
				WHEN LOWER (TYPE_NAME (C.system_type_id)) NOT IN (N''bigint'', N''bit'', N''date'', N''datetime'', N''datetime2'', N''datetimeoffset'', N''decimal'', N''float'', N''int'', N''money'', N''numeric'', N''real'', N''smalldatetime'', N''smallint'', N''smallmoney'', N''time'', N''tinyint'') THEN CONVERT (VARCHAR (6), C.max_length)
				ELSE CONVERT (VARCHAR (6), C.max_length) + '' ('' + CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, ''Precision'')) + '','' + ISNULL (CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, ''Scale'')), 0) + '')''
				END) AS data_length
		'


	IF @Search_Against_Object_Definitions = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,'''' AS [definition]
			'

	END


	SET @SQL_String = @SQL_String +

		'
			,''Column Name'' AS search_criteria_matched_on
		'


	IF @Search_Against_Object_Names = 1
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				,'''' AS row_count
				,'''' AS total_space
				,'''' AS space_used
				,'''' AS space_data
				,'''' AS space_index
				,'''' AS space_unused
			'

	END


	SET @SQL_String = @SQL_String +

		'
			FROM
				sys.' + @Object_Prefix + 'objects O
				INNER JOIN sys.' + @Object_Prefix + 'columns C ON C.[object_id] = O.[object_id]
				INNER JOIN sys.types T ON T.user_type_id = C.user_type_id
			WHERE
				C.name LIKE ' + '''%' + @Search_String + '%''' + '
		'

		+ @Creation_Filter


	IF @Object_Type <> ''
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				AND O.[type] IN (''' + @Object_Type + ''')
			'

	END


	IF @Exclude_String <> ''
	BEGIN

		SET @SQL_String = @SQL_String +

			'
				AND C.name NOT LIKE ' + '''%' + @Exclude_String + '%''' + '
			'

	END


	Definition_Name_Only:


	EXECUTE (@SQL_Start_Code + @SQL_String)


	IF @Database_Search_Type = 0
	BEGIN

		SET @Database_Name = NULL

	END
	ELSE BEGIN

		SET @Database_Name = (SELECT TOP (1) X.database_name FROM @Database_Names X WHERE X.database_name > @Database_Name ORDER BY X.database_name)

	END

END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SET @SQL_String =

	'
		SELECT' + (CASE WHEN @Hit_Limit > 0 THEN ' TOP (' + CONVERT (VARCHAR (10), @Hit_Limit) + ')' ELSE '' END) + '
			UT.*
		FROM
			dbo.#temp_object_search UT
		ORDER BY
			 UT.database_name
			,UT.is_ms_shipped
			,UT.object_type
			,UT.[object_name]
			,UT.search_criteria_matched_on
	'


IF @Search_Against_Column_Names = 1
BEGIN

	IF (SELECT COUNT (DISTINCT X.column_name) FROM dbo.#temp_object_search X) <= 1
	BEGIN

		IF (SELECT TOP (1) Y.column_name FROM dbo.#temp_object_search Y) = ''
		BEGIN

			ALTER TABLE dbo.#temp_object_search DROP COLUMN column_name
			ALTER TABLE dbo.#temp_object_search DROP COLUMN data_type
			ALTER TABLE dbo.#temp_object_search DROP COLUMN data_length

		END

	END
	ELSE BEGIN

		SET @SQL_String = @SQL_String +

			'
				,UT.column_name
				,UT.data_type
				,UT.data_length
			'

	END

END


IF @Search_Against_Object_Definitions = 1
BEGIN

	IF (SELECT COUNT (DISTINCT X.[definition]) FROM dbo.#temp_object_search X) <= 1
	BEGIN

		IF (SELECT TOP (1) Y.[definition] FROM dbo.#temp_object_search Y) = ''
		BEGIN

			ALTER TABLE dbo.#temp_object_search DROP COLUMN [definition]

		END

	END

END


IF @Search_Against_Object_Names = 1
BEGIN

	IF (SELECT COUNT (DISTINCT X.row_count) FROM dbo.#temp_object_search X) <= 1
	BEGIN

		IF (SELECT TOP (1) Y.row_count FROM dbo.#temp_object_search Y) = ''
		BEGIN

			ALTER TABLE dbo.#temp_object_search DROP COLUMN row_count
			ALTER TABLE dbo.#temp_object_search DROP COLUMN total_space
			ALTER TABLE dbo.#temp_object_search DROP COLUMN space_used
			ALTER TABLE dbo.#temp_object_search DROP COLUMN space_data
			ALTER TABLE dbo.#temp_object_search DROP COLUMN space_index
			ALTER TABLE dbo.#temp_object_search DROP COLUMN space_unused

		END

	END

END


EXECUTE (@SQL_String)
GO