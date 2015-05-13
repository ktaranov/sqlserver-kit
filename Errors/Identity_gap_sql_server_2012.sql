IF OBJECT_ID('t1', 'U') IS NOT NULL
DROP TABLE t1;
GO

CREATE TABLE t1 (
	col1 INTEGER IDENTITY(1,1),
    col2 VARCHAR(10),
	col3 CHAR(10),
	col4 NCHAR(10),
	col5 TINYINT,
	col6 BIGINT
);
GO

INSERT INTO t1 (col2, col3, col4, col5, col6)
SELECT 'val1', 'val1', 'val1', 0, 0
UNION ALL
SELECT 'val2', 'val2', 'val2', 255, 255;

SELECT *
FROM t1;

DBCC CHECKIDENT('t1', 'NORESEED');

-- Restart SQL Server

DBCC CHECKIDENT('t1', 'NORESEED');

INSERT INTO t1 (col2, col3, col4, col5, col6)
VALUES ('val3', 'val3', 'val3', 10, 10),
       ('val4', 'val4', 'val4', 100, 100);

SELECT *,
       LEN(col1) AS integer_len,
       LEN(col2) AS varchar_len,
       LEN(col3) AS char_len,
	   LEN(col4) AS nchar_len,
	   LEN(col5) AS tinyint_len,
	   LEN(col6) AS bigint_len,
	   DATALENGTH(col1) AS integer_datalength,
	   DATALENGTH(col2) AS varchar_datalength,
	   DATALENGTH(col3) AS char_datalength,
	   DATALENGTH(col4) AS nchar_datalength,
	   DATALENGTH(col5) AS tinyint_datalength,
	   DATALENGTH(col6) AS  bigint_datalength
FROM t1;

-- DBCC CHECKIDENT('t1', 'RESEED', 5);

IF EXISTS (SELECT 1 FROM sys.all_objects sao WHERE sao.name = 't1' AND sao.type = 'U')
DROP TABLE t1
ELSE PRINT 'Table t1 not exist!';
GO

BEGIN TRY
SELECT --/*
       CAST(-1 AS tinyint),
	    1/0
       --*/ * FROM t1;
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() AS ERROR_NUMBER,
       ERROR_SEVERITY() AS ERROR_SEVERITY,
	   ERROR_STATE() AS ERROR_STATE,
	   ERROR_PROCEDURE() AS ERROR_PROCEDURE,
       ERROR_MESSAGE() AS ERROR_MESSAGE,
	   ERROR_LINE() AS ERROR_LINE;
END CATCH;