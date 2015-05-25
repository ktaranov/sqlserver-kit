CREATE FUNCTION [dbo].[udf_Tally]
    (
     @pMin BIGINT
    ,@pMax BIGINT
    )
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN

    /* Uses the Bates algorithm for generating the rows from         */
    /* http://www.sqlservercentral.com/scripts/Tally+Table/99617/    */

    /*
    Usage:
    SELECT N FROM [dbo].[itvfTally](1001,1100)
    SELECT N FROM [dbo].[itvfTally](-10,100)
    SELECT N FROM [dbo].[itvfTally](0,1000)
    SELECT N FROM [dbo].[itvfTally](1,1000)
    */    
    
    WITH T1(F) AS 
    (
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1 UNION ALL
        SELECT 1
    ),
    T2(F) AS 
        (SELECT 1 FROM T1 A, T1 B),
    T3(F) AS 
        (SELECT 1 FROM T2 A, T2 B),
    T4(F) AS 
        (SELECT 1 FROM T3 A, T3 B),
    cteTally(N) AS 
        (
        SELECT TOP ((@pMax-(((ABS(@pMin)+@pMin)/2)))+1)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) 
            + ((((ABS(@pMin)+@pMin)/2))-1)
        FROM T4
        )
SELECT 
    N
FROM 
    cteTally T
;