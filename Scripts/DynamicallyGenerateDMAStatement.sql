/*
Author: Kenneth Fisher
Original link: https://sqlstudies.com/2017/06/21/query-to-run-command-line-dma-on-each-database
*/
-- Dynamically generate the command line DMA statement for each database

SELECT name, '"C:\Program Files\Microsoft Data Migration Assistant\DmaCmd.exe" ' + 
    '/AssessmentName="DMA_Output" ' +
    '/AssessmentDatabases="Server=' + @@ServerName +
    ';Initial Catalog=' + sys.databases.name +
    ';Integrated Security=true" ' + 
    '/AssessmentEvaluateCompatibilityIssues /AssessmentOverwriteResult ' + 
    '/AssessmentResultCSV="\\PathToSaveTo\'+REPLACE(@@ServerName,'\','_')+'\'+sys.databases.name+'.CSV"' +
    ' > "\\PathToSaveTo\'+REPLACE(@@ServerName,'\','_')+'\'+sys.databases.name+'.LOG"'
FROM sys.databases WHERE state <> 6 -- exclude offline databases
  and database_id > 4 -- Exclude system databases
  