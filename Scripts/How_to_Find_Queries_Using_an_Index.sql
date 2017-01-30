/*
Author: Kendra Little
Original link: https://www.littlekendra.com/2017/01/24/how-to-find-queries-using-an-index-and-queries-using-index-hints/
*/

--Search for queries in the execution plan cache
--Simply plug the name of the index you’re looking for into this query. If you have multiple databases with the same index name,
--you’ll need to add additional criteria to get just the database you’re looking for.
SELECT 
    querystats.plan_handle,
    querystats.query_hash,
    SUBSTRING(sqltext.text, (querystats.statement_start_offset / 2) + 1, 
                (CASE querystats.statement_end_offset 
                    WHEN -1 THEN DATALENGTH(sqltext.text) 
                    ELSE querystats.statement_end_offset 
                END - querystats.statement_start_offset) / 2 + 1) AS sqltext, 
    querystats.execution_count,
    querystats.total_logical_reads,
    querystats.total_logical_writes,
    querystats.creation_time,
    querystats.last_execution_time,
    CAST(query_plan AS xml) as plan_xml
FROM sys.dm_exec_query_stats as querystats
CROSS APPLY sys.dm_exec_text_query_plan
    (querystats.plan_handle, querystats.statement_start_offset, querystats.statement_end_offset) 
    as textplan
CROSS APPLY sys.dm_exec_sql_text(querystats.sql_handle) AS sqltext 
WHERE 
    textplan.query_plan like '%PK_Sales_Invoices%'
ORDER BY querystats.last_execution_time DESC
OPTION (RECOMPILE);
GO


--Find queries using the index in Query Store
--If you’ve enabled the SQL Server 2016+ Query Store on your databases, you’ve got something better to search than the plan cache
SELECT
    qsq.query_id,
    qsq.query_hash,
    (SELECT TOP 1 qsqt.query_sql_text FROM sys.query_store_query_text qsqt
        WHERE qsqt.query_text_id = MAX(qsq.query_text_id)) AS sqltext,    
    SUM(qrs.count_executions) AS execution_count,
    SUM(qrs.count_executions) * AVG(qrs.avg_logical_io_reads) as est_logical_reads,
    SUM(qrs.count_executions) * AVG(qrs.avg_logical_io_writes) as est_writes,
    MIN(qrs.last_execution_time AT TIME ZONE 'Pacific Standard Time') as min_execution_time_PST,
    MAX(qrs.last_execution_time AT TIME ZONE 'Pacific Standard Time') as last_execution_time_PST,
    SUM(qsq.count_compiles) AS sum_compiles,
    TRY_CONVERT(XML, (SELECT TOP 1 qsp2.query_plan from sys.query_store_plan qsp2
        WHERE qsp2.query_id=qsq.query_id
        ORDER BY qsp2.plan_id DESC)) AS query_plan
FROM sys.query_store_query qsq
JOIN sys.query_store_plan qsp on qsq.query_id=qsp.query_id
CROSS APPLY (SELECT TRY_CONVERT(XML, qsp.query_plan) AS query_plan_xml) AS qpx
JOIN sys.query_store_runtime_stats qrs on qsp.plan_id = qrs.plan_id
JOIN sys.query_store_runtime_stats_interval qsrsi on qrs.runtime_stats_interval_id=qsrsi.runtime_stats_interval_id
WHERE    
    qsp.query_plan like N'%PK_Sales_Invoices%'
    AND qsp.query_plan not like '%query_store_runtime_stats%' /* Not a query store query */
    AND qsp.query_plan not like '%dm_exec_sql_text%' /* Not a query searching the plan cache */
GROUP BY 
    qsq.query_id, qsq.query_hash
ORDER BY est_logical_reads DESC
OPTION (RECOMPILE);
GO


--Search the execution plan cache for index hints
--To find forced indexes in the plan cache, look for plans that contain ‘%ForcedIndex=”1″%’
SELECT 
    querystats.plan_handle,
    querystats.query_hash,
    SUBSTRING(sqltext.text, (querystats.statement_start_offset / 2) + 1, 
                (CASE querystats.statement_end_offset 
                    WHEN -1 THEN DATALENGTH(sqltext.text) 
                    ELSE querystats.statement_end_offset 
                END - querystats.statement_start_offset) / 2 + 1) AS sqltext, 
    querystats.execution_count,
    querystats.total_logical_reads,
    querystats.total_logical_writes,
    querystats.creation_time,
    querystats.last_execution_time,
    CAST(query_plan AS xml) as plan_xml
FROM sys.dm_exec_query_stats as querystats
CROSS APPLY sys.dm_exec_text_query_plan
    (querystats.plan_handle, querystats.statement_start_offset, querystats.statement_end_offset) 
    as textplan
CROSS APPLY sys.dm_exec_sql_text(querystats.sql_handle) AS sqltext 
WHERE 
    textplan.query_plan like N'%ForcedIndex="1"%'
    and UPPER(sqltext.text) like N'%INDEX%'
OPTION (RECOMPILE);
GO


--Find index hints in Query Store
--If you’ve enabled the SQL Server 2016+ Query Store on your databases
SELECT
    qsq.query_id,
    qsq.query_hash,
    (SELECT TOP 1 qsqt.query_sql_text FROM sys.query_store_query_text qsqt
        WHERE qsqt.query_text_id = MAX(qsq.query_text_id)) AS sqltext,    
    SUM(qrs.count_executions) AS execution_count,
    SUM(qrs.count_executions) * AVG(qrs.avg_logical_io_reads) as est_logical_reads,
    SUM(qrs.count_executions) * AVG(qrs.avg_logical_io_writes) as est_writes,
    MIN(qrs.last_execution_time AT TIME ZONE 'Pacific Standard Time') as min_execution_time_PST,
    MAX(qrs.last_execution_time AT TIME ZONE 'Pacific Standard Time') as last_execution_time_PST,
    SUM(qsq.count_compiles) AS sum_compiles,
    TRY_CONVERT(XML, (SELECT TOP 1 qsp2.query_plan from sys.query_store_plan qsp2
        WHERE qsp2.query_id=qsq.query_id
        ORDER BY qsp2.plan_id DESC)) AS query_plan
FROM sys.query_store_query qsq
JOIN sys.query_store_plan qsp on qsq.query_id=qsp.query_id
CROSS APPLY (SELECT TRY_CONVERT(XML, qsp.query_plan) AS query_plan_xml) AS qpx
JOIN sys.query_store_runtime_stats qrs on qsp.plan_id = qrs.plan_id
JOIN sys.query_store_runtime_stats_interval qsrsi on qrs.runtime_stats_interval_id=qsrsi.runtime_stats_interval_id
WHERE    
    qsp.query_plan like N'%ForcedIndex="1"%'
GROUP BY 
    qsq.query_id, qsq.query_hash
ORDER BY est_logical_reads DESC
OPTION (RECOMPILE);
GO
