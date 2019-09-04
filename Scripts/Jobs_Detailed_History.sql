/*
<documentation>
  <summary>Detail Job History</summary>
  <returns>1 result set with detailed jobs information.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-08-16</created>
  <modified>2019-08-27 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Read_Errorlog.sql</sourceLink>
  <originalLink>https://jasonbrimhall.info/2019/06/27/detail-job-history-back-to-basics/</originalLink>
</documentation>
*/

WITH jobhist
AS (SELECT jh.job_id,
           jh.run_date,
           jh.run_status,
           jh.step_id,
           ROW_NUMBER() OVER (PARTITION BY jh.job_id, jh.run_status ORDER BY jh.run_date DESC) AS rownum
    FROM dbo.sysjobhistory jh
    WHERE jh.step_id = 0),
     agglastsixty
AS (SELECT sjh.job_id,
           sjh.run_status,
           COUNT(*) AS RunCount
    FROM dbo.sysjobhistory AS sjh
        INNER JOIN jobhist AS jh
            ON jh.job_id = sjh.job_id
               AND jh.run_status = sjh.run_status
               AND jh.step_id = sjh.step_id
    WHERE CONVERT(DATE, CONVERT(varchar(30), sjh.run_date)) > DATEADD(d, -60, CONVERT(DATE, CONVERT(varchar(30), jh.run_date)))
          AND jh.rownum = 1
    GROUP BY sjh.job_id,
             sjh.run_status),
     aggtotal
AS (SELECT sjh.job_id,
           sjh.run_status,
           COUNT(*) AS RunCount
    FROM dbo.sysjobhistory sjh
        INNER JOIN jobhist jh
            ON jh.job_id = sjh.job_id
               AND jh.run_status = sjh.run_status
               AND jh.step_id = sjh.step_id
    WHERE jh.rownum = 1
    GROUP BY sjh.job_id,
             sjh.run_status)
SELECT j.name AS JobName,
       sc.name AS CategoryName,
       j.date_created,
       j.enabled,
       CONVERT(DATE, CONVERT(VARCHAR(30), oa.run_date)) AS RunDate,
       CASE oa.run_status
           WHEN 0 THEN
               'Failed'
           WHEN 1 THEN
               'Succeeded'
           WHEN 2 THEN
               'Retry'
           WHEN 3 THEN
               'Canceled'
           WHEN 4 THEN
               'In Progress'
       END AS run_status,
       als.RunCount AS Last60StatusCount,
       agt.RunCount AS TotalStatusCount,
       js.subsystem AS JobStepSubsystem,
       js.command,
       CASE
           WHEN js.subsystem = 'SSIS'
                AND js.command LIKE '%DECRYPT%' THEN
               LTRIM(RTRIM(SUBSTRING(
                                        js.command,
                                        CHARINDEX('/DECRYPT', js.command, 1) + 9,
                                        CHARINDEX('/', js.command, CHARINDEX('/DECRYPT', js.command, 1) + 1)
                                        - CHARINDEX('/DECRYPT', js.command, 1) - 9
                                    )
                          )
                    )
           ELSE
               'N/A'
       END AS PkgPassword,
       CASE
           WHEN js.subsystem = 'SSIS'
                AND js.command LIKE '%FILE%' THEN
               LTRIM(RTRIM(SUBSTRING(
                                        js.command,
                                        CHARINDEX('/FILE', js.command, 1) + 9,
                                        CHARINDEX('\""', js.command, CHARINDEX('/FILE', js.command, 1) + 1)
                                        - CHARINDEX('/FILE', js.command, 1) - 9
                                    )
                          )
                    )
           ELSE
               'N/A'
       END AS PkgPath,
       spr.name AS ProxyName,
       spr.credential_id
FROM dbo.sysjobs j
    LEFT JOIN jobhist oa
        ON oa.job_id = j.job_id
    LEFT OUTER JOIN agglastsixty als
        ON als.job_id = oa.job_id
           AND als.run_status = oa.run_status
    LEFT OUTER JOIN aggtotal agt
        ON agt.job_id = oa.job_id
           AND agt.run_status = oa.run_status
    INNER JOIN sys.server_principals sp
        ON j.owner_sid = sp.sid
    INNER JOIN dbo.syscategories sc
        ON j.category_id = sc.category_id
    INNER JOIN dbo.sysjobsteps js
        ON js.job_id = j.job_id
    LEFT JOIN dbo.sysproxies spr
        ON js.proxy_id = spr.proxy_id
WHERE oa.rownum = 1
--AND oa.run_status = 0
ORDER BY RunDate DESC;
