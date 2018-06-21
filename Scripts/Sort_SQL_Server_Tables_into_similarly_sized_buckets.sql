/*
Author: Bill Fellows
Original link: http://billfellows.blogspot.com/2018/04/sort-sql-server-tables-into-similarly_5.html
*/

SET NOCOUNT ON;
DECLARE
    @bucketCount tinyint = 6;

IF OBJECT_ID('tempdb..#work') IS NOT NULL
BEGIN
    DROP TABLE #work;
END

CREATE TABLE #work (
    _row    int IDENTITY(1, 1) NOT NULL,
    [SchemaName] sysname,
    [TableName] sysname,
    [RowsCounted]  bigint NOT NULL,
    GroupNumber     int NOT NULL,
    moved   tinyint NOT NULL,
    PRIMARY KEY CLUSTERED ([RowsCounted], _row)
);

WITH cte AS (
SELECT B.RowsCounted
,   B.SchemaName
,   B.TableName
    FROM
    (
        SELECT
            s.[Name] as [SchemaName]
        ,   t.[name] as [TableName]
        ,   SUM(p.rows) as [RowsCounted]
        FROM
            sys.schemas s
            LEFT OUTER JOIN 
                sys.tables t
                ON s.schema_id = t.schema_id
            LEFT OUTER JOIN 
                sys.partitions p
                ON t.object_id = p.object_id
            LEFT OUTER JOIN  
                sys.allocation_units a
                ON p.partition_id = a.container_id
        WHERE
            p.index_id IN (0,1)
            AND p.rows IS NOT NULL
            AND a.type = 1
        GROUP BY 
            s.[Name]
        ,   t.[name]
    ) B
);

INSERT INTO #work ([RowsCounted], SchemaName, TableName, GroupNumber, moved)
SELECT [RowsCounted], SchemaName, TableName, ROW_NUMBER() OVER (ORDER BY [RowsCounted]) % @bucketCount AS GroupNumber, 0
FROM cte;

WHILE (@@ROWCOUNT!=0)
WITH cte AS
(
    SELECT
        *
    ,   SUM(RowsCounted) OVER (PARTITION BY GroupNumber) - SUM(RowsCounted) OVER (PARTITION BY (SELECT NULL)) / @bucketCount AS _GroupNumberoffset
    FROM
        #work
)
UPDATE
    w
SET
    w.GroupNumber = (CASE w._row
                 WHEN x._pos_row THEN x._neg_GroupNumber
                 ELSE x._pos_GroupNumber
             END
            )
,   w.moved = w.moved + 1
FROM
    #work AS w
    INNER JOIN
    (
        SELECT TOP 1
            pos._row AS _pos_row
        ,   pos.GroupNumber AS _pos_GroupNumber
        ,   neg._row AS _neg_row
        ,   neg.GroupNumber AS _neg_GroupNumber
        FROM
            cte AS pos
            INNER JOIN
                cte AS neg
                ON pos._GroupNumberoffset > 0
                   AND neg._GroupNumberoffset < 0
                   AND
            --- To prevent infinite recursion:
            pos.moved < @bucketCount
                   AND neg.moved < @bucketCount
        WHERE --- must improve positive side's offset:
            ABS(pos._GroupNumberoffset - pos.RowsCounted + neg.RowsCounted) <= pos._GroupNumberoffset
            AND
            --- must improve negative side's offset:
            ABS(neg._GroupNumberoffset - neg.RowsCounted + pos.RowsCounted) <= ABS(neg._GroupNumberoffset)
        --- Largest changes first:
        ORDER BY
            ABS(pos.RowsCounted - neg.RowsCounted) DESC
    ) AS x
    ON w._row IN
       (
           x._pos_row
       ,   x._neg_row
       );

SELECT
    W.GroupNumber
,   COUNT_BIG(1) AS TotalTables
,   SUM(W.RowsCounted) AS GroupTotalRows
FROM
    #work AS W
GROUP BY
    W.GroupNumber
ORDER BY
    W.GroupNumber;

SELECT
    W.GroupNumber
,   W.SchemaName
,   W.TableName
,   W.RowsCounted
,   COUNT_BIG(1) OVER (PARTITION BY W.GroupNumber ORDER BY (SELECT NULL)) AS TotalTables
,   SUM(W.RowsCounted) OVER (PARTITION BY W.GroupNumber ORDER BY (SELECT NULL)) AS GroupTotalRows
FROM
    #work AS W
ORDER BY
    W.GroupNumber;
