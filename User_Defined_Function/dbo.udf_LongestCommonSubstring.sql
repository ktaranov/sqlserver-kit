--This will need a NUMBERS table, stocked with numbers. If you haven't got one
--this will create it automatically 
IF NOT EXISTS (SELECT 1 FROM information_Schema.Tables
  WHERE table_name='Numbers')
  BEGIN 
    CREATE TABLE [dbo].[Numbers]
        (
         [number] [int],
         CONSTRAINT [Index_Numbers] PRIMARY KEY CLUSTERED ([number] ASC)
            ON [PRIMARY]
        )
    ON  [PRIMARY] 
  END
IF NOT EXISTS(SELECT 1 FROM numbers WHERE number=99999)
BEGIN
TRUNCATE TABLE numbers
    ;WITH Digits(i) AS 
      (SELECT i
       FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (0)) AS X(i))
     INSERT INTO numbers(number)
       SELECT (D6.i*1000000 +D5.i*100000 + D4.i*10000 + D3.i * 1000 + D2.i * 100 
                   + D1.i * 10 + D0.i + 1) AS seq
        FROM Digits AS D0, Digits AS D1, Digits AS D2, Digits AS D3, 
           Digits AS D4, Digits AS D5, Digits AS D6
    END  
 
IF OBJECT_ID (N'LongestCommonSubstring') IS NOT NULL
   DROP FUNCTION LongestCommonSubstring
GO
 
CREATE FUNCTION LongestCommonSubstring
/**
summary:   >
 The longest common subSubstring (LCS) tells you the longest common substring between two strings.
	 If you, for example, were to compare 'And the Dish ran away with the Spoon' with 'away', you'd 
	 get 'away' as being the string in common. Likewise, comparing '465932859472109683472' with 
	 '697834859472135348' would give you  '8594721'. This returns a one-row table that gives you the 
	 length and location of the string as well as the string itself. It can easily be modified to give
	  you all the substrings (whatever your criteria for the smallest substring. E.g. two characters? 
 
Author: Phil Factor
Revision: 1.0
date: 05 Dec 2014
example:
code: |
     Select * from dbo.LongestCommonSubstring ('1234', '1224533324')
     Select * from dbo.LongestCommonSubstring ('thisisatest', 'testing123testing')
     Select * from dbo.LongestCommonSubstring ( 'findthishere', 'where is this?') 
     Select * from dbo.LongestCommonSubstring ( null, 'xab') 
     Select * from dbo.LongestCommonSubstring ( 'not beginning-middle-ending',
       'beginning-diddle-dum-ending')
returns:   >
  the longest common subString as a string
**/    
(
@firstString VARCHAR(MAX),
@SecondString VARCHAR(MAX)
)
RETURNS @hit TABLE --returns a single row table 
--(it is easy to change to return a string but I wanted the location of the match)
(
MatchLength INT,--the length of the match. Not necessarily the length of input 
FirstCharInMatch INT,--first character of match in first string
FirstCharInString INT,--first character of match in second string
CommonString VARCHAR(8000) --the part of the FirstString successfully matched
)
 
AS BEGIN
DECLARE @Order INT, @TheGroup INT, @Sequential INT
--this table is used to do a quirky update to enable a grouping only on sequential characters
DECLARE  @Scratch TABLE (TheRightOrder INT IDENTITY PRIMARY KEY,TheGroup smallint, Sequential INT,
        FirstOrder smallint, SecondOrder smallint, ch CHAR(1))
--first we reduce the amount of data to those characters in the first string that have a match 
--in the second, and where they were.       
INSERT INTO @Scratch ( TheGroup , firstorder,  secondorder, ch)
   SELECT Thefirst.number-TheSecond.number AS TheGroup,Thefirst.number, TheSecond.number, TheSecond.ch 
   FROM --divide up the first string into a table of characters/sequence
    (SELECT number, SUBSTRING(@FirstString,number,1) AS ch
       FROM numbers WHERE number <= LEN(@FirstString)) TheFirst 
   INNER JOIN --divide up the second string into a table of characters/sequence
    (SELECT number, SUBSTRING(@SecondString,number,1) AS ch
       FROM numbers WHERE number <= LEN(@SecondString))  TheSecond
   ON Thefirst.ch= Thesecond.ch --do all valid matches
   ORDER BY Thefirst.number-TheSecond.number, TheSecond.number
--now @scratch has all matches in the correct order for checking unbroken sequence   
SELECT @Order=-1, @TheGroup=-1, @Sequential=0 --initialise everything
UPDATE @Scratch --now check by incrementing a value every time a sequence is broken
  SET @Sequential=Sequential = 
         CASE --if it is not a sequence from the one before increment the variable
           WHEN secondorder=@order+1 AND TheGroup=@TheGroup 
           THEN @Sequential ELSE @Sequential+1 END,
   @Order=secondorder, 
   @TheGroup=TheGroup
--now we just aggregate it, and choose the first longest match. Easy   
INSERT INTO @hit (MatchLength,FirstCharInMatch, FirstCharInString,CommonString)
SELECT  TOP 1 ---just the first. You may want more so feel free to change
    COUNT(*) AS MatchLength, 
    MIN(firstorder) FirstCharInMatch,
    MIN(secondorder) AS FirstCharInString,
    SUBSTRING(@SecondString, 
    MIN(secondorder), 
    COUNT(*)) AS CommonString
  FROM @scratch GROUP BY TheGroup,Sequential 
  ORDER BY COUNT(*) DESC, MIN(firstOrder) ASC, MIN(SecondOrder) ASC
RETURN 
END--and we do a test run
 
go
 
--do an outer apply to check the obvious flaws and raise an error 
--if any erros appear.
IF EXISTS (
  SELECT firstString, secondString,correct, LCS.*
  FROM (VALUES 
   ('Call me Ishmael. Some years ago...','Something','Some' ),
   ('unrestfulness','having little or no money in my purse, and nothing particular to interest me on shore','rest' ),
   ('1234563457','3456','3456' ),
   ('','',NULL ),
   (NULL,'',NULL ),
   ('I find myself involuntarily pausing before coffin warehouses','Jailhouse rock','house'),
   (',.-=dfgd%','-=','-='),
      ('protest is useless','I need to test this routine. Tests are valuable','test' )
   ) 
   
   AS X(FirstString,secondString, Correct)
  OUTER APPLY dbo.LongestCommonSubstring(firstString, secondString) AS LCS
  WHERE COALESCE(correct,'null')<>COALESCE(LCS.CommonString,'null')
  )
    RAISERROR ('the LongestCommonSubstring routine has broken',16,1)   