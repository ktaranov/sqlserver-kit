/*
<documentation>
  <summary>Counts reads and writes for databases</summary>
  <returns>Reads and writes per database.</returns>
  <created>2020-04-07 by Brent Ozar</created>
  <modified>2020-04-15 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Count_Database_Reads_and_Writes.sql</sourceLink>
  <originalLink>https://www.brentozar.com/archive/2020/04/how-can-i-measure-if-my-database-does-more-reads-than-writes/</originalLink>
</documentation>
*/


WITH reads_and_writes AS (
    SELECT db.name AS database_name,
        SUM(user_seeks + user_scans + user_lookups) AS reads,
        SUM(user_updates) AS writes,
        SUM(user_seeks + user_scans + user_lookups + user_updates) AS all_activity
    FROM sys.dm_db_index_usage_stats us
    INNER JOIN sys.databases db ON us.database_id = db.database_id
    GROUP BY db.name
)
SELECT
    database_name
    , reads
    , ((reads * 1.0) / all_activity) * 100 AS reads_percent
    , writes
    , ((writes * 1.0) / all_activity) * 100 AS writes_percent
    FROM reads_and_writes AS rw
    ORDER BY database_name;
