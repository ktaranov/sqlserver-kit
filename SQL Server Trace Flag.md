# Microsoft SQL Server Trace Flags
Complete list of Microsoft SQL Server trace flags (180 trace flags).

Headers:
 - [What are Microsoft SQL Server Trace Flags?](#what-are-microsoft-sql-server-trace-flags)
 - [How do I turn Trace Flags on and off?](#how-do-i-turn-trace-flags-on-and-off)
 - [How do I know what Trace Flags are turned on at the moment?](#how-do-i-know-what-trace-flags-are-turned-on-at-the-moment)
 - [Trace flag list](#trace-flag-list)

Source links:
 - [Steinar Andersen great post](http://www.sqlservice.se/updated-microsoft-sql-server-trace-flag-list/)
 - [Yusuf Anis trace flag table](http://www.sqlservercentral.com/articles/trace+flags/70131/)
 - MSDN TF list: http://sqlserverpedia.com/wiki/Trace_Flags
 - Albert van der Sel TF list: http://antapex.org/traceflags_sqlserver.txt
 - Technet Wiki TF list: http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx
 - Amit Banerjee TF list: http://troubleshootingsql.com/2012/07/01/sql-server-2008-trace-flags/
 - Paul Randal discussing TF Pro’s and Con’s: http://www.sqlskills.com/blogs/paul/the-pros-and-cons-of-trace-flags/
 - **Some trace flags needs to be specified with "t" rather than with "T" in startup options!**: http://technet.microsoft.com/en-us/library/ms190737(v=sql.110).aspx

**Thanks to:**
 - Steinar Andersen
 - Brent Ozar
 - Yusuf Anis
 - Lars Utterström
 - Martin Höglund
 - Håkan Winther
 - Toine Rozemeijer
 - Robert L Davis aka @sqlsoldier
 - sql_handle aka @sql_handle
 - Andrzej Kukuła


## What are Microsoft SQL Server Trace Flags?
Trace Flags are settings that in some way or another alters the behavior of various SQL Server functions: https://msdn.microsoft.com/en-us/library/ms188396.aspx


## How do I turn Trace Flags on and off?
 - You can use the [DBCC TRACEON](https://msdn.microsoft.com/en-us/library/ms187329.aspx "Official MSDN DBCC TRACEON Article") and [DBCC TRACEOFF](https://msdn.microsoft.com/en-us/library/ms174401.aspx "Official MSDN DBCC TRACEOFF Article") commands
 - You can use the [-T option](https://technet.microsoft.com/en-us/library/ms190737%28v=sql.120%29.aspx "Official TECHNET Database Engine Service Startup Options Article") in the startup configuration for the SQL Server Service.
   **When specifying a trace flag with the -T option, use an uppercase "T" to pass the trace flag number. A lowercase "t" is accepted by SQL Server, but this sets other internal trace flags that are required only by SQL Server support engineers. (Parameters specified in the Control Panel startup window are not read.)**
 - You can also use the hint [QUERYTRACEON](https://support.microsoft.com/en-us/kb/2801413 "Official QUERYTRACEON KB Article") in your queries: **&lt;querytraceon_hint ::= {QUERYTRACEON trace_flag_number}>**


## How do I know what Trace Flags are turned on at the moment?
 - You can use the [DBCC TRACESTATUS](https://msdn.microsoft.com/en-us/library/ms187809.aspx "Official MSDN link") command


**REMEMBER: Be extremely careful with trace flags, test in your test environment first. And consult professionals first if you are the slightest uncertain about the effects of your changes.**


## Trace flag list
Summary: 180 trace flags

**Trace Flag: -1**<br />
Function: Sets trace flags for all connections<br />
Link:  None (Yusuf Anis)


**Trace Flag: 101**<br />
Function: Verbose Merge Replication logging output for troubleshooting
Merger repl performance<br />
Link: http://support.microsoft.com/kb/2892633


**Trace Flag: 102**<br />
Function: Verbose Merge Replication logging to msmerge\_history table
for troubleshooting Merger repl performance<br />
Link: http://support.microsoft.com/kb/2892633


**Trace Flag: 105**<br />
Function: Join more than 16 tables in SQL server 6.5<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 106**<br />
Function: This enables you to see the messages that are sent to and from the Publisher, if you are using Web Synchronization<br />
Link: http://technet.microsoft.com/en-us/library/ms151872(v=sql.105).aspx


**Trace Flag: 107**<br />
Function: SQL 6.5/7/8 – Interprets numbers with a decimal point as float instead of decimal<br />
Link: http://support.microsoft.com/kb/203787<br />
Link: https://support.microsoft.com/en-us/kb/155714<br />
*Thanks to: http://www.sqlservercentral.com*


**Trace Flag: 110**<br />
Function: SQL 6.5 – Turns off ANSI select characteristics<br />
Link: https://support.microsoft.com/en-us/kb/152032


**Trace Flag: 146**<br />
Function: Consider using when replaying against SQL 8.0, to avoid an attempt to set an encrypted connection.<br />
Link: None


**Trace Flag: 168**<br />
Function: Bugfix in ORDER BY<br />
Link: http://support.microsoft.com/kb/926292


**Trace Flag: 204**<br />
Function: SQL 6.5 – Backward compatibility switch that enables non-ansi standard behavior. E.g. previously SQL server ignored trailing blanks in the like statement and allowed queries that contained aggregated functions to have items in the group by clause that were not in the select list.<br />
Link: None


**Trace Flag: 205**<br />
Function: Log usage of AutoStat/Auto Update Statistics<br />
Link: http://support.microsoft.com/kb/195565


**Trace Flag: 206**<br />
Function: SQL 6.5 – Provides backward compatibility for the set user statement. KB 160732<br />
Link: None


**Trace Flag: 208**<br />
Function: SET QUOTED IDENTIFIER ON<br />
Link: None


**Trace Flag: 210**<br />
Function: SQL 9 – Error when you run a query against a view: "An error occurred while executing batch"<br />
Link: https://support.microsoft.com/en-us/kb/945892


**Trace Flag: 212**<br />
Function: SQL 9 – Query may run much slower when compared to SQL 8 when you use a cursor to run the query<br />
Link: https://support.microsoft.com/en-us/kb/951184


**Trace Flag: 237**<br />
Function: Tells SQL Server to use correlated sub-queries in Non-ANSI standard backward compatibility mode<br />
Link: None


**Trace Flag: 242**<br />
Function: Provides backward compatibility for correlated subqueries where non-ANSI-standard results are desired<br />
Link: None


**Trace Flag: 243**<br />
Function: Provides backward compatibility for nullability behavior. When set, SQL Server has the same nullability violation behavior as that of a ver 4.2: Processing of the entire batch is terminated if the nullability error (inserting NULL into a NOT NULL field) can be detected at compile time; Processing of offending row is skipped, but the command continues if the nullability violation is detected at run time.Behavior of SQL Server is now more consistent because nullability checks are made at run time and a nullability violation results in the command terminating and the batch or transaction process continuing.<br />
Link: None


**Trace Flag: 244**<br />
Function: Disables checking for allowed interim constraint violations. By default, SQL Server checks for and allows interim constraint violations. An interim constraint violation is caused by a change that removes the violation such that the constraint is met, all within a single statement and transaction. SQL Server checks for interim constraint violations for self-referencing DELETE statements, INSERT, and multi-row UPDATE statements. This checking requires more work tables. With this trace flag you can disallow interim constraint violations, thus requiring fewer work tables.<br />
Link: None


**Trace Flag: 246**<br />
Function: Derived or NULL columns must be explicitly named in a select…INTO or create view statement when not done they raise an error. This flag avoids that.<br />
Link: None


**Trace Flag: 253**<br />
Function: Prevents ad-hoc query plans to stay in cache<br />
Link: http://www.sqlservercentral.com/Forums/Topic837613-146-1.aspx


**Trace Flag: 257**<br />
Function: Will invoke a print algorithm on the XML output before returning it to make the XML result more readable<br />
Link: None


**Trace Flag: 260**<br />
Function: Prints versioning information about extended stored procedure dynamic-link libraries (DLLs). Scope: global or session<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Link: http://msdn.microsoft.com/en-us/library/ms164627.aspx<br />
Scope: global


**Trace Flag: 262**<br />
Function: SQL 7 – Trailing spaces are no longer truncated from literal strings in CASE statements<br />
Link: https://support.microsoft.com/en-us/kb/891116


**Trace Flag: 272**<br />
Function: Generates a log record per identity increment. Can be users
to convert SQL 2012 back to old style Identity behaviour<br />
Link: http://www.big.info/2013/01/how-to-solve-sql-server-2012-identity.html<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/739013/failover-or-restart-results-in-reseed-of-identity


**Trace Flag: 302**<br />
Function: Output Index Selection info<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 310**<br />
Function: Outputs info about actual join order<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 320**<br />
Function: Disables join-order heuristics used in ANSI joins. To see join-order heuristics use flag 310. SQL Server uses join-order heuristics to reduce of permutations when using the best join order. <br />
Link: None


**Trace Flag: 323**<br />
Function: Outputs detailed info about updates<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 325**<br />
Function: Prints information about the cost of using a non-clustered index or a sort to process an ORDER BY clause<br />
Link: None


**Trace Flag: 345**<br />
Function: Changes join order selection logic in SQL Server 6.5<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 445**<br />
Function: Prints ”compile issued” message in the errorlog for each
compiled statement, when used together with 3605<br />
Link: None


**Trace Flag: 610**<br />
Function: Minimally logged inserts to indexed tables<br />
Link: http://msdn.microsoft.com/en-us/library/dd425070%28v=SQL.100%29.aspx


**Trace Flag: 634**<br />
Function: Disables the background columnstore compression task<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 652**<br />
Function: Disable page pre-fetching scans<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 661**<br />
Function: Disable the ghost record removal process<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 662**<br />
Function: Prints detailed information about the work done by the ghost
cleanup task when it runs next. Use TF 3605 to see the output in the
errorlog<br />
Link: http://blogs.msdn.com/b/sqljourney/archive/2012/07/28/an-in-depth-look-at-ghost-records-in-sql-server.aspx


**Trace Flag: 806**<br />
Function: Turn on Page Audit functionality, to verify page validity<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 818**<br />
Function: Turn on ringbuffer to store info about IO write operations.
Used to troubleshoot IO problems<br />
Link: http://support.microsoft.com/kb/826433


**Trace Flag: 834**<br />
Function: Large Page Allocations<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 836**<br />
Function: Use the max server memory option for the buffer pool<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 845**<br />
Function: Enable Lock pages in Memory on Standard Edition<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-performance-with-dynamics-axapta.aspx


**Trace Flag: 902**<br />
Function: Bypass Upgrade Scripts<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx


**Trace Flag: 1117**<br />
Function: Simultaneous Autogrowth in Multiple-file database<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://blogs.technet.com/technet_blog_images/b/sql_server_sizing_ha_and_performance_hints/archive/2012/02/09/sql-server-2008-trace-flag-t-1117.aspx


**Trace Flag: 1118**<br />
Function: Force Uniform Extent Allocation<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://blogs.msdn.com/b/psssql/archive/2008/12/17/sql-server-2005-and-2008-trace-flag-1118-t1118-usage.aspx<br />
Scope: global


**Trace Flag: 1119**<br />
Function: Turns of mixed extent allocation (Similar to 1118?)<br />
Link: http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx


**Trace Flag: 1124**<br />
Function: Unknown. Has been reportedly found turned on in some SQL Server instances running Dynamics AX. Also rumored to be invalid in public builds of SQL Server<br />
Link: None


**Trace Flag: 1140**<br />
Function: Fix for growing tempdb in special cases<br />
Link: http://support.microsoft.com/kb/2000471


**Trace Flag: 1200**<br />
Function: Prints detailed lock information as every request for a lock is made (the process ID and type of lock requested)<br />
Link: http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx


**Trace Flag: 1204**<br />
Function: Returns info about deadlocks<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 1211**<br />
Function: Disables Lock escalation caused by memory pressure<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global or session


**Trace Flag: 1222**<br />
Function: Returns Deadlock info in XML format<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 1224**<br />
Function: Disables lock escalation based on number of locks<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global or session


**Trace Flag: 1236**<br />
Function: Fixes performance problem in scenarios with high lock activity
in SQL 2012 and SQL 2014<br />
Link: http://support.microsoft.com/kb/2926217


**Trace Flag: 1264**<br />
Function: Collect process names in non-yielding scenario memory dumps<br />
Link: http://support.microsoft.com/kb/2630458/en-us


**Trace Flag: 1448**<br />
Function: Alters replication log reader functionality<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 1462**<br />
Function: Disable Mirroring Log compression<br />
Link: http://sqlcat.com/sqlcat/b/technicalnotes/archive/2007/09/17/database-mirroring-log-compression-in-sql-server-2008-improves-throughput.aspx


**Trace Flag: 1717**<br />
Function: MSShipped bit will be set automatically at Create time when
creating stored procedures<br />
Link: None


**Trace Flag: 1806**<br />
Function: Disable Instant File Initialization<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 1807**<br />
Function: Enable option to have database files on SMB share for SQL
Server 2008 and 2008R2<br />
Link: http://blogs.msdn.com/b/varund/archive/2010/09/02/create-a-sql-server-database-on-a-network-shared-drive.aspx


**Trace Flag: 2301**<br />
Function: Enable advanced decision support optimizations<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 2312**<br />
Function: Forces the query optimizer to use the SQL Server 2014 version
of the cardinality estimator when creating the query plan when running
SQL Server 2014 with database compatibility level 110<br />
Link: http://support.microsoft.com/kb/2801413


**Trace Flag: 2330**<br />
Function: Query performance decreases when sys.dm_db_index_usage_stats has large number of rows<br />
Link: https://support.microsoft.com/en-us/kb/2003031
Link: http://www.brentozar.com/archive/2015/11/trace-flag-2330-who-needs-missing-index-requests/


**Trace Flag: 2335**<br />
Function: Generates Query Plans optimized for less memory<br />
Link: http://support.microsoft.com/kb/2413549


**Trace Flag: 2340**<br />
Function: Disable specific SORT optimization in Query Plan<br />
Link: http://support.microsoft.com/kb/2009160


**Trace Flag: 2371**<br />
Function: Change threshold for auto update stats<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server--auto-update-stats-part-2.aspx


**Trace Flag: 2372**<br />
Function: Displays memory utilization during the optimization process<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 2373**<br />
Function: Displays memory utilization during the optimization process<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 2388**<br />
Function: Change DBCC SHOW\_STATISTICS output to show stats history and
lead key type such as known ascending keys<br />
Link: http://www.benjaminnevarez.com/2013/02/statistics-on-ascending-keys


**Trace Flag: 2389**<br />
Function: Enable auto-quick-statistics update for known ascending keys<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx<br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767


**Trace Flag: 2390**<br />
Function: Enable auto-quick-statistics update for all columns<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx<br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767


**Trace Flag: 2430**<br />
Function: Fixes performance problem when using large numbers of locks<br />
Link: http://support.microsoft.com/kb/2754301/en-us


**Trace Flag: 2453**<br />
Function: Allow a table variable to trigger recompile when enough number
of rows are changed with may allow the query optimizer to choose a more
efficient plan.<br />
Link: http://sqlperformance.com/2014/06/t-sql-queries/table-variable-perf-fix<br />
Link: http://http//support.microsoft.com/kb/2952444


**Trace Flag: 2470**<br />
Function: Fixes performance problem when using AFTER triggers on
partitioned tables<br />
Link: http://support.microsoft.com/kb/2606883/en-us


**Trace Flag : 2514**<br />
Function: Verbose Merge Replication logging to msmerge\_history table
for troubleshooting Merger repl performance<br />
Link: http://sqlblog.com/blogs/argenis_fernandez/archive/2012/05/29/ghost-records-backups-and-database-compression-with-a-pinch-of-security-considerations.aspx


**Trace Flag: 2528**<br />
Function: Disables parallelism in CHECKDB etc<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 2529**<br />
Function: Displays memory usage for DBCC commands when used with TF
3604S<br />
Link: None


**Trace Flag: 2537**<br />
Function: Allows you to see inactive records in transaction log using
fn\_dblog<br />
Link: http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog


**Trace Flag: 2540**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2541**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2542**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2543**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2544**<br />
Function: Produces a full memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2545**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2546**<br />
Function: Dumps all threads for SQL Server in the dump file<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2547**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2548**<br />
Function: Shrink will run faster with this trace flag if there are LOB
pages that need conversion and/or compaction, because that actions will
be skipped.<br />
Link: http://blogs.msdn.com/b/psssql/archive/2008/03/28/how-it-works-sql-server-2005-dbcc-shrink-may-take-longer-than-sql-server-2000.aspx

*Thanks to: Andrzej Kukula*


**Trace Flag: 2549**<br />
Function: Faster CHECKDB<br />
Link: http://www.sqlservice.se/sv/start/blogg/faster-dbcc-checkdb-by-using-trace-flag-2562-and-2549.aspx<br />
Link: http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx<br />
Link: http://support.microsoft.com/kb/2634571<br />
Link: http://support.microsoft.com/kb/2732669/en-us


**Trace Flag: 2550**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2551**<br />
Function: Produces a filtered memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2552**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2553**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2554**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2555**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2556**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2557**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2558**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2559**<br />
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2562**<br />
Function: Faster CHECKDB<br />
Link: http://www.sqlservice.se/sv/start/blogg/faster-dbcc-checkdb-by-using-trace-flag-2562-and-2549.aspx<br />
Link: http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx<br />
Link: http://support.microsoft.com/kb/2634571<br />
Link: http://support.microsoft.com/kb/2732669/en-us


**Trace Flag: 2588**<br />
Function: Get more information about undocumented DBCC commands<br />
Link: http://www.sqlservice.se/sv/start/blogg/trace-flag--undocumented-commands.aspx


**Trace Flag: 2861**<br />
Function: Keep zero cost plans in cache<br />
Link: http://support.microsoft.com/kb/325607


**Trace Flag: 3004**<br />
Function: Returns more info about Instant File Initialization<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3014**<br />
Function: Returns more info about backups to the errorlog<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3042**<br />
Function: Alters backup compression functionality<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 3101**<br />
Function: Fix performance problems when restoring database with CDC<br />
Link: http://support.microsoft.com/kb/2567366/en-us


**Trace Flag: 3205**<br />
Function: Disable HW compression for backup to tape drives<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 3213**<br />
Function: Output buffer info for backups to ERRORLOG
<br />
Link: http://sqlcat.com/sqlcat/b/technicalnotes/archive/2008/04/21/tuning-the-performance-of-backup-compression-in-sql-server-2008.aspx


**Trace Flag: 3226**<br />
Function: Turns off ”Backup Successful” messages in errorlog<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx

*Thanks to: @lwiederstein (https://twitter.com/lwiederstein)*


**Trace Flag: 3422**<br />
Function: Log record auditing<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 3502**<br />
Function: Writes info about checkpoints to teh errorlog<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3505**<br />
Function: Disables automatic checkpointing<br />
Link: http://support.microsoft.com/kb/815436


**Trace Flag: 3604**<br />
Function: Redirect DBCC command output to query window<br />
Link: http://blogs.msdn.com/b/askjay/archive/2011/01/21/why-do-we-need-trace-flag-3604-for-dbcc-statements.aspx<br />
Link: http://www.sqlservice.se/sv/start/blogg/querytraceon.aspx


**Trace Flag: 3605**<br />
Function: Directs the output of some Trace Flags to the Errorlog<br />
Link: http://sqlcat.com/sqlcat/b/technicalnotes/archive/2008/04/21/tuning-the-performance-of-backup-compression-in-sql-server-2008.aspx


**Trace Flag: 3607**<br />
Function: Skip recovery on startup<br />
Link: http://sqlkbs.blogspot.se/2008/01/trace-flag.html


**Trace Flag: 3608**<br />
Function: Recover only Master db at startup<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 3609**<br />
Function: Do not create tempdb at startup<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/


**Trace Flag: 3625**<br />
Function: Masks some error messages<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 3656**<br />
Function: Enables resolve of all call stacks in extended events<br />
Link: http://sqlcat.com/sqlcat/b/msdnmirror/archive/2010/05/11/resolving-dtc-related-waits-and-tuning-scalability-of-dtc.aspx


**Trace Flag: 3659**<br />
Function: Enables logging all errors to error log during server startup<br />
Link: http://spaghettidba.com/2011/05/20/trace-flag-3659/


**Trace Flag: 3688**<br />
Function: Removes messages to error log about traces started and stopped<br />
Link: http://support.microsoft.com/kb/922578/en-us


**Trace Flag: 3801**<br />
Function: Prohibits use of USE DB statement<br />
Link: None


 **Trace Flag: 3923**<br />
Function: Let SQL Server throw an exception to the application when the 3303 warning message is raised.<br />
Link: https://support.microsoft.com/kb/3014867/en-us


**Trace Flag: 4013**<br />
Function: Log each new connection the error log<br />
Link: http://sqlkbs.blogspot.se/2008/01/trace-flag.html


**Trace Flag: 4022**<br />
Function: Bypass Startup procedures<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx


**Trace Flag: 4130**<br />
Function: XML performance fix<br />
Link: http://support.microsoft.com/kb/957205


**Trace Flag: 4134**<br />
Function: Bugfix for error: parallel query returning different results every time<br />
Link: http://support.microsoft.com/kb/2546901<br />
Link: http://sql-sasquatch.blogspot.se/2014/04/whaddayaknow-bout-sqlserver-trace-flag.html


**Trace Flag: 4135**<br />
Function: Bugfix for error inserting to temp table<br />
Link: http://support.microsoft.com/kb/960770


**Trace Flag: 4136**<br />
Function: Parameter Sniffing behaviour alteration<br />
Link: http://blogs.msdn.com/b/axinthefield/archive/2010/11/04/sql-server-trace-flags-for-dynamics-ax.aspx<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx


**Trace Flag: 4137**<br />
Function: Fix for bad performance in queries with several AND criteria<br />
Link: http://support.microsoft.com/kb/2658214


**Trace Flag: 4138**<br />
Function: Fixes performance problems with certain queries that use TOP
statement<br />
Link: http://support.microsoft.com/kb/2667211


**Trace Flag: 4199**<br />
Function: Turn on all optimizations<br />
Link: http://www.sqlservice.se/sv/start/blogg/one-trace-flag-to-rule-them-all.aspx<br />
Scope: global or session


**Trace Flag: 4606**<br />
Function: Ignore domain policy about weak password<br />
Link: None


**Trace Flag: 4616**<br />
Function: Alters server-level meta data visibility<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 6527**<br />
Function: Disables generation of a memory dump on the first occurrence of an out-of-memory exception in CLR integration. By default, SQL Server generates a small memory dump on the first occurrence of an out-of-memory exception in the CLR.
The behaviour of the trace flag is as follows:
If this is used as a startup trace flag, a memory dump is never generated. However, a memory dump may be generated if other trace flags are used.
If this trace flag is enabled on a running server, a memory dump will not be automatically generated from that point on. However, if a memory dump has already been generated due to an out-of-memory exception in the CLR, this trace flag will have no effect.
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 7300**<br />
Function: Outputs extra info about linked server errors<br />
Link: http://support.microsoft.com/kb/314530


**Trace Flag: 7502**<br />
Function: Disable cursor plan caching for extended stored procedures<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/


**Trace Flag: 7806**<br />
Function: Enables DAC on SQL Server Express<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx<br />
Scope: global


**Trace Flag: 7826**<br />
Function: Disable Connectivity ring buffer<br />
Link: http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx


**Trace Flag: 7827**<br />
Function: Record connection closure info in ring buffer<br />
Link: http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/518158/-packet-error-a-fatal-error-occurred-while-reading-the-input-stream-from-the-network


**Trace Flag: 8002**<br />
Function: Changes CPU Affinity behaviour<br />
Link: http://support.microsoft.com/kb/818769


**Trace Flag: 8010**<br />
Function: Fixes problem that SQL Server services can not be stopped<br />
Link: http://support.microsoft.com/kb/2633271/en-us


**Trace Flag: 8011**<br />
Function: Disable the ring buffer for Resource Monitor<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8012**<br />
Function: Disable the ring buffer for schedulers<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8015**<br />
Function: Ignore NUMA functionality<br />
Link: http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html
*Thanks to: @sql\_handle (https://twitter.com/sql_handle)*


**Trace Flag: 8018**<br />
Function: Disable the exception ring buffer<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8019**<br />
Function: Disable stack collection for the exception ring buffer<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8020**<br />
Function: Disable working set monitoring<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8026**<br />
Function: SQL Server will clear a dump trigger after generating the dump
once<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 8030**<br />
Function: Fix for performance bug<br />
Link: http://support.microsoft.com/kb/917035<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2005-slowing-down-after-a-while.aspx


**Trace Flag: 8032**<br />
Function: Alters cache limit settings<br />
Warning: Trace flag 8032 can cause poor performance if large caches make less memory available for other memory consumers, such as the buffer pool.<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 8038**<br />
Function: will drastically reduce the number of context switches when
running SQL 2005 or 2008<br />
Link: http://forum.proxmox.com/threads/15844-Win7-x64-guest-with-SQLServer-2012-High-CPU-usage<br />
Link: http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx


**Trace Flag: 8040**<br />
Function: Disables Resource Governor<br />
Link: http://www.sqlservergeeks.com/blogs/AmitBansal/sql-server-bi/64/sql-server-disabling-resource-governor-permanently-somewhat


**Trace Flag: 8048**<br />
Function: NUMA CPU based partitioning<br />
Link: http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html<br />
Link: http://blogs.msdn.com/b/psssql/archive/2012/12/20/how-it-works-cmemthread-and-debugging-them.aspx<br />
Link: http://blogs.msdn.com/b/psssql/archive/2011/09/01/sql-server-2008-2008-r2-on-newer-machines-with-more-than-8-cpus-presented-per-numa-node-may-need-trace-flag-8048.aspx

*Thanks to: @sql\_handle (https://twitter.com/sql_handle)*
Related to: 8015, 9024


**Trace Flag: 8207**<br />
Function: Alters Transactional Replication behaviour of UPDATE statement<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 8209**<br />
Function: Output extra information to error log regarding replication of
schema changes in SQL Server Replication<br />
Link: http://support.microsoft.com/kb/916706/en-us


**Trace Flag: 8602**<br />
Function: Disable Query Hints
<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-trace-flag-8602.aspx


**Trace Flag: 8605**<br />
Function: Displays logical and physical trees used during the
optimization process<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 8607**<br />
Function: Displays the optimization output tree during the optimization
process<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 8649**<br />
Function: Set Cost Threshold for parallelism to 0<br />
Link: http://www.sqlservice.se/sv/start/blogg/enable-parallellism-for-specific-query.aspx


**Trace Flag: 8675**<br />
Function: Displays the query optimization phases for a specific
optimization<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 8690**<br />
**Undocumented trace flag**<br />
Function: Disable the spool on the inner side of nested loop.<br />
Spools improve performance in majority of the cases. But it’s based on estimates. Sometimes, this can be incorrect due to unevenly distributed or skewed data, causing slow performance. But in vast majority of situations, you don’t need to manually disable spool with this trace flag.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2015/12/15/spool-operator-and-trace-flag-8690/
Link: http://dba.stackexchange.com/questions/52552/index-not-making-execution-faster-and-in-some-cases-is-slowing-down-the-query


**Trace Flag: 8722**<br />
Function: Disable all hints except locking hints<br />
Link: http://sqlmag.com/sql-server/investigating-trace-flags


**Trace Flag: 8744**<br />
Function: Disable pre-fetching for ranges<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8755**<br />
Function: Disable all locking hints<br />
Link: http://sqlmag.com/sql-server/investigating-trace-flags


**Trace Flag: 8757**<br />
Function: Skip trivial plan optimization and force a full optimization<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 8780**<br />
Function: Give the optimizer more time to find a better plan<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-trace-flag--8780.aspx


**Trace Flag: 9185**<br />
Function: Cardinality estimates for literals that are outside the
histogram range are very low<br />
Link: https://support.microsoft.com/en-us/kb/kbview/833406
Related to: 9205


**Trace Flag: 9024**<br />
Function: Performance fix for AlwaysON log replication<br />
Link: http://support.microsoft.com/kb/2809338/en-us
Related to: 8048


**Trace Flag: 9204**<br />
Function: Output Statistics used by Query Optimizer
When enabled and a plan is compiled or recompiled there is a listing of statistics which is being fully loaded & used to produce cardinality and distribution estimates for some plan alternative or other<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx
Related to: 9292


**Trace Flag: 9205**<br />
Function: Cardinality estimates for literals that are outside the histogram range are very low for tables that have parent-child relationships<br />
Link: https://support.microsoft.com/en-us/kb/kbview/833406
Related to: 9185


**Trace Flag: 9207**<br />
Function: Fixes that SQL Server underestimates the cardinality of a
query expression and query performance may be slow<br />
Link: https://support.microsoft.com/en-us/kb/831302


**Trace flag: 9259**<br />
Function: SQL 9/10 - An access violation occurs on running a query marked by the following message and a dump in the log folder: KB 970279 / 971490
Msg 0, Level 11, State 0, Line 0 - A severe error occurred on the current command. The results, if any, should be discarded.
Msg 0, Level 20, State 0, Line 0 - A severe error occurred on the current command. The results, if any, should be discarded.<br />
Link: None


**Trace flag: 9268**<br />
Function: SQL 8 - When SQL Server runs a parameterized query that contains several IN clauses, each with a large number of values, SQL Server may return the following error message after a minute or more of high CPU utilization: KB 325658
Server: Msg 8623, Level 16, State 1
Internal Query Processor Error: The query processor could not produce a query plan. Contact your primary support provider for more information.<br />
Link: None


**Trace Flag: 9292**<br />
Function: Output Statistics considered to be used by Query Optimizer<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx
Related to: 9204


**Trace Flag: 9481**<br />
Function: Forces the query optimizer to use the SQL Server 2012 version
of the cardinality estimator when creating the query plan when running
SQL Server 2014 with the default database compatibility level 120<br />
Link: http://support.microsoft.com/kb/2801413


**Trace Flag: 9485**<br />
Function: Disables SELECT permission for DBCC SHOW\_STATISTICS<br />
Link: http://msdn.microsoft.com/en-us/library/ms188396.aspx


**Trace Flag: 9532**<br />
Function: SQL 11 CTP3 - to get more than 1 availability group replica in CTP3 Scope Startup<br />
Link: http://connect.microsoft.com/SQLServer/feedback/details/682581/denali-hadron-read-only-routing-url-is-not-yet-implemente


**Trace Flag: 9806**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


**Trace Flag: 9807**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


**Trace Flag: 9808**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


**Trace Flag: 9830**<br />
**Undocumented trace flag**<br />
Function: Activate the trace flag before creating a natively compiled procedure. If you now open up the SQL Server error log you should see the compilation process for the natively compiled procedure. This is an undocumented trace flag so please don’t use this on a production system.<br />
Link: http://speedysql.com/2015/10/28/new-trace-flag-for-in-memory-oltp-hekaton/#more-1216
