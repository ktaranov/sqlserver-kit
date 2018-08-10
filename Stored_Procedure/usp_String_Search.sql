IF OBJECT_ID (N'dbo.usp_String_Search', N'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.usp_String_Search AS SELECT 1 AS shell')
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Search For A String Value Within Columns Of Data Types CHAR, NCHAR, NTEXT, NVARCHAR, TEXT, VARCHAR, XML
--	Create Date (MM/DD/YYYY): 03/20/2012
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Modification History: Listing Of All Modifications Since Original Implementation
-----------------------------------------------------------------------------------------------------------------------------

--	Description: Added "is_ms_shipped" Field
--	           : Added Option To Include System Objects In Search
--	Date (MM/DD/YYYY): 12/06/2015
--	Developer: Sean Smith (s.smith.sql AT gmail DOT com)
--	Additional Notes: N/A


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Create Procedure
-----------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE dbo.usp_String_Search(
     @Search_String AS NVARCHAR (500)
    ,@Database_Name AS NVARCHAR (300)
    ,@Object_Types AS NVARCHAR (10) = NULL
    ,@Data_Types AS NVARCHAR (100) = NULL
    ,@Table_Max_Rows AS BIGINT = NULL
    ,@Column_Max_Length AS SMALLINT = NULL
    ,@Creation_Source AS NVARCHAR (1) = N'U'
)
AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;
SET ARITHABORT OFF;
SET ARITHIGNORE ON;
SET TEXTSIZE 2147483647;

DECLARE
     @Creation_Filter AS NVARCHAR (30)
    ,@Loop_Column_Number AS BIGINT
    ,@Loop_Column_Number_First AS BIGINT
    ,@Loop_Object_Number AS BIGINT
    ,@Object_Name AS SYSNAME
    ,@Object_Prefix AS NVARCHAR (4)
    ,@Schema_Name AS SYSNAME
    ,@SQL_String_Full AS NVARCHAR (MAX)
    ,@SQL_String_IN_Column_Name AS NVARCHAR (MAX)
    ,@SQL_String_SELECT AS NVARCHAR (MAX)
    ,@SQL_String_WHERE AS NVARCHAR (MAX);

SET @Creation_Filter = (CASE @Creation_Source
                            WHEN N'S' THEN N'AND O.is_ms_shipped = 1'
                            WHEN N'U' THEN N'AND O.is_ms_shipped = 0'
                            ELSE N''
                            END);

SET @Object_Prefix = (CASE
                        WHEN @Creation_Source IN (N'B', N'S') THEN N'all_'
                        ELSE N''
                        END);

SET @Object_Types = N'''' + REPLACE (REPLACE (NULLIF (@Object_Types, N''), N' ', N''), N',', N''',''') + N''''
SET @Data_Types = N'''' + REPLACE (REPLACE (NULLIF (@Data_Types, N''), N' ', N''), N',', N''',''') + N''''

-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping I: Validate "@Creation_Source", "@Database_Name", And "@Search_String" Input Parameter Values
-----------------------------------------------------------------------------------------------------------------------------

IF @Creation_Source NOT IN (N'B', N'S', N'U')
BEGIN

    RAISERROR(
             'ERROR: ''%s'' is not a valid creation source.

Valid Creation Sources:

B : Both (User and System created objects)
S : System created objects only
U : User created objects only'
            ,16
            ,1
            ,@Creation_Source
        );
    RETURN
END


IF EXISTS (SELECT * FROM master.sys.databases DB WHERE DB.name = @Database_Name)
BEGIN

    SET @Database_Name = QUOTENAME (@Database_Name)

END
ELSE IF EXISTS (SELECT * FROM master.sys.databases DB WHERE QUOTENAME (DB.name) = @Database_Name + N']')
BEGIN

    SET @Database_Name = @Database_Name + N']'

END
ELSE IF NOT EXISTS (SELECT * FROM master.sys.databases DB WHERE QUOTENAME (DB.name) = @Database_Name)
BEGIN

    RAISERROR

        (
             N'ERROR: Database (''%s'') does not exist. Make sure that the name is entered correctly.'
            ,16
            ,1
            ,@Database_Name
        );
    RETURN
END


IF NULLIF (@Search_String, N'') IS NOT NULL
BEGIN
    SET @Search_String = REPLACE (REPLACE (REPLACE (REPLACE (@Search_String, N'[', N'[[]'), N'%', N'[%]'), N'_', N'[_]'), N'''', N'''''')
END
ELSE BEGIN

    RAISERROR
        (
             N'ERROR: @Search_String input parameter cannot be blank or NULL.'
            ,16
            ,1
        );
    RETURN;
END;

-----------------------------------------------------------------------------------------------------------------------------
--	Table Creation: Create Temp Tables To Temporarily Store Searchable Objects / Columns And Output Results
-----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE dbo.#temp_string_search_objects_columns

    (
         object_type VARCHAR (2) NOT NULL
        ,is_ms_shipped BIT NOT NULL
        ,data_type SYSNAME NOT NULL
        ,data_length SMALLINT NOT NULL
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
    );

CREATE TABLE dbo.#temp_string_search_results

    (
         [schema_name] SYSNAME NOT NULL
        ,[object_name] SYSNAME NOT NULL
        ,column_name SYSNAME NOT NULL
        ,column_data NVARCHAR (MAX) NOT NULL
        ,occurrences INT NOT NULL
    );

-----------------------------------------------------------------------------------------------------------------------------
--	Table Update I: Insert Searchable Objects / Columns Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------
 SET @SQL_String_Full =
     N'
        SELECT
             O.[type] AS object_type
            ,O.is_ms_shipped
            ,LOWER (TYPE_NAME (C.user_type_id) + ISNULL ((N'': [ '' + (CASE
                                                                            WHEN C.system_type_id <> C.user_type_id THEN TYPE_NAME (C.system_type_id)
                                                                            END) + N'' ]''), N'''')) AS data_type
            ,(CASE
                WHEN LOWER (TYPE_NAME (C.system_type_id)) IN (N''nchar'', N''ntext'', N''nvarchar'') THEN CONVERT (VARCHAR (6), C.max_length / 2)
                WHEN LOWER (TYPE_NAME (C.system_type_id)) NOT IN (N''bigint'', N''bit'', N''date'', N''datetime'', N''datetime2'', N''datetimeoffset'', N''decimal'', N''float'', N''int'', N''money'', N''numeric'', N''real'', N''smalldatetime'', N''smallint'', N''smallmoney'', N''time'', N''tinyint'') THEN CONVERT (VARCHAR (6), C.max_length)
                ELSE CONVERT (VARCHAR (6), C.max_length) + '' ('' + CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, ''Precision'')) + '','' + ISNULL (CONVERT (VARCHAR (11), COLUMNPROPERTY (C.[object_id], C.name, ''Scale'')), 0) + '')''
                END) AS data_length
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
            ' + @Database_Name + N'.sys.schemas S
            INNER JOIN ' + @Database_Name + N'.sys.' + @Object_Prefix + N'objects O ON O.[schema_id] = S.[schema_id]
                AND O.[type] IN (' + (CASE
                                        WHEN @Object_Types IS NOT NULL THEN @Object_Types
                                        ELSE N'''U'', ''V'''
                                        END) + N')
     '
      + @Creation_Filter +
    N'
            INNER JOIN ' + @Database_Name + N'.sys.' + @Object_Prefix + N'columns C ON C.[object_id] = O.[object_id]
     '

IF @Column_Max_Length > 0
BEGIN
    SET @SQL_String_Full = @SQL_String_Full +
        N'
            ' + NCHAR (9) + N'AND C.system_type_id IN (167, 175, 231, 239)
            ' + NCHAR (9) + N'AND (CASE
                                        WHEN TYPE_NAME (C.system_type_id) IN (N''nchar'', N''ntext'', N''nvarchar'') THEN C.max_length / 2
                                        ELSE C.max_length
                                        END) BETWEEN 1 AND ' + CONVERT (NVARCHAR (6), @Column_Max_Length) + N'
         ';
END
ELSE BEGIN
    SET @SQL_String_Full = @SQL_String_Full +
        N'
            ' + NCHAR (9) + N'AND C.system_type_id IN (35, 99, 167, 175, 231, 239, 241)
         ';
END

SET @SQL_String_Full = @SQL_String_Full +
    N'
            INNER JOIN ' + @Database_Name + N'.sys.types T ON T.system_type_id = C.system_type_id
                AND T.user_type_id = C.user_type_id
     ' + (CASE
            WHEN @Data_Types IS NOT NULL THEN REPLICATE (NCHAR (9), 3) + N'AND T.name IN (' + @Data_Types + N')'
            ELSE N''
            END)

IF @Table_Max_Rows > 0
BEGIN
    SET @SQL_String_Full = @SQL_String_Full +
        N'
            INNER JOIN
                 (
                    SELECT
                        DDPS.[object_id]
                    FROM
                        ' + @Database_Name + N'.sys.dm_db_partition_stats DDPS
                    WHERE
                        DDPS.index_id < 2
                    GROUP BY
                        DDPS.[object_id]
                    HAVING
                        SUM (DDPS.row_count) <= ' + CONVERT (NVARCHAR (20), @Table_Max_Rows) + N'
                ) sqTMR ON sqTMR.[object_id] = O.[object_id]
         '
END


INSERT INTO dbo.#temp_string_search_objects_columns(
         object_type
        ,is_ms_shipped
        ,data_type
        ,data_length
        ,[schema_name]
        ,[object_name]
        ,column_name
        ,schema_object_dense_rank
        ,column_row_number
    )
EXECUTE (@SQL_String_Full);


-----------------------------------------------------------------------------------------------------------------------------
--	Table Update II: Insert Matched Results Into Temp Table
-----------------------------------------------------------------------------------------------------------------------------
SELECT TOP (1)
     @Loop_Object_Number = X.schema_object_dense_rank
    ,@Schema_Name = X.[schema_name]
    ,@Object_Name = X.[object_name]
FROM
    dbo.#temp_string_search_objects_columns X
ORDER BY
    X.schema_object_dense_rank;

WHILE @Loop_Object_Number IS NOT NULL
BEGIN

    SET @SQL_String_SELECT = N'';
    SET @SQL_String_IN_Column_Name = N'';
    SET @SQL_String_WHERE = N'';
    SET @Loop_Column_Number = (SELECT MIN (X.column_row_number) FROM dbo.#temp_string_search_objects_columns X WHERE X.schema_object_dense_rank = @Loop_Object_Number);
    SET @Loop_Column_Number_First = @Loop_Column_Number;
    WHILE @Loop_Column_Number IS NOT NULL
    BEGIN
        SELECT
             @SQL_String_SELECT = @SQL_String_SELECT + (CASE
                                                            WHEN @Loop_Column_Number = @Loop_Column_Number_First THEN N'SELECT' + NCHAR (13) + REPLICATE (NCHAR (9), 7) + N' '
                                                            ELSE NCHAR (13) + REPLICATE (NCHAR (9), 7) + N','
                                                            END) + N'CONVERT (NVARCHAR (MAX), (CASE
                                                                                                    WHEN ' + (CASE
                                                                                                                WHEN X.data_type = N'XML' THEN N'CONVERT (NVARCHAR (MAX), '
                                                                                                                ELSE N''
                                                                                                                END) + QUOTENAME (X.column_name) + (CASE
                                                                                                                                                        WHEN X.data_type = N'XML' THEN N')'
                                                                                                                                                        ELSE N''
                                                                                                                                                        END) + N' LIKE ''%' + @Search_String + N'%'' THEN ' + QUOTENAME (X.column_name) + N'
                                                                                                    ELSE NULL
                                                                                                    END)) AS ' + QUOTENAME (X.column_name)
            ,@SQL_String_IN_Column_Name = @SQL_String_IN_Column_Name + (CASE
                                                                            WHEN @Loop_Column_Number = @Loop_Column_Number_First THEN N''
                                                                            ELSE N', '
                                                                            END) + QUOTENAME (X.column_name)
            ,@SQL_String_WHERE = @SQL_String_WHERE + (CASE
                                                        WHEN @Loop_Column_Number = @Loop_Column_Number_First THEN NCHAR (13) + REPLICATE (NCHAR (9), 6) + N'WHERE' + NCHAR (13) + REPLICATE (NCHAR (9), 7)
                                                        ELSE NCHAR (13) + REPLICATE (NCHAR (9), 7) + N'OR '
                                                        END) + (CASE
                                                                    WHEN X.data_type = N'XML' THEN N'CONVERT (NVARCHAR (MAX), '
                                                                    ELSE N''
                                                                    END) + QUOTENAME (X.column_name) + (CASE
                                                                                                            WHEN X.data_type = N'XML' THEN N')'
                                                                                                            ELSE N''
                                                                                                            END) + N' LIKE ''%' + @Search_String + N'%'''
        FROM
            dbo.#temp_string_search_objects_columns X
        WHERE
            X.schema_object_dense_rank = @Loop_Object_Number
            AND X.column_row_number = @Loop_Column_Number;


        SET @Loop_Column_Number = (SELECT MIN (X.column_row_number) FROM dbo.#temp_string_search_objects_columns X WHERE X.schema_object_dense_rank = @Loop_Object_Number AND X.column_row_number > @Loop_Column_Number)

    END


    SET @SQL_String_Full =

        (
            N'
                SELECT
                     ''' + @Schema_Name + N''' AS [schema_name]
                    ,''' + @Object_Name + N''' AS [object_name]
                    ,UNPV.column_name
                    ,UNPV.column_data
                    ,COUNT (*) AS occurrences
                FROM

                    (
                        '
                            + @SQL_String_SELECT
                            + NCHAR (13) + REPLICATE (NCHAR (9), 6) + N'FROM' + NCHAR (13)
                            + REPLICATE (NCHAR (9), 7) + @Database_Name
                            + N'.'
                            + QUOTENAME (@Schema_Name)
                            + N'.'
                            + QUOTENAME (@Object_Name)
                            + @SQL_String_WHERE
                        + N'
                    ) sqMAT

                UNPIVOT

                    (
                        column_data FOR column_name IN

                            (
                                ' + @SQL_String_IN_Column_Name + N'
                            )

                    ) UNPV

                GROUP BY
                     UNPV.column_name
                    ,UNPV.column_data
             '
        )


    BEGIN TRY

        INSERT INTO dbo.#temp_string_search_results

            (
                 [schema_name]
                ,[object_name]
                ,column_name
                ,column_data
                ,occurrences
            )

        EXECUTE (@SQL_String_Full)

    END TRY
    BEGIN CATCH

    END CATCH


    SELECT TOP (1)
         @Loop_Object_Number = X.schema_object_dense_rank
        ,@Schema_Name = X.[schema_name]
        ,@Object_Name = X.[object_name]
    FROM
        dbo.#temp_string_search_objects_columns X
    WHERE
        X.schema_object_dense_rank = @Loop_Object_Number + 1
    ORDER BY
        X.schema_object_dense_rank
 
    IF @@ROWCOUNT = 0
    BEGIN
        SET @Loop_Object_Number = NULL
    END
END


-----------------------------------------------------------------------------------------------------------------------------
--	Main Query: Final Display / Output
-----------------------------------------------------------------------------------------------------------------------------

SELECT
     (CASE Y.object_type
        WHEN 'U' THEN 'Table'
        WHEN 'V' THEN 'View'
        ELSE 'ERROR'
        END) AS object_type
    ,(CASE
        WHEN Y.is_ms_shipped = 1 THEN 'Yes'
        ELSE 'No'
        END) AS is_ms_shipped
    ,Y.data_type
    ,Y.data_length
    ,DB_NAME (DB_ID (SUBSTRING (@Database_Name, 2, LEN (@Database_Name) - 2))) AS database_name
    ,Y.[schema_name]
    ,Y.[object_name]
    ,Y.column_name
    ,Z.column_data
    ,CONVERT (XML, (CASE
                        WHEN Y.data_type = N'XML' THEN Z.column_data
                        ELSE N''
                        END)) AS column_data_xml
    ,Z.occurrences
FROM
    dbo.#temp_string_search_objects_columns Y
    INNER JOIN dbo.#temp_string_search_results Z ON Z.[schema_name] = Y.[schema_name]
        AND Z.[object_name] = Y.[object_name]
        AND Z.column_name = Y.column_name
ORDER BY
     Y.object_type
    ,Y.is_ms_shipped
    ,Y.[schema_name]
    ,Y.[object_name]
    ,Y.column_name
    ,Z.column_data;
GO
