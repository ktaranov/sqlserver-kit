/*
Author: Konstantin Taranov
Link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/IN_Memory_Example_2017.sql
*/
USE master;
GO

DECLARE @databaseFilePath NVARCHAR(1000) = N'';
SELECT @databaseFilePath = SUBSTRING(physical_name, 1, CHARINDEX(N'master.mdf', LOWER(physical_name)) - 1)
 FROM  master.sys.master_files
 WHERE database_id = 1 AND file_id = 1;

DECLARE @databaseName SYSNAME = N'1ಠಠಠ 16+ 错误的名字! Wrong Name! गलत नाम! Неправильное название! Nombre incorrecto! Falscher Name! 間違った名前! שם שגוי! Mauvais Nom!1';
/* To prevent Msg 5135, שםשגוי cannot be used for FILESTREAM files */
DECLARE @dbFileName_mod   SYSNAME        = SUBSTRING(@databaseName, 1, 80) + N'_mod';
DECLARE @databaseFileName NVARCHAR(1000) = REPLACE(@databaseName, N' ', N'');
DECLARE @tsqlStatement    NVARCHAR(4000) = N'';
DECLARE @crlf             VARCHAR(10) = CHAR(10) + CHAR(13);
DECLARE @debug            BIT            = 1;

SET @tsqlStatement = N'
USE master;' +
CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END +
N'IF DB_ID(N''@databaseName'') IS NOT NULL
BEGIN
    ALTER DATABASE [@databaseName] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE  [@databaseName];
END;

CREATE DATABASE [@databaseName]
 CONTAINMENT = NONE
 ON PRIMARY
(NAME = N''@databaseName'',
FILENAME = N''@databaseFilePath@databaseFileName.mdf'', SIZE = 32MB, MAXSIZE = 2048MB, FILEGROWTH = 64MB),
FILEGROUP [@databaseName] CONTAINS MEMORY_OPTIMIZED_DATA DEFAULT
( NAME = N''@databaseName_mod'', FILENAME = N''@databaseFilePath@dbFileName_mod'', MAXSIZE = 2048MB)
 LOG ON
( NAME = N''@databaseName_log'', FILENAME = N''@databaseFilePath@databaseFileName_log.ldf'', SIZE = 32MB, MAXSIZE = 2048MB, FILEGROWTH = 64MB);
' + CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END +
N'IF CAST(SERVERPROPERTY(''ProductMajorVersion'') AS INT) = 14
ALTER DATABASE [@databaseName] SET COMPATIBILITY_LEVEL = 140;

IF CAST(SERVERPROPERTY(''ProductMajorVersion'') AS INT) = 13
ALTER DATABASE [@databaseName] SET COMPATIBILITY_LEVEL = 130;';

SET @tsqlStatement = REPLACE(@tsqlStatement, '@databaseName',     @databaseName);
SET @tsqlStatement = REPLACE(@tsqlStatement, '@dbFileName_mod',   @dbFileName_mod);
SET @tsqlStatement = REPLACE(@tsqlStatement, '@databaseFileName', @databaseFileName);
SET @tsqlStatement = REPLACE(@tsqlStatement, '@databaseFilePath', @databaseFilePath);

IF @debug = 1 PRINT(@tsqlStatement)
ELSE
EXEC sp_executesql @tsqlStatement;


SET @tsqlStatement = N'USE [@databaseName];' +
CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END +
N'/* configure recommended DB option */
ALTER DATABASE CURRENT SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON;

/* memory-optimized table */
CREATE TABLE dbo.[¯\_(ツ)_/¯ 😁__間違った名前 In Memory Table Я не советую так называть__👻 ¯\_(ツ)_/¯]
( c1 INT IDENTITY PRIMARY KEY NONCLUSTERED,
  c2 NVARCHAR(MAX))
WITH (MEMORY_OPTIMIZED=ON);

/* non-durable table */
CREATE TABLE dbo.temp_table1
( c1 INT IDENTITY PRIMARY KEY NONCLUSTERED,
  c2 NVARCHAR(MAX))
WITH (MEMORY_OPTIMIZED=ON,
      DURABILITY=SCHEMA_ONLY);

/* memory-optimized table type */
CREATE TYPE dbo.tt_table1 AS TABLE
( c1 INT IDENTITY,
  c2 NVARCHAR(MAX),
  is_transient BIT NOT NULL DEFAULT (0),
  INDEX ix_c1 HASH (c1) WITH (BUCKET_COUNT=1024))
WITH (MEMORY_OPTIMIZED=ON);

CREATE TABLE dbo.[¯\_(ツ)_/¯ 😁__間違った名前 In Memory Table Я не советую так называть__👻 ¯\_(ツ)_/¯](
      keyColumn INT IDENTITY PRIMARY KEY NONCLUSTERED
    , description CHAR(100) NOT NULL
)
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);

INSERT dbo.[¯\_(ツ)_/¯ 😁__間違った名前 In Memory Table Я не советую так называть__👻 ¯\_(ツ)_/¯]
(
description
)
VALUES
 (REPLICATE(''A'', 100))
,(REPLICATE(''B'', 100))
,(REPLICATE(''C'', 100))
,(REPLICATE(''D'', 100))
,(REPLICATE(''E'', 100))
,(REPLICATE(''F'', 100));
';

SET @tsqlStatement = REPLACE(@tsqlStatement, '@databaseName', @databaseName);

IF @debug = 1 PRINT(@tsqlStatement)
ELSE
EXEC sp_executesql @tsqlStatement;


/* https://stackoverflow.com/a/793362/2298061 */
DECLARE @UseAndExecStatment NVARCHAR(4000);
SET @UseAndExecStatment = N'USE [' + @databaseName + N']; EXEC sp_executesql @tsqlStatement';

SET @tsqlStatement = CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END +
N'/* natively compiled stored procedure */
CREATE PROCEDURE dbo.usp_ingest_table1
  @table1 dbo.tt_table1 READONLY
WITH NATIVE_COMPILATION, SCHEMABINDING
AS
BEGIN ATOMIC
    WITH (TRANSACTION ISOLATION LEVEL=SNAPSHOT,
          LANGUAGE=N''us_english'')

  DECLARE @i INT = 1

  WHILE @i > 0
  BEGIN
    INSERT dbo.table1
    SELECT c2
    FROM @table1
    WHERE c1 = @i AND is_transient=0

    IF @@ROWCOUNT > 0
      SET @i += 1
    ELSE
    BEGIN
      INSERT dbo.temp_table1
      SELECT c2
      FROM @table1
      WHERE c1 = @i AND is_transient=1

      IF @@ROWCOUNT > 0
        SET @i += 1
      ELSE
        SET @i = 0
    END
  END
END;';

IF @debug = 1 PRINT(@tsqlStatement)
ELSE
BEGIN
EXEC sp_executesql @UseAndExecStatment,
     N'@tsqlStatement NVARCHAR(MAX)', @tsqlStatement = @tsqlStatement;
END;


SET @UseAndExecStatment = N'USE [' + @databaseName + N']; EXEC sp_executesql @tsqlStatement';
SET @tsqlStatement = CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END +
N'
CREATE OR ALTER PROCEDURE dbo.native_sp
WITH NATIVE_COMPILATION, SCHEMABINDING, EXECUTE AS OWNER
AS
BEGIN ATOMIC WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N''us_english'')
SELECT keyColumn
,description
FROM dbo.[¯\_(ツ)_/¯ 😁__間違った名前 In Memory Table Я не советую так называть__👻 ¯\_(ツ)_/¯];
END;' + CASE WHEN @debug = 1 THEN @crlf + N'GO' + @crlf ELSE N'' END;

IF @debug = 1 PRINT(@tsqlStatement)
ELSE
BEGIN
EXEC sp_executesql @UseAndExecStatment,
     N'@tsqlStatement NVARCHAR(MAX)', @tsqlStatement = @tsqlStatement;
END;


SET @UseAndExecStatment = N'USE [' + @databaseName + N']; EXEC sp_executesql @tsqlStatement';
SET @tsqlStatement = '
/* sample execution of the proc */
DECLARE @table1 dbo.tt_table1;
INSERT @table1 (c2, is_transient) VALUES (N''sample durable'', 0);
INSERT @table1 (c2, is_transient) VALUES (N''sample non-durable'', 1);

EXECUTE dbo.usp_ingest_table1 @table1=@table1

SELECT c1, c2 from dbo.table1
SELECT c1, c2 from dbo.temp_table1;

EXECUTE dbo.native_sp;
';

IF @debug = 1 PRINT(@tsqlStatement)
ELSE
BEGIN
EXEC sp_executesql @UseAndExecStatment,
     N'@tsqlStatement NVARCHAR(MAX)', @tsqlStatement = @tsqlStatement;
END;
