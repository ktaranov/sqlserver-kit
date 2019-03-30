IF OBJECT_ID(N'dbo.udf_ListAllUnicodeCodePoints', N'IF') IS NULL
   EXEC (N'CREATE FUNCTION dbo.udf_ListAllUnicodeCodePoints() RETURNS TABLE AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_ListAllUnicodeCodePoints
/*
<documentation>
  <author>Solomon Rutzky</author>
  <summary>List All Unicode Code Points.</summary>
  <returns>List of 188657 Unicode Code Points.</returns>
  <created>2019-03-25</created>
  <modified>2019-03-30</modified>
  <example>
  List some emoji:
  <code>
      SELECT cp.*
      FROM   dbo.udf_ListAllUnicodeCodePoints() cp
      WHERE  cp.[CdPntINT] BETWEEN 0x1F000 AND 0x1F9FF;
  </code>
  </example>
  <example>
  List the Tibetan characters, sorted naturally for that language:
  <code>
      SELECT cp.*
      FROM   dbo.ListAllUnicodeCodePoints() cp
      WHERE  cp.[CdPntINT] BETWEEN 0x0F00 AND 0x0FFF -- Tibetan
      ORDER BY  cp.[Char] COLLATE Nepali_100_CS_AS;
  </code>
  </example>
</documentation>
*/
()
RETURNS TABLE
AS RETURN
WITH nums AS
(
  SELECT TOP(1114111) (ROW_NUMBER() OVER
                      (ORDER BY @@MICROSOFTVERSION) - 1) AS [num]
  FROM   master.sys.all_columns AS ac1
  CROSS JOIN master.sys.all_columns AS ac2
), chars AS
(
  SELECT n.[num], /* pass-through */
         RIGHT(CONVERT(CHAR(6), CONVERT(BINARY(3), n.[num]), 2),
             CASE
              WHEN n.[num] > 65535 THEN 5
              ELSE 4
             END) AS [CodePointHex],
         CASE
           WHEN n.[num] > 65535 THEN 55232 + (n.[num] / 1024)
           ELSE NULL
         END AS [HighSurrogateINT],
         CASE
           WHEN n.[num] > 65535 THEN 56320 + (n.[num] % 1024)
           ELSE NULL END AS [LowSurrogateINT]
  FROM   nums n
  WHERE  n.[num] BETWEEN 0x000000 AND 0x014700 /* filter out 925,455 */
  OR     n.[num] BETWEEN 0x016800 AND 0x030000 /* unmapped code */
  OR     n.[num] BETWEEN 0x0E0001 AND 0x0E01EF /* points */
)
SELECT
       'U+' + c.[CodePointHex] AS [CodePoint],
       c.[num] AS [CdPntINT],
       '0x' + c.[CodePointHex] AS [CdPntBIN],
       CASE
         WHEN c.[num] > 65535 THEN NCHAR(c.[HighSurrogateINT])
           + NCHAR(c.[LowSurrogateINT])
         ELSE NCHAR(c.[num])
       END AS [Char],
       CASE
         WHEN c.[num] > 65535 THEN CONVERT(CHAR(10), CONVERT(BINARY(4),
           NCHAR(c.[HighSurrogateINT]) + NCHAR(c.[LowSurrogateINT])), 1)
         ELSE CONVERT(CHAR(6), CONVERT(BINARY(2), NCHAR(c.[num])), 1)
       END AS [UTF-16LE       ],
       c.[HighSurrogateINT] AS [HighSrgtINT],
       c.[LowSurrogateINT] AS [LowSrgtINT],
       CONVERT(BINARY(2), c.[HighSurrogateINT]) AS [HighSrgtBIN],
       CONVERT(BINARY(2), c.[LowSurrogateINT]) AS [LowSrgtBIN],
       'NCHAR(' + CASE
                    WHEN c.[num] > 65535 THEN CONVERT(CHAR(6), CONVERT(BINARY(2), c.[HighSurrogateINT]), 1)
                      + ') + NCHAR(' + CONVERT(CHAR(6),
                      CONVERT(BINARY(2), c.[LowSurrogateINT]), 1)
                    ELSE CONVERT(CHAR(6), CONVERT(BINARY(2), c.[num]), 1)
                  END + ')'
         AS [T-SQL                                                  ],
       '&#x' + c.[CodePointHex] + ';' AS [HTML        ],
       '\x' + CASE
                WHEN c.[num] > 65535 THEN CONVERT(CHAR(4),
                  CONVERT(BINARY(2), c.[HighSurrogateINT]), 2) + '\x'
                  + CONVERT(CHAR(4), CONVERT(BINARY(2),
                  c.[LowSurrogateINT]), 2)
                ELSE CONVERT(CHAR(4), CONVERT(BINARY(2), c.[num]), 2)
         END AS [C/C++/C#/Java/?]
FROM   chars c;
GO
