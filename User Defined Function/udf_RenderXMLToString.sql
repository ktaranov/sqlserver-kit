-- =============================================
-- Author:      Andrei Solntsev
-- Create date: Feb 2013
-- Description:	Converts xml value to nvarchar with formatting
-- =============================================
ALTER FUNCTION dbo.udf_RenderXMLToString
(
  @xml xml
)
RETURNS nvarchar(max)
AS
BEGIN
  DECLARE @ret nvarchar(max) = '';  -- return value
  DECLARE @s nvarchar(max);         -- string to render
  DECLARE @ss nvarchar(max);        -- single line of text from @s
  DECLARE @NewLine nvarchar(max) = '
';

  DECLARE @Level int = 0, @LineBegins int = 1, @LineEnds int = 0;

  SET @s = CONVERT(nvarchar(max), @xml, 1);

  IF LEN(@s) > 2
  BEGIN
    SET @s = REPLACE(REPLACE(@s, '<', '|<'),'|</','</');                     -- Use | as new line markers
    SET @s = SUBSTRING(@s, 2, LEN(@s)-1);                                    -- remove fist |
    SET @s = REPLACE(@s, '></', '>|</') + '|';

    WHILE @LineBegins < LEN(@s)
    BEGIN
      SET @LineEnds = CHARINDEX('|', @s, @LineBegins+1);
      IF @LineEnds > 0
      BEGIN
        SET @ss = SUBSTRING(@s, @LineBegins, @LineEnds-@LineBegins);

        IF @ss LIKE '<_%>%<[/]_%>' OR @ss LIKE '<_%[/]>'                     -- one line tag on the same level
          SET @ret = @ret + REPLICATE('  ', @Level) + @ss + @NewLine
        ELSE IF @ss LIKE '<[/]_%>'                                           -- ending tag only
        BEGIN
          SET @Level = @Level - 1;
          SET @ret = @ret + REPLICATE('  ', @Level) + @ss + @NewLine;
        END 
        ELSE IF @ss LIKE '<[^/]%[^/]>'                                       -- starting tag only
        BEGIN
          SET @ret = @ret + REPLICATE('  ', @Level) + @ss + @NewLine;
          SET @Level = @Level + 1;
        END 
        ELSE SET @ret = @ret + @ss + @NewLine;                               -- any text string without tags

        SET @LineBegins = @LineEnds+1;
      END ELSE BREAK;
    END
    SET @ret = LEFT(@ret, LEN(@ret)-2);  -- Remove last CRLF
  END
  RETURN @ret
END
GO
