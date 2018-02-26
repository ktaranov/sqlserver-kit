#' Benchmarking TSQL statements.
#'
#' @description Run SQL statement specified times, show results, insert execution details into table master.dbo.BenchmarkTSQL (create if not exist).
#'   
#' @param tsqlStatement input character vector
#' TSQL statement for benchmarking
#' @param trustedConnection input boolean vector
#' Using trusted connection 
#' @param clearCache input boolean vector
#' Clear cached plan for TSQL statement
#' @param calcMedian input boolean vector
#' Calculate pseudo median of execution time
#' @param printStepInfo input boolean vector
#' PRINT detailed step information: step count, start time, end time, duration
#' @param saveResults input boolean vector
#' Save benchmark details to master.dbo.BenchmarkTSQL table if saveResults = 1.
#' @param datetimeFun input character vector
#' Define using datetime function, possible values of functions: SYSDATETIME, SYSUTCDATETIME.
#' See details https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql
#' @param durationAccuracy input character vector
#' Duration accuracy calculation, possible values: ns, mcs, ms, ss, mi, hh, wk, dd.
#' See DATEDIFF https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql
#' @param times input integer vector
#' Number of execution TSQL statement.
#'
#' @return print benchmark result
#'
#' @author Konstantin Taranov
#'
#' @examples
#' BenchmarkTSQL("SELECT * FROM sys.databases", trustedConnection=TRUE, clearCache=1, times=10)
#' BenchmarkTSQL("SELECT * FROM sys.databases", trustedConnection=TRUE, clearCache=1, times=3, datetimeFun='SYSUTCDATETIME', calcMedian=TRUE, durationAccuracy='mcs')
#'
#' @export

BenchmarkTSQL <- function(tsqlStatement,
           trustedConnection = TRUE,
           clearCache        = FALSE,
           calcMedian        = FALSE,
           printStepInfo     = TRUE,
           saveResults       = FALSE,
           datetimeFun       = 'SYSDATETIME',
           durationAccuracy  = 'ms',
           times             = 10L) {
    
  library("RODBC")
  options(digits = 7)
  
  if (!datetimeFun %in% list('SYSDATETIME', 'SYSUTCDATETIME')){
    stop(
      print(paste0(
        "For 'datetimeFun' allowed only 'SYSUTCDATETIME' and 'SYSDATETIME'. For details see:", 
        "https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql")
        )
      )
  }
  
  if (!durationAccuracy %in% c('ns'
                              ,'mcs'
                              ,'ms'
                              ,'ss'
                              ,'mi'
                              ,'hh'
                              ,'wk'
                              ,'dd')){
    stop(
      print(paste0(
        "For 'durationAccuracy' allowed only ns, mcs, ms, ss, mi, hh, wk, dd. For details see:",
        "https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql")
        )
      )
  }
  
  if (trustedConnection <- TRUE) {
      connectionString <-
          "driver={SQL Server};server=.;database=master;trusted_connection=true;"
  } else{
      databaseLogin    <- readline(prompt = "Enter a login: ")
      databasePassword <- readline(prompt = "Enter a password: ")
      connectionString <-
          gsub(
              "__pwd__",
              databasePassword,
              "Driver=ODBC Driver 11 for SQL Server;Server=.;Database=master;Uid=__login__;pwd=__pwd__;"
          )
      connectionString <-
          gsub("__login__",
               databaseLogin,
               connectionString)
  }
  
  
  ch <- odbcDriverConnect(connection = connectionString)
  
  original_login <-
      sqlQuery(
          ch,
          "
          DECLARE @originalLogin SYSNAME = ORIGINAL_LOGIN();
          SELECT ORIGINAL_LOGIN() AS OriginalLogin;",
          errors = TRUE
      )
  tsqlstatement_guid <-
      sqlQuery(
          ch,
          "
          DECLARE @TSQLStatementGUID VARCHAR(36) = NEWID();
          SELECT @TSQLStatementGUID AS TSQLStatementGUID;",
          errors = TRUE
      )

  startTime <- Sys.time()
  if (datetimeFun == 'SYSUTCDATETIME')
    startTime <- as.POSIXlt.POSIXct(Sys.time(), tz='UTC')
  print(
    paste0(
      "Benchmark started at ", startTime, " by ", original_login$OriginalLogin))
  
  timetemp <- NULL
  for (i in 1L:times) {
      if (clearCache) {
          tsql <- "
          DECLARE @plan_handle   VARBINARY(64);
          DECLARE @tsqlStatement NVARCHAR(MAX) = N'@tsqlStatementIN';
  
          SELECT @plan_handle = plan_handle
          FROM sys.dm_exec_cached_plans
          CROSS APPLY sys.dm_exec_sql_text(plan_handle)
          WHERE [text] LIKE @tsqlStatement;
          -- LIKE instead = (equal) because = ignore trailing spaces
  
          IF @plan_handle IS NOT NULL DBCC FREEPROCCACHE (@plan_handle);
          "
  
          sqlQuery(
              ch,
              gsub(
                "@tsqlStatementIN", 
                tsqlStatement, 
                tsql),
              errors = TRUE,
              as.is = TRUE
          )
      }
      sqlQuery(
          ch,
          gsub(
            "__datetimeFun__",
            datetimeFun,
            gsub(
              "__durationAccuracy__",
              durationAccuracy,
              paste0(
                 "
                 DECLARE @timestart DATETIME2(7) = __datetimeFun__();\n
                 IF OBJECT_ID('tempdb..#timetemp', 'U') IS NOT NULL DROP TABLE #timetemp\n",
                 "
                 ", tsqlStatement, "\n",
                 "
                  SELECT '", tsqlstatement_guid$TSQLStatementGUID,"' AS TSQLSTATEMENTGUID,
                          ", i," AS STEPROWNUMBER,
                          CAST('", startTime,"' AS DATETIME2(7)) AS STARTTIMESTAMP,
                          @timestart AS RUNTIMESTAMP, 
                          CAST(__datetimeFun__() AS DATETIME2(7)) AS FINISHTIMESTAMP, 
                          CAST(DATEDIFF(__durationAccuracy__,  @timestart, CAST(__datetimeFun__() AS DATETIME2(7))) AS BIGINT) AS DURATION,
                          '", tsqlStatement, ";' AS TSQLSTATEMENT,
                          '", clearCache, "' AS CLEARCACHE,
                          '", printStepInfo, "' AS PRINTSTEPINFO,
                          '", durationAccuracy, "' AS DURATIONACCURACY,
                          '", original_login$OriginalLogin, "' AS ORIGINALLOGIN
                     INTO #timetemp;"
                 )
              )
            ),
          errors = TRUE,
          as.is = TRUE
          )
      timetemp <-
        rbind(
          timetemp,
          sqlQuery(
            ch,
            "
             SELECT RUNTIMESTAMP
                  , FINISHTIMESTAMP
                  , DURATION
              FROM #timetemp",
            errors = TRUE
            )
          )
      
      stepStart <-
        strptime(timetemp$RUNTIMESTAMP[nrow(timetemp)], format = "%Y-%m-%d %H:%M:%OS")
      stepEnd <-
        strptime(timetemp$FINISHTIMESTAMP[nrow(timetemp)], format = "%Y-%m-%d %H:%M:%OS")
      duration <-
        timetemp$DURATION[nrow(timetemp)]
      
      if (printStepInfo){
        print(
          paste0(
            "Run ",
            i,
            ", start: ",
            stepStart,
            ", finish: ",
            stepEnd,
            ", duration: ",
            duration,
            " ",
            durationAccuracy
            )
          )
      }
      if (saveResults)
        sqlQuery(
          ch,
          "IF OBJECT_ID('master.dbo.BenchmarkTSQL', 'U') IS NULL
           BEGIN
            CREATE TABLE master.dbo.BenchmarkTSQL(
                 BenchmarkTSQLID       INT IDENTITY  NOT NULL
               , TSQLStatementGUID     VARCHAR(36)   NOT NULL
               , StepRowNumber         INT           NOT NULL
               , StartTimeStamp        DATETIME2(7)  NOT NULL
               , RunTimeStamp          DATETIME2(7)  NOT NULL
               , FinishTimeStamp       DATETIME2(7)  NOT NULL
               , Duration              BIGINT        NOT NULL
               , TsqlStatement         NVARCHAR(MAX) NOT NULL
               , ClearCache            BIT           NOT NULL
               , PrintStepInfo         BIT           NOT NULL
               , DurationAccuracy      VARCHAR(10)   NOT NULL
               , OriginalLogin         SYSNAME       NOT NULL
            );
          END
    
          INSERT INTO master.dbo.BenchmarkTSQL(
                 TSQLStatementGUID
               , StepRowNumber
               , StartTimeStamp
               , RunTimeStamp
               , FinishTimeStamp
               , Duration
               , TsqlStatement
               , ClearCache
               , PrintStepInfo
               , DurationAccuracy
               , OriginalLogin
          )
          SELECT TSQLSTATEMENTGUID AS TSQLStatementGUID
               , STEPROWNUMBER AS StepRowNumber
               , STARTTIMESTAMP AS StartTimeStamp
               , RUNTIMESTAMP AS RunTimeStamp
               , FINISHTIMESTAMP AS FinishTimeStamp
               , DURATION AS Duration
               , TSQLSTATEMENT AS TsqlStatement
               , CLEARCACHE AS ClearCache
               , PRINTSTEPINFO AS PrintStepInfo
               , DURATIONACCURACY AS DurationAccuracy
               , ORIGINALLOGIN AS OriginalLogin
            FROM #timetemp;"
        )
  }
  
  print(
    gsub(
      "__durationAccuracy__",
      durationAccuracy,
      paste0(
        "Min: ",
        min(timetemp$DURATION),
        " __durationAccuracy__, average: ",
        round(mean(timetemp$DURATION), 7),
        " __durationAccuracy__, max: ",
        max(timetemp$DURATION),
        " __durationAccuracy__",
        if (calcMedian)
          paste0(", median: ",
                 round(median(timetemp$DURATION), 7),
                 ' __durationAccuracy__')
        )
      )
    )
  
  odbcClose(ch)
  
  endTime <- Sys.time()    
  if (datetimeFun == 'SYSUTCDATETIME') 
    endTime <- as.POSIXlt.POSIXct(Sys.time(), tz='UTC')
  
  print(paste0(
      "Benchmark ended at ",
      endTime,
      " by ",
      original_login$OriginalLogin
  ))
}
