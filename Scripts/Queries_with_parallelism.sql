/*
Author: Eitan Blumin
Source link: http://www.madeiradata.com/cost-threshold-for-parallelism-and-how-to-increase-it-properly/
*/

DECLARE
      @MinUseCount			INT	= 50	-- Set minimum usecount to ignore rarely-used plans
    , @CurrentCostThreshold		FLOAT	= 5	-- Serves as minimum sub-tree cost
    , @MaxSubTreeCost		FLOAT	= 30	-- Set the maximum sub-tree cost, plans with higher cost than this wouldn't normally interest us

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT @CurrentCostThreshold = CONVERT(FLOAT, value_in_use)
FROM sys.configurations
WHERE [name] = 'cost threshold for parallelism';

WITH XMLNAMESPACES   
(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT *
FROM
(
SELECT
     ecp.plan_handle,
     CompleteQueryPlan		= query_plan, 
     StatementText		= n.value('(@StatementText)[1]', 'VARCHAR(4000)'), 
     StatementSubTreeCost	= n.value('(@StatementSubTreeCost)[1]', 'VARCHAR(128)'), 
     ParallelSubTreeXML		= n.query('.'),  
     ecp.usecounts, 
     ecp.size_in_bytes,
    RankPerText		= ROW_NUMBER() OVER (PARTITION BY n.value('(@StatementText)[1]', 'VARCHAR(4000)') ORDER BY ecp.usecounts DESC)
FROM sys.dm_exec_cached_plans AS ecp 
CROSS APPLY sys.dm_exec_query_plan(plan_handle) AS eqp 
CROSS APPLY query_plan.nodes('/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple') AS qn(n)
WHERE	n.query('.').exist('//RelOp[@PhysicalOp="Parallelism"]') = 1 
AND	ecp.usecounts > @MinUseCount
AND	n.value('(@StatementSubTreeCost)[1]', 'float') BETWEEN @CurrentCostThreshold AND @MaxSubTreeCost
) AS Q
WHERE
    RankPerText = 1 -- This would filter out duplicate statements, returning only those with the highest usecount
ORDER BY
    usecounts DESC;
