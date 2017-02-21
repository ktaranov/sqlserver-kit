 	
alter FUNCTION LevenschteinDifference
(
@FirstString nVarchar(255), @SecondString nVarchar(255)
)
RETURNS int
as begin
Declare @PseudoMatrix table 
     (location int identity primary key, 
      firstorder int not null, 
      Firstch nchar(1), 
      secondorder int not null, 
      Secondch nchar(1), 
      Thevalue int not null default 0,
      PreviousRowValues varchar(200)
      )
 
insert into @PseudoMatrix (firstorder, firstch, secondorder, secondch, TheValue )
SELECT TheFirst.number,TheFirst.ch, TheSecond.number,TheSecond.ch,0
  FROM --divide up the first string into a table of characters/sequence
   (SELECT number, SUBSTRING(@FirstString,number,1) AS ch
    FROM numbers WHERE number <= LEN(@FirstString) union all Select 0,Char(0)) TheFirst 
  cross JOIN --divide up the second string into a table of characters/sequence
   (SELECT number, SUBSTRING(@SecondString,number,1) AS ch
    FROM numbers WHERE number <= LEN(@SecondString) union all Select 0,Char(0)) TheSecond
  --ON Thefirst.ch= Thesecond.ch --do all valid matches
order by TheFirst.number, TheSecond.number 
 
Declare @current Varchar(255)
Declare @previous Varchar(255)
Declare @TheValue int
Declare @Deletion int, @Insertion int, @Substitution int, @minim int
Select @current='', @previous=''
Update @PseudoMatrix
    Set
    @Deletion=@TheValue+1,
    @Insertion=ascii(substring(@previous,secondorder+1,1))+1,
    @Substitution=ascii(substring(@previous,(secondorder),1)) +1,
    @minim=case when @Deletion<@Insertion then @Deletion else @insertion end,
    @TheValue = Thevalue = case --when Firstorder+SecondOrder=0 then 0
                         when SecondOrder=0 then FirstOrder
                         When FirstOrder=0 then Secondorder
                 when FirstCh=SecondCh then ascii(substring(@previous,(secondorder),1))
                 else case when @Minim<@Substitution then @Minim else @Substitution end
               end,
    @Previous=PreviousRowValues=case when secondorder =0 then @current else @Previous end,         
    @current= case when secondorder =0 then char(@TheValue) else @Current+char(@TheValue) end    
return @TheValue
End          
Go