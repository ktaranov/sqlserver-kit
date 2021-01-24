# Microsoft SQL Server Trace Flags
Detailed list of all discovered (documented and undocumented) Microsoft SQL Server trace flags (**613** trace flags).

⚠ **REMEMBER: Be extremely careful with trace flags, test in your development environment first.
And consult professionals first if you are the slightest uncertain about the effects of your changes.**

⚠ **Some trace flags were introduced in specific SQL Server versions.
For more information on the applicable version, see the Microsoft Support article associated with a specific trace flag.**

⚠ **Trace flag behavior may not be supported in future releases of SQL Server.**

⚠ **[Azure SQL Database Managed Instance](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-managed-instance) supports the following global Trace Flags: [460](#460), [2301](#2301), [2389](#2389), [2390](#2390), [2453](#2453), [2467](#2467), [7471](#7471), [8207](#8207), [9389](#9389), [10316](#10316) and [11024](#11024).
Session trace-flags are not yet supported in Managed Instance.**

⚠ **[When specifying a trace flag with the `-T` option](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/database-engine-service-startup-options#list-of-startup-options), use an uppercase "**T**" to pass the trace flag number.
A lowercase "**t**" is accepted by SQL Server, but this sets other internal trace flags that are required only by SQL Server support engineers.
(Parameters specified in the Control Panel startup window are not read.)**

Headers:
 - [What are Microsoft SQL Server Trace Flags?](#what-are-microsoft-sql-server-trace-flags)
 - [How do I turn Trace Flags on and off?](#how-do-i-turn-trace-flags-on-and-off)
 - [How do I know what Trace Flags are turned on at the moment?](#how-do-i-know-what-trace-flags-are-turned-on-at-the-moment)
 - [What Are the Optimizer Rules?](#what-are-the-optimizer-rules)
 - [Remarks](#remarks)
 - [Unknown trace flags](#unknown-trace-flags)
 - [Recommended Trace Flags](#recommended-trace-flags)
 - [Trace flags list](#trace-flags-list)

Source links:
- [Docs Trace Flags]
- [A Topical Collection of SQL Server Flags](https://sqlcrossjoin.wordpress.com/2013/10/28/a-topical-collection-of-sql-server-flags/) (by Aaron Morelli)
- [Steinar Andersen great post](http://www.sqlservice.se/updated-microsoft-sql-server-trace-flag-list/)
- [Yusuf Anis trace flag table](http://www.sqlservercentral.com/articles/trace+flags/70131/)
- [Albert van der Sel TF list](http://antapex.org/traceflags_sqlserver.txt)
- [TECHNET List Of SQL Server Trace Flags]
- [Amit Banerjee TF list](http://troubleshootingsql.com/2012/07/01/sql-server-2008-trace-flags/)
- [Paul Randal discussing TF Pro’s and Con’s](http://www.sqlskills.com/blogs/paul/the-pros-and-cons-of-trace-flags/)
- [Enabling SQL Server Trace Flag for a Poor Performing Query Using QUERYTRACEON](https://www.mssqltips.com/sqlservertip/3320/enabling-sql-server-trace-flag-for-a-poor-performing-query-using-querytraceon/)
- [Disabling SQL Server Optimizer Rules with QUERYRULEOFF](https://www.mssqltips.com/sqlservertip/4175/disabling-sql-server-optimizer-rules-with-queryruleoff/)
- [SQLskills SQL101: Trace Flags](https://www.sqlskills.com/blogs/erin/sqlskills-101-trace-flags/)
- [Derik Hammer - Trace Flag Recommendation](http://www.sqlhammer.com/deriks-favorite-trace-flags/)
- [Brent Ozar - Bad Idea Jeans: Finding Undocumented Trace Flags](https://rebrand.ly/brent-finding-undocumented-trace-flags)
- [Joe Obbish - A Method to Find Trace Flags](https://rebrand.ly/joe-finding-undocumented-trace-flags)

**Great thanks to:**
- Aaron Morelli ([b](https://sqlcrossjoin.wordpress.com) | [@sqlcrossjoin](https://twitter.com/sqlcrossjoin))
- Steinar Andersen ([b](http://www.sqlservice.se/) | [@SQLSteinar](https://twitter.com/SQLSteinar))
- Brent Ozar ([b](https://www.brentozar.com/) | [@BrentO](https://twitter.com/BrentO))
- Yusuf Anis
- Lars Utterström
- Martin Höglund
- Håkan Winther
- Toine Rozemeijer
- Robert L Davis ([b](http://www.sqlsoldier.com/wp/) | [@SQLSoldier](https://twitter.com/SQLSoldier))
- Lonny Niederstadt ([b](http://sql-sasquatch.blogspot.ru/) | [@sql_handle](https://twitter.com/@sql_handle))
- Andrzej Kukuła
- Alexander Titenko ([gtihub](https://github.com/AlexTitenko))
- Albert van der Sel
- Amit Banerjee
- Erin Stellato ([b](http://www.sqlskills.com/blogs/erin/) | [@erinstellato](https://twitter.com/erinstellato))
- Darik Hammer ([b](http://www.sqlhammer.com/) | [@drayhammer](https://twitter.com/drayhammer))
- Erik Darling ([b](https://www.brentozar.com/archive/author/erik-darling/))
- Joe Obbish ([b](https://orderbyselectnull.com/))
- Glenn Berry ([b](https://sqlserverperformance.wordpress.com/) | [t](https://twitter.com/GlennAlanBerry))
- Pedro Lopes ([b](https://social.msdn.microsoft.com/profile/Pedro+Lopes+%28PL%29) | [t](https://twitter.com/sqlpto))
- Paul White ([b](https://www.sql.kiwi/) | [t](https://twitter.com/SQL_Kiwi))
- Alexey Nagorskiy ([github](https://github.com/fenixfx))
- Niko Neugebauer ([b](http://www.nikoport.com/) | [t](https://twitter.com/@NikoNeugebauer))
- Solomon Rutzky ([b](https://SqlQuantumLeap.com/) | [t](https://twitter.com/@SqlQuantumLeap))
- Jason Brimhall ([b](http://jasonbrimhall.info/) | [t](https://twitter.com/sqlrnnr))
- Victor Isakov ([b](https://victorisakov.wordpress.com/))
- Scott Caldwell ([b](https://blog.rdx.com/) | [t](https://twitter.com/sqldroid))
- Mike Fal ([b](http://www.mikefal.net) | [t](https://twitter.com/Mike_Fal))
- Prince Kumar Rastogi ([b](https://www.sqlservergeeks.com/author/princerastogi/) | [t](https://twitter.com/princerastogi2))
- Kendra Little ([b](http://www.littlekendra.com/) | [t](https://twitter.com/Kendra_Little))
- Slava Oks ([t](https://twitter.com/slava_oks/))
- John Sterrett ([b](https://www.procuresql.com/))
- Pavel Málek ([t](https://twitter.com/malekpav))
- Andrew Pruski ([b](https://dbafromthecold.com/) | [t](https://twitter.com/dbafromthecold))
- Josh Darnell ([b](https://joshthecoder.com/) | [t](https://twitter.com/josh_the_coder))
- Andrzej Kukula
- Aaron Bertrand ([b](https://sqlperformance.com/author/abertrand) | [t](https://twitter.com/AaronBertrand))
- Wilfred van Dijk


<a id="what-are-microsoft-sql-server-trace-flags"></a>
## What are Microsoft SQL Server Trace Flags?
Trace Flags are settings that in some way or another alters the behavior of various SQL Server functions: [Docs Trace Flags]

Trace flags are used to set specific server characteristics or to alter a particular behavior. For example, trace flag [3226](#3226) is a commonly used startup trace flag which suppresses successful backup messages in the error log.
Trace flags are frequently used to diagnose performance issues or to debug stored procedures or complex computer systems, but they may also be recommended by Microsoft Support to address behavior that is negatively impacting a specific workload.
All documented trace flags and those recommended by Microsoft Support are fully supported in a production environment when used as directed.
Note that trace flags in this list may have additional considerations regarding their particular usage, so it is advisable to carefully review all the recommendations given here and/or by your support engineer.
Also, as with any configuration change in SQL Server, it is always best to thoroughly test the flag in a non-production environment before deploying.


<a id="how-do-i-turn-trace-flags-on-and-off"></a>
## How do I turn Trace Flags on and off?
 - You can use the [DBCC TRACEON] and [DBCC TRACEOFF] commands
 - You can use the [-T option](https://docs.microsoft.com/sql/database-engine/configure-windows/database-engine-service-startup-options "Official Microsoft Docs Database Engine Service Startup Options Article") in the startup configuration for the SQL Server Service.
   **When specifying a trace flag with the `-T` option, use an uppercase `"T"` to pass the trace flag number. A lowercase `"t"` is accepted by SQL Server, but this sets other internal trace flags that are required only by SQL Server support engineers. (Parameters specified in the Control Panel startup window are not read.)**
 - You can also use the hint [QUERYTRACEON](https://support.microsoft.com/kb/2801413 "Official QUERYTRACEON KB Article") in your queries: **&lt;querytraceon_hint ::= {QUERYTRACEON trace_flag_number}>**


<a id="how-do-i-know-what-trace-flags-are-turned-on-at-the-moment"></a>
## How do I know what Trace Flags are turned on at the moment?
From SSMS 16 every sql plan content information about trace flags in section `Trace flags`.

You can use the [DBCC TRACESTATUS] command.

The following example displays the status of all trace flags that are currently enabled globally:
```tsql
DBCC TRACESTATUS(-1);
GO
```

The following example displays the status of trace flags 2528 and 3205:
```tsql
DBCC TRACESTATUS (2528, 3205);
GO
```

The following example displays whether trace flag 3205 is enabled globally:
```tsql
DBCC TRACESTATUS (3205, -1);
GO
```

The following example lists all the trace flags that are enabled for the current session:
```tsql
DBCC TRACESTATUS ();
GO
```


<a id="what-are-the-optimizer-rules"></a>
## What Are the Optimizer Rules?
We all know that every time SQL Server executes a query it builds an execution plan that translates the logical operations like joins and predicates into physical operations that are implemented in the SQL Server source code.
That conversion is based on certain rules known as the Optimizer Rules. They define for example how to perform an INNER JOIN.
When we write a simple select statement with an inner join, the query optimizer chooses based on statistics, indexes and enabled rules if the join is executed as a Merge Join, Nested Loop or a Hash Join and also if the join can use the commutative property of joins. Mathematically A join B is equal to B join A, but the computational cost generally is not the same.

### Getting the List of Available Rules
To obtain the list of rules of your version of SQL Server we must use the undocumented DBCC commands SHOWONRULES and SHOWOFFRULES.
Those commands display the enabled and disabled rules for the whole instance respectively. As you may guess, the number of rules varies amongst versions.

```tsql
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


<a id="remarks"></a>
## Remarks
There are three scopes at which trace flags can work: query, session, and global.
- Query trace flags are active for the context of a specific query
- Session trace flags are active for a connection and are visible only to that connection
- Global trace flags are set at the server level and are visible to every connection on the server.

Some flags can only be enabled as global, and some can be enabled at either global or session scope.

⚠ **Some `USE HINT` hints may conflict with trace flags enabled at the global or session level, or database scoped configuration settings. In this case, the query level hint (`USE HINT`) always takes precedence. If a `USE HINT` conflicts with another query hint, or a trace flag enabled at the query level (such as by [QUERYTRACEON]), SQL Server will generate an error when trying to execute the query.**

The following rules apply:
- A global trace flag must be enabled globally. Otherwise, the trace flag has no effect. We recommend that you enable global trace flags at startup, by using the `-T` command line option. This ensures the trace flag remains active after a server restart. Restart SQL Server for the trace flag to take effect.
- If a trace flag has either global, session or query scope, it can be enabled with the appropriate scope. A trace flag that is enabled at the session level never affects another session, and the effect of the trace flag is lost when the SPID that opened the session logs out.

Trace flags are set `ON` or `OFF` by using either of the following methods:
- Using the [DBCC TRACEON] and [DBCC TRACEOFF] commands.
For example, to enable the 2528 trace flag globally, use `DBCC TRACEON` with the `-1` argument: `DBCC TRACEON (2528, -1)`. The effect of enabling a global trace flag with `DBCC TRACEON` is lost on server restart. To turn off a global trace flag, use `DBCC TRACEOFF` with the `-1` argument.
- Using the `-T` startup option to specify that the trace flag be set on during startup.
The `-T` startup option enables a trace flag globally. You cannot enable a session-level trace flag by using a startup option. This ensures the trace flag remains active after a server restart. For more information about startup options, see [Database Engine Service Startup Options](https://github.com/MicrosoftDocs/sql-docs/blob/live/docs/database-engine/configure-windows/database-engine-service-startup-options.md).
- At the query level, by using the [QUERYTRACEON][KB2801413] query hint. The [QUERYTRACEON][KB2801413] option is only supported for Query Optimizer trace flags documented in the [Docs Trace Flags].  However, this option will not return any error or warning if an unsupported trace flag number is used. If the specified trace flag is not one that affects a query execution plan, the option will be silently ignored. 
More than one trace flag can be specified in the OPTION clause if `QUERYTRACEON` `trace_flag_number` is duplicated with different trace flag numbers.
Executing a query with the [QUERYTRACEON][KB2801413] option requires membership in the sysadmin fixed server role.
The [QUERYTRACEON][KB2801413] option can be used in [Plan Guides](https://docs.microsoft.com/en-us/sql/relational-databases/performance/plan-guides).

Use the [DBCC TRACESTATUS] command to determine which trace flags are currently active.


<a id="unknown-trace-flags"></a>
## Unknown trace flags
List of Unknown trace flags enabled on default Azure SQL Server instances, see more details here: [Azure SQL DB Managed Instances: Trace Flags, Ahoy!](https://www.brentozar.com/archive/2018/03/azure-sql-db-managed-instances-trace-flags-ahoy/)
If you know behavior some of them please open an issue or contact me (taranov.pro).

 - [ ] 2591
 - [ ] 3447 (but 3448 is there, which is supposed to help fix an issue with hung Mirrored databases)
 - [ ] 3978
 - [ ] 4141
 - [ ] 5521
 - [ ] 7838
 - [ ] 8037
 - [ ] 8054
 - [ ] 8057
 - [ ] 8063
 - [ ] 8065
 - [ ] 9041
 - [ ] 9537
 - [ ] 9570
 - [ ] 9883
 - [ ] 9905
 - [ ] 9934
 - [ ] 9940
 - [ ] 9941


<a id="recommended-trace-flags"></a>
## Recommended Trace Flags

 - [Trace Flag 272](#272) (for SQL Server 2012)
 - [Trace Flag 460](#460) (2017 for >= CU14, 2016 for >= SP2 CU6)
 - [Trace Flag 1118](#1118) (for versions < SQL Server 2016)
 - [Trace Flag 3023](#3023) (for versions < SQL Server 2014)
 - [Trace Flag 3226](#3226) (for all versions)
 - [Trace Flag 3427](#3427) (for SQL Server 2016)
 - [Trace Flag 3449](#3449) (for versions SQL Server 2012 SP3 CU3 or later or SQL Server 2014 SP1 CU7 or later)
 - [Trace Flag 6534](#6534) (for versions SQL Server 2012, 2014, 2016) (if use [spatial data types](https://docs.microsoft.com/sql/relational-databases/spatial/spatial-data-sql-server))
 - [Trace Flag 7412](#7412) (for versions >= SQL Server 2016)
 - [Trace Flag 7745](#7745) (for versions >= SQL Server 2016 and Query Store enabled)
 - [Trace Flag 7752](#7752) (for versions >= SQL Server 2016 and < 2019 and Query Store enabled)
 - [Trace Flag 7806](#7806) (for SQL Server Express Edition)
 - [Trace Flag 8099](#8099) (for versions >= 2019 CU2)

**Trace Flag 272** prevents identity gap after restarting SQL Server 2012 instance, critical for columns with identity and `tinyint` and `smallint` data types.
(Demo for repeating this issue [here](https://github.com/ktaranov/sqlserver-kit/Errors/Identity_gap_sql_server_2012.sql))

**Trace Flag 460** Replace error message [8152] with [2628] (`String or binary data would be truncated. The statement has been terminated.`).
Description for [2628] message has useful information - which column had the truncation and which row.<br />

**Trace flag 1118** addresses contention that can exist on a particular type of page in a database, the SGAM page.
This trace flag typically provides benefit for customers that make heavy use of the tempdb system database.
In SQL Server 2016, you change this behavior using the `MIXED_PAGE_ALLOCATION` database option, and there is no need for TF 1118.

**Trace flag 3023** is used to enable the CHECKSUM option, by default, for all backups taken on an instance.
With this option enabled, page checksums are validated during a backup, and a checksum for the entire backup is generated.
Starting in SQL Server 2014, this option can be set instance-wide through `sp_configure ('backup checksum default')`.

**Trace flag 3226** prevents the writing of successful backup messages to the SQL Server ERRORLOG.
Information about successful backups is still written to `msdb` and can be queried using T-SQL.
For servers with multiple databases and regular transaction log backups, enabling this option means the ERRORLOG is no longer bloated with BACKUP DATABASE and Database backed up messages.
As a DBA, this is a good thing because when I look in my ERRORLOG, I really only want to see errors, I don’t want to scroll through hundreds or thousands of entries about successful backups.

**Trace flag 3427** Another change in SQL Server 2016 behavior that could impact tempdb-heavy workloads has to do with Common Criteria Compliance (CCC), also known as C2 auditing.
We introduced functionality to allow for transaction-level auditing in CCC which can cause some additional overhead, particularly in workloads that do heavy inserts and updates in temp tables.
Unfortunately, this overhead is incurred whether you have CCC enabled or not. In SQL Server 2016 you can enable trace flag 3427 to bypass this overhead starting with SP1 CU2. Starting in SQL Server 2017 CU4, we automatically bypass this code if CCC is disabled.

**Trace flag 3449** (and you are on SQL Server 2012 SP3 CU3 or later or SQL Server 2014 SP1 CU7 or later),
will get much better performance by avoiding a FlushCache call in a number of different common scenarios, such as backup database,
backup transaction log, create database, add a file to a database, restore a transaction log, recover a database, shrink a database file, and a SQL Server “graceful” shutdown.

**Trace flag 6534** enables performance improvement of query operations with spatial data types in SQL Server 2012, SQL Server 2014 and SQL Server 2016.
The performance gain will vary, depending on the configuration, the types of queries, and the objects.

**Trace flag 7412** enables the lightweight query execution statistics profiling infrastructure.
Unless your server is already CPU bound, like you’re running all the time with 95% CPU, unless you are at that point, turn on this trace flag at any server you have.
This would be my advice here because this enables that lightweight profiling infrastructure there and then you’ll see in a few minutes what it unleashes here.
So one thing that happens when I enable the lightweight profiling is that the sys.dm_exec_query_profiles DMV, which is something that actually populates the live query stats ability or feature of SSMS, now also is also populated with this lightweight profiling, which means that for all essence, we are now able to run a live query stats on all fashions at any given point in time, and this is extremely useful for let’s say a production DBA that someone calls and says, “Hey, you have a problem.
To tap into running system and look at what it’s doing.”

**Trace flag 7745** forces Query Store to not flush data to disk on database shutdown.
Using this trace may cause Query Store data not previously flushed to disk to be lost in case of shutdown.
For a SQL Server shutdown, the command SHUTDOWN WITH NOWAIT can be used instead of this trace flag to force an immediate shutdown.

**Trace Flag: 7752** enables asynchronous load of Query Store.
Use this trace flag if SQL Server is experiencing high number of [QDS_LOADDB](https://www.sqlskills.com/help/waits/qds_loaddb/) waits related to Query Store synchronous load (default behavior).

**Trace Flag: 7806** enables a dedicated administrator connection ([DAC]) on SQL Server Express.

**Trace Flag: 8099** enables a spinlock contention fix for high-end systems running SQL Server 2019 (15.x) serving many concurrent users.


<a id="trace-flags-list"></a>
## Trace Flags List
Summary: **613 trace flags**


<a id="-1"></a>
#### Trace Flag: -1
Function: Sets trace flags for all client connections, rather than for a single client connection.
Because trace flags set using the -T command-line option automatically apply to all connections, this trace flag is used only when setting trace flags using [DBCC TRACEON] and [DBCC TRACEOFF].<br />
Link: http://www.sql-server-performance.com/2002/traceflags/


<a id="101"></a>
#### Trace Flag: 101
Function: Increases the verboseness of the merge replication agent logging.<br />
**IMPORTANT**: Trace flag 101 can only be enabled for the [Replication Merge Agent] using the `-T` option when executing `replmerg.exe` from the command prompt.<br />
**WARNING**: Trace flag 101 is not meant to be enabled continuously in a production environment, but only for time-limited troubleshooting purposes.<br />
Link: https://support.microsoft.com/kb/2892633<br />
Scope: Replication Merge Agent only


<a id="102"></a>
#### Trace Flag: 102
Function: Increases the verboseness of the merge replication agent logging and directs it to the `<Distribution server>..msmerge_history` table.<br />
**IMPORTANT**: Trace flag 102 can only be enabled for the pReplication Merge Agent[ using the `-T` option when executing `replmerg.exe` from the command prompt.
**WARNING**: Trace flag 102 is not meant to be enabled continuously in a production environment, but only for time-limited troubleshooting purposes.
Link: https://support.microsoft.com/kb/2892633<br />
Scope: Replication Merge Agent only


<a id="105"></a>
#### Trace Flag: 105
**Undocumented trace flag**<br />
Function: Join more than 16 tables in SQL server 6.5<br />
Link: [SQL Server 6.5: Some Useful Trace Flag]


<a id="106"></a>
#### Trace Flag: 106
Function: If you are using Web Synchronization, you can start Replmerg.exe and pass the -T 106 option to use trace flag 106.
This enables you to see the messages that are sent to and from the Publisher.
The agent writes the client's input messages to a file that is named ExchangeID(guid).IN.XML, and writes the output messages to a file that is named ExchangeID(guid).OUT.XML.
(In these file names, guid is the GUID of the Exchange Server session.)
These files are created in the directory from which Replmerg.exe was invoked.
For security, you should delete these files after you are finished.<br />
Link: http://technet.microsoft.com/en-us/library/ms151872(v=sql.105).aspx


<a id="107"></a>
#### Trace Flag: 107
**Undocumented trace flag**<br />
Function: SQL 6.5/7/8 – Interprets numbers with a decimal point as float instead of decimal<br />
Link: None


<a id="110"></a>
#### Trace Flag: 110
**Undocumented trace flag**<br />
Function: SQL 6.5 – Turns off ANSI select characteristics<br />
Link: None


<a id="120"></a>
#### Trace Flag: 120
**Undocumented trace flag**<br />
Function: FIX: Error message when you schedule a Replication Merge Agent job to run after you install SQL Server 2000 Service Pack 4: "The process could not enumerate changes at the 'Subscriber'"<br />
Link: None


<a id="139"></a>
#### Trace Flag: 139
Function: Forces correct conversion semantics in the scope of DBCC check commands like [DBCC CHECKDB], [DBCC CHECKTABLE] and [DBCC CHECKCONSTRAINTS], when analyzing the improved precision and conversion logic introduced with compatibility level 130 for specific data types, on a database that has a lower compatibility level.
**Note: This trace flag applies to SQL Server 2016 RTM CU3, SQL Server 2016 SP1 and higher builds.**<br />
**WARNING: Trace flag 139 is not meant to be enabled continuously in a production environment, and should be used for the sole purpose of performing database validation checks described in this Microsoft Support article.
It should be immediately disabled after validation checks are completed.**<br />
Link: https://support.microsoft.com/kb/4010261<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="144"></a>
#### Trace Flag: 144
Function: Force server side bucketization.
For legacy applications where change to client side code is not an option and
when the application has queries that are improperly parameterized, this trace flag forces server side bucketization.<br />
Link: http://blogs.msdn.microsoft.com/sqlprogrammability/2007/01/13/6-0-best-programming-practices


<a id="146"></a>
#### Trace Flag: 146
**Undocumented trace flag**<br />
Function: Consider using when replaying against SQL 8.0, to avoid an attempt to set an encrypted connection.<br />
Link: None


<a id="166"></a>
#### Trace Flag: 166
**Undocumented trace flag**<br />
Function: Unclear. Observable effect was to change the identifier for act1008 to act1009 in a query plan.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="168"></a>
#### Trace Flag: 168
Function: Bugfix in ORDER BY. This hotfix introduces trace flag 168. After you apply this hotfix, you must enable trace flag 168.
Trace flag 168 must be set before the database is migrated to SQL Server 2005.
If trace flag 168 is set after the database is migrated, the query result will remain unsorted.<br />
Link: https://support.microsoft.com/kb/926292


<a id="174"></a>
#### Trace Flag: 174
Function: Increases the SQL Server Database Engine plan cache bucket count from 40,009 to 160,001 on 64-bit systems.<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://support.microsoft.com/kb/3026083/<br />
Link: [Docs Trace Flags]<br />
Link: [SQL Server Plan Cache Limits]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="176"></a>
#### Trace Flag: 176
Function: Enables a fix to address errors when rebuilding partitions online for tables that contain a computed partitioning column.<br />
Link: https://support.microsoft.com/kb/3213683/<br />
Link: https://support.microsoft.com/kb/4541096/<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="204"></a>
#### Trace Flag: 204
Function: SQL 6.5 – Backward compatibility switch that enables non-ansi standard behavior.
E.g. previously SQL server ignored trailing blanks in the like statement and allowed queries that contained aggregated functions to have items in the group by clause that were not in the select list.<br />
Link: [KB153096]


<a id="205"></a>
#### Trace Flag: 205
Function: Reports to the error log when a statistics-dependent stored procedure is being recompiled as a result of auto-update statistics.<br />
Link: https://support.microsoft.com/kb/195565<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="206"></a>
#### Trace Flag: 206
**Undocumented trace flag**<br />
Function: SQL 6.5 – Provides backward compatibility for the set user statement. KB 160732<br />
Link: None


<a id="208"></a>
#### Trace Flag: 208
**Undocumented trace flag**<br />
Function: SET QUOTED IDENTIFIER ON<br />
Link: None


<a id="210"></a>
#### Trace Flag: 210
Function: SQL 9 – Error when you run a query against a view: "An error occurred while executing batch"<br />
Link: https://support.microsoft.com/kb/945892


<a id="212"></a>
#### Trace Flag: 212
**Undocumented trace flag**<br />
Function: SQL 9 – Query may run much slower when compared to SQL 8 when you use a cursor to run the query<br />
Link: None


<a id="220"></a>
#### Trace Flag: 220
**Undocumented trace flag**<br />
Function: “FIX: Error Message: "Insufficient key column information for updating" Occurs in SQL Server 2000 SP3”<br />
Link: None


<a id="221"></a>
#### Trace Flag: 221
**Undocumented trace flag**<br />
Function: “FIX: The query runs slower than you expected when you try to parse a query in SQL Server 2000”<br />
Link: None


<a id="222"></a>
#### Trace Flag: 222
**Undocumented trace flag**<br />
Function: “FIX: Each query takes a long time to compile when you execute a single query or when you execute multiple concurrent queries in SQL Server 2000”<br />
Link: None


<a id="237"></a>
#### Trace Flag: 237
**Undocumented trace flag**<br />
Function: Tells SQL Server to use correlated sub-queries in Non-ANSI standard backward compatibility mode<br />
Link: None


<a id="242"></a>
#### Trace Flag: 242
**Undocumented trace flag**<br />
Function: Provides backward compatibility for correlated subqueries where non-ANSI-standard results are desired<br />
Link: None


<a id="243"></a>
#### Trace Flag: 243
**Undocumented trace flag**<br />
Function: Provides backward compatibility for nullability behavior. When set, SQL Server has the same nullability violation behavior as that of a ver 4.2: Processing of the entire batch is terminated if the nullability error (inserting NULL into a NOT NULL field) can be detected at compile time; Processing of offending row is skipped, but the command continues if the nullability violation is detected at run time.Behavior of SQL Server is now more consistent because nullability checks are made at run time and a nullability violation results in the command terminating and the batch or transaction process continuing.<br />
Link: None


<a id="244"></a>
#### Trace Flag: 244
**Undocumented trace flag**<br />
Function: Disables checking for allowed interim constraint violations. By default, SQL Server checks for and allows interim constraint violations. An interim constraint violation is caused by a change that removes the violation such that the constraint is met, all within a single statement and transaction. SQL Server checks for interim constraint violations for self-referencing DELETE statements, INSERT, and multi-row UPDATE statements. This checking requires more work tables. With this trace flag you can disallow interim constraint violations, thus requiring fewer work tables.<br />
Link: None


<a id="246"></a>
#### Trace Flag: 246
**Undocumented trace flag**<br />
Function: Derived or NULL columns must be explicitly named in a select…INTO or create view statement when not done they raise an error. This flag avoids that.<br />
Link: None


<a id="253"></a>
#### Trace Flag: 253
**Undocumented trace flag**<br />
Function: Prevents ad-hoc query plans to stay in cache<br />
Link: http://www.sqlservercentral.com/Forums/Topic837613-146-1.aspx


<a id="257"></a>
#### Trace Flag: 257
**Undocumented trace flag**<br />
Function: Will invoke a print algorithm on the XML output before returning it to make the XML result more readable<br />
Link: None


<a id="260"></a>
#### Trace Flag: 260
Function: Prints versioning information about extended stored procedure dynamic-link libraries (DLLs).
When SQL Server is started with the trace flag `-T260` or if a user with system administrator privileges runs `DBCC TRACEON (260)`, and if the extended stored procedure DLL does not support `__GetXpVersion()`, a warning message (`Error 8131: Extended stored procedure DLL '%' does not export __GetXpVersion().`) is printed to the error log. (Note that `__GetXpVersion()` begins with **two underscores**.)<br />
Link: https://docs.microsoft.com/en-us/sql/relational-databases/extended-stored-procedures-programming/creating-extended-stored-procedures<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="262"></a>
#### Trace Flag: 262
**Undocumented trace flag**<br />
Function: SQL 7 – Trailing spaces are no longer truncated from literal strings in CASE statements<br />
Link: None


<a id="272"></a>
#### Trace Flag: 272
<a id="272"></a>
**Note: Recommended for SQL Server 2012**<br />
Function: Disabling the identity cache. It prevents identity gap after restarting SQL Server 2012 instance, critical for columns with identity and tinyint and smallint data types.<br />
Link: http://www.big.info/2013/01/how-to-solve-sql-server-2012-identity.html<br />
Link: https://web.archive.org/web/20160822054721/https://connect.microsoft.com/SQLServer/feedback/details/739013/failover-or-restart-results-in-reseed-of-identity<br />
Link: https://dbafromthecold.com/2017/05/24/disabling-the-identity-cache-in-sql-server-2017/<br />
Link: [Demo](https://github.com/ktaranov/sqlserver-kit/blob/master/Errors/Identity_gap_sql_server_2012.sql)<br />
Link: https://stackoverflow.com/q/14146148/2298061<br />
Scope: global only


<a id="274"></a>
#### Trace Flag: 274
**Undocumented trace flag**<br />
Function: “FIX: Error message when you insert a new row into a view in SQL Server 2005: Cannot insert explicit value for identity column in table <TableName> when IDENTITY_INSERT is set to OFF”<br />
Link: None


<a id="302"></a>
#### Trace Flag: 302
**Undocumented trace flag**<br />
Function: Output Index Selection info<br />
Link: [SQL Server 6.5: Some Useful Trace Flag]


<a id="304"></a>
#### Trace Flag: 304
**Undocumented trace flag**<br />
Function: Changed the reported CachedPlanSize.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="310"></a>
#### Trace Flag: 310
**Undocumented trace flag**<br />
Function: Outputs info about actual join order<br />
Link: [SQL Server 6.5: Some Useful Trace Flag]


<a id="320"></a>
#### Trace Flag: 320
**Undocumented trace flag**<br />
Function: Disables join-order heuristics used in ANSI joins. To see join-order heuristics use flag 310. SQL Server uses join-order heuristics to reduce of permutations when using the best join order. <br />
Link: None


<a id="323"></a>
#### Trace Flag: 323
Function: Outputs detailed info about updates<br />
Link: [SQL Server 6.5: Some Useful Trace Flag]<br />
Link: [KB153096]


<a id="325"></a>
#### Trace Flag: 325
**Undocumented trace flag**<br />
Function: Prints information about the cost of using a non-clustered index or a sort to process an ORDER BY clause<br />
Link: None


<a id="326"></a>
#### Trace Flag: 326
**Undocumented trace flag**<br />
Function: Prints information about estimated & actual costs of sorts. Instructs server to use arithmetic averaging when calculating density instead of a geometric weighted average when updating statistics. Useful for building better stats when an index has skew on the leading column. Use only for updating the stats of a table/index with known skewed data.<br />
Link: None


<a id="330"></a>
#### Trace Flag: 330
**Undocumented trace flag**<br />
Function: Enables full output when using the SET SHOWPLAN_ALL option, which gives detailed information about joins<br />
Link: None


<a id="342"></a>
#### Trace Flag: 342
**Undocumented trace flag**<br />
Function: Disables the costing of pseudo-merge joins, thus significantly reducing time spent on the parse for certain types of large, multi-table joins. One can also use SET FORCEPLAN ON to disable the costing of pseudo-merge joins because the query is forced to use the order specified in the FROM clause. <br />
Link: None


<a id="345"></a>
#### Trace Flag: 345
**Undocumented trace flag**<br />
Function: Changes join order selection logic in SQL Server 6.5<br />
Link: [SQL Server 6.5: Some Useful Trace Flag]


<a id="445"></a>
#### Trace Flag: 445
**Undocumented trace flag**<br />
Function: Prints ”compile issued” message in the errorlog for each compiled statement, when used together with 3605<br />
Link: None


<a id="460"></a>
#### Trace Flag: 460
Function: Replace error message ID [8152] with message ID [2628] (`String or binary data would be truncated. The statement has been terminated.`).
Description for [2628] message has useful information - which column had the truncation and which row.
Starting with SQL Server 2019 (15.x) CTP 2.4, to accomplish this at the database level, see the `VERBOSE_TRUNCATION_WARNINGS` option in [ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)].<br />
**Note: This trace flag applies to SQL Server 2017 (14.x) CU12 and higher builds.**<br />
**Note: Starting with database compatibility level 150, message ID [2628] is the default and this trace flag has no effect.**<br />
**Note: Don’t leave this trace flag enabled on global scope for SQL Server 2017 CU12 and CU13.**<br />
There’s at least one [bug](https://feedback.azure.com/forums/908035-sql-server/suggestions/36311467-traceflag-460-causing-truncation-errors-on-code-pa) on SQL Server 2017 CU13: table variables will throw errors saying their contents are being truncated even when no data is going into them.**<br />
Link: [Docs Trace Flags]<br />
Link: https://www.procuresql.com/blog/2018/09/26/string-or-binary-data-get-truncated/<br />
Link: https://feedback.azure.com/forums/908035-sql-server/suggestions/32908417-binary-or-string-data-would-be-truncated-error<br />
Link: https://blogs.msdn.microsoft.com/sql_server_team/string-or-binary-data-would-be-truncated-replacing-the-infamous-error-8152/<br />
Link: https://support.microsoft.com/kb/4468101<br />
Link: https://www.brentozar.com/archive/2019/03/how-to-fix-the-error-string-or-binary-data-would-be-truncated/<br />
Link: https://feedback.azure.com/forums/908035-sql-server/suggestions/36311467-traceflag-460-causing-truncation-errors-on-code-pa<br />
Link: https://support.microsoft.com/kb/4490142<br />
Scope: global or session<br />
SQL Server Version: >= 2017 CU12, >= 2016 SP2 CU6<br />
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_460.sql


<a id="506"></a>
#### Trace Flag: 506
**Undocumented trace flag**<br />
Function: Enforces SQL-92 standards regarding null values for comparisons between variables and parameters. Any comparison of variables and parameters that contain a NULL always results in a NULL.<br />
Link: None


<a id="610"></a>
#### Trace Flag: 610
Function: Controls minimally logged inserts into indexed tables.
This trace flag is not required starting SQL Server 2016 as minimal logging is turned on by default for indexed tables.
In SQL Server 2016, when the bulk load operation causes a new page to be allocated, all of the rows sequentially filling that new page are minimally logged if all the other pre-requisites for minimal logging are met.
Rows inserted into existing pages (no new page allocation) to maintain index order are still fully logged, as are rows that are moved as a result of page splits during the load.
It is also important to have `ALLOW_PAGE_LOCKS` turned `ON` for indexes (which is `ON` by default) for minimal logging operation to work as page locks are acquired during allocation and thereby only page or extent allocations are logged.<br />
Link: http://msdn.microsoft.com/en-us/library/dd425070%28v=SQL.100%29.aspx<br />
Link: https://www.pythian.com/blog/minimally-logged-operations-data-loads/<br />
Link: https://msdn.microsoft.com/library/dd425070.aspx<br />
Link: [Docs Trace Flags]<br />
Link: https://orderbyselectnull.com/2017/07/10/trace-flag-610-and-sql-server-2016/<br />
Scope: global or session


<a id="611"></a>
#### Trace Flag: 611
**Undocumented trace flag**<br />
Function: SQL 9 – When turned on, each lock escalation is recorded in the error log along with the SQL Server handle number.
Aaron confirmed this still works in SQL 2014. Outputs info of the form: "Escalated locks - Reason: LOCK_THRESHOLD, Mode: S, Granularity: TABLE, Table: 222623836,
HoBt: 150:256, HoBt Lock Count: 6248, Escalated Lock Count: 6249, Line Number: 1, Start Offset: 0, SQL Statement: select count(*) from dbo.BigTable"<br />
Link: None


<a id="617"></a>
#### Trace Flag: 617
Function: SQL 9 – When turned on, each lock escalation is recorded in the error log along with the SQL Server handle number.
As long as there are no SCH_M lock requests waiting in the ‘lock wait list’,
the ‘lock wait list’ will be bypassed by statements issued in uncommitted read transaction isolation level.
If there is a SCH_M lock request in the ‘lock wait list’, a query in uncommitted read transaction isolation level
will not bypass the ‘lock wait list’, but the SCH_S lock request will go into the ‘lock wait list’.
In order behind the SCH_M lock waiting in the same list. As a result the grant of the SCH_S request for such a query
is dependent on the grant and release of the SCH_M lock request entering the ‘lock wait list’ earlier.<br />
Link: https://blogs.msdn.microsoft.com/saponsqlserver/2014/01/17/new-functionality-in-sql-server-2014-part-3-low-priority-wait/


<a id="634"></a>
#### Trace Flag: 634
Function: Disables the background columnstore compression task. SQL Server periodically runs the Tuple Mover background task that compresses columnstore index rowgroups with uncompressed data, one such rowgroup at a time.
Columnstore compression improves query performance but also consumes system resources.
You can control the timing of columnstore compression manually, by disabling the background compression task with trace flag 634, and then explicitly invoking ALTER INDEX REORGANIZE or ALTER INDEX REBUILD at the time of your choice.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/trace-flag-634-disable-background-columnstore-compression/<br />
Link: [SQL Server 2019 Aggressive Clustered Columnstore Cleanup]<br />
Scope: global only


<a id="646"></a>
#### Trace Flag: 646
**Undocumented trace flag**<br />
Function: Serves for getting detailed information on which Columnstore were eliminated by the Query Optimiser right into the error log.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]<br />
Link: http://www.sqlskills.com/blogs/joe/exploring-columnstore-index-metadata-segment-distribution-and-elimination-behaviors<br />
Scope: global or session


<a id="647"></a>
#### Trace Flag: 647
Function: Avoids a new-in-SQL 2012 data check (done when adding a column to a table) that can cause ALTER TABLE... ADD <column> operations to take a very long time.
The KB has a useful query for determining the row size for a table.<br />
Link: https://support.microsoft.com/kb/2986423<br />


<a id="652"></a>
#### Trace Flag: 652
Function: Disable page pre-fetching scans.
If you turn on trace flag 652, SQL Server no longer brings database pages into the buffer pool before these database pages are consumed by the scans.
If you turn on trace flag 652, queries that benefit from the page pre-fetching feature exhibit low performance.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-652/<br />
Scope: global or session


<a id="653"></a>
#### Trace Flag: 653
**Undocumented trace flag**<br />
Function: Disables read ahead for the current connection<br />
Link: None


<a id="661"></a>
#### Trace Flag: 661
Function: Disables the ghost record removal process. A ghost record is the result of a delete operation.
When you delete a record, the deleted record is kept as a ghost record. Later, the deleted record is purged by the ghost record removal process.
When you disable this process, the deleted record is not purged. Therefore, the space that the deleted record consumes is not freed.
This behavior affects space consumption and the performance of scan operations. <br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: [Let’s talk about trace flags]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-661/<br />
Link: [SQL Server 2019 Aggressive Clustered Columnstore Cleanup]<br />
Scope: global or session


<a id="662"></a>
#### Trace Flag: 662
**Undocumented trace flag**<br />
Function: Prints detailed information about the work done by the ghost cleanup task when it runs next.
Use TF [3605](#3605) to see the output in the errorlog<br />
Link: http://blogs.msdn.com/b/sqljourney/archive/2012/07/28/an-in-depth-look-at-ghost-records-in-sql-server.aspx


<a id="669"></a>
#### Trace Flag: 669
Function: “...prevents user queries from queuing requests to the ghost cleanup process”. This flag is a workaround for stack dumps occurring right after SQL Server startup, where user queries (that queue pages for ghost cleanup) were running so quickly after SQL startup that they were queuing pages before the ghost cleanup process had actually initialized.<br />
Link: https://support.microsoft.com/kb/3027860


<a id="683"></a>
#### Trace Flag: 683
**Undocumented trace flag**<br />
Function: According to the KB, used to workaround a bug in SQL 2000 SP3 by reverting to pre-SP3 parallel-scan behavior in parallel queries. Database-Wiki.com: “Disallow row counter and column mod counters to be partitioned”<br />
Link: None


<a id="692"></a>
#### Trace Flag: 692
Function: Disables fast inserts while bulk loading data into heap or clustered index.
Starting SQL Server 2016, fast inserts is enabled by default leveraging minimal logging when database is in simple or bulk logged recovery model to optimize insert performance for records inserted into new pages.
With fast inserts, each bulk load batch acquires new extent(s) bypassing the allocation lookup for existing extent with available free space to optimize insert performance.
With fast inserts, bulk loads with small batch sizes can lead to increased unused space consumed by objects hence it is recommended to use large batch size for each batch to fill the extent completely.
If increasing batch size is not feasible, this trace flag can help reduce unused space reserved at the expense of performance.<br />
**Note:  This trace flag applies to SQL Server 2016 (13.x) RTM and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/sql_server_team/sql-server-2016-minimal-logging-and-impact-of-the-batchsize-in-bulk-load-operations/<br />
Scope: global or session


<a id="698"></a>
#### Trace Flag: 698
**Undocumented trace flag**<br />
Function: SQL 9 – Performance of INSERT operations against a table with an identity column may be slow when compared to SQL 8<br />
Link: None


<a id="699"></a>
#### Trace Flag: 699
**Undocumented trace flag**<br />
Function: Turn off transaction logging for the entire SQL dataserver<br />
Link: None


#### Trace Flag: 670, 671
**Undocumented trace flag**<br />
Function: Disables deferred deallocation. But note Paul White’s comment on the post! The flag # may actuall by 671.<br />
Link: [Controlling SQL Server memory dumps]


<a id="715"></a>
#### Trace Flag: 715
Function: Enables table lock for bulk load operations into a heap with no non-clustered indexes.
When this trace flag is enabled, bulk load operations acquire bulk update (BU) locks when bulk copying data into a table.
Bulk update (BU) locks allow multiple threads to bulk load data concurrently into the same table, while preventing other processes that are not bulk loading data from accessing the table.
The behavior is similar to when the user explicitly specifies `TABLOCK` hint while performing bulk load, or when the `sp_tableoption` table lock on bulk load is enabled for a given table.
However, when this trace flag is enabled, this behavior becomes default without any query or database changes.<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="806"></a>
#### Trace Flag: 806
Function:  enables DBCC audit checks to be performed on pages to test for logical consistency problems.
These checks try to detect when a read operation from a disk does not experience any errors but the read operation returns data that is not valid.
Pages will be audited every time that they are read from disk.
Page auditing can affect performance and should only be used in systems where data stability is in question.<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx<br />
Link: http://www.sqlskills.com/blogs/paul/how-to-tell-if-the-io-subsystem-is-causing-corruptions<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://technet.microsoft.com/en-au/library/cc917726.aspx<br />
Scope: ?


<a id="809"></a>
#### Trace Flag: 809
**Undocumented trace flag**<br />
Function: SQL 8 – Limits the amount of Lazy write activity<br />
Link: None


<a id="815"></a>
#### Trace Flag: 815
Function: SQL 8/9 – Enables latch enforcement. SQL Server 8 (with service pack 4) and SQL Server 9 can perform latch enforcement for data pages found in the buffer pool cache. Latch enforcement changes the virtual memory protection state while database page status changes from "clean" to "dirty" ("dirty" means modified through INSERT, UPDATE or DELETE operation). If an attempt is made to modify a data page while latch enforcement is set, it causes an exception and creates a mini-dump in SQL Server installation's LOG directory. Microsoft support can examine the contents of such mini-dump to determine the cause of the exception. In order to modify the data page the connection must first acquire a modification latch. Once the data modification latch is acquired the page protection is changed to read-write. Once the modification latch is released the page protection changes back to read-only.<br />
Link: https://technet.microsoft.com/en-us/library/cc966500.aspx<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/11/12/how-can-reference-counting-be-a-leading-memory-scribbler-cause


<a id="818"></a>
#### Trace Flag: 818
Function: Enables additional I/O diagnostics to check for Lost Write or Stale Read conditions during file I/O operations.
Trace flag 818 enables an in-memory ring buffer that is used for tracking the last 2,048 successful write operations that are performed by SQL Server, not including sort and workfile I/Os.
When errors such as Error 605, 823, or 3448 occur, the incoming buffer's log sequence number (LSN) value is compared to the recent write list.
If the LSN that is retrieved is older than the one specified during the write operation, a new error message is logged in the SQL Server Errorlog.<br />
Link: https://support.microsoft.com/kb/826433<br />
Link: https://technet.microsoft.com/en-us/library/cc966500.aspx<br />
Link: https://support.microsoft.com/kb/828339<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Scope: global only


<a id="822"></a>
#### Trace Flag: 822
**Undocumented trace flag**<br />
Function: A workaround for SQL 2000 over-committing memory on the machine<br />
Link: None


<a id="825"></a>
#### Trace Flag: 825
**Undocumented trace flag**<br />
Function: In SQL 2000, enables Buffer Pool support for NUMA. TF 888 must be used.<br />
Link: None


<a id="828"></a>
#### Trace Flag: 828
Function: SQL 8 - When enabled checkpoint ignores the recovery interval target and keeps steady I/O otherwise it uses recovery interval setting as a target for the length of time that checkpoint will take<br />
Link: https://support.microsoft.com/kb/906121
Link: https://blogs.msdn.microsoft.com/psssql/2008/04/11/how-it-works-sql-server-checkpoint-flushcache-outstanding-io-target/


<a id="830"></a>
#### Trace Flag: 830
Function: SQL 9 – Disable the reporting of CPU Drift errors in the SQL Server errorlog like SQL Server has encountered 2 occurrence(s) of I/O requests taking longer than 15 seconds to complete<br />
Link: https://support.microsoft.com/kb/897284<br />
Link: https://technet.microsoft.com/en-us/library/aa175396(v=SQL.80).aspx


<a id="831"></a>
#### Trace Flag: 831
**Undocumented trace flag**<br />
Function: Protect unchanged pages in the buffer pool to catch memory corruptions<br />
Link: None


<a id="833"></a>
#### Trace Flag: 833
**Undocumented trace flag**<br />
Function: Disable [superlatches](https://www.sqlshack.com/all-about-latches-in-sql-server/).
Starting with SQL Server 2005, superlatches (also called sublatches) were introduced to improve SQL Server efficiency in highly concurrent OLTP workloads for a certain pattern of usage (i.e. very high shared read only access to the page (SH) while write access is very low or not exists).
**Superlatches are used by SQL Server only in NUMA systems with 32+ logical processors.**
A Superlatch will behave as a single latch with sublatch structures and there can be one sublatch per partition per logical CPU core.
So when a superlatch is created, the CPU worker thread will just have to acquire the shared (SH) sublatch that is assigned to the scheduler.
This ensures that a shared (SH) superlatch uses less resources while at the same time access to pages is more efficient comparing to non-partitioned shared latches.
The reason for this is that the superlatch do not require any synchronization of the global state as it will access only the local NUMA memory.<br />
Link: https://www.sqlservercentral.com/forums/topic/sql-server-trace-flags-complete-list/page/3/#post-3679021<br />
Scope: global


<a id="834"></a>
#### Trace Flag: 834
Function: Uses Microsoft Windows large-page allocations for the buffer pool.
Trace flag 834 causes SQL Server to use Microsoft Windows large-page allocations for the memory that is allocated for the buffer pool.
The page size varies depending on the hardware platform, but the page size may be from 2 MB to 16 MB.
Large pages are allocated at startup and are kept throughout the lifetime of the process.
Trace flag 834 improves performance by increasing the efficiency of the translation look-aside buffer (TLB) in the CPU. <br />
**Note: If you are using the Columnstore Index feature of SQL Server 2012 to SQL Server 2016, we do not recommend turning on trace flag 834.
If using SQL Server 2019 (15.x) and columnstore, see trace flag [876](#876) instead.**<br />
Link: [KB920093]<br />
Link: https://support.microsoft.com/kb/3210239<br />
Link: [Docs Trace Flags]<br />
Link: [Let’s talk about trace flags]<br />
Link: [KB2964518]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-834/<br />
Scope: global only


<a id="835"></a>
#### Trace Flag: 835
**Undocumented trace flag**<br />
Function: SQL 9 / 10 – On 64 bit SQL Server it turns off Lock pages in memory<br />
Link: None<br />
Scope: ?


<a id="836"></a>
#### Trace Flag: 836
Function: Trace flag 836 causes SQL Server to size the buffer pool at startup based on the value of the max server memory option instead of based on the total physical memory.
You can use trace flag 836 to reduce the number of buffer descriptors that are allocated at startup in 32-bit Address Windowing Extensions (AWE) mode.
Trace flag 836 applies only to 32-bit versions of SQL Server that have the AWE allocation enabled. You can turn on trace flag 836 only at startup.<br />
Link: [KB920093]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/12/11/how-it-works-sql-server-32-bit-paeawe-on-sql-2005-2008-and-2008-r2-not-using-as-much-ram-as-expected/<br />
Scope: global only


<a id="839"></a>
#### Trace Flag: 839
Function: (Apparently) forces SQL Server to treate all NUMA memory as “flat”, as if it was SMP.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2010/04/02/how-it-works-soft-numa-io-completion-thread-lazy-writer-workers-and-memory-nodes<br />
Scope: global only


<a id="840"></a>
#### Trace Flag: 840
Function: SQL 9 – When trace turned on, SQL Server can perform larger I/O extent reads to populate the buffer pool when SQL Server starts this populates the buffer pool faster. Additionally, the larger I/O extent reads improve the initial query compilation and the response time when SQL Server starts.<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2011/12/09/the-read-ahead-that-doesnt-count-as-read-ahead<br />
Scope: global only


<a id="842"></a>
#### Trace Flag: 842
**Undocumented trace flag**<br />
Function: Use sys.dm_os_memory_node_access_stats to verify local vs. foreign memory under NUMA configurations after turning on this flag<br />
Link: None


<a id="845"></a>
#### Trace Flag: 845
**Undocumented trace flag**<br />
Function: Enable Lock pages in Memory on Standard Edition for SQL Server 2005 and 2008.<br />
Link: https://support.microsoft.com/kb/970070<br />
Link: https://support.microsoft.com/kb/2708594<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-845/<br />
Scope: global only


<a id="851"></a>
**Undocumented trace flag**<br />
#### Trace Flag: 851
Function: According to Bob Ward’s PASS 2014 talk on SQL Server IO, “disable[s] BPE even if enabled via ALTER SERVER”<br />
Link: None


<a id="861"></a>
#### Trace Flag: 861
**Undocumented trace flag**<br />
Function: According to the error log this disables buffer pool extension.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="862"></a>
#### Trace Flag: 862
**Undocumented trace flag**<br />
Function: According to the error log this enables buffer pool extension. This TF probably doesn’t do anything anymore.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="876"></a>
#### Trace Flag: 876
Function: Uses large-page allocations for columnstore.
Turns 8k page allocations for Column Store segments into 2MB instead.<br />
**Note: Unlike trace flag [834](#834), using trace flag 876 does not pre-allocate SQLOS memory at instance startup, and unused memory can be released.**<br />
**Note: This trace flag applies to SQL Server 2019 (15.x) and higher builds.**<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: [Docs Trace Flags]<br />
Link: https://twitter.com/slava_oks/status/1044257034361757696<br />
Link: https://github.com/ktaranov/sqlserver-kit/issues/151<br />
Scope: global only


<a id="888"></a>
**Undocumented trace flag**<br />
#### Trace Flag: 888
Function: Enables support for locked pages for SQL 2000<br />
Link: None


<a id="902"></a>
#### Trace Flag: 902
Function: Bypasses execution of database upgrade script when installing a Cumulative Update or Service Pack.
If you encounter an error during script upgrade mode, it is recommended to contact Microsoft SQL Customer Service and Support (CSS) for further guidance.<br />
**Warning: This trace flag is meant for troubleshooting of failed updates during script upgrade mode, and it is not supported to run it continuously in a production environment.
Database upgrade scripts needs to execute successfully for a complete install of Cumulative Updates and Service Packs.
Not doing so can cause unexpected issues with your SQL Server instance.**<br />
Link: https://support.microsoft.com/kb/2163980<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/luti/2017/05/17/sql-server-offline-after-applying-service-pack/<br />
Link: https://blog.sqlauthority.com/2018/11/06/sql-server-script-level-upgrade-for-database-master-failed-because-upgrade-step-msdb110_upgrade-sql-encountered-error-926-state-1-severity-25/<br />
Scope: global only


<a id="916"></a>
#### Trace Flag: 916
**Undocumented trace flag**<br />
Function: The KB article references the flag in the context of seeing a Profiler dump<br />
Link: None


<a id="1106"></a>
#### Trace Flag: 1106
Function: SQL 9 - Used space in tempdb increases continuously when you run a query that creates internal objects in tempdb<br />
Link: https://support.microsoft.com/kb/947204<br />
Link: https://blogs.msdn.microsoft.com/arvindsh/2014/02/24/tracking-tempdb-internal-object-space-usage-in-sql-2012


<a id="1117"></a>
#### Trace Flag: 1117
Function: When a file in the filegroup meets the autogrow threshold, all files in the filegroup grow.
This trace flag affects all databases and is recommended only if every database is safe to be grow all files in a filegroup by the same amount.<br />
**Note: Beginning with SQL Server 2016 this behavior is controlled by the `AUTOGROW_SINGLE_FILE` and `AUTOGROW_ALL_FILES` option of `ALTER DATABASE`, and trace flag 1117 has no affect.
For more information, see [ALTER DATABASE File and Filegroup Options (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-file-and-filegroup-options).**<br />
Link: https://www.littlekendra.com/2017/01/03/parallelism-and-tempdb-data-file-usage-in-sql-server/<br />
Link: [SQL Server 2016 : Getting tempdb a little more right]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlskills.com/blogs/paul/tempdb-configuration-survey-results-and-advice<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2011/12/01/attempt-to-grow-all-files-in-one-filegroup-and-not-just-the-one-next-in-the-autogrowth-chain-using-trace-flag-1117<br />
Link: http://sql-articles.com/articles/general/day-6trace-flag-1117-auto-grow-equally-in-all-data-file<br />
Link: http://www.ryanjadams.com/2017/05/trace-flag-1117-growth-contention/<br />
Link: https://www.sqlskills.com/blogs/paul/misconceptions-around-tf-1118/<br/>
Link: [KB2964518]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-1117/<br />
Scope: global only


<a id="1118"></a>
#### Trace Flag: 1118
<a id="1118"></a>
Function: Forces page allocations on uniform extents instead of mixed extents, reducing contention on the SGAM page.
When a new object is created, by default, the first eight pages are allocated from different extents (mixed extents).
Afterwards, when more pages are needed, those are allocated from that same extent (uniform extent).
The SGAM page is used to track these mixed extents, so can quickly become a bottleneck when numerous mixed page allocations are occurring.
This trace flag allocates all eight pages from the same extent when creating new objects, minimizing the need to scan the SGAM page.<br />
**Note: Beginning with SQL Server 2016 this behavior is controlled by the `SET MIXED_PAGE_ALLOCATION` option of `ALTER DATABASE`, and trace flag 1118 has no affect. For more information, see [ALTER DATABASE SET Options (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-set-options).**<br />
Link: http://blogs.msdn.com/b/psssql/archive/2008/12/17/sql-server-2005-and-2008-trace-flag-1118-t1118-usage.aspx<br />
Link: http://www.sqlskills.com/blogs/paul/misconceptions-around-tf-1118/<br />
Link: https://support.microsoft.com/kb/328551<br />
Link: [SQL Server 2016 : Getting tempdb a little more right]<br />
Link: [Docs Trace Flags]<br />
Link: https://chrisadkin.org/2015/04/14/well-known-and-not-so-well-known-sql-server-tuning-knobs-and-switches<br />
Link: [KB2964518]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-1118/<br />
Scope: global only


<a id="1119"></a>
#### Trace Flag: 1119
Function: Turns off mixed extent allocation (Similar to 1118?)<br />
Link: [TECHNET List Of SQL Server Trace Flags]


<a id="1124"></a>
#### Trace Flag: 1124
**Undocumented trace flag**<br />
Function: Unknown. Has been reportedly found turned on in some SQL Server instances running Dynamics AX. Also rumored to be invalid in public builds of SQL Server<br />
Link: None


<a id="1140"></a>
#### Trace Flag: 1140
**Undocumented trace flag**<br />
Function: A workaround for a bug in SQL 2005 SP2, SP3, and SQL 2008, where mixed page allocations climb continually, due to a change in the way that mixed-page allocations are done.<br />
Link: None


<a id="1165"></a>
#### Trace Flag: 1165
**Undocumented trace flag**<br />
Function: In the Proportional Fill Algorithm, each database data file will be assigned with a ranking integer number to specify how many times this file will be skipped from the writing process to the next file depending on the free space of that file, this number is called the Skip Target where the minimum value equal to 1 means that a write process will be performed on that file.
The Skip Target can be measured by dividing the number of free extents in the file with the largest free space amount by the number of free extents in the current file, as integer value. The larger the free space in the database data file, the smaller Skip Target value.
To have one file to write on each loop, there should be minimum one data file with Skip Target value equal to 1.
Each time a new database data file is added or removed, or 8192 extents is filled in the database filegroup, the Skip Target value will be calculated again. In this way, all database data files will become full approximately at the same time.
The Skip Target calculation can be monitored by enabling the Trace Flag 1165.<br />
Link: https://www.sqlshack.com/understanding-sql-server-proportional-fill-algorithm/<br />
Scope: global or session
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_1165.sql


<a id="1180"></a>
#### Trace Flag: 1180
**Undocumented trace flag**<br />
Function: SQL 7 - Forces allocation to use free pages for text or image data and maintain efficiency of storage.  Helpful in case when DBCC SHRINKFILE and SHRINKDATABASE commands may not work because of sparsely populated text, ntext, or image columns.<br />
Link: None


<a id="1197"></a>
#### Trace Flag: 1197
**Undocumented trace flag**<br />
Function: Applies only in the case of SQL 7 – SP3, similar with trace flag 1180<br />
Link: None


<a id="1200"></a>
#### Trace Flag: 1200
Function: Prints detailed lock information as every request for a lock is made (the process ID and type of lock requested)<br />
Link: [TECHNET List Of SQL Server Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/sqlserverstorageengine/2008/03/30/tempdb-table-variable-vs-local-temporary-table<br />
Link: [KB169960]<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Scope: ?


<a id="1202"></a>
#### Trace Flag: 1202
**Undocumented trace flag**<br />
Function: Insert blocked lock requests into syslocks<br />
Link: None


<a id="1204"></a>
#### Trace Flag: 1204
Function: Returns the resources and types of locks participating in a deadlock and also the current command affected.
Writes information about deadlocks to the ERRORLOG in a "text format".
Trace flag 1204 provides node base information about deadlock in another words you can say that all nodes which are involved in deadlock.
Finally after all nodes information it also provides information about deadlock victim.<br />
Link: https://support.microsoft.com/kb/832524<br />
Link: [Docs Trace Flags]<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://www.sqlservergeeks.com/sql-server-deadlock-trace-flag-1204/<br />
Scope: global only


<a id="1205"></a>
#### Trace Flag: 1205
Function: More detailed information about the command being executed at the time of a deadlock. Documented in SQL 7 BOL.<br />
Link: https://support.microsoft.com/kb/832524


<a id="1206"></a>
#### Trace Flag: 1206
Function: Used to complement flag 1204 by displaying other locks held by deadlock parties<br />
Link: [KB169960]


<a id="1208"></a>
#### Trace Flag: 1208
Function: KB: “Prints the host name and program name supplied by the client. This can help identify a client involved in a deadlock, assuming the client specifies a unique value for each connection.”<br />
Link: [KB169960]


<a id="1211"></a>
#### Trace Flag: 1211
Function: Disables lock escalation based on memory pressure, or based on number of locks. The SQL Server Database Engine will not escalate row or page locks to table locks.
Using this trace flag can generate excessive numbers of locks. This can slow the performance of the Database Engine, or cause 1204 errors (unable to allocate lock resource) because of insufficient memory.
If both trace flag 1211 and [1224](#1224) are set, 1211 takes precedence over [1224](#1224).
However, because trace flag 1211 prevents escalation in every case, even under memory pressure, we recommend that you use [1224](#1224).
This helps avoid "out-of-locks" errors when many locks are being used.<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-2330-lock-escalation<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://support.microsoft.com/kb/323630<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-1211/<br />
Scope: global or session


<a id="1216"></a>
#### Trace Flag: 1216
**Undocumented trace flag**<br />
Function: SQL 7 - Disables Health reporting. Lock monitor when detects a (worker thread) resource level blocking scenario. If a SPID that owns a lock is currently queued to the scheduler, because all the assigned worker threads have been created and all the assigned worker threads are in an un-resolvable wait state, the following error message is written to the SQL Server error log: Error 1223: Process ID %d:%d cannot acquire lock "%s" on resource %s because a potential deadlock exists on Scheduler %d for the resource. Process ID %d:% d holds a lock "%h" on this resource.<br />
Link: None


<a id="1217"></a>
#### Trace Flag: 1217
**Undocumented trace flag**<br />
Function: Disables (for 7.0) the “UMS Health” reporting messages described in the KB article.<br />
Link: None


<a id="1222"></a>
#### Trace Flag: 1222
Function: Returns the resources and types of locks that are participating in a deadlock and also the current command affected, in an XML format that does not comply with any XSD schema.
Write deadlock information to sql server error log.<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/bartd/2006/09/08/deadlock-troubleshooting-part-1/<br />
Link: https://blog.sqlauthority.com/2017/01/09/sql-server-get-historical-deadlock-information-system-health-extended-events<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: <br />
Scope: global only


<a id="1224"></a>
#### Trace Flag: 1224
Function: Disables lock escalation based on the number of locks. However, memory pressure can still activate lock escalation.
The Database Engine escalates row or page locks to table (or partition) locks if the amount of memory used by lock objects exceeds one of the following conditions:
 - Forty percent of the memory that is used by Database Engine. This is applicable only when the locks parameter of sp_configure is set to 0.
 - Forty percent of the lock memory that is configured by using the locks parameter of sp_configure.
For more information, see [Server Configuration Options (SQL Server)](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server).
If both trace flag [1211](#1211) and 1224 are set, [1211](#1211) takes precedence over 1224.
However, because trace flag 1211 prevents escalation in every case, even under memory pressure, we recommend that you use 1224.
This helps avoid "out-of-locks" errors when many locks are being used.<br />
**Note: Lock escalation to the table- or HoBT-level granularity can also be controlled by using the `LOCK_ESCALATION` option of the `ALTER TABLE` statement.**<br />
Link: [Docs Trace Flags]<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-1224/<br />
Scope: global or session


<a id="1228"></a>
#### Trace Flag: 1228
Function: Enable lock partitioning.
By default, lock partitioning is enabled when a server has 16 or more CPUs. Otherwise, lock partitioning is disabled.
Trace flag 1228 enables lock partitioning for 2 or more CPUs. Trace flag [1229](#1229) disables lock partitioning.
Trace flag [1229](#1229) overrides trace flag 1228 if trace flag 1228 is also set.
Lock partitioning is useful on multiple-CPU servers where some tables have very high lock rates.
You can turn on trace flag 1228 and trace flag [1229](#1229) only at startup.<br />
Link: [Trace Flag 1228 and 1229]<br />
Link: [Microsoft SQL Server 2005 TPC-C Trace Flags]<br />
Scope: global only


<a id="1229"></a>
#### Trace Flag: 1229
Function: Disables all lock partitioning regardless of the number of CPUs.
By default, SQL Server enables lock partitioning when a server has 16 or more CPUs, to improve the scalability characteristics of larger systems.
For more information on lock partitioning, see the [Transaction Locking and Row Versioning Guide](https://docs.microsoft.com/en-us/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide?view=sql-server-2017#lock_partitioning)<br />
**WARNING: Trace flag 1229 can cause spinlock contention and poor performance.**
Link: [Docs Trace Flags]<br />
Link: [Trace Flag 1228 and 1229]<br />
Link: [Microsoft SQL Server 2005 TPC-C Trace Flags]<br />
Scope: global only


<a id="1236"></a>
#### Trace Flag: 1236
Function: Enables database lock partitioning. Fixes performance problem in scenarios with high lock activity in SQL 2012 and SQL 2014.<br />
**Note: Beginning with SQL Server 2012 SP3 and SQL Server 2014 SP1 this behavior is controlled by the engine and trace flag 1236 has no effect.**<br />
Link: https://support.microsoft.com/kb/2926217<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="1237"></a>
#### Trace Flag: 1237
Function: Allows the `ALTER PARTITION FUNCTION` statement to honor the current user-defined session deadlock priority instead of being the likely deadlock victim by default.<br />
**Note: Starting with SQL Server 2017 and database [compatibility level] 140 this is the default behavior and trace flag 1237 has no effect.**<br />
Link: https://support.microsoft.com/kb/4025261<br />
Link: [Docs Trace Flags]<br />
Scope: global or session or query


<a id="1260"></a>
#### Trace Flag: 1260
Function: Disabled mini-dump for non-yield condition.
Disables mini-dump generation for "any of the 17883, 17884, 17887, or 17888 errors.
The trace flag can be used in conjunction with trace flag –T1262. For example, you could enable `–T1262` to get 10- and a 60-second interval reporting and also enable `–T1260` to avoid getting mini-dumps."<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]<br />
Link: [Docs Trace Flags]<br />
Link: https://www.sqlservergeeks.com/sql-trace-flag-1260/<br />
Scope: global only


<a id="1261"></a>
#### Trace Flag: 1261
**Undocumented trace flag**<br />
Function: SQL 8 - Disables Health reporting. Lock monitor when detects a (worker thread) resource level blocking scenario. If a SPID that owns a lock is currently queued to the scheduler, because all the assigned worker threads have been created and all the assigned worker threads are in an un-resolvable wait state, the following error message is written to the SQL Server error log: Error 1229: Process ID %d:%d owns resources that are blocking processes on scheduler %d.<br />
Link: None


<a id="1262"></a>
#### Trace Flag: 1262
Function: The default behavior (for 1788* errors) is for SQL to generate a mini-dump on the first occurrence, but never after.
1262 changes the behavior: “When –T1262 is enabled, a mini-dump is generated when the non-yielding condition is declared (15 seconds) and at subsequent 60-second intervals for the same non-yield occurrence.
A new nonDiagCorrect17883etc; yielding occurrence causes dump captures to occur again.”
In SQL 2000 this was a startup-only flag; in 2005+ it can be enabled via TRACEON.
Note that the flag is also covered in Khen2005, p400, but with no new information.<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]<br />
Link: https://www.sqlservergeeks.com/sql-trace-flag-1262/<br />
Scope: global or session


<a id="1264"></a>
#### Trace Flag: 1264
Function: Collect process names in non-yielding scenario memory dumps<br />
Link: [A Topical Collection of SQL Server Flags v6]<br />
Link: https://support.microsoft.com/kb/2630458


<a id="1400"></a>
#### Trace Flag: 1400
Function: SQL 9 RTM – Enables creation of database mirroring endpoint, which is required for setting up and using database mirroring<br />
Link: None


<a id="1439"></a>
#### Trace Flag: 1439
Function: Trace database restart and failover messages to SQL Errorlog for mirrored databases<br />
Link: [Trace flags in sql server from trace flag 902 to trace flag 1462]


<a id="1448"></a>
#### Trace Flag: 1448
Function: Enables the replication log reader to move forward even if the async secondaries have not acknowledged the reception of a change.
Even with this trace flag enabled the log reader always waits for the sync secondaries. The log reader will not go beyond the min ack of the sync secondaries.
This trace flag applies to the instance of SQL Server, not just an availability group, an availability database, or a log reader instance.
Takes effect immediately without a restart. This trace flag can be activated ahead of time or when an async secondary fails.<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="1449"></a>
#### Trace Flag: 1449
Function: When you use SNAC to connect to an instance of a principal server in a database mirroring session: "The connection attempted to fail over to a server that does not have a failover partner".<br />
Link: https://support.microsoft.com/kb/936179


<a id="1462"></a>
#### Trace Flag: 1462
Function: Disables log stream compression for asynchronous availability groups.
This feature is enabled by default on asynchronous availability groups in order to optimize network bandwidth.<br />
Link: [Tune compression for availability group]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlskills.com/blogs/paul/sql-server-2008-performance-boost-for-database-mirroring<br />
Link: http://sqlblog.com/blogs/joe_chang/archive/2014/03/13/hekaton-and-benchmarks.aspx<br />
Scope: global only


<a id="1482"></a>
#### Trace Flag: 1482
Function: Prints information to the Error Log (3605 is not necessary) for a variety of transaction log operations are done, including when the MinLSN value is reset, when a VLF is formatted, etc.<br />
Link: None


<a id="1504"></a>
#### Trace Flag: 1504
Function: Dynamic memory grant expansion can also help with parallel index build plans where the distribution of rows across threads is uneven.
The amount of memory that can be consumed this way is not unlimited, however.
SQL Server checks each time an expansion is needed to see if the request is reasonable given the resources available at that time.
Some insight to this process can be obtained by enabling undocumented trace flag 1504, together with 3604 (for message output to the console)
or 3605 (output to the SQL Server error log). If the index build plan is parallel, only 3605 is effective because parallel workers cannot send trace messages cross-thread to the console.<br />
Link: [Internals of the Seven SQL Server Sorts – Part 1]


<a id="1603"></a>
#### Trace Flag: 1603
Function: Use standard disk I/O (i.e. turn off asynchronous I/O)<br />
Link: None


<a id="1604"></a>
#### Trace Flag: 1604
Function: Once enabled at start up makes SQL Server output information regarding memory allocation requests<br />
Link: None


<a id="1609"></a>
#### Trace Flag: 1609
Function: Turns on the unpacking and checking of RPC information in Open Data Services. Used only when applications depend on the old behavior.<br />
Link: None


<a id="1610"></a>
#### Trace Flag: 1610
Function: Boot the SQL dataserver with TCP_NODELAY enabled<br />
Link: None


<a id="1611"></a>
#### Trace Flag: 1611
Function: If possible, pin shared memory -- check errorlog for success/failure<br />
Link: None


<a id="1613"></a>
#### Trace Flag: 1613
Function: Set affinity of the SQL data server engine's onto particular CPUs -- usually pins engine 0 to processor 0, engine 1 to processor 1...<br />
Link: None

<a id="1615"></a>
#### Trace Flag: 1615
Function: Khen2005, page 385 (paraphrased): directs SQL to use threads instead of fiber even if the “lightweight pooling” config option is on. (Apparently, sometimes SQL wouldn’t start successfully when using lightweight pooling, and so this lets you get SQL up and running, so that you can turn the config option off)<br />
Link: None


<a id="1704"></a>
#### Trace Flag: 1704
Function: Prints information when a temporary table is created or dropped<br />
Link: None


<a id="1717"></a>
#### Trace Flag: 1717
Function: MSShipped bit will be set automatically at Create time when creating stored procedures<br />
Link: None


<a id="1800"></a>
#### Trace Flag: 1800
Function: Enables SQL Server optimization when disks of different sector sizes are used for primary and secondary replica log files, in SQL Server Always On and Log Shipping environments.
This trace flag is only required to be enabled on SQL Server instances with transaction log file residing on disk with sector size of 512 bytes.
It is **not** required to be enabled on disk with 4k sector sizes.<br />
**Note: This trace flag applies to SQL Server 2012 (11.x) SP1 CU13, SQL Server 2012 (11.x) SP2 CU3, SQL Server 2014 (12.x) RTM CU5, and higher builds.**<br />
Link: https://support.microsoft.com/kb/3009974<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="1802"></a>
#### Trace Flag: 1802
Function: SQL 9 - After detaching a database that resides on network-attached storage, you cannot reattach the SQL Server database<br />
Link: https://support.microsoft.com/kb/922804


<a id="1806"></a>
#### Trace Flag: 1806
Function: Disable Instant File Initialization.
Used to guarantee the physical data file space acquisition during data file creation or expansion, on a thin provisioned subsystem<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx<br />
Link: https://blogs.msdn.microsoft.com/sql_pfe_blog/2009/12/22/how-and-why-to-enable-instant-file-initialization<br />
Link: http://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-330-instant-file-initialization-can-be-controlled-from-within-sql-server<br />
Link: https://support.microsoft.com/kb/2574695<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Scope: ?


<a id="1807"></a>
#### Trace Flag: 1807
Function: Enable option to have database files on SMB share for SQL Server 2008 and 2008R2<br />
Link: http://blogs.msdn.com/b/varund/archive/2010/09/02/create-a-sql-server-database-on-a-network-shared-drive.aspx<br />
Link: https://support.microsoft.com/kb/304261


<a id="1808"></a>
#### Trace Flag: 1808
Function: Directs SQL Server to ignore auto-closing databases even if the Auto-close property is set to ON. Must be set globally. Present in Yukon forward<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/04/11/want-your-sql-server-to-simply-ignore-the-auto_close-setting-for-all-open-databases-for-which-it-has-been-enabled


<a id="1810"></a>
#### Trace Flag: 1810
Function: Prints the file create/open/close timings<br />
Link: None


<a id="1816"></a>
#### Trace Flag: 1816
Function: Bob Ward briefly references this flag in his PASS 2014 SQL Server IO talk, saying that it “could provide more details around errors” that occur with IO done to SQL data files in Azure Storage.<br />
Link: None


<a id="1819"></a>
#### Trace Flag: 1819
Function: Allows [backup to URL](https://docs.microsoft.com/en-gb/sql/relational-databases/backup-restore/sql-server-backup-to-url?view=sql-server-ver15) to leverage a proxy server when accessing Azure block blobs. In addition to this trace flag, you must set the WinHTTP proxy configuration on the server via one of the following methods:
- The [`proxycfg.exe`](https://docs.microsoft.com/en-us/windows/win32/winhttp/proxycfg-exe--a-proxy-configuration-tool) utility on Windows XP or Windows Server 2003 and earlier.
- The [`netsh.exe`]() utility on Windows Vista and Windows Server 2008 or later.<br />
Link: [Docs Trace Flags]
Scope: global or session or query (QUERYTRACEON)


<a id="1851"></a>
#### Trace Flag: 1851
Function: Anecdotally, from a JustDave’s notes on an Amanda Ford talk at SQL Relay Reading 2014: “...disables the automerge functionality for in-memory oltp”<br />
Link: https://justdaveinfo.wordpress.com/2014/10/16/october-13-microsoft-sql-relay-reading


<a id="1903"></a>
#### Trace Flag: 1903
Function: SQL 8 - When you capture a SQL Profiler trace in a file and then you try to import the trace files into tables by using the fn_trace_gettable function no rows may be returned<br />
Link: Note


<a id="1905"></a>
#### Trace Flag: 1905
Function: Unknown<br />
Link: [Upgrading an expired SQL Server 2016 Evaluation Edition]


<a id="1906"></a>
#### Trace Flag: 1906
**Undocumented trace flag**<br />
Function: It enables SQL Server to read ETW tracing templates stored in the `etwcnf.xml` directory on SQL Server 2008.
When the flag is turned off, the file is not read, and a static in-memory ETW template is used instead.
It is not documented because it can cause SQL Server to hang on startup.
We will be supported by Microsoft running this trace flag as long as we do not experience start up "hangs".
Microsoft recommends using Xevents instead the template file.<br />
Link: https://social.msdn.microsoft.com/Forums/sqlserver/en-US/0489f308-2e0c-479f-85a8-9a5661b2462f/trace-flag-1906?forum=sqldatabaseengine


<a id="2301"></a>
#### Trace Flag: 2301
Function: Trace flag 2301 enables advanced optimizations that are specific to decision support queries.
This option applies to decision support processing of large data sets.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.queryprocessor.com/ce_join_base_containment_assumption<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/772232/make-optimizer-estimations-more-accurate-by-using-metadata<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-2301/<br />
Scope: global or session or query


<a id="2309"></a>
#### Trace Flag: 2309
Function: In SQL 2014, enables output from a 3rd parameter for [DBCC SHOW_STATISTICS] such that the partial statistics histogram (for just one partition) is shown. <br />
Link: https://sqlperformance.com/2015/05/sql-statistics/incremental-statistics-are-not-used-by-the-query-optimizer<br />
Link: http://blog.dbi-services.com/sql-server-2014-new-incremental-statistics


<a id="2312"></a>
#### Trace Flag: 2312
Function: Sets the query optimizer cardinality estimation model to the SQL Server 2014 (12.x) through SQL Server 2017 versions, dependent of the compatibility level of the database.
Starting with SQL Server 2016 (13.x) SP1, to accomplish this at the query level, add the USE HINT 'FORCE_DEFAULT_CARDINALITY_ESTIMATION' query hint instead of using this trace flag.<br />
**Note: If the database compatibility level is lower than 120, enabling trace flag 2312 uses the cardinality estimation model of SQL Server 2014 (12.x) (120).**
Link: [KB2801413]<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-2014-trace-flags-2312/<br />
Link: [KB2801413]<br />
Scope: global or session or query


<a id="2315"></a>
#### Trace Flag: 2315
Function: Aaron: I stumbled onto this one. Seems to output memory allocations taken during 
the compilation process (and maybe the plan as well? “PROCHDR”), as well as 
memory broker states & values at the beginning and end of compilation.<br />
Link: None


<a id="2318"></a>
#### Trace Flag: 2318
Function: Aaron: stumbled onto this one as well. I’ve only seen one type of output so far: “Optimization Stage: HEURISTICJOINREORDER”. Maybe useful in combo with other compilation trace flags to see the timing of join reordering?<br />
Link: None


<a id="2324"></a>
#### Trace Flag: 2324
Function: Disables Implied Predicates<br />
Link: https://answers.sqlperformance.com/questions/2299/why-not-seek-predicate.html?utm_content=buffer9bed5&utm_medium=social&utm_source=twitter.com&utm_campaign=buffer


<a id="2328"></a>
#### Trace Flag: 2328
Function: SQL 9+ - Makes cardinality estimates upon resulting selectivity.  The reasoning for this is that one or more of the constants may be statement parameters, which would change from one execution of the statement to the next.<br />
Link: https://blogs.msdn.microsoft.com/ianjo/2006/03/28/disabling-constant-constant-comparison-estimation<br />
Link: http://www.queryprocessor.ru/isnumeric_ce_bug_eng


<a id="2329"></a>
#### Trace Flag: 2329
Function: Disables “Few Outer Rows” optimization<br />
Link: http://www.queryprocessor.com/few-outer-rows-optimization


<a id="2330"></a>
#### Trace Flag: 2330
Function: Query performance decreases when sys.dm_db_index_usage_stats has large number of rows<br />
Link: http://www.brentozar.com/archive/2015/11/trace-flag-2330-who-needs-missing-index-requests/<br />
Link: https://chrisadkin.org/2015/04/14/well-known-and-not-so-well-known-sql-server-tuning-knobs-and-switches/


<a id="2332"></a>
#### Trace Flag: 2332
Function: PWhite: “Force DML Request Sort (CUpdUtil::FDemandRowsSortedForPerformance)”<br />
Link: [Optimizing T-SQL queries that change data]


<a id="2335"></a>
#### Trace Flag: 2335
Function: Causes SQL Server to assume a fixed amount of memory is available during query optimization. It does not limit the memory SQL Server grants to execute the query.
The memory configured for SQL Server will still be used by data cache, query execution and other consumers.<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://www.brentozar.com/archive/2018/08/how-trace-flag-2335-affects-memory-grants/<br />
Link: https://support.microsoft.com/kb/2413549<br />
Link: [Docs Trace Flags]<br />
Link: http://dba.stackexchange.com/questions/53726/difference-in-execution-plans-on-uat-and-prod-server<br />
Link: [KB2801413]<br />
Scope: global or session or query


<a id="2336"></a>
#### Trace Flag: 2336
Function: Aaron: Another one that I stumbled onto. Appears to tie memory info and cached page likelihoods with costing<br />
Link: None


<a id="2340"></a>
#### Trace Flag: 2340
Function: Causes SQL Server not to use a sort operation (batch sort) for optimized Nested Loops joins when generating a plan.
By default, SQL Server can use an optimized Nested Loops join instead of a full scan or a Nested Loops join with an explicit Sort, when the Query Optimizer concludes that a sort is most likely not required, but still a possibility in the event that the cardinality or cost estimates are incorrect.
Starting with SQL Server 2016 (13.x) SP1, to accomplish this at the query level, add the USE HINT 'DISABLE_OPTIMIZED_NESTED_LOOP' query hint instead of using this trace flag..<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2010/01/11/high-cpu-after-upgrading-to-sql-server-2005-from-2000-due-to-batch-sort<br />
Link: http://www.queryprocessor.com/batch-sort-and-nested-loops<br />
Link: [KB2801413]<br />
Link: https://www.sqlservergeeks.com/trace-flag-2340/<br />
Scope: global or session or query


<a id="2341"></a>
#### Trace Flag: 2341
Function: Enables the use of a hash join for joins to column store indexes even when the join clause would normally be removed “during query normalization”. <br />
Link: https://support.microsoft.com/kb/3146123


<a id="2363"></a>
#### Trace Flag: 2363
Function: TF Selectivity. can be used with the new cardinality estimation model to see the derivation of the distinct estimate on the outer input to an apply, and cardinality estimation in general.<br />
Link: [Cardinality Estimation Framework 2014 First Look]<br />
Link: http://www.queryprocessor.com/ce-process<br />
Link: https://sqlperformance.com/2014/01/sql-plan/cardinality-estimation-for-multiple-predicates
Link: [Nested Loops Joins and Performance Spools]<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: session or query


<a id="2368"></a>
#### Trace Flag: 2368
**Undocumented trace flag**<br />
Function: For one query, this resulted in a parallel plan significantly more expensive than the naturally occurring serial plan. Could be related to trace flag 3651.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="2371"></a>
#### Trace Flag: 2371
Function: Changes the fixed update statistics threshold to a linear update statistics threshold.
Change a fixed rate 20% of rows changed for Recompilation Thresholds (RT) on new formula - **SQRT(1000 * table rows)**<br />
**Note: Starting with SQL Server 2016 (13.x) and under the database compatibility level 130 or above, this behavior is controlled by the engine and trace flag 2371 has no effect.**<br />
Link: https://support.microsoft.com/kb/2754171<br />
Link: https://blogs.msdn.microsoft.com/saponsqlserver/2011/09/07/changes-to-automatic-update-statistics-in-sql-server-traceflag-2371/<br />
Link: https://blogs.msdn.microsoft.com/axinthefield/sql-server-trace-flag-2371-for-dynamics-ax/<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-2371/<br />
Link: [Temporary Table Caching in Stored Procedures]<br />
Scope: global or session
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_2371.sql


<a id="2372"></a>
#### Trace Flag: 2372
Function: Displays memory utilization during the optimization process. Memory for Phases
Memory before and after deriving properties and rules (verbose) <br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Cardinality Estimation Framework 2014 First Look]<br />
Link: [Query Optimizer Deep Dive - Part 4]


<a id="2373"></a>
#### Trace Flag: 2373
Function: Displays memory utilization during the optimization process. Memory for Deriving Properties.<br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Cardinality Estimation Framework 2014 First Look]


<a id="2374"></a>
#### Trace Flag: 2374
**Undocumented trace flag**<br />
Function: Removes QueryHash and QueryPlanHash information from estimated query plans.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="2382"></a>
#### Trace Flag: 2382
Function: SSC: “SQL 8 -Statistics collected for system tables.”<br />
Link: None


<a id="2387"></a>
#### Trace Flag: 2387
**Undocumented trace flag**<br />
Function: can be used to reduce the CPU cost of reading rows from a lazy index spool.
This flag affects general CPU cost estimates for reading a range of rows from a b-tree.
This flag tends to make index spool selection more likely, for cost reasons.<br />
Link: [New Undocumented Trace Flags]<br />
Link: [Nested Loops Joins and Performance Spools]<br />
Scope: ?


<a id="2388"></a>
#### Trace Flag: 2388
Function: Changes the output of [DBCC SHOW_STATISTICS].
Instead of the normal Header/Vector/Histogram output, instead we get a single row that gives information related to whether the lead column of the stat object is considered to be ascending or not.
This TF is primarily helpful in watching the state of a stat object change from “Unknown”, to “Ascending” (and potentially to “Stationary”).
Also In SQL Server, if you want to see the information of last four statistics update on a statistics object then you can use trace flag 2388.
In simple words, we can say that this trace flag provide us the historical information about statistics update.<br />
Link: [SQL Server - estimates outside of the histogram - half-baked draft]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-2388/<br />
Link: [Fun with SQL Server Plan Cache, Trace Flag 8666, and Trace Flag 2388]<br />
Scope: session only


<a id="2389"></a>
#### Trace Flag: 2389
Function: Enable automatically generated quick statistics for ascending keys (histogram amendment).
If trace flag 2389 is set, and a leading statistics column is marked as ascending, then the histogram used to estimate cardinality will be adjusted at query compile time.<br />
**Note: This trace flag does not apply to CE version 120 or above. Use trace flag [4139](#4139) instead.**<br />
Link: <br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767<br />
Link: https://sqlperformance.com/2016/07/sql-statistics/trace-flag-2389-new-cardinality-estimator<br />
Link: https://www.sswug.org/sswugresearch/community/trace-flag-2389-and-the-new-cardinality-estimator/<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: [SQL Server - estimates outside of the histogram - half-baked draft]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-2389/<br />
Scope: global or session or query


<a id="2390"></a>
#### Trace Flag: 2390
Function: Enable automatically generated quick statistics for ascending or unknown keys (histogram amendment).
If trace flag 2390 is set, and a leading statistics column is marked as ascending or unknown, then the histogram used to estimate cardinality will be adjusted at query compile time<br />
**Use this flag only with [2389](#2389) trace flag.**<br />
**Note: This trace flag does not apply to CE version 120 or above. Use trace flag [4139](#4139) instead.**<br />
Link: http://blogs.msdn.com/b/ianjo/archive/2006/04/24/582227.aspx<br />
Link: [KB2801413]<br />
Link: http://www.sqlmag.com/article/tsql3/making-the-most-of-automatic-statistics-updating--96767<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/ianjo/2006/04/24/ascending-keys-and-auto-quick-corrected-statistics<br />
Link: [SQL Server - estimates outside of the histogram - half-baked draft]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-2390/<br />
Scope: global or session or query


<a id="2392"></a>
#### Trace Flag: 2392
**Undocumented trace flag**<br />
Function: Trace Flag 2392 can be used to turn the missing index feature off completely (as a workaround to the issue that is corrected by the hotfix).
This trace flag has been in the product since SQL Server 2005.
The problem is, it will not disable/enable missing index stats collection unless it is enabled at startup.
If you set it as a startup TF and restart SQL Server, then no missing index stats are collected.
If you then subsequently disable TF 2392 while SQL Server is running, it still won’t collect any missing index stats (despite what you may expect).<br />
Link: https://www.sqlskills.com/blogs/glenn/sql-server-missing-indexes-feature-and-trace-flag-2392/<br />
Link: https://support.microsoft.com/kb/4042232<br />
Scope: global only


<a id="2398"></a>
#### Trace Flag: 2398
**Undocumented trace flag**<br />
Function: Disable SSC (Smart Seek Costing).
SSC attempts to assess inner side seek I/O cost in more detail, perhaps by considering local ordering and/or the range of values to fetch.<br />
Link: https://dba.stackexchange.com/a/149933/107045<br />
Scope: session or query


<a id="2399"></a>
#### Trace Flag: 2399
**Undocumented trace flag**<br />
Function: Small changes in operator costs were observed for some queries. These were typically less than 0.01 units.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="2418"></a>
#### Trace Flag: 2418
**Undocumented trace flag**<br />
Function: Disables serial Batch mode processing.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="2422"></a>
#### Trace Flag: 2422
Function: Enables the SQL Server Database Engine to abort a request when the maximum time set by Resource Governor REQUEST_MAX_CPU_TIME_SEC configuration is exceeded.<br />
**Note: This trace flag applies to SQL Server 2017 CU3 and higher builds.**<br />
Link: https://support.microsoft.com/kb/4038419<br />
Scope: global only


<a id="2430"></a>
#### Trace Flag: 2430
Function: Fixes performance problem when using large numbers of locks<br />
Link: https://support.microsoft.com/kb/2754301<br />
Link: https://support.microsoft.com/kb/2746341


<a id="2440"></a>
#### Trace Flag: 2440
Function: SQL 10 - Parallel query execution strategy on partitioned tables. SQL 9 used single thread per partition parallel query execution strategy. In SQL 10, multiple threads can be allocated to a single partition by turning on this flag.<br />
Link: https://social.msdn.microsoft.com/Forums/sqlserver/en-US/dc010af9-afa0-4c87-937c-4343b4e1119a/trace-flag-2440


<a id="2451"></a>
#### Trace Flag: 2451
**Note: This trace flag applies to SQL Server 2019 preview CTP 2.4 and higher builds.**
Function: Enables the equivalent of the last actual execution plan in [`sys.dm_exec_query_plan_stats`](https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql).<br />
Link: [Docs Trace Flags]<br />
SQL Server Version: >= 2019 CTP 2.4<br />
Scope: global only


<a id="2453"></a>
#### Trace Flag: 2453
Function: Allow a table variable to trigger recompile when enough number of rows are changed with may allow the query optimizer to choose a more efficient plan.<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://sqlperformance.com/2014/06/t-sql-queries/table-variable-perf-fix<br />
Link: https://support.microsoft.com/kb/2952444<br />
Link: [Docs Trace Flags]<br />
Link: https://www.brentozar.com/archive/2017/02/using-trace-flag-2453-improve-table-variable-performance<br />
Link: https://www.brentozar.com/archive/2018/03/table-valued-parameters-unexpected-parameter-sniffing<br />
Link: [TEMPDB – Files and Trace Flags and Updates]<br />
Link: http://www.sqlservergeeks.com/the-correct-cardinality-estimation-for-table-variable-using-trace-flag-2543/<br />
Scope: global or session or query


<a id="2456"></a>
#### Trace Flag: 2456
Function: Relieves RESOURCE_SEMAPHORE_MUTEX contention, which may be primarily due to a bug in SQL 2005.<br />
Link: None


<a id="2466"></a>
#### Trace Flag: 2466
Function: When SQL Server is determining the runtime DOP for a parallel plan, this flag directs it to use logic found in “older versions” (the post doesn’t say which versions) to 
determine which NUMA node to place the parallel plan on. This older logic relies on a polling mechanism (roughly every 1 second), and can result in race conditions where 2 
parallel plans end up on the same node. The newer logic “significantly reduces” the likelihood of this happening.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/09/27/how-it-works-maximizing-max-degree-of-parallelism-maxdop


<a id="2467"></a>
#### Trace Flag: 2467
Function: Enables an alternate parallel worker thread allocation policy, based on which node has the least allocated threads.
For more information, see [Parallel Query Processing](https://docs.microsoft.com/en-us/sql/relational-databases/query-processing-architecture-guide#parallel-query-processing).
Refer to [Configure the max worker threads Server Configuration Option](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-worker-threads-server-configuration-option) for information on configuring the max worker threads server option.
**Note: Query degree of parallelism (DOP) has to fit into a single node for this alternate policy to be used, or the default thread allocation policy is used instead. Using this trace flag, it is not recommended to execute queries specifying a DOP over the number of schedulers in a single node, as this could interfere with queries specifying a DOP below or equal to the number of schedulers in a single node.
Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/09/27/how-it-works-maximizing-max-degree-of-parallelism-maxdop<br />
Link: https://erikdarlingdata.com/2019/06/thoughts-on-maxdop/<br />
Link: [SQL Server Parallel Query Placement Decision Logic]<br />
Scope: global only


<a id="2468"></a>
#### Trace Flag: 2468
**Undocumented trace flag**<br />
Function: “Find the next node that can service the DOP request. Unlike full mode, the global, resource manager keeps track of the last node used.
Starting from the last position, and moving to the next node, SQL Server checks for query placement opportunities.
If a node can’t support the request SQL Server continues advancing nodes and searching.”<br />
Link: [SQL Server Parallel Query Placement Decision Logic]


<a id="2469"></a>
#### Trace Flag: 2469
Function: Enables alternate exchange for `INSERT INTO ... SELECT` into a partitioned columnstore index.<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3204769/<br />
Scope: global or session or query


<a id="2470"></a>
#### Trace Flag: 2470
**Undocumented trace flag**<br />
Function: Fixes performance problem when using AFTER triggers on partitioned tables<br />
Link: https://support.microsoft.com/kb/2606883


<a id="2479"></a>
#### Trace Flag: 2479
**Undocumented trace flag**<br />
Function: When SQL Server is determining the runtime DOP for a parallel plan, this flag directs it to limit the NUMA Node placement for the query to the node that the connection is associated with.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/09/27/how-it-works-maximizing-max-degree-of-parallelism-maxdop<br />
Link: [SQL Server Parallel Query Placement Decision Logic]


<a id="2486"></a>
#### Trace Flag: 2486
**Undocumented trace flag**<br />
Function: In SQL 2016 (CTP 3.0 at least), enables output for the “query_trace_column_values” Extended Event, allowing the value of output columns from individual plan iterators to be traced.<br />
Link: http://www.queryprocessor.com/query-trace-column-values


<a id="2505"></a>
**Undocumented trace flag**<br />
#### Trace Flag: 2505
Function: SQL 7 - Prevents DBCC TRACEON 208, SPID 10 errors from appearing in the error log (Note: DBCC TRACEON(208) just means “SET QUOTED IDENTIFIER ON”)<br />
Link: None


<a id="2508"></a>
#### Trace Flag: 2508
**Undocumented trace flag**<br />
Function: Disables parallel non-clustered index checking for DBCC CHECKTABLE<br />
Link: None


<a id="2509"></a>
#### Trace Flag: 2509
**Undocumented trace flag**<br />
Function: Used with `DBCC CHECKTABLE` to see the total count of forward records in a table<br />
Link: None


<a id="2514"></a>
#### Trace Flag: 2514
**Undocumented trace flag**<br />
Function: Verbose Merge Replication logging to msmerge\_history table for troubleshooting Merger repl performance<br />
Link: http://sqlblog.com/blogs/argenis_fernandez/archive/2012/05/29/ghost-records-backups-and-database-compression-with-a-pinch-of-security-considerations.aspx


<a id="2520"></a>
#### Trace Flag: 2520
**Undocumented trace flag**<br />
Function: For SQL Server prior 2005. Forces DBCC HELP to return syntax of undocumented DBCC statements.
If 2520/2588 is not turned on, DBCC HELP will refuse to give you the syntax stating: "No help available for DBCC statement 'undocumented statement'".
Also affects dbcc help ('?')<br />
Link: http://www.sqlskills.com/blogs/paul/dbcc-writepage/<br />
Scope: session only


<a id="2521"></a>
#### Trace Flag: 2521
**Undocumented trace flag**<br />
Function: SQL 7 SP2 - Facilitates capturing a Sqlservr.exe user-mode crash dump for postmortem analysis<br />
Link: None


<a id="2528"></a>
#### Trace Flag: 2528
Function: Disables parallel checking of objects by DBCC CHECKDB, DBCC CHECKFILEGROUP, and DBCC CHECKTABLE. By default, the degree of parallelism is automatically determined by the query processor.
The maximum degree of parallelism is configured just like that of parallel queries. For more information, see [Configure the max degree of parallelism Server Configuration Option](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option).
**Note: Parallel DBCC checks should typically be enabled (default). The query processor reevaluates and automatically adjusts parallelism for each table or batch of tables checked by DBCC CHECKDB.**
The typical use scenario is when a system administrator knows that server load will increase before DBCC CHECKDB completes, and so chooses to manually decrease or disable parallelism, in order to increase concurrency with other user workload. However, disabling parallel checks in DBCC CHECKDB can cause it to take longer to complete.
**Note: If DBCC CHECKDB is executed using the TABLOCK option and parallelism is disabled, tables may be locked for longer periods of time.**
**Note: Starting with SQL Server 2014 (12.x) SP2, a MAXDOP option is available to override the max degree of parallelism configuration option of sp_configure for the DBCC statements.**
Link: [Docs Trace Flags]<br />
Link: http://www.sqlskills.com/blogs/paul/checkdb-from-every-angle-how-long-will-checkdb-take-to-run<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-2528/<br />
Scope: global or session


<a id="2529"></a>
#### Trace Flag: 2529
**Undocumented trace flag**<br />
Function: Displays memory usage for DBCC commands when used with TF 3604<br />
Link: None


<a id="2536"></a>
#### Trace Flag: 2536
**Undocumented trace flag**<br />
Function: Allows you to see inactive records in transaction log using fn\_dblog.
Similar to trace flag 2537 for older version than SQL Server 2008.<br />
Link: http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog


<a id="2537"></a>
#### Trace Flag: 2537
**Undocumented trace flag**<br />
Function: By using this trace flag, function `fn_dblog()` will read both active and inactive portions of transaction log.<br />
Link: http://www.sqlsoldier.com/wp/sqlserver/day19of31daysofdisasterrecoveryhowmuchlogcanabackuplog<br />
Link: http://www.sqlskills.com/blogs/paul/finding-out-who-dropped-a-table-using-the-transaction-log<br />
Link: http://sqlserverandme.blogspot.ru/2014/03/how-to-view-transaction-log.html<br />
Link: https://www.sqlservergeeks.com/trace-flag-2537/<br />
Scope: session only


<a id="2540"></a>
#### Trace Flag: 2540
**Undocumented trace flag**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2541"></a>
#### Trace Flag: 2541
**Undocumented trace flag**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2542"></a>
#### Trace Flag: 2542
**Undocumented trace flag**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]<br />
Link: [Controlling SQL Server memory dumps]


<a id="2543"></a>
#### Trace Flag: 2543
**Undocumented trace flag**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2544"></a>
#### Trace Flag: 2544
**Undocumented trace flag**<br />
Function: Produces a full memory dump<br />
Link: [KB917825]<br />
Link: https://blogs.msdn.microsoft.com/askjay/2010/02/05/how-can-i-create-a-dump-of-sql-server<br />
Link: https://social.msdn.microsoft.com/Forums/sqlserver/en-US/13ce4292-b8a7-41fa-a173-645693957d70/sqldumper?forum=sqldisasterrecovery&forum=sqldisasterrecovery<br />
Link: [SQL Server Trace Flag 2544, Trace Flag 2546 and Trace Flag 2551]<br />
Scope: Session


<a id="2545"></a>
#### Trace Flag: 2545
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2546"></a>
#### Trace Flag: 2546
Function: Generates dump file for all threads of SQL Server (mini dump).<br />
Link: [KB917825]<br />
Link: https://blogs.msdn.microsoft.com/askjay/2010/02/05/how-can-i-create-a-dump-of-sql-server<br />
Link: https://social.msdn.microsoft.com/Forums/sqlserver/en-US/13ce4292-b8a7-41fa-a173-645693957d70/sqldumper?forum=sqldisasterrecovery&forum=sqldisasterrecovery<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/09/12/sql-server-2000-2005-2008-recoveryrollback-taking-longer-than-expected<br />
Link: [SQL Server Trace Flag 2544, Trace Flag 2546 and Trace Flag 2551]<br />
Scope: Session


<a id="2547"></a>
#### Trace Flag: 2547
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: [KB917825]


<a id="2548"></a>
#### Trace Flag: 2548
Function: Shrink will run faster with this trace flag if there are LOB pages that need conversion and/or compaction, because that actions will be skipped.<br />
Link: http://blogs.msdn.com/b/psssql/archive/2008/03/28/how-it-works-sql-server-2005-dbcc-shrink-may-take-longer-than-sql-server-2000.aspx


<a id="2549"></a>
#### Trace Flag: 2549
Function: Forces the `DBCC CHECKDB` command to assume each database file is on a unique disk drive but treating different physical files as one logical file.
`DBCC CHECKDB` command builds an internal list of pages to read per unique disk drive across all database files.
This logic determines unique disk drives based on the drive letter of the physical file name of each file.
**Note: Do not use this trace flag unless you know that each file is based on a unique physical disk.**
**Note: Although this trace flag improve the performance of the DBCC CHECKDB commands which target usage of the `PHYSICAL_ONLY` option, some users may not see any improvement in performance.
While this trace flag improves disk I/O resources usage, the underlying performance of disk resources may limit the overall performance of the DBCC CHECKDB command.**<br />
Link: [Minimizing the impact of DBCC CHECKDB]
Link: http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx<br />
Link: [KB2634571]<br />
Link: https://support.microsoft.com/kb/2732669<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="2550"></a>
#### Trace Flag: 2550
**Undocumented trace flag**<br />
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2551"></a>
#### Trace Flag: 2551
**Undocumented trace flag**<br />
Function: Produces a filtered memory dump<br />
Link: [KB917825]<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/477863/sql-server-is-terminating-because-of-fatal-exception-c0150014<br />
Link: [Let’s talk about trace flags]<br />
Link: [SQL Server Trace Flag 2544, Trace Flag 2546 and Trace Flag 2551]<br />
Scope: Session


<a id="2552"></a>
#### Trace Flag: 2552
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2553"></a>
#### Trace Flag: 2553
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2554"></a>
#### Trace Flag: 2554
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2555"></a>
#### Trace Flag: 2555
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2556"></a>
#### Trace Flag: 2556
Function: Unknown, but related to controlling the contents of a
memory dump<br />
Link: [KB917825]


<a id="2557"></a>
#### Trace Flag: 2557
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2558"></a>
#### Trace Flag: 2558
Function: Disables integration between CHECKDB and Watson<br />
Link: [KB917825]<br />
Link: [Controlling SQL Server memory dumps]


<a id="2559"></a>
#### Trace Flag: 2559
Function: Unknown, but related to controlling the contents of a memory dump<br />
Link: [KB917825]


<a id="2562"></a>
#### Trace Flag: 2562
Function: Runs the `DBCC CHECKDB` command in a single "batch" regardless of the number of indexes in the database.
By default, the `DBCC CHECKDB` command tries to minimize TempDB resources by limiting the number of indexes or "facts" that it generates by using a "batches" concept.
But this trace flag forces all processing into one batch.
One effect of using this trace flag is that the space requirements for TempDB may increase. TempDB may grow to as much as 5% or more of the user database that is being processed by the DBCC CHECKDB command.
**Note: Although this trace flag improve the performance of the DBCC CHECKDB commands which target usage of the `PHYSICAL_ONLY` option, some users may not see any improvement in performance. While this trace flag improves disk I/O resources usage, the underlying performance of disk resources may limit the overall performance of the DBCC CHECKDB command.**<br />
Link: [Minimizing the impact of DBCC CHECKDB]
Link: http://blogs.msdn.com/b/saponsqlserver/archive/2011/12/22/faster-dbcc-checkdb-released-in-sql-2008-r2-sp1-traceflag-2562-amp-2549.aspx<br />
Link: [KB2634571]<br />
Link: https://support.microsoft.com/kb/2732669<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="2566"></a>
#### Trace Flag: 2566
Function: Runs the `DBCC CHECKDB` command without data purity check unless `DATA_PURITY` option is specified.<br />
**Note: Column-value integrity checks are enabled by default and do not require the DATA_PURITY option.
For databases upgraded from earlier versions of SQL Server, column-value checks are not enabled by default until `DBCC CHECKDB WITH DATA_PURITY` has been run error free on the database at least once.
After this, `DBCC CHECKDB` checks column-value integrity by default.**<br />
Link: [Docs Trace Flags]<br />
Link: [Minimizing the impact of DBCC CHECKDB]<br />
Link: https://support.microsoft.com/kb/2888996<br />
Link: [KB2964518]<br />
Scope: global only


<a id="2588"></a>
#### Trace Flag: 2588
Function: For SQL Server since 2005. Forces DBCC HELP to return syntax of undocumented DBCC statements.
If 2520/2588 is not turned on, DBCC HELP will refuse to give you the syntax stating: "No help available for DBCC statement 'undocumented statement'".
Also affects dbcc help ('?')<br />
Link: http://www.sqlskills.com/blogs/paul/dbcc-writepage/<br />
Scope: session only


<a id="2592"></a>
#### Trace Flag: 2592
Function: When used in conjunction with trace flag [3656](#3656), enables symbol resolution on stack dumps when the Debugging Tools for Windows are installed.
For more information, see this [Microsoft Whitepaper](https://www.microsoft.com/download/details.aspx?id=26666).<br />
**WARNING: This is a debugging trace flag and not meant for production environment use.**<br />
**Note: This trace flag applies to SQL Server 2019 (15.x) and higher builds.**<br/>
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="2701"></a>
#### Trace Flag: 2701
Function: SQL 6.5 - Sets the `@@ERROR` system function to 50000 for `RAISERROR` messages with severity levels of 10 or less. When disabled, sets the @@ERROR system function to 0 for RAISERROR messages with severity levels of 10 or less<br />
Link: None


<a id="2861"></a>
#### Trace Flag: 2861
**Undocumented trace flag**<br />
**TF2861 only exists in SQL Server 2000 SP3 and SP4, was removed before 2005 shipped, and if you’re using it now you’re definitely incorrect and should removed it from your startup parameters/application code that enables it.**
Function: Keep zero cost plans in cache. Tip: Avoid Using Trace Flag 2861 to Cache Zero-Cost Query Plan<br />
Link: http://www.seangallardy.com/trace-flag-2861-the-trace-flag-the-myth-the-legend/<br />
Link: https://web.archive.org/web/20121008074923/http://support.microsoft.com/kb/325607<br />
Scope: global only


#### Trace Flag: 2880
Function: Both 2880 and 2881 are related to a SQL 2000 hotfix introduced to solve problems where ad-hoc queries would cause the procedure cache to get too big<br />
Link: None


#### Trace Flag: 2881
Function: Both 2880 and 2881 are related to a SQL 2000 hotfix introduced to solve problems where ad-hoc queries would cause the procedure cache to get too big<br />
Link: None


<a id="3001"></a>
#### Trace Flag: 3001
Function: Stops sending backup entries into MSDB<br />
Link: https://bytes.com/topic/sql-server/answers/162385-how-do-i-prevent-sql-2000-posting-message-event-viewer-application-log


<a id="3004"></a>
#### Trace Flag: 3004
Function: Returns more info about Instant File Initialization. Shows information about backups and file creations use with [3605](#3605) to direct to error log.
Can be used to ensure that SQL Server has been configured to take advantage of IFI correctly.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/01/23/how-it-works-what-is-restorebackup-doing/<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://blogs.msdn.microsoft.com/sql_pfe_blog/2009/12/22/how-and-why-to-enable-instant-file-initialization/<br />
Link: [Undocumented Trace Flags: Inside the Restore Process]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3004/<br />
Scope: session only


<a id="3014"></a>
#### Trace Flag: 3014
Function: Returns more info about backups to the errorlog: Backup activity, Restore activity, File creation.<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/02/06/how-it-works-how-does-sql-server-backup-and-restore-select-transfer-sizes<br />
Link: [Undocumented Trace Flags: Inside the Restore Process]<br />
Link: [What’s CHECKDB doing in my database restore?]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3014/<br />
Scope: session only


<a id="3023"></a>
#### Trace Flag: 3023
<a id="3023"></a>
Function: Enables `CHECKSUM` option as default for `BACKUP` command.<br />
**Note: Beginning with SQL Server 2014 this behavior is controlled by setting the backup checksum default configuration option.
For more information, see [Server Configuration Options (SQL Server)](https://msdn.microsoft.com/en-us/library/ms189631.aspx)**.<br />
Link: https://support.microsoft.com/kb/2656988<br />
Link: [Docs Trace Flags]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3023/<br />
Scope: global or session


<a id="3028"></a>
#### Trace Flag: 3028
Function: Enables a hotfix for a problem encountered when backing up to tape with specific backup options<br />
Link: None


<a id="3031"></a>
#### Trace Flag: 3031
Function: SQL 9 - Will turn the NO_LOG and TRUNCATE_ONLY options into checkpoints in all recovery modes<br />
Link: http://www.sqlskills.com/blogs/paul/backup-log-with-no_log-use-abuse-and-undocumented-trace-flags-to-stop-it


<a id="3034"></a>
#### Trace Flag: 3034
Function: Overrides the server default, and thus always forces backup compression unless the backup command had the no_compression clause explicitly present.<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/02/24/vdi-backups-and-backup-compression-default


<a id="3035"></a>
#### Trace Flag: 3035
Function: Overrides the server default to always avoid compression, unless the backup command explicitly uses the compression clause. If both 3034 and 3035 are enabled, 3035 takes precedence<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/02/24/vdi-backups-and-backup-compression-default


<a id="3039"></a>
#### Trace Flag: 3039
Function: As long as the SQL edition supports backup compression, this will allow VDI backups to be affected by the default compression setting just as non-VDI BACKUP commands are affected.<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/02/24/vdi-backups-and-backup-compression-default


<a id="3042"></a>
#### Trace Flag: 3042
Function: Bypasses the default backup compression pre-allocation algorithm to allow the backup file to grow only as needed to reach its final size. This trace flag is useful if you need to save on space by allocating only the actual size required for the compressed backup. Using this trace flag might cause a slight performance penalty (a possible increase in the duration of the backup operation).
For more information about the pre-allocation algorithm, see [Backup Compression (SQL Server)](https://msdn.microsoft.com/en-us/library/bb964719.aspx).<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/2001026<br />
Link: https://blogs.msdn.microsoft.com/psssql/2011/08/11/how-compressed-is-your-backup/<br />
Link: https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/backup-compression-sql-server<br />
Link: https://sqlstudies.com/2017/03/16/compressed-backup-errors-and-tf-3042/<br />
Scope: global only


<a id="3051"></a>
#### Trace Flag: 3051
Function: Enables SQL Server Backup to URL logging to a specific error log file.<br />
Link: [Docs Trace Flags]<br />
Link: https://msdn.microsoft.com/en-us/library/jj919149.aspx<br />
Scope: global only


<a id="3057"></a>
#### Trace Flag: 3057
Function: Enables functionality after a hotfix that allows a log backup that was taken on a t-logfile hosted on a drive with “Bytes per physical sector”=512 to be restored onto a log file/drive that has “Bytes per physical sector”=4096<br />
Link: https://support.microsoft.com/kb/2987585


<a id="3101"></a>
#### Trace Flag: 3101
Function: Fix performance problems when restoring database with CDC<br />
Link: https://support.microsoft.com/kb/2567366


<a id="3104"></a>
#### Trace Flag: 3104
Function: Causes SQL Server to bypass checking for free space<br />
Link: http://sqlblogcasts.com/blogs/martinbell/archive/2011/07/06/Mount-point-Permission-Issues.aspx<br />
Link: http://www.databasejournal.com/features/mssql/article.php/1547551/Troubleshooting-SQL-Server-BackupRestore-Problems.htm


<a id="3106"></a>
#### Trace Flag: 3106
Function: Required to move sys databases<br />
Link: None


<a id="3111"></a>
#### Trace Flag: 3111
Function: “FIX: Backup or Restore Using Large Transaction Logs May Return Error 3241” Causes LogMgr::ValidateBackedupBlock to be skipped during backup and restore operations, allowing backups of very large T-logs to succeed.<br />
Link: None


<a id="3117"></a>
#### Trace Flag: 3117
Function: QL 9 - SQL Server 2005 tries to restore the log files and the data files in a single step which some third-party snapshot backup utilities do not support. Turing on 3117 does things the SQL 8 way multiple-step restore process.<br />
Link: None


<a id="3205"></a>
#### Trace Flag: 3205
Function: Disable HW compression for backup to tape drives<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="3207"></a>
#### Trace Flag: 3207
Function: Fixes SQL 6.5 so that tape drives work correctly with DUMP and LOAD statements<br />
Link: None


<a id="3210"></a>
#### Trace Flag: 3210
Function: According to Bob Ward’s PASS 2014 talk on SQL Server IO, prints information about “collisions and wait times” that occur between the various “Asynchronous Disk Pool” threads during BACKUP (what about RESTORE?) operations.<br />
Link: None


<a id="3212"></a>
#### Trace Flag: 3212
Function: Prints “Backup stats” to the SQL log<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/24/why-does-restoring-a-database-needs-tempdb


<a id="3213"></a>
#### Trace Flag: 3213
Function: Output buffer info for backups to ERRORLOG<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/02/06/how-it-works-how-does-sql-server-backup-and-restore-select-transfer-sizes<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/01/28/how-it-works-sql-server-backup-buffer-exchange-a-vdi-focus/<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-3213/<br />
Scope: global or session


<a id="3216"></a>
#### Trace Flag: 3216
Function: Prints quite a lot of info about RESTORE internals. Only seems to print to the error log (TF 3605 is required).<br />
Link: http://jamessql.blogspot.ru/2013/07/trace-flag-for-backup-and-restore.html


<a id="3222"></a>
#### Trace Flag: 3222
Function: Disables the read ahead that is used by the recovery operation during roll forward operations<br />
Link: [TECHNET List Of SQL Server Trace Flags]


<a id="3226"></a>
#### Trace Flag: 3226
Function: By default, every successful backup operation adds an entry in the SQL Server error log and in the system event log.
If you create very frequent log backups, these success messages accumulate quickly, resulting in huge error logs in which finding other messages is problematic.
With this trace flag, you can suppress these log entries. This is useful if you are running frequent log backups and if none of your scripts depend on those entries.<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlskills.com/blogs/paul/fed-up-with-backup-success-messages-bloating-your-error-logs<br />
Link: https://blogs.msdn.microsoft.com/sqlserverstorageengine/2007/10/30/when-is-too-much-success-a-bad-thing<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3226/<br />
Scope: global only


<a id="3231"></a>
#### Trace Flag: 3231
Function: SQL 8/9 - Will turn the NO_LOG and TRUNCATE_ONLY options into no-ops in FULL/BULK_LOGGED recovery mode, and will clear the log in SIMPLE recovery mode. When set, BACKUP LOG with TRUNCATE_ONLY and BACKUP LOG with NO_LOG do not allow a log backup to run if the database's recovery model is FULL or BULK_LOGGED.<br />
Link: http://www.sqlskills.com/blogs/paul/backup-log-with-no_log-use-abuse-and-undocumented-trace-flags-to-stop-it<br />
Link: http://www.sqlskills.com/blogs/kimberly/understanding-backups-and-log-related-trace-flags-in-sql-server-20002005-and-2008<br />
Scope: ?


<a id="3282"></a>
#### Trace Flag: 3282
**Undocumented trace flag**<br />
Function: SQL 6.5 - Used after backup restoration fails<br />
Scope: ?


<a id="3400"></a>
#### Trace Flag: 3400
Function: Prints the recovery timings<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/392158/recovery-portion-of-sql-2008-restore-takes-much-longer-than-normal-when-restoring-from-sql-2005-backup


<a id="3408"></a>
#### Trace Flag: 3408
Function: This forces SQL Server startup to use a single thread when recovering all DBs at SQL Server startup, instead of running through its algorithm for determining how many threads to allocate to DB recovery<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/08/how-much-is-crash-recovery-parallelized-in-which-order-are-databases-recovered/


<a id="3412"></a>
#### Trace Flag: 3412
**Undocumented trace flag**<br />
Function: The KB article refers to SQL 6.5, but it is possible that the TF still prints out info to the SQL error log, so leaving it here for now. KB: “...reports when each transaction
is rolled forward or back [examine the error log for progress]. However, you will not see any progress if SQL Server is rolling a large transaction forward or back. Additionally, this trace flag duplicates 
the sp_configure setting Recovery flags..."<br />
Link: None


<a id="3422"></a>
#### Trace Flag: 3422
Function: Cause auditing of transaction log records as they're read (during transaction rollback or log recovery).
This is useful because there is no equivalent to page checksums for transaction log records and so no way to detect whether log records are being corrupted e careful with these trace flags - I don't recommend using them unless you are experiencing corruptions that you can't diagnose.
Turning them on will cause a big CPU hit because of the extra auditing that's happening.<br />
Link: https://support.microsoft.com/kb/215458<br />
Link: http://www.sqlskills.com/blogs/paul/how-to-tell-if-the-io-subsystem-is-causing-corruptions<br />
Link: http://technet.microsoft.com/en-au/library/cc917726.aspx<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Scope: ?


<a id="3427"></a>
#### Trace Flag: 3427
Function: Enables fix for issue when many consecutive transactions inserting data into temp table in SQL Server 2016 consume more CPU than in SQL Server 2014.
Another change in SQL Server 2016 behavior that could impact tempdb-heavy workloads has to do with Common Criteria Compliance (CCC), also known as C2 auditing.
We introduced functionality to allow for transaction-level auditing in CCC which can cause some additional overhead, particularly in workloads that do heavy inserts and updates in temp tables
Unfortunately, this overhead is incurred whether you have CCC enabled or not. In SQL Server 2016 you can enable trace flag 3427 to bypass this overhead starting with SP1 CU2. Starting in SQL Server 2017 CU4, we automatically bypass this code if CCC is disabled.<br />
**Note: This trace flag applies to SQL Server 2016 (13.x) SP1 CU2 through SQL Server 2016 (13.x) SP2 CU2. Starting with SQL Server 2016 (13.x) SP2 CU3 and SQL Server 2017 (14.x), this trace flag has no effect.**<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3216543<br />
Link: [TEMPDB – Files and Trace Flags and Updates]<br />
Scope: global only


<a id="3448"></a>
#### Trace Flag: 3448
Function: Introduced in the KB to fix a race condition leading to a hung database in mirroring failover situations. “ This trace flag forces new connections to keep checking for 
database state every two seconds instead of waiting for a lock for infinite time. It helps ending the connection tasks faster as the mirroring reac
hes the start of the recovery phase and releasing more worker threads to be used by database mirroring.”<br />
Link: https://support.microsoft.com/kb/2970421


<a id="3449"></a>
#### Trace Flag: 3449
Function: If you enable global TF 3449 (and you are on SQL Server 2012 SP3 CU3 or later or SQL Server 2014 SP1 CU7 or later),
you will get much better performance by avoiding a FlushCache call in a number of different common scenarios, such as backup database,
backup transaction log, create database, add a file to a database, restore a transaction log, recover a database, shrink a database file, and a SQL Server “graceful” shutdown.<br />
Link: https://support.microsoft.com/kb/3158396<br />
Link: https://blogs.msdn.microsoft.com/psssql/2017/06/29/sql-server-large-ram-and-db-checkpointing/<br />
Link: [Hidden Performance & Manageability Improvements in SQL Server 2012 / 2014]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="3459"></a>
#### Trace Flag: 3459
Function: Disables parallel redo.
Assume that you use an Always On availability group (AG) that contains heap tables.
Starting in SQL Server 2016, parallel thread for redo operations is used in secondary replicas.
In this case, heap tables redo operation may generate a runtime assert dump or the SQL Server may crash with an access violation error in some cases.<br />
**Note: This trace flag applies to SQL Server 2016 (13.x), SQL Server 2017 (14.x), and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3200975<br />
Link: https://support.microsoft.com/kb/4101554<br />
Link: https://support.microsoft.com/kb/4339858<br />
Scope: global only


<a id="3468"></a>
#### Trace Flag: 3468
Function: Disables [indirect checkpoints](https://docs.microsoft.com/en-us/sql/relational-databases/logs/database-checkpoints-sql-server?view=sql-server-2017#IndirectChkpt) on `tempdb`.<br />
**Note: This trace flag applies to SQL Server 2016 (13.x) SP1 CU5, SQL Server 2017 (14.x) CU1 and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Link: https://techcommunity.microsoft.com/t5/SQL-Server/Indirect-Checkpoint-and-tempdb-8211-the-good-the-bad-and-the-non/bc-p/851152#M1351
Scope: global only


<a id="3499"></a>
#### Trace Flag: 3499
**Undocumented trace flag**<br />
Function: Provides a workaround for doing a rolling upgrade from SQL 2005 to SQL 2008 with a DB that has a full-text index<br />
Link: None


<a id="3502"></a>
#### Trace Flag: 3502
**Undocumented trace flag**<br />
Function: Write checkpoint start and end messages in the SQL Server error log.<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://blogs.msdn.microsoft.com/joaol/2008/11/20/sql-server-checkpoint-problems/<br />
Link: [A SQL Server DBA myth a day: (15/30) checkpoint only writes pages from committed transactions]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3502/<br />
Scope: session only


<a id="3503"></a>
#### Trace Flag: 3503
**Undocumented trace flag**<br />
Function: Indicates whether the checkpoint at the end of automatic recovery was skipped for a database (this applies only to read-only databases)<br />
Link: http://www.sql-server-performance.com/2002/traceflags/


<a id="3504"></a>
#### Trace Flag: 3504
**Undocumented trace flag**<br />
Function: writes to the error log information about what is written to disk.
For internal testing. Will raise a bogus log-out-of-space condition from checkpoint.<br />
Link: https://blogs.msdn.microsoft.com/joaol/2008/11/20/sql-server-checkpoint-problems/<br />
Link: [A SQL Server DBA myth a day: (15/30) checkpoint only writes pages from committed transactions]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3504/<br />
Link: https://www.sqlshack.com/sql-server-checkpoint-lazy-writer-eager-writer-and-dirty-pages-in-sql-server/<br />
Link: https://docs.microsoft.com/en-us/archive/blogs/psssql/how-it-works-when-is-the-flushcache-message-added-to-sql-server-error-log<br />
Scope: session only


<a id="3505"></a>
#### Trace Flag: 3505
**Undocumented trace flag**<br />
Function: Disables automatic checkpoints.
Setting trace flag 3505 may increase recovery time and can prevent log space reuse until the next checkpoint is issued.
Make sure to issue manual checkpoints on all read/write databases at appropriate time intervals.
"For high availability systems, such as clusters, Microsoft recommends that you do not change the recovery interval because it may affect data safety and availability."<br />
Link: http://www.sqlskills.com/blogs/paul/benchmarking-1-tb-table-population-part-2-optimizing-log-block-io-size-and-how-log-io-works/<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3505/<br />
Scope: global only


<a id="3601"></a>
#### Trace Flag: 3601
Function: Appears to disable CPU instruction prefetching. The Blog post to the right uses it, in concert with 3603, to enable SQL 2000 to run on a machine with a # of processors that is *not* a power of 2<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2009/05/27/info-sql-2000-msde-installation-will-fail-if-you-have-number-of-cpus-on-a-box-which-is-not-in-power-of-2


<a id="3602"></a>
#### Trace Flag: 3602
Function: Records all error and warning messages sent to the client<br />
Link: https://support.microsoft.com/kb/199037


<a id="3603"></a>
#### Trace Flag: 3603
Function: Disables “Simultaneous Multithreading Processor check”. Used in concern with TF 3601 in the blog post to the right to enable SQL 2000 to run on a machine with a # of processors that is *not* a power of 2<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2009/05/27/info-sql-2000-msde-installation-will-fail-if-you-have-number-of-cpus-on-a-box-which-is-not-in-power-of-2


<a id="3604"></a>
#### Trace Flag: 3604
**Undocumented trace flag**<br />
Function: Enables the output from a large number of trace flags and DBCC commands to be sent back to the client.
The Connect issue notes that problems can occur when using 3604 with a query that executes across a linked server.
[This CSS page](https://blogs.msdn.microsoft.com/psssql/2009/05/11/how-do-i-determine-which-dump-triggers-are-enabled/) points out that 3604 is necessary for DBCC DumpTrigger(‘display’)<br />
Link: http://blogs.msdn.com/b/askjay/archive/2011/01/21/why-do-we-need-trace-flag-3604-for-dbcc-statements.aspx<br />
Link: [Internals of the Seven SQL Server Sorts – Part 1]<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/306380/trace-flag-issue-7300-3604<br />
Link: [How to Find the Statistics Used to Compile an Execution Plan]<br />
Link: [A Row Goal Riddle]<br />
Link: [Undocumented Trace Flags: Inside the Restore Process]<br />
Link: [What’s CHECKDB doing in my database restore?]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3604/<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: session only


<a id="3605"></a>
#### Trace Flag: 3605
Function: Sends a variety of types of information to the SQL Server error log instead of to the user console.
Often referenced in KB and blog articles in the context of other trace flags (e.g. 3604).<br />
Link: https://blogs.msdn.microsoft.com/askjay/2011/01/21/why-do-we-need-trace-flag-3604-for-dbcc-statements/<br />
Link: [Undocumented Trace Flags: Inside the Restore Process]<br />
Link: [What’s CHECKDB doing in my database restore?]<br />
Link: https://www.sqlservergeeks.com/sql-server-trace-flag-3605/<br />
Scope: session only


<a id="3607"></a>
#### Trace Flag: 3607
Function: Skip recovery on startup<br />
Link: http://sqlkbs.blogspot.se/2008/01/trace-flag.html<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/24/why-does-restoring-a-database-needs-tempdb/


<a id="3608"></a>
#### Trace Flag: 3608
Function: Prevents SQL Server from automatically starting and recovering any database except the master database.
If activities that require TempDB are initiated, then model is recovered and TempDB is created. Other databases will be started and recovered when accessed.
Some features, such as snapshot isolation and read committed snapshot, might not work. Use for [Move System Databases](https://docs.microsoft.com/en-us/sql/relational-databases/databases/move-system-databases?view=sql-server-2017) and [Move User Databases](https://docs.microsoft.com/en-us/sql/relational-databases/databases/move-user-databases?view=sql-server-2017).<br />
**Note: Do not use during normal operation.**<br />
Link: [Docs Trace Flags]<br />
Link: [Importance of Performing DBCC CHECKDB on all SQL Server Databases]<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/24/why-does-restoring-a-database-needs-tempdb<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-3608/<br />
Scope: global only


<a id="3609"></a>
#### Trace Flag: 3609
Function: Recovering all databases, but not clearing tempdb<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/<br />
Link: [Importance of Performing DBCC CHECKDB on all SQL Server Databases]<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/24/why-does-restoring-a-database-needs-tempdb<br />
Scope: global only


<a id="3610"></a>
#### Trace Flag: 3610
Function: SQL 9 - Divide by zero to result in NULL instead of error<br />
Link: None


<a id="3614"></a>
#### Trace Flag: 3614
Function: Modifies the order of startup operations so that SQL Server can successfully start up even if many user connections are being attempted during SQL startup<br />
Link: None


<a id="3618"></a>
#### Trace Flag: 3618
**Undocumented trace flag**<br />
Function: Disable the new Metadata-Only Column Changes in SQL Server 2016 and upper versions.
This trace flag is not effective when used at the session level.
There is no way to specify a query-level trace flag with an `ALTER COLUMN` command.<br />
Link: https://sqlperformance.com/2020/04/database-design/new-metadata-column-changes-sql-server-2016<br />
Scope: globa only


<a id="3625"></a>
#### Trace Flag: 3625
Function: Limits the amount of information returned to users who are not members of the sysadmin fixed server role, by masking the parameters of some error messages using '******'.
This can help prevent disclosure of sensitive information.<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="3626"></a>
#### Trace Flag: 3626
Function: Turns on tracking of the CPU data for the sysprocesses table.<br />
Link: None


<a id="3628"></a>
#### Trace Flag: 3628
Function: CSS’s mysterious description: “Includes ‘other errors’ in the dump based on a severity.”<br />
Link: [Controlling SQL Server memory dumps]


<a id="3629"></a>
#### Trace Flag: 3629
Function: CSS: A memory dump will “include messages marked to include with this trace flag enabled.”<br />
Link: [Controlling SQL Server memory dumps]


<a id="3635"></a>
#### Trace Flag: 3635
Function: Print diagnostic information. Trace Flag 3635 Diagnostics are written to the console that started it.
There are not written to the errorlog, even if 3605 is turned on.<br />
Link: None


<a id="3640"></a>
#### Trace Flag: 3640
Function: Eliminates sending DONE_IN_PROC messages to client for each statement in stored procedure. This is similar to the session setting of SET NOCOUNT ON, but when set as a trace flag, every client session is handled this way.<br />
Link: https://blogs.msdn.microsoft.com/selvar/2010/07/13/delete-operation-from-a-reporting-service-2005-report-manager-fails-with-internalcatalogexception-and-throws-watson-mini-dump


<a id="3651"></a>
#### Trace Flag: 3651
**Undocumented trace flag**<br />
Function: Can cause stack dumps. For one query, this resulted in a parallel plan significantly more expensive than the naturally occurring serial plan.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="3654"></a>
#### Trace Flag: 3654
Function: Apparently increases info found in the sys.dm_os_memory_allocations DMV (which appears to have replaced the DBCC MEMOBJLIST command) Bob Ward also discusses it in his PASS 2013 session, saying that it turns on tracing for all memory allocations done by “Memory Objects” (a specific SQLOS memory term). This flag will have a significant impact on system performance.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/11/12/how-can-reference-counting-be-a-leading-memory-scribbler-cause<br />
Link: https://blogs.msdn.microsoft.com/slavao/2005/08/30/talking-points-around-memory-manager-in-sql-server-2005<br />
Link: https://support.microsoft.com/kb/2888658


<a id="3656"></a>
#### Trace Flag: 3656
Function: Enables symbol resolution on stack dumps when the Debugging Tools for Windows are installed.
For more information, see this [Microsoft Whitepaper](https://www.microsoft.com/en-us/download/details.aspx?id=26666).<br />
**WARNING: This is a debugging trace flag and not meant for production environment use.**<br />
Link: [Docs Trace Flags]<br />
Link: http://sqlcat.com/sqlcat/b/msdnmirror/archive/2010/05/11/resolving-dtc-related-waits-and-tuning-scalability-of-dtc.aspx<br />
Link: [Controlling SQL Server memory dumps]<br />
Link: http://www.sqlskills.com/blogs/paul/determine-causes-particular-wait-type<br />
Scope: global or session


<a id="3659"></a>
#### Trace Flag: 3659
Function: Enables logging all errors to error log during server startup<br />
Link: http://spaghettidba.com/2011/05/20/trace-flag-3659/<br />
Link: [Change SQL Server Collation – Back to Basics]<br />
Scope: global only


<a id="3660"></a>
#### Trace Flag: 3660
Function: W/o this flag, for DBs that have Auto_Close=true and for DBs on Express Edition, DB recovery is normally deferred until first user access when SQL starts up. This TF forces 
DB recovery to always run (well, only for DBs that actually need recovery done) at SQL Server startup.<br />
Link: https://blogs.msdn.microsoft.com/ialonso/2012/10/08/how-much-is-crash-recovery-parallelized-in-which-order-are-databases-recovered


<a id="3663"></a>
#### Trace Flag: 3663
Function: CSS: “By default [SQL Server] allows system cache involvement [with writing to the SQL Error log] to avoid some of the performance issues you might be suspecting, but you can force it to use FILE_FLAG_WRITE_THROUGH” with TF 3663<br />
Link: http://blogs.msdn.com/b/psssql/archive/2011/01/07/discussion-about-sql-server-i-o.aspx


<a id="3688"></a>
#### Trace Flag: 3688
Function: Removes messages to error log about traces started and stopped<br />
Link: https://support.microsoft.com/kb/922578


<a id="3689"></a>
#### Trace Flag: 3689
Function: Logs extended errors to errorlog when network disconnect occurs, turned off by default. Will dump out the socket error code this can sometimes give you a clue as to the root cause.<br />
Link: https://support.microsoft.com/kb/922578


<a id="3701"></a>
#### Trace Flag: 3701
Function: Unknown<br />
Link: [Upgrading an expired SQL Server 2016 Evaluation Edition]


<a id="3801"></a>
#### Trace Flag: 3801
Function: Prohibits use of USE DB statement<br />
Link: None


<a id="3861"></a>
#### Trace Flag: 3861
Function: This flag allows the SQL Server DB startup code to move system tables to the primary filegroup.
Introduced due to behavior in the SQL 2014 upgrade process, where system tables could be created in a secondary filegroup (if that FG was the default).<br />
Link: https://support.microsoft.com/kb/3003760


<a id="3895"></a>
#### Trace Flag: 3895
**Undocumented trace flag**<br />
Function: In SQL Server 2019, when you enable the [Memory-Optimized TempDB Metadata](https://docs.microsoft.com/en-us/sql/relational-databases/databases/tempdb-database) feature, this trace flag is automatically enabled after the next restart.
When you disable that feature, the trace flag is automatically removed after the next restart.
Also if you add race flag 3895 to startup parameters after restarting SQL Server option `IsTempdbMetadataMemoryOptimized` will be enabled.<br />
Link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_3895.sql<br />
Scope: global only


<a id="3913"></a>
#### Trace Flag: 3913
Function: SQL 7/8 - SQL Server does not update the rowcnt column of the sysindexes system table until the transaction is committed. When turned on the optimizer gets row count information from in-memory metadata that is saved to sysindexes system table when the transaction commits.<br />
Link: None


<a id="3917"></a>
#### Trace Flag: 3917
Function: According to Bob Ward’s PASS 2014 SQL Server IO talk, enables trace output (3605 is required) for the Eager Write functionality that is used with bulk logged operations (such as SELECT INTO)<br />
Link: None


<a id="3923"></a>
#### Trace Flag: 3923
Function: Let SQL Server throw an exception to the application when the 3303 warning message is raised<br />
Link: https://support.microsoft.com/kb/3014867


<a id="3924"></a>
#### Trace Flag: 3924
Function: Enables automatic removal of orphaned DTC transactions with `SPID=-2`, which is a problem for some 3rd party transaction monitors.<br />
Link: https://support.microsoft.com/kb/4519668<br />
Link: https://support.microsoft.com/kb/4511816<br />
Scope: global only


<a id="3940"></a>
#### Trace Flag: 3940
Function: According to Bob Ward’s PASS 2014 SQL Server IO talk, forces the Eager Write functionality to throttle at 1024 outstanding eager writes.<br />
Link: None


<a id="3979"></a>
#### Trace Flag: 3979
**Undocumented trace flag**<br />
Function: **Request Fua Writes**.
SQL Server opens database data and log files with FILE_FLAG_WRITE_THROUGH, mapping to O_DSYNC in the Host Extension, asking for Fua writes. 
Linux Default: Trace flag considered **Off**
Windows Default: Trace flag considered **On **
**The trace flag does not apply to SQL Server on Linux SQL 2017 RTM thru CU5.  The behavior is assumed enabled prior to CU 6.
**The trace flag does not apply to Windows.  On Windows it is always assumed to be enabled.**
On Linux, you need a file system that provides `DpuFua=1` enabled or you have confirmed your system is O_DIRECT safe.
By enabling the trace flag you disable the batch flush requests from SQL Server and are trusting SQLPAL, HE and the I/O subsystem configuration to achieve durability.<br />
Link: [SQL Server On Linux: Forced Unit Access (Fua) Internals]<br />
Scope: global


<a id="3982"></a>
#### Trace Flag: 3982
**Undocumented trace flag**<br />
Function: **Avoid Fua Writes**.
Forces SQL Server to open database data and log files without `FILE_FLAG_WRITE_THROUGH` and issue the `FlushFileBuffers` calls to complete transactions and checkpoint activities.
Linux Default: Trace flag is considered **On**
Windows Default: Trace flag is considered **Off**
**Microsoft retains the policy that SQL Server should always be run on a system with stable media configurations.
The trace flag is NOT supported on Windows.**
[This article](https://support.microsoft.com/kb/86903) highlights these support boundaries.
It was written by David Campbell, Bob Ward, Keith Elmore and I many years ago and the forced flush feature does not alter the intent: “SQL Server requires systems to support ‘ guaranteed delivery to stable media ’ as outlined under the Microsoft SQL Server Always-On Storage Solution Review program.
For more information about the input and output requirements for the SQL Server database engine.
When running on Linux kernels or file systems that do not support optimized Fua capabilities.
The trace flag and forced flush behavior is intended to be a workaround for Linux installations until the SQL Server instance id deployed on a system providing optimized, Fua capabilities.<br />
Link: [SQL Server On Linux: Forced Unit Access (Fua) Internals]<br />
Scope: global


<a id="4001"></a>
#### Trace Flag: 4001
Function: Very verbose logging of each login attempt to the error log. Includes tons of information<br />
Link: None


<a id="4010"></a>
#### Trace Flag: 4010
Function: Allows only shared memory connections to the SQL Server. Meaning, you will only be able to connect from the server machine itself.
Client connections over TCP/IP or named pipes will not happen.<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2011/05/11/inf-hey-my-sql-server-service-is-not-starting-what-do-i-do<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/09/05/sql-server-2005-setup-fails-in-wow-x86-on-computer-with-more-than-32-cpus<br />
Link: [Upgrading an expired SQL Server 2016 Evaluation Edition]


<a id="4013"></a>
#### Trace Flag: 4013
Function: Trace flag 4013 write entries in error log whenever a new connection established.
These entries contain login name and SPID also.<br />
Link: http://sqlkbs.blogspot.se/2008/01/trace-flag.html<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-4013/<br />
Scope: global or session


<a id="4020"></a>
#### Trace Flag: 4020
Function: Boot without recover<br />
Link: None


<a id="4022"></a>
#### Trace Flag: 4022
Function: Directs the SQL instance to ignore stored procedures that have been configured as “auto-start” procedures. Their auto-start configuration is not affected, so the next time the instance is started w/o this flag they will return to their normal behavior.<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2011/05/11/inf-hey-my-sql-server-service-is-not-starting-what-do-i-do/<br />
Link: [Upgrading an expired SQL Server 2016 Evaluation Edition]<br />
Link: [Change SQL Server Collation – Back to Basics]<br />
Scope: global only


<a id="4029"></a>
#### Trace Flag: 4029
Function: Logs extended errors to errorlog when network disconnect occurs, turned off by default.
Will dump out the socket error code this can sometimes give you a clue as to the root cause.<br />
Link: https://blogs.msdn.microsoft.com/sql_protocols/2005/12/19/vss-sql-server-does-not-exist-or-access-denied


<a id="4030"></a>
#### Trace Flag: 4030
Function: Prints both a byte and ASCII representation of the receive buffer.
Used when you want to see what queries a client is sending to SQL Server.
You can use this trace flag if you experience a protection violation and want to determine which statement caused it.
Typically, you can set this flag globally or use SQL Server Enterprise Manager.
You can also use [DBCC INPUTBUFFER](https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-inputbuffer-transact-sql).<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-4030/<br />
Scope: global only


<a id="4031"></a>
#### Trace Flag: 4031
Function: Prints both a byte and ASCII representation of the send buffers (what SQL Server sends back to the client).
You can also use [DBCC OUTPUTBUFFER](https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-outputbuffer-transact-sql).<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-4031/<br />
Scope: global only


<a id="4032"></a>
#### Trace Flag: 4032
Function: Traces the SQL commands coming in from the client. When enabled with 3605 it will direct those all to the error log.<br />
Link: https://support.microsoft.com/kb/199037<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-4032/<br />
Scope: global only


<a id="4044"></a>
#### Trace Flag: 4044
Function: SA account can be unlocked by rebooting server with trace flag. If sa (or sso_role) password is lost, add this to your RUN_serverfile. This will generate new password when server started.<br />
Link: None


<a id="4052"></a>
#### Trace Flag: 4052
Function: SQL 9+ Prints TDS packets sent to the client (output) to console. Startup only.<br />
Link: None


<a id="4055"></a>
#### Trace Flag: 4055
Function: SQL 9+ Prints TDS packets received from the client to console. Startup only.<br />
Link: None


<a id="4101"></a>
#### Trace Flag: 4101
Function: “FIX: Reorder outer joins with filter criteria before non-selective joins and outer joins” Enabling this flag may increase the chance that selective filter criteria on an OUTER 
JOIN will influence the OJ earlier in the plan, rather than the more typical behavior of INNER JOINs being prioritized before OJs. Note that 4101 is also required to enable KB942444.<br />
Link: https://support.microsoft.com/kb/318530


<a id="4102"></a>
#### Trace Flag: 4102
Function: SQL 9 - Query performance is slow if the execution plan of the query contains semi join operators Typically, semi join operators are generated when the query contains the IN keyword or the EXISTS keyword. Enable flag 4102 and 4118 to overcome this.<br />
Link: https://support.microsoft.com/kb/946020


<a id="4103"></a>
#### Trace Flag: 4103
Function: “FIX: A query may take longer to run in SQL Server 2005 SP1 than it takes to run in the original release version of SQL Server 2005 or in SQL 
Server 2000” Applies particularly to queries that contain subqueries with “many column joins”.<br />
Link: None


<a id="4104"></a>
#### Trace Flag: 4104
Function: SQL 9 - Overestimating cardinality of JOIN operator. When additional join predicates are involved, this problem may increase the estimated cost of the JOIN operator to the point where the query optimizer chooses a different join order. When the query optimizer chooses a different join order, SQL 9 system performance may be slow.<br />
Link: None


<a id="4105"></a>
#### Trace Flag: 4105
Function: “FIX: The SQL Server 2005 query optimizer may incorrectly estimate the cardinality for a query that has a predicate that contains an index union alternative”<br />
Link: None


<a id="4106"></a>
#### Trace Flag: 4106
Function: “FIX: A query may take a long time to compile when the query contains several JOIN clauses against a SQL Server 2005 database”<br />
Link: None


<a id="4107"></a>
#### Trace Flag: 4107
Function: SQL 9 - When you run a query that references a partitioned table, query performance may decrease<br />
Link: None


<a id="4108"></a>
#### Trace Flag: 4108
Function: “FIX: The query performance is very slow when you use a fast forward-only cursor to run a query in SQL Server 2005”<br />
Link: None


<a id="4109"></a>
#### Trace Flag: 4109
Function: “FIX: Error message when you run a query that uses a fast forward-only cursor in SQL Server 2005: "Query processor could not produce a query plan because of the hints defined in this query”<br />
Link: https://support.microsoft.com/kb/926773


<a id="4110"></a>
#### Trace Flag: 4110
Function: “FIX: The query performance is slow when you run a query that uses a user-defined scalar function against an instance of SQL Server 2005”<br />
Link: None


<a id="4111"></a>
#### Trace Flag: 4111
Function: Fixes a cardinality estimate issue with an unnamed builtin function. The KB article title shows that the issue was initially hit due to timeouts with the Replication Merge agent, but the problem was ultimately a poor query plan.<br />
Link: None


<a id="4112"></a>
#### Trace Flag: 4112
Function: Enables a fix for a problem that occurs when a linked server from 2005 or 2008 targets SQL 2000: “This problem occurs because SQL Server 2005 generates an 
execution plan that has a remote query. SQL Server 2005 must execute the remote query against SQL Server 2000 to retrieve the required data. SQL Server 2000 cannot 
handle the remote query. Therefore, error 107 occurs in SQL Server 2000. Then, error 107 is propagated back to SQL Server 2005. Therefore, error 107 occurs in SQL Server 
2005, and error 8180 occurs in SQL Server 2005.”<br />
Link: https://support.microsoft.com/kb/936223


<a id="4115"></a>
#### Trace Flag: 4115
Function: “FIX: A query that you run by using a FORWARD_ONLY cursor takes alonger time to run in Microsoft SQL Server 2005 than in SQL Server 2000 ”The fix apparently increases the likelihood that a certain type of cursor will use an index seek (as it did in SQL 2000) rather than regressing to a scan for each Fetch. The notes also contain some interesting info about sp_cursoropen<br />
Link: None


<a id="4116"></a>
#### Trace Flag: 4116
Function: SQL 9 - Query runs slowly when using joins between a local and a remote table<br />
Link: None


<a id="4117"></a>
#### Trace Flag: 4117
Function: “FIX: A blocking issue occurs when you update rows in a table in SQL Server 2005...[A] problem occurs because the positioned update in a transaction performs a table scan on all involved tables. This behavior causes many update locks to be generated on many rows in the table. Additionally, SQL Server tries to add an update lock on the ow that has already been granted an exclusive lock by another transaction. Therefore, a blocking issue occurs.”<br />
Link: None


<a id="4119"></a>
#### Trace Flag: 4119
Function: “FIX: The query performance is slower when you run the query in SQL Server 2005 than when you run the query in SQL Server 2000” The example given in the KB article indicates that selective LIKE predicates may not be considered fully when less-selective “comparison” (e.g. =, >, etc) predicates are done on the same parameter (or variable?) value as the LIKE predicate.<br />
Link: None


<a id="4120"></a>
#### Trace Flag: 4120
Function: “FIX: Error message when you perform an update operation by using a cursor in SQL Server 2005: Transaction (Process ID <SPID>) was deadlocked on lock resources with another process and has been chosen as the deadlock victim” This issue is apparently due to deadlock issues related to upgrading a U lock to an X lock.<br />
Link: https://support.microsoft.com/kb/953948


<a id="4121"></a>
#### Trace Flag: 4121
Function: SQL 9 - Query that involves an outer join operation runs very slowly. However, if you use the FORCE ORDER query hint in the query, the query runs much faster. Additionally, the execution plan of the query contains the following text in the Warnings column: NO JOIN PREDICATE.<br />
Link: None


<a id="4123"></a>
#### Trace Flag: 4123
Function: Query that has many outer joins takes a long time to compile in SQL Server 2005<br />
Link: None


<a id="4124"></a>
#### Trace Flag: 4124
Function: “FIX: A query performance issue occurs when you run a query against a column of the bigint data type in SQL Server 2005... If the All Density column [of SHOW_STATISTICS] displays incorrect values of 1, you are encountering this problem”<br />
Link: None


<a id="4125"></a>
#### Trace Flag: 4125
Function: SQL 9 - Query may take more time to finish if using an inner join to join a derived table that uses DISTINCT keyword<br />
Link: None


<a id="4126"></a>
#### Trace Flag: 4126
Function: “FIX: The synchronization process is slow, and the CPU usage is high on the computer that is configured as the Distributor in SQL Server 2005” The problem manifested as a replication performance issue, but the following phrase found in the KB article indicates that it is a query processor issue: “the query that performs poorly shows that a join predicate is not pushed down to a Clustered Index Seek operator.”<br />
Link: https://support.microsoft.com/kb/959013


<a id="4127"></a>
#### Trace Flag: 4127
Function: SQL 9 - Compilation time of some queries is very long in an x64-based version.
Basically its more than execution time because more memory allocations are necessary in the compilation process.<br />
Link: Note


<a id="4128"></a>
#### Trace Flag: 4128
Function: “FIX: When you update rows by using a cursor in SQL Server 2005, the update may take a long time to finish”<br />
Link: https://support.microsoft.com/kb/957872


<a id="4129"></a>
#### Trace Flag: 4129
Function: “FIX: The values of the datetime column are not same for the rows that are copied when you copy data to a table by using the GETDATE() function in Microsoft SQL Server 2005”<br />
Link: None


<a id="4130"></a>
#### Trace Flag: 4130
Function: XML performance fix<br />
Link: None


<a id="4131"></a>
#### Trace Flag: 4131
Function: “FIX: When you run a query that contains a JOIN operation in SQL Server 2005 or SQL Server 2008, and the ON clause of the JOIN operator contains a LIKE predicate, the query runs slower than in SQL Server 2000”<br />
Link: None


<a id="4133"></a>
#### Trace Flag: 4133
Function: “FIX: The size of the SQL Server 2005 error log file or of the SQL Server 2008 error log file grows very quickly when query notifications are created and destroyed in a high ratio” & “FIX: The restore operation takes a long time when you restore a database that has query notification enabled in SQL Server 2005 or in SQL Server 2008”<br />
Link: https://support.microsoft.com/kb/958006


<a id="4134"></a>
#### Trace Flag: 4134
Function: Bugfix for error: parallel query returning different results every time
 The trace flag disables an optimization in the query optimizer.
The optimization caused the issue described in the KB article when you try to insert into a table by selecting from the table itself.
As turning on the trace flag could result in a perf degradation, you only should use it if you run into the issue described in the KB article.<br />
Link: https://support.microsoft.com/kb/2546901<br />
Link: http://sql-sasquatch.blogspot.se/2014/04/whaddayaknow-bout-sqlserver-trace-flag.html<br />
Link: https://social.msdn.microsoft.com/Forums/sqlserver/en-US/9ea718c2-e0e0-40cf-b12b-3269130448b7/trace-flag-4135-sql-server-2008?forum=sqldatabaseengine


<a id="4135"></a>
#### Trace Flag: 4135
Function: Bugfix for error inserting to temp table<br />
Link: https://support.microsoft.com/kb/960770<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/541352/tempdb-errors-during-statistics-auto-update


<a id="4136"></a>
#### Trace Flag: 4136
Function: Disables parameter sniffing unless OPTION(RECOMPILE), WITH RECOMPILE or OPTIMIZE FOR value is used.
Starting with SQL Server 2016 (13.x), to accomplish this at the database level, see the PARAMETER_SNIFFING option in [ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)].
To accomplish the same result at the query level, add the OPTIMIZE FOR UNKNOWN [query hint](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-query?view=sql-server-2017).
The `OPTIMIZE FOR UNKNOWN` hint doesn't disable the parameter sniffing mechanism, but effectively bypasses it to achieve the same intended result.
Starting with SQL Server 2016 (13.x) SP1, a second option to accomplish this at the query level is to add the USE HINT 'DISABLE_PARAMETER_SNIFFING' query hint instead of using this trace flag.
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: http://blogs.msdn.com/b/axinthefield/archive/2010/11/04/sql-server-trace-flags-for-dynamics-ax.aspx<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: http://kejser.org/trace-flag-4136-2/<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-4136/<br />
Link: http://www.sqlservergeeks.com/sql-server-did-you-know-about-trace-flag-4136/<br />
Link: [KB2801413]<br />
Scope: global or session or query


<a id="4137"></a>
#### Trace Flag: 4137
Function: Causes SQL Server to generate a plan using minimum selectivity when estimating AND predicates for filters to account for partial correlation instead of independence, under the query optimizer cardinality estimation model of SQL Server 2012 (11.x) and earlier versions (70).<br />
Starting with SQL Server 2016 (13.x) SP1, to accomplish this at the query level, add the USE HINT 'ASSUME_MIN_SELECTIVITY_FOR_FILTER_ESTIMATES' query hint instead of using this trace flag when using the CE 70.
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
**Note: This trace flag does not apply to CE version 120 or above. Use trace flag [9471](#9471) instead.**<br />
Link: https://support.microsoft.com/kb/2658214<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: [KB2801413]<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: global or session or query


<a id="4138"></a>
#### Trace Flag: 4138
Function: Causes SQL Server to generate a plan that does not use row goal adjustments with queries that contain `TOP`, `OPTION (FAST N)`, `IN`, or `EXISTS` keywords<br />
Beginning with SQL Server 2016 SP1, to accomplish this at the query level, add the `USE HINT` query hint instead of using this trace flag.
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://support.microsoft.com/kb/2667211<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: https://answers.sqlperformance.com/questions/1609/trying-to-figure-out-how-to-resolve-the-data-skew.html<br />
Link: http://dba.stackexchange.com/questions/55198/huge-slowdown-to-sql-server-query-on-adding-wildcard-or-top<br />
Link: [KB2801413]<br />
Scope: global or session or query


<a id="4139"></a>
#### Trace Flag: 4139
Function: Enable automatically generated quick statistics (histogram amendment) regardless of key column status.
If trace flag 4139 is set, regardless of the leading statistics column status (ascending, descending, or stationary), the histogram used to estimate cardinality will be adjusted at query compile time<br />
Beginning with SQL Server 2016 SP1, to accomplish this at the query level, add the USE HINT query hint instead of using this trace flag.
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://support.microsoft.com/kb/2952101<br />
Link: [Docs Trace Flags]<br />
Link: [SQL Server - estimates outside of the histogram - half-baked draft]<br />
Link: [Parallelism in Hekaton (In-Memory OLTP)]<br />
Link: [Important Trace Flags That Every DBA Should Know]<br />
Link: https://support.microsoft.com/kb/974006<br />
Scope: global or session or query


<a id="4199"></a>
#### Trace Flag: 4199
**Important: Query Optimizer fixes that address wrong results or access violation errors are not enabled by trace flag 4199.
Those fixes are not considered optional and become enabled by default once the update package is installed.**<br />
Function: Enables query optimizer (QO) changes released in SQL Server Cumulative Updates and Service Packs.
QO changes that are made to previous releases of SQL Server are enabled by default under the latest database [compatibility level](https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-transact-sql-compatibility-level) in a given product release, without trace flag 4199 enabled.<br />
The following table summarizes the behavior when using specific database compatibility levels and trace flag 4199:

|Database Engine (DE) version                                   | Database compatibility level | TF 4199     | QO changes from all previous Database Compatibility Levels | QO changes for DE version post-RTM |
|---------------------------------------------------------------|------------------------------|-------------|------------------------------------------------------------|------------------------------------|
| 13 (SQL Server 2016 (13.x))                                   | 100 to 120                   | Off<br />On | Disabled<br />Enabled                                      | Disabled<br />Enabled              |
|                                                               | 130 (Default)                | Off<br />On | Enabled<br />Enabled                                       | Disabled<br />Enabled              |
| 14 (SQL Server 2017 (14.x))                                   | 100 to 120                   | Off<br />On | Disabled<br />Enabled                                      | Disabled<br />Enabled              |
|                                                               | 130                          | Off<br />On | Enabled<br />Enabled                                       | Disabled<br />Enabled              |
|                                                               | 140 (Default)                | Off<br />On | Enabled<br />Enabled                                       | Disabled<br />Enabled              |
| 15 (SQL Server 2019 (15.x))<br /> and 12 (Azure SQL Database) | 100 to 120                   | Off<br />On | Disabled<br />Enabled                                      | Disabled<br />Enabled              |
|                                                               | 130 to 140                   | Off<br />On | Enabled<br />Enabled                                       | Disabled<br />Enabled              |
|                                                               | 150 (Default)                | Off<br />On | Enabled<br />Enabled                                       | Disabled<br />Enabled              |

Starting with SQL Server 2016 (13.x), to accomplish this at the database level, see the QUERY_OPTIMIZER_HOTFIXES option in [ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)](https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql).
Starting with  SQL Server 2016 (13.x) SP1, to accomplish this at the query level, add the USE HINT [query hint](https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-query) instead of using this trace flag.<br />
Link: https://support.microsoft.com/kb/974006<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/974006<br />
Link: https://sqlworkbooks.com/2017/04/selectively-enabletrace-flag-4199-and-query_optimizer_hotfixes-in-sql-server-2016/<br />
Link: https://sqlworkbooks.com/2017/04/trace-flag-4199-no-per-session-override-if-you-enable-it-globally/<br />
Link: http://www.sqlservergeeks.com/sql-server-2016-database-scoped-configuration-and-trace-flag-4199/<br />
Link: https://nebraskasql.blogspot.com/2018/11/things-i-learned-at-summit-v20-trace.html<br />
Link: [Let’s talk about trace flags]<br />
Link: [KB2964518]<br />
Link: [KB2801413]<br />
Scope: global or session or query


<a id="4606"></a>
#### Trace Flag: 4606
Function: Over comes SA password by startup. Disables password policy check during server startup.<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2011/05/11/inf-hey-my-sql-server-service-is-not-starting-what-do-i-do<br />
Link: https://blogs.msdn.microsoft.com/sqlserverfaq/2008/07/31/upgrade-of-sql-server-2000-instance-to-sql-server-2005-fails-with-error-similar-to-enforce-password-policy


<a id="4610"></a>
#### Trace Flag: 4610
Function: Increases the size of the hash table that stores the cache entries by a factor of 8.
When used together with trace flag 4618 increases the number of entries in the TokenAndPermUserStore cache store to 8,192.<br />
Link: https://support.microsoft.com/kb/959823<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2008/06/16/query-performance-issues-associated-with-a-large-sized-security-cache/<br />
Scope: global only


<a id="4612"></a>
#### Trace Flag: 4612
Function: Disable the ring buffer logging - no new entries will be made into the ring buffer<br />
Link: http://blogs.msdn.com/b/lcris/archive/2007/02/19/sql-server-2005-some-new-security-features-in-sp2.aspx


<a id="4613"></a>
#### Trace Flag: 4613
Function: Generate a minidump file whenever an entry is logged into the ring buffer<br />
Link: http://blogs.msdn.com/b/lcris/archive/2007/02/19/sql-server-2005-some-new-security-features-in-sp2.aspx


<a id="4614"></a>
#### Trace Flag: 4614
Function: Enables SQL Server authenticated logins that use Windows domain password policy enforcement to log on to the instance even though the SQL Server service account is locked out or disabled on the Windows domain controller.<br />
Link: https://support.microsoft.com/kb/925744


<a id="4616"></a>
#### Trace Flag: 4616
Function: Makes server-level metadata visible to application roles.
In SQL Server, an application role cannot access metadata outside its own database because application roles are not associated with a server-level principal.
This is a change of behavior from earlier versions of SQL Server.
Setting this global flag disables the new restrictions, and allows for application roles to access server-level metadata.<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/906549<br />
Scope: global only


<a id="4618"></a>
#### Trace Flag: 4618
Function: Limits number of entries per user cache store to 1024.
It may incur a small CPU overhead as when removing old cache entries when new entries are inserted.
It performs this action to limit the size of the cache store growth. However, the CPU overhead is spread over time.
When used together with trace flag 4610 increases the number of entries in the TokenAndPermUserStore cache store to 8192<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/933564<br />
Link: https://support.microsoft.com/kb/959823<br />
Scope: global only


<a id="4620"></a>
#### Trace Flag: 4620
Function: According to the Connect item, causes permission checking to be done on a global cache instead of the per-user caches that were introduced in SQL 2008. The thread 
includes some interesting information on the cache stores, especially as they relate to TokenPermAndUserStore.<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/467661/sql-server-2008-has-incorrect-cache-names-in-sys-dm-os-memory-cache-counters


<a id="4621"></a>
#### Trace Flag: 4621
Function: SQL 9 – After 4610 & 4618 you can still customize the quota for TokenAndPermUserStore cache store that is based on the current workload<br />
Link: https://support.microsoft.com/kb/959823


<a id="5004"></a>
#### Trace Flag: 5004
Function: Pauses TDE encryption scan and causes encryption scan worker to exit without doing any work.
The database will continue to be in encrypting state (encryption in progress).
To resume re-encryption scan, disable trace flag 5004 and run ALTER DATABASE SET ENCRYPTION ON.<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="5101"></a>
#### Trace Flag: 5101
Function: Forces all I/O requests to go through engine 0.
This removes the contention between processors but could create a bottleneck if engine 0 becomes busy with non-I/O tasks.<br />
Link: http://dba.fyicenter.com/Interview-Questions/SYBASE/What_is_Trace_Flag_Definitions_in_Sybase.html#1.3.4#1.3.4


<a id="5102"></a>
#### Trace Flag: 5102
Function: Prevents engine 0 from running any non-affinitied tasks.<br />
Link: http://dba.fyicenter.com/Interview-Questions/SYBASE/What_is_Trace_Flag_Definitions_in_Sybase.html#1.3.4#1.3.4


<a id="5302"></a>
#### Trace Flag: 5302
Function: Alters default behavior of select…INTO (and other processes) that lock system tables for the duration of the transaction.
This trace flag disables such locking during an implicit transaction.<br />
Link: [KB153096]


<a id="6498"></a>
#### Trace Flag: 6498
Function: 	Enables more than one large query compilation to gain access to the big gateway when there is sufficient memory available.
This trace flag can be used to keep memory usage for the compilation of incoming queries under control, avoiding compilation waits for concurrent large queries.
It is based on the 80 percentage of SQL Server Target Memory, and it allows for one large query compilation per 25 gigabytes (GB) of memory.<br />
**Note: Beginning with SQL Server 2014 SP2 and SQL Server 2016 this behavior is controlled by the engine and trace flag 6498 has no effect.**<br />
Link: https://support.microsoft.com/kb/3024815<br />
Link: [Docs Trace Flags]<br />
Link: http://blogs.msdn.com/b/sql_server_team/archive/2015/10/09/query-compile-big-gateway-policy-changes-in-sql-server.aspx<br />
Link: [KB2964518]<br />
Scope: global only


<a id="6527"></a>
#### Trace Flag: 6527
Function: Disables generation of a memory dump on the first occurrence of an out-of-memory exception in CLR integration.
By default, SQL Server generates a small memory dump on the first occurrence of an out-of-memory exception in the CLR.
The behaviour of the trace flag is as follows: If this is used as a startup trace flag, a memory dump is never generated.
However, a memory dump may be generated if other trace flags are used.
If this trace flag is enabled on a running server, a memory dump will not be automatically generated from that point on.
However, if a memory dump has already been generated due to an out-of-memory exception in the CLR, this trace flag will have no effect.<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="6530"></a>
#### Trace Flag: 6530
Function: Enables a hotfix for “
FIX: Slow performance in SQL Server 2012 or SQL Server 2014 when you build an index on a spatial data type of a large table”<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/11/19/spatial-indexing-from-4-days-to-4-hours<br />
Link: https://support.microsoft.com/kb/2896720

<a id="6531"></a>
#### Trace Flag: 6531
Function: Enables adjustment in the SQLOS scheduling layer to handle queries that issue many short-duration calls to spatial data (which is implemented via CLR functions): “
This fix introduces the trace flag 6531 to indicate to the SQLOS hosting layer that the spatial data type should avoid preemptive protections. This can reduce the CPU consumption 
and improve the overall performance for spatial activities. Only use this trace flag if the individual, spatial method invocations (per row and column) take less than ~4ms. 
Longer invocations without preemptive protection could lead to scheduler concurrency issues and SQLCLR punishment messages logged to the error log.”<br />
Link: https://support.microsoft.com/kb/3005300


<a id="6532"></a>
#### Trace Flag: 6532
Function: Enables performance improvement of query operations with spatial data types in SQL Server 2012 and SQL Server 2014.
The performance gain will vary, depending on the configuration, the types of queries, and the objects.<br />
Link: [KB3107399]<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global or session


<a id="6533"></a>
#### Trace Flag: 6533
Function: Enables performance improvement of query operations with spatial data types in SQL Server 2012 and SQL Server 2014.
The performance gain will vary, depending on the configuration, the types of queries, and the objects.<br />
Link: [KB3107399]<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global or session


<a id="6534"></a>
#### Trace Flag: 6534
Function: Enables performance improvement of query operations with spatial data types in SQL Server 2012, SQL Server 2014 and SQL Server 2016.
The performance gain will vary, depending on the configuration, the types of queries, and the objects.<br />
Link: https://support.microsoft.com/kb/3054180<br />
Link: [KB3107399]<br />
Link: https://blogs.msdn.microsoft.com/bobsql/2016/06/03/sql-2016-it-just-runs-faster-native-spatial-implementations/<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="6545"></a>
#### Trace Flag: 6545
Function: Enables "CLR strict security" behavior (introduced in SQL Server 2017) in SQL Server 2012, SQL Server 2014, and SQL Server 2016.
When enabled, this option will require that _all_ assemblies, regardless of `PERMISSION_SET`, be signed, have an associated signature-based Login, and that the associated Login be granted the `UNSAFE ASSEMBLY` permission.<br />
Please note:
1. This TF can only be specified as a startup parameter!<br />
1. This TF is only available in instances that have been updated / patched with a Service Pack (SP), Cumulative Update (CU), or GDR that was released on or after 2017-08-08.<br />
**Note: This trace flag applies to SQL Server 2012 (11.x) SP3 CU10, SQL Server 2014 (12.x) SP2 CU6, SQL Server 2016 (13.x) RTM CU7, SQL Server 2016 (13.x) SP1 CU4, and higher builds.
Starting with SQL Server 2017 (14.x) this feature is enabled by default and trace flag 6545 has no effect.**<br />
Link: [SQLCLR vs. SQL Server 2012 &amp; 2014 &amp; 2016, Part 7: “CLR strict security” – The Problem Continues … in the Past (Wait, What?!?)][TF6545-b]<br />
Link: [Update adds the "CLR strict security" feature to SQL Server 2016][TF6545-a] ( KB4018930 )<br />
Link: https://support.microsoft.com/kb/3107399
Scope: global only


<a id="6559"></a>
#### Trace Flag: 6559
Function: avoids blocking from orphaned CLR sessions. Enables new functionality in SQL Server 2016 SP1 CU10, SQL Server 2017 CU18, and SQL Server 2019 CU1. Based on the description, this behavior will never be the default, and even though it is available in all versions after 2019, you have to opt into it with the trace flag.<br />
Link: https://support.microsoft.com/kb/4517771<br />
Scope: global only<br />
SQL Server Version: >= 2019 CU1, >= 2017 CU18, >= 2016 SP1 CU10


<a id="7103"></a>
#### Trace Flag: 7103
**Undocumented trace flag**<br />
Function: Disable table lock promotion for text columns<br />
Link: None


<a id="7300"></a>
#### Trace Flag: 7300
Function: Outputs extra info about linked server errors<br />
Link: https://support.microsoft.com/kb/314530<br />
Link: https://support.microsoft.com/kb/280106<br />
Link: https://support.microsoft.com/kb/280102<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/306380/trace-flag-issue-7300-3604


<a id="7301"></a>
#### Trace Flag: 7301
Function: Fixes a problem in SQL 6.5 where SELECT INTO queries with text/image types were not bulk-logged.<br />
Link: None


<a id="7311"></a>
#### Trace Flag: 7311
Function: Offers a new alternative to handling the tricky problem of converting Oracle NUMBER types (across OLEDB linked server queries) with unknown precision/scale to a valid SQL Server data type, by treating all such types as NUMERIC(38,10).<br />
Link: https://support.microsoft.com/kb/3051993


<a id="7314"></a>
#### Trace Flag: 7314
Function: Forces NUMBER values with unknown precision/scale to be treated as double values with OLE DB provider<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3051993<br />
Scope: global or session


<a id="7352"></a>
#### Trace Flag: 7352
Function: Show the optimizer output and the post-optimization rewrite in action (After Post Optimization Rewrite)<br />
Link: [Internals of the Seven SQL Server Sorts – Part 1]<br />
Link: https://www.sql.kiwi/2013/08/sql-server-internals-nested-loops-prefetching.html<br />
Link: http://www.queryprocessor.com/batch-sort-and-nested-loops<br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: [Few Outer Rows Optimization]<br />
Related to [8607](#8607) trace flag<br />
Scope: session only


<a id="7356"></a>
#### Trace Flag: 7356
**Undocumented trace flag**<br />
Function: Added a probe residual to an adaptive join. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="7357"></a>
#### Trace Flag: 7357
Function: Outputs info re: hashing operators, including role reversal, recursion levels, whether the Unique Hash optimization could be used, info about the hash-related bitmap, etc. Dima’s article is a must-read. For parallel query plans, 7357 does NOT send output to the console window. However, output to the SQL Server error log can be enabled by enabling 3605.<br />
Link: http://www.queryprocessor.com/hash-join-execution-internals<br />
Link: [Query Optimizer Deep Dive - Part 4]


<a id="7359"></a>
#### Trace Flag: 7359
Function: Disables the bitmap associated with hash matching. This bitmap is used for “bit-vector filtering” and can reduce the amount of data written to TempDB during hash spills.<br />
Link: www.queryprocessor.com/hash-join-execution-internals


<a id="7398"></a>
#### Trace Flag: 7398
**Undocumented trace flag**<br />
Function: Changed a nested loop join to have ordered prefetch.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="7470"></a>
#### Trace Flag: 7470
Function: Enables additional computations for memory grants required for sort operations.<br />
**Note: This trace flag applies to SQL Server 2012 (11.x) SP2 CU8, SQL Server 2014 (12.x) RTM CU10, SQL Server 2014 (12.x) SP1 CU3, and higher builds.**<br />
**WARNING: Trace flag 7470 will increase memory requirements for queries using sort operators and may impact memory availability for other concurrent queries.**<br />
Link: https://support.microsoft.com/kb/3088480/<br />
Scope: global or session or query


<a id="7412"></a>
#### Trace Flag: 7412
Function: Enables the lightweight query execution statistics profiling infrastructure.
unless your server is already CPU bound, like you’re running all the time with 95% CPU, unless you are at that point, turn on this trace flag at any server you have.
This would be my advice here because this enables that lightweight profiling infrastructure there and then you’ll see in a few minutes what it unleashes here.
So one thing that happens when I enable the lightweight profiling is that the sys.dm_exec_query_profiles DMV, which is something that actually populates the live query stats ability or feature of SSMS, now also is also populated with this lightweight profiling, which means that for all essence, we are now able to run a live query stats on all fashions at any given point in time, and this is extremely useful for let’s say a production DBA that someone calls and says, “Hey, you have a problem. To tap into running system and look at what it’s doing.”<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3170113<br />
Link: https://www.brentozar.com/archive/2017/10/get-live-query-plans-sp_blitzwho/<br />
Link: https://groupby.org/conference-session-abstracts/enhancements-that-will-make-your-sql-database-engine-roar-2016-sp1-edition/<br />
Link: https://www.scarydba.com/2018/06/11/plan-metrics-without-the-plan-trace-flag-7412/<br />
Link: [KB2964518]<br />
Scope: global only


<a id="7470"></a>
#### Trace Flag: 7470
Function: Fix for sort operator spills to tempdb in SQL Server 2012 or SQL Server 2014 when estimated number of rows and row size are correct<br />
Link: https://support.microsoft.com/kb/3088480


<a id="7471"></a>
#### Trace Flag: 7471
Function: Running multiple `UPDATE STATISTICS` for different statistics on a single table concurrently.
Trace Flag 7471 changes the locking behavior of update statistics command such that SQL Server engine no longer acquires `X LOCK` on UPDSTATS resource on the table.
Rather the engine acquires an (update) `U LOCK` on each individual statistics object being updated which doesn't block other parallel threads on the same table running on different statistics.
This behavior improves the overall concurrency of the update statistics job run executing in parallel and improves its performance.<br />
** TF 7471 can increase the possibility of deadlock especially when creation of new statistics and updating of existing statistics are executed simultaneously.
So the recommended best practice is to use TF 7471 only as a part of maintenance when update statistics jobs are run in parallel and should be turned off otherwise.**
Link: https://support.microsoft.com/kb/3156157<br />
Link: https://sqlperformance.com/2016/05/sql-performance/parallel-rebuilds<br />
Link: [KB2964518]<br />
Link: https://blogs.msdn.microsoft.com/sql_server_team/boosting-update-statistics-performance-with-sql-2014-sp1cu6/<br />
Scope: global only


<a id="7497"></a>
#### Trace Flag: 7497
Function: Behavior and intended purpose unknown, but in this post Paul White uses it in concert with 7498 to disable “optimized bitmaps”.<br />
Link: https://sqlperformance.com/2015/11/sql-plan/hash-joins-on-nullable-columns


<a id="7498"></a>
#### Trace Flag: 7498
Function: Behavior and intended purpose unknown, but in this post Paul White uses it in concert with 7497 to disable “optimized bitmaps”.<br />
Link: https://sqlperformance.com/2015/11/sql-plan/hash-joins-on-nullable-columns


<a id="7501"></a>
#### Trace Flag: 7501
Function: Dynamic cursors are used by default on forward-only cursors.
Dynamic cursors are faster than in earlier versions and no longer require unique indexes.
This flag disables the dynamic cursor enhancements and reverts to version 6.0 behavior.<br />
Link: None


<a id="7502"></a>
#### Trace Flag: 7502
Function: Disable cursor plan caching for extended stored procedures<br />
Link: http://basitaalishan.com/2012/02/20/essential-trace-flags-for-recovery-debugging/


<a id="7505"></a>
#### Trace Flag: 7505
Function: Enables version 6.x handling of return codes when calling dbcursorfetchex and the resulting cursor position follows the end of the cursor result set<br />
Link: None


<a id="7525"></a>
#### Trace Flag: 7525
Function: SQL 8 - Reverts to ver 7 behavior of closing nonstatic cursors regardless of the SET CURSOR_CLOSE_ON_COMMIT state<br />
Link: None


#### Trace Flag: 7601, 7603, 7604, 7605
Function: Helps in gathering more information in full text search by turning on full text tracing which gathers information on indexing process using the error log. Also 7603, 7604, 7605 trace flags.<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/526343/looking-for-documentation-on-trace-flags-7601-7603-7604-and-7605


<a id="7608"></a>
#### Trace Flag: 7608
Function: Performance fix for slow full text population with a composite clustered index<br />
Link: None


<a id="7613"></a>
#### Trace Flag: 7613
Function: SQL 9 - Search results are missing when performing a full-text search operation on Win SharePoint Services 2.0 site after upgrading<br />
Link: None


<a id="7614"></a>
#### Trace Flag: 7614
Function: SQL 9 - Full-text index population for the indexed view is very slow<br />
Link: None


<a id="7646"></a>
#### Trace Flag: 7646
Function: SQL 10 - Avoids blocking when using full text indexing.
An issue we experienced that full text can be slow when there is a high number of updates to the index and is caused by blocking on the docidfilter internal table.<br />
Link: None


<a id="7745"></a>
#### Trace Flag: 7745
Function: Forces Query Store to not flush data to disk on database shutdown.<br />
Note: Using this trace may cause Query Store data not previously flushed to disk to be lost in case of shutdown.
For a SQL Server shutdown, the command SHUTDOWN WITH NOWAIT can be used instead of this trace flag to force an immediate shutdown.<br />
Link: [Docs Trace Flags]<br />
Link: [Query Store Trace Flags]<br />
Scope: global only


<a id="7752"></a>
#### Trace Flag: 7752
Function: Enables asynchronous load of Query Store.<br />
**Note: Use this trace flag if SQL Server is experiencing high number of [QDS_LOADDB](https://www.sqlskills.com/help/waits/qds_loaddb/) waits related to Query Store synchronous load (default behavior).**<br />
**Note: Starting with SQL Server 2019 this behavior is controlled by the engine and trace flag 7752 has no effect.**<br />
Link: [Docs Trace Flags]<br />
Link: [Query Store Trace Flags]<br />
Link: [Let’s talk about trace flags]<br />
Scope: global only


<a id="7806"></a>
#### Trace Flag: 7806
Function: Enables a dedicated administrator connection ([DAC]) on SQL Server Express.
By default, no [DAC] resources are reserved on SQL Server Express.<br />
Link: [Docs Trace Flags]<br />
Link: https://msdn.microsoft.com/en-us/library/ms189595.aspx<br />
Link: https://sqlperformance.com/2012/08/sql-memory/test-your-dac-connection<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-7806/<br />
Scope: global only


<a id="7826"></a>
#### Trace Flag: 7826
Function: Disable Connectivity ring buffer<br />
Link: http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx


<a id="7827"></a>
#### Trace Flag: 7827
Function: Record connection closure info in ring buffer<br />
Link: http://blogs.msdn.com/b/sql_protocols/archive/2008/05/20/connectivity-troubleshooting-in-sql-server-2008-with-the-connectivity-ring-buffer.aspx<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/518158/-packet-error-a-fatal-error-occurred-while-reading-the-input-stream-from-the-network


<a id="7833"></a>
#### Trace Flag: 7833
Function: SQL 2012 SP2 CU8 introduced a fix for a “silent error” condition in the sqlcmd tool. The CU also included this flag to allow customers to revert to pre-CU fix behavior.<br />
Link: https://support.microsoft.com/kb/3082877


<a id="8001"></a>
#### Trace Flag: 8001
Function: Khen2005, p2: “For SQL Server 2005, the SQL Server product team opted not to include some wait types that fall under one of the following three categories:
- Wait types that are never used in SQL Server 2005; note that some wait types not excluded are also never used.
- Wait types that can occur only at times when they do not affect user activity, such as during initial server startup and shutdown, and are not visible to users.
- Wait types that are innocuous but have caused concern among users because of their high occurrence or duration
The complete list of wait types is available by enabling trace flag 8001. The only effect of this trace flag is to force sys.dm_os_wait_stats to display all wait types.”<br />
Link: None


<a id="8002"></a>
#### Trace Flag: 8002
Function: Changes CPU Affinity behaviour<br />
Link: https://blogs.msdn.microsoft.com/psssql/2011/11/11/sql-server-clarifying-the-numa-configuration-information


<a id="8004"></a>
#### Trace Flag: 8004
Function: SQL server to create a mini-dump once you enable 2551 and a out of memory condition is hit<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/342691/not-enough-memory-was-available-for-trace-error-when-attempting-to-profile-sql-2008


<a id="8008"></a>
#### Trace Flag: 8008
**Undocumented trace flag**<br />
Function: Force the scheduler hint to be ignored.
Always assign to the scheduler with the least load (pool based on SQL 2012 EE SKU or Load Factor for previous versions and SKUs.)<br />
Link: [How It Works: SQL Server 2012 Database Engine Task Scheduling]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/08/13/how-it-works-sql-server-2012-database-engine-task-scheduling<br />
Link: http://www.stillhq.com/sqldownunder/archives/msg05089.html


<a id="8009"></a>
#### Trace Flag: 8009
**Undocumented trace flag**<br />
Function: Enables the “idle state behavior” (see IO Basics, Chapter 2 document) that a SQL instance can enter under certain conditions.<br />
Link: https://technet.microsoft.com/en-us/library/cc917726.aspx


<a id="8010"></a>
#### Trace Flag: 8010
Function: Disables the “idle state” behavior that a SQL instance can enter (see TF 8009). Fixes problem that SQL Server services can not be stopped<br />
Link: https://support.microsoft.com/kb/2633271
Link: https://technet.microsoft.com/en-us/library/cc917726.aspx


<a id="8011"></a>
#### Trace Flag: 8011
Function: Trace flag 8011 disables the collection of additional diagnostic information for Resource Monitor.
You can use the information in this ring buffer to diagnose out-of-memory conditions.
Trace flag 8011 always applies across the server and has global scope. You can turn on trace flag 8011 at startup or in a user session.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-ring-buffer-trace-flag-8011/<br />
Scope: global only


<a id="8012"></a>
#### Trace Flag: 8012
Function: Disable the ring buffer for schedulers.
SQL Server records an event in the schedule ring buffer every time that one of the following events occurs:
a scheduler switches context to another worker, a worker is suspended, a worker is resumed, a worker enters the preemptive mode or the non-preemptive mode.
You can use the diagnostic information in this ring buffer to analyze scheduling problems.
For example, you can use the information in this ring buffer to troubleshoot problems when SQL Server stops responding.
Trace flag 8012 disables recording of events for schedulers. You can turn on trace flag 8012 only at startup.
The exception ring buffer records the last 256 exceptions that are raised on a node.
Each record contains some information about the error and contains a stack trace. A record is added to the ring buffer when an exception is raised.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-ring-buffer-trace-flag-8012/<br />
Scope: global only


<a id="8015"></a>
#### Trace Flag: 8015
Function: Disable auto-detection and NUMA setup<br />
Link: [Docs Trace Flags]<br />
Link: http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html<br />
Link: [Upgrading an expired SQL Server 2016 Evaluation Edition]<br />
Scope: global only


<a id="8016"></a>
#### Trace Flag: 8016
**Undocumented trace flag**<br />
Function: Force load balancing to be ignored. Always assign to the preferred scheduler.<br />
Link: [How It Works: SQL Server 2012 Database Engine Task Scheduling]


<a id="8017"></a>
#### Trace Flag: 8017
Function: Upgrade version conflict<br />
Link: http://social.msdn.microsoft.com/Forums/eu/sqlexpress/thread/dd6fdc16-9d8d-4186-9549-85ba4c322d10<br />
Link: http://connect.microsoft.com/SQLServer/feedback/details/407692/indicateur-de-trace-8017-reported-while-upgrading-from-ssee2005-to-ssee2008<br />
Link: http://dba.stackexchange.com/questions/48580/trace-flag-and-which-need-to-be-turned-off-and-why


<a id="8018"></a>
#### Trace Flag: 8018
Function: Disables the creation of the ring buffer, and no exception information is recorded.
Disabling the exception ring buffer makes it more difficult to diagnose problems that are related to internal server errors.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-ring-buffer-trace-flag-8018/<br />
Link: http://www.sqlservergeeks.com/sql-server-ring-buffer-trace-flag-8019/<br />
Scope: global only


<a id="8019"></a>
#### Trace Flag: 8019
Function: Disable stack collection for the exception ring buffer
Disables stack collection during the record creation.
Trace flag 8019 has no effect if trace flag [8018](#8018) is turned on.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-ring-buffer-trace-flag-8019/<br />
Scope: global only


<a id="8020"></a>
#### Trace Flag: 8020
Function: Disable working set monitoring.
SQL Server uses the size of the working set when SQL Server interprets the global memory state signals from the operating system.
Trace flag 8020 removes the size of the working set from consideration when SQL Server interprets the global memory state signals.
If you use this trace flag incorrectly, heavy paging occurs, and the performance is poor.
Therefore, contact Microsoft Support before you turn on trace flag 8020.<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="8021"></a>
#### Trace Flag: 8021
Function: On some lower end hardware we used to get reported that each CPU has its own NUMA node.
This was usually incorrect and when we detected only a single CPU per NODE we would assume NO NUMA.
Trace flag 8021 disables this override.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2011/11/11/sql-server-clarifying-the-numa-configuration-information/


<a id="8022"></a>
#### Trace Flag: 8022
Function: This flag gives more information about the conditions when a non-yielding scheduler/situation was encountered.
The whitepaper linked to on the right gives example output for this flag<br />
Link: None


<a id="8024"></a>
#### Trace Flag: 8024
Function: When this TF is on, it affects the mini-dump generation logic for the 1788* errors:
"To capture a mini-dump, one of the following checks must also be met.
1. The non-yielding workers CPU utilization must be > 40 percent.
2. The SQL Server process is not starved for overall CPU resource utilization.
Additional check #1 is targeted at runaway CPU users. Additional check #2 is targeted
at workers with lower utilizations that are probably stuck in an API call or similar activity."<br />
Link: [How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]


<a id="8025"></a>
#### Trace Flag: 8025
Function: SQL on NUMA normally does most of its allocation on Node 1, because usually Windows and other programs will allocate from Node 0. However, if 
you want SQL to do its resource allocation on the default node (node 0), turn on this flag.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2011/11/11/sql-server-clarifying-the-numa-configuration-information


<a id="8026"></a>
#### Trace Flag: 8026
Function: SQL Server will clear a dump trigger after generating the dump once<br />
Link: [KB917825]<br />
Link: [Controlling SQL Server memory dumps]


<a id="8030"></a>
#### Trace Flag: 8030
Function: Fix for performance bug<br />
Link: https://support.microsoft.com/kb/917035<br />


<a id="8032"></a>
#### Trace Flag: 8032
Function: Alters cache limit settings<br />
**Warning: Trace flag 8032 can cause poor performance if large caches make less memory available for other memory consumers, such as the buffer pool.**<br />
Link: [Docs Trace Flags]<br />
Link: [SQL Server Plan Cache Limits]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="8033"></a>
#### Trace Flag: 8033
Function: Suppresses messages of the form “The time stamp counter of CPU on scheduler id 1 is not synchronized with other CPUs” from being placed in the SQL Error log when CPU drift is noticed<br />
**Warning: SQL 9 - Disable the reporting of CPU Drift errors in the SQL Server error log like time stamp counter of CPU on scheduler id 1 is not synchronized with other CPUs.**<br />
Link: https://support.microsoft.com/kb/931279<br />
Link: https://blogs.msdn.microsoft.com/psssql/2007/08/19/sql-server-2005-rdtsc-truths-and-myths-discussed


<a id="8038"></a>
#### Trace Flag: 8038
Function: Will drastically reduce the number of context switches when running SQL 2005 or 2008<br />
Link: [KB972767]<br />
Link: http://forum.proxmox.com/threads/15844-Win7-x64-guest-with-SQLServer-2012-High-CPU-usage<br />
Link: [TECHNET List Of SQL Server Trace Flags]


<a id="8040"></a>
#### Trace Flag: 8040
Function: Disables Resource Governor<br />
Link: http://www.sqlservergeeks.com/blogs/AmitBansal/sql-server-bi/64/sql-server-disabling-resource-governor-permanently-somewhat


<a id="8048"></a>
#### Trace Flag: 8048
**Note: Beginning with SQL Server 2014 SP2 and SQL Server 2016 this behavior is controlled by the engine and trace flag 8048 has no effect.**<br />
Function: Converts NUMA partitioned memory objects into CPU partitioned<br />
Link: http://sql-sasquatch.blogspot.se/2013/04/startup-trace-flags-i-love.html<br />
Link: https://support.microsoft.com/kb/2809338<br />
Link: http://blogs.msdn.com/b/psssql/archive/2012/12/20/how-it-works-cmemthread-and-debugging-them.aspx<br />
Link: [Docs Trace Flags]<br />
Link: http://blogs.msdn.com/b/psssql/archive/2011/09/01/sql-server-2008-2008-r2-on-newer-machines-with-more-than-8-cpus-presented-per-numa-node-may-need-trace-flag-8048.aspx<br />
Link: [Hidden Performance & Manageability Improvements in SQL Server 2012 / 2014]<br />
Link: [KB2964518]<br />
Related to: [8015](#8015), [9024](#9024)<br />
Scope: global only


<a id="8049"></a>
#### Trace Flag: 8049
Function: SQL 9+ Startup only – Allows use of 1ms times even when patched. Check 8038 for details.<br />
Link: [KB972767]<br />
Link: https://blogs.msdn.microsoft.com/psssql/2010/08/18/how-it-works-timer-outputs-in-sql-server-2008-r2-invariant-tsc


<a id="8050"></a>
#### Trace Flag: 8050
Function: Causes "optional" wait types (see the CSS article) to be excluded when querying sys.dm_os_wait_stats<br />
Link: https://blogs.msdn.microsoft.com/psssql/2009/11/02/the-sql-server-wait-type-repository/


<a id="8075"></a>
#### Trace Flag: 8075
Function: Enables a fix (after applying the appropriate CU) for x64 VAS exhaustion.
Assume that you install the 64-bit version of Microsoft SQL Server 2014, 2016 or 2017 on a computer that's running Windows Server 2012 or an earlier version of Windows operating system.
When SQL Server uses up all the user-mode virtual address space, you may receive an out of memory error message in the SQL Server error log.
Additionally, queries take a long time to finish execution, and the `SOS_MEMORY_TOPLEVELBLOCKALLOCATOR` wait occurs.<br />
Link: https://support.microsoft.com/kb/3074434<br />
Link: [KB2964518]<br />
Scope: global only


<a id="8079"></a>
#### Trace Flag: 8079
Function: Allows SQL Server 2014 SP2 to interrogate the hardware layout and automatically configure Soft-NUMA on systems reporting 8 or more CPUs per NUMA node.
The automatic Soft-NUMA behavior is Hyperthread (HT/logical processor) aware.
The partitioning and creation of additional nodes scales background processing by increasing the number of listeners, scaling and network and encryption capabilities.
When Trace Flag 8079 is enabled during startup, SQL Server 2012 SP4 will interrogate the hardware layout and automatically configure Soft NUMA on systems reporting 8 or more CPUs per NUMA node.
It is recommended to first test the performance of workload with Auto-Soft NUMA before it is turned ON in production.
**Note: This trace flag applies to SQL Server 2014 SP2 and SQL Server 2012 SP4. Beginning with SQL Server 2016 this behavior is controlled by the engine and trace flag 8048 has no effect.**<br />
Link: [KB972767]<br />
Link: [Docs Trace Flags]<br />
Link: https://blogs.msdn.microsoft.com/sqlreleaseservices/sql-server-2012-service-pack-4-sp4-released/<br />
Link: [Hidden Performance & Manageability Improvements in SQL Server 2012 / 2014]<br />
Link: [KB2964518]<br />
Scope: global only


<a id="8099"></a>
#### Trace Flag: 8099
Function: Enables a spinlock contention fix for high-end systems running SQL Server 2019 (15.x) serving many concurrent users.<br />
Note: This trace flag applies to SQL Server 2019 (15.x) CU2 and higher builds.<br />
Link: https://support.microsoft.com/kb/4538688<br />
Scope: global only


<a id="8202"></a>
#### Trace Flag: 8202
Function: Used to replicate `UPDATE` as `DELETE/INSERT` pair at the publisher. i.e. UPDATE commands at the publisher can be run as an "on-page DELETE/INSERT" or a "full DELETE/INSERT".
If the UPDATE command is run as an "on-page DELETE/INSERT," the Logreader send UDPATE command to the subscriber,
If the UPDATE command is run as a "full DELETE/INSERT," the Logreader send UPDATE as DELETE/INSERT Pair.
If you turn on trace flag 8202, then UPDATE commands at the publisher will be always send to the subscriber as DELETE/INSERT pair.<br />
Link: None


<a id="8203"></a>
#### Trace Flag: 8203
Function: Display statement and transaction locks on a deadlock error<br />
Link: None


<a id="8206"></a>
#### Trace Flag: 8206
Function: SQL 8 - Supports stored procedure execution with a user specified owner name for SQL Server subscribers or without owner qualification for heterogeneous subscribers<br />
Link: None


<a id="8207"></a>
#### Trace Flag: 8207
Function: Enables singleton updates for Transactional Replication. Updates to subscribers can be replicated as a DELETE and INSERT pair.
This might not meet business rules, such as firing an UPDATE trigger. With trace flag 8207 an update to a unique column that affects only one row (a singleton update) is replicated as an UPDATE and not as a DELETE or INSERT pair.
If the update affects a column on which has a unique constraint or if the update affects multiple rows, the update is still replicated as a DELETE or INSERT pair.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2009/11/02/the-sql-server-wait-type-repository/<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="8209"></a>
#### Trace Flag: 8209
Function: Output extra information to error log regarding replication of schema changes in SQL Server Replication<br />
Link: None


<a id="8218"></a>
#### Trace Flag: 8218
Function: Determine whether trace flag to bypass proc generation has been set.
Referenced in the system procedure `[master].[sys].[sp_cdc_vupgrade]`<br />
Link: None


<a id="8295"></a>
#### Trace Flag: 8295
Function: Creates a secondary index on the identifying columns on the change tracking side table at enable time<br />
Link: https://social.msdn.microsoft.com/forums/sqlserver/en-US/00250311-7991-47b0-b788-7fae2e102254/trace-flag-8295<br />
Link: https://support.microsoft.com/kb/2476322<br />
Link: https://www.brentozar.com/archive/2014/06/performance-tuning-sql-server-change-tracking<br />
Link: https://blogs.technet.microsoft.com/smartinez/2013/03/06/sql-server-for-configmgr-2012-ebook-and-top-10-database-issues<br />


<a id="8446"></a>
#### Trace Flag: 8446
Function: Databases in SQL 8 do not have a Service Broker ID. If you restore these databases on SQL 9 by using the WITH NORECOVERY option, these databases will not be upgraded causing mirroring & log-shipping configurations to fail.<br />
Link: https://support.microsoft.com/kb/959008


<a id="8501"></a>
#### Trace Flag: 8501
Function: Writes detailed information about Ms-DTC context & state changes to the log<br />
Link: None


<a id="8599"></a>
#### Trace Flag: 8599
Function: Allows you to use a save-point within a distributed transaction<br />
Link: None


<a id="8602"></a>
#### Trace Flag: 8602
Function: This trace flag is used to ignore all the index hints specified in query or stored procedure.
We can use this trace flag to troubleshooting the query performance without changing index hints.<br />
Link: http://download.microsoft.com/download/6/e/5/6e52bf39-0519-42b7-b806-c32905f4a066/eim_perf_flowchart_final.pdf<br />
Link: http://sqlblog.com/blogs/kalen_delaney/archive/2008/02/26/lost-without-a-trace.aspx<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-8602/<br />
Scope: global only<br />
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_8602.sql


<a id="8605"></a>
#### Trace Flag: 8605
**Undocumented trace flag**<br />
Function: Displays logical and physical trees used during the optimization process<br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: [Query Optimizer Deep Dive - Part 1]<br />
Scope: session or query


<a id="8606"></a>
#### Trace Flag: 8606
**Undocumented trace flag**<br />
Function: Show LogOp Trees<br />
Link: [Cardinality Estimation Framework 2014 First Look]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [Query Optimizer Deep Dive - Part 4]


<a id="8607"></a>
#### Trace Flag: 8607
Function: Displays the optimization output tree during the optimization process (Before Post Optimization Rewrite).<br />
Link: [Internals of the Seven SQL Server Sorts – Part 1]<br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: [Few Outer Rows Optimization]<br />
Scope: session only


<a id="8608"></a>
#### Trace Flag: 8608
Function: Shows the initial Memo structure<br />
Link: http://www.queryprocessor.ru/optimizer-part-3-full-optimiztion-optimization-search0<br />
Link: http://www.benjaminnevarez.com/2012/04/inside-the-query-optimizer-memo-structure<br />
Link: [Query Optimizer Deep Dive – Part 3]<br />
Link: [Query Optimizer Deep Dive - Part 4]


<a id="8609"></a>
#### Trace Flag: 8609
Function: PWhite: “Task and operation type counts”. <br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: http://www.queryprocessor.ru/good-enough-plan<br />
Scope: session only


<a id="8612"></a>
#### Trace Flag: 8612
Function: Add Extra Info to the Trees Output<br />
Link: [Cardinality Estimation Framework 2014 First Look]<br />
Link: [Hello Operator, My Switch Is Bored]


<a id="8615"></a>
#### Trace Flag: 8615
**Undocumented trace flag**<br />
Function: Display the final memo structure<br />
Link: http://www.benjaminnevarez.com/2012/04/inside-the-query-optimizer-memo-structure/<br />
Link: http://www.somewheresomehow.ru/optimizer-part-3-full-optimiztion-optimization-search0/<br />
Link: [A Row Goal Riddle]<br />
Scope: session only


<a id="8619"></a>
#### Trace Flag: 8619
**Undocumented trace flag**<br />
Function: Show Applied Transformation Rules<br />
Link: https://www.sql.kiwi/2013/02/incorrect-results-with-indexed-views.html<br />
Link: [Cardinality Estimation Framework 2014 First Look]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [A Row Goal Riddle]<br />
Scope: session only


<a id="8620"></a>
#### Trace Flag: 8620
**Undocumented trace flag**<br />
Function: Add memo arguments to trace flag 8619<br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [A Row Goal Riddle]<br />
Scope: session only


<a id="8621"></a>
#### Trace Flag: 8621
**Undocumented trace flag**<br />
Function: Rule with resulting tree<br />
Link: [Query Optimizer Deep Dive - Part 4]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: [A Row Goal Riddle]<br />
Scope: session only


<a id="8628"></a>
#### Trace Flag: 8628
**Undocumented trace flag**<br />
Function: When used with TF [8666](#8666), causes extra information about the transformation rules applied to be put into the XML showplan.<br />
Link: [Yet another X-Ray for the QP]


<a id="8633"></a>
#### Trace Flag: 8633
Function: PWhite: “Enable prefetch (CUpdUtil::FPrefetchAllowedForDML and CPhyOp_StreamUpdate::FDoNotPrefetch)”<br />
Link: [Optimizing T-SQL queries that change data]


<a id="8649"></a>
#### Trace Flag: 8649
**Undocumented trace flag**<br />
Function: Set Cost Threshold for parallelism from 1 to 0, Forcing a Parallel Query Execution Plan.
Possible drawbacks: you'll run out of worker threads (if max worker threads is at default value) and unintentionally reduce DOP for queries that could really use parallelism.
Also be queries that looked fine with a serial merge join that, with a parallel merge join now have an order-preserving repartition streams and their performance will go to crap.
In the new version of SQL Server 2017 there is one more way to force parallel plan, that involves using the undocumented hint `ENABLE_PARALLEL_PLAN_PREFERENCE`.<br />
Link: https://www.sql.kiwi/2011/12/forcing-a-parallel-query-execution-plan.html<br />
Link: https://www.sqlshack.com/sql-server-2017-how-to-get-a-parallel-plan/<br />
Link: [What You Need to Know about the Batch Mode Window Aggregate Operator in SQL Server 2016: Part 1]<br />
Link: [Few Outer Rows Optimization]<br />
Link: [Next-Level Parallel Plan Forcing: An Alternative to 8649]<br />
Link: https://logicalread.com/2015/10/30/sql-server-query-parallelizing-mc11/<br />
Link: https://twitter.com/erikdarlingdata/status/1233449807907303425<br />
Scope: global or session or query


<a id="8665"></a>
#### Trace Flag: 8665
**Undocumented trace flag**<br />
Function: Disables local/global aggregation.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8666"></a>
#### Trace Flag: 8666
**Undocumented trace flag**<br />
Function: Included in execution plans are the names of the stats it used to come up with the plan.
Using a bit o' XML magic and over time, it allows you to clearly identify which stats are actually in use so that you can delete unused stats.
CQScanPartitionSortNew is one of only two sort classes that sets the Soft Sort property exposed when Sort operator execution plan properties are generated with undocumented trace flag 8666 enabled<br />
Link: [Internals of the Seven SQL Server Sorts – Part 1]<br />
Link: [Yet another X-Ray for the QP]<br />
Link: https://blogfabiano.com/2012/07/03/statistics-used-in-a-cached-query-plan<br />
Link: http://dataidol.com/davebally/2014/04/12/reasons-why-your-plans-suck-no-56536<br />
Link: https://www.mssqltips.com/sqlservertip/4269/how-to-identify-useful-sql-server-table-statistics/<br />
Link: http://sql-sasquatch.blogspot.com/2018/06/harvesting-sql-server-trace-flag-8666.html<br />
Link: https://sql-sasquatch.blogspot.com/2018/12/fun-with-sql-server-plan-cache-trace.html<br />
Link: [Fun with SQL Server Plan Cache, Trace Flag 8666, and Trace Flag 2388]<br />
Scope: global or session


<a id="8671"></a>
#### Trace Flag: 8671
**Undocumented trace flag**<br />
Function: According to Dimitriy Pilugin, disables the logic that prunes the memo and prevents the optimization process from stopping due to “Good Enough Plan found”.
Can significantly increase the amount of time, CPU, and memory used in the compilation process<br />
Link: http://www.queryprocessor.ru/optimizer_unleashed_2


<a id="8675"></a>
#### Trace Flag: 8675
Function: Displays the query optimization phases for a specific optimization<br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Query Optimizer Deep Dive – Part 3]<br />
Link: https://sqlperformance.com/2013/06/sql-indexes/recognizing-missed-optimizations


<a id="8677"></a>
#### Trace Flag: 8677
**Undocumented trace flag**<br />
Function: Skips “Search 1” phase of query optimization, and only Search 0 and Search 2 execute.<br />
Link: https://sqlbits.com/Sessions/Event12/Query_Optimizer_Internals_Traceflag_fun


<a id="8678"></a>
#### Trace Flag: 8678
**Undocumented trace flag**<br />
Function: For one query this changed a bushy plan to a left deep one. There was no change in cost. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8679"></a>
#### Trace Flag: 8679
**Undocumented trace flag**<br />
Function: Prevents the SQL Server optimizer from using a Hash Match Team operator<br />
Link: None


<a id="8687"></a>
#### Trace Flag: 8687
**Undocumented trace flag**<br />
Function: Prevents the SQL Server optimizer from using a Hash Match Team operator<br />
Link: None


<a id="8688"></a>
#### Trace Flag: 8688
**Undocumented trace flag**<br />
Function: Disables parallel scans.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8690"></a>
#### Trace Flag: 8690
**Undocumented trace flag**<br />
Function: Disable the spool on the inner side of nested loop.
Spools improve performance in majority of the cases. But it’s based on estimates.
Sometimes, this can be incorrect due to unevenly distributed or skewed data, causing slow performance.
But in vast majority of situations, you don’t need to manually disable spool with this trace flag.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2015/12/15/spool-operator-and-trace-flag-8690/<br />
Link: http://dba.stackexchange.com/questions/52552/index-not-making-execution-faster-and-in-some-cases-is-slowing-down-the-query<br />
Link: http://connect.microsoft.com/SQL/feedback/ViewFeedback.aspx?FeedbackID=453982
Link: [Nested Loops Joins and Performance Spools]<br />
Scope: ?

<a id="8691"></a>
#### Trace Flag: 8691
**Undocumented trace flag**<br />
Function: 'performance spool' optimization to the RegEx execution, reduces the number of executions of the RegEx function.<br />
Link: [Splitting Strings Based on Patterns]<br />
Link: [Nested Loops Joins and Performance Spools]<br />
Scope: ?


<a id="8692"></a>
#### Trace Flag: 8692
Function: Force optimizer to use an Eager Spool for Halloween Protection<br />
Link: http://www.sqlperformance.com/2013/02/sql-plan/halloween-problem-part-4<br />
Link: https://sqlperformance.com/2016/03/sql-plan/changes-to-a-writable-partition-may-fail


<a id="8719"></a>
#### Trace Flag: 8719
Function: In SQL 2000, apparently would show IO prefetch on loop joins and bookmarks. I (Aaron) was unable to replicate the query plan behavior on SQL 2012 using the same test, so this flag may be obsolete.<br />
Link: http://www.hanlincrest.com/SQLServerLockEscalation.htm


<a id="8720"></a>
#### Trace Flag: 8720
Function: In SQL 2000, apparently would have the same effect as OPTION(KEEPFIXED PLAN)<br />
Link: http://www.hanlincrest.com/SQLserverStoredProcRecompiles.htm


<a id="8721"></a>
#### Trace Flag: 8721
Function: Reports to the error log when auto-update statistics executes<br />
Link: https://support.microsoft.com/kb/195565<br />
Link: [Docs Trace Flags]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-8721/<br />
Scope: global only


<a id="8722"></a>
#### Trace Flag: 8722
Function: Disable all hints except locking hints<br />
Link: http://sqlmag.com/sql-server/investigating-trace-flags


<a id="8726"></a>
#### Trace Flag: 8726<br />
**Undocumented trace flag**<br />
Function: Disables the heuristic that discourages the optimizer from producing an index union plan.<br />
Link: [Why are (seemingly) suitable indexes not used on a LEFT JOIN with OR]<br />
Link: https://github.com/ktaranov/sqlserver-kit/issues/170<br />
Link: https://dba.stackexchange.com/a/23779<br />
Link: https://dba.stackexchange.com/a/261790<br />
Scope: query only<br />
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_8726.sql


<a id="8727"></a>
#### Trace Flag: 8727<br />
**Undocumented trace flag**<br />
Function: Can be used to prevent unwanted index union plans.<br />
Link: [Why are (seemingly) suitable indexes not used on a LEFT JOIN with OR]<br />
Link: https://github.com/ktaranov/sqlserver-kit/issues/170<br />
Scope: query only<br />
Demo: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Trace_Flag/Trace_Flag_8727.sql


<a id="8738"></a>
#### Trace Flag: 8738
Function: (Apparently) disables an optimization where rows are sorted before a Key Lookup operator. (The optimization is meant to promote Sequential IO rather than the random nature of IO from Key Lookups). 
Note that the context in which this flag is described means that the above description may not be very precise, or even the only use of this flag.<br />
Link: https://answers.sqlperformance.com/questions/603/why-is-the-sort-operator-needed-in-this-plan.html


<a id="8739"></a>
#### Trace Flag: 8739
Function: Group Optimization Information<br />
Link: http://www.queryprocessor.ru/good-enough-plan


<a id="8741"></a>
#### Trace Flag: 8741
**Undocumented trace flag**<br />
Function: Resulted in a different join order for some queries with a higher estimated cost. Perhaps this disables Transitive Predicates? Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8742"></a>
#### Trace Flag: 8742
**Undocumented trace flag**<br />
Function: Resulted in a different join order for some queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8743"></a>
#### Trace Flag: 8743
**Undocumented trace flag**<br />
Function: Disable SM join.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8744"></a>
#### Trace Flag: 8744
Function: Disable pre-fetching for the Nested Loop operator.
**WARNING: Incorrect use of this trace flag may cause additional physical reads when SQL Server executes plans that contain the Nested Loops operator.**<br />
Link: [KB920093]<br />
Link: [Docs Trace Flags]<br />
Link: https://www.sql.kiwi/2013/03/execution-plan-analysis-the-mystery-work-table.html<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/780194/make-dbcc-trace-flags-available-as-option-querytraceon<br />
Scope: global or session


<a id="8746"></a>
#### Trace Flag: 8746
Function: Whatever else it does, one effect is to disable the “rowset sharing” optimization described in the 2 PWhite posts.<br />
Link: https://sqlperformance.com/2016/03/sql-plan/changes-to-a-writable-partition-may-fail


<a id="8750"></a>
#### Trace Flag: 8750
**Undocumented trace flag**<br />
Function: Skips search 0 optimization phase and moves to search 1.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8755"></a>
#### Trace Flag: 8755
Function: Disable all locking hints<br />
Link: http://sqlmag.com/sql-server/investigating-trace-flags


<a id="8757"></a>
#### Trace Flag: 8757
Function: Skip trivial plan optimization and force a full optimization<br />
Link: [More Undocumented Query Optimizer Trace Flags]<br />
Link: [Query Optimizer Deep Dive - Part 1]<br />
Scope: session or query


<a id="8758"></a>
#### Trace Flag: 8758
Function: “A [workaround to the MERGE bug described] is to apply Trace Flag 8758 –unfortunately this disables a number of optimisations, not just the one 
above, so it’s not really recommended for long term use.” “Disable rewrite to a single operator plan (CPhyOp_StreamUpdate::PqteConvert)”<br />
Link: https://www.sql.kiwi/2010/08/another-interesting-merge-bug.html<br />
Link: [Optimizing T-SQL queries that change data]<br />


<a id="8759"></a>
#### Trace Flag: 8759
**Undocumented trace flag**<br />
Function: Detect and write part of the query to the error log when it has been autoparameterized.<br />
Link: https://github.com/ktaranov/sqlserver-kit/issues/146#issue-358855110<br />
Scope: ?


<a id="8765"></a>
#### Trace Flag: 8765
Function: Allows use of variable length data, from ODBC driver; fixes the issue of a field returning the wrong data length<br />
Link: http://jacob.steelsmith.org/content/sql-server-and-ole-db<br />
Scope: global or session


<a id="8780"></a>
#### Trace Flag: 8780
Function: Give the optimizer more time to find a better plan<br />
Link: http://www.queryprocessor.ru/optimizer_unleashed_1<br />
Link: http://www.sqlservice.se/sql-server-trace-flag-8780/<br />
Scope: global or session


<a id="8783"></a>
#### Trace Flag: 8783
Function: Allows DELETE, INSERT, and UPDATE statements to honor the SET ROWCOUNT ON setting when enabled<br />
Link: None


<a id="8790"></a>
#### Trace Flag: 8790
Function: PWhite: “Undocumented trace flag 8790 forces a wide update plan for any data-changing query (remember that a wide update plan is always possible)”<br />
Link: https://support.microsoft.com/kb/956718<br />
Link: https://www.sql.kiwi/2012/12/merge-bug-with-filtered-indexes.html<br />
Link: https://sqlperformance.com/2014/06/sql-plan/filtered-index-side-effect


<a id="8795"></a>
#### Trace Flag: 8795
Function: PWhite: “Disable DML Request Sort (CUpdUtil::FDemandRowsSortedForPerformance)”<br />
Link: [Optimizing T-SQL queries that change data]<br />
Link: https://sqlperformance.com/2014/10/t-sql-queries/performance-tuning-whole-plan


<a id="8799"></a>
#### Trace Flag: 8799
**Undocumented trace flag**<br />
Function: Forces unordered scans.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="8809"></a>
#### Trace Flag: 8809
Function: Extended Page Heap Activities.
Referenced in passing in the CSS article in relation to debugging memory scribbler problems.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/11/12/how-can-reference-counting-be-a-leading-memory-scribbler-cause/


<a id="8816"></a>
#### Trace Flag: 8816
Function: Logs every two-digit year conversion to a four-digit year<br />
Link: None


<a id="8901"></a>
#### Trace Flag: 8901
Function: Enables new (in 7.0) code to correct a problem with the SHRINK command and empty text or image extents<br />
Link: None


<a id="8903"></a>
#### Trace Flag: 8903
Function: Allows SQL Server to use a specific  API (SetFileIoOverlappedRange) when Locked Pages in Memory is enabled.<br />
Link: https://blogs.msdn.microsoft.com/psssql/2012/03/20/setfileiooverlappedrange-can-lead-to-unexpected-behavior-for-sql-server-2008-r2-or-sql-server-2012-denali<br />
Link: https://support.microsoft.com/kb/2679255<br />
Link: https://blogs.msdn.microsoft.com/psssql/2013/10/16/every-time-i-attach-database-sql-logs-error-1314-for-setfileiooverlappedrange


<a id="9024"></a>
#### Trace Flag: 9024
Function: Converts a global log pool memory object into NUMA node partitioned memory object<br />
**Note: Beginning with SQL Server 2012 SP3 and SQL Server 2014 SP1 this behavior is controlled by the engine and trace flag 9024 has no effect.**<br />
Link: https://support.microsoft.com/kb/2809338<br />
Link: [Docs Trace Flags]<br />
Link: [KB2964518]<br />
Scope: global only<br />
Related to: [8048](#8048)


<a id="9050"></a>
#### Trace Flag: 9050
Function: “FIX: The compile time for a query that uses at least one outer join may be greater for SQL Server post-SP3 builds”<br />
Link: None


<a id="9052"></a>
#### Trace Flag: 9052
Function: “FIX: Queries that join a view may run slowly if the view contains outer joins”<br />
Link: None


<a id="9054"></a>
#### Trace Flag: 9054
Function: “FIX: SQL Server 2000 Service Pack 1 (SP1) and later builds may not generate an execution plan for a query, and you receive error message 8623”<br />
Link: None


<a id="9055"></a>
#### Trace Flag: 9055
Function: “FIX: The performance of a DML operation that fires a trigger may decrease when the trigger execution plan recompiles repeatedly”<br />
Link: None


<a id="9056"></a>
#### Trace Flag: 9056
Function: “FIX: A user-defined function returns results that are not correct for a query”<br />
Link: None


<a id="9059"></a>
#### Trace Flag: 9059
Function: SQL 8 - Turns back behavior to SP3 after a SP4 installation, this allows to choose an index seek when comparing numeric columns or numeric constants that are of different precision or scale; else would have to change schema/code.<br />
Link: None


<a id="9061"></a>
#### Trace Flag: 9061
Function: “FIX: Build 8.00.0837: A query that contains a correlated subquery runs slowly”<br />
Link: None


<a id="9062"></a>
#### Trace Flag: 9062
Function: “FIX: Some complex queries are slower after you install SQL Server 2000 Service Pack 2 or SQL Server 2000 Service Pack 3”<br />
Link: None


<a id="9063"></a>
#### Trace Flag: 9063
Function: “FIX: Query performance may be slower if the query contains both a GROUP BY clause and a DISTINCT keyword on the same column”<br />
Link: None


<a id="9065"></a>
#### Trace Flag: 9065
Function: “FIX: The query plan may take longer than expected to compile, and you may receive error message 701, error message 8623, or error message 8651 in SQL Server 2000”<br />
Link: None


<a id="9068"></a>
#### Trace Flag: 9068
Function: “FIX: A query may run more slowly against SQL Server 2000 post-SP3 hotfix build 8.00.0988 than a query that you run against SQL Server 2000 post-SP3 hotfix builds that are earlier than build 8.00.0988”<br />
Link: None


<a id="9079"></a>
#### Trace Flag: 9079
Function: “FIX: The query performance may be slow when you query data from a view in SQL Server 2000”<br />
Link: None


<a id="9082"></a>
#### Trace Flag: 9082
Function: SQL 9 - Stored procedure using views, perform slow compared to ver 8 if views use JOIN operator and contain sub queries<br />
Link: None

<a id="9109"></a>
#### Trace Flag: 9109
Function: Used to workaround a problem with query notifications and restoring a DB with the NEW_BROKER option enabled.<br />
Link: https://support.microsoft.com/kb/2483090


<a id="9114"></a>
#### Trace Flag: 9114
**Undocumented trace flag**<br />
Function: Prevents the optimizer rewriting the apply as a join.<br />
Link: [New Undocumented Trace Flags]<br />
Link: https://dba.stackexchange.com/a/274195/107045<br />
Scope: global or session or query<br />
Versions: 2008-2019


<a id="9115"></a>
#### Trace Flag: 9115
Function: PWhite: “Disable prefetch (CUpdUtil::FPrefetchAllowedForDML)” Dima: “Disables both [NLoop Implicit Batch Sort {TF 2340} and NL Prefetching {TF 8744}], and not only on the Post Optimization, but the explicit Sort also”<br />
Link: [Optimizing T-SQL queries that change data]<br />
Link: http://www.hanlincrest.com/SQLServerLockEscalation.htm<br />
Link: http://www.queryprocessor.com/batch-sort-and-nested-loops


<a id="9130"></a>
#### Trace Flag: 9130
**Undocumented trace flag**<br />
Function: Disables the particular copy out stage rewrite from Filter + (Scan or Seek) to (Scan or Seek) + Residual Predicate.
Enabling this flag retains the Filter in the final execution plan, resulting in a SQL Server 2008+ plan that mirrors the 2005 version.
Before Service Pack 3 of SQL Server 2012, we didn't have property `Number of Rows Read` in execution plan, and to get a feel for the difference between the `Number of Rows Read` and the `Actual Number of Rows`, we'd need to use trace flag 9130.<br />
Link: https://www.sql.kiwi/2012/10/cardinality-estimation-bug-with-lookups-in-sql-server-2008-onward.html<br />
Link: http://sqlblogcasts.com/blogs/sqlandthelike/archive/2012/12/06/my-new-favourite-traceflag.aspx<br />
Link: [Hello Operator, My Switch Is Bored]<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/767395/cardinality-estimation-error-with-pushed-predicate-on-a-lookup<br />
Link: http://www.theboreddba.com/Categories/FunWithFlags/Revealing-Predicates-in-Execution-Plans-(TF-9130).aspx<br />
Link: https://sqlperformance.com/2016/06/sql-indexes/actual-rows-read-warnings-plan-explorer<br />
Scope: global or session or query


<a id="9134"></a>
#### Trace Flag: 9134
Function: SQL 8 - Does additional reads to test if the page is allocated & linked correctly this checks IAM & PFS. Fixes error 601 for queries under Isolation level read uncommitted. In case performance is affected (because of a bug) apply SP4.<br />
Link: https://support.microsoft.com/kb/815008


<a id="9136"></a>
#### Trace Flag: 9136
Function: “PRB: You receive error message 8623 when you try to run a query that joins multiple tables”<br />
Link: None


<a id="9164"></a>
#### Trace Flag: 9164
**Undocumented trace flag**<br />
Function: Disables HM (hash joins).<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9165"></a>
#### Trace Flag: 9165
**Undocumented trace flag**<br />
Function: Disable NL join and remove an index recommendation from a plan.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9182"></a>
#### Trace Flag: 9182
**Undocumented trace flag**<br />
Function: Resulted in a very strange cost change to a clustered index delete.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9183"></a>
#### Trace Flag: 9183
**Undocumented trace flag**<br />
Function: Resulted in a very strange cost change to a clustered index delete.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9185"></a>
#### Trace Flag: 9185
Function: Cardinality estimates for literals that are outside the
histogram range are very low<br />
Link: None
Related to: [9205](#9205)


<a id="9198"></a>
#### Trace Flag: 9198
**Undocumented trace flag**<br />
Function: Ccan be used to disable lazy index performance spools specifically.
You may still get a lazy table or row count spool instead (with or without sort optimization), depending on costing.<br />
Link: [Nested Loops Joins and Performance Spools]<br />
Scope: ?

<a id="9204"></a>
#### Trace Flag: 9204
Function: Output Statistics used by Query Optimizer. When enabled and a plan is compiled or recompiled there is a listing of statistics which is being fully loaded & used to produce cardinality and distribution estimates for some plan alternative or other.<br />
Link: [How to Find the Statistics Used to Compile an Execution Plan]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-9204/<br />
Link: https://www.sqlpassion.at/archive/2013/10/29/fixing-cardinality-estimation-errors-with-filtered-statistics/<br />
Scope: global or query
Related to: [9292](#9292)


<a id="9205"></a>
#### Trace Flag: 9205
Function: Cardinality estimates for literals that are outside the histogram range are very low for tables that have parent-child relationships<br />
Link: None
Related to: [9185](#9185)


<a id="9207"></a>
#### Trace Flag: 9207
Function: Fixes that SQL Server underestimates the cardinality of a query expression and query performance may be slow<br />
Link: None


<a id="9209"></a>
#### Trace Flag: 9209
Function: “FIX: Some queries that have a left outer join and an IS NULL filter run slower after you install SQL Server 2000 post-SP3 hotfix”<br />
Link: None


<a id="9210"></a>
#### Trace Flag: 9210
Function: “FIX: A query filter condition that has a LEFT OUTER JOIN clause may cause an incorrect row count estimate in the query execution plan”<br />
Link: None


<a id="9236"></a>
#### Trace Flag: 9236
**Undocumented trace flag**<br />
Function: Resulted in a different join order for some queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9251"></a>
#### Trace Flag: 9251
**Undocumented trace flag**<br />
Function: Change in cardinality estimates for some queries. It might only work with the legacy CE. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9259"></a>
#### Trace Flag: 9259
Function: Disables Project Normalization step<br />
**Note: Please, don’t use TF 9259 that disables Project Normalization step in a real production system, besides it is undocumented and unsupported, it may hurt your performance.**<br />
Link: http://www.queryprocessor.com/sudf-ce/


<a id="9260"></a>
#### Trace Flag: 9260
**Undocumented trace flag**<br />
Function: Adds an explicit sort before creation of an index spool. Almost doesn’t change the total estimated cost. Might be identical plans with just more detail shown at that step.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9268"></a>
#### Trace Flag: 9268
Function: SQL 8 - When SQL Server runs a parameterized query that contains several IN clauses, each with a large number of values, SQL Server may return the following error message after a minute or more of high CPU utilization: KB 325658. Server: Msg 8623, Level 16, State 1. Internal Query Processor Error: The query processor could not produce a query plan. Contact your primary support provider for more information.<br />
Link: None


<a id="9275"></a>
#### Trace Flag: 9275
Function: “FIX: A DML Operation on a Large Table Can Cause Performance Problems” Enables SQL 2000 optimizations that sort data in DML statements before the changes are applied to a clustered index<br />
Link: None


<a id="9284"></a>
#### Trace Flag: 9284
**Undocumented trace flag**<br />
Function: Changed the order of a scalar operator comparison in a single join for certain queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9287"></a>
#### Trace Flag: 9287
**Undocumented trace flag**<br />
Function: Appears to disable partial aggreation.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9288"></a>
#### Trace Flag: 9288
**Undocumented trace flag**<br />
Function: Effects around local and global aggregates - choose coerce partial and global aggregation over scalar aggregation.<br />
Link: https://github.com/ktaranov/sqlserver-kit/issues/93<br />
Scope: session only


<a id="9292"></a>
#### Trace Flag: 9292
Function: Output Statistics considered to be used by Query Optimizer<br />
Link: [How to Find the Statistics Used to Compile an Execution Plan]<br />
Link: http://www.sqlservergeeks.com/sql-server-trace-flag-9292/<br />
Scope: session only
Related to: [9204](#9204)


<a id="9341"></a>
#### Trace Flag: 9341
**Undocumented trace flag**<br />
Function: Resulted in a rather odd plan for a COUNT(DISTINCT) query against a CCI.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9346"></a>
#### Trace Flag: 9346
**Undocumented trace flag**<br />
Function: Appears to disable batch mode window aggregates.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9347"></a>
#### Trace Flag: 9347
Function: Disables batch mode for sort operator. SQL Server 2016 introduces a new batch mode sort operator that boosts performance for many analytical queries.<br />
Link: https://support.microsoft.com/kb/3172787<br />
Link: [Docs Trace Flags]<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Scope: global or session or query


<a id="9348"></a>
#### Trace Flag: 9348
Function: Sets a row limit (based on cardinality estimates) that controls whether a bulk insert is attempted or not (assuming conditions are met for a bulk insert). Introduced as a workaround for memory errors encountered with bulk insert.<br />
Link: https://support.microsoft.com/kb/2998301


<a id="9349"></a>
#### Trace Flag: 9349
Function: Disables batch mode for top N sort operator. SQL Server 2016 introduces a new batch mode top sort operator that boosts performance for many analytical queries.<br />
Link: [Docs Trace Flags]<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: https://support.microsoft.com/kb/3172787<br />
Scope: global or session or query


<a id="9354"></a>
#### Trace Flag: 9354
**Undocumented trace flag**<br />
Function: Disable [aggregate pushdown](http://www.nikoport.com/2015/07/11/columnstore-indexes-part-59-aggregate-pushdown/) operations for columnstore indexes.
The number of rows aggregated at the level of the scan is displayed in the new property plan [Actual Number Of Locally Aggregated Rows](http://www.nikoport.com/2016/03/21/clustered-columnstore-indexes-part-80-local-aggregation/).
TF 9354 can be used to disable the push of aggregation, the difference can be observed by the runtime, according to the number of rows in the plan Actual Number Of Locally Aggregated Rows and number Actual Number Of Rows output from the scan operator.<br />
Example:

```sql
use AdventureworksDW2016CTP3;
set nocount on;
go
-- Undocumented TF 9354 disables this optimization, run to see Aggregation Pushdown Performance Gain
set statistics xml, time on;
select count_big(*) from dbo.FactResellerSalesXL_CCI;
select count_big(*) from dbo.FactResellerSalesXL_CCI option(querytraceon 9354); -- undocumented/unsupported TF 9354 to disable aggregate pushdown
set statistics xml, time off;
```


<a id="9358"></a>
#### Trace Flag: 9358
Function: Disable batch mode sort operations in a complex parallel query. For example, this flag could apply if the query contains merge join operations.<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: https://support.microsoft.com/kb/3171555<br />
Scope: global or session or query


<a id="9384"></a>
#### Trace Flag: 9384
**Undocumented trace flag**<br />
Function: Very slightly changed the memory grant of a query with a batch mode window aggregate.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9389"></a>
#### Trace Flag: 9389
Function: Enables additional dynamic memory grant for batch mode operators.
If a query does not get all the memory it needs, it spills data to TempDB, incurring additional I/O and potentially impacting query performance.
If the dynamic memory grant trace flag is enabled, a batch mode operator may ask for additional memory and avoid spilling to TempDB if additional memory is available.
For more information, see the *Effects of min memory per query* section of the [Memory Management Architecture Guide](https://docs.microsoft.com/en-us/sql/relational-databases/memory-management-architecture-guide?view=sql-server-2017#effects-of-min-memory-per-query).<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="9390"></a>
#### Trace Flag: 9390
**Undocumented trace flag**<br />
Function: Resulted in plan changes including parallelism for queries that shouldn’t have been eligible for parallelism based on CTFP. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9394"></a>
#### Trace Flag: 9394
Function: Apparently enables a fix for an access violation when a table with Japanese characters has an indexed changed.<br />
Link: https://support.microsoft.com/kb/3142595<br />
Link: https://support.microsoft.com/kb/3138659


<a id="9398"></a>
#### Trace Flag: 9398
**Undocumented trace flag**<br />
Function: Disable adaptive join.<br />
Link: [SQL Server 2017: Adaptive Join Internals]<br />
Scope: ?


<a id="9399"></a>
#### Trace Flag: 9399
**Undocumented trace flag**<br />
Function: Optimization adaptive threshold rows. The adaptive threshold to the minimum estimate.<br />
Link: [SQL Server 2017: Adaptive Join Internals]<br />
Scope: ?


<a id="9410"></a>
#### Trace Flag: 9410
**Undocumented trace flag**<br />
Function: Fix slowly query runs when SQL Server uses hash aggregate in the query plan.<br />
Link: https://support.microsoft.com/kb/3167159<br />
Scope: ?


<a id="9412"></a>
#### Trace Flag: 9412
**Undocumented trace flag**<br />
Function: Removes the new OptimizerStatsUsage information from estimated query plans.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9415"></a>
#### Trace Flag: 9415
**Undocumented trace flag**<br />
Function: Optimization adaptive join internals.<br />
Link: [SQL Server 2017: Adaptive Join Internals]<br />
Scope: ?


<a id="9424"></a>
#### Trace Flag: 9424
**Undocumented trace flag**<br />
Function: Sets the number of splits to four.
The SQL Server 2019 query optimizer has a new trick available to improve the performance of large aggregations.
The new exploration abilities are encoded in two new closely-related optimizer rules: `GbAggSplitToRanges` and `SelOnGbAggSplitToRanges`.
The extended event `query_optimizer_batch_mode_agg_split is` provided to track when this new optimization is considered.
The description of this event is: Occurs when the query optimizer detects batch mode aggregation is likely to spill and tries to split it into multiple smaller aggregations.<br />
Link: [SQL Server 2019 Aggregate Splitting]<br />
Scope: session or query


<a id="9426"></a>
#### Trace Flag: 9426
**Undocumented trace flag**<br />
Function: Disables the aggregate splitting feature.
The SQL Server 2019 query optimizer has a new trick available to improve the performance of large aggregations.
The new exploration abilities are encoded in two new closely-related optimizer rules: `GbAggSplitToRanges` and `SelOnGbAggSplitToRanges`.
The extended event `query_optimizer_batch_mode_agg_split is` provided to track when this new optimization is considered.
The description of this event is: Occurs when the query optimizer detects batch mode aggregation is likely to spill and tries to split it into multiple smaller aggregations.<br />
Link: [SQL Server 2019 Aggregate Splitting]<br />
Scope: session or query


<a id="9447"></a>
#### Trace Flag: 9447
**Undocumented trace flag**<br />
Function: Forces query plans to use the new referential integrity operator when validating UPDATE and DELETE queries against foreign key parent tables.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9448"></a>
#### Trace Flag: 9448
**Undocumented trace flag**<br />
Function: Disables the referential integrity operator.<br />
Link: https://orderbyselectnull.com/2017/12/05/the-referential-integrity-operator/


<a id="9453"></a>
#### Trace Flag: 9453
Function: Disables Batch Mode in Parallel Columnstore query plans.
(Note that a plan using batch mode appears to require a recompile before the TF takes effect)
Sunil Agarwal also used this trace flag in demo scripts for a PASS 2014 session on column store indexing<br />
Link: [Niko Neugebauer Columnstore Indexes – part 35]<br />
Link: [What You Need to Know about the Batch Mode Window Aggregate Operator in SQL Server 2016: Part 1]


<a id="9471"></a>
#### Trace Flag: 9471
Function: Causes SQL Server to generate a plan using minimum selectivity for single-table filters, under the query optimizer cardinality estimation model of SQL Server 2014 (12.x) and later versions.
Starting with SQL Server 2016 (13.x) SP1, to accomplish this at the query level, add the USE HINT 'ASSUME_MIN_SELECTIVITY_FOR_FILTER_ESTIMATES' query hint instead of using this trace flag.<br />
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
**Note: This trace flag does not apply to CE version 70. Use trace flag [4137](#4137) instead.**<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: global or session or query


<a id="9472"></a>
#### Trace Flag: 9472
**Undocumented trace flag**<br />
Function: Assumes independence for multiple WHERE predicates in the SQL 2014 cardinality estimation model.
Predicate independence was the default for versions prior to SQL Server 2014, and thus this flag can be used to more closely emulate pre-SQL 2014 cardinality estimate behavior in a more specific fashion than TF 9481.<br />
Link: https://sqlperformance.com/2014/01/sql-plan/cardinality-estimation-for-multiple-predicates<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/801908/sql-server-2014-cardinality-estimation-regression<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: global or session or query


<a id="9473"></a>
#### Trace Flag: 9473
**Undocumented trace flag**<br />
Function: Allowing the outer join to keep a zero-row inner-side estimate (instead of raising to one row) (so all outer rows qualify) gives a 'bug-free' join estimation with either calculator.
If you're interested in exploring this, the undocumented trace flag is 9473 (alone).<br />
Link: https://dba.stackexchange.com/a/141533/107045<br />
Scope: ?


<a id="9474"></a>
#### Trace Flag: 9474
**Undocumented trace flag**<br />
Function: Change in cardinality estimates for some joins in certain queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9476"></a>
#### Trace Flag: 9476
Function: Causes SQL Server to generate a plan using the Simple Containment assumption instead of the default Base Containment assumption, under the query optimizer cardinality estimation model of SQL Server 2014 through SQL Server 2016 versions.
Beginning with SQL Server 2016 SP1, to accomplish this at the query level, add the USE HINT query hint instead of using this trace flag.
**Note: Please ensure that you thoroughly test this option, before rolling it into a production environment.**<br />
Link: https://support.microsoft.com/kb/3189675<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: [Docs Trace Flags]<br />
Scope: global or session or query


<a id="9477"></a>
#### Trace Flag: 9477
**Undocumented trace flag**<br />
Function: Slight change in ratio of EstimateRebinds and EstimateRewinds was observed. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9478"></a>
#### Trace Flag: 9478
**Undocumented trace flag**<br />
Function: Change in cardinality estimates for some joins in certain queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9479"></a>
#### Trace Flag: 9479
**Undocumented trace flag**<br />
Function: Forces the optimizer to use Simple Join [estimation] even if a histogram is available.
Will force optimizer to use a simple join estimation algorithm, it may be CSelCalcSimpleJoinWithDistinctCounts, CSelCalcSimpleJoin or CSelCalcSimpleJoinWithUpperBound, depending on the compatibility level and predicate comparison type.<br />
Link: [Statistics and Cardinality Estimation]<br />
Scope: ?


<a id="9480"></a>
#### Trace Flag: 9480
**Undocumented trace flag**<br />
Function: Reduced the selectivity of a bitmap filter from 0.001 to 0.000001. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9481"></a>
#### Trace Flag: 9481
Function: Enables you to set the query optimizer cardinality estimation model to the SQL Server 2012 and earlier version independent of the compatibility level of the database.
To accomplish this at the database level, see [ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)].
To accomplish this at the query level, add the QUERYTRACEON query hint.<br />
Link: [New Features in SQL Server 2016 Service Pack 1]<br />
Link: https://sqlserverscotsman.wordpress.com/2016/11/28/a-guide-on-forcing-the-legacy-ce/<br />
Link: [Docs Trace Flags]<br />
Link: [KB2801413]<br />
Link: http://www.sqlservergeeks.com/sql-server-2014-trace-flags-9481/<br />
Link: https://sqlperformance.com/2019/01/sql-performance/compatibility-levels-and-cardinality-estimation-primer<br />
Link: [KB2801413]<br />
Link: [Cardinality Estimation for Multiple Predicates]<br />
Scope: global or session or query


<a id="9482"></a>
#### Trace Flag: 9482
**Undocumented trace flag**<br />
Function: Implements a “model variation” in the SQL 2014 cardinality estimator. The flag turns off the “overpopulated primary key” adjustment that the optimizer might use when determining that a “dimension” table (the schema could be OLTP as well) has many 
more distinct values than the “fact” table. (The seminal example is where a Date dimension is populated out into the future, but the fact table only has rows up to the current date). Since join cardinality estimation occurs based on the contents of the 
histograms of the joined columns, an “overpopulated primary key” can result in higher selectivity estimates, causing rowcount estimates to be too low.<br />
Link: http://www.queryprocessor.com/ce_opk


<a id="9483"></a>
#### Trace Flag: 9483
**Undocumented trace flag**<br />
Function: Implements a “model variation” in the SQL 2014 cardinality estimator. The flag will force the optimizer to create (if possible) a filtered statistics object based on a predicate in 
the query. This filtered stat object is not persisted and thus would be extremely resource intensive for frequent compilations. In Dima’s example, the filtered stat object 
is actually created on the join column...i.e. “CREATE STATISTICS [filtered stat obj] ON [table] (Join column) WHERE (predicate column = ‘literal’)”<br />
Link: http://www.queryprocessor.com/ce_filteredstats


<a id="9484"></a>
#### Trace Flag: 9484
**Undocumented trace flag**<br />
Function: Slight change in estimated number of rewinds. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9485"></a>
#### Trace Flag: 9485
Function: Disables SELECT permission for DBCC SHOW\_STATISTICS<br />
Link: https://support.microsoft.com/kb/2683304<br />
Link: [Docs Trace Flags]<br />
Link: http://www.benjaminnevarez.com/2013/02/dbcc-show_statistics-works-with-select-permission<br />
Scope: global only


<a id="9488"></a>
#### Trace Flag: 9488
**Undocumented trace flag**<br />
Function: Implements a “model variation” in the SQL 2014 cardinality estimator. This flag reverts the estimation behavior for multi-statement TVFs back to 1 row (instead of the 100-row estimate behavior that was adopted in SQL 2014).<br />
Link: http://www.queryprocessor.com/ce_mtvf


<a id="9489"></a>
#### Trace Flag: 9489
**Undocumented trace flag**<br />
Function: Implements a “model variation” in the SQL 2014 cardinality estimator and turns off the new logic that handles ascending keys. <br />
Link: http://www.queryprocessor.com/ce_asckey


<a id="9490"></a>
#### Trace Flag: 9490
**Undocumented trace flag**<br />
Function: Change in cardinality estimate. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="9494"></a>
#### Trace Flag: 9494
**Undocumented trace flag**<br />
Function: The behaviour of the join cardinality estimation with CSelCalcExpressionComparedToExpression can also be modified to not account for ``bId` with another undocumented variation flag (9494)<br />
Link: https://dba.stackexchange.com/a/141533/107045<br />
Scope: ?


<a id="9495"></a>
#### Trace Flag: 9495
Function: Disables parallelism during insertion for INSERT...SELECT operations and it applies to both user and temporary tables<br />
Link: https://support.microsoft.com/kb/3180087<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="9497"></a>
#### Trace Flag: 9497
**Undocumented trace flag**<br />
Function: For SQL Server versions where the behaviour previously enabled under TF [2371](#2371) is the default, start-up trace flag 9497 reverts to the original behaviour for the statistics update recompilation threshold.
The formula to compute RT (Recompilation Thresholds) values is different when trace flag [2371](#2371) is enabled (or for versions and compatibility settings where the sublinear behaviour is default (if trace flag 9497 is off)).
The new formula for RT is SQRT(1000 * table rows).<br />
Link: [Temporary Table Caching in Stored Procedures]<br />
Scope: global only


<a id="9532"></a>
#### Trace Flag: 9532
Function: SQL 11 CTP3 - to get more than 1 availability group replica in CTP3 Scope Startup<br />
Link: http://connect.microsoft.com/SQLServer/feedback/details/682581/denali-hadron-read-only-routing-url-is-not-yet-implemente


<a id="9559"></a>
#### Trace Flag: 9559
**Undocumented trace flag**<br />
Function: For AGs, “when enabled on the secondary ignores the redo target provided from the primary progress message and always set the redo target at the Max LSN value.”<br />
Link: https://blogs.msdn.microsoft.com/alwaysonpro/2013/12/04/recovery-on-secondary-lagging-shared-redo-target


<a id="9567"></a>
#### Trace Flag: 9567
Function: Enables compression of the data stream for availability groups during automatic seeding.
Compression can significantly reduce the transfer time during automatic seeding and will increase the load on the processor.<br />
Link: [Docs Trace Flags]<br />
Link: https://www.mssqltips.com/sqlservertip/4537/sql-server-2016-availability-group-automatic-seeding/<br />
Link: https://msdn.microsoft.com/en-us/library/mt735149.aspx<br />
Link: [Tune compression for availability group]<br />
Scope: global or session


<a id="9571"></a>
#### Trace Flag: 9571
Function: Disables Availability Groups Auto seeding to the default database path.<br />
Link: https://docs.microsoft.com/en-us/sql/database-engine/availability-groups/windows/automatic-seeding-secondary-replicas<br />
Scope: global or session


<a id="9576"></a>
#### Trace Flag: 9576
Function: Revert to the original (SQL Server 2016) implementation of database level health detection using TF 9576 as either a startup parameter or enabled using DBCC TRACEON command.
This new implementation is currently only available for SQL Server running on Windows and will be ported to SQL Server 2017 on Linux in an upcoming cumulative update.<br />
Link: https://blogs.msdn.microsoft.com/sql_server_team/sql-server-availability-groups-enhanced-database-level-failover/<br />
Scope: global only


<a id="9591"></a>
#### Trace Flag: 9591
Function: Disables log block compression in Always On Availability Groups.
Log block compression is the default behavior used with both synchronous and asynchronous replicas in SQL Server 2012 and SQL Server 2014.
In SQL Server 2016, compression is only used with asynchronous replica.<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="9592"></a>
#### Trace Flag: 9592
Function: Enables log stream compression for synchronous availability groups.
This feature is disabled by default on synchronous availability groups because compression adds latency.<br />
Link: [Docs Trace Flags]<br />
Link: [Tune compression for availability group]<br />
Scope: global or session


<a id="9706"></a>
#### Trace Flag: 9706
**Undocumented trace flag**<br />
Function: Software Usage Metrics is disabled.<br />
Link: [Bad Idea Jeans: Finding Undocumented Trace Flags]


<a id="9806"></a>
#### Trace Flag: 9806
**Undocumented trace flag**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


<a id="9807"></a>
#### Trace Flag: 9807
**Undocumented trace flag**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


<a id="9808"></a>
#### Trace Flag: 9808
**Undocumented trace flag**<br />
Function: Unknown. Is turned on on SQL Server 2014 CTP1 standard installation in Windows Azure VM<br />
Link: None


<a id="9830"></a>
#### Trace Flag: 9830
**Undocumented trace flag**<br />
Function: Activate the trace flag before creating a natively compiled procedure.
If you now open up the SQL Server error log you should see the compilation process for the natively compiled procedure.
This is an undocumented trace flag so please don’t use this on a production system.<br />
Link: https://web.archive.org/web/20160327221828/http://speedysql.com/2015/10/28/new-trace-flag-for-in-memory-oltp-hekaton/


<a id="9837"></a>
#### Trace Flag: 9837
**Undocumented trace flag**<br />
Function: According to Bob Ward’s PASS 2014 talk on SQL Server IO, enables “extra tracing but massive output” for Hekaton checkpoint files.<br />
Link: None


<a id="9850"></a>
#### Trace Flag: 9850
**Undocumented trace flag**<br />
Function: Dumps more diagnostic stuff in the log.<br />
Link: [Bad Idea Jeans: Finding Undocumented Trace Flags]


<a id="9851"></a>
#### Trace Flag: 9851
**Undocumented trace flag**<br />
Function: For testing purposes, you might want to turn off automatic merging of files, so that you can more readily
explore this metadata. You can do that by turning on the undocumented trace flag 9851. And of course,
be sure to turn off the trace flag when done testing.<br/>
Link: http://gsl.azurewebsites.net/Portals/0/Users/dewitt/talks/HekatonWhitePaper.pdf


<a id="9929"></a>
#### Trace Flag: 9929
Function: Enables an update that reduces the “disk footprint [of In-Memory OLTP] by reducing the In-Memory checkpoint files to 1 MB (megabytes) each.”
 Because this traceflag is instance level, it affects the size of checkpoint files for all databases with a memory optimized filegroup on that instance.
 Be cautious when you use this traceflag.<br/>
Link: https://support.microsoft.com/kb/3147012/
Scope: global or session


<a id="9939"></a>
#### Trace Flag: 9939
Function: Disables merge/recompress during columnstore index reorganization.
In SQL Server 2016, when a columnstore index is reorganized, there is new functionality to automatically merge any small compressed rowgroups into larger compressed rowgroups, as well as recompressing any rowgroups that have a large number of deleted rows.<br />
**Note: Trace flag 10204 does not apply to columnstore indexes which are created on memory-optimized tables.**<br />
Link: [Docs Trace Flags]<br />
Link: [Parallelism in Hekaton (In-Memory OLTP)]
Scope: global or session


<a id="9989"></a>
#### Trace Flag: 9989
**Undocumented trace flag**<br />
Function: In CTP2, enabled functionality for reading in-memory tables on a readable secondary<br />
Link: https://connect.microsoft.com/SQLServer/feedback/details/795360/secondary-db-gets-suspect-when-i-add-in-memory-table-to-db-which-is-part-of-alwayson-availability-group


<a id="10202"></a>
#### Trace Flag: 10202
**Undocumented trace flag**<br />
Function: According to demo scripts from a Sunil Agarwal session at PASS 2014, enables a new DMV named sys.dm_db_column_store_row_group_physical_stats.
This DMV is not in SQL 2014 RTM and Sunil did not perform this demo during the session, so this DMV appears to be in a future (or internal) version of SQL Server.<br/>
Link: None


<a id="10204"></a>
#### Trace Flag: 10204
Function: Disables merge/recompress during columnstore index reorganization.
In SQL Server 2016, when a columnstore index is reorganized, there is new functionality to automatically merge any small compressed rowgroups
into larger compressed rowgroups, as well as recompressing any rowgroups that have a large number of deleted rows.<br />
**Note: Trace flag 10204 does not apply to column store indexes which are created on memory-optimized tables.**<br />
Link: [Docs Trace Flags]<br />
Link: [Niko Neugebauer Columnstore Indexes – part 86]<br />
Scope: global or session or query


<a id="10207"></a>
#### Trace Flag: 10207
Function: When a Clustered Columnstore index has corrupted segments, turning on this flag suppresses errors 5288 and 5289 and allows a scan of a clustered columns store to skip corrupt segments and complete (though with results that do not include the corrupted segment(s)). This flag is helpful when attempting to copy-out data in a corrupt CCI.<br/>
Link: https://support.microsoft.com/kb/3067257/<br />
Link: https://blogs.msdn.microsoft.com/sqlreleaseservices/partial-results-in-a-query-of-a-clustered-columnstore-index-in-sql-server-2014


<a id="10213"></a>
#### Trace Flag: 10213
**Undocumented trace flag**<br />
Function: Enables the option to configure compression delay in columnstore indexes in SQL Server 2016<br />
Link: http://www.nikoport.com/2016/02/04/columnstore-indexes-part-76-compression-delay/<br />
Scope: session only


<a id="10264"></a>
#### Trace Flag: 10264
**Undocumented trace flag**<br />
Function: Polybase mode enabled for SqlComposable.<br />
Link: [Bad Idea Jeans: Finding Undocumented Trace Flags]


<a id="10316"></a>
#### Trace Flag: 10316
Function: Enables creation of additional indexes on internal memory-optimized staging temporal table, beside the default one.
If you have specific query pattern that includes columns which are not covered by the default index you may consider adding additional ones.<br />
**Note: System-versioned temporal tables for Memory-Optimized Tables are designed to provide high transactional throughput.
Please be aware that creating additional indexes may introduce overhead for DML operations that update or delete rows in the current table.
With the additional indexes you should aim to find the right balance between performance of temporal queries and additional DML overhead.**<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/3198846<br />
Link: https://blogs.msdn.microsoft.com/sqlcat/2016/12/08/improve-query-performance-on-memory-optimized-tables-with-temporal-using-new-index-creation-enhancement-in-sp1/<br />
Scope: global or session


<a id="10809"></a>
#### Trace Flag: 10809
**Undocumented trace flag**<br />
Function: Force stream Aggregates for scalar aggregation in batch mode.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="11001"></a>
#### Trace Flag: 11001
**Undocumented trace flag**<br />
Function: Results in a different join order for some queries. Full effect unknown.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="11023"></a>
#### Trace Flag: 11023
Function: Disables the use of the last persisted sample rate, for all subsequent statistics update where a sample rate is not specified explicitly as part of the [UPDATE STATISTICS](https://docs.microsoft.com/en-us/sql/t-sql/statements/update-statistics-transact-sql) statement.<br />
Link: https://support.microsoft.com/kb/4039284<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="11024"></a>
#### Trace Flag: 11024
Function: In Microsoft SQL Server 2017, when incremental statistics are built on the top of partitioned tables, the sum of modification counts of all partitions is stored as the modification count of the root node.
When the modification count of the root node exceeds a [threshold](https://docs.microsoft.com/en-us/sql/relational-databases/statistics/statistics#AutoUpdateStats), the auto update of statistics is triggered.
However, if the modification count of any single partition does not exceed the local threshold, the statistics are not updated.
Additionally, the modification count of the root node is reset to zero. This may cause delay in the auto update of incremental statistics.
When trace flag 11024 is enabled, the modification count of the root node is kept as the sum of modification counts of all partitions.<br />
**Note: This trace flag applies to SQL Server 2016 (13.x) SP2, SQL Server 2017 (14.x) CU3, and higher builds.**<br />
Link: https://support.microsoft.com/kb/4041811<br />
Link: [Docs Trace Flags]<br />
Scope: global or session


<a id="11029"></a>
#### Trace Flag: 11029
**Undocumented trace flag**<br />
Function: Prevents new information about row goals from getting logged to the plan cache.<br />
Link: [New Undocumented Trace Flags]<br />
Scope: ?


<a id="11047"></a>
#### Trace Flag: 11047
Function: Applies the default timeout set by `query wait (s)` or the Resource Governor `REQUEST_MEMORY_GRANT_TIMEOUT_SEC` configuration to Columnstore index build operations.<br />
**Note: This trace flag applies to SQL Server 2016 (13.x) SP2 CU5, SQL Server 2017 (14.x) CU14, and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Link: https://support.microsoft.com/kb/4480641<br />
Scope: global or session


<a id="11064"></a>
#### Trace Flag: 11064
Function: Improves the scalability of data loading operations into columnstore indexes, by optimizing memory distribution between the `SELECT` and `INSERT` statements.<br />
For more information on loading data into a columnstore index, see [Columnstore indexes - Data loading guidance](https://docs.microsoft.com/en-gb/sql/relational-databases/indexes/columnstore-indexes-data-loading-guidance).
**Note: This trace flag applies to SQL Server 2019 (15.x) and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Scope: global only


<a id="11068"></a>
#### Trace Flag: 11068
Function: Uses the configured max degree of parallelism (MAXDOP) value for columnstore index insert operations.
For more information on overriding degrees of parallelism, see the [Query Processing Architecture Guide](https://docs.microsoft.com/en-gb/sql/relational-databases/query-processing-architecture-guide#overriding-degrees-of-parallelism).<br />
**Important: This trace flag is only effective if trace flag [11064](#11064) is also enabled.**<br />
**Important: Use this trace flag when faster data loads are preferred over maintaining [columnstore segment](https://docs.microsoft.com/en-gb/sql/relational-databases/indexes/columnstore-indexes-overview#column-segment) quality.
For example, using this trace flag when loading 1,048,577 rows into a columnstore may result in more than one compressed rowgroup, if the insert operation is executing in parallel mode.
Without this trace flag, the insert operation would result in one compressed rowgroup.**<br />
**Note: This trace flag applies to SQL Server 2019 (15.x) and higher builds.**<br />
Link: [Docs Trace Flags]<br />
Scope: global only


[Docs Trace Flags]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql
[Query Store Trace Flags]:https://www.sqlskills.com/blogs/erin/query-store-trace-flags/
[DBCC TRACEON]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-traceon-transact-sql
[DBCC TRACEOFF]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-traceoff-transact-sql
[DBCC TRACESTATUS]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-tracestatus-transact-sql
[DBCC CHECKDB]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql
[DBCC CHECKTABLE]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-checktable-transact-sql
[DBCC CHECKCONSTRAINTS]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-checkconstraints-transact-sql
[KB2801413]:https://support.microsoft.com/kb/2801413
[Niko Neugebauer Columnstore Indexes – part 86]:http://www.nikoport.com/2016/07/29/columnstore-indexes-part-86-new-trace-flags-in-sql-server-2016/
[Niko Neugebauer Columnstore Indexes – part 35]:http://www.nikoport.com/2014/07/24/clustered-columnstore-indexes-part-35-trace-flags-query-optimiser-rules/
[Microsoft SQL Server 2005 TPC-C Trace Flags]:http://webcache.googleusercontent.com/search?q=cache:Nttlt2Dp8egJ:blogs.msmvps.com/gladchenko/2009/08/21/sql_trace_flags_tpc-c/+&cd=6&hl=en&ct=clnk&gl=ru
[Trace Flag 1228 and 1229]:http://www.sqlservercentral.com/Forums/Topic741825-146-1.aspx
[A Topical Collection of SQL Server Flags v6]:https://sqlcrossjoin.files.wordpress.com/2016/04/sqlcrossjoin_traceflagrepository_v6.pdf
[How To Diagnose and Correct Errors 17883, 17884, 17887, and 17888]:https://msdn.microsoft.com/library/cc917684.aspx
[Trace flags in sql server from trace flag 902 to trace flag 1462]:http://www.sqlserverf1.com/tag/sql-server-trace-flag-1448/
[TECHNET List Of SQL Server Trace Flags]:http://social.technet.microsoft.com/wiki/contents/articles/13105.trace-flags-in-sql-server.aspx
[Cardinality Estimation Framework 2014 First Look]:http://www.somewheresomehow.ru/cardinality-estimation-framework-2014-first-look/
[Query Optimizer Deep Dive - Part 4]:https://www.sql.kiwi/2012/05/query-optimizer-deep-dive-part-4.html
[KB920093]:https://support.microsoft.com/kb/920093
[KB972767]:https://support.microsoft.com/kb/972767
[Tune compression for availability group]:https://docs.microsoft.com/sql/database-engine/availability-groups/windows/tune-compression-for-availability-group
[More Undocumented Query Optimizer Trace Flags]:http://www.benjaminnevarez.com/2012/04/more-undocumented-query-optimizer-trace-flags/
[KB3107399]:https://support.microsoft.com/kb/3107399
[KB2801413]:https://web.archive.org/web/20131202110153/https://support.microsoft.com/kb/2801413
[New Features in SQL Server 2016 Service Pack 1]:https://www.mssqltips.com/sqlservertip/4574/new-features-in-sql-server-2016-service-pack-1/
[Internals of the Seven SQL Server Sorts – Part 1]:https://sqlperformance.com/2015/04/sql-plan/internals-of-the-seven-sql-server-sorts-part-1
[Yet another X-Ray for the QP]:http://www.queryprocessor.com/tf_8628/
[How It Works: SQL Server 2012 Database Engine Task Scheduling]:https://blogs.msdn.microsoft.com/psssql/2013/08/13/how-it-works-sql-server-2012-database-engine-task-scheduling/
[What You Need to Know about the Batch Mode Window Aggregate Operator in SQL Server 2016: Part 1]:http://sqlmag.com/sql-server/what-you-need-know-about-batch-mode-window-aggregate-operator-sql-server-2016-part-1
[SQL Server 2016 : Getting tempdb a little more right]:https://blogs.sentryone.com/aaronbertrand/sql-server-2016-tempdb-fixes/
[Importance of Performing DBCC CHECKDB on all SQL Server Databases]:https://www.mssqltips.com/sqlservertip/4581/importance-of-performing-dbcc-checkdb-on-all-sql-server-databases/
[SQL Server Parallel Query Placement Decision Logic]:https://blogs.msdn.microsoft.com/psssql/2016/03/04/sql-server-parallel-query-placement-decision-logic/
[compatibility level]:https://docs.microsoft.com/sql/t-sql/statements/alter-database-transact-sql-compatibility-level
[Bad Idea Jeans: Finding Undocumented Trace Flags]:https://www.brentozar.com/archive/2017/10/bad-idea-jeans-finding-undocumented-trace-flags/
[SQL Server - estimates outside of the histogram - half-baked draft]:http://sql-sasquatch.blogspot.ru/2017/09/sql-server-estimates-outside-of.html
[Upgrading an expired SQL Server 2016 Evaluation Edition]:https://www.codykonior.com/2017/11/30/upgrading-an-expired-sql-server-2016-evaluation-edition/
[How to Find the Statistics Used to Compile an Execution Plan]:https://www.sql.kiwi/2011/09/how-to-find-the-statistics-used-to-compile-an-execution-plan.html
[New Undocumented Trace Flags]:https://orderbyselectnull.com/2018/01/09/45-new-trace-flags/
[Statistics and Cardinality Estimation]:http://topicaltraceflags.readthedocs.io/en/latest/cat/qry_StatsAndEst.html
[Splitting Strings Based on Patterns]:https://www.sqlservercentral.com/Forums/Topic1390297-3122-5.aspx
[SQL Server 2017: Adaptive Join Internals]:http://www.queryprocessor.com/adaptive-join-internals/
[Parallelism in Hekaton (In-Memory OLTP)]:http://www.nikoport.com/2018/01/20/parallelism-in-hekaton-in-memory-oltp/
[Hidden Performance & Manageability Improvements in SQL Server 2012 / 2014]:https://sqlperformance.com/2018/01/sql-performance/hidden-performance-manageability-improvements-sql-server-2012-2014
[KB917825]:https://support.microsoft.com/kb/917825
[TF6545-a]:https://support.microsoft.com/kb/4018930
[TF6545-b]:https://SqlQuantumLeap.com/2018/02/23/sqlclr-vs-sql-server-2012-2014-2016-part-7-clr-strict-security-the-problem-continues-in-the-past-wait-what/
[Controlling SQL Server memory dumps]:https://blogs.msdn.microsoft.com/psssql/2009/11/17/how-it-works-controlling-sql-server-memory-dumps
[Change SQL Server Collation – Back to Basics]:http://jasonbrimhall.info/2018/04/12/change-sql-server-collation/
[Important Trace Flags That Every DBA Should Know]:http://victorisakov.files.wordpress.com/2011/10/sql_pass_summit_2011-important_trace_flags_that_every_dba_should_know-victor_isakov.pdf
[A Row Goal Riddle]:https://orderbyselectnull.com/2018/03/30/a-row-goal-riddle/
[Undocumented Trace Flags: Inside the Restore Process]:https://blog.rdx.com/undocumented-trace-flags-inside-the-restore-process/
[What’s CHECKDB doing in my database restore?]:http://www.mikefal.net/2018/04/10/whats-checkdb-doing-in-my-database-restore/
[Few Outer Rows Optimization]:https://www.sqlshack.com/few-outer-rows-optimization/
[TEMPDB – Files and Trace Flags and Updates]:https://blogs.msdn.microsoft.com/sql_server_team/tempdb-files-and-trace-flags-and-updates-oh-my/
[Next-Level Parallel Plan Forcing: An Alternative to 8649]:http://dataeducation.com/next-level-parallel-plan-forcing-an-alternative-to-8649/
[SQL Server 6.5: Some Useful Trace Flag]:http://www.databasejournal.com/features/mssql/article.php/1443351/SQL-Server-65-Some-Useful-Trace-Flags.htm
[DAC]:https://docs.microsoft.com/sql/database-engine/configure-windows/diagnostic-connection-for-database-administrators
[DBCC SHOW_STATISTICS]:https://docs.microsoft.com/sql/t-sql/database-console-commands/dbcc-show-statistics-transact-sql
[ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)]:https://docs.microsoft.com/sql/t-sql/statements/alter-database-scoped-configuration-transact-sql
[KB169960]:https://web.archive.org/web/20150111103047/http://support.microsoft.com:80/kb/169960
[2628]:https://docs.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-events-and-errors?view=sql-server-2017#errors-2000-to-2999
[8152]:https://docs.microsoft.com/en-us/sql/relational-databases/errors-events/database-engine-events-and-errors?view=sql-server-2017#errors-8000-to-8999
[Fun with SQL Server Plan Cache, Trace Flag 8666, and Trace Flag 2388]:http://sql-sasquatch.blogspot.com/2018/12/fun-with-sql-server-plan-cache-trace_6.html
[Let’s talk about trace flags]:https://blogs.msdn.microsoft.com/sql_server_team/lets-talk-about-trace-flags/
[SQL Server Plan Cache Limits]:https://www.sqlskills.com/blogs/erin/sql-server-plan-cache-limits/
[KB2964518]:https://support.microsoft.com/kb/2964518
[SQL Server On Linux: Forced Unit Access (Fua) Internals]:http://bobsql.com/sql-server-on-linux-forced-unit-access-fua-internals/
[SQL Server Trace Flag 2544, Trace Flag 2546 and Trace Flag 2551]:https://www.sqlservergeeks.com/trace-flag-2544/
[Nested Loops Joins and Performance Spools]:https://sqlperformance.com/2019/09/sql-performance/nested-loops-joins-performance-spools
[Query Optimizer Deep Dive - Part 1]:https://www.sql.kiwi/2012/04/query-optimizer-deep-dive-part-1.html
[Optimizing T-SQL queries that change data]:https://www.sql.kiwi/2013/01/optimizing-t-sql-queries-that-change-data.html
[Query Optimizer Deep Dive – Part 3]:https://www.sql.kiwi/2012/04/query-optimizer-deep-dive-part-3.html
[Hello Operator, My Switch Is Bored]:https://www.sql.kiwi/2013/06/hello-operator-my-switch-is-bored.html
[Cardinality Estimation for Multiple Predicates]:https://sqlperformance.com/2014/01/sql-plan/cardinality-estimation-for-multiple-predicates
[Temporary Table Caching in Stored Procedures]:https://www.sql.kiwi/2012/08/temporary-tables-in-stored-procedures.html
[Replication Merge Agent]:https://docs.microsoft.com/en-us/sql/relational-databases/replication/agents/replication-merge-agent
[Why are (seemingly) suitable indexes not used on a LEFT JOIN with OR]:https://topanswers.xyz/databases?q=815#a960
[A SQL Server DBA myth a day: (15/30) checkpoint only writes pages from committed transactions]:http://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-1530-checkpoint-only-writes-pages-from-committed-transactions/
[SQL Server 2019 Aggressive Clustered Columnstore Cleanup]:https://www.tarynpivots.com/post/aggressive-clustered-columnstore-cleanup/
[KB153096]:https://support.microsoft.com/kb/153096
[SQL Server 2019 Aggregate Splitting]:https://www.sql.kiwi/2020/08/sql-server-2019-aggregate-splitting.html
[Minimizing the impact of DBCC CHECKDB]:https://sqlperformance.com/2012/11/io-subsystem/minimize-impact-of-checkdb
[KB2634571]:https://web.archive.org/web/20150303213855/http://support.microsoft.com/kb/2634571
