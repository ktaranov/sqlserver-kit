IF OBJECT_ID('dbo.udf_ConvertHexLSN') IS NULL
   EXECUTE ('CREATE FUNCTION udf_ConvertHexLSN() RETURNS TABLE AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_ConvertHexLSN(
    @lsnc varchar(25)
)
/*
Author: Max Vernon
Original link: https://www.sqlserverscience.com/internals/convert-lsn-hex-decimal/

SELECT * FROM dbo.udf_ConvertHexLSN('00000268:0000356c:0001');
*/
RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN
    (
        SELECT TOP(1)
               LSNd = CONVERT(varchar(8), CONVERT(int, CONVERT(varbinary(8), '0x' + CONVERT(varchar(10),      LEFT(@lsnc, 8), 0), 1), 1))
              + ':' + CONVERT(varchar(8), CONVERT(int, CONVERT(varbinary(8), '0x' + CONVERT(varchar(10), SUBSTRING(@lsnc, 10, 8), 0), 1)), 1)
              + ':' + CONVERT(varchar(8), CONVERT(int, CONVERT(varbinary(8), '0x' + CONVERT(varchar(10),     RIGHT(@lsnc, 4), 0), 1), 1))
    );
GO
