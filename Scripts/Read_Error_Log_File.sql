/*
Created: 2019-03-05 by Max Vernon
Modified: 2019-03-26 by Konstantin Taranov
Original link: https://www.sqlserverscience.com/tools/error-log-analysis-script/
Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Read_Error_Log_File.sql
Note: Shows the contents of the SQL Server Error Log files, up to a maximum of the most recent 9 files.
Certain "noisy" log messages are filtered out via the #exclusions temp table.
*/

SET NOCOUNT ON;

DECLARE @ErrorLogType tinyint;
SET @ErrorLogType = 1; --1 for SQL Server Error log, 2 for SQL Server Agent Log

IF OBJECT_ID(N'tempdb..#exclusions', N'U') IS NOT NULL DROP TABLE #exclusions;

CREATE TABLE #exclusions
(
    LogTextToExclude VARCHAR(4000)-- COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       -- PRIMARY KEY CLUSTERED
    , LogType tinyint NOT NULL
);

-- the pipe symbol, "|", should be used as the escape character
INSERT INTO #exclusions (LogTextToExclude, LogType)
VALUES ('%Using ''dbghelp.dll'' version ''4.0.5''%', 1)
    , ('%informational message%no user action is required%', 1)
    , ('Log was backed up%', 1)
    , ('Database backed up%', 1)
    , ('BACKUP DATABASE %', 1)
    , ('DBCC %', 1)
    , ('Setting database option RECOVERY to %', 1)
    , ('This instance of SQL Server has been using a process ID of %', 1)
    , ('Starting up database%', 1)
    , ('Software Usage Metrics is enabled.', 1)
    , ('|[184|] Job completion for % is being logged to sysjobhistory%', 2)
    , ('|[177|] Job % has been requested to run by Schedule %', 2)
    , ('|[248|] Saving NextRunDate/Times for all updated job schedules...%', 2)
    , ('|[249|] % job schedule|(s|) saved%', 2)
    , ('|[182|] Job completion for % is being logged to the eventlog%', 2)
    , ('|[171|] There are % alert|(s|) in the alert cache%', 2)
    , ('|[168|] There are 21 job(s) |[0 disabled|] in the job cache%', 2)
    , ('|[170|] Populating alert cache...%', 2)
    , ('|[473|] Database Mail profile DBA refreshed.%', 2)
    , ('|[353|] Mail session started%', 2)
    , ('|[273|] Mail dispatcher started%', 2)
    , ('|[174|] Job scheduler engine started |(maximum user worker threads: 200, maximum system worker threads: 100|)%', 2)
    , ('|[193|] Alert engine started |(using Eventlog Events|)%', 2)
    , ('|[146|] Request servicer engine started%', 2)
    , ('|[167|] Populating job cache...%', 2)
    , ('|[133|] Support engine started%', 2)
    , ('|[271|] Idle processor poller started%', 2)


IF OBJECT_ID(N'tempdb..#mverrlog', N'U') IS NOT NULL
DROP TABLE #mverrlog;
CREATE TABLE #mverrlog
(
      RowNum INT PRIMARY KEY CLUSTERED IDENTITY(1,1)
    , ErrorLogFileNum INT NULL
    , LogDate DATETIME NOT NULL
    , ProcessInfo NVARCHAR(255) NOT NULL
    , [Text]      NVARCHAR(4000) NOT NULL
);

DECLARE @ErrorLogCount int;
DECLARE @cmd varchar(2000);
DECLARE @msg varchar(1000);

DECLARE @ErrorlogEnum TABLE(
      [Archive #] varchar(3) NOT NULL PRIMARY KEY CLUSTERED
    , [Date] datetime NOT NULL
    , [Log File Size (Byte)] int NOT NULL
);

INSERT INTO @ErrorlogEnum ([Archive #], [Date], [Log File Size (Byte)])
EXEC sys.sp_enumerrorlogs;

SET @ErrorLogCount = COALESCE((
    SELECT COUNT(1)
    FROM @ErrorlogEnum eln
    WHERE eln.[Log File Size (Byte)] > 0
    ), 0);

IF @ErrorLogCount > 9 SET @ErrorLogCount = 9;

DECLARE @FileNum INT;
SET @FileNum = 0

WHILE @FileNum < @ErrorLogCount
BEGIN TRY
    SET @msg = 'Retreiving log ' + CONVERT(varchar(100), @FileNum);
    RAISERROR (@msg, 0, 1) WITH NOWAIT; --send progress to the "Messages" tab

    INSERT INTO #mverrlog (LogDate, ProcessInfo, [Text])
    EXEC sys.xp_readerrorlog @FileNum, @ErrorLogType;

    UPDATE #mverrlog
    SET ErrorLogFileNum = @FileNum
    WHERE ErrorLogFileNum IS NULL;

    SET @FileNum = @FileNum + 1;
END TRY
BEGIN CATCH
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER())  +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE())    +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-')        +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE())     +
          ', User name: ' + CONVERT(sysname, ORIGINAL_LOGIN());
    PRINT(ERROR_MESSAGE());
    PRINT('Change @FileNum to smaller value!');
END CATCH

SELECT FileNumber = el.ErrorLogFileNum
    , el.LogDate
    , el.Text
FROM #mverrlog el
WHERE NOT EXISTS (
    SELECT 1
    FROM #exclusions e
    WHERE (el.Text LIKE e.LogTextToExclude ESCAPE '|')
        AND e.LogType = @ErrorLogType
    )
ORDER BY el.ErrorLogFileNum, el.RowNum DESC;
