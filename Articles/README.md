# Microsoft SQL Server Articles

Articles types:
 - **[AZ]** Azure Articles
 - **[AMZ]** Amazon AWS Articles
 - **[B]** Backup Articles
 - **[BENCH]** Benchmarking Articles
 - **[IDX]** Index Articles
 - **[CLR]** [SQL Server Common Language Runtime Integration](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/sql-server-common-language-runtime-integration) Articles
 - **[CHP]** Checkpont Articles
 - **[COR]** Corruption Articles
 - **[DAX]** Data Analysis Expressions Articles
 - **[DBA]** DBA Articles
 - **[DEV]** Developers Articles
 - **[DM]** Database Mail
 - **[DBCC]** DBCC commands
 - **[DS]** Dynamic SQL
 - **[MG]** Migration Articles
 - **[J]** Jobs Articles
 - **[P]** Performance Articles
 - **[PS]** Powershell Articles
 - **[QS]** Query Store Articles
 - **[R]** R Language
 - **[SEC]** SQL Server Security Articles
 - **[SSIS]** [SQL Server Integration Services](https://docs.microsoft.com/en-us/sql/integration-services/sql-server-integration-services)
 - **[V]** Visualization Articles
 - **[X]** XML, JSON, YAML, HTML Articles
 - **[XE]** [Extended events](https://docs.microsoft.com/en-us/sql/relational-databases/extended-events/extended-events)

| Title                                                                                                                   | Author                                   | Modified   | Type        |
|-------------------------------------------------------------------------------------------------------------------------|------------------------------------------|------------|-------------|
| [Understanding how SQL Server executes a query]                                                                         | Remus Rusanu                             | 2016-04-15 |             |
| [SQL Server Index Design Guide]                                                                                         | Microsoft                                | 1753-01-01 | [IDX]       |
| [SQL Server 2012 Security Best Practices - Microsoft]                                                                   | Bob Beauchemin                           | 2012-01-15 | [SEC]       |
| [Help, my database is corrupt. Now what?]                                                                               | Gail Shaw                                | 2010-04-23 | [COR]       |
| [What to Do When DBCC CHECKDB Reports Corruption]                                                                       | Brent Ozar                               | 2016-05-19 | [COR]       |
| [Troubleshooting SQL Server CPU Performance Issues]                                                                     | Joe Sack                                 | 2013-05-28 | [P]         |
| [Knee-Jerk Performance Tuning : Incorrect Use of Temporary Tables]                                                      | Paul Randal                              | 2016-04-06 | [P]         |
| [High Performance T-SQL using Code Patterns]                                                                            | Dwain Camps                              | 2015-05-27 |             |
| [SQL Server Database Corruption Repair]                                                                                 | Steve Stedman                            | 2015-08-26 | [COR]       |
| [Basic SQL Server Performance Troubleshooting For Developers]                                                           | Tony Davis                               | 2015-08-14 | [P]         |
| [The Curse and Blessings of Dynamic SQL]                                                                                | Erland Sommarskog                        | 2015-04-14 | [DS]        |
| [Dynamic Search Conditions in T-SQL]                                                                                    | Erland Sommarskog                        | 2016-10-29 |             |
| [Slow in the Application, Fast in SSMS]                                                                                 | Erland Sommarskog                        | 2013-12-18 |             |
| [How to share data between stored procedures]                                                                           | Erland Sommarskog                        | 2013-11-02 |             |
| [Arrays and Lists in SQL Server 2008]                                                                                   | Erland Sommarskog                        | 2016-08-21 |             |
| [Packaging Permissions in Stored Procedures]                                                                            | Erland Sommarskog                        | 2011-12-31 |             |
| [Error and Transaction Handling in SQL Server Part One – Jumpstart Error Handling]                                      | Erland Sommarskog                        | 2015-05-03 | [DBA][DEV]  |
| [Error and Transaction Handling in SQL Server Part Two – Commands and Mechanisms]                                       | Erland Sommarskog                        | 2019-09-03 | [DBA][DEV]  |
| [Error and Transaction Handling in SQL Server Part Three – Implementation]                                              | Erland Sommarskog                        | 2017-05-03 | [DBA][DEV]  |
| [Using the Bulk-Load Tools in SQL Server]                                                                               | Erland Sommarskog                        | 2016-12-08 |             |
| [Using Table-Valued Parameters in SQL Server and .NET]                                                                  | Erland Sommarskog                        | 2016-12-08 |             |
| [SQL Server Columnstore Articles]                                                                                       | Niko Neugebauer                          | 2016-05-09 |             |
| [Documentation: It Does not Suck!]                                                                                      | Jes Schultz Borland                      | 2013-01-15 |             |
| [The Data Loading Performance Guide]                                                                                    | Thomas Kejser, Peter Carlin, Stuart Ozer | 2009-01-15 |             |
| [Required Testing for Installing SQL Server Cumulative Updates and Service Packs]                                       | Kendra Little                            | 2016-04-28 |             |
| [Stop Shrinking Your Database Files. Seriously. Now.]                                                                   | Brent Ozar                               | 2009-08-19 |             |
| [How to shrink a database in 4 easy steps]                                                                              | Andy Mallon                              | 2016-04-28 |             |
| [Introduction to the Index Operational Statistics Dynamic Management Function]                                          | Tim Ford                                 | 2016-04-26 | [IDX]       |
| [Updating Statistics in SQL Server: Maintenance Questions & Answers]                                                    | Kendra Little                            | 2016-04-18 |             |
| [Overcoming Variable Limitations in SQLCmd Mode]                                                                        | Robert L Davis                           | 2015-11-23 |             |
| [Contents of a Run Book]                                                                                                | Microsoft                                | 2002-11-12 |             |
| [Compressed and Encrypted Backups on the Cheap]                                                                         | Randolph West                            | 2015-04-19 | [B]         |
| [Curing Data-Obesity in OLTP Databases]                                                                                 | Feodor Georgiev                          | 2015-02-06 |             |
| [Understanding GRANT, DENY, and REVOKE in SQL Server]                                                                   | K. Brian Kelley                          | 2013-02-27 |             |
| [Monitor SQL Server Transaction Log File Free Space]                                                                    | Mike Eastland                            | 2015-05-12 |             |
| [Dynamically Query a 100 Million Row Table-Efficiently]                                                                 | Gary Strange                             | 2016-05-27 |             |
| [Understanding and Using Parallelism in SQL Server]                                                                     | Paul White                               | 2011-03-03 |             |
| [Diagnosing and Resolving Latch Contention on SQL Server]                                                               | Microsoft                                | 2014-02-28 |             |
| [Parallel Execution Plans – Branches and Threads]                                                                       | Paul White                               | 2013-10-07 | [DBA][DEV]  |
| [Nasty Fast PERCENT_RANK]                                                                                               | Alan Burstein                            | 2016-06-07 |             |
| [Looking at VIEWs, Close Up]                                                                                            | Joe Celko                                | 2016-05-10 |             |
| [SQL Server 2016: It Just Runs Faster]                                                                                  | Thomas LaRock                            | 2016-06-01 |             |
| [TSQL JOIN Types Poster]                                                                                                | Steve Stedman                            | 2015-05-28 |             |
| [It is Hard To Destroy Data]                                                                                            | Michael J Swart                          | 2015-05-20 |             |
| [How to transfer logins and passwords between instances of SQL Server]                                                  | Microsoft                                | 2013-12-07 |             |
| [Finding File Growths with Extended Events]                                                                             | Andy Galbraith                           | 2016-06-13 | [XE]        |
| [Questions You Should Ask About the Databases You Manage]                                                               | Brent Ozar                               | 2016-06-16 |             |
| [Clustered Indexes in SQL Server]                                                                                       | Derik Hammer                             | 2016-06-22 | [IDX]       |
| [Triage Quiz: Is Your SQL Server Safe?]                                                                                 | Angie Rudduck                            | 2016-06-15 |             |
| [Why Not Just Create Statistics?]                                                                                       | Erik Darling                             | 2016-07-14 |             |
| [Understanding the SQL Server NOLOCK hint]                                                                              | Greg Robidoux                            | 2011-08-16 |             |
| [Recover access to a SQL Server instance]                                                                               | Aaron Bertrand                           | 2012-08-30 | [SEC]       |
| [SQL Server 2016 Upgrade Planning]                                                                                      | Jen Underwood                            | 2016-06-28 |             |
| [Graphs and Graph Algorithms in T-SQL]                                                                                  | Hans Olav Norheim                        | 2010-05-22 |             |
| [Episode 4: SQL Server R Services makes you a smarter T-SQL Developer]                                                  | Sanjay Mishra                            | 2016-07-12 | [DEV][R]    |
| [How to Set Max Degree of Parallelism in SQL Server]                                                                    | Kendra Little                            | 2016-07-14 |             |
| [Undocumented Query Plans: Equality Comparisons]                                                                        | Paul White                               | 2016-06-22 |             |
| [Simplified Order Of Operations]                                                                                        | Michael J Swart                          | 2016-07-20 |             |
| [SQL Server Statistics Basics]                                                                                          | Robert Sheldon                           | 2016-07-22 |             |
| [Learn to Use sp_Blitz, sp_BlitzCache, sp_BlitzFirst, and sp_BlitzIndex with These Tutorial Videos]                     | Brent Ozar                               | 2016-09-12 |             |
| [Where is a record really located?]                                                                                     | Tim Chapman                              | 2016-09-15 |             |
| [Instant File Initialization (IFI)]                                                                                     | Steve Stedman                            | 2016-09-19 |             |
| [How to Query the StackExchange Databases]                                                                              | Brent Ozar                               | 2014-01-17 |             |
| [How to Troubleshoot Performance in SQL Server (Dear SQL DBA)]                                                          | Kendra Little                            | 2016-06-02 |             |
| [How to Log Activity Using sp_whoisactive in a Loop]                                                                    | Brent Ozar                               | 2016-07-01 |             |
| [Logging Activity Using sp_WhoIsActive – Take 2]                                                                        | Tara Kizer                               | 2016-07-26 |             |
| [How To Fix Forwarded Records]                                                                                          | Tara Kizer                               | 2016-07-29 |             |
| [Should I Automate my Windows Updates for SQL Server?]                                                                  | Kendra Little                            | 2016-07-28 |             |
| [Finding the Right Path]                                                                                                | Jason Brimhall                           | 2016-08-24 |             |
| [#BackToBasics : An Updated "Kitchen Sink" Example]                                                                     | Aaron Bertrand                           | 2016-06-01 |             |
| [Locking and Blocking in SQL Server]                                                                                    | Brent OZar                               | 2016-01-01 |             |
| [Nested Loops Prefetching]                                                                                              | Paul White                               | 2013-08-31 |             |
| [Performance tuning backup and restore operations]                                                                      | Derik Hammer                             | 2015-12-21 | [B][P]      |
| [Execution Plan Analysis: The Mystery Work Table]                                                                       | Paul White                               | 2013-03-08 |             |
| [How to move data between File Groups in SQL Server]                                                                    | Klaus Aschenbrenner                      | 2016-09-26 |             |
| [Optimizing Your Query Plans with the SQL Server 2014 Cardinality Estimator]                                            | Joseph Sack                              | 2014-06-24 |             |
| [Parallelism in SQL Server Query Tuning]                                                                                | Itzik Ben-Gan                            | 2011-03-14 |             |
| [What You Need to Know about the Batch Mode Window Aggregate Operator in SQL Server 2016: Part 1]                       | Itzik Ben-Gan                            | 2016-05-31 |             |
| [What To Do If sp_BlitzFirst Warns About High Compilations]                                                             | Erik Darling                             | 2016-09-27 |             |
| [Questions You Should Be Asking About Your Backups]                                                                     | Erik Darling                             | 2016-10-13 | [B]         |
| [Evolutionary Database Design]                                                                                          | Martin Fowler                            | 2016-05-01 |             |
| [Implementing a custom sort]                                                                                            | Rob Farley                               | 2016-10-17 |             |
| [Deletes that Split Pages and Forwarded Ghosts]                                                                         | Paul White                               | 2012-08-31 |             |
| [Query Optimizer Deep Dive - Part 1]                                                                                    | Paul White                               | 2012-04-28 |             |
| [Query Optimizer Deep Dive - Part 2]                                                                                    | Paul White                               | 2012-04-28 |             |
| [Query Optimizer Deep Dive - Part 3]                                                                                    | Paul White                               | 2012-04-29 |             |
| [Query Optimizer Deep Dive - Part 4]                                                                                    | Paul White                               | 2012-05-01 |             |
| [Should You Rebuild or Reorganize Indexes on Large Tables?]                                                             | Kendra Little                            | 2016-10-13 | [IDX]       |
| [Retrieving SQL Server Query Execution Plans]                                                                           | Robert Sheldon                           | 2016-10-18 |             |
| [Introduction to Latches in SQL Server]                                                                                 | Klaus Aschenbrenner                      | 2014-06-23 |             |
| [Latch Coupling in SQL Server]                                                                                          | Klaus Aschenbrenner                      | 2016-10-24 |             |
| [Partitioned Views? A How-To Guide]                                                                                     | Erik Darling                             | 2016-09-22 |             |
| [How to Choose Between RCSI and Snapshot Isolation Levels]                                                              | Kendra Little                            | 2016-02-18 |             |
| [TroubleShooting SQL Server Memory Consumption]                                                                         | Satnam Singh                             | 2012-09-28 |             |
| [Time Series Algorithms in SQL Server]                                                                                  | Dinesh Asanka                            | 2015-06-01 |             |
| [Heap Tables in SQL Server]                                                                                             | Klaus Aschenbrenner                      | 2015-10-19 |             |
| [Internals of the Seven SQL Server Sorts – Part 1]                                                                      | Paul White                               | 2015-04-29 |             |
| [Internals of the Seven SQL Server Sorts – Part 2]                                                                      | Paul White                               | 2015-05-07 |             |
| [The 9 Letters That Get DBAs Fired]                                                                                     | Brent Ozar                               | 2011-12-22 |             |
| [Restarting SQL Server – always a good idea?]                                                                           | Klaus Aschenbrenner                      | 2016-08-08 |             |
| [Don’t believe everything you read: Reconfigure flushes the plan cache]                                                 | Matt Bowler                              | 2012-06-25 |             |
| [How-to load data fast into SQL Server 2016]                                                                            | Henk                                     | 2016-10-24 |             |
| [Database Design Matters, RTO and Filegroups]                                                                           | Raul Gonzalez                            | 2016-10-28 |             |
| [Automate Alerting for SQL Server Suspect Database Pages]                                                               | Ben Snaidero                             | 2016-01-25 |             |
| [Successful Anti-Patterns, Storage Requirements]                                                                        | Raul Gonzalez                            | 2016-10-19 |             |
| [SQL Server table columns under the hood]                                                                               | Remus Rusanu                             | 2011-10-20 |             |
| [How to analyse SQL Server performance]                                                                                 | Remus Rusanu                             | 2014-02-24 |             |
| [To BLOB or Not To BLOB: Large Object Storage in a Database or a Filesystem?]                                           | Jim Gray                                 | 2006-04-01 |             |
| [Asynchronous procedure execution]                                                                                      | Remus Rusanu                             | 2009-08-05 |             |
| [What is the CXPACKET Wait Type, and How Do You Reduce It?]                                                             | Brent Ozar                               | 2013-08-27 |             |
| [New indexes, hypothetically]                                                                                           | Kenneth Fisher                           | 2016-11-02 | [IDX]       |
| [Indexing Wide Keys in SQL Server]                                                                                      | Brent Ozar                               | 2013-05-08 | [IDX]       |
| [The Anatomy and (In)Security of Microsoft SQL Server Transparent Data Encryption (TDE), or How to Break TDE]           | Simon McAuliffe                          | 2016-03-31 | [SEC]       |
| [Correctly adding data files to tempdb]                                                                                 | Paul Randal                              | 2014-10-14 |             |
| [Why You Should Test Your Queries Against Bigger Data]                                                                  | Erik Darling                             | 2016-11-01 |             |
| [Tally OH! An Improved SQL 8K “CSV Splitter” Function]                                                                  | Jeff Moden                               | 2012-12-28 |             |
| [Set Statistics… Profile?]                                                                                              | Erik Darling                             | 2016-10-11 |             |
| [Hierarchies on Steroids #1: Convert an Adjacency List to Nested Sets]                                                  | Jeff Moden                               | 2014-09-19 |             |
| [Optimizing T-SQL queries that change data]                                                                             | Paul White                               | 2013-01-26 |             |
| [Measuring Query Duration: SSMS vs SQL Sentry Plan Explorer]                                                            | Kendra Little                            | 2016-09-27 |             |
| [Inside the Statistics Histogram & Density Vector]                                                                      | Klaus Aschenbrenner                      | 2014-01-28 |             |
| [Misconceptions on parameter sniffing]                                                                                  | Hugo Kornelis                            | 2016-11-03 |             |
| [What Every Accidental DBA Needs to Know Now: Basics of SQL Security]                                                   | Tim Ford                                 | 2016-10-03 | [SEC]       |
| [SQL Server Perfmon (Performance Monitor) Best Practices]                                                               | Brent Ozar                               | 2006-12-30 |             |
| [Top 5 Overlooked Index Features]                                                                                       | Erik Darling                             | 2016-11-10 | [IDX]       |
| [A Sysadmin’s Guide to Microsoft SQL Server Memory]                                                                     | Brent Ozar                               | 2016-09-15 |             |
| [Searching Strings in SQL Server is Expensive]                                                                          | Brent Ozar                               | 2016-10-18 |             |
| [Altering an INT Column to a BIGINT]                                                                                    | Kendra Little                            | 2016-08-04 |             |
| [Query tuning 101: Problems with IN ()]                                                                                 | Daniel Janik                             | 2016-11-10 |             |
| [Admin: Bulkadmin vs ADMINISTER BULK OPERATIONS]                                                                        | Richard A Brown                          | 2012-01-31 |             |
| [Can Indexes My Query Doesn’t Use Help My Query?]                                                                       | Erik Darling                             | 2016-11-09 | [IDX]       |
| [SQL Server Audit Walkthrough]                                                                                          | Sadequl Hussain                          | 2016-01-01 |             |
| [The SQL Server 2016 Query Store: Overview and Architecture]                                                            | Enrico van de Laar                       | 2015-11-16 | [QS]        |
| [Reading, Writing, and Creating SQL Server Extended Properties]                                                         | Phil Factor                              | 2015-10-21 | [XE]        |
| [Questions About SQL Server Security and Access Control You Were Too Shy to Ask]                                        | William Brewer                           | 2016-11-04 | [SEC]       |
| [The Ten Commandments of SQL Server Monitoring]                                                                         | Adam Machanic                            | 2013-04-09 |             |
| [Should I use NOT IN, OUTER APPLY, LEFT OUTER JOIN, EXCEPT, or NOT EXISTS?]                                             | Adam Machanic                            | 2012-12-27 |             |
| [Parameter Sniffing, Embedding, and the RECOMPILE Options]                                                              | Paul White                               | 2013-08-28 |             |
| [Can comments hamper stored procedure performance?]                                                                     | Aaron Bertrand                           | 2016-11-09 |             |
| [SQL Server Temporary Table Caching]                                                                                    | Simon Liew                               | 2016-08-12 |             |
| [Techniques to Monitor SQL Server memory usage]                                                                         | Basit Farooq                             | 2016-08-01 |             |
| [Troubleshooting Query Regressions Caused By The New Cardinality Estimator]                                             | SQL Scotsman                             | 2016-11-28 |             |
| [Migrating Databases to Azure SQL Database]                                                                             | Tim Radney                               | 2016-10-25 | [AZ][MG]    |
| [Solve Common SQL Server Restore Issues]                                                                                | Sergey Gigoyan                           | 2015-04-12 |             |
| [Spills SQL Server Doesn’t Warn You About]                                                                              | Erik Darling                             | 2016-11-30 |             |
| [How often should I run DBCC CHECKDB?]                                                                                  | Erik Darling                             | 2016-02-25 |             |
| [Why is My Query Faster the Second Time it Runs?]                                                                       | Kendra Little                            | 2016-11-25 |             |
| [Downgrading the SQL Server Edition of a Dev Environment]                                                               | Kendra Little                            | 2016-11-15 |             |
| [Date Math In The WHERE Clause]                                                                                         | Erik Darling                             | 2016-12-01 |             |
| [Why is This Partitioned Query Slower?]                                                                                 | Kendra Little                            | 2015-09-01 |             |
| [A Beginner’s Guide to the True Order of SQL Operations]                                                                | Lukas Eder                               | 2016-12-09 |             |
| [Logical Query Processing: What It Is And What It Means to You]                                                         | Itzik Ben-Gan                            | 2016-01-15 |             |
| [Forcing a Parallel Query Execution Plan]                                                                               | Paul White                               | 2011-12-23 |             |
| [Join Containment Assumption and CE Model Variation]                                                                    | Dmitri Pilugin                           | 2014-05-04 |             |
| [Table Variable Tip]                                                                                                    | Itzik Ben-Gan                            | 2015-02-08 |             |
| [Heap tables in SQL Server]                                                                                             | Derik Hammer                             | 2016-04-13 |             |
| [The ‘B’ in B-Tree – Indexing in SQL Server]                                                                            | Derik Hammer                             | 2016-04-04 | [IDX]       |
| [How to read the SQL Server Database Transaction Log]                                                                   | Manvendra Singh                          | 2013-10-31 |             |
| [Filtered Statistics Follow-up]                                                                                         | Erik Darling                             | 2016-12-22 |             |
| [SQL Server Query Optimization: No Unknown Unknowns]                                                                    | Itzik Ben-Gan                            | 2015-10-13 |             |
| [Sync Vs Async Statistics: The Old Debate]                                                                              | SQL Scotsman                             | 2016-12-10 |             |
| [Recommended updates and configuration options for SQL Server 2012 and SQL Server 2014 with high-performance workloads] | Microsoft                                | 2016-03-08 |             |
| [Troubleshooting SQL Server backup and restore operations]                                                              | Microsoft                                | 2016-07-23 | [B]         |
| [SQL Server 2016: Getting tempdb a little more right]                                                                   | Aaron Bertrand                           | 2015-09-30 |             |
| [Practical uses of binary types]                                                                                        | Daniel Hutmacher                         | 2017-01-09 |             |
| [Backing Up SQL Server Databases is Easier in PowerShell than T-SQL]                                                    | Aaron Nelson                             | 2017-01-12 | [PS]        |
| [Creating, detaching, re-attaching, and fixing a SUSPECT database]                                                      | Paul Randal                              | 2008-08-29 |             |
| [Modifying Tables Online – Part 1: Migration Strategy]                                                                  | Michael J Swart                          | 2012-04-16 | [MG]        |
| [Modifying Tables Online – Part 2: Implementation Example]                                                              | Michael J Swart                          | 2012-04-17 | [MG]        |
| [Modifying Tables Online – Part 3: Example With Error Handling]                                                         | Michael J Swart                          | 2012-04-20 | [MG]        |
| [Modifying Tables Online – Part 4: Testing]                                                                             | Michael J Swart                          | 2012-04-26 | [MG]        |
| [Modifying Tables Online – Part 5: Just One More Thing]                                                                 | Michael J Swart                          | 2012-04-27 |             |
| [DATEDIFF vs. DATEADD]                                                                                                  | Guy Glanster                             | 2017-01-25 |             |
| [Disaster recovery 101: hack-attach a damaged database]                                                                 | Paul Randal                              | 2010-06-18 |             |
| [Bones of SQL - The Calendar Table]                                                                                     | Bob Hovious                              | 2016-09-08 |             |
| [SQL Server 2016, Double or Nothing, Always Encrypted with temporal tables]                                             | Raul Gonzalez                            | 2016-07-27 |             |
| [Reclaiming Space After Column Data Type Change]                                                                        | David Fundakowski                        | 2016-08-09 |             |
| [Packing Intervals with Priorities]                                                                                     | Itzik Ben-Gan                            | 2015-11-10 |             |
| [Avoid Unnecessary Lookups when Using ROW_NUMBER for Paging]                                                            | Itzik Ben-Gan                            | 2014-12-11 |             |
| [Migrating a Disk-Based Table to a Memory-Optimized Table in SQL Server]                                                | Alex Grinberg                            | 2017-02-26 | [MG]        |
| [SQL Server Hardware Optimization]                                                                                      | Basit Farooq                             | 2016-06-01 |             |
| [Index Types  Heaps, Primary Keys, Clustered and Nonclustered Indexes]                                                  | Kendra Little                            | 2017-02-02 | [IDX]       |
| [Identifying Existence of Intersections in Intervals]                                                                   | Itzik Ben-Gan                            | 2017-02-08 |             |
| [Cheat Sheet  How to Configure TempDB for Microsoft SQL Server]                                                         | Brent Ozar                               | 2016-01-14 |             |
| [A Tourist’s Guide to the sp_Blitz Source Code, Part 1: The Big Picture]                                                | Brent Ozar                               | 2017-02-09 |             |
| [SQL Server Default Configurations That You Should Change]                                                              | Pio Balistoy                             | 2017-02-06 |             |
| [Decoding Key and Page WaitResource for Deadlocks and Blocking]                                                         | Kendra Little                            | 2016-10-17 |             |
| [Security in the CLR World Inside SQL Server]                                                                           | Kiely Don                                | 1990-01-01 | [CLR][SEC]  |
| [On the Advantages of DateTime2(n) over DateTime]                                                                       | William Assaf                            | 2012-12-04 |             |
| [Build Your Own Tools]                                                                                                  | Michael J Swart                          | 2016-09-23 |             |
| [Enhanced T-SQL Error Handling With Extended Events]                                                                    | Dave Mason                               | 2016-09-14 | [XE]        |
| [Compression and its Effects on Performance]                                                                            | Erin Stellato                            | 2017-01-20 |             |
| [Does Truncate Table Reset Statistics]                                                                                  | Kendra Little                            | 2016-12-08 |             |
| [SQL Server Database Decommissioning Check List]                                                                        | Svetlana Golovko                         | 2016-06-23 |             |
| [New SQL Server Database Request Questionnaire and Checklist]                                                           | Svetlana Golovko                         | 2015-02-24 |             |
| [Adding Partitions to the Lower End of a Left Based Partition Function]                                                 | Kendra Little                            | 2017-02-21 |             |
| [Don't Panic  Busting a File Space Myth]                                                                                | Tim Ford                                 | 2016-11-14 |             |
| [#BackToBasics : Dating Responsibly]                                                                                    | Aaron Bertrand                           | 2016-04-06 |             |
| [How to Establish Dedicated Admin Connection (DAC) to SQL Server]                                                       | Mika Wendelius                           | 2016-10-05 |             |
| [SQL and SQL only Best Practice]                                                                                        | Nagaraj Venkatesan                       | 2013-05-27 |             |
| [There Is No Difference Between Table Variables, Temporary Tables, and Common Table Expressions]                        | Grant Fritchey                           | 2016-08-04 |             |
| [Availability Group on SQL Server 2016]                                                                                 | Guy Glantser                             | 2017-02-01 |             |
| [Using SQL Server and R Services for analyzing DBA Tasks]                                                               | Tomaž Kaštrun                            | 2017-02-17 |             |
| [SQLskills SQL101: Dealing with SQL Server corruption]                                                                  | Paul Randal                              | 2017-02-28 | [COR]       |
| [Advanced Analytics with R & SQL: Part I - R Distributions]                                                             | Frank A. Banin                           | 2016-10-31 | [R]         |
| [T-SQL Tuesday #85  STOP! Restore Time!]                                                                                | Derik Hammer                             | 2016-12-13 |             |
| [Filtered Indexes: Rowstore vs Nonclustered Columnstore]                                                                | Kendra Little                            | 2016-11-10 | [IDX]       |
| [ALTER SCHEMA TRANSFER for Zero Downtime Database Upgrades]                                                             | Dave Wentzel                             | 2013-05-21 |             |
| [Delayed Durability in SQL Server 2014]                                                                                 | Aaron Bertrand                           | 2014-04-28 |             |
| [Daylight Savings end affects not only you, but your SQL Server too]                                                    | Aaron Bertrand                           | 2014-04-28 |             |
| [Searching Strings in SQL Server is Expensive]                                                                          | Brent Ozar                               | 2016-10-18 |             |
| [Let’s Corrupt a SQL Server Database Together, Part 1: Clustered Indexes]                                               | Brent Ozar                               | 2017-02-22 | [COR][IDX]  |
| [Let’s Corrupt a Database Together, Part 2: Nonclustered Indexes]                                                       | Brent Ozar                               | 2017-02-28 | [COR][IDX]  |
| [The Guide  SQL Server Installation Checklist (settings that increase SQL Server Performance)]                          | Mark Varnas                              | 2017-03-03 |             |
| [SQL Browser, what is it good for? Absolutely something!]                                                               | Chris Sommer                             | 2017-03-01 |             |
| [PowerShell Getting More From Generic Error Messages]                                                                   | Shane O'Neill                            | 2017-03-02 | [PS]        |
| [#BackToBasics : Common Table Expressions (CTEs)]                                                                       | Aaron Bertrand                           | 2016-01-06 |             |
| [SQL VNext sp_configure on Windows and Linux with dbatools]                                                             | Rob Sewell                               | 2017-03-02 | [PS]        |
| [Adding a T-SQL Job Step to a SQL Agent Job with PowerShell]                                                            | Rob Sewell                               | 2017-02-20 | [PS][J]     |
| [Setting up Database Mail to use my Gmail account]                                                                      | Mat Hayward                              | 2017-03-01 | [DM]        |
| [Using DBCC CLONEDATABASE and Query Store for Testing]                                                                  | Erin Stellato                            | 2017-02-22 | [DBCC][QS]  |
| [Getting Started with Natural Earth — A SQL Server Shapefile Alternative (Geospatial Resource)]                         | Jeff Pries                               | 2017-02-17 | [V]         |
| [SQL Server Temporal Tables: How-To Recipes]                                                                            | Alex Grinberg                            | 2017-02-10 | [DEV]       |
| [The Migration Checklist]                                                                                               | Steve Jones                              | 2017-03-08 | [MG]        |
| [Upgrading to SQL Server 2014: A Dozen Things to Check]                                                                 | Steve Jones                              | 2014-06-03 | [MG]        |
| [Introducing the Set-based Loop]                                                                                        | Luis Cazares                             | 2015-07-27 | [DEV]       |
| [Representing Hierarchical Data for Mere Mortals]                                                                       | Phil Factor                              | 2016-10-06 | [DEV]       |
| [KPIs For DBAs to Show Their CIOs]                                                                                      | Thomas Larock                            | 2017-03-08 | [DBA]       |
| [How To Forecast Database Disk Capacity If You Don’t Have A Monitoring Tool]                                            | Edwin M Sarmiento                        | 2015-07-31 | [DBA]       |
| [Statistical Sampling for Verifying Database Backups]                                                                   | Thomas Larock                            | 2010-05-13 | [B][DBA]    |
| [Using dbatools for automated restore and CHECKDB]                                                                      | Anthony Nocentino                        | 2017-03-04 | [DBA][PS]   |
| [Bad Habits Revival]                                                                                                    | Aaron Bertrand                           | 2017-01-26 | [DBA]       |
| [Deploying Multiple SSIS Projects via PowerShell]                                                                       | Nat Sundar                               | 2017-02-27 | [SSIS,][PS] |
| [Determining the Cost Threshold for Parallelism]                                                                        | Grant Fritchey                           | 2017-02-28 | [DBA]       |
| [Identifying a row’s physical location]                                                                                 | Wayne Sheffield                          | 2017-03-08 | [DBA]       |
| [Split a file group into multiple data files]                                                                           | Trayce Jordan                            | 2017-03-03 | [DBA]       |
| [Why PFS pages cannot be repaired]                                                                                      | Paul Randal                              | 2017-03-05 | [DBA]       |
| [ERRORLOG records max out at 2049 characters]                                                                           | Cody Konior                              | 2017-03-02 | [DEV]       |
| [How to Build a SQL Server Disaster Recovery Plan with Google Compute Engine]                                           | Tara Kizer                               | 2017-03-10 | [DBA]       |
| [SQL Server Performance Tuning in Google Compute Engine]                                                                | Erik Darling                             | 2017-03-09 | [DBA][P]    |
| [Configuring R on SQL Server 2016]                                                                                      | Ginger Grant                             | 2016-12-06 | [DBA][R]    |
| [Knee-Jerk PerfMon Counters: Page Life Expectancy]                                                                      | Paul Randal                              | 2014-10-20 | [DBA][P]    |
| [Change Management Template for SQL Server DBAs and Developers]                                                         | Kendra Little                            | 2016-04-12 | [DBA]       |
| [Performance Myths: Clustered vs. Non-Clustered Indexes]                                                                | Aaron Bertrand                           | 2017-03-17 | [IDX]       |
| [Bad habits: Counting rows the hard way]                                                                                | Aaron Bertrand                           | 2014-10-30 | [DEV]       |
| [Why Cost Threshold For Parallelism Shouldn’t Be Set To 5]                                                              | Erik Darling                             | 2017-03-14 | [DBA]       |
| [Join Performance, Implicit Conversions, and Residuals]                                                                 | Paul White                               | 2011-07-18 | [DEV]       |
| [Implicit Conversions that cause Index Scans]                                                                           | Jonathan Kehayias                        | 2011-04-11 | [DEV]       |
| [When Is It Appropriate To Store JSON in SQL Server?]                                                                   | Bert Wagner                              | 2017-03-14 | [DEV]       |
| [The Performance Penalty of Bookmark Lookups in SQL Server]                                                             | Klaus Aschenbrenner                      | 2017-03-17 | [IDX]       |
| [Why You Should Change the Cost Threshold for Parallelism]                                                              | Grant Fritchey                           | 2017-03-13 | [DBA]       |
| [Why Update Statistics can cause an IO storm]                                                                           | Kendra Little                            | 2014-01-29 | [DBA]       |
| [SQLskills SQL101  Temporary table misuse]                                                                              | Paul White                               | 2017-03-13 | [DEV]       |
| [SQL Server sp_execute_external_script Stored Procedure Examples]                                                       | Vitor Montalvao                          | 2017-03-10 | [R]         |
| [Transparent Data Encryption and Replication]                                                                           | Drew Furgiuele                           | 2017-03-15 | [DBA]       |
| [SQL Server Installation Checklist]                                                                                     | Jonathan Kehayias                        | 2010-03-22 | [DBA]       |
| [Indexed Views And Data Modifications]                                                                                  | Erik Darling                             | 2017-03-16 | [DEV]       |
| [Deployment Automation for SQL Server Integration Services (SSIS)]                                                      | Nat Sundar                               | 2017-01-12 | [DEV]       |
| [Why Developers Should Consider Microsoft SQL Server]                                                                   | Brent Ozar                               | 2017-03-22 | [DEV]       |
| [SQLskills SQL101: Indexes on Foreign Keys]                                                                             | Kimberly Tripp                           | 2017-03-21 | [DEV]       |
| [SQLskills SQL101: Updating SQL Server Statistics Part I – Automatic Updates]                                           | Erin Stellato                            | 2017-03-23 | [DBA]       |
| [Processing Loops in SQL Server]                                                                                        | CHill60                                  | 2017-03-23 | [DEV]       |
| [The Mysterious Case of the Missing Default Value]                                                                      | Raul Gonzalez                            | 2017-03-24 | [DEV]       |
| [Plan Caching]                                                                                                          | Klaus Aschenbrenner                      | 2017-03-20 | [DEV]       |
| [sp_executesql Is Not Faster Than an Ad Hoc Query]                                                                      | Grant Fritchey                           | 2016-11-07 | [DEV]       |
| [Backing up SQL Server on Linux using Ola Hallengrens Maintenance Solution]                                             | Rob Sewell                               | 2017-03-22 | [B]         |
| [Delayed Durability in SQL Server 2014 Paul Randal]                                                                     | Paul Randal                              | 2014-11-20 | [DBA]       |
| [Why Is This Query Sometimes Fast and Sometimes Slow]                                                                   | Brent Ozar                               | 2016-11-16 | [DEV]       |
| [Using Plan Guides to Remove OPTIMIZE FOR UNKNOWN Hints]                                                                | Brent Ozar                               | 2016-11-17 | [DEV]       |
| [ETL Best Practices]                                                                                                    | Tim Mitchel                              | 2017-01-01 | [DEV]       |
| [Resolving Key Lookup Deadlocks with Plan Explorer]                                                                     | Greg Gonzalez                            | 2017-03-21 | [DEV]       |
| [Why ROWLOCK Hints Can Make Queries Slower and Blocking Worse in SQL Server]                                            | Kendra Little                            | 2016-02-04 | [DEV]       |
| [Does a Clustered Index really physically store the rows in key order]                                                  | Wayne Sheffield                          | 2012-10-21 | [DEV]       |
| [Ugly Pragmatism For The Win]                                                                                           | Michael J Swart                          | 2016-02-11 | [DEV]       |
| [Architecting Microsoft SQL Server on VMware vSphere]                                                                   | Niran Even-Chen                          | 2017-03-15 | [DBA]       |
| [Hiding tables in SSMS Object Explorer]                                                                                 | Kenneth Fisher                           | 2017-04-03 | [DEV]       |
| [Clustered columnstore: on-disk vs. in-mem]                                                                             | Ned Otter                                | 2017-03-21 | [DBA]       |
| [Generating Plots Automatically From PowerShell and SQL Server Using Gnuplot]                                           | Phil Factor                              | 2017-03-27 | [DEV]       |
| [How to Benchmark Alternative SQL Queries to Find the Fastest Query]                                                    | Luka Seder                               | 2017-03-29 | [BENCH]     |
| [Checking for Strange Client Settings with sys.dm_exec_sessions]                                                        | Brent Ozar                               | 2017-03-31 | [DEV]       |
| [Decrypting Insert Query Plans]                                                                                         | Eric Darling                             | 2017-03-30 | [DEV]       |
| [SQLskills SQL101: Partitioning]                                                                                        | Kimberly Tripp                           | 2017-03-27 | [DBA]       |
| [SQLskills SQL101: Switching recovery models]                                                                           | Paul Randal                              | 2017-03-29 | [DBA]       |
| [Using AT TIME ZONE to fix an old report]                                                                               | Rob Farley                               | 2017-02-14 | [DEV]       |
| [What the heck is a DTU]                                                                                                | Andy Mallon                              | 2017-03-30 | [AZ]        |
| [Hack-Attaching a SQL Server database with NORECOVERY]                                                                  | Argenis Fernandez                        | 2016-01-24 | [DBA]       |
| [Switch in Staging Tables Instead of sp_rename]                                                                         | Kendra Little                            | 2017-01-19 | [DBA]       |
| [Performance Myths: Table variables are always in-memory]                                                               | Derik Hammer                             | 2017-04-04 | [DEV]       |
| [Questions About SQL Server Collations You Were Too Shy to Ask]                                                         | Robert Sheldon                           | 2017-04-06 | [DBA][DEV]  |
| [NULL - The database's black hole]                                                                                      | Hugo Kornelis                            | 2007-07-06 | [DEV]       |
| [For The Better Developer: SQL Server Indexes]                                                                          | Davide Mauri                             | 2017-04-02 | [DEV]       |
| [#EntryLevel: Compression & Data Types]                                                                                 | Melissa Connors                          | 2016-04-17 | [DEV]       |
| [Cardinality Estimation for a Predicate on a COUNT Expression]                                                          | Paul White                               | 2017-04-12 | [DEV]       |
| [Changing SQL Server Collation After Installation]                                                                      | Douglas P. Castilho                      | 2015-02-19 | [DBA]       |
| [Does a TempDB spill mean statistics are out of date?]                                                                  | Brent Ozar                               | 2017-04-12 | [DEV]       |
| [Transaction log growth during BACKUP]                                                                                  | Andy Mallon                              | 2017-04-10 | [B][DBA]    |
| [When is a SQL function not a function?]                                                                                | Rob Farley                               | 2011-11-08 | [DEV]       |
| [Introducing Batch Mode Adaptive Joins]                                                                                 | Joseph Sack                              | 2017-04-19 | [DEV]       |
| [Investigating the proportional fill algorithm]                                                                         | Paul Randal                              | 2016-10-04 | [DBA]       |
| [Understanding Logging and Recovery in SQL Server]                                                                      | Paul Randal                              | 2009-02-01 | [DBA]       |
| [Bad Habits to Kick: Using shorthand with date/time operations]                                                         | Aaron Bertrand                           | 2011-09-20 | [DEV]       |
| [Generating Charts and Drawings in SQL Server Management Studio]                                                        | Zanevsky                                 | 2012-03-26 | [DEV]       |
| [How expensive are column-side Implicit Conversions?]                                                                   | Jonathan Kehayias                        | 2013-04-15 | [DEV]       |
| [Execution Plan Basics]                                                                                                 | Grant Fritchey                           | 2008-05-11 | [DEV]       |
| [Disabling ROW and PAGE Level Locks in SQL Server]                                                                      | Klaus Aschenbrenner                      | 2016-10-31 | [DEV]       |
| [Fixing Cardinality Estimation Errors with Filtered Statistics]                                                         | Klaus Aschenbrenner                      | 2013-10-29 | [DEV]       |
| [Cardinality Estimation for Multiple Predicates]                                                                        | Paul Randal                              | 2014-01-15 | [DEV]       |
| [Weaning yourself off of SQL Profiler (Part 1)]                                                                         | Wayne Sheffield                          | 2017-04-19 | [DBA][DEV]  |
| [Properly Persisted Computed Columns]                                                                                   | Paul White                               | 2017-05-25 | [DEV]       |
| [A SQL Server DBA myth a day: (17/30) page checksums]                                                                   | Paul Randal                              | 2010-04-17 | [DBA]       |
| [What are different ways to replace ISNULL() in a WHERE clause that uses only literal values?]                          | Eric Darling                             | 2017-05-27 | [DEV]       |
| [SQL Server 2016 enhancements – Truncate Table and Table Partitioning]                                                  | Prashanth Jayaram                        | 2017-04-18 | [DBA][DEV]  |
| [SQL Server Mysteries: The Case of the Not 100% RESTORE…]                                                               | Bob Ward                                 | 2017-04-21 | [DBA]       |
| [Transactional Replication and Stored Procedure Execution: Silver Bullet or Poison Pill?]                               | Drew Furgiuele                           | 2017-04-11 | [DBA]       |
| [STOPAT And Date Formats]                                                                                               | Dave Mason                               | 2017-07-12 | [DBA][XE]   |
| [Row-count Estimates when there are no Statistics]                                                                      | Matthew McGiffen                         | 2017-06-28 | [DEV]       |
| [SQL Server DBA On-Boarding Checklist]                                                                                  | Svetlana Golovko                         | 2017-06-20 | [DBA]       |
| [Be Wary of Date Formatting in T-SQL]                                                                                   | Randolph West                            | 2017-07-12 | [DEV]       |
| [Statistics and Cardinality Estimation]                                                                                 | Matthew McGiffen                         | 2017-06-20 | [DEV]       |
| [Message queues for the DBA: sending data out into the world]                                                           | Drew Furgiuele                           | 2017-07-21 | [DBA]       |
| [Schema-Based Access Control for SQL Server Databases]                                                                  | Phil Factor                              | 2017-04-09 | [DBA]       |
| [SQL Server: large RAM and DB Checkpointing]                                                                            | Guillaume Fourrat                        | 2017-06-29 | [DBA]       |
| [Handling SQL Server Deadlocks With Event Notifications]                                                                | Dave Mason                               | 2017-07-17 | [R][XE]     |
| [SQL Server R Services: Digging into the R Language]                                                                    | Robert Sheldon                           | 2017-06-29 | [DBA][DEV]  |
| [Investigating the Cause of SQL Server High CPU Load Conditions When They Happen]                                       | Laerte Junior                            | 2017-07-17 | [DBA]       |
| [In-Memory Engine DURABILITY = SCHEMA_ONLY And Transaction Rollback]                                                    | Chris Adkin                              | 2017-07-17 | [DEV]       |
| [Builder Day: Doing a Point-in-Time Restore in Azure SQL DB]                                                            | Brent Ozar                               | 2017-06-20 | [DBA][AZ]   |
| [Creating Continuous Integration Build Pipelines With Jenkins, Docker and SQL Server]                                   | Chris Adkin                              | 2017-07-18 | [DBA]       |
| [Scale-able Windows Aggregate Functions With Row Store Object]                                                          | Chris Adkin                              | 2017-07-24 | [DEV]       |
| [Azure DWH part 11: Data Warehouse Migration Utility]                                                                   | Daniel Calbimonte                        | 2017-07-17 | [AZ][MG]    |
| [Representing a simple hierarchical list in SQL Server with JSON, YAML, XML and HTML]                                   | William Brewer                           | 2017-07-18 | [DEV], [X]  |
| [Advanced Analytics with R and SQL Part II - Data Science Scenarios]                                                    | Frank A. Banin                           | 2017-07-27 | [DEV], [R]  |
| [Think twice before using table variables]                                                                              | Matthew McGiffen                         | 2017-07-11 | [DEV]       |
| [ColumnStore Indexes And Recursive CTEs]                                                                                | Erik Darling                             | 2017-07-27 | [DEV]       |
| [CCIs and String Aggregation]                                                                                           | Joe Obbish                               | 2017-07-03 | [DEV]       |
| [Brad’s Sure DBA Checklist]                                                                                             | Brad McGehee                             | 2010-01-20 | [DBA]       |
| [Query Store and Parameterization Problems]                                                                             | Dennes Torres                            | 2017-07-06 | [QS]        |
| [SQL Server Event Handling: Event Notifications]                                                                        | Dave Mason                               | 2016-11-30 | [DBA][XE]   |
| [Identifying Deprecated Feature Usage (Part 1)]                                                                         | Dave Mason                               | 2017-07-20 | [DBA][XE]   |
| [Let’s Corrupt a Database Together, Part 3: Detecting Corruption]                                                       | Brent Ozar                               | 2017-07-25 | [DBA][COR]  |
| [XML vs JSON Shootout: Which is Superior in SQL Server 2016?]                                                           | Bert Wagner                              | 2017-05-16 | [DEV][X]    |
| [One SQL Cheat Code For Amazingly Fast JSON Queries]                                                                    | Bert Wagner                              | 2017-05-09 | [DEV][X]    |
| [The Ultimate SQL Server JSON Cheat Sheet]                                                                              | Bert Wagner                              | 2017-03-07 | [DEV][X]    |
| [Are your indexes being thwarted by mismatched datatypes?]                                                              | Bert Wagner                              | 2017-08-01 | [DEV]       |
| [Why Missing Index Recommendations Aren’t Perfect]                                                                      | Brent Ozar                               | 2017-08-02 | [DBA][DEV]  |
| [Top 5 Misleading SQL Server Performance Counters]                                                                      | Kendra Little                            | 2017-06-05 | [DBA][DEV]  |
| [The Case of the Space at the End]                                                                                      | Adam St. Pierre                          | 2017-07-24 | [DEV]       |
| [SELECT…INTO in SQL Server 2017]                                                                                        | Andrew Pruski                            | 2017-08-02 | [DEV]       |
| [Your Service Level Agreement is a Disaster]                                                                            | Jennifer McCown                          | 2017-07-24 | [DBA]       |
| [SQLskills SQL101: REBUILD vs. REORGANIZE]                                                                              | Paul Randal                              | 2017-08-03 | [DBA]       |
| [Where do the Books Online index fragmentation thresholds come from?]                                                   | Paul Randal                              | 2009-12-08 | [DBA]       |
| [The SQL Hall of Shame]                                                                                                 | Adam Machanic                            | 2017-06-14 | [DBA][DEV]  |
| [A Better Way To Select Star]                                                                                           | Erik Darling                             | 2017-07-05 | [DEV]       |
| [UDP vs TCP]                                                                                                            | Kenneth Fisher                           | 2017-06-07 | [DBA]       |
| [When a Nonclustered Index and Statistics Make a Query Slower]                                                          | Kendra Little                            | 2017-03-24 | [DBA][DEV]  |
| [Lipoaspiration in your SQL Server Database]                                                                            | Fabiano Amorim                           | 2011-03-03 | [DEV]       |
| [13 Things You Should Know About Statistics and the Query Optimizer]                                                    | Fabiano Amorim                           | 2010-01-07 | [DBA][DEV]  |
| [Creating R Stored Procedures in SQL Server 2016 Using sqlrutils]                                                       | Niels Berglund                           | 2017-06-25 | [DEV][R]    |
| [A Quick start Guide to Managing SQL Server 2017 on CentOS/RHEL Using the SSH Protocol]                                 | Prashanth Jayaram                        | 2017-08-08 | [DEV]       |
| [SQL Server v.Next : STRING_AGG Performance, Part 2]                                                                    | Aaron Bertrand                           | 2017-01-06 | [DEV]       |
| [Why Parameter Sniffing Isn’t Always A Bad Thing (But Usually Is)]                                                      | Bert Wagner                              | 2017-08-08 | [DEV]       |
| [Persisting statistics sampling rate]                                                                                   | Pedro Lopes                              | 2017-08-11 | [DBA]       |
| [All about locking in SQL Server]                                                                                       | Nikola Dimitrijevic                      | 2017-06-16 | [DBA][DEV]  |
| [All about Latches in SQL Server]                                                                                       | Nikola Dimitrijevic                      | 2017-08-10 | [DBA][DEV]  |
| [All about SQL Server spinlocks]                                                                                        | Nikola Dimitrijevic                      | 2017-08-23 | [DBA][DEV]  |
| [How to monitor object space growth in SQL Server]                                                                      | Jefferson Elias                          | 2017-08-16 | [DBA][DEV]  |
| [How to Read a Transaction Log Backup]                                                                                  | Greg Larsen                              | 2017-07-03 | [B][DBA]    |
| [How to Find Out Which Database Object Got Deleted]                                                                     | Greg Larsen                              | 2017-07-03 | [DBA]       |
| [In-Memory OLTP Enhancements in SQL Server 2016]                                                                        | Ahmad Yaseen                             | 2017-08-22 | [DBA][DEV]  |
| [Sync SQL Logins and Jobs]                                                                                              | Ryan J. Adams                            | 2017-08-21 | [DBA][J]    |
| [The Trillion Row Table]                                                                                                | Joe Obbish                               | 2017-08-16 | [BENCH]     |
| [Dynamic Data Unmasking]                                                                                                | Joe Obbish                               | 2017-08-25 | [DEV]       |
| [Why is My Database Application so Slow?]                                                                               | Dan Turner                               | 2017-08-24 | [DEV]       |
| [Generating Concurrent Activity]                                                                                        | Michael J Swart                          | 2017-01-23 | [DBA][DEV]  |
| [Required Testing for Installing SQL Server Cumulative Updates and Service Packs]                                       | Kendra Little                            | 2017-04-28 | [DBA]       |
| [Microsoft SQL Server R Services - Internals X]                                                                         | Niels Berglund                           | 2017-08-29 | [DEV][R]    |
| [Clustered columnstore: on-disk vs. in-mem]                                                                             | Ned Otter                                | 2017-08-29 | [DBA][DEV]  |
| [Hands on Full-Text Search in SQL Server]                                                                               | Jefferson Elias                          | 2017-08-25 | [DBA][DEV]  |
| [SQL Code Smells]                                                                                                       | Phil Factor                              | 2017-08-31 | [DBA][DEV]  |
| [Corruption demo databases and scripts]                                                                                 | Paul Randal                              | 2013-01-08 | [DBA][COR]  |
| [Understanding Cross-Database Transactions in SQL Server]                                                               | Grahaeme Ross                            | 2015-04-11 | [DBA][DEV]  |
| [Optional Parameters and Missing Index Requests]                                                                        | Brent OZar                               | 2017-09-14 | [DBA][DEV]  |
| [Uniquifier is a rather unique word isn’t it?]                                                                          | Kenneth Fisher                           | 2017-09-18 | [DBA][DEV]  |
| [Importance of proper transaction log size management]                                                                  | Paul Randal                              | 2009-04-10 | [DEV]       |
| [#TSQL2sDay – Starting Out with PowerShell]                                                                             | Rob Sewell                               | 2017-09-12 | [DBA][PS]   |
| [Using native compilation to insert parent/child tables]                                                                | Ned Otter                                | 2017-09-11 | [DEV]       |
| [Questions About RDS SQL Server You Were Too Shy to Ask]                                                                | Laerte Junior                            | 2017-09-13 | [DEV]       |
| [Active Directory Authentication with SQL Server on Ubuntu]                                                             | Drew Furgiuele                           | 2017-09-19 | [DBA]       |
| [Temporary Tables in Stored Procedures]                                                                                 | Paul Randal                              | 2012-08-15 | [DEV]       |
| [SQLCLR in Practice: Creating a Better Way of Sending Email from SQL Server]                                            | Darko Martinović                         | 2017-07-17 | [CLR]       |
| [T-SQL commands performance comparison – NOT IN vs NOT EXISTS vs LEFT JOIN vs EXCEPT]                                   | Ahmad Yaseen                             | 2017-09-22 | [DBA][DEV]  |
| [Clustered vs Nonclustered: Index Fundamentals You Need To Know]                                                        | Bert Wagner                              | 2017-09-26 | [DBA][DEV]  |
| [How to Write Efficient TOP N Queries in SQL]                                                                           | Lukas Eder                               | 2017-09-22 | [DEV]       |
| [Checklist: DR Plan Sanity Check]                                                                                       | Robert Davis                             | 2017-09-04 | [DBA]       |
| [Table level recovery for selected SQL Server tables]                                                                   | Tibor Nagy                               | 2012-11-30 | [DEV]       |
| [SQL Mirroring, Preserving the Log Chain During Database Migrations]                                                    | SQL Undercover                           | 2017-01-21 | [DBA][MG]   |
| [How NOLOCK Will Block Your Queries]                                                                                    | Bert Wagner                              | 2017-10-10 | [DEV]       |
| [8 Ways to Export SQL Results To a Text File]                                                                           | Daniel Calbimonte                        | 2017-10-06 | [DBA][DEV]  |
| [SQL Server Installation Failed Due to Pending Restart of Server?]                                                      | thelonedba                               | 2017-09-18 | [DBA][DEV]  |
| [Six Scary SQL Surprises]                                                                                               | Brent Ozar                               | 2017-09-06 | [DEV]       |
| [How the rowversion datatype works when adding and deleting columns]                                                    | Louis Davidson                           | 2017-09-26 | [DEV]       |
| [Quick! What's the difference between RANK, DENSE_RANK, and ROW_NUMBER?]                                                | Douglas Kline                            | 2017-10-01 | [DEV]       |
| [A Serial Parallel Query]                                                                                               | Joe Obbish                               | 2017-10-20 | [DEV]       |
| [Add or Remove IDENTITY Property From an Existing Column Efficiently]                                                   | Dan Guzman                               | 2017-04-16 | [DBA][DEV]  |
| [How Do I Analyze a SQL Server Execution Plan?]                                                                         | Kendra Little                            | 2017-09-22 | [DEV]       |
| [A Subtle Difference Between COALESCE and ISNULL]                                                                       | Shaneis                                  | 2017-10-09 | [DEV]       |
| [Puzzle Challenge: Graph Matching with T-SQL Part 1-Concepts]                                                           | Itzik Ben-Gan                            | 2017-08-08 | [DEV]       |
| [Graph Matching with T-SQL Part 3: Maximum Matching]                                                                    | Itzik Ben-Gan                            | 2017-10-12 | [DEV]       |
| [Running PowerShell in a SQL Agent Job]                                                                                 | Derik Hammer                             | 2017-03-04 | [PS]        |
| [Line-Continuation in T-SQL]                                                                                            | Solomon Rutzky                           | 2017-10-27 | [DEV]       |
| [SQL Server 2017: Making Backups Great Again!]                                                                          | John Sterrett                            | 2017-10-31 | [B][DBA]    |
| [Say NO to Venn Diagrams When Explaining JOINs]                                                                         | Lukas Eder                               | 2016-07-05 | [DBA][DEV]  |
| [Surprise Delta Stores]                                                                                                 | Joe Obbish                               | 2017-11-07 | [DEV]       |
| [SQL 2014 Clustered Columnstore index rebuild and maintenance considerations]                                           | Denzil Ribeiro                           | 2015-07-08 | [DBA][DEV]  |
| [The Case of the Weirdly Long COLUMNSTORE_BUILD_THROTTLE Wait]                                                          | Kendra Little                            | 2017-11-09 | [DEV]       |
| [Multiple Output Datasets With R and SQL Server]                                                                        | Kendra Little                            | 2017-11-06 | [DEV][R]    |
| [How to Avoid Excessive Sorts in Window Functions]                                                                      | Lukas Eder                               | 2017-11-06 | [DEV]       |
| [Extracting a DAX Query Plan With Analysis Services 2016 Extended Events]                                               | Koen Verbeeck                            | 2017-10-03 | [DAX], [XE] |
| [What impact can different cursor options have?]                                                                        | Aaron Bertrand                           | 2012-09-10 | [DBA][DEV]  |
| [SQL Smackdown!!! Cursors VS Loops]                                                                                     | SQL Undercover                           | 2017-11-16 | [DBA][DEV]  |
| [Using the OPTION (RECOMPILE) option for a statement]                                                                   | Kimberly Tripp                           | 2010-04-15 | [DBA][DEV]  |
| [Execution Plan Caching and Reuse]                                                                                      | Microsoft                                | 2015-02-12 | [DBA][DEV]  |
| [Buffer Management]                                                                                                     | Microsoft                                | 1753-01-01 | [DBA][DEV]  |
| [RECOMPILE Hints and Execution Plan Caching]                                                                            | Kendra Little                            | 2017-12-17 | [DBA][DEV]  |
| [Improving query performance with OPTION (RECOMPILE), Constant Folding and avoiding Parameter Sniffing issues]          | Robin Lester                             | 2016-08-10 | [DBA][DEV]  |
| [Eight Different Ways to Clear the SQL Server Plan Cache]                                                               | Glenn Berry                              | 2016-03-26 | [DBA][DEV]  |
| [Introduction and FAQs about Microsoft Azure technologies]                                                              | Daniel Calbimonte                        | 2017-10-13 | [AZ][DEV]   |
| [Inside the XEvent Profiler]                                                                                            | Derik Hammer                             | 2017-10-11 | [DBA][DEV]  |
| [Does The Join Order of My Tables Matter?]                                                                              | Bert Wagner                              | 2017-11-21 | [DBA][DEV]  |
| [Encrypting SQL Server connections with Let’s Encrypt certificates]                                                     | Derik Hammer                             | 2017-11-12 | [DBA]       |
| [Start SQL Server without tempdb]                                                                                       | Kenneth Fisher                           | 2016-01-20 | [DBA]       |
| [How to configure database mail in SQL Server]                                                                          | Bojan Petrovic                           | 2017-11-22 | [DBA]       |
| [Understanding SQL server memory grant]                                                                                 | Jay Choe                                 | 2010-02-16 | [DBA][DEV]  |
| [Cleanly Uninstalling Stubborn SQL Server Components]                                                                   | Aaron Bertrand                           | 2015-10-06 | [DBA]       |
| [Hey! What's the deal with SQL Server NOCOUNT and T-SQL WHILE loops?]                                                   | @sqL_handLe                              | 2017-17-30 | [DEV]       |
| [Query Store Settings]                                                                                                  | Erin Stellato                            | 2010-11-28 | [QS]        |
| [Using Plan Explorer with Entity Framework]                                                                             | Jason Hall                               | 2010-11-28 | [DEV]       |
| [Overview of Encryption Tools in SQL Server]                                                                            | Matthew McGiffen                         | 2017-12-05 | [DBA][DEV]  |
| [Clustered Index Uniquifier Existence and Size]                                                                         | Solomon Rutzky                           | 2017-09-18 | [DBA][DEV]  |
| [Understanding Logging and Recovery in SQL Server]                                                                      | Paul Randal                              | 2009-02-01 | [DBA][B]    |
| [Understanding SQL Server Backups]                                                                                      | Paul Randal                              | 2009-07-01 | [B][DBA]    |
| [Recovering from Disasters Using Backups]                                                                               | Paul Randal                              | 2009-11-01 | [B][DBA]    |
| [Simple SQL: Handling Location Datatypes]                                                                               | Joe Celko                                | 2017-10-19 | [DEV]       |
| [Improve SQL Server Performance by Looking at Plan Cache (Part 1)]                                                      | Thomas LaRock                            | 2014-10-30 | [DBA][DEV]  |
| [Improve SQL Server Performance by Looking at Plan Cache (Part 2)]                                                      | Thomas LaRock                            | 2014-10-30 | [DBA][DEV]  |
| [Improve SQL Server Performance by Looking at Plan Cache (Part 3)]                                                      | Thomas LaRock                            | 2014-10-30 | [DBA][DEV]  |
| [Take Care When Scripting Batches]                                                                                      | Michael J Swart                          | 2014-09-09 | [DBA][DEV]  |
| [When Measuring Timespans, try DATEADD instead of DATEDIFF]                                                             | Michael J Swart                          | 2017-12-20 | [DBA][DEV]  |
| [Which user function do I use?]                                                                                         | Kenneth Fisher                           | 2015-06-24 | [DBA][DEV]  |
| [What’s So Bad About Shrinking Databases with DBCC SHRINKDATABASE?]                                                     | Brent Ozar                               | 2017-12-29 | [DBA][DEV]  |
| [Which Collation is Used to Convert NVARCHAR to VARCHAR in a WHERE Condition? (Part A of 2: “Duck”)]                    | Solomon Rutzky                           | 2017-12-08 | [DBA][DEV]  |
| [Which Collation is Used to Convert NVARCHAR to VARCHAR in a WHERE Condition? (Part B of 2: “Rabbit”)]                  | Solomon Rutzky                           | 2017-12-11 | [DBA][DEV]  |
| [Current State of the NewSQL/NoSQL Cloud Arena]                                                                         | Warner Chaves                            | 2017-11-27 | [DBA][DEV]  |
| [SQL Server 2017: JSON]                                                                                                 | Sergey Syrovatchenko                     | 2017-11-17 | [X]         |
| [Simulating Bad Networks to Test SQL Server Replication]                                                                | John Paul Cook                           | 2018-01-02 | [DBA]       |
| [How to Turn on Instant File Initialization]                                                                            | Greg Larsen                              | 2017-12-04 | [DBA]       |
| [Bad Idea Jeans: Finding Undocumented Trace Flags]                                                                      | Brent Ozar                               | 2017-10-04 | [DEV]       |
| [A Method to Find Trace Flags]                                                                                          | Joe Obbish                               | 2018-01-16 | [DEV]       |
| [Using Windows stored credentials to connect to SQL in containers]                                                      | Andrew Pruski                            | 2018-01-17 | [DEV]       |
| [Step by Step Guide to Migrate SQL Server Data to SQL Server 2017]                                                      | Anoop Kumar                              | 2017-12-21 | [DBA][MG]   |
| [Nasty Fast PERCENT_RANK]                                                                                               | Alan Burstein                            | 2018-01-05 | [DEV]       |
| [Administrative Logins and Users]                                                                                       | Kenneth Fisher                           | 2015-11-02 | [DEV]       |
| [Parallelism in Hekaton (In-Memory OLTP)]                                                                               | Niko Neugebauer                          | 2018-01-20 | [DEV]       |
| [Troubleshooting THREADPOOL Waits]                                                                                      | Klaus Aschenbrenner ·                    | 2015-10-20 | [DEV]       |
| [Andy’s Excellent SSIS-in-the-Cloud Adventure, Part 1 – Build an ADFv2 IR Instance]                                     | Andy Leonard        ·                    | 2018-01-28 | [AZ][SSIS]  |
| [PRINT vs. RAISERROR]                                                                                                   | sqlity.net          ·                    | 2012-05-27 | [DEV]       |
| [Does a Clustered Index Give a Default Ordering?]                                                                       | Kendra Little       ·                    | 2018-02-02 | [DEV]       |
| [Without ORDER BY, You Can’t Depend On the Order of Results]                                                            | Michael J Swart       ·                  | 2013-09-13 | [DEV]       |
| [Query Store and “in memory”]                                                                                           | Erin Stellato       ·                    | 2018-01-31 | [QS]        |
| [Setting and Identifying Row Goals in Execution Plans]                                                                  | Paul White       ·                       | 2018-02-12 | [DEV]       |
| [Azure and Windows PowerShell: The Basics]                                                                              | Nicolas Prigent  ·                       | 2017-12-29 | [AZ]        |
| [Auditing Linked Servers]                                                                                               | Thomas LaRock                            | 2018-02-08 | [DEV]       |
| [An alternative to data masking]                                                                                        | Daniel Hutmacher                         | 2018-02-05 | [DEV]       |
| [Safely and Easily Use High-Level Permissions Without Granting Them to Anyone: Server-level]                            | Solomon Rutzky                           | 2018-02-15 | [DBA]       |
| [PLEASE, Please, please Stop Using Impersonation, TRUSTWORTHY, and Cross-DB Ownership Chaining]                         | Solomon Rutzky                           | 2018-12-30 | [DBA]       |
| [Indexing and Partitioning]                                                                                             | DBA From The Cold                        | 2018-02-21 | [DEV]       |
| [Schema Compare for SQL Server]                                                                                         | Thomas Larock                            | 2018-02-14 | [DEV]       |
| [How to change SQL Server ERRORLOG location]                                                                            | Mark Varnas                              | 2018-03-04 | [DBA]       |
| [The Uni-Code: The Search for the True List of Valid Characters for T-SQL Regular Identifiers, Part 1]                  | Solomon Rutzky                           | 2018-04-02 | [DBA][DEV]  |
| [The Uni-Code: The Search for the True List of Valid Characters for T-SQL Regular Identifiers, Part 2]                  | Solomon Rutzky                           | 2018-04-04 | [DBA][DEV]  |
| [What’s in a Name?: Inside the Wacky World of T-SQL Identifiers]                                                        | Solomon Rutzky                           | 2018-04-09 | [DBA][DEV]  |
| [Programming SQL Server with SQL Server Management Objects Framework]                                                   | Darko Martinović                         | 2018-04-09 | [DEV]       |
| [Interval Queries in SQL Server]                                                                                        | Itzik Ben-Gan                            | 2013-06-12 | [DEV]       |
| [Dealing with date and time instead of datetime]                                                                        | Rob Farley                               | 2018-03-29 | [DEV]       |
| [Insight into the SQL Server buffer cache]                                                                              | Ed Pollack                               | 2018-02-18 | [DBA][DEV]  |
| [A concrete example of migration between an Oracle Database and SQL Server using Microsoft Data Migration Assistant]    | Jefferson Elias                          | 2018-04-12 | [DBA][DEV]  |
| [Audit SQL Server stop, start, restart]                                                                                 | Steve Keeler                             | 2018-03-12 | [DBA]       |
| [Query tuning: Apply yourself]                                                                                          | Daniel Janik                             | 2018-04-06 | [DEV]       |
| [How to identify and monitor unused indexes in SQL Server]                                                              | Nikola Dimitrijevic                      | 2018-04-17 | [IDX]       |
| [Benchmarking: 1-TB table population (part 1: the baseline)]                                                            | Paul Randal                              | 2010-01-21 | [BENCH]     |
| [Benchmarking: 1-TB table population (part 2: optimizing log block IO size and how log IO works)]                       | Paul Randal                              | 2010-01-27 | [BENCH]     |
| [An overview of SQL Server database migration tools provided by Microsoft]                                              | Jefferson Elias                          | 2018-03-16 | [DBA][MG]   |
| [Calling Http endpoints in T-SQL using CURL extension]                                                                  | Jovan Popovic                            | 2018-04-17 | [CLR]       |
| [Why Table Join Orders In Relational Databases]                                                                         | Bert Wagner                              | 2018-04-16 | [DEV]       |
| [Finding overlapping ranges of data]                                                                                    | Louis Davidson                           | 2018-04-18 | [DEV]       |
| [Avoid use of the MONEY and SMALLMONEY datatypes]                                                                       | Phil Factor                              | 2018-04-18 | [DEV]       |
| [Provisioning SQL Server Instances with Docker]                                                                         | Laerte Junior                            | 2018-04-18 | [DBA]       |
| [Understanding the graphical representation of the SQL Server Deadlock Graph]                                           | Minette Steynberg                        | 2016-08-16 | [DBA][DEV]  |
| [Digitally Signing a Stored Procedure To Allow It To Run With Elevated Permissions]                                     | SQL Undercover                           | 2018-05-02 | [DBA][DEV]  |
| [NOLOCK and Top Optimization]                                                                                           | Dmitry Piliugin                          | 2018-04-12 | [DEV]       |
| [Operator Precedence versus the Confusing Constraint Translation]                                                       | Louis Davidson                           | 2018-04-30 | [DEV]       |
| [Interval Queries in SQL Server]                                                                                        | Itzik Ben-Gan                            | 2013-06-13 | [DEV]       |
| [Query Trace Column Values]                                                                                             | Dmitry Piliugin                          | 2018-04-23 | [XE]        |
| [Concurrency Week: How to Delete Just Some Rows from a Really Big Table]                                                | Brent Ozar                               | 2018-04-27 | [DEV]       |
| [Break large delete operations into chunks]                                                                             | Aaron Bertrand                           | 2013-03-13 | [DBA][DEV]  |
| [How to perform a page level restore in SQL Server]                                                                     | Prashanth Jayaram                        | 2018-08-18 | [DBA][DEV]  |
| [Grouping dates without blocking operators]                                                                             | Daniel Hutmacher                         | 2018-05-14 | [DEV]       |
| [What’s CHECKDB doing in my database restore?]                                                                          | Mike Fal                                 | 2018-04-10 | [DBA]       |
| [How To Hide An Instance Of SQL Server]                                                                                 | Thomas Larock                            | 2018-04-10 | [DBA]       |
| [Troubleshooting Parameter Sniffing Issues the Right Way: Part 1]                                                       | Tara Kizer                               | 2018-03-06 | [DEV]       |
| [Troubleshooting Parameter Sniffing Issues the Right Way: Part 2]                                                       | Tara Kizer                               | 2018-03-07 | [DEV]       |
| [Troubleshooting Parameter Sniffing Issues the Right Way: Part 3]                                                       | Tara Kizer                               | 2018-03-06 | [DEV]       |
| [When to use the SELECT…INTO statement]                                                                                 | Phil Factor                              | 2018-03-19 | [DEV]       |
| [Temp Tables In SSIS]                                                                                                   | Tim Mitchel                              | 2018-05-29 | [SSIS]      |
| [Changing the Collation of the Instance, the Databases, and All Columns in All User Databases]                          | Solomon Rutzky                           | 2018-06-11 | [DBA]       |
| [10 Cool SQL Optimisations That do not Depend on the Cost Model]                                                        | Lukas Eder                               | 2017-09-28 | [DBA][DEV]  |
| [Scheduling powershell tasks with sql agent]                                                                            | Chrissy Lemaire                          | 2017-09-26 | [J][PS]     |
| [Three ways to track logins using dbatools]                                                                             | Chrissy Lemaire                          | 2018-04-10 | [PS]        |
| [Impact of Fragmentation on Execution Plans]                                                                            | Jonathan Kehayias                        | 2017-12-18 | [DEV]       |
| [How to “debug” a Linked Server from SQL Server to an Oracle Database instance]                                         | Jefferson Elias                          | 2018-06-11 | [DEV]       |
| [How to implement error handling in SQL Server]                                                                         | Bojan Petrovic                           | 2018-06-15 | [DEV]       |
| [SQL Server Closure Tables]                                                                                             | Phil Factor                              | 2018-04-10 | [DEV]       |
| [Deadlock victim choice in SQL Server - an exception?]                                                                  | Josh Darnell                             | 2018-05-10 | [DBA][DEV]  |
| [Azure and Windows PowerShell: The Basics]                                                                              | Nicolas Prigent                          | 2017-12-29 | [AZ][PS]    |
| [Azure and Windows PowerShell: Getting Information]                                                                     | Nicolas Prigent                          | 2018-06-26 | [AZ][PS]    |
| [Be our guest, be our guest, put our database to the test]                                                              | Kenneth Fisher                           | 2018-06-25 | [DBA]       |
| [Finding code smells using SQL Prompt: the SET NOCOUNT problem (PE008 and PE009)]                                       | Phil Factor                              | 2018-01-04 | [DEV]       |
| [DATABASES 101 guide for the non-technical professional]                                                                | Thomas LaRock                            | 2018-07-05 | [DBA][DEV]  |
| [Understanding your Azure EA Billing Data and Building a Centralized Data Storage Solution]                             | Feodor Georgiev                          | 2018-07-17 | [AZ]        |
| [READ COMMITTED SNAPSHOT ISOLATION and High version_ghost_record_count]                                                 | Uwe Ricken                               | 2018-03-06 | [DBA][DEV]  |
| [In-Memory OLTP Indexes – Part 1: Recommendations.]                                                                     | Kunal Karoth                             | 2017-11-02 | [IDX]       |
| [In-Memory OLTP Indexes – Part 2: Performance Troubleshooting Guide.]                                                   | Kunal Karoth                             | 2017-11-14 | [IDX]       |
| [Optimization Thresholds – Grouping and Aggregating Data, Part 1]                                                       | Itzik Ben-Gan                            | 2018-04-10 | [DEV]       |
| [Optimization Thresholds – Grouping and Aggregating Data, Part 2]                                                       | Itzik Ben-Gan                            | 2018-05-09 | [DEV]       |
| [Optimization Thresholds – Grouping and Aggregating Data, Part 3]                                                       | Itzik Ben-Gan                            | 2018-06-13 | [DEV]       |
| [Optimization Thresholds – Grouping and Aggregating Data, Part 4]                                                       | Itzik Ben-Gan                            | 2018-07-11 | [DEV]       |
| [Optimization Thresholds – Grouping and Aggregating Data, Part 5]                                                       | Itzik Ben-Gan                            | 2018-08-08 | [DEV]       |
| [When DBCC OpenTran doesn’t list all open transactions]                                                                 | Mohamed                                  | 2013-02-17 | [DBA]       |
| [How I spot not-yet-documented features in SQL Server CTPs]                                                             | Aaron Bertrand                           | 2015-12-02 | [DBA]       |
| [More ways to discover changes in new versions of SQL Server]                                                           | Aaron Bertrand                           | 2016-03-30 | [DBA]       |
| [Tail-Log Backup and Restore in SQL Server]                                                                             | Prashanth Jayaram                        | 2018-05-31 | [B][DBA]    |
| [Database Filegroup(s) and Piecemeal restores in SQL Server]                                                            | Prashanth Jayaram                        | 2018-06-22 | [DBA]       |
| [Updating Statistics with Ola Hallengren’s Script]                                                                      | Erin Stellato                            | 2018-06-22 | [DBA]       |
| [Interview questions on SQL Server database backups, restores and recovery – Part I]                                    | Prashanth Jayaram                        | 2018-07-25 | [B][DBA]    |
| [Interview questions on SQL Server database backups, restores and recovery – Part II]                                   | Prashanth Jayaram                        | 2018-07-25 | [B][DBA]    |
| [Interview questions on SQL Server database backups, restores and recovery – Part III]                                  | Prashanth Jayaram                        | 2018-07-25 | [B][DBA]    |
| [Can Rowstore Compression Beat Columnstore Compression?]                                                                | Joe Obbish                               | 2018-06-28 | [DBA][DEV]  |
| [Inside the Storage Engine: Anatomy of a record]                                                                        | Paul Randal                              | 2007-09-30 | [DBA][DEV]  |
| [Inside the Storage Engine: Using DBCC PAGE and DBCC IND to find out if page splits ever roll back]                     | Paul Randal                              | 2007-10-01 | [DBA][DEV]  |
| [Inside the Storage Engine: Anatomy of a page]                                                                          | Paul Randal                              | 2007-10-03 | [DBA][DEV]  |
| [Inside the Storage Engine: Anatomy of an extent]                                                                       | Paul Randal                              | 2007-10-03 | [DBA][DEV]  |
| [Inside the Storage Engine: IAM pages, IAM chains, and allocation units]                                                | Paul Randal                              | 2007-10-04 | [DBA][DEV]  |
| [Inside The Storage Engine: GAM, SGAM, PFS and other allocation maps]                                                   | Paul Randal                              | 2008-03-14 | [DBA][DEV]  |
| [Disaster recovery 101: fixing a broken boot page]                                                                      | Paul Randal                              | 2015-06-23 | [DBA][DEV]  |
| [How to download a sqlservr.pdb symbol file]                                                                            | Paul Randal                              | 2011-04-13 | [DBA][DEV]  |
| [A cause of high-duration ASYNC_IO_COMPLETION waits]                                                                    | Paul Randal                              | 2014-03-19 | [DBA][DEV]  |
| [How to solve the Identity Crisis in SQL Server]                                                                        | Ed Pollack                               | 2017-11-14 | [DBA][DEV]  |
| [Azure SQL Database Performance and Service Tiers Explained]                                                            | Glenn Berry                              | 2018-08-01 | [AZ]        |
| [What To Do When Wait Stats Don’t Help]                                                                                 | Joe Obbish                               | 2018-07-20 | [DEV]       |
| [SQL Server Brute Force Attack Detection: Part 1]                                                                       | Ryan G Conrad                            | 2018-03-26 | [DBA]       |
| [SQL Server Brute Force Attack Detection: Part 2]                                                                       | Ryan G Conrad                            | 2018-03-26 | [DBA]       |
| [SQL Server Brute Force Attack Detection: Part 3]                                                                       | Ryan G Conrad                            | 2018-03-26 | [DBA]       |
| [SQLCLR vs SQL Server 2017, Part 8: Is SQLCLR Deprecated in Favor of Python or R (sp_execute_external_script)?]         | Solomon Rutzky                           | 2018-08-09 | [DBA][DEV]  |
| [Sql Server Agent For Azure Sql Database, Azure Elastic Database Pools & Azure Managed Instance]                        | ?                                        | 2018-07-20 | [AZ]        |
| [Storage performance best practices and considerations for Azure SQL DB Managed Instance (General Purpose)]             | Dimitri Furman                           | 2018-07-20 | [AZ]        |
| [T-SQL Tuesday #017: APPLY: It Slices! It Dices! It Does It All!]                                                       | Brad Schulz                              | 2011-04-12 | [DEV]       |
| [SQL Server Encryption, What’s The Key Hierarchy All About?]                                                            | David Fowler                             | 2018-08-12 | [DBA][DEV]  |
| [Overview of the SQLCMD utility in SQL Server]                                                                          | Prashanth Jayaram                        | 2018-08-13 | [DBA][DEV]  |
| [The BCP (Bulk Copy Program) command in action]                                                                         | Prashanth Jayaram                        | 2018-08-13 | [DBA][DEV]  |
| [Measuring Query Execution Time]                                                                                        | Grant Fritchey                           | 2018-08-13 | [DBA][DEV]  |
| [How to Check Performance on a New SQL Server]                                                                          | Brent Ozar                               | 2018-08-03 | [DBA][DEV]  |
| [Questions About Kerberos and SQL Server That You Were Too Shy to Ask]                                                  | Kathi Kellenberger                       | 2018-08-21 | [DBA]       |
| [SQL Server Execution Plans overview]                                                                                   | Ahmad Yaseen                             | 2018-07-04 | [DBA][DEV]  |
| [SQL Server Execution Plans types]                                                                                      | Ahmad Yaseen                             | 2018-07-23 | [DBA][DEV]  |
| [How to Analyze SQL Execution Plan Graphical Components]                                                                | Ahmad Yaseen                             | 2018-09-07 | [DBA][DEV]  |
| [Query optimization techniques in SQL Server: the basics]                                                               | Ed Pollack                               | 2018-05-30 | [DBA][DEV]  |
| [Query optimization techniques in SQL Server: tips and tricks]                                                          | Ed Pollack                               | 2018-06-19 | [DBA][DEV]  |
| [Query optimization techniques in SQL Server: Database Design and Architecture]                                         | Ed Pollack                               | 2018-07-13 | [DBA][DEV]  |
| [SQL Query Optimization Techniques in SQL Server: Parameter Sniffing]                                                   | Ed Pollack                               | 2018-09-04 | [DBA][DEV]  |
| [Similarities and Differences among RANK, DENSE_RANK and ROW_NUMBER Functions]                                          | Ben Richardson                           | 2018-08-20 | [DBA][DEV]  |
| [Temporal Tables Under The Covers]                                                                                      | Randolph West                            | 2015-11-17 | [DBA][DEV]  |
| [Faking Temporal Tables with Triggers]                                                                                  | Bert Wagner                              | 2018-09-11 | [DBA][DEV]  |
| [SQL queries to manage hierarchical or parent-child relational rows in SQL Server]                                      | Dipon Roy                                | 2014-09-16 | [DBA][DEV]  |
| [Choosing Between Table Variables and Temporary Tables]                                                                 | Phil Factor                              | 2018-05-11 | [DBA][DEV]  |
| [What's New in the First Public CTP of SQL Server 2019]                                                                 | Aaron Bertrand                           | 2018-09-24 | [DBA][DEV]  |
| [SQL Server support for TLS 1.2 – Read This First!]                                                                     | Aaron Bertrand                           | 2016-03-03 | [DBA][DEV]  |
| [Misconceptions in SQL Server: A Trio of table variables]                                                               | Gail Shaw                                | 2010-10-12 | [DBA][DEV]  |
| [Using the Same Column Twice in a SQL UPDATE Statement]                                                                 | SQL Theater                              | 2018-09-13 | [DBA][DEV]  |
| [How to perform a performance test against a SQL Server instance]                                                       | Jefferson Elias                          | 2018-09-14 | [DBA][DEV]  |
| [The Black Art Of Spatial Index Tuning In SQL Server]                                                                   | Todd Jackson                             | 2011-04-26 | [DEV]       |
| [Patching SQL Server on Windows notes from the field]                                                                   | Kevin Chant                              | 2019-01-10 | [DBA]       |
| [Availability Group Readable Secondaries – Just Say No]                                                                 | Jonathan Kehayias                        | 2019-01-10 | [DBA]       |
| [Finding the Slowest Query in a Stored Procedure]                                                                       | Erin Stellato                            | 2018-12-13 | [DBA][DEV]  |
| [A Monumental Migration to SQL Server 2016 – Part 1]                                                                    | Andy Levy                                | 2019-01-07 | [DBA][MG]   |
| [A Monumental Migration to SQL Server 2016 – Part 2]                                                                    | Andy Levy                                | 2019-01-09 | [DBA][MG]   |
| [A unique review of SQL Server index types]                                                                             | Kevin Chant                              | 2019-10-18 | [DBA][DEV]  |
| [Don’t Just Rely on Query Execution Stats for T-SQL Execution]                                                          | Kevin Chant                              | 2018-09-18 | [DBA][DEV]  |
| [Posting SQL Server notifications to Slack]                                                                             | Alessandro Alpi                          | 2018-09-19 | [DBA][DEV]  |
| [How to create DACPAC file?]                                                                                            | Kamil Nowinski                           | 2018-10-31 | [DBA][DEV]  |
| [Find the Next Non-NULL Row in a Series With SQL]                                                                       | Lukas Eder                               | 2018-09-03 | [DEV]       |
| [Calculate Percentiles to Learn About Data Set Skew in SQL]                                                             | Lukas Eder                               | 2019-01-22 | [DEV]       |
| [Comparing multiple rows insert vs single row insert with three data load methods]                                      | Phil Factor                              | 2013-02-21 | [DBA][DEV]  |
| [The Cause of Every Deadlock in SQL Server]                                                                             | Thomas Larock                            | 2018-09-19 | [DBA][DEV]  |
| [Deadlock Troubleshooting, Part 1]                                                                                      | Bart Dunkan                              | 2006-09-08 | [DBA][DEV]  |
| [Deadlock Troubleshooting, Part 2]                                                                                      | Bart Dunkan                              | 2006-09-12 | [DBA][DEV]  |
| [Deadlock Troubleshooting, Part 3]                                                                                      | Bart Dunkan                              | 2006-09-08 | [DBA][DEV]  |
| [The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 1]                                        | Milosra Divojevic                        | 2018-10-04 | [DBA][DEV]  |
| [The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 2]                                        | Milosra Divojevic                        | 2018-10-05 | [DBA][DEV]  |
| [The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 3]                                        | Milosra Divojevic                        | 2018-10-08 | [DBA][DEV]  |
| [Creating a SQL Server 2019 Demo Environment in a Docker Container]                                                     | Cathrine Wilhelmsen                      | 2018-12-02 | [DBA][DEV]  |
| [Overview of Data Compression in SQL Server]                                                                            | Prashanth Jayaram                        | 2018-12-06 | [DBA][DEV]  |
| [SQL Server Hash Match Operator]                                                                                        | Hugo Kornelis                            | 2018-06-01 | [DBA][DEV]  |
| [How to use Microsoft Assessment and Planning (MAP) Toolkit for SQL Server]                                             | Musab Umair                              | 2017-03-31 | [DBA]       |
| [Improve the Performance of Your Azure SQL Database (and Save Money!) with Automatic Tuning]                            | Monica Rathbun                           | 2019-01-30 | [AZ][DBA]   |
| [The Importance of Database Compatibility Level in SQL Server]                                                          | Glenn Berry                              | 2019-01-14 | [DBA]       |
| [Azure Managed vs Unmanaged disks : The choice]                                                                         | Samir Farhat                             | 2017-05-31 | [AZ]        |
| [Storage options for SQL Server database files in Azure]                                                                | James Serra                              | 2019-01-29 | [AZ]        |
| [The Performance of Window Aggregates Revisited with SQL Server 2019]                                                   | Kathi Kellenberger                       | 2019-02-11 | [DEV]       |
| [Super Scaling Singleton Inserts]                                                                                       | Chris Adkin                              | 2015-02-19 | [DEV]       |
| [Preparation for SQL Server Installation]                                                                               | Michal Sadowski                          | 2018-12-12 | [DBA]       |
| [Executing xp_cmdshell with Non SysAdmin Account]                                                                       | Lucas Kartawidjaja                       | 2019-01-04 | [DBA]       |
| [Generating SQL using Biml (T-SQL Tuesday #110)]                                                                        | Cathrine Wilhelmsen                      | 2019-01-08 | [DEV]       |
| [Avoiding SQL Server Upgrade Performance Issues]                                                                        | Glenn Berry                              | 2019-02-05 | [DBA]       |
| [Using Temporary Procedures]                                                                                            | Phil Factor                              | 2019-02-08 | [DBA][DEV]  |
| [Introduction to SQL Server Security — Part 1]                                                                          | Robert Sheldon                           | 2018-12-31 | [SEC]       |
| [Introduction to SQL Server Security — Part 2]                                                                          | Robert Sheldon                           | 2019-01-28 | [SEC]       |
| [Introduction to SQL Server Security — Part 3]                                                                          | Robert Sheldon                           | 2019-02-25 | [SEC]       |
| [Introduction to SQL Server Security — Part 4]                                                                          | Robert Sheldon                           | 2019-03-26 | [SEC]       |
| [Introduction to T-SQL Window Functions]                                                                                | Kathi Kellenberger                       | 2018-07-13 | [DBA][DEV]  |
| [Intro to Debugging a Memory Dump]                                                                                      | Adam W. Saxton                           | 2012-03-15 | [DBA][DEV]  |
| [Considering Security with SQL Bulk Insert]                                                                             | Timothy Smith                            | 2019-01-17 | [SEC]       |
| [SQL Server 2012 AlwaysOn – Part 11 – Performance Aspects and Performance Monitoring I]                                 | Juergen Thomas                           | 2013-04-21 | [DBA]       |
| [SQL Server 2012 AlwaysOn – Part 11 – Performance Aspects and Performance Monitoring II]                                | Juergen Thomas                           | 2013-04-24 | [DBA]       |
| [Data Compression Internals]                                                                                            | Jess Pomfret                             | 2019-02-19 | [DBA][DEV]  |
| [SQL Server Data Compression – Crunch Time!]                                                                            | Jeff Mlakar                              | 2019-02-22 | [DBA][DEV]  |
| [Create a slipstream installer for SQL Server on Windows]                                                               | Randolph West                            | 2018-10-24 | [DBA]       |
| [Temporary Tables in SQL Server]                                                                                        | Phil Factor                              | 2011-09-01 | [DBA][DEV]  |
| [SQL unit testing with the tSQLt framework for beginners]                                                               | Esat Erkec                               | 2019-03-19 | [DEV]       |
| [Oracle vs. SQL Server Architecture]                                                                                    | Kellyn Pot'vin-Gorman                    | 2019-03-20 | [DBA][DEV]  |
| [Oracle RAC vs. SQL Server AG]                                                                                          | Kellyn Pot'vin-Gorman                    | 2019-03-28 | [DBA][DEV]  |
| [SSIS vs. Oracle GG]                                                                                                    | Kellyn Pot'vin-Gorman                    | 2019-04-10 | [DBA][DEV]  |
| [Analysis Services Telemetry: What information does SSAS submit? and how has it changed in SSAS 2019?]                  | Shabnam Watson                           | 2019-04-13 | [DBA]       |
| [The Curious Case of… how to find FILESTREAM info from an MDF]                                                          | Paul Randal                              | 2019-04-18 | [DBA]       |
| [Does index fragmentation matter?]                                                                                      | Tibor Karaszi                            | 2019-04-05 | [DBA][DEV]  |
| [How to perform a Page Level Restore in SQL Server]                                                                     | Klaus Aschenbrenner                      | 2015-10-13 | [DBA]       |
| [How Much Memory Does SSIS Need?]                                                                                       | Tim Mitchell                             | 2019-05-02 | [SSIS]      |
| [The Curious Case of… trying to find an MDF file in a RAW disk]                                                         | Paul Randal                              | 2019-04-30 | [DBA]       |
| [Understanding the SQL Server NOLOCK hint]                                                                              | Greg Robidoux                            | 2019-04-29 | [DBA][DEV]  |
| [Methods to Insert Data into SQL Server]                                                                                | Ed Pollack                               | 2019-04-10 | [DBA][DEV]  |
| [Batching data manipulation is great as long as you do it correctly]                                                    | Jeff Iannucci                            | 2018-09-15 | [DBA][DEV]  |
| [Azure and Windows PowerShell: Using VM Extensions]                                                                     | Nicolas Prigent                          | 2018-10-09 | [PS]        |
| [Reloading fact tables with zero downtime]                                                                              | Daniel Hutmacher                         | 2014-08-24 | [DBA][DEV]  |
| [Transferring Data Efficiently by Using Partition Switching]                                                            | Microsoft Docs                           | 2012-04-10 | [DBA][DEV]  |
| [Another Difference between N'' and '' in SQL Server]                                                                   | Shane O'Neill                            | 2018-10-24 | [DBA][DEV]  |
| [Ignoring NULLs with FIRST_VALUE]                                                                                       | Bert Wagner                              | 2018-08-28 | [DEV]       |
| [Shortchanged with International Money in SQL Server]                                                                   | Bert Wagner                              | 2018-09-25 | [DEV]       |
| [Understanding database recovery with SQL Server 2016 Extended Events]                                                  | Rajendra Gupta                           | 2016-07-05 | [DBA]       |
| [SQL Server 2019: Batch Mode on Rowstore]                                                                               | Dmitri Pilugin                           | 2018-10-04 | [DBA][DEV]  |
| [Using Indexing To Solve Blocking and Deadlocking Issues]                                                               | David Fowler                             | 2019-03-15 | [DBA][DEV]  |
| [Change collation of existing Azure SQL database]                                                                       | Fonseca Sergio                           | 2018-11-09 | [AZ]        |
| [Creating Database Maintenance Plans]                                                                                   | Nisarg Upadhyay                          | 2018-11-09 | [DBA]       |
| [SQL Server Upgrade Checklist]                                                                                          | Mike Walsh                               | 2019-03-07 | [DBA]       |
| [Failing a PowerShell Sql Agent step]                                                                                   | Stuart Moore                             | 2019-03-04 | [PS]        |
| [The Curse of Cursor Options]                                                                                           | Brent Ozar                               | 2018-11-02 | [DBA][DEV]  |
| [Accelerated Database Recovery; Instant Rollback and Database Recovery]                                                 | Rajendra Gupta                           | 2019-03-12 | [DBA]       |
| [Accelerated Database Recovery and Long Running Transactions with Transaction Log Growth]                               | Rajendra Gupta                           | 2019-03-21 | [DBA]       |
| [Using docker named volumes to persist databases in SQL Server]                                                         | Andrew Pruski                            | 2019-03-21 | [DBA][DEV]  |
| [T-SQL bugs, pitfalls, and best practices – determinism]                                                                | Itzik Ben-Gan                            | 2019-03-13 | [DBA][DEV]  |
| [Grouped Concatenation in SQL Server]                                                                                   | Aaron Bertrand                           | 2014-08-06 | [DBA][DEV]  |
| [Working with tempdb in SQL Server 2005]                                                                                | Microsoft Docs                           | 2010-01-28 | [DBA][DEV]  |
| [SQLskills SQL101: Temporary table misuse]                                                                              | Paul Randal                              | 2017-03-13 | [DBA][DEV]  |
| [Running SQL Server on Linux on your own laptop]                                                                        | Kevin Chant                              | 2019-03-26 | [DBA][DEV]  |
| [SSIS and Pentaho – A Quick Comparison]                                                                                 | Koen Verbeeck                            | 2018-10-17 | [SSIS]      |
| [WinDbg and SQL Server Fun]                                                                                             | Shane O'Neill                            | 2017-06-14 | [DBA][DEV]  |
| [Certificates, Proxies and Jobs! Oh My!]                                                                                | Kenneth Fisher                           | 2016-04-27 | [DBA][J]    |
| [SQL Server: Diagnosing Intermittent Connectivity Issues]                                                               | Mitch Wheat                              | 2019-04-12 | [DBA][DEV]  |
| [Difference between Identity & Sequence in SQL Server]                                                                  | Ben Richardson                           | 2018-08-15 | [DBA][DEV]  |
| [Does the Rowmodctr Update for Non-Updating Updates?]                                                                   | Brent Ozar                               | 2019-05-20 | [DBA][DEV]  |
| [An Intro To Data Modeling]                                                                                             | JBOSEMS                                  | 2019-04-12 | [DBA][DEV]  |
| [On telemetry and other data collected by SQL Server]                                                                   | Aaron Bertrand                           | 2016-04-04 | [DBA][DEV]  |
| [Purging data with batched deletes]                                                                                     | Andy Mallon                              | 2019-04-03 | [DBA][DEV]  |
| [Don’t Forget RoboCopy]                                                                                                 | John Morehouse                           | 2019-03-03 | [DBA]       |
| [Understanding the XML description of the Deadlock Graph in SQL Server]                                                 | Minette Steynberg                        | 2016-04-26 | [DBA][DEV]  |
| [What Is The Difference Between Checkpoint And Lazy Writer]                                                             | Saurabh Sinha                            | 2012-10-01 | [DBA]       |
| [Efficiently Indexing Long Character Strings]                                                                           | Jon Seigel                               | 2013-07-13 | [DBA][DEV]  |
| [SQL Server Read-only tables]                                                                                           | Kenneth Fisher                           | 2019-01-21 | [DBA]       |
| [Slow inserts across a linked server?]                                                                                  | Max Vernon                               | 2019-04-25 | [DBA][DEV]  |
| [Using IGNORE NULLS With SQL Window Functions to Fill Gaps]                                                             | Lukas Eder                               | 2019-04-24 | [DBA][DEV]  |
| [SQL Server Logical Reads]                                                                                              | Ami Levin                                | 2008-01-01 | [DBA][DEV]  |
| [Two Words For Faster Scalar Functions]                                                                                 | Bert Wagner                              | 2018-12-04 | [DBA][DEV]  |
| [How to Get SQL Server Dates and Times Horribly Wrong]                                                                  | Robert Sheldon                           | 2015-05-28 | [DBA][DEV]  |
| [Diagnosing and Resolving Spinlock Contention on SQL Server]                                                            | Ewan Fairweather, Mike Ruthruff          | 2011-06-01 | [DBA][DEV]  |
| [Diagnosing and Resolving Latch Contention on SQL Server]                                                               | Ewan Fairweather, Mike Ruthruff          | 2011-06-01 | [DBA][DEV]  |
| [Advanced Nutanix: SQL Server on Nutanix Best Practices Released!]                                                      | Steven Poitras                           | 2013-11-09 | [DBA]       |
| [Gaps and Islands Across Date Ranges]                                                                                   | Bert Wagner                              | 2019-03-12 | [DBA]       |
| [NOT NULL Persisted Computed Columns (And What They Allow)]                                                             | Louis Davidson                           | 2019-06-01 | [DBA][DEV]  |
| [How many ways are there to sort GUIDs? How much time do you have?]                                                     | Raymond Chen                             | 2019-04-26 | [DBA][DEV]  |
| [How do I force a SQL Login to change it’s password on next login]                                                      | Kenneth Fisher                           | 2019-06-05 | [DBA]       |
| [SQL Server Performance Benchmarking with Patterns]                                                                     | Paul Brewer                              | 2017-10-19 | [BENCH]     |
| [SQL Server function to convert integer date to datetime format]                                                        | Tim Ford                                 | 2019-05-24 | [DBA][DEV]  |
| [Storing Utc Is Not A Silver Bullet]                                                                                    | Jon Skeet                                | 2019-03-27 | [DBA][DEV]  |
| [Logical Query Processing Part 8 : SELECT and ORDER BY]                                                                 | Itzik Ben-Gan                            | 2016-11-15 | [DBA][DEV]  |
| [SQL Server Common Table Expression vs Temp Table]                                                                      | Rick Dobson                              | 2019-05-22 | [DBA][DEV]  |
| [Which Query Used The Most Cpu? Implementing Extended Events]                                                           | Grant Fritchey                           | 2019-06-03 | [XE]        |
| [SQL Server Plan Cache Limits]                                                                                          | Erin Stellato                            | 2019-05-28 | [DBA]       |
| [SQL Server and ReFS: Part 1 – DBCC and In Memory OLTP]                                                                 | swasheck                                 | 2014-11-11 | [DBA]       |
| [SQL Server and ReFS: Part 2 – FIO Benchmarking NTFS vs. ReFS]                                                          | swasheck                                 | 2014-12-18 | [DBA]       |
| [Why Rolling back inserts with Identity columns is a bad idea]                                                          | Adrian Buckman                           | 2019-04-11 | [DBA][DEV]  |
| [What’s Better, CTEs or Temp Tables?]                                                                                   | Brent Ozar                               | 2019-06-06 | [DBA][DEV]  |
| [The Difference Between SQL’s JOIN .. ON Clause and the Where Clause]                                                   | Lukas Eder                               | 2019-04-09 | [DBA][DEV]  |
| [My IT department installed an antivirus with SQL Server]                                                               | Randolph West                            | 2019-06-05 | [DBA]       |
| [An Experiment with Deadlocks - ROWLOCK hint myth]                                                                      | Jason Brimhall                           | 2019-03-25 | [DBA][DEV]  |
| [Adding a New Transaction Log File when the Existing Log is Full]                                                       | Max Vernon                               | 2019-03-19 | [DBA]       |
| [Transactions Don't Start At BEGIN TRAN]                                                                                | Josh Darnell                             | 2019-06-05 | [DBA][DEV]  |
| [CAST/CONVERT makes expressions nullable]                                                                               | Daniel Hutmacher                         | 2019-06-05 | [DBA][DEV]  |
| [Deciding between COALESCE and ISNULL in SQL Server]                                                                    | Aaron Bertrand                           | 2012-04-30 | [DBA][DEV]  |
| [How do you choose which columns to include in your SQL Server clustered index?]                                        | agilesql                                 | 2019-06-01 | [DBA][DEV]  |
| [A ever-increasing Clustered Key value doesn’t scale]                                                                   | Klaus Aschenbrenner                      | 2014-04-15 | [DBA][DEV]  |
| [SQL Server Bit reversion]                                                                                              | Rick                                     | 2011-10-03 | [DBA][DEV]  |
| [Troubleshooting a renamed SQL Server]                                                                                  | Jamie Wick                               | 2019-06-05 | [DBA]       |
| [Are Differential Backups Necessary?]                                                                                   | Jamie Wick                               | 2019-04-02 | [B][DBA]    |
| [Updating Statistics on Secondary Replicas of the Availability Groups]                                                  | Niko Neugebauer                          | 2019-06-20 | [DBA]       |
| [It’s interesting how an OR short circuits]                                                                             | Kenneth Fisher                           | 2019-06-17 | [DBA][DEV]  |
| [SQL Server NOLOCK Anomalies, Issues and Inconsistencies]                                                               | Aaron Bertrand                           | 2019-06-18 | [DBA][DEV]  |
| [Choosing a Database for Serverless Applications]                                                                       | Alex DeBrie                              | 2019-06-22 | [DEV]       |
| [SQL Server On Linux: Forced Unit Access (Fua) Internals]                                                               | Robert Dorr                              | 2018-12-18 | [DBA]       |
| [Socrates: The New SQL Server in the Cloud]                                                                             | Microsoft                                | 2019-05-01 | [DBA][DEV]  |
| [What permissions do temp stored procedures use?]                                                                       | Kenneth Fisher                           | 2019-06-19 | [DBA][DEV]  |
| [Common SQL Server Mishaps]                                                                                             | Tim Radney                               | 2019-06-21 | [DBA]       |
| [SQL Server Agent for SQL Express on Linux]                                                                             | Thom Andrews                             | 2019-06-18 | [DBA]       |
| [Trailing Spaces in SQL Server]                                                                                         | Bert Wagner                              | 2019-06-18 | [DEV]       |
| [Troubleshooting a Change in Query Performance]                                                                         | Erin Stellato                            | 2019-06-20 | [P]         |
| [The Silent Bug I Find in Most Triggers]                                                                                | Brent Ozar                               | 2019-05-06 | [DBA][DEV]  |
| [How to Copy a Table in SQL Server to Another Database]                                                                 | Pablo Echeverria                         | 2019-05-14 | [DBA][DEV]  |
| [Configuration of SQL Server instance]                                                                                  | Michal Sadowski                          | 2019-06-18 | [DBA]       |
| [What is the SQL Server Virtual Log file and how to monitor it]                                                         | Musab Umair                              | 2017-04-26 | [DBA]       |
| [Important change to VLF creation algorithm in SQL Server 2014]                                                         | Paul Randal                              | 2015-01-06 | [DBA]       |
| [SQL Server Transaction Log Fragmentation: a Primer]                                                                    | Greg Larsen                              | 2012-04-26 | [DBA]       |
| [8 Steps to better Transaction Log throughput]                                                                          | Kimberly Tripp                           | 2019-01-01 | [DBA]       |
| [Joins With OR Clauses = 💔]                                                                                            | Erik Darling                             | 2019-06-04 | [DBA][DEV]  |
| [Thoughts on MAXDOP]                                                                                                    | Erik Darling                             | 2019-06-18 | [DBA][DEV]  |
| [What the Arrow Sizes in Query Plans Really Mean]                                                                       | Brent Ozar                               | 2019-06-21 | [DBA][DEV]  |
| [Query Store Best Practices]                                                                                            | Erin Stellato                            | 2019-06-25 | [DBA][DEV]  |
| [Introduction to Data Normalization: A Database "Best" Practice]                                                        | Scott Wambler                            | 2019-01-01 | [DBA][DEV]  |
| [Dr. OUTPUT or: How I Learned to Stop Worrying and Love the MERGE]                                                      | Adam Machanic                            | 2009-08-24 | [DBA][DEV]  |
| [SQL Server Tipping Games – Why Non-Clustered Indexes are just ignored!]                                                | Klaus Aschenbrenner                      | 2013-06-12 | [DBA][DEV]  |
| [SQL Server Guide To NULL Handling]                                                                                     | Gavin Draper                             | 2018-11-29 | [DBA][DEV]  |
| [Living with SQL’s 900 Byte Index Key Length Limit]                                                                     | Bart Duncan                              | 2011-01-06 | [DBA][DEV]  |
| [Memory-Optimized TempDB Metadata in SQL Server 2019]                                                                   | Ed Pollack                               | 2019-07-10 | [DBA][DEV]  |
| [Forcing A Plan That Has A Plan Guide]                                                                                  | Grant Fritchey                           | 2018-11-26 | [DBA][DEV]  |
| [Remember the Default Window]                                                                                           | Steve Jones                              | 2018-08-23 | [DBA][DEV]  |
| [The Impact of Non-Updating Updates]                                                                                    | Paul Randal                              | 2010-08-11 | [DBA][DEV]  |
| [What are Columnstore Indexes?]                                                                                         | Monica Rathbun                           | 2019-07-22 | [DBA][DEV]  |
| [PolyBase in SQL Server 2019 – The End of ETL?]                                                                         | Benjamin Weissman                        | 2019-07-23 | [DBA][DEV]  |
| [Overview of Service Principal Name and Kerberos authentication in SQL Server]                                          | Rajendra Gupta                           | 2019-07-18 | [DBA]       |
| [Data Transfer Strategies between MongoDB and SQL Server]                                                               | Phil Factor                              | 2019-07-22 | [DBA][DEV]  |
| [SQL Server and Excel Hierarchyid Example for Organization Charts]                                                      | Rick Dobson                              | 2019-07-04 | [DEV]       |
| [Difference between sp_execute and sp_executesql and exec]                                                              | Prasad Sahoo                             | 2015-02-09 | [DBA][DEV]  |
| [EXEC and sp_executesql – how are they different?]                                                                      | Kimberly Tripp                           | 2010-04-05 | [DBA][DEV]  |
| [Little Bobby Tables, SQL Injection and EXECUTE AS]                                                                     | Kimberly Tripp                           | 2010-04-04 | [DBA][DEV]  |
| [Examining the Performance Impact of an Adhoc Workload]                                                                 | Erin Stellato                            | 2019-05-22 | [BENCH]     |
| [Backup to URL]                                                                                                         | Jon Gurgul                               | 2019-01-01 | [B][DBA]    |
| [Spotting Unauthorized Configuration Settings in SQL Server]                                                            | Phil Factor                              | 2018-09-30 | [DBA][DEV]  |
| [Window Functions in SQL Server]                                                                                        | Fabiano Amorim                           | 2011-10-27 | [DBA][DEV]  |
| [Window Functions in SQL Server: Part 2-The Frame]                                                                      | Fabiano Amorim                           | 2011-11-24 | [DBA][DEV]  |
| [An Intro to SQL Window Functions]                                                                                      | Neal Barnett                             | 2019-07-07 | [DBA][DEV]  |
| [SQL Database Performance Tuning for Developers]                                                                        | Rodrigo Koch                             | 1753-01-01 | [P]         |
| [“But NOLOCK Is Okay When The Data Isn’t Changing, Right?”]                                                             | Brent Ozar                               | 2019-08-05 | [DBA][DEV]  |
| [tempdb Enhancements in SQL Server 2019]                                                                                | Erin Stellato                            | 2019-08-02 | [BENCH]     |
| [Feature Restrictions in SQL Server 2019 are Worse Than Useless: a False Sense of Security And Wasted Opportunity]      | Solomon Rutzky                           | 2019-08-05 | [SEC]       |
| [How to get SQL Server Sysadmin Privileges as a Local Admin with PowerUpSQL]                                            | Scott Sutherland                         | 2017-05-23 | [PS][SEC]   |
| [Views of the Same Problem: Network Admin, DBA, and Developer]                                                          | Kyle Brandt                              | 2011-03-16 | [DBA][DEV]  |
| [The SQL Server Data Row Size Question: Why is It Bigger?]                                                              | Kendra Little                            | 2019-03-19 | [DBA][DEV]  |
| [Finding Max Concurrent Operations With T-SQL (Part 1)]                                                                 | Kevin Feasel                             | 2019-01-02 | [DEV]       |
| [Finding Max Concurrent Operations With T-SQL (Part 2)]                                                                 | Kevin Feasel                             | 2019-01-03 | [DEV]       |
| [Stack Overflow: The Architecture - 2016 Edition]                                                                       | Nick Craver                              | 2019-02-17 | [DBA][DEV]  |
| [Stack Overflow: The Hardware - 2016 Edition]                                                                           | Nick Craver                              | 2016-03-29 | [DBA]       |
| [Stack Overflow: How We Do Deployment - 2016 Edition]                                                                   | Nick Craver                              | 2016-05-03 | [DBA][DEV]  |
| [Stack Overflow: How We Do Monitoring - 2018 Edition]                                                                   | Nick Craver                              | 2018-11-29 | [DBA][DEV]  |
| [Stack Overflow: How We Do App Caching - 2019 Edition]                                                                  | Nick Craver                              | 2019-08-06 | [DBA][DEV]  |
| [Adding a Missing Index Killed Performance]                                                                             | Jeffry Schwartz                          | 2019-08-15 | [DBA][DEV]  |
| [Corruption in TempDB]                                                                                                  | Steve Stedman                            | 2019-08-12 | [COR][DBA]  |
| [Corruption recovery using DBCC WRITEPAGE]                                                                              | Paul Randal                              | 2014-02-13 | [COR][DBA]  |
| [Why DBCC CHECKDB can miss memory corruption]                                                                           | Paul Randal                              | 2017-07-19 | [COR][DBA]  |
| [Fixing Cardinality Estimation Errors with Filtered Statistics]                                                         | Klaus Aschenbrenner                      | 2013-10-29 | [DBA][DEV]  |
| [Plan Stitch: Harnessing the Best of Many Plans]                                                                        | Bailu Ding, Sudipto Das Wentao …         | 2018-07-01 | [DBA][DEV]  |
| [Query and Resource Optimization: Bridging the Gap]                                                                     | Lalitha Viswanathan, Alekh Jindal …      | 2018-02-01 | [DBA][DEV]  |
| [Cuttlefish: A Lightweight Primitive for Adaptive Query Processing]                                                     | Tomer Kaftan, Magdalena Balazinska …     | 2018-02-01 | [DBA][DEV]  |
| [Leveraging Re-costing for Online Optimization of Parameterized Queries with Guarantees]                                | Anshuman Dutt, Vivek Narasayya …         | 2017-05-01 | [DBA][DEV]  |
| [How to choose antivirus software to run on computers that are running SQL Server]                                      | Microsoft                                | 2018-10-31 | [DBA][SEC]  |
| [Why is SYSDATETIME() slower than SYSUTCDATETIME()?]                                                                    | Erik Darling                             | 2019-05-28 | [DBA][DEV]  |
| [Constant Time Recovery in Azure SQL Database]                                                                          | Panagiotis Antonopoulos, Peter Byrne …   | 2019-06-01 | [AZ]        |
| [Improving Optimistic Concurrency Control Through Transaction Batching and Operation Reordering]                        | Bailu Ding, Lucja Kot, Johannes Gehrke   | 2019-01-01 | [DBA][DEV]  |
| [An Empirical Evaluation of In-Memory Multi-Version Concurrency Control]                                                | Yingjun Wu, Joy Arulraj, Jiexi Lin …     | 2019-01-01 | [DBA][DEV]  |
| [Automatically Indexing Millions of Databases in Microsoft Azure SQL Database]                                          | Sudipto Das, Miroslav Grbic, Igor Ilic … | 2019-01-01 | [AZ][IDX]   |
| [Adding a Column with a Default Constraint]                                                                             | Matthew Mcgiffen                         | 2019-07-16 | [DBA][DEV]  |
| [A Hidden Value Of Apply]                                                                                               | Erik Darling                             | 2019-06-24 | [DEV]       |
| [Improve Performance of UDFs with NULL ON NULL INPUT]                                                                   | Jonathan Kehayias                        | 2018-12-27 | [DEV]       |
| [The ‘= NULL’ Mistake and other SQL NULL Heresies]                                                                      | Phill Factor                             | 2019-06-17 | [DBA][DEV]  |
| [How to Corrupt a Database]                                                                                             | Max Vernon                               | 2019-07-29 | [DBA][COR]  |
| [SQL Server Page Types]                                                                                                 | John Huang                               | 2011-10-31 | [DBA][DEV]  |
| [SQL Server Index Maintenance – You’re Doing It Wrong]                                                                  | Sean Gallardy                            | 2019-09-01 | [DBA][DEV]  |
| [Stop Worrying About SQL Server Fragmentation]                                                                          | Brent Ozar                               | 2012-08-14 | [DBA]       |
| [How much will it cost or save to rebuild that index?]                                                                  | Jeff Moden                               | 2019-09-03 | [DBA][DEV]  |
| [To BLOB or Not To BLOB: Large Object Storage in a Database or a Filesystem?]                                           | Russell Sears2, Catharine van Ingen …    | 2019-04-01 | [DBA][DEV]  |
| [SQL Server UPSERT Patterns and Antipatterns]                                                                           | Michael J Swart                          | 2017-07-20 | [DBA][DEV]  |
| [Use Caution with SQL Server's MERGE Statement]                                                                         | Aaron Bertrand                           | 2018-07-24 | [DBA][DEV]  |
| [“UPSERT” Race Condition With MERGE]                                                                                    | Dan Guzman                               | 2009-01-31 | [DBA][DEV]  |
| [Checking for potential constraint violations before entering SQL Server TRY and CATCH logic]                           | Aaron Bertrand                           | 2012-02-18 | [DBA][DEV]  |
| [Performance impact of different error handling techniques]                                                             | Aaron Bertrand                           | 2012-08-12 | [DBA][DEV]  |
| [Backup and Restore Databases with CHECKSUM and VERIFYONLY]                                                             | Lori Brown                               | 2019-08-29 | [B][DBA]    |
| [dm_db_database_page_allocations]                                                                                       | Max Vernon                               | 2019-08-01 | [DBA][DEV]  |
| [Compress Big Tables]                                                                                                   | Max Vernon                               | 2019-08-22 | [DBA][DEV]  |
| [Hardening SQL Server Security]                                                                                         | Mitch Wheat                              | 2019-08-21 | [DBA][SEC]  |
| [Splitting Strings With OPENJSON]                                                                                       | Dave Mason                               | 2019-05-06 | [DEV][X]    |
| [How to migrate to Amazon RDS for SQL Server using transactional replication]                                           | Richard Waymire                          | 2018-05-17 | [AMZ][MG]   |
| [The Hardest Part Of Query Tuning: Logical Equivalence]                                                                 | Erik Darling                             | 2019-08-13 | [DBA][DEV]  |
| [SQL Injection: What is it? Causes and exploits]                                                                        | Ed Pollack                               | 2019-08-30 | [SEC]       |
| [SQL Injection: Detection and prevention]                                                                               | Ed Pollack                               | 2019-08-30 | [SEC]       |
| [Some T-SQL INSERTs DO Follow the Fill Factor!]                                                                         | Jeff Moden                               | 2019-08-08 | [DBA][DEV]  |
| [Install SQL Server 2019 Big Data Cluster using Azure Data Studio]                                                      | Niels Berglund                           | 2019-09-11 | [DBA][DEV]  |
| [Indirect Checkpoint and tempdb – the good, the bad and the non-yielding scheduler]                                     | Parikshit Savjani                        | 2018-09-14 | [DBA]       |
| [Ghost Records in SQL Server… Now whats that ????]                                                                      | Sachin Nandanwar                         | 2011-04-10 | [DBA]       |
| [Transaction Isolation Levels and sp_executesql]                                                                        | Max Vernon                               | 2019-08-19 | [DBA][DEV]  |
| [Batch Mode Bitmaps in SQL Server]                                                                                      | Paul White                               | 2019-08-23 | [DBA][DEV]  |
| [Transparent Data Encryption (TDE) on Azure SQL database]                                                               | Ranga Babu                               | 2019-09-13 | [DBA][AZ]   |
| [Analyzing Estimates from the CSelCalcAscendingKeyFilter Calculator]                                                    | Josh Darnell                             | 2019-08-21 | [DEV]       |
| [Building Storage for SQL Server (and other database) Virtual Machines in the Cloud]                                    | Joey Dantoni                             | 2019-09-18 | [AZ]        |
| [SQL Server Simple and Forced Parameterization]                                                                         | Brady Upton                              | 2013-04-23 | [DBA][DEV]  |
| [How to use a SQL Server Plan Guide to Tune Queries]                                                                    | Armando Prato                            | 2018-06-02 | [DBA][DEV]  |
| [Neglecting to Use, or Misusing, the RETURN Keyword (BP016)]                                                            | Phil Factor                              | 2019-08-14 | [DBA][DEV]  |
| [Defensive Error Handling]                                                                                              | Alex Kuznetsov                           | 2010-10-08 | [DBA][DEV]  |
| [A Self-Tuning Fill Factor Technique for SQL Server – Part 1]                                                           | Mike Byrd                                | 2019-08-20 | [DBA][DEV]  |
| [A Self-Tuning Fill Factor Technique for SQL Server – Part 2]                                                           | Mike Byrd                                | 2019-08-27 | [DBA][DEV]  |
| [SQL: Been told you can't access master database system views in Azure SQL Database? Not true!]                         | Greg Low                                 | 2019-09-17 | [AZ]        |
| [How to increase SQL Database Full Backup speed using compression and Solid State Disks]                                | Henk                                     | 2010-01-15 | [DBA]       |
| [Troubleshooting NUMA Node Imbalance Problems (HammerDB Benchmark)]                                                     | Klaus Aschenbrenner                      | 2019-09-23 | [BENCH]     |
| [SQL Server Unequal NUMA CPU engagement]                                                                                | @sqL_handLe                              | 2019-09-19 | [DBA]       |
| [SSIS Connection Managers: OLE DB vs ODBC vs ADO.NET]                                                                   | Hadi Fadlallah                           | 2019-10-04 | [SSIS]      |
| [SSIS Data Flows – ADO.NET vs. OLE DB vs. ODBC]                                                                         | Ross at Datatell                         | 2015-01-13 | [SSIS]      |
| [SSIS – Fastest data flow task item for transferring data over the network]                                             | Gilbert Quevauvilliers                   | 2013-01-19 | [SSIS]      |
| [The Case of the Vanishing Index Compression]                                                                           | Louis Davidson                           | 2019-09-30 | [DBA][IDX]  |
| [Migrating from MSSQL to PostgreSQL - What You Should Know]                                                             | Severalnines                             | 2018-11-05 | [DEV]       |
| [Difference between Identity and Sequence in SQL Server 2012]                                                           | Muhammad Imran                           | 2012-05-01 | [DEV]       |
| [Sequence vs Identity – Performance Comparison]                                                                         | Bill Anton                               | 2012-09-02 | [DEV]       |
| [Read Excel File in SQL Server with OPENROWSET or OPENDATASOURCE]                                                       | Diana Moldovan                           | 2019-10-10 | [DBA][DEV]  |
| [Upgrading SQL Server using Availability Groups – Checklist]                                                            | Thomas Rushton                           | 2019-10-17 | [DBA]       |
| [Using indexed views? WITH (NOEXPAND) for Standard Edition]                                                             | Randolph West                            | 2019-10-09 | [DEV][IDX]  |
| [Using indexed views? What is an imprecise or non-deterministic convert?]                                               | Randolph West                            | 2019-10-16 | [DEV][IDX]  |
| [JSON in your Azure SQL Database? Let’s benchmark some options!]                                                        | Silvano Coriani                          | 2019-10-15 | [X]         |
| [Looking for strange - addition to system_health XE]                                                                    | Tibor Karaszi's                          | 1753-01-01 | [DBA][XE]   |
| [What's new in SQL Server version x]                                                                                    | Tibor Karaszi's                          | 1753-01-01 | [DBA][DEV]  |
| [The ultimate guide to the datetime datatypes]                                                                          | Tibor Karaszi's                          | 2010-01-01 | [DBA][DEV]  |
| [Some numbers that you will know by heart if you have been working with SQL Server for a while]                         | Unknown                                  | 2019-03-20 | [DBA][DEV]  |
| [#TSQL2sday: How Much Plan Cache History Do You Have?]                                                                  | Brent Ozar                               | 2018-07-10 | [DBA][DEV]  |
| [Fixing SQL Server Management Studio’s Tab Text]                                                                        | Brent Ozar                               | 2011-06-07 | [DBA][DEV]  |
| [An overview of the SQL table variable]                                                                                 | Rajendra Gupta                           | 2019-10-16 | [DBA][DEV]  |
| [Performance Impact of Small Queries]                                                                                   | Forrest McDaniel                         | 2019-06-15 | [DBA][DEV]  |
| [How we use SQL Server as a Document Store]                                                                             | Paul Stovell                             | 2019-03-24 | [DBA][DEV]  |
| [Overlooked T-SQL Gems]                                                                                                 | Itzik Ben-Gan                            | 2019-10-09 | [DBA][DEV]  |
| [Are SQL Server database triggers evil?]                                                                                | Daniel Calbimonte                        | 2017-01-25 | [DBA][DEV]  |
| [Configuration Best Practices for SQL Server Tempdb–Initial Sizing]                                                     | Christian Bolton, Justin Langford …      | 2013-02-12 | [DBA]       |
| [Sql Server Extended Events Trace Overhead]                                                                             | Nenad Noveljic                           | 2018-09-04 | [DBA]       |
| [Measuring "Observer Overhead" of SQL Trace vs. Extended Events]                                                        | Jonathan Kehayias                        | 2012-10-23 | [DBA][XE]   |
| [Performance overhead of tracing with Extended Event targets vs SQL Trace under CPU Load]                               | Andreas Wolter                           | 2013-07-01 | [DBA][XE]   |
| [Fragmentation, the final installment]                                                                                  | Tibor Karaszi's                          | 2019-10-18 | [DBA][IX]   |
| [Atomic Durability - How do databases recover from a crash ?]                                                           | Pedro Ramalhete                          | 2019-10-01 | [DBA][DEV]  |
| [Truth First, or Why You Should Mostly Implement Database First Designs]                                                | Lukas Eder                               | 2018-06-06 | [DEV]       |
| [SQL Server CHECKPOINT, Lazy Writer, Eager Writer and Dirty Pages in SQL Server]                                        | Rajendra Gupta                           | 2019-08-22 | [DBA]       |
| [T-SQL bugs, pitfalls, and best practices – window functions]                                                           | Itzik Ben-Gan                            | 2019-08-14 | [DBA][DEV]  |
| [#BackToBasics: Why I use lower case for data type names (now)]                                                         | Aaron Bertrand                           | 2016-10-04 | [DBA][DEV]  |
| [New high availability and disaster recovery benefits for SQL Server]                                                   | Amit Banerjee                            | 2019-10-30 | [DBA]       |
| [Because Your Index Maintenance Script Is Measuring The Wrong Thing]                                                    | Eric Darling                             | 2019-10-28 | [DBA][IDX]  |
| [Memory-Optimized TempDB Metadata]                                                                                      | Niko Neugebauer                          | 2019-10-30 | [DBA][BENCH]|
| [Build a SQL Cluster Lab Part 1]                                                                                        | Ryan Adams                               | 2019-10-28 | [DBA]       |
| [There is no Such Thing as Object-Relational Impedance Mismatch]                                                        | Lukas Eder                               | 2015-08-26 | [DEV]       |
| [ORMs Under the Hood]                                                                                                   | Patrycja Dybka                           | 2015-08-18 | [DEV]       |
| [EMERGENCY-mode repair: the very, very last resort]                                                                     | Paul Randal                              | 2007-10-02 | [DBA]       |
| [Scalar functions and improvements in SQL Server 2019]                                                                  | Tibor Karaszi's                          | 2019-11-07 | [DEV]       |
| [Scalar functions in SQL server 2019, part 2]                                                                           | Tibor Karaszi's                          | 2019-11-07 | [DEV]       |
| [Dos and Don'ts of Dynamic SQL]                                                                                         | Thom Andrews                             | 2019-04-29 | [DEV][DBA]  |
| [Differences Between Sql Server TEXT and VARCHAR(MAX) Data Type]                                                        | Basavaraj Biradar                        | 2016-05-11 | [DEV][DBA]  |
| [VARBINARY(MAX) Tames the BLOB]                                                                                         | Michael Otey                             | 2006-08-22 | [DEV][DBA]  |
| [Query Store Options in SSMS 18.4]                                                                                      | Erin Stellato                            | 2019-11-12 | [DBA][QS]   |
| [Query Store Performance Overhead: What you need to know]                                                               | Erin Stellato                            | 2018-11-06 | [DBA][QS]   |
| [How to fork a GitHub repository and contribute to an open source project]                                              | Rob Sewell                               | 2019-11-29 | [DBA][DEV]  |
| [But I Need To Compare Two Date Columns In My Where Clause]                                                             | Eric Darling                             | 2019-11-27 | [DBA][IDX]  |
| [The Difference Between Fault Tolerance, High Availability, & Disaster Recovery]                                        | Patrick Benson                           | 2014-02-25 | [DBA][DEV]  |
| [Why LOB data makes shrink run slooooowly]                                                                              | Paul Randal                              | 2010-05-11 | [DBA]       |
| [SQL Server 2019 Scalar UDF inlining - out of memory in some cases]                                                     | @sqL_handLe                              | 2019-11-19 | [DBA][DEV]  |
| [Is it true that editing a single row in Management Studio empties and reloads the entire table?]                       | Randolph West                            | 2019-11-27 | [DBA][DEV]  |
| [A Guide to SQL Naming Conventions]                                                                                     | Lukas Eder                               | 2019-10-29 | [DBA][DEV]  |
| [Stop Mapping Stuff in Your Middleware. Use SQL’s XML or JSON Operators Instead]                                        | Lukas Eder                               | 2019-11-13 | [DBA][DEV]  |
| [How Does Accelerated Database Recovery Work]                                                                           | Forrest McDaniel                         | 2019-11-26 | [DBA]       |
| [Recover SQL Server Resource Database]                                                                                  | Daniel Farina                            | 2019-10-25 | [DBA]       |
| [What’s in that database? Getting information about routines]                                                           | Phil Factor                              | 2019-11-04 | [DBA][DEV]  |
| [The Gloop: An Easier way of Managing SQL Server Documentation]                                                         | Phil Factor                              | 2019-12-03 | [DBA][DEV]  |
| [The SQL of Gaps and Islands in Sequences]                                                                              | Dwain Camps                              | 2013-07-25 | [DEV]       |
| [Drop Database Objects Practically Risk-Free!]                                                                          | Pamela Mooney                            | 2019-04-17 | [DBA]       |
| [Predicate Pushdown and why should I care?]                                                                             | Pedro Lopes                              | 2018-07-06 | [DBA][DEV]  |
| [Stack Overflow Demo Database Column Store Edition: Downloads And Links]                                                | Eric Darling                             | 2019-11-11 | [DBA][DEV]  |
| [Stack Overflow Demo Database Column Store Edition: Exploring Relationships]                                            | Eric Darling                             | 2019-11-14 | [DBA][DEV]  |
| [Stack Overflow Demo Database Column Store Edition: Helpful Links]                                                      | Eric Darling                             | 2019-11-15 | [DBA][DEV]  |
| [Online, Resumable, and WAIT_AT_LOW_PRIORITY operations in SQL Server]                                                  | Kendra Little                            | 2019-12-09 | [DBA][DEV]  |
| [How filtered indexes could be a more powerful feature]                                                                 | Aaron Bertrand                           | 2013-04-24 | [IDX]       |
| [How Forced Parameterization in SQL Server Affects Filtered Indexes]                                                    | Aaron Bertrand                           | 2019-09-19 | [IDX]       |
| [Filtered Indexes and Forced Parameterization (redux)]                                                                  | Aaron Bertrand                           | 2019-12-03 | [IDX]       |
| [Interpreting SQL Server 2019 DBCC MEMORYSTATUS output -- Part 1]                                                       | @sqL_handLe                              | 2019-12-15 | [DBA]       |
| [Invisible tempdb Killer]                                                                                               | Josh Darnell                             | 2019-12-18 | [DBA][DEV]  |
| [Batch Mode On Row Store Is Fickle]                                                                                     | Eric Darling                             | 2019-12-19 | [DBA][DEV]  |
| [Use Azure To Store Sql Server Backups Offsite]                                                                         | Sander Stad                              | 2019-12-18 | [AZ][B]     |
| [Handling Data Returned from a SQL Stored Procedure]                                                                    | Drew                                     | 2019-12-20 | [DBA][DEV]  |
| [When QUERY_OPTIMIZER_COMPATIBILITY_LEVEL_140 does not follow CL 140 rules]                                             | Milos Radivojevic                        | 2019-12-20 | [DBA][DEV]  |
| [SQL Server–HOW-TO: quickly retrieve accurate row count for table]                                                      | martijnh1                                | 2010-07-15 | [DBA][DEV]  |
| [Do You Have REFERENCES?]                                                                                               | Joe Celko                                | 2019-12-03 | [DBA][DEV]  |
| [Fun with (columnstore) compression on a very large table – part 1]                                                     | Aaron Bertrand                           | 2019-12-27 | [DBA]       |
| [How to Make SELECT COUNT(*) Queries Crazy Fast]                                                                        | Brent Ozar                               | 2019-12-26 | [DBA][DEV]  |
| [SSISDB Catalog Defaults Best Practices]                                                                                | Steve Rezhener                           | 2019-12-26 | [DBA][DEV]  |
| [Temporal Tables, and how to deal with computed columns]                                                                | Randolph West                            | 2019-12-25 | [DBA][DEV]  |
| [Cardinality Estimation for Disjunctive Predicates in SQL Server 2014]                                                  | Paul White                               | 2014-04-15 | [DBA][DEV]  |
| [Create Distributed Availability Group in Sql Server Linux(Redhat) --- step by step]                                    | Liwei                                    | 2019-11-14 | [DBA]       |
| [Connection options in SSMS]                                                                                            | Kenneth Fisher                           | 2013-11-18 | [DBA][DEV]  |
| [A Script To Automatically Align Columnstore Indexes To Enhance Segment Elimination (and Hence Performances)]           | Emanuele Meazzo                          | 2018-06-04 | [DBA][IDX]  |
| [Issues with SQLCMD when using special characters]                                                                      | Daniel Farina                            | 2018-01-11 | [DBA][DEV]  |
| [Encrypting passwords with Python Scripts in SQL Notebooks of Azure Data Studio]                                        | Rajendra Gupta                           | 2020-01-06 | [DBA][DEV]  |
| [Fun with (columnstore) compression on a very large table – part 2]                                                     | Aaron Bertrand                           | 2020-01-07 | [DBA][IDX]  |
| [The curious case of the sqlcmd password]                                                                               | Randolph West                            | 2020-01-08 | [DBA][DEV]  |
| [Setting up Management Studio for remote SQL Server]                                                                    | aveek22                                  | 2020-01-06 | [DBA][DEV]  |
| [SQL Server Security Best Practices for an Application Installed on SQL Server]                                         | Svetlana Golovko                         | 2019-12-08 | [DBA][SEC]  |
| [PCI Best Practices Guide for SQL Server DBAs]                                                                          | Tibor Nagy                               | 2015-05-08 | [DBA][SEC]  |
| [SQL Server Security Checklist]                                                                                         | Tibor Nagy                               | 2014-02-06 | [DBA][SEC]  |
| [Replace Model SQL Server Database with a User Database]                                                                | Daniel Farina                            | 2019-12-13 | [DBA]       |
| [SQL Server Linux installation for Amazon EC2 instance with Red Hat OS]                                                 | Rajendra Gupta                           | 2020-01-09 | [AMZ        |
| [Departure of a SQL Server Administrator – What to Check?]                                                              | Thomas Rushton                           | 2020-01-03 | [DBA]       |
| [The Curious Case of… transactions rolling back during DBCC CHECKDB]                                                    | Paul Randal                              | 2020-01-15 | [DBA]       |
| [Don’t install SQL Server from a mounted ISO]                                                                           | Randolph West                            | 2020-01-15 | [DBA]       |
| [NULL complexities – Part 1]                                                                                            | Itzik Ben-Gan                            | 2019-12-11 | [DBA][DEV]  |
| [NULL complexities – Part 2]                                                                                            | Itzik Ben-Gan                            | 2020-01-08 | [DBA][DEV]  |
| [NULL complexities – Part 3]                                                                                            | Itzik Ben-Gan                            | 2020-02-12 | [DBA][DEV]  |
| [How to fix the “Agent XPs disabled” error]                                                                             | Nisarg Upadhyay                          | 2019-12-27 | [DBA][DEV]  |
| [Number of Rows Read / Actual Rows Read warnings in Plan Explorer]                                                      | Rob Farley                               | 2016-06-02 | [DBA][DEV]  |
| [Data Compression + Backup Compression = Double Compression?]                                                           | Jess Pomfret                             | 2019-08-12 | [B][DBA]    |
| [How Many Bytes Per Character in SQL Server: a Completely Complete Guide]                                               | Solomon Rutzky                           | 2019-11-12 | [DBA][DEV]  |
| [Storage 101: Welcome to the Wonderful World of Storage]                                                                | Robert Sheldon                           | 2019-12-03 | [DBA][DEV]  |
| [How to detect and prevent unexpected growth of the TempDB database]                                                    | Ahmad Yaseen                             | 2020-01-13 | [DBA]       |
| [Understanding the SQL Server Proportional fill algorithm]                                                              | Ahmad Yaseen                             | 2016-11-22 | [DBA]       |
| [VALUES() and Long Parameter Lists]                                                                                     | Joe Celko                                | 2010-07-22 | [DBA][DEV]  |
| [Going Serverless with Azure SQL Database]                                                                              | John Miner                               | 2019-12-20 | [DBA][DEV]  |
| [SQLskills SQL101: Why are Statistics so Important?]                                                                    | Kimberly Tripp                           | 2020-01-20 | [DBA][DEV]  |
| [Configuring SQL Server Express edition as SQL witness server in Database Mirroring]                                    | Nisarg Upadhyay                          | 2020-01-20 | [DBA]       |
| [The Half Apply Query]                                                                                                  | Forrest McDaniel                         | 2020-01-20 | [DBA][DEV]  |
| [Import JSON data into SQL Server]                                                                                      | Rajendra Gupta                           | 2020-01-17 | [X]         |
| [Auditing in AWS RDS SQL Server]                                                                                        | Rajendra Gupta                           | 2020-01-20 | [DBA]       |
| [Types of SQL Server Indexes]                                                                                           | Ben Snaidero                             | 2019-12-24 | [IDX]       |
| [Use SQL Server's UNPIVOT operator to help normalize output]                                                            | Aaron Bertrand                           | 2013-07-12 | [DBA][DEV]  |
| [Prevent SSMS from seeing the server's file system]                                                                     | Randi Vertongen                          | 2019-09-02 | [DBA]       |
| [Add the ability to disable or enable a few new DMVs and DMFs introduced in SQL Server 2017]                            | Microsoft                                | 2017-11-08 | [DBA]       |
| [Actual Difference Between EXISTS(SELECT 1 …), EXISTS(SELECT * …), and EXISTS(SELECT column …)]                         | Solomon Rutzky                           | 2020-01-24 | [DBA][DEV]  |
| [Why Wait Stats Alone Are Not Enough]                                                                                   | Greg Gonzalez                            | 2020-01-24 | [DBA][DEV]  |
| [Estimating AWS RDS SQL Server costs]                                                                                   | Rajendra Gupta                           | 2020-01-23 | [DEV]       |
| [SQL Server Performance Tuning Using Wait Statistics: A Beginner’s Guide]                                               | Jonathan Kehayias, Erin Stellato         | 2014-04-01 | [DBA][DEV]  |
| [sys.xp_delete_files and ‘allow filesystem enumeration’: two new undocumented items in SQL Server 2019]                 | Solomon Rutzky                           | 2020-01-26 | [DBA][DEV]  |
| [Why Database Monitoring Tools Are So Hard to Interpret]                                                                | Brent Ozar                               | 2020-01-27 | [DBA]       |
| [Extended Events Misperceptions: Profiler Is Easier]                                                                    | Grant Fritchey                           | 2020-01-20 | [DBA][DEV]  |
| [Extended Events Misperceptions: Profiler Is Easier, Part 2]                                                            | Grant Fritchey                           | 2020-01-27 | [DBA][DEV]  |
| [Automate SFTP File Transfer with SQL Server Agent and WinSCP]                                                          | Joe Gavin                                | 2020-01-16 | [DBA][DEV]  |
| [Running Database Console Commands (DBCCs) on Azure SQL Database]                                                       | Marcin Policht                           | 2020-01-20 | [AZ]        |
| [How to Remove Times from Dates in SQL Server]                                                                          | Brent Ozar                               | 2020-01-29 | [DBA][DEV]  |
| [Export/Import Data using BCP - SQL Server on Linux]                                                                    | Carlos Robles                            | 2020-01-30 | [DBA][DEV]  |
| [Prevent SQL Server Blocking using Lock_Timeout]                                                                        | Bhavesh Patel                            | 2020-01-07 | [DBA][DEV]  |
| [Bin Packing Problems: The SQL]                                                                                         | Joe Celko                                | 2012-03-22 | [DBA][DEV]  |
| [Causation, Correlation and Crackpots]                                                                                  | Joe Celko                                | 2009-09-15 | [DBA][DEV]  |
| [What Events are in a Trace?]                                                                                           | Erin Stellato                            | 2020-01-23 | [DBA]       |
| [What Are Soft Deletes, and How Are They Implemented?]                                                                  | Brent Ozar                               | 2020-02-04 | [DBA][DEV]  |
| [Why You Should Switch in Staging Tables Instead of Renaming Them (Dear SQL DBA Episode 26)]                            | Kendra Little                            | 2017-01-19 | [DBA][DEV]  |
| [Changing a column from int to bigint, without downtime]                                                                | Andy Mallon                              | 2019-12-11 | [DBA][DEV]  |
| [I hate sp_estimate_data_compression_savings]                                                                           | Andy Mallon                              | 2019-12-17 | [DBA][DEV]  |
| [Testing as another user…without their password -  impersonate the other user]                                          | Andy Mallon                              | 2019-12-18 | [DBA][DEV]  |
| [How does a database RESTORE affect plan cache?]                                                                        | Andy Mallon                              | 2019-10-24 | [DBA]       |
| [Recovery of database is 0% complete (approximately 1000000 seconds remain)]                                            | Andy Mallon                              | 2019-10-12 | [DBA]       |
| [Code to purge data based on creation date]                                                                             | Andy Mallon                              | 2019-04-04 | [DBA]       |
| [Blocking with OBJECT_NAME()]                                                                                           | Andy Mallon                              | 2019-12-24 | [DBA]       |
| [Performance Myths: The query result cache]                                                                             | Andy Mallon                              | 2018-07-23 | [DBA][DEV]  |
| [Fun with (columnstore) compression on a very large table – part 3]                                                     | Aaron Bertrand                           | 2020-02-03 | [DBA][DEV]  |
| [Indexing basics]                                                                                                       | Daniel Hutmacher                         | 2013-02-19 | [IDX]       |
| [Working with covering indexes]                                                                                         | Daniel Hutmacher                         | 2013-02-19 | [IDX]       |
| [Using Erik Darling’s sp_pressure_detector to resolve CPU issues]                                                       | Jeff Iannucci                            | 2020-01-28 | [DBA][DEV]  |
| [The Accidental DBA (Day 16 of 30): General Security]                                                                   | Jonathan Kehayias                        | 2013-01-16 | [DBA][SEC]  |
| [Securing Data in SQL Server]                                                                                           | Jonathan Kehayias                        | 2020-01-27 | [DBA][SEC]  |
| [Performance Testing SQL 2008's Transparent Data Encryption]                                                            | Rob Garrison                             | 2009-04-20 | [DBA]       |
| [Common SQL Server Security Issues and Solutions]                                                                       | Paul Randal                              | 2016-10-04 | [DBA][SEC]  |
| [Chaos Engineering and SQL Server]                                                                                      | Andrew Pruski                            | 2020-01-29 | [DBA]       |
| [Different methods to attach SQL Server MDF files]                                                                      | Nisarg Upadhyay                          | 2020-02-07 | [DBA]       |
| [Learn SQL: How to Write a Complex SELECT Query]                                                                        | Emil Drkusic                             | 2020-02-04 | [DBA][DEV]  |
| [Filling In Missing Values Using the T-SQL Window Frame]                                                                | Dwain Camps                              | 2014-09-18 | [DBA][DEV]  |
| [Select * in a view]                                                                                                    | Reitse Eskens                            | 2020-02-20 | [DBA][DEV]  |
| [T-SQL TUESDAY #123: Aggregates of Aggregates using Windowing Functions]                                                | James Mcgillivray                        | 2020-02-20 | [DBA][DEV]  |
| [SQL Server Statistics: Explained]                                                                                      | Krishna Golla                            | 2012-09-04 | [DBA][DEV]  |
| [How to Pass a List of Values Into a Stored Procedure]                                                                  | Brent Ozar                               | 2020-02-13 | [DBA][DEV]  |
| [What's the difference between a temp table and table variable in SQL Server?]                                          | Paul White                               | 2019-05-04 | [DBA][DEV]  |
| [Be Mindful of SQL Server Tempdb Use (aka Tempdb Parasites!)]                                                           | Jason Hall                               | 2020-01-28 | [DBA][DEV]  |
| [Robyn Page’s SQL Server Cursor Workbench (Quirky Update)]                                                              | Robyn Page                               | 2007-01-24 | [DBA][DEV]  |
| [Solving the Running Total and Ordinal Rank Problems (Rewritten) (Quirky Update)]                                       | Jeff Moden                               | 2012-01-27 | [DBA][DEV]  |
| [Running totals in “Denali” CTP3 (Quirky Update)]                                                                       | Wayne Sheffield                          | 2011-08-23 | [DBA][DEV]  |
| [WHERE GETDATE() BETWEEN StartDate AND EndDate Is Hard to Tune.]                                                        | Brent Ozar                               | 2020-02-18 | [DBA][DEV]  |
| [WHERE GETDATE() BETWEEN StartDate AND COALESCE(CancelDate, EndDate) Is Even Harder to Tune.]                           | Brent Ozar                               | 2020-02-19 | [DBA][DEV]  |
| [How to solve the SQL Identity Crisis in SQL Server]                                                                    | Ed Pollack                               | 2017-11-14 | [DBA][DEV]  |
| [Significant SQL Server 2019 licensing changes]                                                                         | Kevin Chant                              | 2020-02-17 | [DBA]       |
| [Indexed View Maintenance Is Only As Bad As Your Indexes]                                                               | Erik Darling                             | 2020-02-19 | [DBA][DEV]  |
| [Why Design Impacts Performance on Microsoft SQL Server]                                                                | Kevin Kline                              | 2020-01-29 | [DBA][DEV]  |
| [Apply versus Nested Loops Join]                                                                                        | Paul White                               | 2019-06-09 | [DBA][DEV]  |
| [Inside the Optimizer: Constructing a Plan - Part 1]                                                                    | Paul White                               | 2010-07-29 | [DBA][DEV]  |
| [Inside the Optimizer: Constructing a Plan - Part 2]                                                                    | Paul White                               | 2010-07-29 | [DBA][DEV]  |
| [Inside the Optimizer: Constructing a Plan - Part 3]                                                                    | Paul White                               | 2010-07-31 | [DBA][DEV]  |
| [Inside the Optimizer: Constructing a Plan - Part 4]                                                                    | Paul White                               | 2010-07-31 | [DBA][DEV]  |
| [Tips for dealing with large SQL Server scripts]                                                                        | Kevin Chant                              | 2020-02-24 | [DBA][DEV]  |
| [Database Normalization in SQL with Examples]                                                                           | Gouri Shankar                            | 2020-02-18 | [DBA][DEV]  |
| [Why SQL Server May Not Parallelize a Query]                                                                            | SolarWinds                               | 2015-10-30 | [DBA][DEV]  |
| [Parallelism in SQL Server Execution Plan]                                                                              | Ahmad Yaseen                             | 2018-03-30 | [DBA][DEV]  |
| [An XEvent a Day (26 of 31) – Configuring Session Options]                                                              | Jonathan Kehayias                        | 2010-12-26 | [XE]        |
| [Azure SQL Managed Instance Performance Considerations]                                                                 | Tim Radney                               | 2020-02-26 | [AZ]        |
| [The Curious Case of… whether corruption can propagate to secondary databases]                                          | Paul Randal                              | 2020-02-26 | [COR][DBA]  |
| [Stop and Think Before You Shrink – Shrinking a SQL Server Database]                                                    | Jeff Mlakar                              | 2018-09-25 | [DBA]       |
| [How to Analyze the SQL Server Error Log]                                                                               | Jeff Mlakar                              | 2018-11-02 | [DBA]       |
| [Converting SQL Trace to Extended Events in SQL Server 2012]                                                            | Jonathan Kehayias                        | 2012-04-04 | [DBA]       |
| [What event information can I get by default from SQL Server?]                                                          | Aaron Bertrand                           | 2019-03-28 | [DBA]       |
| [Removing the default trace – Part 1]                                                                                   | Aaron Bertrand                           | 2020-03-02 | [DBA]       |
| [Removing the default trace – Part 2]                                                                                   | Aaron Bertrand                           | 2020-03-02 | [DBA]       |
| [Removing the default trace – Part 3]                                                                                   | Aaron Bertrand                           | 2020-03-02 | [DBA]       |
| [Keeping DRY in SQL Server with Scalar User Defined Functions – Part 1]                                                 | Adrian Hills                             | 2020-02-20 | [DBA][DEV]  |
| [Different Ways to Monitor SQL Server AlwaysOn Availability Groups]                                                     | Nisarg Upadhyay                          | 2020-02-21 | [DBA]       |
| [SQL Server internals: Is Order of Column in the table important?]                                                      | Ronen Ariely                             | 2018-08-11 | [DBA][DEV]  |
| [Code: Order of columns in table might impact the size of the table/database and even related to errors]                | Ronen Ariely                             | 2019-10-13 | [DBA][DEV]  |
| [SQL Server Internals: Getting the data of deleted column]                                                              | Ronen Ariely                             | 2018-11-28 | [DBA][DEV]  |
| [Queue table issues with Availability Groups in SQL Server]                                                             | Aaron Bertrand                           | 2020-01-29 | [DBA]       |
| [Transact-SQL: openjson hierarchy solution]                                                                             | Ronen Ariely                             | 2019-09-29 | [DBA][DEV]  |
| [CREATE DLL TRIGGER ON CREATE_LOGIN to configure default parameters for any new LOGIN]                                  | Ronen Ariely                             | 2019-10-12 | [DBA][DEV]  |
| [Code: Order of columns in table might impact the size of the table/database and even related to errors]                | Ronen Ariely                             | 2019-10-13 | [DBA][DEV]  |
| [SQL Server Internals: Getting the data of deleted column]                                                              | Ronen Ariely                             | 2018-08-11 | [DBA][DEV]  |
| [SQL varchar data type deep dive]                                                                                       | Gauri Mahajan                            | 2019-05-29 | [DBA][DEV]  |
| [What is the datatype SQL_VARIANT]                                                                                      | Kenneth Fisher                           | 2020-04-16 | [DBA][DEV]  |
| [An Introduction to Asynchronous Processing with Service Broker]                                                        | Jonathan Kehayias                        | 2014-03-18 | [DBA][DEV]  |
| [Detecting and Alerting on SQL Server Agent Missed Jobs]                                                                | Ed Pollack                               | 2019-02-21 | [DBA][J]    |
| [Execute multiple jobs Synchronously from in a main job]                                                                | Ronen Ariely                             | 2020-04-11 | [J]         |
| [Why Ordering Isn’t Guaranteed Without an ORDER BY]                                                                     | Brent Ozar                               | 2020-04-22 | [DBA][DEV]  |
| [How to Attach a SQL Server Database without a Transaction Log and with Open Transactions]                              | Daniel Farina                            | 2020-04-29 | [COR]       |
| [SQL 2016 - It Just Runs Faster: Indirect Checkpoint Default]                                                           | Ryan Stonecipher, Peter Byrne, Bob Dorr  | 2016-04-12 | [DBA][CHP]  |
| [Indirect Checkpoint and tempdb – the good, the bad and the non-yielding scheduler]                                     | Parikshit Savjani                        | 2017-06-26 | [DBA][CHP]  |
| [How do checkpoints work and what gets logged]                                                                          | Paul Randal                              | 2009-09-27 | [DBA][CHP]  |
| [Inside the Storage Engine: What’s in the buffer pool?]                                                                 | Paul Randal                              | 2008-08-26 | [DBA]       |  
| [What does checkpoint do for tempdb?]                                                                                   | Paul Randal                              | 2009-10-07 | [DBA][CHP]  |
| [Performance issues from wasted buffer pool memory]                                                                     | Paul Randal                              | 2011-06-01 | [DBA]       |
| [How It Works: When is the FlushCache message added to SQL Server Error Log?]                                           | Bob Dorr                                 | 2012-01-06 | [DBA]       |
| [Negative identity values don’t suck]                                                                                   | Randolph West                            | 2020-05-06 | [DBA][DEV]  |
| [How SQL Server stores data types: integers and decimals]                                                               | Randolph West                            | 2020-05-13 | [DBA][DEV]  |
| [How SQL Server stores data types: DATETIME, DATE, TIME, and DATETIME2]                                                 | Randolph West                            | 2020-04-22 | [DBA][DEV]  |
| [Cross Database Transactions on One Server]                                                                             | Michael J Swart                          | 2020-05-15 | [DBA][DEV]  |
| [Your Views Aren’t The Problem. Your Code Is.]                                                                          | Brent Ozar                               | 2020-05-06 | [DBA][DEV]  |
| [Can I Offload DBCC CHECKDB To Another Server?]                                                                         | Brent Ozar                               | 2020-05-19 | [DBA]       |
| [Negative (-) is an operator and will affect the order of operations.]                                                  | Kenneth Fisher                           | 2020-05-18 | [DBA][DEV]  |
| ["0 to 60" : Switching to indirect checkpoints]                                                                         | Aaron Bertrand                           | 2020-05-01 | [DBA][CHP]  |
| [Parallelism Can Make Queries Perform Worse.]                                                                           | Brent Ozar                               | 2020-05-20 | [DBA][DEV]  |
| [A SQL Server DBA myth a day: (15/30) checkpoint only writes pages from committed transactions]                         | Paul Randal                              | 2010-04-15 | [DBA][CHP]  |
| [Can You Use NVARCHAR As a Universal Parameter? Almost.]                                                                | Brent Ozar                               | 2020-04-30 | [DBA][DEV]  |
| [The Learner’s Guide to SQL Server Performance Triage]                                                                  | Kendra Little                            | 2020-03-19 | [DBA]       |
| [Learner’s Guide to SQL Server Query Tuning]                                                                            | Kendra Little                            | 2020-05-01 | [DBA][DEV]  |
| [How to Get Better Estimates for Modification Queries]                                                                  | Brent Ozar                               | 2020-04-27 | [DBA][DEV]  |
| [SSMS: Prevent Copy and Paste of Text in “Messages” tab (Cruel Joke #2)]                                                | Solomon Rutzky                           | 2020-05-22 | [DBA][DEV]  |
| [Compare the Best SQL Server Performance Monitoring Tools]                                                              | SentryOne                                | 2020-01-01 | [DBA][DEV]  |
| [Minimal Logging with INSERT…SELECT into Heap Tables]                                                                   | Paul White                               | 2020-05-01 | [DBA][DEV]  |
| [Minimal Logging with INSERT…SELECT into Empty Clustered Tables]                                                        | Paul White                               | 2020-05-16 | [DBA][DEV]  |
| [Minimal Logging with INSERT…SELECT and Fast Load Context]                                                              | Paul White                               | 2020-05-19 | [DBA][DEV]  |
| [Avoiding SQL Server Upgrade Performance Issues]                                                                        | Glenn Berry                              | 2020-02-05 | [DBA][DEV]  |
| [Compatibility Levels and Cardinality Estimation Primer]                                                                | Glenn Berry                              | 2020-01-29 | [DBA][DEV]  |
| [An approach to index tuning – Part 1]                                                                                  | Erin Stellato                            | 2020-03-26 | [DBA][DEV]  |
| [An approach to index tuning – Part 2]                                                                                  | Erin Stellato                            | 2020-04-13 | [DBA][DEV]  |
| [Moving A Database to New Storage With No Downtime]                                                                     | Bob Pusateri                             | 2013-03-12 | [DBA]       |
| [RESOURCE_GOVERNOR_IDLE in Azure]                                                                                       | Josh Darnell                             | 2020-06-15 | [AZ]        |
| [Automated Backup Tuning]                                                                                               | Nicholas Cain                            | 2012-12-13 | [B]         |
| [Optimizing Database Restores]                                                                                          | Nicholas Cain                            | 2011-09-26 | [DBA]       |
| [AVAILABILITY_REPLICA - The Deception of the Log Reuse Wait Type]                                                       | Nicholas Cain                            | 2020-05-19 | [DBA]       |
| [Changing an INT to a BIGINT with no downtime]                                                                          | Michael J Swart                          | 2020-06-19 | [DBA]       |
| [New Metadata-Only Column Changes in SQL Server 2016]                                                                   | Paul White                               | 2020-04-17 | [DBA][DEV]  |
| [Bandwidth-friendly Query Profiling for Azure SQL Database]                                                             | Greg Gonzalez                            | 2020-04-15 | [AZ][XE]    |
| [When a Columnstore Index Makes Your Query Fail]                                                                        | Brent Ozar                               | 2020-06-10 | [DBA][DEV]  |
| [Column scope and binding order in subqueries]                                                                          | Gail Shaw                                | 2019-04-23 | [DBA][DEV]  |
| [Improve SQL Server Extended Events system_health Session]                                                              | Aaron Bertrand                           | 2020-06-17 | [DBA][DEV]  |
| [Page Life Expectancy Doesn’t Mean Jack, and You Should Stop Looking At It.]                                            | Brent Ozar                               | 2020-06-17 | [DBA][DEV]  |
| [Unsupported but working versions of SQL Server on Windows Server 2019]                                                 | Randolph West                            | 2020-06-24 | [DBA][DEV]  |
| [Bad Idea Jeans: Building Big Query Plans]                                                                              | Brent Ozar                               | 2020-06-23 | [DBA][DEV]  |
| [SQL Server performance tuning – RESOURCE_SEMAPHORE waits]                                                              | Timothy Smith                            | 2020-06-16 | [DBA][DEV]  |
| [Use session_context to create a “variable” that lasts between batches.]                                                | Kenneth Fisher                           | 2020-05-26 | [DBA][DEV]  |
| [Phase out CONTEXT_INFO() in SQL Server 2016 with SESSION_CONTEXT()]                                                    | Aaron Bertrand                           | 2015-11-19 | [DBA][DEV]  |
| [How to Balance SQL Server Core Licenses Across NUMA Nodes]                                                             | Glenn Berry                              | 2020-06-25 | [DBA]       |
| [What is the Difference Between Physical Sockets, Physical Cores, and Logical Cores?]                                   | Glenn Berry                              | 2019-12-18 | [DBA]       |
| [What is the Difference Between Physical Sockets, Physical Cores, and Logical Cores?]                                   | Kevin Kline                              | 2020-06-01 | [DBA][DEV]  |
| [The 201 Buckets Problem, Part 1: Why You Still Don’t Get Accurate Estimates]                                           | Brent Ozar                               | 2020-07-07 | [DBA][DEV]  |
| [The 201 Buckets Problem, Part 2: How Bad Estimates Backfire As Your Data Grows]                                        | Brent Ozar                               | 2020-07-08 | [DBA][DEV]  |
| [Sql Server — Widely Random Query Exec Times (cxconsumer Wait/cxpacket) & Possible Remediation]                         | VIKTOR                                   | 2020-06-26 | [DBA][DEV]  |
| [How MAXDOP Really Works]                                                                                               | Paul White                               | 2020-06-07 | [DBA][DEV]  |
| [What is MaxDOP controlling?]                                                                                           | Pedro Lopes                              | 2020-07-07 | [DBA][DEV]  |
| [What If You Really DO Need to Shrink a Database?]                                                                      | Brent Ozar                               | 2020-07-14 | [DBA]       |
| [Everything I Never Wanted to Know About Collation]                                                                     | Kendra Little                            | 2020-07-16 | [DBA][DEV]  |
| [Comparing SSIS And Azure Data Factory]                                                                                 | Tim Mitchell                             | 2020-07-16 | [AZ][SSIS]  |
| [sp_Blitz for All Servers]                                                                                              | Garry Bargsley                           | 2020-07-14 | [DBA]       |
| [Where is the SQL Server Community Networking Online?]                                                                  | Brent Ozar                               | 2020-07-13 | [DBA][DEV]  |
| [Make the most out of your Azure Disks using Storage Pools]                                                             | Roberto Marras                           | 2020-07-01 | [AZ][DBA]   |
| [SQL Server High Availability Solutions on Azure VMs]                                                                   | Marco Obinu                              | 2020-07-12 | [AZ][DBA]   |
| [How to Get Started with SQL Server Management Studio]                                                                  | Brent Ozar                               | 2020-07-21 | [DBA][DEV]  |
| [How should I store currency values in SQL Server?]                                                                     | Randolph West                            | 2020-06-03 | [DBA][DEV]  |
| [Read committed isolation level doesn’t guarantee much…]                                                                | Paul Randal                              | 2010-04-17 | [DBA][DEV]  |
| [Prevent Unexpected Failovers When Patching AGs]                                                                        | Josh Darnell                             | 2010-05-21 | [DBA]       |
| [Updating Statistics Causes Parameter Sniffing]                                                                         | Brent Ozar                               | 2010-06-02 | [DBA][DEV]  |
| [The Ascending Key Problem in Fact Tables– Part one: Pain!]                                                             | Thomas Kejser                            | 2011-01-01 | [DBA][DEV]  |
| [The Ascending Key Problem In Fact Tables –Part Two: Stat Job!]                                                         | Thomas Kejser                            | 2011-07-07 | [DBA][DEV]  |
| [Are Statistics Being Used for inserted and deleted tables and table variables?]                                        | Deborah Melkin                           | 2020-05-05 | [DBA][DEV]  |
| [Tackling Imperial and US Customary Measurements in Databases]                                                          | Phil Factor                              | 2020-05-06 | [DBA][DEV]  |
| [In-Memory OLTP Best Practices – Part 1]                                                                                | Jon Guerin, Daniel Taylor                | 2020-03-11 | [DBA][DEV]  |
| [In-Memory OLTP Best Practices – Part 2]                                                                                | Jon Guerin, Daniel Taylor                | 2020-05-06 | [DBA][DEV]  |
| [Things I Wished More Developers Knew About Databases]                                                                  | Jaana Dogan                              | 2020-04-21 | [DBA][DEV]  |
| [Online migrations at scale]                                                                                            | Jacqueline Xu                            | 2017-02-02 | [DBA]       |
| [The Dirty (Baker’s) Dozen of SQL Server Technical Debt]                                                                | Andy Jones                               | 2020-06-01 | [DBA][DEV]  |
| [15 SQL Server Performance Counters to Monitor In 2020]                                                                 | Allen White                              | 2020-05-05 | [DBA][DEV]  |
| [Pulling Group By Above a Join]                                                                                         | Paul White                               | 2020-05-31 | [DBA][DEV]  |
| [SQLskills SQL101: Running out of ints and bigints]                                                                     | Paul Randal                              | 2017-10-03 | [DBA][DEV]  |
| [Parallel Execution Plans – Branches and Threads]                                                                       | Paul White                               | 2013-10-07 | [DBA][DEV]  |
| [Understanding and Using Parallelism in SQL Server]                                                                     | Paul White                               | 2011-03-03 | [DBA][DEV]  |
| [Top Asked Availability Group Questions… and Maybe Some Helpful Tidbits as Answers]                                     | Sean Gallardy                            | 2020-06-16 | [DBA]       |
| [The 201 Buckets Problem, Part 1: Why You Still Don’t Get Accurate Estimates]                                           | Brent Ozar                               | 2020-07-07 | [DBA][DEV]  |
| [The 201 Buckets Problem, Part 2: How Bad Estimates Backfire As Your Data Grows]                                        | Brent Ozar                               | 2020-07-08 | [DBA][DEV]  |
| [Encrypting SQL Server Database Backups]                                                                                | David Fowler                             | 2018-04-04 | [DBA]       |
| [Using Track Causality to Understand Query Execution]                                                                   | Erin Stellato                            | 2019-01-04 | [DBA][DEV]  |
| [Understanding SQL Server Backup Types]                                                                                 | Prashanth Jayaram                        | 2018-04-19 | [B][DBA]    |
| [Scripting the Description of Database Tables Using Extended Properties]                                                | Phil Factor                              | 2020-03-03 | [DBA][DEV]  |
| [The Table Variable in SQL Server]                                                                                      | Esat Erkec                               | 2019-12-03 | [DBA][DEV]  |
| [Multiple Plans for an "Identical" Query]                                                                               | Aaron Bertrand                           | 2014-11-20 | [DBA][DEV]  |
| [Another argument for stored procedures versus ORM versus Add Hoc Queries]                                              | Aaron Bertrand                           | 2013-05-17 | [DBA][DEV]  |
| [Bad habits to kick : avoiding the schema prefix]                                                                       | Aaron Bertrand                           | 2019-09-12 | [DBA][DEV]  |
| [How not to call Hekaton natively-compiled stored procedures]                                                           | Aaron Bertrand                           | 2015-06-05 | [DBA][DEV]  |
| [A One-Slide Summary of the Differences Between TDE and Always Encrypted]                                               | Brent Ozar                               | 2020-07-31 | [SEC]       |
| [Remember “Nothing Stops a Hekaton Transaction?” Yeah, About That.]                                                     | Brent Ozar                               | 2020-07-29 | [DBA][DEV]  |
| [Finding & Downloading Required SQL Server Updates]                                                                     | Andy Levy                                | 2020-07-21 | [DBA]       |
| [SQLskills SQL101: Why do some wait types need to be ignored?]                                                          | Paul Randal                              | 2018-05-23 | [DBA][DEV]  |
| [What is the SOS_WORK_DISPATCHER Wait Type? (Or how to work with Call Stacks in SQL Server)]                            | Joe Obbish                               | 2018-09-27 | [DBA][DEV]  |
| [SQL Server 2019 Aggregate Splitting]                                                                                   | Paul White                               | 2020-08-04 | [DBA][DEV]  |
| [Security Best Practice: dny and revoke permissions granted to All Users by default - HIGHLY IMPORTANT!]                | Ronen Ariely                             | 2019-10-13 | [DBA][SEC]  |
| [Execute multiple jobs Synchronously from in a main job]                                                                | Ronen Ariely                             | 2020-04-11 | [DBA][DEV]  |
| [The Trillion Row Table]                                                                                                | Joe Obbish                               | 2020-08-12 | [BENCH]     |
| [Temporal Tables and Table Partitioning: Not If You Like Switching Partitions]                                          | Erik Darlling                            | 2020-03-03 | [DBA][DEV] |
| [Long Running Query on Read-Only Replica that takes moments on the Primary]                                             | Sean Gallardy,Joe Obbish                 | 2019-09-05 | [DBA][DEV] |
| [Date Tables are Great for Users, but Not So Great for Performance]                                                     | Brent Ozar                               | 2020-08-05 | [DBA][DEV]  |
| [Should I install SSMS on a server running SQL Server?]                                                                 | Andy Mallon                              | 2020-04-14 | [DBA][DEV]  |
| [Finding a table name from a page ID]                                                                                   | Paul Randal                              | 2014-09-25 | [DBA][DEV]  |
| [Finding Distinct Values Quickly]                                                                                       | Paul White                               | 2020-04-17 | [DBA][DEV]  |
| [Can You Fail To Spill To tempdb?]                                                                                      | Josh Darnell                             | 2019-07-17 | [DBA][DEV]  |
| [Migrating SQL workloads to Microsoft Azure: Databases Trip to Azure SQL Database]                                      | Ahmad Yaseen                             | 2020-08-03 | [AZ][DBA]   |
| [How It Works: Bob Dorr's SQL Server I/O Presentation]                                                                  | Bob Dorr                                 | 2010-03-24 | [DBA][DEV]  |
| [Who does SQL Server run xp_cmdshell command as?]                                                                       | Steve Stedman                            | 2020-04-14 | [DBA][DEV]  |
| [Transaction Modes in SQL Server]                                                                                       | Kevin Feasel                             | 2020-08-10 | [DBA][DEV]  |
| [Working Effectively with Legacy SQL]                                                                                   | Kevin Feasel                             | 2015-03-15 | [DBA][DEV]  |
| [A SQL Server DBA myth a day: (26/30) nested transactions are real]                                                     | Paul Randal                              | 2010-04-26 | [DBA][DEV]  |
| [dbatools multithreading commands with PoshRSJob module]                                                                | Kin                                      | 2019-01-04 | [DBA][PS]   |
| [SQL Server Debugging with WinDbg – an Introduction]                                                                    | Klaus Aschenbrenner                      | 2014-05-05 | [DBA][DEV]  |
| [Looking deeper into SQL Server using Minidumps]                                                                        | Thomas Kejser                            | 2009-09-11 | [DBA][DEV]  |
| [Anatomy of a spool operators in SQL Server execution plans]                                                            | Hugo Kornelis                            | 2020-01-01 | [DBA][DEV]  |
| [CAST v/s CONVERT – Is there a difference as far as SQL Server is concerned? Which is better?]                          | Nakul Vachhrajani                        | 2011-07-18 | [DBA][DEV]  |
| [#BackToBasics: CAST vs. CONVERT]                                                                                       | Aaron Bertrand                           | 2016-11-02 | [DBA][DEV]  |
| [Productivity Hacks: Migrate in Minutes to the Most Current Version of SQL Server]                                      | Chris Lumnah                             | 2020-07-29 | [DBA]       |
| [Database alias in Microsoft SQL Server]                                                                                | Bohumír Kubík                            | 2011-01-11 | [DBA][DEV]  |
| [The Curious Case of… the 8060-byte row size limit]                                                                     | Paul Randal                              | 2020-03-11 | [DBA][DEV]  |
| [.NET TransactionScope Considered Annoying - Default Isolation Level is Serializable]                                   | Josh Darnell                             | 2020-07-27 | [DBA][DEV]  |
| [Parameter Sniffing, Embedding, and the RECOMPILE Options]                                                              | Paul White                               | 2013-08-28 | [DBA][DEV]  |
| [Why You’re Tuning Stored Procedures Wrong (the Problem with Local Variables)]                                          | Kendra Little                            | 2020-05-06 | [DBA][DEV]  |
| [Yet Another Post About Local Variables]                                                                                | Erik Darlling                            | 2020-03-31 | [DBA][DEV]  |
| [Cleaning up Backups from Azure Blob Storage]                                                                           | Niko Neugebauer                          | 2020-03-30 | [AZ][B]     |
| [Temporary Table Caching Explained]                                                                                     | Paul White                               | 2012-08-17 | [DBA][DEV]  |
| [SQL Server Temporary Object Caching]                                                                                   | Paul White                               | 2017-05-02 | [DBA][DEV]  |
| [Dynamic Data Unmasking]                                                                                                | Joe Obbish                               | 2017-08-24 | [DBA][DEV]  |
| [3 Ways to Run DBCC CHECKDB Faster]                                                                                     | Brent Ozar                               | 2020-08-27 | [DBA][DEV]  |
| [Back Up SQL Server 43%-67% Faster by Writing to Multiple Files]                                                        | Brent Ozar                               | 2020-08-23 | [DBA][DEV]  |
| [Bad Habits to Kick : Using SELECT * / omitting the column list]                                                        | Aaron Bertrand                           | 2009-10-10 | [DBA][DEV]  |
| [All The Problems With Select *]                                                                                        | Erik Darlling                            | 2019-12-10 | [DBA][DEV]  |
| [When Select * Doesn’t Matter]                                                                                          | Erik Darlling                            | 2019-11-18 | [DBA][DEV]  |
| [HT Waits – Explained and Animated]                                                                                     | Forrest McDaniel                         | 2020-08-12 | [DBA][DEV]  |
| [SQL Server 100% Online Deployments]                                                                                    | Michael J Swart                          | 2018-01-05 | [DBA]       |
| [When Measuring Timespans, try DATEADD instead of DATEDIFF]                                                             | Michael J Swart                          | 2017-12-20 | [DBA][DEV]  |
| [The Curious Case of… setting up a server for DBCC CHECKDB]                                                             | Paul Randal                              | 2020-08-24 | [DBA]       |
| [When should a primary key be declared non-clustered?]                                                                  | Paul White                               | 2012-12-01 | [IDX]       |
| [Guid vs INT - Which is better as a primary key?]                                                                       | Sandeep Kumar M                          | 2011-01-05 | [DBA][DEV]  |
| [Control SQL Jobs based on HADR Role – Taking it to the Next Level]                                                     | Eitan Blumin                             | 2020-05-26 | [DBA][J]    |
| [SQL Friday #16: Eitan Blumin on “How to HADR Your SQL Jobs”]                                                           | Eitan Blumin                             | 2020-07-31 | [DBA][J]    |
| [Choosing the Correct Azure VM Size for Your Workload]                                                                  | Eric Smith                               | 2020-09-09 | [AZ][DBA]   |
| [Table Partitioning in SQL Server – The Basics]                                                                         | Cathrine Wilhelmsen                      | 2015-04-12 | [AZ][DBA]   |
| [Table Partitioning in SQL Server – Partition Switching]                                                                | Cathrine Wilhelmsen                      | 2015-04-19 | [AZ][DBA]   |
| [TempDB in SQL Server]                                                                                                  | SentryOne                                | 2020-09-15 | [DBA]       |
| [SQL Server’s Cost Threshold for Parallelism]                                                                           | Kendra Little                            | 2014-11-20 | [DBA][DEV]  |
| [How many CPUs is my parallel query using in SQL Server?]                                                               | Kendra Little                            | 2014-05-04 | [DBA][DEV]  |
| [Protecting your data against unauthorised reads on SQL Server]                                                         | Monin                                    | 2020-06-24 | [SEC]       |
| [SET IMPLICIT_TRANSACTIONS ON Is One Hell of a Bad Idea]                                                                | Brent Ozar                               | 2019-05-06 | [DBA][DEV]  |
| [Tempdb: The Ghost Of Version Store]                                                                                    | Stijn Wynants                            | 2015-11-09 | [DBA][DEV]  |
| [When Tempdb Becomes Permanentdb (In-memory tempdb metadata and Resource governor problems)]                            | Glenn Boonen                             | 2020-05-07 | [DBA][DEV]  |
| [A SQL Server DBA myth a day: (26/30) nested transactions are real]                                                     | Paul Randal                              | 2010-04-26 | [DBA][DEV]  |
| [The Best Medium-Hard Data Analyst SQL Interview Questions]                                                             | Zachary Thomas                           | 2020-01-01 | [DBA][DEV]  |
| [Starting SQL: Why Not Make Everything Dynamic?]                                                                        | Eric Darling                             | 2020-09-28 | [DBA][DEV]  |
| [dbatools multithreading commands]                                                                                      | Kin                                      | 2019-01-04 | [PS]        |
| [Preventing Brute Force Attacks in SQL Server]                                                                          | Raul Gonzalez                            | 2020-01-01 | [SEC]       |
| [Asynchronous T-SQL Execution Without Service Broker]                                                                   | Oleg Vorkunov                            | 2008-09-15 | [CLR]       |
| [Using hash values in SSIS to determine when to insert or update rows]                                                  | Koen Verbeeck                            | 2019-10-15 | [SSIS]      |
| [Capturing Queries Can Be A Pain]                                                                                       | Grant Fritchey                           | 2020-08-03 | [XE]        |
| [Building full-text indexes using the Sphinx search engine]                                                             | Hadi Fadlallah                           | 2020-08-04 | [DBA][DEV]  |
| [Starting SQL: Measuring A Query]                                                                                       | Eric Darling                             | 2020-09-28 | [DBA][DEV]  |
| [When to use SET vs SELECT when assigning values to variables in SQL Server]                                            | Atif Shehzad                             | 2009-11-25 | [DBA][DEV]  |
| [What is the difference between SET and SELECT when assigning values to variables, in T-SQL?]                           | Narayana Vyas Kondreddi                  | 2005-10-29 | [DBA][DEV]  |
| [CHECKDB From Every Angle: How long will CHECKDB take to run?]                                                          | Paul Randal                              | 2007-11-15 | [DBA]       |
| [CHECKDB From Every Angle: Consistency Checking Options for a VLDB]                                                     | Paul Randal                              | 2007-11-19 | [DBA]       |
| [Minimizing the impact of DBCC CHECKDB : DOs and DON'Ts]                                                                | Aaron Bertrand                           | 2012-11-29 | [DBA]       |
| [A faster CHECKDB – Part II]                                                                                            | Bob Ward                                 | 2012-02-23 | [DBA]       |
| [A faster CHECKDB – Part III]                                                                                           | Bob Dorr                                 | 2014-11-10 | [DBA]       |
| [A faster CHECKDB – Part III]                                                                                           | Bob Dorr                                 | 2015-01-26 | [DBA]       |
| [A faster CHECKDB – Part IV (SQL CLR UDTs)]                                                                             | Bob Dorr                                 | 2015-01-26 | [DBA]       |
| [Minimize performance impact of SQL Server DBCC CHECKDB]                                                                | Robert Pearl                             | 2011-06-02 | [DBA]       |
| [Starting SQL: A Little More Fun With Logging Dynamic SQL]                                                              | Eric Darling                             | 2020-10-01 | [DBA][DEV]  |
| [Allocation Order Scans]                                                                                                | Paul White                               | 2015-01-23 | [DBA][DEV]  |
| [Parameter Sniffing in SQL Server 2019: Air_Quote_Actual Plans]                                                         | Brent Ozar                               | 2020-05-26 | [DBA][DEV]  |
| [Guide For Set Up Of Telegraf For Monitoring Sql Server Xplat]                                                          | Tracy Boggiano                           | 2018-02-24 | [DBA]       |
| [Azure Table Storage Tips for the RDBMS Developer]                                                                      | Adrian Hills                             | 2020-10-21 | [AZ]        |
| [sql_handle and the SQL Server batch text hash]                                                                         | Paul White                               | 2020-10-11 | [DBA][DEV]  |
| [Navigating DBCC CHECKDB for VLDB]                                                                                      | Aaron Bertrand                           | 2020-11-05 | [DBA]       |
| [Hidden Formatting Troubles with STR() (SQL Spackle)]                                                                   | Jeff Moden                               | 2019-04-26 | [DBA][DEV]  |
| [The What, Why, When, and How of Incremental Loads]                                                                     | Tim Mitchell                             | 2020-07-23 | [DBA][DEV]  |
| [How Do I Know If My Query Is Good Enough for Production?]                                                              | Brent Ozar                               | 2020-08-12 | [DBA][DEV]  |
| [How to Find Out Whose Queries are Using The Most CPU]                                                                  | Brent Ozar                               | 2020-08-10 | [DBA][DEV]  |
| [Limitations of SQL Server Native Backup and Restore in Amazon RDS]                                                     | Sadequl Hussain                          | 2017-08-23 | [AMZ][B]    |
| [SQL Server Native Backup and Restore in Amazon RDS]                                                                    | Sadequl Hussain                          | 2017-08-18 | [AMZ][B]    |
| [What Is the SQL Server CEIP Service (telemetry)?]                                                                      | Brent Ozar                               | 2020-10-07 | [DBA]       |
| [Maximum Simultaneous User Connections]                                                                                 | Michael J Swart                          | 2020-10-16 | [DBA]       |
| [Find Database Connection Leaks in Your Application]                                                                    | Michael J Swart                          | 2017-07-07 | [DBA][DEV]  |
| [How to Troubleshoot THREADPOOL Waits and Deadlocked Schedulers]                                                        | Eitan Blumin                             | 2020-10-05 | [DBA][DEV]  |
| [Prevent Lock Escalation On Indexed Views]                                                                              | Thomas Costers                           | 2019-10-30 | [DBA][DEV]  |
| [Concatenating Strings in SQL Server]                                                                                   | Guy Glantser                             | 2020-11-10 | [DBA][DEV]  |
| [Why Full Text’s CONTAINS Queries Are So Slow]                                                                          | Brent Ozar                               | 2020-11-07 | [DBA][DEV]  |
| [Migrating SSIS to Azure – an Overview]                                                                                 | Koen Verbeeck                            | 2020-11-03 | [AZ][MG]    |
| [Why Full Text’s CONTAINS Queries Are So Slow]                                                                          | Brent Ozar                               | 2020-11-12 | [DBA][DEV]  |
| [A Parameterization Puzzle With TOP: Part 1]                                                                            | Eric Darling                             | 2020-10-21 | [DBA][DEV]  |
| [A Parameterization Puzzle With TOP: Part 2]                                                                            | Eric Darling                             | 2020-10-22 | [DBA][DEV]  |
| [T-SQL: Get The Text Between Two Delimiters]                                                                            | Eric Darling                             | 2020-10-22 | [DBA][DEV]  |
| [Explore dynamic management views for monitoring SQL Server Always On Availability Groups]                              | Rajendra Gupta                           | 2020-11-16 | [DBA]       |
| [Deploy SQLWATCH to SQL Server using GitHub Actions]                                                                    | Kevin Chant                              | 2020-11-17 | [DBA]       |
| [SQL Server table hints – WITH (NOLOCK) best practices]                                                                 | Ahmad Yaseen                             | 2018-02-24 | [DBA][DEV]  |
| [Memory-Optimized TempDB Metadata in SQL Server 2019]                                                                   | Aaron Bertrand                           | 2020-02-14 | [DBA]       |
| [What permissions do temp stored procedures use?]                                                                       | Kenneth Fisher                           | 2019-06-19 | [DBA][DEV]  |
| [SQLskills SQL101: Should you kill that long-running transaction?]                                                      | Paul Randal                              | 2020-10-10 | [DBA][DEV]  |
| [A quick and dirty scan of a list of instances using a dynamic linked server]                                           | Kenneth Fisher                           | 2020-11-12 | [DBA]       |
| [sp_whoisactive: Analyzing Tempdb Contention]                                                                           | Adam Machanic                            | 2017-01-01 | [DBA][DEV]  |
| [How to Choose Between RCSI and Snapshot Isolation Levels]                                                              | Little Kendra                            | 2018-02-18 | [DBA][DEV]  |
| [Explore the SQL query table hint READPAST]                                                                             | Rajendra Gupta                           | 2020-11-14 | [DBA][DEV]  |
| [How Bad Statistics Cause Bad SQL Server Query Performance]                                                             | Brent Ozar                               | 2020-11-14 | [DBA][DEV]  |
| [How Scalar User-Defined Functions Slow Down Queries]                                                                   | Brent Ozar                               | 2020-11-14 | [DBA][DEV]  |
| [Could verifying your backups be costing you money?]                                                                    | Matt Robertshaw                          | 2020-01-01 | [AZ][B]     |
| [Extended Events: System_health And A Long Running Query]                                                               | Grant Fritchey                           | 2020-05-09 | [XE]        |
| [Altering an indexed view in SQL Server drops all indexes]                                                              | Little Kendra                            | 2020-03-02 | [DBA][DEV]  |
| [Deprecated and discontinued features in SQL Server]                                                                    | Randolph West                            | 2020-03-04 | [DBA][DEV]  |
| [Query Store, Plan Forcing, And Drop/create]                                                                            | Grant Fritchey                           | 2020-03-02 | [QS]        |
| [Uncommon SQL in SQL Server]                                                                                            | Shane O'Neill                            | 2020-11-20 | [DBA][DEV]  |
| [Configure SQL Server Replication between AWS RDS SQL Server and On-premises SQL Server]                                | Rajendra Gupta                           | 2020-11-12 | [AMZ]       |
| [Import data into Azure SQL database from AWS Redshift]                                                                 | Rahul Mehta                              | 2020-11-10 | [AMZ][AZ]   |
| [When You’re Troubleshooting Blocking, Look at Query #2, Too.]                                                          | Brent Ozar                               | 2020-11-19 | [DBA][DEV]  |
| [Finding the One Query to Tune in a Multi-Query Batch]                                                                  | Brent Ozar                               | 2020-11-23 | [DBA][DEV]  |
| [Recursion in SQL Explained Visually]                                                                                   | Denis Lukichev                           | 2020-11-22 | [DBA][DEV]  |
| [Viva la Famiglia! Stored procedure for created recursive family tree]                                                  | Brad Schulz                              | 2020-10-01 | [DEV]       |
| [How to Set & Get the Next ID Without Serializable Isolation]                                                           | Brent Ozar                               | 2020-11-25 | [DBA][DEV]  |
| [Discovering Three or Four Part Names in SQL Server Database Code]                                                      | Louis Davidson                           | 2019-03-08 | [DBA][DEV]  |
| [Troubleshooting RESOURCE_SEMAPHORE_QUERY_COMPILE Helper Queries]                                                       | Eric Darling                             | 2020-11-24 | [DBA][DEV]  |
| [When Do I Need to Use DESC in Indexes?]                                                                                | Brent Ozar                               | 2020-11-30 | [DBA][DEV]  |
| [Export Power BI Desktop data to SQL Server]                                                                            | Rui Romano                               | 2016-04-21 | [DBA][DEV]  |
| [Exploring errors to reveal unauthorized information]                                                                   | Fabiano Amorim                           | 2020-10-19 | [SEC]       |
| [How to run your CTE just once, and re-use the output]                                                                  | Daniel Hutmacher                         | 2020-12-01 | [DBA][DEV]  |
| [Documenting SSIS Packages using Sequence Diagrams]                                                                     | Aveek Das                                | 2020-11-25 | [SSIS]      |

[Understanding how SQL Server executes a query]:http://rusanu.com/2013/08/01/understanding-how-sql-server-executes-a-query/
[SQL Server Index Design Guide]:https://technet.microsoft.com/en-us/library/jj835095.aspx
[SQL Server 2012 Security Best Practices - Microsoft]:http://download.microsoft.com/download/8/f/a/8fabacd7-803e-40fc-adf8-355e7d218f4c/sql_server_2012_security_best_practice_whitepaper_apr2012.docx
[Help, my database is corrupt. Now what?]:http://www.sqlservercentral.com/articles/Corruption/65804/
[What to Do When DBCC CHECKDB Reports Corruption]:https://www.brentozar.com/archive/2016/05/dbcc-checkdb-reports-corruption/
[Troubleshooting SQL Server CPU Performance Issues]:http://sqlperformance.com/2013/05/io-subsystem/cpu-troubleshooting
[Knee-Jerk Performance Tuning : Incorrect Use of Temporary Tables]:http://sqlperformance.com/2016/04/t-sql-queries/knee-jerk-temporary-tables
[High Performance T-SQL using Code Patterns]:https://dwaincsql.com/2015/05/27/high-performance-t-sql-using-code-patterns/
[SQL Server Database Corruption Repair]:http://stevestedman.com/2015/08/sql-server-database-corruption-repair/
[Basic SQL Server Performance Troubleshooting For Developers]:https://www.simple-talk.com/sql/performance/basic-sql-server-performance-troubleshooting-for-developers/
[The Curse and Blessings of Dynamic SQL]:http://sommarskog.se/dynamic_sql.html
[Dynamic Search Conditions in T-SQL]:http://www.sommarskog.se/dyn-search.html
[Slow in the Application, Fast in SSMS]:http://www.sommarskog.se/query-plan-mysteries.html
[How to share data between stored procedures]:http://www.sommarskog.se/share_data.html
[Arrays and Lists in SQL Server 2008]:http://www.sommarskog.se/arrays-in-sql-2008.html
[Packaging Permissions in Stored Procedures]:http://www.sommarskog.se/grantperm.html
[Error and Transaction Handling in SQL Server Part One – Jumpstart Error Handling]:http://www.sommarskog.se/error_handling/Part1.html
[Error and Transaction Handling in SQL Server Part Two – Commands and Mechanisms]:http://www.sommarskog.se/error_handling/Part2.html
[Error and Transaction Handling in SQL Server Part Three – Implementation]:http://www.sommarskog.se/error_handling/Part3.html
[Using the Bulk-Load Tools in SQL Server]:http://www.sommarskog.se/bulkload.html
[Using Table-Valued Parameters in SQL Server and .NET]:http://www.sommarskog.se/arrays-in-sql-2008.html
[SQL Server Columnstore Articles]:http://www.nikoport.com/columnstore/
[Documentation: It Does not Suck!]:https://www.brentozar.com/archive/2013/01/documentation-it-doesnt-suck/
[The Data Loading Performance Guide]:https://msdn.microsoft.com/en-us/library/dd425070%28v=sql.100%29.aspx
[Required Testing for Installing SQL Server Cumulative Updates and Service Packs]:http://www.littlekendra.com/2016/04/28/required-testing-for-installing-sql-server-cumulative-updates-and-service-packs/
[Stop Shrinking Your Database Files. Seriously. Now.]:https://www.brentozar.com/archive/2009/08/stop-shrinking-your-database-files-seriously-now/
[How to shrink a database in 4 easy steps]:http://am2.co/2016/04/shrink-database-4-easy-steps/
[Introduction to the Index Operational Statistics Dynamic Management Function]:http://sqlmag.com/database-performance-tuning/introduction-index-operational-statistics-dynamic-management-function
[Updating Statistics in SQL Server: Maintenance Questions & Answers]:http://www.littlekendra.com/2016/04/18/updating-statistics-in-sql-server-maintenance-answers/
[Overcoming Variable Limitations in SQLCmd Mode]:http://www.sqlsoldier.com/wp/sqlserver/tsqltuesday65overcomingvariablelimitationsinsqlcmdmode
[Contents of a Run Book]:https://technet.microsoft.com/en-us/library/cc917702.aspx
[Compressed and Encrypted Backups on the Cheap]:https://bornsql.ca/2016/04/compressed-encrypted-backups-cheap/
[Curing Data-Obesity in OLTP Databases]:https://www.simple-talk.com/sql/database-administration/curing-data-obesity-in-oltp-databases/
[Understanding GRANT, DENY, and REVOKE in SQL Server]:https://www.mssqltips.com/sqlservertip/2894/understanding-grant-deny-and-revoke-in-sql-server/
[Monitor SQL Server Transaction Log File Free Space]:https://www.mssqltips.com/sqlservertip/3617/monitor-sql-server-transaction-log-file-free-space/
[Dynamically Query a 100 Million Row Table-Efficiently]:http://www.sqlservercentral.com/articles/T-SQL/121906/
[Understanding and Using Parallelism in SQL Server]:https://www.simple-talk.com/sql/learn-sql-server/understanding-and-using-parallelism-in-sql-server/
[Diagnosing and Resolving Latch Contention on SQL Server]:https://www.microsoft.com/en-us/download/details.aspx?id=26665
[Parallel Execution Plans – Branches and Threads]:http://sqlperformance.com/2013/10/sql-plan/parallel-plans-branches-threads
[Nasty Fast PERCENT_RANK]:http://www.sqlservercentral.com/articles/PERCENT_RANK/141532/
[Looking at VIEWs, Close Up]:https://www.simple-talk.com/sql/t-sql-programming/looking-at-views,-close-up/
[SQL Server 2016: It Just Runs Faster]:http://thomaslarock.com/2016/06/sql-server-2016-just-runs-faster/
[TSQL JOIN Types Poster]:http://stevestedman.com/2015/05/tsql-join-types-poster-version-4-1/
[It is Hard To Destroy Data]:http://michaeljswart.com/2015/05/its-hard-to-destroy-data/
[How to transfer logins and passwords between instances of SQL Server]:https://support.microsoft.com/en-us/kb/918992
[Finding File Growths with Extended Events]:http://nebraskasql.blogspot.ru/2016/06/finding-file-growths-with-extended.html
[Questions You Should Ask About the Databases You Manage]:https://www.brentozar.com/archive/2016/06/questions-ask-databases-manage/
[Clustered Indexes in SQL Server]:http://www.sqlhammer.com/clustered-indexes-sql-server/
[Triage Quiz: Is Your SQL Server Safe?]:https://www.brentozar.com/archive/2016/06/triage-quiz-sql-server-safe/
[Why Not Just Create Statistics?]:https://www.brentozar.com/archive/2016/07/not-just-create-statistics/
[Understanding the SQL Server NOLOCK hint]:https://www.mssqltips.com/sqlservertip/2470/understanding-the-sql-server-nolock-hint/
[Recover access to a SQL Server instance]:https://www.mssqltips.com/sqlservertip/2682/recover-access-to-a-sql-server-instance/
[SQL Server 2016 Upgrade Planning]:http://sqlmag.com/sql-server/sql-server-2016-upgrade-planning-0
[Graphs and Graph Algorithms in T-SQL]:http://www.hansolav.net/sql/graphs.html
[Episode 4: SQL Server R Services makes you a smarter T-SQL Developer]:https://blogs.msdn.microsoft.com/sqlcat/2016/07/12/sqlsweet16-episode-4-sql-server-r-services-makes-you-a-smarter-t-sql-developer/
[How to Set Max Degree of Parallelism in SQL Server]:http://www.littlekendra.com/2016/07/14/max-degree-of-parallelism-cost-threshold-for-parallelism/
[Undocumented Query Plans: Equality Comparisons]:https://www.sql.kiwi/2011/06/undocumented-query-plans-equality-comparisons.html
[Simplified Order Of Operations]:http://michaeljswart.com/2016/07/simplified-order-of-operations/
[SQL Server Statistics Basics]:https://www.simple-talk.com/sql/performance/sql-server-statistics-basics/
[Learn to Use sp_Blitz, sp_BlitzCache, sp_BlitzFirst, and sp_BlitzIndex with These Tutorial Videos]:https://www.brentozar.com/archive/2016/09/learn-use-sp_blitz-sp_blitzcache-sp_blitzfirst-sp_blitzindex-tutorial-videos/
[Where is a record really located?]:https://blogs.msdn.microsoft.com/sql_pfe_blog/2016/09/15/where-is-a-record-really-located/
[Instant File Initialization (IFI)]:http://stevestedman.com/2016/09/instant-file-initialization-ifi/
[How to Query the StackExchange Databases]:https://www.brentozar.com/archive/2014/01/how-to-query-the-stackexchange-databases/
[How to Troubleshoot Performance in SQL Server (Dear SQL DBA)]:http://www.littlekendra.com/2016/06/02/dear-sql-dba-lost-in-performance-troubleshooting/
[How to Log Activity Using sp_whoisactive in a Loop]:https://www.brentozar.com/responder/log-sp_whoisactive-to-a-table/
[Logging Activity Using sp_WhoIsActive – Take 2]:https://www.brentozar.com/archive/2016/07/logging-activity-using-sp_whoisactive-take-2/
[How To Fix Forwarded Records]:https://www.brentozar.com/archive/2016/07/fix-forwarded-records/
[Should I Automate my Windows Updates for SQL Server?]:http://www.littlekendra.com/2016/07/28/should-i-automate-my-windows-updates-for-sql-server-dear-sql-dba-episode-10/
[Finding the Right Path]:http://jasonbrimhall.info/2016/08/24/finding-the-right-path/
[#BackToBasics : An Updated "Kitchen Sink" Example]:https://blogs.sqlsentry.com/aaronbertrand/backtobasics-updated-kitchen-sink-example/
[Locking and Blocking in SQL Server]:https://www.brentozar.com/sql/locking-and-blocking-in-sql-server/
[Nested Loops Prefetching]:https://www.sql.kiwi/2013/08/sql-server-internals-nested-loops-prefetching.html
[Performance tuning backup and restore operations]:http://www.sqlhammer.com/performance-tuning-backup-restore-operations/
[Execution Plan Analysis: The Mystery Work Table]:https://www.sql.kiwi/2013/03/execution-plan-analysis-the-mystery-work-table.html
[How to move data between File Groups in SQL Server]:http://www.sqlpassion.at/archive/2016/09/26/how-to-move-data-between-file-groups-in-sql-server/
[Optimizing Your Query Plans with the SQL Server 2014 Cardinality Estimator]:https://docs.microsoft.com/en-us/previous-versions/dn673537(v=msdn.10)?redirectedfrom=MSDN
[Parallelism in SQL Server Query Tuning]:http://sqlmag.com/sql-server/parallelism-sql-server-query-tuning
[What You Need to Know about the Batch Mode Window Aggregate Operator in SQL Server 2016: Part 1]:http://sqlmag.com/sql-server/what-you-need-know-about-batch-mode-window-aggregate-operator-sql-server-2016-part-1
[What To Do If sp_BlitzFirst Warns About High Compilations]:https://www.brentozar.com/archive/2016/09/what-to-do-if-sp_blitzfirst-warns-about-high-compilations/
[Questions You Should Be Asking About Your Backups]:https://www.brentozar.com/archive/2016/10/questions-asking-backups/
[Evolutionary Database Design]:http://martinfowler.com/articles/evodb.html
[Implementing a custom sort]:https://sqlperformance.com/2016/10/sql-plan/implementing-custom-sort
[Deletes that Split Pages and Forwarded Ghosts]:https://www.sql.kiwi/2012/08/deletes-that-split-pages-and-forwarded-ghosts.html
[Query Optimizer Deep Dive - Part 1]:https://www.sql.kiwi/2012/04/query-optimizer-deep-dive-part-1.html
[Query Optimizer Deep Dive - Part 2]:https://www.sql.kiwi/2012/04/query-optimizer-deep-dive-part-2.html
[Query Optimizer Deep Dive - Part 3]:https://www.sql.kiwi/2012/04/query-optimizer-deep-dive-part-3.html
[Query Optimizer Deep Dive - Part 4]:https://www.sql.kiwi/2012/05/query-optimizer-deep-dive-part-4.html
[Should You Rebuild or Reorganize Indexes on Large Tables?]:https://www.littlekendra.com/2016/10/13/should-you-rebuild-or-reorganize-indexes-on-large-tables-dear-sql-dba-episode-19/
[Retrieving SQL Server Query Execution Plans]:https://www.simple-talk.com/sql/database-administration/retrieving-sql-server-query-execution-plans/ 
[Introduction to Latches in SQL Server]:http://www.sqlpassion.at/archive/2014/06/23/introduction-to-latches-in-sql-server/
[Latch Coupling in SQL Server]:https://www.sqlpassion.at/archive/2016/10/24/latch-coupling-in-sql-server/
[Partitioned Views? A How-To Guide]:https://www.brentozar.com/archive/2016/09/partitioned-views-guide/
[How to Choose Between RCSI and Snapshot Isolation Levels]:https://www.littlekendra.com/2016/02/18/how-to-choose-rcsi-snapshot-isolation-levels/
[TroubleShooting SQL Server Memory Consumption]:http://www.sql-server-performance.com/2016/trouble-shooting-sql-server-ra-memory-consumption/
[Time Series Algorithms in SQL Server]:http://www.sql-server-performance.com/2015/time-series-algorithms-sql-server/
[Heap Tables in SQL Server]:http://www.sqlpassion.at/archive/2015/10/19/heap-tables-in-sql-server/
[Internals of the Seven SQL Server Sorts – Part 1]:https://sqlperformance.com/2015/04/sql-plan/internals-of-the-seven-sql-server-sorts-part-1
[Internals of the Seven SQL Server Sorts – Part 2]:https://sqlperformance.com/2015/05/sql-plan/internals-of-the-seven-sql-server-sorts-part-2
[The 9 Letters That Get DBAs Fired]:https://www.brentozar.com/archive/2011/12/letters-that-get-dbas-fired/
[Restarting SQL Server – always a good idea?]:https://www.sqlpassion.at/archive/2016/08/08/restarting-sql-server-always-a-good-idea/
[Don’t believe everything you read: Reconfigure flushes the plan cache]:https://mattsql.wordpress.com/2012/06/25/dont-believe-everything-you-read-reconfigure-flushes-the-plan-cache/
[How-to load data fast into SQL Server 2016]:http://henkvandervalk.com/how-to-load-data-fast-into-sql-server-2016
[Database Design Matters, RTO and Filegroups]:http://www.sqldoubleg.com/2016/10/28/database-design-matters-rto-and-filegroups/
[Automate Alerting for SQL Server Suspect Database Pages]:https://www.mssqltips.com/sqlservertip/4166/automate-alerting-for-sql-server-suspect-database-pages/
[Successful Anti-Patterns, Storage Requirements]:http://www.sqldoubleg.com/2016/10/19/successful-anti-patterns-storage-requirements/
[SQL Server table columns under the hood]:http://rusanu.com/2011/10/20/sql-server-table-columns-under-the-hood/
[How to analyse SQL Server performance]:http://rusanu.com/2014/02/24/how-to-analyse-sql-server-performance/
[To BLOB or Not To BLOB: Large Object Storage in a Database or a Filesystem?]:https://www.microsoft.com/en-us/research/publication/to-blob-or-not-to-blob-large-object-storage-in-a-database-or-a-filesystem/
[Asynchronous procedure execution]:http://rusanu.com/2009/08/05/asynchronous-procedure-execution/
[What is the CXPACKET Wait Type, and How Do You Reduce It?]:https://www.brentozar.com/archive/2013/08/what-is-the-cxpacket-wait-type-and-how-do-you-reduce-it/
[New indexes, hypothetically]:https://sqlstudies.com/2016/11/02/new-indexes-hypothetically/
[Indexing Wide Keys in SQL Server]:https://www.brentozar.com/archive/2013/05/indexing-wide-keys-in-sql-server/
[The Anatomy and (In)Security of Microsoft SQL Server Transparent Data Encryption (TDE), or How to Break TDE]:http://simonmcauliffe.com/technology/tde/
[Correctly adding data files to tempdb]:http://www.sqlskills.com/blogs/paul/correctly-adding-data-files-tempdb/
[Why You Should Test Your Queries Against Bigger Data]:https://www.brentozar.com/archive/2016/11/why-you-should-test-your-queries-against-bigger-data/
[Tally OH! An Improved SQL 8K “CSV Splitter” Function]:http://www.sqlservercentral.com/articles/Tally+Table/72993/
[Set Statistics… Profile?]:https://www.brentozar.com/archive/2016/10/set-statistics-profile/
[Hierarchies on Steroids #1: Convert an Adjacency List to Nested Sets]:http://www.sqlservercentral.com/articles/Hierarchy/94040/
[Optimizing T-SQL queries that change data]:https://www.sql.kiwi/2013/01/optimizing-t-sql-queries-that-change-data.html
[Measuring Query Duration: SSMS vs SQL Sentry Plan Explorer]:https://www.littlekendra.com/2016/09/27/measuring-query-duration-ssms-vs-sql-sentry-plan-explorer/
[Inside the Statistics Histogram & Density Vector]:http://www.sqlpassion.at/archive/2014/01/28/inside-the-statistics-histogram-density-vector/
[Misconceptions on parameter sniffing]:https://sqlserverfast.com/blog/hugo/2016/11/misconceptions-on-parameter-sniffing/
[What Every Accidental DBA Needs to Know Now: Basics of SQL Security]:http://sqlmag.com/database-security/what-every-accidental-dba-needs-know-now-basics-sql-security
[SQL Server Perfmon (Performance Monitor) Best Practices]:https://www.brentozar.com/archive/2006/12/dba-101-using-perfmon-for-sql-performance-tuning/
[Top 5 Overlooked Index Features]:https://www.brentozar.com/archive/2016/11/top-5-overlooked-index-features/
[A Sysadmin’s Guide to Microsoft SQL Server Memory]:https://www.brentozar.com/archive/2011/09/sysadmins-guide-microsoft-sql-server-memory/
[Searching Strings in SQL Server is Expensive]:https://www.brentozar.com/archive/2016/10/searching-strings-sql-server-expensive/
[Altering an INT Column to a BIGINT]:https://www.littlekendra.com/2016/08/04/altering-an-int-column-to-a-bigint-dear-sql-dba-episode-11/
[Query tuning 101: Problems with IN ()]:http://www.sqlservercentral.com/blogs/confessions-of-a-microsoft-addict/2016/11/10/query-tuning-101-problems-with-in-/
[Admin: Bulkadmin vs ADMINISTER BULK OPERATIONS]:http://richbrownesq-sqlserver.blogspot.ru/2012/01/admin-bulkadmin-vs-administer-bulk.html
[Can Indexes My Query Doesn’t Use Help My Query?]:https://www.brentozar.com/archive/2016/11/can-indexes-query-doesnt-use-help-query/
[SQL Server Audit Walkthrough]:http://www.sql-server-performance.com/2016/walkthrough-sql-server-audit/
[The SQL Server 2016 Query Store: Overview and Architecture]:https://www.simple-talk.com/sql/database-administration/the-sql-server-2016-query-store-overview-and-architecture/
[Reading, Writing, and Creating SQL Server Extended Properties]:https://www.simple-talk.com/sql/database-delivery/reading-writing-creating-sql-server-extended-properties/
[Questions About SQL Server Security and Access Control You Were Too Shy to Ask]:https://www.simple-talk.com/sql/database-delivery/questions-sql-server-security-access-control-shy-ask/
[The Ten Commandments of SQL Server Monitoring]:https://www.simple-talk.com/sql/database-administration/the-ten-commandments-of-sql-server-monitoring/
[Should I use NOT IN, OUTER APPLY, LEFT OUTER JOIN, EXCEPT, or NOT EXISTS?]:https://sqlperformance.com/2012/12/t-sql-queries/left-anti-semi-join
[Parameter Sniffing, Embedding, and the RECOMPILE Options]:https://sqlperformance.com/2013/08/t-sql-queries/parameter-sniffing-embedding-and-the-recompile-options
[Can comments hamper stored procedure performance?]:https://sqlperformance.com/2016/11/sql-performance/comments-hamper-performance
[SQL Server Temporary Table Caching]:https://www.mssqltips.com/sqlservertip/4406/sql-server-temporary-table-caching/
[Techniques to Monitor SQL Server memory usage]:http://www.sql-server-performance.com/2016/monitor-sql-server-memory-usage/
[Troubleshooting Query Regressions Caused By The New Cardinality Estimator]:https://sqlserverscotsman.wordpress.com/2016/11/24/troubleshooting-query-regressions-caused-by-the-new-cardinality-estimator/
[Migrating Databases to Azure SQL Database]:https://sqlperformance.com/2016/10/sql-performance/migrating-to-azure-sql-database
[Solve Common SQL Server Restore Issues]:https://www.mssqltips.com/sqlservertip/4110/solve-common-sql-server-restore-issues/
[Spills SQL Server Doesn’t Warn You About]:https://www.brentozar.com/archive/2016/11/spills-sql-server-doesnt-warn/
[How often should I run DBCC CHECKDB?]:https://www.brentozar.com/archive/2016/02/how-often-should-i-run-dbcc-checkdb/
[Why is My Query Faster the Second Time it Runs?]:https://www.littlekendra.com/2016/11/25/why-is-my-query-faster-the-second-time-it-runs-dear-sql-dba-episode-23/
[Downgrading the SQL Server Edition of a Dev Environment]:https://www.littlekendra.com/2016/11/15/downgrading-the-sql-server-edition-of-a-dev-environment/
[Date Math In The WHERE Clause]:https://www.brentozar.com/archive/2016/12/date-math-clause/
[Why is This Partitioned Query Slower?]:https://www.brentozar.com/archive/2015/09/why-is-this-partitioned-query-slower/
[A Beginner’s Guide to the True Order of SQL Operations]:https://blog.jooq.org/2016/12/09/a-beginners-guide-to-the-true-order-of-sql-operations/
[Logical Query Processing: What It Is And What It Means to You]:http://sqlmag.com/sql-server/logical-query-processing-what-it-and-what-it-means-you
[Forcing a Parallel Query Execution Plan]:https://www.sql.kiwi/2011/12/forcing-a-parallel-query-execution-plan.html
[Join Containment Assumption and CE Model Variation]:http://www.queryprocessor.com/ce_join_base_containment_assumption/
[Table Variable Tip]:http://sqlmag.com/t-sql/table-variable-tip
[Heap tables in SQL Server]:http://www.sqlhammer.com/heaps-in-microsoft-sql-server/
[The ‘B’ in B-Tree – Indexing in SQL Server]:http://www.sqlhammer.com/the-b-in-b-tree-indexing-sql-server/
[How to read the SQL Server Database Transaction Log]:https://www.mssqltips.com/sqlservertip/3076/how-to-read-the-sql-server-database-transaction-log/
[Filtered Statistics Follow-up]:https://www.brentozar.com/archive/2016/12/filtered-statistics-follow/
[SQL Server Query Optimization: No Unknown Unknowns]:http://sqlmag.com/sql-server/sql-server-query-optimization-no-unknown-unknowns
[Sync Vs Async Statistics: The Old Debate]:https://sqlserverscotsman.wordpress.com/2016/12/10/sync-vs-async-statistics-the-old-debate/
[Recommended updates and configuration options for SQL Server 2012 and SQL Server 2014 with high-performance workloads]:https://support.microsoft.com/en-gb/kb/2964518
[Troubleshooting SQL Server backup and restore operations]:https://support.microsoft.com/en-us/kb/224071
[SQL Server 2016: Getting tempdb a little more right]:https://blogs.sentryone.com/aaronbertrand/sql-server-2016-tempdb-fixes/
[Practical uses of binary types]:https://sqlsunday.com/2017/01/09/binary-types/
[Backing Up SQL Server Databases is Easier in PowerShell than T-SQL]:http://www.sqlservercentral.com/articles/PowerShell/151510/
[Creating, detaching, re-attaching, and fixing a SUSPECT database]:http://www.sqlskills.com/blogs/paul/creating-detaching-re-attaching-and-fixing-a-suspect-database/
[Modifying Tables Online – Part 1: Migration Strategy]:http://michaeljswart.com/2012/04/modifying-tables-online-part-1-migration-strategy/
[Modifying Tables Online – Part 2: Implementation Example]:http://michaeljswart.com/2012/04/modifying-tables-online-part-2-implementation-example/
[Modifying Tables Online – Part 3: Example With Error Handling]:http://michaeljswart.com/2012/04/modifying-tables-online-part-3-example-with-error-handling/
[Modifying Tables Online – Part 4: Testing]:http://michaeljswart.com/2012/04/modifying-tables-online-part-4-testing/
[Modifying Tables Online – Part 5: Just One More Thing]:http://michaeljswart.com/2012/04/modifying-tables-online-part-5-just-one-more-thing/
[DATEDIFF vs. DATEADD]:http://www.madeiradata.com/datediff-vs-dateadd/
[Disaster recovery 101: hack-attach a damaged database]:http://www.sqlskills.com/blogs/paul/disaster-recovery-101-hack-attach-a-damaged-database/
[Bones of SQL - The Calendar Table]:http://www.sqlservercentral.com/articles/calendar/145206/
[SQL Server 2016, Double or Nothing, Always Encrypted with temporal tables]:http://www.sqldoubleg.com/2016/07/27/sql-server-2016-double-or-nothing-always-encrypted-with-temporal-tables/
[Reclaiming Space After Column Data Type Change]:http://www.sqlservercentral.com/articles/data+type/144308/
[Packing Intervals with Priorities]:http://sqlmag.com/sql-server/packing-intervals-priorities
[Avoid Unnecessary Lookups when Using ROW_NUMBER for Paging]:http://sqlmag.com/t-sql/avoid-unnecessary-lookups-when-using-rownumber-paging
[Migrating a Disk-Based Table to a Memory-Optimized Table in SQL Server]:https://www.simple-talk.com/sql/database-administration/migrating-disk-based-table-memory-optimized-table-sql-server/
[SQL Server Hardware Optimization]:http://www.sql-server-performance.com/2016/sql-server-hardware-optimization/
[Index Types  Heaps, Primary Keys, Clustered and Nonclustered Indexes]:https://www.littlekendra.com/2017/02/02/index-types-heaps-primary-keys-clustered-and-nonclustered-indexes-dear-sql-dba-episode-28/
[Identifying Existence of Intersections in Intervals]:http://sqlmag.com/sql-server/identifying-existence-intersections-intervals
[Cheat Sheet  How to Configure TempDB for Microsoft SQL Server]:https://www.brentozar.com/archive/2016/01/cheat-sheet-how-to-configure-tempdb-for-microsoft-sql-server/
[A Tourist’s Guide to the sp_Blitz Source Code, Part 1: The Big Picture]:https://www.brentozar.com/archive/2017/02/tourists-guide-sp_blitz-source-code-part-1-big-picture/
[SQL Server Default Configurations That You Should Change]:https://www.pythian.com/blog/sql-server-default-configurations-change/
[Decoding Key and Page WaitResource for Deadlocks and Blocking]:https://www.littlekendra.com/2016/10/17/decoding-key-and-page-waitresource-for-deadlocks-and-blocking/
[Security in the CLR World Inside SQL Server]:http://www.codemag.com/article/0603031
[On the Advantages of DateTime2(n) over DateTime]:http://www.sqltact.com/2012/12/on-advantages-of-datetime2n-over.html
[Build Your Own Tools]:http://michaeljswart.com/2016/09/build-your-own-tools/
[Enhanced T-SQL Error Handling With Extended Events]:http://itsalljustelectrons.blogspot.ru/2016/09/Enhanced-TSQL-Error-Handling-With-Extended-Events.html
[Compression and its Effects on Performance]:https://sqlperformance.com/2017/01/sql-performance/compression-effect-on-performance
[Does Truncate Table Reset Statistics]:https://www.littlekendra.com/2016/12/08/does-truncate-table-reset-statistics/
[SQL Server Database Decommissioning Check List]:https://www.mssqltips.com/sqlservertip/4333/sql-server-database-decommissioning-check-list/
[New SQL Server Database Request Questionnaire and Checklist]:https://www.mssqltips.com/sqlservertip/3523/new-sql-server-database-request-questionnaire-and-checklist/
[Adding Partitions to the Lower End of a Left Based Partition Function]:https://www.littlekendra.com/2017/02/21/adding-partitions-to-the-lower-end-of-a-left-based-partition-function/
[Don't Panic  Busting a File Space Myth]:http://sqlmag.com/database-administration/dont-panic-busting-file-space-myth
[#BackToBasics : Dating Responsibly]:https://blogs.sentryone.com/aaronbertrand/backtobasics-dating-responsibly/
[#BackToBasics : Common Table Expressions (CTEs)]:https://blogs.sentryone.com/aaronbertrand/backtobasics-ctes/
[How to Establish Dedicated Admin Connection (DAC) to SQL Server]:https://www.codeproject.com/tips/1136361/how-to-establish-dedicated-admin-connection-dac-to
[SQL and SQL only Best Practice]:http://strictlysql.blogspot.ru/search/label/Best%20Practices
[There Is No Difference Between Table Variables, Temporary Tables, and Common Table Expressions]:https://dzone.com/articles/there-is-no-difference-between-table-variables-tem
[Availability Group on SQL Server 2016]:http://www.madeiradata.com/availability-group-sql-server-2016/
[Using SQL Server and R Services for analyzing DBA Tasks]:http://www.sqlservercentral.com/articles/R+Language/151405/
[SQLskills SQL101: Dealing with SQL Server corruption]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-dealing-with-sql-server-corruption/
[Advanced Analytics with R & SQL: Part I - R Distributions]:http://www.sqlservercentral.com/articles/Data+Science/146555/
[T-SQL Tuesday #85  STOP! Restore Time!]:http://www.sqlhammer.com/t-sql-tuesday-85-stop-restore-time
[Filtered Indexes: Rowstore vs Nonclustered Columnstore]:https://www.littlekendra.com/2016/11/10/filtered-indexes-rowstore-vs-nonclustered-columnstore/
[ALTER SCHEMA TRANSFER for Zero Downtime Database Upgrades]:http://www.davewentzel.com/content/alter-schema-transfer-zero-downtime-database-upgrades
[Delayed Durability in SQL Server 2014]:https://sqlperformance.com/2014/04/io-subsystem/delayed-durability-in-sql-server-2014
[Daylight Savings end affects not only you, but your SQL Server too]:http://www.sqldoubleg.com/2015/10/28/daylight-savings-end-affects-not-only-you-but-your-sql-server-too/
[Searching Strings in SQL Server is Expensive]:https://www.brentozar.com/archive/2016/10/searching-strings-sql-server-expensive/
[Let’s Corrupt a SQL Server Database Together, Part 1: Clustered Indexes]:https://www.brentozar.com/archive/2017/02/lets-corrupt-sql-server-database-together/
[Let’s Corrupt a Database Together, Part 2: Nonclustered Indexes]:https://www.brentozar.com/archive/2017/02/lets-corrupt-database-together-part-2-nonclustered-indexes/
[The Guide  SQL Server Installation Checklist (settings that increase SQL Server Performance)]:https://red9.com/blog/sql-server-installation-checklist/
[SQL Browser, what is it good for? Absolutely something!]:http://www.cjsommer.com/2017-03-01-sql-browser-what-is-it-good-for-absolutely-something/
[PowerShell Getting More From Generic Error Messages]:https://nocolumnname.wordpress.com/2017/03/02/powershell-getting-more-from-generic-error-messages/
[SQL VNext sp_configure on Windows and Linux with dbatools]:https://sqldbawithabeard.com/2017/02/27/sql-vnext-sp_configure-on-windows-and-linux-with-dbatools/
[Adding a T-SQL Job Step to a SQL Agent Job with PowerShell]:https://sqldbawithabeard.com/2017/02/20/adding-a-t-sql-job-step-to-a-sql-agent-job-with-powershell/
[Setting up Database Mail to use my Gmail account]:https://mathaywardhill.com/2017/03/01/setting-up-database-mail-to-use-my-gmail-account/
[Using DBCC CLONEDATABASE and Query Store for Testing]:https://sqlperformance.com/2017/02/sql-performance/clonedatabase-query-store-testing
[Getting Started with Natural Earth — A SQL Server Shapefile Alternative (Geospatial Resource)]:http://blog.jpries.com/2017/02/17/getting-started-with-natural-earth-sql-server/
[SQL Server Temporal Tables: How-To Recipes]:https://www.simple-talk.com/sql/sql-training/sql-server-temporal-tables-recipes/
[The Migration Checklist]:http://www.sqlservercentral.com/articles/Editorial/154033/
[Upgrading to SQL Server 2014: A Dozen Things to Check]:https://thomaslarock.com/2014/06/upgrading-to-sql-server-2014-a-dozen-things-to-check/
[Introducing the Set-based Loop]:http://www.sqlservercentral.com/articles/set-based+loop/127670/
[Representing Hierarchical Data for Mere Mortals]:https://www.simple-talk.com/sql/database-administration/representing-hierarchical-data-for-mere-mortals/
[KPIs For DBAs to Show Their CIOs]:https://thomaslarock.com/2017/03/kpis-dbas-show-cios/
[How To Forecast Database Disk Capacity If You Don’t Have A Monitoring Tool]:http://www.edwinmsarmiento.com/how-to-forecast-database-disk-capacity-if-you-dont-have-a-monitoring-tool/
[Statistical Sampling for Verifying Database Backups]:https://www.simple-talk.com/sql/database-administration/statistical-sampling-for-verifying-database-backups/
[Using dbatools for automated restore and CHECKDB]:http://www.centinosystems.com/blog/sql/using-dbatools-for-automated-restore-and-checkdb/
[Bad Habits Revival]:https://blogs.sentryone.com/aaronbertrand/bad-habits-revival/
[Deploying Multiple SSIS Projects via PowerShell]:https://www.simple-talk.com/sql/ssis/deploying-multiple-ssis-projects-via-powershell/
[Determining the Cost Threshold for Parallelism]:http://www.scarydba.com/2017/02/28/determining-the-cost-threshold-for-parallelism/
[Identifying a row’s physical location]:http://blog.waynesheffield.com/wayne/archive/2017/03/identifying-rows-physical-location/
[Split a file group into multiple data files]:https://blogs.msdn.microsoft.com/sql_pfe_blog/2017/03/03/split-a-file-group-into-multiple-data-files/
[Why PFS pages cannot be repaired]:https://www.sqlskills.com/blogs/paul/why-pfs-pages-cannot-be-repaired/
[ERRORLOG records max out at 2049 characters]:https://www.codykonior.com/2017/03/02/errorlog-records-max-out-at-2047-characters/
[How to Build a SQL Server Disaster Recovery Plan with Google Compute Engine]:https://www.brentozar.com/archive/2017/03/new-white-paper-build-sql-server-disaster-recovery-plan-google-compute-engine/
[SQL Server Performance Tuning in Google Compute Engine]:https://www.brentozar.com/archive/2017/03/new-white-paper-sql-server-performance-tuning-google-compute-engine/
[Configuring R on SQL Server 2016]:http://sqlmag.com/sql-server/configuring-r-sql-server-2016
[Knee-Jerk PerfMon Counters: Page Life Expectancy]:https://sqlperformance.com/2014/10/sql-performance/knee-jerk-page-life-expectancy
[Change Management Template for SQL Server DBAs and Developers]:https://www.littlekendra.com/2016/04/12/change-management-template-for-sql-server-dbas-and-deveopers/
[Performance Myths: Clustered vs. Non-Clustered Indexes]:https://sqlperformance.com/2017/03/sql-indexes/performance-myths-clustered-vs-non-clustered
[Bad habits: Counting rows the hard way]:https://sqlperformance.com/2014/10/t-sql-queries/bad-habits-count-the-hard-way
[Why Cost Threshold For Parallelism Shouldn’t Be Set To 5]:https://www.brentozar.com/archive/2017/03/why-cost-threshold-for-parallelism-shouldnt-be-set-to-5/
[Join Performance, Implicit Conversions, and Residuals]:https://www.sql.kiwi/2011/07/join-performance-implicit-conversions-and-residuals.html
[Implicit Conversions that cause Index Scans]:https://www.sqlskills.com/blogs/jonathan/implicit-conversions-that-cause-index-scans/
[When Is It Appropriate To Store JSON in SQL Server?]:https://bertwagner.com/2017/03/14/when-is-it-appropriate-to-store-json-in-sql-server/
[The Performance Penalty of Bookmark Lookups in SQL Server]:http://www.sqlpassion.at/archive/2017/03/13/the-performance-penalty-of-bookmark-lookups-in-sql-server/
[Why You Should Change the Cost Threshold for Parallelism]:http://www.scarydba.com/2017/03/13/change-the-cost-threshold-for-parallelism/
[Why Update Statistics can cause an IO storm]:https://www.brentozar.com/archive/2014/01/update-statistics-the-secret-io-explosion/
[SQLskills SQL101  Temporary table misuse]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-temporary-table-misuse/
[SQL Server sp_execute_external_script Stored Procedure Examples]:https://www.mssqltips.com/sqlservertip/4747/sql-server-spexecuteexternalscript-stored-procedure-examples/
[Transparent Data Encryption and Replication]:http://port1433.com/2017/03/15/transparent-data-encryption-and-replication-sql-servers-rear-window/
[SQL Server Installation Checklist]:https://www.sqlskills.com/blogs/jonathan/sql-server-installation-checklist/
[Indexed Views And Data Modifications]:https://www.brentozar.com/archive/2017/03/indexed-views-data-modifications/
[Deployment Automation for SQL Server Integration Services (SSIS)]:https://www.simple-talk.com/sql/ssis/deployment-automation-for-sql-server-integration-services-ssis/
[Why Developers Should Consider Microsoft SQL Server]:https://www.brentozar.com/archive/2017/03/developers-consider-microsoft-sql-server/
[SQLskills SQL101: Indexes on Foreign Keys]:https://www.sqlskills.com/blogs/kimberly/sqlskills-sql101-indexes-foreign-keys/
[SQLskills SQL101: Updating SQL Server Statistics Part I – Automatic Updates]:https://www.sqlskills.com/blogs/erin/sqlskills-sql101-updating-sql-server-statistics-part-i-automatic-updates/
[Processing Loops in SQL Server]:https://www.codeproject.com/Articles/1177788/Processing-Loops-in-SQL-Server
[The Mysterious Case of the Missing Default Value]:http://www.sqlservercentral.com/articles/SQL+Server+internal+storage/132990/
[Plan Caching]:https://www.sqlpassion.at/archive/2017/03/20/plan-caching/
[sp_executesql Is Not Faster Than an Ad Hoc Query]:http://www.sqlservercentral.com/blogs/scarydba/2016/11/07/sp_executesql-is-not-faster-than-an-ad-hoc-query/
[Backing up SQL Server on Linux using Ola Hallengrens Maintenance Solution]:https://sqldbawithabeard.com/2017/03/22/backing-up-sql-server-on-linux-using-ola-hallengrens-maintenance-solution/
[Delayed Durability in SQL Server 2014 Paul Randal]:http://www.sqlskills.com/blogs/paul/delayed-durability-sql-server-2014/
[Why Is This Query Sometimes Fast and Sometimes Slow]:https://www.brentozar.com/archive/2016/11/query-sometimes-fast-sometimes-slow/
[Using Plan Guides to Remove OPTIMIZE FOR UNKNOWN Hints]:https://www.brentozar.com/archive/2016/11/using-plan-guides-remove-optimize-unknown-hints/
[ETL Best Practices]:https://www.timmitchell.net/etl-best-practices/
[Resolving Key Lookup Deadlocks with Plan Explorer]:https://blogs.sentryone.com/greggonzalez/key-lookup-deadlocks-plan-explorer/
[Why ROWLOCK Hints Can Make Queries Slower and Blocking Worse in SQL Server]:https://www.littlekendra.com/2016/02/04/why-rowlock-hints-can-make-queries-slower-and-blocking-worse-in-sql-server/
[Does a Clustered Index really physically store the rows in key order]:http://www.sqlservercentral.com/blogs/discussionofsqlserver/2012/10/21/does-a-clustered-index-really-physically-store-the-rows-in-key-order/
[Ugly Pragmatism For The Win]:http://michaeljswart.com/2016/02/ugly-pragmatism-for-the-win/
[Architecting Microsoft SQL Server on VMware vSphere]:http://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/solutions/sql-server-on-vmware-best-practices-guide.pdf
[Hiding tables in SSMS Object Explorer]:https://sqlstudies.com/2017/04/03/hiding-tables-in-ssms-object-explorer-using-extended-properties/
[Clustered columnstore: on-disk vs. in-mem]:http://nedotter.com/archive/2017/03/clustered-columnstore-on-disk-vs-in-mem/
[Generating Plots Automatically From PowerShell and SQL Server Using Gnuplot]:https://www.simple-talk.com/sql/database-delivery/generating-plots-automatically-powershell-sql-server-using-gnuplot/
[How to Benchmark Alternative SQL Queries to Find the Fastest Query]:https://blog.jooq.org/2017/03/29/how-to-benchmark-alternative-sql-queries-to-find-the-fastest-query/
[Checking for Strange Client Settings with sys.dm_exec_sessions]:https://www.brentozar.com/archive/2017/03/checking-strange-client-settings-sys-dm_exec_sessions/
[Decrypting Insert Query Plans]:https://www.brentozar.com/archive/2017/03/decrypting-insert-query-plans/
[SQLskills SQL101: Partitioning]:https://www.sqlskills.com/blogs/kimberly/sqlskills-sql101-partitioning/
[SQLskills SQL101: Switching recovery models]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-switching-recovery-models/
[Using AT TIME ZONE to fix an old report]:https://sqlperformance.com/2017/02/t-sql-queries/using-at-time-zone-to-fix-an-old-report
[What the heck is a DTU]:https://sqlperformance.com/2017/03/azure/what-the-heck-is-a-dtu
[Hack-Attaching a SQL Server database with NORECOVERY]:http://sqlblog.com/blogs/argenis_fernandez/archive/2017/01/24/hack-attaching-a-sql-server-database-with-norecovery.aspx
[Switch in Staging Tables Instead of sp_rename]:https://www.littlekendra.com/2017/01/19/why-you-should-switch-in-staging-tables-instead-of-renaming/
[Performance Myths: Table variables are always in-memory]:https://sqlperformance.com/2017/04/performance-myths/table-variables-in-memory
[Questions About SQL Server Collations You Were Too Shy to Ask]:https://www.simple-talk.com/sql/sql-development/questions-sql-server-collations-shy-ask/
[NULL - The database's black hole]:https://sqlserverfast.com/blog/hugo/2007/07/null-the-databases-black-hole/
[Inside the Storage Engine: Using DBCC PAGE and DBCC IND to find out if page splits ever roll back]:http://www.sqlskills.com/blogs/paul/inside-the-storage-engine-using-dbcc-page-and-dbcc-ind-to-find-out-if-page-splits-ever-roll-back/
[Inside the Storage Engine: Anatomy of a page]:http://www.sqlskills.com/blogs/paul/inside-the-storage-engine-anatomy-of-a-page/
[For The Better Developer: SQL Server Indexes]:https://medium.com/sql-server-for-the-better-developer/know-your-data-base-affd6241bcac
[#EntryLevel: Compression & Data Types]:https://blogs.sentryone.com/melissaconnors/entry-level-compression/
[Cardinality Estimation for a Predicate on a COUNT Expression]:https://sqlperformance.com/2017/04/sql-optimizer/cardinality-count
[Changing SQL Server Collation After Installation]:https://www.mssqltips.com/sqlservertip/3519/changing-sql-server-collation-after-installation/
[Does a TempDB spill mean statistics are out of date?]:https://www.brentozar.com/archive/2017/04/tempdb-spill-mean-statistics-date/
[Transaction log growth during BACKUP]:https://www.am2.co/2017/04/transaction-log-growth-backup/
[When is a SQL function not a function?]:http://blogs.lobsterpot.com.au/2011/11/08/when-is-a-sql-function-not-a-function/
[Introducing Batch Mode Adaptive Joins]:https://blogs.msdn.microsoft.com/sqlserverstorageengine/2017/04/19/introducing-batch-mode-adaptive-joins/
[Investigating the proportional fill algorithm]:https://www.sqlskills.com/blogs/paul/investigating-the-proportional-fill-algorithm/
[Understanding Logging and Recovery in SQL Server]:https://technet.microsoft.com/en-us/library/2009.02.logging.aspx
[Bad Habits to Kick: Using shorthand with date/time operations]:https://sqlblog.org/2011/09/20/bad-habits-to-kick-using-shorthand-with-date-time-operations
[Generating Charts and Drawings in SQL Server Management Studio]:http://sqlmag.com/t-sql/generating-charts-and-drawings-sql-server-management-studio
[How expensive are column-side Implicit Conversions?]:https://sqlperformance.com/2013/04/t-sql-queries/implicit-conversion-costs
[Execution Plan Basics]:https://www.simple-talk.com/sql/performance/execution-plan-basics/
[Disabling ROW and PAGE Level Locks in SQL Server]:http://www.sqlpassion.at/archive/2016/10/31/disabling-row-and-page-level-locks-in-sql-server/
[Fixing Cardinality Estimation Errors with Filtered Statistics]:https://www.sqlpassion.at/archive/2013/10/29/fixing-cardinality-estimation-errors-with-filtered-statistics/
[Cardinality Estimation for Multiple Predicates]:https://sqlperformance.com/2014/01/sql-plan/cardinality-estimation-for-multiple-predicates
[Weaning yourself off of SQL Profiler (Part 1)]:http://blog.waynesheffield.com/wayne/archive/2017/04/weaning-yourself-off-sql-profiler/
[Properly Persisted Computed Columns]:https://sqlperformance.com/2017/05/sql-plan/properly-persisted-computed-columns
[A SQL Server DBA myth a day: (17/30) page checksums]:https://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-1730-page-checksums/
[What are different ways to replace ISNULL() in a WHERE clause that uses only literal values?]:https://dba.stackexchange.com/questions/168276/what-are-different-ways-to-replace-isnull-in-a-where-clause-that-uses-only-lit
[SQL Server 2016 enhancements – Truncate Table and Table Partitioning]:https://www.sqlshack.com/sql-server-2016-enhancements-truncate-table-table-partitioning
[SQL Server Mysteries: The Case of the Not 100% RESTORE…]:https://blogs.msdn.microsoft.com/sql_server_team/sql-server-mysteries-the-case-of-the-not-100-restore/
[Transactional Replication and Stored Procedure Execution: Silver Bullet or Poison Pill?]:http://port1433.com/2017/04/11/transactional-replication-and-stored-procedure-execution-silver-bullet-or-poison-pill/
[STOPAT And Date Formats]:https://itsalljustelectrons.blogspot.ru/2017/07/STOPAT-And-Date-Formats.html
[Row-count Estimates when there are no Statistics]:http://www.sqlservercentral.com/blogs/matthew-mcgiffen-dba/2017/06/28/row-count-estimates-when-there-are-no-statistics/
[SQL Server DBA On-Boarding Checklist]:https://www.mssqltips.com/sqlservertip/4871/sql-server-dba-onboarding-checklist/
[Be Wary of Date Formatting in T-SQL]:https://bornsql.ca/2017/07/wary-date-formatting-t-sql/
[Statistics and Cardinality Estimation]:http://www.sqlservercentral.com/blogs/matthew-mcgiffen-dba/2017/06/20/statistics-and-cardinality-estimation/
[Message queues for the DBA: sending data out into the world]:http://port1433.com/2017/07/21/messaging-queuing-for-the-dba-sending-data-out-into-the-world/
[Schema-Based Access Control for SQL Server Databases]:https://www.red-gate.com/simple-talk/sql/sql-training/schema-based-access-control-for-sql-server-databases/
[SQL Server: large RAM and DB Checkpointing]:https://blogs.msdn.microsoft.com/psssql/2017/06/29/sql-server-large-ram-and-db-checkpointing/
[Handling SQL Server Deadlocks With Event Notifications]:https://itsalljustelectrons.blogspot.ru/2017/06/Handling-SQL-Server-Deadlocks-With-Event-Notifications.html
[SQL Server R Services: Digging into the R Language]:https://www.red-gate.com/simple-talk/sql/bi/sql-server-r-services-digging-r-language/
[Investigating the Cause of SQL Server High CPU Load Conditions When They Happen]:https://www.red-gate.com/simple-talk/sql/database-administration/investigating-cause-sql-server-high-cpu-load-conditions-happen/
[In-Memory Engine DURABILITY = SCHEMA_ONLY And Transaction Rollback]:https://chrisadkin.io/2017/07/17/in-memory-engine-durability-schema_only-and-transaction-rollback/
[Builder Day: Doing a Point-in-Time Restore in Azure SQL DB]:https://www.brentozar.com/archive/2017/06/builder-day-point-time-restore-azure-sql-db/
[Creating Continuous Integration Build Pipelines With Jenkins, Docker and SQL Server]:https://chrisadkin.io/2017/07/18/creating-continuous-integration-build-pipelines-with-jenkins-docker-and-sql-server/
[Scale-able Windows Aggregate Functions With Row Store Object]:https://chrisadkin.io/2017/07/24/scale-able-windows-aggregate-functions-with-row-store-objects/
[Azure DWH part 11: Data Warehouse Migration Utility]:http://www.sqlservercentral.com/articles/Azure+SQL+Data+Warehouse+(ASDW)/158311/
[Representing a simple hierarchical list in SQL Server with JSON, YAML, XML and HTML]:https://www.red-gate.com/simple-talk/blogs/71858/
[Advanced Analytics with R and SQL Part II - Data Science Scenarios]:http://www.sqlservercentral.com/articles/Data+Science/158498/
[Think twice before using table variables]:http://www.sqlservercentral.com/blogs/matthew-mcgiffen-dba/2017/07/11/think-twice-before-using-table-variables/
[ColumnStore Indexes And Recursive CTEs]:https://www.brentozar.com/archive/2017/07/columnstore-indexes-recursive-ctes/
[CCIs and String Aggregation]:https://orderbyselectnull.com/2017/07/03/ccis-and-string-aggregation/
[Brad’s Sure DBA Checklist]:https://www.red-gate.com/simple-talk/sql/database-administration/brads-sure-dba-checklist/
[Query Store and Parameterization Problems]:https://www.red-gate.com/simple-talk/sql/database-administration/query-store-parameterization-problems/
[SQL Server Event Handling: Event Notifications]:https://itsalljustelectrons.blogspot.ru/2016/11/SQL-Server-Event-Handling-Event-Notifications.html
[Identifying Deprecated Feature Usage (Part 1)]:https://itsalljustelectrons.blogspot.ru/2017/07/Identifying-Deprecated-Feature-Usage-pt1.html
[Let’s Corrupt a Database Together, Part 3: Detecting Corruption]:https://www.brentozar.com/archive/2017/07/lets-corrupt-database-together-part-3-detecting-corruption/
[XML vs JSON Shootout: Which is Superior in SQL Server 2016?]:https://bertwagner.com/2017/05/16/xml-vs-json-shootout-which-is-superior-in-sql-server-2016/
[One SQL Cheat Code For Amazingly Fast JSON Queries]:https://bertwagner.com/2017/05/09/one-sql-cheat-code-for-amazingly-fast-json-queries/
[The Ultimate SQL Server JSON Cheat Sheet]:https://bertwagner.com/2017/03/07/the-ultimate-sql-server-json-cheat-sheet/
[Are your indexes being thwarted by mismatched datatypes?]:https://bertwagner.com/2017/08/01/are-your-indexes-being-thwarted-by-mismatched-datatypes/
[Why Missing Index Recommendations Aren’t Perfect]:https://www.brentozar.com/archive/2017/08/missing-index-recommendations-arent-perfect/
[Top 5 Misleading SQL Server Performance Counters]:https://sqlworkbooks.com/2017/06/top-5-misleading-sql-server-performance-counters/
[The Case of the Space at the End]:http://www.sqlservercentral.com/articles/ANSI_PADDING/157467/
[SELECT…INTO in SQL Server 2017]:https://dbafromthecold.com/2017/08/02/select-into-in-sql-server-2017/
[Your Service Level Agreement is a Disaster]:http://minionware.net/service-level-agreement-disaster/
[SQLskills SQL101: REBUILD vs. REORGANIZE]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-rebuild-vs-reorganize/
[Where do the Books Online index fragmentation thresholds come from?]:https://www.sqlskills.com/blogs/paul/where-do-the-books-online-index-fragmentation-thresholds-come-from/
[The SQL Hall of Shame]:http://dataeducation.com/the-sql-hall-of-shame/
[A Better Way To Select Star]:https://www.brentozar.com/archive/2017/07/better-way-select-star/
[UDP vs TCP]:https://sqlstudies.com/2017/06/07/udp-vs-tcp/
[When a Nonclustered Index and Statistics Make a Query Slower]:https://sqlworkbooks.com/2017/05/when-a-nonclustered-index-and-statistics-make-a-query-slower/
[Lipoaspiration in your SQL Server Database]:https://www.red-gate.com/simple-talk/sql/performance/lipoaspiration-in-your-sql-server-database/
[13 Things You Should Know About Statistics and the Query Optimizer]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/13-things-you-should-know-about-statistics-and-the-query-optimizer/
[Creating R Stored Procedures in SQL Server 2016 Using sqlrutils]:http://www.nielsberglund.com/2017/06/25/creating-r-stored-procedures-in-sql-server-2016-using-sqlrutils/
[A Quick start Guide to Managing SQL Server 2017 on CentOS/RHEL Using the SSH Protocol]:https://www.sqlshack.com/quick-start-guide-managing-sql-server-2017-centosrhel-using-ssh-protocol/
[SQL Server v.Next : STRING_AGG Performance, Part 2]:https://sqlperformance.com/2017/01/sql-performance/sql-server-v-next-string_agg-performance-part-2
[Why Parameter Sniffing Isn’t Always A Bad Thing (But Usually Is)]:https://bertwagner.com/2017/08/08/why-parameter-sniffing-isnt-always-a-bad-thing-but-usually-is/
[Persisting statistics sampling rate]:https://blogs.msdn.microsoft.com/sql_server_team/persisting-statistics-sampling-rate/
[All about locking in SQL Server]:https://www.sqlshack.com/locking-sql-server/
[All about Latches in SQL Server]:https://www.sqlshack.com/all-about-latches-in-sql-server/
[All about SQL Server spinlocks]:https://www.sqlshack.com/sql-server-spinlocks/
[How to monitor object space growth in SQL Server]:https://www.sqlshack.com/monitor-object-space-growth-sql-server/
[How to Read a Transaction Log Backup]:http://www.databasejournal.com/features/mssql/how-to-read-a-transaction-log-backup.html
[How to Find Out Which Database Object Got Deleted]:http://www.databasejournal.com/tips/how-to-find-out-which-database-object-got-deleted.html
[In-Memory OLTP Enhancements in SQL Server 2016]:https://www.sqlshack.com/memory-oltp-enhancements-sql-server-2016/
[Sync SQL Logins and Jobs]:https://blogs.msdn.microsoft.com/sql_pfe_blog/2017/08/21/sync-sql-logins-and-jobs/
[The Trillion Row Table]:https://orderbyselectnull.com/2017/08/16/the-trillion-row-table/
[Dynamic Data Unmasking]:https://orderbyselectnull.com/2017/08/25/dynamic-data-unmasking/
[Why is My Database Application so Slow?]:https://www.red-gate.com/simple-talk/dotnet/net-performance/database-application-slow/
[Generating Concurrent Activity]:http://michaeljswart.com/2014/01/generating-concurrent-activity/
[Required Testing for Installing SQL Server Cumulative Updates and Service Packs]:http://littlekendra.com/2016/04/28/required-testing-for-installing-sql-server-cumulative-updates-and-service-packs/
[Microsoft SQL Server R Services - Internals X]:http://www.nielsberglund.com/2017/08/29/microsoft-sql-server-r-services-internals-x/
[Clustered columnstore: on-disk vs. in-mem]:http://nedotter.com/archive/2017/03/clustered-columnstore-on-disk-vs-in-mem/
[Hands on Full-Text Search in SQL Server]:https://www.sqlshack.com/hands-full-text-search-sql-server/
[SQL Code Smells]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/sql-code-smells/
[Corruption demo databases and scripts]:https://www.sqlskills.com/blogs/paul/corruption-demo-databases-and-scripts/
[Understanding Cross-Database Transactions in SQL Server]:https://www.red-gate.com/simple-talk/sql/database-administration/understanding-cross-database-transactions-in-sql-server/
[Optional Parameters and Missing Index Requests]:https://www.brentozar.com/archive/2017/09/optional-parameters-missing-index-requests/
[Uniquifier is a rather unique word isn’t it?]:https://sqlstudies.com/2017/09/18/uniquifier-is-a-rather-unique-word-isnt-it/
[Importance of proper transaction log size management]:https://www.sqlskills.com/blogs/paul/importance-of-proper-transaction-log-size-management/
[#TSQL2sDay – Starting Out with PowerShell]:https://sqldbawithabeard.com/2017/09/12/tsql2sday-starting-out-with-powershell/
[Using native compilation to insert parent/child tables]:http://nedotter.com/archive/2017/09/using-native-compilation-to-insert-parentchild-tables/
[Questions About RDS SQL Server You Were Too Shy to Ask]:https://www.red-gate.com/simple-talk/cloud/cloud-data/questions-rds-sql-server-shy-ask/
[Active Directory Authentication with SQL Server on Ubuntu]:http://port1433.com/2017/09/19/active-directory-authentication-with-sql-server-on-ubuntu/
[Temporary Tables in Stored Procedures]:https://www.sql.kiwi/2012/08/temporary-tables-in-stored-procedures.html
[SQLCLR in Practice: Creating a Better Way of Sending Email from SQL Server]:https://www.red-gate.com/simple-talk/sql/sql-development/sqlclr-practice-creating-better-way-sending-email-sql-server/
[T-SQL commands performance comparison – NOT IN vs NOT EXISTS vs LEFT JOIN vs EXCEPT]:https://www.sqlshack.com/t-sql-commands-performance-comparison-not-vs-not-exists-vs-left-join-vs-except/
[Clustered vs Nonclustered: Index Fundamentals You Need To Know]:https://bertwagner.com/2017/09/26/clustered-vs-nonclustered-index-fundamentals-you-need-to-know/
[How to Write Efficient TOP N Queries in SQL]:https://blog.jooq.org/2017/09/22/how-to-write-efficient-top-n-queries-in-sql/
[Checklist: DR Plan Sanity Check]:http://sqlsoldier.net/wp/sqlserver/checklistdrplansanitycheck
[Table level recovery for selected SQL Server tables]:https://www.mssqltips.com/sqlservertip/2814/table-level-recovery-for-selected-sql-server-tables/
[SQL Mirroring, Preserving the Log Chain During Database Migrations]:https://sqlundercover.com/2017/01/21/sql-mirroring-preserving-the-log-chain-during-database-migrations/
[How NOLOCK Will Block Your Queries]:https://bertwagner.com/2017/10/10/how-nolock-will-block-your-queries/
[8 Ways to Export SQL Results To a Text File]:http://www.sqlservercentral.com/articles/Export/147145/
[SQL Server Installation Failed Due to Pending Restart of Server?]:https://thelonedba.wordpress.com/2017/09/18/sql-server-installation-failed-due-to-pending-restart-of-server/
[Six Scary SQL Surprises]:https://www.red-gate.com/simple-talk/sql/database-administration/six-scary-sql-surprises/
[How the rowversion datatype works when adding and deleting columns]:http://sqlblog.com/blogs/louis_davidson/archive/2017/09/26/how-the-rowversion-datatype-works-when-adding-and-deleting-columns.aspx
[Quick! What's the difference between RANK, DENSE_RANK, and ROW_NUMBER?]:http://douglaskline.blogspot.ru/2017/10/quick-whats-difference-between-rank.html
[A Serial Parallel Query]:https://orderbyselectnull.com/2017/09/26/a-serial-parallel-query/
[Add or Remove IDENTITY Property From an Existing Column Efficiently]:http://www.dbdelta.com/add-or-remove-identity-property-from-an-existing-column-efficiently/
[How Do I Analyze a SQL Server Execution Plan?]:https://littlekendra.com/2017/09/22/how-do-i-analyze-a-sql-server-execution-plan/
[A Subtle Difference Between COALESCE and ISNULL]:https://nocolumnname.wordpress.com/2017/10/09/a-subtle-difference-between-coalesce-and-isnull/
[Puzzle Challenge: Graph Matching with T-SQL Part 1-Concepts]:http://sqlmag.com/software-development/puzzle-challenge-graph-matching-t-sql-part-1-concepts
[Graph Matching with T-SQL Part 3: Maximum Matching]:http://www.itprotoday.com/microsoft-sql-server/graph-matching-t-sql-part-3-maximum-matching
[Running PowerShell in a SQL Agent Job]:https://www.sqlhammer.com/running-powershell-in-a-sql-agent-job/
[Line-Continuation in T-SQL]:https://sqlquantumleap.com/2017/10/27/line-continuation-in-t-sql/
[SQL Server 2017: Making Backups Great Again!]:https://johnsterrett.com/2017/10/31/sql-server-2017-backups/
[Say NO to Venn Diagrams When Explaining JOINs]:https://blog.jooq.org/2016/07/05/say-no-to-venn-diagrams-when-explaining-joins/
[Surprise Delta Stores]:https://orderbyselectnull.com/2017/11/07/delta-stores/
[SQL 2014 Clustered Columnstore index rebuild and maintenance considerations]:https://blogs.msdn.microsoft.com/sqlcat/2015/07/08/sql-2014-clustered-columnstore-index-rebuild-and-maintenance-considerations/
[The Case of the Weirdly Long COLUMNSTORE_BUILD_THROTTLE Wait]:https://sqlworkbooks.com/2017/11/the-case-of-the-weirdly-long-columnstore_build_throttle-wait/
[Multiple Output Datasets With R and SQL Server]:https://itsalljustelectrons.blogspot.ru/2017/11/Multiple-Output-Datasets-with-R-and-SQL-Server.html
[How to Avoid Excessive Sorts in Window Functions]:https://blog.jooq.org/2017/11/06/how-to-avoid-excessive-sorts-in-window-functions/
[Extracting a DAX Query Plan With Analysis Services 2016 Extended Events]:https://www.mssqltips.com/sqlservertip/5106/extracting-a-dax-query-plan-with-analysis-services-2016-extended-events/
[What impact can different cursor options have?]:https://sqlperformance.com/2012/09/t-sql-queries/cursor-options
[SQL Smackdown!!! Cursors VS Loops]:https://sqlundercover.com/2017/11/16/sql-smackdown-cursors-vs-loops/
[Using the OPTION (RECOMPILE) option for a statement]:https://www.sqlskills.com/blogs/kimberly/using-the-option-recompile-option-for-a-statement/
[Execution Plan Caching and Reuse]:https://msdn.microsoft.com/en-us/library/ms181055.aspx
[Buffer Management]:https://msdn.microsoft.com/en-us/library/aa337525.aspx
[RECOMPILE Hints and Execution Plan Caching]:https://www.brentozar.com/archive/2013/12/recompile-hints-and-execution-plan-caching/
[Improving query performance with OPTION (RECOMPILE), Constant Folding and avoiding Parameter Sniffing issues]:https://blogs.msdn.microsoft.com/robinlester/2016/08/10/improving-query-performance-with-option-recompile-constant-folding-and-avoiding-parameter-sniffing-issues/
[Eight Different Ways to Clear the SQL Server Plan Cache]:https://www.sqlskills.com/blogs/glenn/eight-different-ways-to-clear-the-sql-server-plan-cache/
[Introduction and FAQs about Microsoft Azure technologies]:https://www.sqlshack.com/introduction-faqs-microsoft-azure-technologies/
[Inside the XEvent Profiler]:https://www.sqlhammer.com/inside-xevent-profiler/
[Does The Join Order of My Tables Matter?]:https://bertwagner.com/2017/11/21/does-the-join-order-of-my-tables-matter/
[Encrypting SQL Server connections with Let’s Encrypt certificates]:https://sqlsunday.com/2017/11/22/encrypting-tds-with-letsencrypt/
[Start SQL Server without tempdb]:https://sqlstudies.com/2016/01/20/start-sql-server-without-tempdb/
[How to configure database mail in SQL Server]:https://www.sqlshack.com/configure-database-mail-sql-server/
[Understanding SQL server memory grant]:https://blogs.msdn.microsoft.com/sqlqueryprocessing/2010/02/16/understanding-sql-server-memory-grant/
[Cleanly Uninstalling Stubborn SQL Server Components]:https://www.mssqltips.com/sqlservertip/4050/cleanly-uninstalling-stubborn-sql-server-components/
[Hey! What's the deal with SQL Server NOCOUNT and T-SQL WHILE loops?]:http://sql-sasquatch.blogspot.ru/2017/11/hey-whats-deal-with-nocount-and-t-sql.html
[Query Store Settings]:https://www.sqlskills.com/blogs/erin/query-store-settings/
[Using Plan Explorer with Entity Framework]:https://blogs.sentryone.com/jasonhall/using-plan-explorer-entity-framework/
[Overview of Encryption Tools in SQL Server]:https://matthewmcgiffen.com/2017/12/05/overview-of-encryption-tools-in-sql-server/
[Clustered Index Uniquifier Existence and Size]:https://sqlquantumleap.com/2017/09/18/clustered-index-uniquifier-existence-and-size/
[Understanding Logging and Recovery in SQL Server]:https://technet.microsoft.com/en-us/library/2009.02.logging.aspx
[Understanding SQL Server Backups]:https://docs.microsoft.com/en-us/previous-versions/technet-magazine/dd822915(v=msdn.10)
[Recovering from Disasters Using Backups]:https://technet.microsoft.com/en-us/library/ee677581.aspx
[Simple SQL: Handling Location Datatypes]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/simple-sql-handling-location-datatypes/
[Improve SQL Server Performance by Looking at Plan Cache (Part 1)]:https://logicalread.com/sql-server-minimize-single-use-plans-tl01/
[Improve SQL Server Performance by Looking at Plan Cache (Part 2)]:https://logicalread.com/sql-server-identifying-plans-that-need-tuning-tl01/
[Improve SQL Server Performance by Looking at Plan Cache (Part 3)]:https://logicalread.com/sql-server-identify-similar-plans-tl01/
[Take Care When Scripting Batches]:http://michaeljswart.com/2014/09/take-care-when-scripting-batches/
[When Measuring Timespans, try DATEADD instead of DATEDIFF]:http://michaeljswart.com/2017/12/when-measuring-timespans-try-dateadd-instead-of-datediff/
[Which user function do I use?]:https://sqlstudies.com/2015/06/24/which-user-function-do-i-use/
[What’s So Bad About Shrinking Databases with DBCC SHRINKDATABASE?]:https://www.brentozar.com/archive/2017/12/whats-bad-shrinking-databases-dbcc-shrinkdatabase/
[Which Collation is Used to Convert NVARCHAR to VARCHAR in a WHERE Condition? (Part A of 2: “Duck”)]:https://sqlquantumleap.com/2017/12/08/which-collation-is-used-to-convert-nvarchar-to-varchar-in-a-where-condition-part-a-of-2-duck/
[Which Collation is Used to Convert NVARCHAR to VARCHAR in a WHERE Condition? (Part B of 2: “Rabbit”)]:https://sqlquantumleap.com/2017/12/11/which-collation-is-used-to-convert-nvarchar-to-varchar-in-a-where-condition-part-b-of-2-rabbit/#comments
[Current State of the NewSQL/NoSQL Cloud Arena]:https://www.red-gate.com/simple-talk/cloud/cloud-data/current-state-newsqlnosql-cloud-arena/
[SQL Server 2017: JSON]:http://db-devs.com/blog/archive/sql-server-2017-json/
[Simulating Bad Networks to Test SQL Server Replication]:https://www.red-gate.com/simple-talk/blogs/simulating-bad-networks-test-sql-server-replication/
[How to Turn on Instant File Initialization]:https://www.databasejournal.com/tips/how-to-turn-on-instant-file-initialization.html
[Bad Idea Jeans: Finding Undocumented Trace Flags]:https://rebrand.ly/brent-finding-undocumented-trace-flags
[A Method to Find Trace Flags]:https://rebrand.ly/joe-finding-undocumented-trace-flags
[Using Windows stored credentials to connect to SQL in containers]:https://dbafromthecold.com/2018/01/17/using-windows-stored-credentials-to-connect-to-sql-in-containers/
[Step by Step Guide to Migrate SQL Server Data to SQL Server 2017]:https://www.databasejournal.com/features/mssql/step-by-step-guide-to-migrate-sql-server-data-to-sql-server-2017.html
[Nasty Fast PERCENT_RANK]:http://www.sqlservercentral.com/articles/PERCENT_RANK/141532/
[Administrative Logins and Users]:https://sqlstudies.com/2015/11/02/administrative-logins-and-users/
[Parallelism in Hekaton (In-Memory OLTP)]:http://www.nikoport.com/2018/01/20/parallelism-in-hekaton-in-memory-oltp/
[Troubleshooting THREADPOOL Waits]:https://www.sqlpassion.at/archive/2011/10/25/troubleshooting-threadpool-waits/
[Andy’s Excellent SSIS-in-the-Cloud Adventure, Part 1 – Build an ADFv2 IR Instance]:https://andyleonard.blog/2018/01/andys-excellent-ssis-in-the-cloud-adventure-part-1/
[PRINT vs. RAISERROR]:http://sqlity.net/en/984/print-vs-raiserror/
[Does a Clustered Index Give a Default Ordering?]:https://sqlworkbooks.com/2018/02/does-a-clustered-index-give-a-default-ordering/
[Without ORDER BY, You Can’t Depend On the Order of Results]:http://michaeljswart.com/2013/09/without-order-by-you-cant-depend-on-the-order-of-results/
[Query Store and “in memory”]:https://www.sqlskills.com/blogs/erin/query-store-and-in-memory/
[Setting and Identifying Row Goals in Execution Plans]:https://sqlperformance.com/2018/02/sql-plan/setting-and-identifying-row-goals
[Azure and Windows PowerShell: The Basics]:https://www.red-gate.com/simple-talk/sysadmin/powershell/azure-windows-powershell-basics/
[Auditing Linked Servers]:https://thomaslarock.com/2018/02/auditing-linked-servers/
[An alternative to data masking]:https://sqlsunday.com/2018/02/05/an-alternative-to-data-masking/
[Safely and Easily Use High-Level Permissions Without Granting Them to Anyone: Server-level]:https://sqlquantumleap.com/2018/02/15/safely-and-easily-use-high-level-permissions-without-granting-them-to-anyone-server-level/
[PLEASE, Please, please Stop Using Impersonation, TRUSTWORTHY, and Cross-DB Ownership Chaining]:https://sqlquantumleap.com/2017/12/30/please-please-please-stop-using-impersonation-execute-as/
[Indexing and Partitioning]:https://dbafromthecold.com/2018/02/21/indexing-and-partitioning/
[Schema Compare for SQL Server]:https://thomaslarock.com/2018/02/schema-compare-for-sql-server/
[How to change SQL Server ERRORLOG location]:https://red9.com/sql-server-error-log-location/
[What’s in a Name?: Inside the Wacky World of T-SQL Identifiers]:https://sqlquantumleap.com/2018/04/09/whats-in-a-name-inside-the-wacky-world-of-t-sql-identifiers/
[The Uni-Code: The Search for the True List of Valid Characters for T-SQL Regular Identifiers, Part 1]:https://sqlquantumleap.com/2018/04/02/the-uni-code-the-search-for-the-true-list-of-valid-characters-for-t-sql-regular-identifiers-part-1/
[The Uni-Code: The Search for the True List of Valid Characters for T-SQL Regular Identifiers, Part 2]:https://sqlquantumleap.com/2018/04/04/the-uni-code-the-search-for-the-true-list-of-valid-characters-for-t-sql-regular-identifiers-part-2/
[Programming SQL Server with SQL Server Management Objects Framework]:https://www.red-gate.com/simple-talk/dotnet/c-programming/programming-sql-server-sql-server-management-objects-framework/
[Interval Queries in SQL Server]:http://www.itprotoday.com/software-development/interval-queries-sql-server
[Dealing with date and time instead of datetime]:https://sqlperformance.com/2018/03/sql-optimizer/dealing-with-date-and-time
[Insight into the SQL Server buffer cache]:https://www.sqlshack.com/insight-into-the-sql-server-buffer-cache/
[A concrete example of migration between an Oracle Database and SQL Server using Microsoft Data Migration Assistant]:https://www.sqlshack.com/a-concrete-example-of-migration-between-an-oracle-database-and-sql-server-using-microsoft-data-migration-assistant/
[Audit SQL Server stop, start, restart]:https://blogs.msdn.microsoft.com/skeeler/2018/03/audit-sql-server-stop-start-restart/
[Query tuning: Apply yourself]:https://sqltechblog.com/2018/04/06/query-tuning-apply-yourself/
[How to identify and monitor unused indexes in SQL Server]:https://www.sqlshack.com/how-to-identify-and-monitor-unused-indexes-in-sql-server/
[Benchmarking: 1-TB table population (part 1: the baseline)]:https://www.sqlskills.com/blogs/paul/benchmarking-1-tb-table-population-part-1-the-baseline/
[Benchmarking: 1-TB table population (part 2: optimizing log block IO size and how log IO works)]:https://www.sqlskills.com/blogs/paul/benchmarking-1-tb-table-population-part-2-optimizing-log-block-io-size-and-how-log-io-works/
[An overview of SQL Server database migration tools provided by Microsoft]:https://www.sqlshack.com/an-overview-of-sql-server-database-migration-tools-provided-by-microsoft/
[Calling Http endpoints in T-SQL using CURL extension]:https://blogs.msdn.microsoft.com/sqlserverstorageengine/2018/04/17/calling-http-endpoints-in-t-sql-using-curl-extension/
[Why Table Join Orders In Relational Databases]:https://hackernoon.com/why-table-join-orders-in-relational-databases-dont-matter-6de3a35f2959
[Finding overlapping ranges of data]:https://www.red-gate.com/simple-talk/blogs/finding-overlapping-ranges-data/
[Avoid use of the MONEY and SMALLMONEY datatypes]:https://www.red-gate.com/hub/product-learning/sql-prompt/avoid-use-money-smallmoney-datatypes
[Provisioning SQL Server Instances with Docker]:https://www.red-gate.com/simple-talk/sysadmin/containerization/provisioning-sql-server-instances-docker/
[Understanding the graphical representation of the SQL Server Deadlock Graph]:https://www.sqlshack.com/understanding-graphical-representation-sql-server-deadlock-graph/
[Digitally Signing a Stored Procedure To Allow It To Run With Elevated Permissions]:https://sqlundercover.com/2018/05/02/digitally-signing-a-stored-procedure-to-allow-it-to-run-with-elevated-permissions/
[NOLOCK and Top Optimization]:https://www.sqlshack.com/nolock-and-top-optimization/
[Operator Precedence versus the Confusing Constraint Translation]:https://www.red-gate.com/simple-talk/blogs/operator-precedence-versus-confusing-constraint-translation/
[Interval Queries in SQL Server]:http://www.itprotoday.com/software-development/interval-queries-sql-server
[Query Trace Column Values]:https://www.sqlshack.com/query-trace-column-values/
[Concurrency Week: How to Delete Just Some Rows from a Really Big Table]:https://www.brentozar.com/archive/2018/04/how-to-delete-just-some-rows-from-a-really-big-table/
[Break large delete operations into chunks]:https://sqlperformance.com/2013/03/io-subsystem/chunk-deletes
[How to perform a page level restore in SQL Server]:https://www.sqlshack.com/how-to-perform-a-page-level-restore-in-sql-server/
[Grouping dates without blocking operators]:https://sqlsunday.com/2018/05/14/grouping-dates-without-blocking-operators/
[What’s CHECKDB doing in my database restore?]:http://www.mikefal.net/2018/04/10/whats-checkdb-doing-in-my-database-restore/
[How To Hide An Instance Of SQL Server]:https://thomaslarock.com/2018/04/how-to-hide-an-instance-of-sql-server/
[Troubleshooting Parameter Sniffing Issues the Right Way: Part 1]:https://www.brentozar.com/archive/2018/03/troubleshooting-parameter-sniffing-issues-the-right-way-part-1/
[Troubleshooting Parameter Sniffing Issues the Right Way: Part 2]:https://www.brentozar.com/archive/2018/03/troubleshooting-parameter-sniffing-issues-right-way-part-2/
[Troubleshooting Parameter Sniffing Issues the Right Way: Part 3]:https://www.brentozar.com/archive/2018/03/troubleshooting-parameter-sniffing-issues-the-right-way-part-3/
[When to use the SELECT…INTO statement]:https://www.red-gate.com/hub/product-learning/sql-prompt/use-selectinto-statement
[Temp Tables In SSIS]:https://www.timmitchell.net/post/2018/05/29/temp-tables-in-ssis/
[Changing the Collation of the Instance, the Databases, and All Columns in All User Databases]:https://sqlquantumleap.com/2018/06/11/changing-the-collation-of-the-instance-and-all-columns-across-all-user-databases-what-could-possibly-go-wrong/
[10 Cool SQL Optimisations That do not Depend on the Cost Model]:https://blog.jooq.org/2017/09/28/10-cool-sql-optimisations-that-do-not-depend-on-the-cost-model/
[Scheduling powershell tasks with sql agent]:https://dbatools.io/agent/
[Three ways to track logins using dbatools]:https://dbatools.io/track-logins/
[Impact of Fragmentation on Execution Plans]:https://sqlperformance.com/2017/12/sql-indexes/impact-fragmentation-plans
[How to “debug” a Linked Server from SQL Server to an Oracle Database instance]:https://www.sqlshack.com/how-to-debug-a-linked-server-from-sql-server-to-an-oracle-database-instance/
[How to implement error handling in SQL Server]:https://www.sqlshack.com/how-to-implement-error-handling-in-sql-server/
[SQL Server Closure Tables]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/sql-server-closure-tables/
[Deadlock victim choice in SQL Server - an exception?]:http://joshthecoder.com/2018/05/10/deadlock-victim-choice-an-exception.html
[Azure and Windows PowerShell: The Basics]:https://www.red-gate.com/simple-talk/sysadmin/powershell/azure-windows-powershell-basics/
[Azure and Windows PowerShell: Getting Information]:https://www.red-gate.com/simple-talk/sysadmin/powershell/azure-and-windows-powershell-getting-information/
[Be our guest, be our guest, put our database to the test]:https://sqlstudies.com/2018/06/25/be-our-guest-be-our-guest-put-our-database-to-the-test/
[Finding code smells using SQL Prompt: the SET NOCOUNT problem (PE008 and PE009)]:https://www.red-gate.com/hub/product-learning/sql-prompt/finding-code-smells-using-sql-prompt-set-nocount-problem-pe008-pe009
[DATABASES 101 guide for the non-technical professional]:https://thomaslarock.com/2018/07/databases-101/
[Understanding your Azure EA Billing Data and Building a Centralized Data Storage Solution]:https://www.red-gate.com/simple-talk/cloud/cloud-data/understanding-your-azure-ea-billing-data-and-building-a-centralized-data-storage-solution/
[READ COMMITTED SNAPSHOT ISOLATION and High version_ghost_record_count]:https://www.red-gate.com/simple-talk/sql/performance/read-committed-snapshot-isolation-high-version_ghost_record_count/
[In-Memory OLTP Indexes – Part 1: Recommendations.]:https://blogs.msdn.microsoft.com/sqlserverstorageengine/2017/11/02/in-memory-oltp-indexes-part-1-recommendations/
[In-Memory OLTP Indexes – Part 2: Performance Troubleshooting Guide.]:https://blogs.msdn.microsoft.com/sqlserverstorageengine/2017/11/14/in-memory-oltp-indexes-part-2-performance-troubleshooting-guide/
[Optimization Thresholds – Grouping and Aggregating Data, Part 1]:https://sqlperformance.com/2018/04/sql-plan/grouping-and-aggregating-part-1
[Optimization Thresholds – Grouping and Aggregating Data, Part 2]:https://sqlperformance.com/2018/05/sql-plan/grouping-and-aggregating-part-2
[Optimization Thresholds – Grouping and Aggregating Data, Part 3]:https://sqlperformance.com/2018/06/sql-plan/grouping-and-aggregating-part-3
[Optimization Thresholds – Grouping and Aggregating Data, Part 4]:https://sqlperformance.com/2018/07/sql-performance/grouping-and-aggregating-part-4
[Optimization Thresholds – Grouping and Aggregating Data, Part 5]:https://sqlperformance.com/2018/08/sql-performance/grouping-and-aggregating-part-5
[When DBCC OpenTran doesn’t list all open transactions]:https://blogs.msdn.microsoft.com/mosharaf/2013/02/17/when-dbcc-opentran-doesnt-list-all-open-transactions/
[How I spot not-yet-documented features in SQL Server CTPs]:https://blogs.sentryone.com/aaronbertrand/fishing-for-features-in-ctps/
[More ways to discover changes in new versions of SQL Server]:https://blogs.sentryone.com/aaronbertrand/more-changes-sql-server/
[Tail-Log Backup and Restore in SQL Server]:https://www.sqlshack.com/tail-log-backup-and-restore-in-sql-server/
[Database Filegroup(s) and Piecemeal restores in SQL Server]:https://www.sqlshack.com/database-filegroups-and-piecemeal-restores-in-sql-server/
[Updating Statistics with Ola Hallengren’s Script]:https://www.sqlskills.com/blogs/erin/updating-statistics-with-ola-hallengrens-script/
[Interview questions on SQL Server database backups, restores and recovery – Part I]:https://www.sqlshack.com/interview-questions-on-sql-server-database-backups-restores-and-recovery-part-i/
[Interview questions on SQL Server database backups, restores and recovery – Part II]:https://www.sqlshack.com/interview-questions-on-sql-server-database-backups-restores-and-recovery-part-ii/
[Interview questions on SQL Server database backups, restores and recovery – Part III]:https://www.sqlshack.com/interview-questions-on-sql-server-database-backups-restores-and-recovery-part-iii/
[Can Rowstore Compression Beat Columnstore Compression?]:https://orderbyselectnull.com/2018/06/28/can-rowstore-compression-beat-columnstore-compression/
[Inside the Storage Engine: Anatomy of a record]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-anatomy-of-a-record/
[Inside the Storage Engine: Anatomy of an extent]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-anatomy-of-an-extent/
[Inside the Storage Engine: Anatomy of a page]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-anatomy-of-a-page/
[Inside the Storage Engine: IAM pages, IAM chains, and allocation units]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-iam-pages-iam-chains-and-allocation-units/
[Inside The Storage Engine: GAM, SGAM, PFS and other allocation maps]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-gam-sgam-pfs-and-other-allocation-maps/
[Disaster recovery 101: fixing a broken boot page]:https://www.sqlskills.com/blogs/paul/disaster-recovery-101-fixing-a-broken-boot-page/
[How to download a sqlservr.pdb symbol file]:https://www.sqlskills.com/blogs/paul/how-to-download-a-sqlservr-pdb-symbol-file/
[A cause of high-duration ASYNC_IO_COMPLETION waits]:https://www.sqlskills.com/blogs/paul/cause-high-duration-async_io_completion-waits/
[How to solve the Identity Crisis in SQL Server]:https://www.sqlshack.com/solve-identity-crisis-sql-server/
[Azure SQL Database Performance and Service Tiers Explained]:https://sqlperformance.com/2018/08/sql-performance/azure-sql-database-tiers
[What To Do When Wait Stats Don’t Help]:https://orderbyselectnull.com/2018/07/20/what-to-do-when-wait-stats-dont-help/
[SQL Server Brute Force Attack Detection: Part 1]:https://www.codeproject.com/Articles/1231882/SQL-Server-Brute-Force-Attack-Detection
[SQL Server Brute Force Attack Detection: Part 2]:https://www.codeproject.com/Articles/1236461/SQL-Server-Brute-Force-Attack-Detection-Part-2
[SQL Server Brute Force Attack Detection: Part 3]:https://www.codeproject.com/Articles/1232491/SQL-Server-Brute-Force-Attack-Detection-Part-2
[SQLCLR vs SQL Server 2017, Part 8: Is SQLCLR Deprecated in Favor of Python or R (sp_execute_external_script)?]:https://sqlquantumleap.com/2018/08/09/sqlclr-vs-sql-server-2017-part-8-is-sqlclr-deprecated-in-favor-of-python-or-r-sp_execute_external_script/
[Sql Server Agent For Azure Sql Database, Azure Elastic Database Pools & Azure Managed Instance]:https://swyssql.wordpress.com/2018/07/20/sql-server-agent-for-azure-sql-database-azure-elastic-database-pools-azure-managed-instance/
[Storage performance best practices and considerations for Azure SQL DB Managed Instance (General Purpose)]:https://blogs.msdn.microsoft.com/sqlcat/2018/07/20/storage-performance-best-practices-and-considerations-for-azure-sql-db-managed-instance-general-purpose/
[T-SQL Tuesday #017: APPLY: It Slices! It Dices! It Does It All!]:http://bradsruminations.blogspot.com/2011/04/t-sql-tuesday-017-it-slices-it-dices-it.html
[SQL Server Encryption, What’s The Key Hierarchy All About?]:https://sqlundercover.com/2018/08/09/sql-server-encryption-whats-the-key-hierarchy-all-about/
[Overview of the SQLCMD utility in SQL Server]:https://www.sqlshack.com/overview-of-the-sqlcmd-utility-in-sql-server/
[The BCP (Bulk Copy Program) command in action]:https://www.sqlshack.com/bcp-bulk-copy-program-command-in-action/
[Measuring Query Execution Time]:https://www.scarydba.com/2018/08/13/measuring-query-execution-time/
[How to Check Performance on a New SQL Server]:https://www.brentozar.com/archive/2018/08/how-to-check-performance-on-a-new-sql-server/
[Questions About Kerberos and SQL Server That You Were Too Shy to Ask]:https://www.red-gate.com/simple-talk/sql/database-administration/questions-about-kerberos-and-sql-server-that-you-were-too-shy-to-ask/
[SQL Server Execution Plans overview]:https://www.sqlshack.com/sql-server-execution-plans-overview/
[SQL Server Execution Plans types]:https://www.sqlshack.com/sql-server-execution-plans-types/
[How to Analyze SQL Execution Plan Graphical Components]:https://www.sqlshack.com/how-to-analyze-sql-execution-plan-graphical-components/
[Query optimization techniques in SQL Server: the basics]:https://www.sqlshack.com/query-optimization-techniques-in-sql-server-the-basics/
[Query optimization techniques in SQL Server: tips and tricks]:https://www.sqlshack.com/query-optimization-techniques-in-sql-server-tips-and-tricks/
[Query optimization techniques in SQL Server: Database Design and Architecture]:https://www.sqlshack.com/query-optimization-techniques-in-sql-server-database-design-and-architecture/
[SQL Query Optimization Techniques in SQL Server: Parameter Sniffing]:https://www.sqlshack.com/query-optimization-techniques-in-sql-server-parameter-sniffing/
[Similarities and Differences among RANK, DENSE_RANK and ROW_NUMBER Functions]:https://codingsight.com/similarities-and-differences-among-rank-dense_rank-and-row_number-functions/
[Temporal Tables Under The Covers]:https://bornsql.ca/blog/temporal-tables-under-the-covers/
[Faking Temporal Tables with Triggers]:https://bertwagner.com/2018/09/11/faking-temporal-tables-with-triggers/
[SQL queries to manage hierarchical or parent-child relational rows in SQL Server]:https://www.codeproject.com/Articles/818694/SQL-queries-to-manage-hierarchical-or-parent-child
[Choosing Between Table Variables and Temporary Tables]:https://www.red-gate.com/hub/product-learning/sql-prompt/choosing-table-variables-temporary-tables
[What's New in the First Public CTP of SQL Server 2019]:https://www.mssqltips.com/sqlservertip/5710/whats-new-in-the-first-public-ctp-of-sql-server-2019/
[SQL Server support for TLS 1.2 – Read This First!]:https://blogs.sentryone.com/aaronbertrand/tls-1-2-support-read-first/
[Misconceptions in SQL Server: A Trio of table variables]:https://sqlinthewild.co.za/index.php/2010/10/12/a-trio-of-table-variables/
[Using the Same Column Twice in a SQL UPDATE Statement]:https://www.sqltheater.com/blog/using-the-same-column-twice-in-an-update-statement/
[How to perform a performance test against a SQL Server instance]:https://www.sqlshack.com/how-to-perform-a-performance-test-against-a-sql-server-instance/
[The Black Art Of Spatial Index Tuning In SQL Server]:http://boomphisto.blogspot.com/2011/04/black-art-of-spatial-index-tuning-in.html
[Patching SQL Server on Windows notes from the field]:https://www.kevinrchant.com/2019/01/10/patching-sql-server-on-windows-notes-from-the-field/
[Availability Group Readable Secondaries – Just Say No]:https://www.sqlskills.com/blogs/jonathan/availability-group-readable-secondaries-just-say-no/
[Finding the Slowest Query in a Stored Procedure]:https://www.sqlskills.com/blogs/erin/slowest-query-in-a-stored-procedure/
[A Monumental Migration to SQL Server 2016 – Part 1]:https://flxsql.com/monumental-migration-sql-server-2016-part-1/
[A Monumental Migration to SQL Server 2016 – Part 2]:https://flxsql.com/monumental-migration-sql-server-2016-part-2/
[A unique review of SQL Server index types]:https://www.kevinrchant.com/2018/10/18/a-unique-review-of-sql-server-index-types/
[Don’t Just Rely on Query Execution Stats for T-SQL Execution]:https://matthewmcgiffen.com/2018/09/18/dont-just-rely-on-query-execution-stats-for-t-sql-execution/
[Posting SQL Server notifications to Slack]:https://alessandroalpi.blog/2018/09/19/posting-sql-server-notifications-to-slack/
[How to create DACPAC file?]:https://sqlplayer.net/2018/10/how-to-create-dacpac-file/
[Find the Next Non-NULL Row in a Series With SQL]:https://blog.jooq.org/2018/09/03/find-the-next-non-null-row-in-a-series-with-sql/
[Calculate Percentiles to Learn About Data Set Skew in SQL]:https://blog.jooq.org/2019/01/22/calculate-percentiles-to-learn-about-data-set-skew-in-sql/
[Comparing multiple rows insert vs single row insert with three data load methods]:https://www.red-gate.com/simple-talk/sql/performance/comparing-multiple-rows-insert-vs-single-row-insert-with-three-data-load-methods/
[The Cause of Every Deadlock in SQL Server]:https://thomaslarock.com/2018/09/the-cause-of-every-deadlock-in-sql-server/
[Deadlock Troubleshooting, Part 1]:https://blogs.msdn.microsoft.com/bartd/2006/09/08/deadlock-troubleshooting-part-1/
[Deadlock Troubleshooting, Part 2]:https://blogs.msdn.microsoft.com/bartd/2006/09/12/deadlock-troubleshooting-part-2/
[Deadlock Troubleshooting, Part 3]:https://blogs.msdn.microsoft.com/bartd/2006/09/25/deadlock-troubleshooting-part-3/
[The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 1]:https://milossql.wordpress.com/2018/10/04/the-good-the-bad-and-the-ugly-of-table-variable-deferred-compilation-part-1/
[The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 2]:https://milossql.wordpress.com/2018/10/05/the-good-the-bad-and-the-ugly-of-table-variable-deferred-compilation-part-2/
[The Good, the Bad and the Ugly of Table Variable Deferred Compilation – Part 3]:https://milossql.wordpress.com/2018/10/08/the-good-the-bad-and-the-ugly-of-table-variable-deferred-compilation-part-3/
[Creating a SQL Server 2019 Demo Environment in a Docker Container]:https://www.cathrinewilhelmsen.net/2018/12/02/sql-server-2019-docker-container/
[Overview of Data Compression in SQL Server]:https://codingsight.com/overview-of-data-compression-in-sql-server/
[SQL Server Hash Match Operator]:https://sqlserverfast.com/epr/hash-match/
[How to use Microsoft Assessment and Planning (MAP) Toolkit for SQL Server]:https://www.sqlshack.com/how-to-use-microsoft-assessment-and-planning-map-toolkit-for-sql-server/
[Improve the Performance of Your Azure SQL Database (and Save Money!) with Automatic Tuning]:https://www.red-gate.com/simple-talk/sql/azure-sql-database/improve-the-performance-of-your-azure-sql-database-and-save-money-with-automatic-tuning/
[The Importance of Database Compatibility Level in SQL Server]:https://www.sqlskills.com/blogs/glenn/the-importance-of-database-compatibility-level-in-sql-server/
[Azure Managed vs Unmanaged disks : The choice]:https://buildwindows.wordpress.com/2017/05/31/azure-managed-vs-unmanaged-disks-the-choice/
[Storage options for SQL Server database files in Azure]:https://www.jamesserra.com/archive/2019/01/storage-options-for-sql-server-database-files-in-azure/
[The Performance of Window Aggregates Revisited with SQL Server 2019]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/the-performance-of-window-aggregates-revisited-with-sql-server-2019/
[Super Scaling Singleton Inserts]:https://chrisadkin.io/2015/02/19/super-scaling-singleton-inserts/
[Preparation for SQL Server Installation]:https://sqlplayer.net/2018/12/preparation-for-sql-server-installation/
[Executing xp_cmdshell with Non SysAdmin Account]:http://www.lucasnotes.com/2019/01/executing-xpcmdshell-with-non-sysadmin.html
[Generating SQL using Biml (T-SQL Tuesday #110)]:https://www.cathrinewilhelmsen.net/2019/01/08/generating-sql-using-biml/
[Avoiding SQL Server Upgrade Performance Issues]:https://www.sqlskills.com/blogs/glenn/avoiding-sql-server-upgrade-performance-issues/
[Using Temporary Procedures]:https://www.red-gate.com/simple-talk/blogs/using-temporary-procedures/
[Introduction to SQL Server Security — Part 1]:https://www.red-gate.com/simple-talk/sysadmin/data-protection-and-privacy/introduction-to-sql-server-security-part-1/
[Introduction to SQL Server Security — Part 2]:https://www.red-gate.com/simple-talk/sysadmin/data-protection-and-privacy/introduction-to-sql-server-security-part-2/
[Introduction to SQL Server Security — Part 3]:https://www.red-gate.com/simple-talk/sysadmin/data-protection-and-privacy/introduction-to-sql-server-security-part-3/
[Introduction to SQL Server Security — Part 4]:https://www.red-gate.com/simple-talk/sysadmin/data-protection-and-privacy/introduction-to-sql-server-security-part-4/
[Introduction to T-SQL Window Functions]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/introduction-to-t-sql-window-functions/
[Intro to Debugging a Memory Dump]:https://blogs.msdn.microsoft.com/psssql/2012/03/15/intro-to-debugging-a-memory-dump/
[Considering Security with SQL Bulk Insert]:https://www.sqlshack.com/considering-security-with-sql-bulk-insert/
[SQL Server 2012 AlwaysOn – Part 11 – Performance Aspects and Performance Monitoring I]:https://blogs.msdn.microsoft.com/saponsqlserver/2013/04/21/sql-server-2012-alwayson-part-11-performance-aspects-and-performance-monitoring-i/
[SQL Server 2012 AlwaysOn – Part 11 – Performance Aspects and Performance Monitoring II]:https://blogs.msdn.microsoft.com/saponsqlserver/2013/04/24/sql-server-2012-alwayson-part-12-performance-aspects-and-performance-monitoring-ii/
[Data Compression Internals]:https://jesspomfret.com/data-compression-internals/
[SQL Server Data Compression – Crunch Time!]:https://www.mlakartechtalk.com/sql-server-data-compression-crunch-time/
[Create a slipstream installer for SQL Server on Windows]:https://bornsql.ca/blog/create-a-slipstream-installer-for-sql-server-on-windows/
[Temporary Tables in SQL Server]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/temporary-tables-in-sql-server/
[SQL unit testing with the tSQLt framework for beginners]:https://www.sqlshack.com/sql-unit-testing-with-the-tsqlt-framework-for-beginners/
[Oracle vs. SQL Server Architecture]:https://dbakevlar.com/2019/03/oracle-vs-sql-server-architecture/
[Oracle RAC vs. SQL Server AG]:https://dbakevlar.com/2019/03/oracle-rac-vs-sql-server-ag/
[SSIS vs. Oracle GG]:https://dbakevlar.com/2019/04/ssis-vs-oracle-gg/
[Analysis Services Telemetry: What information does SSAS submit? and how has it changed in SSAS 2019?]:https://shabnamwatson.wordpress.com/2019/04/13/analysis-services-telemetry-what-information-does-ssas-submit-and-how-has-it-changed-in-ssas-2019/
[The Curious Case of… how to find FILESTREAM info from an MDF]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-how-to-find-filestream-info-from-an-md
[Does index fragmentation matter?]:http://sqlblog.karaszi.com/does-index-fragmentation-matter/
[How to perform a Page Level Restore in SQL Server]:https://sqlperfmon.blogspot.com/2016/07/how-to-perform-page-level-restore-in.html
[How Much Memory Does SSIS Need?]:https://www.timmitchell.net/post/2019/05/02/how-much-memory-does-ssis-need/
[The Curious Case of… trying to find an MDF file in a RAW disk]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-trying-to-find-an-mdf-file-in-a-raw-disk/
[Understanding the SQL Server NOLOCK hint]:https://www.mssqltips.com/sqlservertip/2470/understanding-the-sql-server-nolock-hint/
[Methods to Insert Data into SQL Server]:https://www.sqlshack.com/methods-to-insert-data-into-sql-server/
[Batching data manipulation is great as long as you do it correctly]:http://desertdba.com/batching-data-manipulation-is-great/
[Azure and Windows PowerShell: Using VM Extensions]:https://www.red-gate.com/simple-talk/sysadmin/powershell/azure-and-windows-powershell-using-vm-extensions/
[Reloading fact tables with zero downtime]:https://sqlsunday.com/2014/08/24/reloading-fact-tables-with-zero-downtime/
[Transferring Data Efficiently by Using Partition Switching]:https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms191160(v=sql.105)
[Another Difference between N'' and '' in SQL Server]:https://nocolumnname.blog/2018/10/24/another-difference-between-n-and-in-sql-server/
[Ignoring NULLs with FIRST_VALUE]:https://bertwagner.com/2018/08/28/ignoring-nulls-with-first-value/
[Shortchanged with International Money in SQL Server]:https://bertwagner.com/2018/09/25/try-parse-convert-strings-to-numbers/
[Understanding database recovery with SQL Server 2016 Extended Events]:https://www.mssqltips.com/sqlservertip/4339/understanding-database-recovery-with-sql-server-2016-extended-events/
[SQL Server 2019: Batch Mode on Rowstore]:http://www.queryprocessor.com/batch-mode-on-row-store/
[Using Indexing To Solve Blocking and Deadlocking Issues]:https://sqlundercover.com/2019/03/05/using-indexing-to-solve-blocking-and-deadlocking-issues/
[Change collation of existing Azure SQL database]:https://blogs.msdn.microsoft.com/azuresqldbsupport/2018/11/09/change-collation-of-existing-azure-sql-database/
[Creating Database Maintenance Plans]:https://codingsight.com/creating-database-maintenance-plans/
[SQL Server Upgrade Checklist]:https://straightpathsql.com/archives/2019/03/sql-server-upgrade-checklist/
[Failing a PowerShell Sql Agent step]:https://stuart-moore.com/failing-a-powershell-sql-agent-step/
[The Curse of Cursor Options]:https://www.brentozar.com/archive/2018/11/the-curse-of-cursor-options/
[Accelerated Database Recovery; Instant Rollback and Database Recovery]:https://www.sqlshack.com/accelerated-database-recovery-instant-rollback-and-database-recovery/
[Accelerated Database Recovery and Long Running Transactions with Transaction Log Growth]:https://www.sqlshack.com/accelerated-database-recovery-and-long-running-transactions-with-transaction-log-growth/
[Using docker named volumes to persist databases in SQL Server]:https://dbafromthecold.com/2019/03/21/using-docker-named-volumes-to-persist-databases-in-sql-server/
[T-SQL bugs, pitfalls, and best practices – determinism]:https://sqlperformance.com/2019/03/t-sql-queries/bugs-pitfalls-best-practices-determinism
[Grouped Concatenation in SQL Server]:https://sqlperformance.com/2014/08/t-sql-queries/sql-server-grouped-concatenation
[Working with tempdb in SQL Server 2005]:https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2005/administrator/cc966545(v%3dtechnet.10)
[SQLskills SQL101: Temporary table misuse]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-temporary-table-misuse/
[Running SQL Server on Linux on your own laptop]:https://www.kevinrchant.com/2019/03/26/running-sql-server-on-linux-on-your-own-laptop/
[SSIS and Pentaho – A Quick Comparison]:https://sqlkover.com/ssis-and-pentaho-a-quick-comparison/
[WinDbg and SQL Server Fun]:https://blobeater.blog/2017/06/14/windbg-and-sql-server-fun/
[Certificates, Proxies and Jobs! Oh My!]:https://sqlstudies.com/2016/04/27/certificates-proxies-and-jobs-oh-my/
[SQL Server: Diagnosing Intermittent Connectivity Issues]:https://mitchwheat.com/2019/04/12/sql-server-diagnosing-intermittent-connectivity-issues/
[Difference between Identity & Sequence in SQL Server]:https://www.sqlshack.com/difference-between-identity-sequence-in-sql-server/
[Does the Rowmodctr Update for Non-Updating Updates?]:https://www.brentozar.com/archive/2019/05/does-the-rowmodctr-update-for-non-updating-updates/
[An Intro To Data Modeling]:https://donedifferent.data.blog/2019/04/12/an-intro-to-data-modeling/
[On telemetry and other data collected by SQL Server]:https://blogs.sentryone.com/aaronbertrand/sql-server-telemetry/
[Purging data with batched deletes]:https://am2.co/2019/04/purging-data-with-batched-deletes/
[Don’t Forget RoboCopy]:https://sqlrus.com/2019/05/dont-forget-robocopy/
[Understanding the XML description of the Deadlock Graph in SQL Server]:https://www.sqlshack.com/understanding-the-xml-description-of-the-deadlock-graph-in-sql-server/
[What Is The Difference Between Checkpoint And Lazy Writer]:https://saurabhsinhainblogs.blogspot.com/2012/10/interview-question-checkpoint-and-lazy.html?m=1
[Efficiently Indexing Long Character Strings]:https://voluntarydba.com/2013/07/30/efficiently-indexing-long-character-strings/
[SQL Server Read-only tables]:https://sqlstudies.com/2019/01/21/read-only-tables/
[Slow inserts across a linked server?]:https://www.sqlserverscience.com/performance/slow-inserts-across-linked-server/
[Using IGNORE NULLS With SQL Window Functions to Fill Gaps]:https://blog.jooq.org/2019/04/24/using-ignore-nulls-with-sql-window-functions-to-fill-gaps/
[SQL Server Logical Reads]:http://www.sql-server-performance.com/logical-reads/
[Two Words For Faster Scalar Functions]:https://bertwagner.com/2018/12/04/two-words-for-faster-scalar-functions/
[How to Get SQL Server Dates and Times Horribly Wrong]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/how-to-get-sql-server-dates-and-times-horribly-wrong/
[Diagnosing and Resolving Spinlock Contention on SQL Server]:http://download.microsoft.com/download/D/A/A/DAAD63AF-B06F-4F29-AF1D-68A78102ABF4/SQLServerSpinlockContention.pdf
[Diagnosing and Resolving Latch Contention on SQL Server]:http://download.microsoft.com/download/B/9/E/B9EDF2CD-1DBF-4954-B81E-82522880A2DC/SQLServerLatchContention.pdf
[Advanced Nutanix: SQL Server on Nutanix Best Practices Released!]:http://stevenpoitras.com/2013/11/advanced-nutanix-sql-server-nutanix-best-practices-released/
[Gaps and Islands Across Date Ranges]:https://bertwagner.com/2019/03/12/gaps-and-islands/
[NOT NULL Persisted Computed Columns (And What They Allow)]:https://www.red-gate.com/simple-talk/blogs/not-null-persisted-computed-columns-and-what-they-allow/
[How many ways are there to sort GUIDs? How much time do you have?]:https://devblogs.microsoft.com/oldnewthing/20190426-00/?p=102450
[How do I force a SQL Login to change it’s password on next login]:https://sqlstudies.com/2019/06/05/how-do-i-force-a-sql-login-to-change-its-password-on-next-login/
[SQL Server Performance Benchmarking with Patterns]:https://www.sqlservercentral.com/articles/sql-server-performance-benchmarking-with-patterns
[SQL Server function to convert integer date to datetime format]:https://www.mssqltips.com/sqlservertip/1712/sql-server-function-to-convert-integer-date-to-datetime-format/
[Storing Utc Is Not A Silver Bullet]:https://codeblog.jonskeet.uk/2019/03/27/storing-utc-is-not-a-silver-bullet/
[Logical Query Processing Part 8 : SELECT and ORDER BY]:https://www.itprotoday.com/sql-server/logical-query-processing-part-8-select-and-order
[SQL Server Common Table Expression vs Temp Table]:https://www.mssqltips.com/sqlservertip/6040/sql-server-common-table-expression-vs-temp-table/
[Which Query Used The Most Cpu? Implementing Extended Events]:https://www.scarydba.com/2019/06/03/which-query-used-the-most-cpu-implementing-extended-events/
[SQL Server Plan Cache Limits]:https://www.sqlskills.com/blogs/erin/sql-server-plan-cache-limits/
[SQL Server and ReFS: Part 1 – DBCC and In Memory OLTP]:https://swasheck.wordpress.com/2014/11/11/sql-server-and-refs-part-1-dbcc-and-in-memory-oltp/
[SQL Server and ReFS: Part 2 – FIO Benchmarking NTFS vs. ReFS]:https://swasheck.wordpress.com/2014/12/18/sql-server-and-refs-part-2-fio-benchmarking-ntfs-vs-refs/
[Why Rolling back inserts with Identity columns is a bad idea]:https://sqlundercover.com/2019/04/11/rolling-back-inserts-with-identity-columns/
[What’s Better, CTEs or Temp Tables?]:https://www.brentozar.com/archive/2019/06/whats-better-ctes-or-temp-tables/
[The Difference Between SQL’s JOIN .. ON Clause and the Where Clause]:https://blog.jooq.org/2019/04/09/the-difference-between-sqls-join-on-clause-and-the-where-clause/
[My IT department installed an antivirus with SQL Server]:https://bornsql.ca/blog/my-it-department-installed-an-antivirus-with-sql-server/
[An Experiment with Deadlocks - ROWLOCK hint myth]:http://jasonbrimhall.info/2019/03/25/an-experiment-with-deadlocks/
[Adding a New Transaction Log File when the Existing Log is Full]:https://www.sqlserverscience.com/internals/adding-new-transaction-log-file-when-existing-log-full/
[Transactions Don't Start At BEGIN TRAN]:https://www.joshthecoder.com/2019/06/05/transactions-dont-start-at-begin-tran.html
[CAST/CONVERT makes expressions nullable]:https://sqlsunday.com/2019/06/05/cast-convert-makes-expressions-nullable/
[Deciding between COALESCE and ISNULL in SQL Server]:https://www.mssqltips.com/sqlservertip/2689/deciding-between-coalesce-and-isnull-in-sql-server/]
[How do you choose which columns to include in your SQL Server clustered index?]:https://the.agilesql.club/2019/06/how-do-you-choose-which-columns-to-include-in-your-sql-server-clustered-index/
[A ever-increasing Clustered Key value doesn’t scale]:https://www.sqlpassion.at/archive/2014/04/15/an-ever-increasing-clustered-key-value-doesnt-scale/
[SQL Server Bit reversion]:https://dangerousdba.blogspot.com/2011/10/bit-reversion.html
[Troubleshooting a renamed SQL Server]:https://blog.wicktech.net/troubleshooting-a-renamed-sql-server/
[Are Differential Backups Necessary?]:https://blog.wicktech.net/differential-backups/
[Updating Statistics on Secondary Replicas of the Availability Groups]:http://www.nikoport.com/2019/06/20/updating-statistics-on-secondary-replicas-of-the-availability-groups/
[It’s interesting how an OR short circuits]:https://sqlstudies.com/2019/06/17/its-interesting-how-an-or-short-circuits/
[SQL Server NOLOCK Anomalies, Issues and Inconsistencies]:https://www.mssqltips.com/sqlservertip/6072/sql-server-nolock-anomalies-issues-and-inconsistencies/
[Choosing a Database for Serverless Applications]:https://serverless.com/blog/choosing-a-database-with-serverless/
[SQL Server On Linux: Forced Unit Access (Fua) Internals]:http://bobsql.com/sql-server-on-linux-forced-unit-access-fua-internals/
[Socrates: The New SQL Server in the Cloud]:https://www.microsoft.com/en-us/research/uploads/prod/2019/05/socrates.pdf
[What permissions do temp stored procedures use?]:https://sqlstudies.com/2019/06/19/what-permissions-do-temp-stored-procedures-use/
[Common SQL Server Mishaps]:https://sqlperformance.com/2019/06/sql-performance/common-sql-server-mishaps
[SQL Server Agent for SQL Express on Linux]:https://www.sqlservercentral.com/articles/sql-server-agent-for-sql-express-on-linux
[Trailing Spaces in SQL Server]:https://bertwagner.com/2019/06/18/trailing-spaces-in-sql-server/
[Troubleshooting a Change in Query Performance]:https://www.sqlskills.com/blogs/erin/troubleshooting-a-change-in-query-performance/
[The Silent Bug I Find in Most Triggers]:https://www.brentozar.com/archive/2019/05/the-silent-bug-i-find-in-most-triggers/
[How to Copy a Table in SQL Server to Another Database]:https://www.mssqltips.com/sqlservertip/6009/how-to-copy-a-table-in-sql-server-to-another-database/
[Configuration of SQL Server instance]:https://sqlplayer.net/2019/06/configuration-of-sql-server-instance/
[What is the SQL Server Virtual Log file and how to monitor it]:https://www.sqlshack.com/what-is-sql-server-virtual-log-file-and-how-to-monitor-it/
[Important change to VLF creation algorithm in SQL Server 2014]:https://www.sqlskills.com/blogs/paul/important-change-vlf-creation-algorithm-sql-server-2014/
[SQL Server Transaction Log Fragmentation: a Primer]:https://www.red-gate.com/simple-talk/sql/database-administration/sql-server-transaction-log-fragmentation-a-primer/
[8 Steps to better Transaction Log throughput]:https://www.sqlskills.com/blogs/kimberly/8-steps-to-better-transaction-log-throughput/
[Joins With OR Clauses = 💔]:https://erikdarlingdata.com/2019/06/joins-with-or-clauses-%F0%9F%92%94/
[Thoughts on MAXDOP]:https://erikdarlingdata.com/2019/06/thoughts-on-maxdop/
[What the Arrow Sizes in Query Plans Really Mean]:https://www.brentozar.com/archive/2019/06/what-the-arrow-sizes-in-query-plans-really-mean/
[Query Store Best Practices]:https://www.sqlskills.com/blogs/erin/query-store-best-practices/
[Introduction to Data Normalization: A Database "Best" Practice]:http://agiledata.org/essays/dataNormalization.html
[Dr. OUTPUT or: How I Learned to Stop Worrying and Love the MERGE]:http://dataeducation.com/dr-output-or-how-i-learned-to-stop-worrying-and-love-the-merge/
[SQL Server Tipping Games – Why Non-Clustered Indexes are just ignored!]:https://www.sqlpassion.at/archive/2013/06/12/sql-server-tipping-games-why-non-clustered-indexes-are-just-ignored/
[SQL Server Guide To NULL Handling]:https://gavindraper.com//2018/11/29/SQL-Server-Guide-To-NULL-Handling/
[Living with SQL’s 900 Byte Index Key Length Limit]:https://blogs.msdn.microsoft.com/bartd/2011/01/06/living-with-sqls-900-byte-index-key-length-limit/
[Memory-Optimized TempDB Metadata in SQL Server 2019]:https://www.sqlshack.com/memory-optimized-tempdb-metadata-in-sql-server-2019/
[Forcing A Plan That Has A Plan Guide]:https://www.scarydba.com/2018/11/26/forcing-a-plan-that-has-a-plan-guide/
[Remember the Default Window]:https://voiceofthedba.com/2018/08/23/remember-the-default-window/
[The Impact of Non-Updating Updates]:https://www.sql.kiwi/2010/08/the-impact-of-non-updating-updates.html
[What are Columnstore Indexes?]:https://www.red-gate.com/simple-talk/sql/sql-development/what-are-columnstore-indexes/
[PolyBase in SQL Server 2019 – The End of ETL?]:https://www.red-gate.com/simple-talk/sql/data-platform/polybase-in-sql-server-2019-the-end-of-etl/
[Overview of Service Principal Name and Kerberos authentication in SQL Server]:https://www.sqlshack.com/overview-of-service-principal-name-and-kerberos-authentication-sql-server/
[Data Transfer Strategies between MongoDB and SQL Server]:https://www.sqlservercentral.com/articles/data-transfer-strategies-between-mongodb-and-sql-server
[SQL Server and Excel Hierarchyid Example for Organization Charts]:https://www.mssqltips.com/sqlservertip/6054/sql-server-and-excel-hierarchyid-example-for-organization-charts/
[Difference between sp_execute and sp_executesql and exec]:https://www.sqlindia.com/difference-between-sp_execute-sp_executesql-exec/
[EXEC and sp_executesql – how are they different?]:https://www.sqlskills.com/blogs/kimberly/exec-and-sp_executesql-how-are-they-different/
[Little Bobby Tables, SQL Injection and EXECUTE AS]:https://www.sqlskills.com/blogs/kimberly/little-bobby-tables-sql-injection-and-execute-as/
[Examining the Performance Impact of an Adhoc Workload]:https://sqlperformance.com/2019/05/sql-plan/perf-impact-adhoc-workload
[Backup to URL]:https://blog.coeo.com/backup-to-url
[Spotting Unauthorized Configuration Settings in SQL Server]:https://www.red-gate.com/hub/product-learning/sql-monitor/spotting-unauthorized-configuration-settings-sql-server
[Window Functions in SQL Server]:https://www.red-gate.com/simple-talk/sql/learn-sql-server/window-functions-in-sql-server/
[Window Functions in SQL Server: Part 2-The Frame]:https://www.red-gate.com/simple-talk/sql/learn-sql-server/window-functions-in-sql-server-part-2-the-frame/
[An Intro to SQL Window Functions]:https://www.toptal.com/sql/intro-to-sql-windows-functions
[SQL Database Performance Tuning for Developers]:https://www.toptal.com/sql-server/sql-database-tuning-for-developers
[“But NOLOCK Is Okay When The Data Isn’t Changing, Right?”]:https://www.brentozar.com/archive/2019/08/but-nolock-is-okay-when-the-data-isnt-changing-right/
[tempdb Enhancements in SQL Server 2019]:https://sqlperformance.com/2019/08/tempdb/tempdb-enhancements-in-sql-server-2019
[Feature Restrictions in SQL Server 2019 are Worse Than Useless: a False Sense of Security And Wasted Opportunity]:https://sqlquantumleap.com/2019/08/05/feature-restrictions-in-sql-server-2019-are-worse-than-useless-a-false-sense-of-security-and-wasted-opportunity/
[How to get SQL Server Sysadmin Privileges as a Local Admin with PowerUpSQL]:https://blog.netspi.com/get-sql-server-sysadmin-privileges-local-admin-powerupsql/
[Views of the Same Problem: Network Admin, DBA, and Developer]:https://blog.serverfault.com/2011/03/16/views-of-the-same-problem-network-admin-dba-and-developer/
[The SQL Server Data Row Size Question: Why is It Bigger?]:https://sqlworkbooks.com/2019/03/the-sql-server-data-row-size-question-why-is-it-bigger/
[Finding Max Concurrent Operations With T-SQL (Part 1)]:https://36chambers.wordpress.com/2019/01/02/finding-max-concurrent-operations-with-t-sql-part-1/
[Finding Max Concurrent Operations With T-SQL (Part 2)]:https://36chambers.wordpress.com/2019/01/03/finding-max-concurrent-operations-with-t-sql-part-2/
[Stack Overflow: The Architecture - 2016 Edition]:https://nickcraver.com/blog/2016/02/17/stack-overflow-the-architecture-2016-edition/
[Stack Overflow: The Hardware - 2016 Edition]:https://nickcraver.com/blog/2016/03/29/stack-overflow-the-hardware-2016-edition/
[Stack Overflow: How We Do Deployment - 2016 Edition]:https://nickcraver.com/blog/2016/05/03/stack-overflow-how-we-do-deployment-2016-edition/
[Stack Overflow: How We Do Monitoring - 2018 Edition]:https://nickcraver.com/blog/2018/11/29/stack-overflow-how-we-do-monitoring/
[Stack Overflow: How We Do App Caching - 2019 Edition]:https://nickcraver.com/blog/2019/08/06/stack-overflow-how-we-do-app-caching/
[Adding a Missing Index Killed Performance]:https://www.sqlrx.com/missing-index-killed-performance/
[Corruption in TempDB]:https://stevestedman.com/2019/08/corruption-in-tempdb/
[Corruption recovery using DBCC WRITEPAGE]:https://www.sqlskills.com/blogs/paul/corruption-recovery-using-dbcc-writepage/
[Why DBCC CHECKDB can miss memory corruption]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-why-dbcc-checkdb-can-miss-memory-corruption/
[Fixing Cardinality Estimation Errors with Filtered Statistics]:https://www.sqlpassion.at/archive/2013/10/29/fixing-cardinality-estimation-errors-with-filtered-statistics/
[Plan Stitch: Harnessing the Best of Many Plans]:https://www.microsoft.com/en-us/research/publication/plan-stitch-harnessing-the-best-of-many-plans-2/
[Query and Resource Optimization: Bridging the Gap]:https://www.microsoft.com/en-us/research/publication/query-resource-optimization-bridging-gap/
[Cuttlefish: A Lightweight Primitive for Adaptive Query Processing]:https://www.microsoft.com/en-us/research/publication/cuttlefish-a-lightweight-primitive-for-adaptive-query-processing/
[Leveraging Re-costing for Online Optimization of Parameterized Queries with Guarantees]:https://www.microsoft.com/en-us/research/publication/leveraging-re-costing-online-optimization-parameterized-queries-guarantees/
[How to choose antivirus software to run on computers that are running SQL Server]:https://support.microsoft.com/help/309422
[Why is SYSDATETIME() slower than SYSUTCDATETIME()?]:https://erikdarlingdata.com/2019/05/why-is-sysdatetime-slower-than-sysutcdatetime/
[Constant Time Recovery in Azure SQL Database]:https://www.microsoft.com/en-us/research/publication/constant-time-recovery-in-azure-sql-database/
[Improving Optimistic Concurrency Control Through Transaction Batching and Operation Reordering]:https://www.microsoft.com/en-us/research/publication/improving-optimistic-concurrency-control-through-transaction-batching-and-operation-reordering/
[An Empirical Evaluation of In-Memory Multi-Version Concurrency Control]:https://www.cs.cmu.edu/~pavlo/papers/p781-wu.pdf
[Automatically Indexing Millions of Databases in Microsoft Azure SQL Database]:https://www.microsoft.com/en-us/research/publication/automatically-indexing-millions-of-databases-in-microsoft-azure-sql-database/
[Adding a Column with a Default Constraint]:https://matthewmcgiffen.com/2019/07/16/adding-a-column-with-a-default-constraint/
[A Hidden Value Of Apply]:https://erikdarlingdata.com/2019/06/a-hidden-value-of-apply/
[Improve Performance of UDFs with NULL ON NULL INPUT]:https://sqlperformance.com/2018/12/sql-performance/improve-udfs-null-on-null-input
[The ‘= NULL’ Mistake and other SQL NULL Heresies]:https://www.red-gate.com/hub/product-learning/sql-prompt/the-null-mistake-and-other-sql-null-heresies
[How to Corrupt a Database]:https://www.sqlserverscience.com/tools/how-to-corrupt-a-database/
[SQL Server Page Types]:http://www.sqlnotes.info/2011/10/31/page-type/
[SQL Server Index Maintenance – You’re Doing It Wrong]:http://www.seangallardy.com/sql-server-index-maintenance-youre-doing-it-wrong/
[Stop Worrying About SQL Server Fragmentation]:https://www.brentozar.com/archive/2012/08/sql-server-index-fragmentation/
[How much will it cost or save to rebuild that index?]:https://www.sqlservercentral.com/articles/rebuild-index
[To BLOB or Not To BLOB: Large Object Storage in a Database or a Filesystem?]:https://www.microsoft.com/en-us/research/wp-content/uploads/2006/04/tr-2006-45.pdf
[SQL Server UPSERT Patterns and Antipatterns]:https://michaeljswart.com/2017/07/sql-server-upsert-patterns-and-antipatterns/
[“UPSERT” Race Condition With MERGE]:https://weblogs.sqlteam.com/dang/2009/01/31/upsert-race-condition-with-merge/
[Use Caution with SQL Server's MERGE Statement]:https://www.mssqltips.com/sqlservertip/3074/use-caution-with-sql-servers-merge-statement/
[Checking for potential constraint violations before entering SQL Server TRY and CATCH logic]:https://www.mssqltips.com/sqlservertip/2632/checking-for-potential-constraint-violations-before-entering-sql-server-try-and-catch-logic/
[Performance impact of different error handling techniques]:https://sqlperformance.com/2012/08/t-sql-queries/error-handling
[Backup and Restore Databases with CHECKSUM and VERIFYONLY]:https://www.sqlrx.com/backup-and-restore-databases-with-checksum-and-verifyonly/
[dm_db_database_page_allocations]:https://www.sqlserverscience.com/sys/dm_db_database_page_allocations/
[Compress Big Tables]:https://www.sqlserverscience.com/performance/compress-big-tables/
[Hardening SQL Server Security]:https://mitchwheat.com/2019/08/21/hardening-sql-server-security/
[Splitting Strings With OPENJSON]:https://itsalljustelectrons.blogspot.com/2019/05/Splitting-Strings-With-OPENJSON.html
[How to migrate to Amazon RDS for SQL Server using transactional replication]:https://aws.amazon.com/ru/blogs/database/how-to-migrate-to-amazon-rds-for-sql-server-using-transactional-replication/
[The Hardest Part Of Query Tuning: Logical Equivalence]:https://erikdarlingdata.com/2019/08/the-hardest-part-of-query-tuning-logical-equivalence/
[SQL Injection: What is it? Causes and exploits]:https://www.sqlshack.com/sql-injection-what-is-it-causes-and-exploits/
[SQL Injection: Detection and prevention]:https://www.sqlshack.com/sql-injection-detection-and-prevention/
[Some T-SQL INSERTs DO Follow the Fill Factor!]:https://www.sqlservercentral.com/articles/some-t-sql-inserts-do-follow-the-fill-factor-sql-oolie
[Install SQL Server 2019 Big Data Cluster using Azure Data Studio]:https://nielsberglund.com/2019/09/11/install-sql-server-2019-big-data-cluster-using-azure-data-studio/
[Indirect Checkpoint and tempdb – the good, the bad and the non-yielding scheduler]:https://techcommunity.microsoft.com/t5/SQL-Server/Indirect-Checkpoint-and-tempdb-8211-the-good-the-bad-and-the-non/bc-p/851152#M1351
[Ghost Records in SQL Server… Now whats that ????]:https://www.sqlservergeeks.com/sql-server-ghost-records-in-sql-server-now-whats-that/
[Transaction Isolation Levels and sp_executesql]:https://www.sqlserverscience.com/basics/stored-procedure-dynamic-sql-execute-as/
[Batch Mode Bitmaps in SQL Server]:https://sqlperformance.com/2019/08/sql-performance/batch-mode-bitmaps-in-sql-server
[Transparent Data Encryption (TDE) on Azure SQL database]:https://www.sqlshack.com/transparent-data-encryption-tde-on-the-azure-sql-database/
[Analyzing Estimates from the CSelCalcAscendingKeyFilter Calculator]:https://www.joshthecoder.com/2019/08/21/analyzing-estimates-cselcalcascendingkeyfilter-calculator.html
[Building Storage for SQL Server (and other database) Virtual Machines in the Cloud]:https://joeydantoni.com/2019/09/18/building-storage-for-sql-server-and-other-database-virtual-machines-in-the-cloud/
[SQL Server Simple and Forced Parameterization]:https://www.mssqltips.com/sqlservertip/2935/sql-server-simple-and-forced-parameterization/
[How to use a SQL Server Plan Guide to Tune Queries]:https://www.mssqltips.com/sqlservertip/1630/how-to-use-a-sql-server-plan-guide-to-tune-queries/
[Neglecting to Use, or Misusing, the RETURN Keyword (BP016)]:https://www.red-gate.com/hub/product-learning/sql-prompt/neglecting-to-use-or-misusing-the-return-keyword-bp016
[Defensive Error Handling]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/defensive-error-handling/
[A Self-Tuning Fill Factor Technique for SQL Server – Part 1]:https://www.sqlservercentral.com/articles/a-self-tuning-fill-factor-technique-for-sql-server-part-1
[A Self-Tuning Fill Factor Technique for SQL Server – Part 2]:https://www.sqlservercentral.com/articles/a-self-tuning-fill-factor-technique-for-sql-server-part-2
[SQL: Been told you can't access master database system views in Azure SQL Database? Not true!]:https://blog.greglow.com/2019/09/17/sql-told-cannot-access-master-database-system-views-azure-sql-database-not-true/
[How to increase SQL Database Full Backup speed using compression and Solid State Disks]:http://henkvandervalk.com/how-to-increase-sql-database-full-backup-speed-using-compression-and-solid-state-disks
[Troubleshooting NUMA Node Imbalance Problems (HammerDB Benchmark)]:https://www.sqlpassion.at/archive/2019/09/23/troubleshooting-numa-node-inbalance-problems/
[SQL Server Unequal NUMA CPU engagement]:https://sql-sasquatch.blogspot.com/2019/09/sql-server-numa-cpu-engagement.html
[SSIS Connection Managers: OLE DB vs ODBC vs ADO.NET]:https://www.sqlshack.com/ssis-connection-managers-ole-db-vs-odbc-vs-ado-net/
[SSIS Data Flows – ADO.NET vs. OLE DB vs. ODBC]:https://datatellblog.wordpress.com/2015/01/13/ssis-data-flows-ado-net-vs-ole-db-vs-odbc/
[SSIS – Fastest data flow task item for transferring data over the network]:https://gqbi.wordpress.com/2013/06/19/ssis-fastest-data-flow-task-item-for-transferring-data-over-the-network/
[The Case of the Vanishing Index Compression]:red-gate.com/simple-talk/blogs/the-case-of-the-vanishing-index-compression/
[Migrating from MSSQL to PostgreSQL - What You Should Know]:https://severalnines.com/database-blog/migrating-mssql-postgresql-what-you-should-know
[Difference between Identity and Sequence in SQL Server 2012]:https://raresql.com/2012/05/01/difference-between-identity-and-sequence/
[Sequence vs Identity – Performance Comparison]:http://byobi.com/2012/09/sequence-vs-identity-performance-comparison/
[Read Excel File in SQL Server with OPENROWSET or OPENDATASOURCE]:https://www.mssqltips.com/sqlservertip/6178/read-excel-file-in-sql-server-with-openrowset-or-opendatasource/
[Upgrading SQL Server using Availability Groups – Checklist]:https://thelonedba.wordpress.com/2019/10/17/upgrading-sql-server-using-availability-groups-checklist/
[Using indexed views? WITH (NOEXPAND) for Standard Edition]:https://bornsql.ca/blog/using-indexed-views-dont-forget-this-important-tip/
[Using indexed views? What is an imprecise or non-deterministic convert?]:https://bornsql.ca/blog/using-indexed-views-what-is-an-imprecise-or-non-deterministic-convert/
[JSON in your Azure SQL Database? Let’s benchmark some options!]:https://techcommunity.microsoft.com/t5/SQL-Customer-Success-Engineering/JSON-in-your-Azure-SQL-Database-Let-s-benchmark-some-options/ba-p/909131
[Looking for strange - addition to system_health XE]:https://karaszi.com/looking-for-strange
[What's new in SQL Server version x]:https://karaszi.com/new-in-version-x
[The ultimate guide to the datetime datatypes]:https://karaszi.com/the-ultimate-guide-to-the-datetime-datatypes
[Some numbers that you will know by heart if you have been working with SQL Server for a while]:https://sqlservercode.blogspot.com/2019/03/some-numbers-that-you-will-know-by.html
[#TSQL2sday: How Much Plan Cache History Do You Have?]:https://www.brentozar.com/archive/2018/07/tsql2sday-how-much-plan-cache-history-do-you-have/
[Fixing SQL Server Management Studio’s Tab Text]:https://www.brentozar.com/archive/2011/06/fixing-sql-server-management-studios-tab-text/
[An overview of the SQL table variable]:https://www.sqlshack.com/an-overview-of-the-sql-table-variable/
[Performance Impact of Small Queries]:https://forrestmcdaniel.com/2019/06/25/performance-impact-of-small-queries/
[How we use SQL Server as a Document Store]:https://octopus.com/blog/sql-as-document-store
[Overlooked T-SQL Gems]:https://sqlperformance.com/2019/10/t-sql-queries/overlooked-t-sql-gems
[Are SQL Server database triggers evil?]:https://www.sqlshack.com/are-sql-server-database-triggers-evil/
[Configuration Best Practices for SQL Server Tempdb–Initial Sizing]:https://logicalread.com/2013/02/12/sql-server-tempdb-best-practices-initial-sizing-w01/
[Sql Server Extended Events Trace Overhead]:https://nenadnoveljic.com/blog/sql-server-extended-events-trace-overhead/
[Measuring "Observer Overhead" of SQL Trace vs. Extended Events]:https://sqlperformance.com/2012/10/sql-trace/observer-overhead-trace-extended-events
[Performance overhead of tracing with Extended Event targets vs SQL Trace under CPU Load]:http://andreas-wolter.com/en/performance-overhead-of-tracing-with-extended-event-targets-vs-sql-trace-under-cpu-load/
[Fragmentation, the final installment]:http://sqlblog.karaszi.com/fragmentation-the-final-installment/
[Atomic Durability - How do databases recover from a crash ?]:https://concurrencyfreaks.blogspot.com/2019/10/atomic-durability-how-do-databases.html
[Truth First, or Why You Should Mostly Implement Database First Designs]:https://blog.jooq.org/2018/06/06/truth-first-or-why-you-should-mostly-implement-database-first-designs/
[SQL Server CHECKPOINT, Lazy Writer, Eager Writer and Dirty Pages in SQL Server]:https://www.sqlshack.com/sql-server-checkpoint-lazy-writer-eager-writer-and-dirty-pages-in-sql-server/
[T-SQL bugs, pitfalls, and best practices – window functions]:https://sqlperformance.com/2019/08/sql-performance/t-sql-bugs-pitfalls-and-best-practices-window-functions
[#BackToBasics: Why I use lower case for data type names (now)]:https://www.sentryone.com/blog/aaronbertrand/backtobasics-lower-case-data-types
[New high availability and disaster recovery benefits for SQL Server]:https://cloudblogs.microsoft.com/sqlserver/2019/10/30/new-high-availability-and-disaster-recovery-benefits-for-sql-server/
[Because Your Index Maintenance Script Is Measuring The Wrong Thing]:https://www.erikdarlingdata.com/2019/10/because-your-index-maintenance-script-is-measuring-the-wrong-thing/
[Memory-Optimized TempDB Metadata]:http://www.nikoport.com/2019/10/30/memory-optimized-tempdb-metadata/
[Build a SQL Cluster Lab Part 1]:https://www.ryanjadams.com/2019/10/build-a-sql-cluster-lab-part-1/
[There is no Such Thing as Object-Relational Impedance Mismatch]:https://blog.jooq.org/2015/08/26/there-is-no-such-thing-as-object-relational-impedance-mismatch/
[ORMs Under the Hood]:https://www.vertabelo.com/blog/orms-under-the-hood/
[EMERGENCY-mode repair: the very, very last resort]:https://www.sqlskills.com/blogs/paul/checkdb-from-every-angle-emergency-mode-repair-the-very-very-last-resort/
[Scalar functions and improvements in SQL Server 2019]:http://sqlblog.karaszi.com/scalar-functions-and-improvements-in-sql-server-2019/
[Scalar functions in SQL server 2019, part 2]:http://sqlblog.karaszi.com/scalar-functions-in-sql-server-2019-part-2/
[Dos and Don'ts of Dynamic SQL]:https://www.sqlservercentral.com/articles/dos-and-donts-of-dynamic-sql
[Differences Between Sql Server TEXT and VARCHAR(MAX) Data Type]:https://sqlhints.com/2016/05/11/differences-between-sql-server-text-and-varcharmax-data-type/
[VARBINARY(MAX) Tames the BLOB]:https://www.itprotoday.com/microsoft-visual-studio/varbinarymax-tames-blob
[Query Store Options in SSMS 18.4]:https://www.sqlskills.com/blogs/erin/query-store-options-in-ssms-18-4/
[Query Store Performance Overhead: What you need to know]:https://www.sqlskills.com/blogs/erin/query-store-performance-overhead/
[How to fork a GitHub repository and contribute to an open source project]:https://sqldbawithabeard.com/2019/11/29/how-to-fork-a-github-repository-and-contribute-to-an-open-source-project/
[But I Need To Compare Two Date Columns In My Where Clause]:https://www.erikdarlingdata.com/2019/11/but-i-need-to-compare-two-date-columns-in-my-where-clause/
[The Difference Between Fault Tolerance, High Availability, & Disaster Recovery]:http://www.pbenson.net/2014/02/the-difference-between-fault-tolerance-high-availability-disaster-recovery/
[Why LOB data makes shrink run slooooowly]:https://www.sqlskills.com/blogs/paul/why-lob-data-makes-shrink-run-slooooowly-t-sql-tuesday-006/
[SQL Server 2019 Scalar UDF inlining - out of memory in some cases]:https://sql-sasquatch.blogspot.com/2019/11/sql-server-2019-udf-inlining-oom-in.html
[Is it true that editing a single row in Management Studio empties and reloads the entire table?]:https://bornsql.ca/blog/is-it-true-that-editing-a-single-row-in-management-studio-empties-and-reloads-the-entire-table/
[A Guide to SQL Naming Conventions]:https://blog.jooq.org/2019/10/29/a-guide-to-sql-naming-conventions/
[Stop Mapping Stuff in Your Middleware. Use SQL’s XML or JSON Operators Instead]:https://blog.jooq.org/2019/11/13/stop-mapping-stuff-in-your-middleware-use-sqls-xml-or-json-operators-instead/
[How Does Accelerated Database Recovery Work]:https://www.red-gate.com/simple-talk/sql/database-administration/how-does-accelerated-database-recovery-work/
[Recover SQL Server Resource Database]:https://www.mssqltips.com/sqlservertip/6194/recover-sql-server-resource-database/
[What’s in that database? Getting information about routines]:https://www.red-gate.com/simple-talk/blogs/whats-in-that-database-getting-information-about-routines/
[The Gloop: An Easier way of Managing SQL Server Documentation]:https://www.red-gate.com/simple-talk/blogs/the-gloop-an-easier-way-of-managing-sql-server-documentation/
[The SQL of Gaps and Islands in Sequences]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/the-sql-of-gaps-and-islands-in-sequences/
[Drop Database Objects Practically Risk-Free!]:https://thenonclutteredindex.com/2019/04/17/drop-database-objects-practically-risk-free/
[Predicate Pushdown and why should I care?]:https://techcommunity.microsoft.com/t5/SQL-Server/Predicate-Pushdown-and-why-should-I-care/bc-p/1045243#M1406
[Stack Overflow Demo Database Column Store Edition: Downloads And Links]:https://www.erikdarlingdata.com/2019/11/stack-overflow-demo-database-column-store-edition-downloads-and-links/
[Stack Overflow Demo Database Column Store Edition: Exploring Relationships]:https://www.erikdarlingdata.com/2019/11/stack-overflow-demo-database-column-store-edition-exploring-relationships/
[Stack Overflow Demo Database Column Store Edition: Helpful Links]:https://www.erikdarlingdata.com/2019/11/stack-overflow-demo-database-column-store-edition-helpful-links/
[Online, Resumable, and WAIT_AT_LOW_PRIORITY operations in SQL Server]:https://littlekendra.com/2019/12/09/online-resumable-and-wait_at_low_priority-operations-in-sql-server/
[How filtered indexes could be a more powerful feature]:https://sqlperformance.com/2013/04/t-sql-queries/filtered-indexes
[How Forced Parameterization in SQL Server Affects Filtered Indexes]:https://www.mssqltips.com/sqlservertip/6139/how-forced-parameterization-in-sql-server-affects-filtered-indexes/
[Filtered Indexes and Forced Parameterization (redux)]:https://sqlperformance.com/2019/12/t-sql-queries/filtered-indexes-forced-parameterization
[Interpreting SQL Server 2019 DBCC MEMORYSTATUS output -- Part 1]:https://sql-sasquatch.blogspot.com/2019/12/interpreting-sql-server-2019-dbcc.html
[Invisible tempdb Killer]:https://www.joshthecoder.com/2019/12/18/invisible-tempdb-killer.html
[Batch Mode On Row Store Is Fickle]:https://www.erikdarlingdata.com/2019/12/batch-mode-on-row-store-is-fickle/
[Use Azure To Store Sql Server Backups Offsite]:https://www.sqlstad.nl/sql-server/use-azure-to-store-sql-server-backups-offsite/
[Handling Data Returned from a SQL Stored Procedure]:https://www.drewsk.tech/2019/12/20/handling-data-returned-from-a-sql-stored-procedure/
[When QUERY_OPTIMIZER_COMPATIBILITY_LEVEL_140 does not follow CL 140 rules]:https://milossql.wordpress.com/2019/12/20/query_optimizer_compatibility_level_140/
[SQL Server–HOW-TO: quickly retrieve accurate row count for table]:https://blogs.msdn.microsoft.com/martijnh/2010/07/15/sql-serverhow-to-quickly-retrieve-accurate-row-count-for-table/
[Do You Have REFERENCES?]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/do-you-have-references/
[Fun with (columnstore) compression on a very large table – part 1]:https://sqlperformance.com/2019/12/columnstore/fun-with-compression-very-large-table-1
[How to Make SELECT COUNT(*) Queries Crazy Fast]:https://www.brentozar.com/archive/2019/12/how-to-make-select-count-queries-crazy-fast/
[SSISDB Catalog Defaults Best Practices]:https://datasteve.com/2019/12/06/ssisdb-catalog-defaults-best-practices/
[Temporal Tables, and how to deal with computed columns]:https://bornsql.ca/blog/temporal-tables-and-how-to-deal-with-computed-columns/
[Cardinality Estimation for Disjunctive Predicates in SQL Server 2014]:https://www.sql.kiwi/2014/04/cardinality-estimation-for-disjunctive-predicates-in-2014.html
[Create Distributed Availability Group in Sql Server Linux(Redhat) --- step by step]:https://techcommunity.microsoft.com/t5/sql-server-support/create-distributed-availability-group-in-sql-server-linux-redhat/ba-p/1003471
[Connection options in SSMS]:https://sqlstudies.com/2013/11/18/connection-options-in-ssms/
[A Script To Automatically Align Columnstore Indexes To Enhance Segment Elimination (and Hence Performances)]:https://tsql.tech/a-script-to-automatically-align-columnstore-indexes-to-enhance-segment-elimination-and-hence-performances/
[Issues with SQLCMD when using special characters]:https://www.mssqltips.com/sqlservertip/5132/issues-with-sqlcmd-when-using-special-characters/
[Encrypting passwords with Python Scripts in SQL Notebooks of Azure Data Studio]:https://www.sqlshack.com/encrypting-passwords-with-python-scripts-in-sql-notebooks-of-azure-data-studio/
[Fun with (columnstore) compression on a very large table – part 2]:https://sqlperformance.com/2020/01/columnstore/fun-with-compression-very-large-table-2
[The curious case of the sqlcmd password]:https://bornsql.ca/blog/the-curious-case-of-the-sqlcmd-password/
[Setting up Management Studio for remote SQL Server]:https://www.sqlservercentral.com/articles/setting-up-management-studio-for-remote-sql-server
[SQL Server Security Best Practices for an Application Installed on SQL Server]:https://www.mssqltips.com/sqlservertip/6266/sql-server-security-best-practices-for-an-application-installed-on-sql-server/
[PCI Best Practices Guide for SQL Server DBAs]:https://www.mssqltips.com/sqlservertip/3609/pci-best-practices-guide-for-sql-server-dbas/
[SQL Server Security Checklist]:https://www.mssqltips.com/sqlservertip/3159/sql-server-security-checklist/
[Replace Model SQL Server Database with a User Database]:https://www.mssqltips.com/sqlservertip/6154/replace-model-sql-server-database-with-a-user-database/
[SQL Server Linux installation for Amazon EC2 instance with Red Hat OS]:https://www.sqlshack.com/sql-server-linux-installation-for-amazon-ec2-instance-with-red-hat-os/
[Departure of a SQL Server Administrator – What to Check?]:https://thelonedba.wordpress.com/2020/01/03/departure-of-a-sql-server-administrator-what-to-check/
[The Curious Case of… transactions rolling back during DBCC CHECKDB]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-transactions-rolling-back-during-dbcc-checkdb/
[Don’t install SQL Server from a mounted ISO]:https://bornsql.ca/blog/dont-install-sql-server-from-a-mounted-iso/
[NULL complexities – Part 1]:https://sqlperformance.com/2019/12/t-sql-queries/null-complexities-part-1
[NULL complexities – Part 2]:https://sqlperformance.com/2020/01/t-sql-queries/null-complexities-part-2
[NULL complexities – Part 3]:https://sqlperformance.com/2020/01/t-sql-queries/null-complexities-part-3
[How to fix the “Agent XPs disabled” error]:https://www.sqlshack.com/how-to-fix-the-agent-xps-disabled-error/
[Number of Rows Read / Actual Rows Read warnings in Plan Explorer]:https://sqlperformance.com/2016/06/sql-indexes/actual-rows-read-warnings-plan-explorer
[Data Compression + Backup Compression = Double Compression?]:https://jesspomfret.com/double-compression/
[How Many Bytes Per Character in SQL Server: a Completely Complete Guide]:https://sqlquantumleap.com/2019/11/22/how-many-bytes-per-character-in-sql-server-a-completely-complete-guide/
[Storage 101: Welcome to the Wonderful World of Storage]:https://www.red-gate.com/simple-talk/sql/database-administration/storage-101-welcome-to-the-wonderful-world-of-storage/
[How to detect and prevent unexpected growth of the TempDB database]:https://www.sqlshack.com/how-to-detect-and-prevent-unexpected-growth-of-the-tempdb-database/
[Understanding the SQL Server Proportional fill algorithm]:https://www.sqlshack.com/understanding-sql-server-proportional-fill-algorithm/
[VALUES() and Long Parameter Lists]:https://www.red-gate.com/simple-talk/sql/learn-sql-server/values-and-long-parameter-lists/
[Going Serverless with Azure SQL Database]:https://www.mssqltips.com/sqlservertip/6273/going-serverless-with-azure-sql-database/
[SQLskills SQL101: Why are Statistics so Important?]:https://www.sqlskills.com/blogs/kimberly/sql101_whystatisticsareimportant/
[Configuring SQL Server Express edition as SQL witness server in Database Mirroring]:https://www.sqlshack.com/configuring-sql-server-express-edition-as-sql-witness-server-in-database-mirroring/
[The Half Apply Query]:https://forrestmcdaniel.com/2020/01/20/the-half-apply-query/
[Import JSON data into SQL Server]:https://www.sqlshack.com/import-json-data-into-sql-server/
[Auditing in AWS RDS SQL Server]:https://www.sqlshack.com/auditing-in-aws-rds-sql-server/
[Types of SQL Server Indexes]:https://www.mssqltips.com/sqlservertip/6274/types-of-sql-server-indexes/
[Use SQL Server's UNPIVOT operator to help normalize output]:https://www.mssqltips.com/sqlservertip/3000/use-sql-servers-unpivot-operator-to-help-normalize-output/
[Prevent SSMS from seeing the server's file system]:https://dba.stackexchange.com/a/246783/107045
[Add the ability to disable or enable a few new DMVs and DMFs introduced in SQL Server 2017]:https://support.microsoft.com/help/4046638/
[Actual Difference Between EXISTS(SELECT 1 …), EXISTS(SELECT * …), and EXISTS(SELECT column …)]:https://sqlquantumleap.com/2020/01/24/actual-difference-between-existsselect-1-existsselect-and-existsselect-column/
[Why Wait Stats Alone Are Not Enough]:https://sqlperformance.com/2020/01/sql-performance/why-waits-alone-are-not-enough
[Estimating AWS RDS SQL Server costs]:https://www.sqlshack.com/estimating-aws-rds-sql-server-costs/
[SQL Server Performance Tuning Using Wait Statistics: A Beginner’s Guide]:https://www.sqlskills.com/wp-content/uploads/2014/04/sql-server-performance-tuning-using-wait-statistics-whitepaper.pdf
[sys.xp_delete_files and ‘allow filesystem enumeration’: two new undocumented items in SQL Server 2019]:https://sqlquantumleap.com/2020/01/26/sys-xp_delete_files-and-allow-filesystem-enumeration-two-new-undocumented-items-in-sql-server-2019/
[Why Database Monitoring Tools Are So Hard to Interpret]:https://www.brentozar.com/archive/2020/01/why-database-monitoring-tools-are-so-hard-to-interpret/
[Extended Events Misperceptions: Profiler Is Easier]:https://www.scarydba.com/2020/01/20/extended-events-misperceptions-profiler-is-easier/
[Extended Events Misperceptions: Profiler Is Easier, Part 2]:https://www.scarydba.com/2020/01/27/extended-events-misperceptions-profiler-is-easier-part-2/
[Automate SFTP File Transfer with SQL Server Agent and WinSCP]:https://www.mssqltips.com/sqlservertip/6285/automate-sftp-file-transfer-with-sql-server-agent-and-winscp/
[Running Database Console Commands (DBCCs) on Azure SQL Database]:https://www.databasejournal.com/features/mssql/running-database-console-commands-dbccs-on-azure-sql-database.html
[How to Remove Times from Dates in SQL Server]:https://www.brentozar.com/archive/2020/01/how-to-remove-times-from-dates-in-sql-server/
[Export/Import Data using BCP - SQL Server on Linux]:https://www.sqlservercentral.com/articles/export-import-data-using-bcp-sql-server-on-linux
[Prevent SQL Server Blocking using Lock_Timeout]:https://www.mssqltips.com/sqlservertip/6279/prevent-sql-server-blocking-using-locktimeout/
[Bin Packing Problems: The SQL]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/bin-packing-problems-the-sql/
[Causation, Correlation and Crackpots]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/causation-correlation-and-crackpots/
[What Events are in a Trace?]:https://www.sqlskills.com/blogs/erin/what-events-are-in-a-trace/
[What Are Soft Deletes, and How Are They Implemented?]:https://www.brentozar.com/archive/2020/02/what-are-soft-deletes-and-how-are-they-implemented/
[Why You Should Switch in Staging Tables Instead of Renaming Them (Dear SQL DBA Episode 26)]:https://littlekendra.com/2017/01/19/why-you-should-switch-in-staging-tables-instead-of-renaming/
[Changing a column from int to bigint, without downtime]:https://am2.co/2019/12/changing-a-column-from-int-to-bigint-without-downtime/
[I hate sp_estimate_data_compression_savings]:https://am2.co/2019/12/i-hate-sp_estimate_data_compression_savings/
[Testing as another user…without their password -  impersonate the other user]:https://am2.co/2019/12/testing-as-another-user-without-their-password/
[How does a database RESTORE affect plan cache?]:https://am2.co/2019/10/how-does-a-database-restore-affect-plan-cache/
[Recovery of database is 0% complete (approximately 1000000 seconds remain)]:https://am2.co/2019/10/recovery-of-database-is-0-complete-approximately-1000000-seconds-remain/
[Code to purge data based on creation date]:https://am2.co/2019/04/code-to-purge-data-on-creation-date/
[Blocking with OBJECT_NAME()]:https://am2.co/2019/12/blocking-with-object_name/
[Performance Myths: The query result cache]:https://sqlperformance.com/2018/07/performance-myths/query-result-cache
[Fun with (columnstore) compression on a very large table – part 3]:https://sqlperformance.com/2020/02/columnstore/fun-with-columnstore-compression-on-a-very-large-table-part-3
[Indexing basics]:https://sqlsunday.com/2013/02/19/indexing-basics/
[Working with covering indexes]:https://sqlsunday.com/2013/02/24/covering-indexes/
[Using Erik Darling’s sp_pressure_detector to resolve CPU issues]:https://desertdba.com/using-erik-darlings-sp_pressure_detector-to-resolve-cpu-issues/
[The Accidental DBA (Day 16 of 30): General Security]:https://www.sqlskills.com/blogs/jonathan/the-accidental-dba-day-16-of-30-general-security/
[Securing Data in SQL Server]:https://www.sqlskills.com/blogs/jonathan/securing-data-in-sql-server/
[Performance Testing SQL 2008's Transparent Data Encryption]:https://www.databasejournal.com/features/mssql/article.php/3815501/Performance-Testing-SQL-2008146s-Transparent-Data-Encryption.htm
[Common SQL Server Security Issues and Solutions]:https://docs.microsoft.com/en-us/previous-versions/technet-magazine/dd637114(v=msdn.10)
[Chaos Engineering and SQL Server]:https://dbafromthecold.com/2020/01/29/chaos-engineering-and-sql-server/
[Different methods to attach SQL Server MDF files]:https://www.sqlshack.com/different-methods-to-attach-sql-server-mdf-files/
[Learn SQL: How to Write a Complex SELECT Query]:https://www.sqlshack.com/learn-sql-how-to-write-a-complex-select-query/
[Filling In Missing Values Using the T-SQL Window Frame]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/filling-in-missing-values-using-the-t-sql-window-frame/
[Select * in a view]:https://sqlreitse.home.blog/2020/02/12/select-in-a-view/
[T-SQL TUESDAY #123: Aggregates of Aggregates using Windowing Functions]:https://jimbabwe.co.za/2020/02/12/t-sql-tuesday-123-life-hacking-by-opening-windows/
[SQL Server Statistics: Explained]:https://blogs.msdn.microsoft.com/srgolla/2012/09/04/sql-server-statistics-explained/
[How to Pass a List of Values Into a Stored Procedure]:https://www.brentozar.com/archive/2020/02/how-to-pass-a-list-of-values-into-a-stored-procedure/
[What's the difference between a temp table and table variable in SQL Server?]:https://dba.stackexchange.com/a/16386/107045
[Be Mindful of SQL Server Tempdb Use (aka Tempdb Parasites!)]:https://www.sentryone.com/blog/be-mindful-of-sql-server-tempdb-use-aka-tempdb-parasites
[Robyn Page’s SQL Server Cursor Workbench (Quirky Update)]:https://www.red-gate.com/simple-talk/sql/learn-sql-server/robyn-pages-sql-server-cursor-workbench/
[Solving the Running Total and Ordinal Rank Problems (Rewritten) (Quirky Update)]:https://www.sqlservercentral.com/articles/solving-the-running-total-and-ordinal-rank-problems-rewritten
[Running totals in “Denali” CTP3 (Quirky Update)]:https://blog.waynesheffield.com/wayne/archive/2011/08/running-totals-in-denali-ctp3/
[WHERE GETDATE() BETWEEN StartDate AND EndDate Is Hard to Tune.]:https://www.brentozar.com/archive/2020/02/where-getdate-between-startdate-and-enddate-is-hard-to-tune/
[WHERE GETDATE() BETWEEN StartDate AND COALESCE(CancelDate, EndDate) Is Even Harder to Tune.]:https://www.brentozar.com/archive/2020/02/where-getdate-between-startdate-and-coalescecanceldate-enddate-is-even-harder-to-tune/
[How to solve the SQL Identity Crisis in SQL Server]:https://www.sqlshack.com/solve-identity-crisis-sql-server/
[Significant SQL Server 2019 licensing changes]:https://www.kevinrchant.com/2020/02/17/significant-sql-server-2019-licensing-changes/
[Indexed View Maintenance Is Only As Bad As Your Indexes]:https://www.erikdarlingdata.com/2020/02/indexed-view-maintenance-is-only-as-bad-as-your-indexes/
[Why Design Impacts Performance on Microsoft SQL Server]:https://www.sentryone.com/blog/why-design-impacts-performance-microsoft-sql-server
[Apply versus Nested Loops Join]:https://www.sql.kiwi/2019/06/apply-versus-nested-loops-join.html
[Inside the Optimizer: Constructing a Plan - Part 1]:https://www.sql.kiwi/2010/07/inside-the-optimiser-constructing-a-plan.html
[Inside the Optimizer: Constructing a Plan - Part 2]:https://www.sql.kiwi/2010/07/inside-the-optimiser-constructing-a-plan-ii.html
[Inside the Optimizer: Constructing a Plan - Part 3]:https://www.sql.kiwi/2010/07/inside-the-optimiser-constructing-a-plan-part-3.html
[Inside the Optimizer: Constructing a Plan - Part 4]:https://www.sql.kiwi/2010/07/inside-the-optimiser-constructing-a-plan-part-4.html
[Tips for dealing with large SQL Server scripts]:https://www.kevinrchant.com/2020/02/24/tips-for-dealing-with-large-sql-server-scripts/
[Database Normalization in SQL with Examples]:https://www.sqlservercentral.com/articles/database-normalization-in-sql-with-examples
[Why SQL Server May Not Parallelize a Query]:https://logicalread.com/2015/10/30/sql-server-query-parallelizing-mc11/
[Parallelism in SQL Server Execution Plan]:https://www.mssqltips.com/sqlservertip/5404/parallelism-in-sql-server-execution-plan/
[An XEvent a Day (26 of 31) – Configuring Session Options]:https://www.sqlskills.com/blogs/jonathan/an-xevent-a-day-26-of-31-configuring-session-options/
[Azure SQL Managed Instance Performance Considerations]:https://sqlperformance.com/2020/02/azure/sql-managed-instance-performance-considerations
[The Curious Case of… whether corruption can propagate to secondary databases]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-whether-corruption-can-propagate-to-secondary-databases/
[Stop and Think Before You Shrink – Shrinking a SQL Server Database]:https://www.mlakartechtalk.com/stop-and-think-before-you-shrink-shrinking-a-sql-server-database/
[How to Analyze the SQL Server Error Log]:https://www.mlakartechtalk.com/how-to-analyze-the-sql-server-error-log/
[Converting SQL Trace to Extended Events in SQL Server 2012]:https://www.sqlskills.com/blogs/jonathan/converting-sql-trace-to-extended-events-in-sql-server-2012/
[What event information can I get by default from SQL Server?]:https://dba.stackexchange.com/a/48053/107045
[Removing the default trace – Part 1]:https://sqlperformance.com/2020/03/extended-events/removing-default-trace-1
[Removing the default trace – Part 2]:https://sqlperformance.com/2020/04/extended-events/removing-default-trace-2
[Removing the default trace – Part 3]:https://sqlperformance.com/2020/04/extended-events/removing-default-trace-3
[Keeping DRY in SQL Server with Scalar User Defined Functions – Part 1]:https://www.sentryone.com/blog/keeping-dry-in-sql-server-with-scalar-user-defined-functions-part-1
[Different Ways to Monitor SQL Server AlwaysOn Availability Groups]:https://codingsight.com/different-ways-to-monitor-sql-server-alwayson-availability-groups/
[SQL Server internals: Is Order of Column in the table important?]:http://ariely.info/Blog/tabid/83/EntryId/219/SQL-Server-internals-Is-Order-of-Column-in-the-table-important.aspx
[Code: Order of columns in table might impact the size of the table/database and even related to errors]:http://ariely.info/Blog/tabid/83/EntryId/243/Code-Order-of-columns-in-table-might-impact-the-size-of-the-table-database-and-even-related-to-errors.aspx
[SQL Server Internals: Getting the data of deleted column]:http://ariely.info/Blog/tabid/83/EntryId/213/SQL-Server-Internals-Getting-the-data-of-deleted-column.aspx
[Queue table issues with Availability Groups in SQL Server]:mssqltips.com/sqlservertip/6284/queue-table-issues-with-availability-groups-in-sql-server/
[Transact-SQL: openjson hierarchy solution]:http://ariely.info/Blog/tabid/83/EntryId/239/Transact-SQL-openjson-hierarchy-solution.aspx
[CREATE DLL TRIGGER ON CREATE_LOGIN to configure default parameters for any new LOGIN]:http://ariely.info/Blog/tabid/83/EntryId/240/CREATE-DLL-TRIGGER-ON-CREATE_LOGIN-to-configure-default-parameters-for-any-new-LOGIN.aspx
[Code: Order of columns in table might impact the size of the table/database and even related to errors]:http://ariely.info/Blog/tabid/83/EntryId/243/Code-Order-of-columns-in-table-might-impact-the-size-of-the-table-database-and-even-related-to-errors.aspx
[SQL Server Internals: Getting the data of deleted column]:http://ariely.info/Blog/tabid/83/EntryId/213/SQL-Server-Internals-Getting-the-data-of-deleted-column.aspx
[SQL varchar data type deep dive]:https://www.sqlshack.com/sql-varchar-data-type-deep-dive/
[What is the datatype SQL_VARIANT]:https://sqlstudies.com/2020/04/16/what-is-the-datatype-sql_varient/
[An Introduction to Asynchronous Processing with Service Broker]:https://sqlperformance.com/2014/03/sql-performance/intro-to-service-broker
[Detecting and Alerting on SQL Server Agent Missed Jobs]:https://www.sqlshack.com/detecting-and-alerting-on-sql-server-agent-missed-jobs-2/
[Execute multiple jobs Synchronously from in a main job]:http://ariely.info/Blog/tabid/83/EntryId/250/Execute-multiple-jobs-Synchronously-from-in-a-main-job.aspx
[Why Ordering Isn’t Guaranteed Without an ORDER BY]:https://www.brentozar.com/archive/2020/04/why-ordering-isnt-guaranteed-without-an-order-by/
[How to Attach a SQL Server Database without a Transaction Log and with Open Transactions]:https://www.mssqltips.com/sqlservertip/3579/how-to-attach-a-sql-server-database-without-a-transaction-log-and-with-open-transactions/
[SQL 2016 - It Just Runs Faster: Indirect Checkpoint Default]:https://docs.microsoft.com/en-gb/archive/blogs/psssql/sql-2016-it-just-runs-faster-indirect-checkpoint-default
[SQL Server : large RAM and DB Checkpointing]:https://docs.microsoft.com/en-us/archive/blogs/psssql/sql-server-large-ram-and-db-checkpointing
[Indirect Checkpoint and tempdb – the good, the bad and the non-yielding scheduler]:https://docs.microsoft.com/en-gb/archive/blogs/sql_server_team/indirect-checkpoint-and-tempdb-the-good-the-bad-and-the-non-yielding-scheduler
[How do checkpoints work and what gets logged]:https://www.sqlskills.com/blogs/paul/how-do-checkpoints-work-and-what-gets-logged/
[Inside the Storage Engine: What’s in the buffer pool?]:https://www.sqlskills.com/blogs/paul/inside-the-storage-engine-whats-in-the-buffer-pool/
[What does checkpoint do for tempdb?]:https://www.sqlskills.com/blogs/paul/what-does-checkpoint-do-for-tempdb/
[Performance issues from wasted buffer pool memory]:https://www.sqlskills.com/blogs/paul/performance-issues-from-wasted-buffer-pool-memory/
[How It Works: When is the FlushCache message added to SQL Server Error Log?]:https://docs.microsoft.com/en-us/archive/blogs/psssql/how-it-works-when-is-the-flushcache-message-added-to-sql-server-error-log
[Cross Database Transactions on One Server]:https://michaeljswart.com/2020/05/cross_database_transactions/
[Your Views Aren’t The Problem. Your Code Is.]:https://www.brentozar.com/archive/2020/05/your-views-arent-the-problem-your-code-is/
[Negative identity values don’t suck]:https://bornsql.ca/blog/negative-identity-values-dont-suck/
[How SQL Server stores data types: integers and decimals]:https://bornsql.ca/blog/how-sql-server-stores-data-types-integers-and-decimals/
[How SQL Server stores data types: DATETIME, DATE, TIME, and DATETIME2]:https://bornsql.ca/blog/how-sql-server-stores-data-types-datetime-date-time-and-datetime2/
[Can I Offload DBCC CHECKDB To Another Server?]:https://www.brentozar.com/archive/2020/05/can-i-offload-dbcc-checkdb-to-another-server/
[Negative (-) is an operator and will affect the order of operations.]:https://sqlstudies.com/2020/05/18/negative-is-an-operator-and-will-effect-the-order-of-operations/
["0 to 60" : Switching to indirect checkpoints]:https://sqlperformance.com/2020/05/system-configuration/0-to-60-switching-to-indirect-checkpoints
[Parallelism Can Make Queries Perform Worse.]:https://www.brentozar.com/archive/2020/05/parallelism-can-make-queries-perform-worse/
[A SQL Server DBA myth a day: (15/30) checkpoint only writes pages from committed transactions]:https://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-1530-checkpoint-only-writes-pages-from-committed-transactions/
[Can You Use NVARCHAR As a Universal Parameter? Almost.]:https://www.brentozar.com/archive/2020/04/can-you-use-nvarchar-as-a-universal-parameter-almost/
[The Learner’s Guide to SQL Server Performance Triage]:https://littlekendra.com/2020/03/19/the-learners-guide-to-sql-server-performance-triage/
[Learner’s Guide to SQL Server Query Tuning]:https://littlekendra.com/2020/05/01/learners-guide-to-sql-server-query-tuning/
[How to Get Better Estimates for Modification Queries]:https://www.brentozar.com/archive/2020/04/how-to-get-better-estimates-for-modification-queries/
[SSMS: Prevent Copy and Paste of Text in “Messages” tab (Cruel Joke #2)]:https://sqlquantumleap.com/2020/05/22/ssms-prevent-copy-and-paste-of-text-in-messages-tab-cruel-joke-2/s
[Compare the Best SQL Server Performance Monitoring Tools]:https://www.sentryone.com/compare-best-sql-server-monitoring-tools
[Minimal Logging with INSERT…SELECT into Heap Tables]:https://sqlperformance.com/2019/05/sql-performance/minimal-logging-insert-select-heap
[Minimal Logging with INSERT…SELECT into Empty Clustered Tables]:https://sqlperformance.com/2019/05/sql-performance/minimal-logging-empty-clustered
[Minimal Logging with INSERT…SELECT and Fast Load Context]:https://sqlperformance.com/2019/05/sql-performance/minimal-logging-fast-load-context
[Avoiding SQL Server Upgrade Performance Issues]:https://www.sqlskills.com/blogs/glenn/avoid-sql-server-upgrade-performance-issues/
[Compatibility Levels and Cardinality Estimation Primer]:https://sqlperformance.com/2019/01/sql-performance/compatibility-levels-and-cardinality-estimation-primer
[An approach to index tuning – Part 1]:https://sqlperformance.com/2020/03/sql-indexes/an-approach-to-index-tuning-part-1
[An approach to index tuning – Part 2]:https://sqlperformance.com/2020/04/sql-indexes/an-approach-to-index-tuning-part-2
[Moving A Database to New Storage With No Downtime]:https://www.bobpusateri.com/archive/2013/03/moving-a-database-to-new-storage-with-no-downtime/
[RESOURCE_GOVERNOR_IDLE in Azure]:https://joshthecoder.com/2020/06/15/resource-governor-idle-in-azure.html
[Automated Backup Tuning]:https://sirsql.net/2012/12/13/20121212automated-backup-tuning/
[Optimizing Database Restores]:https://sirsql.net/2011/09/26/2011926optimizing-database-restores-html/
[AVAILABILITY_REPLICA - The Deception of the Log Reuse Wait Type]:https://sirsql.net/2020/05/19/the-deception-of-the-log-reuse-wait-type/
[Changing an INT to a BIGINT with no downtime]:https://michaeljswart.com/2020/06/problem-solving-by-cheating/
[New Metadata-Only Column Changes in SQL Server 2016]:https://sqlperformance.com/2020/04/database-design/new-metadata-column-changes-sql-server-2016
[Bandwidth-friendly Query Profiling for Azure SQL Database]:https://sqlperformance.com/2020/04/sql-performance/bandwidth-friendly-query-profiling-azure-sql-database
[When a Columnstore Index Makes Your Query Fail]:https://www.brentozar.com/archive/2020/06/when-a-columnstore-index-makes-your-query-fail/
[Column scope and binding order in subqueries]:https://sqlinthewild.co.za/index.php/2019/04/23/no-this-is-not-a-bug-in-t-sql/
[Improve SQL Server Extended Events system_health Session]:https://www.mssqltips.com/sqlservertip/6456/improve-sql-server-extended-events-systemhealth-session/
[Page Life Expectancy Doesn’t Mean Jack, and You Should Stop Looking At It.]:https://www.brentozar.com/archive/2020/06/page-life-expectancy-doesnt-mean-jack-and-you-should-stop-looking-at-it/
[Unsupported but working versions of SQL Server on Windows Server 2019]:https://bornsql.ca/blog/unsupported-but-working-versions-of-sql-server-on-windows-server-2019/
[Bad Idea Jeans: Building Big Query Plans]:https://www.brentozar.com/archive/2020/06/bad-idea-jeans-building-big-query-plans/
[SQL Server performance tuning – RESOURCE_SEMAPHORE waits]:https://www.sqlshack.com/sql-server-performance-tuning-resource_semaphore-waits/
[Use session_context to create a “variable” that lasts between batches.]:https://sqlstudies.com/2020/05/26/use-session_context-to-create-a-variable-that-lasts-between-batches/
[Phase out CONTEXT_INFO() in SQL Server 2016 with SESSION_CONTEXT()]:https://www.mssqltips.com/sqlservertip/4094/phase-out-contextinfo-in-sql-server-2016-with-sessioncontext/
[How to Balance SQL Server Core Licenses Across NUMA Nodes]:https://glennsqlperformance.com/2020/06/25/how-to-balance-sql-server-core-licenses-across-numa-nodes/
[What is the Difference Between Physical Sockets, Physical Cores, and Logical Cores?]:https://glennsqlperformance.com/2019/12/18/what-is-the-difference-between-physical-sockets-physical-cores-and-logical-cores/
[Troubleshooting SQL Server Wait Stats]:https://www.sentryone.com/white-papers/troubleshooting-sql-server-wait-stats
[The 201 Buckets Problem, Part 1: Why You Still Don’t Get Accurate Estimates]:https://www.brentozar.com/archive/2020/07/the-201-buckets-problem-part-1-why-you-still-dont-get-accurate-estimates/
[The 201 Buckets Problem, Part 2: How Bad Estimates Backfire As Your Data Grows]:https://www.brentozar.com/archive/2020/07/the-201-buckets-problem-part-2-how-bad-estimates-backfire-as-your-data-grows/
[Sql Server — Widely Random Query Exec Times (cxconsumer Wait/cxpacket) & Possible Remediation]:https://viktorsrandomposts.wordpress.com/2020/06/26/sql-server-widely-random-query-exec-times-cxconsumer-wait-possible-remediation/
[How MAXDOP Really Works]:https://www.sql.kiwi/2020/07/how-maxdop-really-works.html
[What is MaxDOP controlling?]:https://techcommunity.microsoft.com/t5/sql-server/what-is-maxdop-controlling/ba-p/1505968
[What If You Really DO Need to Shrink a Database?]:https://www.brentozar.com/archive/2020/07/what-if-you-really-do-need-to-shrink-a-database/
[Everything I Never Wanted to Know About Collation]:https://littlekendra.com/2020/07/16/everything-i-never-wanted-to-know-about-collation-14-minute-video-podcast-episode/
[Comparing SSIS And Azure Data Factory]:https://www.timmitchell.net/post/2020/07/16/comparing-ssis-and-azure-data-factory/
[sp_Blitz for All Servers]:https://garrybargsley.com/2020/07/14/sp_blitz-for-all-servers/
[Where is the SQL Server Community Networking Online?]:https://www.brentozar.com/archive/2020/07/where-is-the-sql-server-community-networking-online/
[Make the most out of your Azure Disks using Storage Pools]:https://blog.coeo.com/make-the-most-out-of-your-azure-disks-using-storage-pools
[SQL Server High Availability Solutions on Azure VMs]:https://www.brentozar.com/archive/2020/07/where-is-the-sql-server-community-networking-online/
[How to Get Started with SQL Server Management Studio]:https://www.brentozar.com/archive/2020/07/how-to-get-started-with-sql-server-management-studio/
[How should I store currency values in SQL Server?]:https://bornsql.ca/blog/how-should-i-store-currency-values-in-sql-server/
[Read committed isolation level doesn’t guarantee much…]:https://www.sqlskills.com/blogs/paul/read-committed-doesnt-guarantee-much/
[Prevent Unexpected Failovers When Patching AGs]:https://joshthecoder.com/2020/05/21/prevent-unexpected-failovers-when-patching-ags.html
[Updating Statistics Causes Parameter Sniffing]:https://www.brentozar.com/archive/2020/06/updating-statistics-causes-parameter-sniffing/
[The Ascending Key Problem in Fact Tables– Part one: Pain!]:https://kejserbi.wordpress.com/2011/07/01/the-ascending-key-problem-in-fact-tables-part-one-pain/
[The Ascending Key Problem In Fact Tables –Part Two: Stat Job!]:http://blog.kejser.org/the-ascending-column-problem-in-fact-tables-part-two-stat-job/
[Are Statistics Being Used for inserted and deleted tables and table variables?]:https://community.idera.com/database-tools/blog/b/community_blog/posts/are-statistics-being-used
[Tackling Imperial and US Customary Measurements in Databases]:https://www.red-gate.com/simple-talk/blogs/tackling-imperial-and-us-customary-measurements-in-databases/
[In-Memory OLTP Best Practices – Part 1]:https://devblogs.microsoft.com/premier-developer/in-memory-oltp-best-practices-part-1/
[In-Memory OLTP Best Practices – Part 2]:https://devblogs.microsoft.com/premier-developer/in-memory-oltp-best-practices-part-2/
[Things I Wished More Developers Knew About Databases]:https://medium.com/@rakyll/things-i-wished-more-developers-knew-about-databases-2d0178464f78
[Online migrations at scale]:https://stripe.com/blog/online-migrations
[The Dirty (Baker’s) Dozen of SQL Server Technical Debt]:https://blog.coeo.com/the-dirty-bakers-dozen-of-sql-server-technical-debt
[15 SQL Server Performance Counters to Monitor In 2020]:https://www.sentryone.com/blog/allenwhite/sql-server-performance-counters-to-monitor
[Pulling Group By Above a Join]:https://www.sql.kiwi/2020/05/pulling-group-by-above-join.html
[SQLskills SQL101: Running out of ints and bigints]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-running-out-of-ints-and-bigints/
[Parallel Execution Plans – Branches and Threads]:https://sqlperformance.com/2013/10/sql-plan/parallel-plans-branches-threads
[Understanding and Using Parallelism in SQL Server]:https://www.red-gate.com/simple-talk/sql/learn-sql-server/understanding-and-using-parallelism-in-sql-server/
[Top Asked Availability Group Questions… and Maybe Some Helpful Tidbits as Answers]:https://www.seangallardy.com/top-asked-availability-group-questions-and-maybe-some-helpful-tidbits-as-answers/
[The 201 Buckets Problem, Part 1: Why You Still Don’t Get Accurate Estimates]:https://www.brentozar.com/archive/2020/07/the-201-buckets-problem-part-1-why-you-still-dont-get-accurate-estimates/
[The 201 Buckets Problem, Part 2: How Bad Estimates Backfire As Your Data Grows]:https://www.brentozar.com/archive/2020/07/the-201-buckets-problem-part-2-how-bad-estimates-backfire-as-your-data-grows/
[Encrypting SQL Server Database Backups]:https://sqlundercover.com/2018/04/04/encrypting-sql-server-database-backups/
[Using Track Causality to Understand Query Execution]:https://sqlperformance.com/2019/01/extended-events/using-track-causality-to-understand-query-execution
[Understanding SQL Server Backup Types]:https://www.sqlshack.com/understanding-sql-server-backup-types/
[Scripting the Description of Database Tables Using Extended Properties]:https://www.red-gate.com/simple-talk/sql/database-delivery/scripting-description-database-tables-using-extended-properties/
[The Table Variable in SQL Server]:https://www.sqlshack.com/the-table-variable-in-sql-server/
[Multiple Plans for an "Identical" Query]:https://sqlperformance.com/2014/11/t-sql-queries/multiple-plans-identical-query
[Another argument for stored procedures versus ORM versus Add Hoc Queries]:https://sqlperformance.com/2013/05/t-sql-queries/another-argument-for-stored-procedures
[Bad habits to kick : avoiding the schema prefix]:https://sqlblog.org/2019/09/12/bad-habits-to-kick-avoiding-the-schema-prefix
[How not to call Hekaton natively-compiled stored procedures]:https://sqlperformance.com/2015/06/t-sql-queries/how-not-to-call-hekaton-procedures
[A One-Slide Summary of the Differences Between TDE and Always Encrypted]:https://www.brentozar.com/archive/2020/07/a-one-slide-summary-of-the-differences-between-tde-and-always-encrypted/
[Remember “Nothing Stops a Hekaton Transaction?” Yeah, About That.]:https://www.brentozar.com/archive/2020/07/remember-nothing-stops-a-hekaton-transaction-yeah-about-that/
[Finding & Downloading Required SQL Server Updates]:https://flxsql.com/downloading-latest-sql-server-updates/
[SQLskills SQL101: Why do some wait types need to be ignored?]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-why-do-some-wait-types-need-to-be-ignored/
[What is the SOS_WORK_DISPATCHER Wait Type? (Or how to work with Call Stacks in SQL Server)]:https://orderbyselectnull.com/2018/09/27/what-is-the-sos_work_dispatcher-wait-type/
[SQL Server 2019 Aggregate Splitting]:https://www.sql.kiwi/2020/08/sql-server-2019-aggregate-splitting.html
[Security Best Practice: dny and revoke permissions granted to All Users by default - HIGHLY IMPORTANT!]:https://ariely.info/Blog/tabid/83/EntryId/241/Security-Best-Practice-dny-and-revoke-permissions-granted-to-All-Users-by-default-HIGHLY-IMPORTANT.aspx
[Execute multiple jobs Synchronously from in a main job]:https://ariely.info/Blog/tabid/83/EntryId/250/Execute-multiple-jobs-Synchronously-from-in-a-main-job.aspx
[The Trillion Row Operator]:https://www.erikdarlingdata.com/2020/08/the-trillion-row-operator/
[Temporal Tables and Table Partitioning: Not If You Like Switching Partitions]:https://www.erikdarlingdata.com/sql-server/temporal-tables-and-table-partitioning-not-if-you-like-switching-partitions/
[Long Running Query on Read-Only Replica that takes moments on the Primary]:https://dba.stackexchange.com/questions/237671/long-running-query-on-read-only-replica-that-takes-moments-on-the-primary/
[Date Tables are Great for Users, but Not So Great for Performance]:https://www.brentozar.com/archive/2020/08/date-tables-are-great-for-users-but-not-so-great-for-performance/
[Should I install SSMS on a server running SQL Server?]:https://am2.co/2020/04/should-i-install-ssms-on-a-server-running-sql-server/
[Finding a table name from a page ID]:https://www.sqlskills.com/blogs/paul/finding-table-name-page-id/
[Finding Distinct Values Quickly]:https://sqlperformance.com/2020/03/sql-performance/finding-distinct-values-quickly
[Can You Fail To Spill To tempdb?]:https://www.joshthecoder.com/2019/07/17/can-you-fail-to-spill-to-tempdb.html
[Migrating SQL workloads to Microsoft Azure: Databases Trip to Azure SQL Database]:https://www.sqlshack.com/migrate-sql-workloads-to-microsoft-azure-databases-trip-to-azure-sql-database/
[How It Works: Bob Dorr's SQL Server I/O Presentation]:https://techcommunity.microsoft.com/t5/sql-server-support/how-it-works-bob-dorr-s-sql-server-i-o-presentation/ba-p/316031
[Who does SQL Server run xp_cmdshell command as?]:https://stevestedman.com/2020/04/who-does-sql-server-run-xp_cmdshell-command-as/
[Transaction Modes in SQL Server]:https://36chambers.wordpress.com/2020/08/10/transaction-modes-in-sql-server/
[Working Effectively with Legacy SQL]:https://www.catallaxyservices.com/presentations/legacy-sql/
[A SQL Server DBA myth a day: (26/30) nested transactions are real]:https://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-2630-nested-transactions-are-real/
[dbatools multithreading commands with PoshRSJob module]:https://dbatools.io/multithread/
[SQL Server Debugging with WinDbg – an Introduction]:https://www.sqlpassion.at/archive/2014/05/05/sql-server-debugging-with-windbg-an-introduction/
[Looking deeper into SQL Server using Minidumps]:https://docs.microsoft.com/en-gb/archive/blogs/sqlcat/looking-deeper-into-sql-server-using-minidumps
[Anatomy of a spool operators in SQL Server execution plans]:https://sqlserverfast.com/articles/anatomy-of-a-spool/
[CAST v/s CONVERT – Is there a difference as far as SQL Server is concerned? Which is better?]:https://nakulvachhrajani.com/2011/07/18/cast-vs-convert-is-there-a-difference-as-far-as-sql-server-is-concerned-which-is-better/
[#BackToBasics: CAST vs. CONVERT]:https://www.sentryone.com/blog/aaronbertrand/backtobasics-cast-vs-convert
[Productivity Hacks: Migrate in Minutes to the Most Current Version of SQL Server]:https://www.rubrik.com/blog/migrate-quickly-current-version-sql-server/
[Database alias in Microsoft SQL Server]:http://www.baud.cz/blog/database-alias-in-microsoft-sql-server
[The Curious Case of… the 8060-byte row size limit]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-the-8060-byte-row-size-limit/
[.NET TransactionScope Considered Annoying - Default Isolation Level is Serializable]:https://joshthecoder.com/2020/07/27/transactionscope-considered-annoying.html
[Parameter Sniffing, Embedding, and the RECOMPILE Options]:https://sqlperformance.com/2013/08/t-sql-queries/parameter-sniffing-embedding-and-the-recompile-options
[Why You’re Tuning Stored Procedures Wrong (the Problem with Local Variables)]:https://www.brentozar.com/archive/2014/06/tuning-stored-procedures-local-variables-problems/
[Yet Another Post About Local Variables]:https://www.erikdarlingdata.com/sql-server/yet-another-post-about-local-variables/
[Cleaning up Backups from Azure Blob Storage]:http://www.nikoport.com/2020/03/30/cleaning-up-backups-from-azure-blob-storage/
[Temporary Table Caching Explained]:https://www.sql.kiwi/2012/08/temporary-object-caching-explained.html
[SQL Server Temporary Object Caching]:https://sqlperformance.com/2017/05/sql-performance/sql-server-temporary-object-caching
[Dynamic Data Unmasking]:https://www.erikdarlingdata.com/sql-server/dynamic-data-unmasking/
[3 Ways to Run DBCC CHECKDB Faster]:https://www.brentozar.com/archive/2020/08/3-ways-to-run-dbcc-checkdb-faster/
[Back Up SQL Server 43%-67% Faster by Writing to Multiple Files]:https://www.brentozar.com/archive/2020/08/back-up-sql-server-43-67-faster-by-writing-to-multiple-files/
[Bad Habits to Kick : Using SELECT * / omitting the column list]:https://sqlblog.org/2009/10/10/bad-habits-to-kick-using-select-omitting-the-column-list
[All The Problems With Select *]:https://www.erikdarlingdata.com/sql-server/all-the-problems-with-select/
[When Select * Doesn’t Matter]:https://www.erikdarlingdata.com/sql-server/when-select-doesnt-matter/
[HT Waits – Explained and Animated]:https://forrestmcdaniel.com/2020/08/12/ht-waits-explained-and-animated/
[SQL Server 100% Online Deployments]:https://michaeljswart.com/2018/01/100-online-deployments/
[When Measuring Timespans, try DATEADD instead of DATEDIFF]:https://michaeljswart.com/2017/12/when-measuring-timespans-try-dateadd-instead-of-datediff/
[The Curious Case of… setting up a server for DBCC CHECKDB]:https://www.sqlskills.com/blogs/paul/the-curious-case-of-setting-up-a-server-for-dbcc-checkdb/
[When should a primary key be declared non-clustered?]:https://dba.stackexchange.com/q/7741/107045
[Guid vs INT - Which is better as a primary key?]:https://dba.stackexchange.com/q/264/107045
[Control SQL Jobs based on HADR Role – Taking it to the Next Level]:https://eitanblumin.com/2020/05/26/sql-jobs-based-on-hadr-role-next-level/
[SQL Friday #16: Eitan Blumin on “How to HADR Your SQL Jobs”]:https://sqlfriday.net/past-sql-friday-sessions/sql-friday-16-eitan-blumin-on-how-to-hadr-your-sql-jobs/
[Choosing the Correct Azure VM Size for Your Workload]:https://www.sentryone.com/blog/choosing-the-correct-azure-vm-size-for-your-workload
[Table Partitioning in SQL Server – The Basics]:https://www.cathrinewilhelmsen.net/2015/04/12/table-partitioning-in-sql-server/
[Table Partitioning in SQL Server – Partition Switching]:https://www.cathrinewilhelmsen.net/2015/04/19/table-partitioning-in-sql-server-partition-switching/
[TempDB in SQL Server]:https://www.sentryone.com/tempdb-in-sql-server
[SQL Server’s Cost Threshold for Parallelism]:https://www.brentozar.com/archive/2014/11/sql-server-cost-threshold-for-parallelism/
[How many CPUs is my parallel query using in SQL Server?]:https://www.brentozar.com/archive/2014/11/many-cpus-parallel-query-using-sql-server/
[Protecting your data against unauthorised reads on SQL Server]:https://monin-it.be/2020/06/23/protectingyourdata/
[SET IMPLICIT_TRANSACTIONS ON Is One Hell of a Bad Idea]:https://www.brentozar.com/archive/2018/02/set-implicit_transactions-one-hell-bad-idea/
[Tempdb: The Ghost Of Version Store]:https://kohera.be/blog/sql-server/tempdb-the-ghost-of-version-store/
[Row Versioning Concurrency in SQL Server]:https://www.red-gate.com/simple-talk/sql/t-sql-programming/row-versioning-concurrency-in-sql-server/
[When Tempdb Becomes Permanentdb (In-memory tempdb metadata and Resource governor problems)]:https://kohera.be/blog/sql-server/when-tempdb-becomes-permanentdb/
[A SQL Server DBA myth a day: (26/30) nested transactions are real]:https://www.sqlskills.com/blogs/paul/a-sql-server-dba-myth-a-day-2630-nested-transactions-are-real/
[The Best Medium-Hard Data Analyst SQL Interview Questions]:https://quip.com/2gwZArKuWk7W
[Starting SQL: Why Not Make Everything Dynamic?]:https://www.erikdarlingdata.com/starting-sql/starting-sql-why-not-make-everything-dynamic/
[dbatools multithreading commands]:https://dbatools.io/multithread/
[Preventing Brute Force Attacks in SQL Server]:https://blog.coeo.com/preventing-brute-force-attacks-in-sql-server
[Asynchronous T-SQL Execution Without Service Broker]:https://www.codeproject.com/Articles/29356/Asynchronous-T-SQL-Execution-Without-Service-Broke
[Using hash values in SSIS to determine when to insert or update rows]:https://www.mssqltips.com/sqlservertip/3170/using-hash-values-in-ssis-to-determine-when-to-insert-or-update-rows/
[Capturing Queries Can Be A Pain]:https://www.scarydba.com/2020/08/03/capturing-queries-can-be-a-pain/
[Building full-text indexes using the Sphinx search engine]:https://www.sqlshack.com/building-full-text-indexes-using-the-sphinx-search-engine/
[Starting SQL: Measuring A Query]:https://www.erikdarlingdata.com/starting-sql/starting-sql-measuring-a-query/
[When to use SET vs SELECT when assigning values to variables in SQL Server]:https://www.mssqltips.com/sqlservertip/1888/when-to-use-set-vs-select-when-assigning-values-to-variables-in-sql-server/
[What is the difference between SET and SELECT when assigning values to variables, in T-SQL?]:http://vyaskn.tripod.com/differences_between_set_and_select.htm
[CHECKDB From Every Angle: How long will CHECKDB take to run?]:https://www.sqlskills.com/blogs/paul/checkdb-from-every-angle-how-long-will-checkdb-take-to-run/
[CHECKDB From Every Angle: Consistency Checking Options for a VLDB]:https://www.sqlskills.com/blogs/paul/checkdb-from-every-angle-consistency-checking-options-for-a-vldb/
[Minimizing the impact of DBCC CHECKDB : DOs and DON'Ts]:https://sqlperformance.com/2012/11/io-subsystem/minimize-impact-of-checkdb
[A faster CHECKDB – Part II]:https://web.archive.org/web/20150315173540/http://blogs.msdn.com/b/psssql/archive/2012/02/23/a-faster-checkdb-part-ii.aspx
[A faster CHECKDB – Part III]:https://web.archive.org/web/20150206201933/http://blogs.msdn.com/b/psssql/archive/2014/11/10/a-faster-checkdb-part-iii.aspx
[A faster CHECKDB – Part IV (SQL CLR UDTs)]:https://web.archive.org/web/20150205043737/http://blogs.msdn.com/b/psssql/archive/2015/01/26/a-faster-checkdb-part-iv-sql-clr-udts.aspx
[Minimize performance impact of SQL Server DBCC CHECKDB]:https://www.mssqltips.com/sqlservertip/2399/minimize-performance-impact-of-sql-server-dbcc-checkdb/
[Starting SQL: A Little More Fun With Logging Dynamic SQL]:https://www.erikdarlingdata.com/starting-sql/starting-sql-a-little-more-fun-with-logging-dynamic-sql/
[Allocation Order Scans]:https://sqlperformance.com/2015/01/t-sql-queries/allocation-order-scans
[Parameter Sniffing in SQL Server 2019: Air_Quote_Actual Plans]:https://www.brentozar.com/archive/2019/04/parameter-sniffing-in-sql-server-2019-air_quote_actual-plans/
[Guide For Set Up Of Telegraf For Monitoring Sql Server Xplat]:https://tracyboggiano.com/archive/2018/02/setup-of-telegraf/
[Azure Table Storage Tips for the RDBMS Developer]:https://www.sentryone.com/blog/azure-table-storage-tips-for-the-rdbms-developer
[sql_handle and the SQL Server batch text hash]:https://www.sql.kiwi/2020/10/sqlhandle-and-sql-server-batch-text-hash.html
[Navigating DBCC CHECKDB for VLDB]:https://sqlblog.org/2020/11/05/navigating-dbcc-checkdb-for-vldb
[Hidden Formatting Troubles with STR() (SQL Spackle)]:https://www.sqlservercentral.com/articles/hidden-formatting-troubles-with-str-sql-spackle
[The What, Why, When, and How of Incremental Loads]:https://www.timmitchell.net/post/2020/07/23/incremental-loads/
[How Do I Know If My Query Is Good Enough for Production?]:https://www.brentozar.com/archive/2020/08/how-do-i-know-if-my-query-is-good-enough-for-production/
[How to Find Out Whose Queries are Using The Most CPU]:https://www.brentozar.com/archive/2020/08/how-to-find-out-whose-queries-are-using-the-most-cpu/
[Limitations of SQL Server Native Backup and Restore in Amazon RDS]:https://www.mssqltips.com/sqlservertip/5042/limitations-of-sql-server-native-backup-and-restore-in-amazon-rds/
[SQL Server Native Backup and Restore in Amazon RDS]:https://www.mssqltips.com/sqlservertip/5041/sql-server-native-backup-and-restore-in-amazon-rds/
[What Is the SQL Server CEIP Service (telemetry)?]:https://www.brentozar.com/archive/2020/10/what-is-the-sql-server-ceip-service/
[Maximum Simultaneous User Connections]:http://www.sqlnuggets.com/blog/disable-telemetry-on-multiple-sql-servers-with-powershell/
[Find Database Connection Leaks in Your Application]:https://sqlperformance.com/2017/07/sql-performance/find-database-connection-leaks
[How to Troubleshoot THREADPOOL Waits and Deadlocked Schedulers]:https://eitanblumin.com/2020/10/05/how-to-troubleshoot-threadpool-waits-and-deadlocked-schedulers/
[Prevent Lock Escalation On Indexed Views]:https://kohera.be/blog/sql-server/prevent-lock-escalation-on-indexed-views/
[Concatenating Strings in SQL Server]:https://www.madeiradata.com/post/concatenating-strings
[Why Full Text’s CONTAINS Queries Are So Slow]:https://www.brentozar.com/archive/2020/11/why-full-texts-contains-queries-are-so-slow/
[Migrating SSIS to Azure – an Overview]:https://sqlkover.com/migrating-ssis-to-azure-an-overview/
[(Video) How to Troubleshoot Someone Else’s Temp Table Contents]:https://www.brentozar.com/archive/2020/11/video-how-to-troubleshoot-someone-elses-temp-table-contents/
[A Parameterization Puzzle With TOP: Part 1]:https://www.erikdarlingdata.com/execution-plans/a-parameterization-puzzle-with-top-part-1/
[A Parameterization Puzzle With TOP: Part 2]:https://www.erikdarlingdata.com/execution-plans/a-parameterization-puzzle-with-top-part-2/
[T-SQL: Get The Text Between Two Delimiters]:https://www.erikdarlingdata.com/sql-server/t-sql-get-the-text-between-two-delimiters/
[Explore dynamic management views for monitoring SQL Server Always On Availability Groups]:https://www.sqlshack.com/explore-dynamic-management-views-for-monitoring-sql-server-always-on-availability-groups/
[Deploy SQLWATCH to SQL Server using GitHub Actions]:https://www.kevinrchant.com/2020/11/17/deploy-sqlwatch-to-sql-server-using-github-actions/
[SQL Server table hints – WITH (NOLOCK) best practices]:https://www.sqlshack.com/understanding-impact-clr-strict-security-configuration-setting-sql-server-2017/
[Memory-Optimized TempDB Metadata in SQL Server 2019]:https://www.mssqltips.com/sqlservertip/6230/memoryoptimized-tempdb-metadata-in-sql-server-2019/
[What permissions do temp stored procedures use?]:https://sqlstudies.com/2019/06/19/what-permissions-do-temp-stored-procedures-use/
[SQLskills SQL101: Should you kill that long-running transaction?]:https://www.sqlskills.com/blogs/paul/sqlskills-sql101-should-you-kill-that-long-running-transaction/
[A quick and dirty scan of a list of instances using a dynamic linked server]:https://sqlstudies.com/2020/11/12/a-quick-and-dirty-scan-of-a-list-of-instances-using-a-dynamic-linked-server/
[sp_whoisactive: Analyzing Tempdb Contention]:http://whoisactive.com/docs/21_tempdb/
[How to Choose Between RCSI and Snapshot Isolation Levels]:https://littlekendra.com/2016/02/18/how-to-choose-rcsi-snapshot-isolation-levels/
[Explore the SQL query table hint READPAST]:https://www.sqlshack.com/explore-the-sql-query-table-hint-readpast/
[How Bad Statistics Cause Bad SQL Server Query Performance]:https://www.brentozar.com/archive/2020/11/how-bad-statistics-cause-bad-sql-server-query-performance/
[How Scalar User-Defined Functions Slow Down Queries]:https://www.brentozar.com/archive/2020/11/how-scalar-user-defined-functions-slow-down-queries/
[Could verifying your backups be costing you money?]:https://blog.coeo.com/verifying-backups-cost
[Extended Events: System_health And A Long Running Query]:https://www.scarydba.com/2020/03/09/extended-events-system_health-and-a-long-running-query/
[Altering an indexed view in SQL Server drops all indexes]:https://littlekendra.com/2020/03/02/altering-an-indexed-view-in-sql-server-drops-all-indexes/
[Deprecated and discontinued features in SQL Server]:https://bornsql.ca/blog/deprecated-and-discontinued-features-in-sql-server/
[Query Store, Plan Forcing, And Drop/create]:https://www.scarydba.com/2020/03/02/query-store-plan-forcing-and-drop-create/
[Uncommon SQL in SQL Server]:https://nocolumnname.blog/2020/11/20/uncommon-sql/
[Configure SQL Server Replication between AWS RDS SQL Server and On-premises SQL Server]:https://www.sqlshack.com/configure-sql-server-replication-between-aws-rds-sql-server-and-on-premises-sql-server/
[Import data into Azure SQL database from AWS Redshift]:https://www.sqlshack.com/import-data-into-azure-sql-database-from-aws-redshift/
[When You’re Troubleshooting Blocking, Look at Query #2, Too.]:https://www.brentozar.com/archive/2020/11/when-youre-troubleshooting-blocking-look-at-query-2-too/
[Finding the One Query to Tune in a Multi-Query Batch]:https://www.brentozar.com/archive/2020/11/finding-the-one-query-to-tune-in-a-multi-query-batch/
[Recursion in SQL Explained Visually]:https://medium.com/swlh/recursion-in-sql-explained-graphically-679f6a0f143b
[Viva la Famiglia! Stored procedure for created recursive family tree]:https://bradsruminations.blogspot.com/2009/10/viva-la-famiglia.html
[How to Set & Get the Next ID Without Serializable Isolation]:https://www.brentozar.com/archive/2020/11/how-to-set-get-the-next-id-without-serializable-isolation/
[Discovering Three or Four Part Names in SQL Server Database Code]:https://www.red-gate.com/simple-talk/blogs/discovering-three-or-four-part-names-in-sql-server-database-code/
[Troubleshooting RESOURCE_SEMAPHORE_QUERY_COMPILE Helper Queries]:https://www.erikdarlingdata.com/sql-server/troubleshooting-resource_semaphore_query_compile-helper-queries/
[When Do I Need to Use DESC in Indexes?]:https://www.brentozar.com/archive/2020/11/when-do-i-need-to-use-desc-in-indexes/
[Export Power BI Desktop data to SQL Server]:https://ruiromanoblog.wordpress.com/2016/04/21/use-power-bi-desktop-as-an-etl-tool/
[Exploring errors to reveal unauthorized information]:https://www.red-gate.com/simple-talk/sql/database-administration/exploring-errors-to-reveal-unauthorized-information/
[How to run your CTE just once, and re-use the output]:https://sqlsunday.com/2020/12/01/run-your-cte-just-once-and-reuse-output/
[Documenting SSIS Packages using Sequence Diagrams]:https://www.sqlshack.com/documenting-ssis-packages-using-sequence-diagrams-2/
