/*
https://docs.microsoft.com/en-us/sql/t-sql/data-types/float-and-real-transact-sql
*/

SELECT CAST(-2.22999999999999E-308     AS float(53)) AS "Float(53) Negative Max"
     , CAST(-1.797693134862315807E+308 AS float(53)) AS "Float(53) Negative Min"
     , CAST(+1.797693134862315807E+308 AS float(53)) AS "Float(53) Positive Max";


SET NOCOUNT ON;

DROP TABLE IF EXISTS t;
CREATE TABLE t (
     i int IDENTITY(1, 1) NOT NULL
   , f float(53)          NOT NULL
   , s varchar(100)       NOT NULL
);
GO

DECLARE @s varchar(100) = '+1.79';  /* +1.79 -2.22*/
DECLARE @i int = 1;
DECLARE @j int = 9;

WHILE (@i < 200 AND LEN(@s) < 22)
BEGIN
    BEGIN TRY
        SET @i = @i + 1;

        INSERT INTO t(f, s) SELECT CAST((@s + CAST(@j AS varchar) + 'E' + LEFT(@s, 1) + '308') AS float(53)), @s AS s;
        SET @s = (@s + CAST(@j AS varchar));
        SET @j = 9;
    END TRY

    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;
        SET @j = @j - 1;
    END CATCH
END;

SELECT i, f, s
FROM t
WHERE f = (SELECT MAX(f) AS FLOAT_MAX FROM t);
