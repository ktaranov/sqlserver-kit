/*
Author: Perry Whittle
Original link: http://sqlstudies.com/2013/03/01/script-to-clean-up-windows-logins-no-longer-in-ad/
*/

SELECT * FROM
(
 SELECT JobName, RunStart, DATEADD(second, RunSeconds, RunStart) RunEnd, RunSeconds
 FROM
 (
  SELECT j.name AS 'JobName',
    msdb.dbo.agent_datetime(run_date, run_time) AS 'RunStart',
    ((jh.run_duration/1000000)*86400) 
    + (((jh.run_duration-((jh.run_duration/1000000)*1000000))/10000)*3600) 
    + (((jh.run_duration-((jh.run_duration/10000)*10000))/100)*60) 
    + (jh.run_duration-(jh.run_duration/100)*100) RunSeconds
  FROM msdb.dbo.sysjobs j 
  INNER JOIN msdb.dbo.sysjobhistory jh ON j.job_id = jh.job_id 
  WHERE jh.step_id=0 --The Summary Step
 ) AS H
) AS H2
WHERE '2016-05-19 10:16:10' BETWEEN RunStart AND RunEnd
ORDER BY JobName, RunEnd;
