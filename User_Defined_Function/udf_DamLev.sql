-- =============================================
-- Computes and returns the Damerau-Levenshtein edit distance between two strings, 
-- i.e. the number of insertion, deletion, substitution, and transposition edits
-- required to transform one string to the other.  This value will be >= 0, where
-- 0 indicates identical strings. Comparisons use the case-sensitivity configured
-- in SQL Server (case-insensitive by default). This algorithm is basically the
-- Levenshtein algorithm with a modification that considers transposition of two
-- adjacent characters as a single edit.
-- http://blog.softwx.net/2015/01/optimizing-damerau-levenshtein_19.html
-- See http://en.wikipedia.org/wiki/Damerau%E2%80%93Levenshtein_distance
-- Note that this uses Sten Hjelmqvist's "Fast, memory efficient" algorithm, described
-- at http://www.codeproject.com/Articles/13525/Fast-memory-efficient-Levenshtein-algorithm.
-- This version differs by including some optimizations, and extending it to the Damerau-
-- Levenshtein algorithm.
-- Note that this is the simpler and faster optimal string alignment (aka restricted edit) distance
-- that difers slightly from the full Damerau-Levenshtein algorithm by imposing the restriction
-- that no substring is edited more than once. So for example, "CA" to "ABC" has an edit distance
-- of 2 by a complete application of Damerau-Levenshtein, but a distance of 3 by this method that
-- uses the optimal string alignment algorithm. See wikipedia article for more detail on this
-- distinction.
-- 
-- @s - String being compared for distance.
-- @t - String being compared against other string.
-- @max - Maximum distance allowed, or NULL if no maximum is desired. Returns NULL if distance will exceed @max.
-- returns int edit distance, >= 0 representing the number of edits required to transform one string to the other.
-- =============================================
 
CREATE FUNCTION [dbo].[DamLev](
 
    @s nvarchar(4000)
  , @t nvarchar(4000)
  , @max int
)
RETURNS int
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @distance int = 0 -- return variable
          , @v0 nvarchar(4000)-- running scratchpad for storing computed distances
          , @v2 nvarchar(4000)-- running scratchpad for storing previous column's computed distances
          , @start int = 1      -- index (1 based) of first non-matching character between the two string
          , @i int, @j int      -- loop counters: i for s string and j for t string
          , @diag int          -- distance in cell diagonally above and left if we were using an m by n matrix
          , @left int          -- distance in cell to the left if we were using an m by n matrix
          , @nextTransCost int-- transposition base cost for next iteration 
          , @thisTransCost int-- transposition base cost (2 distant along diagonal) for current iteration
          , @sChar nchar      -- character at index i from s string
          , @tChar nchar      -- character at index j from t string
          , @thisJ int          -- temporary storage of @j to allow SELECT combining
          , @jOffset int      -- offset used to calculate starting value for j loop
          , @jEnd int          -- ending value for j loop (stopping point for processing a column)
          -- get input string lengths including any trailing spaces (which SQL Server would otherwise ignore)
          , @sLen int = datalength(@s) / datalength(left(left(@s, 1) + '.', 1))    -- length of smaller string
          , @tLen int = datalength(@t) / datalength(left(left(@t, 1) + '.', 1))    -- length of larger string
          , @lenDiff int      -- difference in length between the two strings
    -- if strings of different lengths, ensure shorter string is in s. This can result in a little
    -- faster speed by spending more time spinning just the inner loop during the main processing.
    IF (@sLen > @tLen) BEGIN
        SELECT @v0 = @s, @i = @sLen -- temporarily use v0 for swap
        SELECT @s = @t, @sLen = @tLen
        SELECT @t = @v0, @tLen = @i
    END
    SELECT @max = ISNULL(@max, @tLen)
         , @lenDiff = @tLen - @sLen
    IF @lenDiff > @max RETURN NULL
 
    -- suffix common to both strings can be ignored
    WHILE(@sLen > 0 AND SUBSTRING(@s, @sLen, 1) = SUBSTRING(@t, @tLen, 1))
        SELECT @sLen = @sLen - 1, @tLen = @tLen - 1
 
    IF (@sLen = 0) RETURN @tLen
 
    -- prefix common to both strings can be ignored
    WHILE (@start < @sLen AND SUBSTRING(@s, @start, 1) = SUBSTRING(@t, @start, 1)) 
        SELECT @start = @start + 1
    IF (@start > 1) BEGIN
        SELECT @sLen = @sLen - (@start - 1)
             , @tLen = @tLen - (@start - 1)
 
        -- if all of shorter string matches prefix and/or suffix of longer string, then
        -- edit distance is just the delete of additional characters present in longer string
        IF (@sLen <= 0) RETURN @tLen
 
        SELECT @s = SUBSTRING(@s, @start, @sLen)
             , @t = SUBSTRING(@t, @start, @tLen)
    END
 
    -- initialize v0 array of distances
    SELECT @v0 = '', @j = 1
    WHILE (@j <= @tLen) BEGIN
        SELECT @v0 = @v0 + NCHAR(CASE WHEN @j > @max THEN @max ELSE @j END)
        SELECT @j = @j + 1
    END
     
    SELECT @v2 = @v0 -- copy...doesn't matter what's in v2, just need to initialize its size
         , @jOffset = @max - @lenDiff
         , @i = 1
    WHILE (@i <= @sLen) BEGIN
        SELECT @distance = @i
             , @diag = @i - 1
             , @sChar = SUBSTRING(@s, @i, 1)
             -- no need to look beyond window of upper left diagonal (@i) + @max cells
             -- and the lower right diagonal (@i - @lenDiff) - @max cells
             , @j = CASE WHEN @i <= @jOffset THEN 1 ELSE @i - @jOffset END
             , @jEnd = CASE WHEN @i + @max >= @tLen THEN @tLen ELSE @i + @max END
             , @thisTransCost = 0
        WHILE (@j <= @jEnd) BEGIN
            -- at this point, @distance holds the previous value (the cell above if we were using an m by n matrix)
            SELECT @nextTransCost = UNICODE(SUBSTRING(@v2, @j, 1))
                 , @v2 = STUFF(@v2, @j, 1, NCHAR(@diag))
                 , @tChar = SUBSTRING(@t, @j, 1)
                 , @left = UNICODE(SUBSTRING(@v0, @j, 1))
                 , @thisJ = @j
            SELECT @distance = CASE WHEN @diag < @left AND @diag < @distance THEN @diag    --substitution
                                    WHEN @left < @distance THEN @left                    -- insertion
                                    ELSE @distance                                        -- deletion
                                END
            SELECT @distance = CASE WHEN (@sChar = @tChar) THEN @diag    -- no change (characters match)
                                    WHEN @i <> 1 AND @j <> 1
                                        AND @tChar = SUBSTRING(@s, @i - 1, 1)
                                        AND @thisTransCost < @distance
                                        AND @sChar = SUBSTRING(@t, @j - 1, 1)
                                        THEN 1 + @thisTransCost        -- transposition
                                    ELSE 1 + @distance END
            SELECT @v0 = STUFF(@v0, @thisJ, 1, NCHAR(@distance))
                 , @diag = @left
                 , @thisTransCost = @nextTransCost
                 , @j = case when (@distance > @max) AND (@thisJ = @i + @lenDiff) then @jEnd + 2 else @thisJ + 1 end
        END
        SELECT @i = CASE WHEN @j > @jEnd + 1 THEN @sLen + 1 ELSE @i + 1 END
    END
    RETURN CASE WHEN @distance <= @max THEN @distance ELSE NULL END
END