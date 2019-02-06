/*
Author: Pinal Dave
Created Date: 2018-09-12
Original link: https://blog.sqlauthority.com/2018/09/12/sql-server-simple-method-to-extract-scale-part-from-decimal-number/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Extract_Scale_Part_From_Decimal_Number.sql
Modified: 2018-01-29 by Konstantin Taranov
*/

IF OBJECT_ID(N'tempdb..#Numbers', 'U') IS NOT NULL DROP TABLE #Numbers;

CREATE TABLE #Numbers (DecimalValue DECIMAL(16, 10) NOT NULL);

INSERT INTO #Numbers(DecimalValue) VALUES (100.0000000001);
INSERT INTO #Numbers(DecimalValue) VALUES (-23.8900000098);
INSERT INTO #Numbers(DecimalValue) VALUES (390.077);
INSERT INTO #Numbers(DecimalValue) VALUES (12.87);
INSERT INTO #Numbers(DecimalValue) VALUES (390.1);

SELECT DecimalValue
    , ABS(DecimalValue)%1 AS DecimalScale
 FROM #Numbers;
 GO
