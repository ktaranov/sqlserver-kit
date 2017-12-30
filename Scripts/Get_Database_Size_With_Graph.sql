/*
Author: Denis Gobo
Original link: http://sqlservercode.blogspot.ru/2017/11/use-t-sql-to-create-caveman-graphs.html
*/

SELECT database_name = DB_NAME(database_id) 
     , TotalSizeGB = CAST(SUM(size) * 8.0 / 1024/1024 AS DECIMAL(30,2))
     , PercentSize = (CONVERT(decimal(30,4), (SUM(size) /
                                               (SELECT SUM(CONVERT(decimal(30,4),size))
                                               FROM sys.master_files WITH(NOWAIT)))
                                               ) * 100.00)
     , Graph = replicate('|', ((convert(decimal(30,2), (SUM(size) /
                                                       (SELECT SUM(CONVERT(decimal(30,2),size))
                                                        FROM sys.master_files WITH(NOWAIT)))) * 100)
                                                        )
                        )
FROM sys.master_files WITH(NOWAIT)
GROUP BY database_id
ORDER BY PercentSize DESC;
