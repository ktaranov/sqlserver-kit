# Microsoft SQL Server Trace Flags


## Source links
 - [Steinar Andersen great post](http://www.sqlservice.se/updated-microsoft-sql-server-trace-flag-list/)
 - [Yusuf Anis trace flag table](http://www.sqlservercentral.com/articles/trace+flags/70131/)


## What are Microsoft SQL Server Trace Flags?
Trace Flags are settings that in some way or another alters the
behaviour of various SQL Server functions.


## How do I turn Trace Flags on and off?
 - You can use the DBCC TRACEON and DBCC TRACEOFF commands
 - You can use the -T option in the startup configuration fo the SQL
Server Service
 - You can also use the hint QUERYTRACEON in your queries: **&lt;querytraceon_hint> ::= {QUERYTRACEON trace_flag_number}**


## How do I know what Trace Flags are turned on at the moment?
 - You can use the [DBCC TRACESTATUS](https://msdn.microsoft.com/en-us/library/ms187809.aspx "Official MSDN link") command


**REMEMBER: Be extremely careful with trace flags, test in your test
environment first. And consult professionals first if you are the
slightest uncertain about the effects of your changes.**


## General Links:
 - SQL Server Central TF List:
<http://www.sqlservercentral.com/articles/trace+flags/70131/>
 - MSDN TF list: <http://sqlserverpedia.com/wiki/Trace_Flags>
 - Albert van der Sel TF list: <http://antapex.org/traceflags_sqlserver.txt>
 - Technet Wiki TF list: <http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx>
 - Amit Banerjee TF list: <http://troubleshootingsql.com/2012/07/01/sql-server-2008-trace-flags/>
 - Paul Randal discussing TF Pro’s and Con’s:
<http://www.sqlskills.com/blogs/paul/the-pros-and-cons-of-trace-flags/>
 - **Some trace flags needs to be specified with ”t” rather than with ”T” in startup options!**: <http://technet.microsoft.com/en-us/library/ms190737(v=sql.110).aspx>


**Thanks to:**
 - Steinar Andersen
 - Yusuf Anis
 - Lars Utterström
 - Martin Höglund
 - Håkan Winther
 - Toine Rozemeijer
 - Robert L Davis aka @sqlsoldier
 - sql_handle aka @sql_handle
 - Andrzej Kukuła


## Trace flag list


**Trace Flag: -1**
Function: Sets trace flags for all connections
Link: None (Yusuf Anis)


**Trace Flag: 101**
Function: Verbose Merge Replication logging output for troubleshooting
Merger repl performance
Link: <http://support.microsoft.com/kb/2892633>


**Trace Flag: 102**
Function: Verbose Merge Replication logging to msmerge\_history table
for troubleshooting Merger repl performance
Link: <http://support.microsoft.com/kb/2892633>


**Trace Flag: 105**
Function: Join more than 16 tables in SQL server 6.5
Link: <http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm>


**Trace Flag: 106**
Function: This enables you to see the messages that are sent to and from
the Publisher, if you are using Web Synchronization
Link: <http://technet.microsoft.com/en-us/library/ms151872(v=sql.105).aspx>


**Trace Flag: 107**
Function: Alter input rules for decimal numbers
Link: <http://support.microsoft.com/kb/203787>
*Thanks to: <http://www.sqlservercentral.com>*


**Trace Flag: 168**
Function: Bugfix in ORDER BY
Link: <http://support.microsoft.com/kb/926292>


**Trace Flag: 205**
Function: Log usage of AutoStat/Auto Update Statistics
Link: <http://support.microsoft.com/kb/195565>


**Trace Flag: 253**
Function: Prevent adhoc query plans from staying in cache (SQL 2005)
Link: <http://www.sqlservercentral.com/Forums/Topic837613-146-1.aspx>


**Trace Flag: 260**
Function: Prints versioning information about extended stored procedure dynamic-link libraries (DLLs). Scope: global or session
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>
Link: <http://msdn.microsoft.com/en-us/library/ms164627.aspx>


**Trace Flag: 272**
Function: Generates a log record per identity increment. Can be users
to convert SQL 2012 back to old style Identity behaviour
Link: <http://www.big.info/2013/01/how-to-solve-sql-server-2012-identity.html>
Link: <https://connect.microsoft.com/SQLServer/feedback/details/739013/failover-or-restart-results-in-reseed-of-identity>


**Trace Flag: 302**
Function: Output Index Selection info
Link: <http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm>


**Trace Flag: 310**
Function: Outputs info about actual join order
Link: <http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm>


**Trace Flag: 323**
Function: Outputs detailed info about updates
Link: <http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm>


**Trace Flag: 345**
Function: Changes join order selection logic in SQL Server 6.5
Link: <http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm>


**Trace Flag: 445**
Function: Prints ”compile issued” message in the errorlog for each
compiled statement, when used together with 3605
Link: None


**Trace Flag: 610**
Function: Minimally logged inserts to indexed tables
Link: <http://msdn.microsoft.com/en-us/library/dd425070%28v=SQL.100%29.aspx>


**Trace Flag: 652**
Function: Disable page pre-fetching scans
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 661**
Function: Disable the ghost record removal process
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 662**
Function: Prints detailed information about the work done by the ghost
cleanup task when it runs next. Use TF 3605 to see the output in the
errorlog
Link: <http://blogs.msdn.com/b/sqljourney/archive/2012/07/28/an-in-depth-look-at-ghost-records-in-sql-server.aspx>


**Trace Flag: 806**
Function: Turn on Page Audit functionality, to verify page validity
Link: <http://technet.microsoft.com/en-au/library/cc917726.aspx>


**Trace Flag: 818**
Function: Turn on ringbuffer to store info about IO write operations.
Used to troubleshoot IO problems
Link: <http://support.microsoft.com/kb/826433>


**Trace Flag: 834**
Function: Large Page Allocations
Link: <http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx>
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 836 **
Function: Use the max server memory option for the buffer pool
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 845**
Function: Enable Lock pages in Memory on Standard Edition
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-performance-with-dynamics-axapta.aspx>


**Trace Flag: 902**
Function: Bypass Upgrade Scripts
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx>


**Trace Flag: 1117**
Function: Simultaneous Autogrowth in Multiple-file database
Link: <http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx>
Link: <http://blogs.technet.com/technet_blog_images/b/sql_server_sizing_ha_and_performance_hints/archive/2012/02/09/sql-server-2008-trace-flag-t-1117.aspx>


**Trace Flag: 1118**
Function: Force Uniform Extent Allocation
Link: <http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx>
Link: <http://blogs.msdn.com/b/psssql/archive/2008/12/17/sql-server-2005-and-2008-trace-flag-1118-t1118-usage.aspx>


**Trace Flag: 1119**
Function: Turns of mixed extent allocation (Similar to 1118?)
Link: <http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx>


**Trace Flag: 1140**
Function: Fix for growing tempdb in special cases
Link: <http://support.microsoft.com/kb/2000471>


**Trace Flag: 1200**
Function: Prints detailed lock information as every request for a lock is made (the process ID and type of lock requested)
Link: <http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx>


**Trace Flag: 1124**
Function: Unknown. Has been reportedly found turned on in some SQL
Server instances running Dynamics AX. Also rumored to be invalid in
public builds of SQL Server
Link: None


**Trace Flag: 1204**
Function: Returns info about deadlocks
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 1211**
Function: Disables Lock escalation caused by memory pressure
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 1222**
Function: Returns Deadlock info in XML format
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 1224**
Function: Disables lock escalation based on number of locks
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 1236**
Function: Fixes performance problem in scenarios with high lock activity
in SQL 2012 and SQL 2014
Link: <http://support.microsoft.com/kb/2926217>


**Trace Flag: 1264**
Function: Collect process names in non-yielding scenario memory dumps
Link: <http://support.microsoft.com/kb/2630458/en-us>


**Trace Flag: 1448**
Function: Alters replication log reader functionality
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 1462**
Function: Disable Mirroring Log compression
Link: <http://sqlcat.com/sqlcat/b/technicalnotes/archive/2007/09/17/database-mirroring-log-compression-in-sql-server-2008-improves-throughput.aspx>


**Trace Flag: 1717**
Function: MSShipped bit will be set automatically at Create time when
creating stored procedures
Link: None


**Trace Flag: 1806**
Function: Disable Instant File Initialization
Link: <http://technet.microsoft.com/en-au/library/cc917726.aspx>


**Trace Flag: 1807**
Function: Enable option to have database files on SMB share for SQL
Server 2008 and 2008R2
Link: <http://blogs.msdn.com/b/varund/archive/2010/09/02/create-a-sql-server-database-on-a-network-shared-drive.aspx>


**Trace Flag: 2301**
Function: Enable advanced decision support optimizations
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 2312**
Function: Forces the query optimizer to use the SQL Server 2014 version
of the cardinality estimator when creating the query plan when running
SQL Server 2014 with database compatibility level 110
Link: http://support.microsoft.com/kb/2801413


**Trace Flag: 2335**
Function: Generates Query Plans optimized for less memory
Link: <http://support.microsoft.com/kb/2413549>


**Trace Flag: 2340**
Function: Disable specific SORT optimization in Query Plan
Link: <http://support.microsoft.com/kb/2009160>


**Trace Flag: 2371**
Function: Change threshold for auto update stats
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server--auto-update-stats-part-2.aspx>


**Trace Flag: 2372**
Function: Displays memory utilization during the optimization process
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 2373**
Function: Displays memory utilization during the optimization process
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 2388**
Function: Change DBCC SHOW\_STATISTICS output to show stats history and
lead key type such as known ascending keys
Link: <http://www.benjaminnevarez.com/2013/02/statistics-on-ascending-keys>


**Trace Flag: 2389**
Function: Enable auto-quick-statistics update for known ascending keys
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx>
Link: <http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx>
Link: <http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767>


**Trace Flag: 2390**
Function: Enable auto-quick-statistics update for all columns
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx>
Link: <http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx>
Link: <http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767>


**Trace Flag: 2430**
Function: Fixes performance problem when using large numbers of locks
Link: <http://support.microsoft.com/kb/2754301/en-us>


**Trace Flag: 2453**
Function: Allow a table variable to trigger recompile when enough number
of rows are changed with may allow the query optimizer to choose a more
efficient plan.
Link: <http://sqlperformance.com/2014/06/t-sql-queries/table-variable-perf-fix>
Link: <http://http//support.microsoft.com/kb/2952444>


**Trace Flag: 2470**
Function: Fixes performance problem when using AFTER triggers on
partitioned tables
Link: <http://support.microsoft.com/kb/2606883/en-us>


**Trace Flag : 2514**
Function: Verbose Merge Replication logging to msmerge\_history table
for troubleshooting Merger repl performance
Link: <http://sqlblog.com/blogs/argenis_fernandez/archive/2012/05/29/ghost-records-backups-and-database-compression-with-a-pinch-of-security-considerations.aspx>


**Trace Flag: 2528**
Function: Disables parallelism in CHECKDB etc
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 2529**
Function: Displays memory usage for DBCC commands when used with TF
3604S
Link: None


**Trace Flag: 2537**
Function: Allows you to see inactive records in transaction log using
fn\_dblog
Link: <http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog>


**Trace Flag: 2540**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2541**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2542**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2543**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2544**
Function: Produces a full memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2545**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2546**
Function: Dumps all threads for SQL Server in the dump file
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2547**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2548**
Function: Shrink will run faster with this trace flag if there are LOB
pages that need conversion and/or compaction, because that actions will
be skipped.
Link: <http://blogs.msdn.com/b/psssql/archive/2008/03/28/how-it-works-sql-server-2005-dbcc-shrink-may-take-longer-than-sql-server-2000.aspx>
*Thanks to: Andrzej Kukula*


**Trace Flag: 2549**
Function: Faster CHECKDB
Link: <http://www.sqlservice.se/sv/start/blogg/faster-dbcc-checkdb-by-using-trace-flag-2562-and-2549.aspx>
Link: <http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx>
Link: <http://support.microsoft.com/kb/2634571>
Link: <http://support.microsoft.com/kb/2732669/en-us>


**Trace Flag: 2550**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2551**
Function: Produces a filtered memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2552**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2553**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2554**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2555**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2556**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2557**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2558**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2559**
Function: Unknown, but related to controlling the contents of a
memory dump
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 2562**
Function: Faster CHECKDB
Link: <http://www.sqlservice.se/sv/start/blogg/faster-dbcc-checkdb-by-using-trace-flag-2562-and-2549.aspx>
Link: <http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx>
Link: <http://support.microsoft.com/kb/2634571>
Link: <http://support.microsoft.com/kb/2732669/en-us>


**Trace Flag: 2588**
Function: Get more information about undocumented DBCC commands
Link: <http://www.sqlservice.se/sv/start/blogg/trace-flag--undocumented-commands.aspx>


**Trace Flag: 2861**
Function: Keep zero cost plans in cache
Link: <http://support.microsoft.com/kb/325607>


**Trace Flag: 3004**
Function: Returns more info about Instant File Initialization
Link: <http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf>


**Trace Flag: 3014**
Function: Returns more info about backups to the errorlog
Link: <http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf>


**Trace Flag: 3042**
Function: Alters backup compression functionality
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 3101**
Function: Fix performance problems when restoring database with CDC
Link: <http://support.microsoft.com/kb/2567366/en-us>


**Trace Flag: 3205**
Function: Disable HW compression for backup to tape drives
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 3213**
Function: Output buffer info for backups to ERRORLOG
Link:<http://sqlcat.com/sqlcat/b/technicalnotes/archive/2008/04/21/tuning-the-performance-of-backup-compression-in-sql-server-2008.aspx>


**Trace Flag: 3226**
Function: Turns off ”Backup Successful” messages in errorlog
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>
*Thanks to: @lwiederstein (<https://twitter.com/lwiederstein>)*


**Trace Flag: 3422**
Function: Log record auditing
Link: <http://technet.microsoft.com/en-au/library/cc917726.aspx>


**Trace Flag: 3502**
Function: Writes info about checkpoints to teh errorlog
Link: <http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf>


**Trace Flag: 3505**
Function: Disables automatic checkpointing
Link: <http://support.microsoft.com/kb/815436>


**Trace Flag: 3604**
Function: Redirect DBCC command output to query window
Link: <http://blogs.msdn.com/b/askjay/archive/2011/01/21/why-do-we-need-trace-flag-3604-for-dbcc-statements.aspx>
Link: <http://www.sqlservice.se/sv/start/blogg/querytraceon.aspx>


**Trace Flag: 3605**
Function: Directs the output of some Trace Flags to the Errorlog
Link:<http://sqlcat.com/sqlcat/b/technicalnotes/archive/2008/04/21/tuning-the-performance-of-backup-compression-in-sql-server-2008.aspx>


**Trace Flag: 3607**
Function: Skip recovery on startup
Link: <http://sqlkbs.blogspot.se/2008/01/trace-flag.html>


**Trace Flag: 3608**
Function: Recover only Master db at startup
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 3609**
Function: Do not create tempdb at startup
Link: <http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/>


**Trace Flag: 3625**
Function: Masks some error messages
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 3656**
Function: Enables resolve of all call stacks in extended events
Link: <http://sqlcat.com/sqlcat/b/msdnmirror/archive/2010/05/11/resolving-dtc-related-waits-and-tuning-scalability-of-dtc.aspx>


**Trace Flag: 3659**
Function: Enables logging all errors to error log during server startup
Link: <http://spaghettidba.com/2011/05/20/trace-flag-3659/>


**Trace Flag: 3688**
Function: Removes messages to error log about traces started and stopped
Link: <http://support.microsoft.com/kb/922578/en-us>


**Trace Flag: 3801**
Function: Prohibits use of USE DB statement
Link: None


 **Trace Flag: 3923**
Function: Let SQL Server throw an exception to the application when the
3303 warning message is raised.
Link: <https://support.microsoft.com/kb/3014867/en-us>


**Trace Flag: 4013**
Function: Log each new connection the error log
Link: <http://sqlkbs.blogspot.se/2008/01/trace-flag.html>


**Trace Flag: 4022**
Function: Bypass Startup procedures
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx>


**Trace Flag: 4130**
Function: XML performance fix
Link: <http://support.microsoft.com/kb/957205>


**Trace Flag: 4134**
Function: Bugfix for error: parallel query returning different results
every time
Link: <http://support.microsoft.com/kb/2546901>
Link: <http://sql-sasquatch.blogspot.se/2014/04/whaddayaknow-bout-sqlserver-trace-flag.html>


**Trace Flag: 4135**
Function: Bugfix for error inserting to temp table
Link: <http://support.microsoft.com/kb/960770>


**Trace Flag: 4136**
Function: Parameter Sniffing behaviour alteration
Link: <http://blogs.msdn.com/b/axinthefield/archive/2010/11/04/sql-server-trace-flags-for-dynamics-ax.aspx>
Link: <http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx>


**Trace Flag: 4137**
Function: Fix for bad performance in queries with several AND criteria
Link: <http://support.microsoft.com/kb/2658214>


**Trace Flag: 4138**
Function: Fixes performance problems with certain queries that use TOP
statement
Link: <http://support.microsoft.com/kb/2667211>


**Trace Flag: 4199**
Function: Turn on all optimizations
Link: <http://www.sqlservice.se/sv/start/blogg/one-trace-flag-to-rule-them-all.aspx>


**Trace Flag: 4606**
Function: Ignore domain policy about weak password
Link: None


**Trace Flag: 4616**
Function: Alters server-level meta data visibility
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 6527**
Function: Disables generation of a memory dump on the first occurrence of an out-of-memory exception in CLR integration. By default, SQL Server generates a small memory dump on the first occurrence of an out-of-memory exception in the CLR.
The behaviour of the trace flag is as follows:
If this is used as a startup trace flag, a memory dump is never generated. However, a memory dump may be generated if other trace flags are used.
If this trace flag is enabled on a running server, a memory dump will not be automatically generated from that point on. However, if a memory dump has already been generated due to an out-of-memory exception in the CLR, this trace flag will have no effect.
Scope: global 
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 7300**
Function: Outputs extra info about linked server errors
Link: <http://support.microsoft.com/kb/314530>


**Trace Flag: 7502**
Function: Disable cursor plan caching for extended stored procedures
Link: <http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/>


**Trace Flag: 7806**
Function: Enables DAC on SQL Server Express
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 7826**
Function: Disable Connectivity ring buffer
Link: <http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx>


**Trace Flag: 7827**
Function: Record connection closure info in ring buffer
Link: <http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx>
Link: <https://connect.microsoft.com/SQLServer/feedback/details/518158/-packet-error-a-fatal-error-occurred-while-reading-the-input-stream-from-the-network>


**Trace Flag: 8002**
Function: Changes CPU Affinity behaviour
Link: <http://support.microsoft.com/kb/818769>


**Trace Flag: 8010**
Function: Fixes problem that SQL Server services can not be stopped
Link: <http://support.microsoft.com/kb/2633271/en-us>


**Trace Flag: 8011**
Function: Disable the ring buffer for Resource Monitor
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8012**
Function: Disable the ring buffer for schedulers
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8015**
Function: Ignore NUMA functionality
Link:<http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html>
*Thanks to: @sql\_handle (<https://twitter.com/sql_handle>)*


**Trace Flag: 8018**
Function: Disable the exception ring buffer
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8019**
Function: Disable stack collection for the exception ring buffer
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8020**
Function: Disable working set monitoring
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8026**
Function: SQL Server will clear a dump trigger after generating the dump
once
Link: <http://support.microsoft.com/kb/917825/en-us>


**Trace Flag: 8030**
Function: Fix for performance bug
Link: <http://support.microsoft.com/kb/917035>
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-2005-slowing-down-after-a-while.aspx>


**Trace Flag: 8032**
Function: Alters cache limit settings
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 8038**
Function: will drastically reduce the number of context switches when
running SQL 2005 or 2008
Link: <http://forum.proxmox.com/threads/15844-Win7-x64-guest-with-SQLServer-2012-High-CPU-usage>
Link: <http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx>


**Trace Flag: 8040**
Function: Disables Resource Governor
Link: <http://www.sqlservergeeks.com/blogs/AmitBansal/sql-server-bi/64/sql-server-disabling-resource-governor-permanently-somewhat>


**Trace Flag: 8048**
Function: NUMA CPU based partitioning
Link: <http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html>
Link: <http://blogs.msdn.com/b/psssql/archive/2012/12/20/how-it-works-cmemthread-and-debugging-them.aspx>
Link: <http://blogs.msdn.com/b/psssql/archive/2011/09/01/sql-server-2008-2008-r2-on-newer-machines-with-more-than-8-cpus-presented-per-numa-node-may-need-trace-flag-8048.aspx>
*Thanks to: @sql\_handle (<https://twitter.com/sql_handle>)*
Related to: 8015, 9024


**Trace Flag: 8207**
Function: Alters Transactional Replication behaviour of UPDATE statement
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 8209**
Function: Output extra information to error log regarding replication of
schema changes in SQL Server Replication
Link: <http://support.microsoft.com/kb/916706/en-us>


**Trace Flag: 8602**
Function: Disable Query Hints
Link:<http://www.sqlservice.se/sv/start/blogg/sql-server-trace-flag-8602.aspx>


**Trace Flag: 8605**
Function: Displays logical and physical trees used during the
optimization process
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 8607**
Function: Displays the optimization output tree during the optimization
process
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 8649**
Function: Set Cost Threshold for parallelism to 0
Link: <http://www.sqlservice.se/sv/start/blogg/enable-parallellism-for-specific-query.aspx>


**Trace Flag: 8675**
Function: Displays the query optimization phases for a specific
optimization
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 8722**
Function: Disable all hints except locking hints
Link: <http://sqlmag.com/sql-server/investigating-trace-flags>


**Trace Flag: 8744**
Function: Disable pre-fetching for ranges
Link: <http://support.microsoft.com/kb/920093>


**Trace Flag: 8755**
Function: Disable all locking hints
Link: <http://sqlmag.com/sql-server/investigating-trace-flags>


**Trace Flag: 8757**
Function: Skip trivial plan optimization and force a full optimization
Link: <http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/>


**Trace Flag: 8780**
Function: Give the optimizer more time to find a better plan
Link: <http://www.sqlservice.se/sv/start/blogg/sql-server-trace-flag--8780.aspx>


**Trace Flag: 9185**
Function: Cardinality estimates for literals that are outside the
histogram range are very low
Link: <https://support.microsoft.com/en-us/kb/kbview/833406>
Related to: 9205


**Trace Flag: 9024**
Function: Performance fix for AlwaysON log replication
Link: <http://support.microsoft.com/kb/2809338/en-us>
Related to: 8048


**Trace Flag: 9204**
Function: Output Statistics used by Query Optimizer
When enabled and a plan is compiled or recompiled there is a listing of statistics which is being fully loaded & used to produce cardinality and distribution estimates for some plan alternative or other
Link: <http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx>
Related to: 9292


**Trace Flag: 9205**
Function: Cardinality estimates for literals that are outside the
histogram range are very low for tables that have parent-child
relationships
Link: <https://support.microsoft.com/en-us/kb/kbview/833406>
Related to: 9185


**Trace Flag: 9207**
Function: Fixes that SQL Server underestimates the cardinality of a
query expression and query performance may be slow
Link: <https://support.microsoft.com/en-us/kb/831302>


**Trace flag: 9259**
Function: SQL 9/10 - An access violation occurs on running a query marked by the following message and a dump in the log folder: KB 970279 / 971490
Msg 0, Level 11, State 0, Line 0 - A severe error occurred on the current command. The results, if any, should be discarded.
Msg 0, Level 20, State 0, Line 0 - A severe error occurred on the current command. The results, if any, should be discarded.
Link: None


**Trace flag: 9268**
Function: SQL 8 - When SQL Server runs a parameterized query that contains several IN clauses, each with a large number of values, SQL Server may return the following error message after a minute or more of high CPU utilization: KB 325658
Server: Msg 8623, Level 16, State 1
Internal Query Processor Error: The query processor could not produce a query plan. Contact your primary support provider for more information.
Link: None


**Trace Flag: 9292**
Function: Output Statistics considered to be used by Query Optimizer
Link: <http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx>
Related to: 9204


**Trace Flag: 9481**
Function: Forces the query optimizer to use the SQL Server 2012 version
of the cardinality estimator when creating the query plan when running
SQL Server 2014 with the default database compatibility level 120
Link: <http://support.microsoft.com/kb/2801413>


**Trace Flag: 9485**
Function: Disables SELECT permission for DBCC SHOW\_STATISTICS
Link: <http://msdn.microsoft.com/en-us/library/ms188396.aspx>


**Trace Flag: 9532**
Function: SQL 11 CTP3 - to get more than 1 availability group replica in CTP3 Scope Startup
Link: <http://connect.microsoft.com/SQLServer/feedback/details/682581/denali-hadron-read-only-routing-url-is-not-yet-implemente>


**Trace Flag: 9806**
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard
installation in Windows Azure VM
Link: None


**Trace Flag: 9807**
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard
installation in Windows Azure VM
Link: None


**Trace Flag: 9808**
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard
installation in Windows Azure VM
Link: None
