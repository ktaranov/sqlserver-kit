/*
Original link: http://stevestedman.com/2015/09/dbcc-checkdb-all-databases/
Author: Steve Stedman
*/

IF OBJECT_ID('dbo.usp_checkAllDatabases') IS NULL
    EXEC sp_executesql N'CREATE PROCEDURE dbo.usp_checkAllDatabases AS SELECT 1;'
GO

ALTER PROCEDURE usp_checkAllDatabases
AS
/*
EXEC usp_checkAllDatabases;
*/
BEGIN
    DECLARE @databaseList as CURSOR;
    DECLARE @databaseName as NVARCHAR(500);
    DECLARE @tsql AS NVARCHAR(500);

    SET @databaseList = CURSOR  LOCAL FORWARD_ONLY STATIC READ_ONLY 
    FOR
          SELECT QUOTENAME([name])
          FROM sys.databases
          WHERE [state] = 0
          AND [is_read_only] = 0;
    OPEN @databaseList;
    FETCH NEXT FROM @databaseList into @databaseName;
    WHILE @@FETCH_STATUS = 0
    BEGIN
       SET @tsql = N'DBCC CheckDB(' + @databaseName + ') WITH NO_INFOMSGS;';
       EXECUTE (@tsql);
       FETCH NEXT FROM @databaseList into @databaseName;
    END
    CLOSE @databaseList;
    DEALLOCATE @databaseList;
END
GO
