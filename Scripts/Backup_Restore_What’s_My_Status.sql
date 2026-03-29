/*
Author: Chris Yates
Original link: http://www.sqlservercentral.com/blogs/the-sql-professor/2017/01/26/backuprestorewhats-my-status/
*/

--By checking only for the restore and backup command lines you will be able to quickly identify your session id
--and get an  approximate ETA and percentage complete. you can tinker of course with the estimations
--if you’d like or pull back more fields. This is just a simple technique in utilizing a helpful DMV to provide info quickly.
SELECT  r.session_id
      , r.command
      , r.start_time
      , r.status
      , CONVERT(NUMERIC(6, 2), r.percent_complete) AS [Percent Complete]
      , CONVERT(VARCHAR(20), DATEADD(ms, r.estimated_completion_time , GETDATE()), 20) AS [ETA Completion Time]
      , CONVERT(NUMERIC(10, 2), r.total_elapsed_time / 1000.0 / 60.0) AS [Elapsed Min]
      , CONVERT(NUMERIC(10, 2), r.total_elapsed_time / 1000.0 / 60.0 / 60.0) AS [Elapsed Hours]
      , CONVERT(NUMERIC(10, 2), r.estimated_completion_time / 1000.0 / 60.0) AS [ETA Min]
      , CONVERT(NUMERIC(10, 2), r.estimated_completion_time / 1000.0 / 60.0/ 60.0) AS [ETA Hours]
      , CONVERT(VARCHAR(1000), (
                 SELECT SUBSTRING(TEXT, r.statement_start_offset / 2, CASE
                             WHEN r.statement_end_offset = -1
                                 THEN 1000
                             ELSE (r.statement_end_offset - r.statement_start_offset) / 2
                             END)
                 FROM   sys.dm_exec_sql_text(sql_handle)
                 )) AS TSQLStatement
FROM sys.dm_exec_requests r
WHERE command IN (
        'RESTORE DATABASE'
        , 'BACKUP DATABASE'
        ,'RESTORE LOG'
        ,'BACKUP LOG'
        );
