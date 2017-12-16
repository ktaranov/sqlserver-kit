IF OBJECT_ID('dbo.sp_BenchmarkTSQL', 'P') IS NULL 
    EXECUTE ('CREATE PROCEDURE dbo.sp_BenchmarkTSQL AS SELECT 1;');
GO


ALTER PROCEDURE dbo.sp_BenchmarkTSQL(
      @tsqlStatement       NVARCHAR(MAX) = N''
    , @numberOfExecution   INT           = 10
    , @saveResults         BIT           = 0
    , @clearCache          BIT           = 0
    , @calcMedian          BIT           = 0
    , @printStepInfo       BIT           = 1
)
/*
.SYNOPSIS
    Calculate SQL statement execution time, save results if need.

.DESCRIPTION
    Run SQL statement specified times, show results in ms, insert execution details into table dbo.BenchmarkTSQL (create if not exist).

.PARAMETER @tsqlStatement
    TSQL statement for benchmarking.

.PARAMETER @numberOfExecution
    Number of execution TSQL statement.

.PARAMETER @saveResults
    Save benchmark details to dbo.BenchmarkTSQL table.

.PARAMETER @clearCache
    Clear cached plan for TSQL statement.

.PARAMETER @calcMedian
    Calculate pseudo median of execution time.

.PARAMETER @printStepInfo
    PRINT detailed step information: step count, start time, end time, duration

.EXAMPLE
    EXEC sp_BenchmarkTSQL @tsqlStatement = 'SELECT * FROM , sys.databases';
    -- RETURN: Incorrect syntax near ','.

.EXAMPLE
    EXEC sp_BenchmarkTSQL @tsqlStatement = 'SELECT * FROM sys.databases';

.EXAMPLE
    EXEC sp_BenchmarkTSQL @tsqlStatement = 'SELECT TOP(10000) * FROM sys.objects AS o1 CROSS JOIN sys.objects AS o2;'
       , @numberOfExecution = 100
       , @calcMedian        = 1
       , @clearCache        = 1
       , @printStepInfo     = 0;

.NOTE
    Author: Aleksei Nagorskii
    Created date: 2017-12-14
    Version: 1.0

    Author: Aleksei Nagorskii
    Modified date: 2017-12-15
    Version: 1.1

    Author: Konstantin Taranov
    Modified date: 2017-12-16
    Version: 1.2
*/
AS
BEGIN TRY

    SET NOCOUNT ON;

    IF @tsqlStatement IS NULL
        THROW 55001, '@tsqlStatement is NULL, please specify TSQL statement.', 1;
    IF @tsqlStatement = N''
        THROW 55001, '@tsqlStatement is empty, please specify TSQL statement.', 1;

    IF EXISTS (
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
        DECLARE @err_msg NVARCHAR(MAX);

        SELECT @err_msg = [error_message]
        FROM sys.dm_exec_describe_first_result_set(@tsqlStatement, NULL, 0)
        WHERE column_ordinal = 0;

        THROW 55002, @err_msg, 1;
    END

    DECLARE @crlf        VARCHAR(10)   = CHAR(10);
    DECLARE @cts         DATETIME      = CURRENT_TIMESTAMP;
    DECLARE @r           INT           = 0;
    DECLARE @handle      VARBINARY(64);
    DECLARE @min         INT;
    DECLARE @avg         INT;
    DECLARE @max         INT;
    DECLARE @median      REAL;
    DECLARE @plan_handle VARBINARY(64);
    DECLARE @rts         DATETIME;
    DECLARE @t           TABLE (
        StartTimeStamp   DATETIME2,
        RunTimeStamp     DATETIME2,
        FinishTimeStamp  DATETIME2,
        TsqlStatement    NVARCHAR(MAX),
        ClearCache       BIT
        );

    PRINT ('Benchmark started at ' + CONVERT(VARCHAR(23), CURRENT_TIMESTAMP, 121));

    WHILE @r < @numberOfExecution
    BEGIN
        SET @r = @r + 1;
        SET @rts = CURRENT_TIMESTAMP;

        IF @clearCache = 1
        BEGIN
            SELECT @handle = plan_handle
            FROM sys.dm_exec_cached_plans
            CROSS APPLY sys.dm_exec_sql_text(plan_handle)
            WHERE [text] LIKE @tsqlStatement;

            IF @handle IS NOT NULL DBCC FREEPROCCACHE (@handle);
        END;

        EXECUTE sp_executesql @tsqlStatement;

        IF @printStepInfo = 1
        PRINT (
               'Run ' + CASE WHEN @r < 10  THEN '  ' + CAST(@r AS VARCHAR(30))
                             WHEN @r < 100 THEN ' '  + CAST(@r AS VARCHAR(30))
                             ELSE CAST(@r AS VARCHAR(30))
                        END +
               ', start: ' + CONVERT(VARCHAR(23), @rts, 121) +
               ', finish: ' + CONVERT(VARCHAR(23), CURRENT_TIMESTAMP, 121) +
               ', duration: ' + CAST(DATEDIFF(ms, @rts, CURRENT_TIMESTAMP) AS VARCHAR(MAX)) + 'ms.'
               );

        INSERT @t (
              StartTimeStamp
            , RunTimeStamp
            , FinishTimeStamp
            , TsqlStatement
            , ClearCache
            )
        VALUES (
              @cts
            , @rts
            , CURRENT_TIMESTAMP
            , @tsqlStatement
            , @clearCache
            );
    END;

    SELECT @min = MIN(DATEDIFF(ms, RunTimeStamp, FinishTimeStamp))
         , @avg = AVG(DATEDIFF(ms, RunTimeStamp, FinishTimeStamp))
         , @max = MAX(DATEDIFF(ms, RunTimeStamp, FinishTimeStamp))
    FROM @t;

    IF @calcMedian = 1
    BEGIN
        SELECT @median = (
         (SELECT MAX(TMIN) FROM
           (SELECT TOP 50 PERCENT DATEDIFF(ms, RunTimeStamp, FinishTimeStamp) AS TMIN FROM @t ORDER BY TMIN) AS BottomHalf)
        +
         (SELECT MIN(TMAX) FROM
           (SELECT TOP 50 PERCENT DATEDIFF(ms, RunTimeStamp, FinishTimeStamp) AS TMAX FROM @t ORDER BY TMAX DESC) AS TopHalf)
        ) / 2.0;
    END;

    PRINT (
          'Min: '         + CAST(@min AS VARCHAR(30)) +
          'ms, Max: '     + CAST(@max AS VARCHAR(30)) +
          'ms, Average: ' + CAST(@avg AS VARCHAR(30)) +
          CASE WHEN @calcMedian = 1 THEN 'ms, Median: ' + CAST(@median AS VARCHAR(30)) ELSE '' END +
          'ms.' + @crlf +
          'Benchmark finished at ' + CONVERT(VARCHAR(23), CURRENT_TIMESTAMP, 121) + '.'
          );


    IF @saveResults = 1
        IF OBJECT_ID('.[dbo].[BenchmarkTSQL]', 'U') IS NULL
            SELECT * INTO dbo.BenchmarkTSQL FROM @t
        ELSE
            INSERT INTO dbo.BenchmarkTSQL SELECT * FROM @t;

    SET NOCOUNT ON;
END TRY

BEGIN CATCH
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
          ', User name: ' + CONVERT(sysname, CURRENT_USER);
    PRINT ERROR_MESSAGE();
END CATCH;
GO
