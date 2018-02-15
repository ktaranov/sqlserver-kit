IF OBJECT_ID('dbo.sp_BenchmarkTSQL', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.sp_BenchmarkTSQL AS SELECT 1;');
GO

　
ALTER PROCEDURE dbo.sp_BenchmarkTSQL(
      @tsqlStatementBefore NVARCHAR(MAX) = NULL
    , @tsqlStatement       NVARCHAR(MAX)
    , @tsqlStatementAfter  NVARCHAR(MAX) = NULL
    , @numberOfExecution   INT           = 10
    , @saveResults         BIT           = 0
    , @skipTSQLCheck       BIT           = 1
    , @clearCache          BIT           = 0
    , @calcMedian          BIT           = 0
    , @printStepInfo       BIT           = 1
    , @durationAccuracy    VARCHAR(5)    = 'ss'
    , @dateTimeFunction    VARCHAR(16)   = 'SYSDATETIME'
)
/*
.SYNOPSIS
    Run TSQL statement n times and calculate execution time, save results if needed or print it.

.DESCRIPTION
    Run SQL statement specified times, show results, insert execution details into table master.dbo.BenchmarkTSQL (create if not exist).

.PARAMETER @tsqlStatementBefore
    TSQL statement that executed before run main TSQL statement.

.PARAMETER @tsqlStatement
    TSQL statement for benchmarking.

.PARAMETER @tsqlStatementAfter
    TSQL statement that executed after run main TSQL statement.

.PARAMETER @numberOfExecution
    Number of execution TSQL statement.

.PARAMETER @saveResults
    Save benchmark details to master.dbo.BenchmarkTSQL table if @saveResults = 1.

.PARAMETER @skipTSQLCheck
    Checking for valid TSQL statement.

.PARAMETER @clearCache
    Clear cached plan for TSQL statement.

.PARAMETER @calcMedian
    Calculate pseudo median of execution time.

.PARAMETER @printStepInfo
    PRINT detailed step information: step count, start time, end time, duration.

.PARAMETER @durationAccuracy
    Duration accuracy calculation, possible values: ns, mcs, ms, ss, mi, hh, wk, dd.
    See DATEDIFF https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql

.PARAMETER @dateTimeFunction
    Define using datetime function, possible values of functions: SYSDATETIME, SYSUTCDATETIME.
    See https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql

.EXAMPLE
    EXEC sp_BenchmarkTSQL
         @tsqlStatement = 'SELECT * FROM , sys.databases'
       , @skipTSQLCheck = 0;
    -- RETURN: Incorrect syntax near ','.

.EXAMPLE
    EXEC sp_BenchmarkTSQL
         @tsqlStatement = 'SELECT * FROM sys.databases'
       , @skipTSQLCheck = 0;

.EXAMPLE
    EXEC sp_BenchmarkTSQL
         @tsqlStatement = 'SELECT TOP(100000) * FROM sys.objects AS o1 CROSS JOIN sys.objects AS o2 CROSS JOIN sys.objects AS o3;'
       , @numberOfExecution = 10
       , @saveResults       = 1
       , @calcMedian        = 1
       , @clearCache        = 1
       , @printStepInfo     = 1
       , @durationAccuracy  = 'ms';

.EXAMPLE
    EXEC sp_BenchmarkTSQL
         @tsqlStatementBefore = 'WAITFOR DELAY ''00:00:01'';'
       , @tsqlStatement       = 'BACKUP DATABASE [master] TO  DISK = N''D:\master.bak'' WITH NOFORMAT, NOINIT;'
       , @tsqlStatementAfter  = 'WAITFOR DELAY ''00:00:02'';'
       , @numberOfExecution   = 5
       , @saveResults         = 1
       , @calcMedian          = 1
       , @clearCache          = 1
       , @printStepInfo       = 1
       , @durationAccuracy    = 'ss'
       , @dateTimeFunction    = 'SYSUTCDATETIME';

.LICENSE MIT
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.NOTE
    Author: Aleksei Nagorskii
    Created date: 2017-12-14 by Konstantin Taranov k@taranov.pro
    Version: 4.5
    Last Modified: 2018-02-15 19:16 UTC+3 by Konstantin Taranov
    Main contributors: Konstantin Taranov, Aleksei Nagorskii
    Source: https://rebrand.ly/sp_BenchmarkTSQL
*/
AS
BEGIN TRY

    SET NOCOUNT ON;

    DECLARE @originalLogin SYSNAME = QUOTENAME(ORIGINAL_LOGIN()); -- https://sqlstudies.com/2015/06/24/which-user-function-do-i-use/
    DECLARE @startTime DATETIME2(7) = CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                                           WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME()
                                      END;
    DECLARE @err_msg NVARCHAR(MAX);
    PRINT('Benchmark started at ' +  CONVERT(VARCHAR(27), @startTime, 121) + ' by ' + @originalLogin);

    DECLARE @productMajorVersion SQL_VARIANT = SERVERPROPERTY('ProductMajorVersion');
    IF CAST(@productMajorVersion AS INT) < 10
    BEGIN
        DECLARE @MsgError VARCHAR(2000) = 'Stored procedure sp_BenchmarkTSQL works only for SQL Server 2008 and higher. Yor ProductMajorVersion is ' +
                                           CAST(@productMajorVersion AS VARCHAR(30)) +
                                           '. You can try to replace DATETIME2 data type on DATETIME, perhaps it will be enough.';
        THROW 55001, @MsgError, 1;
    END;

    IF @tsqlStatement IS NULL
        THROW 55002, '@tsqlStatement is NULL, please specify TSQL statement.', 1;
    IF @tsqlStatement = N''
        THROW 55003, '@tsqlStatement is empty, please specify TSQL statement.', 1;

    IF @durationAccuracy NOT IN (
                                   'ns'  -- nanosecond
                                 , 'mcs' -- microsecond
                                 , 'ms'  -- millisecond
                                 , 'ss'  -- second
                                 , 'mi'  -- minute
                                 , 'hh'  -- hour
                                 , 'wk'  -- week
                                 , 'dd'  -- day
    )
    THROW 55004, '@durationAccuracy accept only this values: ns, mcs, ms, ss, mi, hh, wk, dd. See DATEDIFF https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql' , 1;

    IF @dateTimeFunction NOT IN (
                              'SYSDATETIME'
                            , 'SYSUTCDATETIME'
    )
    THROW 55005, '@dateTimeFunction accept only SYSUTCDATETIME and SYSDATETIME, default is SYSDATETIME. See https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql', 1;

    IF @numberOfExecution <= 0 OR @numberOfExecution >= 32000
        THROW 55006, '@numberOfExecution must be > 0 and < 32000', 1;

    IF @skipTSQLCheck = 0
    BEGIN
        IF @tsqlStatementBefore IS NOT NULL AND @tsqlStatementBefore <> '' AND EXISTS (
            SELECT 1
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatementBefore, NULL, 0)
            WHERE error_message IS NOT NULL
              AND error_number IS NOT NULL
              AND error_severity IS NOT NULL
              AND error_state IS NOT NULL
              AND error_type IS NOT NULL
              AND error_type_desc IS NOT NULL
              )
        BEGIN
            SELECT @err_msg = [error_message]
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatementBefore, NULL, 0)
            WHERE column_ordinal = 0;

            THROW 55007, @err_msg, 1;
        END;

        IF @tsqlStatement IS NOT NULL AND @tsqlStatement <> '' AND EXISTS (
            SELECT 1
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatement, NULL, 0)
            WHERE error_message IS NOT NULL
              AND error_number IS NOT NULL
              AND error_severity IS NOT NULL
              AND error_state IS NOT NULL
              AND error_type IS NOT NULL
              AND error_type_desc IS NOT NULL
              )
        BEGIN
            SELECT @err_msg = [error_message]
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatement, NULL, 0)
            WHERE column_ordinal = 0;

            THROW 55008, @err_msg, 1;
        END;

        IF @tsqlStatementAfter IS NOT NULL AND @tsqlStatementAfter <> '' AND EXISTS (
            SELECT 1
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatementAfter, NULL, 0)
            WHERE error_message IS NOT NULL
              AND error_number IS NOT NULL
              AND error_severity IS NOT NULL
              AND error_state IS NOT NULL
              AND error_type IS NOT NULL
              AND error_type_desc IS NOT NULL
              )
        BEGIN
            SELECT @err_msg = [error_message]
            FROM sys.dm_exec_describe_first_result_set(@tsqlStatementAfter, NULL, 0)
            WHERE column_ordinal = 0;
    
            THROW 55009, @err_msg, 1;
        END;
    END;

    DECLARE @crlf           NVARCHAR(10) = CHAR(10);
    DECLARE @stepNumnber    INT          = 0;
    DECLARE @min            BIGINT;
    DECLARE @avg            BIGINT;
    DECLARE @max            BIGINT;
    DECLARE @median         REAL;
    DECLARE @plan_handle    VARBINARY(64);
    DECLARE @runTimeStamp   DATETIME2(7);
    DECLARE @finishTime     DATETIME2(7);
    DECLARE @duration       INT;

    DECLARE @BenchmarkTSQL TABLE (
        StartBenchmarkTime  DATETIME2(7)  NOT NULL
      , FinishBenchmarkTime DATETIME2(7)  NULL
      , RunTimeStamp        DATETIME2(7)  NOT NULL
      , FinishTimeStamp     DATETIME2(7)  NOT NULL
      , Duration            BIGINT        NOT NULL
      , ClearCache          BIT           NOT NULL
      , PrintStepInfo       BIT           NOT NULL
      , DurationAccuracy    VARCHAR(10)   NOT NULL
      );

    WHILE @stepNumnber < @numberOfExecution
    BEGIN
        SET @stepNumnber = @stepNumnber + 1;

        IF @clearCache = 1
        BEGIN
            SELECT @plan_handle = plan_handle
            FROM sys.dm_exec_cached_plans
            CROSS APPLY sys.dm_exec_sql_text(plan_handle)
            WHERE [text] LIKE @tsqlStatement;  -- LIKE instead = (equal) because = ignore trailing spaces

            IF @plan_handle IS NOT NULL DBCC FREEPROCCACHE (@plan_handle);
        END;

        IF @tsqlStatementBefore IS NOT NULL AND @tsqlStatementBefore <> ''
            EXECUTE sp_executesql @tsqlStatementBefore;

        SET @runTimeStamp = CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                                 WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME()
                            END;

        EXECUTE sp_executesql @tsqlStatement;

        SET @finishTime = CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                               WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME()
                          END;

        SET @duration = CASE WHEN @durationAccuracy = 'ns'  THEN DATEDIFF(ns,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'mcs' THEN DATEDIFF(mcs, @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'ms'  THEN DATEDIFF(ms,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'ss'  THEN DATEDIFF(ss,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'mi'  THEN DATEDIFF(mi,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'hh'  THEN DATEDIFF(hh,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'wk'  THEN DATEDIFF(wk,  @runTimeStamp, @finishTime)
                             WHEN @durationAccuracy = 'dd'  THEN DATEDIFF(dd,  @runTimeStamp, @finishTime)
                             ELSE 0
                        END;

        INSERT @BenchmarkTSQL (
              StartBenchmarkTime
            , FinishBenchmarkTime
            , RunTimeStamp
            , FinishTimeStamp
            , Duration
            , ClearCache
            , PrintStepInfo
            , DurationAccuracy
            )
        VALUES (
              @startTime
            , NULL
            , @runTimeStamp
            , @finishTime
            , @duration
            , @clearCache
            , @printStepInfo
            , @durationAccuracy
            );

       IF @printStepInfo = 1
       -- Using RAISEEROR for interactive step printing http://sqlity.net/en/984/print-vs-raiserror/
           DECLARE @RaiseError VARCHAR(2000) = 'Run ' + CASE WHEN @stepNumnber < 10   THEN '   ' + CAST(@stepNumnber AS VARCHAR(30))
                                WHEN @stepNumnber < 100  THEN '  '  + CAST(@stepNumnber AS VARCHAR(30))
                                WHEN @stepNumnber < 1000 THEN ' '  + CAST(@stepNumnber AS VARCHAR(30))
                                ELSE CAST(@stepNumnber AS VARCHAR(30))
                           END +
                  ', start: '    + CONVERT(VARCHAR(27), @runTimeStamp, 121) +
                  ', finish: '   + CONVERT(VARCHAR(27), CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                                                             WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME()
                                                        END, 121) +
                  ', duration: ' + CAST(@duration AS VARCHAR(100)) + @durationAccuracy + '.';
           RAISERROR(@RaiseError, 0, 1) WITH NOWAIT;

        IF @tsqlStatementAfter IS NOT NULL AND @tsqlStatementAfter <> ''
            EXECUTE sp_executesql @tsqlStatementAfter;

    END;

    SELECT @min = MIN(Duration)
         , @avg = AVG(Duration)
         , @max = MAX(Duration)
      FROM @BenchmarkTSQL;

    DECLARE @FinishBenchmarkTime DATETIME2(7) = CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                                                     WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME() ELSE SYSDATETIME()
                                                END;

    IF @saveResults = 1
    BEGIN
    DECLARE @TSQLStatementGUID VARCHAR(36) = NEWID();

        IF OBJECT_ID('master.dbo.BenchmarkTSQL', 'U') IS NULL
        BEGIN
            CREATE TABLE master.dbo.BenchmarkTSQL(
                  BenchmarkTSQLID     INT IDENTITY  NOT NULL
                , TSQLStatementGUID   VARCHAR(36)   NOT NULL
                , StepRowNumber       INT           NOT NULL
                , StartBenchmarkTime  DATETIME2(7)  NOT NULL
                , FinishBenchmarkTime DATETIME2(7)  NOT NULL
                , RunTimeStamp        DATETIME2(7)  NOT NULL
                , FinishTimeStamp     DATETIME2(7)  NOT NULL
                , Duration            BIGINT        NOT NULL
                , TsqlStatementBefore NVARCHAR(MAX) NULL
                , TsqlStatement       NVARCHAR(MAX) NOT NULL
                , TsqlStatementAfter  NVARCHAR(MAX) NULL
                , ClearCache          BIT           NOT NULL
                , PrintStepInfo       BIT           NOT NULL
                , DurationAccuracy    VARCHAR(10)   NOT NULL
                , OriginalLogin       SYSNAME       NOT NULL
            );

            INSERT INTO master.dbo.BenchmarkTSQL(
                 TSQLStatementGUID
               , StepRowNumber
               , StartBenchmarkTime
               , FinishBenchmarkTime
               , RunTimeStamp
               , FinishTimeStamp
               , Duration
               , TsqlStatementBefore
               , TsqlStatement
               , TsqlStatementAfter
               , ClearCache
               , PrintStepInfo
               , DurationAccuracy
               , OriginalLogin
            )
            SELECT @TSQLStatementGUID AS TSQLStatementGUID
                 , ROW_NUMBER() OVER (ORDER BY RunTimeStamp, FinishTimeStamp) AS StepRowNumber
                 , StartBenchmarkTime
                 , @FinishBenchmarkTime
                 , RunTimeStamp
                 , FinishTimeStamp
                 , Duration
                 , @tsqlStatementBefore
                 , @tsqlStatement
                 , @tsqlStatementAfter
                 , ClearCache
                 , PrintStepInfo
                 , DurationAccuracy
                 , @originalLogin AS OriginalLogin
             FROM @BenchmarkTSQL;
        END
        ELSE
            INSERT INTO master.dbo.BenchmarkTSQL
            SELECT @TSQLStatementGUID AS TSQLStatementGUID
                 , ROW_NUMBER() OVER (ORDER BY RunTimeStamp, FinishTimeStamp) AS StepRowNumber
                 , StartBenchmarkTime
                 , @FinishBenchmarkTime
                 , RunTimeStamp
                 , FinishTimeStamp
                 , Duration
                 , @tsqlStatementBefore
                 , @tsqlStatement
                 , @tsqlStatementAfter
                 , ClearCache
                 , PrintStepInfo
                 , DurationAccuracy
                 , @originalLogin AS OriginalLogin
             FROM @BenchmarkTSQL;
    END;

    IF @calcMedian = 1
    BEGIN
        SELECT @median =
        (
             (SELECT MAX(TMIN) FROM
                  (SELECT TOP(50) PERCENT
                          CASE WHEN @durationAccuracy = 'ns'  THEN DATEDIFF(ns,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'mcs' THEN DATEDIFF(mcs, RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'ms'  THEN DATEDIFF(ms,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'ss'  THEN DATEDIFF(ss,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'mi'  THEN DATEDIFF(mi,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'hh'  THEN DATEDIFF(hh,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'wk'  THEN DATEDIFF(wk,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'dd'  THEN DATEDIFF(dd,  RunTimeStamp, FinishTimeStamp)
                               ELSE 0
                          END AS TMIN
                   FROM @BenchmarkTSQL
                   ORDER BY TMIN
                  ) AS BottomHalf
             )
             +
             (SELECT MIN(TMAX) FROM
                  (SELECT TOP 50 PERCENT
                          CASE WHEN @durationAccuracy = 'ns'  THEN DATEDIFF(ns,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'mcs' THEN DATEDIFF(mcs, RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'ms'  THEN DATEDIFF(ms,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'ss'  THEN DATEDIFF(ss,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'mi'  THEN DATEDIFF(mi,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'hh'  THEN DATEDIFF(hh,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'wk'  THEN DATEDIFF(wk,  RunTimeStamp, FinishTimeStamp)
                               WHEN @durationAccuracy = 'dd'  THEN DATEDIFF(dd,  RunTimeStamp, FinishTimeStamp)
                               ELSE 0
                          END AS TMAX
                   FROM @BenchmarkTSQL
                   ORDER BY TMAX DESC
                  ) AS TopHalf
             )
         ) / 2.0;
    END;

    PRINT(@crlf +
         'Min: '       + CAST(@min AS VARCHAR(30)) + @durationAccuracy +
         ', Max: '     + CAST(@max AS VARCHAR(30)) + @durationAccuracy +
         ', Average: ' + CAST(@avg AS VARCHAR(30)) + @durationAccuracy +
         CASE WHEN @calcMedian = 1 THEN ', Median: ' + CAST(@median AS VARCHAR(30)) + @durationAccuracy ELSE '' END +
         @crlf +
         'Benchmark finished at ' + CONVERT(VARCHAR(23), CASE WHEN @dateTimeFunction = 'SYSDATETIME'    THEN SYSDATETIME()
                                                              WHEN @dateTimeFunction = 'SYSUTCDATETIME' THEN SYSUTCDATETIME()
                                                         END, 121) + 
         ' by ' + @originalLogin
         );

        DECLARE @BenchmarkDuration BIGINT = CASE WHEN @durationAccuracy = 'ns'  THEN DATEDIFF(ns,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'mcs' THEN DATEDIFF(mcs, @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'ms'  THEN DATEDIFF(ms,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'ss'  THEN DATEDIFF(ss,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'mi'  THEN DATEDIFF(mi,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'hh'  THEN DATEDIFF(hh,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'wk'  THEN DATEDIFF(wk,  @startTime, @FinishBenchmarkTime)
                                                 WHEN @durationAccuracy = 'dd'  THEN DATEDIFF(dd,  @startTime, @FinishBenchmarkTime)
                                                 ELSE 0
                                            END;

         PRINT(@crlf + 'Duration of benchmark: ' +  CAST(@BenchmarkDuration AS VARCHAR(30)) + @durationAccuracy + '.')

END TRY

BEGIN CATCH
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER())  +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE())    +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-')        +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE())     +
          ', User name: ' + CONVERT(sysname, CURRENT_USER);
    PRINT(ERROR_MESSAGE());

    IF ERROR_NUMBER() = 535
    PRINT('Your @durationAccuracy = ' + @durationAccuracy + '. Try to use @durationAccuracy with a less precise datepart - seconds (ss) or minutes (mm) or days (dd).' + @crlf +
    'But in log table master.dbo.BenchmarkTSQL all times saving with DATETIME2(7) precise! You can manualy calculate difference after decreasing precise datepart.')
END CATCH;
GO
