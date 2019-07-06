CREATE FUNCTION dbo.udf_StringComparisonsLevenshteinFullMatrix(
    @FirstString  nvarchar(255)
  , @SecondString nvarchar(255)
)
RETURNS int
AS BEGIN
DECLARE @PseudoMatrix table 
     (location int identity primary key, 
      FirstOrder int not null, 
      Firstch nchar(1), 
      SecondOrder int not null, 
      Secondch nchar(1), 
      TheValue int not null default 0,
      PreviousRowValues varchar(200)
      );
 
INSERT INTO @PseudoMatrix (FirstOrder, Firstch, SecondOrder, Secondch, TheValue)
SELECT TheFirst.number,TheFirst.ch, TheSecond.number,TheSecond.ch,0
  FROM --divide up the first string into a table of characters/sequence
   (SELECT number, SUBSTRING(@FirstString,number,1) AS ch
    FROM Numbers WHERE number <= LEN(@FirstString) union all Select 0,Char(0)) TheFirst 
  cross JOIN --divide up the second string into a table of characters/sequence
   (SELECT number, SUBSTRING(@SecondString,number,1) AS ch
    FROM Numbers WHERE number <= LEN(@SecondString) union all Select 0,Char(0)) TheSecond
  --ON Thefirst.ch= Thesecond.ch --do all valid matches
order by TheFirst.number, TheSecond.number 
 
DECLARE @current  varchar(255);
DECLARE @previous varchar(255);
DECLARE @TheValue int;
DECLARE @deletion int, @insertion int, @substitution int, @minim int;

SELECT @current='', @previous=''
UPDATE @PseudoMatrix
    SET
    @deletion = @TheValue + 1,
    @insertion = ASCII(SUBSTRING(@previous,SecondOrder+1,1))+1,
    @substitution = ASCII(SUBSTRING(@previous,(SecondOrder),1)) +1,
    @minim=case when @deletion < @insertion then @deletion else @insertion end,
    @TheValue = TheValue = case
                         when SecondOrder = 0 then FirstOrder
                         When FirstOrder = 0 then SecondOrder
                 when Firstch = Secondch then ascii(substring(@previous,(SecondOrder),1))
                 else case when @minim < @substitution then @minim ELSE @substitution end
               end,
    @previous = PreviousRowValues=case when SecondOrder =0 then @current else @previous end,
    @current= case when SecondOrder =0 then char(@TheValue) else @current+char(@TheValue) end
return @TheValue
END;
GO
