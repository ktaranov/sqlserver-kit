/*
Author: Shane O'Neill
Source link: https://nocolumnname.wordpress.com/2017/04/20/stop-hammer-pivot/
*/

SELECT Pivot1.ColumnName,
       Pivot1.[dbo.DifferenceTable01],
       Pivot1.[dbo.DifferenceTable02],
       CASE WHEN [dbo.DifferenceTable01] = 1 AND [dbo.DifferenceTable02] = 1
            THEN 'Both'
            WHEN [dbo.DifferenceTable01] = 1 AND [dbo.DifferenceTable02] IS NULL
            THEN 'Table 1 only'
            WHEN [dbo.DifferenceTable01] IS NULL AND [dbo.DifferenceTable02] = 1
            THEN 'Table 2 only'
            ELSE 'Eh...this should not really happen'
      END AS HumanReadableFormat
FROM (  SELECT 
            c.[name] AS ColumnName,
            tb.TableName,
            1 AS ColumnExists
        FROM sys.columns AS c
        RIGHT JOIN (    VALUES 
                        (OBJECT_ID(N'dbo.DifferenceTable01', N'U'), 'dbo.DifferenceTable01'),
                        (OBJECT_ID(N'dbo.DifferenceTable02', N'U'), 'dbo.DifferenceTable02')
                   ) AS tb (ObjectID, TableName)
            ON c.object_id = tb.ObjectID
     ) AS UnPivotedColumns
PIVOT (
    MAX(ColumnExists) FOR TableName IN ([dbo.DifferenceTable01], [dbo.DifferenceTable02])
      ) AS Pivot1
ORDER BY Pivot1.ColumnName ASC;
