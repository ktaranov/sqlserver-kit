# Microsoft SQL Server version
Source link:
 - Awesome unofficial build chart lists: <http://sqlserverbuilds.blogspot.ru/>
 - SQL Server Updates by Brent Ozar team: <http://sqlserverupdates.com/>

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


## Internal Database Version and Compatibility Level

| SQL Server Version                           | Internal Database Version | Database Compatibility Level |
|:---------------------------------------------|--------------------------:|-----------------------------:|
| SQL Server 2014                              | 782                       | 120                          |
| SQL Server 2012                              | 706                       | 110                          |
| SQL Server 2012 CTP1                         | 684                       | 110                          |
| SQL Server 2008 R2                           | 660 / 661                 | 100                          |
| SQL Server 2008                              | 655                       | 100                          |
| SQL Server 2005 SP2+ with VarDecimal enabled | 612                       | 90                           |
| SQL Server 2005                              | 611                       | 90                           |
| SQL Server 2000                              | 539                       | 80                           |
| SQL Server 7.0                               | 515                       | 70                           |
| SQL Server 6.5                               | 408                       | 65                           |
| SQL Server 6.0                               | ?                         | 60                           |
| SQL Server 4.21                              | ?                         | 60                           |


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


## Microsoft SQL Server 2016 Builds

| Build         | File version     | KB / Description                                                                | Release Date |
|---------------|------------------|---------------------------------------------------------------------------------|--------------|
| 13.00.700.139 | 2016.130.700.139 | [Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)]           | 2015-10-28   |
| 13.00.600.65  | 2016.130.600.65  | Microsoft SQL Server 2016 Community Technology Preview 2.4 (CTP2.4)             | 2015-09-30   |
| 13.00.500.53  | 2016.130.500.53  | Microsoft SQL Server 2016 Community Technology Preview 2.3 (CTP2.3)             | 2015-08-28   |
| 13.00.407.1   | 2016.130.407.1   | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2)             | 2015-07-23   |
| 13.00.400.91  | 2016.130.400.91  | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2) [withdrawn] | 2015-07-22   |
| 13.00.300.44  | 2016.130.300.444 | Microsoft SQL Server 2016 Community Technology Preview 2.1 (CTP2.1)             | 2015-06-24   |
| 13.00.200.172 | 2016.130.200.172 | Microsoft SQL Server 2016 Community Technology Preview 2 (CTP2)                 | 2015-05-27   |


## Microsoft SQL Server 2014 Builds

| Build      | File version     | KB / Description                                                                                                                 | Release Date |
|------------|------------------|----------------------------------------------------------------------------------------------------------------------------------|--------------|
| 12.00.4427 | 2014.120.4427.24 | 3094221 Cumulative update package 3 (CU3) for SQL Server 2014 Service Pack 1                                                     | 2015-10-21   |
| 12.00.4422 | 2014.120.4422.0  | 3075950 Cumulative update package 2 (CU2) for SQL Server 2014 Service Pack 1                                                     | 2015-08-17   |
| 12.00.4416 | 2014.120.4416.0  | 3067839 Cumulative update package 1 (CU1) for SQL Server 2014 Service Pack 1                                                     | 2015-06-22   |
| 12.00.4213 | 2014.120.4213.0  | MS15-058: Description of the nonsecurity update for SQL Server 2014 Service Pack 1 GDR: July 14, 2015                            | 2015-07-14   |
| 12.00.4100 | 2014.120.4100.1  | SQL Server 2014 Service Pack 1 (SP1)                                                                                             | 2015-05-14   |
| 12.00.4050 | 2014.120.4050.0  | SQL Server 2014 Service Pack 1 (SP1) [withdrawn]                                                                                 | 2015-04-15   |
| 12.00.2556 | 2014.120.2556.4  | 3094220 Cumulative update package 10 (CU10) for SQL Server 2014                                                                  | 2015-10-20   |
| 12.00.2553 | 2014.120.2553.0  | 3075949 Cumulative update package 9 (CU9) for SQL Server 2014                                                                    | 2015-08-17   |
| 12.00.2548 | 2014.120.2548.0  | MS15-058: Description of the security update for SQL Server 2014 QFE: July 14, 2015                                              | 2015-07-14   |
| 12.00.2546 | 2014.120.2546.0  | 3067836 Cumulative update package 8 (CU8) for SQL Server 2014                                                                    | 2015-06-22   |
| 12.00.2506 | 2014.120.2506.0  | 3063054 Update enables Premium Storage support for Data files on Azure Storage and resolves backup failures                      | 2015-05-19   |
| 12.00.2505 | 2014.120.2505.0  | 3052167 FIX: Error 1205 when you execute parallel query that contains outer join operators in SQL Server 2014                    | 2015-05-19   |
| 12.00.2504 | 2014.120.2504.0  | 2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014                                               | 2015-05-05   |
| 12.00.2504 | 2014.120.2504.0  | 3058512 FIX: Unpivot Transformation task changes null to zero or empty strings in SSIS 2014                                      | 2015-05-05   |
| 12.00.2495 | 2014.120.2495.0  | 3046038 Cumulative update package 7 (CU7) for SQL Server 2014                                                                    | 2015-04-23   |
| 12.00.2488 | 2014.120.2488.0  | 3048751 FIX: Deadlock cannot be resolved automatically when you run a SELECT query that can result in a parallel batch-mode scan | 2015-04-01   |
| 12.00.2485 | 2014.120.2485.0  | 3043788 An on-demand hotfix update package is available for SQL Server 2014                                                      | 2015-03-16   |
| 12.00.2480 | 2014.120.2480.0  | 3031047 Cumulative update package 6 (CU6) for SQL Server 2014                                                                    | 2015-02-16   |
| 12.00.2474 | 2014.120.2474.0  | 3034679 FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING                                                      | 2015-05-15   |
| 12.00.2472 | 2014.120.2472.0  | 3032087 FIX: Cannot show requested dialog after you connect to the latest SQL Database Update V12 (preview) with SQL Server 2014 | 2015-01-28   |
| 12.00.2464 | 2014.120.2464.0  | 3024815 Large query compilation waits on RESOURCE_SEMAPHORE_QUERY_COMPILE in SQL Server 2014                                     | 2015-01-05   |
| 12.00.2456 | 2014.120.2456.0  | 3011055 Cumulative update package 5 (CU5) for SQL Server 2014                                                                    | 2014-12-18   |
| 12.00.2436 | 2014.120.2436.0  | 3014867 FIX: "Remote hardening failure" exception cannot be caught and a potential data loss when you use SQL Server 2014        | 2014-11-27   |
| 12.00.2430 | 2014.120.2430.0  | 2999197 Cumulative update package 4 (CU4) for SQL Server 2014                                                                    | 2014-10-21   |
| 12.00.2423 | 2014.120.2423.0  | 3007050 FIX: RTDATA_LIST waits when you run natively stored procedures that encounter expected failures in SQL Server 2014       | 2014-10-22   |
| 12.00.2405 | 2014.120.2405.0  | 2999809 FIX: Poor performance when a query contains table joins in SQL Server 2014                                               | 2014-09-25   |
| 12.00.2402 | 2014.120.2402.0  | 2984923 Cumulative update package 3 (CU3) for SQL Server 2014                                                                    | 2014-08-18   |
| 12.00.2381 | 2014.120.2381.0  | 2977316 MS14-044: Description of the security update for SQL Server 2014 (QFE)                                                   | 2014-08-12   |
| 12.00.2370 | 2014.120.2370.0  | 2967546 Cumulative update package 2 (CU2) for SQL Server 2014                                                                    | 2014-06-27   |
| 12.00.2342 | 2014.120.2342.0  | 2931693 Cumulative update package 1 (CU1) for SQL Server 2014                                                                    | 2014-04-21   |
| 12.00.2269 | 2014.120.2269.0  | 3045324 MS15-058: Description of the security update for SQL Server 2014 GDR: July 14, 2015                                      | 2015-07-14   |
| 12.00.2254 | 2014.120.2254.0  | 2977315 MS14-044: Description of the security update for SQL Server 2014 (GDR)                                                   | 2014-08-12   |
| 12.00.2000 | 2014.120.2000.8  | SQL Server 2014 RTM                                                                                                              | 2014-04-01   |
| 12.00.1524 | 2014.120.1524.0  | Microsoft SQL Server 2014 Community Technology Preview 2 (CTP2)                                                                  | 2013-10-15   |
| 11.00.9120 | 2013.110.9120.0  | Microsoft SQL Server 2014 Community Technology Preview 1 (CTP1)                                                                  | 2013-06-25   |


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
[Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)]:https://technet.microsoft.com/en-in/evalcenter/mt130694.aspx
