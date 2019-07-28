/*
    Builds a CREATE TABLE statement to create a temporary table with the required columns
    By: Max Vernon
*/
SET NOCOUNT ON;

USE tempdb;
IF OBJECT_ID(N'dbo.outputTest', N'P') IS NOT NULL
DROP PROCEDURE dbo.outputTest;
GO
CREATE PROCEDURE dbo.outputTest
(
    @column_i int
    , @column_j varchar(30)
    , @column_k char(6) 
)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT v.i
        , v.j
        , v.k
    FROM (VALUES (@column_i, @column_j, @column_k)) v(i, j, k);
END
GO

DECLARE @tempTableName sysname;
DECLARE @cmd nvarchar(max)

SET @tempTableName = N'#someTable';
SET @cmd = N'EXEC dbo.outputTest @column_i = 1, @column_j = NULL, @column_k = NULL;';

DECLARE @createTableStmt nvarchar(max);
DECLARE @maxColumnNameLength int;
DECLARE @maxTypeNameLength int;
SELECT @maxColumnNameLength = MAX(LEN(rs.name))
    , @maxTypeNameLength = MAX(LEN(rs.system_type_name))
FROM sys.dm_exec_describe_first_result_set(@cmd, NULL, NULL) rs;

SET @createTableStmt = STUFF(
    (
        SELECT N', ' + rs.name 
            + N' ' + REPLICATE(N' ', @maxColumnNameLength - LEN(rs.name)) 
            + rs.system_type_name + N' ' + REPLICATE(N' ', @maxTypeNameLength - LEN(rs.system_type_name)) 
            + CASE WHEN rs.collation_name IS NOT NULL AND rs.collation_name <> DATABASEPROPERTYEX(DB_NAME(), 'Collation') 
                THEN N'COLLATE ' + rs.collation_name + N' ' ELSE N'' END
            + CASE WHEN rs.is_nullable = 1 THEN N'NULL' ELSE N'NOT NULL' END
        FROM sys.dm_exec_describe_first_result_set(@cmd, NULL, NULL) rs 
        ORDER BY rs.column_ordinal
        FOR XML PATH('')
    ), 1, 2, N'');
SET @createTableStmt = 'IF OBJECT_ID(N''' + @tempTableName + N''', N''U'') IS NOT NULL
BEGIN
    DROP TABLE ' + @tempTableName + N';
END
CREATE TABLE ' + @tempTableName + N'
(
      ' + REPLACE(@createTableStmt, N', ', NCHAR(13) + NCHAR(10) + N'    , ') + N'
);
';

IF LEN(@createTableStmt) > 4000 
BEGIN
    DECLARE @CurrentLen int;
    SET @CurrentLen = 1;
    WHILE @CurrentLen <= LEN(@createTableStmt)
    BEGIN
        PRINT SUBSTRING(@createTableStmt, @CurrentLen, 4000);
        SET @CurrentLen = @CurrentLen + 4000;
    END
    RAISERROR (N'Output is chunked into 4,000 char pieces - look for errant line endings!', 14, 1);
END
ELSE
BEGIN
    PRINT @createTableStmt;
END;
