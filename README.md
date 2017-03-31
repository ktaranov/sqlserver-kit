# SQL Server KIT

<a name="header01"></a>
<a name="header02"></a>
<a name="header020"></a>
<a name="header03"></a>
<a name="header04"></a>
<a name="header05"></a>
<a name="header06"></a>
<a name="header07"></a>
<a name="header08"></a>
<a name="header09"></a>
[![licence badge]][licence]
[![stars badge]][stars]
[![forks badge]][forks]
[![issues badge]][issues]
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/ktaranov/sqlserver-kit.svg)](http://isitmaintained.com/project/ktaranov/sqlserver-kit "Average time to resolve an issue")
[![Join the chat at https://gitter.im/sqlserver-kit/Lobby](https://badges.gitter.im/sqlserver-kit/Lobby.svg)](https://gitter.im/sqlserver-kit/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![contributors_badge]][contributors]

[licence badge]:https://img.shields.io/badge/license-MIT-blue.svg
[stars badge]:https://img.shields.io/github/stars/ktaranov/sqlserver-kit.svg
[forks badge]:https://img.shields.io/github/forks/ktaranov/sqlserver-kit.svg
[issues badge]:https://img.shields.io/github/issues/ktaranov/sqlserver-kit.svg
[contributors_badge]:https://img.shields.io/github/contributors/ktaranov/sqlserver-kit.svg

[licence]:https://github.com/ktaranov/sqlserver-kit/blob/master/LICENSE.md
[stars]:https://github.com/ktaranov/sqlserver-kit/stargazers
[forks]:https://github.com/ktaranov/sqlserver-kit/network
[issues]:https://github.com/ktaranov/sqlserver-kit/issues
[contributors]:https://github.com/ktaranov/sqlserver-kit/graphs/contributors

Useful links, scripts, tools and best practice for Microsoft SQL Server Database

Headers:
 - [Repo Folders and Files](#repo-folders-and-files)
 - [SQL Server Web Resources](#sql-server-web-resources)
 - [BIML Resources and Bloggers](#biml-resources-and-bloggers)
 - [SQL Server Sample Databases and Datasets](#sql-server-sample-databases-and-datasets)
 - [Microsoft Transact-SQL Hints](#microsoft-transact-sql-hints)
 - [PowerShell and SQL Server](#powershell-and-sql-server)
 - [TSQL Format Code](#tsql-format-code)
 - [SQL Server Test Data Generation](#sql-server-test-data-generation)
 - [Free SQL Server and R ebooks](#free-sql-server-and-r-ebooks)
 - [License](#license)


## Repo Folders and Files
 - [SQL Server Data Types](/SQL%20Server%20Data%20Types.md)
 - [SQL Server Edition](/SQL%20Server%20Edition.md)
 - [SQL Server Name Convention and T-SQL Programming Style](/SQL%20Server%20Name%20Convention%20and%20T-SQL%20Programming%20Style.md)
 - [SQL Server Licensing](/SQL%20Server%20Licensing.md)
 - [SQL Server People](/SQL%20Server%20People.md 'Most Valuable SQL Server professionals')
 - [SQL Server Trace Flag](/SQL%20Server%20Trace%20Flag.md 'Complete list - 511 Trace Flags') (**Complete list - 511 trace flags**)
 - [SQL Server Version](/SQL%20Server%20Version.md 'List of all Microsoft SQL Sever versions') (**Complete list - from SQL Server 1.0 to SQL Server VNext**)
 - [Articles](/Articles)
 - [CLR procedures](/CLR)
    - [SQL#](/CLR/SQLsharp_SETUP.sql) free version - QUICKEST and EASIEST way to extending the power of T-SQL with C#
    - [SplitterB_CLR](/CLR/SplitterB_CLR.sql)
 - [Extended Events](/Extended_Events)
 - [Known Errors](/Errors)
 - [Solution](/Solution)
    - [dbWarden](/Solution/dbWarden) a free SQL Server Monitoring Package (by Stevie Rounds and Michael Rounds)
    - [Base line Collector script](/Solution/BaselineCollector) (by Robert Virag)
    - [Ola Maintenance Solution](/Solution/Ola_Maintenance_Solution) (by Ola Hallengren)
    - [SQLQueryStress](/Solution/SQLQueryStress) (by Adam Machanic)
    - [SysJobHistory](/Solution/SysJobHistory) (by David Wentzel)
 - [SSMS](/SSMS)
    - [SSMS addins](/SSMS/SSMS_Addins.md) (**29 useful free and paid SSMS Addins**)
    - [SSMS Snippets](/SSMS/SSMS_Snippets)
    - [SSMS Shortcuts](/SSMS/SSMS_Shortcuts.md)
 - [Scripts](/Scripts)
    - **Awesome SQL Server Diagnostic Information Queries** (by Glenn Alan Berry)
      - [SQL Server vNext Diagnostic Information Queries](/Scripts/SQL%20Server%20vNext%20Diagnostic%20Information%20Queries.sql)
      - [SQL Server 2016 Diagnostic Information Queries](/Scripts/SQL%20Server%202016%20Diagnostic%20Information%20Queries.sql)
      - [SQL Server 2014 Diagnostic Information Queries](Scripts/SQL%20Server%202014%20Diagnostic%20Information%20Queries.sql)
      - [SQL Server 2012 Diagnostic Information Queries](/Scripts/SQL%20Server%202012%20Diagnostic%20Information%20Queries.sql)
      - [SQL Server 2008 R2 Diagnostic Information Queries](/Scripts/SQL%20Server%202008%20R2%20Diagnostic%20Information%20Queries.sql)
      - [SQL Server 2008 Diagnostic Information Queries](/Scripts/SQL%20Server%202008%20Diagnostic%20Information%20Queries.sql)
    - [Table count alternative](/Scripts/Table%20Count%20alternative.sql) (by Jes Schultz Borland)
    - [Foreign Key batch rename](/Scripts/Foreign%20Key%20batch%20rename.sql) (by Wes Henriksen)
    - [Count character matches](/Scripts/Count%20character%20matches.sql)
    - and many others...
 - [Stored Procedure](/Stored_Procedure)
   - [sp_DBPermissions](/Stored_Procedure/sp_DBPermissions.sql) (by Kenneth Fisher)
   - [sp_SrvPermissions](/Stored_Procedure/sp_SrvPermissions.sql) (by Kenneth Fisher)
   - [sp_RestoreGene](/Stored_Procedure/sp_RestoreGene.sql) (by Paul Brewer)
   - [usp_who5](/Stored_Procedure/usp_who5.sql) (by Sean Smith)
   - [usp_String_Search](/Stored_Procedure/usp_String_Search.sql) (by Sean Smith)
   - [usp_BulkUpload](/Stored_Procedure/usp_BulkUpload.sql)
   - [usp_TableUnpivot](/Stored_Procedure/usp_TableUnpivot.sql)
   - and many others...
 - [User Defined Function](/User_Defined_Function)
    - [udf_parseJSON](/User_Defined_Function/udf_parseJSON.sql)
    - [udf_RenderXMLToString](/User_Defined_Function/udf_RenderXMLToString.sql)
    - [udf_RTF2Text](/User_Defined_Function/udf_RTF2Text.sql)
    - [udf_SplitStringByDelimiter](/User_Defined_Function/udf_SplitStringByDelimiter.sql)
    - [udf_Tally](/User_Defined_Function/udf_Tally.sql)
    - and many others...
 - [Utilities](/Utilities) (**complete list of 210 SQL Server paid and free Utilities and Tools**)

[*Back to top*](#header01)


## SQL Server Web Resources
 - Blogs
    - [SQL Central Blog Scripts](http://www.sqlservercentral.com/Scripts/)
    - [SQL Central Blog Articles](http://www.sqlservercentral.com/Articles/)
    - [SQL Central Blog Stairways](http://www.sqlservercentral.com/stairway/)
    - [DatabaseWeekly](http://www.databaseweekly.com/)
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
    - [LessThanDot SQL Server Blog](http://blogs.lessthandot.com/index.php/category/datamgmt/dbprogramming/mssqlserver/)
    - [SQLBlog](http://sqlblog.com)
    - [DatabseJournal SQL Server Blog](http://www.databasejournal.com/features/mssql/)
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
    - [SQL.ru SQL Server](http://www.sql.ru/blogs/t-sql) (Russian)
    - [C# Corner SQL Server Articles](http://www.c-sharpcorner.com/technologies/sql-server)
    - [TechTarget Blog](http://searchsqlserver.techtarget.com/)
    - [Toad SQL Server Blog](http://www.toadworld.com/platforms/sql-server/b/weblog)
    - [SQL-Articles](http://sql-articles.com/articles/)
    - [DallasDBAs Blog](http://dallasdbas.com/blog/)
    - [UpSearch Blog](https://upsearch.com/blog/)
    - [ProData Blog](http://blogs.prodata.ie/)
    - [Red9 SQL Server Performance Blog](https://red9.com/blog/)
 - Security (great thanks to [Troy Hunt](https://www.troyhunt.com/troys-ultimate-list-of-security-links/))
   - SQL injection
     - [sqlmap](http://sqlmap.org/) – The tool for mounting SQL injection attacks tests against a running site
     - [Drupal 7 SQL injection flaw of 2014](https://www.drupal.org/PSA-2014-003) – great example of how impactful it still is (patch it within 7 hours or you’re owned)
     - [Ethical Hacking: SQL Injection](http://www.pluralsight.com/courses/ethical-hacking-sql-injection) – If you really want to go deep, here’s five and a half hours worth of Pluralsight content
   - Exploit databases and breach coverage
     - [seclists.org](http://seclists.org) – Heaps of exploits consolidated from various bug tracking lists
     - [Exploit Database](https://www.exploit-db.com/) – Very comprehensive list of vulnerabilities
     - [PunkSPIDER](https://www.punkspider.org/) – Lots of vulnerabilities of all kinds all over the web (about 90M sites scanned with over 3M vulns at present)
     - [Data Loss DB](http://datalossdb.org/) – Good list of breaches including stats on number of records compromised
     - [Information is Beautiful: World’s Biggest Data Breaches](http://www.informationisbeautiful.net/visualizations/worlds-biggest-data-breaches-hacks/) – Fantastic visualisation of incidents that give a great indication of scale
   - [SQL Server Database Engine Permission Posters](http://social.technet.microsoft.com/wiki/contents/articles/11842.sql-server-database-engine-permission-posters.aspx)
 - Free Videos
   - [Youtube Brent Ozar](https://www.youtube.com/user/BrentOzar/videos)
   - [IDERA Resource Center](https://www.idera.com/resourcecentral)
   - [MSSQLTips SQL Server Webcasts and Videos](https://www.mssqltips.com/sql-server-webcasts/)
   - [SQL Server Videos](http://www.sqlservervideos.com/)
   - [TECHNET How do I Videos](https://technet.microsoft.com/en-us/library/dd353197.aspx)
   - [Veeam Learn Microsoft SQL Server](http://go.veeam.com/learn-microsoft-sql-server-free-video-tutorial-course.html)
   - [MidnightDBA ITBookWorm Video](http://midnightdba.itbookworm.com/)
   - [SQL Server Hangouts](https://www.youtube.com/playlist?list=PLvcGRPk71pmRi2UZHKfyruJKu_zHZ0ROc) (by Boris Hristov, Cathrine Wilhelmsen)
   - [Youtube russianVC](https://www.youtube.com/channel/UC0UA5gKnOq9TM1RNvMIArwg) (Russian)
   - [Youtube Redgate Videos](https://www.youtube.com/redgate)
   - [Dell DBA days the Brent Ozar Unlimited 2015](https://software.dell.com/event/webcast-series-dell-dba-days-the-brent-ozar-unlimited-show890450)
   - [Dell DBA days the Brent Ozar Unlimited 2016](https://software.dell.com/event/live-webcast-series-dell-dba-days-the-brent-ozar-unlimited-show-the-se8112821)
   - [User Group.tv](http://usergroup.tv/) (by Shawn Weisfeld)
   - [SQLPass Virtual Chapters](http://www.sqlpass.org/passchapters/virtualchapters.aspx)
   - [Youtube SQLpassion](https://www.youtube.com/channel/UCkrUQVPrv36Musorn0K4KoA)
   - [SQLBits Video](http://sqlbits.com/)
   - [Business Intelligence Videos](http://www.bidn.com/Videos/Videos)
   - [Pragmatic Works Free Training Webinars](http://pragmaticworks.com/Training/FreeTrainingWebinars)
   - [Youtube Pragmatic Works Video](https://www.youtube.com/user/PragmaticWorks) (by Devin Knight and Manuel Quintana)
   - [MVP: Data Platform](https://channel9.msdn.com/Blogs/MVP-Data-Platform)
 - Free Database Podcasts
   - [SQL Server Radio](http://www.sqlserverradio.com/) (by Guy Glantser and Matan Yungman)
   - [SQL Data Partners](http://sqldatapartners.com/podcast/) (by Carlos L Chacon, César Oviedo and Adrian Miranda)
   - [Away from the Keyboard](http://awayfromthekeyboard.com/) (by Cecil Phillip and Richie Rump)
   - [RunAs Radio](http://runasradio.com/) (by Richard Campbell and Greg Hughes)
   - [People Talking Tech](http://peopletalkingtech.com/) (by Denny Cherry)
   - [NET Rocks!](http://www.dotnetrocks.com/) (by Richard Campbell and Carl Franklin)
   - [SQL Down Under Podcast](http://www.sqldownunder.com/Podcasts) (by Greg Low)
   - [Free sql server video tutorials for beginners](http://csharp-video-tutorials.blogspot.ru/p/free-sql-server-video-tutorials-for.html) (by PRAGIM Technologies)
   - [Midnight DBA Podcast](http://midnightdba.itbookworm.com/Show) (by Sean and Jen McCown)
   - [Dear SQL DBA](https://www.littlekendra.com/dearsqldba/) (by Kendra Little)
   - [GroupBy.org - Group By is a free online event for the community, by the community](https://groupby.org/) (by Brent Ozar team)
   - [DevopsCafe](http://devopscafe.org/) (by John Willis and Damon Edwards)
   - [SQLDataPartners Podcast](http://sqldatapartners.com/podcast/)
 - Courses
   - Free
     - [Learn SQL Server by solving problems](https://sqlworkbooks.com/courses-overview/) (by Little Kendra)
     - [Codecademy Learn SQL](https://www.codecademy.com/learn/learn-sql)
     - [Codecademy SQL: Table Transformation](https://www.codecademy.com/learn/sql-table-transformation)
     - [Codecademy SQL: Analyzing Business Metrics](https://www.codecademy.com/learn/sql-analyzing-business-metrics)
     - [MVA SQL Server Courses](https://mva.microsoft.com/product-training/sql-server)
     - [How to Think Like the SQL Server Engine](https://learnfrom.brentozar.com/courses/how-to-think-like-the-engine-an-introduction-to-sql-server-internals/)
     - [Number and Date Tables](https://www.brentozar.com/archive/2016/01/video-free-training-of-the-week-number-and-date-tables/)
     - [Free SQL Tutorials](http://www.guru99.com/sql.html)
     - [OpenedX Microsoft Courses](https://openedx.microsoft.com/)
   - Paid
     - [Lynda Courses](http://www.lynda.com/SQL-Server-training-tutorials/456-0.html)
     - [Veeam Free Courses](https://go.veeam.com/microsoft-sql-series-webinars.html)
     - [SQLSkills Trainings](https://www.sqlskills.com/sql-server-training/online-training/)
     - [Brent Ozar Team Trainings](https://learnfrom.brentozar.com/)
     - [Pluralsight Courses](https://www.pluralsight.com/search?q=sql+server&categories=all)
     - [SolidQ Classes](https://training.solidq.com/classes/)
     - [JOOQ SQL Masterclass](http://www.jooq.org/training/)
     - [Learn SQL Server High Availability & Disaster Recovery](https://learnsqlserverhadr.com/) (by Edwin M Sarmiento)
     - [Madeira Data Solutions Academy](http://madeira-data-solutions.teachable.com/)
     - [SQLpassion Online Academy](http://www.sqlpassion.at/online-training/index.html) (by Klaus Aschenbrenner)
 - SQL Server Backwards Compatibility
   - [VNext Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc280407(v=sql.140).aspx)
   - [2016 Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc280407(v=sql.130).aspx)
   - [2014 Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc280407(v=sql.120).aspx)
   - [2012 Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc707787(v=sql.110).aspx)
   - [2008 R2 Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc707787(v=sql.105).aspx)
   - [2008 Backwards Compatibility](https://msdn.microsoft.com/en-us/library/cc707787(v=sql.100).aspx)
   - [2005 Backwards Compatibility](http://technet.microsoft.com/en-us/library/ms143532(v=sql.90).aspx)
 - SQL Server System Views Map
   - [SQL Server 2008 System Views Map](https://www.microsoft.com/en-us/download/details.aspx?id=9301)
   - [SQL Server 2012 System Views Map](https://www.microsoft.com/en-us/download/details.aspx?id=39083)
 - Microsoft Troubleshooting guides
   - [Solving Connectivity errors to SQL Server](https://support.microsoft.com/en-us/help/4009936/solving-connectivity-errors-to-sql-server)
   - [Troubleshooting connectivity issues with Microsoft Azure SQL Database](https://support.microsoft.com/en-in/help/10085/troubleshooting-connectivity-issues-with-microsoft-azure-sql-database)
   - [Troubleshooting Always On Issues](https://support.microsoft.com/en-us/help/10179/troubleshooting-alwayson-issues)
 - Social, Forum and Messenger SQL Server Groups
   - [SQLServerCentral Forum](http://www.sqlservercentral.com/Forums/) (more than 10^6 People)
   - [Slack #sqlhelp](https://sqlcommunity.slack.com/messages/sqlhelp/) (more than 700 People)
   - [Slack #firstresponderkit](https://sqlcommunity.slack.com/messages/firstresponderkit/) (more then 70 People)
   - [Twitter #sqlhelp](https://twitter.com/hashtag/sqlhelp) (more than 500 People)
   - [SQL.ru SQL Server Forum](http://www.sql.ru/forum/microsoft-sql-server) (more than 10^5 People, Russian)
   - [VK.com #sqlcom](https://vk.com/sqlcom) (more than 3600 People, Russian)
 - Open Source Projects
    - [Brent Ozar SQL Server First Responder Kit](https://github.com/BrentOzarULTD/SQL-Server-First-Responder-Kit) (Github)
    - [Statistic Parser](https://github.com/Jorriss/StatisticsParser) (by Richie Rump) (Github)
    - [SQL Generator](https://github.com/Jorriss/sqlgenerator) (by Richie Rump) (Github)
    - [Columnstore Indexes Scripts Library](https://github.com/NikoNeugebauer/CISL) (by Niko Neugebauer) (Github)
    - [MOSL - Memory Optimized Script Library](https://github.com/NikoNeugebauer/MOSL) (by Niko Neugebauer) (Github)
    - [SQLCover - TSQL code coverage tool for SQL Server 2008+](https://github.com/GoEddie/SQLCover) (by Ed Elliott) (Github)
    - [tSQLt testing framework for Microsoft SQL Server](https://github.com/tSQLt-org/tSQLt) (Github)
    - [T-SQL SimMetrics string matching algorithms](https://github.com/GuerrillaAnalytics/similarity) (Github)
    - [Azure Blob Storage Backup](https://github.com/bornsql/azureblobstoragesync) (by Randolph West) (Github)
    - [StackExchange.DataExplorer - free tool for executing SQL queries against Stack Exchange databases](https://github.com/StackExchange/StackExchange.DataExplorer) (Github)
    - [Machine Learning Templates with SQL Server 2016 R Services](https://github.com/Microsoft/SQL-Server-R-Services-Samples) (by Sheri Gilley) (Github)
    - [Campaign Optimization - Predicting How and When to Contact Leads Implemented on SQL Server 2016 R Services](https://github.com/Microsoft/r-server-campaign-optimization) (by Sheri Gilley) (Github)
    - [SQL Server Performance Dashboards - contains all Microsoft based reports, custom built reports, modified reports and the TSQL setup](http://sqldashboards.codeplex.com/) (by Arun Sirpal)
    - [tigertoolbox - Repository for Tiger team for "as-is" solutions and tools/scripts that the team publishes for SQL Server](https://github.com/Microsoft/tigertoolbox) (Github)
    - [SQL Server FineBuild - makes it easy for anyone to produce a best-practice installation and configuration of SQL Server](https://sqlserverfinebuild.codeplex.com/) (by Brian Davis)
    - [Pssdiag/Sqldiag Manager - is a graphic interface that provides customization capabilities to collect data for SQL Server using sqldiag collector engine](https://github.com/Microsoft/DiagManager) (Github)
 - Other
    - [SQL Server Management Studio](https://msdn.microsoft.com/en-us/library/mt238290.aspx) installation download link
    - [Ola Maintenance Solution - Best free backup and index maintenance solution for SQL Server](https://ola.hallengren.com/) (by Ola Hallengren)
    - [sp_whoisactive](http://whoisactive.com/) (by Adam Machanic)
    - [SQL# CLR functions](http://www.sqlsharp.com/) (by Sql Quantum Leap)
    - [SQL Server Latch Classes Library](https://www.sqlskills.com/help/latches/) (by Paul S. Randal)
    - [SQL Server Wait Types Library](https://www.sqlskills.com/help/waits/) (by Paul S. Randal)
    - [Waitopedia - is a comprehensive resource of information about SQL Server waits](https://www.spotlightessentials.com/waitopedia) (by Spotlight Essentials)
    - [SSIS Performance Benchmarks](http://ssisperformance.com/)
    - [Using Excel to parse Set Statistics IO output](http://vickyharp.com/2012/03/using-excel-to-parse-set-statistics-io-output/) (by Vicky Harp)
    - [Stackoverflow SQL Server](http://stackoverflow.com/questions/tagged/sql-server)
    - [DBA Stackexchange SQL Server](http://dba.stackexchange.com/questions/tagged/sql-server)
    - [SQL Server Connection Strings](http://www.connectionstrings.com/sql-server/)
    - [SQL Injection Cheat Sheet](https://www.netsparker.com/blog/web-security/sql-injection-cheat-sheet/) (by Ferruh Mavituna)
    - [RSS Most Recent SQL Server KBs](https://support.microsoft.com/en-us/rss?rssid=1044)
    - [Stackoverflow SQL Anti Patterns](http://stackoverflow.com/questions/346659/what-are-the-most-common-sql-anti-patterns)
    - [Azure Speed](http://www.azurespeed.com/) (by Blair Chen)
    - [SQLFiddle](http://sqlfiddle.com)
    - [Practical skills of SQL language](http://www.sql-ex.ru) (Russian, English)
    - [Experts-Exchange.com MS SQL Server Topics](https://www.experts-exchange.com/topics/ms-sql-server/)
    - [Paste The Plan](https://www.brentozar.com/pastetheplan/)
    - [StackExchange DataExplorer Query On line](http://data.stackexchange.com/stackoverflow/query/new)
    - [Dell Databases Wiki](http://en.community.dell.com/techcenter/storage/w/wiki/5018.sc-series-technical-documents) (by Doug Bernhardt)
    - [SDUTools - Free Tools for DBAs and Developers on pure TSQL](http://sqldownunder.azurewebsites.net/Resources/SDUTools) (by SQL Down Under)
    - [SqlServerSearcher - open source C# tool for searching SQL Server objects](https://github.com/CoderAllan/SqlServerSearcher) (by Allan Simonsen)
    - [DbUp is a .NET library that helps you to deploy changes to SQL Server databases](https://github.com/DbUp/DbUp)
    - [SQL Server monitor, manages sql server performance, monitor sql server processes and jobs, analyze performance](https://github.com/unruledboy/SQLMonitor) (by Wilson Chen)

[*Back to top*](#header02)


## BIML Resources and Bloggers
BIML - [Business Intelligence Markup Language](https://varigence.com/biml)

BIML Resources
- [BimlScript.com](http://bimlscript.com/)
- [Varigence](https://varigence.com/Biml)
- [Biml Forum at Varigence](https://varigence.com/Forums?forumName=Biml)
- [SQLServerCentral.com](http://www.sqlservercentral.com/search/?q=Biml)
- [Stairway to Biml](http://www.sqlservercentral.com/stairway/100550/)
- [Biml User Group at LinkedIn](https://www.linkedin.com/groups/4640985)
- [Building Blocks of Biml (Pluralsight course by Stacia Misner Varga)](https://app.pluralsight.com/library/courses/building-blocks-biml/table-of-contents)
- [Biml-tagged posts on this blog](http://sqlblog.com/blogs/andy_leonard/archive/tags/BIML/default.aspx)

BIML Bloggers
- [Ben Weissman](https://www.solisyon.de/biml-blog-de/)
- [Bill Fellows](http://billfellows.blogspot.com/search/label/Biml)
- [Boris Hristov](http://borishristov.com/biml/)
- [Brian Bønk](http://www.bonk.dk/biml/)
- [Cathrine Wilhelmsen](http://www.cathrinewilhelmsen.net/biml/)
- [Datachix: Julie Smith and Audrey Hammonds](http://datachix.com/)
- [David Stein](http://www.made2mentor.com/category/biml/)
- [Davide Mauri](http://sqlblog.com/blogs/davide_mauri/archive/tags/BIML/default.aspx)
- [Erik Hudzik](http://www.anexinet.com/blog/author/ehudzik/)
- [Hennie de Nooijer](http://bifuture.blogspot.com/search/label/BIML)
- [John Welch](http://agilebi.com/jwelch/tag/biml/)
- [Joost van Rossum](http://microsoft-ssis.blogspot.com/search/label/BIML)
- [Koen Verbeeck](http://blogs.lessthandot.com/index.php/tag/biml/)
- [Marco Schreuder](http://blog.in2bi.eu/biml/)
- [Martin Andersson](http://www.frysdisken.net/)
- [Meagan Longoria](https://datasavvy.wordpress.com/category/biml/)
- [Nicholas Sorrell](http://sorrell.github.io/)
- [Paul Te Braak](https://paultebraak.wordpress.com/tag/biml/)
- [Peter Schott](http://schottsql.blogspot.com/search/label/BIML)
- [Reeves Smith](https://reevessmith.wordpress.com/category/biml/)
- [Roelant Vos](http://roelantvos.com/blog/?tag=biml)
- [Rui Custódio](http://www.bi4all.pt/taxonomy/term/75)
- [Samuel Vanga](http://samuelvanga.com/category/biml/)
- [Stephen Leach](http://www.imgroup.com/author/stephen-leach/)
- [Tim Mitchell](https://www.timmitchell.net/post/tag/biml/)
- [Warwick Rudd](http://www.sqlmastersconsulting.com.au/SQL-Server-Blog/PID/1675/mcat/1682/evl/0/nsw/t/EDNSearch/Biml)

[*Back to top*](#header020)


## SQL Server Sample Databases and Datasets
Alternative download link for some sample databases: http://bit.ly/ya-ssk

 - [AdventureWorks Sample Databases and Scripts for SQL Server 2016 CTP3](https://www.microsoft.com/en-us/download/details.aspx?id=49502)
 - [Microsoft SQL Server Community Projects & Samples](http://sqlserversamples.codeplex.com/)
 - [Adventure Works 2014 Sample Databases](https://msftdbprodsamples.codeplex.com/releases/view/125550)
 - [Adventure Works 2012 Sample Databases](http://msftdbprodsamples.codeplex.com/releases/view/55330)
 - [Microsoft SQL Server 2008 R2 SR1 Sample Databases](https://sqlserversamples.codeplex.com/releases/view/72278)
 - [Thinking Big (Adventure)](http://sqlblog.com/blogs/adam_machanic/archive/2011/10/17/thinking-big-adventure.aspx) (by Adam Machanic)
 - [WideWorldImporters Sample Database](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/wide-world-importers) (Github Microsoft)
 - [WideWorldImporters Sample Database Download Files](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0) (Github Microsoft)
 - [IoT Smart Grid sample - demonstrates how SQL Server 2016 memory optimized databases could be used to ingest a very high input data rate](https://github.com/Microsoft/sql-server-samples/releases/tag/iot-smart-grid-v1.0) (Github Microsoft)
 - [In-Memory OLTP (WWI Sales Orders)](https://github.com/Microsoft/sql-server-samples/releases/tag/wwi-sales-orders-v0.5) (Github Microsoft)
 - [Bigger Fact Table for Wide World Importers](http://www.sqlservercentral.com/blogs/koen-verbeeck/2016/08/12/bigger-fact-table-for-wide-world-importers/) (by Koen Verbeeck)
 - [Contoso Retail Data Warehose](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/contoso-data-warehouse) (Github)
 - [How to Download the Stack Overflow Database via BitTorrent 2016-03](https://www.brentozar.com/archive/2015/10/how-to-download-the-stack-overflow-database-via-bittorrent/) (by Brent Ozar)
 - [Updating the Stack Overflow Demo Database version 2016-12-15](https://www.brentozar.com/archive/2017/01/updating-stack-overflow-demo-database/)
 - [Amazon product data](http://jmcauley.ucsd.edu/data/amazon/) (This dataset contains product reviews and metadata from Amazon, including 142.8 million reviews spanning May 1996 - July 2014)
 - [Git repo for SQL Server Reporting Services samples and community projects](https://github.com/Microsoft/Reporting-Services)
 - [SQLSkills sample databases](https://www.sqlskills.com/sql-server-resources/sql-server-demos/) (also include SAMPLE CORRUPT DATABASES)
 - [SQLIndexWorkbook Sample Database](http://www.littlekendra.com/downloads/get-the-sqlindexworkbook-database/) (by Little Kendra)
 - [Data.gov](https://www.data.gov/)
 - [Itzik Ben-Gan Sample Databases](http://tsql.solidq.com/books/source_code/) (by Itzik Ben-Gan)
 - [Orders: Open Source Sample Database](https://www.brentozar.com/orders-open-source-sample-database/) (by Brent Ozar)
 - [BabbyNames Database](https://github.com/LitKnd/BabbyNames) (by Kendra Little)

[*Back to top*](#header03)


## [Microsoft Transact-SQL Hints](https://msdn.microsoft.com/en-us/library/ms187713.aspx)
 - [Transact-SQL Join Hints](https://msdn.microsoft.com/en-us/library/ms173815.aspx)
 - [Transact-SQL Table Hints](https://msdn.microsoft.com/en-us/library/ms187373.aspx)
 - [Transact-SQL Query Hints](https://msdn.microsoft.com/en-us/library/ms181714.aspx)

[*Back to top*](#header04)


## PowerShell and SQL Server
 - [SQL Server & Windows Documentation Using Windows PowerShell](https://sqlpowerdoc.codeplex.com/) (by Kendal Vandyke)
 - [TSQL Code Smells Finder](https://tsqlsmells.codeplex.com/) (by Dave Ballantyne)
 - [Stairway to SQL PowerShell](http://www.sqlservercentral.com/stairway/91327/) (by Ben Miller)
 - [SQL Server Health Check Script with Powershell](http://www.codeproject.com/Tips/848661/SQL-Server-Health-Check-Script-with-Powershell) (by Atul Kapoor)
 - [Universal SQL Server Installation Scripts](https://github.com/ktaranov/Universal-SQL-Installation-Scripts) (by Prakash Heda)  (Github)
 - [Powershell SQL Server Performance Health Check](https://github.com/SpeedySQL/HealthCheck) (by Omid Afzalalghom) (Github)
 - [PSCI - Powershell Continuous Integration](https://github.com/ObjectivityBSS/PSCI) (by Objectivity Bespoke Software Specialists) (Github)
 - [SQLTranscriptase - SQL Server Documentation in Powershell](https://github.com/vijaybandi/SQLTranscriptase) (by Vijay Bandi) (Github)
 - [SQL Server PowerShell Extensions (SQLPSX)](https://github.com/MikeShepard/SQLPSX) (by Mike Shepard) (Github)
 - [PowerShell dbatools for SQL Server](https://github.com/ctrlbold/dbatools) (by Chrissy LeMaire) (Github)
 - [Create a Monitoring Server for SQL Server with PowerShell](https://www.simple-talk.com/sql/database-administration/create-a-monitoring-server-for-sql-server-with-powershell/) (by Laerte Junior)
 - [PowerShell SQLPass articles and video](http://powershell.sqlpass.org/default.aspx)
 - [PowerShell Blog NetNerds](https://blog.netnerds.net/)
 - [QS Config](http://www.sqlhammer.com/qs-config/) (by Derik Hammer)
 - [Idera 89 Free SQL Server PowerShell Scripts](https://www.idera.com/productssolutions/freetools/sqlpowershellscripts)
 - [Performance Analysis of Logs (PAL) Tool](https://pal.codeplex.com/) (by Clint Huffman)
 - [Powershell SQL Server Library (PSSQLLib)](https://github.com/sanderstad/PSSQLLib) (by Sander Stad) (Github)
 - [Trello Board: Powershell and SQL Client Tools](https://trello.com/b/NEerYXUU/powershell-sql-client-tools-sqlps-ssms)
 - [PowerUpSQL: A PowerShell Toolkit for Attacking SQL Server](https://github.com/NetSPI/PowerUpSQL) (Github)
 - [PowerShell DBA Reports](https://github.com/SQLDBAWithABeard/dbareports) (Github)
 - [PowerShell sqlCheck](https://bitbucket.org/yardbirdsax/sqlcheck/src) (Bitbucket) (by Josh Feierman)
 - [PowerShell Enterprise Policy Management Framework](https://epmframework.codeplex.com/)
 - [ReportingServicesTools - Reporting Services Powershell Tools](https://github.com/Microsoft/ReportingServicesTools) (by Microsoft)

[*Back to top*](#header05)


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

[*Back to top*](#header06)


## SQL Server Test Data Generation
 - https://www.simple-talk.com/sql/t-sql-programming/generating-test-data-in-tsql/
 - http://www.yandataellan.com/
 - https://github.com/benkeen/generatedata
 - https://sourceforge.net/projects/dbmonster/
 - https://sourceforge.net/projects/spawner/
 - http://databene.org/databene-benerator
 - http://stackoverflow.com/questions/591892/tools-for-generating-mock-data

[*Back to top*](#header07)


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
 - [SQL Sentry Free eBooks](https://www.sqlsentry.com/sql-server-books)
 - [Microsoft Cloud Security for Enterprise Architects (PDF)](http://download.microsoft.com/download/6/d/f/6dfd7614-bbcf-4572-a871-e446b8cf5d79/msft_cloud_architecture_security.pdf)
 - [Brent Ozar SQL Server Setup Checklist eBook](http://u.brentozar.com/eBook_SQL_Server_Setup_Checklist.pdf)
 - [Introducing Microsoft SQL Server 2016](https://info.microsoft.com/Introducing-SQL-Server-2016-eBook.html)
 - [Giving away millions of free Microsoft Ebooks](https://blogs.msdn.microsoft.com/mssmallbiz/2016/07/10/free-thats-right-im-giving-away-millions-of-free-microsoft-ebooks-again-including-windows-10-office-365-office-2016-power-bi-azure-windows-8-1-office-2013-sharepoint-2016-sha/) (by Eric Ligman)
 - [Free Phil Factor eBook: Confessions of an IT Manager](https://www.simple-talk.com/opinion/opinion-pieces/free-phil-factor-ebook-confessions-of-an-it-manager/) (by Phil Factor)
 - [Power BI from Rookie to Rock Star book](http://radacad.com/download-free-power-bi-book-pdf-format) (by Reza Rad)

R:
 - [FreeComputerBooks R EBooks](http://freecomputerbooks.com/langRBooks.html)
 - [Effective Graphs with Microsoft R Open](http://blog.revolutionanalytics.com/2016/05/e-book-effective-graphs.html)
 - [Little Book of R for Time Series](http://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/index.html) (by Avril Coghlan)
 - [Little Book of R for Biomedical Statistics](http://a-little-book-of-r-for-biomedical-statistics.readthedocs.io/en/latest/index.html) (by Avril Coghlan)
 - [Little Book of R for Multivariate Analysis](http://little-book-of-r-for-multivariate-analysis.readthedocs.io/en/latest/index.html) (by Avril Coghlan)
 - [Text Mining with R](http://tidytextmining.com/) (by Julia Silge and David Robinson)
 - [An Introduction to Statistical Learning with Applications in R](http://www-bcf.usc.edu/~gareth/ISL/) (by Gareth James, Daniela Witten, Trevor Hastie and Robert Tibshirani)

[*Back to top*](#header08)


## License
[MIT](/LICENSE.md)

If some procedures or scripts are restricted due to **ELUA** (or we can not find original author), please email or add issue - we remove/update it immediately.
Thanks for understanding and patience.

<a name="header09"></a>
