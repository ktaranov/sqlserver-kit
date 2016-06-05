/*
Author: Paul S. Randal
Original link: http://www.sqlskills.com/blogs/paul/most-common-latch-classes-and-what-they-mean/
*/
WITH [Latches] AS
    (SELECT
        [latch_class],
        [wait_time_ms] / 1000.0 AS [WaitS],
        [waiting_requests_count] AS [WaitCount],
        100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER() AS [Percentage],
        ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC) AS [RowNum]
    FROM sys.dm_os_latch_stats
    WHERE [latch_class] NOT IN (
        N'BUFFER')
    AND [wait_time_ms] > 0
)
SELECT
    MAX ([W1].[latch_class]) AS [LatchClass], 
    CAST (MAX ([W1].[WaitS]) AS DECIMAL(14, 2)) AS [Wait_S],
    MAX ([W1].[WaitCount]) AS [WaitCount],
    CAST (MAX ([W1].[Percentage]) AS DECIMAL(14, 2)) AS [Percentage],
    CAST ((MAX ([W1].[WaitS]) / MAX ([W1].[WaitCount])) AS DECIMAL (14, 4)) AS [AvgWait_S]
FROM [Latches] AS [W1]
INNER JOIN [Latches] AS [W2]
    ON [W2].[RowNum] <= [W1].[RowNum]
GROUP BY [W1].[RowNum]
HAVING SUM ([W2].[Percentage]) - MAX ([W1].[Percentage]) < 95; -- percentage threshold
GO
