DECLARE @HkeyLocal nvarchar(18) = N'HKEY_LOCAL_MACHINE';
DECLARE @MSSqlServerRegPath nvarchar(31) = N'SOFTWARE\Microsoft\MSSQLServer';
DECLARE @InstanceRegPath sysname = @MSSqlServerRegPath + N'\MSSQLServer';

DECLARE @BackupDirectory nvarchar(512)
if 1=isnull(cast(SERVERPROPERTY('IsLocalDB') as bit), 0)
SET @BackupDirectory=cast(SERVERPROPERTY('instancedefaultdatapath') as nvarchar(512))
else
EXEC master.dbo.xp_instance_regread @HkeyLocal, @InstanceRegPath, N'BackupDirectory', @BackupDirectory OUTPUT;

SELECT @BackupDirectory AS SQLServerBackupDirectory;
