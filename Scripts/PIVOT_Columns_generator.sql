/*
<documentation>
  <summary>Generate numeric columns for PIVOT statement</summary>
  <returns>1 column</returns>
  <issues>No</issues>
  <created>2020-01-23 by Konstantin Taranov</created>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/PIVOT_Columns_generator.sql</sourceLink>
</documentation>
*/

DECLARE @i   int          = 1990;
DECLARE @s   varchar(max) = '';
DECLARE @sep varchar(10)  = ', ';

WHILE @i <= 2020
BEGIN
    SET @s = @s + '[' + CAST(@i AS varchar) + ']' + @sep;
    SET @i = @i + 1;
END;

SELECT LEFT(@s, DATALENGTH(@s) - DATALENGTH(@sep)) AS y;
