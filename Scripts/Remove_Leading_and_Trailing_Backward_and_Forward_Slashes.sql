/*
https://sqlperformance.com/2019/10/t-sql-queries/overlooked-t-sql-gems
*/

SELECT string, leading_slash_count, trailing_slash_count,
    STUFF(STUFF(string, LEN(string) - trailing_slash_count + 1,
trailing_slash_count, ''), 1, leading_slash_count, '') AS new_string
FROM ( VALUES
        (CAST('//\\ remove leading and trailing backward (\) and forward (/) slashes \\//' AS varchar(200))),
        ('//\\**remove leading and trailing backward (\) and forward (/) slashes**\\//')
) AS test_data(string)
CROSS APPLY (
SELECT PATINDEX('%[^/\]%', string) - 1 AS leading_slash_count,
        PATINDEX('%[^/\]%', REVERSE(string)) - 1 AS trailing_slash_count
) AS ca1;
