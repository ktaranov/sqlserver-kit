/*
<documentation>
  <summary>Read error log with filters</summary>
  <returns>2 result sets with detailed info from error log.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-06-27</created>
  <modified>2019-08-27 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Jobs_Detailed_History.sql</sourceLink>
  <originalLink>https://thelonedba.wordpress.com/2019/08/16/reading-sql-server-error-logs/</originalLink>
</documentation>
*/

DECLARE @daysback INT = 0; -- number of days to go back in the logs.  0 = today only

-- table variable for holding the details of the error logs.
-- Yes, I know, table variables are evil.  This one is unlikely to hold more than a few dozen rather narrow lines
DECLARE @ErrorLogs TABLE
(
    Archive INT NOT NULL,
    LogDate DATETIME NOT NULL,
    LogFileSizeBytes BIGINT NOT NULL,
    ReadThis TINYINT NULL
);

-- useful trick if you don't know it: INSERT INTO a table the results of EXECing a SP.
INSERT INTO @ErrorLogs
(
    Archive,
    LogDate,
    LogFileSizeBytes
)
EXEC sys.sp_enumerrorlogs;

DECLARE @lognum INT = 0;
DECLARE @logdate DATETIME;

--figure out which logfiles we need.
WITH NextLog
AS (SELECT Archive,
           LogDate,
           LogFileSizeBytes,
           ReadThis,
           ISNULL(LAG(LogDate) OVER (ORDER BY Archive), LogDate) AS nextlogdate
    FROM @ErrorLogs)
UPDATE @ErrorLogs
SET ReadThis = CASE
                   WHEN e.Archive = 1 THEN
                       1 -- always read the first file; doesn't always get identified by the next line
                   WHEN n.nextlogdate >= DATEADD(DAY, DATEDIFF(DAY, '20100101', GETDATE()) - ABS(@daysback), '20100101') THEN
                       1
                   ELSE
                       0
               END
FROM NextLog AS n
    INNER JOIN @ErrorLogs AS e
        ON e.Archive = n.Archive;

--just checking which files we're looking at...  Probably comment this line out for production use
SELECT *
FROM @ErrorLogs
ORDER BY Archive;

IF OBJECT_ID('tempdb.dbo.#spErrorLog', 'U') IS NOT NULL
BEGIN
    DROP TABLE #spErrorLog;
END;

CREATE TABLE #spErrorLog
(
    logdate DATETIME NOT NULL,
    ProcessInfo VARCHAR(20) NULL,
    Text NVARCHAR(MAX) NOT NULL
);

WHILE @lognum <= (SELECT MAX(Archive) FROM @ErrorLogs WHERE ReadThis = 1)
BEGIN
    INSERT INTO #spErrorLog
    EXEC sys.sp_readerrorlog @p1 = @lognum;

    SELECT @lognum = @lognum + 1;

    SELECT @logdate = LogDate
    FROM @ErrorLogs
    WHERE Archive = @lognum;
END;

SELECT *
FROM #spErrorLog
WHERE 1 = 1
      AND
      (
          ProcessInfo = 'Server' -- we like server-related boot messages.
          OR
          ( -- filter out noisy messages that we don't really need to see here
              Text NOT LIKE '%Backup Log%'
              AND Text NOT LIKE 'Log was backed up%'
              AND Text NOT LIKE 'CHECKDB for database % finished without errors on %This is an informational message only; no user action is required.'
              AND Text NOT LIKE 'DBCC CHECKDB % WITH all_errormsgs, no_infomsgs, data_purity executed by % found 0 errors and repaired 0 errors.%'
              AND Text NOT LIKE 'BACKUP DATABASE WITH DIFFERENTIAL successfully processed % pages%'
              AND Text NOT LIKE 'Database differential changes were backed up. Database: % This is an informational message. No user action is required.'
              AND Text NOT LIKE 'BACKUP DATABASE successfully processed % pages %'
              AND Text NOT LIKE 'Database backed up. Database: % This is an informational message only. No user action is required.'
              AND logdate >= DATEADD(DAY, DATEDIFF(DAY, '20100101', GETDATE()) - ABS(@daysback), '20100101')
          )
      )
ORDER BY logdate;
