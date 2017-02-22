IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINES.ROUTINE_NAME='SecondConvertRangesInIntegerList'
    AND ROUTINES.ROUTINE_TYPE='function')
DROP FUNCTION dbo.SecondConvertRangesInIntegerList
go
CREATE FUNCTION SecondConvertRangesInIntegerList
(
       -- the simple list. The list doesn't have to be in sorted order.
       @list VARCHAR(MAX) --eg. 1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30
       --which would become     1-4,6,8-11,13,21-23,25,27,28,30
       --note that 27,28 are not converted to 27-28 because the range isn't sufficient
--SELECT dbo.SecondConvertRangesInIntegerList ('1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30')
)
RETURNS VARCHAR(MAX)
AS
Begin
DECLARE @XMLVersionOfList XML; -- we use this to slice up the list
DECLARE @MyNumbers TABLE --we will insert it into this table variable
  (
    rank INT IDENTITY(1, 1),
    number INT PRIMARY KEY
);
DECLARE @ranks TABLE
  (
    theMin INT,
    TheMax INT,
    TheCount INT
);
SELECT @XMLVersionOfList =
  '<list><i>' + REPLACE(@list, ',', '</i><i>') + '</i></list>';
--this will convert the list of numbers into XML and do some validity-checking.
--we put these in a table variable that has a primary key, ready for use
INSERT INTO @MyNumbers(number)
  SELECT x.y.value('.', 'int') AS IDs
  FROM @XMLVersionOfList.nodes('/list/i/text()') AS x(y);
--this will fail of course if it isn't an integer
-- now we group into sequences 
INSERT INTO @ranks(theMin, TheMax, TheCount)
  SELECT MIN([@MyNumbers].number), MAX([@MyNumbers].number), COUNT(*)
  FROM @MyNumbers
  GROUP BY [@MyNumbers].number - [@MyNumbers].rank;
-- we can now create the ranged list. We need to check whether the sequence
-- was less than three long. Otherwise it would be simple.
DECLARE @Outputlist VARCHAR(MAX);
SELECT @Outputlist = '';
SELECT @Outputlist = @Outputlist+
  CASE 
    WHEN ThisRowsRange.TheCount IS NULL THEN 
      CASE WHEN PreviousRowsRange.TheCount < 3 
	  THEN ','+CONVERT(VARCHAR(5),ThisRow.number) ELSE '' 
	  END 
	WHEN ThisRowsRange.TheCount<3 THEN ','+CONVERT(VARCHAR(5),ThisRow.number)
	ELSE ','+CONVERT(VARCHAR(5),ThisRowsRange.theMin)
	        +'-'+CONVERT(VARCHAR(5),ThisRowsRange.TheMax) 
  END
  FROM @MyNumbers ThisRow
    LEFT OUTER JOIN @MyNumbers PreviousRow
      ON ThisRow.rank = PreviousRow.rank + 1
    LEFT OUTER JOIN @ranks ThisRowsRange
      ON ThisRow.number = ThisRowsRange.theMin
    LEFT OUTER JOIN @ranks PreviousRowsRange
      ON PreviousRow.number = PreviousRowsRange.theMin
  ORDER BY ThisRow.rank;
RETURN STUFF(@Outputlist, 1, 1, '');
End