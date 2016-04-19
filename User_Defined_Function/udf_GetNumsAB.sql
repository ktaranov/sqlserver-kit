IF OBJECT_ID('dbo.udf_GetNumsAB', 'IF') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_GetNumsAB() RETURNS TABLE WITH SCHEMABINDING AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_GetNumsAB(
      @low  bigint
    , @high bigint
    , @gap  bigint
    , @row1 bit
)
/****************************************************************************************
Purpose:
 Creates up to 100,544,625 sequential numbers beginning with @low and ending with @high.
 Used to replace iterative methods such as loops, cursors and recursive CTEs to solve SQL
 problems. Based on Itzik Ben-Gan's getnums function with some tweeks and enhancements 
 and added functionality. The logic for getting rn to begin at 0 or 1 is based comes from 
 Jeff Moden's fnTally function. 

Compatibility: 
 SQL Server 2008+ and Azure SQL Database

Syntax:
 SELECT rn, n1, n2 FROM dbo.udf_GetNumsAB(@low,@high,@gap,@row1);

Parameters:
 @low  = a bigint that represents the lowest value for n1.
 @high = a bigint that represents the highest value for n1.
 @gap  = a bigint that represents how much n1 and n2 will increase each row; @gap also
         represents the difference between n1 and n2.
 @row1 = a bit that represents the first value of rn. When @row = 0 then rn begins
         at 0, when @row = 1 then rn will begin at 1.
 
Return Types:
 Inline Table Valued Function returns:
 rn = bigint; a row number that works just like T-SQL ROW_NUMBER() except that it can 
      start at 0 or 1 which is dictated by @row1.
 n1 = bigint; a sequential number starting at the value of @low and incrimentingby the
      value of @gap until it is less than or equal to the value of @high.
 n2 = bigint; a sequential number starting at the value of @low+@gap and  incrimenting 
      by the value of @gap.

Developer Notes:
 1. The lowest and highest possible numbers returned are whatever is allowable by a 
    bigint. The function, however, returns no more than 100,544,625 rows (465^3).
 2. @gap does not affect rn, rn will begin at @row1 and increase by 1 until the last row
    unless its used in a query where a filter is applied to rn.
 3. @gap must be greater than 0 or the function will not return any rows.
 4. Keep in mind that when @row1 is 0 then the highest row-number will be the number of
    rows returned minus 1
 5. If you only need is a sequential set beginning at 0 or 1 then, for best performance
    use the RN column. Use N1 and/or N2 when you need to begin your sequence at any 
	number other than 0 or 1 or if you need a gap between your sequence of numbers. 
 6. Although @gap is a bigint it must be a positive integer or the function will
    not return any rows.
 7. @high must be equal or higher than @low or the function won't return any rows.
 8. There is no performance penalty for sorting by rn ASC; there is a large performance 
    penalty for sorting in descending order. To sort in descending order, first make sure
    that @gap = 1. Next create an alias column (called "n_desc" in the example below) and
    use the formula: n_desc = ABS(rn-(@high+1)). The example below will return the numbers 
    1 to 10 in descending order:

    DECLARE @low int = 1, @high int = 10, @gap int = 1, @row1 bit = 1;

    SELECT n_desc = ABS(rn-(@high+(@row1))) 
    FROM dbo.udf_GetNumsAB(@low,@high,1,@ro1)
    ORDER BY rn;

Examples:

--===== 1. Using RN (rownumber)
 -- (1.1) The best way to get the numbers 1,2,3...@high (e.g. 1 to 5):
 SELECT RN FROM dbo.udf_GetNumsAB(1,5,1,1);

 -- (1.2) The best way to get the numbers 0,1,2...@high-1 (e.g. 0 to 5):
 SELECT RN FROM dbo.udf_GetNumsAB(0,5,1,0);

--===== 2. Using N1
 -- (2.1) To begin with numbers other than 0 or 1 use N1 (e.g. -3 to 3):
 SELECT N1 FROM dbo.udf_GetNumsAB(-3,3,1,1);

 -- (2.2) ROW_NUMBER() is built in. If you want a ROW_NUMBER() include RN:
 SELECT RN, N1 FROM dbo.udf_GetNumsAB(-3,3,1,1);

 -- (2.3) If you wanted a ROW_NUMBER() that started at 0 you would do this:
 SELECT RN, N1 FROM dbo.udf_GetNumsAB(-3,3,1,0);

--===== 3. Using N2 and @gap
 -- (3.1) To get 0,10,20,30...100, set @low to 0, @high to 100 and @gap to 10:
 SELECT N1 FROM dbo.udf_GetNumsAB(0,100,10,1);

 -- (3.2) Note that N2=N1+@gap; this allows you to create a sequence of ranges.
 --       For example, to get (0,10),(10,20),(20,30).... (90,100):
 SELECT N1, N2 FROM dbo.udf_GetNumsAB(0,90,10,1);

 -- (3.3) Remember that a rownumber is included and it can begin at 0 or 1:
 SELECT RN, N1, N2 FROM dbo.udf_GetNumsAB(0,90,10,1);

--===== (4) A real life example using RN, N1 and N2:
 -- Beginning with @StartDate, to generate ranges of weeks that occur between 
 -- @startDate & @EndDate:

 DECLARE @StartDate datetime = '1/1/2015', @EndDate datetime = '2/28/2015';

 SELECT 
   WeekNbr   = 'Week #'+CAST(RN AS varchar(2)),
   WeekStart = CONVERT(DATE, DATEADD(DAY,N1,@StartDate)), 
   WeekEnd   = CONVERT(DATE, DATEADD(DAY,N2-1,@StartDate))
 FROM dbo.udf_GetNumsAB(0,datediff(DAY,@StartDate,@EndDate),7,1);

---------------------------------------------------------------------------------------
Revision History: 
 Rev 00 - 20140518 - Initial Development - Alan Burstein
 Rev 01 - 20151029 - Added 65 rows to make L1=465; 465^3=100.5M. Updated comment section
        - Alan Burstein
****************************************************************************************/
RETURNS TABLE WITH SCHEMABINDING AS RETURN
WITH 
L1(N) AS 
(
  SELECT 1 
  FROM (VALUES
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),
       (NULL),(NULL),(NULL)) t(N) -- 465 values 
),
iTally AS
(
  SELECT rn = 0 WHERE @row1 = 0 
  UNION ALL
  SELECT rn = ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
  FROM L1 a CROSS APPLY L1 b CROSS APPLY L1 c
) --Up to 100,544,625 numbers (select 465*465*465 = 100,544,625)
SELECT TOP (ABS((@high-@low)/ISNULL(NULLIF(@gap,0),1)+1))
       rn
     , n1 = ((rn-( @row1 ))*@gap+@low)
     , n2 = ((rn-(@row1-1))*@gap+@low)
FROM iTally
WHERE @high >= @low and @gap > 0
ORDER BY rn;
GO
