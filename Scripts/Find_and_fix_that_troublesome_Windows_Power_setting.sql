/*
<documentation>
  <summary>Fix troublesome Windows Power setting</summary>
  <returns>No.</returns>
  <issues>No</issues>
  <author>Jeff Iannucci</author>
  <created>2019-04-30</created>
  <modified></modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Jobs_Find_And_Replace_Text.sql</sourceLink>
  <originalLink>http://desertdba.com/find-and-fix-that-troublesome-windows-power-setting/</originalLink>
</documentation>
*/

SET NOCOUNT ON;


-- Collect current configuration settings

DECLARE
@isCmdShellEnabled bit
, @isShowAdvanced  bit
, @isGettinFixed   bit;

-- Do you want to Fix this? Then SET this to 1

SET @isGettinFixed = 0;

SELECT @isCmdShellEnabled = CAST(value AS BIT)

FROM sys.configurations

WHERE name = 'xp_cmdshell';

SELECT @isShowAdvanced = CAST(value AS BIT)

FROM sys.configurations

WHERE name = 'show advanced options';

IF(@isShowAdvanced = 0) BEGIN

EXEC sp_configure 'show advanced options', 1;

RECONFIGURE;

END;

IF(@isCmdShellEnabled = 0) BEGIN

EXEC sp_configure 'xp_cmdshell', 1;

RECONFIGURE;

END;

-- Run xp_cmdshell to get power settings

IF OBJECT_ID('tempdb..#Power') IS NOT NULL DROP TABLE #Power;

CREATE TABLE #Power (PowerScheme varchar(1000));

INSERT #Power (PowerScheme)

EXEC xp_cmdshell 'powercfg /list';

SELECT PowerScheme FROM #Power WHERE RIGHT(LTRIM(RTRIM(PowerScheme)),1) = '*';

-- Set to High Performance

IF @isGettinFixed = 1 BEGIN

EXEC xp_cmdshell 'powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c';

END;

-- If necessary, turn off 'xp_cmdshell'

IF(@isCmdShellEnabled = 0) BEGIN

EXEC sp_configure 'xp_cmdshell', 0;

RECONFIGURE;

END;

-- If necessary, turn off 'show advanced options'

IF(@isShowAdvanced = 0) BEGIN

EXEC sp_configure 'show advanced options', 0;

RECONFIGURE;

END;
