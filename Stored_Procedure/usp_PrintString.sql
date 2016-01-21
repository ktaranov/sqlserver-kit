IF OBJECT_ID('dbo.usp_PrintString', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.usp_PrintString AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_PrintString (@str VARCHAR(max))
AS
BEGIN
    DECLARE @line VARCHAR(max)
        ,@StartLocation INT
        ,@Length INT
        ,@TotalLength INT
        ,@Current INT

    SELECT @StartLocation = 1
        ,@TotalLength = datalength(@str)
        ,@Current = 1
        ,@Length = 0

    DECLARE @PrintLine NVARCHAR(max) = 
            'declare @pos int = 1
            while @pos <= len(@line)
            begin
                print substring(@line, @pos, 8000)
                select @pos = @pos + 8000
            end'

    WHILE @Current <= @TotalLength
    BEGIN
        IF (
                substring(@str, @Current, 2) IN (
                    CHAR(0x0D) + CHAR(0x0A)
                    ,CHAR(0x0A) + CHAR(0x0D)
                    )
                )
        BEGIN
            IF @Length <= 0
                PRINT ''
            ELSE
            BEGIN -- line
                SELECT @line = substring(@str, @StartLocation, @Length)

                EXEC sp_executesql @PrintLine
                    ,N'@Line varchar(max)'
                    ,@line
            END

            SELECT @StartLocation = @Current + 2
                ,@Current = @Current + 2
                ,@Length = 0

            CONTINUE;
        END
        ELSE IF (
                substring(@str, @Current, 1) IN (
                    CHAR(0x0D)
                    ,CHAR(0x0A)
                    )
                )
        BEGIN
            IF @Length <= 0
                PRINT ''
            ELSE
            BEGIN
                SELECT @line = substring(@str, @StartLocation, @Length)

                EXEC sp_executesql @PrintLine
                    ,N'@Line varchar(max)'
                    ,@line
            END

            SELECT @StartLocation = @Current + 1
                ,@Current = @Current + 1
                ,@Length = 0

            CONTINUE;
        END

        SELECT @Current = @Current + 1
            ,@Length = @Length + 1
    END

    IF (@StartLocation <= datalength(@str))
        PRINT substring(@str, @StartLocation, datalength(@str))
END;
GO
