IF OBJECT_ID('dbo.usp_PrintString', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.usp_PrintString AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_PrintString (
                @str NVARCHAR(MAX)
)
AS
/*
EXEC dbo.usp_PrintString REPLICATE(¸, 5000);
*/
BEGIN
    DECLARE @line          NVARCHAR(MAX)
          , @StartLocation INT
          , @Length        INT
          , @TotalLength   INT
          , @Current       INT

    SELECT @StartLocation = 1
        ,@TotalLength = DATALENGTH(@str)
        ,@Current = 1
        ,@Length = 0

    DECLARE @PrintLine NVARCHAR(MAX) = 
            N'DECLARE @pos int = 1
            WHILE @pos <= LEN(@line)
            BEGIN
                PRINT SUBSTRING(@line, @pos, 4000);
                SET @pos = @pos + 4000;
            END;'

    WHILE @Current <= @TotalLength
    BEGIN
        IF (
                SUBSTRING(@str, @Current, 2) IN (
                    CHAR(0x0D) + CHAR(0x0A)
                    ,CHAR(0x0A) + CHAR(0x0D)
                    )
                )
        BEGIN
            IF @Length <= 0
                PRINT '';
            ELSE
            BEGIN -- line
                SELECT @line = SUBSTRING(@str, @StartLocation, @Length);

                EXEC sp_executesql @PrintLine
                    ,N'@line NVARCHAR(max)'
                    ,@line;
            END

            SELECT @StartLocation = @Current + 2
                ,@Current = @Current + 2
                ,@Length = 0;

            CONTINUE;
        END
        ELSE IF (
                SUBSTRING(@str, @Current, 1) IN (
                    CHAR(0x0D)
                    ,CHAR(0x0A)
                    )
                )
        BEGIN
            IF @Length <= 0
                PRINT '';
            ELSE
            BEGIN
                SELECT @line = SUBSTRING(@str, @StartLocation, @Length);

                EXEC sp_executesql @PrintLine
                    ,N'@line NVARCHAR(max)'
                    ,@line;
            END

            SELECT @StartLocation = @Current + 1
                ,@Current = @Current + 1
                ,@Length = 0;

            CONTINUE;
        END

        SELECT @Current = @Current + 1
             , @Length  = @Length  + 1;
    END

    IF (@StartLocation <= DATALENGTH(@str))
        PRINT SUBSTRING(@str, @StartLocation, DATALENGTH(@str))
END;
GO
