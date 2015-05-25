CREATE FUNCTION [dbo].[udf_DateFormattedByMask]
(
	@InputDate DATETIME,
	@Mask NVARCHAR(40)
)
/*
YYYY - Year, 4 digit
YY   - Year, 2 digit
MMMM - Month name
MMM  - Month name, first 3 characters
MM   - Month, 2 digit
DDDD - Day of week
DDD  - Day of week, first 3 characters
DD   - Day of month, 2 digit
hh   - hour (24 hour clock, 2 digit)
mi   - minutes, 2 digit
ss   - seconds, 2 digit
*/
RETURNS VARCHAR(40)
AS
BEGIN


	SELECT @Mask = REPLACE(@Mask,'YYYY',DATENAME(YEAR,@InputDate))
	SELECT @Mask = REPLACE(@Mask,'YY',RIGHT(DATENAME(YEAR,@InputDate),2))
	SELECT @Mask = REPLACE(@Mask,'MMMM', DATENAME(MONTH,@InputDate))
	SELECT @Mask = REPLACE(@Mask,'MMM', LEFT(DATENAME(MONTH,@InputDate),3))
	SELECT @Mask = REPLACE(@Mask,'MM', RIGHT('0'+CAST(MONTH(@InputDate) AS NVARCHAR(2)),2))
	SELECT @Mask = REPLACE(@Mask,'DDDD', DATENAME(dw,@InputDate))
	SELECT @Mask = REPLACE(@Mask,'DDD', LEFT(DATENAME(dw,@InputDate),3))
	SELECT @Mask = REPLACE(@Mask,'DD', RIGHT('0'+DATENAME(DAY,@InputDate),2))
	SELECT @Mask = REPLACE(@Mask,'hh', RIGHT('0'+DATENAME(hh,@InputDate),2))
	SELECT @Mask = REPLACE(@Mask,'mi', RIGHT('0'+DATENAME(mi,@InputDate),2))
	SELECT @Mask = REPLACE(@Mask,'ss', RIGHT('0'+DATENAME(ss,@InputDate),2))

	RETURN @Mask

END

GO
