/*
Author: Tim Ford
Original link: http://sqlmag.com/database-backup-and-recovery/how-old-are-your-backups
*/
WITH full_backups AS (
SELECT ROW_NUMBER() OVER(PARTITION BY BS.database_name,
                                      BS.type
                             ORDER BY BS.database_name ASC,
                                      BS.backup_finish_date DESC
                        ) AS [Row Number],
        D.name AS [database_name],
        BS.backup_set_id,
        BS.type AS backup_type,
        BS.backup_finish_date,
        D.recovery_model_desc
FROM master.sys.databases AS D
        LEFT JOIN msdb.dbo.[backupset] AS BS
                ON D.name = BS.database_name
/* FILTERING OPTIONS*/
--WHERE BS.[type] = '<backup_type,,D>'
--WHERE BS.[name] = '<database_name,,Foo_DB>'
)
SELECT FB.database_name,
       CASE FB.backup_type
               WHEN 'D' THEN 'Data'
               WHEN 'I' THEN 'Differential'
               WHEN 'L' THEN 'Transaction Log'
       END AS backup_type_desc,
       FB.recovery_model_desc,
       FB.backup_finish_date,
       BMF.physical_device_name,
       DATEDIFF(hour, FB.backup_finish_date, GETDATE()) AS backup_hours,
       DATEDIFF(minute, FB.backup_finish_date, GETDATE()) AS backup_minutes
FROM full_backups FB
 LEFT JOIN msdb.dbo.[backupset] BS ON FB.backup_set_id = BS.backup_set_id
 LEFT JOIN msdb.dbo.backupmediafamily BMF ON BS.media_set_id = BMF.media_set_id
 WHERE FB.[Row Number] = 1
ORDER BY FB.database_name, FB.[Row Number], FB.backup_type;
