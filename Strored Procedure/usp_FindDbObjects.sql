CREATE PROCEDURE [dbo].[usp_FindDbObjects]
 @string NVARCHAR(MAX) = ''
AS
BEGIN
	
	SET NOCOUNT ON
	SET ANSI_WARNINGS OFF
	
	-- Returns list of DB objects containing the string in their definition and/or in their name.
	SELECT [DB_ObjName] = OBJECT_SCHEMA_NAME(sm.[object_id]) + '.' + OBJECT_NAME(sm.[object_id]), so.type_desc [DB_ObjType], 
	 (LEN(sm.[definition]) - LEN(REPLACE(sm.[definition], CHAR(10), ''))) Lines_of_Code
	FROM SYS.SQL_MODULES sm
	 INNER JOIN SYS.OBJECTS so
		ON sm.[OBJECT_ID] = so.[OBJECT_ID]
	WHERE sm.[definition] LIKE N'%' + @string + '%'
	 OR so.[name] like N'%' + @string + '%'
	GROUP BY sm.[object_id], so.type_desc,sm.[definition]
	ORDER BY [DB_ObjName], [DB_ObjType];
	
	SET NOCOUNT OFF
	SET ANSI_WARNINGS ON
	
END