/*
Author:Ryan Adams
Original link: http://www.ryanjadams.com/2017/05/implementing-buffer-pool-extension
*/

--Review current BPE configuration
SELECT [path], state_description, current_size_in_kb,
CAST(current_size_in_kb/1048576.0 AS DECIMAL(10,2)) AS [Size (GB)]
FROM sys.dm_os_buffer_pool_extension_configuration;
 
--Reduce SQL Server Max memory to restrict the BP and force the use of BPE
EXEC sys.sp_configure 'show advanced options', '1'  RECONFIGURE WITH OVERRIDE;
GO
EXEC sys.sp_configure 'max server memory (MB)', '2000';
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sys.sp_configure 'show advanced options', '0'  RECONFIGURE WITH OVERRIDE;
GO
/*********** WE HAVE TO RESTART SQL SERVER FOR BPE TO SEE THE RAM CHANGE ***************/
 
--Enable BPE
--Go look at the file size on disk right after you run this
ALTER SERVER CONFIGURATION
SET BUFFER POOL EXTENSION ON (FILENAME = 'C:\Temp\BP_Extension.BPE', SIZE = 2 GB);
 
--Now that it is enabled we'll inspect the configuration again
SELECT [path], state_description, current_size_in_kb,
CAST(current_size_in_kb/1048576.0 AS DECIMAL(10,2)) AS [Size (GB)]
FROM sys.dm_os_buffer_pool_extension_configuration;
 
--Try to read enough data to fill BP and start using BPE
USE AdventureworksDW2016CTP3;
GO
SELECT * FROM dbo.FactResellerSalesXL_PageCompressed;
--If the above didn't do the trick then query this table as well
--SELECT * FROM dbo.FactResellerSalesXL_CCI;
 
--Let's see what went to BPE.  If there are no results then go query more data.
SELECT DB_NAME(database_id) AS [Database Name], COUNT(page_id) AS [Page Count],
CAST(COUNT(*)/128.0 AS DECIMAL(10, 2)) AS [Buffer size(MB)],
AVG(read_microsec) AS [Avg Read Time (microseconds)]
FROM sys.dm_os_buffer_descriptors
WHERE database_id <> 32767
AND is_in_bpool_extension = 1
GROUP BY DB_NAME(database_id)
ORDER BY [Buffer size(MB)] DESC;
 
--Turn BPE off. Go look in c:\temp to see what happens to the physical data file
ALTER SERVER CONFIGURATION
SET BUFFER POOL EXTENSION OFF;
 
--Put Max Server Memory back where it was
EXEC sys.sp_configure 'show advanced options', '1'  RECONFIGURE WITH OVERRIDE;
GO
EXEC sys.sp_configure 'max server memory (MB)', '3500';
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sys.sp_configure 'show advanced options', '0'  RECONFIGURE WITH OVERRIDE;
GO