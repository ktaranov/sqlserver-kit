# SQL Server Utilities
Useful SQL Server utilities

Source link:
 - [Microsoft's Log Parser Utility: Swell ETL](https://www.simple-talk.com/sql/sql-tools/microsofts-log-parser-utility-swell-etl/) by Robert Sheldon
 - [SQL Server tablediff utility](https://www.simple-talk.com/sql/sql-tools/sql-server-tablediff-utility/) by Robert Sheldon
 - [Seven SQL Server Under-Used](https://www.simple-talk.com/sql/database-administration/seven-sql-server-under-used-utilities/) by Robert Sheldon


| Name                                                      | Official/Download page       | Release Date | Author      | Free version | Paid/Price  |
|-----------------------------------------------------------|------------------------------|------------- | ------------| ------------ | ------------|
| [GraphView](#graphview)                                   | [GraphView]                  | -            | Microsoft   | Yes          | No          |
| [tablediff Utility](#tablediff-utility)                   | [tablediff Utility]          | -            | Microsoft   | Yes          | No          |
| [Microsoft Log Parser](#microsoft-log-parser)             | [Microsoft Log Parser]       | -            | Microsoft   | Yes          | No          |
| [Diskspd](#diskspd)                                       | [Diskspd]                    | 2015-12-14   | Microsoft   | Yes          | No          |
| [HammerDB](#hammerdb)                                     | [HammerDB]                   | 2015-05-04   | Open Source | Yes          | No          |
| [dta Utility](#dta-utility)                               | [dta Utility]                | -            | Microsoft   | Yes          | No          |
| [osql Utility](#osql-utility)                             | [osql Utility]               | -            | Microsoft   | Yes          | No          |
| [sqldiag Utility](#sqldiag-utility)                       | [sqldiag Utility]            | -            | Microsoft   | Yes          | No          |
| [sqldumper Utility](#sqldumper-utility)                   | [sqldumper Utility]          | -            | Microsoft   | Yes          | No          |
| [SqlLocalDB Utility](#sqllocaldb-utility)                 | [SqlLocalDB Utility]         | -            | Microsoft   | Yes          | No          |
| [sqllogship Utility](#sqllogship-utility)                 | [sqllogship Utility]         | -            | Microsoft   | Yes          | No          |
| [sqlservr Application](#sqlservr-application)             | [sqlservr Application]       | -            | Microsoft   | Yes          | No          |
| [sqlps Utility](#sqlps-utility)                           | [sqlps Utility]              | -            | Microsoft   | Yes          | No          |
| [sqlmaint Utility](#sqlmaint-utility)                     | [sqlmaint Utility]           | -            | Microsoft   | Yes          | No          |
| [Ssms Utility](#ssms-utility)                             | [Ssms Utility]               | -            | Microsoft   | Yes          | No          |
| [dtexec Utility](#dtexec-utility)                         | [dtexec Utility]             | -            | Microsoft   | Yes          | No          |
| [SQL XEvent Profiler](#sql-xevent-profiler)               | [SQL XEvent Profiler]        | 2014-03-14   | Idera       | Yes          | No          |
| [DLM Dashboard](#dlm-dashboard)                           | [DLM Dashboard]              | 2015-12-16   | Red Gate    | Yes          | No          |
| [SQL DBA Bundle](#sql-dba-bundle)                         | [SQL DBA Bundle]             | 2015-12-16   | Red Gate    | No           | Yes/$2640   |
| [SQL Check](#sql-check)                                   | [SQL Check]                  | 2015-09-24   | Idera       | Yes          | No          |
| [SQL Fragmentation Analyzer](#sql-fragmentation-analyzer) | [SQL Fragmentation Analyzer] | 2015-06-24   | Idera       | Yes          | No          |
| [SQL Heat Map](#sql-heat-map)                             | [SQL Heat Map]               | 2015-12-07   | Idera       | Yes          | No          |
| [SQL Hekaton Memory Check](#sql-hekaton-memory-check)     | [SQL Hekaton Memory Check]   | 2015-06-10   | Idera       | Yes          | No          |
| [SQL Page Viewer](#sql-page-viewer)                       | [SQL Page Viewer]            | 2014-08-25   | Idera       | Yes          | No          |
| [SQL Update Statistics](#sql-update-statistics)           | [SQL Update Statistics]      | 2015-12-14   | Idera       | Yes          | No          |
| [SQL Statistics Aggregator](#sql-statistics-aggregator)   | [SQL Statistics Aggregator]  | 2015-05-18   | Idera       | Yes          | No          |
| [SQL Backup Status Reporter](#sql-backup-status-reporter) | [SQL Backup Status Reporter] | 2015-08-07   | Idera       | Yes          | No          |
| [SQL Integrity Check](#sql-integrity-check)               | [SQL Integrity Check]        | 2013-08-26   | Idera       | Yes          | No          |
| [SQL Job Manager](#sql-job-manager)                       | [SQL Job Manager]            | 2012-03-19   | Idera       | Yes          | No          |
| [Azure SQL Database Backup](#azure-sql-database-backup)   | [Azure SQL Database Backup]  | 2012-10-02   | Idera       | Yes          | No          |
| [SQL Column Search](#sql-column-search)                   | [SQL Column Search]          | 2015-11-17   | Idera       | Yes          | No          |
| [SQL Permissions Extractor](#sql-permissions-extractor)   | [SQL Permissions Extractor]  | 2015-08-07   | Idera       | Yes          | No          |
| [dbForge Schema Compare](#dbforge-schema-compare)         | [dbForge Schema Compare]     | 2015-12-22   | Devart      | No           | Yes/$149.95 |
| [dbForge Data Compare](#dbforge-data-compare)             | [dbForge Data Compare]       | 2015-11-30   | Devart      | No           | Yes/$149.95 |
| [dbForge Data Generator](#dbforge-data-generator)         | [dbForge Data Generator]     | 2015-12-30   | Devart      | No           | Yes/$249.95 |
| [dbForge Query Builder](#dbforge-query-builder)           | [dbForge Query Builder]      | 2015-06-03   | Devart      | No           | Yes/$99.95  |
| [dbForge Event Profiler](#dbforge-event-profiler)         | [dbForge Event Profiler]     | 2015-04-08   | Devart      | Yes          | No          |
| [dbForge SQL Decryptor](#dbforge-sql-decryptor)           | [dbForge SQL Decryptor]      | 2013-11-07   | Devart      | Yes          | No          |


## GraphView <a id="graphview"></a>
Download page: [GraphView]<br/>
Release date: -<br/>
Support Version: ???<br/>
Free version: Yes

GraphView is a DLL library that enables users to use SQL Server or Azure SQL Database to manage graphs. It connects to a SQL database locally or in the cloud, stores graph data in tables and queries graphs through a SQL-extended language.


## tablediff Utility <a id="tablediff-utility"></a>
Download page: [tablediff Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The tablediff utility is used to compare the data in two tables for non-convergence, and is particularly useful for troubleshooting non-convergence<br />
in a replication topology. This utility can be used from the command prompt or in a batch file to perform the following tasks:
 - A row by row comparison between a source table in an instance of Microsoft SQL Server acting as a replication Publisher and the destination table at one or more instances of SQL Server acting as replication Subscribers.
 - Perform a fast comparison by only comparing row counts and schema.
 - Perform column-level comparisons.
 - Generate a Transact-SQL script to fix discrepancies at the destination server to bring the source and destination tables into convergence.
 - Log results to an output file or into a table in the destination database.


## Microsoft Log Parser <a id="microsoft-log-parser"></a>
Download page: [Microsoft Log Parser]<br/>
Release date: -<br/>
Support Version: ???<br/>
Free version: Yes

Log parser is a powerful, versatile tool that provides universal query access to text-based data such as log files,<br />
XML files and CSV files, as well as key data sources on the Windows operating system such as the Event Log, the Registry, the file system, and Active Directory. 


## Diskspd <a id="diskspd"></a>
Download page: [Diskspd]<br/>
Release date: 2015-12-14<br/>
Support Version: ???<br/>
Free version: Yes

DISKSPD is a storage load generator / performance test tool from the Windows/Windows Server and Cloud Server Infrastructure Engineering teams.

Compilation is supported with Visual Studio and Visual Studio Express. Use the Visual Studio solution file inside the diskspd_vs2013 directory.


## HammerDB <a id="hammerdb"></a>
Download page: [HammerDB]<br/>
Release date: 2015-05-04<br/>
Support Version: ???<br/>
Free version: Yes

HammerDB is an open source database load testing and benchmarking tool for Oracle, SQL Server, DB2, TimesTen, PostgreSQL, Greenplum, Postgres Plus Advanced Server, MySQL,  Redis and Trafodion SQL on Hadoop.


## dta Utility <a id="dba-utility"></a>
Download page: [dta Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

Capture performance and usage data about your Microsoft SQL Server 2005+ databases to inform insights and improve troubleshooting.

Key real-time metrics provide an overview of your databases and detailed measurements about memory usage, connections, network I/O, and file I/O.


## osql Utility <a id="osql-utility"></a>
Download page: [osql Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The osql utility allows you to enter Transact-SQL statements, system procedures, and script files.<br />
This utility uses ODBC to communicate with the server.


## sqldiag Utility <a id="sqldiag-utility"></a>
Download page: [sqldiag Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The SQLdiag utility is a general purpose diagnostics collection utility that can be run as a console application or as a service.<br />
You can use SQLdiag to collect logs and data files from SQL Server and other types of servers, and use it to monitor your servers over time<br />
or troubleshoot specific problems with your servers.<br />
SQLdiag is intended to expedite and simplify diagnostic information gathering for Microsoft Customer Support Services.


## sqldumper Utility <a id="sqldumper-utility"></a>
Download page: [sqldumper Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012<br/>
Free version: Yes

You can use the Sqldumper.exe utility to generate a dump file on demand for any Microsoft Windows application.<br />
For example, you can generate a dump file for debugging an application problem when a computer that is running SQL Server 2005,<br />
Microsoft SQL Server 2008, Microsoft SQL Server 2008 R2, or Microsoft SQL Server 2012 is not responding to user requests.<br />
A dump file can be a mini-dump file, a full dump file, or a filtered dump file.


## SqlLocalDB Utility <a id="sqllocaldb-utility"></a>
Download page: [SqlLocalDB Utility]<br/>
Release date: -<br/>
Support Version: 2012/2014/2016<br/>
Free version: Yes

SqlLocalDB lets you create, delete, start, stop, and perform a number of other related tasks on an instance of SQL Server 2012 Express LocalDB,<br />
an execution mode of SQL Server Express that’s targeted at developers. A LocalDB instance uses a minimal set of files to start the database engine.


## sqllogship Utility <a id="sqllogship-utility"></a>
Download page: [sqllogship Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The sqllogship application performs a backup, copy, or restore operation and associated clean-up tasks for a log shipping configuration.<br />
The operation is performed on a specific instance of Microsoft SQL Server for a specific database.


## sqlservr Application <a id="sqlservr-application"></a>
Download page: [sqlservr Application]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The sqlservr application starts, stops, pauses, and continues an instance of Microsoft SQL Server from a command prompt.


## sqlps Utility <a id="sqlps-utility"></a>
Download page: [sqlps Utility]<br/>
Release date: -<br/>
Support Version: 2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The sqlps utility starts a Windows PowerShell 2.0 session with the SQL Server PowerShell provider and cmdlets loaded and registered. You can enter PowerShell commands or scripts that use the SQL Server PowerShell components to work with instances of SQL Server and their objects.
This feature will be removed in a future version of Microsoft SQL Server. Avoid using this feature in new development work, and plan to modify applications that currently use this feature. Use the sqlps PowerShell module instead.


## sqlmaint Utility <a id="sqlmaint-utility"></a>
Download page: [sqlmaint Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The sqlmaint utility performs a specified set of maintenance operations on one or more databases. Use sqlmaint to run DBCC checks, back up a database and its transaction log, update statistics, and rebuild indexes. All database maintenance activities generate a report that can be sent to a designated text file, HTML file, or e-mail account. sqlmaint executes database maintenance plans created with previous versions of SQL Server. To run SQL Server maintenance plans from the command prompt, use the dtexec Utility.
This feature will be removed in the next version of Microsoft SQL Server. Avoid using this feature in new development work, and plan to modify applications that currently use this feature. Use SQL Server maintenance plan feature instead.


## Ssms Utility <a id="ssms-utility"></a>
Download page: [Ssms Utility]<br/>
Release date: -<br/>
Support Version: 2005/2008/2008R2/2012/2014/2016<br/>
Free version: Yes

The Ssms utility opens SQL Server Management Studio. If specified, Ssms also establishes a connection to a server, and opens queries, scripts, files, projects, and solutions.
You can specify files that contain queries, projects, or solutions. Files that contain queries are automatically connected to a server if connection information is provided and the file type is associated with that type of server. For instance, .sql files will open a SQL Query Editor window in SQL Server Management Studio, and .mdx files will open an MDX Query Editor window in SQL Server Management Studio. SQL Server Solutions and Projects will open in SQL Server Management Studio.


## dtexec Utility <a id="dtexec-utility"></a>
Download page: [dtexec Utility]<br/>
Release date: -<br/>
Support Version: 2012/2014/2016<br/>
Free version: Yes

The dtexec command prompt utility is used to configure and execute SQL Server Integration Services packages. The dtexec utility provides access to all the package configuration and execution features, such as parameters, connections, properties, variables, logging, and progress indicators. The dtexec utility lets you load packages from these sources: the Integration Services server, an .ispac project file, a Microsoft SQL Server database, the SSIS Package Store, and the file system.


## SQL XEvent Profiler <a id="sql-xevent-profiler"></a>
Download page: [SQL XEvent Profiler]<br/>
Release date: 2014-03-14<br/>
Support Version: 2012/2014<br/>
Free version: Yes

Idera’s SQL XEvent Profiler emulates the functionality and simplicity of SQL Server Profiler, letting you quickly view data from SQL events<br />
and see what's happening on the server. Plus, it leverages SQL Extended Events (XEvents) as the backing technology — making it more efficient than SQL Trace.


## DLM Dashboard <a id="dlm-dashboard"></a>
DLM Dashboard tracks your database schemas and alerts you when they change.<br />
As a SQL Server user, you want to make sure all your databases are in the right state.<br />
DLM Dashboard monitors up to 50 of your databases, and sends you an email alert as soon as your databases start to drift,<br />
or change from their expected state. On the web dashboard, you can see exactly what changed, who made the changes, and when.


## SQL DBA Bundle <a id="sql-dba-bundle"></a>
Red Gate 7 products for DBA:
 - SQL Backup Pro: Compress, securely encrypt, and strengthen your backups
 - SQL Monitor: Monitor your SQL Server performance and be alerted to problems
 - SQL Multi Script Unlimited: Deploy multiple scripts to multiple servers with just one click
 - SQL Compare: Compare and synchronize database schemas
 - SQL Data Compare: Compare and synchronize database contents
 - SQL Prompt: Write, format, and refactor SQL effortlessly
 - SQL Doc: Automatically generate database documentation


## SQL Check <a id="sql-check"></a>
Download page: [SQL Check]<br/>
Release date: 2015-09-24<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Check you can:
 - check out what happens in batches, compilations, recompilations, and transactions throughout the SQL Server environment so you don’t experience any surprises and know where to direct your attention to prevent potential issues.
 - monitor some of the most important metrics in SQL Server including wait stats, reads, writes, session details, and cache hits.
 - see SQL operations as they occur for the latest information; consider it a heart rate monitor for your SQL Server environment providing instant feedback and results. Customize the refresh rate and amount of historical data for each SQL server.
 - install easily without agents


## SQL Fragmentation Analyzer <a id="sql-fragmentation-analyzer"></a>
Download page: [SQL Fragmentation Analyzer]<br/>
Release date: 2015-06-24<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Fragmentation Analyzer you can:
 - analyze fragmentation by one table or an entire database
 - identify databases in need of defragmentation
 - set fragmentation thresholds: normal, warning, critical


## SQL Heat Map <a id="sql-heat-map"></a>
Download page: [SQL Heat Map]<br/>
Release date: 2015-12-07<br/>
Support Version: 2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Heat Map you can:
 - get one visual view of storage in all tables of a database
 - see storage allocation, utilization, and type of data
 - quickly locate tables and indexes that need more allocated storage


## SQL Hekaton Memory Check <a id="sql-hekaton-memory-check"></a>
Download page: [SQL Hekaton Memory Check]<br/>
Release date: 2015-12-07<br/>
Support Version: 2014<br/>
Free version: Yes

With SQL Hekaton Memory Check you can:
 - monitor the impact of memory optimized tables on server memory
 - identify high memory utilizing tables
 - assess server memory capacity
 - simulate moving to In-Memory OLTP


## SQL Page Viewer <a id="sql-page-viewer"></a>
Download page: [SQL Page Viewer]<br/>
Release date: 2014-08-25<br/>
Support Version: 2005/2008/2008R2/2012/2014<br/>
Free version: Yes

SQL Page Viewer:
 - displays page level data summary and detail information
 - has elegant GUI design for fast access in 1 click
 - can select any SQL server and database table
 - can navigate to any page data quickly in a tree view
 - can launch directly within SSMS for optimal usability


## SQL Update Statistics <a id="sql-update-statistics"></a>
Download page: [SQL Update Statistics]<br/>
Release date: 2015-12-14<br/>
Support Version: 2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Update Statistics you can:
 - launch directly within SSMS for optimal usability
 - identify out-of-date SQL Server table and index statistics
 - view and change database statistics options
 - create graphical histograms for each column’s statistics


## SQL Statistics Aggregator <a id="sql-statistics-aggregator"></a>
Download page: [SQL Statistics Aggregator]<br/>
Release date: 2015-05-18<br/>
Support Version: 2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Statistics Aggregator you can:
 - aggregate IO statistics to identify problem tables
 - correlate disk activity with query plan nodes
 - compare runs of a query over time
 - export and import results for easy collaboration


## SQL Backup Status Reporter <a id="sql-backup-status-reporter"></a>
Download page: [SQL Backup Status Reporter]<br/>
Release date: 2015-08-07<br/>
Support Version: 2000/2005/2008/2008R2/2012<br/>
Free version: Yes

With SQL Backup Status Reporter you can:
 - quickly identify databases which have not had backups
 - view backup history including the backup date and type
 - have simplified grid view for easy sorting and navigation
 - identify full and differential backups for many databases


## SQL Integrity Check <a id="sql-integritu-check"></a>
Download page: [SQL Integrity Check]<br/>
Release date: 2013-08-26<br/>
Support Version: 2000/2005/2008/2008R2/2012<br/>
Free version: Yes

With SQL Integrity Check you can:
 - easily run a CHECKDB for any database on-demand
 - view integrity check results to identify corruption
 - routinely verifies when last check was performed
 - receive alerts when databases are due for checks
 - don't need to write and maintain scripts


## SQL Job Manager <a id="sql-job-manager"></a>
Download page: [SQL Job Manager]<br/>
Release date: 2012-03-19<br/>
Support Version: ???<br/>
Free version: Yes

With SQL Job Manager you:
 - have management console to easily view past and current jobs
 - can identify and correct job contention
 - can drag and drop jobs across servers to level workloads
 - can “at a glance” view to see failed or runaway jobs
 - have customizable calendar view


## Azure SQL Database Backup <a id="azure-sql-database-backup"></a>
Download page: [Azure SQL Database Backup]<br/>
Release date: 2015-08-07<br/>
Support Version: ???<br/>
Free version: Yes

Azure SQL Database Backup allows/gives you:
 - to save time and storage space with up to 95% compression
 - backup on-premise or to Azure BLOB storage
 - central data storage to prevent data loss
 - view historical backup and restore operations
 - restore with transaction consistency to and from the cloud


## SQL Column Search <a id="sql-column-search"></a>
Download page: [SQL Column Search]<br/>
Release date: 2015-11-17<br/>
Support Version: 2005/2008/2008R2/2012/2014<br/>
Free version: Yes

With SQL Column Search you can:
 - find potentially sensitive data
 - search an entire instance or a specific table
 - export results to CSV format for easy analysis and reporting


## SQL Permissions Extractor <a id="sql-permissions-extractor"></a>
Download page: [SQL Permissions Extractor]<br/>
Release date: 2015-08-07<br/>
Support Version: 2000/2005/2008/2008R2/2012<br/>
Free version: Yes

With SQL Permissions Extractor you can:
 - Generate T-SQL scripts for copying of user permissions
 - edit, save, and execute permissions scripts
 - include object level permissions for selected databases
 - copy, extract, modify and apply changes in four steps


## dbForge Schema Compare <a id="dbforge-schema-compare"></a>
Download page: [dbForge Schema Compare]<br/>
Release date: 2015-12-22<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: No

dbForge Schema Compare for SQL Server is a reliable tool that will save you time and effort when you need to compare databases on SQL Server. The relentlessly tested compare tool allows working with live SQL Server databases, database snapshots, and backups. 
You can compare your SQL Server databases, analyze differences and synchronize your schemas using generated SQL script in a well-designed user interface quickly and without errors.


## dbForge Data Compare <a id="dbforge-data-compare"></a>
Download page: [dbForge Schema Compare]<br/>
Release date: 2015-11-30<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: No

dbForge Data Compare for SQL Server is a powerful, fast and easy to use SQL comparison tool, capable of using native SQL Server backups as metadata source. With dbForge Data Compare you can tune your SQL database comparison, quickly analyze differences in a well-designed user interface and effortlessly synchronize data via a convenient wizard with additional options.


## dbForge Data Generator <a id="dbforge-data-generator"></a>
Download page: [dbForge Data Generator]<br/>
Release date: 2015-12-30<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: No

dbForge Data Generator for SQL Server is a powerful GUI tool for fast generation of meaningful test data. The tool includes 190+ predefined generators with sensible configuration options, that allow emulating column-intelligent real-world data. dbForge Data Generator for SQL Server can save your time and effort by populating SQL Server tables with millions of rows of test data that looks just like real data.


## dbForge Query Builder <a id="dbforge-query-builder"></a>
Download page: [dbForge Query Builder]<br/>
Release date: 2015-06-03<br/>
Support Version: 2000/2005/2008/2008R2/2012/2014<br/>
Free version: No

dbForge Query Builder for SQL Server allows users to build complex SQL queries via an intuitive visual query building interface easily and without manual code writing. Our visual SQL query tool is destined for simplification of developing SQL queries for SQL Server. This SQL query designer will be useful to those, who often create queries to databases. 
Visual features to create queries, usage of graphical SQL query creator to interactively build queries, would be most appreciated by users who have no experience in writing queries manually. But
 even experienced users can save a lot of time on routine work.


## dbForge Event Profiler <a id="dbforge-event-profiler"></a>
Download page: [dbForge Event Profiler]<br/>
Release date: 2015-04-08<br/>
Support Version: 2008/2012/2014<br/>
Free version: No

dbForge Event Profiler for SQL Server is a FREE tool that allows you to capture and analyze SQL Server events. The events and data columns are stored in a physical trace file for later examination. You can use this information to identify and troubleshoot many SQL Server-related problems.


## dbForge SQL Decryptor <a id="dbforge-sql-decryptor"></a>
Download page: [dbForge SQL Decryptor]<br/>
Release date: 2013-11-07<br/>
Support Version: 2000/2005/2008/2008R2/2012<br/>
Free version: No

If you have encrypted an object definition in your database by specifying WITH ENCRYPTION option, and by some reason you cannot restore its original T-SQL body, the  dbForge SQL Decryptor  will easily do it for you absolutely free. Save your time and funds on restoring lost definitions and stay happy with our products.


[GraphView]:https://github.com/Microsoft/GraphView
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
[SQL Check]: https://www.idera.com/productssolutions/freetools/sqlcheck
[SQL Fragmentation Analyzer]: https://www.idera.com/productssolutions/freetools/sqlfragmentationanalyzer/overview
[SQL Heat Map]: https://www.idera.com/productssolutions/freetools/sql-storage
[SQL Hekaton Memory Check]: https://www.idera.com/productssolutions/freetools/hekaton-memory-check-for-sql-memory-optimized-tables
[SQL Page Viewer]: https://www.idera.com/productssolutions/freetools/sql-server-page
[SQL Update Statistics]: https://www.idera.com/productssolutions/freetools/sql-server-statistics/overview
[SQL Statistics Aggregator]: https://www.idera.com/productssolutions/freetools/statistics-aggregator-for-performance-tuning-in-sql
[SQL Backup Status Reporter]: https://www.idera.com/productssolutions/freetools/sqlbackupstatusreporter/overview
[SQL Integrity Check]: https://www.idera.com/productssolutions/freetools/sqlintegritycheck/overview
[SQL Job Manager]: https://www.idera.com/productssolutions/freetools/sqljobmanager
[Azure SQL Database Backup]: https://www.idera.com/productssolutions/freetools/azuresqldatabasebackup
[SQL Column Search]: https://www.idera.com/productssolutions/freetools/sql-column-search
[SQL Permissions Extractor]: https://www.idera.com/productssolutions/freetools/sqlpermissionsextractor
[dbForge Schema Compare]: https://www.devart.com/dbforge/sql/schemacompare/
[dbForge Data Compare]: https://www.devart.com/dbforge/sql/datacompare/
[dbForge Data Generator]: https://www.devart.com/dbforge/sql/data-generator/
[dbForge Query Builder]: https://www.devart.com/dbforge/sql/querybuilder/
[dbForge Event Profiler]: https://www.devart.com/dbforge/sql/event-profiler/
[dbForge SQL Decryptor]: https://www.devart.com/dbforge/sql/sqldecryptor/
[sqlps Utility]: https://msdn.microsoft.com/en-us/library/cc280450.aspx
[sqlmaint Utility]: https://msdn.microsoft.com/en-us/library/ms162827.aspx
[Ssms Utility]: https://msdn.microsoft.com/en-us/library/ms162825.aspx
[dtexec Utility]: https://msdn.microsoft.com/en-us/library/hh231187.aspx
