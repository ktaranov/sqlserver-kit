IF OBJECT_ID('[dbo].[udf_RTF2Text]', 'FN') IS NULL
EXECUTE('CREATE FUNCTION [dbo].[udf_RTF2Text] (@input INT) RETURNS INT AS BEGIN RETURN 1 END');
go

ALTER FUNCTION [dbo].[udf_RTF2Text]
(
    @rtf nvarchar(max)
)
RETURNS nvarchar(max)
AS
/*
Author: NightWizzard
Source: http://www.codeproject.com/Tips/821281/Convert-RTF-to-Plain-Text-Revised-Again
SQLServer version: 2008/2012/2014
SELECT [<YourRTFColumnNameHere>]
     , [dbo].[RTF2Text]([<YourRTFColumnNameHere>]) AS [TextFromRTF]
  FROM [dbo].[<YourTableNameHere>]
*/
BEGIN
    DECLARE @Pos1 int;
    DECLARE @Pos2 int;
    DECLARE @hex varchar(316);
    DECLARE @Stage table
    (
        [Char] char(1),
        [Pos] int
    );

    INSERT @Stage
        (
           [Char]
         , [Pos]
        )
    SELECT SUBSTRING(@rtf, [Number], 1)
         , [Number]
      FROM [master]..[spt_values]
     WHERE ([Type] = 'p')
       AND (SUBSTRING(@rtf, Number, 1) IN ('{', '}'));

    SELECT @Pos1 = MIN([Pos])
         , @Pos2 = MAX([Pos])
      FROM @Stage;

    DELETE
      FROM @Stage
     WHERE ([Pos] IN (@Pos1, @Pos2));

    WHILE (1 = 1)
        BEGIN
            SELECT TOP 1 @Pos1 = s1.[Pos]
                 , @Pos2 = s2.[Pos]
              FROM @Stage s1
                INNER JOIN @Stage s2 ON s2.[Pos] > s1.[Pos]
             WHERE (s1.[Char] = '{')
               AND (s2.[Char] = '}')
            ORDER BY s2.[Pos] - s1.[Pos];

            IF @@ROWCOUNT = 0
                BREAK

            DELETE
              FROM @Stage
             WHERE ([Pos] IN (@Pos1, @Pos2));

            UPDATE @Stage
               SET [Pos] = [Pos] - @Pos2 + @Pos1 - 1
             WHERE ([Pos] > @Pos2);

            SET @rtf = STUFF(@rtf, @Pos1, @Pos2 - @Pos1 + 1, '');
        END

    SET @Pos1 = PATINDEX('%\cf[0123456789][0123456789 ]%', @rtf);

    WHILE @Pos1 > 0
        SELECT @Pos2 = CHARINDEX(' ', @rtf, @Pos1 + 1),
        @rtf = STUFF(@rtf, @Pos1, @Pos2 - @Pos1 + 1, ''),
        @Pos1 = PATINDEX('%\cf[0123456789][0123456789 ]%', @rtf);

    SELECT @rtf = REPLACE(@rtf, '\pard', ''), @rtf = REPLACE(@rtf, '\par', ''),
    @rtf = CASE WHEN LEN(@rtf) > 0 THEN LEFT(@rtf, LEN(@rtf) - 1) ELSE @rtf END;
    SELECT @rtf = REPLACE(@rtf, '\b0 ', ''), @rtf = REPLACE(@rtf, '\b ', '');
    SELECT @rtf = STUFF(@rtf, 1, CHARINDEX(' ', @rtf), '');

    WHILE (Right(@rtf, 1) IN (' ', CHAR(13), CHAR(10), '}'))
      BEGIN
        SELECT @rtf = SUBSTRING(@rtf, 1, (LEN(@rtf) - 1));
        IF LEN(@rtf) = 0 BREAK
      END
    
    SET @Pos1 = CHARINDEX('\' + CHAR(39), @rtf);

    WHILE (@Pos1 > 0)
        BEGIN
            IF @Pos1 > 0
                BEGIN
                    SET @hex = '0x' + SUBSTRING(@rtf, @Pos1 + 2, 2);

                    SELECT @rtf = REPLACE(@rtf, SUBSTRING(@rtf, @Pos1, 4),
                    CHAR(CONVERT(int, CONVERT (binary(1), @hex,1))))

                    SET @Pos1 = CHARINDEX('\''', @rtf)
                END
        END

    RETURN @rtf;
END
