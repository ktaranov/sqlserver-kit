# SQL Server Debugging

- [Obtaining symbol files (.PDB) for SQL Server Releases](https://github.com/arvindshmicrosoft/SQLCallStackResolver/wiki/Scripts-to-download-symbols-for-SQL-Server-2019)
- [What is the SOS_WORK_DISPATCHER Wait Type?](https://orderbyselectnull.com/2018/09/27/what-is-the-sos_work_dispatcher-wait-type/)
- [An XEvent a Day (24 of 31) – What is the callstack?](https://www.sqlskills.com/blogs/jonathan/an-xevent-a-day-24-of-31-what-is-the-callstack/)

This section contains PowerShell scripts which automate the download and extraction of `.PDB` files corresponding to major releases of SQL Server.

For running any of these scripts, please note the following:
- You must run them within PowerShell, preferably within Windows
- You must have Internet access from the machine running the PowerShell script
- You might want to replace the $outputFolder placeholder with a different folder path (for example, `N:\sqlsymbols\SQL2016SP1`)
- The script will automatically create the folder where the downloaded PDB files are stored.

Please click on one of the links below depending on the major version of SQL Server that you are looking at:
- [SQL Server 2019](SQL-Server-2019.md)
- [SQL Server 2017](SQL-Server-2017.md)
- [SQL Server 2016](SQL-Server-2016.md)
- [SQL Server 2014](SQL-Server-2014.md)
- [SQL Server 2012](SQL-Server-2012.md)
- [SQL Server 2008 R2](SQL-Server-2008-R2.md)
- [SQL Server 2008](SQL-Server-2008.md)
