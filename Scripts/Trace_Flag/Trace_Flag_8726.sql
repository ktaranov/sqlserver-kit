/*
Trace Flag Demo: 8726
!!! Undocumented trace flag !!!
Function: Disables the heuristic that discourages the optimizer from producing an index union plan.
SQL Server Version: ?
Information link: https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Trace%20Flag.md#8726
*/

USE StackOverflow2010;
GO

/* Execution Plan: https://www.brentozar.com/pastetheplan/?id=B1mSzXGv8 */
/* No index union (seek on Users, multiple scans on Comments) */
SELECT *
FROM Users u
	LEFT JOIN Comments c
		ON u.Id = c.UserId 
		OR u.Id = c.PostId
WHERE u.DisplayName = 'alex';

/* Gets the index union plan */
SELECT *
FROM Users u
	LEFT JOIN Comments c
		ON u.Id = c.UserId 
		OR u.Id = c.PostId
WHERE u.DisplayName = 'alex'
OPTION (QUERYTRACEON 8726);
