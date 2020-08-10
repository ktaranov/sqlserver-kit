/*
<documentation>
  <summary>Return active jobs info.</summary>
  <returns>1 data set with information about current runnig jobs.</returns>
  <created>2017-01-07 by Brenda</created>
  <modified>2020-08-10 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Jobs_Get_runing_info.sql</sourceLink>
  <originalLink>https://sqlstudies.com/2013/09/05/a-t-sql-query-to-get-current-job-activity/</originalLink>
</documentation>
*/

SELECT 
    DISTINCT j.name as JobName
    , CASE WHEN ja.last_executed_step_id IS NULL THEN js.step_name ELSE js2.step_name END AS StepName
    , ja.start_execution_date AS StartDateTime
    , 'Running' AS RunStatus
    , RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(second, ja.start_execution_date, GetDate())/3600), 2) + ':' +
      RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(second, ja.start_execution_date, GetDate())%3600/60), 2)  + ':' +
      RIGHT('0' + CONVERT(VARCHAR(2), DATEDIFF(second, ja.start_execution_date, GetDate())%60), 2) AS Duration
    , '' AS message
FROM msdb.dbo.sysjobactivity ja
   JOIN msdb.dbo.sysjobs j
       ON ja.job_id = j.job_id
   LEFT JOIN msdb.dbo.sysjobsteps js
       ON j.job_id = js.job_id
           AND CASE WHEN ja.last_executed_step_id IS NULL THEN j.start_step_id 
            ELSE ja.last_executed_step_id
            END = js.step_id
   LEFT JOIN msdb.dbo.sysjobsteps js2
       ON js.job_id = js2.job_id
       AND js.on_success_step_id = js2.step_id
WHERE ja.session_id = (
                          SELECT TOP(1) session_id
                          FROM msdb.dbo.syssessions
                          ORDER BY agent_start_date DESC
                      )
AND ja.start_execution_date IS NOT NULL
AND ja.stop_execution_date IS NULL;
