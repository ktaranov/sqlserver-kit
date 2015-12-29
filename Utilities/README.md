# SQL Server Utilities
Useful SQL Server utilities

Source link:
 - [Microsoft's Log Parser Utility: Swell ETL](https://www.simple-talk.com/sql/sql-tools/microsofts-log-parser-utility-swell-etl/) by Robert Sheldon
 - [SQL Server tablediff utility](https://www.simple-talk.com/sql/sql-tools/sql-server-tablediff-utility/) by Robert Sheldon
 - [Seven SQL Server Under-Used](https://www.simple-talk.com/sql/database-administration/seven-sql-server-under-used-utilities/) by Robert Sheldon

To Add:
 - [Idera SQL Check]: https://www.idera.com/productssolutions/freetools/sqlcheck
 - Idera SQL Fragmentation Analyzer
 - Idera SQL Heat Map
 - Idera SQL Hekaton Memory Check
 - Idera SQL Page Viewer
 - Idera SQL Update Statistics
 - Idera SQL Statistics Aggregator
 - Idera SQL Backup Status Reporter
 - Idera SQL Integrity Check
 - Idera SQL Job Manager
 - Idera Azure SQL Database Backup
 - Idera SQL Column Search
 - Idera SQL Permissions Extractor


| Name                                          | Official/Download page | Release Date | Author      | Free version | Paid/Price |
|-----------------------------------------------|------------------------|------------- | ------------| ------------ | -----------|
| [tablediff Utility](#tablediff-utility)       | [tablediff Utility]    | -            | Microsoft   | Yes          | No         |
| [Microsoft Log Parser](#microsoft-log-parser) | [Microsoft Log Parser] | -            | Microsoft   | Yes          | No         |
| [Diskspd](#diskspd)                           | [Diskspd]              | 2015-12-14   | Microsoft   | Yes          | No         |
| [HammerDB](#hammerdb)                         | [HammerDB]             | 2015-05-04   | Open Source | Yes          | No         |
| [dta Utility](#dta-utility)                   | [dta Utility]          | -            | Microsoft   | Yes          | No         |
| [osql Utility](#osql-utility)                 | [osql Utility]         | -            | Microsoft   | Yes          | No         |
| [sqldiag Utility](#sqldiag-utility)           | [sqldiag Utility]      | -            | Microsoft   | Yes          | No         |
| [sqldumper Utility](#sqldumper-utility)       | [sqldumper Utility]    | -            | Microsoft   | Yes          | No         |
| [SqlLocalDB Utility](#sqllocaldb-utility)     | [SqlLocalDB Utility]   | -            | Microsoft   | Yes          | No         |
| [sqllogship Utility](#sqllogship-utility)     | [sqllogship Utility]   | -            | Microsoft   | Yes          | No         |
| [sqlservr Application](#sqlservr-application) | [sqlservr Application] | -            | Microsoft   | Yes          | No         |
| [SQL XEvent Profiler](#sql-xevent-profiler)   | [SQL XEvent Profiler]  | 2014-03-14   | Idera       | Yes          | No         |
| [DLM Dashboard](#dlm-dashboard)               | [DLM Dashboard]        | 2015-16-12   | Red Gate    | Yes          | No         |
| [SQL DBA Bundle](#sql-dba-bundle)             | [SQL DBA Bundle]       | 2015-16-12   | Red Gate    | No           | Yes/$2640  |


## Microsoft Log Parser
Log parser is a powerful, versatile tool that provides universal query access to text-based data such as log files,<br />
XML files and CSV files, as well as key data sources on the Windows operating system such as the Event Log, the Registry, the file system, and Active Directory. 


## tablediff Utility
The tablediff utility is used to compare the data in two tables for non-convergence, and is particularly useful for troubleshooting non-convergence<br />
in a replication topology. This utility can be used from the command prompt or in a batch file to perform the following tasks:
 - A row by row comparison between a source table in an instance of Microsoft SQL Server acting as a replication Publisher and the destination table at one or more instances of SQL Server acting as replication Subscribers.
 - Perform a fast comparison by only comparing row counts and schema.
 - Perform column-level comparisons.
 - Generate a Transact-SQL script to fix discrepancies at the destination server to bring the source and destination tables into convergence.
 - Log results to an output file or into a table in the destination database.


## Diskspd
DISKSPD is a storage load generator / performance test tool from the Windows/Windows Server and Cloud Server Infrastructure Engineering teams.

Compilation is supported with Visual Studio and Visual Studio Express. Use the Visual Studio solution file inside the diskspd_vs2013 directory.


## HammerDB
HammerDB is an open source database load testing and benchmarking tool for Oracle, SQL Server, DB2, TimesTen, PostgreSQL, Greenplum, Postgres Plus Advanced Server, MySQL,  Redis and Trafodion SQL on Hadoop.


## dta Utility
Capture performance and usage data about your Microsoft SQL Server 2005+ databases to inform insights and improve troubleshooting.

Key real-time metrics provide an overview of your databases and detailed measurements about memory usage, connections, network I/O, and file I/O.


## osql Utility
The osql utility allows you to enter Transact-SQL statements, system procedures, and script files.<br />
This utility uses ODBC to communicate with the server.


## sqldiag Utility
The SQLdiag utility is a general purpose diagnostics collection utility that can be run as a console application or as a service.<br />
You can use SQLdiag to collect logs and data files from SQL Server and other types of servers, and use it to monitor your servers over time<br />
or troubleshoot specific problems with your servers.<br />
SQLdiag is intended to expedite and simplify diagnostic information gathering for Microsoft Customer Support Services.


## sqldumper Utility
ou can use the Sqldumper.exe utility to generate a dump file on demand for any Microsoft Windows application.<br />
For example, you can generate a dump file for debugging an application problem when a computer that is running SQL Server 2005,<br />
Microsoft SQL Server 2008, Microsoft SQL Server 2008 R2, or Microsoft SQL Server 2012 is not responding to user requests.<br />
A dump file can be a mini-dump file, a full dump file, or a filtered dump file.


## SqlLocalDB Utility
SqlLocalDB lets you create, delete, start, stop, and perform a number of other related tasks on an instance of SQL Server 2012 Express LocalDB,<br />
an execution mode of SQL Server Express that’s targeted at developers. A LocalDB instance uses a minimal set of files to start the database engine.


## sqllogship Utility
The sqllogship application performs a backup, copy, or restore operation and associated clean-up tasks for a log shipping configuration.<br />
The operation is performed on a specific instance of Microsoft SQL Server for a specific database.


## sqlservr Application
The sqlservr application starts, stops, pauses, and continues an instance of Microsoft SQL Server from a command prompt.


## SQL XEvent Profiler
Idera’s SQL XEvent Profiler emulates the functionality and simplicity of SQL Server Profiler, letting you quickly view data from SQL events<br />
and see what's happening on the server. Plus, it leverages SQL Extended Events (XEvents) as the backing technology — making it more efficient than SQL Trace.


## DLM Dashboard
DLM Dashboard tracks your database schemas and alerts you when they change.<br />
As a SQL Server user, you want to make sure all your databases are in the right state.<br />
DLM Dashboard monitors up to 50 of your databases, and sends you an email alert as soon as your databases start to drift,<br />
or change from their expected state. On the web dashboard, you can see exactly what changed, who made the changes, and when.


## SQL DBA Bundle
Red Gate 7 products for DBA:
 - SQL Backup Pro: Compress, securely encrypt, and strengthen your backups
 - SQL Monitor: Monitor your SQL Server performance and be alerted to problems
 - SQL Multi Script Unlimited: Deploy multiple scripts to multiple servers with just one click
 - SQL Compare: Compare and synchronize database schemas
 - SQL Data Compare: Compare and synchronize database contents
 - SQL Prompt: Write, format, and refactor SQL effortlessly
 - SQL Doc: Automatically generate database documentation


[Microsoft Log Parser]:https://www.microsoft.com/en-us/download/details.aspx?id=24659
[tablediff Utility]:https://msdn.microsoft.com/en-us/library/ms162843.aspx
[Diskspd]:https://github.com/microsoft/diskspd
[HammerDB]:http://www.hammerdb.com/
[dta Utility]:https://msdn.microsoft.com/en-us/library/ms162812.aspx
[osql Utility]:https://msdn.microsoft.com/en-us/library/ms162806.aspx
[sqldiag Utility]:https://msdn.microsoft.com/en-us/library/ms162833.aspx
[sqldumper Utility]:https://support.microsoft.com/en-us/kb/917825
[SqlLocalDB Utility]:https://msdn.microsoft.com/en-us/library/hh212961.aspx
[sqllogship Utility]:https://msdn.microsoft.com/en-us/library/bb283327.aspx
[sqlservr Application]:https://msdn.microsoft.com/en-us/library/ms162819.aspx
[SQL XEvent Profiler]:https://www.idera.com/productssolutions/freetools/sqlxeventprofiler
[DLM Dashboard]:http://www.red-gate.com/products/dlm/dlm-dashboard/
[SQL DBA Bundle]:http://www.red-gate.com/products/dba/dba-bundle/
