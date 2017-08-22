/*
Author: Bert Wagner
Source link: https://blog.bertwagner.com/how-to-search-and-destroy-non-sargable-queries-on-your-server-ff9f57c7268e
*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @dbname SYSNAME;
SET @dbname = QUOTENAME(DB_NAME());

--WITH XMLNAMESPACES (DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')

SELECT
   stmt.value('(@StatementText)[1]', 'varchar(max)') AS [Query],
   query_plan AS [QueryPlan],
   sc.value('(.//Identifier/ColumnReference/@Schema)[1]', 'varchar(128)') AS [Schema]
   , sc.value('(.//Identifier/ColumnReference/@Table)[1]', 'varchar(128)') AS [Table]
   , sc.value('(.//Identifier/ColumnReference/@Column)[1]', 'varchar(128)') AS [Column]
   , CASE WHEN s.exist('.//TableScan') = 1 THEN 'TableScan' ELSE 'IndexScan' END AS [ScanType],
   sc.value('(@ScalarString)[1]', 'varchar(128)') AS [ScalarString]
FROM 
    sys.dm_exec_cached_plans AS cp
    CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
    CROSS APPLY query_plan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple') AS batch(stmt)
    CROSS APPLY stmt.nodes('.//RelOp[TableScan or IndexScan]') AS scan(s)
    CROSS APPLY s.nodes('.//ScalarOperator') AS scalar(sc)
WHERE
    s.exist('.//ScalarOperator[@ScalarString]!=""') = 1 
    AND sc.exist('.//Identifier/ColumnReference[@Database=sql:variable("@dbname")][@Schema!="[sys]"]') = 1
    AND sc.value('(@ScalarString)[1]', 'varchar(128)') IS NOT NULL;
