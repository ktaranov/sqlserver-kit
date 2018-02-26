SELECT DATALENGTH(CAST(99999999999999999999999999999999999999 AS DECIMAL(38, 0))) AS DECIMAL38
     , DATALENGTH(CAST(          9999999999999999999999999999 AS DECIMAL(28, 0))) AS DECIMAL28
     , DATALENGTH(CAST(                   9999999999999999999 AS DECIMAL(19, 0))) AS DECIMAL19
     , DATALENGTH(CAST(                       999999999999999 AS DECIMAL(15, 0))) AS DECIMAL15
     , DATALENGTH(CAST(                   9223372036854775807 AS BIGINT        )) AS [BIGINT]
   -- Arithmetic overflow error converting expression to data type bigint.
   --, DATALENGTH(CAST(                   9223372036854775808 AS BIGINT)) AS [BIGINT]
     , DATALENGTH(CAST(                             999999999 AS DECIMAL( 9, 0))) AS DECIMAL9
     , DATALENGTH(CAST(                            2147483647 AS INT           )) AS [INT]
     , DATALENGTH(CAST(                                 32600 AS SMALLINT      )) AS [SMALLINT]
     , DATALENGTH(CAST(                                   255 AS TINYINT       )) AS [TINYINT]
     , DATALENGTH(CAST(                                     9 AS DECIMAL( 1, 0))) AS DECIMAL1
     , DATALENGTH(POWER(10.0, 37)) AS [Power10^37];
