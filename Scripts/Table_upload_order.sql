/*
Author:
Link:
*/

WITH fk_tables AS 
    (SELECT s1.name        AS from_schema
      , o1.name            AS from_table
      , s2.name            AS to_schema
      , o2.name            AS to_table
    FROM sys.foreign_keys     fk
    INNER JOIN sys.objects    o1 ON fk.parent_object_id     = o1.object_id
    INNER JOIN sys.schemas    s1 ON o1.schema_id            = s1.schema_id
    INNER JOIN sys.objects    o2 ON fk.referenced_object_id = o2.object_id
    INNER JOIN sys.schemas    s2 ON o2.schema_id            = s2.schema_id
    INNER JOIN (SELECT object_id, SUM(row_count) AS row_count
              FROM sys.dm_db_partition_stats
              WHERE index_id < 2
              GROUP BY object_id
              ) AS rc ON o1.object_id            = rc.object_id
        /*For the purposes of finding dependency hierarchy
        we're not worried about self-referencing tables*/
    WHERE NOT 
        (s1.name        = s2.name
            AND o1.name = o2.name 
        )
    )
  , ordered_tables AS
    (SELECT s.name AS schemaName
      , t.name     AS tableName
      , 0          AS TableLevel
    FROM(SELECT    *
        FROM sys.tables
        )                     t
    INNER JOIN sys.schemas    s  ON t.schema_id = s.schema_id
    LEFT OUTER JOIN fk_tables fk ON s.name      = fk.from_schema AND t.name = fk.from_table
    WHERE fk.from_schema                  IS NULL
    UNION ALL
    SELECT fk.from_schema
      , fk.from_table
      , ot.TableLevel +       1
    FROM fk_tables            fk
    INNER JOIN ordered_tables ot ON fk.to_schema = ot.schemaName AND fk.to_table = ot.tableName
    )
  , final AS
    (SELECT    DISTINCT ot.schemaName
      , ot.tableName
      , ot.TableLevel
    FROM ordered_tables ot
    INNER JOIN 
        (SELECT schemaName
          , tableName
          , MAX(TableLevel) maxTableLevel
        FROM ordered_tables
        GROUP BY schemaName 
          , tableName
        ) mx ON ot.schemaName = mx.schemaName AND ot.tableName = mx.tableName AND mx.maxTableLevel = ot.TableLevel
    )
SELECT QUOTENAME(final.schemaName) + '.' + QUOTENAME(final.tableName)
     , TableLevel
FROM final
WHERE(
        -- exclude some schemes by IN
        final.schemaName NOT IN('dbo' 
                              , 'consumption')
        -- exclude some tables by IN
        AND final.tableName NOT IN('TP6'
                                 , 'WorldScenarioResult')
        -- exclude some tables by mask
        AND final.tableName NOT LIKE '%Temp'
    )
    -- add some tables by mask and with IN
    OR final.tableName IN('IPAdmin')
    OR final.tableName LIKE 'AspNet%'
    OR final.tableName LIKE 'Application%'
ORDER BY TableLevel;