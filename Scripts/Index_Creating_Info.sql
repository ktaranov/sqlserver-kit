/*
<documentation>
  <summary>Track index creating progress</summary>
  <returns>1 data set: index creation info.</returns>
  <issues>No</issues>
  <author>Solomon Rutzky</author>
  <created>2020-09-03</created>
  <modified>2021-08-12 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Index_Creating_Info.sql</sourceLink>
  <originalLink>https://dba.stackexchange.com/a/139225/107045</originalLink>
</documentation>
*/

WITH agg AS
(
     SELECT SUM(qp.row_count) AS RowsProcessed,
            SUM(qp.estimate_row_count) AS TotalRows,
            MAX(qp.last_active_time) - MIN(qp.first_active_time) AS ElapsedMS,
            MAX(IIF(qp.close_time = 0 AND qp.first_row_time > 0,
                    physical_operator_name,
                    N'<Transition>')) AS CurrentStep
     FROM sys.dm_exec_query_profiles qp
     WHERE qp.[physical_operator_name] IN (N'Table Scan', N'Clustered Index Scan',
                                           N'Index Scan',  N'Sort')
     AND   qp.[session_id] IN (SELECT session_id from sys.dm_exec_requests where command IN ( 'CREATE INDEX','ALTER INDEX','ALTER TABLE') )
), comp AS
(
     SELECT *,
            (TotalRows - RowsProcessed) AS RowsLeft,
            (ElapsedMS / 1000.0) AS ElapsedSeconds
     FROM   agg
)
SELECT CurrentStep,
       TotalRows,
       RowsProcessed,
       RowsLeft,
       CONVERT(DECIMAL(5, 2),
               ((RowsProcessed * 1.0) / TotalRows) * 100) AS PercentComplete,
       ElapsedSeconds,
       ((ElapsedSeconds / RowsProcessed) * RowsLeft) AS EstimatedSecondsLeft,
       DATEADD(SECOND,
               ((ElapsedSeconds / RowsProcessed) * RowsLeft),
               GETDATE()) AS EstimatedCompletionTime
FROM   comp;
