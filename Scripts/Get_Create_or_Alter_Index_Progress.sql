/*
<documentation>
  <summary>Track progrees CREATE or ALTER Index commands</summary>
  <returns>1 data set</returns>
  <issues>No</issues>
  <author>Solomon Rutzky</author>
  <created>2019-12-02</created>
  <modified>2019-12-02</modified>
  <version>1.0</version>
  <originalLink>https://dba.stackexchange.com/a/139225/107045</originalLink>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Create_or_Alter_Index_Progress.sql</sourceLink>
</documentation>
*/

DECLARE @SPID int = 51;

WITH agg AS
(
     SELECT SUM(qp.[row_count]) AS [RowsProcessed],
            SUM(qp.[estimate_row_count]) AS [TotalRows],
            MAX(qp.last_active_time) - MIN(qp.first_active_time) AS [ElapsedMS],
            MAX(IIF(qp.[close_time] = 0 AND qp.[first_row_time] > 0,
                    [physical_operator_name],
                    N'<Transition>')) AS [CurrentStep]
     FROM sys.dm_exec_query_profiles qp
     WHERE qp.[physical_operator_name] IN (N'Table Scan', N'Clustered Index Scan',
                                           N'Index Scan',  N'Sort')
     AND   qp.[session_id] = @SPID
), comp AS
(
     SELECT *,
            ([TotalRows] - [RowsProcessed]) AS [RowsLeft],
            ([ElapsedMS] / 1000.0) AS [ElapsedSeconds]
     FROM   agg
)
SELECT [CurrentStep],
       [TotalRows],
       [RowsProcessed],
       [RowsLeft],
       CONVERT(DECIMAL(5, 2),
               (([RowsProcessed] * 1.0) / [TotalRows]) * 100) AS [PercentComplete],
       [ElapsedSeconds],
       (([ElapsedSeconds] / [RowsProcessed]) * [RowsLeft]) AS [EstimatedSecondsLeft],
       DATEADD(SECOND,
               (([ElapsedSeconds] / [RowsProcessed]) * [RowsLeft]),
               GETDATE()) AS [EstimatedCompletionTime]
FROM   comp;
