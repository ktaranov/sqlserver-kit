/*
Trace Flag Demo: 3895
!!! Undocumented trace flag !!!
Function: In SQL Server 2019, when you enable the [Memory-Optimized TempDB Metadata](https://docs.microsoft.com/en-us/sql/relational-databases/databases/tempdb-database) feature, this trace flag is automatically enabled after the next restart.
When you disable that feature, the trace flag is automatically removed after the next restart.
Also if you add race flag 3895 to startup parameters after restarting SQL Server option `IsTempdbMetadataMemoryOptimized` will be enabled.
SQL Server Version: 2019
Information link: https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Trace%20Flag.md#3895
*/

/* Check is it session trace flag? */
DBCC TRACEON (3895);
GO
/* Answer - NO
Ignoring trace flag 3895. It is either an invalid trace flag or a trace flag that can only be specified during server startup.
DBCC execution completed. If DBCC printed error messages, contact your system administrator.
*/

/* Check current working flags */
DBCC TRACESTATUS(-1);
GO

/* https://docs.microsoft.com/en-us/sql/relational-databases/databases/tempdb-database */
ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON;

/* RESTART SQL SERVER */
DBCC TRACESTATUS(-1);
GO
/* Return that 3895 trace flag is enabled */

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
