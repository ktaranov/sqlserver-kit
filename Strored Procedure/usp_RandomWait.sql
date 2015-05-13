----------------------------------------------------------------------------------------------------------------
--Procedure to wait randomized number of minutes or seconds, used to delay jobs
----------------------------------------------------------------------------------------------------------------
IF OBJECT_ID('usp_RandomWait') IS NOT NULL DROP PROC usp_RandomWait
GO

CREATE PROC usp_RandomWait
 @sec_or_min char(1) = 'm'
,@span tinyint = 30 
AS
IF @sec_or_min NOT IN ('s', 'm')
	BEGIN
		RAISERROR('The parameter @sec_or_min must be ''m'' (minutes) or ''s'' (seconds).', 16, 1)
		RETURN
	END
DECLARE @towait char(2)
,@parsedWait char(8)
,@msg varchar(100)
SET @towait = RIGHT('0' + CAST(CAST(RAND()*@span AS int)%@span+1 AS varchar(2)), 2)
SET @parsedWait =  
 CASE WHEN @sec_or_min = 's' THEN '00:00:' + @towait 
 ELSE '00:' + @towait + ':00'
 END
SET @msg = 'Waiting ' + @parsedWait
RAISERROR (@msg, 10, 1) WITH NOWAIT
WAITFOR DELAY @parsedWait

/* Test
EXEC usp_RandomWait
EXEC usp_RandomWait @sec_or_min = 'm', @span = 30
EXEC usp_RandomWait @sec_or_min = 's', @span = 10
*/
GO
