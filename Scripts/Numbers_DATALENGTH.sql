SELECT DATALENGTH(CAST(99999999999999999999999999999999999999 AS decimal(38, 0))) AS DECIMAL38
     , DATALENGTH(CAST(          9999999999999999999999999999 AS decimal(28, 0))) AS DECIMAL28
     , DATALENGTH(CAST(                   9999999999999999999 AS decimal(19, 0))) AS DECIMAL19
     , DATALENGTH(CAST(                             999999999 AS decimal( 9, 0))) AS DECIMAL9
     , DATALENGTH(CAST(                                     9 AS decimal( 1, 0))) AS DECIMAL1
     , DATALENGTH(CAST(             1.797693134862315807E+308 AS float(53)))      AS FLOAT53
     , DATALENGTH(CAST(             9999999999999999999999999 AS float(25)))      AS FLOAT25
     , DATALENGTH(CAST(              999999999999999999999999 AS float(24)))      AS FLOAT24
     , DATALENGTH(CAST(                                     9 AS float( 1)))      AS FLOAT1
     , DATALENGTH(CAST(              999999999999999999999999 AS real))           AS "REAL"
     , DATALENGTH(CAST(                   9223372036854775807 AS bigint        )) AS "BIGINT"
     , DATALENGTH(CAST(                            2147483647 AS int           )) AS "INT"
     , DATALENGTH(CAST(                                 32600 AS smallint      )) AS "SMALLINT"
     , DATALENGTH(CAST(                                   255 AS tinyint       )) AS "TINYINT"
     , DATALENGTH(CAST(                                     0 AS bit           )) AS BIT0
     , DATALENGTH(CAST(             1.797693134862315807E+308 AS bit           )) AS BIT1
     , DATALENGTH(POWER(10.0, 37))                                                AS "Power10^37";
