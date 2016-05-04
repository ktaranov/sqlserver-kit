IF OBJECT_ID('dbo.udf_SplitStringByDelimiter', 'IF') IS NULL
EXECUTE('CREATE FUNCTION dbo.udf_SplitStringByDelimiter() RETURNS TABLE WITH SCHEMABINDING AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_SplitStringByDelimiter(
   @List NVARCHAR(MAX),
   @Delimiter NVARCHAR(MAX)
)
RETURNS TABLE
WITH SCHEMABINDING AS
RETURN
  WITH E1(N)        AS ( SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 
                         UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 
                         UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1),
       E2(N)        AS (SELECT 1 FROM E1 a, E1 b),
       E4(N)        AS (SELECT 1 FROM E2 a, E2 b),
       E42(N)       AS (SELECT 1 FROM E4 a, E2 b),
       cteTally(N)  AS (SELECT 0 UNION ALL SELECT TOP (DATALENGTH(ISNULL(@List,1))) 
                         ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E42),
       cteStart(N1) AS (SELECT t.N+1 FROM cteTally t
                         WHERE (SUBSTRING(@List,t.N,1) = @Delimiter OR t.N = 0))
  SELECT Item = SUBSTRING(@List, s.N1, ISNULL(NULLIF(CHARINDEX(@Delimiter,@List,s.N1),0)-s.N1,8000))
    FROM cteStart s;
GO
