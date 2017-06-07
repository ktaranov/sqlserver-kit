/*
Author: Alan Burstein
Original link: http://www.sqlservercentral.com/scripts/String+Function/141686
*/

IF OBJECT_ID('dbo.udf_DigitsOnlyEE') IS NOT NULL DROP FUNCTION dbo.udf_DigitsOnlyEE;
GO
CREATE FUNCTION dbo.udf_DigitsOnlyEE (@pString VARCHAR(8000))
/****************************************************************************************
Purpose:
 Given a VARCHAR(8000) or less string, return only the numeric digits from the string.

Compatibility: 
 SQL Server 2008+, Azure SQL Database, Azure SQL Data Warehouse & Parallel Data Warehouse

Parameters:
 @pString = varchar(8000); Input string to be cleaned

Returns:
 DigitsOnly = nvarchar(max) 

Syntax:
--===== Autonomous
 SELECT ca.DigitsOnly
 FROM dbo.DigitsOnly(@pString) ca;

--===== CROSS APPLY example
 SELECT ca.DigitsOnly
 FROM dbo.SomeTable
 CROSS APPLY dbo.DigitsOnly(SomeVarcharCol) ca

Programmer's Notes:
 1. This is an iTVF (Inline Table Valued Function) that performs the same task as a 
    scalar user defined function (UDF) accept that it requires the APPLY table operator. 
    Note the usage examples below and See this article for more details: 
    http://www.sqlservercentral.com/articles/T-SQL/91724/ 

    The function will be slightly more complicated to use than a scalar UDF but will yeild
    much better performance. For example - unlike a scalar UDF, this function does not 
    restrict the query optimizer's ability generate a parallel query plan. Initial testing
    showed that the function generally gets a 

 2. Runs 2-4 times faster with a parallel query plan. For optimal performance use Adam
    Machanic's make_parallel() function (provided that you are on a machine with two or 
    more logical CPUs). make_parallel can be found here: 
 sqlblog.com/blogs/adam_machanic/archive/2013/07/11/next-level-parallel-plan-porcing.aspx

 3. This is an iTVF (Inline Table Valued Function) that will be used as an iSF 
    (Inline Scalar Function) in that it returns a single value in the returned 
    table and should normally be used in the FROM clause as with any other iTVF.

 4. CHECKSUM returns an INT and will return the exact number given if given an 
    INT to begin with. It's also faster than a CAST or CONVERT and is used as a 
    performance enhancer by changing the BIGINT of ROW_NUMBER() to a more 
    appropriately sized INT.

 5. Another performance enhancement is using a WHERE clause calculation to prevent 
    the relatively expensive XML PATH concatentation of empty strings normally 
    determined by a CASE statement in the XML "loop".

 6. Another performance enhancement is not making this function a generic function 
    that could handle a pattern. That allows us to use all integer math to do the 
    comparison using the high speed ASCII function convert characters to their numeric
    equivalent.  ASCII characters 48 through 57 are the digit characters of 0 through 9.

 7. Keep in mind that udf_DigitsOnlyEE returns an nvarchar(max) value. If you are returning
    small numbers consider casting or converting yout values to a numeric data type if 
    you are inserting the return value into a new table or using it for joins or comparison
    purposes. 

 8. udf_DigitsOnlyEE is deterministic; for more about deterministic and nondeterministic 
    functions see https://msdn.microsoft.com/en-us/library/ms178091.aspx

Kudos:

 1. Hats off to Eirikur Eiriksson for the ASCII conversion idea and for the reminders 
    that dedicated functions will always be faster than generic functions and that 
    integer math beats the tar out of character comparisons that use LIKE or PATINDEX.

 2. Hats off to all of the good people that submitted and tested their code on the 
    following thread. It's this type of participation and interest that makes code 
    better.  You've just gotta love this commmunity.
    http://www.sqlservercentral.com/Forums/Topic1585850-391-2.aspx#bm1629360

Usage Examples:
--===== 1. Basic use against a literal
 SELECT DigitsOnly 
 FROM dbo.udf_DigitsOnlyEE('xxx123abc999!!!');

--===== 2. Against a table 
 DECLARE @sampleTxt TABLE (txtID int identity, txt varchar(100));
 INSERT @sampleTxt(txt) VALUES ('abc123'),('!!!555!!!'),('000.999'),(NULL);

 SELECT txtID, OldTxt = txt, DigitsOnly
 FROM @sampleTxt st
 CROSS APPLY dbo.udf_DigitsOnlyEE(st.txt);

---------------------------------------------------------------------------------------
Revision History:
 Rev 00 - 20141029 - Initial Creation - Jeff Moden 
 Rev 01 - 20141210 - TOP clause changed to handle NULL inputs - Eirikur Eiriksson
 Rev 02 - 20160512 - Substantial updates to the comments & examples - Alan Burstein
****************************************************************************************/
RETURNS TABLE WITH SCHEMABINDING AS RETURN
WITH 
E1(N) AS 
(
  SELECT N 
  FROM (VALUES (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL))X(N)
),
iTally(N) AS 
(
  SELECT TOP (LEN(ISNULL(@pString,CHAR(32)))) 
    (CHECKSUM(ROW_NUMBER() OVER (ORDER BY (SELECT NULL))))
  FROM E1 a CROSS JOIN E1 b CROSS JOIN E1 c  CROSS JOIN E1 d
)
SELECT DigitsOnly = 
(
  SELECT SUBSTRING(@pString,N,1)
  FROM iTally 
  WHERE ((ASCII(SUBSTRING(@pString,N,1)) - 48) & 0x7FFF) < 10
  FOR XML PATH('')
);