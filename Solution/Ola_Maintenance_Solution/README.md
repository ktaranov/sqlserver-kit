# SQL Server Backup, Integrity Check, and Index and Statistics Maintenance

Source link: [ola.hallengren.com](https://ola.hallengren.com)

The SQL Server Maintenance Solution comprises scripts for running backups, integrity checks, and index and statistics maintenance
on all editions of Microsoft SQL Server 2005, SQL Server 2008, SQL Server 2008 R2, SQL Server 2012, SQL Server 2014 and SQL Server 2016.
The solution is based on stored procedures, the sqlcmd utility, and SQL Server Agent jobs.
Ola Hallengren designed the solution for the most mission-critical environments, and it is used in many 
[organizations](https://ola.hallengren.com/organizations.html) around the world.
Numerous SQL Server community experts recommend the SQL Server Maintenance Solution, which has been a Gold winner in the
[2013](http://sqlmag.com/sql-server/best-free-sql-server-tool-2013), 
[2012](http://sqlmag.com/sql-server/2012-sql-server-pro-editors-best-and-community-choice-awards), 
[2011](http://sqlmag.com/sql-server/2011-sql-server-magazine-editors-best-and-community-choice-awards), 
and [2010](http://sqlmag.com/sql-server/2010-sql-server-magazine-editors-best-and-community-choice-awards)
SQL Server Magazine Awards.
The SQL Server Maintenance Solution is [free](https://ola.hallengren.com/license.html).


## Getting Started

Download [MaintenanceSolution.sql](/Ola_Maintenance_Solution/MaintenanceSolution.sql).
This script creates all the objects and jobs that you need. Learn more about using the SQL Server Maintenance Solution.

You can also download the objects as separate scripts:
 - [DatabaseBackup](/Ola_Maintenance_Solution/DatabaseBackup.sql): SQL Server Backup
 - [DatabaseIntegrityCheck](/Ola_Maintenance_Solution/DatabaseIntegrityCheck.sql): SQL Server Integrity Check
 - [IndexOptimize](/Ola_Maintenance_Solution/IndexOptimize.sql): SQL Server Index and Statistics Maintenance
 - [CommandExecute](/Ola_Maintenance_Solution/CommandExecute.sql): Stored procedure to execute and log commands
 - [CommandLog](/Ola_Maintenance_Solution/CommandLog.sql): Table to log commands

Note that you always need CommandExecute, DatabaseBackup, DatabaseIntegrityCheck, and IndexOptimize are using it.
You need CommandLog if you are going to use the option to log commands to a table.
