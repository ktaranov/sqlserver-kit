IF OBJECT_ID (N'LongestCommonSubsequence') IS NOT NULL
   DROP FUNCTION LongestCommonSubsequence
GO
 
Create FUNCTION LongestCommonSubsequence
/**
summary:   >
 The longest common subsequence (LCS) problem is the problem of finding the
 longest subsequence common to all sequences in two sequences. It differs
 from problems of finding common substrings: unlike substrings, subsequences
 are not required to occupy consecutive positions within the original
 sequences. For example, the sequences "1234" and "1224533324" have an LCS
 of "1234":
Author: Phil Factor
Revision: 1.0
date: 05 Dec 2014
example:
 code: |
     Select dbo.LongestCommonSubsequence ('1234', '1224533324')
     Select dbo.LongestCommonSubsequence ('thisisatest', 'testing123testing')
     Select dbo.LongestCommonSubsequence ( 'XMJYAUZ', 'MZJAWXU') 
     Select dbo.LongestCommonSubsequence ( 'beginning-middle-ending',
       'beginning-diddle-dum-ending')
returns:   >
  the longest common subsequence as a string
**/    
(
 @firstString Varchar(max),
 @SecondString Varchar(max)
)
RETURNS varchar(max)
as begin
 
Declare @Array Varchar(MAX)
Declare @ArrayMax int
Declare @west char(1)
Declare @Lines Varchar(max)
Declare @ii int, @jj int, @iiMax int, @jjMax int, @index int
 
Select @iiMax=len(@FirstString), --the length of the first string
       @jjMax=len(@SecondString), --the length of the second string
       @index=@jjMax+1 --where the first new item (matrix has an extra row & column)
Select @ArrayMax=(@iiMax)*(@jjMax)--total length of the array iterated 
Select @Array=replicate(char(0), @jjMax+1) --add in the first nought-filled row
 
Select 
  @Index=@Index+case when (number-1) % @jjMax = 0 then 2 else 1 end, --current index
  @west=case when (number-1) % @jjMax = 0 then Char(0) else substring(@Array,@index-1,1) end,
  --as we add an extra column in, this is a dangerous operation otherwise
  @Array=@Array --we add a character to the string array, Char(0)--char
        + case when (number-1) % @jjMax = 0 then Char(0) else '' end -- begin new row always zero
        + case --check first to see if there was a match. If so, take north west number incremented
            when substring(@firstString,((Number-1)/@jjMax)+1,1)
                             =substring(@SecondString, ((number-1)% @jjMax)+1 ,1)
            --remember to set the appropriate collation for this comparison!
           then  Char(Ascii(substring(@Array,@index-@jjmax-2,1))+1)--increment the NW value 
         when Ascii(substring(@Array,@index-@jjmax-1,1))>ascii(@west) --compare west to north
           then substring(@Array,@index-@jjmax-1,1) --and take the larger
         else @west-- number to west if larger
        end
from numbers where number<=@ArrayMax
 
--Now all we need to do is to backtrack through the matrix to find the best solution
Declare @commonString Varchar(max), @X_Y int
Select @CommonString ='' --this contains the string
Select @ii=@iimax+1,@jj=@jjmax+1
while (@ii>1 and @jj>1) 
  begin
  Select @X_Y = ((@ii-1)*(@jjMax+1))+@jj --the current matrix location
  if (substring(@firststring,@ii-1,1) = substring(@Secondstring,@jj-1,1))
       BEGIN --if there is a match, add the character (we'll reverse it later)
    Select @CommonString=@CommonString+substring(@firststring,@ii-1,1)
    select @jj=@jj-1, @ii=@ii-1 --go north-west
    end
  else if ascii(Substring(@Array,@X_Y,1)) = ascii(Substring(@Array, @X_Y-@jjMax-1, 1))
    select @ii=@ii-1
  ELSE if ascii(Substring(@Array,@X_Y,1)) = ascii(Substring(@Array, @X_Y-1, 1))
    select @jj=@jj-1
  else break  
  if @@error>0 break   
  end
 return  Reverse(@CommonString)
 end
go
 
Declare @timing datetime Select @Timing=GetDate()
 
if dbo.LongestCommonSubsequence ('1234', '1224533324')<>'1234' 
   raiserror('test 1 failed',16,1)
if dbo.LongestCommonSubsequence ('thisisatest', 'testing123testing')<>'tsitest' 
   raiserror('test 2 failed',16,1)
if dbo.LongestCommonSubsequence ('XMJYAUZ', 'MZJAWXU')<>'MJAU'
   raiserror('test 3 failed',16,1)
if dbo.LongestCommonSubsequence ('yab', 'xabyrbyab')<>'yab'
   raiserror('test 4 failed',16,1)
if dbo.LongestCommonSubsequence ('beginning-middle-ending','beginning-diddle-dum-ending')
   <>'beginning-iddle-ending' raiserror('test 5 failed',16,1)
 
select datediff(millisecond,@timing,GetDate()) as milliseconds