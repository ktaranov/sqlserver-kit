# PowerShell Scripts for Microsoft SQL Server Database


## [Csv Sql import](CsvSqlimport.ps1)
Author: Chrissy LeMaire<br />
Original link: https://github.com/ctrlbold/dbatools/blob/master/Functions/CsvSqlimport.ps1<br />
Description: Efficiently imports very large (and small) CSV files into SQL Server using only the .NET Framework and PowerShell


## [Fast table export to csv](Fast_table_to_csv.ps1)
Author: Bill Graziano<br />
Original link: http://www.sqlteam.com/article/fast-csv-import-in-powershell-to-sql-server<br />
Description: Fast export sql query to csv file


## [Get Machine Information to Excel](Get-MachineInformationExcel)
Author: Sander Stad<br />
Original link: https://www.simple-talk.com/sql/database-administration/documenting-sql-server-with-powershell/<br />
Description: Get machine information like memory, CPU and disk configuration and output it to Excel


## [Multiply SQL Server Connections](Multiply_SQL_Server_Connections.ps1)
Author: Kenneth Fisher<br />
Original link: http://sqlstudies.com/2016/02/24/powershell-script-to-create-multiple-sql-server-connections/<br />
Description: This script creates a number of connections ($MaxConnections) to a SQL Server instance ($Server) that connect to a random database and exist/run for a certain amount of time ($WaitType/$WaitTime)


## [Reset SQL Server Sa Password](ResetSqlSaPassword.psm1)
Author: Chrissy LeMaire<br />
Original link: https://gallery.technet.microsoft.com/scriptcenter/Reset-SQL-SA-Password-15fb488d<br />
Description: This function allows administrators to regain access to local or remote SQL Servers by either resetting the sa password, adding sysadmin role to existing login, or adding a new login (SQL or Windows) and granting it sysadmin privileges.


## [SQL_Server_linked_server_connection_check](SQL_Server_linked_server_connection_check.ps1)
Author: Thomas LaRock<br />
Original link: http://thomaslarock.com/2016/03/sql-server-linked-server-connection-test<br />
Description: Test the connection for each linked server defined in a SQL Server


## [Set Extended Events Sessions to AutoStart](Set_Extended_Events_Sessions_to_AutoStart.ps1)
Author: Rob Sewell<br />
Original link: https://sqldbawithabeard.com/2016/03/28/using-powershell-to-set-extended-events-sessions-to-autostart/#comments<br />
Sets Extended Events Sessions to Auto-Start and starts it if it is not running


## [SQL Server Test Backups Script](SQL_Server_Test_backups.ps1)
Author: Derik Hammer<br />
Original link: http://www.sqlshack.com/backup-testing-powershell-part-1-test/<br />
Description: Script will reach out to a sql server central management server, derive a server list and database backup list. Then asynchronously restore them to a test server followed by integrity checks.


## [WOX Permissions](WOX_Permissions.ps1)
Author: Chris Bell<br />
Original link: https://wateroxconsulting.com/archives/sql-server-access/<br />
Description: This script can be used to step through the various levels of security on each of your SQL Server instances
