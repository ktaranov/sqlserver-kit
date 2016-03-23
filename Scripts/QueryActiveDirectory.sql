/*
Author: Ryan Adams
Original link: http://www.ryanjadams.com/2016/03/query-active-directory-sql-server/
*/

--There are 2 ways to query AD from SQL Server.&amp;nbsp; The first is using OPENROWSET and the second is using OPENQUERY which requires a linked server.

/*** OPENROWSET METHOD ***/
--You have to enable Ad Hoc Distributed Queries to use OPENROWSET.&amp;nbsp; Note the OPENQUERY does NOT require this to be enabled since it uses Linked servers.

sp_configure 'show advanced options', 1;
RECONFIGURE;
GO
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO
sp_configure 'show advanced options', 0;
RECONFIGURE;
GO

SELECT DisplayName
FROM OPENROWSET('ADSDSOOBJECT','adsdatasource','SELECT displayName
FROM ''LDAP://mydomainFQDN.com/ou=mySubOU,ou=myTopOU,dc=mychilddomain,dc=myTLdomain,dc=com''
WHERE objectClass =&amp;nbsp;''User'' ')

/*** OPENQUERY METHOD ***/
--Here is where we create our Linked Server connection to AD
EXEC master.dbo.sp_addlinkedserver @server = N'AD', @srvproduct=N'Active Directory Services Interface', @provider=N'ADsDSOObject', @datasrc=N'adsdatasource'
GO

EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'AD', @locallogin = NULL , @useself = N'True'
GO

--Here is the query using the above created Linked server
SELECT displayName FROM OpenQuery (AD,
'SELECT displayName
FROM ''LDAP://mydomainFQDN.com/ou=mySubOU,ou=myTopOU,dc=mychilddomain,dc=myTLdomain,dc=com''
WHERE objectClass =&amp;nbsp;''User'' ')
GO

--Here we delete our Linked Server
EXEC master.dbo.sp_dropserver @server=N'AD', @droplogins='droplogins'
GO
