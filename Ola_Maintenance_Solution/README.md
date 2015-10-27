# SQL Server Backup, Integrity Check, and Index and Statistics Maintenance

The SQL Server Maintenance Solution comprises scripts for running backups, integrity checks, and index and statistics maintenance on all editions of Microsoft SQL Server 2005, SQL Server 2008, SQL Server 2008
R2, SQL Server 2012, and SQL Server 2014. The solution is based on stored procedures, the sqlcmd utility, and SQL Server Agent jobs. I designed the solution for the most mission-critical environments, and it is used in many [organizations](/organizations.html) around the world. Numerous SQL Server community experts recommend the SQL Server Maintenance Solution, which has been a Gold winner in the [2013](http://sqlmag.com/sql-server/best-free-sql-server-tool-2013), [2012](http://sqlmag.com/sql-server/2012-sql-server-pro-editors-best-and-community-choice-awards), [2011](http://sqlmag.com/sql-server/2011-sql-server-magazine-editors-best-and-community-choice-awards),
and [2010](http://sqlmag.com/sql-server/2010-sql-server-magazine-editors-best-and-community-choice-awards)
SQL Server Magazine Awards. The SQL Server Maintenance Solution is [free](/license.html).


## Getting Started

Download [MaintenanceSolution.sql](/scripts/MaintenanceSolution.sql).
This script creates all the objects and jobs that you need.
Learn more about using the SQL Server Maintenance Solution:
 - [DatabaseBackup](/sql-server-backup.sql): SQL Server Backup
 - [DatabaseIntegrityCheck](/sql-server-integrity-check.sql): SQL Server Integrity Check
 - [IndexOptimize](/sql-server-index-and-statistics-maintenance.sql): SQL Server Index and Statistics Maintenance
 - [CommandExecute](/CommandExecute.sql): Stored procedure to execute and log commands
 - [CommandLog](/CommandLog.sql:) Table to log commands

Note that you always need CommandExecute; DatabaseBackup, DatabaseIntegrityCheck, and IndexOptimize are using it. You need CommandLog if you are going to use the option to log commands to a table.

The SQL Server Maintenance Solution is supported on SQL Server 2005, SQL Server 2008, SQL Server 2008 R2, SQL Server 2012, and SQL Server 2014.
