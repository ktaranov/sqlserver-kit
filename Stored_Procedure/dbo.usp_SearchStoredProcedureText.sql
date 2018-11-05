SET NOEXEC OFF;

IF OBJECT_ID('dbo.sp_foreachdb', 'P') IS NULL
RAISERROR('Please install before awesome stored procedure https://github.com/ktaranov/SQL-Server-First-Responder-Kit/blob/master/sp_foreachdb.sql', 16, 1);
SET NOEXEC ON;
GO


IF OBJECT_ID('dbo.usp_SearchStoredProcedureText', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.usp_SearchStoredProcedureText AS RETURN');
GO


ALTER PROCEDURE dbo.usp_SearchStoredProcedureText(
    @searchforthis NVARCHAR(512)
  , @object_type VARCHAR(2) = NULL
  , @is_ms_shipped BIT = 0
)
AS
/*
.DESCRIPTION
Search text in stored procedures

.EXAMPLE
EXEC dbo.usp_SearchStoredProcedureText @searchforthis = 'sp_foreachdb';

.NOTE
    Author: Tim Ford
    Original link: https://www.itprotoday.com/microsoft-sql-server/using-sqlmodules-system-catalog-view-search-function-and-stored-procedure


*/
SET NOCOUNT ON;

DECLARE @search_text NVARCHAR(MAX);

CREATE TABLE #search_results
    (
    the__database sysname NOT NULL,
    the__schema sysname NOT NULL,
    object__name sysname NOT NULL,
    object__type NVARCHAR(120) NOT NULL,
    is_ms_shipped BIT NOT NULL,
    sql__text NVARCHAR(MAX) NOT NULL
    );

IF @object_type IS NULL
    BEGIN
        SELECT @search_text =
        'USE ?; 
        INSERT INTO #search_results (the__database, the__schema, object__name, object__type, is_ms_shipped, sql__text)
        SELECT db_name() AS the__database
                , OBJECT_SCHEMA_NAME(O.object_id) AS the__schema
                , O.name AS object__name 
                , O.type_desc AS object__type
                , O.is_ms_shipped
                , M.definition AS sql__text
        FROM sys.objects O WITH(NOLOCK)
                LEFT JOIN sys.sql_modules M ON O.object_id = M.object_id
        WHERE O.is_ms_shipped = ' + CAST(@is_ms_shipped AS VARCHAR(1)) + ' AND M.definition LIKE ''%' + @searchforthis + '%''' + ';';
    END;
ELSE
    BEGIN
        SELECT @search_text =
        'USE ?; 
        INSERT INTO #search_results (the__database, the__schema, object__name, object__type, is_ms_shipped, sql__text) 
        SELECT db_name() AS the__database
                , OBJECT_SCHEMA_NAME(O.object_id) AS the__schema
                , O.name AS object__name 
                , O.type_desc AS object__type
                , O.is_ms_shipped
                , M.definition AS sql__text
        FROM sys.objects O WITH(NOLOCK)
            LEFT JOIN sys.sql_modules M ON O.object_id = M.object_id
        WHERE O.is_ms_shipped = ' + CAST(@is_ms_shipped AS VARCHAR(1)) + ' AND O.type = ''' + @object_type + '''' +
            'AND M.definition LIKE ''%' + @searchforthis + '%''' + ';';
    END;

EXEC dbo.sp_foreachdb @command = @search_text;

SELECT the__database
     , the__schema
     , object__name
     , object__type
     , is_ms_shipped
     , sql__text
FROM #search_results
ORDER BY the__database
    , the__schema
    , object__name;
GO
