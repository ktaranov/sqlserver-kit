IF OBJECT_ID('dbo.udf_PatReplace8K', 'IF') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_PatReplace8K() RETURNS TABLE WITH SCHEMABINDING AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_PatReplace8K
(
  @string  varchar(8000),
  @pattern varchar(50),
  @replace varchar(1)
) 
/*****************************************************************************************
Purpose:
 Given a string (@string), a pattern (@pattern), and a replacement character (@replace)
 udf_PatReplace8K will replace any character in @string that matches the @pattern parameter 
 with the character, @replace.

Usage:
--===== Basic Syntax Example
 SELECT pr.NewString
 FROM dbo.udf_PatReplace8K(@string, @pattern, @replace);

--===== Replace numeric characters with a "*"
 SELECT pr.NewString
 FROM dbo.udf_PatReplace8K('My phone number is 555-2211','[0-9]','*') pr;

--==== Using againsts a table
 DECLARE @table TABLE(OldString varchar(40));
 INSERT @table VALUES 
 ('Call me at 555-222-6666'),
 ('phone number: (312)555-2323'),
 ('He can be reached at 444.665.4466');
 SELECT t.OldString, pr.NewString
 FROM @table t
 CROSS APPLY dbo.udf_PatReplace8K(t.OldString,'[0-9]','*') pr;

 Programmer Notes:
 1. Required SQL Server 2008+
 2. @pattern IS case sensitive but can be easily modified to make it case insensitive
 3. There is no need to include the "%" before and/or after your pattern since since we 
    are evaluating each character individually
 4. Certain special characters, such as "$" and "%" need to be escaped with a "/"
    like so: [/$/%]

Revision History:
 Rev 00 - 10/27/2014 Initial Development - Alan Burstein

 Rev 01 - 10/29/2014 Mar 2007 - Alan Burstein
        - Redesigned based on the dbo.STRIP_NUM_EE by Eirikur Eiriksson
          (see: http://www.sqlservercentral.com/Forums/Topic1585850-391-2.aspx)
        - change how the cte tally table is created 
        - put the include/exclude logic in a CASE statement instead of a WHERE clause
        - Added Latin1_General_BIN Colation
        - Add code to use the pattern as a parameter.

 Rev 02 - 20141106
        - Added final performane enhancement (more cudo's to Eirikur Eiriksson)
        - Put 0 = PATINDEX filter logic into the WHERE clause

Rev 03  - 20150516
        - Updated to deal with special XML characters

Rev 04  - 20170320
        - changed @replace from char(1) to varchar(1) to address how spaces are handled
*****************************************************************************************/
RETURNS TABLE WITH SCHEMABINDING
AS
RETURN
WITH
E1(N) AS (SELECT N FROM (VALUES (1),(1),(1),(1),(1),(1),(1),(1),(1),(1)) AS E1(N)),
iTally(N) AS 
(
  SELECT TOP (LEN(@string)) CHECKSUM(ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) 
  FROM E1 a,E1 b,E1 c,E1 d
)
SELECT NewString =
((
  SELECT
    CASE 
      WHEN PATINDEX(@pattern,SUBSTRING(@string COLLATE Latin1_General_BIN,N,1)) = 0
      THEN SUBSTRING(@string,N,1)
      ELSE @replace
    END
  FROM iTally
  FOR XML PATH(''), TYPE
).value('.[1]','varchar(8000)'));
GO
