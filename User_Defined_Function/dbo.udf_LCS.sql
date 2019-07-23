IF OBJECT_ID('dbo.udf_LCS') IS NULL
   EXECUTE ('CREATE FUNCTION dbo.udf_LCS() RETURNS nvarchar(max) AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_LCS
  /**
summary:   >
 The longest common subsequence (LCS) problem is the problem of finding the
 longest subsequence common to all sequences in two sequences. It differs
 from problems of finding common substrings: unlike substrings, subsequences
 are not required to occupy consecutive positions within the original
 sequences. For example, the sequences "1234" and "1224533324" have an LCS of "1234"
Author: Phil Factor
Revision: 1.1
Created Date: 2019-04-05
Modified date: 2019-07-08 Konstantin Taranov
Original link: https://www.red-gate.com/simple-talk/blogs/using-json-for-matrices-in-sql-server/
example:
 code:
     SELECT dbo.udf_LCS ('1234', '1224533324');
     SELECT dbo.udf_LCS ('thisisatest', 'testing123testing');
     SELECT dbo.udf_LCS ( 'XMJYAUZ', 'MZJAWXU');
     SELECT dbo.udf_LCS ( 'beginning-middle-ending', 'beginning-diddle-dum-ending');
returns:   >
  the longest common subsequence as a string
**/
  (@xString varchar(max), @yString varchar(max))
RETURNS varchar(max)
AS
  BEGIN

    DECLARE @ii int = 1; --inner index
    DECLARE @jj int = 1; --next loop index
    DECLARE @West int; --array reference number to left
    DECLARE @NorthWest int; --array reference previous left
    DECLARE @North int; --array reference previous
    DECLARE @Max int; --holds the maximum of two values
    DECLARE @Current int; --current number of matches
    DECLARE @Matrix nvarchar(max);
    DECLARE @PreviousRow nvarchar(2000); -- the previous matrix row
    DECLARE @JSON nvarchar(4000); --json work variable
    DECLARE @Numbers TABLE (jj int);
-- SQL Prompt formatting off

INSERT INTO @Numbers(jj) --this is designed for words of max 40 characters
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),
      (16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),
      (29),(30),(31),(32),(33),(34),(35),(36),(37),(38),(39),(40)
-- SQL Prompt formatting on
--the to start with, the first row is all zeros.
    SELECT @PreviousRow =
      N'[' + Replicate('0,', Len(@xString) + 1) + N'"'
      + Substring(@yString, 1, 1) + N'"]';
    SELECT @Matrix = @PreviousRow;--add this to the matrix
    /* we now build the matrix in bottom up fashion.  */
    WHILE (@ii <= Len(@yString))
      BEGIN
        SELECT @West = 0, @JSON = NULL;
        --now create a row in just one query
        SELECT @NorthWest =
          Json_Value(@PreviousRow, '$[' + Cast(jj - 1 AS varchar(5)) + ']'),
          @North =
            Json_Value(@PreviousRow, '$[' + Cast(jj AS varchar(5)) + ']'),
          @Max = CASE WHEN @West > @North THEN @West ELSE @North END,
          @Current =
            CASE WHEN Substring(@xString, jj, 1) = Substring(@yString, @ii, 1) THEN
                   @NorthWest + 1 ELSE @Max END,
          @JSON =
            Coalesce(@JSON + ',', '[0,')
            + Coalesce(Cast(@Current AS varchar(5)), 'null'), @West = @Current
          FROM @Numbers AS f
          WHERE f.jj <= Len(@xString);
          --and store the result as the previous row
        SELECT @PreviousRow =
               @JSON + N',"' + Substring(@yString, @ii, 1) + N'"]';
          --and add the reow to the matrix
        SELECT @Matrix = Coalesce(@Matrix + ',
               ', '') + @PreviousRow, @ii = @ii + 1;
      END;
    --we add the boundong brackets.
    SELECT @Matrix = N'[' + @Matrix + N']';
    SELECT @ii = Len(@yString), @jj = Len(@xString);
    DECLARE @previousColScore INT, @PreviousRowScore INT, @Ychar NCHAR;
    DECLARE @Subsequence NVARCHAR(4000) = '';
    WHILE (@Current > 0)
      BEGIN
        SELECT @Ychar = Substring(@yString, @ii, 1);
        IF (@Ychar = Substring(@xString, @jj, 1))
-- If current character in X[] and Y[] are same, then it is part of LCS
          SELECT @ii = @ii - 1, @jj = @jj - 1,
            @Subsequence = @Ychar + @Subsequence, @Current = @Current - 1;
        ELSE
--If not same, then find the larger of two and traverse in that direction 
          BEGIN
            --find out the two scores, one to the north and one to the west
            SELECT @PreviousRowScore =
              Json_Value(
                          @Matrix,
                          'strict $[' + Convert(varchar(5), @ii - 1) + ']['
                          + Convert(varchar(5), @jj) + ']'
                        ),
              @previousColScore =
                Json_Value(
                            @Matrix,
                            'strict $[' + Convert(varchar(5), @ii) + ']['
                            + Convert(varchar(5), @jj - 1) + ']'
                          );
           --either go north or west
            IF @PreviousRowScore < @previousColScore SELECT @jj = @jj - 1;
            ELSE SELECT @ii = @ii - 1;
          END;
      END;
    RETURN @Subsequence;
  END;
GO
