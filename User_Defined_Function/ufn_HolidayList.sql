CREATE FUNCTION dbo.FloatingDate(@Occur INT,@WeekDay INT,@Month INT,@Year INT)
RETURNS
SMALLDATETIME
AS
BEGIN
DECLARE @Result SMALLDATETIME
DECLARE @StartDate SMALLDATETIME

-- Get Starting date, which is first day of the month
SET @StartDate = CONVERT(SmallDateTime,CAST(@Month AS VARCHAR(2))+'/1/'+CAST(@Year AS VARCHAR(4)))

SET @Result = cast(str(@Month)+'/'+ str((7+ @Weekday-datepart(dw,@StartDate))%7+1) +'/'+str(@Year) AS datetime)+(@Occur-1)*7 

RETURN @Result
END

---------------------------------------------------------------------------------
-- Returns a virtual table containing all holidays for a given year
---------------------------------------------------------------------------------
CREATE FUNCTION [dbo].udf_HolidayList (@nYear INT)
RETURNS @Holidays TABLE
(Holiday_name VARCHAR(32),
Holiday_date SMALLDATETIME
)
AS
BEGIN
-- Calculate Easter Sunday
DECLARE @g INT
DECLARE @c INT
DECLARE @h INT
DECLARE @i INT
DECLARE @j INT
DECLARE @l INT
DECLARE @Month INT
DECLARE @Day INT
DECLARE @Easter SMALLDATETIME
DECLARE @WorkDT SMALLDATETIME

-- Bizarre Algorithm to determine Easter Sunday
SET @g = @nYear % 19
SET @c = @nYear / 100
SET @h = ((@c - (@c / 4) - ((8 * @c + 13) / 25) + (19 * @g) + 15) % 30)
SET @i = @h - ((@h / 28) * (1 - (@h /28) * (29 / (@h + 1)) * ((21 - @g) / 11)))
SET @j = ((@nYear + (@nYear / 4) + @i + 2 - @c + (@c / 4)) % 7)
SET @l = @i - @j
SET @Month = 3 + ((@l + 40) / 44)
SET @Day = @l + 28 - (31 * (@Month / 4))
SET @Easter = CAST(@Month AS VARCHAR(2)) + '/' + CAST(@Day As VARCHAR(2)) + '/' + CAST(@nYear AS VARCHAR(4))

------------------------------------------------------------------------------------------------
-- Add Easter Sunday to holiday list, and get holidays based around Easter
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Easter',@Easter)
-- Good Friday
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Good Friday',DateAdd(d,-2,@Easter))
-- Palm Sunday
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Palm Sunday',DateAdd(ww,-1,@Easter))
-------------------------------------------------------------------------------------------------

-- Fixed date holidays are loaded next
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('New Year''s Day',CONVERT(SmallDateTime,'1/1/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Groundhog Day',CONVERT(SmallDateTime,'2/2/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Lincoln''s Birthday',CONVERT(SmallDateTime,'2/12/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Valentines Day',CONVERT(SmallDateTime,'2/14/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('St. Patrick''s Day',CONVERT(SmallDateTime,'3/17/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('April Fools Day',CONVERT(SmallDateTime,'4/1/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Flag Day',CONVERT(SmallDateTime,'6/14/'+CAST(@nYear AS VARCHAR(4))))
IF @nYear >=1776 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Independence Day',CONVERT(SmallDateTime,'7/4/'+CAST(@nYear AS VARCHAR(4))))
IF @nYear >=1958 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Boss''s Day',CONVERT(SmallDateTime,'10/16/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Halloween',CONVERT(SmallDateTime,'10/31/'+CAST(@nYear AS VARCHAR(4))))
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Christmas',CONVERT(SmallDateTime,'12/25/'+CAST(@nYear AS VARCHAR(4))))
IF @nYear >=1966 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Kwanzaa',CONVERT(SmallDateTime,'12/26/'+CAST(@nYear AS VARCHAR(4))))

-- Holidays that full on the same day of the week (based on the year they were officially established)
IF @nYear>=1983 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Martin Luther King Day',dbo.FloatingDate(3,2,1,@nYear)) -- 3rd Monday in January
IF @nYear>=1993 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Take your Daughter to Work Day',dbo.FloatingDate(4,5,4,@nYear)) -- 4th Thursday in April
IF @nYear>=1908 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Mothers Day',dbo.FloatingDate(2,1,5,@nYear)) -- 2nd Sunday in May
IF @nYear>=1950 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Armed Forces Day',dbo.FloatingDate(3,7,5,@nYear)) -- 3rd Saturday in May
IF @nYear>=1910 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Fathers Day',dbo.FloatingDate(3,1,6,@nYear)) -- 3rd Sunday in June
IF @nYear>=1894 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Labor Day',dbo.FloatingDate(1,2,9,@nYear)) -- 1st Monday in September
IF @nYear>=1941 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Thanksgiving',dbo.FloatingDate(4,5,11,@nYear)) -- 4th Thursday in November

---------------------------------------------------------------------------------------
-- Federal holidays that only come every 4 years
---------------------------------------------------------------------------------------
IF (@nYear >= 1937) AND ((@nYear-1937) % 4)=0
BEGIN
 SET @WorkDT=CONVERT(SmallDateTime,'01/20/'+CAST(@nYear AS VARCHAR(4))) -- Get Inauguration day
 IF DatePart(dw,@WorkDT)=1 SET @WorkDt=DateAdd(d,1,@WorkDt) -- Move to Monday if it falls on Sunday
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Inauguration Day',@WorkDt)
END

IF (@nYear < 1937) AND ((@nYear-1937) % 4)=0
BEGIN
-- Get Inauguration day for years prior to 1937
 SET @WorkDT = CONVERT(SmallDateTime,'03/04/'+CAST(@nYear AS VARCHAR(4)))
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Inauguration Day',@WorkDt)
END
---------------------------------------------------------------------------------------
-- Holidays that change based upon year
---------------------------------------------------------------------------------------
IF @nYear >= 1971
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Presidents Day',dbo.FloatingDate(3,2,2,@nYear)) -- 3rd Monday in February
IF @nYear < 1971
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Washington''s Birthday',CONVERT(SmallDateTime,'2/22/'+CAST(@nYear AS VARCHAR(4))))

IF (@nYear >=1954)
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Veteran''s Day',CONVERT(SmallDateTime,'11/11/'+CAST(@nYear AS VARCHAR(4))))
IF (@nYear >=1921 and @nYear < 1954)
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Armistice',CONVERT(SmallDateTime,'11/11/'+CAST(@nYear AS VARCHAR(4))))

IF @nYear>=1971
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Columbus Day',dbo.FloatingDate(2,2,10,@nYear)) -- 2nd Monday in October
IF @nYear>=1937 and @nYear <1971
INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Columbus Day',CONVERT(SmallDateTime,'10/12/'+CAST(@nYear AS VARCHAR(4))))
---------------------------------------------------------------------------------------
-- Day light savings start and end, based on US Federal law only
---------------------------------------------------------------------------------------
IF @nYear >= 1987 AND @nYear <2007
BEGIN
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Daylight Savings -Start',dbo.FloatingDate(1,1,4,@nYear)) -- 1st Sunday in April
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Daylight Savings -End',dbo.FloatingDate(4,1,10,@nYear)) -- 4th Sunday in October
END

IF @nYear >= 2007
BEGIN
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Daylight Savings -Start',dbo.FloatingDate(2,1,3,@nYear)) -- 2nd Sunday in March
 INSERT INTO @Holidays (Holiday_name,Holiday_date) VALUES ('Daylight Savings -End',dbo.FloatingDate(1,1,11,@nYear)) -- 1st Sunday in November
END
RETURN
END
GO