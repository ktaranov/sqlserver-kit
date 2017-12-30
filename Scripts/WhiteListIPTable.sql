/*
Author: Patrick Keisler
Original link: http://www.patrickkeisler.com/2017/05/create-whitelist-for-sql-server-updated.html
*/

USE master;
GO

IF OBJECT_ID('dbo.WhiteList') IS NOT NULL
  DROP TABLE dbo.WhiteList;
GO

CREATE TABLE dbo.WhiteList
(
   Id INT IDENTITY(1,1) PRIMARY KEY
  ,LoginName VARCHAR(255)
  ,HostName VARCHAR(255)
  ,HostIpAddress VARCHAR(50)
  ,Comments VARCHAR(2000)
);
GO

GRANT SELECT ON dbo.WhiteList TO PUBLIC;
GO

INSERT dbo.WhiteList(LoginName,HostName,HostIpAddress,Comments)
VALUES
   ('*','ECHOBASE1','*','Any user from the workstation "ECHOBASE1" is allowed to connect, regardless of IP address.')
  ,('WebSiteLogin','webserver1','192.168.100.55','Only the WebSiteLogin from webserver1 with an IP of 192.168.100.55 is allowed access.');
GO

CREATE TRIGGER WhiteListTrigger
ON ALL SERVER FOR LOGON
AS
BEGIN
  DECLARE 
     @LoginName VARCHAR(255) = ORIGINAL_LOGIN()
    ,@HostName VARCHAR(255) = HOST_NAME()
    ,@HostIpAddress VARCHAR(50) = CONVERT(VARCHAR(50),CONNECTIONPROPERTY('client_net_address'));

  IF 
  (
    SELECT COUNT(*) FROM dbo.WhiteList
    WHERE 
    (
      (LoginName = @LoginName) OR (LoginName = '*')
    )
    AND
    (
      (HostName = @HostName) OR (HostName = '*')
    )
    AND
    (
      (HostIpAddress = @HostIpAddress) OR (HostIpAddress = '*')
    )
  ) = 0
  ROLLBACK;
END;
GO
