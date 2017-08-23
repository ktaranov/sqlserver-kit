/*
Author: Ben Snaidero
Original link: https://www.mssqltips.com/sqlservertip/4166/automate-alerting-for-sql-server-suspect-database-pages/
*/

SELECT sp.database_id AS DatabaseID
  , d.name            AS DatabaseName
  , sp.file_id        AS FileID
  , mf.physical_name  AS FileName
  , sp.page_id        AS PageID
  , CASE
        WHEN sp.event_type = 1
        THEN '823 or 824 error other than a bad checksum or a torn page'
        WHEN sp.event_type = 2
        THEN 'Bad checksum'
        WHEN sp.event_type = 3
        THEN 'Torn Page'
        WHEN sp.event_type = 4
        THEN 'Restored (The page was restored after it was marked bad)'
        WHEN sp.event_type = 5
        THEN 'Repaired (DBCC repaired the page)'
        WHEN sp.event_type = 7
        THEN 'Deallocated by DBCC'
    END                     AS EventDesc
  , sp.error_count          AS ErrorCount
  , sp.last_update_date     AS LastUpdated
FROM msdb.dbo.suspect_pages AS sp
INNER JOIN sys.databases    AS d  ON d.database_id  = sp.database_id
INNER JOIN sys.master_files AS mf ON mf.database_id = sp.database_id AND mf.file_id = sp.file_id;
