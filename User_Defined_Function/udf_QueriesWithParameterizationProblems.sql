/*
Author: Dennes Torres
Original link: https://www.red-gate.com/simple-talk/sql/database-administration/query-store-parameterization-problems
Description: Query Store and Parameterization Problems
*/


CREATE FUNCTION dbo.QueriesWithParameterizationProblems()
  RETURNS TABLE 
  AS
  RETURN 
  (
  -- Parameterized queries with text and most recent planId
  -- related with runtime stats grouped
  -- Filtering system queries
  select qsq.query_id,
        max(qsqt.query_sql_text) query_sql_text,
        max(qsp.plan_id) plan_id, 
        max(qsrs.max_duration) max_duration,
        max(qsrs.max_cpu_time) max_cpu_time,
        min(qsrs.min_cpu_time) min_cpu_time,
        min(qsrs.min_duration) min_duration,
        max(qsrs.stdev_duration) stdev_duration,
        max(qsrs.stdev_cpu_time) stdev_cpu_time
  from sys.query_store_query qsq, 
        sys.query_store_query_text qsqt,
        sys.query_store_plan qsp,
        sys.query_store_runtime_stats qsrs
  where qsq.query_text_id= qsqt.query_text_id 
    and qsp.query_id=qsq.query_id
    and qsrs.plan_id=qsp.plan_id
    and (qsq.query_parameterization_type<>0
         or qsqt.query_sql_text like '%@%')
    and qsq.is_internal_query=0
         and qsqt.query_sql_text not like '%sys.%' 
    and qsqt.query_sql_text not like '%sys[ ].%'
         and qsqt.query_sql_text not like '%@[sys@].%'  escape '@'
         and qsqt.query_sql_text not like '%INFORMATION_SCHEMA%'
         and qsqt.query_sql_text not like '%msdb%' 
    and qsqt.query_sql_text not like '%master%'
    and qsp.last_execution_time=(select max(last_execution_time)
                    from sys.query_store_plan qsp2
                    where qsp2.query_id= qsp.query_id)
  group by qsq.query_id
  )
GO
