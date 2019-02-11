/*
Author: Max Vernon 
Created Date: 2019-02-05
Original link: https://blog.sqlauthority.com/2018/09/12/sql-server-simple-method-to-extract-scale-part-from-decimal-number/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Failed_SQL_Server_Agent_Jobs_With_Restart_Command.sql
Modified: 2019-02-11 by Konstantin Taranov
*/

WITH sys_job_history AS 
(
    SELECT *
        , rn = ROW_NUMBER() OVER (PARTITION BY sjh.job_id ORDER BY msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time) DESC)
    FROM msdb.dbo.sysjobhistory sjh
    WHERE sjh.step_id > 0
        AND sjh.run_date > CONVERT(int, CONVERT(varchar(8), DATEADD(DAY, -1, GETDATE()), 112))
)
SELECT sj.name
     , sjh.step_name
     , sjh.step_id
     , sjh.sql_message_id
     , sjh.sql_severity
     , sjh.message
     , sjh.server
     , RunDateTime = msdb.dbo.agent_datetime(sjh.run_date, sjh.run_time)
     , StartJobCommand = N'EXEC msdb.dbo.sp_start_job @job_name = ''' + sj.name + N''', @step_name = ''' + sjh.step_name + N''';'
FROM sys_job_history sjh
    INNER JOIN msdb.dbo.sysjobs sj ON sjh.job_id = sj.job_id
    INNER JOIN msdb.dbo.sysjobschedules sjsch ON sj.job_id = sjsch.job_id
    INNER JOIN msdb.dbo.sysschedules ss ON sjsch.schedule_id = ss.schedule_id
WHERE sjh.rn = 1
    AND sjh.run_status = 0 --failed
    AND ss.enabled = 1
ORDER BY sj.name;
