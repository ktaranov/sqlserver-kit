/*
 ------- Uppercase All String Columns (and in a Single Query!) -------

Created By: Solomon Rutzky / Sql Quantum Leap
Created On: 2019-03-20
Updated On: n/a

Location:          https://pastebin.com/vbzz0LqN
Related blog post: https://sqlquantumleap.com/2019/03/20/uppercase-all-characters-and-in-a-single-query/
----------------------------------------------------------------------
*/


USE [tempdb];
SET NOCOUNT ON;


IF (OBJECT_ID(N'dbo.One''Column') IS NULL)
BEGIN
  CREATE TABLE dbo.[One'Column]
  (
    [One'ColumnID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_One'Column] PRIMARY KEY,
    [String] VARCHAR(100) COLLATE SQL_Latin1_General_CP1_CI_AS,
    [SomeDate] DATETIME
  );

  CREATE TABLE dbo.TwoColumns
  (
    [TwoColumnsID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_TwoColumns] PRIMARY KEY,
    [Stringy]]] NCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS,
    [SomeDate] DATETIME,
    [LOBy] TEXT COLLATE SQL_Latin1_General_CP1_CI_AS
  );

  CREATE TABLE dbo.NoColumns
  (
    [NoColumnsID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_NoColumns] PRIMARY KEY,
    [SomeDate] DATETIME,
    [SomeMoney] MONEY
  );

  CREATE TABLE dbo.[Another]]One'Column]
  (
    [Another]]One'ColumnID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_Another]]One'Column] PRIMARY KEY,
    [Stringy] CHAR(100) COLLATE Latin1_General_100_CI_AS,
    [SomeDate] DATETIME,

  );

  CREATE TABLE dbo.ThreeColumns
  (
    [ThreeColumnsID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_ThreeColumns] PRIMARY KEY,
    ['FarCar] VARCHAR(100) COLLATE Latin1_General_CI_AS,
    [SomeDate] DATETIME,
	[InTharKahr] NVARCHAR(50) COLLATE Latin1_General_100_CI_AS,
    [💣EnTexxed💥] NTEXT COLLATE Latin1_General_CI_AS
  );

  CREATE TABLE dbo.[Yet🙀Another]]One'Column]
  (
    [Yet🙀Another]]One'ColumnID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_Yet🙀Another]]One'Column] PRIMARY KEY,
    [Stringy] NVARCHAR(50) COLLATE Syriac_90_CI_AS_SC,
    [SomeDate] DATETIME,

  );

  CREATE TABLE dbo.[DatabaseCollation]
  (
    [DatabaseCollationID] INT NOT NULL IDENTITY(1, 1)
      CONSTRAINT [PK_DatabaseCollation] PRIMARY KEY,
    [VarChar] VARCHAR(100),
    [NVarChar] NVARCHAR(50),
    [SomeDate] DATETIME,

  );


  DECLARE @TestValue NVARCHAR(100) = NCHAR(0xE0) + NCHAR(0xE1) + NCHAR(0xE2) + NCHAR(0xE3) + NCHAR(0xE4) +
                       NCHAR(0xE4) + NCHAR(0xE5) + NCHAR(0xE6) + NCHAR(0xE7) + NCHAR(0xE8) + NCHAR(0xE9) +
                       NCHAR(0xEA) + NCHAR(0xEB) + NCHAR(0xEC) + NCHAR(0xED) + NCHAR(0xEE) + NCHAR(0xEF) +
                       NCHAR(0xF1) + NCHAR(0xF2) + NCHAR(0xF3) + NCHAR(0xF4) + NCHAR(0xF5) + NCHAR(0xF6) +
                       NCHAR(0xF8) + NCHAR(0xF9) + NCHAR(0xFA) + NCHAR(0xFB) + NCHAR(0xFC) + NCHAR(0xFD) +
                       NCHAR(0xFE) + N' ' + NCHAR(0x01F9) + N' ' + NCHAR(0x0219) + N' ' + NCHAR(0x03E1) +
                       N' ' + NCHAR(0x1F90); 

  SELECT @TestValue AS [NVarCharValue],
         DATALENGTH(@TestValue) AS [NVarCharBytes],
         CONVERT(VARCHAR(100), @TestValue) AS [VarCharValue],
         DATALENGTH(CONVERT(VARCHAR(100), @TestValue)) AS [VarCharBytes];


  INSERT INTO dbo.[One'Column] ([SomeDate], [String])
    VALUES (GETDATE(), @TestValue); -- VC (SQL)
  INSERT INTO dbo.TwoColumns ([Stringy]]], [SomeDate], [LOBy])
    VALUES (@TestValue, GETDATE(), @TestValue); -- NC (SQL), TX (SQL)
  INSERT INTO dbo.NoColumns ([SomeDate], [SomeMoney])
    VALUES (GETDATE(), $123.45);
  INSERT INTO dbo.[Another]]One'Column] ([Stringy], [SomeDate])
    VALUES (@TestValue, GETDATE()); -- C (100)
  INSERT INTO dbo.ThreeColumns (['FarCar], [SomeDate], [InTharKahr], [💣EnTexxed💥])
    VALUES (@TestValue, GETDATE(), @TestValue, @TestValue); -- VC (80), NVC (100), NTX (80)
  INSERT INTO dbo.[Yet🙀Another]]One'Column] ([Stringy], [SomeDate])
    VALUES (@TestValue, GETDATE()); -- NVC (90)
  INSERT INTO dbo.[DatabaseCollation] ([VarChar], [NVarChar], [SomeDate])
    VALUES (@TestValue, @TestValue, GETDATE()); -- VC (DATABASE_DEFAULT), NVC (DATABASE_DEFAULT)

END;


SELECT 'BEFORE' AS [WHEN], @@TRANCOUNT AS [@@TRANCOUNT];
SELECT * FROM dbo.[One'Column];
SELECT * FROM dbo.TwoColumns;
SELECT * FROM dbo.NoColumns;
SELECT * FROM dbo.[Another]]One'Column];
SELECT * FROM dbo.ThreeColumns;
SELECT * FROM dbo.[Yet🙀Another]]One'Column]
SELECT * FROM dbo.[DatabaseCollation];

-------------------------------------------------------------------------------
--===========================================================================--
-------------------------------------------------------------------------------
DECLARE @TablesPerTransaction TINYINT = 2,
        @FixNVarCharCollation BIT = 1;

DECLARE @SQL NVARCHAR(MAX) = N'',
        @CurrentTableName NVARCHAR(MAX) = N'',
        @PreviousTableName NVARCHAR(MAX) = N'',
        @FullScript NVARCHAR(MAX) = N'';

;WITH pieces AS
(
  SELECT QUOTENAME(sch.[name]) AS [SchemaName],
         QUOTENAME(obj.[name]) AS [TableName],
         QUOTENAME(col.[name]) AS [ColumnName],
         typ.[name] AS [DataType],
         IIF(    COLLATIONPROPERTY(col.[collation_name], 'version') < 2
             AND (   typ.[name] IN (N'nchar', N'nvarchar', N'ntext')
                  OR col.[collation_name] LIKE N'%UTF8%'),
             1, 0) AS [CollationNeedsFixin],
         ROW_NUMBER() OVER (PARTITION BY sch.[name], obj.[name]
                            ORDER BY sch.[name], obj.[name], col.[name]) AS [ColumnNum],
         DENSE_RANK() OVER (ORDER BY sch.[name], obj.[name]) AS [ObjectNum]
  FROM   sys.objects obj
  INNER JOIN sys.schemas sch
          ON sch.[schema_id] = obj.[schema_id]
  INNER JOIN sys.columns col
          ON col.[object_id] = obj.[object_id]
  INNER JOIN sys.types typ
          ON typ.[user_type_id] = col.[system_type_id]
  WHERE  obj.[is_ms_shipped] = 0
  AND    obj.[type] = N'U'
  AND    typ.[name] IN (N'char', N'varchar', N'text', N'nchar', N'nvarchar', N'ntext')
  --ORDER BY sch.[name], obj.[name], col.[name]
), core AS
(
  SELECT NCHAR(0x000D) + NCHAR(0x000A) AS [CRLF],
         NCHAR(0x0009) AS [TAB],
         NCHAR(0x0027) AS [APOS], -- single-quote
         NCHAR(0x0027) + NCHAR(0x0027) AS [APOSx2], -- double single-quote
         CONVERT(NVARCHAR(128), SERVERPROPERTY('ProductVersion')) AS [ProdVer]
), util AS
(
  SELECT core.[CRLF], -- pass-through
         core.[TAB], -- pass-through
         core.[APOS], -- pass-through
         core.[APOSx2], -- pass-through
         CONVERT(INT, SUBSTRING(core.[ProdVer], 1, CHARINDEX(N'.', core.[ProdVer]) - 1)) AS [Version],
         N'DECLARE @ErrorMessage NVARCHAR(MAX),' + core.[CRLF]
           + N'        @CurrentTime NVARCHAR(50);' + core.[CRLF] AS [ScriptStart],
         N'BEGIN TRAN;' + core.[CRLF] AS [TranStart],
         N'BEGIN TRY' + core.[CRLF]
           + core.[TAB] + N'SET @CurrentTime = CONVERT(VARCHAR(50), SYSDATETIME(), 121);' + core.[CRLF]
           + core.[TAB] + N'RAISERROR(N''%s -- %s ...'', 10, 1, @CurrentTime, N''{{TABLE_NAME}}'') WITH NOWAIT;'
           + core.[CRLF] AS [TryCatchStart],
         core.[TAB] + N'UPDATE {{TABLE_NAME}} SET' + core.[CRLF] AS [TableStart],
         N',' + core.[CRLF] AS [ColumnEnd],
         N';' + core.[CRLF] AS [TableEnd],
         N'END TRY' + core.[CRLF]
           + N'BEGIN CATCH' + core.[CRLF]
           + core.[TAB] + N'IF (@@TRANCOUNT > 0) ROLLBACK TRAN;' + core.[CRLF]
           + core.[TAB] + N'SET @ErrorMessage = N''( {{TABLE_NAME}} ): '' + ERROR_MESSAGE();' + core.[CRLF]
           + core.[TAB] + N'RAISERROR(@ErrorMessage, 16, 1);' + core.[CRLF]
           + core.[TAB] + N'RETURN;' + core.[CRLF]
           + N'END CATCH;' + core.[CRLF] + core.[CRLF] AS [TryCatchEnd],
         N'IF (@@TRANCOUNT > 0) COMMIT TRAN;' + core.[CRLF] AS [TranEnd]
  FROM   core
)
SELECT -- { store value to use multiple times in remaining variable concatenations }
       @CurrentTableName = p.[SchemaName] + N'.' + p.[TableName],

       -- { main script generation }
       @SQL += -- { end previous line }
               IIF(DATALENGTH(@SQL) = 0,
                   u.[ScriptStart] + u.[CRLF] -- no previous line
                     + IIF((@TablesPerTransaction > 1) AND (p.[ObjectNum] % @TablesPerTransaction = 1),
                           N'',
                           N'--') + u.[TranStart] + u.[CRLF],
                   IIF(p.[ColumnNum] = 1, -- previous line was final column of a table
                       u.[TableEnd]
                         + REPLACE(u.[TryCatchEnd], N'{{TABLE_NAME}}', @PreviousTableName)
                         + IIF((@TablesPerTransaction > 1) AND (p.[ObjectNum] % @TablesPerTransaction = 1),
                               u.[TranEnd] + u.[TranStart],
                               N'--' + u.[TranEnd] + N'--' + u.[TranStart]) + u.[CRLF],
                       u.[ColumnEnd]))
               -- { start new table }
             + IIF(p.[ColumnNum] = 1,
                   REPLACE(u.[TryCatchStart], N'{{TABLE_NAME}}', REPLACE(@CurrentTableName, u.[APOS], u.[APOSx2]))
                     + REPLACE(u.[TableStart], N'{{TABLE_NAME}}', @CurrentTableName),
                   N'')
               -- { start column }
             + u.[TAB] + u.[TAB] + p.[ColumnName] + N' = UPPER('
               -- { TEXT and NTEXT aren't valid for UPPER() ; UTF8 needs special handling }
             + CASE 
                 WHEN (p.[DataType] IN (N'char', N'varchar')) AND (p.[CollationNeedsFixin] = 1)
                   THEN N'CONVERT(NVARCHAR(MAX), ' + p.[ColumnName] + N')'
                 WHEN p.[DataType] = N'text' THEN N'CONVERT(VARCHAR(MAX), ' + p.[ColumnName] + N')'
                 WHEN p.[DataType] = N'ntext' THEN N'CONVERT(NVARCHAR(MAX), ' + p.[ColumnName] + N')'
                 ELSE p.[ColumnName]
               END
               -- { For SQL Server 2008 or newer, NVARCHAR data must use a version 100 (or newer) collation }
             + IIF((@FixNVarCharCollation = 1) AND (p.[CollationNeedsFixin] = 1),
                   N' COLLATE '
                     + CASE
                         WHEN u.[Version] = 9 THEN N'Latin1_General_BIN2' -- 2005
                         WHEN u.[Version] < 14 THEN N'Latin1_General_100_BIN2' -- 2008, 2008 R2, 2012, 2014, 2016
                         ELSE N'Japanese_XJIS_140_BIN2' -- 2017 and newer
                       END,
                   N'')
               -- { finish column }
             + N')',

       -- { store value to use at beginning of next row }
       @PreviousTableName = REPLACE(@CurrentTableName, u.[APOS], u.[APOSx2]), -- store TableName for CATCH BLOCK

       -- { store value to use after query finishes }
       @FullScript = @SQL + u.[TableEnd]
                    + REPLACE(u.[TryCatchEnd], N'{{TABLE_NAME}}', @PreviousTableName)
                    + u.[TranEnd]
                    + u.[CRLF] + u.[CRLF]
FROM   pieces p
CROSS JOIN util u
ORDER BY p.[ObjectNum], p.[ColumnNum];



PRINT '-----------------------';
--PRINT @PreviousTableName;
--PRINT @SQL;

PRINT @FullScript; -- DEBUG (this is usually commented-out)
PRINT '-----------------------';

EXEC (@FullScript);
-------------------------------------------------------------------------------
--===========================================================================--
-------------------------------------------------------------------------------

SELECT 'AFTER' AS [WHEN], @@TRANCOUNT AS [@@TRANCOUNT];
SELECT * FROM dbo.[One'Column];
SELECT * FROM dbo.TwoColumns;
SELECT * FROM dbo.NoColumns;
SELECT * FROM dbo.[Another]]One'Column];
SELECT * FROM dbo.ThreeColumns;
SELECT * FROM dbo.[Yet🙀Another]]One'Column]
SELECT * FROM dbo.[DatabaseCollation];
GO


IF (OBJECT_ID(N'dbo.One''Column') IS NOT NULL)
BEGIN
  RAISERROR('Deleting test tables...', 10, 1) WITH NOWAIT;
  DROP TABLE dbo.[One'Column];
  DROP TABLE dbo.TwoColumns;
  DROP TABLE dbo.NoColumns;
  DROP TABLE dbo.[Another]]One'Column];
  DROP TABLE dbo.ThreeColumns;
  DROP TABLE dbo.[Yet🙀Another]]One'Column];
  DROP TABLE dbo.[DatabaseCollation];
END;

GO
----------------------------------------------------------------------------------------------------------