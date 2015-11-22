# Microsoft SQL Server Version
Download links and complete information for all Microsoft SQL Server versions and builds

Headers:
 - [What are the most recent updates for SQL Server? (by Brent Ozar)](#what-are-the-most-recent-updates-for-sql-server-by-brent-ozar)
 - [Internal Database Version and Compatibility Level](#internal-database-version-and-compatibility-level)
 - [Quick summary for SQL Server Service Packs](#quick-summary-for-sql-server-service-packs)
 - [Microsoft SQL Server 2016 Builds](#microsoft-sql-server-2016-builds)
 - [Microsoft SQL Server 2014 Builds](#microsoft-sql-server-2014-builds)
 - [Microsoft SQL Server 2012 Builds](#microsoft-sql-server-2012-builds)
 - [Microsoft SQL Server 2008 R2 Builds](#microsoft-sql-server-2008-r2-builds)
 - [Microsoft SQL Server 2008 Builds](#microsoft-sql-server-2008-builds)
 - [Microsoft SQL Server 2005 Builds](#microsoft-sql-server-2005-builds)

Source link:
 - Awesome unofficial build chart lists: <http://sqlserverbuilds.blogspot.ru/>
 - SQL Server Updates by Brent Ozar team: <http://sqlserverupdates.com/>
 - Wikipedia: <https://en.wikipedia.org/wiki/Microsoft_SQL_Server>

Useful articles:
 - [How to identify your SQL Server version and edition](http://support.microsoft.com/kb/321185/en-us)
 - [SQL Server Internal Database Versions](http://sqlserverbuilds.blogspot.ru/2014/01/sql-server-internal-database-versions.html)
 - [Microsoft SQL Server Support Lifecycle](http://support2.microsoft.com/lifecycle/?LN=en-us&c2=1044)
 - [Microsoft SQL Server Home](http://www.microsoft.com/sql)
 - [Microsoft SQL Server Developer Center](http://msdn.microsoft.com/sqlserver)
 - [Microsoft TechNet: Microsoft SQL Server](http://technet.microsoft.com/en-us/sqlserver)
 - [Microsoft Knowledge Base](http://kbupdate.info/)
 - [Sqlservr.exe versions](http://www.mskbfiles.com/sqlservr.exe.php)

All SQLServer service packs are cumulative, meaning that each new service pack contains all the fixes that are included with previous service packs and any new fixes.

Legend:
 - **CTP**: Community Technology Preview (beta release)
 - **RC**:  Release Candidate
 - **RTM**: Released To Manufacturing; It is the original, released build version of the product, i.e. what you get on the DVD or when you download the ISO file from MSDN.
 - **CU**:  Cumulative Update; Cumulative updates contain the bug fixes and enhancements–up to that point in time–that have been added since the previous Service Pack release and will be contained in the next service pack release. Installation of the Cumulative Update is similar to the installation of a Service Pack. Cumulative Updates are not fully regression tested.
 - **SP**: Service Pack; much larger collection of hotfixes that have been fully regression tested. In some cases delivers product enhancements.
 - **GDR**: General Distribution Release; GDR fixes should not contain any of the CU updates.
 - **QFE**: Quick Fix Engineering; QFE updates include CU fixes.
 - **SU**: Security update.


## What are the most recent updates for SQL Server? (by Brent Ozar)

| Version | Latest Update                                  | Build Number                 | Release Date              | Support Ends | Other Updates                                                     |
|---------|------------------------------------------------|------------------------------|---------------------------|--------------|-------------------------------------------------------------------|
| 2016    | [Download CTP3 2016]                           | 13.00.700.139                | 2015-10-28                | ?            | [Other SQL 2016 Updates](#microsoft-sql-server-2016-builds)       |
| 2014    | [Download SP1 2014] then<br/>[CU3 KB3094221]   | 12.0.4100.1<br/>12.0.4427.24 | 2015-05-15<br/>2015-10-19 | 2024-07-09   | [Other SQL 2014 Updates](#microsoft-sql-server-2014-builds)       |
| 2012    | [Download SP2 2012] then<br/>[CU9 KB3098512]   | 11.0.5058.0<br/>11.0.5641.0  | 2014-06-10<br/>2015-11-18 | 2022-07-12   | [Other SQL 2012 Updates](#microsoft-sql-server-2012-builds)       |
| 2008 R2 | [Download SP3 2008 R2] then<br/>[SU KB3045311] | 10.50.6000<br/>10.50.6220.0  | 2014-09-30<br/>2015-07-14 | 2019-07-09   | [Other SQL 2008 R2 Updates](#microsoft-sql-server-2008-r2-builds) |
| 2008    | [Download SP4 2008] then<br/>[SU KB3045316]    | 10.00.6000<br/>10.0.6241.0   | 2014-09-30<br/>2015-07-14 | 2019-07-09   | [Other SQL 2008 Updates](#microsoft-sql-server-2008-builds)       |
| 2005    | [Download SP4 2005] then<br/>[CU3 2507769]     | 9.00.5000.00<br/>9.00.5266   | 2010-12-17<br/>2011-03-17 | 2016-04-12   | [Other SQL 2005 Updates](#microsoft-sql-server-2005-builds)       |

[Download CTP3 2016]:https://technet.microsoft.com/en-in/evalcenter/mt130694.aspx
[Download SP1 2014]:http://www.microsoft.com/en-us/download/details.aspx?id=46694&WT.mc_id=rss_alldownloads_all
[CU3 KB3094221]:https://support.microsoft.com/en-us/kb/3094221
[Download SP2 2012]:http://www.microsoft.com/en-us/download/details.aspx?id=43340
[CU9 KB3098512]:https://support.microsoft.com/en-us/kb/3098512
[Download SP3 2008 R2]:http://www.microsoft.com/en-us/download/details.aspx?id=44271
[SU KB3045311]:https://www.microsoft.com/downloads/details.aspx?familyid=7af16cb8-c944-41cb-a897-c6fc373869cd
[Download SP4 2008]:http://www.microsoft.com/en-us/download/details.aspx?id=44278
[SU KB3045316]:https://www.microsoft.com/downloads/details.aspx?familyid=40328565-3067-4e36-96ba-26ade333d715
[Download SP4 2005]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=b953e84f-9307-405e-bceb-47bd345baece
[CU3 2507769]:http://support.microsoft.com/kb/2507769


## Internal Database Version and Compatibility Level

| SQL Server Version                           | Code Name   | Release Year | Internal Database Version | Database Compatibility Level |
|:---------------------------------------------|:------------|-------------:|--------------------------:|-----------------------------:|
| SQL Server 2016                              | ?           | 2016         | 782                       | 120                          |
| SQL Server 2014                              | SQL14       | 2014         | 782                       | 120                          |
| SQL Server 2012                              | Denali      | 2012         | 706                       | 110                          |
| SQL Server 2012 CTP1                         | Denali      | 2010         | 684                       | 110                          |
| SQL Server 2008 R2                           | Kilimanjaro | 2010         | 660 / 661                 | 100                          |
| Azure SQL DB                                 | CloudDB     | 2010         | ?                         | ?                          |
| SQL Server 2008                              | Katmai      | 2008         | 655                       | 100                          |
| SQL Server 2005 SP2+ with VarDecimal enabled | Yukon       | 2005         | 612                       |  90                          |
| SQL Server 2005                              | Yukon       | 2005         | 611                       |  90                          |
| SQL Server 2000                              | Shiloh      | 2000         | 539                       |  80                          |
| SQL Server 7.0                               | Sphinx      | 1998         | 515                       |  70                          |
| SQL Server 6.5                               | Hydra       | 1996         | 408                       |  65                          |
| SQL Server 6.0                               | SQL95       | 1995         | ?                         |  60                          |
| SQL Server 4.21                              | SQLNT       | 1993         | ?                         |  60                          |
| SQL Server 1.1 (16 bit)                      | ?           | 1991         | ?                         |  60                          |
| SQL Server 1.0 (16 bit)                      | Ashton-Tate | 1989         | ?                         |  60                          |


## Quick summary for SQL Server Service Packs

| Version            | Codename    | RTM (no SP)  | SP1                             | SP2                             | SP3                               | SP4                             |
|:-------------------|:------------|:-------------|:--------------------------------|:--------------------------------|:----------------------------------|:--------------------------------|
| SQL Server 2016    | ?           | [CTP 3.0]    |                                 |                                 |                                   |                                 |
| SQL Server 2014    | SQL14       | 12.0.2000.8  | [12.0.4100.1]<br/>12.1.4100.1   |                                 |                                   |                                 |
| SQL Server 2012    | Denali      | 11.0.2100.60 | [11.0.3000.0]<br/>11.1.3000.0   | [11.0.5058.0]                   |                                   |                                 |
| SQL Server 2008 R2 | Kilimanjaro | 10.50.1600.1 | [10.50.2500.0]<br/>10.51.2500.0 | [10.50.4000.0]<br/>10.52.4000.0 | [10.50.6000.34]<br/>10.53.6000.34 |                                 |
| SQL Server 2008    | Katmai      | 10.0.1600.22 | [10.0.2531.0]<br/>10.1.2531.0   | [10.0.4000.0]<br/>10.2.4000.0   | [10.0.5500.0]<br/>10.3.5500.0     | [10.0.6000.29]<br/>10.4.6000.29 |
| SQL Server 2005    | Yukon       | 9.0.1399.06  | [9.0.2047]                      | [9.0.3042]                      | [9.0.4035]                        | [9.0.5000]                      |
| SQL Server 2000    | Shiloh      | 8.0.194      | [8.0.384]                       | [8.0.532]                       | [8.0.760]                         | [8.0.2039]                      |
| SQL Server 7.0     | Sphinx      | 7.0.623      | 7.0.699                         | 7.0.842                         | 7.0.961                           | [7.0.1063]                      |
| SQL Server 6.5     | Hydra       | ?            |                                 |                                 |                                   |                                 |
| SQL Server 6.0     | SQL95       | ?            |                                 |                                 |                                   |                                 |
| SQL Server 4.21    | SQLNT       | ?            |                                 |                                 |                                   |                                 |

[CTP 3.0]:https://www.microsoft.com/en-us/evalcenter/evaluate-sql-server-2016#evaluation_4114
[12.0.4100.1]:http://www.microsoft.com/en-us/download/details.aspx?id=46694
[11.0.3000.0]:http://www.microsoft.com/en-us/download/details.aspx?id=35575
[11.0.5058.0]:http://www.microsoft.com/en-us/download/details.aspx?id=43340
[10.50.2500.0]:http://www.microsoft.com/en-us/download/details.aspx?id=26727
[10.50.4000.0]:http://www.microsoft.com/en-us/download/details.aspx?id=30437
[10.50.6000.34]:http://www.microsoft.com/en-us/download/details.aspx?id=44271
[10.0.2531.0]:http://www.microsoft.com/downloads/details.aspx?familyid=66AB3DBB-BF3E-4F46-9559-CCC6A4F9DC19
[10.0.4000.0]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=8FBFC1DE-D25E-4790-88B5-7DDA1F1D4E17
[10.0.5500.0]:http://www.microsoft.com/download/en/details.aspx?id=27594
[10.0.6000.29]:http://www.microsoft.com/en-us/download/details.aspx?id=44278
[9.0.2047]:http://www.microsoft.com/downloads/details.aspx?FamilyID=CB6C71EA-D649-47FF-9176-E7CAC58FD4BC
[9.0.3042]:http://www.microsoft.com/downloads/details.aspx?FamilyId=d07219b2-1e23-49c8-8f0c-63fa18f26d3a
[9.0.4035]:http://www.microsoft.com/downloads/details.aspx?FamilyId=ae7387c3-348c-4faa-8ae5-949fdfbe59c4
[9.0.5000]:http://www.microsoft.com/downloads/details.aspx?FamilyId=b953e84f-9307-405e-bceb-47bd345baece
[8.0.384]:http://www.microsoft.com/downloads/details.aspx?FamilyID=DFF43C50-51DF-4FE0-9717-DE41FB48556E
[8.0.532]:http://www.microsoft.com/downloads/details.aspx?FamilyID=75672496-af8e-40dc-853e-ad2c9fe96882
[8.0.760]:http://www.microsoft.com/downloads/details.aspx?familyid=90DCD52C-0488-4E46-AFBF-ACACE5369FA3
[8.0.2039]:http://www.microsoft.com/downloads/details.aspx?FamilyId=8E2DFC8D-C20E-4446-99A9-B7F0213F8BC5
[7.0.1063]:https://www.microsoft.com/en-us/download/details.aspx?id=7959


## Microsoft SQL Server 2016 Builds

| Build        | File version     | KB / Description                                                                | Release Date |
|--------------|------------------|---------------------------------------------------------------------------------|--------------|
| 13.0.700.139 | 2016.130.700.139 | [Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)]           | 2015-10-28   |
| 13.0.600.65  | 2016.130.600.65  | Microsoft SQL Server 2016 Community Technology Preview 2.4 (CTP2.4)             | 2015-09-30   |
| 13.0.500.53  | 2016.130.500.53  | Microsoft SQL Server 2016 Community Technology Preview 2.3 (CTP2.3)             | 2015-08-28   |
| 13.0.407.1   | 2016.130.407.1   | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2)             | 2015-07-23   |
| 13.0.400.91  | 2016.130.400.91  | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2) [withdrawn] | 2015-07-22   |
| 13.0.300.44  | 2016.130.300.444 | Microsoft SQL Server 2016 Community Technology Preview 2.1 (CTP2.1)             | 2015-06-24   |
| 13.0.200.172 | 2016.130.200.172 | Microsoft SQL Server 2016 Community Technology Preview 2 (CTP2)                 | 2015-05-27   |

[Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)]:https://technet.microsoft.com/en-in/evalcenter/mt130694.aspx


## Microsoft SQL Server 2014 Builds

| Build     | File version     | KB / Description                                                                                                                 | Release Date |
|-----------|------------------|----------------------------------------------------------------------------------------------------------------------------------|--------------|
| 12.0.4427 | 2014.120.4427.24 | [3094221 Cumulative update package 3 (CU3) for SQL Server 2014 Service Pack 1]                                                     | 2015-10-21   |
| 12.0.4422 | 2014.120.4422.0  | [3075950 Cumulative update package 2 (CU2) for SQL Server 2014 Service Pack 1]                                                     | 2015-08-17   |
| 12.0.4416 | 2014.120.4416.0  | [3067839 Cumulative update package 1 (CU1) for SQL Server 2014 Service Pack 1]                                                     | 2015-06-22   |
| 12.0.4213 | 2014.120.4213.0  | [MS15-058: Description of the nonsecurity update for SQL Server 2014 Service Pack 1 GDR: July 14, 2015]                            | 2015-07-14   |
| 12.0.4100 | 2014.120.4100.1  | [SQL Server 2014 Service Pack 1 (SP1)]                                                                                             | 2015-05-14   |
| 12.0.4050 | 2014.120.4050.0  | SQL Server 2014 Service Pack 1 (SP1) [withdrawn]                                                                                   | 2015-04-15   |
| 12.0.2556 | 2014.120.2556.4  | [3094220 Cumulative update package 10 (CU10) for SQL Server 2014]                                                                  | 2015-10-20   |
| 12.0.2553 | 2014.120.2553.0  | [3075949 Cumulative update package 9 (CU9) for SQL Server 2014]                                                                    | 2015-08-17   |
| 12.0.2548 | 2014.120.2548.0  | [MS15-058: Description of the security update for SQL Server 2014 QFE: July 14, 2015]                                              | 2015-07-14   |
| 12.0.2546 | 2014.120.2546.0  | [3067836 Cumulative update package 8 (CU8) for SQL Server 2014]                                                                    | 2015-06-22   |
| 12.0.2506 | 2014.120.2506.0  | [3063054 Update enables Premium Storage support for Data files on Azure Storage and resolves backup failures]                      | 2015-05-19   |
| 12.0.2505 | 2014.120.2505.0  | [3052167 FIX: Error 1205 when you execute parallel query that contains outer join operators in SQL Server 2014]                    | 2015-05-19   |
| 12.0.2504 | 2014.120.2504.0  | [2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014]                                               | 2015-05-05   |
| 12.0.2504 | 2014.120.2504.0  | [3058512 FIX: Unpivot Transformation task changes null to zero or empty strings in SSIS 2014]                                      | 2015-05-05   |
| 12.0.2495 | 2014.120.2495.0  | [3046038 Cumulative update package 7 (CU7) for SQL Server 2014]                                                                    | 2015-04-23   |
| 12.0.2488 | 2014.120.2488.0  | [3048751 FIX: Deadlock cannot be resolved automatically when you run a SELECT query that can result in a parallel batch-mode scan] | 2015-04-01   |
| 12.0.2485 | 2014.120.2485.0  | [3043788 An on-demand hotfix update package is available for SQL Server 2014]                                                      | 2015-03-16   |
| 12.0.2480 | 2014.120.2480.0  | [3031047 Cumulative update package 6 (CU6) for SQL Server 2014]                                                                    | 2015-02-16   |
| 12.0.2474 | 2014.120.2474.0  | [3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]                                                      | 2015-05-15   |
| 12.0.2472 | 2014.120.2472.0  | [3032087 FIX: Cannot show requested dialog after you connect to the latest SQL Database Update V12 (preview) with SQL Server 2014] | 2015-01-28   |
| 12.0.2464 | 2014.120.2464.0  | [3024815 Large query compilation waits on RESOURCE_SEMAPHORE_QUERY_COMPILE in SQL Server 2014]                                     | 2015-01-05   |
| 12.0.2456 | 2014.120.2456.0  | [3011055 Cumulative update package 5 (CU5) for SQL Server 2014]                                                                    | 2014-12-18   |
| 12.0.2436 | 2014.120.2436.0  | [3014867 FIX: "Remote hardening failure" exception cannot be caught and a potential data loss when you use SQL Server 2014]        | 2014-11-27   |
| 12.0.2430 | 2014.120.2430.0  | [2999197 Cumulative update package 4 (CU4) for SQL Server 2014]                                                                    | 2014-10-21   |
| 12.0.2423 | 2014.120.2423.0  | [3007050 FIX: RTDATA_LIST waits when you run natively stored procedures that encounter expected failures in SQL Server 2014]       | 2014-10-22   |
| 12.0.2405 | 2014.120.2405.0  | [2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014]                                               | 2014-09-25   |
| 12.0.2402 | 2014.120.2402.0  | [2984923 Cumulative update package 3 (CU3) for SQL Server 2014]                                                                    | 2014-08-18   |
| 12.0.2381 | 2014.120.2381.0  | [2977316 MS14-044: Description of the security update for SQL Server 2014 (QFE)]                                                   | 2014-08-12   |
| 12.0.2370 | 2014.120.2370.0  | [2967546 Cumulative update package 2 (CU2) for SQL Server 2014]                                                                    | 2014-06-27   |
| 12.0.2342 | 2014.120.2342.0  | [2931693 Cumulative update package 1 (CU1) for SQL Server 2014]                                                                    | 2014-04-21   |
| 12.0.2269 | 2014.120.2269.0  | [3045324 MS15-058: Description of the security update for SQL Server 2014 GDR: July 14, 2015]                                      | 2015-07-14   |
| 12.0.2254 | 2014.120.2254.0  | [2977315 MS14-044: Description of the security update for SQL Server 2014 (GDR)]                                                   | 2014-08-12   |
| 12.0.2000 | 2014.120.2000.8  | SQL Server 2014 RTM                                                                                                                | 2014-04-01   |
| 12.0.1524 | 2014.120.1524.0  | Microsoft SQL Server 2014 Community Technology Preview 2 (CTP2)                                                                    | 2013-10-15   |
| 11.0.9120 | 2013.110.9120.0  | Microsoft SQL Server 2014 Community Technology Preview 1 (CTP1)                                                                    | 2013-06-25   |

[3094221 Cumulative update package 3 (CU3) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3094221/en-us
[3075950 Cumulative update package 2 (CU2) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3075950/en-us
[3067839 Cumulative update package 1 (CU1) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3067839/en-us
[MS15-058: Description of the nonsecurity update for SQL Server 2014 Service Pack 1 GDR: July 14, 2015]:https://support.microsoft.com/en-us/kb/3070446
[SQL Server 2014 Service Pack 1 (SP1)]:http://www.microsoft.com/en-us/download/details.aspx?id=46694
[3094220 Cumulative update package 10 (CU10) for SQL Server 2014]:http://support.microsoft.com/kb/3094220/en-us
[3075949 Cumulative update package 9 (CU9) for SQL Server 2014]:http://support.microsoft.com/kb/3075949/en-us
[MS15-058: Description of the security update for SQL Server 2014 QFE: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045323
[3067836 Cumulative update package 8 (CU8) for SQL Server 2014]:http://support.microsoft.com/kb/3067836/en-us
[3063054 Update enables Premium Storage support for Data files on Azure Storage and resolves backup failures]:http://support.microsoft.com/kb/3063054/en-us
[3052167 FIX: Error 1205 when you execute parallel query that contains outer join operators in SQL Server 2014]:http://support.microsoft.com/kb/3052167/en-us
[2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014]:http://support.microsoft.com/kb/2999809/en-us
[3058512 FIX: Unpivot Transformation task changes null to zero or empty strings in SSIS 2014]:http://support.microsoft.com/kb/3058512/en-us
[3046038 Cumulative update package 7 (CU7) for SQL Server 2014]:http://support.microsoft.com/kb/3046038/en-us
[3048751 FIX: Deadlock cannot be resolved automatically when you run a SELECT query that can result in a parallel batch-mode scan]:http://support.microsoft.com/kb/3048751/en-us
[3043788 An on-demand hotfix update package is available for SQL Server 2014]:http://support.microsoft.com/kb/3043788/en-us
[3031047 Cumulative update package 6 (CU6) for SQL Server 2014]:http://support.microsoft.com/kb/3031047/en-us
[3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]:http://support.microsoft.com/kb/3034679/en-us
[3032087 FIX: Cannot show requested dialog after you connect to the latest SQL Database Update V12 (preview) with SQL Server 2014]:http://support.microsoft.com/kb/3032087/en-us
[3024815 Large query compilation waits on RESOURCE_SEMAPHORE_QUERY_COMPILE in SQL Server 2014]:http://support.microsoft.com/kb/3024815/en-us
[3011055 Cumulative update package 5 (CU5) for SQL Server 2014]:http://support.microsoft.com/kb/3011055/en-us
[3014867 FIX: "Remote hardening failure" exception cannot be caught and a potential data loss when you use SQL Server 2014]:http://support.microsoft.com/kb/3014867/en-us
[2999197 Cumulative update package 4 (CU4) for SQL Server 2014]:http://support.microsoft.com/kb/2999197/en-us
[3007050 FIX: RTDATA_LIST waits when you run natively stored procedures that encounter expected failures in SQL Server 2014]:http://support.microsoft.com/kb/3007050/en-us
[2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014]:http://support.microsoft.com/kb/2999809/en-us
[2984923 Cumulative update package 3 (CU3) for SQL Server 2014]:http://support.microsoft.com/kb/2984923/en-us
[2977316 MS14-044: Description of the security update for SQL Server 2014 (QFE)]:http://support.microsoft.com/kb/2977316/en-us
[2967546 Cumulative update package 2 (CU2) for SQL Server 2014]:http://support.microsoft.com/kb/2967546/en-us
[2931693 Cumulative update package 1 (CU1) for SQL Server 2014]:http://support.microsoft.com/kb/2931693/en-us
[3045324 MS15-058: Description of the security update for SQL Server 2014 GDR: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045324
[2977315 MS14-044: Description of the security update for SQL Server 2014 (GDR)]:http://support.microsoft.com/kb/2977315/en-us


## Microsoft SQL Server 2012 Builds

| Build         | File version     | KB / Description                                                                                                                       | Release Date |
|---------------|------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------|
| [11.0.5641.0] | 11.2.56.41.0     | 3098512 Cumulative update package 9 for SQL Server 2012 SP2                                                                            | 2015-11-18   |
| 11.0.5636     | 2011.110.5636.3  | [3097636 FIX: Performance decrease when application with connection pooling frequently connects or disconnects in SQL Server]          | 2015-09-22   |
| 11.0.5634     | 2011.110.5634.0  | [3082561 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 2]                                                         | 2015-09-21   |
| 11.0.5629     | 2011.110.5629.0  | [3087872 FIX: Access violations when you use the FileTable feature in SQL Server 2012]                                                 | 2015-08-31   |
| 11.0.5623     | 2011.110.5623.0  | [3072100 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 2]                                                         | 2015-07-20   |
| 11.0.5613     | 2011.110.5613.0  | [3045319 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 QFE: July 14, 2015]                           | 2015-07-14   |
| 11.0.5592     | 2011.110.5592.0  | [3052468 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 2]                                                         | 2015-05-19   |
| 11.0.5582     | 2011.110.5582.0  | [3037255 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 2]                                                         | 2015-03-16   |
| 11.0.5571     | 2011.110.5571.0  | [3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]                                                          | 2015-05-15   |
| 11.0.5569     | 2011.110.5569.0  | [3007556 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 2]                                                         | 2015-01-20   |
| 11.0.5556     | 2011.110.5556.0  | [3002049 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 2]                                                         | 2014-11-17   |
| 11.0.5548     | 2011.110.5548.0  | [2983175 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 2]                                                         | 2014-09-15   |
| 11.0.5532     | 2011.110.5532.0  | [2976982 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 2]                                                         | 2014-07-24   |
| 11.0.5522     | 2011.110.5522.0  | [2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP2)]         | 2014-06-20   |
| 11.0.5343     | 2011.110.5343.0  | [3045321 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015]                           | 2015-07-14   |
| 11.0.5058     | 2011.110.5058.0  | [SQL Server 2012 Service Pack 2 (SP2)]                                                                                                 | 2014-06-10   |
| 11.0.3513     | 2011.110.3513.0  | [3045317 MS15-058: Description of the security update for SQL Server 2012 SP1 QFE: July 14, 2015]                                      | 2015-07-14   |
| 11.0.3492     | 2011.110.3492.0  | [3052476 Cumulative update package 16 (CU16) for SQL Server 2012 Service Pack 1]                                                       | 2015-05-18   |
| 11.0.3487     | 2011.110.3487.0  | [3038001 Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 1]                                                       | 2015-03-16   |
| 11.0.3486     | 2011.110.3486.0  | [3023636 Cumulative update package 14 (CU14) for SQL Server 2012 Service Pack 1]                                                       | 2015-01-19   |
| 11.0.3460     | 2011.110.3460.0  | [2977325 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (QFE)]                                        | 2014-08-12   |
| 11.0.3482     | 2011.110.3482.0  | [3002044 Cumulative update package 13 (CU13) for SQL Server 2012 Service Pack 1]                                                       | 2014-11-17   |
| 11.0.3470     | 2011.110.3470.0  | [2991533 Cumulative update package 12 (CU12) for SQL Server 2012 Service Pack 1]                                                       | 2014-09-15   |
| 11.0.3449     | 2011.110.3449.0  | [2975396 Cumulative update package 11 (CU11) for SQL Server 2012 Service Pack 1]                                                       | 2014-07-21   |
| 11.0.3437     | 2011.110.3437.0  | [2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP1)]         | 2014-06-10   |
| 11.0.3431     | 2011.110.3431.0  | [2954099 Cumulative update package 10 (CU10) for SQL Server 2012 Service Pack 1]                                                       | 2014-05-19   |
| 11.0.3412     | 2011.110.3412.0  | [2931078 Cumulative update package 9 (CU9) for SQL Server 2012 Service Pack 1]                                                         | 2014-03-18   |
| 11.0.3401     | 2011.110.3401.0  | [2917531 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 1]                                                         | 2014-01-20   |
| 11.0.3393     | 2011.110.3393.0  | [2894115 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 1]                                                         | 2013-11-18   |
| 11.0.3381     | 2011.110.3381.0  | [2874879 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 1]                                                         | 2013-09-16   |
| 11.0.3373     | 2011.110.3373.0  | [2861107 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 1]                                                         | 2013-07-16   |
| 11.0.3368     | 2011.110.3368.0  | [2833645 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 1]                                                         | 2013-05-31   |
| 11.0.3350     | 2011.110.3350.0  | [2832017 FIX: You can’t create or open SSIS projects or maintenance plans after you apply Cumulative Update 3 for SQL Server 2012 SP1] | 2013-04-17   |
| 11.0.3349     | 2011.110.3349.0  | [2812412 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 1]                                                         | 2013-03-18   |
| 11.0.3339     | 2011.110.3339.0  | [2790947 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 1]                                                         | 2013-01-25   |
| 11.0.3335     | 2011.110.3335.0  | [2800050 FIX: Component installation process fails after you install SQL Server 2012 SP1]                                              | 2013-01-14   |
| 11.0.3321     | 2011.110.3321.0  | [2765331 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 1]                                                         | 2012-11-20   |
| 11.0.3156     | 2011.110.3156.0  | [3045318 MS15-058: Description of the security update for SQL Server 2012 SP1 GDR: July 14, 2015]                                      | 2015-07-14   |
| 11.0.3153     | 2011.110.3153.0  | [2977326 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (GDR)]                                        | 2014-08-12   |
| 11.0.3128     | 2011.110.3128.0  | [2793634 Windows Installer starts repeatedly after you install SQL Server 2012 SP1]                                                    | 2013-01-03   |
| 11.0.3000     | 2011.110.3000.0  | [SQL Server 2012 Service Pack 1 (SP1)]                                                                                                 | 2012-11-06   |
| 11.0.2845     | 2011.110.2845.0  | SQL Server 2012 Service Pack 1 Customer Technology Preview 4 (CTP4)                                                                    | 2012-09-20   |
| 11.0.2809     | 2011.110.2809.24 | SQL Server 2012 Service Pack 1 Customer Technology Preview 3 (CTP3)                                                                    | 2012-07-05   |
| 11.0.2424     | 2011.110.2424.0  | [2908007 Cumulative update package 11 (CU11) for SQL Server 2012]                                                                      | 2013-12-17   |
| 11.0.2420     | 2011.110.2420.0  | [2891666 Cumulative update package 10 (CU10) for SQL Server 2012]                                                                      | 2013-10-21   |
| 11.0.2419     | 2011.110.2419.0  | [2867319 Cumulative update package 9 (CU9) for SQL Server 2012]                                                                        | 2013-08-21   |
| 11.0.2410     | 2011.110.2410.0  | [2844205 Cumulative update package 8 (CU8) for SQL Server 2012]                                                                        | 2013-06-18   |
| 11.0.2405     | 2011.110.2405.0  | [2823247 Cumulative update package 7 (CU7) for SQL Server 2012]                                                                        | 2013-04-15   |
| 11.0.2401     | 2011.110.2401.0  | [2728897 Cumulative update package 6 (CU6) for SQL Server 2012]                                                                        | 2013-02-18   |
| 11.0.2395     | 2011.110.2395.0  | [2777772 Cumulative update package 5 (CU5) for SQL Server 2012]                                                                        | 2012-12-18   |
| 11.0.9000     | 2011.110.9000.5  | Microsoft SQL Server 2012 With Power View For Multidimensional Models Customer Technology Preview (CTP3)                               | 2012-11-27   |
| 11.0.2383     | 2011.110.2383.0  | [2758687 Cumulative update package 4 (CU4) for SQL Server 2012]                                                                        | 2012-10-18   |
| 11.0.2376     | 2011.110.2376.0  | [Microsoft Security Bulletin MS12-070]                                                                                                 | 2012-10-09   |
| 11.0.2332     | 2011.110.2332.0  | [2723749 Cumulative update package 3 (CU3) for SQL Server 2012]                                                                        | 2012-08-29   |
| 11.0.2325     | 2011.110.2325.0  | [2703275 Cumulative update package 2 (CU2) for SQL Server 2012]                                                                        | 2012-06-18   |
| 11.0.2316     | 2011.110.2316.0  | [2679368 Cumulative update package 1 (CU1) for SQL Server 2012]                                                                        | 2012-04-12   |
| 11.0.2218     | 2011.110.2218.0  | [Microsoft Security Bulletin MS12-070]                                                                                                 | 2012-10-09   |
| 11.0.2214     | 2011.110.2214.0  | 2685308 FIX: SSAS uses only 20 cores in SQL Server 2012 Business Intelligence                                                          | 2012-04-06   |
| 11.0.2100     | 2011.110.2100.60 | SQL Server 2012 RTM                                                                                                                    | 2012-03-06   |
| 11.0.1913     | 2011.110.1913.37 | Microsoft SQL Server 2012 Release Candidate 1 (RC1)                                                                                    | 2011-12-16   |
| 11.0.1750     | 2011.110.1750.32 | Microsoft SQL Server 2012 Release Candidate 0 (RC0)                                                                                    | 2011-11-17   |
| 11.0.1440     | 2010.110.1440.19 | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 3 (CTP3)                                                      | 2011-07-11   |
| 11.0.1103     | 2010.110.1103.9  | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 1 (CTP1)                                                      | 2010-11-08   |

[11.0.5641.0]:https://support.microsoft.com/en-us/kb/3098512
[3097636 FIX: Performance decrease when application with connection pooling frequently connects or disconnects in SQL Server]:https://support.microsoft.com/en-us/kb/3097636
[3082561 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3082561/en-us
[3087872 FIX: Access violations when you use the FileTable feature in SQL Server 2012]:https://support.microsoft.com/en-us/kb/3087872
[3072100 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3072100/en-us
[3045319 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 QFE: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045319
[3052468 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3052468/en-us
[3037255 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3037255/en-us
[3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]:http://support.microsoft.com/kb/3034679/en-us
[3007556 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3007556/en-us
[3002049 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3002049/en-us
[2983175 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/2983175/en-us
[2976982 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/2976982/en-us
[2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP2)]:http://support.microsoft.com/kb/2969896/en-us
[3045321 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045321
[SQL Server 2012 Service Pack 2 (SP2)]:http://www.microsoft.com/en-us/download/details.aspx?id=43340
[3045317 MS15-058: Description of the security update for SQL Server 2012 SP1 QFE: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045317
[3052476 Cumulative update package 16 (CU16) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3052476/en-us
[3038001 Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3038001/en-us
[3023636 Cumulative update package 14 (CU14) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3023636/en-us
[2977325 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (QFE)]:http://support.microsoft.com/kb/2977325/en-us
[3002044 Cumulative update package 13 (CU13) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3002044/en-us
[2991533 Cumulative update package 12 (CU12) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2991533/en-us
[2975396 Cumulative update package 11 (CU11) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2975396/en-us
[2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP1)]:http://support.microsoft.com/kb/2969896/en-us
[2954099 Cumulative update package 10 (CU10) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2954099/en-us
[2931078 Cumulative update package 9 (CU9) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2931078/en-us
[2917531 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2917531/en-us
[2894115 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2894115/en-us
[2874879 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2874879/en-us
[2861107 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2861107/en-us
[2833645 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2833645/en-us
[2832017 FIX: You can’t create or open SSIS projects or maintenance plans after you apply Cumulative Update 3 for SQL Server 2012 SP1]:http://support.microsoft.com/kb/2832017/en-us
[2812412 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2812412/en-us
[2790947 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2790947/en-us
[2800050 FIX: Component installation process fails after you install SQL Server 2012 SP1]:http://support.microsoft.com/kb/2800050/en-us
[2765331 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2765331/en-us
[3045318 MS15-058: Description of the security update for SQL Server 2012 SP1 GDR: July 14, 2015]:https://support.microsoft.com/en-us/kb/3045318
[2977326 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (GDR)]:http://support.microsoft.com/kb/2977326/en-us
[2793634 Windows Installer starts repeatedly after you install SQL Server 2012 SP1]:http://support.microsoft.com/kb/2793634/en-us
[SQL Server 2012 Service Pack 1 (SP1)]:http://www.microsoft.com/en-us/download/details.aspx?id=35575
[2908007 Cumulative update package 11 (CU11) for SQL Server 2012]:http://support.microsoft.com/kb/2908007/en-us
[2891666 Cumulative update package 10 (CU10) for SQL Server 2012]:http://support.microsoft.com/kb/2891666/en-us
[2867319 Cumulative update package 9 (CU9) for SQL Server 2012]:http://support.microsoft.com/kb/2867319/en-us
[2844205 Cumulative update package 8 (CU8) for SQL Server 2012]:http://support.microsoft.com/kb/2844205/en-us
[2823247 Cumulative update package 7 (CU7) for SQL Server 2012]:http://support.microsoft.com/kb/2823247/en-us
[2728897 Cumulative update package 6 (CU6) for SQL Server 2012]:http://support.microsoft.com/kb/2728897/en-us
[2777772 Cumulative update package 5 (CU5) for SQL Server 2012]:http://support.microsoft.com/kb/2777772/en-us
[2758687 Cumulative update package 4 (CU4) for SQL Server 2012]:http://support.microsoft.com/kb/2758687/en-us
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/en-us/security/bulletin/ms12-070
[2723749 Cumulative update package 3 (CU3) for SQL Server 2012]:http://support.microsoft.com/kb/2723749/en-us
[2703275 Cumulative update package 2 (CU2) for SQL Server 2012]:http://support.microsoft.com/kb/2703275/en-us
[2679368 Cumulative update package 1 (CU1) for SQL Server 2012]:http://support.microsoft.com/kb/2679368/en-us
[2685308 FIX: SSAS uses only 20 cores in SQL Server 2012 Business Intelligence]:http://support.microsoft.com/kb/2685308/en-us


## Microsoft SQL Server 2008 R2 Builds

| Build      | File version     | KB / Description                                                                                                                                                                              | Release Date |
|------------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 10.50.6529 | 2009.100.6529.0  | [3045314 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 QFE: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.6525 | 2009.100.6525.0  | [3033860 An on-demand hotfix update package is available for SQL Server 2008 R2 Service Pack 3 (SP3)]                                                                                         | 2015-02-09   |
| 10.50.6220 | 2009.100.6220.0  | [3045316 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 GDR: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.6000 | 2009.100.6000.0  | [SQL Server 2008 R2 Service Pack 3 (SP3)]                                                                                                                                                     | 2014-09-26   |
| 10.50.4339 | 2009.100.4339.0  | [3045312 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 QFE: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.4331 | 2009.100.4331.0  | [2987585 Restore Log with Standby Mode on an Advanced Format disk may cause a 9004 error in SQL Server 2008 R2 or SQL Server 2012]                                                            | 2014-08-27   |
| 10.50.4321 | 2009.100.4321.0  | [2977319 MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (QFE)]                                                                                            | 2014-08-12   |
| 10.50.4319 | 2009.100.4319.0  | [2967540 Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-06-30   |
| 10.50.4305 | 2009.100.4305.0  | [2938478 Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-04-21   |
| 10.50.4302 | 2009.100.4302.0  | [2926028 Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-02-18   |
| 10.50.4297 | 2009.100.4297.0  | [2908087 Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2013-12-16   |
| 10.50.4295 | 2009.100.4295.0  | [2887606 Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-10-29   |
| 10.50.4290 | 2009.100.4290.0  | [2871401 Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-08-30   |
| 10.50.4286 | 2009.100.4286.0  | [2844090 Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-06-17   |
| 10.50.4285 | 2009.100.4285.0  | [2830140 Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (updated)]                                                                                                   | 2013-06-13   |
| 10.50.4279 | 2009.100.4279.0  | 2830140 Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (replaced)                                                                                                    | 2013-04-15   |
| 10.50.4276 | 2009.100.4276.0  | [2797460 Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-02-18   |
| 10.50.4270 | 2009.100.4270.0  | [2777358 Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-12-17   |
| 10.50.4266 | 2009.100.4266.0  | [2754552 Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-10-15   |
| 10.50.4263 | 2009.100.4263.0  | [2740411 Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-08-29   |
| 10.50.4260 | 2009.100.4260.0  | [2720425 Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-08-01   |
| 10.50.4042 | 2009.100.4042.0  | [3045313 MS15-058: MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 GDR: July 14, 2015]                                                                     | 2015-07-14   |
| 10.50.4033 | 2009.100.4033.0  | [2977320 MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (GDR)]                                                                                            | 2014-08-12   |
| 10.50.4000 | 2009.100.4000.0  | [SQL Server 2008 R2 Service Pack 2 (SP2)]                                                                                                                                                     | 2012-06-26   |
| 10.50.3720 | 2009.100.3720.0  | SQL Server 2008 R2 Service Pack 2 Community Technology Preview (CTP)                                                                                                                          | 2012-05-13   |
| 10.50.2881 | 2009.100.2881.0  | [2868244 An on-demand hotfix update package for SQL Server 2008 R2 Service Pack 1]                                                                                                            | 2013-08-12   |
| 10.50.2876 | 2009.100.2876.0  | [2855792 Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2013-06-17   |
| 10.50.2875 | 2009.100.2875.0  | [2828727 Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (updated)]                                                                                                 | 2013-06-13   |
| 10.50.2874 | 2009.100.2874.0  | 2828727 Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (replaced)                                                                                                  | 2013-04-15   |
| 10.50.2861 | 2009.100.2861.0  | [Microsoft Security Bulletin MS12-070]                                                                                                                                                        | 2012-10-09   |
| 10.50.2869 | 2009.100.2869.0  | [2812683 Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2013-02-18   |
| 10.50.2868 | 2009.100.2868.0  | [2783135 Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2012-12-17   |
| 10.50.2866 | 2009.100.2866.0  | [2756574 Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-11-06   |
| 10.50.2861 | 2009.100.2861.0  | [2716439 MS12-070: Description of the security update for SQL Server 2008 R2 Service Pack 1 QFE: October 9, 2012]                                                                             | 2012-10-09   |
| 10.50.2822 | 2009.100.2822.0  | [2723743 Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-08-29   |
| 10.50.2817 | 2009.100.2817.0  | [2703282 Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-06-18   |
| 10.50.2811 | 2009.100.2811.0  | [2679367 Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-04-16   |
| 10.50.2807 | 2009.100.2807.0  | [2675522 FIX: Access violation when you run DML statements against a table that has partitioned indexes in SQL Server 2008 R2]                                                                | 2012-03-12   |
| 10.50.2806 | 2009.100.2806.0  | [2659694 Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-02-22   |
| 10.50.2799 | 2009.100.2799.0  | [2633357 FIX: "Non-yielding Scheduler" error might occur when you run a query that uses the CHARINDEX function in SQL Server 2008 R2]                                                         | 2012-02-22   |
| 10.50.2796 | 2009.100.2796.0  | [2633146 Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-12-20   |
| 10.50.2789 | 2009.100.2789.0  | [2591748 Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-10-17   |
| 10.50.2776 | 2009.100.2776.0  | [2606883 FIX: Slow performance when an AFTER trigger runs on a partitioned table in SQL Server 2008 R2]                                                                                       | 2011-10-18   |
| 10.50.2772 | 2009.100.2772.0  | [2567714 Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-08-15   |
| 10.50.2769 | 2009.100.2769.0  | [2544793 Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-07-18   |
| 10.50.2550 | 2009.100.2550.0  | [Microsoft Security Bulletin MS12-070]                                                                                                                                                        | 2012-10-09   |
| 10.50.2500 | 2009.100.2500.0  | [SQL Server 2008 R2 Service Pack 1 (SP1)]                                                                                                                                                     | 2011-07-11   |
| 10.50.1817 | 2009.100.1817.0  | [2703280 Cumulative update package 14 (CU14) for SQL Server 2008 R2]                                                                                                                          | 2012-06-18   |
| 10.50.1815 | 2009.100.1815.0  | [2679366 Cumulative update package 13 (CU13) for SQL Server 2008 R2]                                                                                                                          | 2012-04-17   |
| 10.50.1810 | 2009.100.1810.0  | [2659692 Cumulative update package 12 (CU12) for SQL Server 2008 R2]                                                                                                                          | 2012-02-21   |
| 10.50.1809 | 2009.100.1809.0  | [2633145 Cumulative update package 11 (CU11) for SQL Server 2008 R2]                                                                                                                          | 2012-01-09   |
| 10.50.1807 | 2009.100.1807.0  | [2591746 Cumulative update package 10 (CU10) for SQL Server 2008 R2]                                                                                                                          | 2011-10-19   |
| 10.50.1804 | 2009.100.1804.0  | [2567713 Cumulative update package 9 (CU9) for SQL Server 2008 R2]                                                                                                                            | 2011-08-16   |
| 10.50.1800 | 2009.100.1800.0  | [2574699 FIX: Database data files might be incorrectly marked as sparse in SQL Server 2008 R2 or in SQL Server 2008 even when the physical files are marked as not sparse in the file system] | 2011-10-18   |
| 10.50.1797 | 2009.100.1797.0  | [2534352 Cumulative update package 8 (CU8) for SQL Server 2008 R2]                                                                                                                            | 2011-06-20   |
| 10.50.1790 | 2009.100.1790.0  | [2494086 MS11-049: Description of the security update for SQL Server 2008 R2 QFE: June 14, 2011]                                                                                              | 2011-06-17   |
| 10.50.1777 | 2009.100.1777.0  | [2507770 Cumulative update package 7 (CU7) for SQL Server 2008 R2]                                                                                                                            | 2011-06-16   |
| 10.50.1769 | 2009.100.1769.0  | [2520808 FIX: Non-yielding scheduler error when you run a query that uses a TVP in SQL Server 2008 or in SQL Server 2008 R2 if SQL Profiler or SQL Server Extended Events is used]            | 2011-04-18   |
| 10.50.1765 | 2009.100.1765.0  | [2489376 Cumulative update package 6 (CU6) for SQL Server 2008 R2]                                                                                                                            | 2011-02-21   |
| 10.50.1753 | 2009.100.1753.0  | [2438347 Cumulative update package 5 (CU5) for SQL Server 2008 R2]                                                                                                                            | 2010-12-23   |
| 10.50.1746 | 2009.100.1746.0  | [2345451 Cumulative update package 4 (CU4) for SQL Server 2008 R2]                                                                                                                            | 2010-10-18   |
| 10.50.1734 | 2009.100.1734.0  | [2261464 Cumulative update package 3 (CU3) for SQL Server 2008 R2]                                                                                                                            | 2010-08-20   |
| 10.50.1720 | 2009.100.1720.0  | [2072493 Cumulative update package 2 (CU2) for SQL Server 2008 R2]                                                                                                                            | 2010-06-25   |
| 10.50.1702 | 2009.100.1702.0  | [981355 Cumulative update package 1 (CU1) for SQL Server 2008 R2]                                                                                                                             | 2010-05-18   |
| 10.50.1617 | 2009.100.1617.0  | [2494088 MS11-049: Description of the security update for SQL Server 2008 R2 GDR: June 14, 2011]                                                                                              | 2011-06-14   |
| 10.50.1600 | 2009.100.1600.1  | SQL Server 2008 R2 RTM                                                                                                                                                                        | 2010-04-21   |
| 10.50.1352 | 2009.100.1352.12 | Microsoft SQL Server 2008 R2 November Community Technology Preview (CTP)                                                                                                                      | 2009-11-12   |
| 10.50.1092 | 2009.100.1092.20 | Microsoft SQL Server 2008 R2 August Community Technology Preview (CTP)                                                                                                                        | 2009-06-30   |

[3045314 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 QFE: July 14, 2015]:http://support.microsoft.com/kb/3045314/en-us
[3033860 An on-demand hotfix update package is available for SQL Server 2008 R2 Service Pack 3 (SP3)]:http://support.microsoft.com/kb/3033860/en-us
[3045316 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 GDR: July 14, 2015]:http://support.microsoft.com/kb/3045316/en-us
[SQL Server 2008 R2 Service Pack 3 (SP3)]:http://www.microsoft.com/en-us/download/details.aspx?id=44271
[3045312 MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 QFE: July 14, 2015]:http://support.microsoft.com/kb/3045312/en-us
[2987585 Restore Log with Standby Mode on an Advanced Format disk may cause a 9004 error in SQL Server 2008 R2 or SQL Server 2012]:http://support.microsoft.com/kb/2987585/en-us
[2977319 MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (QFE)]:http://support.microsoft.com/kb/2977319/en-us
[2967540 Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2967540/en-us
[2938478 Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2938478/en-us
[2926028 Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2926028/en-us
[2908087 Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2908087/en-us
[2887606 Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2887606/en-us
[2871401 Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2871401/en-us
[2844090 Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2844090/en-us
[2830140 Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (updated)]:http://support.microsoft.com/kb/2830140/en-us
[2797460 Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2797460
[2777358 Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2777358
[2754552 Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2754552
[2740411 Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2740411
[2720425 Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2720425
[3045313 MS15-058: MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 GDR: July 14, 2015]:http://support.microsoft.com/kb/3045313/en-us
[2977320 MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (GDR)]:http://support.microsoft.com/kb/2977320/en-us
[SQL Server 2008 R2 Service Pack 2 (SP2)]:http://www.microsoft.com/en-us/download/details.aspx?id=30437
[2868244 An on-demand hotfix update package for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2868244/en-us
[2855792 Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2855792/en-us
[2828727 Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (updated)]:http://support.microsoft.com/kb/2828727/en-us
[2812683 Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2812683
[2783135 Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2783135
[2756574 Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2756574
[2716439 MS12-070: Description of the security update for SQL Server 2008 R2 Service Pack 1 QFE: October 9, 2012]:http://support.microsoft.com/kb/2716439
[2723743 Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2723743
[2703282 Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2703282
[2679367 Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2679367
[2675522 FIX: Access violation when you run DML statements against a table that has partitioned indexes in SQL Server 2008 R2]:http://support.microsoft.com/kb/2675522
[2659694 Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2659694
[2633357 FIX: "Non-yielding Scheduler" error might occur when you run a query that uses the CHARINDEX function in SQL Server 2008 R2]:http://support.microsoft.com/kb/2633357
[2633146 Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2633146
[2591748 Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2591748
[2606883 FIX: Slow performance when an AFTER trigger runs on a partitioned table in SQL Server 2008 R2]:http://support.microsoft.com/kb/2606883
[2567714 Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2567714
[2544793 Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2544793
[SQL Server 2008 R2 Service Pack 1 (SP1)]:http://www.microsoft.com/download/en/details.aspx?id=26727
[2703280 Cumulative update package 14 (CU14) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2703280
[2679366 Cumulative update package 13 (CU13) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2679366
[2659692 Cumulative update package 12 (CU12) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2659692
[2633145 Cumulative update package 11 (CU11) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2633145
[2591746 Cumulative update package 10 (CU10) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2591746
[2567713 Cumulative update package 9 (CU9) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2567713
[2574699 FIX: Database data files might be incorrectly marked as sparse in SQL Server 2008 R2 or in SQL Server 2008 even when the physical files are marked as not sparse in the file system]:http://support.microsoft.com/kb/2574699
[2534352 Cumulative update package 8 (CU8) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2534352
[2494086 MS11-049: Description of the security update for SQL Server 2008 R2 QFE: June 14, 2011]:http://support.microsoft.com/kb/2494086
[2507770 Cumulative update package 7 (CU7) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2507770
[2520808 FIX: Non-yielding scheduler error when you run a query that uses a TVP in SQL Server 2008 or in SQL Server 2008 R2 if SQL Profiler or SQL Server Extended Events is used]:http://support.microsoft.com/kb/2520808
[2489376 Cumulative update package 6 (CU6) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2489376
[2438347 Cumulative update package 5 (CU5) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2438347
[2345451 Cumulative update package 4 (CU4) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2345451
[2261464 Cumulative update package 3 (CU3) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2261464
[2072493 Cumulative update package 2 (CU2) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2072493
[981355 Cumulative update package 1 (CU1) for SQL Server 2008 R2]:http://support.microsoft.com/kb/981355
[2494088 MS11-049: Description of the security update for SQL Server 2008 R2 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494088


## Microsoft SQL Server 2008 Builds

| Build        | File version     | KB / Description                                                                                                                                                                                                                                      | Release Date |
|--------------|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| [10.00.6535] | 2007.100.6535.0  | 3045308 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 QFE: July 14, 2015                                                                                                                                            | 2015-07-14   |
| [10.00.6526] | 2007.100.6526.0  | 3034373 An on-demand hotfix update package is available for SQL Server 2008 Service Pack 4 (SP4)                                                                                                                                                      | 2015-02-09   |
| [10.00.6241] | 2007.100.6241.0  | 3045311 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 GDR: July 14, 2015                                                                                                                                            | 2015-07-14   |
| [10.00.6000] | 2007.100.6000.0  | SQL Server 2008 Service Pack 4 (SP4)                                                                                                                                                                                                                  | 2014-09-30   |
| [10.00.5890] | 2007.100.5890.0  | 3045303 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 QFE: July 14, 2015                                                                                                                                            | 2015-07-14   |
| [10.00.5869] | 2007.100.5869.0  | 2977322 MS14-044: Description of the security update for SQL Server 2008 SP3 (QFE)                                                                                                                                                                    | 2014-08-12   |
| [10.00.5867] | 2007.100.5867.0  | 2877204 FIX: Error 8985 when you run the dbcc shrinkfile statement by using the logical name of a file in SQL Server 2008 R2 or SQL Server 2008                                                                                                       | 2014-07-02   |
| [10.00.5861] | 2007.100.5861.0  | 2958696 Cumulative update package 17 (CU17) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2014-05-19   |
| [10.00.5852] | 2007.100.5852.0  | 2936421 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2014-03-17   |
| [10.00.5850] | 2007.100.5850.0  | 2923520 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2014-01-20   |
| [10.00.5848] | 2007.100.5848.0  | 2893410 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2013-11-18   |
| [10.00.5846] | 2007.100.5846.0  | 2880350 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2013-09-16   |
| [10.00.5844] | 2007.100.5844.0  | 2863205 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2013-07-16   |
| [10.00.5841] | 2007.100.5841.0  | 2834048 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 3 (updated)                                                                                                                                                              | 2013-06-13   |
| 10.00.5840   | 2007.100.5840.0  | 2834048 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 3 (replaced)                                                                                                                                                             | 2013-05-20   |
| [10.00.5835] | 2007.100.5835.0  | 2814783 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 3                                                                                                                                                                        | 2013-03-18   |
| [10.00.5829] | 2007.100.5829.0  | 2799883 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2013-01-23   |
| [10.00.5828] | 2007.100.5828.0  | 2771833 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-11-19   |
| [10.00.5826] | 2007.100.5826.0  | 2716435 Microsoft Security Bulletin MS12-070                                                                                                                                                                                                          | 2012-10-09   |
| [10.00.5794] | 2007.100.5794.0  | 2738350 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-09-21   |
| [10.00.5788] | 2007.100.5788.0  | 2715953 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-07-16   |
| [10.00.5785] | 2007.100.5785.0  | 2696626 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-05-19   |
| [10.00.5775] | 2007.100.5775.0  | 2673383 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-03-20   |
| [10.00.5770] | 2007.100.5770.0  | 2648098 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2012-01-16   |
| [10.00.5768] | 2007.100.5768.0  | 2633143 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2011-11-22   |
| [10.00.5766] | 2007.100.5766.0  | 2617146 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 3                                                                                                                                                                          | 2011-10-18   |
| [10.00.5538] | 2007.100.5538.0  | 3045305 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 GDR: July 14, 2015                                                                                                                                            | 2015-07-14   |
| [10.00.5520] | 2007.100.5520.0  | 2977321 MS14-044: Description of the security update for SQL Server 2008 SP3 (GDR)                                                                                                                                                                    | 2014-08-12   |
| [10.00.5512] | 2007.100.5512.0  | Microsoft Security Bulletin MS12-070                                                                                                                                                                                                                  | 2012-10-09   |
| [10.00.5500] | 2007.100.5500.0  | SQL Server 2008 Service Pack 3 (SP3)                                                                                                                                                                                                                  | 2011-10-06   |
| 10.00.5416   | 2007.100.5416.0  | SQL Server 2008 Service Pack 3 CTP                                                                                                                                                                                                                    | 2011-08-22   |
| [10.00.4371] | 2007.100.4371.0  | Microsoft Security Bulletin MS12-070                                                                                                                                                                                                                  | 2012-10-09   |
| [10.00.4333] | 2007.100.4333.0  | 2715951 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 2                                                                                                                                                                        | 2012-07-16   |
| [10.00.4332] | 2007.100.4332.0  | 2696625 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 2                                                                                                                                                                        | 2012-05-20   |
| [10.00.4330] | 2007.100.4330.0  | 2673382 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2012-03-19   |
| [10.00.4326] | 2007.100.4326.0  | 2648096 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2012-01-30   |
| [10.00.4323] | 2007.100.4323.0  | 2617148 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-11-21   |
| [10.00.4321] | 2007.100.4321.0  | 2582285 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-09-20   |
| [10.00.4316] | 2007.100.4316.0  | 2555408 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-07-18   |
| [10.00.4285] | 2007.100.4285.0  | 2527180 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-05-16   |
| [10.00.4279] | 2007.100.4279.0  | 2498535 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-03-11   |
| [10.00.4272] | 2007.100.4272.0  | 2467239 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2011-02-10   |
| [10.00.4266] | 2007.100.4266.0  | 2289254 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 2                                                                                                                                                                          | 2010-11-15   |
| [10.00.4067] | 2007.100.4067.0  | Microsoft Security Bulletin MS12-070                                                                                                                                                                                                                  | 2012-10-09   |
| [10.00.4064] | 2007.100.4064.0  | 2494089 MS11-049: Description of the security update for SQL Server 2008 Service Pack 2 GDR: June 14, 2011                                                                                                                                            | 2011-06-14   |
| [10.00.4000] | 2007.100.4000.0  | SQL Server 2008 Service Pack 2 (SP2)                                                                                                                                                                                                                  | 2010-09-29   |
|  10.00.3798  | 2007.100.3798.0  | SQL Server 2008 Service Pack 2 CTP                                                                                                                                                                                                                    | 2010-07-07   |
| [10.00.2850] | 2007.100.2850.0  | 2582282 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2011-09-19   |
| [10.00.2847] | 2007.100.2847.0  | 2555406 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2011-07-18   |
| [10.00.2821] | 2007.100.2821.0  | 2527187 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2011-05-16   |
| [10.00.2816] | 2007.100.2816.0  | 2497673 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2011-03-22   |
| [10.00.2808] | 2007.100.2808.0  | 2467236 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2011-02-10   |
| [10.00.2804] | 2007.100.2804.0  | 2413738 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2010-11-15   |
| [10.00.2799] | 2007.100.2799.0  | 2279604 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 1                                                                                                                                                                        | 2010-09-21   |
| [10.00.2789] | 2007.100.2789.0  | 2083921 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 1                                                                                                                                                                          | 2010-07-21   |
| [10.00.2787] | 2007.100.2787.0  | 2231277 FIX: The Reporting Services service stops unexpectedly after you apply SQL Server 2008 SP1 CU 7 or CU8                                                                                                                                        | 2010-07-30   |
| [10.00.2775] | 2007.100.2775.0  | 981702 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2010-05-17   |
| [10.00.2766] | 2007.100.2766.0  | 979065 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2010-03-26   |
| [10.00.2757] | 2007.100.2757.0  | 977443 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2010-01-18   |
| [10.00.2746] | 2007.100.2746.0  | 975977 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2009-11-16   |
| [10.00.2740] | 2007.100.2740.0  | 976761 FIX: Error message when you perform a rolling upgrade in a SQL Server 2008 cluster : 18401, Login failed for user SQLTEST\AgentService. Reason: Server is in script upgrade mode. Only administrator can connect at this time.[SQLState 42000] | 2009-11-24   |
| [10.00.2734] | 2007.100.2734.0  | 973602 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2009-09-22   |
| [10.00.2723] | 2007.100.2723.0  | 971491 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2009-07-21   |
| [10.00.2714] | 2007.100.2714.0  | 970315 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2009-05-18   |
| [10.00.2712] | 2007.100.2712.0  | 970507 FIX: Error message in SQL Server 2008 when you run an INSERT SELECT statement on a table: Violation of PRIMARY KEY constraint <PrimaryKey>. Cannot insert duplicate key in object <TableName>                                                  | 2009-07-21   |
| [10.00.2710] | 2007.100.2710.0  | 969099 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 1                                                                                                                                                                           | 2009-04-16   |
| [10.00.2573] | 2007.100.2573.0  | 2494096 MS11-049: Description of the security update for SQL Server 2008 Service Pack 1 GDR: June 14, 2011                                                                                                                                            | 2011-06-14   |
| [10.00.2531] | 2007.100.2531.0  | SQL Server 2008 Service Pack 1 (SP1)                                                                                                                                                                                                                  | 2009-04-07   |
|  10.00.2520  | 2007.100.2520.0  | SQL Server 2008 Service Pack 1 - CTP                                                                                                                                                                                                                  | 2009-02-23   |
| [10.00.1835] | 2007.100.1835.0  | 979064 Cumulative update package 10 (CU10) for SQL Server 2008                                                                                                                                                                                        | 2010-03-15   |
| [10.00.1828] | 2007.100.1828.0  | 977444 Cumulative update package 9 (CU9) for SQL Server 2008                                                                                                                                                                                          | 2010-01-18   |
| [10.00.1823] | 2007.100.1823.0  | 975976 Cumulative update package 8 (CU8) for SQL Server 2008                                                                                                                                                                                          | 2009-11-16   |
| [10.00.1818] | 2007.100.1818.0  | 973601 Cumulative update package 7 (CU7) for SQL Server 2008                                                                                                                                                                                          | 2009-09-21   |
| [10.00.1812] | 2007.100.1812.0  | 971490 Cumulative update package 6 (CU6) for SQL Server 2008                                                                                                                                                                                          | 2009-07-21   |
| [10.00.1806] | 2007.100.1806.0  | 969531 Cumulative update package 5 (CU5) for SQL Server 2008                                                                                                                                                                                          | 2009-05-18   |
| [10.00.1798] | 2007.100.1798.0  | 963036 Cumulative update package 4 (CU4) for SQL Server 2008                                                                                                                                                                                          | 2009-03-17   |
| [10.00.1787] | 2007.100.1787.0  | 960484 Cumulative update package 3 (CU3) for SQL Server 2008                                                                                                                                                                                          | 2009-01-19   |
| [10.00.1779] | 2007.100.1779.0  | 958186 Cumulative update package 2 (CU2) for SQL Server 2008                                                                                                                                                                                          | 2008-11-19   |
| [10.00.1771] | 2007.100.1771.0  | 958611 FIX: You may receive incorrect results when you run a query that references three or more tables in the FROM clause in SQL Server 2008                                                                                                         | 2008-10-29   |
| [10.00.1763] | 2007.100.1763.0  | 956717 Cumulative update package 1 (CU1) for SQL Server 2008                                                                                                                                                                                          | 2008-10-28   |
| [10.00.1750] | 2007.100.1750.0  | 956718 FIX: A MERGE statement may not enforce a foreign key constraint when the statement updates a unique key column that is not part of a clustering key that has a single row as the update source in SQL Server 2008                              | 2008-08-25   |
| 10.00.1600   | 2007.100.1600.22 | SQL Server 2008 RTM                                                                                                                                                                                                                                   | 2008-08-07   |
| 10.00.1442   | 2007.100.1442.32 | Microsoft SQL Server 2008 RC0                                                                                                                                                                                                                         | 2008-06-05   |
| 10.00.1300   | 2007.100.1300.13 | Microsoft SQL Server 2008 CTP, February 2008                                                                                                                                                                                                          | 2008-02-19   |
| 10.00.1075   | 2007.100.1075.23 | Microsoft SQL Server 2008 CTP, November 2007                                                                                                                                                                                                          | 2007-11-18   |
| 10.00.1049   | 2007.100.1049.14 | SQL Server 2008 CTP, July 2007                                                                                                                                                                                                                        | 2007-07-31   |
| 10.00.1019   | 2007.100.1019.17 | SQL Server 2008 CTP, June 2007                                                                                                                                                                                                                        | 2007-05-21   |

[10.00.6535]:http://support.microsoft.com/kb/3045308/en-us
[10.00.6526]:http://support.microsoft.com/kb/3034373/en-us
[10.00.6241]:https://support.microsoft.com/en-us/kb/3045311
[10.00.6000]:http://www.microsoft.com/en-us/download/details.aspx?id=44278
[10.00.5890]:https://support.microsoft.com/en-us/kb/3045303
[10.00.5869]:http://support.microsoft.com/kb/2977322/en-us
[10.00.5867]:http://support.microsoft.com/kb/2877204/en-us
[10.00.5861]:http://support.microsoft.com/kb/2958696/en-us
[10.00.5852]:http://support.microsoft.com/kb/2936421/en-us
[10.00.5850]:http://support.microsoft.com/kb/2923520/en-us
[10.00.5848]:http://support.microsoft.com/kb/2893410/en-us
[10.00.5846]:http://support.microsoft.com/kb/2880350/en-us
[10.00.5844]:http://support.microsoft.com/kb/2863205/en-us
[10.00.5841]:http://support.microsoft.com/kb/2834048/en-us
[10.00.5835]:http://support.microsoft.com/kb/2814783
[10.00.5829]:http://support.microsoft.com/kb/2799883
[10.00.5828]:http://support.microsoft.com/kb/2771833
[10.00.5826]:http://support.microsoft.com/kb/2716435
[10.00.5794]:http://support.microsoft.com/kb/2738350
[10.00.5788]:http://support.microsoft.com/kb/2715953
[10.00.5785]:http://support.microsoft.com/kb/2696626
[10.00.5775]:http://support.microsoft.com/kb/2673383
[10.00.5770]:http://support.microsoft.com/kb/2648098
[10.00.5768]:http://support.microsoft.com/kb/2633143
[10.00.5766]:http://support.microsoft.com/kb/2617146
[10.00.5538]:https://support.microsoft.com/en-us/kb/3045305
[10.00.5520]:http://support.microsoft.com/kb/2977321/en-us
[10.00.5500]:http://www.microsoft.com/download/en/details.aspx?id=27594
[10.00.4333]:http://support.microsoft.com/kb/2715951
[10.00.4332]:http://support.microsoft.com/kb/2696625
[10.00.4330]:http://support.microsoft.com/kb/2673382
[10.00.4326]:http://support.microsoft.com/kb/2648096
[10.00.4323]:http://support.microsoft.com/kb/2617148
[10.00.4321]:http://support.microsoft.com/kb/2582285
[10.00.4316]:http://support.microsoft.com/kb/2555408
[10.00.4285]:http://support.microsoft.com/kb/2527180
[10.00.4279]:http://support.microsoft.com/kb/2498535
[10.00.4272]:http://support.microsoft.com/kb/2467239
[10.00.4266]:http://support.microsoft.com/kb/2289254
[10.00.4064]:http://support.microsoft.com/kb/2494089
[10.00.4000]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=8FBFC1DE-D25E-4790-88B5-7DDA1F1D4E17
[10.00.2850]:http://support.microsoft.com/kb/2582282
[10.00.2847]:http://support.microsoft.com/kb/2555406
[10.00.2821]:http://support.microsoft.com/kb/2527187
[10.00.2816]:http://support.microsoft.com/kb/2497673
[10.00.2808]:http://support.microsoft.com/kb/2467236
[10.00.2804]:http://support.microsoft.com/kb/2413738
[10.00.2799]:http://support.microsoft.com/kb/2279604
[10.00.2789]:http://support.microsoft.com/kb/2083921
[10.00.2787]:http://support.microsoft.com/kb/2231277
[10.00.2775]:http://support.microsoft.com/kb/981702
[10.00.2766]:http://support.microsoft.com/kb/979065
[10.00.2757]:http://support.microsoft.com/kb/977443
[10.00.2746]:http://support.microsoft.com/kb/975977
[10.00.2740]:http://support.microsoft.com/kb/976761
[10.00.2734]:http://support.microsoft.com/kb/973602
[10.00.2723]:http://support.microsoft.com/kb/971491
[10.00.2714]:http://support.microsoft.com/kb/970315
[10.00.2712]:http://support.microsoft.com/kb/970507
[10.00.2710]:http://support.microsoft.com/kb/969099
[10.00.2573]:http://support.microsoft.com/kb/2494096
[10.00.2531]:http://www.microsoft.com/downloads/details.aspx?familyid=66AB3DBB-BF3E-4F46-9559-CCC6A4F9DC19
[10.00.1835]:http://support.microsoft.com/kb/979064
[10.00.1828]:http://support.microsoft.com/kb/977444
[10.00.1823]:http://support.microsoft.com/kb/975976
[10.00.1818]:http://support.microsoft.com/kb/973601
[10.00.1812]:http://support.microsoft.com/kb/971490
[10.00.1806]:http://support.microsoft.com/kb/969531
[10.00.1798]:http://support.microsoft.com/kb/963036
[10.00.1787]:http://support.microsoft.com/kb/960484
[10.00.1779]:http://support.microsoft.com/kb/958186
[10.00.1771]:http://support.microsoft.com/kb/958611
[10.00.1763]:http://support.microsoft.com/kb/956717
[10.00.1750]:http://support.microsoft.com/kb/956718


## Microsoft SQL Server 2005 Builds

| Build     | File version   | KB / Description                                                                                                                                                                                                                                                     | Release Date |
|-----------|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 9.00.5324 | 2005.90.5324.0 | [2716427 MS12-070: Description of the security update for SQL Server 2005 Service Pack 4 QFE]                                                                                                                                                                        | 2012-10-09   |
| 9.00.5296 | 2005.90.5296.0 | [2615425 FIX: "Msg 7359" error when a view uses another view in SQL Server 2005 if the schema version of a remote table is updated]                                                                                                                                  | 2011-10-24   |
| 9.00.5295 | 2005.90.5295.0 | [2598903 FIX: SQL Server Agent job randomly stops when you schedule the job to run past midnight on specific days in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2]                                                                                   | 2012-05-21   |
| 9.00.5294 | 2005.90.5294.0 | [2572407 FIX: Error 5180 when you use the ONLINE option to rebuild an index in SQL Server 2005]                                                                                                                                                                      | 2011-08-10   |
| 9.00.5292 | 2005.90.5292.0 | [2494123 MS11-049: Description of the security update for SQL Server 2005 Service Pack 4 QFE: June 14, 2011]                                                                                                                                                         | 2011-06-14   |
| 9.00.5266 | 2005.90.5266.0 | [2507769 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 4]                                                                                                                                                                                       | 2011-03-22   |
| 9.00.5259 | 2005.90.5259.0 | [2489409 Cumulative update package 2 (CU2) for SQL Server 2005 Service Pack 4]                                                                                                                                                                                       | 2011-02-22   |
| 9.00.5254 | 2005.90.5254.0 | [2464079 Cumulative update package 1 (CU1) for SQL Server 2005 Service Pack 4]                                                                                                                                                                                       | 2010-12-24   |
| 9.00.5069 | 2005.90.5069.0 | [Microsoft Security Bulletin MS12-070]                                                                                                                                                                                                                               | 2012-10-09   |
| 9.00.5057 | 2005.90.5057.0 | [2494120 MS11-049: Description of the security update for SQL Server 2005 Service Pack 4 GDR: June 14, 2011]                                                                                                                                                         | 2011-06-14   |
| 9.00.5000 | 2005.90.5000.0 | SQL Server 2005 Service Pack 4 (SP4)                                                                                                                                                                                                                                 | 2010-12-17   |
| 9.00.4912 | 2005.90.4912.0 | SQL Server 2005 Service Pack 4 (SP4) - Customer Technology Preview (CTP)                                                                                                                                                                                             | 2010-11-03   |
| 9.00.4342 | 2005.90.4342.0 | [2598903 FIX: SQL Server Agent job randomly stops when you schedule the job to run past midnight on specific days in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2]                                                                                   | 2012-05-21   |
| 9.00.4340 | 2005.90.4340.0 | [2494112 MS11-049: Description of the security update for SQL Server 2005 Service Pack 3 QFE: June 14, 2011]                                                                                                                                                         | 2011-06-14   |
| 9.00.4325 | 2005.90.4325.0 | [2507766 Cumulative update package 15 (CU15) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                     | 2011-03-22   |
| 9.00.4317 | 2005.90.4317.0 | [2489375 Cumulative update package 14 (CU14) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                     | 2011-02-21   |
| 9.00.4315 | 2005.90.4315.0 | [2438344 Cumulative update package 13 (CU13) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                     | 2010-12-23   |
| 9.00.4311 | 2005.90.4311.0 | [2345449 Cumulative update package 12 (CU12) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                     | 2010-10-18   |
| 9.00.4309 | 2005.90.4309.0 | [2258854 Cumulative update package 11 (CU11) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                     | 2010-08-16   |
| 9.00.4305 | 2005.90.4305.0 | [983329 Cumulative update package 10 (CU10) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                      | 2010-06-23   |
| 9.00.4294 | 2005.90.4294.0 | [980176 Cumulative update package 9 (CU9) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2010-04-19   |
| 9.00.4285 | 2005.90.4285.0 | [978915 Cumulative update package 8 (CU8) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2010-02-16   |
| 9.00.4273 | 2005.90.4273.0 | [976951 Cumulative update package 7 (CU7) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-12-21   |
| 9.00.4268 | 2005.90.4268.0 | [977151 FIX: Error message when you add a subscription to a republisher that is in a merge publication in SQL Server 2005: "Cannot create the subscription because the subscription already exists in the subscription database"]                                    | 2009-12-21   |
| 9.00.4266 | 2005.90.4266.0 | [974648 Cumulative update package 6 (CU6) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-10-19   |
| 9.00.4262 | 2005.90.4262.0 | [970894 MS09-062: Description of the security update for SQL Server 2005 Service Pack 3 QFE: October 13, 2009]                                                                                                                                                       | 2009-10-13   |
| 9.00.4230 | 2005.90.4230.0 | [972511 Cumulative update package 5 (CU5) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-08-17   |
| 9.00.4226 | 2005.90.4226.0 | [970279 Cumulative update package 4 (CU4) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-06-16   |
| 9.00.4224 | 2005.90.4224.0 | [971409 FIX: Error message when you run a query that contains duplicate join conditions in SQL Server 2005: "Internal Query Processor Error: The query processor could not produce a query plan"]                                                                    | 2009-06-16   |
| 9.00.4220 | 2005.90.4220.0 | [967909 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-04-20   |
| 9.00.4216 | 2005.90.4216.0 | [967101 FIX: The performance of database mirroring decreases when you run a database maintenance job that generates a large number of transaction log activities in SQL Server 2005]                                                                                 | 2009-04-20   |
| 9.00.4211 | 2005.90.4211.0 | [961930 Cumulative update package 2 (CU2) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2009-02-17   |
| 9.00.4207 | 2005.90.4207.0 | [959195 Cumulative update package 1 (CU1) for SQL Server 2005 Service Pack 3]                                                                                                                                                                                        | 2008-12-20   |
| 9.00.4060 | 2005.90.4060.0 | [2494113 MS11-049: Description of the security update for SQL Server 2005 Service Pack 3 GDR: June 14, 2011]                                                                                                                                                         | 2011-06-14   |
| 9.00.4053 | 2005.90.4053.0 | [970892 MS09-062: Description of the security update for SQL Server 2005 Service Pack 3 GDR: October 13, 2009]                                                                                                                                                       | 2009-10-13   |
| 9.00.4035 | 2005.90.4035.0 | [SQL Server 2005 Service Pack 3 (SP3)]                                                                                                                                                                                                                               | 2008-12-15   |
| 9.00.4028 | 2005.90.4028.0 | SQL Server 2005 Service Pack 3 (SP3) - CTP                                                                                                                                                                                                                           | 2008-10-27   |
| 9.00.3356 | 2005.90.3356.0 | [976952 Cumulative update package 17 (CU17) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-12-21   |
| 9.00.3355 | 2005.90.3355.0 | [974647 Cumulative update package 16 (CU16) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-10-19   |
| 9.00.3353 | 2005.90.3353.0 | [970896 MS09-062: Description of the security update for SQL Server 2005 Service Pack 2 QFE: October 13, 2009]                                                                                                                                                       | 2009-10-13   |
| 9.00.3330 | 2005.90.3330.0 | [972510 Cumulative update package 15 (CU15) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-08-18   |
| 9.00.3328 | 2005.90.3328.0 | [970278 Cumulative update package 14 (CU14) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-06-16   |
| 9.00.3325 | 2005.90.3325.0 | [967908 Cumulative update package 13 (CU13) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-04-20   |
| 9.00.3320 | 2005.90.3320.0 | [969142 FIX: Error message when you run the DBCC CHECKDB statement on a database in SQL Server 2005: "Unable to deallocate a kept page"]                                                                                                                             | 2009-04-01   |
| 9.00.3318 | 2005.90.3318.0 | [967199 FIX: The Wmiprvse.exe host process stops responding when you run a SQL Server 2005-based application that sends a Windows Management Instrumentation (WMI) query to the SQL Server WMI provider]                                                             | 2009-04-20   |
| 9.00.3315 | 2005.90.3315.0 | [962970 Cumulative update package 12 (CU12) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2009-02-17   |
| 9.00.3310 | 2005.90.3310.0 | [960090 MS09-004: Description of the security update for SQL Server 2005 QFE: February 10, 2009]                                                                                                                                                                     | 2009-02-10   |
| 9.00.3301 | 2005.90.3301.0 | [958735 Cumulative update package 11 (CU11) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2008-12-16   |
| 9.00.3294 | 2005.90.3294.0 | [956854 Cumulative update package 10 (CU10) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                      | 2008-10-20   |
| 9.00.3282 | 2005.90.3282.0 | [953752 Cumulative update package 9 (CU9) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2008-06-16   |
| 9.00.3260 | 2005.90.3260.0 | [954950 FIX: Error message when you run a distributed query in SQL Server 2005: "OLE DB provider 'SQLNCLI' for linked server '<Linked Server>' returned message 'No transaction is active'"]                                                                         | 2008-07-14   |
| 9.00.3259 | 2005.90.3259.0 | [954831 FIX: In SQL Server 2005, the session that runs the TRUNCATE TABLE statement may stop responding, and you cannot end the session]                                                                                                                             | 2008-08-14   |
| 9.00.3259 | 2005.90.3259.0 | [954669 FIX: An ongoing MS DTC transaction is orphaned in SQL Server 2005]                                                                                                                                                                                           | 2008-07-14   |
| 9.00.3257 | 2005.90.3257.0 | [951217 Cumulative update package 8 (CU8) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2008-06-18   |
| 9.00.3246 | 2005.90.3246.0 | [952233 FIX: All the MDX queries that are running on an instance of SQL Server 2005 Analysis Services are canceled when you start or stop a SQL Server Profiler trace for the instance]                                                                              | 2008-05-23   |
| 9.00.3244 | 2005.90.3244.0 | [952330 FIX: The Replication Log Reader Agent may fail intermittently when a transactional replication synchronizes data in SQL Server 2005]                                                                                                                         | 2008-06-03   |
| 9.00.3240 | 2005.90.3240.0 | [951204 FIX: An access violation occurs when you update a table through a view by using a cursor in SQL Server 2005]                                                                                                                                                 | 2008-05-21   |
| 9.00.3239 | 2005.90.3239.0 | [949095 Cumulative update package 7 (CU7) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2008-04-17   |
| 9.00.3232 | 2005.90.3232.0 | [949959 FIX: Error message when you synchronize the data of a merge replication in SQL Server 2005: "The merge process is retrying a failed operation made to article 'ArticleName' - Reason: 'Invalid input parameter values. Check the status values for detail.'"]| 2008-03-19   |
| 9.00.3231 | 2005.90.3231.0 | [949595 FIX: Error message when you run a query that uses a join condition in SQL Server 2005: "Non-yielding Scheduler"]                                                                                                                                             | 2008-03-18   |
| 9.00.3231 | 2005.90.3231.0 | [949687 FIX: Error message when you run a transaction from a remote server by using a linked server in SQL Server 2005: "This operation conflicts with another pending operation on this transaction"]                                                               | 2008-03-14   |
| 9.00.3230 | 2005.90.3230.0 | [949199 FIX: Error message when you run queries on a database that has the SNAPSHOT isolation level enabled in SQL Server 2005: "Unable to deallocate a kept page"]                                                                                                  | 2008-03-07   |
| 9.00.3228 | 2005.90.3228.0 | [946608 Cumulative update package 6 (CU6) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2008-02-19   |
| 9.00.3224 | 2005.90.3224.0 | [947463 FIX: A stored procedure cannot finish its execution in SQL Server 2005]                                                                                                                                                                                      | 2008-02-04   |
| 9.00.3221 | 2005.90.3221.0 | [942908 FIX: The change may be undone during the later synchronizations when you change an article on the subscriber in SQL Server 2005]                                                                                                                             | 2008-01-31   |
| 9.00.3221 | 2005.90.3221.0 | [945443 FIX: A query takes longer to finish in SQL Server 2005 than in SQL Server 2000 when you open a fast forward-only cursor for the query]                                                                                                                       | 2008-01-11   |
| 9.00.3221 | 2005.90.3221.0 | [945916 FIX: Error messages when you delete some records of a table in a transaction or when you update some records of a table in a transaction in SQL Server 2005: "Msg 9002," "Msg 3314," and "Msg 9001"]                                                         | 2008-01-10   |
| 9.00.3221 | 2005.90.3221.0 | [945442 FIX: You cannot cancel the query execution immediately if you open a fast forward-only cursor for the query in SQL Server 2005]                                                                                                                              | 2008-01-09   |
| 9.00.3215 | 2005.90.3215.0 | [943656 Cumulative update package 5 (CU5) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2007-12-18   |
| 9.00.3208 | 2005.90.3208.0 | [944902 FIX: A federated database server stops responding when you run parallel queries on a multiprocessor computer that uses NUMA architecture in SQL Server 2005]                                                                                                 | 2007-11-21   |
| 9.00.3206 | 2005.90.3206.0 | [944677 FIX: Conflicts are not logged when you use the Microsoft SQL Server Subscriber Always Wins Conflict Resolver for an article in a merge replication in Microsoft SQL Server 2005]                                                                             | 2007-12-11   |
| 9.00.3200 | 2005.90.3200.0 | [941450 Cumulative update package 4 (CU4) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2007-10-17   |
| 9.00.3194 | 2005.90.3194.0 | [940933 FIX: Some changes from subscribers who use SQL Server 2005 Compact Edition or Web synchronization are not uploaded to the publisher when you use the republishing model in a merge publication in Microsoft SQL Server 2005]                                 | 2007-09-24   |
| 9.00.3186 | 2005.90.3186.0 | [940943 FIX: The performance of a query that performs an insert operation or an update operation is much slower in SQL Server 2005 SP2 than in earlier versions of SQL Server 2005]                                                                                  | 2007-08-29   |
| 9.00.3186 | 2005.90.3186.0 | [940378 FIX: A cursor uses the incorrect transaction isolation level after you change the transaction isolation level for the cursor in SQL Server 2005]                                                                                                             | 2007-08-24   |
| 9.00.3186 | 2005.90.3186.0 | [940269 FIX: Error message when you try to edit a SQL Server Agent job or a maintenance plan by using SQL Server Management Studio in SQL Server 2005: "String or binary data would be truncated"]                                                                   | 2007-08-23   |
| 9.00.3186 | 2005.90.3186.0 | [940945 FIX: Performance is very slow when the same stored procedure is executed at the same time in many connections on a multiple-processor computer that is running SQL Server 2005]                                                                              | 2007-08-22   |
| 9.00.3186 | 2005.90.3186.0 | [940937 FIX: Error message when you try to update the index key columns of a non-unique clustered index in SQL Server 2005: "Cannot insert duplicate key row in object 'ObjectName' with unique index 'IndexName'"]                                                  | 2007-08-21   |
| 9.00.3186 | 2005.90.3186.0 | [940379 FIX: Error message when you use the UNLOAD and REWIND options to back up a database to a tape device in SQL Server 2005: "Operation on device '<TapeDevice>' exceeded retry count"]                                                                          | 2007-08-20   |
| 9.00.3186 | 2005.90.3186.0 | [940375 FIX: Error message when you use the Copy Database Wizard to move a database from SQL Server 2000 to SQL Server 2005]                                                                                                                                         | 2007-08-20   |
| 9.00.3186 | 2005.90.3186.0 | [937100 FIX: Error message when you run a SQL Server 2005 Integration Services package that contains a Script Component transformation:"Insufficient memory to continue the execution of the program"]                                                               | 2007-08-20   |
| 9.00.3186 | 2005.90.3186.0 | [940126 FIX: Error 9003 is logged in the SQL Server error log file when you use log shipping in SQL Server 2005]                                                                                                                                                     | 2007-08-20   |
| 9.00.3186 | 2005.90.3186.0 | [938363 FIX: Data is not replicated to a subscriber in a different partition by using parameterized row filters in SQL Server 2005]                                                                                                                                  | 2007-08-17   |
| 9.00.3186 | 2005.90.3186.0 | [940935 FIX: Error message when you run a query that is associated with a parallel execution plan in SQL Server 2005: "SQL Server Assertion: File: <lckmgr.cpp>, line=10850 Failed Assertion = 'GetLocalLockPartition () == xactLockInfo->GetLocalLockPartition ()'"]| 2007-08-17   |
| 9.00.3186 | 2005.90.3186.0 | [940221 FIX: Error message when you try to create an Oracle publication by using the New Publication Wizard in SQL Server 2005 Service Pack 2: "OLE DB Provider 'OraOLEDB.ORACLE' for Linked server <LinkedServerName> returned message"]                            | 2007-08-17   |
| 9.00.3186 | 2005.90.3186.0 | [940942 FIX: Error message when you run a stored procedure that references tables after you upgrade a database from SQL Server 2000 to SQL Server 2005: "A time-out occurred while waiting for buffer latch"]                                                        | 2007-08-17   |
| 9.00.3186 | 2005.90.3186.0 | [940384 FIX: You receive a System.InvalidCastException exception when you run an application that calls the Server.JobServer.Jobs.Contains method on a computer that has SQL Server 2005 Service Pack 2 installed]                                                   | 2007-08-13   |
| 9.00.3186 | 2005.90.3186.0 | [940281 FIX: An access violation may occur, and you may receive an error message, when you query the sys.dm_exe_sessions dynamic management view in SQL Server 2005]                                                                                                 | 2007-08-13   |
| 9.00.3186 | 2005.90.3186.0 | [940545 FIX: The performance of insert operations against a table that contains an identity column may be slow in SQL Server 2005]                                                                                                                                   | 2007-08-10   |
| 9.00.3186 | 2005.90.3186.0 | [940210 FIX: Error message when you try to insert more than 3 megabytes of data into a distributed partitioned view in SQL Server 2005: "A system assertion check has failed"]                                                                                       | 2007-08-08   |
| 9.00.3186 | 2005.90.3186.0 | [939537 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 2]                                                                                                                                                                                        | 2007-08-23   |
| 9.00.3182 | 2005.90.3182.0 | [940128 FIX: You receive error 8623 when you run a complex query in SQL Server 2005]                                                                                                                                                                                 | 2007-08-03   |
| 9.00.3179 | 2005.90.3179.0 | [938243 FIX: Error message when you run a full-text query against a catalog in SQL Server 2005: "The execution of a full-text query failed. The content index is corrupt."]                                                                                          | 2007-07-30   |
| 9.00.3178 | 2005.90.3178.0 | [938086 FIX: A SQL Server Agent job fails when you run the SQL Server Agent job in the context of a proxy account in SQL Server 2005]                                                                                                                                | 2007-08-22   |
| 9.00.3177 | 2005.90.3177.0 | [939285 FIX: Error message when you run a stored procedure that starts a transaction that contains a Transact-SQL statement in SQL Server 2005: "New request is not allowed to start because it should come with valid transaction descriptor"]                      | 2007-08-22   |
| 9.00.3177 | 2005.90.3177.0 | [939562 FIX: Error message when you run a query that fires an INSTEAD OF trigger in SQL Server 2005 Service Pack 2: "Internal Query Processor Error The query processor could not produce a query plan"]                                                             | 2007-08-20   |
| 9.00.3177 | 2005.90.3177.0 | [939563 FIX: Error message when you synchronize a merge replication in Microsoft SQL Server 2005: "MSmerge_del_<GUID>, Line 42 String or binary data would be truncated"]                                                                                            | 2007-08-09   |
| 9.00.3175 | 2005.90.3175.0 | [936534 FIX: Error message when the Distribution Agent tries to apply the snapshot to the subscriber in SQL Server 2005: "Must declare the scalar variable "@Variable""]                                                                                             | 2007-08-20   |
| 9.00.3175 | 2005.90.3175.0 | [938671 FIX: The Distribution Agent may skip some rows when you configure a transactional replication that uses the "-SkipErrors" parameter in SQL Server 2005]                                                                                                      | 2007-08-01   |
| 9.00.3175 | 2005.90.3175.0 | [936488 The service pack update or hotfix installation stops unexpectedly when you try to install either Microsoft SQL Server 2005 Service Pack 2 or a hotfix for SQL Server 2005 SP2]                                                                               | 2007-07-10   |
| 9.00.3175 | 2005.90.3175.0 | [938825 FIX: A foreign key constraint that you drop on a table at the publisher is not dropped on the table at the subscriber in a SQL Server 2005 merge replication]                                                                                                | 2007-06-29   |
| 9.00.3175 | 2005.90.3175.0 | [936305 Cumulative update package 2 (CU2 build 3175) for SQL Server 2005 Service Pack 2 is available]                                                                                                                                                                | 2007-06-28   |
| 9.00.3171 | 2005.90.3171.0 | [937745 FIX: You may receive error messages when you try to log in to an instance of SQL Server 2005 and SQL Server handles many concurrent connections]                                                                                                             | 2007-07-16   |
| 9.00.3169 | 2005.90.3169.0 | [937033 FIX: Error message when you run a linked server query in SQL Server 2005: "The oledbprovider unisys.dmsII.1 for linkserver '<ServerName>' reported an error the provider ran out of memory"]                                                                 | 2007-06-19   |
| 9.00.3169 | 2005.90.3169.0 | [937041 FIX: Changes in the publisher database are not replicated to the subscribers in a transactional replication if the publisher database runs exposed in a database mirroring session in SQL Server 2005]                                                       | 2007-05-25   |
| 9.00.3166 | 2005.90.3166.0 | [936185 FIX: Blocking and performance problems may occur when you enable trace flag 1118 in SQL Server 2005 if the temporary table creation workload is high]                                                                                                        | 2007-06-11   |
| 9.00.3166 | 2005.90.3166.0 | [934734 FIX: A database is marked as suspect when you update a table that contains a nonclustered index in SQL Server 2005]                                                                                                                                          | 2007-07-16   |
| 9.00.3161 | 2005.90.3161.0 | [935789 FIX: On a computer that is running SQL Server 2005 and that has multiple processors, you may receive incorrect results when you run a query that contains an inner join]                                                                                     | 2007-09-24   |
| 9.00.3161 | 2005.90.3161.0 | [934706 FIX: Error message when you perform a piecemeal restore operation after you enable vardecimal database compression in SQL Server 2005 Service Pack 2: "Piecemeal restore is not supported when an upgrade is involved"]                                      | 2007-06-04   |
| 9.00.3161 | 2005.90.3161.0 | [933724 FIX: The query performance is slow when you run a query that uses a user-defined scalar function against an instance of SQL Server 2005]                                                                                                                     | 2007-05-09   |
| 9.00.3161 | 2005.90.3161.0 | [935356 Cumulative update package (CU1 build 3161) for SQL Server 2005 Service Pack 2 is available]                                                                                                                                                                  | 2007-04-16   |
| 9.00.3159 | 2005.90.3159.0 | [934459 FIX: The Check Database Integrity task and the Execute T-SQL Statement task in a maintenance plan may lose database context in certain circumstances in SQL Server 2005 builds 3150 through 3158]                                                            | 2007-04-03   |
| 9.00.3156 | 2005.90.3156.0 | [934226 FIX: Error message when you try to use Database Mail to send an e-mail message in SQL Server 2005: "profile name is not valid (Microsoft SQL Server, Error 14607)"]                                                                                          | 2007-04-25   |
| 9.00.3155 | 2005.90.3155.0 | [933808 FIX: Error message when you run a query that contains nested FOR XML clauses in SQL Server 2005: "The XML data type is damaged"]                                                                                                                             | 2007-06-13   |
| 9.00.3155 | 2005.90.3155.0 | [933499 FIX: Error message when you use transactional replication to replicate the execution of stored procedures to subscribers in SQL Server 2005: "Insufficient memory to run query"]                                                                             | 2007-06-12   |
| 9.00.3155 | 2005.90.3155.0 | [933766 FIX: Failed assertion message in the Errorlog file when you perform various operations in SQL Server 2005: "Failed Assertion = 'fFalse' Attempt to access expired blob handle (3)"]                                                                          | 2007-05-15   |
| 9.00.3155 | 2005.90.3155.0 | [933549 FIX: You may receive an access violation when you perform a bulk copy operation in SQL Server 2005]                                                                                                                                                          | 2007-04-25   |
| 9.00.3154 | 2005.90.3154.0 | [934188 FIX: The Distribution Agent does not deliver commands to the Subscriber even if the Distribution Agent is running in SQL Server 2005]                                                                                                                        | 2007-04-25   |
| 9.00.3154 | 2005.90.3154.0 | [934109 FIX: The Distribution Agent generates an access violation when you configure a transactional replication publication to run an additional script after the snapshot is applied at the subscriber in SQL Server 2005]                                         | 2007-04-25   |
| 9.00.3154 | 2005.90.3154.0 | [934106 FIX: SQL Server 2005 database engine generates failed assertion errors when you use the Replication Monitor to monitor the distribution database]                                                                                                            | 2007-04-25   |
| 9.00.3153 | 2005.90.3153.0 | [933564 FIX: A gradual increase in memory consumption for the USERSTORE_TOKENPERM cache store occurs in SQL Server 2005]                                                                                                                                             | 2007-04-16   |
| 9.00.3152 | 2005.90.3152.0 | [933097 Cumulative hotfix package (build 3152) for SQL Server 2005 Service Pack 2 is available]                                                                                                                                                                      | 2007-03-07   |
| 9.00.3080 | 2005.90.3080.0 | [970895 MS09-062: Description of the security update for GDI+ for SQL Server 2005 Service Pack 2 GDR: October 13, 2009]                                                                                                                                              | 2009-10-13   |
| 9.00.3077 | 2005.90.3077.0 | [960089 MS09-004: Description of the security update for SQL Server 2005 GDR: February 10, 2009]                                                                                                                                                                     | 2009-02-10   |
| 9.00.3073 | 2005.90.3073.0 | [954606 MS08-052: Description of the security update for GDI+ for SQL Server 2005 Service Pack 2 GDR: September 9, 2008]                                                                                                                                             | 2008-09-09   |
| 9.00.3068 | 2005.90.3068.0 | [941203 MS08-040: Vulnerabilities in Microsoft SQL Server could allow elevation of privilege]                                                                                                                                                                        | 2008-08-05   |
| 9.00.3054 | 2005.90.3054.0 | [934458 FIX: The Check Database Integrity task and the Execute T-SQL Statement task in a maintenance plan may lose database context in certain circumstances in SQL Server 2005 builds 3042 through 3053]                                                            | 2008-01-02   |
| 9.00.3050 | 2005.90.3050.0 | [933508 Microsoft SQL Server 2005 Service Pack 2 issue: Cleanup tasks run at different intervals than intended]                                                                                                                                                      | 2007-03-07   |
| 9.00.3042 | 2005.90.3042.0 | [SQL Server 2005 Service Pack 2 (SP2)]                                                                                                                                                                                                                               | 2007-02-19   |
| 9.00.3033 | 2005.90.3033.0 | SQL Server 2005 Service Pack 2 (SP2) - CTP December 2006                                                                                                                                                                                                             | 2006-12-19   |
| 9.00.3027 | 2005.90.3027.0 | SQL Server 2005 Service Pack 2 (SP2) - CTP November 2006                                                                                                                                                                                                             | 2006-11-06   |
| 9.00.3026 | 2005.90.3026.0 | [929376 FIX: A "17187" error message may be logged in the Errorlog file when an instance of SQL Server 2005 is under a heavy load]                                                                                                                                   | 2007-02-14   |
| 9.00.2239 | 2005.90.2239.0 | [940961 FIX: Transactions that are being committed on the principal server may not be copied to the mirror server when a database mirroring failover occurs in SQL Server 2005]                                                                                      | 2007-09-24   |
| 9.00.2237 | 2005.90.2237.0 | [940719 FIX: A memory leak occurs when you call the Initialize method and the Terminate method of the SQLDistribution object in a loop in an application that you develop by using Microsoft ActiveX replication controls in SQL Server 2005]                        | 2007-09-24   |
| 9.00.2236 | 2005.90.2236.0 | [940287 FIX: Error message when you use Service Broker in SQL Server 2005: "An error occurred while receiving data: '64(The specified network name is no longer available.)'"]                                                                                       | 2007-07-29   |
| 9.00.2236 | 2005.90.2236.0 | [940286 FIX: A Service Broker endpoint stops passing messages in a database mirroring session of SQL Server 2005]                                                                                                                                                    | 2007-07-26   |
| 9.00.2234 | 2005.90.2234.0 | [937343 FIX: SQL Server 2005 stops and then restarts unexpectedly and errors occur in the tempdb database]                                                                                                                                                           | 2007-06-20   |
| 9.00.2233 | 2005.90.2233.0 | [937545 FIX: Error message when you use the BULK INSERT statement to import a data file into a table in SQL Server 2005 with SP1: "The OLE DB provider "BULK" for linked server "(null)" reported an error"]                                                         | 2007-06-18   |
| 9.00.2233 | 2005.90.2233.0 | [933499 FIX: Error message when you use transactional replication to replicate the execution of stored procedures to subscribers in SQL Server 2005: "Insufficient memory to run query"]                                                                             | 2007-06-12   |
| 9.00.2233 | 2005.90.2233.0 | [937544 FIX: You may receive error 3456 when you try to restore a transaction log for a SQL Server 2005 database]                                                                                                                                                    | 2007-06-05   |
| 9.00.2232 | 2005.90.2232.0 | [937277 FIX: A memory leak occurs when you use the sp_OAMethod stored procedure to call a method of a COM object in SQL Server 2005]                                                                                                                                 | 2007-06-19   |
| 9.00.2231 | 2005.90.2231.0 | [934812 FIX: You cannot bring the SQL Server group online in a cluster environment after you rename the virtual server name of the default instance of SQL Server 2005]                                                                                              | 2007-11-06   |
| 9.00.2230 | 2005.90.2230.0 | [936179 FIX: Error message when you use SQL Native Client to connect to an instance of a principal server in a database mirroring session: "The connection attempted to fail over to a server that does not have a failover partner"]                                | 2007-09-20   |
| 9.00.2229 | 2005.90.2229.0 | [935446 FIX: You receive error messages when you use the BULK INSERT statement in SQL Server 2005 to import data in bulk]                                                                                                                                            | 2007-06-11   |
| 9.00.2227 | 2005.90.2227.0 | [933265 FIX: You may receive error 1203 when you run an INSERT statement against a table that has an identity column in SQL Server 2005]                                                                                                                             | 2007-06-26   |
| 9.00.2226 | 2005.90.2226.0 | [934065 FIX: Error message when the Replication Merge Agent runs to synchronize a merge replication subscription in SQL Server 2005: "The merge process failed to execute a query because the query timed out"]                                                      | 2007-06-22   |
| 9.00.2226 | 2005.90.2226.0 | [933762 FIX: You receive error 18815 when the Log Reader Agent runs for a transactional publication in SQL Server 2005]                                                                                                                                              | 2007-06-22   |
| 9.00.2223 | 2005.90.2223.0 | [932393 FIX: You may experience poor performance after you install SQL Server 2005 Service Pack 1]                                                                                                                                                                   | 2007-06-18   |
| 9.00.2221 | 2005.90.2221.0 | [931593 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 2153 and later builds]                                                                                                                  | 2007-07-11   |
| 9.00.2219 | 2005.90.2219.0 | [932115 FIX: The ghost row clean-up thread does not remove ghost rows on some data files of a database in SQL Server 2005]                                                                                                                                           | 2007-04-25   |
| 9.00.2218 | 2005.90.2218.0 | [931843 FIX: SQL Server 2005 does not reclaim the disk space that is allocated to the temporary table if the stored procedure is stopped]                                                                                                                            | 2007-04-25   |
| 9.00.2216 | 2005.90.2216.0 | [931821 FIX: High CPU utilization by SQL Server 2005 may occur when you use NUMA architecture on a computer that has an x64-based version of SQL Server 2005 installed]                                                                                              | 2007-05-15   |
| 9.00.2214 | 2005.90.2214.0 | [930505 FIX: Error message when you run DML statements against a table that is published for merge replication in SQL Server 2005: "Could not find stored procedure"]                                                                                                | 2007-02-19   |
| 9.00.2214 | 2005.90.2214.0 | [929240 FIX: I/O requests that are generated by the checkpoint process may cause I/O bottlenecks if the I/O subsystem is not fast enough to sustain the IO requests in SQL Server 2005]                                                                              | 2007-02-13   |
| 9.00.2211 | 2005.90.2211.0 | [930284 FIX: You receive error 1456 when you try to add a witness to a DBM session in SQL Server 2005]                                                                                                                                                               | 2007-02-20   |
| 9.00.2211 | 2005.90.2211.0 | [930283 FIX: You receive error 1456 when you add a witness to a database mirroring session and the database name is the same as an existing database mirroring session in SQL Server 2005]                                                                           | 2007-02-14   |
| 9.00.2209 | 2005.90.2209.0 | [929278 FIX: SQL Server 2005 may not perform histogram amendments when you use trace flags 2389 and 2390]                                                                                                                                                            | 2007-02-07   |
| 9.00.2208 | 2005.90.2208.0 | [929179 FIX: A memory leak may occur every time that you synchronize a SQL Server Mobile subscriber in SQL Server 2005]                                                                                                                                              | 2007-01-09   |
| 9.00.2207 | 2005.90.2207.0 | [928394 FIX: The changes are not reflected in the publication database after you reinitialize the subscriptions in SQL Server 2005]                                                                                                                                  | 2006-12-19   |
| 9.00.2207 | 2005.90.2207.0 | [928372 FIX: Error message when you use a synonym for a stored procedure in SQL Server 2005: "A severe error occurred on the current command"]                                                                                                                       | 2006-12-19   |
| 9.00.2207 | 2005.90.2207.0 | [928789 FIX: Error message in the database mail log when you try to use the sp_send_dbmail stored procedure to send an e-mail in SQL Server 2005: "Invalid XML message format received on the ExternalMailQueue"]                                                    | 2007-01-02   |
| 9.00.2206 | 2005.90.2206.0 | [928083 FIX: You may receive an error message when you run a CLR stored procedure or CLR function that uses a context connection in SQL Server 2005]                                                                                                                 | 2007-02-01   |
| 9.00.2206 | 2005.90.2206.0 | [928537 FIX: The full-text index population for the indexed view is very slow in SQL Server 2005]                                                                                                                                                                    | 2007-01-12   |
| 9.00.2206 | 2005.90.2206.0 | [926493 FIX: Error message when you restore a transaction-log backup that is generated in SQL Server 2000 SP4 to an instance of SQL Server 2005: Msg 3456, Level 16, State 1, Line 1. Could not redo log record"]                                                    | 2007-01-02   |
| 9.00.2206 | 2005.90.2206.0 | [928539 FIX: An access violation is logged in the SQL Server Errorlog file when you run a query that uses a plan guide in SQL Server 2005]                                                                                                                           | 2006-12-13   |
| 9.00.2202 | 2005.90.2202.0 | [927643 FIX: Some search results are missing when you perform a full-text search operation on a Windows SharePoint Services 2.0 site after you upgrade to SQL Server 2005]                                                                                           | 2007-02-16   |
| 9.00.2201 | 2005.90.2201.0 | [927289 FIX: Updates to the SQL Server Mobile subscriber may not be reflected in the SQL Server 2005 merge publication]                                                                                                                                              | 2007-01-10   |
| 9.00.2198 | 2005.90.2198.0 | [926613 FIX: You may receive incorrect results when you query a table that is published in a transactional replication in SQL Server 2005]                                                                                                                           | 2007-02-21   |
| 9.00.2198 | 2005.90.2198.0 | [926106 FIX: You receive an error message when you use the Print Preview option on a large report in SQL Server 2005 Reporting Services]                                                                                                                             | 2007-02-20   |
| 9.00.2198 | 2005.90.2198.0 | [924807 FIX: The restore operation may take a long time to finish when you restore a database in SQL Server 2005]                                                                                                                                                    | 2007-02-02   |
| 9.00.2198 | 2005.90.2198.0 | [924264 FIX: The metadata of the Description object of a Key Performance Indicator appears in the default language after you define a translation for the Description object in SQL Server 2005 Business Intelligence Development Studio]                            | 2006-12-13   |
| 9.00.2198 | 2005.90.2198.0 | [926612 FIX: SQL Server Agent does not send an alert quickly or does not send an alert when you use an alert of the SQL Server event alert type in SQL Server 2005]                                                                                                  | 2007-01-04   |
| 9.00.2198 | 2005.90.2198.0 | [926773 FIX: Error message when you run a query that uses a fast forward-only cursor in SQL Server 2005: "Query processor could not produce a query plan because of the hints defined in this query"]                                                                | 2006-11-16   |
| 9.00.2198 | 2005.90.2198.0 | [926611 FIX: SQL Server 2005 may not send a message notification that is based on the specific string in the forwarded event when a computer that is running SQL Server 2000 forwards an event to a computer that is running SQL Server 2005]                        | 2006-11-28   |
| 9.00.2198 | 2005.90.2198.0 | [924808 FIX: You receive an error message, or you obtain an incorrect result when you query data in a partitioned table that does not have a clustered index in SQL Server 2005]                                                                                     | 2006-12-13   |
| 9.00.2198 | 2005.90.2198.0 | [925277 FIX: You may experience very large growth increments of a principal database after you manually fail over a database mirroring session in SQL Server 2005]                                                                                                   | 2007-01-02   |
| 9.00.2196 | 2005.90.2196.0 | [926285 Fix: Error message when you convert a column from the varbinary(max) data type to the XML data type in SQL Server 2005: "Msg 6322, Level 16, State 1, Line 2 Too many attributes or namespace definitions"]                                                  | 2006-11-10   |
| 9.00.2196 | 2005.90.2196.0 | [926335 FIX: Error message when you trace the Audit Database Management event and you try to bring a database online in SQL Server 2005: “Msg 942, Level 14, State 4, Line 1”]                                                                                       | 2006-12-05   |
| 9.00.2195 | 2005.90.2195.0 | [926240 FIX: SQL Server 2005 may stop responding when you use the SqlBulkCopy class to import data from another data source]                                                                                                                                         | 2006-12-19   |
| 9.00.2194 | 2005.90.2194.0 | [925744 FIX: Error message when you try to use a SQL Server authenticated login to log on to an instance of SQL Server 2005: "Logon error: 18456"]                                                                                                                   | 2006-10-20   |
| 9.00.2192 | 2005.90.2192.0 | [924954 FIX: Error message when you use a table-valued function (TVF) together with the CROSS APPLY operator in a query in SQL Server 2005: "There is insufficient system memory to run this query"]                                                                 | 2006-09-29   |
| 9.00.2192 | 2005.90.2192.0 | [925335 FIX: Error message when you use a label after a Transact-SQL query in SQL Server 2005: "Incorrect syntax near 'X'"]                                                                                                                                          | 2006-10-05   |
| 9.00.2191 | 2005.90.2191.0 | [925135 FIX: An empty string is replicated as a NULL value when you synchronize a table to a SQL Server 2005 Compact Edition subscriber]                                                                                                                             | 2006-12-06   |
| 9.00.2190 | 2005.90.2190.0 | [925227 FIX: Error message when you call the SQLTables function against an instance of SQL Server 2005: "Invalid cursor state (0)"]                                                                                                                                  | 2006-10-16   |
| 9.00.2189 | 2005.90.2189.0 | [925153 FIX: You may receive different date values for each row when you use the getdate function within a case statement in SQL Server 2005]                                                                                                                        | 2006-09-22   |
| 9.00.2187 | 2005.90.2187.0 | [923849 FIX: When you run a query that references a partitioned table in SQL Server 2005, query performance may decrease]                                                                                                                                            | 2006-09-22   |
| 9.00.2181 | 2005.90.2181.0 | [923605 FIX: A deadlock occurs and a query never finishes when you run the query on a computer that is running SQL Server 2005 and has multiple processors]                                                                                                          | 2007-02-19   |
| 9.00.2181 | 2005.90.2181.0 | [923624 FIX: Error message when you run an application against SQL Server 2005 that uses many unique user logins or performs many user login impersonations: "insufficient system memory to run this query"]                                                         | 2006-10-04   |
| 9.00.2176 | 2005.90.2176.0 | [922594 FIX: Error message when you use SQL Server 2005: "High priority system task thread Operating system error Exception 0xAE encountered"]                                                                                                                       | 2007-02-12   |
| 9.00.2176 | 2005.90.2176.0 | [923296 FIX: Log Reader Agent fails, and an assertion error message is logged when you use transactional replication in SQL Server 2005]                                                                                                                             | 2006-09-06   |
| 9.00.2175 | 2005.90.2175.0 | [921395 FIX: The color and the background image may not appear when you try to display a report in HTML format in Report Manager in SQL Server 2005 Reporting Services]                                                                                              | 2006-08-08   |
| 9.00.2175 | 2005.90.2175.0 | [917905 FIX: SQL Server 2005 performance may be slower than SQL Server 2000 performance when you use an API server cursor]                                                                                                                                           | 2006-08-14   |
| 9.00.2175 | 2005.90.2175.0 | [922578 FIX: In SQL Server 2005, the sp_altermessage stored procedure does not suppress system error messages that are logged in the SQL Server error log and in the Application log]                                                                                | 2006-08-30   |
| 9.00.2175 | 2005.90.2175.0 | [922438 FIX: A query may take a long time to compile when the query contains several JOIN clauses against a SQL Server 2005 database]                                                                                                                                | 2006-12-14   |
| 9.00.2175 | 2005.90.2175.0 | [921536 FIX: A handled access violation may occur in the CValSwitch::GetDataX function when you run a complex query in SQL Server 2005]                                                                                                                              | 2006-12-18   |
| 9.00.2174 | 2005.90.2174.0 | [922063 FIX: You may notice a large increase in compile time when you enable trace flags 2389 and 2390 in SQL Server 2005 Service Pack 1]                                                                                                                            | 2006-07-25   |
| 9.00.2167 | 2005.90.2167.0 | [920974 FIX: SQL Server 2005 treats an identity column in a view as an ordinary int column when the compatibility level of the database is set to 80]                                                                                                                | 2006-08-09   |
| 9.00.2164 | 2005.90.2164.0 | [919243 FIX: Some rows in the Text Data column are always displayed for a trace that you create by using SQL Server Profiler in SQL Server 2005]                                                                                                                     | 2007-02-08   |
| 9.00.2164 | 2005.90.2164.0 | [920346 FIX: SQL Server 2005 may overestimate the cardinality of the JOIN operator when a SQL Server 2005 query contains a join predicate that is a multicolumn predicate]                                                                                           | 2006-09-19   |
| 9.00.2164 | 2005.90.2164.0 | [920347 FIX: The SQL Server 2005 query optimizer may incorrectly estimate the cardinality for a query that has a predicate that contains an index union alternative]                                                                                                 | 2006-09-19   |
| 9.00.2164 | 2005.90.2164.0 | [919929 FIX: Error message when the Replication Merge Agent runs in SQL Server 2005: "Source: MSSQL_REPL, Error number: MSSQL_REPL-2147199402"]                                                                                                                      | 2006-10-26   |
| 9.00.2164 | 2005.90.2164.0 | [921003 FIX: You may receive an error message when you manually define a Back Up Database task in SQL Server 2005 to back up the transaction log]                                                                                                                    | 2006-08-29   |
| 9.00.2164 | 2005.90.2164.0 | [920206 FIX: System performance may be slow when an application submits many queries against a SQL Server 2005 database that uses simple parameterization]                                                                                                           | 2006-09-26   |
| 9.00.2164 | 2005.90.2164.0 | [918882 FIX: A query plan is not cached in SQL Server 2005 when the text of the hint is a large object]                                                                                                                                                              | 2006-09-06   |
| 9.00.2164 | 2005.90.2164.0 | [919636 FIX: Memory usage of the compiled query plan may unexpectedly increase in SQL Server 2005]                                                                                                                                                                   | 2006-07-26   |
| 9.00.2164 | 2005.90.2164.0 | [919775 FIX: The BULK INSERT statement may not return any errors when you try to import data from a text file to a table by using the BULK INSERT statement in Microsoft SQL Server 2005]                                                                            | 2006-08-09   |
| 9.00.2156 | 2005.90.2156.0 | [919611 FIX: The value of the automatic growth increment of a database file may be very large in SQL Server 2005 with Service Pack 1]                                                                                                                                | 2006-07-26   |
| 9.00.2153 | 2005.90.2153.0 | [918222 Cumulative hotfix package (build 2153) for SQL Server 2005 is available]                                                                                                                                                                                     | 2006-09-14   |
| 9.00.2153 | 2005.90.2153.0 | [919224 FIX: You may receive an error message when you install the cumulative hotfix package (build 2153) for SQL Server 2005]                                                                                                                                       | 2006-05-23   |
| 9.00.2050 | 2005.90.2050.0 | [932555 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 2047]                                                                                                                                   | 2007-07-11   |
| 9.00.2047 | 2005.90.2047.0 | [SQL Server 2005 Service Pack 1 (SP1)]                                                                                                                                                                                                                               | 2006-04-18   |
| 9.00.2040 | 2005.90.2040.0 | SQL Server 2005 Service Pack 1 (SP1) CTP March 2006                                                                                                                                                                                                                  | 2006-03-12   |
| 9.00.2029 | 2005.90.2029.0 | SLQ Server 2005 Service Pack 1 (SP1) Beta                                                                                                                                                                                                                            | 2005-11-07   |
| 9.00.1561 | 2005.90.1561.0 | [932556 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 1500 and later builds]                                                                                                                  | 2007-07-11   |
| 9.00.1558 | 2005.90.1558.0 | [926493 FIX: Error message when you restore a transaction-log backup that is generated in SQL Server 2000 SP4 to an instance of SQL Server 2005: "Msg 3456, Level 16, State 1, Line 1. Could not redo log record"]                                                   | 2007-01-04   |
| 9.00.1554 | 2005.90.1554.0 | [926292 FIX: When you query through a view that uses the ORDER BY clause in SQL Server 2005, the result is still returned in random order]                                                                                                                           | 2007-06-26   |
| 9.00.1551 | 2005.90.1551.0 | [922527 FIX: Error message when you schedule some SQL Server 2005 Integration Services packages to run as jobs: "Package <PackageName> has been cancelled"]                                                                                                          | 2007-01-22   |
| 9.00.1551 | 2005.90.1551.0 | [922804 FIX: After you detach a Microsoft SQL Server 2005 database that resides on network-attached storage, you cannot reattach the SQL Server database]                                                                                                            | 2006-11-22   |
| 9.00.1550 | 2005.90.1550.0 | [917887 FIX: The value of the automatic growth increment of a database file may be very large in SQL Server 2005]                                                                                                                                                    | 2006-07-26   |
| 9.00.1550 | 2005.90.1550.0 | [921106 FIX: You receive an error message when you try to create a differential database backup in SQL Server 2005]                                                                                                                                                  | 2006-11-22   |
| 9.00.1547 | 2005.90.1547.0 | [918276 FIX: You notice additional random trailing character in values when you retrieve the values from a fixed-size character column or a fixed-size binary column of a table in SQL Server 2005]                                                                  | 2006-11-20   |
| 9.00.1545 | 2005.90.1545.0 | [917905 FIX: SQL Server 2005 performance may be slower than SQL Server 2000 performance when you use an API server cursor]                                                                                                                                           | 2006-08-14   |
| 9.00.1541 | 2005.90.1541.0 | [917888 FIX: Error message when you use a server-side cursor to run a large complex query in SQL Server 2005: "Error: 8623, Severity: 16, State: 1 The query processor ran out of internal resources"]                                                               | 2006-11-22   |
| 9.00.1541 | 2005.90.1541.0 | [917971 FIX: You may receive more than 100,000 page faults when you try to back up a SQL Server 2005 database that contains hundreds of files and file groups]                                                                                                       | 2006-11-22   |
| 9.00.1539 | 2005.90.1539.0 | [917738 FIX: SQL Server 2005 system performance may be slow when you use a keyset-driven cursor to execute a FETCH statement]                                                                                                                                        | 2006-08-11   |
| 9.00.1538 | 2005.90.1538.0 | [917824 FIX: The SQL Server 2005 SqlCommandBuilder.DeriveParameters method returns an exception when the input parameter is a XML parameter that has an associated XSD from an SQL schema]                                                                           | 2006-07-26   |
| 9.00.1536 | 2005.90.1536.0 | [917016 FIX: The monitor server does not monitor all primary servers and secondary servers when you configure log shipping in SQL Server 2005]                                                                                                                       | 2006-07-26   |
| 9.00.1534 | 2005.90.1534.0 | [916706 FIX: When you run the "dbcc dbreindex" command or the "alter index" command, some transactions are not replicated to the subscribers in a transactional replication in SQL Server 2005]                                                                      | 2007-05-15   |
| 9.00.1533 | 2005.90.1533.0 | [916086 FIX: Errors may be generated in the tempdb database when you create and then drop many temporary tables in SQL Server 2005]                                                                                                                                  | 2006-07-26   |
| 9.00.1532 | 2005.90.1532.0 | [916046 FIX: Indexes may grow very large when you insert a row into a table and then update the same row in SQL Server 2005]                                                                                                                                         | 2007-01-09   |
| 9.00.1531 | 2005.90.1531.0 | [915918 FIX: The internal deadlock monitor may not detect a deadlock between two or more sessions in SQL Server 2005]                                                                                                                                                | 2006-07-26   |
| 9.00.1528 | 2005.90.1528.0 | [915309 FIX: When you start a merge agent, synchronization between the subscriber and the publisher takes a long time to be completed in SQL Server 2005]                                                                                                            | 2007-01-15   |
| 9.00.1528 | 2005.90.1528.0 | [915308 FIX: The CPU usage of the server reaches 100% when many DML activities occur in SQL Server 2005]                                                                                                                                                             | 2007-01-04   |
| 9.00.1528 | 2005.90.1528.0 | [915307 FIX: You experience a slow uploading process if conflicts occur when many merge agents upload changes to the publishers at the same time in SQL Server 2005]                                                                                                 | 2007-01-11   |
| 9.00.1528 | 2005.90.1528.0 | [915306 FIX: The merge agent fails and a "permission denied" error message is logged when you synchronize a SQL Server 2005-based merge publication]                                                                                                                 | 2007-01-08   |
| 9.00.1528 | 2005.90.1528.0 | [915112 FIX: Error message when an ADO.NET-connected application tries to reuse a connection from the connection pool in SQL Server 2005: "The request failed to run because the batch is aborted"]                                                                  | 2006-07-26   |
| 9.00.1519 | 2005.90.1519.0 | [913494 FIX: The merge agent does not use a specified custom user update to handle conflicting UPDATE statements in SQL Server 2005]                                                                                                                                 | 2007-01-20   |
| 9.00.1518 | 2005.90.1518.0 | [913941 FIX: A SQL Server login may have more permissions when you log on to an instance of SQL Server 2005]                                                                                                                                                         | 2006-09-22   |
| 9.00.1518 | 2005.90.1518.0 | [912472 FIX: An incorrect result may appear in the subscribing database when you set database mirroring for a database and database failover occurs in SQL Server 2005]                                                                                              | 2006-07-26   |
| 9.00.1518 | 2005.90.1518.0 | [913371 FIX: You may receive error messages when you use the sp_cursoropen statement to open a cursor on a user-defined stored procedure in SQL Server 2005]                                                                                                         | 2006-07-26   |
| 9.00.1514 | 2005.90.1514.0 | [912471 FIX: The replication on the server does not work any longer when you manually fail over databases in SQL Server 2005]                                                                                                                                        | 2006-07-26   |
| 9.00.1503 | 2005.90.1503.0 | [911662 FIX: You may receive an access violation error message when you run a SELECT query in SQL Server 2005]                                                                                                                                                       | 2006-07-26   |
| 9.00.1502 | 2005.90.1502.0 | [915793 FIX: You cannot restore the log backups on the mirror server after you remove database mirroring for the mirror database in SQL Server 2005]                                                                                                                 | 2006-07-26   |
| 9.00.1500 | 2005.90.1500.0 | [910416 FIX: Error message when you run certain queries or certain stored procedures in SQL Server 2005: "A severe error occurred on the current command"]                                                                                                           | 2006-06-01   |
| 9.00.1406 | 2005.90.1406.0 | [932557 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 1399]                                                                                                                                   | 2007-07-11   |
| 9.00.1399 | 2005.90.1399.0 | SQL Server 2005 RTM                                                                                                                                                                                                                                                  | 2005-11-07   |

[2716427 MS12-070: Description of the security update for SQL Server 2005 Service Pack 4 QFE]:http://support.microsoft.com/kb/2716427
[2615425 FIX: "Msg 7359" error when a view uses another view in SQL Server 2005 if the schema version of a remote table is updated]:http://support.microsoft.com/kb/2615425
[2598903 FIX: SQL Server Agent job randomly stops when you schedule the job to run past midnight on specific days in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2]:http://support.microsoft.com/kb/2598903
[2572407 FIX: Error 5180 when you use the ONLINE option to rebuild an index in SQL Server 2005]:http://support.microsoft.com/kb/2572407
[2494123 MS11-049: Description of the security update for SQL Server 2005 Service Pack 4 QFE: June 14, 2011]:http://support.microsoft.com/kb/2494123
[2507769 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2507769
[2489409 Cumulative update package 2 (CU2) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2489409
[2464079 Cumulative update package 1 (CU1) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2464079
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/en-us/security/bulletin/ms12-070
[2494120 MS11-049: Description of the security update for SQL Server 2005 Service Pack 4 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494120
[SQL Server 2005 Service Pack 4 (SP4)]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=b953e84f-9307-405e-bceb-47bd345baece
[2598903 FIX: SQL Server Agent job randomly stops when you schedule the job to run past midnight on specific days in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2]:http://support.microsoft.com/kb/2598903
[2494112 MS11-049: Description of the security update for SQL Server 2005 Service Pack 3 QFE: June 14, 2011]:http://support.microsoft.com/kb/2494112
[2507766 Cumulative update package 15 (CU15) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/2507766
[2489375 Cumulative update package 14 (CU14) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/2489375
[2438344 Cumulative update package 13 (CU13) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/2438344
[2345449 Cumulative update package 12 (CU12) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/2345449
[2258854 Cumulative update package 11 (CU11) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/2258854
[983329 Cumulative update package 10 (CU10) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/983329
[980176 Cumulative update package 9 (CU9) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/980176
[978915 Cumulative update package 8 (CU8) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/978915
[976951 Cumulative update package 7 (CU7) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/976951
[977151 FIX: Error message when you add a subscription to a republisher that is in a merge publication in SQL Server 2005: "Cannot create the subscription because the subscription already exists in the subscription database"]:http://support.microsoft.com/kb/977151
[974648 Cumulative update package 6 (CU6) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/974648
[970894 MS09-062: Description of the security update for SQL Server 2005 Service Pack 3 QFE: October 13, 2009]:http://support.microsoft.com/kb/970894
[972511 Cumulative update package 5 (CU5) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/972511
[970279 Cumulative update package 4 (CU4) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/970279
[971409 FIX: Error message when you run a query that contains duplicate join conditions in SQL Server 2005: "Internal Query Processor Error: The query processor could not produce a query plan"]:http://support.microsoft.com/kb/971409
[967909 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/967909
[967101 FIX: The performance of database mirroring decreases when you run a database maintenance job that generates a large number of transaction log activities in SQL Server 2005]:http://support.microsoft.com/kb/967101
[961930 Cumulative update package 2 (CU2) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/961930
[959195 Cumulative update package 1 (CU1) for SQL Server 2005 Service Pack 3]:http://support.microsoft.com/kb/959195
[2494113 MS11-049: Description of the security update for SQL Server 2005 Service Pack 3 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494113
[970892 MS09-062: Description of the security update for SQL Server 2005 Service Pack 3 GDR: October 13, 2009]:http://support.microsoft.com/kb/970892/
[SQL Server 2005 Service Pack 3 (SP3)]:http://www.microsoft.com/downloads/details.aspx?FamilyId=AE7387C3-348C-4FAA-8AE5-949FDFBE59C4
[976952 Cumulative update package 17 (CU17) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/976952
[974647 Cumulative update package 16 (CU16) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/974647
[970896 MS09-062: Description of the security update for SQL Server 2005 Service Pack 2 QFE: October 13, 2009]:http://support.microsoft.com/kb/970896
[972510 Cumulative update package 15 (CU15) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/972510
[970278 Cumulative update package 14 (CU14) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/970278
[967908 Cumulative update package 13 (CU13) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/967908
[969142 FIX: Error message when you run the DBCC CHECKDB statement on a database in SQL Server 2005: "Unable to deallocate a kept page"]:http://support.microsoft.com/kb/969142
[967199 FIX: The Wmiprvse.exe host process stops responding when you run a SQL Server 2005-based application that sends a Windows Management Instrumentation (WMI) query to the SQL Server WMI provider]:http://support.microsoft.com/kb/967199
[962970 Cumulative update package 12 (CU12) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/962970
[960090 MS09-004: Description of the security update for SQL Server 2005 QFE: February 10, 2009]:http://support.microsoft.com/kb/960090
[958735 Cumulative update package 11 (CU11) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/958735
[956854 Cumulative update package 10 (CU10) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/956854
[953752 Cumulative update package 9 (CU9) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/953752
[954950 FIX: Error message when you run a distributed query in SQL Server 2005: "OLE DB provider 'SQLNCLI' for linked server '<Linked Server>' returned message 'No transaction is active'"]:http://support.microsoft.com/kb/954950
[954831 FIX: In SQL Server 2005, the session that runs the TRUNCATE TABLE statement may stop responding, and you cannot end the session]:http://support.microsoft.com/kb/954831
[954669 FIX: An ongoing MS DTC transaction is orphaned in SQL Server 2005]:http://support.microsoft.com/kb/954669
[951217 Cumulative update package 8 (CU8) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/951217
[952233 FIX: All the MDX queries that are running on an instance of SQL Server 2005 Analysis Services are canceled when you start or stop a SQL Server Profiler trace for the instance]:http://support.microsoft.com/kb/952233
[952330 FIX: The Replication Log Reader Agent may fail intermittently when a transactional replication synchronizes data in SQL Server 2005]:http://support.microsoft.com/kb/952330
[951204 FIX: An access violation occurs when you update a table through a view by using a cursor in SQL Server 2005]:http://support.microsoft.com/kb/951204
[949095 Cumulative update package 7 (CU7) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/949095
[949959 FIX: Error message when you synchronize the data of a merge replication in SQL Server 2005: "The merge process is retrying a failed operation made to article 'ArticleName' - Reason: 'Invalid input parameter values. Check the status values for detail.'"]:http://support.microsoft.com/kb/949959
[949595 FIX: Error message when you run a query that uses a join condition in SQL Server 2005: "Non-yielding Scheduler"]:http://support.microsoft.com/kb/949595
[949687 FIX: Error message when you run a transaction from a remote server by using a linked server in SQL Server 2005: "This operation conflicts with another pending operation on this transaction"]:http://support.microsoft.com/kb/949687
[949199 FIX: Error message when you run queries on a database that has the SNAPSHOT isolation level enabled in SQL Server 2005: "Unable to deallocate a kept page"]:http://support.microsoft.com/kb/949199
[946608 Cumulative update package 6 (CU6) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/946608
[947463 FIX: A stored procedure cannot finish its execution in SQL Server 2005]:http://support.microsoft.com/kb/947463
[942908 FIX: The change may be undone during the later synchronizations when you change an article on the subscriber in SQL Server 2005]:http://support.microsoft.com/kb/942908
[945443 FIX: A query takes longer to finish in SQL Server 2005 than in SQL Server 2000 when you open a fast forward-only cursor for the query]:http://support.microsoft.com/kb/945443
[945916 FIX: Error messages when you delete some records of a table in a transaction or when you update some records of a table in a transaction in SQL Server 2005: "Msg 9002," "Msg 3314," and "Msg 9001"]:http://support.microsoft.com/kb/945916
[945442 FIX: You cannot cancel the query execution immediately if you open a fast forward-only cursor for the query in SQL Server 2005]:http://support.microsoft.com/kb/945442
[943656 Cumulative update package 5 (CU5) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/943656
[944902 FIX: A federated database server stops responding when you run parallel queries on a multiprocessor computer that uses NUMA architecture in SQL Server 2005]:http://support.microsoft.com/kb/944902
[944677 FIX: Conflicts are not logged when you use the Microsoft SQL Server Subscriber Always Wins Conflict Resolver for an article in a merge replication in Microsoft SQL Server 2005]:http://support.microsoft.com/kb/944677
[941450 Cumulative update package 4 (CU4) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/941450
[940933 FIX: Some changes from subscribers who use SQL Server 2005 Compact Edition or Web synchronization are not uploaded to the publisher when you use the republishing model in a merge publication in Microsoft SQL Server 2005]:http://support.microsoft.com/kb/940933
[940943 FIX: The performance of a query that performs an insert operation or an update operation is much slower in SQL Server 2005 SP2 than in earlier versions of SQL Server 2005]:http://support.microsoft.com/kb/940943
[940378 FIX: A cursor uses the incorrect transaction isolation level after you change the transaction isolation level for the cursor in SQL Server 2005]:http://support.microsoft.com/kb/940378
[940269 FIX: Error message when you try to edit a SQL Server Agent job or a maintenance plan by using SQL Server Management Studio in SQL Server 2005: "String or binary data would be truncated"]:http://support.microsoft.com/kb/940269
[940945 FIX: Performance is very slow when the same stored procedure is executed at the same time in many connections on a multiple-processor computer that is running SQL Server 2005]:http://support.microsoft.com/kb/940945
[940937 FIX: Error message when you try to update the index key columns of a non-unique clustered index in SQL Server 2005: "Cannot insert duplicate key row in object 'ObjectName' with unique index 'IndexName'"]:http://support.microsoft.com/kb/940937
[940379 FIX: Error message when you use the UNLOAD and REWIND options to back up a database to a tape device in SQL Server 2005: "Operation on device '<TapeDevice>' exceeded retry count"]:http://support.microsoft.com/kb/940379
[940375 FIX: Error message when you use the Copy Database Wizard to move a database from SQL Server 2000 to SQL Server 2005]:http://support.microsoft.com/kb/940375
[937100 FIX: Error message when you run a SQL Server 2005 Integration Services package that contains a Script Component transformation:"Insufficient memory to continue the execution of the program"]:http://support.microsoft.com/kb/937100
[940126 FIX: Error 9003 is logged in the SQL Server error log file when you use log shipping in SQL Server 2005]:http://support.microsoft.com/kb/940126
[938363 FIX: Data is not replicated to a subscriber in a different partition by using parameterized row filters in SQL Server 2005]:http://support.microsoft.com/kb/938363
[940935 FIX: Error message when you run a query that is associated with a parallel execution plan in SQL Server 2005: "SQL Server Assertion: File: <lckmgr.cpp>, line=10850 Failed Assertion = 'GetLocalLockPartition () == xactLockInfo->GetLocalLockPartition ()'"]:http://support.microsoft.com/kb/940935
[940221 FIX: Error message when you try to create an Oracle publication by using the New Publication Wizard in SQL Server 2005 Service Pack 2: "OLE DB Provider 'OraOLEDB.ORACLE' for Linked server <LinkedServerName> returned message"]:http://support.microsoft.com/kb/940221
[940942 FIX: Error message when you run a stored procedure that references tables after you upgrade a database from SQL Server 2000 to SQL Server 2005: "A time-out occurred while waiting for buffer latch"]:http://support.microsoft.com/kb/940942
[940384 FIX: You receive a System.InvalidCastException exception when you run an application that calls the Server.JobServer.Jobs.Contains method on a computer that has SQL Server 2005 Service Pack 2 installed]:http://support.microsoft.com/kb/940384
[940281 FIX: An access violation may occur, and you may receive an error message, when you query the sys.dm_exe_sessions dynamic management view in SQL Server 2005]:http://support.microsoft.com/kb/940281
[940545 FIX: The performance of insert operations against a table that contains an identity column may be slow in SQL Server 2005]:http://support.microsoft.com/kb/940545
[940210 FIX: Error message when you try to insert more than 3 megabytes of data into a distributed partitioned view in SQL Server 2005: "A system assertion check has failed"]:http://support.microsoft.com/kb/940210
[939537 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 2]:http://support.microsoft.com/kb/939537
[940128 FIX: You receive error 8623 when you run a complex query in SQL Server 2005]:http://support.microsoft.com/kb/940128
[938243 FIX: Error message when you run a full-text query against a catalog in SQL Server 2005: "The execution of a full-text query failed. The content index is corrupt."]:http://support.microsoft.com/kb/938243
[938086 FIX: A SQL Server Agent job fails when you run the SQL Server Agent job in the context of a proxy account in SQL Server 2005]:http://support.microsoft.com/kb/938086
[939285 FIX: Error message when you run a stored procedure that starts a transaction that contains a Transact-SQL statement in SQL Server 2005: "New request is not allowed to start because it should come with valid transaction descriptor"]:http://support.microsoft.com/kb/939285
[939562 FIX: Error message when you run a query that fires an INSTEAD OF trigger in SQL Server 2005 Service Pack 2: "Internal Query Processor Error The query processor could not produce a query plan"]:http://support.microsoft.com/kb/939562
[939563 FIX: Error message when you synchronize a merge replication in Microsoft SQL Server 2005: "MSmerge_del_<GUID>, Line 42 String or binary data would be truncated"]:http://support.microsoft.com/kb/939563
[936534 FIX: Error message when the Distribution Agent tries to apply the snapshot to the subscriber in SQL Server 2005: "Must declare the scalar variable "@Variable""]:http://support.microsoft.com/kb/936534
[938671 FIX: The Distribution Agent may skip some rows when you configure a transactional replication that uses the "-SkipErrors" parameter in SQL Server 2005]:http://support.microsoft.com/kb/938671
[936488 The service pack update or hotfix installation stops unexpectedly when you try to install either Microsoft SQL Server 2005 Service Pack 2 or a hotfix for SQL Server 2005 SP2]:http://support.microsoft.com/kb/936488
[938825 FIX: A foreign key constraint that you drop on a table at the publisher is not dropped on the table at the subscriber in a SQL Server 2005 merge replication]:http://support.microsoft.com/kb/938825
[936305 Cumulative update package 2 (CU2 build 3175) for SQL Server 2005 Service Pack 2 is available]:http://support.microsoft.com/kb/936305
[937745 FIX: You may receive error messages when you try to log in to an instance of SQL Server 2005 and SQL Server handles many concurrent connections]:http://support.microsoft.com/kb/937745
[937033 FIX: Error message when you run a linked server query in SQL Server 2005: "The oledbprovider unisys.dmsII.1 for linkserver '<ServerName>' reported an error the provider ran out of memory"]:http://support.microsoft.com/kb/937033
[937041 FIX: Changes in the publisher database are not replicated to the subscribers in a transactional replication if the publisher database runs exposed in a database mirroring session in SQL Server 2005]:http://support.microsoft.com/kb/937041
[936185 FIX: Blocking and performance problems may occur when you enable trace flag 1118 in SQL Server 2005 if the temporary table creation workload is high]:http://support.microsoft.com/kb/936185
[934734 FIX: A database is marked as suspect when you update a table that contains a nonclustered index in SQL Server 2005]:http://support.microsoft.com/kb/934734
[935789 FIX: On a computer that is running SQL Server 2005 and that has multiple processors, you may receive incorrect results when you run a query that contains an inner join]:http://support.microsoft.com/kb/935789
[934706 FIX: Error message when you perform a piecemeal restore operation after you enable vardecimal database compression in SQL Server 2005 Service Pack 2: "Piecemeal restore is not supported when an upgrade is involved"]:http://support.microsoft.com/kb/934706
[933724 FIX: The query performance is slow when you run a query that uses a user-defined scalar function against an instance of SQL Server 2005]:http://support.microsoft.com/kb/933724
[935356 Cumulative update package (CU1 build 3161) for SQL Server 2005 Service Pack 2 is available]:http://support.microsoft.com/kb/935356
[934459 FIX: The Check Database Integrity task and the Execute T-SQL Statement task in a maintenance plan may lose database context in certain circumstances in SQL Server 2005 builds 3150 through 3158]:http://support.microsoft.com/kb/934459
[934226 FIX: Error message when you try to use Database Mail to send an e-mail message in SQL Server 2005: "profile name is not valid (Microsoft SQL Server, Error 14607)"]:http://support.microsoft.com/kb/934226
[933808 FIX: Error message when you run a query that contains nested FOR XML clauses in SQL Server 2005: "The XML data type is damaged"]:http://support.microsoft.com/kb/933808
[933499 FIX: Error message when you use transactional replication to replicate the execution of stored procedures to subscribers in SQL Server 2005: "Insufficient memory to run query"]:http://support.microsoft.com/kb/933499
[933766 FIX: Failed assertion message in the Errorlog file when you perform various operations in SQL Server 2005: "Failed Assertion = 'fFalse' Attempt to access expired blob handle (3)"]:http://support.microsoft.com/kb/933766
[933549 FIX: You may receive an access violation when you perform a bulk copy operation in SQL Server 2005]:http://support.microsoft.com/kb/933549
[934188 FIX: The Distribution Agent does not deliver commands to the Subscriber even if the Distribution Agent is running in SQL Server 2005]:http://support.microsoft.com/kb/934188
[934109 FIX: The Distribution Agent generates an access violation when you configure a transactional replication publication to run an additional script after the snapshot is applied at the subscriber in SQL Server 2005]:http://support.microsoft.com/kb/934109
[934106 FIX: SQL Server 2005 database engine generates failed assertion errors when you use the Replication Monitor to monitor the distribution database]:http://support.microsoft.com/kb/934106
[933564 FIX: A gradual increase in memory consumption for the USERSTORE_TOKENPERM cache store occurs in SQL Server 2005]:http://support.microsoft.com/kb/933564
[933097 Cumulative hotfix package (build 3152) for SQL Server 2005 Service Pack 2 is available]:http://support.microsoft.com/kb/933097
[970895 MS09-062: Description of the security update for GDI+ for SQL Server 2005 Service Pack 2 GDR: October 13, 2009]:http://support.microsoft.com/kb/970895
[960089 MS09-004: Description of the security update for SQL Server 2005 GDR: February 10, 2009]:http://support.microsoft.com/kb/960089
[954606 MS08-052: Description of the security update for GDI+ for SQL Server 2005 Service Pack 2 GDR: September 9, 2008]:http://support.microsoft.com/kb/954606
[941203 MS08-040: Vulnerabilities in Microsoft SQL Server could allow elevation of privilege]:http://support.microsoft.com/kb/941203
[934458 FIX: The Check Database Integrity task and the Execute T-SQL Statement task in a maintenance plan may lose database context in certain circumstances in SQL Server 2005 builds 3042 through 3053]:http://support.microsoft.com/kb/934458
[933508 Microsoft SQL Server 2005 Service Pack 2 issue: Cleanup tasks run at different intervals than intended]:http://support.microsoft.com/kb/933508
[SQL Server 2005 Service Pack 2 (SP2)]:http://www.microsoft.com/downloads/details.aspx?FamilyId=d07219b2-1e23-49c8-8f0c-63fa18f26d3a
[929376 FIX: A "17187" error message may be logged in the Errorlog file when an instance of SQL Server 2005 is under a heavy load]:http://support.microsoft.com/kb/929376
[940961 FIX: Transactions that are being committed on the principal server may not be copied to the mirror server when a database mirroring failover occurs in SQL Server 2005]:http://support.microsoft.com/kb/940961
[940719 FIX: A memory leak occurs when you call the Initialize method and the Terminate method of the SQLDistribution object in a loop in an application that you develop by using Microsoft ActiveX replication controls in SQL Server 2005]:http://support.microsoft.com/kb/940719
[940287 FIX: Error message when you use Service Broker in SQL Server 2005: "An error occurred while receiving data: '64(The specified network name is no longer available.)'"]:http://support.microsoft.com/kb/940287
[940286 FIX: A Service Broker endpoint stops passing messages in a database mirroring session of SQL Server 2005]:http://support.microsoft.com/kb/940286
[937343 FIX: SQL Server 2005 stops and then restarts unexpectedly and errors occur in the tempdb database]:http://support.microsoft.com/kb/937343
[937545 FIX: Error message when you use the BULK INSERT statement to import a data file into a table in SQL Server 2005 with SP1: "The OLE DB provider "BULK" for linked server "(null)" reported an error"]:http://support.microsoft.com/kb/937545
[933499 FIX: Error message when you use transactional replication to replicate the execution of stored procedures to subscribers in SQL Server 2005: "Insufficient memory to run query"]:https://support.microsoft.com/en-us/kb/933499
[937544 FIX: You may receive error 3456 when you try to restore a transaction log for a SQL Server 2005 database]:http://support.microsoft.com/kb/937544
[937277 FIX: A memory leak occurs when you use the sp_OAMethod stored procedure to call a method of a COM object in SQL Server 2005]:http://support.microsoft.com/kb/937277
[934812 FIX: You cannot bring the SQL Server group online in a cluster environment after you rename the virtual server name of the default instance of SQL Server 2005]:http://support.microsoft.com/kb/934812
[936179 FIX: Error message when you use SQL Native Client to connect to an instance of a principal server in a database mirroring session: "The connection attempted to fail over to a server that does not have a failover partner"]:http://support.microsoft.com/kb/936179
[935446 FIX: You receive error messages when you use the BULK INSERT statement in SQL Server 2005 to import data in bulk]:http://support.microsoft.com/kb/935446
[933265 FIX: You may receive error 1203 when you run an INSERT statement against a table that has an identity column in SQL Server 2005]:http://support.microsoft.com/kb/933265
[934065 FIX: Error message when the Replication Merge Agent runs to synchronize a merge replication subscription in SQL Server 2005: "The merge process failed to execute a query because the query timed out"]:http://support.microsoft.com/kb/934065
[933762 FIX: You receive error 18815 when the Log Reader Agent runs for a transactional publication in SQL Server 2005]:http://support.microsoft.com/kb/933762
[932393 FIX: You may experience poor performance after you install SQL Server 2005 Service Pack 1]:http://support.microsoft.com/kb/932393
[931593 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 2153 and later builds]:http://support.microsoft.com/kb/931593
[932115 FIX: The ghost row clean-up thread does not remove ghost rows on some data files of a database in SQL Server 2005]:http://support.microsoft.com/kb/932115
[931843 FIX: SQL Server 2005 does not reclaim the disk space that is allocated to the temporary table if the stored procedure is stopped]:http://support.microsoft.com/kb/931843
[931821 FIX: High CPU utilization by SQL Server 2005 may occur when you use NUMA architecture on a computer that has an x64-based version of SQL Server 2005 installed]:http://support.microsoft.com/kb/931821
[930505 FIX: Error message when you run DML statements against a table that is published for merge replication in SQL Server 2005: "Could not find stored procedure"]:http://support.microsoft.com/kb/930505
[929240 FIX: I/O requests that are generated by the checkpoint process may cause I/O bottlenecks if the I/O subsystem is not fast enough to sustain the IO requests in SQL Server 2005]:http://support.microsoft.com/kb/929240
[930284 FIX: You receive error 1456 when you try to add a witness to a DBM session in SQL Server 2005]:http://support.microsoft.com/kb/930284
[930283 FIX: You receive error 1456 when you add a witness to a database mirroring session and the database name is the same as an existing database mirroring session in SQL Server 2005]:http://support.microsoft.com/kb/930283
[929278 FIX: SQL Server 2005 may not perform histogram amendments when you use trace flags 2389 and 2390]:http://support.microsoft.com/kb/929278
[929179 FIX: A memory leak may occur every time that you synchronize a SQL Server Mobile subscriber in SQL Server 2005]:http://support.microsoft.com/kb/929179
[928394 FIX: The changes are not reflected in the publication database after you reinitialize the subscriptions in SQL Server 2005]:http://support.microsoft.com/kb/928394
[928372 FIX: Error message when you use a synonym for a stored procedure in SQL Server 2005: "A severe error occurred on the current command"]:http://support.microsoft.com/kb/928372
[928789 FIX: Error message in the database mail log when you try to use the sp_send_dbmail stored procedure to send an e-mail in SQL Server 2005: "Invalid XML message format received on the ExternalMailQueue"]:http://support.microsoft.com/kb/928789
[928083 FIX: You may receive an error message when you run a CLR stored procedure or CLR function that uses a context connection in SQL Server 2005]:http://support.microsoft.com/kb/928083
[928537 FIX: The full-text index population for the indexed view is very slow in SQL Server 2005]:http://support.microsoft.com/kb/928537
[926493 FIX: Error message when you restore a transaction-log backup that is generated in SQL Server 2000 SP4 to an instance of SQL Server 2005: Msg 3456, Level 16, State 1, Line 1. Could not redo log record"]:http://support.microsoft.com/kb/926493
[928539 FIX: An access violation is logged in the SQL Server Errorlog file when you run a query that uses a plan guide in SQL Server 2005]:http://support.microsoft.com/kb/928539
[927643 FIX: Some search results are missing when you perform a full-text search operation on a Windows SharePoint Services 2.0 site after you upgrade to SQL Server 2005]:http://support.microsoft.com/kb/927643
[927289 FIX: Updates to the SQL Server Mobile subscriber may not be reflected in the SQL Server 2005 merge publication]:http://support.microsoft.com/kb/927289
[926613 FIX: You may receive incorrect results when you query a table that is published in a transactional replication in SQL Server 2005]:http://support.microsoft.com/kb/926613
[926106 FIX: You receive an error message when you use the Print Preview option on a large report in SQL Server 2005 Reporting Services]:http://support.microsoft.com/kb/926106
[924807 FIX: The restore operation may take a long time to finish when you restore a database in SQL Server 2005]:http://support.microsoft.com/kb/924807
[924264 FIX: The metadata of the Description object of a Key Performance Indicator appears in the default language after you define a translation for the Description object in SQL Server 2005 Business Intelligence Development Studio]:http://support.microsoft.com/kb/924264
[926612 FIX: SQL Server Agent does not send an alert quickly or does not send an alert when you use an alert of the SQL Server event alert type in SQL Server 2005]:http://support.microsoft.com/kb/926612
[926773 FIX: Error message when you run a query that uses a fast forward-only cursor in SQL Server 2005: "Query processor could not produce a query plan because of the hints defined in this query"]:http://support.microsoft.com/kb/926773
[926611 FIX: SQL Server 2005 may not send a message notification that is based on the specific string in the forwarded event when a computer that is running SQL Server 2000 forwards an event to a computer that is running SQL Server 2005]:http://support.microsoft.com/kb/926611
[924808 FIX: You receive an error message, or you obtain an incorrect result when you query data in a partitioned table that does not have a clustered index in SQL Server 2005]:http://support.microsoft.com/kb/924808
[925277 FIX: You may experience very large growth increments of a principal database after you manually fail over a database mirroring session in SQL Server 2005]:http://support.microsoft.com/kb/925277
[926285 Fix: Error message when you convert a column from the varbinary(max) data type to the XML data type in SQL Server 2005: "Msg 6322, Level 16, State 1, Line 2 Too many attributes or namespace definitions"]:http://support.microsoft.com/kb/926285
[926335 FIX: Error message when you trace the Audit Database Management event and you try to bring a database online in SQL Server 2005: “Msg 942, Level 14, State 4, Line 1”]:http://support.microsoft.com/kb/926335
[926240 FIX: SQL Server 2005 may stop responding when you use the SqlBulkCopy class to import data from another data source]:http://support.microsoft.com/kb/926240
[925744 FIX: Error message when you try to use a SQL Server authenticated login to log on to an instance of SQL Server 2005: "Logon error: 18456"]:http://support.microsoft.com/kb/925744
[924954 FIX: Error message when you use a table-valued function (TVF) together with the CROSS APPLY operator in a query in SQL Server 2005: "There is insufficient system memory to run this query"]:http://support.microsoft.com/kb/924954
[925335 FIX: Error message when you use a label after a Transact-SQL query in SQL Server 2005: "Incorrect syntax near 'X'"]:http://support.microsoft.com/kb/925335
[925135 FIX: An empty string is replicated as a NULL value when you synchronize a table to a SQL Server 2005 Compact Edition subscriber]:http://support.microsoft.com/kb/925135
[925227 FIX: Error message when you call the SQLTables function against an instance of SQL Server 2005: "Invalid cursor state (0)"]:http://support.microsoft.com/kb/925227
[925153 FIX: You may receive different date values for each row when you use the getdate function within a case statement in SQL Server 2005]:http://support.microsoft.com/kb/925153
[923849 FIX: When you run a query that references a partitioned table in SQL Server 2005, query performance may decrease]:http://support.microsoft.com/kb/923849
[923605 FIX: A deadlock occurs and a query never finishes when you run the query on a computer that is running SQL Server 2005 and has multiple processors]:http://support.microsoft.com/kb/923605
[923624 FIX: Error message when you run an application against SQL Server 2005 that uses many unique user logins or performs many user login impersonations: "insufficient system memory to run this query"]:http://support.microsoft.com/kb/923624
[922594 FIX: Error message when you use SQL Server 2005: "High priority system task thread Operating system error Exception 0xAE encountered"]:http://support.microsoft.com/kb/922594
[923296 FIX: Log Reader Agent fails, and an assertion error message is logged when you use transactional replication in SQL Server 2005]:http://support.microsoft.com/kb/923296
[921395 FIX: The color and the background image may not appear when you try to display a report in HTML format in Report Manager in SQL Server 2005 Reporting Services]:http://support.microsoft.com/kb/921395
[917905 FIX: SQL Server 2005 performance may be slower than SQL Server 2000 performance when you use an API server cursor]:http://support.microsoft.com/kb/917905
[922578 FIX: In SQL Server 2005, the sp_altermessage stored procedure does not suppress system error messages that are logged in the SQL Server error log and in the Application log]:http://support.microsoft.com/kb/922578
[922438 FIX: A query may take a long time to compile when the query contains several JOIN clauses against a SQL Server 2005 database]:http://support.microsoft.com/kb/922438
[921536 FIX: A handled access violation may occur in the CValSwitch::GetDataX function when you run a complex query in SQL Server 2005]:http://support.microsoft.com/kb/921536
[922063 FIX: You may notice a large increase in compile time when you enable trace flags 2389 and 2390 in SQL Server 2005 Service Pack 1]:http://support.microsoft.com/kb/922063
[920974 FIX: SQL Server 2005 treats an identity column in a view as an ordinary int column when the compatibility level of the database is set to 80]:http://support.microsoft.com/kb/920974
[919243 FIX: Some rows in the Text Data column are always displayed for a trace that you create by using SQL Server Profiler in SQL Server 2005]:http://support.microsoft.com/kb/919243
[920346 FIX: SQL Server 2005 may overestimate the cardinality of the JOIN operator when a SQL Server 2005 query contains a join predicate that is a multicolumn predicate]:http://support.microsoft.com/kb/920346
[920347 FIX: The SQL Server 2005 query optimizer may incorrectly estimate the cardinality for a query that has a predicate that contains an index union alternative]:http://support.microsoft.com/kb/920347
[919929 FIX: Error message when the Replication Merge Agent runs in SQL Server 2005: "Source: MSSQL_REPL, Error number: MSSQL_REPL-2147199402"]:http://support.microsoft.com/kb/919929
[921003 FIX: You may receive an error message when you manually define a Back Up Database task in SQL Server 2005 to back up the transaction log]:http://support.microsoft.com/kb/921003
[920206 FIX: System performance may be slow when an application submits many queries against a SQL Server 2005 database that uses simple parameterization]:http://support.microsoft.com/kb/920206
[918882 FIX: A query plan is not cached in SQL Server 2005 when the text of the hint is a large object]:http://support.microsoft.com/kb/918882
[919636 FIX: Memory usage of the compiled query plan may unexpectedly increase in SQL Server 2005]:http://support.microsoft.com/kb/919636
[919775 FIX: The BULK INSERT statement may not return any errors when you try to import data from a text file to a table by using the BULK INSERT statement in Microsoft SQL Server 2005]:http://support.microsoft.com/kb/919775
[919611 FIX: The value of the automatic growth increment of a database file may be very large in SQL Server 2005 with Service Pack 1]:http://support.microsoft.com/kb/919611
[918222 Cumulative hotfix package (build 2153) for SQL Server 2005 is available]:http://support.microsoft.com/kb/918222
[919224 FIX: You may receive an error message when you install the cumulative hotfix package (build 2153) for SQL Server 2005]:http://support.microsoft.com/kb/919224
[932555 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 2047]:http://support.microsoft.com/kb/932555
[SQL Server 2005 Service Pack 1 (SP1)]:http://www.microsoft.com/downloads/details.aspx?FamilyID=CB6C71EA-D649-47FF-9176-E7CAC58FD4BC
[932556 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 1500 and later builds]:http://support.microsoft.com/kb/932556
[926493 FIX: Error message when you restore a transaction-log backup that is generated in SQL Server 2000 SP4 to an instance of SQL Server 2005: "Msg 3456, Level 16, State 1, Line 1. Could not redo log record"]:https://support.microsoft.com/en-us/kb/926493
[926292 FIX: When you query through a view that uses the ORDER BY clause in SQL Server 2005, the result is still returned in random order]:http://support.microsoft.com/kb/926292
[922527 FIX: Error message when you schedule some SQL Server 2005 Integration Services packages to run as jobs: "Package <PackageName> has been cancelled"]:http://support.microsoft.com/kb/922527
[922804 FIX: After you detach a Microsoft SQL Server 2005 database that resides on network-attached storage, you cannot reattach the SQL Server database]:http://support.microsoft.com/kb/922804
[917887 FIX: The value of the automatic growth increment of a database file may be very large in SQL Server 2005]:http://support.microsoft.com/kb/917887
[921106 FIX: You receive an error message when you try to create a differential database backup in SQL Server 2005]:http://support.microsoft.com/kb/921106
[918276 FIX: You notice additional random trailing character in values when you retrieve the values from a fixed-size character column or a fixed-size binary column of a table in SQL Server 2005]:http://support.microsoft.com/kb/918276
[917905 FIX: SQL Server 2005 performance may be slower than SQL Server 2000 performance when you use an API server cursor]:http://support.microsoft.com/kb/917905
[917888 FIX: Error message when you use a server-side cursor to run a large complex query in SQL Server 2005: "Error: 8623, Severity: 16, State: 1 The query processor ran out of internal resources"]:http://support.microsoft.com/kb/917888
[917971 FIX: You may receive more than 100,000 page faults when you try to back up a SQL Server 2005 database that contains hundreds of files and file groups]:http://support.microsoft.com/kb/917971
[917738 FIX: SQL Server 2005 system performance may be slow when you use a keyset-driven cursor to execute a FETCH statement]:http://support.microsoft.com/kb/917738
[917824 FIX: The SQL Server 2005 SqlCommandBuilder.DeriveParameters method returns an exception when the input parameter is a XML parameter that has an associated XSD from an SQL schema]:http://support.microsoft.com/kb/917824
[917016 FIX: The monitor server does not monitor all primary servers and secondary servers when you configure log shipping in SQL Server 2005]:http://support.microsoft.com/kb/917016
[916706 FIX: When you run the "dbcc dbreindex" command or the "alter index" command, some transactions are not replicated to the subscribers in a transactional replication in SQL Server 2005]:http://support.microsoft.com/kb/916706
[916086 FIX: Errors may be generated in the tempdb database when you create and then drop many temporary tables in SQL Server 2005]:http://support.microsoft.com/kb/916086
[916046 FIX: Indexes may grow very large when you insert a row into a table and then update the same row in SQL Server 2005]:http://support.microsoft.com/kb/916046
[915918 FIX: The internal deadlock monitor may not detect a deadlock between two or more sessions in SQL Server 2005]:http://support.microsoft.com/kb/915918
[915309 FIX: When you start a merge agent, synchronization between the subscriber and the publisher takes a long time to be completed in SQL Server 2005]:http://support.microsoft.com/kb/915309
[915308 FIX: The CPU usage of the server reaches 100% when many DML activities occur in SQL Server 2005]:http://support.microsoft.com/kb/915308
[915307 FIX: You experience a slow uploading process if conflicts occur when many merge agents upload changes to the publishers at the same time in SQL Server 2005]:http://support.microsoft.com/kb/915307
[915306 FIX: The merge agent fails and a "permission denied" error message is logged when you synchronize a SQL Server 2005-based merge publication]:http://support.microsoft.com/kb/915306
[915112 FIX: Error message when an ADO.NET-connected application tries to reuse a connection from the connection pool in SQL Server 2005: "The request failed to run because the batch is aborted"]:http://support.microsoft.com/kb/915112
[913494 FIX: The merge agent does not use a specified custom user update to handle conflicting UPDATE statements in SQL Server 2005]:http://support.microsoft.com/kb/913494
[913941 FIX: A SQL Server login may have more permissions when you log on to an instance of SQL Server 2005]:http://support.microsoft.com/kb/913941
[912472 FIX: An incorrect result may appear in the subscribing database when you set database mirroring for a database and database failover occurs in SQL Server 2005]:http://support.microsoft.com/kb/912472
[913371 FIX: You may receive error messages when you use the sp_cursoropen statement to open a cursor on a user-defined stored procedure in SQL Server 2005]:http://support.microsoft.com/kb/913371
[912471 FIX: The replication on the server does not work any longer when you manually fail over databases in SQL Server 2005]:http://support.microsoft.com/kb/912471
[911662 FIX: You may receive an access violation error message when you run a SELECT query in SQL Server 2005]:http://support.microsoft.com/kb/911662
[915793 FIX: You cannot restore the log backups on the mirror server after you remove database mirroring for the mirror database in SQL Server 2005]:http://support.microsoft.com/kb/915793
[910416 FIX: Error message when you run certain queries or certain stored procedures in SQL Server 2005: "A severe error occurred on the current command"]:http://support.microsoft.com/kb/910416
[932557 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 1399]:http://support.microsoft.com/kb/932557
