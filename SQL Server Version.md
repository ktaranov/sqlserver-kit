# Microsoft SQL Server version
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

| Version | Latest Update                               | Build Number | Support Ends | Other Updates             |
|---------|---------------------------------------------|--------------|--------------|---------------------------|
| 2014    | [Download SP1 2014] then [CU3 KB3094221]    | 12.00.4425   | 2024-07-09   | Other SQL 2014 Updates    |
| 2012    | [Download SP2 2012] then [CU8 KB3082561]    | 11.00.5634   | 2022-07-12   | Other SQL 2012 Updates    |
| 2008 R2 | [Download SP3 2008 R2] then [SU KB3045311]  | 10.50.6000   | 2019-07-09   | Other SQL 2008 R2 Updates |
| 2008    | [Download SP4 2008] then [SU KB3045316]     | 10.00.6000   | 2019-07-09   | Other SQL 2008 Updates    |
| 2005    | [Download SP4 2005] then [CU3 2507769]      | 9.00.5266    | 2016-04-12   |                           |

[Download SP1 2014]:http://www.microsoft.com/en-us/download/details.aspx?id=46694&WT.mc_id=rss_alldownloads_all
[CU3 KB3094221]:https://support.microsoft.com/en-us/kb/3094221
[Download SP2 2012]:http://www.microsoft.com/en-us/download/details.aspx?id=43340
[CU8 KB3082561]:https://support.microsoft.com/en-us/kb/3082561
[Download SP3 2008 R2]:http://www.microsoft.com/en-us/download/details.aspx?id=44271
[SU KB3045311]:https://www.microsoft.com/downloads/details.aspx?familyid=7af16cb8-c944-41cb-a897-c6fc373869cd
[Download SP4 2008]:http://www.microsoft.com/en-us/download/details.aspx?id=44278
[SU KB3045316]:https://www.microsoft.com/downloads/details.aspx?familyid=40328565-3067-4e36-96ba-26ade333d715
[Download SP4 2005]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=b953e84f-9307-405e-bceb-47bd345baece
[CU3 2507769]:http://support.microsoft.com/kb/2507769


## Internal Database Version and Compatibility Level

| SQL Server Version                           | Code Name            | Release Year | Internal Database Version | Database Compatibility Level |
|:---------------------------------------------|:---------------------|-------------:|--------------------------:|-----------------------------:|
| SQL Server 2016                              | ?                    | 2016         | 782                       | 120                          |
| SQL Server 2014                              | SQL14                | 2014         | 782                       | 120                          |
| SQL Server 2012                              | Denali               | 2012         | 706                       | 110                          |
| SQL Server 2012 CTP1                         |                      |              | 684                       | 110                          |
| SQL Server 2008 R2                           | Kilimanjaro (aka KJ) | 2010         | 660 / 661                 | 100                          |
| SQL Server 2008                              | Katmai               | 2008         | 655                       | 100                          |
| SQL Server 2005 SP2+ with VarDecimal enabled | ?                    | 2005         | 612                       |  90                          |
| SQL Server 2005                              | Yukon                | 2005         | 611                       |  90                          |
| SQL Server 2000                              | Shiloh               | 2000         | 539                       |  80                          |
| SQL Server 7.0                               | Sphinx               | 1998         | 515                       |  70                          |
| SQL Server 6.5                               | Hydra                | 1996         | 408                       |  65                          |
| SQL Server 6.0                               | SQL95                | 1995         | ?                         |  60                          |
| SQL Server 4.21                              | SQLNT                | 1993         | ?                         |  60                          |
| SQL Server 1.1 (16 bit)                      | ?                    | 1991         | ?                         |  60                          |
| SQL Server 1.0 (16 bit)                      | Ashton-Tate          | 1989         | ?                         |  60                          |


## Quick summary for Service Packs

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

| Build     | File version     | KB / Description                                                                                                                       | Release Date |
|-----------|------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 11.0.5636 | 2011.110.5636.3  | [3097636 FIX: Performance decrease when application with connection pooling frequently connects or disconnects in SQL Server]          | 2015-09-22   |
| 11.0.5634 | 2011.110.5634.0  | [3082561 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 2]                                                         | 2015-09-21   |
| 11.0.5629 | 2011.110.5629.0  | [3087872 FIX: Access violations when you use the FileTable feature in SQL Server 2012]                                                 | 2015-08-31   |
| 11.0.5623 | 2011.110.5623.0  | [3072100 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 2]                                                         | 2015-07-20   |
| 11.0.5613 | 2011.110.5613.0  | [3045319 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 QFE: July 14, 2015]                           | 2015-07-14   |
| 11.0.5592 | 2011.110.5592.0  | [3052468 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 2]                                                         | 2015-05-19   |
| 11.0.5582 | 2011.110.5582.0  | [3037255 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 2]                                                         | 2015-03-16   |
| 11.0.5571 | 2011.110.5571.0  | [3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]                                                          | 2015-05-15   |
| 11.0.5569 | 2011.110.5569.0  | [3007556 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 2]                                                         | 2015-01-20   |
| 11.0.5556 | 2011.110.5556.0  | [3002049 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 2]                                                         | 2014-11-17   |
| 11.0.5548 | 2011.110.5548.0  | [2983175 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 2]                                                         | 2014-09-15   |
| 11.0.5532 | 2011.110.5532.0  | [2976982 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 2]                                                         | 2014-07-24   |
| 11.0.5522 | 2011.110.5522.0  | [2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP2)]         | 2014-06-20   |
| 11.0.5343 | 2011.110.5343.0  | [3045321 MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015]                           | 2015-07-14   |
| 11.0.5058 | 2011.110.5058.0  | [SQL Server 2012 Service Pack 2 (SP2)]                                                                                                 | 2014-06-10   |
| 11.0.3513 | 2011.110.3513.0  | [3045317 MS15-058: Description of the security update for SQL Server 2012 SP1 QFE: July 14, 2015]                                      | 2015-07-14   |
| 11.0.3492 | 2011.110.3492.0  | [3052476 Cumulative update package 16 (CU16) for SQL Server 2012 Service Pack 1]                                                       | 2015-05-18   |
| 11.0.3487 | 2011.110.3487.0  | [3038001 Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 1]                                                       | 2015-03-16   |
| 11.0.3486 | 2011.110.3486.0  | [3023636 Cumulative update package 14 (CU14) for SQL Server 2012 Service Pack 1]                                                       | 2015-01-19   |
| 11.0.3460 | 2011.110.3460.0  | [2977325 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (QFE)]                                        | 2014-08-12   |
| 11.0.3482 | 2011.110.3482.0  | [3002044 Cumulative update package 13 (CU13) for SQL Server 2012 Service Pack 1]                                                       | 2014-11-17   |
| 11.0.3470 | 2011.110.3470.0  | [2991533 Cumulative update package 12 (CU12) for SQL Server 2012 Service Pack 1]                                                       | 2014-09-15   |
| 11.0.3449 | 2011.110.3449.0  | [2975396 Cumulative update package 11 (CU11) for SQL Server 2012 Service Pack 1]                                                       | 2014-07-21   |
| 11.0.3437 | 2011.110.3437.0  | [2969896 FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP1)]         | 2014-06-10   |
| 11.0.3431 | 2011.110.3431.0  | [2954099 Cumulative update package 10 (CU10) for SQL Server 2012 Service Pack 1]                                                       | 2014-05-19   |
| 11.0.3412 | 2011.110.3412.0  | [2931078 Cumulative update package 9 (CU9) for SQL Server 2012 Service Pack 1]                                                         | 2014-03-18   |
| 11.0.3401 | 2011.110.3401.0  | [2917531 Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 1]                                                         | 2014-01-20   |
| 11.0.3393 | 2011.110.3393.0  | [2894115 Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 1]                                                         | 2013-11-18   |
| 11.0.3381 | 2011.110.3381.0  | [2874879 Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 1]                                                         | 2013-09-16   |
| 11.0.3373 | 2011.110.3373.0  | [2861107 Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 1]                                                         | 2013-07-16   |
| 11.0.3368 | 2011.110.3368.0  | [2833645 Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 1]                                                         | 2013-05-31   |
| 11.0.3350 | 2011.110.3350.0  | [2832017 FIX: You can’t create or open SSIS projects or maintenance plans after you apply Cumulative Update 3 for SQL Server 2012 SP1] | 2013-04-17   |
| 11.0.3349 | 2011.110.3349.0  | [2812412 Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 1]                                                         | 2013-03-18   |
| 11.0.3339 | 2011.110.3339.0  | [2790947 Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 1]                                                         | 2013-01-25   |
| 11.0.3335 | 2011.110.3335.0  | [2800050 FIX: Component installation process fails after you install SQL Server 2012 SP1]                                              | 2013-01-14   |
| 11.0.3321 | 2011.110.3321.0  | [2765331 Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 1]                                                         | 2012-11-20   |
| 11.0.3156 | 2011.110.3156.0  | [3045318 MS15-058: Description of the security update for SQL Server 2012 SP1 GDR: July 14, 2015]                                      | 2015-07-14   |
| 11.0.3153 | 2011.110.3153.0  | [2977326 MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (GDR)]                                        | 2014-08-12   |
| 11.0.3128 | 2011.110.3128.0  | [2793634 Windows Installer starts repeatedly after you install SQL Server 2012 SP1]                                                    | 2013-01-03   |
| 11.0.3000 | 2011.110.3000.0  | [SQL Server 2012 Service Pack 1 (SP1)]                                                                                                 | 2012-11-06   |
| 11.0.2845 | 2011.110.2845.0  | [SQL Server 2012 Service Pack 1 Customer Technology Preview 4 (CTP4)                                                                   | 2012-09-20   |
| 11.0.2809 | 2011.110.2809.24 | [SQL Server 2012 Service Pack 1 Customer Technology Preview 3 (CTP3)                                                                   | 2012-07-05   |
| 11.0.2424 | 2011.110.2424.0  | [2908007 Cumulative update package 11 (CU11) for SQL Server 2012]                                                                      | 2013-12-17   |
| 11.0.2420 | 2011.110.2420.0  | [2891666 Cumulative update package 10 (CU10) for SQL Server 2012]                                                                      | 2013-10-21   |
| 11.0.2419 | 2011.110.2419.0  | [2867319 Cumulative update package 9 (CU9) for SQL Server 2012]                                                                        | 2013-08-21   |
| 11.0.2410 | 2011.110.2410.0  | [2844205 Cumulative update package 8 (CU8) for SQL Server 2012]                                                                        | 2013-06-18   |
| 11.0.2405 | 2011.110.2405.0  | [2823247 Cumulative update package 7 (CU7) for SQL Server 2012]                                                                        | 2013-04-15   |
| 11.0.2401 | 2011.110.2401.0  | [2728897 Cumulative update package 6 (CU6) for SQL Server 2012]                                                                        | 2013-02-18   |
| 11.0.2395 | 2011.110.2395.0  | [2777772 Cumulative update package 5 (CU5) for SQL Server 2012]                                                                        | 2012-12-18   |
| 11.0.9000 | 2011.110.9000.5  | [Microsoft SQL Server 2012 With Power View For Multidimensional Models Customer Technology Preview (CTP3)                              | 2012-11-27   |
| 11.0.2383 | 2011.110.2383.0  | [2758687 Cumulative update package 4 (CU4) for SQL Server 2012]                                                                        | 2012-10-18   |
| 11.0.2376 | 2011.110.2376.0  | [Microsoft Security Bulletin MS12-070]                                                                                                 | 2012-10-09   |
| 11.0.2332 | 2011.110.2332.0  | [2723749 Cumulative update package 3 (CU3) for SQL Server 2012]                                                                        | 2012-08-29   |
| 11.0.2325 | 2011.110.2325.0  | [2703275 Cumulative update package 2 (CU2) for SQL Server 2012]                                                                        | 2012-06-18   |
| 11.0.2316 | 2011.110.2316.0  | [2679368 Cumulative update package 1 (CU1) for SQL Server 2012]                                                                        | 2012-04-12   |
| 11.0.2218 | 2011.110.2218.0  | [Microsoft Security Bulletin MS12-070]                                                                                                 | 2012-10-09   |
| 11.0.2214 | 2011.110.2214.0  | 2685308 FIX: SSAS uses only 20 cores in SQL Server 2012 Business Intelligence                                                          | 2012-04-06   |
| 11.0.2100 | 2011.110.2100.60 | SQL Server 2012 RTM                                                                                                                    | 2012-03-06   |
| 11.0.1913 | 2011.110.1913.37 | Microsoft SQL Server 2012 Release Candidate 1 (RC1)                                                                                    | 2011-12-16   |
| 11.0.1750 | 2011.110.1750.32 | Microsoft SQL Server 2012 Release Candidate 0 (RC0)                                                                                    | 2011-11-17   |
| 11.0.1440 | 2010.110.1440.19 | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 3 (CTP3)                                                      | 2011-07-11   |
| 11.0.1103 | 2010.110.1103.9  | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 1 (CTP1)                                                      | 2010-11-08   |


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
| 10.50.2500 | 2009.100.2500.0  | [SQL Server 2008 R2 Service Pack 1 (SP1)                                                                                                                                                      | 2011-07-11   |
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
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/en-us/security/bulletin/ms12-070
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
