/*
<documentation>
  <summary>Get Amazon RDS Instance Size using TSQL</summary>
  <returns>1 data set: InstanceSize.</returns>
  <issues>No</issues>
  <author>Mitch Wheat</author>
  <created>2008-07-27</created>
  <modified>2019-07-02 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Amazon_RDS_Instance_Size.sql</sourceLink>
  <originalLink>https://mitchwheat.com/2019/07/27/amazon-rds-sql-server-get-instance-size-using-tsql/</originalLink>
</documentation>
*/

IF OBJECT_ID('tempdb..#AmazonErrorLog') IS NOT NULL
    DROP TABLE #AmazonErrorLog;

CREATE TABLE #AmazonErrorLog
(
    LogDate datetime2,
    ProcessInfo nvarchar(20),
    [Text] nvarchar(1000)
);

DECLARE @pattern nvarchar(30) = N'System Model:';

INSERT INTO #AmazonErrorLog
EXEC rdsadmin.dbo.rds_read_error_log;

IF @@ROWCOUNT > 0
BEGIN
    SELECT InstanceSize = REPLACE(CAST(SUBSTRING([Text], LEN(@pattern) + 1 + PATINDEX (N'%' + @pattern + N'%', [Text]), 100), '''', '') AS varchar(100))
    FROM #AmazonErrorLog
    WHERE PATINDEX (N'%' + @pattern + N'%', [Text]) > 0 
END;

DROP TABLE #AmazonErrorLog;
