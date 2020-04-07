/*
Trace Flag Demo: 8727
!!! Undocumented trace flag !!!
Function: Can be used to prevent unwanted index union plans.
SQL Server Version: ?
Information link: https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Trace%20Flag.md#8727
*/

USE StackOverflow2010;
GO

/* Execution Plan: https://www.brentozar.com/pastetheplan/?id=HkwhlQGwL */
/* Gets an index union plan normally */
SELECT *
FROM dbo.Users u
OUTER APPLY 
(
	SELECT *
	FROM dbo.Comments c
	WHERE 
		u.Id = c.UserId 
		OR u.Id = c.PostId
) c
WHERE u.DisplayName = 'alex';

/* No index union (seek on Users, multiple scans on Comments) */
SELECT *
FROM dbo.Users u
OUTER APPLY 
(
	SELECT *
	FROM dbo.Comments c
	WHERE 
		u.Id = c.UserId 
		OR u.Id = c.PostId
) c
WHERE u.DisplayName = 'alex'
OPTION (QUERYTRACEON 8727);
