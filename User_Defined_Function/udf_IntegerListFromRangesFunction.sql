IF EXISTS
  (
  SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINES.ROUTINE_NAME = 'IntegerListfromRangesFunction'
      AND ROUTINES.ROUTINE_TYPE = 'function'
  )
DROP FUNCTION dbo.IntegerListfromRangesFunction;
GO
CREATE FUNCTION IntegerListfromRangesFunction
  (
  /**
summary:   >
 This Procedure takes a list of integers with ranges in them and turns it into
 a list of integers. Effectively, it removes the ranges by turning them into all
 the integers in the range. This uses the iterative solution without an intermediary
 table
Author: Phil Factor
Revision: 1.0
date: 20 Nov 2016
example: >
-eg. SELECT dbo.IntegerListfromRangesFunction('1-4,6,8-11,13,21-23,25,27-28,30')
	 --which would become 1,2,3,4,6,8,9,10,11,13,21,22,23,25,27,28,30
returns:  >
  The list as an ascll string representing a list of integers.
**/
  @list VARCHAR(MAX) --eg. 1-4,6,8-11,13,21-23,25,27-28,30
  )
RETURNS VARCHAR(MAX)
AS
  BEGIN
  DECLARE @c CHAR, --the current character being examined
    @ii INT, --the iteration count
    @len INT, --length of the list
    @negative BIT, --is this a negative number,
    @Accumulator INT, --the value of the number so far
    @ThereIsAnRvalue INT, --Is there an Rvalue in the accumulator
    @previous CHAR, --the previous character examined
    @lvalue INT, --left hand side value  of ecxpression, 
    @OutputList VARCHAR(MAX); -- the output list
  --so initialise everything
  SELECT @list = @list + ',', @ii = 1, @len = LEN(@list), @negative = 0,
    @Accumulator = 0, @previous = ',', @lvalue = 0, @OutputList = '',
    @ThereIsAnRvalue = 0;
  WHILE(@ii <= @len) --from the start to end of the list 
    BEGIN
    SELECT @c = SUBSTRING(@list, @ii, 1); --get the next character
    IF @c = '-' AND @previous LIKE '[0-9]' --is it the range keyword
    SELECT @lvalue = --if it is, then save the lvalue
      CASE WHEN @negative = 1 THEN -@Accumulator ELSE @Accumulator END,
      @ThereIsAnRvalue = 1, @Accumulator = 0, @negative = 0;
    ELSE IF @c = '-' --it IS a negative number following
    SELECT @negative = 1;
    ELSE IF @c LIKE '[0-9]' --it is a number
    SELECT @Accumulator = (@Accumulator * 10) + @c;
    ELSE IF(@c = ',') --it is the end of the current list entry 
      BEGIN
      SELECT @Accumulator =
        CASE WHEN @negative = 1 THEN -@Accumulator ELSE @Accumulator END;
      IF @ThereIsAnRvalue = 1
      WHILE(@lvalue <= @Accumulator)
        BEGIN
        SELECT @OutputList =
          @OutputList + ',' + CONVERT(VARCHAR(5), @lvalue);
        SELECT @lvalue = @lvalue + 1;
        END;
      ELSE
      SELECT @OutputList =
        @OutputList + ',' + CONVERT(VARCHAR(5), @Accumulator);
      SELECT @Accumulator = 0, @negative = 0, @lvalue = 0,
        @ThereIsAnRvalue = 0;
      END;
    SELECT @ii = @ii + 1, @previous = @c;
    END;
  RETURN STUFF(@OutputList, 1, 1, '');
  END;