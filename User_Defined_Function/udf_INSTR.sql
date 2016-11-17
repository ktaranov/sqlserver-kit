IF OBJECT_ID('dbo.udf_INSTR', 'IF') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_INSTR() RETURNS TABLE AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_INSTR(
    @str       NVARCHAR(4000),
    @substr    NVARCHAR(4000),
    @start     INT,
    @Occurance INT
)
RETURNS TABLE
AS
/*
Note
    Author: Hannan Kravitz
    Original link: http://www.sqlservercentral.com/scripts/SUBSTRING/148570/
    Modified Date: 2016-11-17
Example:
    SELECT Loc FROM dbo.udf_INSTR ('Hello World', 'l', 1, 1) -- return 3
    SELECT Loc FROM dbo.udf_INSTR ('Hello World', 'l', 1, 3) -- return 10
    SELECT Loc FROM dbo.udf_INSTR ('Hello World', 'l', 1, 4) -- return NULL
    SELECT Loc FROM dbo.udf_INSTR ('Ёжик - это моё имя','ё', 1, 1) -- return 14
*/
RETURN
    WITH Tally(N) AS
    (
        SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
        FROM (VALUES (0),(0),(0),(0),(0),(0),(0),(0)) a(N)
        CROSS JOIN (VALUES(0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) b(N)
        CROSS JOIN (VALUES(0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) c(N)
        CROSS JOIN (VALUES(0),(0),(0),(0),(0),(0),(0),(0),(0),(0)) d(N)
    )
, Find_N_STR AS
    (
    SELECT
    CASE WHEN DENSE_RANK() OVER(PARTITION BY @substr ORDER BY (CHARINDEX(@substr, @str, N))) = @Occurance
         THEN MAX(N - @start + 1) OVER (PARTITION BY CHARINDEX(@substr, @str, N))
         ELSE 0
         END [Loc]
    FROM Tally
    WHERE CHARINDEX(@substr, @str, N) > 0
    )
    SELECT Loc= MAX(Loc)
    FROM Find_N_STR
    WHERE Loc > 0;
GO
