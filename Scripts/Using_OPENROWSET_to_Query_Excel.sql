/*
https://www.mssqltips.com/sqlservertip/6178/read-excel-file-in-sql-server-with-openrowset-or-opendatasource/
*/

CREATE TABLE #Provider (
    ProviderName        varchar(100) NOT NULL
  , [ParseName]         varchar(100) NOT NULL
  , ProviderDescription varchar(100) NOT NULL
  );

INSERT INTO #Provider EXEC sys.sp_enum_oledb_providers;

IF NOT EXISTS (SELECT 1 FROM #Provider WHERE ProviderName LIKE 'Microsoft.ACE.OLEDB%')
PRINT('Please install Microsoft.ACE.OLEDB driver: 16 - https://www.microsoft.com/en-us/download/details.aspx?id=54920 or 12 - https://www.microsoft.com/en-US/download/details.aspx?id=13255');
ELSE PRINT('Microsoft.ACE.OLEDB is installed. Go next.');

IF (SELECT "value" FROM sys.configurations WHERE "name" = 'Ad Hoc Distributed Queries') <> 1
BEGIN
    EXEC sp_configure 'show advanced option', '1';
    RECONFIGURE;
    EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
    RECONFIGURE;
END;

EXEC master.[sys].[sp_MSset_oledb_prop] N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 0;

SELECT *
  FROM OPENROWSET(
      'Microsoft.ACE.OLEDB.16.0'
    , 'Excel 12.0;Database=g:\MSSQL17\Instagram_Statistics.xlsx'
    , 'SELECT * FROM [decoupagpro$]') AS op;
