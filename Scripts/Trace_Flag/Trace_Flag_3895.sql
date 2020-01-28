/*
https://docs.microsoft.com/en-us/sql/relational-databases/databases/tempdb-database
*/

/* Check is it session trace flag? */
DBCC TRACEON (3895);
GO
/* Answer - no
Ignoring trace flag 3895. It is either an invalid trace flag or a trace flag that can only be specified during server startup.
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
*/

/* Check current working flags */
DBCC TRACESTATUS(-1);
GO

ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON;

/* RESTART SQL SERVER */
DBCC TRACESTATUS(-1);
GO

SELECT SERVERPROPERTY('IsTempdbMetadataMemoryOptimized') AS IsTempdbMetadataMemoryOptimized;
/* Return 1 (enabled) */

ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = OFF;

/* RESTART SQL SERVER */

SELECT SERVERPROPERTY('IsTempdbMetadataMemoryOptimized') AS IsTempdbMetadataMemoryOptimized;
/* Return 0 (disabled) */


/* Add trace flag 3894 in SQL Server startup parameteres using SQL Server Configuration Manager
RESTART SQL SERVER
*/

SELECT SERVERPROPERTY('IsTempdbMetadataMemoryOptimized') AS IsTempdbMetadataMemoryOptimized;
/* Return 1 (enabled) */

/* Remoce trace flag 3894 in SQL Server startup parameteres using SQL Server Configuration Manager
RESTART SQL SERVER
*/
SELECT SERVERPROPERTY('IsTempdbMetadataMemoryOptimized') AS IsTempdbMetadataMemoryOptimized;
/* Return 0 (disabled) */
