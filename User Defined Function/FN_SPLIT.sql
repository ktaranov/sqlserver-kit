SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;

IF OBJECT_ID('[dbo].[FN_SPLIT_INT]') IS NOT NULL
	DROP FUNCTION [dbo].[FN_SPLIT_INT]
GO

IF OBJECT_ID('[dbo].[FN_SPLIT]') IS NOT NULL
	DROP FUNCTION [dbo].[FN_SPLIT]
GO

CREATE FUNCTION [dbo].[FN_SPLIT] (
	@Text nvarchar(max),  -- Text to split
	@Delimiter nvarchar(1000)   -- Value to split on, try to only pass a single char. See notes for details.
)
/* ------------------------------------------------------------------------------------------------
Purpose: Split text on a common char. 
Design Notes:
1) Will trim leading/trailing white space from items.
2) Will omit blank and null items.
3) Compatible from SQL 2005 and onward (see details about [item_int] in return table)
4) Return table item is nvarchar(max) (not bound by string length)
5) Reasonably durable with escape sequences, so if a delimiter has a [,%,_ in it, the patter should still match.
6) Uses a sliding search window, not saving the remaining text on each iteration.  However, 
   saving each item in a temp variable (@item) was faster than using a CTE to temporarily 
   store the value, which surprised me.
7) Returns the value as an int as well, which is a common use for this function (splitting comma 
   separated lists of ints).  Note that this should be low impact in that if you don't query 
   against that column since it is a non-persistent computed column (i.e. low overhead).
8) Supports @Delimiter > 1 char, but slower.  Note in the unit tests, with text of approximately 
   10K, 1 char is about 30% faster, hence the big IF block in the code.  Plus, the multi-char 
   delimiter does not scale terribly well. The test with 100,000 records, a 1 char delimiter takes 
   about 6 seconds while with a 5 char delimiter took 430 seconds (7 minutes!).  As such, try to 
   replace your multi char delimiters with a single char value before calling this function.  
   Side Note: For what it's worth, I did try an alternative method of saving the remaining 
   "working text" as a sub string of text so the search would get faster near the end, but overall 
   it was slower at about 500 seconds.

NOTE: This version does not support case sensitivity.  See "TODO" comments if you need a case insensitive version

Revision history:           
---------------------------------------------------------------------------------------------------                           
Date             User								Change Description                     
---------------------------------------------------------------------------------------------------
10/10/2013       Brad Joss (bradjoss@hotmail.com)	Initial Public Draft
---------------------------------------------------------------------------------------------------*/
RETURNS @retTable TABLE 
(
	-- Output table definition
	[item] nvarchar(max) COLLATE DATABASE_DEFAULT NOT NULL,

	-- Since most of the times we split, we are splitting lists of ints, this makes that process easier.
	-- Since the column is non persistent it should only be evaluated when requested (low overhead).
	[item_int] as (
		-- SQL 2012 version, better, use if possible
		-- TRY_CONVERT([int], NULLIF([item],'')) -- SQL 2012 Format, faster and safer, but pre-2012 code provided as well...

		-- Pre SQL 2012 syntax.  Not as reliable, so use 2012 when possible by commenting out this CAST and using the TRY_CONVERT above		
		CAST(
			CASE 
                WHEN LEN(item) > 11 THEN NULL  -- LEN OF (-2147483648) is 11.  Simple out of bounds checking.
				WHEN ISNUMERIC([item]) = 1 AND [item] NOT LIKE '%.%' THEN [item] -- Ensure value conforms to int
				ELSE null
			END 
		as int)
	)
) 
WITH SCHEMABINDING
AS
BEGIN 
	-- Garbage in, Garbage out.  If they did not pass input data, return nothing.
	IF RTRIM(ISNULL(@Text,'')) = '' OR RTRIM(ISNULL(@Delimiter,'')) = ''
		RETURN

	DECLARE
	   @ix bigint -- Current index
	 , @pix bigint -- Previous index
	 , @del_len int -- Delimiter length
	 , @text_len bigint -- Input text length
	 , @item nvarchar(max) -- Temp item buffer.  I tried w/o using CTEs, but this way was faster

	SELECT @del_len = LEN(@Delimiter)
		 , @text_len = LEN(@Text)

	IF @del_len = 1
	BEGIN -- CHARINDEX MODE (Much faster than PATINDEX mode)
		SELECT @ix = CHARINDEX(@Delimiter, @Text) -- TODO: If you want to implment Case Insensitivity here, wrap both in LOWER()
			 , @pix = 0
	
		-- No delim found, just return the passed value, trimmed
		IF @ix = 0
		BEGIN
			INSERT INTO @retTable(item) 
				SELECT LTRIM(RTRIM(@Text)) -- We know this is not null because of the first GIGO check above
		END
		ELSE
		BEGIN
			-- Find most of the matches
			WHILE @ix > 0
			BEGIN
				SELECT 
					-- Get the current value
					  @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,(@ix - @pix)))) 
					-- Move previous pointer to end of last found delimiter
					, @pix = @ix + @del_len 
					-- And update the values for next pass though the loop, finding the next match
					, @ix = CHARINDEX(@Delimiter, @Text, (@ix + @del_len)) -- TODO: If you want to implment Case Insensitivity here, wrap both in LOWER()
				
				IF @item <> '' AND @item IS NOT NULL -- Only save non empty values
					INSERT INTO @retTable(item) VALUES (@item)
			END

			-- Get the trailing text
			SET @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,@text_len)))
			IF @item <> '' AND @item IS NOT NULL  -- Only save non empty values
				INSERT INTO @retTable(item) VALUES (@item)
		END --  @ix = 0
	END
	ELSE -- @del_len = 1
	BEGIN -- PATINDEX Mode (SLOW!) Try to pass in text that uses single char delimeters when possible

		DECLARE @del_pat nvarchar(3002)  -- Assume 3x @Delimiter + 2, for escaping every character plus wrapper %

		-- Escape characters that will mess up the like clause, and wrap in wild cards %
		SELECT @del_pat = '%' + REPLACE(REPLACE(REPLACE(@Delimiter
				, '[','[[]')
				, '%','[%]')
				, '_', '[_]') 
			+ '%'

		SELECT @ix = PATINDEX(@del_pat, @Text) -- TODO: If you want to implment Case Insensitivity here, wrap both in LOWER()
			 , @pix = 0
	
		-- No delim found, just return the passed value, trimmed
		IF @ix = 0
		BEGIN
			INSERT INTO @retTable(item) 
				SELECT LTRIM(RTRIM(@Text)) -- We know this is not null because of the first GIGO check above
		END
		ELSE
		BEGIN
			-- Find most of the matches
			WHILE @ix > 0
			BEGIN
				SELECT 
					-- Get the curent Item
					@item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,(@ix - @pix))))
					-- Move the previous index to the end of the previous delimiter
					, @pix = @ix + @del_len 
					-- And set values for next itteration of the loop, finding the next match
					, @ix = PATINDEX(@del_pat, SUBSTRING(@Text, (@ix + @del_len), @text_len)) -- TODO: If you want to implment Case Insensitivity here, wrap both in LOWER()

				IF @item <> '' AND @item IS NOT NULL  -- Only save non empty values
					INSERT INTO @retTable(item) VALUES (@item)

				IF @ix > 0 SET @ix = ((@ix + @pix) - 1) -- -1 since PatIndex is 1 based and Substring is 0 based
			END

			-- Get the trailing text
			SET @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,@text_len)))
			IF @item <> '' AND @item IS NOT NULL  -- Only save non empty values
				INSERT INTO @retTable(item) VALUES (@item)
		END --  @ix = 0
	END -- @del_len = 1

	RETURN
END

GO

/*
Overloaded version to make splitting comma seperated lists of ints easier.
Note the delimiter is hard coded to comma and that non-int values will be removed.
*/
CREATE FUNCTION [dbo].[FN_SPLIT_INT] (
	@Text nvarchar(max)  -- Text to split
)
RETURNS TABLE
AS
RETURN SELECT [item_int] -- TODO: Optional add distinct?
	FROM [dbo].[FN_SPLIT](@Text, ',') -- Hard coded to comma delimited
	WHERE [item_int] IS NOT NULL -- Remove invalid values
GO
	

GRANT REFERENCES, SELECT ON [dbo].[FN_SPLIT] TO [public] AS [dbo]
GRANT REFERENCES, SELECT ON [dbo].[FN_SPLIT_INT] TO [public] AS [dbo]
GO

-- Precompile, so performance numbers below are not skewed.
SELECT * INTO #Garbage1 FROM [dbo].[FN_SPLIT]('1,2,3',',')
SELECT * INTO #Garbage2 FROM [dbo].[FN_SPLIT_INT]('1,2,3')

DROP TABLE #Garbage1
DROP TABLE #Garbage2
GO

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- Unit test --
-- Split has been problematic enough for me I thought these tests important.

SET NOCOUNT ON

DECLARE @TESTS TABLE (
	[cnt] int,
	[txt] nvarchar(max),
	[delim] nvarchar(1000),
	[sum_len] int
)
DECLARE @RESULTS TABLE (
	[id] int identity(1,1),
	[msg] varchar(255) null,
	[pass_fail] AS (
		CASE 
			WHEN (ISNULL([expected_count],0) = ISNULL([actual_count],0) AND ISNULL([expected_sum_len],0) = ISNULL([actual_sum_len],0)) THEN 'PASS' 
			ELSE 'FAIL' 
			END
	),
	[runtime] int null,
	[expected_count] int null,
	[actual_count] int null,
	[expected_sum_len] int null,
	[actual_sum_len] int null,
	[delim] nvarchar(1000),
	[txt] nvarchar(max)
)

DECLARE @BigText nvarchar(max)
DECLARE @BigTextItemCount int
DECLARE @BigTextSumHash int

-- Alternative large volume tests, set to 10 for quick, set to 100K for a real workout
--SELECT @BigTextItemCount = 10, @BigTextSumHash = 11
SELECT @BigTextItemCount = 10000, @BigTextSumHash = 38894
--SELECT @BigTextItemCount = 100000, @BigTextSumHash = 488895

-- Create the hash of big text. I know this code is somewhat ugly, but it creates the large text in 
-- about 1 second, as opposed to an itterative concat that took 14 minutes... :-)
;with cte as (
	select 9 as [i]
	union all
	select [i] - 1 FROM cte where [i] > 0
),
crs as (
	SELECT ROW_NUMBER() OVER(ORDER BY c1.[i]) as [rn]
	FROM cte c1		  -- 10
	CROSS JOIN cte c2 -- 100
	CROSS JOIN cte c3 -- 1000
	CROSS JOIN cte c4 -- 10000
	CROSS JOIN cte c5 -- 100000
)
SELECT @BigText =
	(
		(
		SELECT '#' + CAST([rn] as nvarchar(32))
		FROM crs
		WHERE [rn] <= @BigTextItemCount
		FOR XML PATH('') , TYPE
		).value('.', 'nvarchar(max)')
	)

-- Most of the tests go here --
INSERT INTO @TESTS (cnt, sum_len, txt, delim)
	-- Basic 1-char Delim Tests
			  SELECT 0, 0, '', ','
	UNION ALL SELECT 0, 0, null, ','
	UNION ALL SELECT 0, 0, 'a', null
	UNION ALL SELECT 0, 0, 'a', ''
	UNION ALL SELECT 3, 3, '1,2,3', ','
	UNION ALL SELECT 3, 3, ',1,2,3', ','
	UNION ALL SELECT 3, 3, '1,2,3,', ','
	UNION ALL SELECT 3, 3, ',1,2,3,', ','
	UNION ALL SELECT 3, 3, ' , 1 , 2 , 3 , ', ','
	UNION ALL SELECT 3, 3, ',,, , 1 , 2 , 3 , ,,,', ','
	UNION ALL SELECT 3, 3, 'a, b, c', ','
	UNION ALL SELECT 3, 3, 'a,b,c', ','
	UNION ALL SELECT 2, 6, 'Cat=Pub', '='
	UNION ALL SELECT 1, 1, 'a', ','
	UNION ALL SELECT 1, 1, '  a  ', ','
	-- 1 char Int Tests
	UNION ALL SELECT 10, 18, 'a,1,2,-1,-2,b,1.0,-1.0, 3 , -4 ,', ','
	-- Basic multi-char delim tests
	UNION ALL SELECT 0, 0, '', '<tag>'
	UNION ALL SELECT 0, 0, null, '<tag>'
	UNION ALL SELECT 0, 0, 'a', null
	UNION ALL SELECT 0, 0, 'a', ''
	UNION ALL SELECT 3, 3, '1<TaG>2<tag>3', '<tag>' -- Case Insensitivity test 1
	UNION ALL SELECT 3, 3, '<tag>1<tag>2<tag>3', '<TaG>' -- Case Insensitivity test 2
	UNION ALL SELECT 3, 3, '1<tag>2<tag>3<tag>', '<tag>'
	UNION ALL SELECT 3, 3, '<tag>1<tag>2<tag>3<tag>', '<tag>'
	UNION ALL SELECT 3, 3, ' <tag> 1 <tag> 2 <tag> 3 <tag> ', '<tag>'
	UNION ALL SELECT 3, 3, '<tag><tag><tag> <tag> 1 <tag> 2 <tag> 3 <tag> <tag><tag><tag>', '<tag>'
	UNION ALL SELECT 3, 3, 'a<tag> b<tag> c', '<tag>'
	UNION ALL SELECT 3, 3, 'a<tag>b<tag>c', '<tag>'
	UNION ALL SELECT 2, 6, 'Cat<tag>Pub', '<tag>'
	UNION ALL SELECT 1, 1, 'a', '<tag>'
	UNION ALL SELECT 1, 1, '  a  ', '<tag>'
	-- multi char delim Int Tests
	UNION ALL SELECT 10, 18, 'a<tag>1<tag>2<tag>-1<tag>-2<tag>b<tag>1.0<tag>-1.0<tag> 3 <tag> -4 <tag>', '<tag>'
	-- Delims with escape char % in it
	UNION ALL SELECT 0, 0, '', '<t%a%g>'
	UNION ALL SELECT 0, 0, null, '<t%a%g>'
	UNION ALL SELECT 0, 0, 'a', null
	UNION ALL SELECT 0, 0, 'a', ''
	UNION ALL SELECT 3, 3, '1<t%a%g>2<t%a%g>3', '<t%a%g>'
	UNION ALL SELECT 3, 3, '<t%a%g>1<t%a%g>2<t%a%g>3', '<t%a%g>'
	UNION ALL SELECT 3, 3, '1<t%a%g>2<t%a%g>3<t%a%g>', '<t%a%g>'
	UNION ALL SELECT 3, 3, '<t%a%g>1<t%a%g>2<t%a%g>3<t%a%g>', '<t%a%g>'
	UNION ALL SELECT 3, 3, ' <t%a%g> 1 <t%a%g> 2 <t%a%g> 3 <t%a%g> ', '<t%a%g>'
	UNION ALL SELECT 3, 3, '<t%a%g><t%a%g><t%a%g> <t%a%g> 1 <t%a%g> 2 <t%a%g> 3 <t%a%g> <t%a%g><t%a%g><t%a%g>', '<t%a%g>'
	UNION ALL SELECT 3, 3, 'a<t%a%g> b<t%a%g> c', '<t%a%g>'
	UNION ALL SELECT 3, 3, 'a<t%a%g>b<t%a%g>c', '<t%a%g>'
	UNION ALL SELECT 2, 6, 'Cat<t%a%g>Pub', '<t%a%g>'
	UNION ALL SELECT 1, 1, 'a', '<t%a%g>'
	UNION ALL SELECT 1, 1, '  a  ', '<t%a%g>'
	UNION ALL SELECT 10, 18, 'a<t%a%g>1<t%a%g>2<t%a%g>-1<t%a%g>-2<t%a%g>b<t%a%g>1.0<t%a%g>-1.0<t%a%g> 3 <t%a%g> -4 <t%a%g>', '<t%a%g>'
	-- Delims with escape char _ in it
	UNION ALL SELECT 0, 0, '', '<t_ag>'
	UNION ALL SELECT 0, 0, null, '<t_ag>'
	UNION ALL SELECT 0, 0, 'a', null
	UNION ALL SELECT 0, 0, 'a', ''
	UNION ALL SELECT 3, 3, '1<t_ag>2<t_ag>3', '<t_ag>'
	UNION ALL SELECT 3, 3, '<t_ag>1<t_ag>2<t_ag>3', '<t_ag>'
	UNION ALL SELECT 3, 3, '1<t_ag>2<t_ag>3<t_ag>', '<t_ag>'
	UNION ALL SELECT 3, 3, '<t_ag>1<t_ag>2<t_ag>3<t_ag>', '<t_ag>'
	UNION ALL SELECT 3, 3, ' <t_ag> 1 <t_ag> 2 <t_ag> 3 <t_ag> ', '<t_ag>'
	UNION ALL SELECT 3, 3, '<t_ag><t_ag><t_ag> <t_ag> 1 <t_ag> 2 <t_ag> 3 <t_ag> <t_ag><t_ag><t_ag>', '<t_ag>'
	UNION ALL SELECT 3, 3, 'a<t_ag> b<t_ag> c', '<t_ag>'
	UNION ALL SELECT 3, 3, 'a<t_ag>b<t_ag>c', '<t_ag>'
	UNION ALL SELECT 2, 6, 'Cat<t_ag>Pub', '<t_ag>'
	UNION ALL SELECT 1, 1, 'a', '<t_ag>'
	UNION ALL SELECT 1, 1, '  a  ', '<t_ag>'
	UNION ALL SELECT 10, 18, 'a<t_ag>1<t_ag>2<t_ag>-1<t_ag>-2<t_ag>b<t_ag>1.0<t_ag>-1.0<t_ag> 3 <t_ag> -4 <t_ag>', '<t_ag>'
	-- Semi Evil tests
	UNION ALL SELECT 2, 2, 'a~`!@#$%^&*()_+|-=\{}:;"''<>,.?/	b', '~`!@#$%^&*()_+|-=\{}:;"''<>,.?/	' -- no []
	UNION ALL SELECT 2, 2, 'a~`!@#$%^&*()_+|-=\{}[]:;"''<>,.?/	b', '~`!@#$%^&*()_+|-=\{}[]:;"''<>,.?/	' -- with []
	UNION ALL SELECT 2, 2, 'a' + CHAR(10) + CHAR(13) + 'b', CHAR(10) + CHAR(13) -- White space chars
	-- Big Text Tests
	UNION ALL SELECT @BigTextItemCount,@BigTextSumHash,@BigText, '#'
	UNION ALL SELECT @BigTextItemCount,@BigTextSumHash,REPLACE(@BigText,'#', '<tag>'), '<tag>'

-- Loop through each of the tests, logging results
DECLARE @txt nvarchar(max) -- Input text
DECLARE @delim nvarchar(1000) -- Input delimiter
DECLARE @cnt int -- Expected count
DECLARE @sum_len int -- Expected sum(len(item))
DECLARE @t_cnt int -- Actual count
DECLARE @t_sum_len int -- Actual sum(len(item))
DECLARE @start datetime -- Test Start time (for performance tracking)

DECLARE cur CURSOR FAST_FORWARD FOR
	SELECT [cnt],[txt],[delim],[sum_len] FROM @TESTS
OPEN cur
FETCH cur INTO @cnt, @txt, @delim,@sum_len
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @start = GetDate();

	-- Execute test
	SELECT @t_cnt = count(*), @t_sum_len = SUM(LEN(item))
		FROM [dbo].[FN_SPLIT](@txt, @delim)
	
	-- Log results
	INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'TEST', DATEDIFF(ms, @start,  GetDate()), @cnt, @t_cnt, @sum_len, ISNULL(@t_sum_len,0), @delim, @txt
	
	FETCH cur INTO @cnt, @txt, @delim,@sum_len
END
CLOSE cur
DEALLOCATE cur

----------------------------------------------------------------------------------------------------------------------------------
-- Extra tests that required additional coding
DECLARE @int_test nvarchar(max)
SELECT @int_test = N'a,1,2,-1,-2,b,1.0,-1.0, 3 , -4 ,'

-- Basic int test, ensure int's are properly returned
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
SELECT 'Tested Ints 1', null, 6, count(*), null, null, ',', @int_test
	FROM [dbo].[FN_SPLIT](@int_test, ',') 
	WHERE [item_int] is not null

-- Ensure text value associated with int values maps 1:1
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
SELECT 'Tested Ints 2', null, 6, count(*), null, null, ',', @int_test
	FROM [dbo].[FN_SPLIT](@int_test, ',') 
	WHERE CAST([item_int] as nvarchar(max)) = [item]
	and item_int is not null


-- Split int tests
SELECT @int_test = '1,-2,3'
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 3, count(*), 2, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

SELECT @int_test = '1,a,-2,b,3,c'
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 3, count(*), 2, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

SELECT @int_test = '1, -2, 3' -- Spaces between commas
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 3, count(*), 2, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

SELECT @int_test = ' 1, -2, 3 ' -- Leading/trailing
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 3, count(*), 2, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

SELECT @int_test = '999999999999999,1,-2,-3,-99999999999999999' -- Basic boundry testing
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 3, count(*), -4, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

SELECT @int_test = ' 1.0, -2.0, 3 ' -- Should only return ints
SELECT @start = GetDate();
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Split Int: ' + @int_test, DATEDIFF(ms, @start,  GetDate()), 1, count(*), 3, SUM(item_int), '#', @int_test
		FROM [dbo].[FN_SPLIT_INT](@int_test)

----------------------------------------------------------------------------------------------------------------------------------
-- Runtime / Performance testing

IF OBJECT_ID('tempdb..#t1') IS NOT NULL	DROP TABLE #t1
IF OBJECT_ID('tempdb..#t2') IS NOT NULL	DROP TABLE #t2
IF OBJECT_ID('tempdb..#t3') IS NOT NULL	DROP TABLE #t3

SELECT @start = GetDate();
SELECT [item] INTO #t1 FROM [dbo].[FN_SPLIT](@BigText, '#') 
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Speed 1: Item only', DATEDIFF(ms, @start,  GetDate()), null, null, null, null, '#', @BigText


SELECT @start = GetDate();
SELECT [item_int] INTO #t3 FROM [dbo].[FN_SPLIT](@BigText, '#') 
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Speed 2: Item Int Only', DATEDIFF(ms, @start,  GetDate()), null, null, null, null, '#', @BigText

SELECT @start = GetDate();
SELECT [item] INTO #t2 FROM [dbo].[FN_SPLIT](@BigText, '#') WHERE [item_int] IS NOT NULL
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'Speed 3: Item With Int Filter', DATEDIFF(ms, @start,  GetDate()), null, null, null, null, '#', @BigText

IF OBJECT_ID('tempdb..#t1') IS NOT NULL	DROP TABLE #t1
IF OBJECT_ID('tempdb..#t2') IS NOT NULL	DROP TABLE #t2
IF OBJECT_ID('tempdb..#t3') IS NOT NULL	DROP TABLE #t3

----------------------------------------------------------------------------------------------------------------------------------
/*
-- Ensure test failures work
INSERT INTO @RESULTS ([msg],[runtime],[expected_count],[actual_count],[expected_sum_len],[actual_sum_len],[delim],[txt])
		SELECT 'INTENTIONAL FAILURE', null, 1, 2, 3, 4, '', ''
*/

-- Display results
SELECT * 
FROM @RESULTS
ORDER BY CASE [pass_fail] WHEN 'FAIL' THEN 0 ELSE 1 END ASC, [id] ASC

-- And Total runtime
SELECT SUM(ISNULL(runtime,0)) as [total_runtime] FROM @RESULTS

-- Raise errors as needed.
IF (SELECT count(*) FROM @RESULTS WHERE [pass_fail] = 'FAIL') > 0
	RAISERROR('Unexpected results.  Review results table for details.',18,1)
GO
