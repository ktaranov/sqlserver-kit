IF OBJECT_ID('dbo.udf_InitCap') IS NULL
   EXECUTE ('CREATE FUNCTION dbo.udf_InitCap() RETURNS nvarchar(max) AS RETURN SELECT 1 AS A;');
GO

ALTER FUNCTION dbo.udf_InitCap(
    @StrStr nvarchar(max)
    )
/*
SELECT dbo.udf_InitCap(N'test STRING ß');

Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/User_Defined_Function/dbo.udf_InitCap.sql
Original link: https://gist.github.com/jef-sure/f67bc2c06c4804ca832f1dc5550c8db4
Author: Anton Petrusevich
Created Date: 2018-09-24
Modified Date: 2019-07-23 by Konstantin Taranov
*/
RETURNS nvarchar(max) AS
BEGIN
     DECLARE @StrNew nvarchar(max);
     DECLARE @c nvarchar(1);
     DECLARE @x integer;
     DECLARE @StrLen integer;
     DECLARE @CloseBracket nvarchar(5);
     DECLARE @OpenBracket varchar(5);
     DECLARE @mode varchar(20) = 'upper';
     SELECT @StrNew = '', @x = 1, @StrLen = LEN(@StrStr)+1;
     SELECT @OpenBracket = CHAR(34) + CHAR(39) + CHAR(40) + CHAR(91) + CHAR(123);
     SELECT @CloseBracket = CHAR(34) + CHAR(39) + CHAR(41) + CHAR(93) + CHAR(125);
     WHILE @x < @StrLen
     BEGIN 
        SET @c = SUBSTRING(@StrStr, @x, 1);
        DECLARE @pbi INT;
        DECLARE @cb NCHAR(1);
        IF @c = 'ß' or unicode(LOWER(@c)) <> unicode(UPPER(@c))
        BEGIN
            IF @mode = 'lower'
                SET @c = lower(@c);
            IF @mode = 'upper'
            BEGIN
                SET @c = upper(@c);
                SET @mode = 'lower';
            END;
        END;
        ELSE
        BEGIN
            SET @pbi = CHARINDEX(@c, @OpenBracket);
            IF @pbi <> 0
            BEGIN
                SET @cb = SUBSTRING(@CloseBracket, @pbi, 1);
                SET @mode = 'preserve';
            END
            ELSE
                IF @mode <> 'preserve'
                    SET @mode = 'upper';
                ELSE
                    IF @c = @cb
                        SET @mode = 'upper';
        END;
        SET @StrNew = @StrNew + @c;
        SET @x = @x +1;
    END;
    RETURN @StrNew;
END;
GO
