alter function LEVENSHTEIN ( @SourceString nvarchar(100), @TargetString nvarchar(100) ) 
--Returns the Levenshtein Distance between @SourceString string and @TargetString
--Translated to TSQL by Joseph Gama
--Updated slightly by Phil Factor
returns int
as
BEGIN
DECLARE @Matrix Nvarchar(4000), @LD int, @TargetStringLength int, @SourceStringLength int,
@ii int, @jj int, @CurrentSourceChar nchar(1), @CurrentTargetChar nchar(1),@Cost int, 
@Above int,@AboveAndToLeft int,@ToTheLeft int, @MinimumValueOfCells int
-- Step 1: Set n to be the length of s. Set m to be the length of t. 
--                    If n = 0, return m and exit.
--    If m = 0, return n and exit.
--    Construct a matrix containing 0..m rows and 0..n columns.
if @SourceString is null or @TargetString is null return null
Select @SourceStringLength=LEN(@SourceString), 
     @TargetStringLength=LEN(@TargetString),
     @Matrix=replicate(nchar(0),(@SourceStringLength+1)*(@TargetStringLength+1))
If @SourceStringLength = 0 return @TargetStringLength
If @TargetStringLength = 0 return @SourceStringLength
if (@TargetStringLength+1)*(@SourceStringLength+1)> 4000 return -1
--Step 2: Initialize the first row to 0..n.
--     Initialize the first column to 0..m.
SET @ii=0
WHILE @ii<=@SourceStringLength
    BEGIN
    SET @Matrix=STUFF(@Matrix,@ii+1,1,nchar(@ii))--d(i, 0) = i
    SET @ii=@ii+1
    END
SET @ii=0
WHILE @ii<=@TargetStringLength
    BEGIN
    SET @Matrix=STUFF(@Matrix,@ii*(@SourceStringLength+1)+1,1,nchar(@ii))--d(0, j) = j
    SET @ii=@ii+1
    END
--Step 3 Examine each character of s (i from 1 to n).
SET @ii=1
WHILE @ii<=@SourceStringLength
    BEGIN
 
--Step 4   Examine each character of t (j from 1 to m).
    SET @jj=1
    WHILE @jj<=@TargetStringLength
        BEGIN
--Step 5 and 6
        Select 
        --Set cell d[i,j] of the matrix equal to the minimum of:
        --a. The cell immediately above plus 1: d[i-1,j] + 1.
        --b. The cell immediately to the left plus 1: d[i,j-1] + 1.
        --c. The cell diagonally above and to the left plus the cost: d[i-1,j-1] + cost
        @Above=unicode(substring(@Matrix,@jj*(@SourceStringLength+1)+@ii-1+1,1))+1,
        @ToTheLeft=unicode(substring(@Matrix,(@jj-1)*(@SourceStringLength+1)+@ii+1,1))+1,
        @AboveAndToLeft=unicode(substring(@Matrix,(@jj-1)*(@SourceStringLength+1)+@ii-1+1,1))
         + case when (substring(@SourceString,@ii,1)) = (substring(@TargetString,@jj,1)) 
            then 0 else 1 end--the cost
        -- If s[i] equals t[j], the cost is 0.
      -- If s[i] doesn't equal t[j], the cost is 1.
        -- now calculate the minimum value of the three
        if (@Above < @ToTheLeft) AND (@Above < @AboveAndToLeft) 
            select @MinimumValueOfCells=@Above
      else if (@ToTheLeft < @Above) AND (@ToTheLeft < @AboveAndToLeft)
            select @MinimumValueOfCells=@ToTheLeft
        else
            select @MinimumValueOfCells=@AboveAndToLeft
        Select @Matrix=STUFF(@Matrix,
                   @jj*(@SourceStringLength+1)+@ii+1,1,
                   nchar(@MinimumValueOfCells)),
           @jj=@jj+1
        END
    SET @ii=@ii+1
    END    
--Step 7 After iteration steps (3, 4, 5, 6) are complete, distance is found in cell d[n,m]
return unicode(substring(
   @Matrix,@SourceStringLength*(@TargetStringLength+1)+@TargetStringLength+1,1
   ))
END
go