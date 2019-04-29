/*
<documentation>
  <summary>When SQL Server Was Installed.</summary>
  <returns>Find in sys.server_principals oldest NT Service login.</returns>
  <issues>No</issues>
  <author>Rebecca Lewis</author>
  <created>2019-04-25</created>
  <modified>2019-04-30 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/When_SQL_Server_Was_Installed.sql</sourceLink>
</documentation>
*/


SELECT TOP(1)
       SERVERPROPERTY('ProductVersion') AS ProductVersion
     , SERVERPROPERTY('ProductLevel')   AS ProductLevel
     , SERVERPROPERTY('Edition')        AS Edition
     , SERVERPROPERTY('MachineName')    AS MachineName
     , create_date                      AS "SQL Server Installation Date"
     , name                             AS SystemUserName
FROM   sys.server_principals
WHERE  name LIKE 'NT Service%'
ORDER BY create_date;
