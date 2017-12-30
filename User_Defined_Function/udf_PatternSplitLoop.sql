-- PatternSplitLoop will split a string based on a pattern of the form 
-- supported by LIKE and PATINDEX 
-- 
-- Created by: Dwain Camps 11-Oct-2012 
CREATE FUNCTION [dbo].[udf_PatternSplitLoop]
 (  @String    VARCHAR(400)
   ,@Pattern   VARCHAR(500)
  ) RETURNS 
  @Results TABLE ( ItemNumber  INT
                  ,Item        VARCHAR(400)
                  ,[Matched]   INT)
   WITH SCHEMABINDING 
AS 
BEGIN;

-- DECLARE a couple of variables we'll need in our loop
DECLARE 
  @ItemNumber  INT = 0 
, @Remaining   VARCHAR(400) = ISNULL(@String, '')
-- Create the "not pattern" 
, @NotPattern  VARCHAR(500) = REPLACE(REPLACE(@Pattern, '[', '[^'), '^^', '')
, @Matched     INT

IF @String IS NULL OR @Pattern IS NULL 
  INSERT INTO @Results SELECT NULL, NULL, NULL

WHILE DATALENGTH(@Remaining) > 0     
 BEGIN
   SELECT @ItemNumber = @ItemNumber + 1
   -- The item returned from the cascaded CROSS APPLY b below
          ,@String = CASE
            -- When a+b = 1, then either a=1 and b=0 (the pattern was found but not pattern
            -- was not found) or a=0 and b=1 (the not pattern was found but pattern was
            -- not found).
            -- This means that no meaninful patterns are found in what remains so we’re done.
               WHEN a+b = 1 THEN @Remaining
            -- This case returns the chunk up to the start of the next pattern/not pattern
               WHEN (a=1 AND b>0) OR (b=1 AND a>0)                                  THEN SUBSTRING(@Remaining, 1, CASE a
                                  WHEN 1 THEN b 
                                  ELSE a 
                                 END - 1)
               ELSE @Remaining                            
                END 
           ,@Matched=CASE a WHEN 1 THEN 1 ELSE 0 END                    FROM (
       -- Find the next occurrence of the Pattern and the NotPattern
        SELECT PATINDEX(@Pattern, @Remaining)
             , PATINDEX(@NotPattern, @Remaining)
           ) a(a, b)

       -- Now that we have our ItemNumber and Item (in @String) INSERT them into our results
       INSERT INTO @Results SELECT @ItemNumber, @String, @Matched

        -- Find the remaining characters in the string
        SELECT @Remaining = CASE
                         WHEN DATALENGTH(@Remaining) = DATALENGTH(@String) THEN ''
                         ELSE SUBSTRING(@Remaining, DATALENGTH(@String)+1, DATALENGTH(@Remaining))
         END
 END

RETURN
END
