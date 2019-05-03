/*
https://eitanblumin.com/2018/11/06/re-align-identity-last-value-to-actual-max-value/
*/

DECLARE @CurrTable SYSNAME, @CurrCol SYSNAME, @LastValue BIGINT
DECLARE @CMD NVARCHAR(MAX), @Result NVARCHAR(MAX)

DECLARE Cur CURSOR
LOCAL FAST_FORWARD
FOR
SELECT QUOTENAME(OBJECT_SCHEMA_NAME(t.object_id)) + '.' + QUOTENAME(OBJECT_NAME(t.object_id)), c.name, CONVERT(int, c.last_value)
FROM sys.identity_columns AS c
INNER JOIN sys.tables AS t
ON c.object_id = t.object_id
WHERE c.last_value > c.seed_value

OPEN Cur
FETCH NEXT FROM Cur INTO @CurrTable, @CurrCol, @LastValue

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @CMD = N'
	SELECT @pResult = N''DBCC CHECKIDENT(''''' + @CurrTable + N''''', RESEED, '' + CONVERT(nvarchar(max), MAX(' + QUOTENAME(@CurrCol) + N')) + N'') -- ' + CONVERT(nvarchar(max), @LastValue) + N'''
	FROM ' + @CurrTable + N'
	HAVING MAX(' + QUOTENAME(@CurrCol) + N') <> @LastValue'

	EXEC sp_executesql @CMD, N'@pResult NVARCHAR(MAX) OUTPUT, @LastValue BIGINT', @Result OUTPUT, @LastValue;

	IF @Result IS NOT NULL
		PRINT @Result;

	FETCH NEXT FROM Cur INTO @CurrTable, @CurrCol, @LastValue
END

CLOSE Cur
DEALLOCATE Cur