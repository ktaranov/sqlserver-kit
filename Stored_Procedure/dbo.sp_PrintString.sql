IF OBJECT_ID('dbo.sp_PrintString', 'P') IS NULL
    EXEC ('CREATE PROCEDURE dbo.sp_PrintString AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_PrintString (
    @str NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @line NVARCHAR(MAX),
            @startLocation INT = 1,
            @length INT = 0,
            @totalLength INT = DATALENGTH(@str),
            @current INT = 1;

    DECLARE @PrintLine NVARCHAR(MAX) = 
        N'
        DECLARE @pos INT = 1
        WHILE @pos <= LEN(@line)
        BEGIN
            PRINT SUBSTRING(@line, @pos, 4000);
            SET @pos = @pos + 4000;
        END;';

    WHILE @current <= @totalLength
    BEGIN
        IF SUBSTRING(@str, @current, 2) IN (
                CHAR(0x0D) + CHAR(0x0A),
                CHAR(0x0A) + CHAR(0x0D)
            )
        BEGIN
            IF @length <= 0
                PRINT '';
            ELSE
            BEGIN
                SELECT @line = SUBSTRING(@str, @startLocation, @length);
                EXEC sp_executesql @PrintLine, N'@line NVARCHAR(MAX)', @line;
            END

            SELECT @startLocation = @current + 2,
                   @current = @current + 2,
                   @length = 0;

            CONTINUE;
        END
        ELSE IF SUBSTRING(@str, @current, 1) IN (CHAR(0x0D), CHAR(0x0A))
        BEGIN
            IF @length <= 0
                PRINT '';
            ELSE
            BEGIN
                SELECT @line = SUBSTRING(@str, @startLocation, @length);
                EXEC sp_executesql @PrintLine, N'@line NVARCHAR(MAX)', @line;
            END

            SELECT @startLocation = @current + 1,
                   @current = @current + 1,
                   @length = 0;

            CONTINUE;
        END

        SELECT @current = @current + 1,
               @length = @length + 1;
    END

    IF @startLocation <= DATALENGTH(@str)
        PRINT SUBSTRING(@str, @startLocation, DATALENGTH(@str));
END;
GO
