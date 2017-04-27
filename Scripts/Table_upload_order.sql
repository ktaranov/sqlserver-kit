/*
Author:
Link:
*/

WITH fk_tables AS (
    select    s1.name as from_schema
    ,        o1.Name as from_table
    ,        s2.name as to_schema
    ,        o2.Name as to_table
    from    sys.foreign_keys fk
    inner    join sys.objects o1
    on        fk.parent_object_id = o1.object_id
    inner    join sys.schemas s1
    on        o1.schema_id = s1.schema_id
    inner    join sys.objects o2
    on        fk.referenced_object_id = o2.object_id
    inner    join sys.schemas s2
    on        o2.schema_id = s2.schema_id
    /*For the purposes of finding dependency hierarchy
        we're not worried about self-referencing tables*/
    where    not    (    s1.name = s2.name
            and        o1.name = o2.name)
)
,ordered_tables AS 
(        SELECT    s.name as schemaName
        ,        t.name as tableName
        ,        0 AS TableLevel
        FROM    (    select    *
                     from    sys.tables
                    ) t
        INNER    JOIN sys.schemas s
        on        t.schema_id = s.schema_id
        LEFT    OUTER JOIN fk_tables fk
        ON        s.name = fk.from_schema
        AND        t.name = fk.from_table
        WHERE    fk.from_schema IS NULL
        UNION    ALL
        SELECT    fk.from_schema
        ,        fk.from_table
        ,        ot.TableLevel + 1
        FROM    fk_tables fk
        INNER    JOIN ordered_tables ot
        ON        fk.to_schema = ot.schemaName
        AND        fk.to_table = ot.tableName
)
,final AS
(
select    distinct    ot.schemaName
,        ot.tableName
,        ot.TableLevel
from    ordered_tables ot
inner    join (
        select    schemaName
        ,        tableName
        ,        MAX(TableLevel) maxTableLevel
        from    ordered_tables
        group    by schemaName,tableName
        ) mx
on        ot.schemaName = mx.schemaName
and        ot.tableName = mx.tableName
and        mx.maxTableLevel = ot.TableLevel
)
SELECT QUOTENAME(final.schemaName) + '.' + QUOTENAME(final.tableName)
  FROM final
 WHERE (
           -- exclude some schemes by IN
           final.schemaName NOT IN ('dbo', 'consumption')
           -- exclude some tables by IN
           AND final.tableName NOT IN (
                 'TP6'
               , 'WorldScenarioResult'
           )
           -- exclude some tables by mask
           AND final.tableName NOT LIKE '%Temp'
      )
      -- add some tables by mask and with IN
      OR final.tableName IN ('IPAdmin')
      OR final.tableName LIKE 'AspNet%'
      OR final.tableName LIKE 'Application%'
ORDER BY TableLevel;
