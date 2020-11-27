# SQL Server Management Studio
SQL Server Management Studio is an integrated environment for managing your SQL Server infrastructure and Azure SQL Database.
Management Studio provides tools to configure, monitor, and administer instances of SQL Server.
It also provides tools to deploy, monitor, and upgrade the data-tier components, such as databases and data warehouses used by your applications, and to build queries and scripts.


## SSMS Guides
- [40 SSMS Tips](SSMS_Tips.md) (by Konstantin Taranov)
- [36 SSMS Addins](SSMS_Addins.md) (by Konstantin Taranov)
- [SSMS Snippets](SSMS_Snippets)
- [SSMS Shortcuts](SSMS_Shortcuts.md) (by Konstantin Taranov)
- [A month of SSMS tips and tricks](https://blog.waynesheffield.com/wayne/archive/2018/02/ssms-tips-tricks/) (by Wayne Sheffield)
- [SSMS Tricks & Shortcuts](http://www.e-squillace.com/ssms-tricks-shortcuts/) (by George Squillace)
- [SSMS Tricks and Tips Ebook](https://sql-down-under.newzenler.com/f/ssms-tips-tricks-book) (by Greg Low)

### Useful Resources
- [Download SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
- [SQL Server Management Studio - Changelog (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-changelog-ssms)
- [SQL Server Management Studio (SSMS) - Release Candidate](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms-release-candidate)
- [Previous SQL Server Management Studio Releases](https://docs.microsoft.com/en-us/sql/ssms/previous-sql-server-management-studio-releases)
- [SQLSentry Latest Builds of Management Studio](http://blogs.sqlsentry.com/team-posts/latest-builds-management-studio/)
- [SQL Server Tools](https://docs.microsoft.com/en-us/sql/ssdt/sql-server-tools)
- [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms)
- [Microsoft Download Center SSMS](https://www.microsoft.com/en-us/download/search.aspx?q=sql%20server%20management%20studio&p=0&r=10&t=&s=Relevancy~Descending)
- [Add Transact-SQL Snippets](https://docs.microsoft.com/en-us/sql/relational-databases/scripting/add-transact-sql-snippets)


## Supported SQL Server versions
This version of SSMS works with all supported versions of SQL Server (SQL Server 2008 - SQL Server 2017), and provides the greatest level of support for working with the latest cloud features in Azure SQL Database, and Azure SQL Data Warehouse.
There is no explicit block for SQL Server 2000 or SQL Server 2005, but some features may not work properly.
Additionally, SSMS 17.x can be installed side-by-side with SSMS 16.X or SQL Server 2014 SSMS and earlier.


## Supported Operating systems
This release of **SSMS 17.x Version** supports the following platforms when used with the latest available service pack: Windows 10, Windows 8, Windows 8.1, Windows 7 (SP1),  Windows Server 2016, Windows Server 2012 (64-bit), Windows Server 2012 R2 (64-bit), Windows Server 2008 R2 (64-bit)

SSMS 18.x is not supported on Windows 8. Windows 10 / Windows Server 2016 requires version 1607 (10.0.14393) or later:
Due to the new dependency on NetFx 4.7.2, SSMS 18.0 does not install on Windows 8, older versions of Windows 10, and Windows Server 2016. SSMS setup will block on those operating systems. Windows 8.1 is still supported.


### SSMS Version Notes
SSMS 17.X is based on the Visual Studio 2015 Isolated shell, which was released before Windows Server 2016.
Microsoft takes app compatibility very seriously and ensures that already-shipped applications continue to run on the latest Windows releases.
Because of this, we do not anticipate that SSMS with all latest updates applied) will encounter issues when running on Windows Server 2016.
Customers are advised to contact support, should they encounter any issues with SSMS on Windows Server 2016.
Support will then work with customers to determine if the issue is with SSMS or Visual Studio or with Windows compatibility, and route the issue appropriately.

SSMS 18.x is based on the new Visual Studio 2017 Isolated Shell: The new shell unlocks all the accessibility fixes that went in to both SSMS and Visual Studio.


## Available Languages
**SQL Server Management Studio 18.5 GA**:
 [Chinese (People's Republic of China)](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x804) |
 [Chinese (Taiwan)](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x404) |
 [English (United States)](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x409) |
 [French](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x40c) |
 [German](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x407) |
 [Italian](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x410) |
 [Japanese](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x411) |
 [Korean](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x412) |
 [Portuguese (Brazil)](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x416) |
 [Russian](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x419) |
 [Spanish](https://go.microsoft.com/fwlink/?linkid=2147207&clcid=0x40a)


## SQL Server Management Studio Download Links and Release Info
- **GA** - General Availability
- **PP** - Public Preview
- Size in Megabytes for English version

| Version/Download Link     | Info           | Build         | Release Date | Size, Mb |
| --------------------------|----------------|---------------|--------------|---------:|
| [18.7.1 GA Release]       | **Latest GA**  | 15.0.18358.0  | 2020-10-27   |      635 |
| [18.7. GA Release]        |                | 15.0.18357.0  | 2020-10-20   |      635 |
| [18.6 GA Release]         |                | 15.0.18338.0  | 2020-07-22   |      534 |
| [18.5.1 GA Release]       |                | 15.0.18333.0  | 2020-06-09   |      535 |
| [18.5 GA Release]         |                | 15.0.18183.0  | 2020-04-07   |      535 |
| [18.4 GA Release]         |                | 15.0.18206.0  | 2019-11-04   |      539 |
| [18.3.1 GA Release]       |                | 15.0.18183.0  | 2019-10-02   |      534 |
| [18.3 GA Release]         |                | 15.0.18178.0  | 2019-09-23   |      534 |
| [18.2 GA Release]         |                | 15.0.18142.0  | 2019-07-25   |      528 |
| [18.1 GA Release]         |                | 15.0.18131.0  | 2019-06-11   |      527 |
| [18.0 GA Release]         |                | 15.0.18118.0  | 2019-04-24   |      524 |
| [18.0 RC1 Release]        |                | 15.0.18098.0  | 2019-03-28   |      484 |
| [18.0 Preview 7 Release]  |                | 15.0.18092.0  | 2019-03-01   |      478 |
| [18.0 Preview 6 Release]  |                | 15.0.18075.0  | 2018-12-18   |      457 |
| [18.0 Preview 5 Release]  |                | 15.0.18068.0  | 2018-11-15   |      457 |
| [18.0 Preview 4 Release]  |                | 15.0.18040.0  | 2018-09-24   |      456 |
| [17.9.1 Release]          | **Latest 17**  | 14.0.17289.0  | 2018-11-21   |      807 |
| [17.9 Release]            |                | 14.0.17285.0  | 2018-09-04   |      807 |
| [17.8.1 Release]          |                | 14.0.17277.0  | 2018-06-26   |      806 |
| [17.8 Release]            | **Deprecated** | 14.0.17276.0  | 2018-06-21   |      806 |
| [17.7 Release]            |                | 14.0.17254.0  | 2018-05-09   |      803 |
| [17.6 Release]            |                | 14.0.17230.0  | 2018-03-20   |      802 |
| [17.5 Release]            |                | 14.0.17224.0  | 2018-02-15   |      802 |
| [17.4 Release]            |                | 14.0.17213.0  | 2017-12-07   |      802 |
| [17.3 Release]            |                | 14.0.17199.0  | 2017-10-09   |      801 |
| [17.2 Release]            |                | 14.0.17177.0  | 2017-08-07   |      819 |
| [17.1 Release]            |                | 14.0.17119.0  | 2017-05-24   |      784 |
| [17.0 Release]            |                | 14.0.17099.0  | 2017-04-25   |      729 |
| [17.0 RC3 Release]        |                | 14.0.17028.0  | 2017-03-09   |      677 |
| [17.0 RC2 Release]        |                | 14.0.16150.0  | 2017-02-01   |      682 |
| [17.0 RC1 Release]        |                | 14.0.16000.64 | 2016-11-16   |      687 |
| [16.5.3 Release]          | **Latest 16**  | 13.0.16106.4  | 2017-01-26   |      898 |
| 16.5.2 Release            | **Deprecated** | 13.0.16105.4  | 2017-01-18   |      898 |
| [16.5.1 Release]          |                | 13.0.16100.1  | 2016-12-05   |      894 |
| [16.5 Release]            |                | 13.0.16000.28 | 2016-10-26   |      894 |
| [16.4.1 Release]          |                | 13.0.15900.1  | 2016-09-23   |      894 |
| 16.4 Release              | **Deprecated** | 13.0.15800.18 | 2016-09-20   |          |
| [16.3 Release]            |                | 13.0.15700.28 | 2016-08-15   |      806 |
| [July 2016 Hotfix Update] |                | 13.0.15600.2  | 2016-07-13   |      825 |
| July 2016 Release         | **Deprecated** | 13.0.15500.91 | 2016-07-01   |          |
| [June 2016 Release]       |                | 13.0.15000.23 | 2016-06-01   |      825 |
| [SQL Server 2014 SP1]     |                | 12.0.4100.1   | 2015-05-14   |      815 |
| [SQL Server 2012 SP3]     |                | 11.0.6020.0   | 2015-11-21   |      964 |
| [SQL Server 2008 R2]      |                | 10.50.4000    | 2012-07-02   |      161 |

[18.7.1 GA Release]:https://go.microsoft.com/fwlink/?linkid=2147207
[18.7 GA Release]:https://go.microsoft.com/fwlink/?linkid=2146265
[18.6 GA Release]:https://go.microsoft.com/fwlink/?linkid=2135491
[18.5.1 GA Release]:https://go.microsoft.com/fwlink/?linkid=2132606
[18.5 GA Release]:https://go.microsoft.com/fwlink/?linkid=2125901
[18.4 GA Release]:https://go.microsoft.com/fwlink/?linkid=2108895
[18.3.1 GA Release]:https://go.microsoft.com/fwlink/?linkid=2105412
[18.3 GA Release]:https://go.microsoft.com/fwlink/?linkid=2104251
[18.2 GA Release]:https://go.microsoft.com/fwlink/?linkid=2099720
[18.1 GA Release]:https://go.microsoft.com/fwlink/?linkid=2094583
[18.0 GA Release]:https://go.microsoft.com/fwlink/?linkid=2088649
[18.0 RC1 Release]:https://go.microsoft.com/fwlink/?linkid=2085742
[18.0 Preview 7 Release]:https://go.microsoft.com/fwlink/?linkid=2078638
[18.0 Preview 6 Release]:https://go.microsoft.com/fwlink/?linkid=2052501
[18.0 Preview 5 Release]:https://go.microsoft.com/fwlink/?linkid=2041155
[18.0 Preview 4 Release]:https://go.microsoft.com/fwlink/?linkid=2014662
[17.9.1 Release]:https://go.microsoft.com/fwlink/?linkid=2043154
[17.9 Release]:https://go.microsoft.com/fwlink/?linkid=2014306
[17.8.1 Release]:https://go.microsoft.com/fwlink/?linkid=875802
[17.8 Release]:https://go.microsoft.com/fwlink/?linkid=875673
[17.7 Release]:https://go.microsoft.com/fwlink/?linkid=873126
[17.6 Release]:https://go.microsoft.com/fwlink/?linkid=870039
[17.5 Release]:https://go.microsoft.com/fwlink/?linkid=867670
[17.4 Release]:https://go.microsoft.com/fwlink/?linkid=864329
[17.3 Release]:https://go.microsoft.com/fwlink/?linkid=858904
[17.2 Release]:https://go.microsoft.com/fwlink/?linkid=854085
[17.1 Release]:https://go.microsoft.com/fwlink/?linkid=849819
[17.0 Release]:https://go.microsoft.com/fwlink/?linkid=847722
[17.0 RC3 Release]:https://go.microsoft.com/fwlink/?linkid=844503
[17.0 RC2 Release]:https://go.microsoft.com/fwlink/?linkid=840957
[17.0 RC1 Release]:https://go.microsoft.com/fwlink/?LinkID=835608
[16.5.3 Release]:https://go.microsoft.com/fwlink/?LinkID=840946
[16.5.1 Release]:https://go.microsoft.com/fwlink/?linkid=837453
[16.5 Release]:http://go.microsoft.com/fwlink/?linkid=832812
[16.4.1 Release]:http://go.microsoft.com/fwlink/?LinkID=828615
[16.3 Release]:http://go.microsoft.com/fwlink/?LinkID=824938
[July 2016 Hotfix Update]:http://go.microsoft.com/fwlink/?LinkID=822301
[June 2016 Release]:http://go.microsoft.com/fwlink/?LinkID=799832
[SQL Server 2014 SP1]:http://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x86/SQLManagementStudio_x86_ENU.exe
[SQL Server 2012 SP3]:http://download.microsoft.com/download/F/6/7/F673709C-D371-4A64-8BF9-C1DD73F60990/ENU/x86/SQLManagementStudio_x86_ENU.exe
[SQL Server 2008 R2]:https://www.microsoft.com/en-us/download/details.aspx?id=30438


## SQL Server 2014 RTM Management Studio download links
 - [SQL Management Studio x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe)


## SQL Server 2012 SP1 Management Studio download links
 - [SQL Management Studio x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x86/SQLManagementStudio_x86_ENU.exe)


## SQL Server 2008 R2 Management Studio download links
 - [SQL Management Studio x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x86_ENU.exe)
