/*
Author: Alexandros Pappas
Original link: http://www.codeproject.com/Articles/1118722/SQL-Table-Hierarchy
*/

DECLARE @fkcolumns TABLE(name SYSNAME PRIMARY KEY, referencedtable SYSNAME, parenttable SYSNAME, referencedcolumns varchar(MAX), parentcolumns varchar(MAX))
INSERT @fkcolumns
SELECT 
    a.name,
    b.name,
    c.name,
    STUFF((
        SELECT ',' + c.name
        FROM sys.foreign_key_columns b
        INNER JOIN sys.columns c ON b.referenced_object_id = c.object_id
        AND b.referenced_column_id = c.column_id
        WHERE a.object_id = b.constraint_object_id
        FOR XML PATH('')), 1, 1, '') parentcolumns,
    STUFF((
        SELECT ',' + c.name
        FROM sys.foreign_key_columns b
        INNER JOIN sys.columns c ON b.parent_object_id = c.object_id
        AND b.parent_column_id = c.column_id
        WHERE a.object_id = b.constraint_object_id
        FOR XML PATH('')), 1, 1, '') childcolumns
FROM sys.foreign_keys a
INNER JOIN sys.tables b ON a.referenced_object_id = b.object_id
INNER JOIN sys.tables c ON a.parent_object_id = c.object_id;

DECLARE @fkrefs TABLE(referencedtable SYSNAME, parenttable SYSNAME, referencedcolumns varchar(MAX), parentcolumns varchar(MAX))
INSERT @fkrefs
SELECT *, 
    (SELECT TOP 1 b.referencedcolumns
     FROM @fkcolumns b
     WHERE a.referencedtable = b.referencedtable and a.parenttable = b.parenttable),
    STUFF((
        SELECT ';' + b.parentcolumns
        FROM @fkcolumns b
        WHERE a.referencedtable = b.referencedtable and a.parenttable = b.parenttable
        FOR XML PATH('')), 1, 1, '')
FROM (
    SELECT referencedtable, parenttable
    FROM @fkcolumns a
    GROUP BY referencedtable, parenttable
) a;

WITH fks(treelevel, treepath, tablename, referencedcolumns, parentcolumns) AS (
SELECT 1,
    CAST(a.name AS VARCHAR(MAX)),
    a.name,
    CAST('' AS VARCHAR(MAX)),
    CAST('' AS VARCHAR(MAX))
    FROM sys.tables a
    LEFT JOIN @fkrefs c ON a.name = c.parenttable AND c.referencedtable <> c.parenttable
    WHERE c.referencedtable IS NULL
    UNION ALL 
    SELECT treelevel + 1,
        CAST(a.treepath + '_' + b.parenttable AS varchar(MAX)),
        b.parenttable,
        b.referencedcolumns,
        b.parentcolumns
    FROM fks a
    INNER JOIN @fkrefs b ON a.tablename = b.referencedtable
    WHERE treelevel < 10)
SELECT treelevel,
    treepath,
    REPLICATE('|---- ', treelevel) + tablename tablename,
    referencedcolumns,
    parentcolumns
FROM fks
ORDER BY treepath;
