# SQL Server KIT
[![licence badge]][licence]
[![stars badge]][stars]
[![forks badge]][forks]
[![issues badge]][issues]

Useful links, scripts, tools and best practice for Microsoft SQL Server Database

Headers:
 - [Repo Folders and Fles](#repo-folders-and-files)
 - [SQL Server Web Resources](#sql-server-web-resources)
 - [SQL Server Developer Edition Links](#sql-server-developer-edition-links)
 - [SQL Server Express direct download links](#sql-server-express-direct-download-links)
 - [Microsoft Adventure Works Sample Databases download links](#microsoft-adventure-works-sample-databases-download-links)
 - [Microsoft Transact-SQL Hints](#microsoft-transact-sql-hints)
 - [PowerShell and SQL Server](#powershell-and-sql-server)
 - [TSQL Format Code](#tsql-format-code)
 - [Free SQL Server Ebooks](#free-sql-server-ebooks)
 - [License](#license)


## Repo Folders and Files
 - [SQL Server Data Types](/SQL Server Data Types.md)
 - [SQL Server Edition](/SQL Server Edition.md)
 - [SQL Server Name Convention and T-SQL Programming Style](/SQL Server Name Convention and T-SQL Programming Style.md)
 - [SQL Server Licensing](/SQL Server Licensing.md)
 - [SQL Server People](/SQL Server People.md 'Most Valuable SQL Server professionals')
 - [SQL Server Trace Flag](/SQL Server Trace Flag.md 'Complete list - 303 Trace Flags') (Complete list - 303 trace flags)
 - [SQL Server Version](/SQL Server Version.md 'List of all Microsoft SQL Sever versions') (Complete list - from SQL Server 1.0 to SQL Server 2016)
 - [Articles](/Articles)
 - [CLR procedures](/CLR)
    - [SQL#](/CLR/SQLsharp_SETUP.sql) free version - QUICKEST and EASIEST way to extending the power of T-SQL with C#
    - [SplitterB_CLR](/CLR/SplitterB_CLR.sql)
 - [Known Errors](/Errors)
 - [Solution](/Solution)
    - [dbWarden](/Solution/dbWarden) a free SQL Server Monitoring Package (by Stevie Rounds and Michael Rounds)
    - [Base line Collector script](/Solution/BaselineCollector) (by Robert Virag)
    - [Ola Maintenance Solution](/Solution/Ola_Maintenance_Solution) (by Ola Hallengren)
    - [SQLQueryStress](/Solution/SQLQueryStress) (by Adam Machanic)
    - [SysJobHistory](/Solution/SysJobHistory) (by David Wentzel)
 - [SSMS](/SSMS)
    - [SSMS addons](/SSMS/SSMS_Addins.md) (24 useful free and paid SSMS Addins)
    - [SSMS Snippets](/SSMS/SSMS_Snippets)
    - [SSMS Shortcuts](/SSMS/SSMS_Shortcuts.md)
 - [Scripts](/Scripts)
    - **Awesome SQL Server Diagnostic Information Queries** (by Glenn Alan Berry)
      - [SQL Server 2016 Diagnostic Information Queries](/Scripts/SQL Server 2016 Diagnostic Information Queries.sql)
      - [SQL Server 2014 Diagnostic Information Queries](/Scripts/SQL Server 2014 Diagnostic Information Queries.sql)
      - [SQL Server 2012 Diagnostic Information Queries](/Scripts/SQL Server 2012 Diagnostic Information Queries.sql)
      - [SQL Server 2008 R2 Diagnostic Information Queries](/Scripts/SQL Server 2008 R2 Diagnostic Information Queries.sql)
      - [SQL Server 2008 Diagnostic Information Queries](/Scripts/SQL Server 2008 Diagnostic Information Queries.sql)
    - [Table count alternative](/Scripts/Table Count alternative.sql) (by Jes Schultz Borland)
    - [Foreign Key batch rename](/Scripts/Foreign Key batch rename.sql) (by Wes Henriksen)
    - [Count character matches](/Scripts/Count character matches.sql)
    - and many others...
 - [Stored Procedure](/Stored_Procedure)
   - [sp_DBPermissions](/Stored_Procedure/sp_DBPermissions.sql) (by Kenneth Fisher)
   - [sp_SrvPermissions](/Stored_Procedure/sp_SrvPermissions.sql) (by Kenneth Fisher)
   - [sp_RestoreGene](/Stored_Procedure/sp_RestoreGene.sql) (by Paul Brewer)
   - [usp_who5](/Stored_Procedure/usp_who5.sql) (by Sean Smith)
   - [usp_String_Search](/Stored_Procedure/usp_String_Search.sql) (by Sean Smith)
   - [usp_BulkUpload](/Stored_Procedure/usp_BulkUpload.sql)
   - [usp_TableUnpivot](/Stored_Procedure/usp_TableUnpivot.sql)
   - [usp_SSIS_ScriptEnvironment](/Stored_Procedure/usp_SSIS_ScriptEnvironment.sql)
   - and many others...
 - [User Defined Function](/User_Defined_Function)
    - [udf_parseJSON](/User_Defined_Function/udf_parseJSON.sql)
    - [udf_RenderXMLToString](/User_Defined_Function/udf_RenderXMLToString.sql)
    - [udf_RTF2Text](/User_Defined_Function/udf_RTF2Text.sql)
    - [udf_SplitStringByDelimiter](/User_Defined_Function/udf_SplitStringByDelimiter.sql)
    - [udf_Tally](/User_Defined_Function/udf_Tally.sql)
    - and many others...
 - [Utilities](/Utilities) (complete list of 124 SQL Server paid and free Utilities and Tools)


## SQL Server Web Resources
 - Blogs
    - [SQL Central Blog Scripts](http://www.sqlservercentral.com/Scripts/)
    - [SQL Central Blog Articles](http://www.sqlservercentral.com/Articles/)
    - [SQL Central Blog Stairways](http://www.sqlservercentral.com/stairway/)
    - [MSSQLTips](https://www.mssqltips.com/get-free-sql-server-tips/)
    - [BRENT OZAR](https://www.brentozar.com/) scripts, videos and articles
    - [Simple-talk Articles](https://www.simple-talk.com/)
    - [SQLSentry Blog](http://blogs.sqlsentry.com)
    - [Glenn Berry's SQL Server Performance](http://sqlserverperformance.wordpress.com/)
    - [Kenneth Fisher SQLStudies Blog](http://sqlstudies.com/)
    - [Best SQL Server Perfomance Blog](http://sqlperformance.com/)
    - [Weblogs SQLTeam Blogs](http://weblogs.sqlteam.com/)
    - [SQLMag](http://sqlmag.com/)
    - [SQLShack](http://www.sqlshack.com/)
    - [SQLPass](http://www.sqlpass.org/Home.aspx)
    - [Vertabelo Blog](http://www.vertabelo.com/blog)
    - [Midnightdba Blog](http://www.midnightdba.com/Jen/)
    - [Madeiradata Blog](http://www.madeiradata.com/blog/)
    - [SQL Server Performance Articles](http://www.sql-server-performance.com/category/articles/)
    - [SQL and more with KRUTI Blog](http://sqlandmorewithkruti.blogspot.ru/search/label/SQL%20Server)
    - [SQL Authority](http://blog.sqlauthority.com/)
    - [TECHNET SQL Server Blog](https://blogs.technet.microsoft.com/dataplatforminsider/)
    - [SQL Server Database Engine Blog](https://blogs.msdn.microsoft.com/sqlserverstorageengine/)
    - [SQL Server BI Blog](https://sqlserverbiblog.wordpress.com/)
    - [Andy Yun SQLBeck Blog](https://sqlbek.wordpress.com/)
    - [Curated SQL](http://curatedsql.com/)
    - [Blog do Ezequiel](https://blogs.msdn.microsoft.com/blogdoezequiel/)
    - [SQLHA Blog](http://sqlha.com/blog/)
    - [SQLSecurity Blog](http://www.sqlsecurity.com/home)
    - [T-SQL.ru](http://www.t-sql.ru/)
 - Free Videos
   - [IDERA Resource Center](https://www.idera.com/resourcecentral)
   - [MSSQLTips SQL Server Webcasts and Videos](https://www.mssqltips.com/sql-server-webcasts/)
   - [SQL Server Videos](http://www.sqlservervideos.com/)
   - [TECHNET How do I Videos](https://technet.microsoft.com/en-us/library/dd353197.aspx)
   - [Veeam Learn Microsoft SQL Server](http://go.veeam.com/learn-microsoft-sql-server-free-video-tutorial-course.html)
   - [MidnightDBA ITBookWorm Video](http://midnightdba.itbookworm.com/)
   - [SQL Server Hangouts](https://www.youtube.com/playlist?list=PLvcGRPk71pmRi2UZHKfyruJKu_zHZ0ROc) (by Boris Hristov, Cathrine Wilhelmsen)
 - Free Database Podcasts
   - [SQL Server Radio](http://www.sqlserverradio.com/) (by Guy Glantser and Matan Yungman)
   - [SQL Data Partners](http://sqldatapartners.com/podcast/) (by Carlos L Chacon, César Oviedo and Adrian Miranda)
   - [Away from the Keyboard](http://awayfromthekeyboard.com/) (by Cecil Phillip and Richie Rump)
   - [RunAs Radio](http://runasradio.com/) (by Richard Campbell and Greg Hughes)
   - [People Talking Tech](http://peopletalkingtech.com/) (by Denny Cherry)
   - [NET Rocks!](http://www.dotnetrocks.com/) (by Richard Campbell and Carl Franklin)
   - [SQL Down Under Podcast](http://www.sqldownunder.com/Podcasts) (by Greg Low)
   - [Free sql server video tutorials for beginners](http://csharp-video-tutorials.blogspot.ru/p/free-sql-server-video-tutorials-for.html) (by PRAGIM Technologies)
 - Courses
   - [MVA SQL Server Courses](https://mva.microsoft.com/product-training/sql-server)
   - [Lynda Courses](http://www.lynda.com/SQL-Server-training-tutorials/456-0.html)
   - [Veeam Free Courses](https://go.veeam.com/microsoft-sql-series-webinars.html)
   - [SQLSkills Trainings](https://www.sqlskills.com/sql-server-training/online-training/)
   - [Brent Ozar Team Trainings](https://learnfrom.brentozar.com/)
   - [Pluralsight Courses](https://www.pluralsight.com/search?q=sql+server&categories=all)
 - SQL Server Backwards Compatibility
   - [2014 Backwards Compatibility](http://msdn.microsoft.com/en-us/library/cc707787.aspx)
   - [2012 Backwards Compatibility](http://msdn.microsoft.com/en-us/library/cc707787(v=sql.110).aspx)
   - [2008 R2 Backwards Compatibility](http://msdn.microsoft.com/en-us/library/cc707787(v=sql.105).aspx)
   - [2008 Backwards Compatibility](http://msdn.microsoft.com/en-us/library/cc707787(v=sql.100).aspx)
   - [2005 Backwards Compatibility](http://technet.microsoft.com/en-us/library/ms143532(v=sql.90).aspx)
 - Other
    - [SQL Server Management Studio](https://msdn.microsoft.com/en-us/library/mt238290.aspx) installation download link
    - Best backup and index maintenance solution [Ola Maintenance Solution](https://ola.hallengren.com/)
    - [SQL# CLR functions](http://www.sqlsharp.com/) (by Sql Quantum Leap)
    - [SSIS Performance Benchmarks](http://ssisperformance.com/)
    - [Statistic Parser](https://github.com/Jorriss/StatisticsParser) (by Richie Rump)
    - [Using Excel to parse Set Statistics IO output](http://vickyharp.com/2012/03/using-excel-to-parse-set-statistics-io-output/) (by Vicky Harp)
    - [SQL Generator](https://github.com/Jorriss/sqlgenerator) (by Richie Rump)
    - [Columnstore Indexes Scripts Library](https://github.com/NikoNeugebauer/CISL) (by Niko Neugebauer)
    - [Stackoverflow SQL Server](http://stackoverflow.com/questions/tagged/sql-server)
    - [DBA Stackexchange SQL Server](http://dba.stackexchange.com/questions/tagged/sql-server)
    - [BIMLScript Learn resource](http://www.bimlscript.com/)
    - [SQL Server Connection Strings](http://www.connectionstrings.com/sql-server/)
    - [SQL Injection Cheat Sheet](https://www.netsparker.com/blog/web-security/sql-injection-cheat-sheet/) (by Ferruh Mavituna)
    - [RSS Most Recent SQL Server KBs](https://support.microsoft.com/en-us/rss?rssid=1044)
    - [Stackoverflow SQL Anti Patterns](http://stackoverflow.com/questions/346659/what-are-the-most-common-sql-anti-patterns)
    - [SQL Server Latch Classes Library](https://www.sqlskills.com/help/latches/) (by Paul S. Randal)
    - [Azure Speed](http://www.azurespeed.com/) (by Blair Chen)


## SQL Server Developer Edition Links <a id="sql-server-developer-edition-links"></a>
**Now it is free!!!** [SQL Server Developer Edition Download page](https://myprodscussu1.app.vssubscriptions.visualstudio.com/Downloads?q=SQL%20Server%20Developer)

For downloading your copy SQL Server Developer Edition you just need to join the [Visual Studio Dev Essentials program](https://www.visualstudio.com/en-us/products/visual-studio-dev-essentials-vs.aspx)

**Important Note**: SQL Server 2016 has a critical pre-requisite for updated Visual Studio VC++ 2013 Runtime Libraries.
To install or check if this update is required on your system, please see [KB316398](http://go.microsoft.com/fwlink/?LinkID=798747).

| Edition\Direct Download Link                                                | Release Date | File name                                                                    | Size, Mb | SHA1                                     |
|-----------------------------------------------------------------------------|--------------|------------------------------------------------------------------------------|---------:|------------------------------------------|
| SQL Server 2016 Developer (x64) - DVD (English)                             | 2016-06-01   | en_sql_server_2016_developer_x64_dvd_8777069.iso                             | 2103     | 1B23982FE56DF3BFE0456BDF0702612EB72ABF75 |
| SQL Server 2014 Developer Edition with Service Pack 1 (x64) - DVD (English) | 2015-05-21   | en_sql_server_2014_developer_edition_with_service_pack_1_x64_dvd_6668542.iso | 3025     | BFEE1F300C39638DA0D2CD594636698C6207C852 |
| SQL Server 2014 Developer Edition with Service Pack 1 (x86) - DVD (English) | 2015-05-21   | en_sql_server_2014_developer_edition_with_service_pack_1_x86_dvd_6668541.iso | 2462     | ED3C70507A73BCC63D67CFA272CD849B9418A18E |
| SQL Server 2014 Developer Edition (x64) - DVD (English)                     | 2014-04-01   | en_sql_server_2014_developer_edition_x64_dvd_3940406.iso                     | 2486     | F73F430F55A71DA219FC7257A3A28E8FC142530F |
| SQL Server 2014 Developer Edition (x86) - DVD (English)                     | 2014-04-01   | en_sql_server_2014_developer_edition_x86_dvd_3938200.iso                     | 2039     | 395B35FD80AA959B02B0C399DA1BB0C020DB6310 |


## SQL Server Express direct download links
Original post written by Scott Hanselman: http://www.hanselman.com/blog/DownloadSQLServerExpress.aspx<br />
Official Microsoft SQL Server Express page: https://www.microsoft.com/en-us/server-cloud/products/sql-server-editions/sql-server-express.aspx


### [Download SQL Server 2014 Express](https://www.microsoft.com/en-us/download/details.aspx?id=52679)


### [Download SQL Server 2014 Express](http://www.microsoft.com/en-us/download/details.aspx?id=42299)
You likely just want SQL Server 2014 Express with Tools. This download includes SQL Management Studio:
 - [SQL Server 2014 Express x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2064BIT/SQLEXPRWT_x64_ENU.exe)
 - [SQL Server 2014 Express x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2032BIT/SQLEXPRWT_x86_ENU.exe)

Here's just SQL Server 2014 Management Studio:
 - [SQL Management Studio x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe)

SQL Server 2014 Express with Advanced Services:
 - [Advanced Services x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2064BIT/SQLEXPRADV_x64_ENU.exe)
 - [Advanced Services x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2032BIT/SQLEXPRADV_x86_ENU.exe)


### [Download SQL Server 2012 Express](http://www.microsoft.com/en-us/download/details.aspx?id=29062)
You likely just want SQL Server 2012 Express with Tools. This download includes SQL Management Studio:
 - [SQL Server 2012 Express x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLEXPRWT_x64_ENU.exe)

Here's just SQL Server 2012 Management Studio:
 - [SQL Management Studio x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x86/SQLManagementStudio_x86_ENU.exe)


### [Download SQL Server 2008 Express R2 SP2](http://www.microsoft.com/en-us/download/details.aspx?id=30438)
You likely just want SQL Server 2008 Express with Tools. This download includes SQL Management Studio:
 - [SQL Server 2008 Express x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe)
 - [SQL Server 2008 Express x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x86_ENU.exe)

Here's just SQL Server 2008 Management Studio:
 - [SQL Management Studio x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe)
 - [SQL Management Studio x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x86_ENU.exe)


### [Download SQL Server 2005 Express](https://www.microsoft.com/en-us/download/details.aspx?id=21844)


## Microsoft Adventure Works Sample Databases download links
 - [AdventureWorks Sample Databases and Scripts for SQL Server 2016 CTP3](https://www.microsoft.com/en-us/download/details.aspx?id=49502)
 - [Microsoft SQL Server Community Projects & Samples](http://sqlserversamples.codeplex.com/)
 - [Adventure Works 2014 Sample Databases](https://msftdbprodsamples.codeplex.com/releases/view/125550)
 - [Adventure Works 2012 Sample Databases](http://msftdbprodsamples.codeplex.com/releases/view/55330)
 - [Microsoft SQL Server 2008 R2 SR1 Sample Databases](https://sqlserversamples.codeplex.com/releases/view/72278)


## [Microsoft Transact-SQL Hints](https://msdn.microsoft.com/en-us/library/ms187713.aspx)
 - [Transact-SQL Join Hints](https://msdn.microsoft.com/en-us/library/ms173815.aspx)
 - [Transact-SQL Table Hints](https://msdn.microsoft.com/en-us/library/ms187373.aspx)
 - [Transact-SQL Query Hints](https://msdn.microsoft.com/en-us/library/ms181714.aspx)


## PowerShell and SQL Server
 - [SQL Server & Windows Documentation Using Windows PowerShell](https://sqlpowerdoc.codeplex.com/) (by Kendal Vandyke)
 - [TSQL Code Smells Finder](https://tsqlsmells.codeplex.com/) (by Dave Ballantyne)
 - [Stairway to SQL PowerShell](http://www.sqlservercentral.com/stairway/91327/) (by Ben Miller)
 - [SQL Server Health Check Script with Powershell](http://www.codeproject.com/Tips/848661/SQL-Server-Health-Check-Script-with-Powershell) (by Atul Kapoor)
 - [Universal SQL Server Installation Scripts](https://github.com/ktaranov/Universal-SQL-Installation-Scripts) (by Prakash Heda)
 - [Powershell SQL Server Performance Health Check ](https://github.com/SpeedySQL/HealthCheck) (by Omid Afzalalghom)
 - [Performance Analysis of Logs (PAL) Tool](http://pal.codeplex.com/) (by svenhau and mikelag)
 - [PSCI - Powershell Continuous Integration](https://github.com/ObjectivityBSS/PSCI) (by Objectivity Bespoke Software Specialists)
 - [SQLTranscriptase - SQL Server Documentation in Powershell](https://github.com/vijaybandi/SQLTranscriptase) (by Vijay Bandi)
 - [SQL Server PowerShell Extensions (SQLPSX)](https://github.com/MikeShepard/SQLPSX) (by Mike Shepard)
 - [PowerShell dbatools for SQL Server](https://github.com/ctrlbold/dbatools) (by Chrissy LeMaire)
 - [Create a Monitoring Server for SQL Server with PowerShell](https://www.simple-talk.com/sql/database-administration/create-a-monitoring-server-for-sql-server-with-powershell/) (by Laerte Junior)
 - [PowerShell SQLPass articles and video](http://powershell.sqlpass.org/default.aspx)
 - [PowerShell Blog NetNerds](https://blog.netnerds.net/)
 - [QS Config](http://www.sqlhammer.com/qs-config/) (by Derik Hammer)
 - [Idera 89 Free SQL Server PowerShell Scripts](https://www.idera.com/productssolutions/freetools/sqlpowershellscripts)
 - [Performance Analysis of Logs (PAL) Tool](https://pal.codeplex.com/) (by Clint Huffman)
 - [Powershell SQL Server Library (PSSQLLib)](https://github.com/sanderstad/PSSQLLib) (by Sander Stad)


## TSQL Format Code
 - http://sqlinform.com/
 - http://www.dpriver.com/pp/sqlformat.htm
 - http://stackoverflow.com/questions/401928/sql-formatter-for-sql-management-studio
 - http://www.apexsql.com/sql_tools_refactor.aspx
 - http://poorsql.com/
 - http://www.architectshack.com/PoorMansTSqlFormatter.ashx
 - http://www.ssmstoolspack.com/
 - http://www.devart.com/dbforge/sql/sqlcomplete/
 - http://www.sql-format.com/


## SQL Server Test Data Generation
 - https://www.simple-talk.com/sql/t-sql-programming/generating-test-data-in-tsql/
 - http://www.yandataellan.com/
 - https://github.com/benkeen/generatedata
 - https://sourceforge.net/projects/dbmonster/
 - https://sourceforge.net/projects/spawner/
 - http://databene.org/databene-benerator
 - http://stackoverflow.com/questions/591892/tools-for-generating-mock-data


## Free SQL Server and R ebooks

SQL Server:
 - [Avesome Red Gate ebooks](http://www.red-gate.com/community/books/)
 - [Microsoft huge collection](https://blogs.msdn.microsoft.com/mssmallbiz/2013/06/18/huge-collection-of-free-microsoft-ebooks-for-you-including-office-office-365-sharepoint-sql-server-system-center-visual-studio-web-development-windows-windows-azure-and-windows-server/)
 - [Microsoft large collection](https://blogs.msdn.microsoft.com/mssmallbiz/2012/07/27/large-collection-of-free-microsoft-ebooks-for-you-including-sharepoint-visual-studio-windows-phone-windows-8-office-365-office-2010-sql-server-2012-azure-and-more/)
 - [Microsoft MVA Free ebooks](https://mva.microsoft.com/ebooks)
 - [OnlineVideoLectures ebooks](http://onlinevideolecture.com/ebooks/?subject=SQL-Server)
 - [Brent Ozar ebooks](http://www.brentozar.com/first-aid/free-database-books-pdfs-download/)
 - [E-books SQL Server Directory](http://www.e-booksdirectory.com/listing.php?category=569)
 - [TOAD SQL Server ebooks](https://www.toadworld.com/platforms/sql-server/b/weblog/archive/2013/06/21/huge-collection-of-free-microsoft-sql-server-ebooks)
 - [Syncfusion Techportal](http://syncfusion.com/resources/techportal)
 - [Modern Storage Strategies for SQL Server](http://www.actualtech.io/gg-modern-storage/)
 - [Migrating SQL Server Databases to Azure](https://blogs.msdn.microsoft.com/microsoft_press/2016/05/11/free-ebook-microsoft-azure-essentials-migrating-sql-server-databases-to-azure/)

R:
 - [FreeComputerBooks R EBooks](http://freecomputerbooks.com/langRBooks.html)
 - [Effective Graphs with Microsoft R Open](http://blog.revolutionanalytics.com/2016/05/e-book-effective-graphs.html)
 - [Little Book of R for Time Series](http://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/index.html) (by Avril Coghlan)
 - [Little Book of R for Biomedical Statistics](http://a-little-book-of-r-for-biomedical-statistics.readthedocs.io/en/latest/index.html) (by Avril Coghlan)
 - [Little Book of R for Multivariate Analysis](http://little-book-of-r-for-multivariate-analysis.readthedocs.io/en/latest/index.html) (by Avril Coghlan)


## License
[MIT](/LICENSE.md)

If some procedures or scripts are restricted due to **ELUA** (or we can not find original author), please email or add issue - we remove/update it immediately.
Thanks for understanding and patience.


[licence badge]:https://img.shields.io/badge/license-MIT-blue.svg
[stars badge]:https://img.shields.io/github/stars/ktaranov/sqlserver-kit.svg
[forks badge]:https://img.shields.io/github/forks/ktaranov/sqlserver-kit.svg
[issues badge]:https://img.shields.io/github/issues/ktaranov/sqlserver-kit.svg

[licence]:https://github.com/ktaranov/sqlserver-kit/blob/master/LICENSE.md
[stars]:https://github.com/ktaranov/sqlserver-kit/stargazers
[forks]:https://github.com/ktaranov/sqlserver-kit/network
[issues]:https://github.com/ktaranov/sqlserver-kit/issues
