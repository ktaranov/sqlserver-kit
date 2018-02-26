IF OBJECT_ID('dbo.sp_DropIndexes', 'P') IS NULL 
    EXECUTE ('CREATE PROCEDURE dbo.sp_DropIndexes AS SELECT 1;');
GO


ALTER PROCEDURE dbo.sp_DropIndexes(
    @debug BIT = 1
)
/*
.SYNOPSIS
    Drop indexes and statistics

.DESCRIPTION
    Drop indexes and statistics

.PARAMETER @debug
    Just generate DROP statements withou executing it

.EXAMPLE
    EXEC sp_DropIndexes @debug = 0;

.LICENSE MIT
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.NOTE
    Author: Brent Ozar
    Created date: 2017-04-11
    Version: 1.0

    Author: Konstantin Taranov
    Modified date: 2018-01-03
    Version: 1.1
*/
AS
SET NOCOUNT ON;

CREATE TABLE #commands (ID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED, Command NVARCHAR(2000));
DECLARE @CurrentCommand NVARCHAR(2000);

INSERT INTO #commands (Command)
SELECT 'DROP INDEX [' + i.name + '] ON [' + s.name + '].[' + t.name + ']'
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE i.type = 2;

INSERT INTO #commands (Command)
SELECT 'DROP STATISTICS ' + SCHEMA_NAME([t].[schema_id]) + '.'  + OBJECT_NAME([s].[object_id]) + '.' + s.[name]
FROM sys.[stats] AS [s]
JOIN sys.[tables] AS [t]
ON s.[object_id] = t.[object_id]
WHERE [s].[name] LIKE '[_]WA[_]Sys[_]%'
AND OBJECT_NAME([s].[object_id]) NOT LIKE 'sys%';

IF @debug = 1
SELECT * FROM #commands;
ELSE
BEGIN
DECLARE result_cursor CURSOR FOR
SELECT Command FROM #commands;

OPEN result_cursor
FETCH NEXT FROM result_cursor into @CurrentCommand
WHILE @@FETCH_STATUS = 0
BEGIN

  EXEC(@CurrentCommand);

FETCH NEXT FROM result_cursor into @CurrentCommand
END
--end loop

--clean up
CLOSE result_cursor;
DEALLOCATE result_cursor;
END;
GO
