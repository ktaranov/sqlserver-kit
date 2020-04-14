/*
<documentation>
  <summary>uniqueidentifier (UID) sorting demo</summary>
  <returns>Sorted UID CTE</returns>
  <created>2007-08-31 by Alberto Ferrari</created>
  <modified>2020-04-14 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Sort_UID_Demo.sql</sourceLink>
  <originalLink>https://web.archive.org/web/20181129024526/http://sqlblog.com:80/blogs/alberto_ferrari/archive/2007/08/31/how-are-guids-sorted-by-sql-server.aspx</originalLink>
</documentation>
*/


WITH CTE_UID AS (/*                       0 1 2 3  4 5  6 7  8 9  A B C D E F */
              SELECT ID =  1, UID = CAST('00000000-0000-0000-0000-010000000000' AS uniqueidentifier)
    UNION ALL SELECT ID =  2, UID = CAST('00000000-0000-0000-0000-000100000000' AS uniqueidentifier)
    UNION ALL SELECT ID =  3, UID = CAST('00000000-0000-0000-0000-000001000000' AS uniqueidentifier)
    UNION ALL SELECT ID =  4, UID = CAST('00000000-0000-0000-0000-000000010000' AS uniqueidentifier)
    UNION ALL SELECT ID =  5, UID = CAST('00000000-0000-0000-0000-000000000100' AS uniqueidentifier)
    UNION ALL SELECT ID =  6, UID = CAST('00000000-0000-0000-0000-000000000001' AS uniqueidentifier)
    UNION ALL SELECT ID =  7, UID = CAST('00000000-0000-0000-0100-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID =  8, UID = CAST('00000000-0000-0000-0010-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID =  9, UID = CAST('00000000-0000-0001-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 10, UID = CAST('00000000-0000-0100-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 11, UID = CAST('00000000-0001-0000-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 12, UID = CAST('00000000-0100-0000-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 13, UID = CAST('00000001-0000-0000-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 14, UID = CAST('00000100-0000-0000-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 15, UID = CAST('00010000-0000-0000-0000-000000000000' AS uniqueidentifier)
    UNION ALL SELECT ID = 16, UID = CAST('01000000-0000-0000-0000-000000000000' AS uniqueidentifier)
)
SELECT
    ID
    , UID
FROM CTE_UID
ORDER BY UID, ID;
