# Microsoft SQL Server Stored Procedure
[SQL Server Name Convention and T-SQL Programming Style](https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Name%20Convention%20and%20T-SQL%20Programming%20Style.md)

Start all procedure from if exist statement:
```sql
IF OBJECT_ID('dbo.ProcedureName', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.ProcedureName AS SELECT 1');
GO


ALTER PROCEDURE dbo.usp_ProcedureName(
```
It helps to save all grants for procedure (analog `CREATE OR REPLACE PROCEDURE` in [Oracle](http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm 'Offical Oracle Documentation')).


## [sp_IndexAnalysis-v11](sp_IndexAnalysis-v11.sql)
Author: Jason Strate<br/>
Original link: http://www.jasonstrate.com/2013/05/index-analysis-may-update/<br/>
Tested on SQL Server version: 2012/2014


## [sp_RestoreGene](sp_RestoreGene.sql)
Author: Andy Yun<br/>
Original link: https://sqlbek.wordpress.com/2015/03/04/sp_helpexpandview-well-i-didnt-expect-that/<br/>
Tested on SQL Server version: 2008/2012/2014


## [sp_RestoreGene](sp_RestoreGene.sql)
Author: Paul Brewer<br/>
Original link: https://paulbrewer.wordpress.com/sp_restoregene/<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_GetUntrustedForeignKeys](usp_GetUntrustedForeignKeys.sql)
Author: Jefferson Elias<br/>
Original link: http://www.sqlshack.com/managing-untrusted-foreign-keys/<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_RunCheckAllUntrustedForeignKeys](usp_RunCheckAllUntrustedForeignKeys.sql)
Author: Jefferson Elias<br/>
Original link: http://www.sqlshack.com/managing-untrusted-foreign-keys/<br/>
Tested on SQL Server version: 2008/2012/2014


## [sp_capture_login_auth](sp_capture_login_auth.sql)
Author: Unknown<br/>
Original link: Unknown<br/>
Tested on SQL Server version: 2012/2014


## [sp_Blocked_Process_Report_Viewer](sp_blocked_process_report_viewer.sql)
Author: Michael J. Swart<br/>
Original link: https://sqlblockedprocesses.codeplex.com/<br/>
Tested on SQL Server version: 2012/2014


## [sp_sqltrace](sp_sqltrace.sql)
Author:  Erland Sommarskog<br/>
Original link: http://www.sommarskog.se/sqlutil/sqltrace.html<br/>
Tested on SQL Server version: 2005/2008/2012/2014


## [usp_BulkUpload](usp_BulkUpload.sql)
Author: Konstantin Taranov<br/>
Original link: None<br/>
Tested on SQL Server version: 2012/2014


## [usp_EnableAndAddFileStreamForDatabase](usp_EnableAndAddFileStreamForDatabase.sql)
Author: Unknown<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012


## [usp_FindDbObjects](usp_FindDbObjects)
Author: Unknown<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_LogError](usp_LogError.sql)
Author: Unknown<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_Object_Search](usp_Object_Search.sql)
Author: Sean Smith<br/>
Original link: http://www.sqlservercentral.com/scripts/object/66798/<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_PrintDebug](usp_PrintDebug.sql)
Author: Unknown<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_PrintError](usp_PrintError.sql)
Author: Microsoft<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_RandomWait](usp_RandomWait.sql)
Author: Unknown<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_SQL_Server_System_Report](usp_SQL_Server_System_Report.sql)
Author: Sean Smith<br />
Original link: <http://www.sqlservercentral.com/scripts/Administration/70243/><br />
Tested on SQL Server version: 2008/2012/2014


## [usp_SearchOnAllDB](usp_SearchOnAllDB.sql)
Author: David Musgrave<br />
Original link: None<br />
Tested on SQL Server version: 2008/2012/2014


## [usp_String_Search](usp_String_Search.sql)
Author: Sean Smith<br />
Original link: None<br />
Tested on SQL Server version: 2008/2012/2014


## [usp_TableUnpivot](usp_TableUnpivot.sql)
Author: Konstantin Taranov<br/>
Original link: None<br/>
Tested on SQL Server version: 2012/2014


## [usp_UnusedInputParameters](usp_UnusedInputParameters.sql)
Author: Sean Smith<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_bcpTableUnload](usp_bcpTableUnload.sql)
Author: Konstantin Taranov<br/>
Original link: None<br/>
Tested on SQL Server version: 2012/2014


## [usp_bcpTableUnloadBatchMode](usp_bcpTableUnloadBatchMode.sql)
Author: Konstantin Taranov<br/>
Original link: None<br/>
Tested on SQL Server version: 2012/2014


## [usp_bcpUnloadSelect](usp_bcpUnloadSelect.sql)
Author: Konstantin Taranov<br/>
Original link: None<br/>
Tested on SQL Server version: 2012/2014


## [usp_who5](usp_who5.sql)
Author: Sean Smith<br />
Original link: http://wwwservercentral.com/scripts/sp_who/68607/<br />
Tested on SQL Server version: 2012/2014


## [usp_PrintString](usp_PrintString.sql)
Author: John Huang<br />
Original link: http://www.sqlservercentral.com/blogs/john-huangs-blog/2015/11/19/print-long-string/<br />
Tested on SQL Server version: 2014


## [usp_Generate_Merge](usp_Generate_Merge.sql)
Author: Narayana Vyas Kondreddi<br/>
Original link: https://github.com/SQLauto/generate-sql-merge/blob/master/master.dbo.sp_generate_merge.sql<br />
Tested on SQL Server version: 2008/2012/2014


## [usp_Generate_Merge](usp_SSIS_ScriptEnvironment.sql)
Author: Jeff Jordan<br/>
Original link: http://www.sqlservercentral.com/articles/Integration+Services+%28SSIS%29/135173/<br />
Tested on SQL Server version: 2012/2014


## [usp_SQLskillsAnalyzeLog](usp_SQLskillsAnalyzeLog.sql)
Author: Paul S. Randal<br/>
Original link: http://www.sqlskills.com/blogs/paul/code-to-analyze-the-transaction-hierarchy-in-the-log/<br />
Tested on SQL Server version: 2012/2014


## [usp_CreatePlantUMLCode](usp_CreatePlantUMLCode.sql)
Author: Phil Factor<br/>
Original link: https://www.simple-talk.com/sql/sql-tools/automatically-creating-uml-database-diagrams-for-sql-server/<br />
Tested on SQL Server version: 2012/2014
