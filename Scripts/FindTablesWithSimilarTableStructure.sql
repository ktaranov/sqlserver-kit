/*
Author: Jana Sattainathan
Original link: https://sqljana.wordpress.com/2017/03/31/sql-server-find-tables-with-similar-table-structure
*/

WITH ColCountsByTable
AS
(
      SELECT
            c.TABLE_CATALOG,
            c.TABLE_SCHEMA,
            c.TABLE_NAME,
            COUNT(1) AS Column_Count
      FROM INFORMATION_SCHEMA.COLUMNS c
      /*
      --Plug in the schema and table name to get similar views/tables just for one or more tables
      WHERE
            c.TABLE_SCHEMA = 'TransactionPreProcessing'
            AND c.TABLE_NAME IN ('PreStagingTransaction')
      */
      GROUP BY
            c.TABLE_CATALOG,
            c.TABLE_SCHEMA,
            c.TABLE_NAME
)
SELECT
      100 * COUNT(c2.COLUMN_NAME) /*Matching_Column_Count*/ / MIN(ColCountsByTable.Column_Count) /*Column_Count*/ AS Match_Percent,
      c.TABLE_CATALOG,
      c.TABLE_SCHEMA,
      c.TABLE_NAME,
      DENSE_RANK() OVER(ORDER BY c.TABLE_CATALOG, c.TABLE_SCHEMA, c.TABLE_NAME) Table_Rank,
      MIN(ColCountsByTable.Column_Count) AS Column_Count,
      c2.TABLE_CATALOG AS Matching_Catalog,
      c2.TABLE_SCHEMA AS Matching_Schema,
      c2.TABLE_NAME AS Matching_Table,
      COUNT(c2.COLUMN_NAME) AS Matching_Column_Count
FROM INFORMATION_SCHEMA.TABLES t
      INNER JOIN INFORMATION_SCHEMA.COLUMNS c
            ON t.TABLE_CATALOG = c.TABLE_CATALOG
                  AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
                  AND t.TABLE_NAME = c.TABLE_NAME
      INNER JOIN ColCountsByTable
            ON t.TABLE_CATALOG = ColCountsByTable.TABLE_CATALOG
                  AND t.TABLE_SCHEMA = ColCountsByTable.TABLE_SCHEMA
                  AND t.TABLE_NAME = ColCountsByTable.TABLE_NAME
      LEFT OUTER JOIN INFORMATION_SCHEMA.COLUMNS c2
            ON t.TABLE_NAME != c2.TABLE_NAME
                  AND c.COLUMN_NAME = c2.COLUMN_NAME
GROUP BY
      c.TABLE_CATALOG,
      c.TABLE_SCHEMA,
      c.TABLE_NAME,
      c2.TABLE_CATALOG,
      c2.TABLE_SCHEMA,
      c2.TABLE_NAME
--Use the below HAVING clause if you want to restrict results to only matches above a certain percent
--HAVING
--    /*Match_Percent*/
--    (100 * COUNT(c2.COLUMN_NAME) /*Matching_Column_Count*/) / MIN(ColCountsByTable.Column_Count) /*Column_Count*/
--          >= 50       --Require atleast 50% of the columns to match
ORDER BY
      Match_Percent DESC