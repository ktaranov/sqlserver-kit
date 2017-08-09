/*
Author: Jonathan Kehayias
Original link: https://www.sqlskills.com/blogs/jonathan/finding-implicit-column-conversions-in-the-plan-cache
Desctiption: Finding Implicit Column Conversions in the Plan Cache
*/


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @dbname SYSNAME
SET @dbname = QUOTENAME(DB_NAME());

WITH XMLNAMESPACES
   (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT
   stmt.value('(@StatementText)[1]', 'varchar(max)'),
   t.value('(ScalarOperator/Identifier/ColumnReference/@Schema)[1]', 'varchar(128)'),
   t.value('(ScalarOperator/Identifier/ColumnReference/@Table)[1]', 'varchar(128)'),
   t.value('(ScalarOperator/Identifier/ColumnReference/@Column)[1]', 'varchar(128)'),
   ic.DATA_TYPE AS ConvertFrom,
   ic.CHARACTER_MAXIMUM_LENGTH AS ConvertFromLength,
   t.value('(@DataType)[1]', 'varchar(128)') AS ConvertTo,
   t.value('(@Length)[1]', 'int') AS ConvertToLength,
   query_plan
FROM sys.dm_exec_cached_plans AS cp
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS qp
CROSS APPLY query_plan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple') AS batch(stmt)
CROSS APPLY stmt.nodes('.//Convert[@Implicit="1"]') AS n(t)
JOIN INFORMATION_SCHEMA.COLUMNS AS ic
   ON QUOTENAME(ic.TABLE_SCHEMA) = t.value('(ScalarOperator/Identifier/ColumnReference/@Schema)[1]', 'varchar(128)')
   AND QUOTENAME(ic.TABLE_NAME) = t.value('(ScalarOperator/Identifier/ColumnReference/@Table)[1]', 'varchar(128)')
   AND ic.COLUMN_NAME = t.value('(ScalarOperator/Identifier/ColumnReference/@Column)[1]', 'varchar(128)')
WHERE t.exist('ScalarOperator/Identifier/ColumnReference[@Database=sql:variable("@dbname")][@Schema!="[sys]"]') = 1
