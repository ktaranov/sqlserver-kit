SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON


-----------------------------------------------------------------------------------------------------------------------------
--	Error Trapping: Check If Procedure Already Exists And Drop If Applicable
-----------------------------------------------------------------------------------------------------------------------------

IF OBJECT_ID (N'dbo.usp_UnusedInputParameters', N'P') IS NOT NULL
BEGIN

	DROP PROCEDURE dbo.usp_UnusedInputParameters

END
GO


-----------------------------------------------------------------------------------------------------------------------------
--	Stored Procedure Details: Listing Of Standard Details Related To The Stored Procedure
-----------------------------------------------------------------------------------------------------------------------------

--	Purpose: Identify All Objects Containing Unused Input Parameters
--	Create Date (MM/DD/YYYY): 11/25/2012
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

CREATE PROCEDURE dbo.usp_UnusedInputParameters

	@v_Database AS SYSNAME

AS

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON
SET ANSI_WARNINGS OFF
SET ARITHABORT OFF
SET ARITHIGNORE ON
SET TEXTSIZE 2147483647


EXECUTE

	(
		N'
			USE [' + @v_Database + N']


			SELECT
				 SCHEMA_NAME (O.[schema_id]) AS [schema_name]
				,O.name AS [object_name]
				,P.name AS parameter_name
				,O.[type] AS object_type
				,TYPE_NAME (P.user_type_id) AS data_type
				,(CASE P.is_output
					WHEN 1 THEN ''Yes''
					ELSE ''No''
					END) AS is_output
				,SQLM.[definition]
			FROM
				sys.parameters P
				INNER JOIN sys.objects O ON O.[object_id] = P.[object_id]
					AND O.is_ms_shipped = 0
				INNER JOIN sys.sql_modules SQLM ON SQLM.[object_id] = P.[object_id]
				LEFT JOIN

					(
						SELECT
							 XP.[object_id]
							,XP.parameter_id
							,XP.name + NCHAR (13) AS parameter_name_modified
							,REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (REPLACE (
								XSQLM.[definition] + NCHAR (13)
									, XP.name + N''	'', XP.name + NCHAR (13))
									, XP.name + N'' '', XP.name + NCHAR (13))
									, XP.name + N''!'', XP.name + NCHAR (13))
									, XP.name + N''"'', XP.name + NCHAR (13))
									, XP.name + N''%'', XP.name + NCHAR (13))
									, XP.name + N''&'', XP.name + NCHAR (13))
									, XP.name + N'''''''', XP.name + NCHAR (13))
									, XP.name + N''('', XP.name + NCHAR (13))
									, XP.name + N'')'', XP.name + NCHAR (13))
									, XP.name + N''*'', XP.name + NCHAR (13))
									, XP.name + N''+'', XP.name + NCHAR (13))
									, XP.name + N'','', XP.name + NCHAR (13))
									, XP.name + N''-'', XP.name + NCHAR (13))
									, XP.name + N''.'', XP.name + NCHAR (13))
									, XP.name + N''/'', XP.name + NCHAR (13))
									, XP.name + N'';'', XP.name + NCHAR (13))
									, XP.name + N''<'', XP.name + NCHAR (13))
									, XP.name + N''='', XP.name + NCHAR (13))
									, XP.name + N''>'', XP.name + NCHAR (13))
									, XP.name + N''['', XP.name + NCHAR (13))
									, XP.name + N'']'', XP.name + NCHAR (13))
							 AS definition_modified
						FROM
							sys.parameters XP
							INNER JOIN sys.sql_modules XSQLM ON XSQLM.[object_id] = XP.[object_id]
						WHERE
							EXISTS

								(
									SELECT
										*
									FROM
										sys.parameters YP
									WHERE
										YP.[object_id] = XP.[object_id]
										AND YP.parameter_id <> XP.parameter_id
										AND LEFT (YP.name, LEN (XP.name)) = XP.name
								)

					) FN ON FN.[object_id] = P.[object_id] AND FN.parameter_id = P.parameter_id

				CROSS APPLY

					(
						SELECT
							 ISNULL (FN.parameter_name_modified, P.name) AS parameter_name_compare
							,ISNULL (FN.definition_modified, SQLM.[definition]) AS definition_compare
					) CV

			WHERE
				P.parameter_id <> 0
				AND CHARINDEX (CV.parameter_name_compare, CV.definition_compare, CHARINDEX (CV.parameter_name_compare, CV.definition_compare) + 1) = 0
			ORDER BY
				 SCHEMA_NAME (O.[schema_id])
				,O.name
				,P.name
		 '
	)
GO