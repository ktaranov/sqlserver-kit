/*
<documentation>
  <summary>Inspects the SQL Server Error Log for failed logins, then uses xp_cmdshell to get the machine name by running nslookup against the IP address of the machine that initiated the failed login</summary>
  <returns>1 data set: temp table #errlog.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-02-01</created>
  <modified>2019-08-09 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Finding_Host_Names_for_Failed_login_attempts.sql</sourceLink>
  <originalLink>https://www.sqlserverscience.com/security/finding-host-names-for-failed-login-attempts/</originalLink>
</documentation>

    Inspects the SQL Server Error Log for failed logins, then
    uses xp_cmdshell to get the machine name by running nslookup against 
    the IP address of the machine that initiated the failed login.

    By:  Max Vernon
    https://www.sqlserverscience.com/security/finding-host-names-for-failed-login-attempts/
*/

SET NOCOUNT ON;

IF (
SELECT CONVERT(INT, ISNULL(value, value_in_use)) AS config_value
FROM  sys.configurations
WHERE  name = 'xp_cmdshell') = 0
RAISERROR ('
Please enable xp_cmdshell for this script using!
-- To allow advanced options to be changed.
EXEC sp_configure ''show advanced options'', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXEC sp_configure ''xp_cmdshell'', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO', 0, 1) WITH NOWAIT;

IF OBJECT_ID(N'tempdb..#errlog', N'U') IS NULL
CREATE TABLE #errlog
(
    ErrorLogFileNum int NULL
    , LogDate datetime
    , ProcessInfo varchar(255)
    , [Text] varchar(4000)
);
TRUNCATE TABLE #errlog;

DECLARE @ErrorLogCount int;
DECLARE @ErrorLogPath varchar(1000);
DECLARE @cmd varchar(2000);
DECLARE @output TABLE
(
    txtID int NOT NULL PRIMARY KEY IDENTITY(1,1)
    , txt varchar(1000) NULL
);

SET @ErrorLogPath = CONVERT(varchar(1000), SERVERPROPERTY(N'errorlogfilename'));
SET @ErrorLogPath = LEFT(@ErrorLogPath, LEN(@ErrorLogPath) - CHARINDEX('\', REVERSE(@ErrorLogPath)));
SET @cmd = 'DIR /b "' + @ErrorLogPath + '\ERRORLOG*"';

INSERT INTO @output (txt)
EXEC xp_cmdshell @cmd;

SELECT @ErrorLogCount = COUNT(*)
FROM @output o
WHERE o.txt IS NOT NULL;

DECLARE @FileNum int;
SET @FileNum = 0

WHILE @FileNum < @ErrorLogCount
BEGIN
    INSERT INTO #errlog (LogDate, ProcessInfo, [Text])
    EXEC sys.sp_readerrorlog @FileNum, 1;

    UPDATE #errlog 
    SET ErrorLogFileNum = @FileNum
    WHERE ErrorLogFileNum IS NULL;

    SET @FileNum = @FileNum + 1;
END

DECLARE @IPs TABLE(
    [IP] varchar(15)  NOT NULL
  , Name varchar(255)
);
DECLARE @IP varchar(15);

DECLARE cur CURSOR LOCAL FORWARD_ONLY STATIC
FOR
SELECT ClientIP = SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9))
FROM #errlog el
WHERE el.[Text] LIKE 'Login failed for user %.%'
GROUP BY SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9));
OPEN cur;
FETCH NEXT FROM cur INTO @IP;
WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM @output;
    SET @cmd = 'nslookup ' + @IP;
    INSERT INTO @output(txt)
    EXEC sys.xp_cmdshell @cmd;

    DELETE 
    FROM @output
    WHERE txt NOT LIKE 'Name: %';

    UPDATE @output 
    SET txt = RIGHT(txt, LEN(txt) - 9);

    INSERT INTO @IPs (IP, Name)
    SELECT @IP, txt
    FROM @output;
    FETCH NEXT FROM cur INTO @IP;
END
CLOSE cur;
DEALLOCATE cur;

DELETE FROM @IPs WHERE Name IS NULL;

--show only the most recent message for each client
SELECT MostRecentFailedLoginAttempt = MAX(el.LogDate)
    , LoginName = SUBSTRING(el.[Text]
        , CHARINDEX('''', el.[Text]) + 1
        , CHARINDEX('''', el.[Text], CHARINDEX('''', el.[Text]) + 1) - (CHARINDEX('''', el.[Text]) + 1))
    , FailureReason = SUBSTRING(el.[Text]
        , CHARINDEX('.', el.[Text]) + 1
        , CHARINDEX('.', el.[Text], CHARINDEX('.', el.[Text]) + 1) - (CHARINDEX('.', el.[Text]) + 1))
    , ClientIP = SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9))
    , ClientName = ips.Name
FROM #errlog el
    LEFT JOIN @IPs ips ON (SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9))) = ips.IP
WHERE el.[Text] LIKE 'Login failed for user %.%'
GROUP BY el.[Text]
    , ips.Name
ORDER BY MAX(el.LogDate) DESC;

--show all messages
SELECT el.LogDate
    , LoginName = SUBSTRING(el.[Text]
        , CHARINDEX('''', el.[Text]) + 1
        , CHARINDEX('''', el.[Text], CHARINDEX('''', el.[Text]) + 1) - (CHARINDEX('''', el.[Text]) + 1))
    , FailureReason = SUBSTRING(el.[Text]
        , CHARINDEX('.', el.[Text]) + 1
        , CHARINDEX('.', el.[Text], CHARINDEX('.', el.[Text]) + 1) - (CHARINDEX('.', el.[Text]) + 1))
    , ClientIP = SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9))
    , ClientName = ips.Name
FROM #errlog el
    LEFT JOIN @IPs ips ON (SUBSTRING(el.[Text]
        , CHARINDEX('[', el.[Text]) + 9
        , CHARINDEX(']', el.[Text]) - (CHARINDEX('[', el.[Text]) + 9))) = ips.IP
WHERE el.[Text] LIKE 'Login failed for user %.%'
ORDER BY el.LogDate DESC;
