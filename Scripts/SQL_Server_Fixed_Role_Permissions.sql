--SQL Server Fixed Role Permissions
--Author: Jason Brimhall
--In this script, I have taken the results from each of the stored procedures and dumped them into a temp table.
--Using this temp table, I can now join to this table to get a more complete list of the permissions in effect for various principals.

CREATE TABLE #role_permission
	(
		DBFixedRole VARCHAR(128)
		, Permission VARCHAR(128)
	)
INSERT INTO #role_permission
		( DBFixedRole, Permission )
		EXECUTE sp_dbfixedrolepermission
GO
 
INSERT INTO #role_permission
		( DBFixedRole, Permission )
		EXECUTE sp_srvrolepermission
GO
 
SELECT *
	FROM #role_permission r;
 
DROP TABLE #role_permission;