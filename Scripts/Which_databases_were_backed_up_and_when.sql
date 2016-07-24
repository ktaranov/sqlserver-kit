/*
Author: Benjamin Nevarez
Original link: https://thelonedba.wordpress.com/2016/07/18/which-databases-were-backed-up-in-which-backup-task/
*/


DECLARE @SQL VARCHAR(MAX);
DECLARE @RunStartedList VARCHAR(MAX);
DECLARE @NumDays INT;
SELECT  @NumDays = 10; -- not doing this as a single line declare-define, as we might be running on older versions.
 
IF @NumDays > 0
    BEGIN
        SELECT  @NumDays = @NumDays * ( -1 );
    END;
 
SELECT  @RunStartedList = STUFF(( SELECT    ', ' + QUOTENAME(CONVERT(VARCHAR(20), msdb.dbo.agent_datetime(jh.run_date, jh.run_time), 120))
                                  FROM      msdb.dbo.sysjobhistory jh
                                            LEFT JOIN msdb.dbo.sysjobs j ON j.job_id = jh.job_id
                                  WHERE     LOWER(j.name) LIKE '%backup%'
                                            AND LOWER(j.name) LIKE '%full%'
                                            AND jh.step_id = 0
                                            AND msdb.dbo.agent_datetime(jh.run_date, jh.run_time) >= DATEADD(DAY, @NumDays, GETDATE())
                                  ORDER BY  msdb.dbo.agent_datetime(jh.run_date, jh.run_time) DESC
                                FOR
                                  XML PATH('')
                                ), 1, 2, '');
 
SELECT  @SQL = '
WITH    JobRuns
          AS ( SELECT   jh.instance_id ,
                        msdb.dbo.agent_datetime(jh.run_date, jh.run_time) AS RunStartDateTime ,
                        DATEADD(SECOND, CONVERT(INT, RIGHT(''000000'' + CONVERT(VARCHAR(20), jh.run_duration), 2)),
                                DATEADD(MINUTE, CONVERT(INT, SUBSTRING(RIGHT(''000000'' + CONVERT(VARCHAR(20), jh.run_duration), 6), 3, 2)),
                                        DATEADD(HOUR, CONVERT(INT, LEFT(RIGHT(''000000'' + CONVERT(VARCHAR(20), jh.run_duration), 6), 2)),
                                                DATEADD(DAY, jh.run_duration / 1000000, msdb.dbo.agent_datetime(jh.run_date, jh.run_time))))) AS RunFinishDateTime
               FROM     msdb.dbo.sysjobhistory jh
                        LEFT JOIN msdb.dbo.sysjobs j ON j.job_id = jh.job_id
               WHERE    LOWER(j.name) LIKE ''%backup%''
                        AND LOWER(j.name) LIKE ''%full%''
                        AND jh.step_id = 0
                                         AND msdb.dbo.agent_datetime(jh.run_date, jh.run_time) >= DATEADD(DAY, ' + CONVERT(NVARCHAR(8), @NumDays) + ', GETDATE())
             ),
        BackupsTaken
          AS ( SELECT   backup_start_date ,
                        backup_finish_date ,
                        database_name AS DBName
               FROM     msdb.dbo.backupset
               WHERE    type = ''D''
             ),
              BackupPivot
                AS ( SELECT DBName, ' + @RunStartedList + '
                        FROM (
                                  SELECT  CONVERT(VARCHAR(20), RunStartDateTime, 120) AS RunStarted,
                                                BackupsTaken.DBName
                                  FROM    JobRuns
                                                LEFT JOIN BackupsTaken ON JobRuns.RunStartDateTime <= BackupsTaken.backup_start_date
                                                                                           AND BackupsTaken.backup_finish_date <= JobRuns.RunFinishDateTime
                                  WHERE   JobRuns.RunStartDateTime >= DATEADD(DAY, ' + CONVERT(NVARCHAR(8), @NumDays) + ', GETDATE())
                                  ) AS src
                           PIVOT
                           ( COUNT(RunStarted) FOR RunStarted IN (' + @RunStartedList + ') ) AS pvt)
SELECT  sd.name as [Sys.Databases.Name],
        bp.*
FROM    BackupPivot bp
        FULL OUTER JOIN master.sys.databases sd ON bp.DBName = sd.name
ORDER BY sd.name ,
        bp.DBName
       ;
       ';
--SELECT  @SQL;
EXEC (@SQL);
