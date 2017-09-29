IF  OBJECT_ID('dbo.Metaphone','FN') IS NOT NULL --drop any existing metaphone function
   DROP FUNCTION dbo.Metaphone
go
CREATE FUNCTION dbo.Metaphone
/**
summary:   >
The Metaphone  phonetic algorithm was devised by Lawrence Philips in 1990.
It reduces words to their basic sounds, but produces a more accurate encoding,
than Soundex for matching words that sound similar. 
Metaphone is a built-in operator in a number of systems such as PHP but there
seemed to be no available SQL Version until I wrote this. It is merely
a reverse engineering of the original published algorithm but tweaked to ensure
that it gave the same result as the PHP version.
Author: Phil Factor
Revision: 1.0
date: 21 Jan 2017
example: >
    Select dbo.Metaphone ('opportunities')
    --OPRTNTS
Parameters: 
    -- @String (a word -all punctuation will be stripped out)
  A string representing the Metaphone equivalent of the word. 
**/  
(
    @String VARCHAR(30)
)
RETURNS VARCHAR(10)
AS
BEGIN
DECLARE  @New BIT, @ii INT, @Metaphone VARCHAR(28), @Len INT, @where INT;
DECLARE @This CHAR, @Next CHAR, @Following CHAR, @Previous CHAR, @silent BIT;
 
SELECT @String = UPPER(LTRIM(COALESCE(@String, ''))); --trim and upper case
SELECT @where= PATINDEX ('%[^A-Z]%',@String COLLATE Latin1_General_CI_AI ) 
WHILE  @where>0 --strip out all non-alphabetic characters!(Edited. Thanks Ros Presser) 
    BEGIN
    SELECT @String=STUFF(@string,@where,1,'')
    SELECT @where=PATINDEX ('%[^A-Z]%',@String COLLATE Latin1_General_CI_AI ) 
    END
IF(LEN(@String) < 2) RETURN  @String
 
--do the start of string stuff first.
--If the word begins with 'KN', 'GN', 'PN', 'AE', 'WR', drop the first letter.
-- "Aebersold", "Gnagy", "Knuth", "Pniewski", "Wright"
IF SUBSTRING(@String, 1, 2) IN ( 'KN', 'GN', 'PN', 'AE', 'WR' )
  SELECT @String = STUFF(@String, 1, 1, '');
-- Beginning of word: "x" change to "s" as in "Deng Xiaopeng"
IF SUBSTRING(@String, 1, 1) = 'X'
  SELECT @String = STUFF(@String, 1, 1, 'S');
-- Beginning of word: "wh-" change to "w" as in "Whatsoever"
IF @String LIKE 'WH%'
  SELECT @String = STUFF(@String, 1, 1, 'W');
-- Set up for While loop 
SELECT @Len = LEN(@String), @Metaphone = '', -- Initialize the main variable 
  @New = 1, -- this variable only used next 10 lines!!! 
  @ii = 1; --Position counter
--
WHILE((LEN(@Metaphone) <= 8) AND (@ii <= @Len))
  BEGIN --SET up the 'pointers' for this loop-around }
  SELECT @Previous =
    CASE WHEN @ii > 1 THEN SUBSTRING(@String, @ii - 1, 1) ELSE '' END,
    -- originally a nul terminated string }
    @This = SUBSTRING(@String, @ii, 1),
    @Next =
      CASE WHEN @ii < @Len THEN SUBSTRING(@String, @ii + 1, 1) ELSE '' END,
    @Following =
      CASE WHEN((@ii + 1) < @Len) THEN SUBSTRING(@String, @ii + 2, 1) ELSE
                                                                        '' END
   -- 'CC' inside word 
  --SELECT @Previous,@this,@Next,@Following,@New,@ii,@Len,@Metaphone
  /* Drop duplicate adjacent letters, except for C.*/
  IF @This=@Previous AND @This<> 'C' 
    BEGIN
    --we do nothing 
    SELECT @New=0
    END
  /*Drop all vowels unless it is the beginning.*/
  ELSE IF @This IN ( 'A', 'E', 'I', 'O', 'U' )
    BEGIN
    IF @ii = 1 --vowel at the beginning
      SELECT @Metaphone = @This;
    /* B -> B unless at the end of word after "m", as in "dumb", "Comb" */
    END;
  ELSE IF @This = 'B' AND NOT ((@ii = @Len) AND (@Previous = 'M'))
         BEGIN
         SELECT @Metaphone = @Metaphone + 'B';
         END;
         -- -mb is silent 
 /*'C' transforms to 'X' if followed by 'IA' or 'H' (unless in latter case, it is part of '-SCH-',
 in which case it transforms to 'K'). 'C' transforms to 'S' if followed by 'I', 'E', or 'Y'. 
 Otherwise, 'C' transforms to 'K'.*/
  ELSE IF @This = 'C'
         BEGIN -- -sce, i, y = silent 
         IF NOT (@Previous= 'S') AND (@Next IN ( 'H', 'E', 'I', 'Y' )) --front vowel set 
           BEGIN
               IF(@Next = 'I') AND (@Following = 'A')
                 SELECT @Metaphone = @Metaphone + 'X'; -- -cia- 
               ELSE IF(@Next IN ( 'E', 'I', 'Y' ))
                 SELECT @Metaphone = @Metaphone + 'S'; -- -ce, i, y = 'S' }
               ELSE IF(@Next = 'H') AND (@Previous = 'S')
                 SELECT @Metaphone = @Metaphone + 'K'; -- -sch- = 'K' }
               ELSE IF(@Next = 'H')
                 BEGIN
                   IF(@ii = 1) AND ((@ii + 2) <= @Len) 
                     AND NOT(@Following IN ( 'A', 'E', 'I', 'O', 'U' ))
                       SELECT @Metaphone = @Metaphone + 'K';
                   ELSE
                     SELECT @Metaphone = @Metaphone + 'X';
                   END
           End  
         ELSE 
           SELECT @Metaphone = @Metaphone +CASE WHEN @Previous= 'S' THEN '' else 'K' end;
               -- Else silent 
         END; -- Case C }
  /*'D' transforms to 'J' if followed by 'GE', 'GY', or 'GI'. Otherwise, 'D' 
  transforms to 'T'.*/
  ELSE IF @This = 'D'
         BEGIN
         SELECT @Metaphone = @Metaphone
           + CASE WHEN(@Next = 'G') AND (@Following IN ( 'E', 'I', 'Y' )) --front vowel set 
                 THEN 'J' ELSE 'T' END;
         END;
  ELSE IF @This = 'G'
         /*Drop 'G' if followed by 'H' and 'H' is not at the end or before a vowel. Drop 'G' 
 if followed by 'N' or 'NED' and is at the end.
 'G' transforms to 'J' if before 'I', 'E', or 'Y', and it is not in 'GG'. 
 Otherwise, 'G' transforms to 'K'.*/
    BEGIN
  SELECT @silent = 
    CASE WHEN (@Next = 'H') AND (@Following IN ('A','E','I','O','U'))
    AND (@ii > 1) AND (((@ii+1) = @Len) OR ((@Next = 'n') AND
    (@Following = 'E') AND SUBSTRING(@String,@ii+3,1) = 'D') AND ((@ii+3) = @Len)) 
-- Terminal -gned 
  AND (@Previous = 'i') AND (@Next = 'n')
  THEN 1 
 -- if not start and near -end or -gned.) 
  WHEN (@ii > 1) AND (@Previous = 'D')-- gnuw
    AND (@Next IN ('E','I','Y')) --front vowel set 
  THEN 1 -- -dge, i, y 
  ELSE 0 END
  IF NOT (@silent=1)
    SELECT @Metaphone = @Metaphone 
    + CASE WHEN (@Next IN ('E','I','Y')) --front vowel set 
      THEN  'J' ELSE  'K' END
  END
  /*Drop 'H' if after vowel and not before a vowel.
  or the second char of  "-ch-", "-sh-", "-ph-", "-th-", "-gh-"*/
 
  ELSE IF @This = 'H'
    BEGIN
    IF NOT ( (@ii= @Len) OR (@Previous IN  ( 'C', 'S', 'T', 'G' ))) 
       AND (@Next IN ( 'A', 'E', 'I', 'O', 'U' ) )
     SELECT @Metaphone = @Metaphone + 'H';
         -- else silent (vowel follows) }
    END;
  ELSE IF @This IN --some get no substitution
       ( 'F', 'J', 'L', 'M', 'N', 'R' )
     BEGIN
     SELECT @Metaphone = @Metaphone + @This;
     END;
  /*'CK' transforms to 'K'.*/
  ELSE IF @This = 'K'
     BEGIN
     IF(@Previous <> 'C')
       SELECT @Metaphone = @Metaphone + 'K';
     END;
  /*'PH' transforms to 'F'.*/
  ELSE IF @This = 'P'
    BEGIN
      IF(@Next = 'H') SELECT @Metaphone = @Metaphone + 'F', @ii = @ii + 1;
      -- Skip the 'H' 
      ELSE
        SELECT @Metaphone = @Metaphone + 'P';
      END;
  /*'Q' transforms to 'K'.*/
  ELSE IF @This = 'Q'
    BEGIN
      SELECT @Metaphone = @Metaphone + 'K';
    END;
  /*'S' transforms to 'X' if followed by 'H', 'IO', or 'IA'.*/
  ELSE IF @This = 'S'
    BEGIN
    SELECT @Metaphone = @Metaphone + 
      CASE 
        WHEN(@Next = 'H')
         OR( (@ii> 1) AND (@Next = 'i') 
          AND (@Following IN ( 'O', 'A' ) )
          ) 
        THEN 'X' ELSE 'S' END;
     END;
  /*'T' transforms to 'X' if followed by 'IA' or 'IO'. 'TH' transforms 
to '0'. Drop 'T' if followed by 'CH'.*/
  ELSE IF @This = 'T'
    BEGIN
    SELECT @Metaphone = @Metaphone
      + CASE 
        WHEN(@ii = 1) AND (@Next = 'H') AND (@Following = 'O') 
           THEN 'T' -- Initial Tho- }
        WHEN(@ii > 1) AND (@Next = 'i') 
             AND (@Following IN ( 'O', 'A' )) 
          THEN 'X'
        WHEN(@Next = 'H') THEN '0'
        WHEN NOT((@Next = 'C') AND (@Following = 'H')) 
          THEN 'T'
        ELSE '' END;
         -- -tch = silent }
    END;
  /*'V' transforms to 'F'.*/
  ELSE IF @This = 'V'
    BEGIN
    SELECT @Metaphone = @Metaphone + 'F';
    END;
  /*'WH' transforms to 'W' if at the beginning. Drop 'W' if not followed by a vowel.*/
  /*Drop 'Y' if not followed by a vowel.*/
  ELSE IF @This IN ( 'W', 'Y' )
    BEGIN
    IF @Next IN ( 'A', 'E', 'I', 'O', 'U' )
      SELECT @Metaphone = @Metaphone + @This;
     --else silent 
     /*'X' transforms to 'S' if at the beginning. Otherwise, 'X' transforms to 'KS'.*/
    END;
  ELSE IF @This = 'X'
    BEGIN
      SELECT @Metaphone = @Metaphone + 'KS';
    END;
  /*'Z' transforms to 'S'.*/
  ELSE IF @This = 'Z'
     BEGIN
       SELECT @Metaphone = @Metaphone + 'S';
     END;
  ELSE
  RETURN 'error with '''+ @This+ '''';
  -- end
  SELECT @ii = @ii + 1;
  END; -- While 
return @Metaphone 
END
GO

/*
Check against the PHP implementation*/
SELECT * FROM 
(SELECT dbo.Metaphone ('craven') AS Attempt,'craven' AS original ,'KRFN' AS canonical
UNION ALL SELECT dbo.Metaphone ('platitudinous'),'platitudinous','PLTTTNS'
UNION ALL SELECT dbo.Metaphone ('woodcarvings'),'woodcarvings','WTKRFNKS'
UNION ALL SELECT dbo.Metaphone ('overlaid'),'overlaid','OFRLT'
UNION ALL SELECT dbo.Metaphone ('solitaries'),'solitaries','SLTRS'
UNION ALL SELECT dbo.Metaphone ('beatific'),'beatific', 'BTFK'
UNION ALL SELECT dbo.Metaphone ('plaza'),'plaza','PLS'
UNION ALL SELECT dbo.Metaphone ('paramilitary'),'paramilitary','PRMLTR'
UNION ALL SELECT dbo.Metaphone ('synod'),'synod','SNT'
UNION ALL SELECT dbo.Metaphone ('marinas'),'marinas','MRNS'
UNION ALL SELECT dbo.Metaphone ('hyperventilation'),'hyperventilation','PRFNTLXN'
UNION ALL SELECT dbo.Metaphone ('celebrant'),'celebrant','SLBRNT'
UNION ALL SELECT dbo.Metaphone ('pipsqueaks'),'pipsqueaks','PPSKKS'
UNION ALL SELECT dbo.Metaphone ('dazzles'),'dazzles', 'TSLS'
UNION ALL SELECT dbo.Metaphone ('bloodbaths'),'bloodbaths','BLTB0S'
UNION ALL SELECT dbo.Metaphone ('lotion'),'lotion','LXN'
UNION ALL SELECT dbo.Metaphone ('agreeable'),'agreeable','AKRBL'
UNION ALL SELECT dbo.Metaphone ('shariah'),'shariah','XR'
UNION ALL SELECT dbo.Metaphone ('direction'),'direction','TRKXN'
UNION ALL SELECT dbo.Metaphone ('constricts'),'constricts','KNSTRKTS'
UNION ALL SELECT dbo.Metaphone ('avowedly'),'avowedly','AFWTL'
UNION ALL SELECT dbo.Metaphone ('exorcisms'),'exorcisms','EKSRSSMS'
UNION ALL SELECT dbo.Metaphone ('starches'),'starches','STRXS'
UNION ALL SELECT dbo.Metaphone ('poses'),'poses','PSS'
UNION ALL SELECT dbo.Metaphone ('levies'),'levies','LFS'
UNION ALL SELECT dbo.Metaphone ('clicks'),'clicks','KLKS'
UNION ALL SELECT dbo.Metaphone ('minstrels'),'minstrels','MNSTRLS'
UNION ALL SELECT dbo.Metaphone ('propounding'),'propounding','PRPNTNK'
UNION ALL SELECT dbo.Metaphone ('opalescent'),'opalescent','OPLSNT'
UNION ALL SELECT dbo.Metaphone ('hotline'),'hotline','HTLN'
UNION ALL SELECT dbo.Metaphone ('soporifically'),'soporifically','SPRFKL'
UNION ALL SELECT dbo.Metaphone ('python'),'python','P0N'
UNION ALL SELECT dbo.Metaphone ('drab'),'drab','TRB'
UNION ALL SELECT dbo.Metaphone ('appraised'),'appraised','APRST'
UNION ALL SELECT dbo.Metaphone ('commotions'),'commotions','KMXNS'
UNION ALL SELECT dbo.Metaphone ('defeatists'),'defeatists','TFTSTS'
UNION ALL SELECT dbo.Metaphone ('dispensations'),'dispensations','TSPNSXNS'
UNION ALL SELECT dbo.Metaphone ('downfall'),'downfall','TNFL'
UNION ALL SELECT dbo.Metaphone ('naturalising'),'naturalising','NTRLSNK')k
WHERE attempt <> canonical
IF @@RowCount>0 RAISERROR( 'As you can see, there was a problem somewhere',16,1);
