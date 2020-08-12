# Microsoft SQL Server Version
Download links and complete information for all Microsoft SQL Server versions and builds

Headers:
 - [Frequently used terms and acronyms](#frequently-used-terms-and-acronyms)
 - [SQL Server Patching Shortcut](#sql-server-patching-shortcut)
 - [What are the most recent updates for SQL Server?](#what-are-the-most-recent-updates-for-sql-server)
 - [Microsoft SQL Server installation files info](#microsoft-sql-server-installation-files-info)
 - [SQL Server Developer Edition Info](#sql-server-developer-edition-info)
 - [SQL Server Express direct download links](#sql-server-express-direct-download-links)
 - [Internal Database Version and Compatibility Level](#internal-database-version-and-compatibility-level)
 - [Microsoft SQL Server 2019 Builds](#microsoft-sql-server-2019-builds)
 - [Microsoft SQL Server 2017 Builds](#microsoft-sql-server-2017-builds)
 - [Microsoft SQL Server 2016 Builds](#microsoft-sql-server-2016-builds)
 - [Microsoft SQL Server 2014 Builds](#microsoft-sql-server-2014-builds)
 - [Microsoft SQL Server 2012 Builds](#microsoft-sql-server-2012-builds)
 - [Microsoft SQL Server 2008 R2 Builds](#microsoft-sql-server-2008-r2-builds)
 - [Microsoft SQL Server 2008 Builds](#microsoft-sql-server-2008-builds)
 - [Microsoft SQL Server 2005 Builds](#microsoft-sql-server-2005-builds)
 - [Microsoft SQL Server 2000 Builds](#microsoft-sql-server-2000-builds)
 - [Microsoft SQL Server 7.0 Builds](#microsoft-sql-server-70-builds)
 - [Microsoft SQL Server 6.5 Builds](#microsoft-sql-server-65-builds)
 - [Microsoft SQL Server 6.0 Builds](#microsoft-sql-server-60-builds)

Useful links:
 - [KB321185 How to determine the version, edition and update level of SQL Server and its components](https://support.microsoft.com/help/321185)
 - [KB822499 Naming schema for Microsoft SQL Server software update packages](https://support.microsoft.com/help/822499)
 - [Microsoft SQL Server Support Lifecycle](https://support.microsoft.com/lifecycle?x=5&y=11&c2=1044)
 - [Microsoft Update Catalog](http://www.catalog.update.microsoft.com)
 - [SQL Server packages for Linux](https://packages.microsoft.com/)
 - [Release notes for SQL Server 2017 on Linux](https://docs.microsoft.com/sql/linux/sql-server-linux-release-notes?view=sql-server-linux-2017)
 - [KB824684 Description of the standard terminology that is used to describe Microsoft software updates](https://support.microsoft.com/help/824684)
 - [KB935897 An Incremental Servicing Model is available from the SQL Server team to deliver hotfixes for reported problems](https://support.microsoft.com/help/935897)
 - [KB2964518 Recommended updates and configuration options for SQL Server 2012 and SQL Server 2014 with high-performance workloads](https://support.microsoft.com/help/2964518)
 - [Azure SQL Server Updates](https://azure.microsoft.com/updates/?product=sql-database&update-type=general-availability)
 - [Most Recent KBs for Microsoft SQL Server RSS](https://support.microsoft.com/rss?rssid=1044)
 - [Testing and Developing Supportability Roadmaps for ISV Applications (PDF)](http://blogs.technet.com/cfs-file.ashx/__key/communityserver-blogs-components-weblogfiles/00-00-00-85-48-files/0827.testing-and-developing-supportability-roadmaps-for-isv-applications.pdf)
 - [SQL Server Updates by Brent Ozar team](http://sqlserverupdates.com/)
 - [Which Version of SQL Server Should You Use?](https://www.brentozar.com/archive/2019/01/which-version-of-sql-server-should-you-use/)
 - [SQL Server Builds by SQLSentry](http://blogs.sqlsentry.com/category/sql-server-builds/)
 - [SQL Server Builds by SQLPerformance.com](https://sqlperformance.com/latest-builds)
 - [SQL Server Release Services](https://blogs.msdn.microsoft.com/sqlreleaseservices/)
 - [Why I have high hopes for the quality of SQL Server 2016 release by Remus Rusanu](https://medium.com/@rusanu/why-i-have-high-hopes-for-the-quality-of-sql-server-2016-release-6173bc1fbc82#.44kg2ktmg)
 - [Unofficial SQL Server build chart lists](http://sqlserverbuilds.blogspot.ru/)
 - [Unofficial SQL Server build chart lists in table representation](http://sqlbuilds.ekelmans.com/)
 - [Hardware and Software Requirements for Installing SQL Server](https://msdn.microsoft.com//library/ms143506.aspx)
 - [Wikipedia Microsoft SQL Server](https://en.wikipedia.org/wiki/Microsoft_SQL_Server)
 - [SQL Server 2005 Downloads](https://msdn.microsoft.com/sqlserver/bb671254.aspx)
 - [SQL Server 2000 Downloads](https://msdn.microsoft.com/sqlserver/bb895925)
 - [SQL Server 7.0 Downloads](https://msdn.microsoft.com/sqlserver/bb671066)

Useful articles:
 - [How to identify your SQL Server version and edition](http://support.microsoft.com/kb/321185/en-us)
 - [SQL Server Internal Database Versions](http://sqlserverbuilds.blogspot.ru/2014/01/sql-server-internal-database-versions.html)
 - [Microsoft SQL Server Support Lifecycle](https://support.microsoft.com/lifecycle/)
 - [Microsoft SQL Server Home](http://www.microsoft.com/sql)
 - [Microsoft SQL Server Developer Center](http://msdn.microsoft.com/sqlserver)
 - [Microsoft TechNet: Microsoft SQL Server](http://technet.microsoft.com/sqlserver)
 - [SQL Server Patching Shortcut](http://www.sqlservercentral.com/articles/SQL+Server+patching/138693/)

**All SQL Server service packs and Cumulative Updates are cumulative, meaning that each new service pack and cumulative update contains all the fixes that are included with previous service packs and any new fixes.**


## Frequently used terms and acronyms
<a id="frequently-used-terms-and-acronyms"></a>
**Great thanks to Aaron Bertrand for awesome article**: [Definitions of SQL Server release acronyms](http://blogs.sqlsentry.com/aaronbertrand/back-to-basics-release-acronyms/)

 - **COD** *Critical On-Demand*: This is a fix for an issue that is deemed "critical" because of the severity of the issue, the number of customers it affects,
or the lack of a feasible workaround (usually a combination of two or all three).
The fix is released out-of-band from the usual Cumulative Update / Service Pack release cycle, and then rolled into the next Cumulative Update (or, depending on timing, the one after that).
A COD can sometimes contain more than one QFE (defined below).
 - **CU** *Cumulative Update*: This is a roll-up of multiple fixes that occurs between Service Packs, usually on a 60-day cycle (though that is subject to change).
It used to require an e-mail and password to download and extract the files, because they were "less tested" than service packs, but [this is no longer the case](https://blogs.msdn.microsoft.com/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism/).
Functionality can also be added in Cumulative Updates (previously, this would only happen in Service Packs, and before that, only in major releases).
Kendra Little just published [a fantastic blog post about this](http://www.littlekendra.com/2016/04/28/required-testing-for-installing-sql-server-cumulative-updates-and-service-packs/).
You should feel comfortable applying Cumulative Updates as quickly as your regression and other test processes allow.
 - **CTP** *Community Technology Preview*: This is a build of the "next" version of SQL Server (or sometimes a Service Pack) that can be used for testing new features and reporting bugs.
With few exceptions, CTPs cannot be used in a production scenario, and they are usually limited to Express / Evaluation Editions.
 - **GA** *General Availability*: For the traditional SQL Server product, this usually means that you can download the ISO from the usual sources (MSDN downloads, the TechNet Evaluation Center, or your volume licensing servers).
For Azure SQL Database, this usually means that you can go and turn on the functionality without first agreeing to a waiver about preview functionality.
 - **GDR** *General Distribution Release*: A GDR fix contains issues that are security-related and/or have a wide impact, and are released without any other critical updates that have been released for the specific branch.
These are typically used by customers who need the fixes they contain, but do not have the resources to test all of the other fixes that come with Cumulative Updates.
 - **QFE** *Quick Fix Engineering*: This is a potentially less-tested fix (also sometimes called a hotfix) that gets distributed to a small number of customers for a very specific issue, through a COD or CU.
(In the Windows world, this is called an LDR – Limited Distribution Release – but that nomenclature has not caught on in the SQL Server team.)
 - **RC** *Release Candidate*: This is a build that is almost ready for final release (RTM / GA). Usually it is feature complete, with the only remaining work comprised of minor bug fixes and fit & finish.
However, this is not always strictly the case, as a few behavior changes were introduced in RCs for SQL Server 2016.
 - **RDP** *Rapid Deployment Program*: No, this has nothing to do with remote desktop; it refers to a set of "early adopter" customers, usually used to help market the launch of a new version or feature.
These are almost always a subset of TAP, and are almost always running the new version in production months before it is available to the public. James Serra goes into more detail [here](http://www.jamesserra.com/archive/2011/10/what-is-microsoft-tap-and-rdp/).
 - **RTM** *Released To Manufacturing*: This means that the release is ready. Back when Microsoft shipped software on CDs and later DVDs, this represented the point in time when the discs could be printed.
Not to be confused with launch (which is a marketing thing only) or General Availability (which means you can actually get the code).
The delay between RTM and GA is much shorter now that software is generally distributed online instead of on physical media.
 - **RTW** *Release to Web*: It indicates a package that was released to the web and made available to customers for downloading.
 - **TAP** *Technology Adoption Program*: This describes a set of customers that help Microsoft shape and test specific features for a new release (or help shape and test new features individually).
 - **SP** *Service Pack*: A Service Pack is, now, essentially a Cumulative Update with slightly different labeling.
It is a roll-up of updates (including bug fixes and security updates) and sometimes contains new features.
Like Cumulative Updates, Service Packs are cumulative. If you are applying SP3, you do not need to first deploy SP1 and SP2.
 - **SU** or **CVE**: Security update.
 - **Hotfix**: A single, cumulative package that includes one or more files that are used to address a problem in a product and are cumulative at the binary and file level. A hotfix addresses a specific customer situation and may not be distributed outside the customers organization.

### References
 - [KB #824684 : Description of the standard terminology that is used to describe Microsoft software updates](https://support.microsoft.com/kb/824684)
 - [KB #935897 : An Incremental Servicing Model is available from the SQL Server team to deliver hotfixes for reported problems](https://support.microsoft.com/kb/935897)
 - [QFE vs GDR/LDR hotfixes](https://blogs.technet.microsoft.com/instan/2009/03/04/qfe-vs-gdrldr-hotfixes/)
 - [GDR, QFE, LDR… WTH?](http://blogs.technet.com/b/mrsnrub/archive/2009/05/14/gdr-qfe-ldr-wth.aspx)
 - [GDR & LDR : The Next Generation](http://blogs.technet.com/b/mrsnrub/archive/2009/05/14/gdr-qfe-ldr-wth.aspx)
 - [Terms used by Microsoft to describe the various software updates released by it](http://www.thewindowsclub.com/terms-used-by-microsoft-to-describe-the-various-software-updates-released-by-it)
 - [What is Microsoft TAP and RDP?](http://www.jamesserra.com/archive/2011/10/what-is-microsoft-tap-and-rdp/)


## SQL Server Patching Shortcut
<a id="sql-server-patching-shortcut"></a>

Step 1. After the CU file has been downloaded, open a DOS prompt and launch it with the /extract option with a path of your choice appended to this option. For example:
```bat
SQLServer2017-KB4052574-x64.exe /extract C:\SQL2017CU2
```
After a few moments you should see the progress bar dialog pop up. The target directory will be created if it does not exist, so this is also a great option for automating patch installs.

No step 2 required. The patch has been extracted to a location of your choice, which means there's one less thing to worry about when it's time to carry out the actual patching.

Profits:
 - This saves time as the install files can be extracted in advance, and if you have to patch a lot of servers this saving is multiplied as the files are extracted once, instead of every time on every server.
 - This time saving also serves to reduces risk as it is one less thing that could go wrong during patching. The last thing you want to be doing during a patching window is scrambling around on a server clearing space in temp folders because there was not enough space free on e.g. the C: drive for the patch to extract itself.
 - This is also a great way of retrieving just an individual msi file (e.g. sqlncli.msi)


## What are the most recent updates for SQL Server?
<a id="what-are-the-most-recent-updates-for-sql-server"></a>

| Version | Latest Update                                                         | Build Number                                 | Release Date                             | Lifecycle Start | Mainstream Support | Extended Support | Other Updates                                                     |
|---------|-----------------------------------------------------------------------|----------------------------------------------|------------------------------------------|-----------------|--------------------|------------------|-------------------------------------------------------------------|
| 2019    | [Install 2019 RTM] then [CU6 KB4563110]                               | 15.0.2070.41<br/>15.0.4053.23                | 2019-11-04<br/>2020-08-04                | 2019-11-04      | 2025-01-07         | 2030-01-08       | [Other SQL 2019 Updates](#microsoft-sql-server-2019-builds)       |
| 2017    | [Install 2017 RTM] then [CU21 KB4557397]                              | 14.0.1000.169<br/>14.0.3335.7                | 2017-10-02<br/>2020-07-01                | 2017-09-29      | 2022-11-10         | 2027-12-10       | [Other SQL 2017 Updates](#microsoft-sql-server-2017-builds)       |
| 2016    | [Install 2016 SP2] then [CU14 KB4564903]                              | 13.0.5026.0<br/>13.0.5830.85                 | 2018-04-24<br/>2020-08-06                | 2016-01-06      | 2021-07-13         | 2026-07-14       | [Other SQL 2016 Updates](#microsoft-sql-server-2016-builds)       |
| 2014    | [Install 2014 SP3] then<br/> [KB4535288]                              | 12.0.6024.0<br/>12.0.6372.1                  | 2018-10-30<br/>2020-02-11                | 2016-07-14      | 2019-07-09         | 2024-07-09       | [Other SQL 2014 Updates](#microsoft-sql-server-2014-builds)       |
| 2012    | [Install 2012] then<br/>[SP4 2012] then<br/>[KB4532098]               | 11.0.2100.60<br/>11.0.7001.0<br/>11.0.7493.4 | 2012-02-14<br/>2017-10-05<br/>2020-02-11 | 2015-12-01      | 2017-07-11         | 2022-07-12       | [Other SQL 2012 Updates](#microsoft-sql-server-2012-builds)       |
| 2008 R2 | [Install 2008 R2] then <br/>[SP3 2008 R2] then<br/>[SU KB3045311]     | 10.50.1600<br/>10.50.6000<br/>10.50.6220.0   | 2010-11-21<br/>2014-09-30<br/>2015-07-14 | 2010-07-20      | 2014-07-08         | 2019-07-09       | [Other SQL 2008 R2 Updates](#microsoft-sql-server-2008-r2-builds) |
| 2008    | [Install 2008] then<br/>[SP4 2008] then<br/>[SU KB3045316]            | 10.0.1600.0<br/>10.0.6000<br/>10.0.6241.0    | 2008-01-19<br/>2014-09-30<br/>2015-07-14 | 2010-07-20      | 2014-07-08         | 2019-07-09       | [Other SQL 2008 Updates](#microsoft-sql-server-2008-builds)       |

[Install 2019 RTM]:https://www.microsoft.com/sql-server/sql-server-2019#Install
[CU6 KB4563110]:https://support.microsoft.com/help/4563110
[Install 2017 RTM]:https://www.microsoft.com/en-us/sql-server/sql-server-2017
[CU21 KB4557397]:https://support.microsoft.com/help/4557397
[Install 2016 SP2]:https://go.microsoft.com/fwlink/?LinkID=799011
[CU14 KB4564903]:https://support.microsoft.com/help/4564903
[Install 2014 SP3]:https://www.microsoft.com/evalcenter/evaluate-sql-server-2014-sp3
[KB4535288]:https://support.microsoft.com/help/4535288
[Install 2012]:https://www.microsoft.com/evalcenter/evaluate-sql-server-2012
[SP4 2012]:https://support.microsoft.com/help/4018073
[KB4532098]:https://support.microsoft.com/help/4532098
[CU9 KB3098512]:https://support.microsoft.com/kb/3098512
[Install 2008 R2]:https://msdn.microsoft.com/subscriptions/securedownloads/#searchTerm=sql%20server%202008%20r2&ProductFamilyId=0&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0
[SP3 2008 R2]:http://www.microsoft.com/download/details.aspx?id=44271
[SU KB3045311]:https://www.microsoft.com/downloads/details.aspx?familyid=7af16cb8-c944-41cb-a897-c6fc373869cd
[Install 2008]:https://msdn.microsoft.com/subscriptions/securedownloads/#searchTerm=sql%20server%202008&ProductFamilyId=0&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0
[SP4 2008]:http://www.microsoft.com/download/details.aspx?id=44278
[SU KB3045316]:https://support.microsoft.com/help/3045311
[Developer Free]:https://www.microsoft.com/cloud-platform/sql-server-editions-developers


## Microsoft SQL Server installation files info
<a id="microsoft-sql-server-installation-files-info"></a>
`SHA1` hash you can easy get with default Windows utility [certutil](https://docs.microsoft.com/windows-server/administration/windows-commands/certutil 'certutil Microsoft docs').

For example, for single file:
```bat
certUtil -hashfile "d:\SQL Server\SQLServer2014SP1-KB3058865-x64-ENU.exe" sha1
```

Or for all files with .exe extensions in folder:
```bat
FOR /R "d:\SQL Server" %I IN (*.exe) DO certUtil -hashfile "%I" sha1
```

Alternative download link for all English x64 distributives: https://rebrand.ly/sql-server-distribs

| Direct x64 Download Link        | File Name                                                         | Release Date | Build Number  | Size, MB | SHA1                                     |
|:--------------------------------|:------------------------------------------------------------------|:-------------|--------------:|---------:|------------------------------------------|
| [SQL Server 2019 RTM]           | SQLServer2019-x64-ENU.iso                                         | 2019-11-04   | 15.0.2000.5   |     1360 | d41eb957a037add32441e2302a734268bda94709 |
| [SQL Server 2019 CU6]           | SQLServer2019-KB4563110-x64.exe                                   | 2020-08-04   | 15.0.4053.23  |      604 | 505c6d0a8773909e87a0456978ffb43449a92309 |
| [SQL Server 2017 RTM]           | SQLServer2017-x64-ENU-Dev.iso                                     | 2017-10-02   | 14.0.1000.169 |     1476 | 0280ff6c1447d287a6bd3b86b81e459fe252d17a |
| [SQL Server 2017 CU21]          | SQLServer2017-KB4557397-x64.exe                                   | 2020-07-01   | 14.0.3335.7   |      533 | e91bfa33a34accf82a0c374c9e8b7d0ce3b7ce05 |
| [SQL Server 2016 SP2]           | SQLServer2016SP1-KB3182545-x64-ENU.exe                            | 2018-04-24   | 13.0.5026.0   |     2832 | 6309d729a0f063d11c0bb7f840f1069483406755 |
| [SQL Server 2016 SP2 CU14]      | SQLServer2016-KB4564903-x64.exe                                   | 2020-05-28   | 13.0.5820.21  |      752 | a1de57f8d273b9ae97868e0fd8394c237d7a593d |
| [SQL Server 2014 SP3]           | SQLServer2014SP3-FullSlipstream-x64-ENU.iso                       | 2018-10-30   | 12.0.6024.0   |     3190 | 6041e06548c46862c9f3536e28113f598bb6ae00 |
| [SQL Server 2014 SP3 KB4535288] | SQLServer2014-KB4535288-x64.exe                                   | 2020-02-11   | 12.0.6372.1   |      604 | f5a76d473fee50a2aabe7c08daeb0910f3590491 |
| [SQL Server 2012 RTM]           | SQLFULL_ENU.iso                                                   | 2012-02-14   | 11.0.2100.60  |     4300 | be00942cc56d033e2c9dce8a17a6f2654f5184a3 |
| [SQL Server 2012 SP4]           | SQLServer2012SP4-KB4018073-x64-ENU.exe                            | 2017-10-05   | 11.0.7001.0   |     1024 | 95127ee2e8dfef180752e531a83cd948c24a3a87 |
| [SQL Server 2012 SP4 KB4532098] | SQLServer2012-KB4532098-x64.exe                                   | 2020-02-11   | 11.0.7493.4   |      867 | e20fa98775d4983a042e987caa6d59eba46ec760 |
| SQL Server 2008 R2 RTM          | SW_DVD9_SQL_Svr_Enterprise_Edtn_2008_R2_English_MLF_X16-29540.ISO | 2010-04-21   | 10.50.1600.1  |     4177 | 18105db70f0f0b23418f5005a6ce4b25317c6d03 |
| [SQL Server 2008 R2 SP3]        | SQLServer2008R2SP3-KB2979597-x64-ENU.exe                          | 2014-09-30   | 10.50.6220.0  |      358 | 194cd740d5812b12639b47886ebde0d04774b4ec |
| [SQL Server 2008 R2 SU]         | SQLServer2008R2-KB3045316-x64.exe                                 | 2015-07-14   | 10.50.6000    |       58 | 3aa4d820553b1e5d96735541cbb55d97322c286e |
| SQL Server 2008                 | ?                                                                 | 2008-01-19   | 10.0.1600.0   |        ? | ?                                        |
| [SQL Server 2008 SP4]           | SQLServer2008SP4-KB2979596-x64-ENU.exe                            | 2014-09-30   | 10.0.6241.0   |      378 | 13610d6cb39e37fcd4a3338244a3ca2a8a404cd8 |
| [SQL Server 2008 SU]            | SQLServer2008-KB3045311-x64.exe                                   | 2015-07-14   | 10.00.6000    |       61 | 37a197c60990d2e83e98d1090109a4ab3f2abe4b |

**For downloading distributive for SQL Server 2008 R2 and SQL Server 2008 you must have MSDN subscription, see [SQL Server 2008 R2] and [SQL Server 2008] links.**

[SQL Server 2019 RTM]:https://go.microsoft.com/fwlink/?linkid=866664
[SQL Server 2019 CU6]:https://download.microsoft.com/download/6/e/7/6e72dddf-dfa4-4889-bc3d-e5d3a0fd11ce/SQLServer2019-KB4563110-x64.exe
[SQL Server 2017 RTM]:https://go.microsoft.com/fwlink/?linkid=853016
[SQL Server 2017 CU21]:https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB4557397-x64.exe
[SQL Server 2016]:http://care.dlservice.microsoft.com/dl/download/F/E/9/FE9397FA-BFAB-4ADD-8B97-91234BC774B2/SQLServer2016-x64-ENU.iso
[SQL Server 2016 SP2]:https://go.microsoft.com/fwlink/?LinkID=799011
[SQL Server 2016 SP2 CU14]:https://download.microsoft.com/download/6/0/6/606B3A2E-0EAE-4DCD-930D-178686370921/SQLServer2016-KB4564903-x64.exe
[SQL Server 2014 SP3]:https://www.microsoft.com/en-us/evalcenter/evaluate-sql-server-2014-sp3
[SQL Server 2014 SP3 KB4535288]:https://www.microsoft.com/en-us/download/confirmation.aspx?id=100913&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1
[SQL Server 2012 RTM]:https://download.microsoft.com/download/4/C/7/4C7D40B9-BCF8-4F8A-9E76-06E9B92FE5AE/ENU/SQLFULL_ENU.iso
[SQL Server 2012 SP4]:https://download.microsoft.com/download/E/A/B/EABF1E75-54F0-42BB-B0EE-58E837B7A17F/SQLServer2012SP4-KB4018073-x64-ENU.exe
[SQL Server 2012 SP4 KB4532098]:https://www.microsoft.com/en-us/download/confirmation.aspx?id=100915&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1]:https://www.microsoft.com/en-us/download/confirmation.aspx?id=100915&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1
[SQL Server 2008 R2]:https://msdn.microsoft.com/subscriptions/securedownloads/#searchTerm=sql%20server%202008%20r2&ProductFamilyId=0&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0
[SQL Server 2008 R2 SP3]:https://download.microsoft.com/download/D/7/A/D7A28B6C-FCFE-4F70-A902-B109388E01E9/ENU/SQLServer2008R2SP3-KB2979597-x64-ENU.exe
[SQL Server 2008 R2 SU]:https://download.microsoft.com/download/4/D/A/4DAE6F9E-960E-4A59-BDE7-1D92DA508315/SQLServer2008R2-KB3045316-x64.exe
[SQL Server 2008]:https://msdn.microsoft.com/subscriptions/securedownloads/#searchTerm=sql%20server%202008&ProductFamilyId=0&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0
[SQL Server 2008 SP4]:https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x64-ENU.exe
[SQL Server 2008 SU]:https://download.microsoft.com/download/E/C/0/EC0A7C15-9A6D-4F41-9B9F-BCA10CC3937C/SQLServer2008-KB3045311-x64.exe


## SQL Server Developer Edition Info
<a id="sql-server-developer-edition-info"></a>
**Now it is free!!!** [SQL Server Developer Edition Download page](https://my.visualstudio.com/downloads?q=sql%20server%20developer)

For downloading your copy SQL Server Developer Edition you just need to join the [Visual Studio Dev Essentials program](https://www.visualstudio.com/products/visual-studio-dev-essentials-vs.aspx)

| Edition\Direct Download Link                                                | Release Date | File name                                                                    | Size, Mb | SHA1                                     |
|-----------------------------------------------------------------------------|--------------|------------------------------------------------------------------------------|---------:|------------------------------------------|
| SQL Server 2019 Developer (x64) - DVD (English)                             | 2019-11-05   | en_sql_server_2019_developer_x64_dvd_baea4195.iso                            |     1367 | 22974e466987d7d4659437aab06ac0798657c700 |
| SQL Server 2017 Developer (x64) - DVD (English)                             | 2017-10-02   | en_sql_server_2017_developer_x64_dvd_11296168.iso                            |     1475 | 0280ff6c1447d287a6bd3b86b81e459fe252d17a |
| SQL Server 2016 Developer with Service Pack 2 (x64) - DVD (English)         | 2018-05-22   | en_sql_server_2016_developer_with_service_pack_2_x64_dvd_12194995.iso        |     2800 | 74279286c2abfba9e9ff6dbee60b71669bd234d2 |
| SQL Server 2016 Developer with Service Pack 1 (x64) - DVD (English)         | 2016-11-16   | en_sql_server_2016_developer_with_service_pack_1_x64_dvd_9548071.iso         |     2590 | b12af2cc5112f22a784a14f8d32b49ee56d296b3 |
| SQL Server 2016 Developer (x64) - DVD (English)                             | 2016-06-01   | en_sql_server_2016_developer_x64_dvd_8777069.iso                             |     2100 | 1b23982fe56df3bfe0456bdf0702612eb72abf75 |
| SQL Server 2014 Developer Edition with Service Pack 1 (x64) - DVD (English) | 2015-05-21   | en_sql_server_2014_developer_edition_with_service_pack_1_x64_dvd_6668542.iso |     3025 | bfee1f300c39638da0d2cd594636698c6207c852 |
| SQL Server 2014 Developer Edition with Service Pack 1 (x86) - DVD (English) | 2015-05-21   | en_sql_server_2014_developer_edition_with_service_pack_1_x86_dvd_6668541.iso |     2462 | ed3c70507a73bcc63d67cfa272cd849b9418a18e |
| SQL Server 2014 Developer Edition (x64) - DVD (English)                     | 2014-04-01   | en_sql_server_2014_developer_edition_x64_dvd_3940406.iso                     |     2486 | f73f430f55a71da219fc7257a3a28e8fc142530f |
| SQL Server 2014 Developer Edition (x86) - DVD (English)                     | 2014-04-01   | en_sql_server_2014_developer_edition_x86_dvd_3938200.iso                     |     2039 | 395b35fd80aa959b02b0c399da1bb0c020db6310 |


## SQL Server Express direct download links
<a id="sql-server-express-direct-download-links"></a>
Great thanks Scott Hanselman for Original post: [Download SQL Server Express](http://downloadsqlserverexpress.com)

- [SQL Server 2019 Express Edition](https://www.microsoft.com/Download/details.aspx?id=101064)
  - [Download SQL Server 2019 Express Basic (English)](https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLEXPR_x64_ENU.exe)
  - [Download SQL Server 2019 Express Advanced (English)](https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SQLEXPRADV_x64_ENU.exe)
  - [Download SQL Server 2019 Express LocalDB (English)](https://download.microsoft.com/download/7/c/1/7c14e92e-bdcb-4f89-b7cf-93543e7112d1/SqlLocalDB.msi)
- [Download SQL Server 2017 Express](https://www.microsoft.com/download/details.aspx?id=55994)
  - [Download SQL Server 2017 Express Basic (English)](https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLEXPR_x64_ENU.exe)
  - [Download SQL Server 2017 Express Advanced (English)](https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLEXPRADV_x64_ENU.exe)
  - [Download SQL Server 2017 Express LocalDB (English)](https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SqlLocalDB.msi)
- SQL Server 2016 Express
  - [Download SQL Server 2016 SP2 Express Basic (English)](https://download.microsoft.com/download/4/1/A/41AD6EDE-9794-44E3-B3D5-A1AF62CD7A6F/sql16_sp2_dlc/en-us/SQLEXPR_x64_ENU.exe)
  - [Download SQL Server 2016 SP2 Express Advanced (English)](https://download.microsoft.com/download/4/1/A/41AD6EDE-9794-44E3-B3D5-A1AF62CD7A6F/sql16_sp2_dlc/en-us/SQLEXPRADV_x64_ENU.exe)
  - [Download SQL Server 2016 SP2 Express LocalDB (English)](https://download.microsoft.com/download/4/1/A/41AD6EDE-9794-44E3-B3D5-A1AF62CD7A6F/sql16_sp2_dlc/en-us/SqlLocalDB.msi)
- SQL Server 2016 Express
  - [Download SQL Server 2016 SP1 Express Basic (English)](https://download.microsoft.com/download/9/0/7/907AD35F-9F9C-43A5-9789-52470555DB90/ENU/SQLEXPR_x64_ENU.exe)
  - [Download SQL Server 2016 SP1 Express Advanced (English)](https://download.microsoft.com/download/9/0/7/907AD35F-9F9C-43A5-9789-52470555DB90/ENU/SQLEXPRADV_x64_ENU.exe)
  - [Download SQL Server 2016 SP1 Express LocalDB (English)](https://download.microsoft.com/download/9/0/7/907AD35F-9F9C-43A5-9789-52470555DB90/ENU/SqlLocalDB.msi)
- [Download SQL Server 2014 Express](http://www.microsoft.com/download/details.aspx?id=42299)
- [Download Microsoft SQL Server 2014 Service Pack 1 (SP1) Express](https://www.microsoft.com/download/details.aspx?id=46697)
  - You likely just want SQL Server 2014 Express with Tools. This download includes SQL Management Studio:
  - [SQL Server 2014 Express x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2064BIT/SQLEXPRWT_x64_ENU.exe)
  - [SQL Server 2014 Express x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2032BIT/SQLEXPRWT_x86_ENU.exe)
  - Here's just SQL Server 2014 Management Studio:
  - [SQL Management Studio x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe)
  - [SQL Management Studio x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe)
  - SQL Server 2014 Express with Advanced Services:
  - [Advanced Services x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2064BIT/SQLEXPRADV_x64_ENU.exe)
  - [Advanced Services x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2032BIT/SQLEXPRADV_x86_ENU.exe)
- [Download SQL Server 2012 Express](http://www.microsoft.com/download/details.aspx?id=29062)
- [Download Microsoft SQL Server 2012 Service Pack 1 (SP1) Express ](https://www.microsoft.com/download/details.aspx?id=35579)
  - You likely just want SQL Server 2012 Express with Tools. This download includes SQL Management Studio:
  - [SQL Server 2012 Express x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLEXPRWT_x64_ENU.exe)
  - Here's just SQL Server 2012 Management Studio:
  - [SQL Management Studio x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLManagementStudio_x64_ENU.exe)
  - [SQL Management Studio x86](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x86/SQLManagementStudio_x86_ENU.exe)
- [Download SQL Server 2008 Express R2 SP2](http://www.microsoft.com/download/details.aspx?id=30438)
  - You likely just want SQL Server 2008 Express with Tools. This download includes SQL Management Studio:
  - [SQL Server 2008 Express x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe)
  - [SQL Server 2008 Express x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x86_ENU.exe)
  - Here's just SQL Server 2008 Management Studio:
  - [SQL Management Studio x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe)
  - [SQL Management Studio x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x86_ENU.exe)
- [Download SQL Server 2005 Express](https://www.microsoft.com/download/details.aspx?id=21844)


## Internal Database Version and Compatibility Level
<a id="internal-database-version-and-compatibility-level"></a>

### Database Compatibility Level
The compatibility level of a database dictates how certain language elements of the database function as it relates to an earlier version of SQL Server. 
In a nutshell, this offers up partial “backward compatibility” to an earlier version.
This functionality is not all encompassing as only certain aspects (i.e. certain syntax) of the database would pertain to this setting.

You can see what compatibility level a database is at by using the SSMS or via code.

Via SSMS:
 1. After connecting to the appropriate instance of the SQL Server Database Engine, in Object Explorer, click the server name.
 2. Expand **Databases**, and, depending on the database, either select a user database or expand **System Databases** and select a system database.
 3. Right-click the database, and then click **Properties**. The **Database Properties** dialog box opens.
 4. In the **Select a page** pane, click **Options**. The current compatibility level is displayed in the **Compatibility level** list box.
 5. To change the compatibility level, select a different option from the list. The choices are **SQL Server 2008 (100)**, **SQL Server 2012 (110)** or **SQL Server 2014 (120)**.

Via T-SQL:
```sql
-- For SQL Server 2005 and newer
SELECT name, compatibility_level FROM sys.databases WHERE name = 'DatabaseNameHere';

-- For SQL Server 2000
SELECT name, cmptlevel FROM sysdatabases WHERE name = 'DatabaseNameHere';
```

To ALTER DATABASE Compatibility Level use simple command:
```sql
ALTER DATABASE database_name SET COMPATIBILITY_LEVEL = { 150 | 140 | 130 | 120 | 110 | 100 | 90 }
```

### Internal Database Version and Compatibility level
[The Importance of Database Compatibility Level in SQL Server](https://www.sqlskills.com/blogs/glenn/the-importance-of-database-compatibility-level-in-sql-server/)

The database version is a number stamped in the boot page of a database that indicates the SQL Server version of the most recent SQL Server instance the database was attached to.
**The database version number does not equal the SQL Server version and does not equal the compatibility level should be considered as a completely different attribute of the database.**

The database version is an internal versioning system that defines what version of SQL Server the database was a recent resident of.
If you migrate a database from an older version to a newer version, the database version value will be increased to reflect the version number of the new server’s model database.

When you create a database, the database version is "stamped" with the same version as the **Model** database.
It is worth noting that if the **Model** database was originally created on a different server edition and then subsequently upgraded, you potentially could end up
with slightly different numbers than what you might expect.
As you upgrade the database to new SQL Server edition (you can not go backward) the version of the database increases.
This is done automatically regardless of what method you use to upgrade the database to the new version of SQL Server.

```sql
/* 1 using DBCC PAGE to look at the boot page (9) of the database
Search dbi_version string
 */
DBCC TRACEON(3604);
DBCC PAGE('DatabaseName', 1, 9, 3);
DBCC TRACEOFF(3604);
GO

/* 2 using DBCC DBINFO */
DBCC TRACEON(3604);
DBCC DBINFO;
DBCC TRACEOFF(3604);
GO

/* 3 using database property */
SELECT DatabaseProperty('DatabaseNameHere', 'version');
GO

/* 4 using RESTORE HEADERONLY for backup files, field DatabaseVersion */
RESTORE HEADERONLY FROM DISK=N'd:\DatabseBackupFile.bak' WITH NOUNLOAD;
GO
```

You will note that for each DBCC command we have to turn on [trace flag 3604](https://rebrand.ly/gh-sqlserver-trace-flags#3604) so that the output of the DBCC command is sent to the SSMS window rather than the default location, the SQL Server log.

If you are still on SQL Serever 2000, you can see this information with a simple query:
```sql
SELECT name, version FROM master.dbo.sysdatabases;
```

Execute the following query to determine the version of the Database Engine that you are connected to:
```sql
SELECT SERVERPROPERTY('ProductVersion');
```

| SQL Server Version                           | Database Engine | Code Name   | Release Year | Internal DB Version | Compatibility Level Designation | Supported Compatibility Level |
|:---------------------------------------------|----------------:|:------------|-------------:|--------------------:|--------------------------------:|------------------------------:|
| SQL Server 2019                              | 15              | 2019        | 2019         | 895-904             | 150                             | 150, 140, 130, 120, 110       |
| SQL Server 2017                              | 14              | 2017        | 2017         | 869-894             | 140                             | 140, 130, 120, 110, 100       |
| SQL Server 2016                              | 13              | Helsinki    | 2016         | 852                 | 130                             | 130, 120, 110, 100            |
| Azure SQL Database                           | 14              | CloudDB     | 2010 (2018)  | 862                 | 140                             | 140, 130, 120, 110, 100       |
| SQL Server 2014                              | 12              | Hekaton     | 2014         | 782                 | 120                             | 120, 110, 100                 |
| SQL Server 2012                              | 11              | Denali      | 2012         | 706                 | 110                             | 110, 100, 90                  |
| SQL Server 2008 R2                           | 10.5            | Kilimanjaro | 2010         | 660 / 661           | 100                             | 100, 90, 80                   |
| SQL Server 2008                              | 10              | Katmai      | 2008         | 655                 | 100                             | 100, 90, 80                   |
| SQL Server 2005 SP2+ with VarDecimal enabled |  9              | Yukon       | 2005         | 612                 |  90                             | 90, 80                        |
| SQL Server 2005                              |  9              | Yukon       | 2005         | 611                 |  90                             | 90, 80                        |
| SQL Server 2000                              |  8              | Shiloh      | 2000         | 539                 |  80                             | 80                            |
| SQL Server 7.0                               |  ?              | Sphinx      | 1998         | 515                 |  70                             | 70                            |
| SQL Server 6.5                               |  ?              | Hydra       | 1996         | 408                 |  65                             | 65                            |
| SQL Server 6.0                               |  ?              | SQL95       | 1995         | ?                   |  60                             | ?                             |
| SQL Server 4.21                              |  ?              | SQLNT       | 1993         | ?                   |  60                             | ?                             |
| SQL Server 1.1 (16 bit)                      |  ?              | Pietro      | 1991         | ?                   |  60                             | ?                             |
| SQL Server 1.0 (16 bit)                      |  ?              | Filipi      | 1989         | ?                   |  60                             | ?                             |

**Azure SQL Database V12** was released in December 2014. One aspect of that release was that newly created databases had their compatibility level set to 120. In 2015 SQL Database began support for level 130, although the default remained 120.

Starting in mid-June 2016, in Azure SQL Database, the default compatibility level will be 130 instead of 120 for newly created databases. Existing databases created before mid-June 2016 will not be affected, and will maintain their current compatibility level (100, 110, or 120).

If you want level 130 for your database generally, but you have reason to prefer the level 110 cardinality estimation algorithm, see [ALTER DATABASE SCOPED CONFIGURATION (Transact-SQL)](https://msdn.microsoft.com/library/mt629158.aspx), and in particular its keyword LEGACY_CARDINALITY_ESTIMATION =ON.

For details about how to assess the performance differences of your most important queries, between two compatibility levels on Azure SQL Database, see [Improved Query Performance with Compatibility Level 130 in Azure SQL Database](http://azure.microsoft.com/documentation/articles/sql-database-compatibility-level-query-performance-130/).

### References
 - [Compatibility Level vs Database Version](http://sqlrus.com/2014/10/compatibility-level-vs-database-version/) (by John Morehouse)
 - [What’s the difference between database version and database compatibility level?](https://blogs.msdn.microsoft.com/sqlserverstorageengine/2007/04/26/whats-the-difference-between-database-version-and-database-compatibility-level/) (by Paul Randal)
 - [ALTER DATABASE Compatibility Level (Transact-SQL)](https://msdn.microsoft.com/library/bb510680(SQL.130).aspx)
 - [View or Change the Compatibility Level of a Database](https://msdn.microsoft.com/library/bb933794.aspx)
 - [Database Version vs Database Compatibility Level](http://sqlblog.com/blogs/jonathan_kehayias/archive/2009/07/28/database-version-vs-database-compatibility-level.aspx) (by Jonathan Kehayias)


## Microsoft SQL Server 2019 Builds
<a id="microsoft-sql-server-2019-builds"></a>
More additional information about latest vNext SQL Server release you can find in this articles:
 - [What's new in SQL Server 2019](https://docs.microsoft.com/sql/sql-server/what-s-new-in-sql-server-ver15?view=sql-server-ver15#utf-8-support)
 - [What's New in the First Public CTP of SQL Server 2019](https://www.mssqltips.com/sqlservertip/5710/whats-new-in-the-first-public-ctp-of-sql-server-2019/)
 - [Froid: How SQL Server vNext Might Fix the Scalar Functions Problem](https://www.brentozar.com/archive/2018/01/froid-sql-server-vnext-might-fix-scalar-functions-problem/)
 - [What’s New in SQL Server 2019 System Tables](https://www.brentozar.com/archive/2018/09/whats-new-in-sql-server-2019-system-tables/)
 - [What’s New in SQL Server 2019’s sys.messages: More Unannounced Features](https://www.brentozar.com/archive/2018/09/whats-new-in-sql-server-2019s-sys-messages-more-unannounced-features/)
 - [What’s New in SQL Server 2019: Faster Table Variables (And New Parameter Sniffing Issues)](https://www.brentozar.com/archive/2018/09/sql-server-2019-faster-table-variables-and-new-parameter-sniffing-issues/)
 - [What’s New in SQL Server 2019: Adaptive Memory Grants](https://www.brentozar.com/archive/2018/09/whats-new-in-sql-server-2019-adaptive-memory-grants/)
 - [Leaked: SQL Server 2019 Big Data Clusters Introduction Video](https://www.brentozar.com/archive/2018/09/leaked-sql-server-2019-big-data-clusters-introduction-video/)
 - [Native UTF-8 Support in SQL Server 2019: Savior, False Prophet, or Both?](https://sqlquantumleap.com/2018/09/28/native-utf-8-support-in-sql-server-2019-savior-false-prophet-or-both/)

Here is the latest output from `SELECT @@VERSION` for SQL Server 2019 CTP Developer Edition:

```
Microsoft SQL Server 2019 (RTM-CU6) (KB4563110) - 15.0.4053.23 (X64)
   Jul 25 2020 11:26:55
   Copyright (C) 2019 Microsoft Corporation
   Developer Edition (64-bit) on …
```

| Build         | File version      | Branch | Type | Info       | KB      | Description/Link                                          | Release Date | Build Date | Fixes | Public | Size, Mb | DB Version |
|---------------|-------------------|--------|------|------------|---------|-----------------------------------------------------------|--------------|------------|------:|-------:|---------:|-----------:|
| 15.0.4053.23  | 2019.150.4053.23  | RTM    | CU   | **Latest** | 4563110 | [Cumulative Update 6 for SQL Server 2019]                 | 2020-08-04   | 2020-07-25 |    51 |     42 |      604 |        904 |
| 15.0.4043.16  | 2019.150.4043.16  | RTM    | CU   |            | 4552255 | [Cumulative Update 5 for SQL Server 2019]                 | 2020-06-22   | 2020-06-10 |    86 |     58 |      603 |        904 |
| 15.0.4033.1   | 2019.150.4033.1   | RTM    | CU   |            | 4548597 | [Cumulative Update 4 for SQL Server 2019]                 | 2020-03-31   | 2020-03-04 |    50 |     38 |      571 |        904 |
| 15.0.4023.6   | 2019.150.4023.6   | RTM    | CU   |            | 4538853 | [Cumulative Update 3 for SQL Server 2019]                 | 2020-03-12   | 2020-02-20 |    56 |     11 |      572 |        904 |
| 15.0.4013.40  | 2019.150.4013.40  | RTM    | CU   |            | 4536075 | [Cumulative Update 2 for SQL Server 2019]                 | 2020-02-07   | 2020-02-03 |   134 |     88 |      537 |        904 |
| 15.0.4003.23  | 2019.150.4003.23  | RTM    | CU   |            | 4527376 | [Cumulative Update 1 for SQL Server 2019]                 | 2020-01-07   | 2019-12-06 |    83 |     62 |      452 |        904 |
| 15.0.2070.41  | 2019.150.2070.41  | RTM    | GDR  |            | 4517790 | [Servicing Update for SQL Server 2019 RTM]                | 2019-11-04   | 2019-10-28 |     1 |      1 |      452 |        904 |
| 15.0.2000.5   | 2019.150.2000.5   | RTM    | RTM  |            |         | [Microsoft SQL Server 2019 RTM]                           | 2019-11-04   | 2019-09-24 |       |        |     1360 |        904 |
| 15.0.1900.47  | 2019.150.1900.47  | CTP    | RC   |            |         | Microsoft SQL Server 2019 Release Candidate 1.1 (RC1.1)   | 2019-08-28   | 2019-08-17 |       |        |     1360 |        904 |
| 15.0.1900.25  | 2019.150.1900.25  | CTP    | RC   |            |         | Microsoft SQL Server 2019 Release Candidate 1 (RC1)       | 2019-08-21   | 2019-08-17 |       |        |     1360 |        904 |
| 15.0.1800.32  | 2019.150.1800.32  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP3.2                          | 2019-07-24   | 2019-07-18 |       |        |     1358 |        904 |
| 15.0.1700.0   | 2019.150.1700.0   | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP3.1                          | 2019-06-26   | 2019-06-20 |       |        |     1341 |        902 |
| 15.0.1600.8   | 2019.150.1600.8   | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP3.0                          | 2019-05-22   | 2019-05-17 |       |        |     1339 |        902 |
| 15.0.1500.28  | 2019.150.1500.28  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.5                          | 2019-04-23   | 2019-04-16 |       |        |     1340 |        897 |
| 15.0.1400.75  | 2019.150.1400.75  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.4                          | 2019-03-27   | 2019-03-17 |       |        |     1331 |        897 |
| 15.0.1300.359 | 2019.150.1200.359 | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.3                          | 2019-03-01   | 2019-02-16 |       |        |     1331 |        897 |
| 15.0.1200.24  | 2018.150.1200.24  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.2                          | 2018-12-11   | 2018-11-02 |       |        |     1302 |        896 |
| 15.0.1100.94  | 2018.150.1100.34  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.1                          | 2018-11-06   | 2018-11-02 |       |        |     1299 |        896 |
| 15.0.1000.34  | 2018.150.1000.34  | CTP    | CTP  |            |         | Microsoft SQL Server 2019 CTP2.0                          | 2018-09-24   | 2018-09-18 |       |        |     1532 |        895 |

[Cumulative Update 6 for SQL Server 2019]:https://support.microsoft.com/help/4563110
[Cumulative Update 5 for SQL Server 2019]:https://support.microsoft.com/help/4552255
[Cumulative Update 4 for SQL Server 2019]:https://support.microsoft.com/help/4548597
[Cumulative Update 3 for SQL Server 2019]:https://support.microsoft.com/help/4538853
[Cumulative Update 2 for SQL Server 2019]:https://support.microsoft.com/help/4536075
[Cumulative Update 1 for SQL Server 2019]:https://support.microsoft.com/help/4527376
[Servicing Update for SQL Server 2019 RTM]:https://support.microsoft.com/help/4517790
[Microsoft SQL Server 2019 RTM]:https://www.microsoft.com/sql-server/sql-server-2019#Install


## Microsoft SQL Server 2017 Builds
<a id="microsoft-sql-server-2017-builds"></a>

All SQL Server 2017 CU downloads: [Catalog Update Microsoft SQL Server 2017](http://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202017)

Here is the latest output from `SELECT @@VERSION` for SQL Server 2017 Developer Edition:

```
Microsoft SQL Server 2017 (RTM-CU21) (KB4557397) - 14.0.3335.7 (X64)
   Jun 13 2020 14:53:45
   Copyright (C) 2017 Microsoft Corporation
   Developer Edition (64-bit) on …
```

| Build         | File version      | Branch | Type | Info                              | KB      | Description/Link                                                                    | Release Date | Build Date | Fixes | Public | Size, Mb |
|---------------|-------------------|--------|------|-----------------------------------|---------|-------------------------------------------------------------------------------------|--------------|------------|------:|-------:|---------:|
| 14.0.3335.7   | 2017.140.3335.7   | RTM    | CU   | **Latest CU**                     | 4535007 | [Microsoft SQL Server 2017 CU21]                                                    | 2020-07-01   | 2020-06-13 |    35 |     33 |      533 |
| 14.0.3294.2   | 2017.140.3294.2   | RTM    | CU   |                                   | 4541283 | [Microsoft SQL Server 2017 CU20]                                                    | 2020-04-07   | 2020-03-14 |    40 |     36 |      530 |
| 14.0.3281.6   | 2017.140.3281.6   | RTM    | CU   |                                   | 4535007 | [Microsoft SQL Server 2017 CU19]                                                    | 2020-02-05   | 2020-01-23 |    38 |     31 |      530 |
| 14.0.3257.3   | 2017.140.3257.3   | RTM    | CU   |                                   | 4527377 | [Microsoft SQL Server 2017 CU18]                                                    | 2019-12-09   | 2019-11-16 |    35 |     28 |      529 |
| 14.0.3238.1   | 2017.140.3238.1   | RTM    | CU   |                                   | 4515579 | [Microsoft SQL Server 2017 CU17]                                                    | 2019-10-01   | 2019-09-14 |    41 |     34 |      528 |
| 14.0.3223.3   | 2017.140.3223.3   | RTM    | CU   |                                   | 4508218 | [Microsoft SQL Server 2017 CU16]                                                    | 2019-08-01   | 2019-07-13 |    50 |     37 |      529 |
| 14.0.3208.1   | 2017.140.3208.1   | RTM    | COD  |                                   | 4510083 | [On-demand hotfix update package 2 for SQL Server 2017 Cumulative update 15 (CU15)] | 2019-07-09   | 2019-06-26 |     2 |      2 |      528 |
| 14.0.3192.2   | 2017.140.3192.2   | RTM    | GDR  | CVE-2019-1068                     | 4505225 | [Security update for SQL Server 2017 CU15 GDR: July 9, 2019]                        | 2019-07-09   | 2019-06-26 |     1 |      1 |      528 |
| 14.0.3164.1   | 2017.140.3164.1   | RTM    | COD  |                                   | 4506633 | [On-demand hotfix update package for SQL Server 2017 Cumulative update 15 (CU15)]   | 2019-06-20   | 2019-05-16 |     1 |      1 |      528 |
| 14.0.3162.1   | 2017.140.3162.1   | RTM    | CU   |                                   | 4498951 | [Microsoft SQL Server 2017 CU15]                                                    | 2019-05-23   | 2019-05-16 |    52 |     45 |      528 |
| 14.0.3103.1   | 2017.140.3103.1   | RTM    | GDR  | CVE-2019-0819                     | 4494352 | [Description of the security update for SQL Server 2017 CU 14 GDR: May 14, 2019]    | 2019-05-14   | 2019-03-23 |     1 |      1 |      491 |
| 14.0.3076.1   | 2017.140.3076.1   | RTM    | CU   |                                   | 4484710 | [Microsoft SQL Server 2017 CU14]                                                    | 2019-03-25   | 2019-03-12 |    51 |     34 |      491 |
| 14.0.3049.1   | 2017.140.3049.1   | RTM    | COD  |                                   | 4483666 | [On-demand hotfix update package for SQL Server 2017 CU13]                          | 2019-01-08   | 2018-12-15 |     3 |      3 |      488 |
| 14.0.3048.4   | 2017.140.3048.4   | RTM    | CU   | **Withdrawn**                     | 4466404 | [Microsoft SQL Server 2017 CU13]                                                    | 2018-12-18   | 2018-12-01 |    62 |     50 |      488 |
| 14.0.3045.24  | 2017.140.3045.24  | RTM    | CU   |                                   | 4464082 | [Microsoft SQL Server 2017 CU12]                                                    | 2018-10-24   | 2018-10-19 |    22 |     18 |      488 |
| 14.0.3038.14  | 2017.140.3038.14  | RTM    | CU   |                                   | 4462262 | [Microsoft SQL Server 2017 CU11]                                                    | 2018-09-20   | 2018-09-14 |    21 |     14 |      487 |
| 14.0.3037.1   | 2017.140.3037.1   | RTM    | CU   |                                   | 4342123 | [Microsoft SQL Server 2017 CU10]                                                    | 2018-08-27   | 2018-07-27 |    30 |     22 |      486 |
| 14.0.3035.2   | 2017.140.3035.2   | RTM    | COD  | CVE-2018-8273                     | 4293805 | [Security update for SQL Server 2017 CU: August 14, 2018]                           | 2018-08-14   | 2018-07-07 |     1 |      1 |      486 |
| 14.0.3030.27  | 2017.140.3030.27  | RTM    | CU   |                                   | 4341265 | [Microsoft SQL Server 2017 CU9]                                                     | 2018-07-18   | 2018-06-30 |    27 |     18 |      486 |
| 14.0.3029.16  | 2017.140.3029.16  | RTM    | CU   |                                   | 4338363 | [Microsoft SQL Server 2017 CU8]                                                     | 2018-06-21   | 2018-06-13 |    60 |     31 |      475 |
| 14.0.3026.27  | 2017.140.3026.27  | RTM    | CU   |                                   | 4229789 | [Microsoft SQL Server 2017 CU7]                                                     | 2018-05-24   | 2018-05-10 |    47 |     28 |      473 |
| 14.0.3025.34  | 2017.140.3025.34  | RTM    | CU   |                                   | 4101464 | [Microsoft SQL Server 2017 CU6]                                                     | 2018-04-19   | 2018-03-03 |    39 |     39 |      473 |
| 14.0.3023.8   | 2017.140.3023.8   | RTM    | CU   |                                   | 4092643 | [Microsoft SQL Server 2017 CU5]                                                     | 2018-03-20   | 2018-03-03 |    22 |     13 |      472 |
| 14.0.3022.28  | 2017.140.3022.28  | RTM    | CU   |                                   | 4056498 | [Microsoft SQL Server 2017 CU4]                                                     | 2018-02-20   | 2018-02-10 |    81 |     55 |      472 |
| 14.0.3015.40  | 2017.140.3015.40  | RTM    | CU   |                                   | 4052987 | [Microsoft SQL Server 2017 CU3]                                                     | 2017-01-03   | 2017-12-23 |    14 |     13 |      459 |
| 14.0.3008.27  | 2017.140.3008.27  | RTM    | CU   |                                   | 4052574 | [Microsoft SQL Server 2017 CU2]                                                     | 2017-11-28   | 2017-11-16 |    56 |     33 |      276 |
| 14.0.3006.16  | 2017.140.3006.16  | RTM    | CU   |                                   | 4038634 | [Microsoft SQL Server 2017 CU1]                                                     | 2017-10-24   | 2017-10-19 |    72 |     68 |      250 |
| 14.0.2027.2   | 2017.140.2027.2   | RTM    | GDR  | CVE-2019-1068                     | 4505224 | [Security update for SQL Server 2017 GDR: July 9, 2019]                             | 2019-07-09   | 2019-06-15 |     1 |      1 |      447 |
| 14.0.2014.14  | 2017.140.2014.14  | RTM    | GDR  | CVE-2019-0819                     | 4494351 | [Security update for SQL Server 2017 GDR: May 14, 2019]                             | 2019-05-14   | 2019-04-05 |     1 |      1 |      447 |
| 14.0.2002.14  | 2017.140.2002.14  | RTM    | GDR  | CVE-2018-8273                     | 4293803 | [Security update for SQL Server 2017 GDR: August 14, 2018]                          | 2018-08-14   | 2018-07-21 |     1 |      1 |      433 |
| 14.0.2000.63  | 2017.140.2000.63  | RTM    | GDR  | CVE-2017-5715,2017-5753,2017-5754 | 4057122 | [Security update for SQL Server 2017 GDR: January 3, 2018]                          | 2018-01-03   | 2017-12-23 |     1 |      1 |      431 |
| 14.0.1000.169 | 2017.140.1000.169 | RTM    | RTM  |                                   |         | [Microsoft SQL Server 2017 RTM]                                                     | 2017-10-02   | 2017-08-23 |       |        |     1475 |
| 14.0.900.75   | 2017.140.900.75   | RC     | RC   |                                   |         | Microsoft SQL Server 2017 Release Candidate 2                                       | 2017-08-02   | 2017-07-27 |       |        |     1473 |
| 14.0.800.90   | 2017.140.800.90   | RC     | RC   |                                   |         | Microsoft SQL Server 2017 Release Candidate 1                                       | 2017-07-17   | 2017-07-11 |       |        |     1473 |
| 14.0.600.250  | 2017.140.600.250  | CTP    | CTP  |                                   |         | Microsoft SQL Server 2017 Community Technology Preview 2.1 (CTP2.1)                 | 2017-05-17   | 2017-05-10 |       |        |     1606 |
| 14.0.500.272  | 2017.140.500.272  | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 2.0 (CTP2.0)                | 2017-04-19   | 2017-04-13 |       |        |     1721 |
| 14.0.405.198  | 2017.140.405.198  | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 1.4 (CTP1.4)                | 2017-03-17   | 2017-03-11 |       |        |     2001 |
| 14.0.304.138  | 2016.140.304.138  | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 1.3 (CTP1.3)                | 2017-02-17   | 2017-02-14 |       |        |     1978 |
| 14.0.200.24   | 2016.140.200.24   | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 1.2 (CTP1.2)                | 2017-01-18   | 2017-01-11 |       |        |     1975 |
| 14.0.100.187  | 2016.140.100.187  | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 1.1 (CTP1.1)                | 2016-12-16   | 2016-12-11 |       |        |     1975 |
| 14.0.1.246    | 2016.140.1.246    | CTP    | CTP  |                                   |         | Microsoft SQL Server vNext Community Technology Preview 1 (CTP1)                    | 2016-11-16   | 2016-11-02 |       |        |     1983 |

[Microsoft SQL Server 2017 CU21]:https://support.microsoft.com/help/4557397
[Microsoft SQL Server 2017 CU20]:https://support.microsoft.com/help/4541283
[Microsoft SQL Server 2017 CU19]:https://support.microsoft.com/help/4535007
[Microsoft SQL Server 2017 CU18]:https://support.microsoft.com/help/4527377
[Microsoft SQL Server 2017 CU17]:https://support.microsoft.com/help/4515579
[Microsoft SQL Server 2017 CU16]:https://support.microsoft.com/help/4508218
[On-demand hotfix update package 2 for SQL Server 2017 Cumulative update 15 (CU15)]:https://support.microsoft.com/help/4510083/
[Security update for SQL Server 2017 CU15 GDR: July 9, 2019]:https://support.microsoft.com/help/4505225/
[On-demand hotfix update package for SQL Server 2017 Cumulative update 15 (CU15)]:https://support.microsoft.com/help/4506633/
[Microsoft SQL Server 2017 CU15]:https://support.microsoft.com/help/4498951/
[Description of the security update for SQL Server 2017 CU 14 GDR: May 14, 2019]:https://support.microsoft.com/help/4494352
[Microsoft SQL Server 2017 CU14]:https://support.microsoft.com/help/4484710
[On-demand hotfix update package for SQL Server 2017 CU13]:https://support.microsoft.com/help/4483666
[Microsoft SQL Server 2017 CU13]:https://support.microsoft.com/help/4466404
[Microsoft SQL Server 2017 CU12]:https://support.microsoft.com/help/4464082
[Microsoft SQL Server 2017 CU11]:https://support.microsoft.com/help/4462262
[Microsoft SQL Server 2017 CU10]:https://support.microsoft.com/help/4342123
[Security update for SQL Server 2017 CU: August 14, 2018]:https://support.microsoft.com/help/4293805
[Microsoft SQL Server 2017 CU9]:https://support.microsoft.com/help/4341265
[Microsoft SQL Server 2017 CU8]:https://support.microsoft.com/help/4338363
[Microsoft SQL Server 2017 CU7]:https://support.microsoft.com/help/4229789
[Microsoft SQL Server 2017 CU6]:https://support.microsoft.com/help/4101464
[Microsoft SQL Server 2017 CU5]:https://support.microsoft.com/help/4092643
[Microsoft SQL Server 2017 CU4]:https://support.microsoft.com/help/4056498
[Microsoft SQL Server 2017 CU3]:https://support.microsoft.com/help/4052987
[Microsoft SQL Server 2017 CU2]:https://support.microsoft.com/help/4052574
[Security update for SQL Server 2017 GDR: July 9, 2019]:https://support.microsoft.com/help/4505224
[Security update for SQL Server 2017 GDR: May 14, 2019]:https://support.microsoft.com/help/4494351
[Microsoft SQL Server 2017 CU1]:https://support.microsoft.com/help/4038634
[Security update for SQL Server 2017 GDR: August 14, 2018]:https://support.microsoft.com/help/4293803
[Security update for SQL Server 2017 GDR: January 3, 2018]:https://support.microsoft.com/help/4057122
[Microsoft SQL Server 2017 RTM]:https://www.microsoft.com/sql-server/sql-server-downloads


<a id="microsoft-sql-server-2016-builds"></a>
## Microsoft SQL Server 2016 Builds

All SQL Server 2016 CU downloads: [Catalog Update Microsoft SQL Server 2016](http://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202016)

Here is the latest output from `SELECT @@VERSION` for SQL Server 2016 SP2 Developer Edition on Windows:
```
Microsoft SQL Server 2016 (SP2-CU14) (KB4564903) - 13.0.5830.85 (X64)
   Jul 31 2020 18:47:07
   Copyright (c) Microsoft Corporation
   Developer Edition (64-bit) on …
```

| Build         | File version      |Branch | Type | Info                              | KB      | Description/Link                                                                                                       | Release Date | Build Date | Fixes | Public | Size, Mb |
|---------------|-------------------|-------|------|-----------------------------------|---------|------------------------------------------------------------------------------------------------------------------------|--------------|------------|------:|-------:|---------:|
| 13.0.5830.85  | 2015.131.5830.85  | SP2   | CU   | **Latest CU SP2**                 | 4564903 | [Cumulative Update 14 for SQL Server 2016 SP2]                                                                         | 2020-05-28   | 2020-08-06 |    18 |     16 |      752 |
| 13.0.5820.21  | 2015.131.5820.21  | SP2   | CU   |                                   | 4549825 | [Cumulative Update 13 for SQL Server 2016 SP2]                                                                         | 2020-05-28   | 2020-05-23 |    29 |     26 |      748 |
| 13.0.5698.0   | 2015.131.5698.0   | SP2   | CU   |                                   | 4536648 | [Cumulative Update 12 for SQL Server 2016 SP2]                                                                         | 2020-02-25   | 2020-02-16 |    39 |     33 |      746 |
| 13.0.5622.0   | 2015.131.5622.0   | SP2   | GDR  | CVE-2020-0618                     | 4535706 | [Description of the security update for SQL Server 2016 SP2 CU11: February 11, 2020]                                   | 2020-02-11   | 2019-11-28 |     1 |      1 |      752 |
| 13.0.5598.27  | 2015.131.5598.27  | SP2   | CU   |                                   | 4527378 | [Cumulative Update 11 for SQL Server 2016 SP2]                                                                         | 2019-12-09   | 2019-11-28 |    29 |     26 |      752 |
| 13.0.5492.2   | 2015.131.5492.2   | SP2   | CU   |                                   | 4524334 | [Cumulative Update 10 for SQL Server 2016 SP2]                                                                         | 2019-10-08   | 2019-10-05 |    21 |     21 |      752 |
| 13.0.5479.0   | 2015.131.5479.0   | SP2   | CU   | **Withdrawn**                     | 4515435 | Cumulative Update 9 for SQL Server 2016 SP2                                                                            | 2019-09-30   | 2019-09-13 |    21 |     21 |      752 |
| 13.0.5426.0   | 2015.131.5426.0   | SP2   | CU   |                                   | 4505830 | [Cumulative Update 8 for SQL Server 2016 SP2]                                                                          | 2019-07-31   | 2019-06-15 |    33 |     28 |      752 |
| 13.0.5382.0   | 2015.131.5382.0   | SP2   | COD  |                                   | 4510807 | [On-demand hotfix update package 2 for SQL Server 2016 Service Pack 2 (SP2) Cumulative update 7 (CU7)]                 | 2019-07-09   | 2019-06-15 |     2 |      2 |      714 |
| 13.0.5366.0   | 2015.131.5366.0   | SP2   | GDR  | CVE-2019-1068                     | 4505222 | [Security update for SQL Server 2016 SP2 CU7 GDR: July 9, 2019]                                                        | 2019-07-09   | 2019-06-15 |     2 |      2 |      714 |
| 13.0.5343.1   | 2015.131.5343.1   | SP2   | COD  |                                   | 4508636 | [On-demand hotfix update package for SQL Server 2016 Service Pack 2 (SP2) Cumulative update 7 (CU7)]                   | 2019-06-24   | 2019-06-15 |     2 |      2 |      714 |
| 13.0.5337.0   | 2015.131.5337.0   | SP2   | CU   |                                   | 4495256 | [Cumulative Update 7 for SQL Server 2016 SP2]                                                                          | 2019-05-22   | 2019-05-16 |    28 |     27 |      714 |
| 13.0.5292.0   | 2015.131.5292.0   | SP2   | CU   |                                   | 4488536 | [Cumulative Update 6 for SQL Server 2016 SP2]                                                                          | 2019-03-19   | 2019-03-12 |    29 |     24 |      714 |
| 13.0.5270.0   | 2015.131.5270.0   | SP2   | COD  |                                   | 4490133 | [On-demand hotfix update package for SQL Server 2016 SP2 CU5]                                                          | 2019-02-14   | 2019-02-08 |     1 |      1 |      712 |
| 13.0.5264.1   | 2015.131.5264.1   | SP2   | CU   |                                   | 4475776 | [Cumulative Update 5 for SQL Server 2016 SP2]                                                                          | 2019-01-23   | 2019-01-11 |    52 |     43 |      712 |
| 13.0.5239.0   | 2015.131.5239.0   | SP2   | COD  |                                   | 4482972 | [On-demand hotfix update package 2 for SQL Server 2016 SP2 CU4]                                                        | 2018-12-20   | 2018-12-03 |     3 |      3 |      690 |
| 13.0.5233.0   | 2015.131.5233.0   | SP2   | CU   |                                   | 4464106 | [Cumulative Update 4 for SQL Server 2016 SP2]                                                                          | 2018-11-13   | 2018-11-03 |    42 |     36 |      690 |
| 13.0.5216.0   | 2015.131.5216.0   | SP2   | CU   |                                   | 4458871 | [Cumulative Update 3 for SQL Server 2016 SP2]                                                                          | 2018-09-21   | 2018-09-14 |    41 |     27 |      688 |
| 13.0.5201.2   | 2015.131.5201.2   | SP2   | CU   | CVE-2018-8273                     | 4458621 | [Security update for SQL Server 2016 SP2 CU: August 19, 2018]                                                          | 2018-08-19   | 2018-08-18 |     1 |      0 |      672 |
| 13.0.5161.0   | 2015.131.5161.0   | SP2   | CU   | **Withdrawn**,CVE-2018-8273       | 4293807 | [Security update for SQL Server 2016 SP2 (CU): August 14, 2018]                                                        | 2018-08-14   | 2018-07-18 |     1 |      0 |      672 |
| 13.0.5153.0   | 2015.131.5153.0   | SP2   | CU   |                                   | 4340355 | [Cumulative Update 2 for SQL Server 2016 SP2]                                                                          | 2018-07-16   | 2018-06-29 |    29 |     21 |      671 |
| 13.0.5149.0   | 2015.131.5149.0   | SP2   | CU   |                                   | 4135048 | [Cumulative Update 1 for SQL Server 2016 SP2]                                                                          | 2018-05-30   | 2018-05-19 |    45 |     28 |      549 |
| 13.0.5102.14  | 2015.131.5102.14  | SP2   | GDR  | CVE-2019-1332,2020-0618           | 4532097 | [Security update for SQL Server 2016 SP2 GDR: February 11, 2020]                                                       | 2020-02-11   | 2019-06-15 |     1 |      1 |      495 |
| 13.0.5101.9   | 2015.131.5101.9   | SP2   | GDR  | CVE-2019-1068                     | 4505220 | [Security update for SQL Server 2016 SP2 GDR: July 9, 2019]                                                            | 2019-07-09   | 2019-06-15 |     2 |      2 |      491 |
| 13.0.5081.1   | 2015.131.5081.1   | SP2   | COD  | CVE-2018-8273                     | 4293802 | [Security update for SQL Server 2016 SP2 GDR: August 14, 2018]                                                         | 2018-05-30   | 2018-05-19 |     1 |      0 |      492 |
| 13.0.5026.0   | 2015.131.5026.0   | SP2   | SP   |                                   | 4052908 | [SQL Server 2016 Service Pack 2 release information]                                                                   | 2018-04-24   | 2018-03-18 |    50 |     50 |      774 |
| 13.0.4604.0   | 2015.130.4604.0   | SP1   | GDR  | **Latest CU SP1**,CVE-2019-1068   | 4505221 | [Security update for SQL Server 2016 SP1 CU15 GDR: July 9, 2019]                                                       | 2019-07-09   | 2019-06-15 |     2 |      2 |      761 |
| 13.0.4577.0   | 2015.130.4577.0   | SP1   | COD  |                                   | 4508471 | [On-demand hotfix update package for SQL Server 2016 Service Pack 1 (SP1) Cumulative update 15 (CU15)]                 | 2019-06-20   | 2019-06-15 |     2 |      2 |      761 |
| 13.0.4574.0   | 2015.130.4574.0   | SP1   | CU   |                                   | 4495257 | [Cumulative Update 15 for SQL Server 2016 SP1]                                                                         | 2019-05-16   | 2019-04-28 |     7 |      7 |      761 |
| 13.0.4560.0   | 2015.130.4560.0   | SP1   | CU   |                                   | 4488535 | [Cumulative update 14 (CU14) for SQL Server 2016 Service Pack 1]                                                       | 2019-03-19   | 2019-03-12 |     7 |      7 |      761 |
| 13.0.4550.1   | 2015.130.4550.1   | SP1   | CU   |                                   | 4475775 | [Cumulative Update 13 for SQL Server 2016 SP1]                                                                         | 2019-01-23   | 2019-01-11 |    12 |      9 |      761 |
| 13.0.4541.0   | 2015.130.4541.0   | SP1   | CU   |                                   | 4464343 | [Cumulative Update 12 for SQL Server 2016 SP1]                                                                         | 2018-11-13   | 2018-10-27 |    21 |     16 |      761 |
| 13.0.4531.0   | 2015.130.4531.0   | SP1   | COD  |                                   | 4465443 | [FIX: The "modification_counter" in DMV sys.dm_db_stats_properties shows incorrect value when partitions are merged]   | 2018-09-27   | 2018-09-22 |     1 |      1 |      759 |
| 13.0.4528.0   | 2015.130.4528.0   | SP1   | CU   |                                   | 4459676 | [Cumulative Update 11 for SQL Server 2016 SP1]                                                                         | 2018-09-18   | 2018-08-31 |    14 |      8 |      762 |
| 13.0.4522.0   | 2015.130.4522.0   | SP1   | CU   | **Withdrawn**,CVE-2018-8273       | 4293808 | [Security update for SQL Server 2016 SP1 (CU): August 14, 2018]                                                        | 2018-08-14   | 2018-07-18 |     1 |      0 |      774 |
| 13.0.4514.0   | 2015.130.4514.0   | SP1   | CU   |                                   | 4341569 | [Cumulative Update 10 for SQL Server 2016 SP1]                                                                         | 2018-07-16   | 2018-06-23 |    26 |     21 |      761 |
| 13.0.4502.0   | 2015.130.4502.0   | SP1   | CU   |                                   | 4100997 | [Cumulative Update 9 for SQL Server 2016 SP1]                                                                          | 2018-05-30   | 2018-05-15 |    39 |     25 |      761 |
| 13.0.4474.0   | 2015.130.4474.0   | SP1   | CU   |                                   | 4077064 | [Cumulative Update 8 for SQL Server 2016 SP1]                                                                          | 2018-03-19   | 2018-02-24 |    57 |     37 |      760 |
| 13.0.4466.4   | 2015.130.4466.4   | SP1   | CU   |                                   | 4057119 | [Cumulative Update 7 for SQL Server 2016 SP1]                                                                          | 2018-01-03   | 2017-11-09 |    15 |     14 |      758 |
| 13.0.4457.0   | 2015.130.4457.0   | SP1   | CU   |                                   | 4037354 | [Cumulative Update 6 for SQL Server 2016 SP1]                                                                          | 2017-11-21   | 2017-11-09 |    55 |     41 |      689 |
| 13.0.4451.0   | 2015.130.4451.0   | SP1   | CU   |                                   | 4040714 | [Cumulative Update 5 for SQL Server 2016 SP1]                                                                          | 2017-09-18   | 2017-09-06 |    49 |     44 |      689 |
| 13.0.4446.0   | 2015.130.4446.0   | SP1   | CU   |                                   | 4024305 | [Cumulative Update 4 for SQL Server 2016 SP1]                                                                          | 2017-08-08   | 2017-07-16 |    63 |     49 |      534 |
| 13.0.4435.0   | 2015.130.4435.0   | SP1   | CU   |                                   | 4019916 | [Cumulative Update 3 for SQL Server 2016 SP1]                                                                          | 2017-05-15   | 2017-04-27 |    70 |     57 |      534 |
| 13.0.4422.0   | 2015.130.4422.0   | SP1   | CU   |                                   | 4013106 | [Cumulative Update 2 for SQL Server 2016 SP1]                                                                          | 2017-03-20   | 2017-03-06 |   117 |    100 |      415 |
| 13.0.4411.0   | 2015.130.4411.0   | SP1   | CU   |                                   | 3208177 | [Cumulative update 1 for SQL Server 2016 Service Pack 1]                                                               | 2017-01-18   | 2017-01-06 |    63 |     55 |      439 |
| 13.0.4259.0   | 2015.130.4223.10  | SP1   | GDR  | CVE-2019-1068                     | 4505219 | [Security update for SQL Server 2016 SP1 GDR: July 9, 2019]                                                            | 2019-07-09   | 2019-06-15 |     2 |      2 |      699 |
| 13.0.4224.16  | 2015.130.4224.16  | SP1   | CU   | CVE-2018-8273                     | 4458842 | [Security update for SQL Server 2016 SP1 GDR: August 22, 2018]                                                         | 2018-08-22   |            |     1 |      0 |      700 |
| 13.0.4223.10  | 2015.130.4223.10  | SP1   | CU   | **Withdrawn**,CVE-2018-8273       | 4293801 | [Security update for SQL Server 2016 SP1 GDR: August 14, 2018]                                                         | 2018-08-14   |            |     1 |      0 |          |
| 13.0.4210.6   | 2015.130.4210.6   | SP1   | CU   | CVE-2017-5715,2017-5753,2017-5754 | 4057118 | [Description of the security update for SQL Server 2016 SP1 GDR: January 3, 2018]                                      | 2018-01-03   |            |     1 |      0 |      696 |
| 13.0.4206.0   | 2015.130.4206.0   | SP1   | COD  |                                   | 4019089 | [Description of the security update for SQL Server 2016 Service Pack 1 GDR: August 8, 2017]                            | 2017-07-16   |            |     1 |      1 |      364 |
| 13.0.4202.0   | 2015.130.4202.0   | SP1   | COD  |                                   | 3210089 | [GDR update package for SQL Server 2016 SP1]                                                                           | 2016-12-16   | 2016-12-13 |     3 |      3 |      378 |
| 13.0.4199.0   | 2015.130.4199.0   | SP1   | COD  |                                   | 3207512 | [Important update for SQL Server 2016 SP1 Reporting Services]                                                          | 2016-11-23   | 2016-11-18 |     2 |      2 |      521 |
| 13.0.4001.0   | 2015.130.4001.0   | SP1   | SP   |                                   | 3182545 | [SQL Server 2016 Service Pack 1 release information]                                                                   | 2016-11-16   | 2016-10-29 |    33 |     33 |      552 |
| 13.0.2218.0   | 2015.130.2218.0   | RTM   | COD  | CVE-2017-5715,2017-5753,2017-5754 | 4058559 | [Security update for SQL Server 2016 CU: January 6, 2018]                                                              | 2018-01-06   |            |       |        |      918 |
| 13.0.2216.0   | 2015.130.2216.0   | RTM   | CU   | **Latest CU RTM**                 | 4037357 | [Cumulative Update 9 for SQL Server 2016]                                                                              | 2017-11-21   | 2017-11-09 |    26 |     21 |      865 |
| 13.0.2213.0   | 2015.130.2213.0   | RTM   | CU   |                                   | 4040713 | [Cumulative Update 8 for SQL Server 2016]                                                                              | 2017-09-18   | 2017-09-06 |    19 |     17 |      864 |
| 13.0.2210.0   | 2015.130.2210.0   | RTM   | CU   |                                   | 4024304 | [Cumulative Update 7 for SQL Server 2016]                                                                              | 2017-08-08   | 2017-07-16 |    33 |     30 |      815 |
| 13.0.2204.0   | 2015.130.2204.0   | RTM   | CU   |                                   | 4019914 | [Cumulative Update 6 for SQL Server 2016]                                                                              | 2017-05-15   | 2017-04-20 |    28 |     22 |      814 |
| 13.0.2197.0   | 2015.130.2197.0   | RTM   | CU   |                                   | 4013105 | [Cumulative Update 5 for SQL Server 2016]                                                                              | 2017-03-20   | 2017-02-25 |    56 |     47 |      700 |
| 13.0.2193.0   | 2015.130.2193.0   | RTM   | CU   |                                   | 3205052 | [Cumulative update 4 for SQL Server 2016]                                                                              | 2017-01-18   | 2017-01-06 |    65 |     57 |      699 |
| 13.0.2190.2   | 2015.130.2190.2   | RTM   | COD  |                                   | 3210110 | [On-demand hotfix update package for SQL Server 2016 CU3]                                                              | 2016-12-16   | 2016-12-13 |     3 |      3 |      691 |
| 13.0.2186.6   | 2015.130.2186.6   | RTM   | CU   |                                   | 3194717 | [MS16-136: Description of the security update for SQL Server 2016 CU]                                                  | 2016-11-08   | 2016-10-31 |    31 |     31 |      691 |
| 13.0.2186.6   | 2015.130.2186.6   | RTM   | CU   |                                   | 3205413 | [Cumulative update 3 for SQL Server 2016] **Duplicate KB3194717**                                                      | 2016-11-08   | 2016-10-31 |       |        |      691 |
| 13.0.2170.0   | 2015.130.2170.0   | RTM   | COD  |                                   | 3199171 | [On-demand hotfix update package for SQL Server 2016 CU2]                                                              | 2016-11-01   | 2016-10-11 |     4 |      4 |      689 |
| 13.0.2169.0   | 2015.130.2169.0   | RTM   | COD  |                                   | 3195813 | [On-demand hotfix update package for SQL Server 2016 CU2]                                                              | 2016-10-26   | 2016-10-05 |     4 |      4 |      689 |
| 13.0.2164.0   | 2015.130.2164.0   | RTM   | CU   |                                   | 3182270 | [Cumulative Update 2 for SQL Server 2016]                                                                              | 2016-09-22   | 2016-09-09 |    68 |     64 |      689 |
| 13.0.2149.0   | 2015.130.2149.0   | RTM   | CU   |                                   | 3164674 | [Cumulative Update 1 for SQL Server 2016]                                                                              | 2016-07-25   | 2016-07-11 |   192 |    146 |      665 |
| 13.0.1745.2   | 2015.130.1745.2   | RTM   | COD  | CVE-2017-5715,2017-5753,2017-5754 | 4058560 | [Description of the security update for SQL Server 2016 GDR: January 6, 2018]                                          | 2018-01-06   |            |       |        |      687 |
| 13.0.1742.0   | 2015.130.1742.0   | RTM   | COD  | CVE-2017-8516                     | 4019088 | [Security update for SQL Server 2016 RTM GDR: August 8, 2017]                                                          | 2017-08-08   |            |       |        |      451 |
| 13.0.1728.2   | 2015.130.1728.2   | RTM   | COD  |                                   | 3210111 | [GDR update package for SQL Server 2016 RTM]                                                                           | 2016-12-16   |            |       |        |      339 |
| 13.0.1722.0   | 2015.130.1722.0   | RTM   | COD  |                                   | 3194716 | [MS16-136: Description of the security update for SQL Server 2016 GDR]                                                 | 2016-11-08   | 2016-10-31 |     3 |      3 |      342 |
| 13.0.1711.0   | 2015.130.1711.0   | RTM   | COD  |                                   | 3179258 | [Processing a partition causes data loss on other partitions after the database is restored in SQL Server 2016 (1200)] | 2016-08-17   | 2016-07-30 |       |        |      282 |
| 13.0.1708.0   | 2015.130.1708.0   | RTM   | COD  |                                   | 3164398 | [Critical update for SQL Server 2016 MSVCRT prerequisites]                                                             | 2016-06-04   | 2016-06-02 |       |        |      265 |
| 13.0.1601.5   | 2015.130.1601.5   | RTM   | RTM  |                                   |         | [Microsoft SQL Server 2016 RTM]                                                                                        | 2016-06-01   | 2016-04-29 |       |        |     2050 |
| 13.0.1400.361 | 2015.130.1400.361 | RC    | RC   |                                   |         | Microsoft SQL Server 2016 Community Technology Release Candidate 3 (RC3)                                               | 2016-04-15   | 2016-04-09 |       |        |     2114 |
| 13.0.1300.275 | 2015.130.1300.275 | RC    | RC   |                                   |         | Microsoft SQL Server 2016 Community Technology Release Candidate 2 (RC2)                                               | 2016-04-01   | 2016-03-26 |       |        |     2101 |
| 13.0.1200.242 | 2015.130.1200.242 | RC    | RC   |                                   |         | Microsoft SQL Server 2016 Community Technology Release Candidate 1 (RC1)                                               | 2016-03-18   | 2016-03-10 |       |        |     2083 |
| 13.0.1100.288 | 2015.130.1100.288 | RC    | RC   |                                   |         | Microsoft SQL Server 2016 Community Technology Release Candidate 0 (RC0)                                               | 2016-03-07   | 2016-02-29 |       |        |          |
| 13.0.1000.281 | 2015.130.1000.281 | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 3.3 (CTP3.3)                                                    | 2016-02-03   | 2016-01-28 |       |        |          |
| 13.0.900.73   | 2015.130.900.73   | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 3.2 (CTP3.2)                                                    | 2015-12-17   | 2015-12-10 |       |        |          |
| 13.0.801.12   | 2015.130.801.12   | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 3.1 (CTP3.1 refresh)                                            | 2015-12-05   | 2015-12-01 |       |        |          |
| 13.0.801.111  | 2015.130.801.111  | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 3.1 (CTP3.1)                                                    | 2015-11-30   | 2015-11-21 |       |        |          |
| 13.0.700.242  | 2015.130.700.242  | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 3.0 (CTP3.0)                                                    | 2015-10-29   | 2015-10-26 |       |        |          |
| 13.0.600.65   | 2015.130.600.65   | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 2.4 (CTP2.4)                                                    | 2015-09-30   | 2015-09-20 |       |        |          |
| 13.0.500.53   | 2015.130.500.53   | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 2.3 (CTP2.3)                                                    | 2015-08-28   | 2015-08-24 |       |        |          |
| 13.0.407.1    | 2015.130.407.1    | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2)                                                    | 2015-07-29   | 2015-07-22 |       |        |          |
| 13.0.400.91   | 2015.130.400.91   | CTP   | CTP  | **Withdrawn**                     |         | Microsoft SQL Server 2016 Community Technology Preview 2.2 (CTP2.2) (withdrawn)                                        | 2015-07-22   | 2015-07-16 |       |        |          |
| 13.0.300.44   | 2015.130.300.444  | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 2.1 (CTP2.1)                                                    | 2015-06-14   | 2015-06-12 |       |        |          |
| 13.0.200.172  | 2015.130.200.172  | CTP   | CTP  |                                   |         | Microsoft SQL Server 2016 Community Technology Preview 2 (CTP2)                                                        | 2015-05-26   | 2015-05-21 |       |        |          |

[Cumulative Update 14 for SQL Server 2016 SP2]:https://support.microsoft.com/4564903
[Cumulative Update 13 for SQL Server 2016 SP2]:https://support.microsoft.com/4549825
[Cumulative Update 12 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4536648
[Description of the security update for SQL Server 2016 SP2 CU11: February 11, 2020]:https://support.microsoft.com/help/4535706
[Cumulative Update 11 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4527378
[Cumulative Update 10 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4524334
[Cumulative Update 8 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4505830
[On-demand hotfix update package 2 for SQL Server 2016 Service Pack 2 (SP2) Cumulative update 7 (CU7)]:https://support.microsoft.com/help/4510807
[Security update for SQL Server 2016 SP2 CU7 GDR: July 9, 2019]:https://support.microsoft.com/help/4505222
[On-demand hotfix update package for SQL Server 2016 Service Pack 2 (SP2) Cumulative update 7 (CU7)]:https://support.microsoft.com/help/4508636
[Cumulative Update 7 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4495256
[Cumulative Update 6 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4488536
[On-demand hotfix update package for SQL Server 2016 SP2 CU5]:https://support.microsoft.com/help/4490133
[Cumulative Update 5 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4475776
[On-demand hotfix update package 2 for SQL Server 2016 SP2 CU4]:https://support.microsoft.com/help/4482972
[Cumulative Update 4 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4464106
[Cumulative Update 3 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4458871
[Security update for SQL Server 2016 SP2 CU: August 19, 2018]:https://support.microsoft.com/help/4458621
[Security update for SQL Server 2016 SP2 (CU): August 14, 2018]:https://support.microsoft.com/help/4293807/
[Cumulative Update 2 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4340355
[Cumulative Update 1 for SQL Server 2016 SP2]:https://support.microsoft.com/help/4135048
[Security update for SQL Server 2016 SP2 GDR: February 11, 2020]:https://support.microsoft.com/help/4532097
[Security update for SQL Server 2016 SP2 GDR: July 9, 2019]:https://support.microsoft.com/help/4505220
[Security update for SQL Server 2016 SP2 GDR: August 14, 2018]:https://support.microsoft.com/help/4293802
[Cumulative Update 12 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4464343
[FIX: The "modification_counter" in DMV sys.dm_db_stats_properties shows incorrect value when partitions are merged]:https://support.microsoft.com/help/4465443/
[SQL Server 2016 Service Pack 2 release information]:https://support.microsoft.com/help/4052908
[Security update for SQL Server 2016 SP1 CU15 GDR: July 9, 2019]:https://support.microsoft.com/help/4505221
[On-demand hotfix update package for SQL Server 2016 Service Pack 1 (SP1) Cumulative update 15 (CU15)]:https://support.microsoft.com/help/4508471
[Cumulative Update 15 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4495257
[Cumulative Update 14 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4488535
[Cumulative Update 13 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4475775
[Cumulative Update 11 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4459676
[Security update for SQL Server 2016 SP1 (CU): August 14, 2018]:https://support.microsoft.com/help/4293808
[Cumulative Update 10 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4341569
[Cumulative Update 9 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4100997
[Cumulative Update 8 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4077064
[Cumulative Update 7 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4057119
[Cumulative Update 6 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4037354
[Cumulative Update 5 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4040714
[Cumulative Update 4 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4024305
[Cumulative Update 3 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4019916
[Cumulative Update 2 for SQL Server 2016 SP1]:https://support.microsoft.com/help/4013106
[Cumulative update 1 for SQL Server 2016 Service Pack 1]:https://support.microsoft.com/help/3208177
[Security update for SQL Server 2016 SP1 GDR: July 9, 2019]:https://support.microsoft.com/help/4505219
[Security update for SQL Server 2016 SP1 GDR: August 22, 2018]:https://support.microsoft.com/help/4458842
[Security update for SQL Server 2016 SP1 GDR: August 14, 2018]:https://support.microsoft.com/help/4293801
[Description of the security update for SQL Server 2016 SP1 GDR: January 3, 2018]:https://support.microsoft.com/help/4057118
[Description of the security update for SQL Server 2016 Service Pack 1 GDR: August 8, 2017]:https://support.microsoft.com/help/4019089
[GDR update package for SQL Server 2016 SP1]:https://support.microsoft.com/help/3210089
[Important update for SQL Server 2016 SP1 Reporting Services]:https://support.microsoft.com/help/3207512
[SQL Server 2016 Service Pack 1 release information]:https://support.microsoft.com/help/3182545
[Security update for SQL Server 2016 CU: January 6, 2018]:https://support.microsoft.com/help/4058559
[Cumulative Update 9 for SQL Server 2016]:https://support.microsoft.com/help/4037357
[Cumulative Update 8 for SQL Server 2016]:https://support.microsoft.com/help/4040713
[Cumulative Update 7 for SQL Server 2016]:https://support.microsoft.com/help/4024304
[Cumulative Update 6 for SQL Server 2016]:https://support.microsoft.com/help/4019914
[Cumulative Update 5 for SQL Server 2016]:https://support.microsoft.com/help/4013105
[Cumulative update 4 for SQL Server 2016]:https://support.microsoft.com/help/3205052
[Description of the security update for SQL Server 2016 GDR: January 6, 2018]:https://support.microsoft.com/help/4058560
[Security update for SQL Server 2016 RTM GDR: August 8, 2017]:https://support.microsoft.com/help/4019088
[GDR update package for SQL Server 2016 RTM]:https://support.microsoft.com/help/3210111
[On-demand hotfix update package for SQL Server 2016 CU3]:https://support.microsoft.com/help/3210110
[MS16-136: Description of the security update for SQL Server 2016 CU]:https://support.microsoft.com/help/3194717
[Cumulative update 3 for SQL Server 2016]:https://support.microsoft.com/help/3205413
[On-demand hotfix update package for SQL Server 2016 CU2]:https://support.microsoft.com/help/3199171
[On-demand hotfix update package for SQL Server 2016 CU2]:https://support.microsoft.com/help/3195813
[Cumulative Update 2 for SQL Server 2016]:https://support.microsoft.com/help/3182270
[Cumulative Update 1 for SQL Server 2016]:https://support.microsoft.com/help/3164674
[MS16-136: Description of the security update for SQL Server 2016 GDR]:https://support.microsoft.com/help/3194716
[Processing a partition causes data loss on other partitions after the database is restored in SQL Server 2016 (1200)]:http://support.microsoft.com/help/3179258
[Critical update for SQL Server 2016 MSVCRT prerequisites]:https://support.microsoft.com/help/3164398
[Microsoft SQL Server 2016 RTM]:https://www.microsoft.com/evalcenter/evaluate-sql-server-2016


<a id="microsoft-sql-server-2014-builds"></a>
## Microsoft SQL Server 2014 Builds

⚠ End-of-Life: SQL Server 2014 reached [end of mainstream support on July 9th, 2019](https://support.microsoft.com/en-us/lifecycle/search?alpha=SQL%20Server%202014%20Service%20Pack%203).

All SQL Server 2014 CU downloads: [Catalog Update Microsoft SQL Server 2014](http://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202014)

Here is the latest output from `SELECT @@VERSION` for SQL Server 2014 Developer Edition on Windows:

```
Microsoft SQL Server 2014 (SP3-CU4) (KB4500181) - 12.0.6329.1 (X64)
   Jul 20 2019 21:42:29
   Copyright (c) Microsoft Corporation
   Developer Edition (64-bit) on …
```

| Build        | File version     | Branch | Type | Info                              | KB      | Description/Link                                                                                                           | Release Date | Fixes | Public | Size, Mb |
|--------------|------------------|--------|------|-----------------------------------|---------|----------------------------------------------------------------------------------------------------------------------------|--------------|------:|-------:|---------:|
| 12.0.6372.1  | 2014.120.6372.1  | SP3    | GDR  | CVE-2020-0618                     | 4535288 | [Security update for SQL Server 2014 SP3 CU4: February 11, 2020]                                                           | 2020-02-11   |     1 |      1 |      604 |
| 12.0.6329.1  | 2014.120.6329.1  | SP3    | CU   | **Latest CU SP3**                 | 4500181 | [Cumulative Update 4 for SQL Server 2014 SP3]                                                                              | 2019-07-29   |    25 |     19 |      658 |
| 12.0.6293.0  | 2014.120.6293.0  | SP3    | GDR  | CVE-2019-1068                     | 4505422 | [Security update for SQL Server 2014 SP3 CU3 GDR: July 9, 2019]                                                            | 2019-07-09   |     1 |      1 |      656 |
| 12.0.6259.0  | 2014.120.6259.0  | SP3    | CU   |                                   | 4491539 | [Cumulative Update 3 for SQL Server 2014 SP3]                                                                              | 2019-04-16   |     4 |      4 |      656 |
| 12.0.6214.1  | 2014.120.6214.1  | SP3    | CU   |                                   | 4482960 | [Cumulative Update 2 for SQL Server 2014 SP3]                                                                              | 2019-02-19   |     5 |      5 |      602 |
| 12.0.6205.1  | 2014.120.6205.1  | SP3    | CU   |                                   | 4470220 | [Cumulative Update 1 for SQL Server 2014 SP3]                                                                              | 2018-12-12   |    16 |     13 |      601 |
| 12.0.6118.4  | 2014.120.6118.4  | SP3    | GDR  | CVE-2020-0618                     | 4532095 | [Security update for SQL Server 2014 SP3 GDR: February 11, 2020]                                                           | 2020-02-11   |     1 |      1 |      656 |
| 12.0.6108.1  | 2014.120.6108.1  | SP3    | GDR  | CVE-2019-1068                     | 4505218 | [Security update for SQL Server 2014 SP3 GDR: July 9, 2019]                                                                | 2019-07-09   |     1 |      1 |      654 |
| 12.0.6024.0  | 2014.120.6024.0  | SP3    | SP   |                                   | 4022619 | [SQL Server 2014 Service Pack 3 release information]                                                                       | 2018-10-30   |    31 |      6 |      791 |
| 12.0.5687.1  | 2014.120.5687.1  | SP2    | CU   | **Latest CU SP2**                 | 4500180 | [Cumulative Update 18 for SQL Server 2014 SP2]                                                                             | 2019-07-29   |     7 |      4 |      681 |
| 12.0.5659.1  | 2014.120.5659.1  | SP2    | GDR  | CVE-2019-1068                     | 4505419 | [Security update for SQL Server 2014 SP2 CU17 GDR: July 9, 2019]                                                           | 2019-07-09   |     1 |      1 |      679 |
| 12.0.5632.1  | 2014.120.5632.1  | SP2    | CU   |                                   | 4491540 | [Cumulative Update 17 for SQL Server 2014 SP2]                                                                             | 2019-04-16   |     3 |      3 |      678 |
| 12.0.5626.1  | 2014.120.5626.1  | SP2    | CU   |                                   | 4482967 | [Cumulative Update 16 for SQL Server 2014 SP2]                                                                             | 2019-02-19   |     3 |      3 |      678 |
| 12.0.5605.1  | 2014.120.5605.1  | SP2    | SP   |                                   | 4469137 | [Cumulative Update 15 for SQL Server 2014 SP2]                                                                             | 2018-12-12   |     8 |      7 |      679 |
| 12.0.5600.1  | 2014.120.5600.1  | SP2    | CU   |                                   | 4459860 | [Cumulative Update 14 for SQL Server 2014 SP2]                                                                             | 2018-10-15   |     8 |      6 |      678 |
| 12.0.5590.1  | 2014.120.5590.1  | SP2    | CU   |                                   | 4456287 | [Cumulative Update 13 for SQL Server 2014 SP2]                                                                             | 2018-08-27   |     4 |      4 |      679 |
| 12.0.5589.7  | 2014.120.5589.7  | SP2    | CU   |                                   | 4130489 | [Cumulative Update 12 for SQL Server 2014 SP2]                                                                             | 2018-06-18   |    27 |     16 |      678 |
| 12.0.5579.0  | 2014.120.5579.0  | SP2    | CU   |                                   | 4077063 | [Cumulative Update 11 for SQL Server 2014 SP2]                                                                             | 2018-03-19   |    12 |     10 |      677 |
| 12.0.5571.0  | 2014.120.5571.0  | SP2    | CU   |                                   | 4052725 | [Cumulative Update 10 for SQL Server 2014 SP2]                                                                             | 2018-01-16   |     5 |      4 |      676 |
| 12.0.5563.0  | 2014.120.5563.0  | SP2    | CU   |                                   | 4055557 | [Cumulative Update 9 for SQL Server 2014 SP2]                                                                              | 2017-12-18   |     8 |      7 |      540 |
| 12.0.5557.0  | 2014.120.5557.0  | SP2    | CU   |                                   | 4037356 | [Cumulative Update 8 for SQL Server 2014 SP2]                                                                              | 2017-10-17   |    15 |      8 |      539 |
| 12.0.5556.0  | 2014.120.5556.0  | SP2    | CU   |                                   | 4032541 | [Cumulative Update 7 for SQL Server 2014 SP2]                                                                              | 2017-08-28   |    15 |      8 |      539 |
| 12.0.5553.0  | 2014.120.5553.0  | SP2    | CU   |                                   | 4019094 | [Cumulative Update 6 for SQL Server 2014 SP2]                                                                              | 2017-08-08   |    29 |     29 |      539 |
| 12.0.5546.0  | 2014.120.5546.0  | SP2    | CU   |                                   | 4013098 | [Cumulative Update 5 for SQL Server 2014 SP2]                                                                              | 2017-04-18   |    24 |     21 |      557 |
| 12.0.5540.0  | 2014.120.5540.0  | SP2    | CU   |                                   | 4010394 | [Cumulative Update 4 for SQL Server 2014 SP2]                                                                              | 2017-02-21   |    30 |     27 |      555 |
| 12.0.5538.0  | 2014.120.5538.0  | SP2    | CU   |                                   | 3204388 | [Cumulative update 3 for SQL Server 2014 SP2]                                                                              | 2016-12-28   |    44 |     39 |      555 |
| 12.0.5532.0  | 2014.120.5532.0  | SP2    | CU   |                                   | 3194718 | [MS16-136: Description of the security update for SQL Server 2014 Service Pack 2 CU: November 8, 2016]                     | 2016-11-08   |     1 |      1 |      551 |
| 12.0.5522.0  | 2014.120.5522.0  | SP2    | CU   |                                   | 3188778 | [Cumulative update 2 for SQL Server 2014 SP2]                                                                              | 2016-10-18   |    18 |     18 |      550 |
| 12.0.5511.0  | 2014.120.5511.0  | SP2    | CU   |                                   | 3178925 | [Cumulative update 1 for SQL Server 2014 SP2]                                                                              | 2016-08-24   |    45 |     36 |      556 |
| 12.0.5223.6  | 2014.120.5223.6  | SP2    | GDR  | CVE-2019-1068                     | 4505217 | [Security update for SQL Server 2014 SP2 GDR: July 9, 2019]                                                                | 2019-07-09   |     1 |      1 |      588 |
| 12.0.5214.6  | 2014.120.5214.6  | SP2    | GDR  | CVE-2017-5715,2017-5753,2017-5754 | 4057120 | [Security update for SQL Server 2014 Service Pack 2 GDR: January 16, 2018]                                                 | 2018-01-16   |       |        |      960 |
| 12.0.5207.0  | 2014.120.5207.0  | SP2    | GDR  |                                   | 4019093 | [Description of the security update for SQL Server 2014 Service Pack 2 GDR: August 8, 2017]                                | 2017-08-08   |     1 |      1 |      413 |
| 12.0.5203.0  | 2014.120.5203.0  | SP2    | GDR  |                                   | 3194714 | [MS16-136: Description of the security update for SQL Server 2014 Service Pack 2 GDR: November 8, 2016]                    | 2016-11-08   |     1 |      1 |      463 |
| 12.0.5000.0  | 2014.120.5000.0  | SP2    | SP   |                                   | 3171021 | [SQL Server 2014 Service Pack 2 release information]                                                                       | 2016-07-11   |   133 |     55 |      681 |
| 12.0.5626.1  | 2014.120.5626.1  | SP1    | CU   | **Latest CU SP1**                 | 4482967 | [Cumulative Update 13 for SQL Server 2014 SP1]                                                                             | 2017-08-08   |    11 |     11 |      577 |
| 12.0.4511.0  | 2014.120.4511.0  | SP1    | CU   |                                   | 4017793 | [Cumulative Update 12 for SQL Server 2014 SP1]                                                                             | 2017-04-17   |    12 |     11 |      573 |
| 12.0.4502.0  | 2014.120.4502.0  | SP1    | CU   |                                   | 4010392 | [Cumulative Update 11 for SQL Server 2014 SP1]                                                                             | 2017-02-21   |    15 |     15 |      571 |
| 12.0.4491.0  | 2014.120.4491.0  | SP1    | CU   |                                   | 3204399 | [Cumulative update package 10 for SQL Server 2014 Service Pack 1]                                                          | 2016-12-28   |    33 |     27 |      571 |
| 12.0.4487.0  | 2014.120.4487.0  | SP1    | CU   |                                   | 3194722 | [MS16-136: Description of the security update for SQL Server 2014 Service Pack 1 CU: November 8, 2016]                     | 2016-11-08   |     1 |      1 |      569 |
| 12.0.4474.0  | 2014.120.4474.0  | SP1    | CU   |                                   | 3186964 | [Cumulative update 9 for SQL Server 2014 SP1]                                                                              | 2016-10-18   |    14 |     14 |      912 |
| 12.0.4468.0  | 2014.120.4468.0  | SP1    | CU   |                                   | 3174038 | [Cumulative update 8 for SQL Server 2014 SP1]                                                                              | 2016-08-16   |    38 |     38 |      929 |
| 12.0.4463.0  | 2014.120.4463.0  | SP1    | COD  |                                   | 3174370 | [COD Hotfix A memory leak occurs when you use Azure Storage in SQL Server 2014]                                            | 2016-08-04   |     1 |      1 |          |
| 12.0.4459.0  | 2014.120.4459.0  | SP1    | CU   |                                   | 3162659 | [Cumulative Update 7 for SQL Server 2014 SP1]                                                                              | 2016-06-20   |    35 |     33 |      928 |
| 12.0.4457.0  | 2014.120.4457.0  | SP1    | CU   | **Refresh**                       | 3167392 | [Cumulative Update 6 for SQL Server 2014 Service Pack 1]                                                                   | 2016-05-31   |    44 |     43 |      927 |
| 12.0.4452.0  | 2014.120.4452.0  | SP1    | COD  | **Withdrawn**                     | 3147825 | 3147825 COD Hotfix                                                                                                         | 2016-04-05   |     1 |      1 |          |
| 12.0.4449.0  | 2014.120.4449.0  | SP1    | CU   | **Withdrawn**                     | 3144524 | [Cumulative update 6 for SQL Server 2014 SP1 (deprecated)]                                                                 | 2016-04-18   |       |        |          |
| 12.0.4439.1  | 2014.120.4439.1  | SP1    | CU   |                                   | 3130926 | [Cumulative Update 5 (CU5) for SQL Server 2014 Service Pack 1]                                                             | 2016-02-22   |    20 |     20 |      924 |
| 12.0.4437.0  | 2014.120.4437.0  | SP1    | COD  |                                   | 3130999 | [On-demand hotfix update package for SQL Server 2014 Service Pack 1 Cumulative Update 4]                                   | 2016-02-05   |     2 |      2 |          |
| 12.0.4436.0  | 2014.120.4436.0  | SP1    | CU   |                                   | 3106660 | [Cumulative update package 4 (CU4) for SQL Server 2014 Service Pack 1]                                                     | 2015-12-21   |    34 |     34 |          |
| 12.0.4433.0  | 2014.120.4433.0  | SP1    | COD  |                                   | 3119148 | [FIX: Error 3203 occurs and a SQL Server 2014 backup job can't restart after a network failure]                            | 2015-12-09   |     1 |      1 |          |
| 12.0.4432.0  | 2014.120.4432.0  | SP1    | COD  |                                   | 3097972 | [FIX: Error when your stored procedure calls another stored procedure on a linked server in SQL Server 2014]               | 2015-11-19   |     3 |      3 |          |
| 12.0.4427.24 | 2014.120.4427.24 | SP1    | CU   |                                   | 3094221 | [Cumulative update package 3 (CU3) for SQL Server 2014 Service Pack 1]                                                     | 2015-10-21   |    40 |     36 |          |
| 12.0.4422.0  | 2014.120.4422.0  | SP1    | CU   |                                   | 3075950 | [Cumulative update package 2 (CU2) for SQL Server 2014 Service Pack 1]                                                     | 2015-08-17   |    51 |     46 |          |
| 12.0.4419.0  | 2014.120.4419.0  | SP1    | COD  |                                   | 3078973 | [An on-demand hotfix update package is available for SQL Server 2014 SP1]                                                  | 2015-07-24   |    13 |     13 |          |
| 12.0.4416.0  | 2014.120.4416.0  | SP1    | CU   |                                   | 3067839 | [Cumulative update package 1 (CU1) for SQL Server 2014 Service Pack 1]                                                     | 2015-06-22   |   141 |    121 |          |
| 12.0.4237.0  | 2014.120.4237.0  | SP1    | GDR  |                                   | 4019091 | [Security update for SQL Server 2014 Service Pack 1 GDR: August 8, 2017]                                                   | 2017-08-08   |     1 |      1 |      391 |
| 12.0.4232.0  | 2014.120.4232.0  | SP1    | CU   |                                   | 3194720 | [MS16-136: Description of the security update for SQL Server 2014 Service Pack 1 GDR: November 8, 2016]                    | 2016-11-08   |     1 |      1 |      371 |
| 12.0.4219.0  | 2014.120.4219.0  | SP1    | GDR  |                                   | 3098852 | [SP1 GDR TLS 1.2 Update]                                                                                                   | 2016-01-29   |       |        |          |
| 12.0.4213.0  | 2014.120.4213.0  | SP1    | GDR  |                                   | 3070446 | [MS15-058: Description of the nonsecurity update for SQL Server 2014 Service Pack 1 GDR: July 14, 2015]                    | 2015-07-14   |       |        |      381 |
| 12.0.4100.1  | 2014.120.4100.1  | SP1    | SP   |                                   | 3058865 | [SQL Server 2014 Service Pack 1 release information]                                                                       | 2015-05-14   |    29 |     29 |     1025 |
| 12.0.4050.0  | 2014.120.4050.0  | SP1    | SP   |                                   |         | SQL Server 2014 Service Pack 1 (SP1) (initial)                                                                             | 2015-04-15   |       |        |          |
| 12.0.2569.0  | 2014.120.2569.0  | RTM    | CU   | **Latest CU RTM**                 | 3158271 | [Cumulative update package 14 (CU14) for SQL Server 2014]                                                                  | 2016-06-20   |    21 |     20 |     1049 |
| 12.0.2568.0  | 2014.120.2568.0  | RTM    | CU   |                                   | 3144517 | [Cumulative update package 13 (CU13) for SQL Server 2014]                                                                  | 2016-04-18   |    30 |     30 |     1047 |
| 12.0.2564.0  | 2014.120.2564.0  | RTM    | CU   |                                   | 3130923 | [Cumulative update package 12 (CU12) for SQL Server 2014]                                                                  | 2016-02-22   |     7 |      7 |     1045 |
| 12.0.2560.0  | 2014.120.2550.0  | RTM    | CU   |                                   | 3106659 | [Cumulative update package 11 (CU11) for SQL Server 2014]                                                                  | 2015-12-21   |    19 |     19 |          |
| 12.0.2556.4  | 2014.120.2556.4  | RTM    | CU   |                                   | 3094220 | [Cumulative update package 10 (CU10) for SQL Server 2014]                                                                  | 2015-10-20   |    33 |     30 |          |
| 12.0.2553.0  | 2014.120.2553.0  | RTM    | CU   |                                   | 3075949 | [Cumulative update package 9 (CU9) for SQL Server 2014]                                                                    | 2015-08-17   |    31 |     30 |          |
| 12.0.2548.0  | 2014.120.2548.0  | RTM    | CU   |                                   | 3045323 | [MS15-058: Description of the security update for SQL Server 2014 QFE: July 14, 2015]                                      | 2015-07-14   |     1 |      1 |     1038 |
| 12.0.2546.0  | 2014.120.2546.0  | RTM    | CU   |                                   | 3067836 | [Cumulative update package 8 (CU8) for SQL Server 2014]                                                                    | 2015-06-22   |    40 |     38 |          |
| 12.0.2506.0  | 2014.120.2506.0  | RTM    | COD  |                                   | 3063054 | [Update enables Premium Storage support for Data files on Azure Storage and resolves backup failures]                      | 2015-05-19   |     1 |      1 |          |
| 12.0.2505.0  | 2014.120.2505.0  | RTM    | COD  |                                   | 3052167 | [FIX: Error 1205 when you execute parallel query that contains outer join operators in SQL Server 2014]                    | 2015-05-19   |     1 |      1 |          |
| 12.0.2504.0  | 2014.120.2504.0  | RTM    | COD  |                                   | 2999809 | [FIX: Poor performance when a query contains table joins in SQL Server 2014]                                               | 2015-05-05   |     2 |      2 |          |
| 12.0.2504.0  | 2014.120.2504.0  | RTM    | COD  |                                   | 3058512 | [FIX: Unpivot Transformation task changes null to zero or empty strings in SSIS 2014]                                      | 2015-05-05   |       |        |          |
| 12.0.2495.0  | 2014.120.2495.0  | RTM    | CU   |                                   | 3046038 | [Cumulative update package 7 (CU7) for SQL Server 2014]                                                                    | 2015-04-23   |    47 |     41 |          |
| 12.0.2488.0  | 2014.120.2488.0  | RTM    | COD  |                                   | 3048751 | [FIX: Deadlock cannot be resolved automatically when you run a SELECT query that can result in a parallel batch-mode scan] | 2015-04-01   |     1 |      1 |          |
| 12.0.2485.0  | 2014.120.2485.0  | RTM    | COD  |                                   | 3043788 | [An on-demand hotfix update package is available for SQL Server 2014]                                                      | 2015-03-16   |     1 |      1 |          |
| 12.0.2480.0  | 2014.120.2480.0  | RTM    | CU   |                                   | 3031047 | [Cumulative update package 6 (CU6) for SQL Server 2014]                                                                    | 2015-02-16   |    64 |     55 |          |
| 12.0.2474.0  | 2014.120.2474.0  | RTM    | COD  |                                   | 3034679 | [FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]                                                      | 2015-02-04   |     1 |      1 |          |
| 12.0.2472.0  | 2014.120.2472.0  | RTM    | COD  |                                   | 3032087 | [FIX: Cannot show requested dialog after you connect to the latest SQL Database Update V12 (preview) with SQL Server 2014] | 2015-01-28   |     1 |      1 |          |
| 12.0.2464.0  | 2014.120.2464.0  | RTM    | COD  |                                   | 3024815 | [Large query compilation waits on RESOURCE_SEMAPHORE_QUERY_COMPILE in SQL Server 2014]                                     | 2015-01-05   |     1 |      1 |          |
| 12.0.2456.0  | 2014.120.2456.0  | RTM    | CU   |                                   | 3011055 | [Cumulative update package 5 (CU5) for SQL Server 2014]                                                                    | 2014-12-18   |    54 |     48 |          |
| 12.0.2436.0  | 2014.120.2436.0  | RTM    | COD  |                                   | 3014867 | [FIX: "Remote hardening failure" exception cannot be caught and a potential data loss when you use SQL Server 2014]        | 2014-11-27   |     1 |      1 |          |
| 12.0.2430.0  | 2014.120.2430.0  | RTM    | CU   |                                   | 2999197 | [Cumulative update package 4 (CU4) for SQL Server 2014]                                                                    | 2014-10-21   |    66 |     54 |          |
| 12.0.2423.0  | 2014.120.2423.0  | RTM    | COD  |                                   | 3007050 | [FIX: RTDATA_LIST waits when you run natively stored procedures that encounter expected failures in SQL Server 2014]       | 2014-10-22   |       |        |          |
| 12.0.2405.0  | 2014.120.2405.0  | RTM    | COD  |                                   | 2999809 | [FIX: Poor performance when a query contains table joins in SQL Server 2014]                                               | 2014-09-25   |       |        |          |
| 12.0.2402.0  | 2014.120.2402.0  | RTM    | CU   |                                   | 2984923 | [Cumulative update package 3 (CU3) for SQL Server 2014]                                                                    | 2014-08-18   |    40 |     32 |          |
| 12.0.2381.0  | 2014.120.2381.0  | RTM    | QFE  |                                   | 2977316 | [MS14-044: Description of the security update for SQL Server 2014 (QFE)]                                                   | 2014-08-12   |     1 |      1 |      602 |
| 12.0.2370.0  | 2014.120.2370.0  | RTM    | CU   |                                   | 2967546 | [Cumulative update package 2 (CU2) for SQL Server 2014]                                                                    | 2014-06-27   |    52 |     48 |          |
| 12.0.2342.0  | 2014.120.2342.0  | RTM    | CU   |                                   | 2931693 | [Cumulative update package 1 (CU1) for SQL Server 2014]                                                                    | 2014-04-21   |   121 |    114 |          |
| 12.0.2271.0  | 2014.120.2271.0  | RTM    | GDR  |                                   |         | [TLS 1.2 support for SQL Server 2014 RTM]                                                                                  | 2016-01-29   |     3 |      3 |          |
| 12.0.2269.0  | 2014.120.2269.0  | RTM    | GDR  |                                   | 3045324 | [MS15-058: Description of the security update for SQL Server 2014 GDR: July 14, 2015]                                      | 2015-07-14   |     2 |      2 |      388 |
| 12.0.2254.0  | 2014.120.2254.0  | RTM    | GDR  |                                   | 2977315 | [MS14-044: Description of the security update for SQL Server 2014 (GDR)]                                                   | 2014-08-12   |     1 |      1 |      183 |
| 12.0.2000.8  | 2014.120.2000.8  | RTM    | RTM  |                                   |         | SQL Server 2014 RTM                                                                                                        | 2014-04-01   |       |        |          |
| 12.0.1524.0  | 2014.120.1524.0  | CTP    | CTP  |                                   |         | Microsoft SQL Server 2014 Community Technology Preview 2 (CTP2)                                                            | 2013-10-15   |       |        |          |
| 11.0.9120.0  | 2013.110.9120.0  | CTP    | CTP  |                                   |         | Microsoft SQL Server 2014 Community Technology Preview 1 (CTP1)                                                            | 2013-06-25   |       |        |          |

[Security update for SQL Server 2014 SP3 CU4: February 11, 2020]:https://support.microsoft.com/help/4535288
[Cumulative Update 4 for SQL Server 2014 SP3]:https://support.microsoft.com/help/4500181
[Security update for SQL Server 2014 SP3 CU3 GDR: July 9, 2019]:https://support.microsoft.com/help/4505422
[Cumulative Update 3 for SQL Server 2014 SP3]:https://support.microsoft.com/help/4491539
[Cumulative Update 2 for SQL Server 2014 SP3]:https://support.microsoft.com/help/4482960
[Cumulative Update 1 for SQL Server 2014 SP3]:https://support.microsoft.com/help/4470220
[Security update for SQL Server 2014 SP3 GDR: February 11, 2020]:https://support.microsoft.com/help/4532095
[Security update for SQL Server 2014 SP3 GDR: July 9, 2019]:https://support.microsoft.com/help/4505218
[SQL Server 2014 Service Pack 3 release information]:https://support.microsoft.com/help/4022619
[Cumulative Update 18 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4500180
[Security update for SQL Server 2014 SP2 CU17 GDR: July 9, 2019]:https://support.microsoft.com/help/4505419
[Cumulative Update 17 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4491540
[Cumulative Update 16 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4482967
[Cumulative Update 15 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4469137
[Cumulative Update 14 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4459860
[Cumulative Update 13 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4456287
[Cumulative Update 12 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4130489
[Cumulative Update 11 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4077063
[Cumulative Update 10 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4052725/cumulative-update-10-for-sql-server-2014-sp2
[Cumulative Update 9 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4055557/cumulative-update-9-for-sql-server-2014-sp2
[Cumulative Update 8 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4037356/cumulative-update-8-for-sql-server-2014-sp2
[Cumulative Update 7 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4032541/cumulative-update-7-for-sql-server-2014-sp2
[Cumulative Update 6 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4019094/cumulative-update-6-for-sql-server-2014-sp2
[Cumulative Update 5 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4013098/cumulative-update-5-for-sql-server-2014-sp2
[Cumulative Update 4 for SQL Server 2014 SP2]:https://support.microsoft.com/help/4010394/cumulative-update-4-for-sql-server-2014-sp2
[Cumulative update 3 for SQL Server 2014 SP2]:https://support.microsoft.com/help/3204388
[MS16-136: Description of the security update for SQL Server 2014 Service Pack 2 CU: November 8, 2016]:https://support.microsoft.com/help/3194718
[Cumulative update 2 for SQL Server 2014 SP2]:https://support.microsoft.com/help/3188778
[Cumulative update 1 for SQL Server 2014 SP2]:https://support.microsoft.com/help/3178925
[Security update for SQL Server 2014 SP2 GDR: July 9, 2019]:https://support.microsoft.com/help/4505217
[MS16-136: Description of the security update for SQL Server 2014 Service Pack 2 GDR: November 8, 2016]:https://support.microsoft.com/help/3194714/
[SQL Server 2014 Service Pack 2 release information]:https://support.microsoft.com/help/3171021
[Cumulative Update 13 for SQL Server 2014 SP1]:https://support.microsoft.com/help/4019099/cumulative-update-13-for-sql-server-2014-sp1
[Cumulative Update 12 for SQL Server 2014 SP1]:https://support.microsoft.com/help/4017793/cumulative-update-12-for-sql-server-2014-sp1
[Cumulative Update 11 for SQL Server 2014 SP1]:https://support.microsoft.com/help/4010392/cumulative-update-11-for-sql-server-2014-sp1
[Cumulative update package 10 for SQL Server 2014 Service Pack 1]:https://support.microsoft.com/help/3204399
[MS16-136: Description of the security update for SQL Server 2014 Service Pack 1 CU: November 8, 2016]:https://support.microsoft.com/kb/3194722
[Cumulative update 9 for SQL Server 2014 SP1]:https://support.microsoft.com/help/3186964
[Security update for SQL Server 2014 Service Pack 2 GDR: January 16, 2018]:https://support.microsoft.com/help/4057120
[Description of the security update for SQL Server 2014 Service Pack 2 GDR: August 8, 2017]:https://support.microsoft.com/help/4019093/
[Cumulative update 8 for SQL Server 2014 SP1]:https://support.microsoft.com/kb/3174038
[COD Hotfix A memory leak occurs when you use Azure Storage in SQL Server 2014]:https://support.microsoft.com/kb/3174370
[Cumulative Update 7 for SQL Server 2014 SP1]:https://support.microsoft.com/kb/3162659
[Cumulative Update 6 for SQL Server 2014 Service Pack 1]:https://support.microsoft.com/kb/3167392
[Cumulative update 6 for SQL Server 2014 SP1 (deprecated)]:https://support.microsoft.com/kb/3144524
[Cumulative Update 5 (CU5) for SQL Server 2014 Service Pack 1]:https://support.microsoft.com/kb/3130926
[On-demand hotfix update package for SQL Server 2014 Service Pack 1 Cumulative Update 4]:https://support.microsoft.com/kb/3130999
[Cumulative update package 4 (CU4) for SQL Server 2014 Service Pack 1]:https://support.microsoft.com/kb/3106660
[FIX: Error 3203 occurs and a SQL Server 2014 backup job can't restart after a network failure]:http://support.microsoft.com/kb/3119148
[FIX: Error when your stored procedure calls another stored procedure on a linked server in SQL Server 2014]:http://support.microsoft.com/kb/3097972
[Cumulative update package 3 (CU3) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3094221
[Cumulative update package 2 (CU2) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3075950
[An on-demand hotfix update package is available for SQL Server 2014 SP1]:http://support.microsoft.com/kb/3078973
[Cumulative update package 1 (CU1) for SQL Server 2014 Service Pack 1]:http://support.microsoft.com/kb/3067839
[Security update for SQL Server 2014 Service Pack 1 GDR: August 8, 2017]:http://support.microsoft.com/help/4019091
[MS16-136: Description of the security update for SQL Server 2014 Service Pack 1 GDR: November 8, 2016]:https://support.microsoft.com/kb/3194720
[SP1 GDR TLS 1.2 Update]:https://support.microsoft.com/hotfix/kbhotfix?kbnum=3098852&kbln=en-us
[MS15-058: Description of the nonsecurity update for SQL Server 2014 Service Pack 1 GDR: July 14, 2015]:https://support.microsoft.com/kb/3070446
[SQL Server 2014 Service Pack 1 release information]:https://support.microsoft.com/kb/3058865
[Cumulative update package 14 (CU14) for SQL Server 2014]:https://support.microsoft.com/kb/3158271
[Cumulative update package 13 (CU13) for SQL Server 2014]:https://support.microsoft.com/kb/3144517
[Cumulative update package 12 (CU12) for SQL Server 2014]:https://support.microsoft.com/kb/3130923
[Cumulative update package 11 (CU11) for SQL Server 2014]:http://support.microsoft.com/kb/3106659
[Cumulative update package 10 (CU10) for SQL Server 2014]:http://support.microsoft.com/kb/3094220
[Cumulative update package 9 (CU9) for SQL Server 2014]:http://support.microsoft.com/kb/3075949
[MS15-058: Description of the security update for SQL Server 2014 QFE: July 14, 2015]:https://support.microsoft.com/kb/3045323
[Cumulative update package 8 (CU8) for SQL Server 2014]:http://support.microsoft.com/kb/3067836
[Update enables Premium Storage support for Data files on Azure Storage and resolves backup failures]:http://support.microsoft.com/kb/3063054
[FIX: Error 1205 when you execute parallel query that contains outer join operators in SQL Server 2014]:http://support.microsoft.com/kb/3052167
[FIX: Poor performance when a query contains table joins in SQL Server 2014]:http://support.microsoft.com/kb/2999809
[FIX: Unpivot Transformation task changes null to zero or empty strings in SSIS 2014]:http://support.microsoft.com/kb/3058512
[Cumulative update package 7 (CU7) for SQL Server 2014]:http://support.microsoft.com/kb/3046038
[FIX: Deadlock cannot be resolved automatically when you run a SELECT query that can result in a parallel batch-mode scan]:http://support.microsoft.com/kb/3048751
[An on-demand hotfix update package is available for SQL Server 2014]:http://support.microsoft.com/kb/3043788
[Cumulative update package 6 (CU6) for SQL Server 2014]:http://support.microsoft.com/kb/3031047
[FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]:http://support.microsoft.com/kb/3034679
[FIX: Cannot show requested dialog after you connect to the latest SQL Database Update V12 (preview) with SQL Server 2014]:http://support.microsoft.com/kb/3032087
[Large query compilation waits on RESOURCE_SEMAPHORE_QUERY_COMPILE in SQL Server 2014]:http://support.microsoft.com/kb/3024815
[Cumulative update package 5 (CU5) for SQL Server 2014]:http://support.microsoft.com/kb/3011055
[FIX: "Remote hardening failure" exception cannot be caught and a potential data loss when you use SQL Server 2014]:http://support.microsoft.com/kb/3014867
[Cumulative update package 4 (CU4) for SQL Server 2014]:http://support.microsoft.com/kb/2999197
[FIX: RTDATA_LIST waits when you run natively stored procedures that encounter expected failures in SQL Server 2014]:http://support.microsoft.com/kb/3007050
[FIX: Poor performance when a query contains table joins in SQL Server 2014]:http://support.microsoft.com/kb/2999809
[Cumulative update package 3 (CU3) for SQL Server 2014]:http://support.microsoft.com/kb/2984923
[MS14-044: Description of the security update for SQL Server 2014 (QFE)]:http://support.microsoft.com/kb/2977316
[Cumulative update package 2 (CU2) for SQL Server 2014]:http://support.microsoft.com/kb/2967546
[Cumulative update package 1 (CU1) for SQL Server 2014]:http://support.microsoft.com/kb/2931693
[TLS 1.2 support for SQL Server 2014 RTM]:https://support.microsoft.com/hotfix/kbhotfix?kbnum=3098856&kbln=en-us
[MS15-058: Description of the security update for SQL Server 2014 GDR: July 14, 2015]:https://support.microsoft.com/kb/3045324
[MS14-044: Description of the security update for SQL Server 2014 (GDR)]:http://support.microsoft.com/kb/2977315


## Microsoft SQL Server 2012 Builds
<a id="microsoft-sql-server-2012-builds"></a>

⚠ End-of-Life: SQL Server 2012 reached [end of mainstream support on July 11th, 2017](https://support.microsoft.com/en-us/lifecycle/search?alpha=sql%20server%202012%20Service%20Pack%204).

All SQL Server 2012 CU downloads: [Catalog Update Microsoft SQL Server 2012](http://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202012)

| Build         | File version     | Branch | Type | Info                              | KB      | Description/Link                                                                                                               | Release Date | Fixes | Public |
|---------------|------------------|--------|------|-----------------------------------|---------|--------------------------------------------------------------------------------------------------------------------------------|--------------|-------|--------|
| 11.0.7493.4   | 2011.110.7462.6  | SP4    | GDR  | CVE-2020-0618                     | 4532098 | [Security update for SQL Server 2012 SP4 GDR: February 11, 2020]                                                               | 2020-02-11   |     1 |      1 |
| 11.0.7469.6   | 2011.110.7469.6  | SP4    | CU   | **Latest CU SP4**                 | 4091266 | [On-demand hotfix update package for SQL Server 2012 SP4]                                                                      | 2018-03-28   |     2 |      2 |
| 11.0.7462.6   | 2011.110.7462.6  | SP4    | GDR  | CVE-2017-5715,2017-5753,2017-5754 | 4057116 | [Security Advisory ADV180002 (GDR)]                                                                                            | 2018-01-12   |     1 |      1 |
| 11.0.7001.0   | 2011.110.7001.0  | SP4    | SP   |                                   | 4018073 | [SQL Server 2012 Service Pack 4 release information]                                                                           | 2017-10-05   |    23 |     23 |
| 11.0.6615.2   | 2012.110.6615.2  | SP3    | CU   | CVE-2017-5715,2017-5753,2017-5754 | 4057121 | [Description of the security update for SQL Server 2012 SP3 CU: January 16, 2018]                                              | 2018-01-16   |     1 |      1 |
| 11.0.6607.3   | 2011.110.6607.3  | SP3    | CU   | **Latest CU SP3**                 | 4016762 | [Cumulative Update 10 for SQL Server 2012 SP3]                                                                                 | 2017-08-08   |     5 |     15 |
| 11.0.6598.0   | 2011.110.6598.0  | SP3    | CU   |                                   | 4016762 | [Cumulative Update 9 for SQL Server 2012 SP3]                                                                                  | 2017-05-15   |    12 |     10 |
| 11.0.6594.0   | 2011.110.6594.0  | SP3    | CU   |                                   | 4013104 | [Cumulative Update 8 for SQL Server 2012 SP3]                                                                                  | 2017-03-21   |    17 |     17 |
| 11.0.6579.0   | 2011.110.6579.0  | SP3    | CU   |                                   | 3205051 | [Cumulative Update Package 7 for SQL Server 2012 SP3]                                                                          | 2017-01-18   |    12 |     12 |
| 11.0.6567.0   | 2011.110.6567.0  | SP3    | COD  |                                   | 3194724 | [MS16-136: Description of the security update for SQL Server 2012 Service Pack 3 CU: November 8, 2016]                         | 2016-11-17   |    16 |     11 |
| 11.0.6544.0   | 2011.110.6544.0  | SP3    | CU   |                                   | 3180915 | [Cumulative update 5 for SQL Server 2012 Service Pack 3]                                                                       | 2016-09-20   |    21 |     18 |
| 11.0.6540.0   | 2011.110.6540.0  | SP3    | CU   |                                   | 3165264 | [Cumulative Update 4 for SQL Server 2012 SP3]                                                                                  | 2016-07-18   |    23 |     22 |
| 11.0.6537.0   | 2011.110.6537.0  | SP3    | CU   |                                   | 3152635 | [Cumulative update package 3 for SQL Server 2012 SP3]                                                                          | 2016-05-17   |    21 |     21 |
| 11.0.6523.0   | 2011.110.6523.0  | SP3    | CU   |                                   | 3137746 | [Cumulative update package 2 for SQL Server 2012 SP3]                                                                          | 2016-03-22   |    21 |     19 |
| 11.0.6518.0   | 2011.110.6518.0  | SP3    | CU   |                                   | 3123299 | [Cumulative update package 1 for SQL Server 2012 SP3]                                                                          | 2016-01-19   |     8 |      8 |
| 11.0.6260.1   | 2011.110.6260.1  | SP3    | GDR  | CVE-2017-5715,2017-5753,2017-5754 | 4057115 | [Description of the security update for SQL Server 2012 SP3 GDR: January 16, 2018 – Security Advisory ADV180002]               | 2018-01-16   |     1 |      1 |
| 11.0.6248.0   | 2011.110.6248.0  | SP3    | GDR  |                                   | 3194721 | [MS16-136: Description of the security update for SQL Server 2012 Service Pack 3 GDR: November 8, 2016]                        | 2016-11-08   |     1 |      1 |
| 11.0.6216.27  | 2011.110.6216.27 | SP3    | GDR  |                                   | 3135244 | [TLS 1.2 support for SQL Server 2012 SP3 GDR]                                                                                  | 2016-01-27   |     1 |      1 |
| 11.3.6020.0   | 2011.110.6020.0  | SP3    | SP   |                                   | 3072779 | [Microsoft SQL Server 2012 Service Pack 3 (SP3)]                                                                               | 2015-11-21   |    37 |     37 |
| 11.0.5678.0   | 2011.110.5678.0  | SP2    | CU   | **Latest CU SP2**                 | 3205054 | [Cumulative Update 16 for SQL Server 2012 SP2]                                                                                 | 2017-01-18   |     5 |      4 |
| 11.0.5676.0   | 2011.110.5676.0  | SP2    | CU   |                                   | 3205416 | [Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 2]                                                       | 2016-11-17   |     2 |      1 |
| 11.0.5676.0   | 2011.110.5676.0  | SP2    | COD  |                                   | 3194725 | [MS16-136: Description of the security update for SQL Server 2012 Service Pack 2 CU: November 8, 2016]                         | 2016-11-08   |     2 |      1 |
| 11.0.5657.0   | 2011.110.5657.0  | SP2    | CU   |                                   | 3180914 | [Cumulative Update 14 for SQL Server 2012 SP2]                                                                                 | 2016-09-20   |     1 |      1 |
| 11.0.5655.0   | 2011.110.5655.0  | SP2    | CU   |                                   | 3165266 | [Cumulative Update 13 for SQL Server 2012 SP2]                                                                                 | 2016-07-18   |     7 |      6 |
| 11.0.5649.0   | 2011.110.5649.0  | SP2    | CU   |                                   | 3152637 | [Cumulative update package 12 for SQL Server 2012 SP2]                                                                         | 2016-05-16   |     7 |      7 |
| 11.0.5646.2   | 2011.110.5646.2  | SP2    | CU   |                                   | 3137745 | [Cumulative update package 11 for SQL Server 2012 SP2]                                                                         | 2016-03-22   |    14 |     13 |
| 11.0.5644.2   | 2011.110.5644.2  | SP2    | CU   |                                   | 3120313 | [Cumulative update package 10 for SQL Server 2012 SP2]                                                                         | 2016-01-19   |    14 |     12 |
| 11.0.5641.0   | 2011.110.5641.0  | SP2    | CU   |                                   | 3098512 | [Cumulative update package 9 for SQL Server 2012 SP2]                                                                          | 2015-11-18   |    14 |     13 |
| 11.0.5636     | 2011.110.5636.3  | SP2    | COD  |                                   | 3097636 | [FIX: Performance decrease when application with connection pooling frequently connects or disconnects in SQL Server]          | 2015-09-22   |     1 |      1 |
| 11.0.5634     | 2011.110.5634.0  | SP2    | CU   |                                   | 3082561 | [Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 2]                                                         | 2015-09-21   |    24 |     23 |
| 11.0.5629     | 2011.110.5629.0  | SP2    | COD  |                                   | 3087872 | [FIX: Access violations when you use the FileTable feature in SQL Server 2012]                                                 | 2015-08-31   |     1 |      1 |
| 11.0.5623     | 2011.110.5623.0  | SP2    | CU   |                                   | 3072100 | [Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 2]                                                         | 2015-07-20   |    38 |     33 |
| 11.0.5613     | 2011.110.5613.0  | SP2    | COD  |                                   | 3045319 | [MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 QFE: July 14, 2015]                           | 2015-07-14   |     1 |      1 |
| 11.0.5592     | 2011.110.5592.0  | SP2    | CU   |                                   | 3052468 | [Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 2]                                                         | 2015-05-19   |    23 |     23 |
| 11.0.5582     | 2011.110.5582.0  | SP2    | CU   |                                   | 3037255 | [Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 2]                                                         | 2015-03-16   |    27 |     27 |
| 11.0.5571     | 2011.110.5571.0  | SP2    | COD  |                                   | 3034679 | [FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]                                                          | 2015-02-04   |     1 |      1 |
| 11.0.5569     | 2011.110.5569.0  | SP2    | CU   |                                   | 3007556 | [Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 2]                                                         | 2015-01-20   |    42 |     36 |
| 11.0.5556     | 2011.110.5556.0  | SP2    | CU   |                                   | 3002049 | [Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 2]                                                         | 2014-11-17   |    40 |     33 |
| 11.0.5548     | 2011.110.5548.0  | SP2    | CU   |                                   | 2983175 | [Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 2]                                                         | 2014-09-15   |    52 |     50 |
| 11.0.5532     | 2011.110.5532.0  | SP2    | CU   |                                   | 2976982 | [Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 2]                                                         | 2014-07-24   |    46 |     45 |
| 11.0.5522     | 2011.110.5522.0  | SP2    | COD  |                                   | 2969896 | [FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP2)]         | 2014-06-20   |     1 |      1 |
| 11.0.5388     | 2012.110.5388.0  | SP2    | GDR  |                                   | 3194719 | [MS16-136: Description of the security update for SQL Server 2012 Service Pack 2 GDR: November 8, 2016]                        | 2016-11-08   |     1 |      1 |
| 11.0.5352     | 2012.110.5352.0  | SP2    | GDR  |                                   | 3135244 | [TLS 1.2 support for SQL Server 2012 SP2 GDR]                                                                                  | 2016-01-27   |     2 |      2 |
| 11.0.5343     | 2011.110.5343.0  | SP2    | GDR  |                                   | 3045321 | [MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015]                           | 2015-07-14   |     1 |      1 |
| 11.0.5058     | 2011.110.5058.0  | SP2    | SP   |                                   |         | [SQL Server 2012 Service Pack 2 (SP2)]                                                                                         | 2014-06-10   |    37 |     37 |
| 11.0.3513     | 2011.110.3513.0  | SP1    | QFE  | **Latest CU SP1**                 | 3045317 | [MS15-058: Description of the security update for SQL Server 2012 SP1 QFE: July 14, 2015]                                      | 2015-07-14   |     1 |      1 |
| 11.0.3492     | 2011.110.3492.0  | SP1    | CU   |                                   | 3052476 | [Cumulative update package 16 (CU16) for SQL Server 2012 Service Pack 1]                                                       | 2015-05-18   |     4 |      4 |
| 11.0.3487     | 2011.110.3487.0  | SP1    | CU   |                                   | 3038001 | [Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 1]                                                       | 2015-03-16   |     1 |      1 |
| 11.0.3486     | 2011.110.3486.0  | SP1    | QFE  |                                   | 3023636 | [Cumulative update package 14 (CU14) for SQL Server 2012 Service Pack 1]                                                       | 2015-01-19   |     9 |      8 |
| 11.0.3482     | 2011.110.3482.0  | SP1    | CU   |                                   | 3002044 | [Cumulative update package 13 (CU13) for SQL Server 2012 Service Pack 1]                                                       | 2014-11-17   |    13 |     10 |
| 11.0.3470     | 2011.110.3470.0  | SP1    | CU   |                                   | 2991533 | [Cumulative update package 12 (CU12) for SQL Server 2012 Service Pack 1]                                                       | 2014-09-15   |    16 |     14 |
| 11.0.3467     | 2011.110.3467.0  | SP1    | COD  |                                   | 2975402 | [COD Hotfix 2975402]                                                                                                           | 2014-08-28   |     1 |      1 |
| 11.0.3460     | 2011.110.3460.0  | SP1    | COD  |                                   | 2977325 | [MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (QFE)]                                        | 2014-08-12   |     1 |      1 |
| 11.0.3449     | 2011.110.3449.0  | SP1    | CU   |                                   | 2975396 | [Cumulative update package 11 (CU11) for SQL Server 2012 Service Pack 1]                                                       | 2014-07-21   |    32 |     32 |
| 11.0.3437     | 2011.110.3437.0  | SP1    | COD  |                                   | 2969896 | [FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP1)]         | 2014-06-10   |     1 |      1 |
| 11.0.3431     | 2011.110.3431.0  | SP1    | CU   |                                   | 2954099 | [Cumulative update package 10 (CU10) for SQL Server 2012 Service Pack 1]                                                       | 2014-05-19   |    38 |     36 |
| 11.0.3412     | 2011.110.3412.0  | SP1    | CU   |                                   | 2931078 | [Cumulative update package 9 (CU9) for SQL Server 2012 Service Pack 1]                                                         | 2014-03-18   |       |        |
| 11.0.3401     | 2011.110.3401.0  | SP1    | CU   |                                   | 2917531 | [Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 1]                                                         | 2014-01-20   |       |        |
| 11.0.3393     | 2011.110.3393.0  | SP1    | CU   |                                   | 2894115 | [Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 1]                                                         | 2013-11-18   |       |        |
| 11.0.3381     | 2011.110.3381.0  | SP1    | CU   |                                   | 2874879 | [Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 1]                                                         | 2013-09-16   |       |        |
| 11.0.3373     | 2011.110.3373.0  | SP1    | CU   |                                   | 2861107 | [Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 1]                                                         | 2013-07-16   |       |        |
| 11.0.3368     | 2011.110.3368.0  | SP1    | CU   |                                   | 2833645 | [Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 1]                                                         | 2013-05-31   |       |        |
| 11.0.3350     | 2011.110.3350.0  | SP1    | COD  |                                   | 2832017 | [FIX: You can’t create or open SSIS projects or maintenance plans after you apply Cumulative Update 3 for SQL Server 2012 SP1] | 2013-04-17   |       |        |
| 11.0.3349     | 2011.110.3349.0  | SP1    | CU   |                                   | 2812412 | [Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 1]                                                         | 2013-03-18   |       |        |
| 11.0.3339     | 2011.110.3339.0  | SP1    | CU   |                                   | 2790947 | [Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 1]                                                         | 2013-01-25   |       |        |
| 11.0.3335     | 2011.110.3335.0  | SP1    | COD  |                                   | 2800050 | [FIX: Component installation process fails after you install SQL Server 2012 SP1]                                              | 2013-01-14   |       |        |
| 11.0.3321     | 2011.110.3321.0  | SP1    | CU   |                                   | 2765331 | [Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 1]                                                         | 2012-11-20   |       |        |
| 11.0.3156     | 2011.110.3156.0  | SP1    | COD  |                                   | 3045318 | [MS15-058: Description of the security update for SQL Server 2012 SP1 GDR: July 14, 2015]                                      | 2015-07-14   |     1 |      1 |
| 11.0.3153     | 2011.110.3153.0  | SP1    | GDR  |                                   | 2977326 | [MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (GDR)]                                        | 2014-08-12   |     1 |      1 |
| 11.0.3128     | 2011.110.3128.0  | SP1    | COD  |                                   | 2793634 | [Windows Installer starts repeatedly after you install SQL Server 2012 SP1]                                                    | 2013-01-03   |       |        |
| 11.0.3000     | 2011.110.3000.0  | SP1    | SP   |                                   |         | [SQL Server 2012 Service Pack 1 (SP1)]                                                                                         | 2012-11-06   |    92 |     92 |
| 11.0.2845     | 2011.110.2845.0  | SP1    | CTP  |                                   |         | SQL Server 2012 Service Pack 1 Customer Technology Preview 4 (CTP4)                                                            | 2012-09-20   |       |        |
| 11.0.2809     | 2011.110.2809.24 | SP1    | CTP  |                                   |         | SQL Server 2012 Service Pack 1 Customer Technology Preview 3 (CTP3)                                                            | 2012-07-05   |       |        |
| 11.0.2424     | 2011.110.2424.0  | RTM    | CU   | **Latest CU RTM**                 | 2908007 | [Cumulative update package 11 (CU11) for SQL Server 2012]                                                                      | 2013-12-17   |    16 |     15 |
| 11.0.2420     | 2011.110.2420.0  | RTM    | CU   |                                   | 2891666 | [Cumulative update package 10 (CU10) for SQL Server 2012]                                                                      | 2013-10-21   |     4 |      4 |
| 11.0.2419     | 2011.110.2419.0  | RTM    | CU   |                                   | 2867319 | [Cumulative update package 9 (CU9) for SQL Server 2012]                                                                        | 2013-08-21   |       |        |
| 11.0.2410     | 2011.110.2410.0  | RTM    | CU   |                                   | 2844205 | [Cumulative update package 8 (CU8) for SQL Server 2012]                                                                        | 2013-06-18   |       |        |
| 11.0.2405     | 2011.110.2405.0  | RTM    | CU   |                                   | 2823247 | [Cumulative update package 7 (CU7) for SQL Server 2012]                                                                        | 2013-04-15   |       |        |
| 11.0.2401     | 2011.110.2401.0  | RTM    | CU   |                                   | 2728897 | [Cumulative update package 6 (CU6) for SQL Server 2012]                                                                        | 2013-02-18   |       |        |
| 11.0.2395     | 2011.110.2395.0  | RTM    | CU   |                                   | 2777772 | [Cumulative update package 5 (CU5) for SQL Server 2012]                                                                        | 2012-12-18   |       |        |
| 11.0.9000     | 2011.110.9000.5  | RTM    | CTP  |                                   |         | Microsoft SQL Server 2012 With Power View For Multidimensional Models Customer Technology Preview (CTP3)                       | 2012-11-27   |       |        |
| 11.0.2383     | 2011.110.2383.0  | RTM    | CU   |                                   | 2758687 | [Cumulative update package 4 (CU4) for SQL Server 2012]                                                                        | 2012-10-18   |       |        |
| 11.0.2376     | 2011.110.2376.0  | RTM    | COD  | [MS12-070]                        | 2716441 | [Security Update for SQL Server 2012 RTM (KB2716441)]                                                                          | 2012-10-09   |       |        |
| 11.0.2332     | 2011.110.2332.0  | RTM    | CU   |                                   | 2723749 | [Cumulative update package 3 (CU3) for SQL Server 2012]                                                                        | 2012-08-29   |       |        |
| 11.0.2325     | 2011.110.2325.0  | RTM    | CU   |                                   | 2703275 | [Cumulative update package 2 (CU2) for SQL Server 2012]                                                                        | 2012-06-18   |       |        |
| 11.0.2316     | 2011.110.2316.0  | RTM    | CU   |                                   | 2679368 | [Cumulative update package 1 (CU1) for SQL Server 2012]                                                                        | 2012-04-12   |       |        |
| 11.0.2218     | 2011.110.2218.0  | RTM    | COD  | [MS12-070]                        | 2716442 | [Security Update for SQL Server 2012 RTM (KB2716442)]                                                                          | 2012-10-09   |       |        |
| 11.0.2214     | 2011.110.2214.0  | RTM    | COD  |                                   | 2685308 | [FIX: SSAS uses only 20 cores in SQL Server 2012 Business Intelligence                                                         | 2012-04-06   |       |        |
| 11.0.2100     | 2011.110.2100.60 | RTM    | RTM  |                                   |         | SQL Server 2012 RTM                                                                                                            | 2012-03-06   |       |        |
| 11.0.1913     | 2011.110.1913.37 | RC     | RC   |                                   |         | Microsoft SQL Server 2012 Release Candidate 1 (RC1)                                                                            | 2011-12-16   |       |        |
| 11.0.1750     | 2011.110.1750.32 | RC     | RC   |                                   |         | Microsoft SQL Server 2012 Release Candidate 0 (RC0)                                                                            | 2011-11-17   |       |        |
| 11.0.1440     | 2010.110.1440.19 | CTP    | CTP  |                                   |         | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 3 (CTP3)                                              | 2011-07-11   |       |        |
| 11.0.1103     | 2010.110.1103.9  | CTP    | CTP  |                                   |         | Microsoft SQL Server 2012 (codename Denali) Community Technology Preview 1 (CTP1)                                              | 2010-11-08   |       |        |

[Security update for SQL Server 2012 SP4 GDR: February 11, 2020]:https://support.microsoft.com/help/4532098
[On-demand hotfix update package for SQL Server 2012 SP4]:https://support.microsoft.com/help/4091266
[Security Advisory ADV180002 (GDR)]:https://support.microsoft.com/help/4057116/security-update-for-vulnerabilities-in-sql-server
[SQL Server 2012 Service Pack 4 release information]:https://support.microsoft.com/help/4018073/sql-server-2012-service-pack-4-release-information
[Description of the security update for SQL Server 2012 SP3 CU: January 16, 2018]:https://support.microsoft.com/help/4057121
[Cumulative Update 10 for SQL Server 2012 SP3]:https://support.microsoft.com/help/4025925/cumulative-update-10-for-sql-server-2012-sp3
[Cumulative Update 9 for SQL Server 2012 SP3]:https://support.microsoft.com/help/4016762/cumulative-update-9-for-sql-server-2012-sp3
[Cumulative Update 8 for SQL Server 2012 SP3]:https://support.microsoft.com/help/4013104/cumulative-update-8-for-sql-server-2012-sp3
[Cumulative Update Package 7 for SQL Server 2012 SP3]:https://support.microsoft.com/help/3205051/cumulative-update-7-for-sql-server-2012-sp3
[MS16-136: Description of the security update for SQL Server 2012 Service Pack 3 CU: November 8, 2016]:https://support.microsoft.com/kb/3194724
[MS16-136: Description of the security update for SQL Server 2012 Service Pack 2 CU: November 8, 2016]:https://support.microsoft.com/kb/3194725
[Cumulative Update 14 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3180914
[Cumulative update 5 for SQL Server 2012 Service Pack 3]:https://support.microsoft.com/kb/3180915
[Cumulative Update 4 for SQL Server 2012 SP3]:https://support.microsoft.com/kb/3165264
[Cumulative Update 13 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3165266
[Cumulative update package 3 for SQL Server 2012 SP3]:https://support.microsoft.com/kb/3152635
[Cumulative update package 12 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3152637
[Cumulative update package 2 for SQL Server 2012 SP3]:https://support.microsoft.com/kb/3137746
[Cumulative update package 11 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3137745
[Cumulative update package 1 for SQL Server 2012 SP3]:https://support.microsoft.com/kb/3123299
[Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 2]:https://support.microsoft.com/kb/3205416
[MS16-136: Description of the security update for SQL Server 2012 Service Pack 3 GDR: November 8, 2016]:https://support.microsoft.com/kb/3194721
[TLS 1.2 support for SQL Server 2012 SP3 GDR]:https://support.microsoft.com/kb/3135244
[Cumulative update package 10 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3120313
[Microsoft SQL Server 2012 Service Pack 3 (SP3)]:https://support.microsoft.com/kb/3072779
[Cumulative Update 16 for SQL Server 2012 SP2]:https://support.microsoft.com/help/3205054/cumulative-update-16-for-sql-server-2012-sp2
[Cumulative update package 9 for SQL Server 2012 SP2]:https://support.microsoft.com/kb/3098512
[FIX: Performance decrease when application with connection pooling frequently connects or disconnects in SQL Server]:https://support.microsoft.com/kb/3097636
[Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3082561
[FIX: Access violations when you use the FileTable feature in SQL Server 2012]:https://support.microsoft.com/kb/3087872
[Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3072100
[MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 QFE: July 14, 2015]:https://support.microsoft.com/kb/3045319
[Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3052468
[Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3037255
[FIX: AlwaysOn availability groups are reported as NOT SYNCHRONIZING]:http://support.microsoft.com/kb/3034679
[Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3007556
[Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/3002049
[Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/2983175
[Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 2]:http://support.microsoft.com/kb/2976982
[FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP2)]:http://support.microsoft.com/kb/2969896
[MS16-136: Description of the security update for SQL Server 2012 Service Pack 2 GDR: November 8, 2016]:https://support.microsoft.com/kb/3194719
[TLS 1.2 support for SQL Server 2012 SP2 GDR]:https://support.microsoft.com/kb/3135244
[MS15-058: Description of the security update for SQL Server 2012 Service Pack 2 GDR: July 14, 2015]:https://support.microsoft.com/kb/3045321
[SQL Server 2012 Service Pack 2 (SP2)]:http://www.microsoft.com/download/details.aspx?id=43340
[MS15-058: Description of the security update for SQL Server 2012 SP1 QFE: July 14, 2015]:https://support.microsoft.com/kb/3045317
[Cumulative update package 16 (CU16) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3052476
[Cumulative update package 15 (CU15) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3038001
[Cumulative update package 14 (CU14) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3023636
[Cumulative update package 13 (CU13) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/3002044
[Cumulative update package 12 (CU12) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2991533
[COD Hotfix 2975402]:http://support.microsoft.com/kb/2975402
[MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (QFE)]:http://support.microsoft.com/kb/2977325
[Cumulative update package 11 (CU11) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2975396
[FIX: Data loss in clustered index occurs when you run online build index in SQL Server 2012 (Hotfix for SQL2012 SP1)]:http://support.microsoft.com/kb/2969896
[Cumulative update package 10 (CU10) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2954099
[Cumulative update package 9 (CU9) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2931078
[Cumulative update package 8 (CU8) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2917531
[Cumulative update package 7 (CU7) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2894115
[Cumulative update package 6 (CU6) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2874879
[Cumulative update package 5 (CU5) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2861107
[Cumulative update package 4 (CU4) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2833645
[FIX: You can’t create or open SSIS projects or maintenance plans after you apply Cumulative Update 3 for SQL Server 2012 SP1]:http://support.microsoft.com/kb/2832017
[Cumulative update package 3 (CU3) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2812412
[Cumulative update package 2 (CU2) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2790947
[FIX: Component installation process fails after you install SQL Server 2012 SP1]:http://support.microsoft.com/kb/2800050
[Cumulative update package 1 (CU1) for SQL Server 2012 Service Pack 1]:http://support.microsoft.com/kb/2765331
[MS15-058: Description of the security update for SQL Server 2012 SP1 GDR: July 14, 2015]:https://support.microsoft.com/kb/3045318
[MS14-044: Description of the security update for SQL Server 2012 Service Pack 1 (GDR)]:http://support.microsoft.com/kb/2977326
[Windows Installer starts repeatedly after you install SQL Server 2012 SP1]:http://support.microsoft.com/kb/2793634
[SQL Server 2012 Service Pack 1 (SP1)]:http://www.microsoft.com/download/details.aspx?id=35575
[Cumulative update package 11 (CU11) for SQL Server 2012]:http://support.microsoft.com/kb/2908007
[Cumulative update package 10 (CU10) for SQL Server 2012]:http://support.microsoft.com/kb/2891666
[Cumulative update package 9 (CU9) for SQL Server 2012]:http://support.microsoft.com/kb/2867319
[Cumulative update package 8 (CU8) for SQL Server 2012]:http://support.microsoft.com/kb/2844205
[Cumulative update package 7 (CU7) for SQL Server 2012]:http://support.microsoft.com/kb/2823247
[Cumulative update package 6 (CU6) for SQL Server 2012]:http://support.microsoft.com/kb/2728897
[Cumulative update package 5 (CU5) for SQL Server 2012]:http://support.microsoft.com/kb/2777772
[Cumulative update package 4 (CU4) for SQL Server 2012]:http://support.microsoft.com/kb/2758687
[Security Update for SQL Server 2012 RTM (KB2716441)]:https://www.microsoft.com/en-us/download/details.aspx?id=34917
[Cumulative update package 3 (CU3) for SQL Server 2012]:http://support.microsoft.com/kb/2723749
[Cumulative update package 2 (CU2) for SQL Server 2012]:http://support.microsoft.com/kb/2703275
[Cumulative update package 1 (CU1) for SQL Server 2012]:http://support.microsoft.com/kb/2679368
[Security Update for SQL Server 2012 RTM (KB2716442)]:https://www.microsoft.com/en-us/download/details.aspx?id=34884
[FIX: SSAS uses only 20 cores in SQL Server 2012 Business Intelligence]:http://support.microsoft.com/kb/2685308
[MS12-070]:http://technet.microsoft.com/security/bulletin/ms12-070


<a id="microsoft-sql-server-2008-r2-builds"></a>
## Microsoft SQL Server 2008 R2 Builds

### All SQL Server 2008 R2 CU downloads
[Catalog Update Microsoft SQL Server 2008 R2]:http://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202008%20R2

| Build         | File version     | Branch | Type | Info             | KB      | Description/Link                                                                                                                                                                      | Release Date |
|---------------|------------------|--------|------|------------------|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 10.50.6542    | 2009.100.6542.0  | SP3    | CU   |**Latest CU SP3** | 3146034 | [Intermittent service terminations occur after you install any SQL Server 2008 or SQL Server 2008 R2 versions from KB3135244]                                                         | 2016-03-03   |
| 10.50.6537    | 2009.100.6537.0  | SP3    | CU   |                  | 3135244 | [TLS 1.2 support for SQL Server 2008 R2 SP3]                                                                                                                                          | 2016-01-27   |
| 10.50.6529    | 2009.100.6529.0  | SP3    | QFE  |                  | 3045314 | [MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 QFE: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.6525    | 2009.100.6525.0  | SP3    | COD  |                  | 3033860 | [An on-demand hotfix update package is available for SQL Server 2008 R2 Service Pack 3 (SP3)]                                                                                         | 2015-02-09   |
| 10.50.6220    | 2009.100.6220.0  | SP3    | COD  |                  | 3045316 | [MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 GDR: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.6000.34 | 2009.100.6000.34 | SP3    | SP   |**Latest SP**     |         | [SQL Server 2008 R2 Service Pack 3 (SP3)]                                                                                                                                             | 2014-09-26   |
| 10.50.4343    | 2009.100.4343.0  | SP2    | CU   |                  | 3135244 | [TLS 1.2 support for SQL Server 2008 R2 SP2 (IA-64 only)]                                                                                                                             | 2016-01-27   |
| 10.50.4339    | 2009.100.4339.0  | SP2    | QFE  |                  | 3045312 | [MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 QFE: July 14, 2015]                                                                               | 2015-07-14   |
| 10.50.4331    | 2009.100.4331.0  | SP2    |      |                  | 2987585 | [Restore Log with Standby Mode on an Advanced Format disk may cause a 9004 error in SQL Server 2008 R2 or SQL Server 2012]                                                            | 2014-08-27   |
| 10.50.4321    | 2009.100.4321.0  | SP2    | QFE  |                  | 2977319 | [MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (QFE)]                                                                                            | 2014-08-12   |
| 10.50.4319    | 2009.100.4319.0  | SP2    | CU   |                  | 2967540 | [Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-06-30   |
| 10.50.4305    | 2009.100.4305.0  | SP2    | CU   |                  | 2938478 | [Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-04-21   |
| 10.50.4302    | 2009.100.4302.0  | SP2    | CU   |                  | 2926028 | [Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2014-02-18   |
| 10.50.4297    | 2009.100.4297.0  | SP2    | CU   |                  | 2908087 | [Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 2]                                                                                                           | 2013-12-16   |
| 10.50.4295    | 2009.100.4295.0  | SP2    | CU   |                  | 2887606 | [Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-10-29   |
| 10.50.4290    | 2009.100.4290.0  | SP2    | CU   |                  | 2871401 | [Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-08-30   |
| 10.50.4286    | 2009.100.4286.0  | SP2    | CU   |                  | 2844090 | [Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-06-17   |
| 10.50.4285    | 2009.100.4285.0  | SP2    | CU   |                  | 2830140 | [Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (updated)]                                                                                                   | 2013-06-13   |
| 10.50.4279    | 2009.100.4279.0  | SP2    | CU   |**Withdrawn**     | 2830140 | Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (replaced)                                                                                                    | 2013-04-15   |
| 10.50.4276    | 2009.100.4276.0  | SP2    | CU   |                  | 2797460 | [Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2013-02-18   |
| 10.50.4270    | 2009.100.4270.0  | SP2    | CU   |                  | 2777358 | [Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-12-17   |
| 10.50.4266    | 2009.100.4266.0  | SP2    | CU   |                  | 2754552 | [Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-10-15   |
| 10.50.4263    | 2009.100.4263.0  | SP2    | CU   |                  | 2740411 | [Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-08-29   |
| 10.50.4260    | 2009.100.4260.0  | SP2    | CU   |                  | 2720425 | [Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 2]                                                                                                             | 2012-08-01   |
| 10.50.4042    | 2009.100.4042.0  | SP2    | GDR  |                  | 3045313 | [MS15-058: MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 GDR: July 14, 2015]                                                                     | 2015-07-14   |
| 10.50.4033    | 2009.100.4033.0  | SP2    | GDR  |                  | 2977320 | [MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (GDR)]                                                                                            | 2014-08-12   |
| 10.50.4000    | 2009.100.4000.0  | SP2    | SP   |                  |         | [SQL Server 2008 R2 Service Pack 2 (SP2)]                                                                                                                                             | 2012-06-26   |
| 10.50.3720    | 2009.100.3720.0  | SP2    | CTP  |                  |         | SQL Server 2008 R2 Service Pack 2 Community Technology Preview (CTP)                                                                                                                  | 2012-05-13   |
| 10.50.2881    | 2009.100.2881.0  | SP1    |      |                  | 2868244 | [An on-demand hotfix update package for SQL Server 2008 R2 Service Pack 1]                                                                                                            | 2013-08-12   |
| 10.50.2876    | 2009.100.2876.0  | SP1    | CU   |                  | 2855792 | [Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2013-06-17   |
| 10.50.2875    | 2009.100.2875.0  | SP1    | CU   |                  | 2828727 | [Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (updated)]                                                                                                 | 2013-06-13   |
| 10.50.2874    | 2009.100.2874.0  | SP1    | CU   |**Withdrawn**     | 2828727 | Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (replaced)                                                                                                  | 2013-04-15   |
| 10.50.2861    | 2009.100.2861.0  | SP1    |      |                  |         | [Microsoft Security Bulletin MS12-070]                                                                                                                                                | 2012-10-09   |
| 10.50.2869    | 2009.100.2869.0  | SP1    | CU   |                  | 2812683 | [Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2013-02-18   |
| 10.50.2868    | 2009.100.2868.0  | SP1    | CU   |                  | 2783135 | [Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 1]                                                                                                           | 2012-12-17   |
| 10.50.2866    | 2009.100.2866.0  | SP1    | CU   |                  | 2756574 | [Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-11-06   |
| 10.50.2861    | 2009.100.2861.0  | SP1    | QFE  |                  | 2716439 | [MS12-070: Description of the security update for SQL Server 2008 R2 Service Pack 1 QFE: October 9, 2012]                                                                             | 2012-10-09   |
| 10.50.2822    | 2009.100.2822.0  | SP1    | CU   |                  | 2723743 | [Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-08-29   |
| 10.50.2817    | 2009.100.2817.0  | SP1    | CU   |                  | 2703282 | [Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-06-18   |
| 10.50.2811    | 2009.100.2811.0  | SP1    | CU   |                  | 2679367 | [Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-04-16   |
| 10.50.2807    | 2009.100.2807.0  | SP1    |      |                  | 2675522 | [FIX: Access violation when you run DML statements against a table that has partitioned indexes in SQL Server 2008 R2]                                                                | 2012-03-12   |
| 10.50.2806    | 2009.100.2806.0  | SP1    | CU   |                  | 2659694 | [Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2012-02-22   |
| 10.50.2799    | 2009.100.2799.0  | SP1    |      |                  | 2633357 | [FIX: "Non-yielding Scheduler" error might occur when you run a query that uses the CHARINDEX function in SQL Server 2008 R2]                                                         | 2012-02-22   |
| 10.50.2796    | 2009.100.2796.0  | SP1    | CU   |                  | 2633146 | [Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-12-20   |
| 10.50.2789    | 2009.100.2789.0  | SP1    | CU   |                  | 2591748 | [Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-10-17   |
| 10.50.2776    | 2009.100.2776.0  | SP1    |      |                  | 2606883 | [FIX: Slow performance when an AFTER trigger runs on a partitioned table in SQL Server 2008 R2]                                                                                       | 2011-10-18   |
| 10.50.2772    | 2009.100.2772.0  | SP1    | CU   |                  | 2567714 | [Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-08-15   |
| 10.50.2769    | 2009.100.2769.0  | SP1    | CU   |                  | 2544793 | [Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 1]                                                                                                             | 2011-07-18   |
| 10.50.2550    | 2009.100.2550.0  | SP1    |      | [MS12-070]       |         | [Microsoft Security Bulletin MS12-070]                                                                                                                                                | 2012-10-09   |
| 10.50.2500    | 2009.100.2500.0  | SP1    | SP   |                  |         | [SQL Server 2008 R2 Service Pack 1 (SP1)]                                                                                                                                             | 2011-07-11   |
| 10.50.1817    | 2009.100.1817.0  | RTM    | CU   |                  | 2703280 | [Cumulative update package 14 (CU14) for SQL Server 2008 R2]                                                                                                                          | 2012-06-18   |
| 10.50.1815    | 2009.100.1815.0  | RTM    | CU   |                  | 2679366 | [Cumulative update package 13 (CU13) for SQL Server 2008 R2]                                                                                                                          | 2012-04-17   |
| 10.50.1810    | 2009.100.1810.0  | RTM    | CU   |                  | 2659692 | [Cumulative update package 12 (CU12) for SQL Server 2008 R2]                                                                                                                          | 2012-02-21   |
| 10.50.1809    | 2009.100.1809.0  | RTM    | CU   |                  | 2633145 | [Cumulative update package 11 (CU11) for SQL Server 2008 R2]                                                                                                                          | 2012-01-09   |
| 10.50.1807    | 2009.100.1807.0  | RTM    | CU   |                  | 2591746 | [Cumulative update package 10 (CU10) for SQL Server 2008 R2]                                                                                                                          | 2011-10-19   |
| 10.50.1804    | 2009.100.1804.0  | RTM    | CU   |                  | 2567713 | [Cumulative update package 9 (CU9) for SQL Server 2008 R2]                                                                                                                            | 2011-08-16   |
| 10.50.1800    | 2009.100.1800.0  | RTM    |      |                  | 2574699 | [FIX: Database data files might be incorrectly marked as sparse in SQL Server 2008 R2 or in SQL Server 2008 even when the physical files are marked as not sparse in the file system] | 2011-10-18   |
| 10.50.1797    | 2009.100.1797.0  | RTM    | CU   |                  | 2534352 | [Cumulative update package 8 (CU8) for SQL Server 2008 R2]                                                                                                                            | 2011-06-20   |
| 10.50.1790    | 2009.100.1790.0  | RTM    | QFE  |                  | 2494086 | [MS11-049: Description of the security update for SQL Server 2008 R2 QFE: June 14, 2011]                                                                                              | 2011-06-17   |
| 10.50.1777    | 2009.100.1777.0  | RTM    | CU   |                  | 2507770 | [Cumulative update package 7 (CU7) for SQL Server 2008 R2]                                                                                                                            | 2011-06-16   |
| 10.50.1769    | 2009.100.1769.0  | RTM    |      |                  | 2520808 | [FIX: Non-yielding scheduler error when you run a query that uses a TVP in SQL Server 2008 or in SQL Server 2008 R2 if SQL Profiler or SQL Server Extended Events is used]            | 2011-04-18   |
| 10.50.1765    | 2009.100.1765.0  | RTM    | CU   |                  | 2489376 | [Cumulative update package 6 (CU6) for SQL Server 2008 R2]                                                                                                                            | 2011-02-21   |
| 10.50.1753    | 2009.100.1753.0  | RTM    | CU   |                  | 2438347 | [Cumulative update package 5 (CU5) for SQL Server 2008 R2]                                                                                                                            | 2010-12-23   |
| 10.50.1746    | 2009.100.1746.0  | RTM    | CU   |                  | 2345451 | [Cumulative update package 4 (CU4) for SQL Server 2008 R2]                                                                                                                            | 2010-10-18   |
| 10.50.1734    | 2009.100.1734.0  | RTM    | CU   |                  | 2261464 | [Cumulative update package 3 (CU3) for SQL Server 2008 R2]                                                                                                                            | 2010-08-20   |
| 10.50.1720    | 2009.100.1720.0  | RTM    | CU   |                  | 2072493 | [Cumulative update package 2 (CU2) for SQL Server 2008 R2]                                                                                                                            | 2010-06-25   |
| 10.50.1702    | 2009.100.1702.0  | RTM    | CU   |                  | 981355  | [Cumulative update package 1 (CU1) for SQL Server 2008 R2]                                                                                                                            | 2010-05-18   |
| 10.50.1617    | 2009.100.1617.0  | RTM    | GDR  |                  | 2494088 | [MS11-049: Description of the security update for SQL Server 2008 R2 GDR: June 14, 2011]                                                                                              | 2011-06-14   |
| 10.50.1600.1  | 2009.100.1600.1  | RTM    | RTM  |**RTM**           |         | SQL Server 2008 R2 RTM                                                                                                                                                                | 2010-04-21   |
| 10.50.1352    | 2009.100.1352.12 | CTP    | CTP  |                  |         | Microsoft SQL Server 2008 R2 November Community Technology Preview (CTP)                                                                                                              | 2009-11-12   |
| 10.50.1092    | 2009.100.1092.20 | CTP    | CTP  |                  |         | Microsoft SQL Server 2008 R2 August Community Technology Preview (CTP)                                                                                                                | 2009-06-30   |

[Intermittent service terminations occur after you install any SQL Server 2008 or SQL Server 2008 R2 versions from KB3135244]:http://support.microsoft.com/kb/3146034
[TLS 1.2 support for SQL Server 2008 R2 SP3]:http://support.microsoft.com/kb/3135244
[MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 QFE: July 14, 2015]:http://support.microsoft.com/kb/3045314
[An on-demand hotfix update package is available for SQL Server 2008 R2 Service Pack 3 (SP3)]:http://support.microsoft.com/kb/3033860
[MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 3 GDR: July 14, 2015]:http://support.microsoft.com/kb/3045316
[SQL Server 2008 R2 Service Pack 3 (SP3)]:http://www.microsoft.com/download/details.aspx?id=44271
[TLS 1.2 support for SQL Server 2008 R2 SP2 (IA-64 only)]:http://support.microsoft.com/kb/3135244
[MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 QFE: July 14, 2015]:http://support.microsoft.com/kb/3045312
[Restore Log with Standby Mode on an Advanced Format disk may cause a 9004 error in SQL Server 2008 R2 or SQL Server 2012]:http://support.microsoft.com/kb/2987585
[MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (QFE)]:http://support.microsoft.com/kb/2977319
[Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2967540
[Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2938478
[Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2926028
[Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2908087
[Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2887606
[Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2871401
[Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2844090
[Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 2 (updated)]:http://support.microsoft.com/kb/2830140
[Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2797460
[Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2777358
[Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2754552
[Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2740411
[Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 2]:http://support.microsoft.com/kb/2720425
[MS15-058: MS15-058: Description of the security update for SQL Server 2008 R2 Service Pack 2 GDR: July 14, 2015]:http://support.microsoft.com/kb/3045313
[MS14-044: Description of the security update for SQL Server 2008 R2 Service Pack 2 (GDR)]:http://support.microsoft.com/kb/2977320
[SQL Server 2008 R2 Service Pack 2 (SP2)]:http://www.microsoft.com/download/details.aspx?id=30437
[An on-demand hotfix update package for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2868244
[Cumulative update package 13 (CU13) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2855792
[Cumulative update package 12 (CU12) for SQL Server 2008 R2 Service Pack 1 (updated)]:http://support.microsoft.com/kb/2828727
[Cumulative update package 11 (CU11) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2812683
[Cumulative update package 10 (CU10) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2783135
[Cumulative update package 9 (CU9) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2756574
[MS12-070: Description of the security update for SQL Server 2008 R2 Service Pack 1 QFE: October 9, 2012]:http://support.microsoft.com/kb/2716439
[Cumulative update package 8 (CU8) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2723743
[Cumulative update package 7 (CU7) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2703282
[Cumulative update package 6 (CU6) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2679367
[FIX: Access violation when you run DML statements against a table that has partitioned indexes in SQL Server 2008 R2]:http://support.microsoft.com/kb/2675522
[Cumulative update package 5 (CU5) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2659694
[FIX: "Non-yielding Scheduler" error might occur when you run a query that uses the CHARINDEX function in SQL Server 2008 R2]:http://support.microsoft.com/kb/2633357
[Cumulative update package 4 (CU4) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2633146
[Cumulative update package 3 (CU3) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2591748
[FIX: Slow performance when an AFTER trigger runs on a partitioned table in SQL Server 2008 R2]:http://support.microsoft.com/kb/2606883
[Cumulative update package 2 (CU2) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2567714
[Cumulative update package 1 (CU1) for SQL Server 2008 R2 Service Pack 1]:http://support.microsoft.com/kb/2544793
[SQL Server 2008 R2 Service Pack 1 (SP1)]:http://www.microsoft.com/download/en/details.aspx?id=26727
[Cumulative update package 14 (CU14) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2703280
[Cumulative update package 13 (CU13) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2679366
[Cumulative update package 12 (CU12) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2659692
[Cumulative update package 11 (CU11) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2633145
[Cumulative update package 10 (CU10) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2591746
[Cumulative update package 9 (CU9) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2567713
[FIX: Database data files might be incorrectly marked as sparse in SQL Server 2008 R2 or in SQL Server 2008 even when the physical files are marked as not sparse in the file system]:http://support.microsoft.com/kb/2574699
[Cumulative update package 8 (CU8) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2534352
[MS11-049: Description of the security update for SQL Server 2008 R2 QFE: June 14, 2011]:http://support.microsoft.com/kb/2494086
[Cumulative update package 7 (CU7) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2507770
[FIX: Non-yielding scheduler error when you run a query that uses a TVP in SQL Server 2008 or in SQL Server 2008 R2 if SQL Profiler or SQL Server Extended Events is used]:http://support.microsoft.com/kb/2520808
[Cumulative update package 6 (CU6) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2489376
[Cumulative update package 5 (CU5) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2438347
[Cumulative update package 4 (CU4) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2345451
[Cumulative update package 3 (CU3) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2261464
[Cumulative update package 2 (CU2) for SQL Server 2008 R2]:http://support.microsoft.com/kb/2072493
[Cumulative update package 1 (CU1) for SQL Server 2008 R2]:http://support.microsoft.com/kb/981355
[MS11-049: Description of the security update for SQL Server 2008 R2 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494088


## Microsoft SQL Server 2008 Builds
<a id="microsoft-sql-server-2008-builds"></a>

| Build        | File version     | KB / Description                                                                                                                                                                                                                                          | Release Date |
|--------------|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 10.0.6547    | 2007.100.6547.0  | [3146034 Intermittent service terminations occur after you install any SQL Server 2008 or SQL Server 2008 R2 versions from KB3135244]                                                                                                                     | 2016-03-03   |
| 10.0.6543    | 2007.100.6543.0  | [3135244 TLS 1.2 support for SQL Server 2008 SP4]                                                                                                                                                                                                         | 2016-01-27   |
| 10.0.6535    | 2007.100.6535.0  | [3045308 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 QFE: July 14, 2015]                                                                                                                                              | 2015-07-14   |
| 10.0.6526    | 2007.100.6526.0  | [3034373 An on-demand hotfix update package is available for SQL Server 2008 Service Pack 4 (SP4)]                                                                                                                                                        | 2015-02-09   |
| 10.0.6241    | 2007.100.6241.0  | [3045311 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 GDR: July 14, 2015]                                                                                                                                              | 2015-07-14   |
| 10.0.6000.29 | 2007.100.6000.29 | [2979596 SQL Server 2008 Service Pack 4 release information]                                                                                                                                                                                              | 2014-09-30   |
| 10.0.5894    | 2007.100.5894.0  | [3135244 TLS 1.2 support for SQL Server 2008 SP3 (IA-64 only)]                                                                                                                                                                                            | 2016-01-27   |
| 10.0.5890    | 2007.100.5890.0  | [3045303 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 QFE: July 14, 2015]                                                                                                                                              | 2015-07-14   |
| 10.0.5869    | 2007.100.5869.0  | [2977322 MS14-044: Description of the security update for SQL Server 2008 SP3 (QFE)]                                                                                                                                                                      | 2014-08-12   |
| 10.0.5867    | 2007.100.5867.0  | [2877204 FIX: Error 8985 when you run the "dbcc shrinkfile" statement by using the logical name of a file in SQL Server 2008 R2 or SQL Server 2008]                                                                                                       | 2014-07-02   |
| 10.0.5861    | 2007.100.5861.0  | [2958696 Cumulative update package 17 (CU17) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2014-05-19   |
| 10.0.5852    | 2007.100.5852.0  | [2936421 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2014-03-17   |
| 10.0.5850    | 2007.100.5850.0  | [2923520 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2014-01-20   |
| 10.0.5848    | 2007.100.5848.0  | [2893410 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2013-11-18   |
| 10.0.5846    | 2007.100.5846.0  | [2880350 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2013-09-16   |
| 10.0.5844    | 2007.100.5844.0  | [2863205 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2013-07-16   |
| 10.0.5841    | 2007.100.5841.0  | [2834048 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 3 (updated)]                                                                                                                                                                | 2013-06-13   |
| 10.0.5840    | 2007.100.5840.0  | 2834048 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 3 (replaced)                                                                                                                                                                 | 2013-05-20   |
| 10.0.5835    | 2007.100.5835.0  | [2814783 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 3]                                                                                                                                                                          | 2013-03-18   |
| 10.0.5829    | 2007.100.5829.0  | [2799883 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2013-01-23   |
| 10.0.5828    | 2007.100.5828.0  | [2771833 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-11-19   |
| 10.0.5826    | 2007.100.5826.0  | [2716435 Microsoft Security Bulletin MS12-070]                                                                                                                                                                                                            | 2012-10-09   |
| 10.0.5794    | 2007.100.5794.0  | [2738350 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-09-21   |
| 10.0.5788    | 2007.100.5788.0  | [2715953 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-07-16   |
| 10.0.5785    | 2007.100.5785.0  | [2696626 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-05-19   |
| 10.0.5775    | 2007.100.5775.0  | [2673383 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-03-20   |
| 10.0.5770    | 2007.100.5770.0  | [2648098 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2012-01-16   |
| 10.0.5768    | 2007.100.5768.0  | [2633143 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2011-11-22   |
| 10.0.5766    | 2007.100.5766.0  | [2617146 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 3]                                                                                                                                                                            | 2011-10-18   |
| 10.0.5538    | 2007.100.5538.0  | [3045305 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 GDR: July 14, 2015]                                                                                                                                              | 2015-07-14   |
| 10.0.5520    | 2007.100.5520.0  | [2977321 MS14-044: Description of the security update for SQL Server 2008 SP3 (GDR)]                                                                                                                                                                      | 2014-08-12   |
| 10.0.5512    | 2007.100.5512.0  | [Microsoft Security Bulletin MS12-070]                                                                                                                                                                                                                    | 2012-10-09   |
| 10.0.5500    | 2007.100.5500.0  | [SQL Server 2008 Service Pack 3 (SP3)]                                                                                                                                                                                                                    | 2011-10-06   |
| 10.0.5416    | 2007.100.5416.0  | SQL Server 2008 Service Pack 3 CTP                                                                                                                                                                                                                        | 2011-08-22   |
| 10.0.4371    | 2007.100.4371.0  | [Microsoft Security Bulletin MS12-070]                                                                                                                                                                                                                    | 2012-10-09   |
| 10.0.4333    | 2007.100.4333.0  | [2715951 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 2]                                                                                                                                                                          | 2012-07-16   |
| 10.0.4332    | 2007.100.4332.0  | [2696625 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 2]                                                                                                                                                                          | 2012-05-20   |
| 10.0.4330    | 2007.100.4330.0  | [2673382 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2012-03-19   |
| 10.0.4326    | 2007.100.4326.0  | [2648096 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2012-01-30   |
| 10.0.4323    | 2007.100.4323.0  | [2617148 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-11-21   |
| 10.0.4321    | 2007.100.4321.0  | [2582285 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-09-20   |
| 10.0.4316    | 2007.100.4316.0  | [2555408 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-07-18   |
| 10.0.4285    | 2007.100.4285.0  | [2527180 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-05-16   |
| 10.0.4279    | 2007.100.4279.0  | [2498535 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-03-11   |
| 10.0.4272    | 2007.100.4272.0  | [2467239 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2011-02-10   |
| 10.0.4266    | 2007.100.4266.0  | [2289254 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 2]                                                                                                                                                                            | 2010-11-15   |
| 10.0.4067    | 2007.100.4067.0  | [Microsoft Security Bulletin MS12-070]                                                                                                                                                                                                                    | 2012-10-09   |
| 10.0.4064    | 2007.100.4064.0  | [2494089 MS11-049: Description of the security update for SQL Server 2008 Service Pack 2 GDR: June 14, 2011]                                                                                                                                              | 2011-06-14   |
| 10.0.4000    | 2007.100.4000.0  | [SQL Server 2008 Service Pack 2 (SP2)]                                                                                                                                                                                                                    | 2010-09-29   |
| 10.0.3798    | 2007.100.3798.0  | SQL Server 2008 Service Pack 2 CTP                                                                                                                                                                                                                        | 2010-07-07   |
| 10.0.2850    | 2007.100.2850.0  | [2582282 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2011-09-19   |
| 10.0.2847    | 2007.100.2847.0  | [2555406 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2011-07-18   |
| 10.0.2821    | 2007.100.2821.0  | [2527187 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2011-05-16   |
| 10.0.2816    | 2007.100.2816.0  | [2497673 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2011-03-22   |
| 10.0.2808    | 2007.100.2808.0  | [2467236 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2011-02-10   |
| 10.0.2804    | 2007.100.2804.0  | [2413738 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2010-11-15   |
| 10.0.2799    | 2007.100.2799.0  | [2279604 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 1]                                                                                                                                                                          | 2010-09-21   |
| 10.0.2789    | 2007.100.2789.0  | [2083921 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 1]                                                                                                                                                                            | 2010-07-21   |
| 10.0.2787    | 2007.100.2787.0  | [2231277 FIX: The Reporting Services service stops unexpectedly after you apply SQL Server 2008 SP1 CU 7 or CU8]                                                                                                                                          | 2010-07-30   |
| 10.0.2775    | 2007.100.2775.0  | [981702 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2010-05-17   |
| 10.0.2766    | 2007.100.2766.0  | [979065 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2010-03-26   |
| 10.0.2757    | 2007.100.2757.0  | [977443 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2010-01-18   |
| 10.0.2746    | 2007.100.2746.0  | [975977 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2009-11-16   |
| 10.0.2740    | 2007.100.2740.0  | [976761 FIX: Error message when you perform a rolling upgrade in a SQL Server 2008 cluster : "18401, Login failed for user SQLTEST\AgentService. Reason: Server is in script upgrade mode. Only administrator can connect at this time.SQLState 42000"]   | 2009-11-24   |
| 10.0.2734    | 2007.100.2734.0  | [973602 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2009-09-22   |
| 10.0.2723    | 2007.100.2723.0  | [971491 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2009-07-21   |
| 10.0.2714    | 2007.100.2714.0  | [970315 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2009-05-18   |
| 10.0.2712    | 2007.100.2712.0  | [970507 FIX: Error message in SQL Server 2008 when you run an INSERT SELECT statement on a table: "Violation of PRIMARY KEY constraint '<PrimaryKey>'. Cannot insert duplicate key in object '<TableName>'"]                                              | 2009-07-21   |
| 10.0.2710    | 2007.100.2710.0  | [969099 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 1]                                                                                                                                                                             | 2009-04-16   |
| 10.0.2573    | 2007.100.2573.0  | [2494096 MS11-049: Description of the security update for SQL Server 2008 Service Pack 1 GDR: June 14, 2011]                                                                                                                                              | 2011-06-14   |
| 10.0.2531    | 2007.100.2531.0  | [SQL Server 2008 Service Pack 1 (SP1)]                                                                                                                                                                                                                    | 2009-04-07   |
| 10.0.2520    | 2007.100.2520.0  | SQL Server 2008 Service Pack 1 - CTP                                                                                                                                                                                                                      | 2009-02-23   |
| 10.0.1835    | 2007.100.1835.0  | [979064 Cumulative update package 10 (CU10) for SQL Server 2008]                                                                                                                                                                                          | 2010-03-15   |
| 10.0.1828    | 2007.100.1828.0  | [977444 Cumulative update package 9 (CU9) for SQL Server 2008]                                                                                                                                                                                            | 2010-01-18   |
| 10.0.1823    | 2007.100.1823.0  | [975976 Cumulative update package 8 (CU8) for SQL Server 2008]                                                                                                                                                                                            | 2009-11-16   |
| 10.0.1818    | 2007.100.1818.0  | [973601 Cumulative update package 7 (CU7) for SQL Server 2008]                                                                                                                                                                                            | 2009-09-21   |
| 10.0.1812    | 2007.100.1812.0  | [971490 Cumulative update package 6 (CU6) for SQL Server 2008]                                                                                                                                                                                            | 2009-07-21   |
| 10.0.1806    | 2007.100.1806.0  | [969531 Cumulative update package 5 (CU5) for SQL Server 2008]                                                                                                                                                                                            | 2009-05-18   |
| 10.0.1798    | 2007.100.1798.0  | [963036 Cumulative update package 4 (CU4) for SQL Server 2008]                                                                                                                                                                                            | 2009-03-17   |
| 10.0.1787    | 2007.100.1787.0  | [960484 Cumulative update package 3 (CU3) for SQL Server 2008]                                                                                                                                                                                            | 2009-01-19   |
| 10.0.1779    | 2007.100.1779.0  | [958186 Cumulative update package 2 (CU2) for SQL Server 2008]                                                                                                                                                                                            | 2008-11-19   |
| 10.0.1771    | 2007.100.1771.0  | [958611 FIX: You may receive incorrect results when you run a query that references three or more tables in the FROM clause in SQL Server 2008]                                                                                                           | 2008-10-29   |
| 10.0.1763    | 2007.100.1763.0  | [956717 Cumulative update package 1 (CU1) for SQL Server 2008]                                                                                                                                                                                            | 2008-10-28   |
| 10.0.1750    | 2007.100.1750.0  | [956718 FIX: A MERGE statement may not enforce a foreign key constraint when the statement updates a unique key column that is not part of a clustering key that has a single row as the update source in SQL Server 2008]                                | 2008-08-25   |
| 10.0.1600    | 2007.100.1600.22 | [SQL Server 2008 RTM]                                                                                                                                                                                                                                     | 2008-08-07   |
| 10.0.1442    | 2007.100.1442.32 | Microsoft SQL Server 2008 RC0                                                                                                                                                                                                                             | 2008-06-05   |
| 10.0.1300    | 2007.100.1300.13 | Microsoft SQL Server 2008 CTP, February 2008                                                                                                                                                                                                              | 2008-02-19   |
| 10.0.1075    | 2007.100.1075.23 | Microsoft SQL Server 2008 CTP, November 2007                                                                                                                                                                                                              | 2007-11-18   |
| 10.0.1049    | 2007.100.1049.14 | SQL Server 2008 CTP, July 2007                                                                                                                                                                                                                            | 2007-07-31   |
| 10.0.1019    | 2007.100.1019.17 | SQL Server 2008 CTP, June 2007                                                                                                                                                                                                                            | 2007-05-21   |

[3146034 Intermittent service terminations occur after you install any SQL Server 2008 or SQL Server 2008 R2 versions from KB3135244]:http://support.microsoft.com/kb/3146034
[3135244 TLS 1.2 support for SQL Server 2008 SP4]:http://support.microsoft.com/kb/3135244
[3045308 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 QFE: July 14, 2015]:http://support.microsoft.com/kb/3045308
[3034373 An on-demand hotfix update package is available for SQL Server 2008 Service Pack 4 (SP4)]:http://support.microsoft.com/kb/3034373
[3045311 MS15-058: Description of the security update for SQL Server 2008 Service Pack 4 GDR: July 14, 2015]:https://support.microsoft.com/kb/3045311
[2979596 SQL Server 2008 Service Pack 4 release information]:https://support.microsoft.com/kb/2979596
[3135244 TLS 1.2 support for SQL Server 2008 SP3 (IA-64 only)]:http://support.microsoft.com/kb/3135244
[3045303 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 QFE: July 14, 2015]:https://support.microsoft.com/kb/3045303
[2977322 MS14-044: Description of the security update for SQL Server 2008 SP3 (QFE)]:http://support.microsoft.com/kb/2977322
[2877204 FIX: Error 8985 when you run the "dbcc shrinkfile" statement by using the logical name of a file in SQL Server 2008 R2 or SQL Server 2008]:http://support.microsoft.com/kb/2877204
[2958696 Cumulative update package 17 (CU17) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2958696
[2936421 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2936421
[2923520 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2923520
[2893410 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2893410
[2880350 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2880350
[2863205 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2863205
[2834048 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 3 (updated)]:http://support.microsoft.com/kb/2834048
[2814783 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2814783
[2799883 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2799883
[2771833 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2771833
[2716435 Microsoft Security Bulletin MS12-070]:http://support.microsoft.com/kb/2716435
[2738350 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2738350
[2715953 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2715953
[2696626 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2696626
[2673383 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2673383
[2648098 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2648098
[2633143 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2633143
[2617146 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 3]:http://support.microsoft.com/kb/2617146
[3045305 MS15-058: Description of the security update for SQL Server 2008 Service Pack 3 GDR: July 14, 2015]:https://support.microsoft.com/kb/3045305
[2977321 MS14-044: Description of the security update for SQL Server 2008 SP3 (GDR)]:http://support.microsoft.com/kb/2977321
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/security/bulletin/ms12-070
[SQL Server 2008 Service Pack 3 (SP3)]:http://www.microsoft.com/download/en/details.aspx?id=27594
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/security/bulletin/ms12-070
[2715951 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2715951
[2696625 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2696625
[2673382 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2673382
[2648096 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2648096
[2617148 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2617148
[2582285 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2582285
[2555408 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2555408
[2527180 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2527180
[2498535 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2498535
[2467239 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2467239
[2289254 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 2]:http://support.microsoft.com/kb/2289254
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/security/bulletin/ms12-070
[2494089 MS11-049: Description of the security update for SQL Server 2008 Service Pack 2 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494089
[SQL Server 2008 Service Pack 2 (SP2)]:http://www.microsoft.com/downloads/en/details.aspx?FamilyID=8FBFC1DE-D25E-4790-88B5-7DDA1F1D4E17
[2582282 Cumulative update package 16 (CU16) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2582282
[2555406 Cumulative update package 15 (CU15) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2555406
[2527187 Cumulative update package 14 (CU14) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2527187
[2497673 Cumulative update package 13 (CU13) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2497673
[2467236 Cumulative update package 12 (CU12) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2467236
[2413738 Cumulative update package 11 (CU11) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2413738
[2279604 Cumulative update package 10 (CU10) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2279604
[2083921 Cumulative update package 9 (CU9) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/2083921
[2231277 FIX: The Reporting Services service stops unexpectedly after you apply SQL Server 2008 SP1 CU 7 or CU8]:http://support.microsoft.com/kb/2231277
[981702 Cumulative update package 8 (CU8) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/981702
[979065 Cumulative update package 7 (CU7) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/979065
[977443 Cumulative update package 6 (CU6) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/977443
[975977 Cumulative update package 5 (CU5) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/975977
[976761 FIX: Error message when you perform a rolling upgrade in a SQL Server 2008 cluster : "18401, Login failed for user SQLTEST\AgentService. Reason: Server is in script upgrade mode. Only administrator can connect at this time.SQLState 42000"]:http://support.microsoft.com/kb/976761
[973602 Cumulative update package 4 (CU4) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/973602
[971491 Cumulative update package 3 (CU3) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/971491
[970315 Cumulative update package 2 (CU2) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/970315
[970507 FIX: Error message in SQL Server 2008 when you run an INSERT SELECT statement on a table: "Violation of PRIMARY KEY constraint '<PrimaryKey>'. Cannot insert duplicate key in object '<TableName>'"]:http://support.microsoft.com/kb/970507
[969099 Cumulative update package 1 (CU1) for SQL Server 2008 Service Pack 1]:http://support.microsoft.com/kb/969099
[2494096 MS11-049: Description of the security update for SQL Server 2008 Service Pack 1 GDR: June 14, 2011]:http://support.microsoft.com/kb/2494096
[SQL Server 2008 Service Pack 1 (SP1)]:http://www.microsoft.com/download/details.aspx?id=20302
[979064 Cumulative update package 10 (CU10) for SQL Server 2008]:http://support.microsoft.com/kb/979064
[977444 Cumulative update package 9 (CU9) for SQL Server 2008]:http://support.microsoft.com/kb/977444
[975976 Cumulative update package 8 (CU8) for SQL Server 2008]:http://support.microsoft.com/kb/975976
[973601 Cumulative update package 7 (CU7) for SQL Server 2008]:http://support.microsoft.com/kb/973601
[971490 Cumulative update package 6 (CU6) for SQL Server 2008]:http://support.microsoft.com/kb/971490
[969531 Cumulative update package 5 (CU5) for SQL Server 2008]:http://support.microsoft.com/kb/969531
[963036 Cumulative update package 4 (CU4) for SQL Server 2008]:http://support.microsoft.com/kb/963036
[960484 Cumulative update package 3 (CU3) for SQL Server 2008]:http://support.microsoft.com/kb/960484
[958186 Cumulative update package 2 (CU2) for SQL Server 2008]:http://support.microsoft.com/kb/958186
[958611 FIX: You may receive incorrect results when you run a query that references three or more tables in the FROM clause in SQL Server 2008]:http://support.microsoft.com/kb/958611
[956717 Cumulative update package 1 (CU1) for SQL Server 2008]:http://support.microsoft.com/kb/956717
[956718 FIX: A MERGE statement may not enforce a foreign key constraint when the statement updates a unique key column that is not part of a clustering key that has a single row as the update source in SQL Server 2008]:http://support.microsoft.com/kb/956718
[SQL Server 2008 RTM]:http://msdn.microsoft.com/subscriptions/downloads/details/default.aspx?pm=pid%3a334


## Microsoft SQL Server 2005 Builds
<a id="microsoft-sql-server-2005-builds"></a>

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
| 9.00.1518 | 2005.90.1518.0 | 913941 FIX: A SQL Server login may have more permissions when you log on to an instance of SQL Server 2005                                                                                                                                                           | 2006-09-22   |
| 9.00.1518 | 2005.90.1518.0 | 912472 FIX: An incorrect result may appear in the subscribing database when you set database mirroring for a database and database failover occurs in SQL Server 2005                                                                                                | 2006-07-26   |
| 9.00.1518 | 2005.90.1518.0 | 913371 FIX: You may receive error messages when you use the sp_cursoropen statement to open a cursor on a user-defined stored procedure in SQL Server 2005                                                                                                           | 2006-07-26   |
| 9.00.1514 | 2005.90.1514.0 | 912471 FIX: The replication on the server does not work any longer when you manually fail over databases in SQL Server 2005                                                                                                                                          | 2006-07-26   |
| 9.00.1503 | 2005.90.1503.0 | 911662 FIX: You may receive an access violation error message when you run a SELECT query in SQL Server 2005                                                                                                                                                         | 2006-07-26   |
| 9.00.1502 | 2005.90.1502.0 | 915793 FIX: You cannot restore the log backups on the mirror server after you remove database mirroring for the mirror database in SQL Server 2005                                                                                                                   | 2006-07-26   |
| 9.00.1500 | 2005.90.1500.0 | 910416 FIX: Error message when you run certain queries or certain stored procedures in SQL Server 2005: "A severe error occurred on the current command"                                                                                                             | 2006-06-01   |
| 9.00.1406 | 2005.90.1406.0 | 932557 FIX: A script task or a script component may not run correctly when you run an SSIS package in SQL Server 2005 build 1399                                                                                                                                     | 2007-07-11   |
| 9.00.1399 | 2005.90.1399.0 | SQL Server 2005 RTM                                                                                                                                                                                                                                                  | 2005-11-07   |

[2716427 MS12-070: Description of the security update for SQL Server 2005 Service Pack 4 QFE]:http://support.microsoft.com/kb/2716427
[2615425 FIX: "Msg 7359" error when a view uses another view in SQL Server 2005 if the schema version of a remote table is updated]:http://support.microsoft.com/kb/2615425
[2598903 FIX: SQL Server Agent job randomly stops when you schedule the job to run past midnight on specific days in SQL Server 2005, in SQL Server 2008 or in SQL Server 2008 R2]:http://support.microsoft.com/kb/2598903
[2572407 FIX: Error 5180 when you use the ONLINE option to rebuild an index in SQL Server 2005]:http://support.microsoft.com/kb/2572407
[2494123 MS11-049: Description of the security update for SQL Server 2005 Service Pack 4 QFE: June 14, 2011]:http://support.microsoft.com/kb/2494123
[2507769 Cumulative update package 3 (CU3) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2507769
[2489409 Cumulative update package 2 (CU2) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2489409
[2464079 Cumulative update package 1 (CU1) for SQL Server 2005 Service Pack 4]:http://support.microsoft.com/kb/2464079
[Microsoft Security Bulletin MS12-070]:http://technet.microsoft.com/security/bulletin/ms12-070
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
[933499 FIX: Error message when you use transactional replication to replicate the execution of stored procedures to subscribers in SQL Server 2005: "Insufficient memory to run query"]:https://support.microsoft.com/kb/933499
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
[926493 FIX: Error message when you restore a transaction-log backup that is generated in SQL Server 2000 SP4 to an instance of SQL Server 2005: "Msg 3456, Level 16, State 1, Line 1. Could not redo log record"]:https://support.microsoft.com/kb/926493
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
[913941 FIX: A SQL Server login may have more permissions when you log on to an instance of SQL Server 2005]:https://web.archive.org/web/20170712163528/https://support.microsoft.com/en-us/help/913494


## Microsoft SQL Server 2000 Builds
<a id="microsoft-sql-server-2000-builds"></a>

| Build     | File version   | KB / Description                                                                                                                                                                                                                                              | Release Date |
|-----------|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 8.00.2305 | 2000.80.2305.0 | [983811 MS12-060: Description of the security update for SQL Server 2000 Service Pack 4 QFE: August 14, 2012]                                                                                                                                                 | 2012-08-14   |
| 8.00.2301 | 2000.80.2301.0 | [983809 MS12-027: Description of the security update for Microsoft SQL Server 2000 Service Pack 4 QFE: April 10, 2012]                                                                                                                                        | 2012-04-10   |
| 8.00.2283 | 2000.80.2283.0 | 971524 FIX: An access violation occurs when you run a DELETE statement or an UPDATE statement in the Itanium-based versions of SQL Server 2000 after you install security update MS09-004]                                                                    | 2009-06-15   |
| 8.00.2282 | 2000.80.2282.0 | [960083 MS09-004: Description of the security update for SQL Server 2000 QFE and for MSDE 2000: February 10, 2009]                                                                                                                                            | 2009-02-10   |
| 8.00.2279 | 2000.80.2279.0 | 959678 FIX: When you run the SPSBackup.exe utility to back up a SQL Server 2000 database that is configured as a back-end database for a Windows SharePoint Services server, the backup operation fails                                                       | 2009-04-08   |
| 8.00.2273 | 2000.80.2273.0 | 948111 MS08-040: Description of the security update for SQL Server 2000 QFE and MSDE 2000 July 8, 2008                                                                                                                                                        | 2008-08-05   |
| 8.00.2271 | 2000.80.2271.0 | 946584 FIX: The SPACE function always returns one space in SQL Server 2000 if the SPACE function uses a collation that differs from the collation of the current database                                                                                     | 2008-03-12   |
| 8.00.2265 | 2000.80.2265.0 | 944985 FIX: The data on the publisher does not match the data on the subscriber when you synchronize a SQL Server 2005 Mobile Edition subscriber with a SQL Server 2000 "merge replication" publisher                                                         | 2007-12-19   |
| 8.00.2253 | 2000.80.2253.0 | 939317 FIX: The CPU utilization may suddenly increase to 100 percent when there are many connections to an instance of SQL Server 2000 on a computer that has multiple processors                                                                             | 2007-10-09   |
| 8.00.2249 | 2000.80.2249.0 | 936232 FIX: An access violation may occur when you try to log in to an instance of SQL Server 2000                                                                                                                                                            | 2007-05-25   |
| 8.00.2248 | 2000.80.2248.0 | 935950 FIX: The foreign key that you created between two tables does not work after you run the CREATE INDEX statement in SQL Server 2000                                                                                                                     | 2007-06-14   |
| 8.00.2246 | 2000.80.2246.0 | 935465 An updated version of Sqlvdi.dll is now available for SQL Server 2000                                                                                                                                                                                  | 2007-06-18   |
| 8.00.2245 | 2000.80.2245.0 | 933573 FIX: You may receive an assertion or database corruption may occur when you use the bcp utility or the "Bulk Insert" Transact-SQL command to import data in SQL Server 2000                                                                            | 2007-04-24   |
| 8.00.2244 | 2000.80.2244.0 | 934203 FIX: A hotfix for Microsoft SQL Server 2000 Service Pack 4 may not update all the necessary files on an x64-based computer                                                                                                                             | 2007-05-10   |
| 8.00.2242 | 2000.80.2242.0 | 929131 FIX: In SQL Server 2000, the synchronization process is slow, and the CPU usage is high on the computer that is configured as the Distributor                                                                                                          | 2007-03-28   |
| 8.00.2238 | 2000.80.2238.0 | 931932 FIX: The merge agent fails intermittently when you use merge replication that uses a custom resolver after you install SQL Server 2000 Service Pack 4                                                                                                  | 2007-02-21   |
| 8.00.2236 | 2000.80.2236.0 | 930484 FIX: CPU utilization may approach 100 percent on a computer that is running SQL Server 2000 after you run the BACKUP DATABASE statement or the BACKUP LOG statement                                                                                    | 2007-02-02   |
| 8.00.2234 | 2000.80.2234.0 | 929440 FIX: Error messages when you try to update table rows or insert table rows into a table in SQL Server 2000: "644" or "2511"                                                                                                                            | 2007-02-22   |
| 8.00.2232 | 2000.80.2232.0 | 928568 FIX: SQL Server 2000 stops responding when you cancel a query or when a query time-out occurs, and error messages are logged in the SQL Server error log file                                                                                          | 2007-01-15   |
| 8.00.2231 | 2000.80.2231.0 | 928079 FIX: The Sqldumper.exe utility cannot generate a filtered SQL Server dump file when you use the Remote Desktop Connection service or Terminal Services to connect to a Windows 2000 Server-based computer in SQL Server 2000                           | 2007-06-19   |
| 8.00.2229 | 2000.80.2229.0 | 927186 FIX: Error message when you create a merge replication for tables that have computed columns in SQL Server 2000 Service Pack 4: "The process could not log conflict information"                                                                       | 2007-07-24   |
| 8.00.2226 | 2000.80.2226.0 | 925684 FIX: You may experience one or more symptoms when you run a "CREATE INDEX" statement on an instance of SQL Server 2000                                                                                                                                 | 2006-11-20   |
| 8.00.2226 | 2000.80.2226.0 | 925732 FIX: You may receive inconsistent comparison results when you compare strings by using a width sensitive collation in SQL Server 2000                                                                                                                  | 2006-11-13   |
| 8.00.2223 | 2000.80.2223.0 | 925419 FIX: The server stops responding, the performance is slow, and a time-out occurs in SQL Server 2000                                                                                                                                                    | 2007-07-20   |
| 8.00.2223 | 2000.80.2223.0 | 925678 FIX: Error message when you schedule a Replication Merge Agent job to run after you install SQL Server 2000 Service Pack 4: "The process could not enumerate changes at the 'Subscriber'"                                                              | 2006-10-31   |
| 8.00.2218 | 2000.80.2218.0 | 925297 FIX: The result may be sorted in the wrong order when you run a query that uses the ORDER BY clause to sort a column in a table in SQL Server 2000                                                                                                     | 2007-06-19   |
| 8.00.2217 | 2000.80.2217.0 | 924664 FIX: You cannot stop the SQL Server service, or many minidump files and many log files are generated in SQL Server 2000                                                                                                                                | 2007-10-25   |
| 8.00.2215 | 2000.80.2215.0 | 923796 FIX: Data in a subscriber of a merge publication in SQL Server 2000 differs from the data in the publisher                                                                                                                                             | 2007-01-12   |
| 8.00.2215 | 2000.80.2215.0 | 924662 FIX: The query performance may be slow when you query data from a view in SQL Server 2000                                                                                                                                                              | 2006-10-05   |
| 8.00.2215 | 2000.80.2215.0 | 923563 FIX: Error message when you configure an immediate updating transactional replication in SQL Server 2000: "Implicit conversion from datatype 'text' to 'nvarchar' is not allowed"                                                                      | 2006-10-30   |
| 8.00.2215 | 2000.80.2215.0 | 923327 FIX: You may receive an access violation error message when you import data by using the "Bulk Insert" command in SQL Server 2000                                                                                                                      | 2006-12-28   |
| 8.00.2209 | 2000.80.2209.0 | 923797 The Knowledge Base (KB) Article You Requested Is Currently Not Available                                                                                                                                                                               | ???          |
| 8.00.2207 | 2000.80.2207.0 | 923344 FIX: A SQL Server 2000 session may be blocked for the whole time that a Snapshot Agent job runs                                                                                                                                                        | 2006-08-28   |
| 8.00.2201 | 2000.80.2201.0 | 920930 FIX: Error message when you try to run a query on a linked server in SQL Server 2000                                                                                                                                                                   | 2006-08-21   |
| 8.00.2199 | 2000.80.2199.0 | 919221 FIX: SQL Server 2000 may take a long time to complete the synchronization phase when you create a merge publication                                                                                                                                    | 2006-07-26   |
| 8.00.2197 | 2000.80.2197.0 | 919133 FIX: Each query takes a long time to compile when you execute a single query or when you execute multiple concurrent queries in SQL Server 2000                                                                                                        | 2006-08-02   |
| 8.00.2197 | 2000.80.2197.0 | 919068 FIX: The query may return incorrect results, and the execution plan for the query may contain a "Table Spool" operator in SQL Server 2000                                                                                                              | 2006-08-08   |
| 8.00.2197 | 2000.80.2197.0 | 919399 FIX: A profiler trace in SQL Server 2000 may stop logging events unexpectedly, and you may receive the following error message: "Failed to read trace data"                                                                                            | 2006-10-18   |
| 8.00.2196 | 2000.80.2196.0 | 919165 FIX: A memory leak occurs when you run a remote query by using a linked server in SQL Server 2000                                                                                                                                                      | 2006-08-14   |
| 8.00.2194 | 2000.80.2194.0 | 917565 FIX: Error 17883 is logged in the SQL Server error log, and the instance of SQL Server 2000 temporarily stops responding                                                                                                                               | 2007-02-21   |
| 8.00.2194 | 2000.80.2194.0 | 917972 FIX: You receive an access violation error message when you try to perform a read of a large binary large object column in SQL Server 2000                                                                                                             | 2006-09-22   |
| 8.00.2192 | 2000.80.2192.0 | 917606 FIX: You may notice a decrease in performance when you run a query that uses the UNION ALL operator in SQL Server 2000 Service Pack 4                                                                                                                  | 2006-08-04   |
| 8.00.2191 | 2000.80.2191.0 | 916698 FIX: Error message when you run SQL Server 2000: "Failed assertion = 'lockFound == TRUE'"                                                                                                                                                              | 2006-07-26   |
| 8.00.2191 | 2000.80.2191.0 | 916950 FIX: You may experience heap corruption, and SQL Server 2000 may shut down with fatal access violations when you try to browse files in SQL Server 2000 Enterprise Manager on a Windows Server 2003 x64-based computer                                 | 2006-10-03   |
| 8.00.2189 | 2000.80.2189.0 | 916652 FIX: An access violation may occur when you run a query on a table that has a multicolumn index in SQL Server 2000                                                                                                                                     | 2006-07-26   |
| 8.00.2189 | 2000.80.2189.0 | 913438 FIX: The SQL Server process may end unexpectedly when you turn on trace flag -T1204 and a profiler trace is capturing the Lock:DeadLock Chain event in SQL Server 2000 SP4                                                                             | 2006-07-19   |
| 8.00.2187 | 2000.80.2187.0 | 915340 FIX: A deadlock occurs when the scheduled SQL Server Agent job that you add or that you update is running in SQL Server 2000                                                                                                                           | 2007-06-18   |
| 8.00.2187 | 2000.80.2187.0 | 916287 A cumulative hotfix package is available for SQL Server 2000 Service Pack 4 build 2187                                                                                                                                                                 | 2006-10-16   |
| 8.00.2187 | 2000.80.2187.0 | 914384 FIX: The database status changes to Suspect when you perform a bulk copy in a transaction and then roll back the transaction in SQL Server 2000                                                                                                        | 2006-07-26   |
| 8.00.2187 | 2000.80.2187.0 | 915065 FIX: Error message when you try to apply a hotfix on a SQL Server 2000-based computer that is configured as a MSCS node: "An error in updating your system has occurred"                                                                               | 2006-12-11   |
| 8.00.2180 | 2000.80.2180.0 | 913789 FIX: The password that you specify in a BACKUP statement appears in the SQL Server Errorlog file or in the Application event log if the BACKUP statement does not run in SQL Server 2000                                                               | 2007-02-19   |
| 8.00.2180 | 2000.80.2180.0 | 913684 FIX: You may receive error messages when you use linked servers in SQL Server 2000 on a 64-bit Itanium processor                                                                                                                                       | 2006-07-26   |
| 8.00.2175 | 2000.80.2175.0 | 911678 FIX: No rows may be returned, and you may receive an error message when you try to import SQL Profiler trace files into tables by using the fn_trace_gettable function in SQL Server 2000                                                              | 2006-07-26   |
| 8.00.2172 | 2000.80.2172.0 | 910707 FIX: When you query a view that was created by using the VIEW_METADATA option, an access violation may occur in SQL Server 2000                                                                                                                        | 2006-07-26   |
| 8.00.2171 | 2000.80.2171.0 | 909369 FIX: Automatic checkpoints on some SQL Server 2000 databases do not run as expected                                                                                                                                                                    | 2006-07-26   |
| 8.00.2168 | 2000.80.2168.0 | 907813 FIX: An error occurs when you try to access the Analysis Services performance monitor counter object after you apply Windows Server 2003 SP1                                                                                                           | 2006-11-21   |
| 8.00.2166 | 2000.80.2166.0 | 909734 FIX: An error message is logged, and new diagnostics do not capture the thread stack when the SQL Server User Mode Scheduler (UMS) experiences a nonyielding thread in SQL Server 2000 Service Pack 4                                                  | 2006-07-26   |
| 8.00.2162 | 2000.80.2162.0 | 904660 A cumulative hotfix package is available for SQL Server 2000 Service Pack 4 build 2162                                                                                                                                                                 | 2006-09-15   |
| 8.00.2159 | 2000.80.2159.0 | 907250 FIX: You may experience concurrency issues when you run the DBCC INDEXDEFRAG statement in SQL Server 2000                                                                                                                                              | 2006-07-26   |
| 8.00.2156 | 2000.80.2156.0 | 906790 FIX: You receive an error message when you try to rebuild the master database after you have installed hotfix builds in SQL Server 2000 SP4 64-bit                                                                                                     | 2006-07-25   |
| 8.00.2151 | 2000.80.2151.0 | 903742 FIX: You receive an "Error: 8526, Severity: 16, State: 2" error message in SQL Profiler when you use SQL Query Analyzer to start or to enlist into a distributed transaction after you have installed SQL Server 2000 SP4                              | 2006-07-25   |
| 8.00.2151 | 2000.80.2151.0 | 904244 FIX: Incorrect data is inserted unexpectedly when you perform a bulk copy operation by using the DB-Library API in SQL Server 2000 Service Pack 4                                                                                                      | 2007-06-13   |
| 8.00.2148 | 2000.80.2148.0 | 899430 FIX: An access violation may occur when you run a SELECT query and the NO_BROWSETABLE option is set to ON in Microsoft SQL Server 2000                                                                                                                 | 2006-07-25   |
| 8.00.2148 | 2000.80.2148.0 | 899431 FIX: An access violation occurs in the Mssdi98.dll file, and SQL Server crashes when you use SQL Query Analyzer to debug a stored procedure in SQL Server 2000 Service Pack 4                                                                          | 2006-07-25   |
| 8.00.2148 | 2000.80.2148.0 | 900390 FIX: The Mssdmn.exe process may use lots of CPU capacity when you perform a SQL Server 2000 full text search of Office Word documents                                                                                                                  | 2006-06-01   |
| 8.00.2148 | 2000.80.2148.0 | 900404 FIX: The results of the query may be returned much slower than you expect when you run a query that includes a GROUP BY statement in SQL Server 2000                                                                                                   | 2006-06-01   |
| 8.00.2148 | 2000.80.2148.0 | 901212 FIX: You receive an error message if you use the sp_addalias or sp_dropalias procedures when the IMPLICIT_TRANSACTIONS option is set to ON in SQL Server 2000 SP4                                                                                      | 2006-07-25   |
| 8.00.2148 | 2000.80.2148.0 | 902150 FIX: Some 32-bit applications that use SQL-DMO and SQL-VDI APIs may stop working after you install SQL Server 2000 Service Pack 4 on an Itanium-based computer                                                                                         | 2006-06-01   |
| 8.00.2148 | 2000.80.2148.0 | 902955 FIX: You receive a "Getting registry information" message when you run the Sqldiag.exe utility after you install SQL Server 2000 SP4                                                                                                                   | 2006-07-25   |
| 8.00.2147 | 2000.80.2147.0 | 899410 FIX: You may experience slow server performance when you start a trace in an instance of SQL Server 2000 that runs on a computer that has more than four processors                                                                                    | 2006-06-01   |
| 8.00.2145 | 2000.80.2145.0 | 826906 FIX: A query that uses a view that contains a correlated subquery and an aggregate runs slowly                                                                                                                                                         | 2005-10-25   |
| 8.00.2145 | 2000.80.2145.0 | 836651 FIX: You receive query results that were not expected when you use both ANSI joins and non-ANSI joins                                                                                                                                                  | 2006-06-07   |
| 8.00.2066 | 2000.80.2066.0 | Microsoft Security Bulletin MS12-060                                                                                                                                                                                                                          | 2012-08-14   |
| 8.00.2065 | 2000.80.2065.0 | 983808 MS12-027: Description of the security update for Microsoft SQL Server 2000 Service Pack 4 GDR: April 10, 2012                                                                                                                                          | 2012-04-10   |
| 8.00.2055 | 2000.80.2055.0 | 959420 MS09-004: Vulnerabilities in Microsoft SQL Server could allow remote code execution                                                                                                                                                                    | 2009-02-10   |
| 8.00.2040 | 2000.80.2040.0 | 899761 FIX: Not all memory is available when AWE is enabled on a computer that is running a 32-bit version of SQL Server 2000 SP4                                                                                                                             | 2006-08-15   |
| 8.00.2039 | 2000.80.2039.0 | SQL Server 2000 Service Pack 4 (SP4)                                                                                                                                                                                                                          | 2005-05-06   |
| 8.00.2026 | 2000.80.2026.0 | SQL Server 2000 Service Pack 4 (SP4) Beta                                                                                                                                                                                                                     | ???          |
| 8.00.1547 | 2000.80.1547.0 | 899410 FIX: You may experience slow server performance when you start a trace in an instance of SQL Server 2000 that runs on a computer that has more than four processors                                                                                    | 2006-06-01   |
| 8.00.1077 | 2000.80.1077.0 | 983814 MS12-070: Description of the security update for SQL Server 2000 Reporting Services Service Pack 2                                                                                                                                                     | 2012-10-09   |
| 8.00.1037 | 2000.80.1037.0 | 930484 FIX: CPU utilization may approach 100 percent on a computer that is running SQL Server 2000 after you run the BACKUP DATABASE statement or the BACKUP LOG statement                                                                                    | 2007-02-02   |
| 8.00.1036 | 2000.80.1036.0 | 929410 FIX: Error message when you run a full-text query in SQL Server 2000: "Error: 17883, Severity: 1, State: 0"                                                                                                                                            | 2007-01-11   |
| 8.00.1035 | 2000.80.1035.0 | 917593 FIX: The "Audit Logout" event does not appear in the trace results file when you run a profiler trace against a linked server instance in SQL Server 2000                                                                                              | 2006-09-22   |
| 8.00.1034 | 2000.80.1034.0 | 915328 FIX: You may intermittently experience an access violation error when a query is executed in a parallel plan and the execution plan contains either a HASH JOIN operation or a Sort operation in SQL Server 2000                                       | 2006-08-09   |
| 8.00.1029 | 2000.80.1029.0 | 902852 FIX: Error message when you run an UPDATE statement that uses two JOIN hints to update a table in SQL Server 2000: "Internal SQL Server error"                                                                                                         | 2006-06-01   |
| 8.00.1027 | 2000.80.1027.0 | 900416 FIX: A 17883 error may occur you run a query that uses a hash join in SQL Server 2000                                                                                                                                                                  | 2006-07-25   |
| 8.00.1025 | 2000.80.1025.0 | 899428 FIX: You receive incorrect results when you run a query that uses a cross join operator in SQL Server 2000 SP3                                                                                                                                         | 2006-06-01   |
| 8.00.1025 | 2000.80.1025.0 | 899430 FIX: An access violation may occur when you run a SELECT query and the NO_BROWSETABLE option is set to ON in Microsoft SQL Server 2000                                                                                                                 | 2006-07-25   |
| 8.00.1024 | 2000.80.1024.0 | 898709 FIX: Error message when you use SQL Server 2000: "Time out occurred while waiting for buffer latch type 3"                                                                                                                                             | 2006-07-25   |
| 8.00.1021 | 2000.80.1021.0 | 887700 FIX: Server Network Utility may display incorrect protocol properties in SQL Server 2000                                                                                                                                                               | 2006-07-25   |
| 8.00.1020 | 2000.80.1020.0 | 896985 FIX: The Subscriber may not be able to upload changes to the Publisher when you incrementally add an article to a publication in SQL Server 2000 SP3                                                                                                   | 2006-07-25   |
| 8.00.1019 | 2000.80.1019.0 | 897572 FIX: You may receive a memory-related error message when you repeatedly create and destroy an out-of-process COM object within the same batch or stored procedure in SQL Server 2000                                                                   | 2006-06-01   |
| 8.00.1017 | 2000.80.1017.0 | 896425 FIX: The BULK INSERT statement silently skips insert attempts when the data value is NULL and the column is defined as NOT NULL for INT, SMALLINT, and BIGINT data types in SQL Server 2000                                                            | 2006-06-01   |
| 8.00.1014 | 2000.80.1014.0 | 895123 FIX: You may receive error message 701, error message 802, and error message 17803 when many hashed buffers are available in SQL Server 2000                                                                                                           | 2006-06-01   |
| 8.00.1014 | 2000.80.1014.0 | 895187 FIX: You receive an error message when you try to delete records by running a Delete Transact-SQL statement in SQL Server 2000                                                                                                                         | 2006-07-25   |
| 8.00.1013 | 2000.80.1013.0 | 891866 FIX: The query runs slower than you expected when you try to parse a query in SQL Server 2000                                                                                                                                                          | 2006-06-01   |
| 8.00.1009 | 2000.80.1009.0 | 894257 FIX: You receive an "Incorrect syntax near ')'" error message when you run a script that was generated by SQL-DMO for an Operator object in SQL Server 2000                                                                                            | 2006-06-01   |
| 8.00.1007 | 2000.80.1007.0 | 893312 FIX: You may receive a "SQL Server could not spawn process_loginread thread" error message, and a memory leak may occur when you cancel a remote query in SQL Server 2000                                                                              | 2006-06-01   |
| 8.00.1003 | 2000.80.1003.0 | 892923 FIX: Differential database backups may not contain database changes in the Page Free Space (PFS) pages in SQL Server 2000                                                                                                                              | 2006-06-01   |
| 8.00.1001 | 2000.80.1001.0 | 892205 FIX: You may receive a 17883 error message when SQL Server 2000 performs a very large hash operation                                                                                                                                                   | 2006-06-01   |
| 8.00.1000 | 2000.80.1000.0 | 891585 FIX: Database recovery does not occur, or a user database is marked as suspect in SQL Server 2000                                                                                                                                                      | 2006-06-01   |
| 8.00.997  | 2000.80.997.0  | 891311 FIX: You cannot create new TCP/IP socket based connections after error messages 17882 and 10055 are written to the Microsoft SQL Server 2000 error log                                                                                                 | 2006-07-18   |
| 8.00.996  | 2000.80.996.0  | 891017 FIX: SQL Server 2000 may stop responding to other requests when you perform a large deallocation operation                                                                                                                                             | 2006-06-01   |
| 8.00.996  | 2000.80.996.0  | 891268 FIX: You receive a 17883 error message and SQL Server 2000 may stop responding to other requests when you perform large in-memory sort operations                                                                                                      | 2006-06-01   |
| 8.00.994  | 2000.80.994.0  | 890942 FIX: Some complex queries are slower after you install SQL Server 2000 Service Pack 2 or SQL Server 2000 Service Pack 3                                                                                                                                | 2006-06-01   |
| 8.00.994  | 2000.80.994.0  | 890768 FIX: You experience non-convergence in a replication topology when you unpublish or drop columns from a dynamically filtered publication in SQL Server 2000                                                                                            | 2006-06-01   |
| 8.00.994  | 2000.80.994.0  | 890767 FIX: You receive a "Server: Msg 107, Level 16, State 3, Procedure TEMP_VIEW_Merge, Line 1" error message when the sum of the length of the published column names in a merge publication exceeds 4,000 characters in SQL Server 2000                   | 2006-06-01   |
| 8.00.993  | 2000.80.993.0  | 890925 FIX: The @@ERROR system function may return an incorrect value when you execute a Transact-SQL statement that uses a parallel execution plan in SQL Server 2000 32-bit or in SQL Server 2000 64-bit                                                    | 2006-06-01   |
| 8.00.993  | 2000.80.993.0  | 888444 FIX: You receive a 17883 error in SQL Server 2000 Service Pack 3 or in SQL Server 2000 Service Pack 3a when a worker thread becomes stuck in a registry call                                                                                           | 2006-06-01   |
| 8.00.993  | 2000.80.993.0  | 890742 FIX: Error message when you use a loopback linked server to run a distributed query in SQL Server 2000: "Could not perform the requested operation because the minimum query memory is not available"                                                  | 2006-05-15   |
| 8.00.991  | 2000.80.991.0  | 889314 FIX: Non-convergence may occur in a merge replication topology if the primary connection to the publisher is disconnected                                                                                                                              | 2006-06-01   |
| 8.00.990  | 2000.80.990.0  | 890200 FIX: SQL Server 2000 stops listening for new TCP/IP Socket connections unexpectedly after error message 17882 is written to the SQL Server 2000 error log                                                                                              | 2006-06-01   |
| 8.00.988  | 2000.80.988.0  | 889166 FIX: You receive a "Msg 3628" error message when you run an inner join query in SQL Server 2000                                                                                                                                                        | 2006-06-01   |
| 8.00.985  | 2000.80.985.0  | 889239 FIX: Start times in the SQL Profiler are different for the Audit:Login and Audit:Logout Events in SQL Server 2000                                                                                                                                      | 2006-06-01   |
| 8.00.980  | 2000.80.980.0  | 887974 FIX: A fetch on a dynamic cursor can cause unexpected results in SQL Server 2000 Service Pack 3                                                                                                                                                        | 2006-06-01   |
| 8.00.977  | 2000.80.977.0  | 888007 You receive a "The product does not have a prerequisite update installed" error message when you try to install a SQL Server 2000 post-Service Pack 3 hotfix                                                                                           | 2005-08-31   |
| 8.00.973  | 2000.80.973.0  | 884554 FIX: A SPID stops responding with a NETWORKIO (0x800) waittype in SQL Server Enterprise Manager when SQL Server tries to process a fragmented TDS network packet                                                                                       | 2006-06-01   |
| 8.00.972  | 2000.80.972.0  | 885290 FIX: An assertion error occurs when you insert data in the same row in a table by using multiple connections to an instance of SQL Server                                                                                                              | 2006-06-01   |
| 8.00.970  | 2000.80.970.0  | 872842 FIX: A CHECKDB statement reports a 2537 corruption error after SQL Server transfers data to a sql_variant column in SQL Server 2000                                                                                                                    | 2006-06-01   |
| 8.00.967  | 2000.80.967.0  | 878501 FIX: You may receive an error message when you run a SET IDENTITY_INSERT ON statement on a table and then try to insert a row into the table in SQL Server 2000                                                                                        | 2006-06-01   |
| 8.00.962  | 2000.80.962.0  | 883415 FIX: A user-defined function returns results that are not correct for a query                                                                                                                                                                          | 2006-06-01   |
| 8.00.961  | 2000.80.961.0  | 873446 FIX: An access violation exception may occur when multiple users try to perform data modification operations at the same time that fire triggers that reference a deleted or an inserted table in SQL Server 2000 on a computer that is running SMP    | 2006-06-01   |
| 8.00.959  | 2000.80.959.0  | 878500 FIX: An Audit Object Permission event is not produced when you run a TRUNCATE TABLE statement                                                                                                                                                          | 2006-06-01   |
| 8.00.957  | 2000.80.957.0  | 870994 FIX: An access violation exception may occur when you run a query that uses index names in the WITH INDEX option to specify an index hint                                                                                                              | 2006-06-01   |
| 8.00.955  | 2000.80.955.0  | 867798 FIX: The @date_received parameter of the xp_readmail extended stored procedure incorrectly returns the date and the time that an e-mail message is submitted by the sender in SQL Server 2000                                                          | 2007-01-08   |
| 8.00.954  | 2000.80.954.0  | 843282 FIX: The Osql.exe utility does not run a Transact-SQL script completely if you start the program from a remote session by using a background service and then log off the console session                                                              | 2007-01-05   |
| 8.00.952  | 2000.80.952.0  | 867878 FIX: The Log Reader Agent may cause 17883 error messages                                                                                                                                                                                               | 2006-06-01   |
| 8.00.952  | 2000.80.952.0  | 867879 FIX: Merge replication non-convergence occurs with SQL Server CE subscribers                                                                                                                                                                           | 2006-06-01   |
| 8.00.952  | 2000.80.952.0  | 867880 FIX: Merge Agent may fail with an "Invalid character value for cast specification" error message                                                                                                                                                       | 2006-06-01   |
| 8.00.949  | 2000.80.949.0  | 843266 FIX: Shared page locks can be held until end of the transaction and can cause blocking or performance problems in SQL Server 2000 Service Pack 3 (SP3)                                                                                                 | 2006-06-02   |
| 8.00.948  | 2000.80.948.0  | 843263 FIX: You may receive an 8623 error message when you try to run a complex query on an instance of SQL Server                                                                                                                                            | 2006-06-01   |
| 8.00.944  | 2000.80.944.0  | 839280 FIX: SQL debugging does not work in Visual Studio .NET after you install Windows XP Service Pack 2                                                                                                                                                     | 2006-06-05   |
| 8.00.937  | 2000.80.937.0  | 841776 FIX: Additional diagnostics have been added to SQL Server 2000 to detect unreported read operation failures                                                                                                                                            | 2006-06-01   |
| 8.00.936  | 2000.80.936.0  | 841627 FIX: SQL Server 2000 may underestimate the cardinality of a query expression under certain circumstances                                                                                                                                               | 2006-06-01   |
| 8.00.935  | 2000.80.935.0  | 841401 FIX: You may notice incorrect values for the "Active Transactions" counter when you perform multiple transactions on an instance of SQL Server 2000 that is running on an SMP computer                                                                 | 2006-06-01   |
| 8.00.934  | 2000.80.934.0  | 841404 FIX: You may receive a "The query processor could not produce a query plan" error message in SQL Server when you run a query that includes multiple subqueries that use self-joins                                                                     | 2006-06-01   |
| 8.00.933  | 2000.80.933.0  | 840856 FIX: The MSSQLServer service exits unexpectedly in SQL Server 2000 Service Pack 3                                                                                                                                                                      | 2006-06-02   |
| 8.00.929  | 2000.80.929.0  | 839529 FIX: 8621 error conditions may cause SQL Server 2000 64-bit to close unexpectedly                                                                                                                                                                      | 2006-06-01   |
| 8.00.928  | 2000.80.928.0  | 839589 FIX: The thread priority is raised for some threads in a parallel query                                                                                                                                                                                | 2006-06-01   |
| 8.00.927  | 2000.80.927.0  | 839688 FIX: Profiler RPC events truncate parameters that have a text data type to 16 characters                                                                                                                                                               | 2006-06-01   |
| 8.00.926  | 2000.80.926.0  | 839523 FIX: An access violation exception may occur when you update a text column by using a stored procedure in SQL Server 2000                                                                                                                              | 2006-06-01   |
| 8.00.923  | 2000.80.923.0  | 838460 FIX: The xp_logininfo procedure may fail with error 8198 after you install Q825042 or any hotfix with SQL Server 8.00.0840 or later                                                                                                                    | 2006-06-01   |
| 8.00.922  | 2000.80.922.0  | 837970 FIX: You may receive an "Invalid object name..." error message when you run the DBCC CHECKCONSTRAINTS Transact-SQL statement on a table in SQL Server 2000                                                                                             | 2005-10-25   |
| 8.00.919  | 2000.80.919.0  | 837957 FIX: When you use Transact-SQL cursor variables to perform operations that have large iterations, memory leaks may occur in SQL Server 2000                                                                                                            | 2005-10-25   |
| 8.00.916  | 2000.80.916.0  | 317989 FIX: Sqlakw32.dll May Corrupt SQL Statements                                                                                                                                                                                                           | 2005-09-27   |
| 8.00.915  | 2000.80.915.0  | 837401 FIX: Rows are not successfully inserted into a table when you use the BULK INSERT command to insert rows                                                                                                                                               | 2005-10-25   |
| 8.00.913  | 2000.80.913.0  | 836651 FIX: You receive query results that were not expected when you use both ANSI joins and non-ANSI joins                                                                                                                                                  | 2006-06-07   |
| 8.00.911  | 2000.80.911.0  | 837957 FIX: When you use Transact-SQL cursor variables to perform operations that have large iterations, memory leaks may occur in SQL Server 2000                                                                                                            | 2005-10-25   |
| 8.00.910  | 2000.80.910.0  | 834798 FIX: SQL Server 2000 may not start if many users try to log in to SQL Server when SQL Server is trying to start                                                                                                                                        | 2005-10-25   |
| 8.00.908  | 2000.80.908.0  | 834290 FIX: You receive a 644 error message when you run an UPDATE statement and the isolation level is set to READ UNCOMMITTED                                                                                                                               | 2005-10-25   |
| 8.00.904  | 2000.80.904.0  | 834453 FIX: The Snapshot Agent may fail after you make schema changes to the underlying tables of a publication                                                                                                                                               | 2005-04-22   |
| 8.00.892  | 2000.80.892.0  | 833710 FIX: You receive an error message when you try to restore a database backup that spans multiple devices                                                                                                                                                | 2005-10-25   |
| 8.00.891  | 2000.80.891.0  | 836141 FIX: An access violation exception may occur when SQL Server runs many parallel query processing operations on a multiprocessor computer                                                                                                               | 2005-04-01   |
| 8.00.879  | 2000.80.879.0  | 832977 FIX: The DBCC PSS Command may cause access violations and 17805 errors in SQL Server 2000                                                                                                                                                              | 2005-10-25   |
| 8.00.878  | 2000.80.878.0  | 831950 FIX: You receive error message 3456 when you try to apply a transaction log to a server                                                                                                                                                                | 2005-10-25   |
| 8.00.876  | 2000.80.876.0  | 830912 FIX: Key Names Read from an .Ini File for a Dynamic Properties Task May Be Truncated                                                                                                                                                                   | 2005-10-25   |
| 8.00.876  | 2000.80.876.0  | 831997 FIX: An invalid cursor state occurs after you apply Hotfix 8.00.0859 or later in SQL Server 2000                                                                                                                                                       | 2005-10-25   |
| 8.00.876  | 2000.80.876.0  | 831999 FIX: An AWE system uses more memory for sorting or for hashing than a non-AWE system in SQL Server 2000                                                                                                                                                | 2005-10-25   |
| 8.00.873  | 2000.80.873.0  | 830887 FIX: Some queries that have a left outer join and an IS NULL filter run slower after you install SQL Server 2000 post-SP3 hotfix                                                                                                                       | 2005-10-25   |
| 8.00.871  | 2000.80.871.0  | 830767 FIX: SQL Query Analyzer may stop responding when you close a query window or open a file                                                                                                                                                               | 2005-10-25   |
| 8.00.871  | 2000.80.871.0  | 830860 FIX: The performance of a computer that is running SQL Server 2000 degrades when query execution plans against temporary tables remain in the procedure cache                                                                                          | 2005-10-25   |
| 8.00.870  | 2000.80.870.0  | 830262 FIX: Unconditional Update May Not Hold Key Locks on New Key Values                                                                                                                                                                                     | 2005-10-25   |
| 8.00.869  | 2000.80.869.0  | 830588 FIX: Access violation when you trace keyset-driven cursors by using SQL Profiler                                                                                                                                                                       | 2005-10-25   |
| 8.00.866  | 2000.80.866.0  | 830366 FIX: An access violation occurs in SQL Server 2000 when a high volume of local shared memory connections occur after you install security update MS03-031                                                                                              | 2006-01-16   |
| 8.00.865  | 2000.80.865.0  | 830395 FIX: An access violation occurs during compilation if the table contains statistics for a computed column                                                                                                                                              | 2005-10-25   |
| 8.00.865  | 2000.80.865.0  | 828945 FIX: You cannot insert explicit values in an IDENTITY column of a SQL Server table by using the SQLBulkOperations function or the SQLSetPos ODBC function in SQL Server 2000                                                                           | 2005-10-25   |
| 8.00.863  | 2000.80.863.0  | 829205 FIX: Query performance may be slow and may be inconsistent when you run a query while another query that contains an IN operator with many values is compiled                                                                                          | 2005-10-25   |
| 8.00.863  | 2000.80.863.0  | 829444 FIX: A floating point exception occurs during the optimization of a query                                                                                                                                                                              | 2005-10-25   |
| 8.00.859  | 2000.80.859.0  | 821334 FIX: Issues that are resolved in SQL Server 2000 build 8.00.0859                                                                                                                                                                                       | 2005-03-31   |
| 8.00.858  | 2000.80.858.0  | 828637 FIX: Users Can Control the Compensating Change Process in Merge Replication                                                                                                                                                                            | 2005-10-25   |
| 8.00.857  | 2000.80.857.0  | 828017 The Knowledge Base (KB) Article You Requested Is Currently Not Available                                                                                                                                                                               | ???          |
| 8.00.857  | 2000.80.857.0  | 827714 FIX: A query may fail with retail assertion when you use the NOLOCK hint or the READ UNCOMMITTED isolation level                                                                                                                                       | 2005-11-23   |
| 8.00.857  | 2000.80.857.0  | 828308 FIX: An Internet Explorer script error occurs when you access metadata information by using DTS in SQL Server Enterprise Manager                                                                                                                       | 2005-10-25   |
| 8.00.856  | 2000.80.856.0  | 828096 FIX: Key Locks Are Held Until the End of the Statement for Rows That Do Not Pass Filter Criteria                                                                                                                                                       | 2005-10-25   |
| 8.00.854  | 2000.80.854.0  | 828699 FIX: An Access Violation Occurs When You Run DBCC UPDATEUSAGE on a Database That Has Many Objects                                                                                                                                                      | 2005-10-25   |
| 8.00.852  | 2000.80.852.0  | 830466 FIX: You may receive an "Internal SQL Server error" error message when you run a Transact-SQL SELECT statement on a view that has many subqueries in SQL Server 2000                                                                                   | 2005-04-01   |
| 8.00.852  | 2000.80.852.0  | 827954 FIX: Slow Execution Times May Occur When You Run DML Statements Against Tables That Have Cascading Referential Integrity                                                                                                                               | 2005-10-25   |
| 8.00.851  | 2000.80.851.0  | 826754 FIX: A Deadlock Occurs If You Run an Explicit UPDATE STATISTICS Command                                                                                                                                                                                | 2005-10-25   |
| 8.00.850  | 2000.80.850.0  | 826860 FIX: Linked Server Query May Return NULL If It Is Performed Through a Keyset Cursor                                                                                                                                                                    | 2005-10-25   |
| 8.00.850  | 2000.80.850.0  | 826815 FIX: You receive an 8623 error message in SQL Server when you try to run a query that has multiple correlated subqueries                                                                                                                               | 2005-10-25   |
| 8.00.850  | 2000.80.850.0  | 826906 FIX: A query that uses a view that contains a correlated subquery and an aggregate runs slowly                                                                                                                                                         | 2005-10-25   |
| 8.00.848  | 2000.80.848.0  | 826822 FIX: A Member of the db_accessadmin Fixed Database Role Can Create an Alias for the dbo Special User                                                                                                                                                   | 2005-10-25   |
| 8.00.847  | 2000.80.847.0  | 826433 PRB: Additional SQL Server Diagnostics Added to Detect Unreported I/O Problems                                                                                                                                                                         | 2005-10-25   |
| 8.00.845  | 2000.80.845.0  | 826364 FIX: A Query with a LIKE Comparison Results in a Non-Optimal Query Plan When You Use a Hungarian SQL Server Collation                                                                                                                                  | 2005-10-05   |
| 8.00.845  | 2000.80.845.0  | 825854 FIX: No Exclusive Locks May Be Taken If the DisAllowsPageLocks Value Is Set to True                                                                                                                                                                    | 2005-10-25   |
| 8.00.844  | 2000.80.844.0  | 826080 FIX: SQL Server 2000 protocol encryption applies to JDBC clients                                                                                                                                                                                       | 2006-10-17   |
| 8.00.842  | 2000.80.842.0  | 825043 FIX: Rows are unexpectedly deleted when you run a distributed query to delete or to update a linked server table                                                                                                                                       | 2005-10-25   |
| 8.00.841  | 2000.80.841.0  | 825225 FIX: You receive an error message when you run a parallel query that uses an aggregation function or the GROUP BY clause                                                                                                                               | 2005-10-25   |
| 8.00.840  | 2000.80.840.0  | 319477 FIX: Extremely Large Number of User Tables on AWE System May Cause BPool::Map Errors                                                                                                                                                                   | 2005-09-27   |
| 8.00.840  | 2000.80.840.0  | 319477 FIX: Extremely Large Number of User Tables on AWE System May Cause BPool::Map Errors                                                                                                                                                                   | 2005-09-27   |
| 8.00.839  | 2000.80.839.0  | 823877 FIX: An Access Violation May Occur When You Run a Query That Contains 32,000 or More OR Clauses                                                                                                                                                        | 2005-10-25   |
| 8.00.839  | 2000.80.839.0  | 824027 FIX: A Cursor with a Large Object Parameter May Cause an Access Violation on CStmtCond::XretExecute                                                                                                                                                    | 2005-10-25   |
| 8.00.837  | 2000.80.837.0  | 820788 FIX: Delayed domain authentication may cause SQL Server to stop responding                                                                                                                                                                             | 2005-10-25   |
| 8.00.837  | 2000.80.837.0  | 821741 FIX: Lock monitor exception in DeadlockMonitor::ResolveDeadlock                                                                                                                                                                                        | 2005-10-25   |
| 8.00.837  | 2000.80.837.0  | 821548 FIX: A Parallel Query May Generate an Access Violation After You Install SQL Server 2000 SP3                                                                                                                                                           | 2005-10-25   |
| 8.00.837  | 2000.80.837.0  | 821740 FIX: MS DTC Transaction Commit Operation Blocks Itself                                                                                                                                                                                                 | 2005-10-25   |
| 8.00.837  | 2000.80.837.0  | 823514 FIX: Build 8.00.0837: A query that contains a correlated subquery runs slowly                                                                                                                                                                          | 2005-10-25   |
| 8.00.819  | 2000.80.819.0  | 826161 FIX: You are prompted for password confirmation after you change a standard SQL Server login                                                                                                                                                           | 2005-10-25   |
| 8.00.818  | 2000.80.818.0  | 821277 MS03-031: Security patch for SQL Server 2000 Service Pack 3                                                                                                                                                                                            | 2006-01-09   |
| 8.00.818  | 2000.80.818.0  | 821337 FIX: Localized versions of SQL Mail and the Web Assistant Wizard may not work as expected in SQL Server 2000 64 bit                                                                                                                                    | 2005-03-16   |
| 8.00.818  | 2000.80.818.0  | 818388 FIX: A Transact-SQL Statement That Is Embedded in the Database Name Runs with System Administrator Permissions                                                                                                                                         | 2005-02-10   |
| 8.00.818  | 2000.80.818.0  | 826161 FIX: You are prompted for password confirmation after you change a standard SQL Server login                                                                                                                                                           | 2005-10-25   |
| 8.00.818  | 2000.80.818.0  | 821280 MS03-031: Security Patch for SQL Server 2000 64-bit                                                                                                                                                                                                    | 2006-03-14   |
| 8.00.816  | 2000.80.816.0  | 818766 FIX: Intense SQL Server activity results in spinloop wait                                                                                                                                                                                              | 2005-10-25   |
| 8.00.814  | 2000.80.814.0  | 819662 FIX: Distribution Cleanup Agent Incorrectly Cleans Up Entries for Anonymous Subscribers                                                                                                                                                                | 2005-10-25   |
| 8.00.811  | 2000.80.811.0  | 819248 FIX: An access violation exception may occur when you insert a row in a table that is referenced by indexed views in SQL Server 2000                                                                                                                   | 2006-04-03   |
| 8.00.811  | 2000.80.811.0  | 819662 FIX: Distribution Cleanup Agent Incorrectly Cleans Up Entries for Anonymous Subscribers                                                                                                                                                                | 2005-10-25   |
| 8.00.811  | 2000.80.811.0  | 818897 FIX: Invalid TDS Sent to SQL Server Results in Access Violation                                                                                                                                                                                        | 2005-10-25   |
| 8.00.807  | 2000.80.807.0  | 818899 FIX: Error Message 3628 May Occur When You Run a Complex Query                                                                                                                                                                                         | 2005-10-25   |
| 8.00.804  | 2000.80.804.0  | 818729 FIX: Internal Query Processor Error 8623 When Microsoft SQL Server Tries to Compile a Plan for a Complex Query                                                                                                                                         | 2005-10-25   |
| 8.00.801  | 2000.80.801.0  | 818540 FIX: SQL Server Enterprise Manager unexpectedly quits when you modify a DTS package                                                                                                                                                                    | 2006-01-26   |
| 8.00.800  | 2000.80.800.0  | 818414 FIX: The Sqldumper.exe File Does Not Generate a Userdump File When It Runs Against a Windows Service                                                                                                                                                   | 2005-09-27   |
| 8.00.800  | 2000.80.800.0  | 818097 FIX: An Access Violation May Occur When You Run DBCC DBREINDEX on a Table That Has Hypothetical Indexes                                                                                                                                                | 2005-09-27   |
| 8.00.800  | 2000.80.800.0  | 818188 FIX: Query on the sysmembers Virtual Table May Fail with a Stack Overflow                                                                                                                                                                              | 2005-09-27   |
| 8.00.798  | 2000.80.798.0  | 817464 FIX: Using Sp_executesql in Merge Agent Operations                                                                                                                                                                                                     | 2005-09-27   |
| 8.00.794  | 2000.80.794.0  | 817464 FIX: Using Sp_executesql in Merge Agent Operations                                                                                                                                                                                                     | 2005-09-27   |
| 8.00.794  | 2000.80.794.0  | 813524 FIX: OLE DB conversion errors may occur after you select a literal string that represents datetime data as a column                                                                                                                                    | 2005-09-27   |
| 8.00.794  | 2000.80.794.0  | 816440 FIX: Error 8623 is Raised When SQL Server Compiles a Complex Query                                                                                                                                                                                     | 2005-09-27   |
| 8.00.794  | 2000.80.794.0  | 817709 FIX: SQL Server 2000 might produce an incorrect cardinality estimate for outer joins                                                                                                                                                                   | 2005-02-11   |
| 8.00.791  | 2000.80.791.0  | 815249 FIX: Performance of a query that is run from a client program on a SQL Server SP3 database is slow after you restart the instance of SQL Server                                                                                                        | 2005-09-27   |
| 8.00.790  | 2000.80.790.0  | 817081 FIX: You receive an error message when you use the SQL-DMO BulkCopy object to import data into a SQL Server table                                                                                                                                      | 2005-09-27   |
| 8.00.789  | 2000.80.789.0  | 816840 FIX: Error 17883 May Display Message Text That Is Not Correct                                                                                                                                                                                          | 2005-09-27   |
| 8.00.788  | 2000.80.788.0  | 816985 FIX: You cannot install SQL Server 2000 SP3 on the Korean version of SQL Server 2000                                                                                                                                                                   | 2005-09-27   |
| 8.00.781  | 2000.80.781.0  | 815057 FIX: SQL Server 2000 Uninstall Option Does Not Remove All Files                                                                                                                                                                                        | 2005-09-27   |
| 8.00.780  | 2000.80.780.0  | 816039 FIX: Code Point Comparison Semantics for SQL_Latin1_General_Cp850_BIN Collation                                                                                                                                                                        | 2005-09-27   |
| 8.00.780  | 2000.80.780.0  | 816084 FIX: sysindexes.statblob Column May Be Corrupted After You Run a DBCC DBREINDEX Statement                                                                                                                                                              | 2005-09-27   |
| 8.00.780  | 2000.80.780.0  | 810185 SQL Server 2000 hotfix update for SQL Server 2000 Service Pack 3 and 3a                                                                                                                                                                                | 2006-10-10   |
| 8.00.779  | 2000.80.779.0  | 814035 FIX: A Full-Text Population Fails After You Apply SQL Server 2000 Service Pack 3                                                                                                                                                                       | 2005-09-27   |
| 8.00.776  | 2000.80.776.0  | Unidentified                                                                                                                                                                                                                                                  | ???          |
| 8.00.775  | 2000.80.775.0  | 815115 FIX: A DTS package that uses global variables ignores an error message raised by RAISERROR                                                                                                                                                             | 2005-09-27   |
| 8.00.769  | 2000.80.769.0  | 814889 FIX: A DELETE statement with a JOIN might fail and you receive a 625 error                                                                                                                                                                             | 2005-09-27   |
| 8.00.769  | 2000.80.769.0  | 814893 FIX: Error Message: "Insufficient key column information for updating" Occurs in SQL Server 2000 SP3                                                                                                                                                   | 2005-09-27   |
| 8.00.765  | 2000.80.765.0  | 810163 FIX: An Access Violation Occurs if an sp_cursoropen Call References a Parameter That Is Not Defined                                                                                                                                                    | 2005-09-27   |
| 8.00.765  | 2000.80.765.0  | 810688 FIX: Merge Agent Can Resend Changes for Filtered Publications                                                                                                                                                                                          | 2005-09-27   |
| 8.00.765  | 2000.80.765.0  | 811611 FIX: Reinitialized SQL Server CE 2.0 subscribers may experience data loss and non-convergence                                                                                                                                                          | 2005-09-27   |
| 8.00.765  | 2000.80.765.0  | 813769 FIX: You May Experience Slow Performance When You Debug a SQL Server Service                                                                                                                                                                           | 2005-09-27   |
| 8.00.763  | 2000.80.763.0  | 814113 FIX: DTS Designer may generate an access violation after you install SQL Server 2000 Service Pack 3                                                                                                                                                    | 2005-09-27   |
| 8.00.762  | 2000.80.762.0  | 814032 FIX: Merge publications cannot synchronize on SQL Server 2000 Service Pack 3                                                                                                                                                                           | 2005-09-27   |
| 8.00.760  | 2000.80.760.0  | SQL Server 2000 Service Pack 3 (SP3 / SP3a)                                                                                                                                                                                                                   | 2003-08-27   |
| 8.00.743  | 2000.80.743.0  | 818406 FIX: A Transact-SQL query that uses views may fail unexpectedly in SQL Server 2000 SP2                                                                                                                                                                 | 2005-10-18   |
| 8.00.743  | 2000.80.743.0  | 818763 FIX: Intense SQL Server Activity Results in Spinloop Wait in SQL Server 2000 Service Pack 2                                                                                                                                                            | 2005-10-25   |
| 8.00.741  | 2000.80.741.0  | 818096 FIX: Many Extent Lock Time-outs May Occur During Extent Allocation                                                                                                                                                                                     | 2005-02-10   |
| 8.00.736  | 2000.80.736.0  | 816937 FIX: A memory leak may occur when you use the sp_OAMethod stored procedure to call a method of a COM object                                                                                                                                            | 2005-09-27   |
| 8.00.735  | 2000.80.735.0  | 814889 FIX: A DELETE statement with a JOIN might fail and you receive a 625 error                                                                                                                                                                             | 2005-09-27   |
| 8.00.733  | 2000.80.733.0  | 813759 FIX: A Large Number of NULL Values in Join Columns Result in Slow Query Performance                                                                                                                                                                    | 2005-09-27   |
| 8.00.730  | 2000.80.730.0  | 813769 FIX: You May Experience Slow Performance When You Debug a SQL Server Service                                                                                                                                                                           | 2005-09-27   |
| 8.00.728  | 2000.80.728.0  | 814460 FIX: Merge Replication with Alternate Synchronization Partners May Not Succeed After You Change the Retention Period                                                                                                                                   | 2005-09-27   |
| 8.00.725  | 2000.80.725.0  | 812995 FIX: A Query with an Aggregate Function May Fail with a 3628 Error                                                                                                                                                                                     | 2005-09-27   |
| 8.00.725  | 2000.80.725.0  | 813494 FIX: Distribution Agent Fails with "Violation of Primary Key Constraint" Error Message                                                                                                                                                                 | 2005-09-27   |
| 8.00.723  | 2000.80.723.0  | 812798 FIX: A UNION ALL View May Not Use Index If Partitions Are Removed at Compile Time                                                                                                                                                                      | 2005-09-27   |
| 8.00.721  | 2000.80.721.0  | 812250 FIX: Indexed View May Cause a Handled Access Violation in CIndex::SetLevel1Names                                                                                                                                                                       | 2005-09-27   |
| 8.00.721  | 2000.80.721.0  | 812393 FIX: Update or Delete Statement Fails with Error 1203 During Row Lock Escalation                                                                                                                                                                       | 2005-09-27   |
| 8.00.718  | 2000.80.718.0  | 811703 FIX: Unexpected results from partial aggregations based on conversions                                                                                                                                                                                 | 2005-09-27   |
| 8.00.715  | 2000.80.715.0  | 810688 FIX: Merge Agent Can Resend Changes for Filtered Publications                                                                                                                                                                                          | 2005-09-27   |
| 8.00.715  | 2000.80.715.0  | 811611 FIX: Reinitialized SQL Server CE 2.0 subscribers may experience data loss and non-convergence                                                                                                                                                          | 2005-09-27   |
| 8.00.714  | 2000.80.714.0  | 811478 FIX: Restoring a SQL Server 7.0 database backup in SQL Server 2000 Service Pack 2 (SP2) may cause an assertion error in the Xdes.cpp file                                                                                                              | 2005-10-18   |
| 8.00.713  | 2000.80.713.0  | 811205 FIX: An error message occurs when you perform a database or a file SHRINK operation                                                                                                                                                                    | 2005-09-27   |
| 8.00.710  | 2000.80.710.0  | 811052 FIX: Latch Time-Out Message 845 Occurs When You Perform a Database or File SHRINK Operation                                                                                                                                                            | 2005-09-27   |
| 8.00.705  | 2000.80.705.0  | 810920 FIX: The JOIN queries in the triggers that involve the inserted table or the deleted table may return results that are not consistent                                                                                                                  | 2005-09-27   |
| 8.00.703  | 2000.80.703.0  | 810526 FIX: Cursors That Have a Long Lifetime May Cause Memory Fragmentation                                                                                                                                                                                  | 2005-09-27   |
| 8.00.702  | 2000.80.702.0  | 328551 FIX: Concurrency enhancements for the tempdb database                                                                                                                                                                                                  | 2006-07-19   |
| 8.00.701  | 2000.80.701.0  | 810026 FIX: A DELETE Statement with a Self-Join May Fail and You Receive a 625 Error                                                                                                                                                                          | 2005-09-27   |
| 8.00.701  | 2000.80.701.0  | 810163 FIX: An Access Violation Occurs if an sp_cursoropen Call References a Parameter That Is Not Defined                                                                                                                                                    | 2005-09-27   |
| 8.00.700  | 2000.80.700.0  | 810072 FIX: Merge Replication Reconciler Stack Overflow                                                                                                                                                                                                       | 2005-09-27   |
| 8.00.696  | 2000.80.696.0  | 810052 FIX: A Memory Leak Occurs When Cursors Are Opened During a Connection                                                                                                                                                                                  | 2005-09-27   |
| 8.00.696  | 2000.80.696.0  | 810010 FIX: The fn_get_sql System Table Function May Cause Various Handled Access Violations                                                                                                                                                                  | 2005-09-27   |
| 8.00.695  | 2000.80.695.0  | 331885 FIX: Update/Delete Statement Fails with Error 1203 During Page Lock Escalation                                                                                                                                                                         | 2005-09-27   |
| 8.00.695  | 2000.80.695.0  | 331965 FIX: The xp_readmail Extended Stored Procedure Overwrites Attachment That Already Exists                                                                                                                                                               | 2005-02-10   |
| 8.00.695  | 2000.80.695.0  | 331968 FIX: The xp_readmail and xp_findnextmsg Extended Stored Procedures Do Not Read Mail in Time Received Order                                                                                                                                             | 2005-02-10   |
| 8.00.693  | 2000.80.693.0  | 330212 FIX: Parallel logical operation returns results that are not consistent                                                                                                                                                                                | 2005-09-27   |
| 8.00.690  | 2000.80.690.0  | 311104 FIX: The SELECT Statement with Parallelism Enabled May Cause an Assertion                                                                                                                                                                              | 2005-10-12   |
| 8.00.689  | 2000.80.689.0  | 329499 FIX: Replication Removed from Database After Restore WITH RECOVERY                                                                                                                                                                                     | 2005-10-11   |
| 8.00.688  | 2000.80.688.0  | 329487 FIX: Transaction Log Restore Fails with Message 3456                                                                                                                                                                                                   | 2005-10-11   |
| 8.00.686  | 2000.80.686.0  | 316333 SQL Server 2000 Security Update for Service Pack 2                                                                                                                                                                                                     | 2006-11-24   |
| 8.00.682  | 2000.80.682.0  | 319851 FIX: Assertion and Error Message 3314 Occurs If You Try to Roll Back a Text Operation with READ UNCOMMITTED                                                                                                                                            | 2005-10-18   |
| 8.00.679  | 2000.80.679.0  | 316333 SQL Server 2000 Security Update for Service Pack 2                                                                                                                                                                                                     | 2006-11-24   |
| 8.00.678  | 2000.80.678.0  | 328354 FIX: A RESTORE DATABASE WITH RECOVERY Statement Can Fail with Error 9003 or Error 9004                                                                                                                                                                 | 2005-09-27   |
| 8.00.667  | 2000.80.667.0  | 2000 SP2+8/14 fix                                                                                                                                                                                                                                             | ???          |
| 8.00.665  | 2000.80.665.0  | 2000 SP2+8/8 fix                                                                                                                                                                                                                                              | ???          |
| 8.00.661  | 2000.80.661.0  | 326999 FIX: Lock escalation on a scan while an update query is running causes a 1203 error message to occur                                                                                                                                                   | 2005-09-27   |
| 8.00.655  | 2000.80.655.0  | 2000 SP2+7/24 fix                                                                                                                                                                                                                                             | ???          |
| 8.00.652  | 2000.80.652.0  | 810010 FIX: The fn_get_sql System Table Function May Cause Various Handled Access Violations                                                                                                                                                                  | 2005-09-27   |
| 8.00.650  | 2000.80.650.0  | 322853 FIX: SQL Server Grants Unnecessary Permissions or an Encryption Function Contains Unchecked Buffers                                                                                                                                                    | 2003-11-05   |
| 8.00.644  | 2000.80.644.0  | 324186 FIX: Slow Compile Time and Execution Time with Query That Contains Aggregates and Subqueries                                                                                                                                                           | 2005-09-27   |
| 8.00.636  | 2000.80.636.0  | Microsoft Security Bulletin MS02-039                                                                                                                                                                                                                          | 2002-06-24   |
| 8.00.608  | 2000.80.608.0  | 319507 FIX: SQL Extended Procedure Functions Contain Unchecked Buffers                                                                                                                                                                                        | 2004-06-21   |
| 8.00.604  | 2000.80.604.0  | 2000 SP2+3/29 fix                                                                                                                                                                                                                                             | ???          |
| 8.00.599  | 2000.80.599.0  | 319869 FIX: Improved SQL Manager Robustness for Odd Length Buffer                                                                                                                                                                                             | 2005-09-27   |
| 8.00.594  | 2000.80.594.0  | 319477 FIX: Extremely Large Number of User Tables on AWE System May Cause BPool::Map Errors                                                                                                                                                                   | 2005-09-27   |
| 8.00.584  | 2000.80.584.0  | 318530 FIX: Reorder outer joins with filter criteria before non-selective joins and outer joins                                                                                                                                                               | 2008-02-04   |
| 8.00.578  | 2000.80.578.0  | 317979 FIX: Unchecked Buffer May Occur When You Connect to Remote Data Source                                                                                                                                                                                 | 2005-09-27   |
| 8.00.578  | 2000.80.578.0  | 318045 FIX: SELECT with Timestamp Column That Uses FOR XML AUTO May Fail with Stack Overflow or AV                                                                                                                                                            | 2005-09-27   |
| 8.00.568  | 2000.80.568.0  | 317748 FIX: Handle Leak Occurs in SQL Server When Service or Application Repeatedly Connects and Disconnects with Shared Memory Network Library                                                                                                               | 2002-10-30   |
| 8.00.561  | 2000.80.561.0  | 2000 SP2+1/29 fix                                                                                                                                                                                                                                             | ???          |
| 8.00.558  | 2000.80.558.0  | 314003 FIX: Query That Uses DESC Index May Result in Access Violation                                                                                                                                                                                         | 2005-09-26   |
| 8.00.558  | 2000.80.558.0  | 315395 FIX: COM May Not Be Uninitialized for Worker Thread When You Use sp_OA                                                                                                                                                                                 | 2005-09-27   |
| 8.00.552  | 2000.80.552.0  | 313002 The Knowledge Base (KB) Article You Requested Is Currently Not Available                                                                                                                                                                               | ???          |
| 8.00.552  | 2000.80.552.0  | 313005 FIX: SELECT from Computed Column That References UDF Causes SQL Server to Terminate                                                                                                                                                                    | 2005-09-26   |
| 8.00.534  | 2000.80.534.0  | 2000 SP2.01                                                                                                                                                                                                                                                   | ???          |
| 8.00.532  | 2000.80.532.0  | SQL Server 2000 Service Pack 2 (SP2)                                                                                                                                                                                                                          | 2003-02-04   |
| 8.00.475  | 2000.80.475.0  | 2000 SP1+1/29 fix                                                                                                                                                                                                                                             | ???          |
| 8.00.474  | 2000.80.474.0  | 315395 FIX: COM May Not Be Uninitialized for Worker Thread When You Use sp_OA                                                                                                                                                                                 | 2005-09-27   |
| 8.00.473  | 2000.80.473.0  | 314003 FIX: Query That Uses DESC Index May Result in Access Violation                                                                                                                                                                                         | 2005-09-26   |
| 8.00.471  | 2000.80.471.0  | 313302 FIX: Shared Table Lock Is Not Released After Lock Escalation                                                                                                                                                                                           | 2005-09-26   |
| 8.00.469  | 2000.80.469.0  | 313005 FIX: SELECT from Computed Column That References UDF Causes SQL Server to Terminate                                                                                                                                                                    | 2005-09-26   |
| 8.00.452  | 2000.80.452.0  | 308547 FIX: SELECT DISTINCT from Table with LEFT JOIN of View Causes Error Messages or Client Application May Stop Responding                                                                                                                                 | 2005-09-26   |
| 8.00.444  | 2000.80.444.0  | 307540 FIX: SQLPutData May Result in Leak of Buffer Pool Memory                                                                                                                                                                                               | 2005-09-26   |
| 8.00.444  | 2000.80.444.0  | 307655 FIX: Querying Syslockinfo with Large Numbers of Locks May Cause Server to Stop Responding                                                                                                                                                              | 2005-10-07   |
| 8.00.443  | 2000.80.443.0  | 307538 FIX: SQLTrace Start and Stop is Now Reported in Windows NT Event Log for SQL Server 2000                                                                                                                                                               | 2005-09-26   |
| 8.00.428  | 2000.80.428.0  | 304850 FIX: SQL Server Text Formatting Functions Contain Unchecked Buffers                                                                                                                                                                                    | 2004-08-05   |
| 8.00.384  | 2000.80.384.0  | SQL Server 2000 Service Pack 1 (SP1)                                                                                                                                                                                                                          | 2001-06-11   |
| 8.00.296  | 2000.80.296.0  | 299717 FIX: Query Method Used to Access Data May Allow Rights that the Login Might Not Normally Have                                                                                                                                                          | 2004-08-09   |
| 8.00.287  | 2000.80.287.0  | 297209 FIX: Deletes, Updates and Rank Based Selects May Cause Deadlock of MSSEARCH                                                                                                                                                                            | 2005-10-07   |
| 8.00.251  | 2000.80.251.0  | 300194 FIX: Error 644 Using Two Indexes on a Column with Uppercase Preference Sort Order                                                                                                                                                                      | 2003-10-17   |
| 8.00.250  | 2000.80.250.0  | 291683 The Knowledge Base (KB) Article You Requested Is Currently Not Available                                                                                                                                                                               | ???          |
| 8.00.249  | 2000.80.249.0  | 288122 FIX: Lock Monitor Uses Excessive CPU                                                                                                                                                                                                                   | 2003-09-12   |
| 8.00.239  | 2000.80.239.0  | 285290 FIX: Complex ANSI Join Query with Distributed Queries May Cause Handled Access Violation                                                                                                                                                               | 2003-10-09   |
| 8.00.233  | 2000.80.233.0  | 282416 FIX: Opening the Database Folder in SQL Server Enterprise Manager 2000 Takes a Long Time                                                                                                                                                               | 2003-10-09   |
| 8.00.231  | 2000.80.231.0  | 282279 FIX: Execution of sp_OACreate on COM Object Without Type Information Causes Server Shut Down                                                                                                                                                           | 2003-10-09   |
| 8.00.226  | 2000.80.226.0  | 278239 FIX: Extreme Memory Usage When Adding Many Security Roles                                                                                                                                                                                              | 2006-11-21   |
| 8.00.225  | 2000.80.225.0  | 281663 "Access Denied" Error Message When You Try to Use a Network Drive to Modify Windows 2000 Permissions                                                                                                                                                   | 2006-10-30   |
| 8.00.223  | 2000.80.223.0  | 280380 FIX: Buffer Overflow Exploit Possible with Extended Stored Procedures                                                                                                                                                                                  | 2004-06-29   |
| 8.00.222  | 2000.80.222.0  | 281769 FIX: Exception Access Violation Encountered During Query Normalization                                                                                                                                                                                 | 2005-10-07   |
| 8.00.218  | 2000.80.218.0  | 279183 FIX: Scripting Object with Several Extended Properties May Cause Exception                                                                                                                                                                             | 2003-10-09   |
| 8.00.217  | 2000.80.217.0  | 279293 FIX: CASE Using LIKE with Empty String Can Result in Access Violation or Abnormal Server Shutdown                                                                                                                                                      | 2003-10-09   |
| 8.00.211  | 2000.80.211.0  | 276329 FIX: Complex Distinct or Group By Query Can Return Unexpected Results with Parallel Execution Plan                                                                                                                                                     | 2003-11-05   |
| 8.00.210  | 2000.80.210.0  | 275900 FIX: Linked Server Query with Hyphen in LIKE Clause May Run Slowly                                                                                                                                                                                     | 2003-10-09   |
| 8.00.205  | 2000.80.205.0  | 274330 FIX: Sending Open Files as Attachment in SQL Mail Fails with Error 18025                                                                                                                                                                               | 2005-10-07   |
| 8.00.204  | 2000.80.204.0  | 274329 FIX: Optimizer Slow to Generate Query Plan for Complex Queries that have Many Joins and Semi-Joins                                                                                                                                                     | 2003-10-09   |
| 8.00.194  | 2000.80.194.0  | SQL Server 2000 RTM (no SP)                                                                                                                                                                                                                                   | ???          |
| 8.00.190  | 2000.80.190.0  | SQL Server 2000 Gold                                                                                                                                                                                                                                          | ???          |
| 8.00.100  | 2000.80.100.0  | SQL Server 2000 Beta 2                                                                                                                                                                                                                                        | ???          |
| 8.00.078  | 2000.80.078.0  | SQL Server 2000 EAP5                                                                                                                                                                                                                                          | ???          |
| 8.00.047  | 2000.80.047.0  | SQL Server 2000 EAP4                                                                                                                                                                                                                                          | ???          |

[983811 MS12-060: Description of the security update for SQL Server 2000 Service Pack 4 QFE: August 14, 2012]:https://support.microsoft.com/help/983811/
[983809 MS12-027: Description of the security update for Microsoft SQL Server 2000 Service Pack 4 QFE: April 10, 2012]:https://support.microsoft.com/help/983809/
[960083 MS09-004: Description of the security update for SQL Server 2000 QFE and for MSDE 2000: February 10, 2009]:https://support.microsoft.com/help/960083/


## Microsoft SQL Server 7.0 Builds
<a id="microsoft-sql-server-70-builds"></a>

| Build     | KB / Description                                                                                                                                                    | Release Date |
|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------|
| 7.00.1152 | [948113 MS08-040: Description of the security update for SQL Server 7.0: July 8, 2008]                                                                              | 2008-07-08   |
| 7.00.1149 | 867763 FIX: An access violation exception may occur when you run a SELECT statement that contains complex JOIN operations in SQL Server 7.0                         | 2006-06-01   |
| 7.00.1143 | 830233 New Connection Events Are Not Recorded in SQL Server Traces                                                                                                  | 2005-10-25   |
| 7.00.1143 | 829015 FIX: An attention signal that is sent from a SQL Server client application because of a query time-out may cause the SQL Server service to quit unexpectedly | 2005-10-25   |
| 7.00.1097 | 822756 A Complex UPDATE Statement That Uses an Index Spool Operation May Cause an Assertion                                                                         | 2005-10-25   |
| 7.00.1094 | 821279 MS03-031: Security patch for SQL Server 7.0 Service Pack 4                                                                                                   | 2006-05-11   |
| 7.00.1094 | 815495 MS03-031: Cumulative security patch for SQL Server                                                                                                           | 2006-05-10   |
| 7.00.1092 | 820788 FIX: Delayed domain authentication may cause SQL Server to stop responding                                                                                   | 2005-10-25   |
| 7.00.1087 | 814693 FIX: SQL Server 7.0 Scheduler May Periodically Stop Responding During Large Sort Operation                                                                   | 2005-09-27   |
| 7.00.1079 | 329499 FIX: Replication Removed from Database After Restore WITH RECOVERY                                                                                           | 2005-10-11   |
| 7.00.1078 | 327068 INF: SQL Server 7.0 Security Update for Service Pack 4                                                                                                       | 2005-09-27   |
| 7.00.1077 | 316333 SQL Server 2000 Security Update for Service Pack 2                                                                                                           | 2006-11-24   |
| 7.00.1063 | [SQL Server 7.0 Service Pack 4 (SP4)]                                                                                                                               | 2002-04-26   |
| 7.00.1033 | 324469 FIX: Error message 9004 may occur when you restore a log that does not contain any transactions                                                              | 2005-10-12   |
| 7.00.1026 | 319851 FIX: Assertion and Error Message 3314 Occurs If You Try to Roll Back a Text Operation with READ UNCOMMITTED                                                  | 2005-10-18   |
| 7.00.1004 | 304851 FIX: SQL Server Text Formatting Functions Contain Unchecked Buffers                                                                                          | 2004-08-05   |
| 7.00.996  | 299717 FIX: Query Method Used to Access Data May Allow Rights that the Login Might Not Normally Have                                                                | 2004-08-09   |
| 7.00.978  | 285870 FIX: Update With Self Join May Update Incorrect Number Of Rows                                                                                               | 2003-10-28   |
| 7.00.977  | 284351 FIX: SQL Server Profiler and SQL Server Agent Alerts May Fail to Work After Installing SQL Server 7.0 SP3                                                    | 2002-04-25   |
| 7.00.970  | 283837 FIX: SQL Server May Generate Nested Query For Linked Server When Option Is Disabled                                                                          | 2002-10-15   |
| 7.00.970  | 282243 FIX: Incorrect Results with Join of Column Converted to Binary                                                                                               | 2003-10-29   |
| 7.00.961  | SQL Server 7.0 Service Pack 3 (SP3)                                                                                                                                 | 2000-12-15   |
| 7.00.921  | 283837 FIX: SQL Server May Generate Nested Query For Linked Server When Option Is Disabled                                                                          | 2002-10-15   |
| 7.00.919  | 282243 FIX: Incorrect Results with Join of Column Converted to Binary                                                                                               | 2003-10-29   |
| 7.00.918  | 280380 FIX: Buffer Overflow Exploit Possible with Extended Stored Procedures                                                                                        | 2004-06-29   |
| 7.00.917  | 279180 FIX: Bcp.exe with Long Query String Can Result in Assertion Failure                                                                                          | 2005-09-26   |
| 7.00.910  | 275901 FIX: SQL RPC That Raises Error Will Mask @@ERROR with Msg 7221                                                                                               | 2003-10-31   |
| 7.00.905  | 274266 FIX: Data Modification Query with a Distinct Subquery on a View May Cause Error 3624                                                                         | 2004-07-15   |
| 7.00.889  | 243741 FIX: Replication Initialize Method Causes Handle Leak on Failure                                                                                             | 2005-10-05   |
| 7.00.879  | 281185 FIX: Linked Index Server Query Through OLE DB Provider with OR Clause Reports Error 7349                                                                     | 2006-03-14   |
| 7.00.857  | 260346 FIX: Transactional Publications with a Filter on Numeric Columns Fail to Replicate Data                                                                      | 2006-03-14   |
| 7.00.843  | 266766 FIX: Temporary Stored Procedures in SA Owned Databases May Bypass Permission Checks When You Run Stored Procedures                                           | 2006-03-14   |
| 7.00.842  | SQL Server 7.0 Service Pack 2 (SP2)                                                                                                                                 | 2000-03-20   |
| 7.00.839  | SQL Server 7.0 Service Pack 2 (SP2) Unidentified                                                                                                                    |              |
| 7.00.835  | SQL Server 7.0 Service Pack 2 (SP2) Beta                                                                                                                            |              |
| 7.00.776  | 258087 FIX: Non-Admin User That Executes Batch While Server Shuts Down May Encounter Retail Assertion                                                               | 2006-03-14   |
| 7.00.770  | 252905 FIX: Slow Compile Time on Complex Joins with Unfiltered Table                                                                                                | 2006-03-14   |
| 7.00.745  | 253738 FIX: SQL Server Components that Access the Registry in a Cluster Environment May Cause a Memory Leak                                                         | 2005-10-07   |
| 7.00.722  | 239458 FIX: Replication: Problems Mapping Characters to DB2 OLEDB Subscribers                                                                                       | 2005-10-05   |
| 7.00.699  | SQL Server 7.0 Service Pack 1 (SP1)                                                                                                                                 | 1999-07-01   |
| 7.00.689  | SQL Server 7.0 Service Pack 1 (SP1) Beta                                                                                                                            |              |
| 7.00.677  | SQL Server 7.0 MSDE from Office 2000 disc                                                                                                                           |              |
| 7.00.662  | 232707 FIX: Query with Complex View Hierarchy May Be Slow to Compile                                                                                                | 2005-10-05   |
| 7.00.658  | 244763 FIX: Access Violation Under High Cursor Stress                                                                                                               | 2006-03-14   |
| 7.00.657  | 229875 FIX: Unable to Perform Automated Installation of SQL 7.0 Using File Images                                                                                   | 2005-10-05   |
| 7.00.643  | 220156 FIX: SQL Cluster Install Fails When SVS Name Contains Special Characters                                                                                     | 2005-10-05   |
| 7.00.623  | SQL Server 7.0 RTM (Gold, no SP)                                                                                                                                    | 1998-11-27   |
| 7.00.583  | SQL Server 7.0 RC1                                                                                                                                                  |              |
| 7.00.517  | SQL Server 7.0 Beta 3                                                                                                                                               |              |

[948113 MS08-040: Description of the security update for SQL Server 7.0: July 8, 2008]:https://support.microsoft.com/help/941203
[SQL Server 7.0 Service Pack 4 (SP4)]:https://www.microsoft.com/download/details.aspx?id=7959


## Microsoft SQL Server 6.5 Builds
<a id="microsoft-sql-server-65-builds"></a>

| Build    | KB / Description                                                                                                  | Release Date |
|----------|-------------------------------------------------------------------------------------------------------------------|--------------|
| 6.50.480 | 238621 FIX: Integrated Security Sprocs Have Race Condition Between Threads That Can Result in an Access Violation | 2005-10-07   |
| 6.50.479 | 273914 Microsoft SQL Server 6.5 Post Service Pack 5a Update                                                       | 2000-09-12   |
| 6.50.469 | 249343 FIX: SQL Performance Counters May Cause Handle Leak in WinLogon Process                                    |              |
| 6.50.465 | 250493 FIX: Memory Leak with xp_sendmail Using Attachments                                                        |              |
| 6.50.464 | 275483 FIX: Insert Error (Msg 213) with NO_BROWSETABLE and INSERT EXEC                                            | 1999-11-08   |
| 6.50.462 | 238620 FIX: Terminating Clients with TSQL KILL May Cause ODS AV                                                   |              |
| 6.50.451 | 236447 FIX: ODS Errors During Attention Signal May Cause SQL Server to Stop Responding                            |              |
| 6.50.444 | 240172 FIX: Multiple Attachments not Sent Correctly Using xp_sendmail                                             |              |
| 6.50.441 | 234679 FIX: SNMP Extended Stored Procedures May Leak Memory                                                       |              |
| 6.50.422 | 187278 FIX: Large Query Text from Socket Client May Cause Open Data Services Access Violation                     |              |
| 6.50.416 | 197176 Microsoft SQL Server 6.5 Service Pack 5a (SP5a)                                                            | 1998-12-24   |
| 6.50.415 | Microsoft SQL Server 6.5 Service Pack 5 (SP5)                                                                     |              |
| 6.50.339 | Y2K hotfix                                                                                                        |              |
| 6.50.297 | "Site Server 3.0 Commerce Edition" hotfix                                                                         |              |
| 6.50.281 | 178295 Microsoft SQL Server 6.5 Service Pack 4 (SP4)                                                              |              |
| 6.50.259 | 6.5 as included with "Small Business Server" only                                                                 |              |
| 6.50.258 | Microsoft SQL Server 6.5 Service Pack 3a (SP3a)                                                                   |              |
| 6.50.252 | Microsoft SQL Server 6.5 Service Pack 3 (SP3)                                                                     |              |
| 6.50.240 | 160727 Microsoft SQL Server 6.5 Service Pack 2 (SP2)                                                              |              |
| 6.50.213 | 153096 Microsoft SQL Server 6.5 Service Pack 1 (SP1)                                                              |              |
| 6.50.201 | Microsoft SQL Server 6.5 RTM                                                                                      | 1996-06-30   |


## Microsoft SQL Server 6.0 Builds
<a id="microsoft-sql-server-60-builds"></a>

| Build    | KB / Description                              | Release Date |
|----------|-----------------------------------------------|--------------|
| 6.00.151 | Microsoft SQL Server 6.0 Service Pack 3 (SP3) |              |
| 6.00.139 | Microsoft SQL Server 6.0 Service Pack 2 (SP2) |              |
| 6.00.124 | Microsoft SQL Server 6.0 Service Pack 1 (SP1) |              |
| 6.00.121 | Microsoft SQL Server 6.0 RTM                  |              |
