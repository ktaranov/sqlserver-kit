/*
<documentation>
  <summary>Find Foreign Key Chains For Tables</summary>
  <returns>nothing.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-08-20</created>
  <modified>2019-08-24 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Find_Foreign_Key_Chains_For_Tables.sql</sourceLink>
  <originalLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Find_Foreign_Key_Chains_For_Tables.sql</originalLink>
</documentation>
*/

WITH fk_tables AS
    (SELECT s1.name        AS from_schema
      , o1.name            AS from_table
      , s2.name            AS to_schema
      , o2.name            AS to_table
    FROM sys.foreign_keys  AS fk
    INNER JOIN sys.objects AS o1 ON fk.parent_object_id     = o1.object_id
    INNER JOIN sys.schemas AS s1 ON o1.schema_id            = s1.schema_id
    INNER JOIN sys.objects AS o2 ON fk.referenced_object_id = o2.object_id
    INNER JOIN sys.schemas AS s2 ON o2.schema_id            = s2.schema_id
    INNER JOIN (SELECT object_id, SUM(row_count) AS row_count
              FROM sys.dm_db_partition_stats
              WHERE index_id < 2
              GROUP BY object_id
              ) AS rc ON o1.object_id = rc.object_id
        /* For the purposes of finding dependency hierarchy
        we're not worried about self-referencing tables */
    WHERE NOT 
        (s1.name        = s2.name
            AND o1.name = o2.name
        )
    )
  , ordered_tables AS
    (SELECT s.name AS SchemaName
          , t.name AS TableName
          , 0      AS TableLevel
    FROM (SELECT name, schema_id FROM sys.tables) AS t
    INNER JOIN sys.schemas AS    s  ON t.schema_id = s.schema_id
    LEFT OUTER JOIN fk_tables AS fk ON s.name      = fk.from_schema AND t.name = fk.from_table
    WHERE fk.from_schema IS NULL
    UNION ALL
    SELECT fk.from_schema
         , fk.from_table
         , ot.TableLevel + 1
    FROM fk_tables AS fk
    INNER JOIN ordered_tables ot ON fk.to_schema = ot.SchemaName AND fk.to_table = ot.TableName
    )
  , final AS
    (SELECT    DISTINCT ot.SchemaName
      , ot.TableName
      , ot.TableLevel
    FROM ordered_tables ot
    INNER JOIN 
        (SELECT SchemaName
          , TableName
          , MAX(TableLevel) maxTableLevel
        FROM ordered_tables
        GROUP BY SchemaName 
          , TableName
        ) mx ON ot.SchemaName = mx.SchemaName AND ot.TableName = mx.TableName AND mx.maxTableLevel = ot.TableLevel
    )
SELECT QUOTENAME(final.SchemaName) + '.' + QUOTENAME(final.TableName) AS TableName
     , TableLevel
FROM final
WHERE(
        /* exclude some schemes by IN */
        final.SchemaName NOT IN ('dbo')
        /* exclude some tables by IN */
        AND final.TableName NOT IN ('Tep1')
        /* exclude some tables by mask */
        AND final.TableName NOT LIKE '%Temp'
    )
    /* add some tables by mask and with IN */
    OR final.TableName IN ('IPAdmin')
    OR final.TableName LIKE 'AspNet%'
    OR final.TableName LIKE 'Application%'
ORDER BY TableLevel;
