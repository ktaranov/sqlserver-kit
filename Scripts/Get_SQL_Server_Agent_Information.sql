/*
Author: sqlity.net
Source link: http://sqlity.net/en/1868/identify-sql-server-service-account-in-t-sql/
*/

IF CAST(SERVERPROPERTY('ProductMajorVersion') AS INT) < 10
BEGIN
    DECLARE @sn NVARCHAR(128);
    EXEC master.dbo.xp_regread
        'HKEY_LOCAL_MACHINE',
        'SYSTEM\CurrentControlSet\services\SQLSERVERAGENT',
        'ObjectName', 
        @sn OUTPUT;
    SELECT @sn;
END;
ELSE
BEGIN
    SELECT DSS.servicename
         , DSS.startup_type_desc
         , DSS.status_desc
         , DSS.last_startup_time
         , DSS.service_account
         , DSS.is_clustered
         , DSS.cluster_nodename
         , DSS.filename
         , DSS.startup_type
         , DSS.status
         , DSS.process_id
      FROM sys.dm_server_services AS DSS;
END;
