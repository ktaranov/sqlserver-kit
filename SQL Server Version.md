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


## Quick summary for SP

| Version            | Codename    | RTM (no SP)  | SP1                           | SP2                           | SP3                             | SP4                           |
|:-------------------|:------------|:-------------|:------------------------------|:------------------------------|:------------------------------- | ----------------------------- |
| SQL Server 2016    | ?           | CTP3.0       |                               |                               |                                 |                               |
| SQL Server 2014    | SQL14       | 12.0.2000.8  | 12.0.4100.1<br/>12.1.4100.1   |                               |                                 |                               |
| SQL Server 2012    | Denali      | 11.0.2100.60 | 11.0.3000.0<br/>11.1.3000.0   | 11.0.5058.0                   |                                 |                               |
| SQL Server 2008 R2 | Kilimanjaro | 10.50.1600.1 | 10.50.2500.0<br/>10.51.2500.0 | 10.50.4000.0<br/>10.52.4000.0 | 10.50.6000.34<br/>10.53.6000.34 |                               |
| SQL Server 2008    | Katmai      | 10.0.1600.22 | 10.0.2531.0<br/>10.1.2531.0   | 10.0.4000.0<br/>10.2.4000.0   | 10.0.5500.0<br/>10.3.5500.0     | 10.0.6000.29<br/>10.4.6000.29 |
| SQL Server 2005    | Yukon       | 9.0.1399.06  | 9.0.2047                      | 9.0.3042                      | 9.0.4035                        | 9.0.5000                      |
| SQL Server 2000    | Shiloh      | 8.0.194      | 8.0.384                       | 8.0.532                       | 8.0.760                         | 8.0.2039                      |
| SQL Server 7.0     | Sphinx      | 7.0.623      | 7.0.699                       | 7.0.842                       | 7.0.961                         | 7.0.1063                      |
| SQL Server 6.5     | Hydra       | ?            |                               |                               |                                 |                               |
| SQL Server 6.0     | SQL95       | ?            |                               |                               |                                 |                               |
| SQL Server 4.21    | SQLNT       | ?            |                               |                               |                                 |                               |


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


[Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)]:https://technet.microsoft.com/en-in/evalcenter/mt130694.aspx
