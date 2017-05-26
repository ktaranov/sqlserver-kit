/*
Author: Daniel Hutmacher
Original link: https://sqlsunday.com/2017/04/10/guessing-fk-constraints
*/

DECLARE @referenced TABLE (
    [object_id]        int NOT NULL,
    index_id        int NOT NULL,
    column_name        sysname NOT NULL,
    user_type_id    int NOT NULL,
    PRIMARY KEY CLUSTERED ([object_id], index_id, column_name)
);

INSERT INTO @referenced ([object_id], index_id, column_name, user_type_id)
SELECT t.[object_id], i.index_id, c.[name] AS column_name, c.user_type_id
FROM sys.tables AS t
INNER JOIN sys.indexes AS i ON t.[object_id]=i.[object_id]
INNER JOIN sys.index_columns AS ic ON i.[object_id]=ic.[object_id] AND i.index_id=ic.index_id
INNER JOIN sys.columns AS c ON ic.[object_id]=c.[object_id] AND ic.column_id=c.column_id
WHERE c.is_nullable=0 AND i.[type] IN (1, 2) AND i.is_unique=1 AND ic.key_ordinal>0;

WITH referenced AS (
    SELECT *, COUNT(*) OVER (
               PARTITION BY [object_id], index_id) AS col_count
    FROM @referenced),

     work AS (
    SELECT COUNT(*) OVER (
               PARTITION BY r.[object_id], r.index_id, t.[object_id]) AS referencing_count,
           r.col_count AS referenced_count, r.index_id,
           t.[object_id] AS referencing_tbl, c.[name] AS referencing_col,
           r.[object_id] AS referenced_tbl,  r.column_name AS referenced_col
    FROM referenced AS r
    INNER JOIN sys.tables AS t ON
        r.[object_id]!=t.[object_id]
    INNER JOIN sys.columns AS c ON
        t.[object_id]=c.[object_id] AND
        --- This is where the column naming logic
        --- can be customized:
        c.[name]=r.column_name AND
        c.user_type_id=r.user_type_id)

SELECT fk.[name] AS [Existing FK],
       'ALTER TABLE '+ts.[name]+'.'+t.[name]+
           ' ADD CONSTRAINT '+
           ISNULL(fk.[name], 'FK_'+rs.[name]+'_'+r.[name]+'_'+ts.[name]+'_'+t.[name])+
           ' FOREIGN KEY ('+x.referencing_columns+')'+
           ' REFERENCES '+rs.[name]+'.'+r.[name]+' ('+x.referenced_columns+')' AS Syntax
FROM work
INNER JOIN sys.tables AS r ON work.referenced_tbl=r.[object_id]
INNER JOIN sys.schemas AS rs ON r.[schema_id]=rs.[schema_id]
INNER JOIN sys.tables AS t ON work.referencing_tbl=t.[object_id]
INNER JOIN sys.schemas AS ts ON t.[schema_id]=ts.[schema_id]
LEFT JOIN sys.foreign_keys AS fk ON
    work.referencing_tbl=fk.parent_object_id AND
    work.referenced_tbl=fk.referenced_object_id
CROSS APPLY (
    SELECT
        SUBSTRING(CAST((
            SELECT ', '+w.referencing_col
            FROM work AS w
            WHERE w.referencing_tbl=work.referencing_tbl AND
                  w.referenced_tbl=work.referenced_tbl AND
                  w.index_id=work.index_id
            ORDER BY w.referencing_col
            FOR XML PATH(''), TYPE) AS varchar(4000)), 3, 4000),
        SUBSTRING(CAST((
            SELECT ', '+w.referenced_col
            FROM work AS w
            WHERE w.referencing_tbl=work.referencing_tbl AND
                  w.referenced_tbl=work.referenced_tbl AND
                  w.index_id=work.index_id
            ORDER BY w.referencing_col
            FOR XML PATH(''), TYPE) AS varchar(4000)), 3, 4000)
    ) AS x(referencing_columns, referenced_columns)
WHERE work.referencing_count=work.referenced_count
GROUP BY ts.[name], t.[name], rs.[name], r.[name], x.referencing_columns, x.referenced_columns, fk.[name]
ORDER BY Syntax;
