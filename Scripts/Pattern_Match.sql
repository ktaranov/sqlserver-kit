/*
https://sqlserverfast.com/blog/hugo/2019/04/removing-multiple-patterns-from-a-string/
*/

IF OBJECT_ID('Number', N'U') IS NULL
BEGIN
       CREATE TABLE Number (
              N INT CONSTRAINT Number_PK PRIMARY KEY CLUSTERED(N)
              ); 
 
       WITH
              L0   AS(SELECT 1 AS C UNION ALL SELECT 1 AS O), -- 2 rows
              L1   AS(SELECT 1 AS C FROM L0 AS A CROSS JOIN L0 AS B), -- 4 rows
              L2   AS(SELECT 1 AS C FROM L1 AS A CROSS JOIN L1 AS B), -- 16 rows
              L3   AS(SELECT 1 AS C FROM L2 AS A CROSS JOIN L2 AS B), -- 256 rows
              L4   AS(SELECT 1 AS C FROM L3 AS A CROSS JOIN L3 AS B), -- 65,536 rows
              L5   AS(SELECT 1 AS C FROM L4 AS A CROSS JOIN L4 AS B), -- 4,294,967,296 rows
              Nums AS(SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS N FROM L5)
 
       INSERT INTO Number SELECT TOP 10000 N FROM Nums ORDER BY N;
END 

DECLARE @test table
    (PartNo varchar(50) NOT NULL PRIMARY KEY);
INSERT  @test
VALUES ('ABC-12%D^^^E3T'),
       ('AB345%6%-44%^^^^No.XXXNo.W8RNo.8R8D');


WITH Patterns
  AS (SELECT    Pattern,
                Length
      FROM      (VALUES ('%-[0-9][0-9][%]%', 4),        -- -@@%
                        ('%[0-9][0-9][%]%', 3),         -- @@%
                        ('%-[0-9][%]%', 3),             -- -@%
                        ('%[0-9][%]%', 2),              -- @%
                        ('%No.[A-Z][A-Z0-9][A-Z]%', 6), -- No.X#X
                        ('%^^^%', 3),                   -- ^^^
                        ('%[0-9][A-Z]', 2)              -- @X (end of string)
      ) AS Patterns (Pattern, Length) )
SELECT  t.PartNo,
        (SELECT SUBSTRING(t.PartNo, n.N, 1)
         FROM   dbo.Number AS n
         WHERE  n.N BETWEEN 1
                    AND     LEN(t.PartNo)
         AND    NOT EXISTS (SELECT  *
                            FROM    Patterns AS p
                            WHERE   PATINDEX(
                                        p.Pattern,
                                        STUFF(t.PartNo,
                                              1,
                                              CASE WHEN n.N > p.Length
                                                   THEN n.N - p.Length
                                                   ELSE 0
                                              END,
                                              '')) BETWEEN 1
                                                       AND CASE WHEN n.N > p.Length
                                                                THEN p.Length
                                                                ELSE n.N
                                                           END)
        ORDER BY n.N
        FOR XML PATH(''))
FROM    @test AS t;
