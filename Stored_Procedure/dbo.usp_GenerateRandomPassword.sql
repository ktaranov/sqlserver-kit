IF OBJECT_ID('dbo.usp_GenerateRandomPassword') IS NULL
     EXEC('CREATE PROCEDURE dbo.usp_GenerateRandomPassword AS SELECT 1;');
GO


ALTER PROCEDURE dbo.usp_GenerateRandomPassword(
    @length int = 20,
    @allowAtoZ BIT = 1,
    @allow0to9 BIT = 1,
    @allowSpecials1 BIT = 1,
    @allowSpecials2 BIT = 1,
    @avoidAmbiguousCharacters BIT = 1)
AS
/*
summary:   >
 This procedure generate random passwords with some customization
 result.
 Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Stored_Procedure/dbo.usp_GenerateRandomPassword.sql
Revisions: 
 - Author: Pinal Dave
   Original link: https://blog.sqlauthority.com/2018/08/15/sql-server-how-to-generate-random-password-enhanced-version-part-2/?utm_source=DBW&utm_medium=pubemail
   Version: 1.0
   Modification: First version
   date: 2018-08-15
 - version: 1.1
   modification: add CREATE and ALTER logic, add documentation, format code
   date: 2019-01-29 by Konstantin Taranov
Example:
     - code: EXEC dbo.usp_GenerateRandomPassword @avoidAmbiguousCharacters = 0;
             EXEC dbo.usp_GenerateRandomPassword @length = 30, @allow0to9 = 0, @allowSpecials1 = 0, @allowSpecials2 = 0, @avoidAmbiguousCharacters = 0;
             EXEC dbo.usp_GenerateRandomPassword @length = 40, @allow0to9 = 0, @allowSpecials1 = 0, @allowSpecials2 = 1, @avoidAmbiguousCharacters = 1;
             EXEC dbo.usp_GenerateRandomPassword @length = 90, @allowAtoZ = 0, @allow0to9 = 0, @allowSpecials1 = 1, @allowSpecials2 = 1;

            IF OBJECT_ID(N't', 'U') IS NULL
            BEGIN
            CREATE TABLE t(
                [Password] NVARCHAR(4000),
                PasswordLength INT,
                AllowAtoZ BIT,
                Allow0to9 BIT,
                AllowSpecials1 BIT,
                AllowSpecials2 BIT,
                AvoidAmbiguousCharacters BIT);
            END;
            DECLARE @i INT = 1;
            WHILE @i <= 50
            BEGIN
                INSERT INTO t EXEC dbo.usp_GenerateRandomPassword;
                SET @i = @i + 1;
            END;
            SELECT * FROM t;
            DROP TABLE t;
returns:   >
 single row with new random password and all input parameters.
*/
BEGIN
    DECLARE @range Varchar(90) = ''
    -- Start by assuming @avoidAmbiguousCharacters is true
    IF @allowAtoZ = 1
BEGIN
        SET @range = @range +'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';
    END
    IF @allow0to9 = 1
BEGIN
        SET @range = @range +'23456789';
    END
    IF @allowSpecials1 = 1
BEGIN
        SET @range = @range +'!"#$%&''()*+,-./';
    END
    IF @allowSpecials2 = 1
BEGIN
        SET @range = @range +':;<=>?@';
    END
    IF @avoidAmbiguousCharacters = 0
BEGIN
        -- put back capital i, lowercase l, capital o, the number(s) 0, 1
        IF @allowAtoZ = 1
BEGIN
            SET @range = @range +'IOl';
        END
        IF @allow0to9 = 1
BEGIN
            SET @range = @range +'01';
        END
    END
    DECLARE @pwd VARCHAR(512) = '';
    --use master.dbo.spt_values as a pseudo tally(numbers) table

    SELECT TOP(@length)
        @pwd += SUBSTRING(@range,fn.rnd,1)
    FROM master.dbo.spt_values sv
        CROSS APPLY (
    SELECT [rnd] = (ABS(CHECKSUM(NEWID())) % (LEN(@range)))
    ) AS fn
    SELECT @pwd AS [Password],
        @length AS PasswordLength,
        @allowAtoZ,
        @allow0to9 AS Allow0to9,
        @allowSpecials1 AS AllowSpecials1,
        @allowSpecials2 AS AllowSpecials2,
        @avoidAmbiguousCharacters AS AvoidAmbiguousCharacters;
END;
GO
