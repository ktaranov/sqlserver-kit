/*
Author: Perry Whittle
Original link: http://sqlstudies.com/2013/03/01/script-to-clean-up-windows-logins-no-longer-in-ad/
*/

IF (OBJECT_ID(‘tempdb..#invalidlogins’) IS NOT NULL)
BEGIN
DROP TABLE #invalidlogins;
END

CREATE TABLE #invalidlogins(
  perr ACCTSID VARBINARY(85)
, NTLOGIN SYSNAME);

INSERT INTO #invalidlogins
EXEC sys.sp_validatelogins;

SELECT NTLOGIN FROM #invalidlogins
ORDER BY 1;
