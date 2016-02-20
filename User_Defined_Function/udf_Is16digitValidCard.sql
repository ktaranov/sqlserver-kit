/*
Original link: https://www.simple-talk.com/blogs/2016/02/16/the-luhn-algorithm-in-sql/
Author: Phil Factor
*/
IF OBJECT_ID(N'dbo.udf_Is16digitValidCard', N'FN') IS NULL
EXECUTE('CREATE FUNCTION dbo.udf_Is16digitValidCard() RETURNS INT AS BEGIN RETURN 1 END;');
GO


ALTER FUNCTION dbo.udf_Is16digitValidCard(
    @Card CHAR(16)
)
RETURNS TINYINT
AS
/*
SELECT dbo.udf_Is16digitValidCard('5019710710103742')
*/
BEGIN
        RETURN  CASE
                WHEN @Card LIKE '%[^0-9]%' THEN 0
                WHEN @Card IS NULL THEN 0
                WHEN    (
                        + 2 * CAST(SUBSTRING(@Card, 1, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 1, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 2, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 3, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 3, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 4, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 5, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 5, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 6, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 7, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 7, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 8, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 9, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 9, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 10, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 11, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 11, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 12, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 13, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 13, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 14, 1) AS TINYINT)
                        + 2 * CAST(SUBSTRING(@Card, 15, 1) AS TINYINT) / 10
                        + 2 * CAST(SUBSTRING(@Card, 15, 1) AS TINYINT) % 10
                        + CAST(SUBSTRING(@Card, 16, 1) AS TINYINT)
                ) % 10 = 0 THEN 1
                ELSE 0
        END;
END;
GO
