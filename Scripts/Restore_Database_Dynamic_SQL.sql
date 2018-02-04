USE master;
GO

DECLARE @restoreStatement NVARCHAR(4000) = N'';
DECLARE @databaseName     SYSNAME        = N'AdventureWorks2014';
DECLARE @backupFilePath   NVARCHAR(2000) = N'G:\YaDisk\Backup\Distrib\SQL Server\Sample_Database\AdventureWorks\' + @databaseName + N'.bak';
DECLARE @serverPath       NVARCHAR(2000) = N'K:\MSSQL\MSSQL14.MSSQLSERVER\MSSQL\DATA\';
DECLARE @debug            BIT = 1;

SET @restoreStatement = N'
RESTORE DATABASE [@databaseName] FROM  DISK = N''@backupFilePath''
WITH  FILE = 1,  MOVE N''@databaseName_Data'' TO N''@serverPath@databaseName_Data.mdf'',
MOVE N''@databaseName_Log'' TO N''@serverPath@databaseName_Log.ldf'',  NOUNLOAD,  STATS = 5';
SET @restoreStatement = REPLACE(@restoreStatement, '@databaseName',   @databaseName);
SET @restoreStatement = REPLACE(@restoreStatement, '@backupFilePath', @backupFilePath);
SET @restoreStatement = REPLACE(@restoreStatement, '@serverPath',     @serverPath);

IF @debug = 1 PRINT(@restoreStatement)
ELSE
EXEC sp_executesql @restoreStatement;
GO
