/* This will need a NUMBERS table, stocked with numbers.
If you haven't got one this will create it automatically */
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Numbers')
  BEGIN
    CREATE TABLE dbo.Numbers(
         [number] [int],
         CONSTRAINT [Index_Numbers] PRIMARY KEY CLUSTERED ([number] ASC)
            ON [PRIMARY]
        )
    ON [PRIMARY]
  END
IF NOT EXISTS(SELECT 1 FROM Numbers WHERE number = 99999)
BEGIN
TRUNCATE TABLE Numbers
    ;WITH Digits(i) AS
      (SELECT i
       FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0)) AS X(i))
     INSERT INTO Numbers(number)
       SELECT (D6.i*1000000 +D5.i*100000 + D4.i*10000 + D3.i * 1000 + D2.i * 100 
                   + D1.i * 10 + D0.i + 1) AS seq
        FROM Digits AS D0, Digits AS D1, Digits AS D2, Digits AS D3, 
           Digits AS D4, Digits AS D5, Digits AS D6
    END;


IF OBJECT_ID(N'dbo.udf_LongestCommonSubstring', N'TF') IS NULL
   EXEC (N'CREATE FUNCTION dbo.udf_LongestCommonSubstring() RETURNS @hit TABLE (
            MatchLength       INT,--the length of the match. Not necessarily the length of input
            FirstCharInMatch  INT,--first character of match in first string
            FirstCharInString INT,--first character of match in second string
            CommonString      VARCHAR(8000) --the part of the FirstString successfully matched
            ) AS BEGIN RETURN END;');
GO

ALTER FUNCTION dbo.udf_LongestCommonSubstring
/**
summary:   >
 The longest common subSubstring (LCS) tells you the longest common substring between two strings.
     If you, for example, were to compare 'And the Dish ran away with the Spoon' with 'away', you'd 
     get 'away' as being the string in common. Likewise, comparing '465932859472109683472' with 
     '697834859472135348' would give you  '8594721'. This returns a one-row table that gives you the 
     length and location of the string as well as the string itself. It can easily be modified to give
      you all the substrings (whatever your criteria for the smallest substring. E.g. two characters? 

Author: Phil Factor
Revision: 1.1
Created Date: 2014-12-05
Modified date: 2019-07-08 Konstantin Taranov
Original link: https://www.red-gate.com/simple-talk/blogs/string-comparisons-in-sql-the-longest-common-substring/
example:
code:
     SELECT * FROM dbo.udf_LongestCommonSubstring ('1234', '1224533324');
     SELECT * FROM dbo.udf_LongestCommonSubstring ('thisisatest', 'testing123testing');
     SELECT * FROM dbo.udf_LongestCommonSubstring ( 'findthishere', 'where is this?');
     SELECT * FROM dbo.udf_LongestCommonSubstring ( NULL, 'xab');
     SELECT * FROM dbo.udf_LongestCommonSubstring ( 'not beginning-middle-ending', 'beginning-diddle-dum-ending');
returns:   >
  the longest common subString as a string
**/
(
@FirstString  VARCHAR(MAX),
@SecondString VARCHAR(MAX)
)
/* returns a single row table
it is easy to change to return a string but I wanted the location of the match */
RETURNS @hit TABLE (
            MatchLength       INT,--the length of the match. Not necessarily the length of input
            FirstCharInMatch  INT,--first character of match in first string
            FirstCharInString INT,--first character of match in second string
            CommonString      VARCHAR(8000) --the part of the FirstString successfully matched
            )
AS
BEGIN
    DECLARE @order      INT;
    DECLARE @theGroup   INT;
    DECLARE @sequential INT;
    /* this table is used to do a quirky update to enable a grouping only on sequential characters */
    DECLARE @Scratch TABLE (TheRightOrder INT IDENTITY PRIMARY KEY,TheGroup smallint, Sequential INT,
            FirstOrder smallint, SecondOrder smallint, ch CHAR(1));

    --first we reduce the amount of data to those characters in the first string that have a match 
    --in the second, and where they were.       
    INSERT INTO @Scratch ( TheGroup , FirstOrder, SecondOrder, ch)
       SELECT TheFirst.number - TheSecond.number AS TheGroup
            , TheFirst.number
            , TheSecond.number
            , TheSecond.ch
       FROM /* divide up the first string into a table of characters/sequence */
        (SELECT number, SUBSTRING(@FirstString,number,1) AS ch
           FROM Numbers WHERE number <= LEN(@FirstString)) TheFirst
       INNER JOIN --divide up the second string into a table of characters/sequence
        (SELECT number, SUBSTRING(@SecondString,number,1) AS ch
           FROM Numbers WHERE number <= LEN(@SecondString))  TheSecond
       ON TheFirst.ch= TheSecond.ch --do all valid matches
       ORDER BY TheFirst.number-TheSecond.number, TheSecond.number
    --now @scratch has all matches in the correct order for checking unbroken sequence
    SELECT @order=-1, @theGroup=-1, @sequential=0 --initialise everything
    UPDATE @Scratch --now check by incrementing a value every time a sequence is broken
      SET @sequential = Sequential = 
             CASE --if it is not a sequence from the one before increment the variable
               WHEN SecondOrder = @order+1 AND TheGroup=@theGroup
               THEN @sequential ELSE @sequential + 1 END,
       @order=SecondOrder, 
       @theGroup=TheGroup
    --now we just aggregate it, and choose the first longest match. Easy   
    INSERT INTO @hit (MatchLength,FirstCharInMatch, FirstCharInString,CommonString)
    SELECT TOP(1) ---just the first. You may want more so feel free to change
        COUNT(*)         AS MatchLength,
        MIN(FirstOrder)  AS FirstCharInMatch,
        MIN(SecondOrder) AS FirstCharInString,
        SUBSTRING(@SecondString, MIN(SecondOrder), COUNT(*)) AS CommonString
      FROM @Scratch
      GROUP BY TheGroup, Sequential
      ORDER BY COUNT(*) DESC, MIN(FirstOrder) ASC, MIN(SecondOrder) ASC;
RETURN;
END
GO
