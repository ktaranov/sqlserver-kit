# Microsoft SQL Server Trace Flags
Complete list of Microsoft SQL Server trace flags (344 trace flags)

**REMEMBER: Be extremely careful with trace flags, test in your test environment first. And consult professionals first if you are the slightest uncertain about the effects of your changes.**


Headers:
 - [What are Microsoft SQL Server Trace Flags?](#what-are-microsoft-sql-server-trace-flags)
 - [How do I turn Trace Flags on and off?](#how-do-i-turn-trace-flags-on-and-off)
 - [How do I know what Trace Flags are turned on at the moment?](#how-do-i-know-what-trace-flags-are-turned-on-at-the-moment)
 - [What Are the Optimizer Rules?](#what-are-the-optimizer-rules)
 - [Trace flags list](#trace-flags-list)

Source links:
 - [Steinar Andersen great post](http://www.sqlservice.se/updated-microsoft-sql-server-trace-flag-list/)
 - [Yusuf Anis trace flag table](http://www.sqlservercentral.com/articles/trace+flags/70131/)
 - [MSDN TF list](http://sqlserverpedia.com/wiki/Trace_Flags)
 - [Albert van der Sel TF list](http://antapex.org/traceflags_sqlserver.txt)
 - [TECHNET List Of SQL Server Trace Flags]
 - [Amit Banerjee TF list](http://troubleshootingsql.com/2012/07/01/sql-server-2008-trace-flags/)
 - [Paul Randal discussing TF Pro’s and Con’s](http://www.sqlskills.com/blogs/paul/the-pros-and-cons-of-trace-flags/)
 - [A Topical Collection of SQL Server Flags](https://sqlcrossjoin.wordpress.com/2013/10/28/a-topical-collection-of-sql-server-flags/)
 - **When specifying a trace flag with the -T option, use an uppercase "T" to pass the trace flag number.
A lowercase "t" is accepted by SQL Server, but this sets other internal trace flags that are required only by SQL Server support engineers.
(Parameters specified in the Control Panel startup window are not read.)**: https://technet.microsoft.com/en-us/en-en/library/ms190737%28v=sql.120%29.aspx
 - [Enabling SQL Server Trace Flag for a Poor Performing Query Using QUERYTRACEON](https://www.mssqltips.com/sqlservertip/3320/enabling-sql-server-trace-flag-for-a-poor-performing-query-using-querytraceon/)
 - [Disabling SQL Server Optimizer Rules with QUERYRULEOFF](https://www.mssqltips.com/sqlservertip/4175/disabling-sql-server-optimizer-rules-with-queryruleoff/)

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


## What are Microsoft SQL Server Trace Flags? <a id="what-are-microsoft-sql-server-trace-flags"></a>
Trace Flags are settings that in some way or another alters the behavior of various SQL Server functions: [MSDN ms188396]


## How do I turn Trace Flags on and off? <a id="how-do-i-turn-trace-flags-on-and-off"></a>
 - You can use the [DBCC TRACEON](https://msdn.microsoft.com/en-us/library/ms187329.aspx "Official MSDN DBCC TRACEON Article") and [DBCC TRACEOFF](https://msdn.microsoft.com/en-us/library/ms174401.aspx "Official MSDN DBCC TRACEOFF Article") commands
 - You can use the [-T option](https://technet.microsoft.com/en-us/library/ms190737%28v=sql.120%29.aspx "Official TECHNET Database Engine Service Startup Options Article") in the startup configuration for the SQL Server Service.
   **When specifying a trace flag with the -T option, use an uppercase "T" to pass the trace flag number. A lowercase "t" is accepted by SQL Server, but this sets other internal trace flags that are required only by SQL Server support engineers. (Parameters specified in the Control Panel startup window are not read.)**
 - You can also use the hint [QUERYTRACEON](https://support.microsoft.com/en-us/kb/2801413 "Official QUERYTRACEON KB Article") in your queries: **&lt;querytraceon_hint ::= {QUERYTRACEON trace_flag_number}>**


## How do I know what Trace Flags are turned on at the moment? <a id="how-do-i-know-what-trace-flags-are-turned-on-at-the-moment"></a>
You can use the [DBCC TRACESTATUS](https://msdn.microsoft.com/en-us/library/ms187809.aspx "Official MSDN link") command

The following example displays the status of all trace flags that are currently enabled globally:
```sql
DBCC TRACESTATUS(-1);
GO
```

The following example displays the status of trace flags 2528 and 3205:
```sql
DBCC TRACESTATUS (2528, 3205);
GO
```

The following example displays whether trace flag 3205 is enabled globally:
```sql
DBCC TRACESTATUS (3205, -1);
GO
```

The following example lists all the trace flags that are enabled for the current session:
```sql
DBCC TRACESTATUS ();
GO
```


## What Are the Optimizer Rules? <a id="what-are-the-optimizer-rules"></a>
We all know that every time SQL Server executes a query it builds an execution plan that translates the logical operations like joins and predicates into physical operations that are implemented in the SQL Server source code. That conversion is based on certain rules known as the Optimizer Rules. They define for example how to perform an INNER JOIN. When we write a simple select statement with an inner join, the query optimizer chooses based on statistics, indexes and enabled rules if the join is executed as a Merge Join, Nested Loop or a Hash Join and also if the join can use the commutative property of joins. Mathematically A join B is equal to B join A, but the computational cost generally is not the same.

### Getting the List of Available Rules
To obtain the list of rules of your version of SQL Server we must use the undocumented DBCC commands SHOWONRULES and SHOWOFFRULES. Those commands display the enabled and disabled rules for the whole instance respectively. As you may guess, the number of rules varies amongst versions.

```sql
USE master;
GO

DBCC TRACEON(3604);
GO

DBCC SHOWONRULES;
GO

DBCC SHOWOFFRULES;
GO
```

| Rule Name | Description                       |
|-----------|-----------------------------------|
| JNtoNL    | Join to Nested Loop               |
| JNtoHS    | Join to Hash                      |
| JNtoSM    | Join to Sort Merge                |
| LOJNtoNL  | Left Outer Join to Nested Loop    |
| LSJNtoHS  | Left Semi Join to Hash            |
| LASJNtoSM | Left Anti Semi Join to Sort Merge |


## Trace flags list <a id="trace-flags-list"></a>
Summary: **344 trace flags**


**Trace Flag: -1**<br />
Function: Sets trace flags for all client connections, rather than for a single client connection. Because trace flags set using the -T command-line option automatically apply to all connections, this trace flag is used only when setting trace flags using DBCC TRACEON and DBCC TRACEOFF.<br />
Link: http://www.sql-server-performance.com/2002/traceflags/


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


**Trace Flag: 144**<br />
Function: Force server side bucketization.
For legacy applications where change to client side code is not an option and
when the application has queries that are improperly parameterized, this trace flag forces server side bucketization.<br />
Link: http://blogs.msdn.microsoft.com/sqlprogrammability/2007/01/13/6-0-best-programming-practices


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
Link: [MSDN ms188396]<br />
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


**Trace Flag: 326**<br />
Function: Prints information about estimated & actual costs of sorts. Instructs server to use arithmetic averaging when calculating density instead of a geometric weighted average when updating statistics. Useful for building better stats when an index has skew on the leading column. Use only for updating the stats of a table/index with known skewed data.<br />
Link: None


**Trace Flag: 330**<br />
Function: Enables full output when using the SET SHOWPLAN_ALL option, which gives detailed information about joins<br />
Link: None


**Trace Flag: 342**<br />
Function: Disables the costing of pseudo-merge joins, thus significantly reducing time spent on the parse for certain types of large, multi-table joins. One can also use SET FORCEPLAN ON to disable the costing of pseudo-merge joins because the query is forced to use the order specified in the FROM clause. <br />
Link: None


**Trace Flag: 345**<br />
Function: Changes join order selection logic in SQL Server 6.5<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm


**Trace Flag: 445**<br />
Function: Prints ”compile issued” message in the errorlog for each compiled statement, when used together with 3605<br />
Link: None


**Trace Flag: 506**<br />
Function: Enforces SQL-92 standards regarding null values for comparisons between variables and parameters. Any comparison of variables and parameters that contain a NULL always results in a NULL.<br />
Link: None


**Trace Flag: 610**<br />
Function: Minimally logged inserts to indexed tables<br />
Link: http://msdn.microsoft.com/en-us/library/dd425070%28v=SQL.100%29.aspx
Link: https://www.pythian.com/blog/minimally-logged-operations-data-loads/


**Trace Flag: 611**<br />
Function: SQL 9 – When turned on, each lock escalation is recorded in the error log along with the SQL Server handle number.
Aaron confirmed this still works in SQL 2014. Outputs info of the form: "Escalated
locks - Reason: LOCK_THRESHOLD, Mode: S, Granularity: TABLE, Table: 222623836,
HoBt: 150:256, HoBt Lock Count: 6248, Escalated Lock Count: 6249, Line Number: 1,
Start Offset: 0, SQL Statement: select count(*) from dbo.BigTable"<br />
Link: None


**Trace Flag: 617**<br />
Function: SQL 9 – When turned on, each lock escalation is recorded in the error log along with the SQL Server handle number.
As long as there are no SCH_M lock requests waiting in the ‘lock wait list’,
the ‘lock wait list’ will be bypassed by statements issued in uncommitted read transaction isolation level.
If there is a SCH_M lock request in the ‘lock wait list’, a query in uncommitted read transaction isolation level
will not bypass the ‘lock wait list’, but the SCH_S lock request will go into the ‘lock wait list’.
In order behind the SCH_M lock waiting in the same list. As a result the grant of the SCH_S request for such a query
is dependent on the grant and release of the SCH_M lock request entering the ‘lock wait list’ earlier.<br />
Link: https://blogs.msdn.microsoft.com/saponsqlserver/2014/01/17/new-functionality-in-sql-server-2014-part-3-low-priority-wait/


**Trace Flag: 634**<br />
Function: Disables the background columnstore compression task<br />
Link: [MSDN ms188396]<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]<br />
Scope: global


**Trace Flag: 646**<br />
Function: Serves for getting detailed information on which Columnstore were eliminated by the Query Optimiser right into the error log.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]


**Trace Flag: 652**<br />
Function: Disable page pre-fetching scans<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 653**<br />
Function: Disables read ahead for the current connection<br />
Link: None


**Trace Flag: 661**<br />
Function: Disable the ghost record removal process<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 662**<br />
Function: Prints detailed information about the work done by the ghost
cleanup task when it runs next. Use TF 3605 to see the output in the
errorlog<br />
Link: http://blogs.msdn.com/b/sqljourney/archive/2012/07/28/an-in-depth-look-at-ghost-records-in-sql-server.aspx


**Trace Flag: 698**<br />
Function: SQL 9 – Performance of INSERT operations against a table with an identity column may be slow when compared to SQL 8<br />
Link: https://support.microsoft.com/en-gb/kb/940545


**Trace Flag: 699**<br />
Function: Turn off transaction logging for the entire SQL dataserver<br />
Link: None


**Trace Flag: 806**<br />
Function: Turn on Page Audit functionality, to verify page validity<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 809**<br />
Function: SQL 8 – Limits the amount of Lazy write activity<br />
Link: None


**Trace Flag: 815**<br />
Function: SQL 8/9 – Enables latch enforcement. SQL Server 8 (with service pack 4) and SQL Server 9 can perform latch enforcement for data pages found in the buffer pool cache. Latch enforcement changes the virtual memory protection state while database page status changes from "clean" to "dirty" ("dirty" means modified through INSERT, UPDATE or DELETE operation). If an attempt is made to modify a data page while latch enforcement is set, it causes an exception and creates a mini-dump in SQL Server installation's LOG directory. Microsoft support can examine the contents of such mini-dump to determine the cause of the exception. In order to modify the data page the connection must first acquire a modification latch. Once the data modification latch is acquired the page protection is changed to read-write. Once the modification latch is released the page protection changes back to read-only.<br />
Link: None


**Trace Flag: 818**<br />
Function: Turn on ringbuffer to store info about IO write operations.
Used to troubleshoot IO problems<br />
Link: http://support.microsoft.com/kb/826433


**Trace Flag: 828**<br />
Function: SQL 8 - When enabled checkpoint ignores the recovery interval target and keeps steady I/O otherwise it uses recovery interval setting as a target for the length of time that checkpoint will take<br />
Link: https://support.microsoft.com/en-gb/kb/906121


**Trace Flag: 830**<br />
Function: SQL 9 – Disable the reporting of CPU Drift errors in the SQL Server errorlog like SQL Server has encountered 2 occurrence(s) of I/O requests taking longer than 15 seconds to complete<br />
Link: https://support.microsoft.com/en-us/kb/897284


**Trace Flag: 831**<br />
Function: Protect unchanged pages in the buffer pool to catch memory corruptions<br />
Link: None


**Trace Flag: 834**<br />
Function: Large Page Allocations<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 835**<br />
Function: SQL 9 / 10 – On 64 bit SQL Server it turns off Lock pages in memory<br />
Link: None


**Trace Flag: 836**<br />
Function: Use the max server memory option for the buffer pool<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 840**<br />
Function: SQL 9 – When trace turned on, SQL Server can perform larger I/O extent reads to populate the buffer pool when SQL Server starts this populates the buffer pool faster. Additionally, the larger I/O extent reads improve the initial query compilation and the response time when SQL Server starts.<br />
Link: https://support.microsoft.com/en-gb/kb/912322


**Trace Flag: 842**<br />
Function: Use sys.dm_os_memory_node_access_stats to verify local vs. foreign memory under NUMA configurations after turning on this flag<br />
Link: None


**Trace Flag: 845**<br />
Function: Enable Lock pages in Memory on Standard Edition<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-performance-with-dynamics-axapta.aspx<br />
Link: https://support.microsoft.com/en-gb/kb/970070


**Trace Flag: 902**<br />
Function: Bypass Upgrade Scripts<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx<br />
Link: https://support.microsoft.com/en-gb/kb/2163980


**Trace Flag: 1106**<br />
Function: SQL 9 - Used space in tempdb increases continuously when you run a query that creates internal objects in tempdb<br />
Link: https://support.microsoft.com/en-gb/kb/947204


**Trace Flag: 1117**<br />
Function: Simultaneous Autogrowth in Multiple-file database<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://blogs.technet.com/technet_blog_images/b/sql_server_sizing_ha_and_performance_hints/archive/2012/02/09/sql-server-2008-trace-flag-t-1117.aspx


**Trace Flag: 1118**<br />
Function: Force Uniform Extent Allocation<br />
Link: http://www.sqlservice.se/sv/start/blogg/nagra-trace-flags-for-sql-server.aspx<br />
Link: http://blogs.msdn.com/b/psssql/archive/2008/12/17/sql-server-2005-and-2008-trace-flag-1118-t1118-usage.aspx<br />
Link: http://www.sqlskills.com/blogs/paul/misconceptions-around-tf-1118/<br />
Scope: global


**Trace Flag: 1119**<br />
Function: Turns of mixed extent allocation (Similar to 1118?)<br />
Link: [TECHNET List Of SQL Server Trace Flags]


**Trace Flag: 1124**<br />
Function: Unknown. Has been reportedly found turned on in some SQL Server instances running Dynamics AX. Also rumored to be invalid in public builds of SQL Server<br />
Link: None


**Trace Flag: 1140**<br />
Function: Fix for growing tempdb in special cases<br />
Link: http://support.microsoft.com/kb/2000471


**Trace Flag: 1180**<br />
Function: SQL 7 - Forces allocation to use free pages for text or image data and maintain efficiency of storage.  Helpful in case when DBCC SHRINKFILE and SHRINKDATABASE commands may not work because of sparsely populated text, ntext, or image columns.<br />
Link: None


**Trace Flag: 1197**<br />
Function: Applies only in the case of SQL 7 – SP3, similar with trace flag 1180<br />
Link: None


**Trace Flag: 1200**<br />
Function: Prints detailed lock information as every request for a lock is made (the process ID and type of lock requested)<br />
Link: [TECHNET List Of SQL Server Trace Flags]


**Trace Flag: 1202**<br />
Function: Insert blocked lock requests into syslocks<br />
Link: None


**Trace Flag: 1204**<br />
Function: Returns info about deadlocks<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 1205**<br />
Function: More detailed information about the command being executed at the time of a deadlock. Documented in SQL 7 BOL.<br />
Link: None


**Trace Flag: 1206**<br />
Function: Used to complement flag 1204 by displaying other locks held by deadlock parties<br />
Link: None


**Trace Flag: 1211**<br />
Function: Disables Lock escalation caused by memory pressure<br />
Link: [MSDN ms188396]<br />
Scope: global or session


**Trace Flag: 1216**<br />
Function:  SQL 7 - Disables Health reporting. Lock monitor when detects a (worker thread) resource level blocking scenario. If a SPID that owns a lock is currently queued to the scheduler, because all the assigned worker threads have been created and all the assigned worker threads are in an un-resolvable wait state, the following error message is written to the SQL Server error log: Error 1223: Process ID %d:%d cannot acquire lock "%s" on resource %s because a potential deadlock exists on Scheduler %d for the resource. Process ID %d:% d holds a lock "%h" on this resource.<br />
Link: None


**Trace Flag: 1222**<br />
Function: Returns Deadlock info in XML format<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 1224**<br />
Function: Disables lock escalation based on number of locks<br />
Link: [MSDN ms188396]<br />
Scope: global or session


**Trace Flag: 1228**<br />
Function: Enable lock partitioning.
By default, lock partitioning is enabled when a server has 16 or more CPUs. Otherwise, lock partitioning is disabled.
Trace flag 1228 enables lock partitioning for 2 or more CPUs. Trace flag 1229 disables lock partitioning.
Trace flag 1229 overrides trace flag 1228 if trace flag 1228 is also set.
Lock partitioning is useful on multiple-CPU servers where some tables have very high lock rates.
You can turn on trace flag 1228 and trace flag 1229 only at startup.<br />
Link: [Trace Flag 1228 and 1229]<br />
Link: [Microsoft SQL Server 2005 TPC-C Trace Flags]


**Trace Flag: 1229**<br />
Function: Enable lock partitioning.
By default, lock partitioning is enabled when a server has 16 or more CPUs. Otherwise, lock partitioning is disabled.
Trace flag 1228 enables lock partitioning for 2 or more CPUs. Trace flag 1229 disables lock partitioning.
Trace flag 1229 overrides trace flag 1228 if trace flag 1228 is also set.
Lock partitioning is useful on multiple-CPU servers where some tables have very high lock rates.
You can turn on trace flag 1228 and trace flag 1229 only at startup.<br />
Link: [Trace Flag 1228 and 1229]<br />
Link: [Microsoft SQL Server 2005 TPC-C Trace Flags]


**Trace Flag: 1236**<br />
Function: Fixes performance problem in scenarios with high lock activity
in SQL 2012 and SQL 2014<br />
Link: http://support.microsoft.com/kb/2926217


**Trace Flag: 1260**<br />
Function: Disabled mini-dump for non-yield condition.
Disables mini-dump generation for "any of the 17883, 17884, 17887, or 17888 errors.
The trace flag can be used in conjunction with trace flag –T1262. For example, you
could enable –T1262 to get 10- and a 60-second interval reporting and also enable – T1260 to avoid getting mini-dumps."<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]


**Trace Flag: 1261**<br />
Function: SQL 8 - Disables Health reporting. Lock monitor when detects a (worker thread) resource level blocking scenario. If a SPID that owns a lock is currently queued to the scheduler, because all the assigned worker threads have been created and all the assigned worker threads are in an un-resolvable wait state, the following error message is written to the SQL Server error log: Error 1229: Process ID %d:%d owns resources that are blocking processes on scheduler %d.<br />
Link: None


**Trace Flag: 1262**<br />
Function: The default behavior (for 1788* errors) is for SQL to generate a mini-dump on the first
occurrence, but never after. 1262 changes the behavior: “When –T1262 is enabled, a
mini-dump is generated when the non-yielding condition is declared (15 seconds) and
at subsequent 60-second intervals for the same non-yield occurrence. A new nonDiagCorrect17883etc;
yielding occurrence causes dump captures to occur again.”
In SQL 2000 this was a startup-only flag; in 2005+ it can be enabled via TRACEON.
Note that the flag is also covered in Khen2005, p400, but with no new information.<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]


**Trace Flag: 1264**<br />
Function: Collect process names in non-yielding scenario memory dumps<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: http://support.microsoft.com/kb/2630458/en-us


**Trace Flag: 1400**<br />
Function: SQL 9 RTM – Enables creation of database mirroring endpoint, which is required for setting up and using database mirroring<br />
Link: None


**Trace Flag: 1439**<br />
Function: Trace database restart and failover messages to SQL Errorlog for mirrored databases<br />
Link: [Trace flags in sql server from trace flag 902 to trace flag 1462]


**Trace Flag: 1448**<br />
Function: Alters replication log reader functionality<br />
Link: [MSDN ms188396]


**Trace Flag: 1449**<br />
Function: When you use SNAC to connect to an instance of a principal server in a database mirroring session: "The connection attempted to fail over to a server that does not have a failover partner".<br />
Link: https://support.microsoft.com/en-gb/kb/936179


**Trace Flag: 1462**<br />
Function: Disable Mirroring Log compression<br />
Link: http://sqlcat.com/sqlcat/b/technicalnotes/archive/2007/09/17/database-mirroring-log-compression-in-sql-server-2008-improves-throughput.aspx


**Trace Flag: 1603**<br />
Function: Use standard disk I/O (i.e. turn off asynchronous I/O)<br />
Link: None


**Trace Flag: 1604**<br />
Function: Once enabled at start up makes SQL Server output information regarding memory allocation requests<br />
Link: None


**Trace Flag: 1609**<br />
Function: Turns on the unpacking and checking of RPC information in Open Data Services. Used only when applications depend on the old behavior.<br />
Link: None


**Trace Flag: 1610**<br />
Function: Boot the SQL dataserver with TCP_NODELAY enabled<br />
Link: None


**Trace Flag: 1611**<br />
Function: If possible, pin shared memory -- check errorlog for success/failure<br />
Link: None


**Trace Flag: 1613**<br />
Function: Set affinity of the SQL data server engine's onto particular CPUs -- usually pins engine 0 to processor 0, engine 1 to processor 1...<br />
Link: None


**Trace Flag: 1704**<br />
Function: Prints information when a temporary table is created or dropped<br />
Link: None


**Trace Flag: 1717**<br />
Function: MSShipped bit will be set automatically at Create time when creating stored procedures<br />
Link: None


**Trace Flag: 1802**<br />
Function: SQL 9 - After detaching a database that resides on network-attached storage, you cannot reattach the SQL Server database<br />
Link: https://support.microsoft.com/en-us/kb/922804


**Trace Flag: 1806**<br />
Function: Disable Instant File Initialization<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 1807**<br />
Function: Enable option to have database files on SMB share for SQL Server 2008 and 2008R2<br />
Link: http://blogs.msdn.com/b/varund/archive/2010/09/02/create-a-sql-server-database-on-a-network-shared-drive.aspx


**Trace Flag: 1810**<br />
Function: Prints the file create/open/close timings<br />
Link: None


**Trace Flag: 1903**<br />
Function: SQL 8 - When you capture a SQL Profiler trace in a file and then you try to import the trace files into tables by using the fn_trace_gettable function no rows may be returned<br />
Link: https://support.microsoft.com/en-us/kb/911678


**Trace Flag: 2301**<br />
Function: Enable advanced decision support optimizations<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 2312**<br />
Function: Forces the query optimizer to use the SQL Server 2014 version
of the cardinality estimator when creating the query plan when running
SQL Server 2014 with database compatibility level 110<br />
Link: http://support.microsoft.com/kb/2801413


**Trace Flag: 2328**<br />
Function: SQL 9+ - Makes cardinality estimates upon resulting selectivity.  The reasoning for this is that one or more of the constants may be statement parameters, which would change from one execution of the statement to the next.<br />
Link: None


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


**Trace Flag: 2363**<br />
Function: TF Selectivity<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 2371**<br />
Function: Change threshold for auto update stats<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server--auto-update-stats-part-2.aspx<br />
Link: https://support.microsoft.com/en-us/kb/2754171
Link: http://blogs.msdn.com/b/saponsqlserver/archive/2011/09/07/changes-to-automatic-update-statistics-in-sql-server-traceflag-2371.aspx


**Trace Flag: 2372**<br />
Function: Displays memory utilization during the optimization process. Memory for Phases.<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 2373**<br />
Function: Displays memory utilization during the optimization process. Memory for Deriving Properties.<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 2388**<br />
Function: Change DBCC SHOW\_STATISTICS output to show stats history and lead key type such as known ascending keys<br />
Link: http://www.benjaminnevarez.com/2013/02/statistics-on-ascending-keys


**Trace Flag: 2389**<br />
Function: Enable auto-quick-statistics update for known ascending keys<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx<br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767<br />
Link: http://sqlperformance.com/2016/07/sql-statistics/trace-flag-2389-new-cardinality-estimator


**Trace Flag: 2390**<br />
Function: Enable auto-quick-statistics update for all columns<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-statistics--traceflags-2389--2390.aspx<br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767


**Trace Flag: 2430**<br />
Function: Fixes performance problem when using large numbers of locks<br />
Link: http://support.microsoft.com/kb/2754301/en-us


**Trace Flag: 2440**<br />
Function: SQL 10 - Parallel query execution strategy on partitioned tables. SQL 9 used single thread per partition parallel query execution strategy. In SQL 10, multiple threads can be allocated to a single partition by turning on this flag.<br />
Link: None


**Trace Flag: 2453**<br />
Function: Allow a table variable to trigger recompile when enough number of rows are changed with may allow the query optimizer to choose a more efficient plan.<br />
Link: http://sqlperformance.com/2014/06/t-sql-queries/table-variable-perf-fix<br />
Link: http://http//support.microsoft.com/kb/2952444


**Trace Flag: 2470**<br />
Function: Fixes performance problem when using AFTER triggers on partitioned tables<br />
Link: http://support.microsoft.com/kb/2606883/en-us


**Trace Flag: 2505**<br />
Function: SQL 7 - Prevents DBCC TRACEON 208, SPID 10 errors from appearing in the error log<br />
Link: https://support.microsoft.com/en-us/kb/243352


**Trace Flag: 2508**<br />
Function: Disables parallel non-clustered index checking for DBCC CHECKTABLE<br />
Link: None


**Trace Flag: 2509**<br />
Function: Used with DBCC CHECKTABLE to see the total count of forward records in a table<br />
Link: None


**Trace Flag: 2514**<br />
Function: Verbose Merge Replication logging to msmerge\_history table for troubleshooting Merger repl performance<br />
Link: http://sqlblog.com/blogs/argenis_fernandez/archive/2012/05/29/ghost-records-backups-and-database-compression-with-a-pinch-of-security-considerations.aspx


**Trace Flag: 2520**<br />
Function: Forces DBCC HELP to return syntax of undocumented DBCC statements. If 2520 is not turned on, DBCC HELP will refuse to give you the syntax stating: "No help available for DBCC statement 'undocumented statement'". dbcc help ('?')<br />
Link: None


**Trace Flag: 2521**<br />
Function: SQL 7 SP2 - Facilitates capturing a Sqlservr.exe user-mode crash dump for postmortem analysis<br />
Link: None


**Trace Flag: 2528**<br />
Function: Disables parallelism in CHECKDB etc<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 2529**<br />
Function: Displays memory usage for DBCC commands when used with TF 3604<br />
Link: None


**Trace Flag: 2536**<br />
Function: Allows you to see inactive records in transaction log using fn\_dblog.
Similar to trace flag 2537 for older version than SQL Server 2008.<br />
Link: http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog


**Trace Flag: 2537**<br />
Function: Allows you to see inactive records in transaction log using fn\_dblog<br />
Link: http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog


**Trace Flag: 2540**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2541**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2542**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 2543**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
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
Function: Shrink will run faster with this trace flag if there are LOB pages that need conversion and/or compaction, because that actions will be skipped.<br />
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


**Trace Flag: 2701**<br />
Function: SQL 6.5 - Sets the @@ERROR system function to 50000 for RAISERROR messages with severity levels of 10 or less. When disabled, sets the @@ERROR system function to 0 for RAISERROR messages with severity levels of 10 or less<br />
Link: None


**Trace Flag: 2861**<br />
Function: Keep zero cost plans in cache. Tip: Avoid Using Trace Flag 2861 to Cache Zero-Cost Query Plan<br />
Link: http://support.microsoft.com/kb/325607<br />


**Trace Flag: 3001**<br />
Function: Stops sending backup entries into MSDB<br />
Link: None


**Trace Flag: 3004**<br />
Function: Returns more info about Instant File Initialization. Shows information about backups and file creations use with 3605 to direct to error log.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/01/23/how-it-works-what-is-restorebackup-doing/<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3014**<br />
Function: Returns more info about backups to the errorlog<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3023**<br />
Function: How to enable the CHECKSUM option if backup utilities do not expose the option<br />
Link: https://support.microsoft.com/kb/2656988


**Trace Flag: 3031**<br />
Function: SQL 9 - Will turn the NO_LOG and TRUNCATE_ONLY options into checkpoints in all recovery modes<br />
Link: None


**Trace Flag: 3042**<br />
Function: Alters backup compression functionality<br />
Link: [MSDN ms188396]


**Trace Flag: 3101**<br />
Function: Fix performance problems when restoring database with CDC<br />
Link: http://support.microsoft.com/kb/2567366/


**Trace Flag: 3104**<br />
Function: Causes SQL Server to bypass checking for free space<br />
Link: None


**Trace Flag: 3106**<br />
Function: Required to move sys databases<br />
Link: None


**Trace Flag: 3111**<br />
Function: Cause LogMgr::ValidateBackedupBlock to be skipped during backup and restore operation<br />
Link: None


**Trace Flag: 3117**<br />
Function: QL 9 - SQL Server 2005 tries to restore the log files and the data files in a single step which some third-party snapshot backup utilities do not support. Turing on 3117 does things the SQL 8 way multiple-step restore process.<br />
Link: https://support.microsoft.com/en-us/kb/915385


**Trace Flag: 3205**<br />
Function: Disable HW compression for backup to tape drives<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 3213**<br />
Function: Output buffer info for backups to ERRORLOG<br />
Link: http://sqlcat.com/sqlcat/b/technicalnotes/archive/2008/04/21/tuning-the-performance-of-backup-compression-in-sql-server-2008.aspx


**Trace Flag: 3222**<br />
Function: Disables the read ahead that is used by the recovery operation during roll forward operations<br />
Link: [TECHNET List Of SQL Server Trace Flags]


**Trace Flag: 3226**<br />
Function: Turns off ”Backup Successful” messages in errorlog<br />
Link: [MSDN ms188396]<br />
Scope: global

*Thanks to: @lwiederstein (https://twitter.com/lwiederstein)*


**Trace Flag: 3422**<br />
Function: Log record auditing<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx


**Trace Flag: 3231**<br />
Function: SQL 8/9 - Will turn the NO_LOG and TRUNCATE_ONLY options into no-ops in FULL/BULK_LOGGED recovery mode, and will clear the log in SIMPLE recovery mode. When set, BACKUP LOG with TRUNCATE_ONLY and BACKUP LOG with NO_LOG do not allow a log backup to run if the database's recovery model is FULL or BULK_LOGGED.<br />
Link: None


**Trace Flag: 3282**<br />
Function: SQL 6.5 - Used after backup restoration fails<br />
Link: https://support.microsoft.com/en-us/kb/215458


**Trace Flag: 3400**<br />
Function: Prints the recovery timings<br />
Link: None


**Trace Flag: 3422**<br />
Function: Cause auditing of transaction log records as they're read (during transaction rollback or log recovery).
This is useful because there is no equivalent to page checksums for transaction log records and so no way to detect whether log records are being corrupted e careful with these trace flags - I don't recommend using them unless you are experiencing corruptions that you can't diagnose. Turning them on will cause a big CPU hit because of the extra auditing that's happening.<br />
Link: https://support.microsoft.com/en-us/kb/215458


**Trace Flag: 3502**<br />
Function: Writes info about checkpoints to teh errorlog<br />
Link: http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf


**Trace Flag: 3503**<br />
Function: Indicates whether the checkpoint at the end of automatic recovery was skipped for a database (this applies only to read-only databases)<br />
Link: http://www.sql-server-performance.com/2002/traceflags/


**Trace Flag: 3504**<br />
Function: For internal testing. Will raise a bogus log-out-of-space condition from checkpoint<br />
Link: None


**Trace Flag: 3505**<br />
Function: Disables automatic checkpointing<br />
Link: http://support.microsoft.com/kb/815436


**Trace Flag: 3601**<br />
Function: Stack trace when error raised. Also see 3603.<br />
Link: None


**Trace Flag: 3602**<br />
Function: Records all error and warning messages sent to the client<br />
Link: None


**Trace Flag: 3603**<br />
Function: SQL Server fails to install on tricore, Bypass SMT check is enabled, flags are added via registry. Also see 3601.<br />
Link: None


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
Link: [MSDN ms188396]


**Trace Flag: 3609**<br />
Function: Do not create tempdb at startup<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/


**Trace Flag: 3610**<br />
Function: SQL 9 - Divide by zero to result in NULL instead of error<br />
Link: None


**Trace Flag: 3625**<br />
Function: Masks some error messages<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 3626**<br />
Function: Turns on tracking of the CPU data for the sysprocesses table.<br />
Link: None


**Trace Flag: 3635**<br />
Function: Print diagnostic information. Trace Flag 3635 Diagnostics are written to the console that started it.
There are not written to the errorlog, even if 3605 is turned on.<br />
Link: None


**Trace Flag: 3640**<br />
Function: Eliminates sending DONE_IN_PROC messages to client for each statement in stored procedure. This is similar to the session setting of SET NOCOUNT ON, but when set as a trace flag, every client session is handled this way.<br />
Link: None


**Trace Flag: 3654**<br />
Function:Allocations to stack<br />
Link: None


**Trace Flag: 3656**<br />
Function: Enables resolve of all call stacks in extended events<br />
Link: http://sqlcat.com/sqlcat/b/msdnmirror/archive/2010/05/11/resolving-dtc-related-waits-and-tuning-scalability-of-dtc.aspx


**Trace Flag: 3659**<br />
Function: Enables logging all errors to error log during server startup<br />
Link: http://spaghettidba.com/2011/05/20/trace-flag-3659/


**Trace Flag: 3688**<br />
Function: Removes messages to error log about traces started and stopped<br />
Link: http://support.microsoft.com/kb/922578/en-us


**Trace Flag: 3689**<br />
Function: Logs extended errors to errorlog when network disconnect occurs, turned off by default. Will dump out the socket error code this can sometimes give you a clue as to the root cause.<br />
Link: http://support.microsoft.com/kb/922578/en-us


**Trace Flag: 3801**<br />
Function: Prohibits use of USE DB statement<br />
Link: None


**Trace Flag: 3913**<br />
Function: SQL 7/8 - SQL Server does not update the rowcnt column of the sysindexes system table until the transaction is committed. When turned on the optimizer gets row count information from in-memory metadata that is saved to sysindexes system table when the transaction commits.<br />
Link: None


**Trace Flag: 3923**<br />
Function: Let SQL Server throw an exception to the application when the 3303 warning message is raised<br />
Link: https://support.microsoft.com/kb/3014867/en-us


**Trace Flag: 4001**<br />
Function: Very verbose logging of each login attempt to the error log. Includes tons of information<br />
Link: None


**Trace Flag: 4010**<br />
Function: Allows only shared memory connections to the SQL Server. Meaning, you will only be able to connect from the server machine itself. Client connections over TCP/IP or named pipes will not happen.<br />
Link: None


**Trace Flag: 4013**<br />
Function: Log each new connection the error log<br />
Link: http://sqlkbs.blogspot.se/2008/01/trace-flag.html


**Trace Flag: 4020**<br />
Function: Boot without recover<br />
Link: None


**Trace Flag: 4022**<br />
Function: Bypass Startup procedures<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2012-cu1-upgrade-step--msdb110_upgrade-sql--encountered-error-547.aspx


**Trace Flag: 4029**<br />
Function: Logs extended errors to errorlog when network disconnect occurs, turned off by default. Will dump out the socket error code this can sometimes give you a clue as to the root cause.<br />
Link: None


**Trace Flag: 4030**<br />
Function: Prints both a byte and ASCII representation of the receive buffer. Used when you want to see what queries a client is sending to SQL Server. You can use this trace flag if you experience a protection violation and want to determine which statement caused it. Typically, you can set this flag globally or use SQL Server Enterprise Manager. You can also use DBCC INPUTBUFFER.<br />
Link: None


**Trace Flag: 4031**<br />
Function: Prints both a byte and ASCII representation of the send buffers (what SQL Server sends back to the client). You can also use DBCC OUTPUTBUFFER.<br />
Link: None


**Trace Flag: 4032**<br />
Function: Traces the SQL commands coming in from the client. When enabled with 3605 it will direct those all to the error log.<br />
Link: None


**Trace Flag: 4044**<br />
Function: SA account can be unlocked by rebooting server with trace flag. If sa (or sso_role) password is lost, add this to your RUN_serverfile. This will generate new password when server started.<br />
Link: None


**Trace Flag: 4052**<br />
Function: SQL 9+ Prints TDS packets sent to the client (output) to console. Startup only.<br />
Link: None


**Trace Flag: 4055**<br />
Function: SQL 9+ Prints TDS packets received from the client to console. Startup only.<br />
Link: None


**Trace Flag: 4102**<br />
Function: SQL 9 - Query performance is slow if the execution plan of the query contains semi join operators Typically, semi join operators are generated when the query contains the IN keyword or the EXISTS keyword. Enable flag 4102 and 4118 to overcome this.<br />
Link: https://support.microsoft.com/en-us/kb/940128


**Trace Flag: 4104**<br />
Function: SQL 9 - Overestimating cardinality of JOIN operator. When additional join predicates are involved, this problem may increase the estimated cost of the JOIN operator to the point where the query optimizer chooses a different join order. When the query optimizer chooses a different join order, SQL 9 system performance may be slow.<br />
Link: https://support.microsoft.com/en-us/kb/920346


**Trace Flag: 4107**<br />
Function: SQL 9 - When you run a query that references a partitioned table, query performance may decrease<br />
Link: https://support.microsoft.com/en-us/kb/923849


**Trace Flag: 4116**<br />
Function: SQL 9 - Query runs slowly when using joins between a local and a remote table<br />
Link: https://support.microsoft.com/en-us/kb/950880


**Trace Flag: 4121**<br />
Function: SQL 9 - Query that involves an outer join operation runs very slowly. However, if you use the FORCE ORDER query hint in the query, the query runs much faster. Additionally, the execution plan of the query contains the following text in the Warnings column: NO JOIN PREDICATE.<br />
Link: None


**Trace Flag: 4123**<br />
Function: Query that has many outer joins takes a long time to compile in SQL Server 2005<br />
Link: https://support.microsoft.com/en-us/kb/943060


**Trace Flag: 4125**<br />
Function: SQL 9 - Query may take more time to finish if using an inner join to join a derived table that uses DISTINCT keyword<br />
Link: https://support.microsoft.com/en-us/kb/949854


**Trace Flag: 4127**<br />
Function: SQL 9 - Compilation time of some queries is very long in an x64-based version.
Basically its more than execution time because more memory allocations are necessary in the compilation process.<br />
Link: https://support.microsoft.com/en-us/kb/953569


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
Function: Fixes performance problems with certain queries that use TOP statement<br />
Link: http://support.microsoft.com/kb/2667211


**Trace Flag: 4139**<br />
Function: Fix for poor cardinality estimation when the ascending key column is branded as stationary<br />
Link : https://support.microsoft.com/en-us/kb/2952101


**Trace Flag: 4199**<br />
Function: Turn on all optimizations<br />
Link: http://www.sqlservice.se/sv/start/blogg/one-trace-flag-to-rule-them-all.aspx<br />
Link: https://msdn.microsoft.com/en-us/library/bb510411.aspx#TraceFlag<br />
Link: https://support.microsoft.com/en-us/kb/974006<br />
Scope: global or session


**Trace Flag: 4606**<br />
Function: Over comes SA password by startup. Disables password policy check during server startup.<br />
Link: https://support.microsoft.com/en-us/kb/936892


**Trace Flag: 4610**<br />
Function: When you use trace flag 4618 together with trace flag 4610, the number of entries in the cache store is limited to 8,192. When the limit is reached, SQL 2005 removes some entries from the TokenAndPermUserStore cache store.<br />
Link: https://support.microsoft.com/en-us/kb/959823


**Trace Flag: 4612**<br />
Function: Disable the ring buffer logging - no new entries will be made into the ring buffer<br />
Link: None


**Trace Flag: 4613**<br />
Function: Generate a minidump file whenever an entry is logged into the ring buffer<br />
Link: None


**Trace Flag: 4614**<br />
Function: Enables SQL Server authenticated logins that use Windows domain password policy enforcement to log on to the instance even though the SQL Server service account is locked out or disabled on the Windows domain controller.<br />
Link: https://support.microsoft.com/en-us/kb/925744


**Trace Flag: 4616**<br />
Function: Makes server-level metadata visible to application roles.
In SQL Server, an application role cannot access metadata outside its own database because application roles are not associated with a server-level principal. This is a change of behavior from earlier versions of SQL Server. Setting this global flag disables the new restrictions, and allows for application roles to access server-level metadata.<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 4618**<br />
Function: Limits number of entries per user cache store to 1024.
It may incur a small CPU overhead as when removing old cache entries when new entries are inserted.
It performs this action to limit the size of the cache store growth. However, the CPU overhead is spread over time.<br />
Link: https://support.microsoft.com/en-us/kb/933564


**Trace Flag: 4621**<br />
Function: SQL 9 – After 4610 & 4618 you can still customize the quota for TokenAndPermUserStore cache store that is based on the current workload<br />
Link: https://support.microsoft.com/en-us/kb/959823


**Trace Flag: 5101**<br />
Function: Forces all I/O requests to go through engine 0.
This removes the contention between processors but could create a bottleneck if engine 0 becomes busy with non-I/O tasks.<br />
Link: None


**Trace Flag: 5102**<br />
Function: Prevents engine 0 from running any non-affinitied tasks.<br />
Link: None


**Trace Flag: 5302**<br />
Function: Alters default behavior of select…INTO (and other processes) that lock system tables for the duration of the transaction.
This trace flag disables such locking during an implicit transaction.<br />
Link: None


**Trace Flag: 6498**<br />
Function: Increased query compilation scalability in SQL Server 2014<br />
Link: https://support.microsoft.com/en-us/kb/3024815<br />
Link: http://blogs.msdn.com/b/sql_server_team/archive/2015/10/09/query-compile-big-gateway-policy-changes-in-sql-server.aspx


**Trace Flag: 6527**<br />
Function: Disables generation of a memory dump on the first occurrence of an out-of-memory exception in CLR integration.
By default, SQL Server generates a small memory dump on the first occurrence of an out-of-memory exception in the CLR.
The behaviour of the trace flag is as follows: If this is used as a startup trace flag, a memory dump is never generated.
However, a memory dump may be generated if other trace flags are used.
If this trace flag is enabled on a running server, a memory dump will not be automatically generated from that point on.
However, if a memory dump has already been generated due to an out-of-memory exception in the CLR, this trace flag will have no effect.<br />
Link: [MSDN ms188396]<br />
Scope: global


**Trace Flag: 6533**<br />
Function: Spatial performance improvements in SQL Server 2012 and 2014<br />
Link: https://support.microsoft.com/en-us/kb/3107399


**Trace Flag: 6534**<br />
Function: This fix updates the sorting algorithm to include angular vectorization techniques that significantly improve the LineString performance<br />
Link: https://support.microsoft.com/en-us/kb/3054180<br />
Link: https://blogs.msdn.microsoft.com/bobsql/2016/06/03/sql-2016-it-just-runs-faster-native-spatial-implementations/


**Trace Flag: 7103**<br />
Function: Disable table lock promotion for text columns<br />
Link: https://support.microsoft.com/en-us/kb/230044


**Trace Flag: 7300**<br />
Function: Outputs extra info about linked server errors<br />
Link: http://support.microsoft.com/kb/314530


**Trace Flag: 7470**<br />
Function: Fix for sort operator spills to tempdb in SQL Server 2012 or SQL Server 2014 when estimated number of rows and row size are correct<br />
Link: https://support.microsoft.com/en-us/kb/3088480


**Trace Flag: 7471**<br />
Function: Running multiple UPDATE STATISTICS for different statistics on a single table concurrently<br />
Link: https://support.microsoft.com/en-us/kb/3156157<br />
Link: http://sqlperformance.com/2016/05/sql-performance/parallel-rebuilds


**Trace Flag: 7501**<br />
Function: Dynamic cursors are used by default on forward-only cursors.
Dynamic cursors are faster than in earlier versions and no longer require unique indexes.
This flag disables the dynamic cursor enhancements and reverts to version 6.0 behavior.<br />
Link: https://support.microsoft.com/en-us/kb/152032


**Trace Flag: 7502**<br />
Function: Disable cursor plan caching for extended stored procedures<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/


**Trace Flag: 7505**<br />
Function: Enables version 6.x handling of return codes when calling dbcursorfetchex and the resulting cursor position follows the end of the cursor result set<br />
Link: None


**Trace Flag: 7525**<br />
Function: SQL 8 - Reverts to ver 7 behavior of closing nonstatic cursors regardless of the SET CURSOR_CLOSE_ON_COMMIT state<br />
Link: None


**Trace Flag: 7601**<br />
Function: Helps in gathering more information in full text search by turning on full text tracing which gathers information on indexing process using the error log. Also 7603, 7604, 7605 trace flags.<br />
Link: None


**Trace Flag: 7608**<br />
Function: Performance fix for slow full text population with a composite clustered index<br />
Link: https://support.microsoft.com/en-us/kb/938672


**Trace Flag: 7613**<br />
Function: SQL 9 - Search results are missing when performing a full-text search operation on Win SharePoint Services 2.0 site after upgrading<br />
Link: https://support.microsoft.com/en-us/kb/927643


**Trace Flag: 7614**<br />
Function: SQL 9 - Full-text index population for the indexed view is very slow<br />
Link: https://support.microsoft.com/en-us/kb/928537


**Trace Flag: 7646**<br />
Function: SQL 10 - Avoids blocking when using full text indexing. An issue we experienced that full text can be slow when there is a high number of updates to the index and is caused by blocking on the docidfilter internal table.<br />
Link: None


**Trace Flag: 7806**<br />
Function: SQL 9 - Enables a dedicated administrator connection on SQL Express, DAC resources are not reserved by default<br />
Link: [MSDN ms188396]<br />
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


**Trace Flag: 8004**<br />
Function: SQL server to create a mini-dump once you enable 2551 and a out of memory condition is hit<br />
Link: None


**Trace Flag: 8010**<br />
Function: Fixes problem that SQL Server services can not be stopped<br />
Link: http://support.microsoft.com/kb/2633271/en-us


**Trace Flag: 8011**<br />
Function: Disable the ring buffer for Resource Monitor<br />
Link: http://support.microsoft.com/kb/920093<br />
Scope: global


**Trace Flag: 8012**<br />
Function: Disable the ring buffer for schedulers<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8015**<br />
Function: Ignore NUMA functionality<br />
Link: https://support.microsoft.com/en-us/kb/948450<br />
Link: http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html

*Thanks to: @sql\_handle (https://twitter.com/sql_handle)*


**Trace Flag: 8017**<br />
Function: Upgrade version conflict<br />
Link: http://social.msdn.microsoft.com/Forums/eu/sqlexpress/thread/dd6fdc16-9d8d-4186-9549-85ba4c322d10<br />
Link: http://connect.microsoft.com/SQLServer/feedback/details/407692/indicateur-de-trace-8017-reported-while-upgrading-from-ssee2005-to-ssee2008


**Trace Flag: 8018**<br />
Function: Disable the exception ring buffer<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8019**<br />
Function: Disable stack collection for the exception ring buffer<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8020**<br />
Function: Disable working set monitoring<br />
Link: http://support.microsoft.com/kb/920093


**Trace Flag: 8021**<br />
Function: On some lower end hardware we used to get reported that each CPU has its own NUMA node.
This was usually incorrect and when we detected only a single CPU per NODE we would assume NO NUMA.
Trace flag 8021 disables this override.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2011/11/11/sql-server-clarifying-the-numa-configuration-information/


**Trace Flag: 8024**<br />
Function: When this TF is on, it affects the mini-dump generation logic for the 1788* errors:
"To capture a mini-dump, one of the following checks must also be met.
1. The non-yielding workers CPU utilization must be > 40 percent.
2. The SQL Server process is not starved for overall CPU resource utilization.
Additional check #1 is targeted at runaway CPU users. Additional check #2 is targeted
at workers with lower utilizations that are probably stuck in an API call or similar activity."<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]


**Trace Flag: 8026**<br />
Function: SQL Server will clear a dump trigger after generating the dump once<br />
Link: http://support.microsoft.com/kb/917825/en-us


**Trace Flag: 8030**<br />
Function: Fix for performance bug<br />
Link: http://support.microsoft.com/kb/917035<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-2005-slowing-down-after-a-while.aspx


**Trace Flag: 8032**<br />
Function: Alters cache limit settings<br />
Warning: Trace flag 8032 can cause poor performance if large caches make less memory available for other memory consumers, such as the buffer pool.<br />
Link: [MSDN ms188396]


**Trace Flag: 8033**<br />
Function: Alters cache limit settings<br />
Warning: SQL 9 - Disable the reporting of CPU Drift errors in the SQL Server error log like time stamp counter of CPU on scheduler id 1 is not synchronized with other CPUs.<br />
Link: None


**Trace Flag: 8038**<br />
Function: Will drastically reduce the number of context switches when running SQL 2005 or 2008<br />
Link: https://support.microsoft.com/en-us/kb/972767<br />
Link: http://forum.proxmox.com/threads/15844-Win7-x64-guest-with-SQLServer-2012-High-CPU-usage<br />
Link: [TECHNET List Of SQL Server Trace Flags]


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


**Trace Flag: 8049**<br />
Function: SQL 9+ Startup only – Allows use of 1ms times even when patched. Check 8038 for details.<br />
Link: https://support.microsoft.com/en-us/kb/972767


**Trace Flag: 8050**<br />
Function: Causes "optional" wait types (see the CSS article) to be excluded when querying sys.dm_os_wait_stats<br />
Link: https://blogs.msdn.microsoft.com/psssql/2009/11/02/the-sql-server-wait-type-repository/


**Trace Flag: 8606**<br />
Function: Show LogOp Trees<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 8612**<br />
Function: Add Extra Info to the Trees Output<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 8615**<br />
Function: Display the final memo structure<br />
Link: http://www.benjaminnevarez.com/2012/04/inside-the-query-optimizer-memo-structure/<br />
Link: http://www.somewheresomehow.ru/optimizer-part-3-full-optimiztion-optimization-search0/


**Trace Flag: 8619**<br />
Function: Show Applied Transformation Rules<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2013/02/06/incorrect-results-with-indexed-views.aspx<br />
Link: [Cardinality Estimation Framework 2014 First Look]


**Trace Flag: 8620**<br />
Function: Add memo arguments to trace flag 8619<br />
Link: [Query Optimizer Deep Dive - Part 4]


**Trace Flag: 8621**<br />
Function: Rule with resulting tree<br />
Link: [Query Optimizer Deep Dive - Part 4]


**Trace Flag: 8628**<br />
Function: When used with TF 8666, causes extra information about the transformation rules
applied to be put into the XML showplan.<br />
Link: http://www.queryprocessor.com/tf_8628/


**Trace Flag: 8202**<br />
Function: Used to replicate UPDATE as DELETE/INSERT pair at the publisher. i.e.
UPDATE commands at the publisher can be run as an "on-page DELETE/INSERT" or a "full DELETE/INSERT".
If the UPDATE command is run as an "on-page DELETE/INSERT," the Logreader send UDPATE command to the subscriber,
If the UPDATE command is run as a "full DELETE/INSERT," the Logreader send UPDATE as DELETE/INSERT Pair.
If you turn on trace flag 8202, then UPDATE commands at the publisher will be always send to the subscriber as DELETE/INSERT pair.<br />
Link: None


**Trace Flag: 8203**<br />
Function: Display statement and transaction locks on a deadlock error<br />
Link: None


**Trace Flag: 8206**<br />
Function: SQL 8 - Supports stored procedure execution with a user specified owner name for SQL Server subscribers or without owner qualification for heterogeneous subscribers<br />
Link: None


**Trace Flag: 8207**<br />
Function: Alters Transactional Replication behaviour of UPDATE statement<br />
Link: https://support.microsoft.com/en-us/kb/302341<br />
Link: [MSDN ms188396]


**Trace Flag: 8209**<br />
Function: Output extra information to error log regarding replication of schema changes in SQL Server Replication<br />
Link: http://support.microsoft.com/kb/916706/en-us


**Trace Flag: 8295**<br />
Function: Creates a secondary index on the identifying columns on the change tracking side table at enable time<br />
Link : https://social.msdn.microsoft.com/forums/sqlserver/en-US/00250311-7991-47b0-b788-7fae2e102254/trace-flag-8295<br />
Thanks to: Wilfred van Dijk


**Trace Flag: 8446**<br />
Function: Databases in SQL 8 do not have a Service Broker ID. If you restore these databases on SQL 9 by using the WITH NORECOVERY option, these databases will not be upgraded causing mirroring & log-shipping configurations to fail.<br />
Link: https://support.microsoft.com/en-us/kb/959008


**Trace Flag: 8501**<br />
Function: Writes detailed information about Ms-DTC context & state changes to the log<br />
Link: None


**Trace Flag: 8599**<br />
Function: Allows you to use a save-point within a distributed transaction<br />
Link: None


**Trace Flag: 8602**<br />
Function: Disable Query Hints<br />
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
Function: Set Cost Threshold for parallelism from 1 to 0<br />
Link: http://www.sqlservice.se/sv/start/blogg/enable-parallellism-for-specific-query.aspx


**Trace Flag: 8675**<br />
Function: Displays the query optimization phases for a specific optimization<br />
Link: http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/


**Trace Flag: 8679**<br />
Function: Prevents the SQL Server optimizer from using a Hash Match Team operator<br />
Link: None


**Trace Flag: 8687**<br />
Function: Prevents the SQL Server optimizer from using a Hash Match Team operator<br />
Link: None


**Trace Flag: 8690**<br />
**Undocumented trace flag**<br />
Function: Disable the spool on the inner side of nested loop.
Spools improve performance in majority of the cases. But it’s based on estimates.
Sometimes, this can be incorrect due to unevenly distributed or skewed data, causing slow performance.
But in vast majority of situations, you don’t need to manually disable spool with this trace flag.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2015/12/15/spool-operator-and-trace-flag-8690/<br />
Link: http://dba.stackexchange.com/questions/52552/index-not-making-execution-faster-and-in-some-cases-is-slowing-down-the-query


**Trace Flag: 8721**<br />
Function: Dumps information into the error log when AutoStat has been run<br />
Link: None


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


**Trace Flag: 8765**<br />
Function: Allows use of variable length data, from ODBC driver; fixes the issue of a field returning the wrong data length<br />
Link: None


**Trace Flag: 8780**<br />
Function: Give the optimizer more time to find a better plan<br />
Link: http://www.sqlservice.se/sv/start/blogg/sql-server-trace-flag--8780.aspx


**Trace Flag: 8783**<br />
Function: Allows DELETE, INSERT, and UPDATE statements to honor the SET ROWCOUNT ON setting when enabled<br />
Link: None


**Trace Flag: 8809**<br />
Function: Extended Page Heap Activities.
Referenced in passing in the CSS article in relation to debugging memory scribbler problems.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/11/12/how-can-reference-counting-be-a-leading-memory-scribbler-cause/


**Trace Flag: 8816**<br />
Function: Logs every two-digit year conversion to a four-digit year<br />
Link: None


**Trace Flag: 9024**<br />
Function: Performance fix for AlwaysON log replication<br />
Link: http://support.microsoft.com/kb/2809338/en-us
Related to: 8048


**Trace Flag: 9130**<br />
Function: Disables the particular copy out stage rewrite from Filter + (Scan or Seek) to (Scan or Seek) + Residual Predicate.
Enabling this flag retains the Filter in the final execution plan, resulting in a SQL Server 2008+ plan that mirrors the 2005 version.<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2012/10/15/cardinality-estimation-bug-with-lookups-in-sql-server-2008-onward.aspx<br />
Link: http://sqlblogcasts.com/blogs/sqlandthelike/archive/2012/12/06/my-new-favourite-traceflag.aspx<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2013/06/11/hello-operator-my-switch-is-bored.aspx<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/767395/cardinality-estimation-error-with-pushed-predicate-on-a-lookup


**Trace Flag: 9453**<br />
Function: Disables Batch Mode in Parallel Columnstore query plans.
(Note that a plan using batch mode appears to require a recompile before the TF takes effect)
Sunil Agarwal also used this trace flag in demo scripts for a PASS 2014 session on column store indexing<br />
Link: http://www.nikoport.com/2014/07/24/clustered-columnstore-indexes-part-35-trace-flags-query-optimiser-rules/


**Trace Flag: 9059**<br />
Function: SQL 8 - Turns back behavior to SP3 after a SP4 installation, this allows to choose an index seek when comparing numeric columns or numeric constants that are of different precision or scale; else would have to change schema/code.<br />
Link: None


**Trace Flag: 9082**<br />
Function: SQL 9 - Stored procedure using views, perform slow compared to ver 8 if views use JOIN operator and contain sub queries<br />
Link: https://support.microsoft.com/en-us/kb/942906


**Trace Flag: 9130**<br />
Function: When you performing tuning or execution plan analysis if things are a little unclear as it might just help<br />
Link: http://www.theboreddba.com/Categories/FunWithFlags/Revealing-Predicates-in-Execution-Plans-(TF-9130).aspx


**Trace Flag: 9134**<br />
Function: SQL 8 - Does additional reads to test if the page is allocated & linked correctly this checks IAM & PFS. Fixes error 601 for queries under Isolation level read uncommitted. In case performance is affected (because of a bug) apply SP4.<br />
Link: None


**Trace Flag: 9185**<br />
Function: Cardinality estimates for literals that are outside the
histogram range are very low<br />
Link: https://support.microsoft.com/en-us/kb/kbview/833406
Related to: 9205


**Trace Flag: 9204**<br />
Function: Output Statistics used by Query Optimizer. When enabled and a plan is compiled or recompiled there is a listing of statistics which is being fully loaded & used to produce cardinality and distribution estimates for some plan alternative or other.<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx<br />
Related to: 9292


**Trace Flag: 9205**<br />
Function: Cardinality estimates for literals that are outside the histogram range are very low for tables that have parent-child relationships<br />
Link: https://support.microsoft.com/en-us/kb/kbview/833406<br />
Related to: 9185


**Trace Flag: 9207**<br />
Function: Fixes that SQL Server underestimates the cardinality of a query expression and query performance may be slow<br />
Link: https://support.microsoft.com/en-us/kb/831302


**Trace flag: 9259**<br />
Function: SQL 9/10 - An access violation occurs on running a query marked by the following message and a dump in the log folder: KB 970279 / 971490. Msg 0, Level 11, State 0, Line 0 - A severe error occurred on the current command. The results, if any, should be discarded.<br />
Link: None


**Trace flag: 9268**<br />
Function: SQL 8 - When SQL Server runs a parameterized query that contains several IN clauses, each with a large number of values, SQL Server may return the following error message after a minute or more of high CPU utilization: KB 325658. Server: Msg 8623, Level 16, State 1. Internal Query Processor Error: The query processor could not produce a query plan. Contact your primary support provider for more information.<br />
Link: None


**Trace Flag: 9292**<br />
Function: Output Statistics considered to be used by Query Optimizer<br />
Link: http://sqlblog.com/blogs/paul_white/archive/2011/09/21/how-to-find-the-statistics-used-to-compile-an-execution-plan.aspx<br />
Related to: 9204


**Trace Flag: 9347**<br />
Function: Disable batch mode sorted by session<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: https://support.microsoft.com/en-us/kb/3172787


**Trace Flag: 9349**<br />
Function: Disables batch mode top sort operator. SQL Server 2016 introduces a new batch mode top sort operator that boosts performance for many analytical queries.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: [MSDN ms188396]


**Trace Flag: 9358**<br />
Function: Disable batch mode sort operations in a complex parallel query. For example, this flag could apply if the query contains merge join operations.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: https://support.microsoft.com/en-us/kb/3171555


**Trace Flag: 9389**<br />
Function: Enables dynamic memory grant for batch mode operators. If a query does not get all the memory it needs, it spills data to tempdb, incurring additional I/O and potentially impacting query performance.
If the dynamic memory grant trace flag is enabled, a batch mode operator may ask for additional memory and avoid spilling to tempdb if additional memory is available.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: [MSDN ms188396]


**Trace Flag: 9453**<br />
Function: If, when querying TransactionsCS or TransactionsDCS, for troubleshooting purposes you want SQL Server to not consider using batch processing, you can use query trace flag 9453 by adding the following at the end of the query: OPTION (QUERYTRACEON 9453).<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]<br />
Link: http://sqlmag.com/sql-server/what-you-need-know-about-batch-mode-window-aggregate-operator-sql-server-2016-part-1


**Trace Flag: 9481**<br />
Function: Enables you to set the query optimizer cardinality estimation model to the SQL Server 2012 and earlier version independent of the compatibility level of the database. For more information, see Microsoft Support article. To accomplish this at the database level, see ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL). To accomplish this at the query level, add the QUERYTRACEONquery hint<br />
Link: http://support.microsoft.com/kb/2801413
Link: [MSDN ms188396]


**Trace Flag: 9485**<br />
Function: Disables SELECT permission for DBCC SHOW\_STATISTICS<br />
Link: https://support.microsoft.com/en-us/kb/2683304<br />
Link: [MSDN ms188396]


**Trace Flag: 9532**<br />
Function: SQL 11 CTP3 - to get more than 1 availability group replica in CTP3 Scope Startup<br />
Link: http://connect.microsoft.com/SQLServer/feedback/details/682581/denali-hadron-read-only-routing-url-is-not-yet-implemente


**Trace Flag: 9567**<br />
Function: Enables compression of the data stream for availability groups during automatic seeding.
Compression can significantly reduce the transfer time during automatic seeding and will increase the load on the processor.<br />
Link: [MSDN ms188396]


**Trace Flag: 9592**<br />
Function: Enables log stream compression for synchronous availability groups.
This feature is disabled by default on synchronous availability groups because compression adds latency.<br />
Link: [MSDN ms188396]


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
Link: https://web.archive.org/web/20160327221828/http://speedysql.com/2015/10/28/new-trace-flag-for-in-memory-oltp-hekaton/


**Trace Flag: 9851**<br />
**Undocumented trace flag**<br />
Function: For testing purposes, you might want to turn off automatic merging of files, so that you can more readily
explore this metadata. You can do that by turning on the undocumented trace flag 9851. And of course,
be sure to turn off the trace flag when done testing.<br/>
Link: http://gsl.azurewebsites.net/Portals/0/Users/dewitt/talks/HekatonWhitePaper.pdf


**Trace Flag: 10204**<br />
Function: Disables merge/recompress during columnstore index reorganization.
In SQL Server 2016, when a columnstore index is reorganized, there is new functionality to automatically merge any small compressed rowgroups into larger compressed rowgroups, as well as recompressing any rowgroups that have a large number of deleted rows.
Note: Trace flag 10204 does not apply to column store indexes which are created on memory-optimized tables.<br />
Link: [MSDN ms188396]


[MSDN ms188396]:https://msdn.microsoft.com/en-us/library/ms188396.aspx
[Niko Neugebauer Columnstore Indexes – part 86]:http://www.nikoport.com/2016/07/29/columnstore-indexes-part-86-new-trace-flags-in-sql-server-2016/
[Niko Neugebauer Columnstore Indexes – part 35]:http://www.nikoport.com/2014/07/24/clustered-columnstore-indexes-part-35-trace-flags-query-optimiser-rules/
[Microsoft SQL Server 2005 TPC-C Trace Flags]:http://webcache.googleusercontent.com/search?q=cache:Nttlt2Dp8egJ:blogs.msmvps.com/gladchenko/2009/08/21/sql_trace_flags_tpc-c/+&cd=6&hl=en&ct=clnk&gl=ru
[Trace Flag 1228 and 1229]:http://www.sqlservercentral.com/Forums/Topic741825-146-1.aspx
[A Topical Collection of SQL Server Flags v6]:https://sqlcrossjoin.files.wordpress.com/2016/04/sqlcrossjoin_traceflagrepository_v6.pdf
[How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]:https://msdn.microsoft.com/en-us/library/cc917684.aspx
[Trace flags in sql server from trace flag 902 to trace flag 1462]:http://www.sqlserverf1.com/tag/sql-server-trace-flag-1448/
[TECHNET List Of SQL Server Trace Flags]:http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx
[Cardinality Estimation Framework 2014 First Look]:http://www.somewheresomehow.ru/cardinality-estimation-framework-2014-first-look/
[Query Optimizer Deep Dive - Part 4]:http://sqlblog.com/blogs/paul_white/archive/2012/05/01/query-optimizer-deep-dive-part-4.aspx
