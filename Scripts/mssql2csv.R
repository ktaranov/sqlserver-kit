options(stringsAsFactors = FALSE)

library("data.table")
library("RODBC")
library("logging")

loggerName <- "mmssql2csv"
addHandler(writeToConsole, logger = loggerName)

loginfo(msg = "Start", logger = loggerName)

rodbcSQLQeuryToDF <- function(connectionString, sqlQuery) {
  ch <- odbcDriverConnect(connection = connectionString)
  df <- sqlQuery(ch, sqlQuery, errors = TRUE)
  odbcClose(ch)
  return(as.data.table(df))
}

outputFolder <- "e:/333/"
numberOfProcess <- as.integer(Sys.getenv("NUMBER_OF_PROCESSORS"))
connectionString <-
  "Driver=ODBC Driver 11 for SQL Server;Server=.;Database=NIIGAZ;Uid=asp_niigaz;pwd=;"

pass <- readline(prompt = "Enter a SQL Server user password: ")

connectionString <-
  gsub("pwd=", paste0("pwd=", pass), connectionString)


listTables <- rodbcSQLQeuryToDF(
    connectionString = connectionString,
    sqlQuery = "
    WITH TablePages AS (
    SELECT s.[object_id]
    , SUM(s.reserved_page_count) AS reserved_pages
    , SUM(s.used_page_count)     AS used_pages
    , SUM(CASE WHEN index_id < 2 THEN in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count
    ELSE lob_used_page_count + row_overflow_used_page_count
    END)                   AS pages
    , (SELECT COUNT(i.[object_id]) FROM sys.indexes AS i WHERE s.[object_id] = i.[object_id] AND i.[type] <> 0) AS IndexCount
    , SUM(row_count)           AS NumberOfRows
    FROM sys.dm_db_partition_stats AS s
    GROUP BY [object_id]
    )
    , ExtraData AS (
    SELECT p.[object_id]
    , COUNT(*)                 AS IndexCount
    , SUM(reserved_page_count) AS reserved_pages
    , SUM(used_page_count)     AS used_pages
    FROM sys.dm_db_partition_stats  AS p
    LEFT JOIN sys.internal_tables   AS it ON p.[object_id] = it.[object_id]
    WHERE it.internal_type IN (202, 204, 211, 212, 213, 214, 215, 216)
    GROUP BY p.[object_id]
    )
    SELECT --TOP(50)
           p.[object_id]
         , OBJECT_SCHEMA_NAME(p.[object_id]) AS ShemaName
         , OBJECT_NAME(p.[object_id])        AS TableName
         , QUOTENAME(OBJECT_SCHEMA_NAME(p.[object_id])) + N'.' + QUOTENAME(OBJECT_NAME(p.[object_id])) AS FullTableName
         , p.NumberOfRows
         , (p.reserved_pages + ISNULL(e.reserved_pages, 0)) * 8 AS ReservedKb
         , p.pages * 8 AS DataKb
         , p.IndexCount
         ,  CASE WHEN p.IndexCount <> 0 AND p.used_pages + ISNULL(e.used_pages, 0) >= p.pages
                 THEN p.used_pages + ISNULL(e.used_pages, 0) - p.pages
            ELSE 0
            END * 8 AS IndexAllKb
         ,  CASE WHEN p.reserved_pages + ISNULL(e.reserved_pages, 0) > p.used_pages + ISNULL(e.used_pages, 0)
                 THEN p.reserved_pages + ISNULL(e.reserved_pages, 0) - p.used_pages + ISNULL(e.used_pages, 0)
            ELSE 0
            END * 8 AS UnusedKb
    FROM TablePages     AS p
    LEFT JOIN ExtraData AS e ON p.[object_id] = e.[object_id]
    WHERE OBJECT_SCHEMA_NAME(p.[object_id]) <> 'sys' AND p.pages > 0
    ORDER BY DataKb ASC;
    "
  )

# GRANT VIEW DATABASE STATE TO asp_niigaz;

for (n in listTables$FullTableName) {
  tryCatch({
    loginfo(msg = paste0("Start reading: ", n))
    
    dt <- rodbcSQLQeuryToDF(
      connectionString = connectionString,
      sqlQuery =
        paste0("SELECT * FROM ", n, ";")
    )
    
    loginfo(msg = paste0("End reading:   ", n))
    
    fwrite(x = dt, file = paste0(outputFolder, n, ".csv"))
    
  },
  error = function(e)
    logerror(paste(e,
                   n,
                   sep = "\t"), logger = loggerName),
  finally = next)
  
}


# Remove password, connection string and latest largest data.table object ####
rm(dt, pass, connectionString)
gc()


# Compare number of files with number of tables ####
csvFiles <- as.data.table(list.files(path = outputFolder, pattern = "*.csv"))
setnames(csvFiles, c("V1"), c("FullTableName"))
csvFiles[, FullTableName := gsub(".csv", "", FullTableName)]

print("List of tables not exported from SQL Server:")
print(fsetdiff(listTables[, "FullTableName"], csvFiles))

loginfo(msg = "End", logger = loggerName)
