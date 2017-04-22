IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINES.ROUTINE_NAME='ConvertRangesInIntegerList'
    AND ROUTINES.ROUTINE_TYPE='function')
DROP FUNCTION dbo.ConvertRangesInIntegerList
go
CREATE FUNCTION ConvertRangesInIntegerList
(
       -- the simple list. The list doesn't have to be in sorted order.
       @list VARCHAR(MAX) --eg. 1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30
       --which would become     1-4,6,8-11,13,21-23,25,27,28,30
       --note that 27,28 are not converted to 27-28 because the range isn't sufficient
--SELECT dbo.ConvertRangesInIntegerList ('1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30')
)
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @Outputlist VARCHAR(MAX);
DECLARE @XMLVersionOfList XML;
DECLARE @MyNumbers TABLE
  (
    Mynumber INT PRIMARY KEY,
    Representation varchar(10),
       Rangelength int
);
SELECT @XMLVersionOfList = '<list><i>' + REPLACE(@list, ',', '</i><i>') + '</i></list>';
--this will convert the list of numbers into XML and do some validity-checking.
DECLARE @PreviousValue INT, @RowRepresentation varchar(10), @RangeLength INT
SELECT @RangeLength=0;
--we put these in a table variable that has a primary key, ready for use
--you'd probably want a Try CATCH section here, but not is an example like this
INSERT INTO @MyNumbers(Mynumber)
  SELECT DISTINCT x.y.value('.', 'int') AS IDs
  FROM @XMLVersionOfList.nodes('/list/i/text()') AS x(y);
--now we update this quirkily to detect gaps in the sequence and represent islands
UPDATE @MyNumbers
  SET
   @RowRepresentation=[@MyNumbers].Representation=
    CASE
         WHEN [@MyNumbers].Mynumber=@PreviousValue+1 --next in the sequence? 
           THEN ''
      WHEN @RowRepresentation='' AND @RangeLength>1--the previous row was in a sequence but this isn't
           THEN '-'+CONVERT(varCHAR(5),@PreviousValue)+','+CONVERT(varCHAR(5),[@MyNumbers].Mynumber) 
      ELSE CASE WHEN @rangelength=1
                THEN ','+CONVERT(varCHAR(5),@PreviousValue) ELSE '' END
                 + ','+CONVERT(varCHAR(5),[@MyNumbers].Mynumber) END,--else it was not in a sequence
   @RangeLength=[@MyNumbers].Rangelength=
    CASE WHEN [@MyNumbers].Mynumber=@PreviousValue+1 THEN @RangeLength+1 ELSE 0 END,
   @PreviousValue=[@MyNumbers].Mynumber --remember the value for the next row
SET @Outputlist='' --now join together all the representations
SELECT @Outputlist=@Outputlist+Representation FROM @MyNumbers
RETURN
  STUFF(--trim the start and add the last entry if it ended with a sequence
   @Outputlist+CASE WHEN @RowRepresentation='' THEN '-'+CONVERT(varCHAR(5),@PreviousValue) ELSE '' END,
   1,1,'')
END
GO