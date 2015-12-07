# SQL Server KIT
Useful links, scripts, tools and best practice for Microsoft SQL Server Database

Headers:
 - [Repo folders and files](#repo-folders-and-files)
 - [Web resource](#web-resource)
 - [SQL Server Express direct download links](#sql-server-express-direct-download-links)
 - [Microsoft Adventure Works Sample Databases download links](#microsoft-adventure-works-sample-databases-download-links)
 - [PowerShell and SQL Server](#powershell-and-sql-server)
 - [TSQL format code](#tsql-format-code)
 - [Free SQL Server ebooks](#free-sql-server-ebooks)


## Repo folders and files
 - [SQL Server Trace Flag](/SQL Server Trace Flag.md 'Complete list from many resources - 162 Trace Flags') (Complete list - 162 trace flags)
 - [SQL Server Version](/SQL Server Version.md 'List of all version Microsoft SQL Sever') (Complete list - from SQL Server 1.0 to SQL Server 2016)
 - [Base line Collector script](/BaselineCollector) (by Robert Virag)
 - [CLR procedures](/CLR)
    - [SQL#](/CLR/SQLsharp_SETUP.sql) free - QUICKEST and EASIEST way to extending the power of T-SQL with C#
    - SplitterB_CLR
 - [Known Errors](/Errors)
 - [Ola Maintenance Solution](/Ola_Maintenance_Solution) (by Ola Hallengren)
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
 - [Useful scripts](/Scripts)
    - **Awesome SQL Server Diagnostic Information Queries** (by Glenn Alan Berry)
    - [Table count alternative](/Scripts/Table Count alternative.sql) (by Jes Schultz Borland)
    - [Foreign Key batch rename](/Scripts/FK Rename.sql) (by Wes Henriksen)
    - [Count character matches](/Scripts/Count character matches.sql)
    - and many others...
 - [SSMS snippets](/Snippets)
 - [Stored Procedure](/Stored_Procedure)
   - [sp_DBPermissions](/Stored_Procedure/sp_DBPermissions.sql) (by Kenneth Fisher)
   - [sp_SrvPermissions](/Stored_Procedure/sp_SrvPermissions.sql) (by Kenneth Fisher)
   - [usp_who5](/Stored_Procedure/usp_who5.sql) (by Sean Smith)
   - [usp_String_Search](/Stored_Procedure/usp_String_Search.sql) (by Sean Smith)
   - [usp_BulkUpload](/Stored_Procedure/usp_BulkUpload.sql)
   - [usp_TableUnpivot](/Stored_Procedure/ usp_TableUnpivot.sql)
   - and many others...
 - [User Defined Function](/User_Defined_Function)
 - [dbWarden - A Free SQL Server Monitoring Package](/dbWarden) (by Stevie Rounds and Michael Rounds)


## Web resource
 - [SQL Central blog Scripts]
 - [SQL Central blog Articles]
 - **Awesome [BRENT OZAR] scripts and articles**
 - [Glenn Berry's SQL Server Performance]
 - Best backup and index maintenance solution [Ola Hallengren]
 - [SQL Server Management Studio] installation download link
 - [SQL# CLR functions](http://www.sqlsharp.com/)


## SQL Server Express direct download links
Original post written by Scott Hanselman: <http://www.hanselman.com/blog/DownloadSQLServerExpress.aspx><br />
Official Microsoft SQL Server Express page: <https://www.microsoft.com/en-us/server-cloud/products/sql-server-editions/sql-server-express.aspx>


### [Download SQL Server 2014 Express](http://www.microsoft.com/en-us/download/details.aspx?id=42299)
-   You likely just want SQL Server 2014 Express with Tools. This
    download includes SQL Management Studio.
    -   [SQL Server 2014 Express x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2064BIT/SQLEXPRWT_x64_ENU.exe)
    -   [SQL Server 2014 Express x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAndTools%2032BIT/SQLEXPRWT_x86_ENU.exe)
-   Here's just SQL Server 2014 Management Studio
    -   [SQL Management Studio x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2064BIT/SQLManagementStudio_x64_ENU.exe)
    -   [SQL Management Studio x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/MgmtStudio%2032BIT/SQLManagementStudio_x86_ENU.exe)
-   SQL Server 2014 Express with Advanced Services
    -   [Advanced Services x64](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2064BIT/SQLEXPRADV_x64_ENU.exe)
    -   [Advanced Services x86](http://download.microsoft.com/download/E/A/E/EAE6F7FC-767A-4038-A954-49B8B05D04EB/ExpressAdv%2032BIT/SQLEXPRADV_x86_ENU.exe)

### [Download SQL Server 2012 Express](http://www.microsoft.com/en-us/download/details.aspx?id=29062)
-   You likely just want SQL Server 2012 Express with Tools. This
    download includes SQL Management Studio.
    -   [SQL Server 2012 Express x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLEXPRWT_x64_ENU.exe)
-   Here's just SQL Server 2012 Management Studio
    -   [SQL Management Studio x64](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x64/SQLManagementStudio_x64_ENU.exe)
    -   [SQL Management Studio
        x86](http://download.microsoft.com/download/8/D/D/8DD7BDBA-CEF7-4D8E-8C16-D9F69527F909/ENU/x86/SQLManagementStudio_x86_ENU.exe)

### [Download SQL Server 2008 Express R2 SP2](http://www.microsoft.com/en-us/download/details.aspx?id=30438)
-   You likely just want SQL Server 2008 Express with Tools. This
    download includes SQL Management Studio.
    -   [SQL Server 2008 Express x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe)
    -   [SQL Server 2008 Express x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x86_ENU.exe)
-   Here's just SQL Server 2008 Management Studio
    -   [SQL Management Studio x64](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x64_ENU.exe)
    -   [SQL Management Studio x86](http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLManagementStudio_x86_ENU.exe)

### [Download SQL Server 2005 Express](https://www.microsoft.com/en-us/download/details.aspx?id=21844)


## Microsoft Adventure Works Sample Databases download links
 - [Microsoft SQL Server Community Projects & Samples](http://sqlserversamples.codeplex.com/)
 - [Adventure Works Sample Databases and Scripts for SQL Server 2016 CTP3](http://www.microsoft.com/en-us/download/details.aspx?id=49502)
 - [Adventure Works 2014 Sample Databases](https://msftdbprodsamples.codeplex.com/releases/view/125550)
 - [Adventure Works 2012 Sample Databases](http://msftdbprodsamples.codeplex.com/releases/view/55330)
 - [Microsoft SQL Server 2008 R2 SR1 Sample Databases](https://sqlserversamples.codeplex.com/releases/view/72278)


## PowerShell and SQL Server
 - [SQL Server & Windows Documentation Using Windows PowerShell](https://sqlpowerdoc.codeplex.com/) (by Kendal Vandyke)
 - [TSQL Code Smells Finder](https://tsqlsmells.codeplex.com/) (by Dave Ballantyne)


## TSQL format code
 - http://www.dpriver.com/pp/sqlformat.htm
 - http://stackoverflow.com/questions/401928/sql-formatter-for-sql-management-studio
 - http://www.apexsql.com/sql_tools_refactor.aspx
 - http://poorsql.com/
 - http://www.architectshack.com/PoorMansTSqlFormatter.ashx
 - http://www.ssmstoolspack.com/
 - http://www.devart.com/dbforge/sql/sqlcomplete/


## Free SQL Server ebooks
 - http://www.red-gate.com/community/books/
 - http://www.red-gate.com/community/books/#sqldba
 - http://www.red-gate.com/community/books/accidental-dba
 - http://www.red-gate.com/products/dba/dba-bundle/


[SQL Central blog Scripts]:http://www.sqlservercentral.com/Scripts/
[SQL Central blog Articles]:http://www.sqlservercentral.com/Articles/
[BRENT OZAR]:http://www.brentozar.com/
[Glenn Berry's SQL Server Performance]:http://sqlserverperformance.wordpress.com/
[Ola Hallengren]:http://ola.hallengren.com/
[SQL Server Management Studio]:https://msdn.microsoft.com/en-us/library/mt238290.aspx
