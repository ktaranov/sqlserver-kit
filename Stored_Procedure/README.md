# Microsoft SQL Server Stored Procedure
Start all procedure from if exist statement:
```sql
IF OBJECT_ID('dbo.ProcedureName', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.ProcedureName AS SELECT 1');
GO
ALTER PROCEDURE dbo.usp_ProcedureName...
```
It helps to save all grants for procedure (analog `CREATE OR REPLACE PROCEDURE` in [Oracle](http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm 'Offical Oracle Documentation')).


## [sp_IndexAnalysis-v11](sp_IndexAnalysis-v11.sql)
Author: Jason Strate<br/>
Original link: <http://www.jasonstrate.com/2013/05/index-analysis-may-update/><br/>
Tested on SQL Server version: 2012/2014


## [sp_SrvPermissions](sp_SrvPermissions.sql)
Author: Kenneth Fisher<br/>
Original link: http://sqlstudies.com/free-scripts/sp_srvpermissions/<br/>
Tested on SQL Server version: 2012


## [sp_capture_login_auth](sp_capture_login_auth.sql)
Author: Unknown<br/>
Original link: Unknown<br/>
Tested on SQL Server version: 2012/2014


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
Original link: <http://www.sqlservercentral.com/scripts/object/66798/><br/>
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
Author: Sean Smith<br/>
Original link: <http://www.sqlservercentral.com/scripts/Administration/70243/><br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_SearchOnAllDB](usp_SearchOnAllDB.sql)
Author: David Musgrave<br/>
Original link: None<br/>
Tested on SQL Server version: 2008/2012/2014


## [usp_String_Search](usp_String_Search.sql)
Author: Sean Smith<br/>
Original link: None<br/>
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
Author: Sean Smith<br/>
Original link: <http://wwwservercentral.com/scripts/sp_who/68607/><br/>
Tested on SQL Server version: 2012/2014
