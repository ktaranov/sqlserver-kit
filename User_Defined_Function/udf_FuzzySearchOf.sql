IF OBJECT_ID (N'dbo.FuzzySearchOf') IS NOT NULL
     DROP FUNCTION dbo.FuzzySearchOf
  GO
  CREATE FUNCTION dbo.FuzzySearchOf(@Searchterm VARCHAR(40))
  /**
  summary:  >
  Returns all candidate words even if the input word is misspelt
  Author: Phil Factor
  Revision: 1.0
  date: 16/02/2017
  example:
  Select * from dbo.FuzzySearchOf('sossyjez')
  Select * from dbo.FuzzySearchOf('acheeve')
  Select * from dbo.FuzzySearchOf('deevyate')--does a 
  returns:  >
   a table containing words
  Dependency: 
  Words: A table of common words
  DamLev http://blog.softwx.net/2015/01/optimizing-damerau-levenshtein_19.html
  dbo.OneEditDifferenceTo(@word)
  dbo.metaphone(@searchterm)
  **/
  RETURNS @candidates TABLE(Candidate VARCHAR(40))
  AS
    -- body of the function
    BEGIN
    DECLARE @Rowcount INT;
    /* The first stage is to see if a word is an alias or a known misspelling.*/
    INSERT INTO @candidates  (Candidate)
      SELECT COALESCE(words.CanonicalVersion, words.word)  FROM dbo.words
        WHERE words.word = @Searchterm;
    -- If not a known word or an alias, then has it an edit-distance of one to any canonical words 
    -- IN the 'Words' table
    IF @@RowCount = 0
      BEGIN
      INSERT INTO @candidates  (Candidate)
        SELECT OneEditDifferenceTo.Candidate FROM dbo.OneEditDifferenceTo(@Searchterm);
      IF @@RowCount = 0
        BEGIN --If not then does it share a metaphone with any words in your table?
        INSERT INTO @candidates  (Candidate)
          SELECT COALESCE(words.CanonicalVersion, words.word) AS candidate
          FROM dbo.words  WHERE words.Metaphone = dbo.Metaphone(@Searchterm);
        SELECT @Rowcount = @@RowCount;
        IF @Rowcount > 5 --If yes, and there are too many, then get what there are and 
          BEGIN --take the top few in ascending edit difference.
          DELETE FROM @candidates;
          INSERT INTO @candidates (Candidate)
            SELECT TOP 5 COALESCE(words.CanonicalVersion, words.word) AS candidate
            FROM dbo.words  WHERE words.Metaphone = dbo.Metaphone(@Searchterm)
            ORDER BY COALESCE(dbo.DamLev(words.word, @Searchterm, 3), 4); --just do three levels
          END;
        IF @Rowcount = 0
          BEGIN
          /* Get a limited number of words with an edit distance of two, using Steve Hatchett’s 
  		version  of the Damerau-Levenshtein Algorithm, specifying that it abandons its work 
  		on a particular word once it realises that it is more than two edit distances away*/
          INSERT INTO @candidates (Candidate)
            SELECT TOP 5 words.word
            FROM dbo.words  WHERE words.CanonicalVersion IS NULL
  			AND word LIKE LEFT(@Searchterm,1)+'%'
              AND COALESCE(dbo.DamLev(words.word, @Searchterm, 2), 3) < 3;
          END;
        END;
      END;
    RETURN;
    END;
  GO