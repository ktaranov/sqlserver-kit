/****** Object:  StoredProcedure [dbo].[IntegerListfromRanges]    Script Date: 01/12/2016 10:45:21 ******/
 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES
	WHERE ROUTINES.ROUTINE_TYPE='procedure' 
	AND ROUTINES.ROUTINE_SCHEMA='dbo'
	AND	ROUTINES.ROUTINE_NAME = 'IntegerListfromRanges')
	DROP PROCEDURE IntegerListfromRanges
go
CREATE procedure [dbo].[IntegerListfromRanges]
/**
summary:   >
 This Procedure takes a list of integers with ranges in them and turns it into
 a list of integers. Effectively, it removes the ranges by turning them into all
 the integers in the range. This is a demonstration of a working method because
 I create a number table on the fly with negative integers (these make things harder)
 and normally you'd just want to have the table of numbers that you would then
 use for whatever relational task you were engaged with
Author: Phil Factor
Revision: 1.0
date: 19 Nov 2016
example: >
    DECLARE @list VARCHAR(MAX)
    EXECUTE dbo.IntegerListFromRanges '-12--3,4,6,7',@list OUTPUT
    SELECT @list
returns:  >
  The list as an ascll string representing a list of integers.
**/  
@Rangelist VARCHAR(MAX), --eg. 1-4,6,8-11,13,21-23,25,27-28,30
	--which would become 1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30
@list VARCHAR(MAX) output
AS
 
BEGIN 
--declare some variables
DECLARE  @inClause VARCHAR(MAX), @BetweenClause VARCHAR(MAX),
         @XMLVersionOfList XML,@NumberTableSQL NVARCHAR(MAX)
DECLARE @MyNumbers TABLE
  (
    MyRange VARCHAR(10)
);
--here we create the numbers table with a precautionary test
IF NOT EXISTS(
  SELECT TABLES.TABLE_NAME FROM tempdb.INFORMATION_SCHEMA.TABLES 
  WHERE TABLES.TABLE_NAME LIKE '#NumbersForRanges%')
	BEGIN
    SELECT TOP 10000 IDENTITY(int,-5000,1) AS Number
      INTO #NumbersForRanges
      FROM sys.objects s1      
        CROSS JOIN sys.objects s2; 
    ALTER TABLE #NumbersForRanges ADD CONSTRAINT 
		PK_NumbersForRanges PRIMARY KEY CLUSTERED (Number);
	end
--we convert the list into XML
SELECT @XMLVersionOfList =
  '<list><i>' + REPLACE(@rangelist, ',', '</i><i>') + '</i></list>';
--we now take each component and insert it into a row of a table variable
INSERT INTO @MyNumbers(MyRange)
  SELECT x.y.value('.', 'varchar(10)') AS IDs
  FROM @XMLVersionOfList.nodes('/list/i/text()') AS x(y);
-- end of section converting list to a table we can work with
SELECT @inClause='', @BetweenClause=''
--we want to make a SELECT statement against a number table
SELECT 
 @inClause=@inClause +CASE WHEN MyRange like '%[0-9]-%' THEN '' ELSE ',' + MyRange END,
 @BetweenClause=@BetweenClause 
  +CASE WHEN MyRange like '%[0-9]-%' 
   THEN 'or (number between '+STUFF(MyRange,PATINDEX('%[0-9]-%',[@MyNumbers].MyRange)+1,1,' and ')+') ' 
   ELSE'' END
 FROM @MyNumbers
 SELECT @list=''
IF @@RowCount>0 
  BEGIN
  SELECT @NumberTableSQL='SELECT @OutputList='''';
  SELECT @OutputList=@OutputList+ '',''+ convert(varchar(5),number)  from #NumbersForRanges where ' +
    CASE WHEN LEN(@inClause)>0 THEN 'number in ('+ STUFF(@inClause,1,1,0)+') 'ELSE '' END+
    CASE WHEN LEN(@BetweenClause)>0 THEN CASE WHEN LEN(@inClause)>0 THEN 'or' ELSE '' END+
	' ('+ STUFF(@BetweenClause,1,3,'')+')'ELSE '' END;
---now we execute the code against the number table
  EXEC sp_ExecuteSQL @NumberTableSQL, N'@OutputList Varchar(max) OUTPUT',@OutputList=@List OUTPUT
  SELECT  @list=STUFF(@list,1,1,'')
  END
end
go