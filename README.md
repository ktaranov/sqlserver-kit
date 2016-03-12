# SQL Server KIT
Useful links, scripts, tools and best practice for Microsoft SQL Server Database

Headers:
 - [Repo folders and files](#repo-folders-and-files)
 - [SQL Server Web Resources](#sql-server-web-resources)
 - [SQL Server Express direct download links](#sql-server-express-direct-download-links)
 - [Microsoft Adventure Works Sample Databases download links](#microsoft-adventure-works-sample-databases-download-links)
 - [Microsoft Transact-SQL Hints](#microsoft-transact-sql-hints)
 - [PowerShell and SQL Server](#powershell-and-sql-server)
 - [TSQL format code](#tsql-format-code)
 - [Free SQL Server ebooks](#free-sql-server-ebooks)
 - [License](#license)


## Repo folders and files
 - [SQL Server Data Types](/SQL Server Data Types.md)
 - [SQL Server Name Convention and T-SQL Programming Style](/SQL Server Name Convention and T-SQL Programming Style.md)
 - [SQL Server Edition](/SQL Server Edition.md)
 - [SQL Server People](/SQL Server People.md 'Most Valuable SQL Server professionals')
 - [SQL Server Trace Flag](/SQL Server Trace Flag.md 'Complete list from many resources - 300 Trace Flags') (Complete list - 300 trace flags)
 - [SQL Server Version](/SQL Server Version.md 'List of all version Microsoft SQL Sever') (Complete list - from SQL Server 1.0 to SQL Server 2016)
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
 - [SSMS addons](/SSMS_addons)
    - [SSMSBoost add-in](/SSMS_addons#ssmsboost 'Adds missing features and improves your productivity')
    - [SQL Code Guard](/SSMS_addons#sql-code-guard 'Provides fast and comprehensive static analysis for T-Sql code, shows code complexity and objects dependencies')
    - [SQL Search](/SSMS_addons#sql-search 'Free add-in from Red Gate that lets you quickly search for SQL across your databases')
    - [SQL Scripts Manager](/SSMS_addons#sql-scripts-manager 'Powerful and reliable scripts written by SQL Server experts')
    - [Supratimas](/SSMS_addons#supratimas 'SQL Server query execution visualizer')
    - [dbForge SQL Complete](/SSMS_addons#dbforge-sql-complete)
    - [SSMS Tools Pack](/SSMS_addons#ssms-tools-pack)
    - [SQL Pretty Printer](/SSMS_addons#sql-pretty-printer)
    - [SQL Sentry Plan Explorer](/SSMS_addons#sql-sentry-plan-explorer)
    - [TSQL Code Smells Finder](/SSMS_addons#tsql-code-smells-finder)
    - [SQLTreeo](/SSMS_addons#sqltreeo)
    - [ApexSQL Complete](/SSMS_addons#apexsql-complete)
    - [ApexSQL Refactor](/SSMS_addons#apexsql-refactor)
    - [ApexSQL Search](/SSMS_addons#apexsql-search)
    - [Spotlight Developer](/SSMS_addons#spotlight-developer)
    - [dbForge Source Control](/SSMS_addons#dbforge-source-control)
    - [dbForge Unit Test](/SSMS_addons#dbforge-unit-test)
    - [dbForge Data Pump](/SSMS_addons#dbforge-data-pump)
    - [dbForge Index Manager](/SSMS_addons#dbforge-index-manager)
    - [dbForge Object Search](/SSMS_addons#dbforge-object-search)
 - [Useful scripts](/Scripts)
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
 - [SSMS snippets](/Snippets)
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
 - [Utilities](/Utilities)
    - [GraphView](/Utilities#graphview) (Microsoft)
    - [tablediff Utility](/Utilities#tablediff-utility) (Microsoft)
    - [Microsoft Log Parser](/Utilities#microsoft-log-parser) (Microsoft)
    - [Diskspd](/Utilities#diskspd) (Microsoft)
    - [HammerDB](/Utilities#hammerdb) (Open Source)
    - [dta Utility](/Utilities#dta-utility) (Microsoft)
    - [osql Utility](/Utilities#osql-utility) (Microsoft)
    - [sqldiag Utility](/Utilities#sqldiag-utility) (Microsoft)
    - [sqldumper Utility](/Utilities#sqldumper-utility) (Microsoft)
    - [SqlLocalDB Utility](/Utilities#sqllocaldb-utility) (Microsoft)
    - [sqllogship Utility](/Utilities#sqllogship-utility) (Microsoft)
    - [sqlservr Application](/Utilities#sqlservr-application) (Microsoft)
    - [sqlps Utility](/Utilities#sqlps-utility) (Microsoft)
    - [sqlmaint Utility](/Utilities#sqlmaint-utility) (Microsoft)
    - [Ssms Utility](/Utilities#ssms-utility) (Microsoft)
    - [dtexec Utility](/Utilities#dtexec-utility) (Microsoft)
    - [SQL Server 2000 Best Practices Analyzer](/Utilities#bpa-2000) (Microsoft)
    - [SQL Server 2005 Best Practices Analyzer](/Utilities#bpa-2005) (Microsoft)
    - [SQL Server 2008 R2 Best Practices Analyzer](/Utilities#bpa-2008) (Microsoft)
    - [SQL Server 2012 Best Practices Analyzer](/Utilities#bpa-2012) (Microsoft)
    - [DLM Dashboard](/Utilities#dlm-dashboard) (Red Gate)
    - [SQL DBA Bundle](/Utilities#sql-dba-bundle) (Red Gate)
    - [ReadyRoll](/Utilities#readyroll) (Red Gate)
    - [SQL XEvent Profiler](/Utilities#sql-xevent-profiler) (Idera)
    - [SQL Check](/Utilities#sql-check) (Idera)
    - [SQL Fragmentation Analyzer](/Utilities#sql-fragmentation-analyzer) (Idera)
    - [SQL Heat Map](/Utilities#sql-heat-map) (Idera)
    - [SQL Hekaton Memory Check](/Utilities#sql-hekaton-memory-check) (Idera)
    - [SQL Page Viewer](/Utilities#sql-page-viewer) (Idera)
    - [SQL Update Statistics](/Utilities#sql-update-statistics) (Idera)
    - [SQL Statistics Aggregator](/Utilities#sql-statistics-aggregator) (Idera)
    - [SQL Backup Status Reporter](/Utilities#sql-backup-status-reporter) (Idera)
    - [SQL Integrity Check](/Utilities#sql-integrity-check) (Idera)
    - [SQL Job Manager](/Utilities#sql-job-manager) (Idera)
    - [Azure SQL Database Backup](/Utilities#azure-sql-database-backup) (Idera)
    - [SQL Column Search](/Utilities#sql-column-search) (Idera)
    - [SQL Permissions Extractor](/Utilities#sql-permissions-extractor) (Idera)
    - [dbForge Schema Compare](/Utilities#dbforge-schema-compare) (Devart)
    - [dbForge Data Compare](/Utilities#dbforge-data-compare) (Devart)
    - [dbForge Data Generator](/Utilities#dbforge-data-generator) (Devart)
    - [dbForge Query Builder](/Utilities#dbforge-query-builder) (Devart)
    - [dbForge Event Profiler](/Utilities#dbforge-event-profiler) (Devart)
    - [dbForge SQL Decryptor](/Utilities#dbforge-SQL-decryptor) (Devart)
    - [Minion Enterprise](/Utilities#minion-enterprise) (MinionWare)


## SQL Server Web Resources
 - Blogs
    - [SQL Central Blog Scripts](http://www.sqlservercentral.com/Scripts/)
    - [SQL Central Blog Articles](http://www.sqlservercentral.com/Articles/)
    - [SQL Central Blog Stairways](http://www.sqlservercentral.com/stairway/)
    - [MSSQLTips](https://www.mssqltips.com/get-free-sql-server-tips/)
    - Awesome [BRENT OZAR](https://www.brentozar.com/) scripts, videos and articles
    - [Glenn Berry's SQL Server Performance](http://sqlserverperformance.wordpress.com/)
    - [Kenneth Fisher SQLStudies Blog](http://sqlstudies.com/)
    - [Best SQL Server Perfomance Blog](http://sqlperformance.com/)
    - Best backup and index maintenance solution [Ola Maintenance Solution](https://ola.hallengren.com/)
    - [Weblogs SQLTeam Blogs](http://weblogs.sqlteam.com/)
    - [SQLMag](http://sqlmag.com/)
 - Free Videos
   - [IDERA Resource Center](https://www.idera.com/resourcecentral)
   - [MSSQLTips SQL Server Webcasts and Videos](https://www.mssqltips.com/sql-server-webcasts/)
   - [SQL Server Videos](http://www.sqlservervideos.com/)
   - [TECHNET How do I Videos](https://technet.microsoft.com/en-us/library/dd353197.aspx)
   - [Veeam Learn Microsoft SQL Server](http://go.veeam.com/learn-microsoft-sql-server-free-video-tutorial-course.html)
 - Free Database Podcasts
   - [SQL Server Radio](http://www.sqlserverradio.com/)
   - [SQL Data Partners](http://sqldatapartners.com/podcast/)
   - [Away from the Keyboard](http://awayfromthekeyboard.com/)
 - Courses
   - [MVA SQL Server Courses](https://mva.microsoft.com/product-training/sql-server)
 - Other
    - [SQL Server Management Studio](https://msdn.microsoft.com/en-us/library/mt238290.aspx) installation download link
    - [SQL# CLR functions](http://www.sqlsharp.com/) (by Sql Quantum Leap)
    - [SSIS Performance Benchmarks](http://ssisperformance.com/)
    - [Statistic Parser](https://github.com/Jorriss/StatisticsParser) (by Richie Rump)
    - [SQL Generator](https://github.com/Jorriss/sqlgenerator) (by Richie Rump)
    - [Columnstore Indexes Scripts Library](https://github.com/NikoNeugebauer/CISL) (by Niko Neugebauer)
    - [Stackoverflow SQL Server](http://stackoverflow.com/questions/tagged/sql-server)
    - [DBA Stackexchange SQL Server](http://dba.stackexchange.com/questions/tagged/sql-server)


## SQL Server Express direct download links
Original post written by Scott Hanselman: http://www.hanselman.com/blog/DownloadSQLServerExpress.aspx<br />
Official Microsoft SQL Server Express page: https://www.microsoft.com/en-us/server-cloud/products/sql-server-editions/sql-server-express.aspx


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
 - [Microsoft SQL Server Community Projects & Samples](http://sqlserversamples.codeplex.com/)
 - [Adventure Works Sample Databases and Scripts for SQL Server 2016 CTP3](http://www.microsoft.com/en-us/download/details.aspx?id=49502)
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
 - [SQL Server Health Check Script with Powershell](http://www.codeproject.com/Tips/848661/SQL-Server-Health-Check-Script-with-Powershell) (by Atul_Kapoor)
 - [Universal SQL Server Installation Scripts](https://github.com/ktaranov/Universal-SQL-Installation-Scripts) (by Prakash Heda)
 - [Powershell SQL Server Performance Health Check ](https://github.com/SpeedySQL/HealthCheck) (by Omid Afzalalghom)
 - [Performance Analysis of Logs (PAL) Tool](http://pal.codeplex.com/) (by svenhau and mikelag)
 - [PSCI - Powershell Continuous Integration](https://github.com/ObjectivityBSS/PSCI) (by Objectivity Bespoke Software Specialists)
 - [SQLTranscriptase - SQL Server Documentation in Powershell](https://github.com/vijaybandi/SQLTranscriptase) (by Vijay Bandi)


## TSQL format code
 - http://sqlinform.com/
 - http://www.dpriver.com/pp/sqlformat.htm
 - http://stackoverflow.com/questions/401928/sql-formatter-for-sql-management-studio
 - http://www.apexsql.com/sql_tools_refactor.aspx
 - http://poorsql.com/
 - http://www.architectshack.com/PoorMansTSqlFormatter.ashx
 - http://www.ssmstoolspack.com/
 - http://www.devart.com/dbforge/sql/sqlcomplete/
 - http://www.sql-format.com/


## Free SQL Server ebooks
 - [Avesome Red Gate ebooks](http://www.red-gate.com/community/books/)
 - [Microsoft huge collection](https://blogs.msdn.microsoft.com/mssmallbiz/2013/06/18/huge-collection-of-free-microsoft-ebooks-for-you-including-office-office-365-sharepoint-sql-server-system-center-visual-studio-web-development-windows-windows-azure-and-windows-server/)
 - [Microsoft large collection](https://blogs.msdn.microsoft.com/mssmallbiz/2012/07/27/large-collection-of-free-microsoft-ebooks-for-you-including-sharepoint-visual-studio-windows-phone-windows-8-office-365-office-2010-sql-server-2012-azure-and-more/)
 - [Microsoft MVA Free ebooks](https://mva.microsoft.com/ebooks)
 - [OnlineVideoLectures ebooks](http://onlinevideolecture.com/ebooks/?subject=SQL-Server)
 - [Brent Ozar ebooks](http://www.brentozar.com/first-aid/free-database-books-pdfs-download/)
 - [E-books Directory](http://www.e-booksdirectory.com/listing.php?category=569)
 - [TOAD SQL Server ebooks](https://www.toadworld.com/platforms/sql-server/b/weblog/archive/2013/06/21/huge-collection-of-free-microsoft-sql-server-ebooks)
 - [Syncfusion Techportal](http://syncfusion.com/resources/techportal)


## License
[MIT](/LICENSE.md)

If some procedures or scripts are restricted due to **ELUA** (or we can't find original author), please email or add issue - we remove/update it immediately. Thanks for understanding and patience.
