library("RODBC")

trustedConnection <- TRUE
clearCache <- FALSE
times <- 3L
tsqlStatement <- "WAITFOR DELAY '00:00:05';"
  # "SELECT TOP(10000) * FROM sys.objects AS o1 CROSS JOIN sys.objects AS o2 CROSS JOIN sys.objects AS o3;"


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

original_login <- sqlQuery(ch, "DECLARE @originalLogin SYSNAME = ORIGINAL_LOGIN();
                           SELECT ORIGINAL_LOGIN() AS OriginalLogin ;", errors = TRUE)

startTime <- Sys.time()
print(paste0(paste0(paste0("Benchmark started at "
                           , startTime), " by "), original_login$OriginalLogin)
)

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

    sqlQuery(ch, gsub("@tsqlStatementIN", tsqlStatement, tsql), errors = TRUE)
  }
  
  stepStart <- Sys.time()
  sqlQuery(ch, tsqlStatement, errors = TRUE)
  
  stepEnd <- Sys.time()
  duration <- stepEnd - stepStart
  
  print(paste0(paste0(paste0(paste0(paste0(
    paste0(paste0("Run ", i), ", start: "), stepStart
  ), ", finish: "), Sys.time()), ", duration: "), duration))

}

odbcClose(ch)

print(paste0(paste0(paste0("Benchmark ended at "
                           , Sys.time()), " by "), original_login$OriginalLogin)
)
