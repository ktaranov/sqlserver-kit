USE master;
GO

IF OBJECT_ID (N'dbo.sp_Snapshot', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE dbo.sp_Snapshot AS SELECT 1');
GO

ALTER PROCEDURE dbo.sp_Snapshot(
      @databaseList NVARCHAR(4000)
    , @listOnly     BIT = 0
    , @debug        BIT = 1
)
AS
/*
EXAMPLE
EXEC dbo.sp_Snapshot
     @databaseList = 'AdventureworksDW2016CTP3,AdventureworksTest'
   , @debug = 0;

NOTE
  Github: https://github.com/ktaranov/sqlserver-kit/blob/master/dbo.sp_Snapshot.sql
  Original Link: https://sqlundercover.com/2017/09/20/sp_snapshot/
  Author: David Fowler
  Created Date: 2017-09-19
  Modified: 2017-09-28 Konstantin Taranov
  (c) SQLUndercover 2017
*/
BEGIN

DECLARE @TSQLStatement NVARCHAR(MAX) = N'';

SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#DatabaseList') IS NOT NULL
    DROP TABLE #DatabaseList;

CREATE TABLE #DatabaseList(name NVARCHAR(4000));
 
IF OBJECT_ID('tempdb..#DatabasesFinal') IS NOT NULL
    DROP TABLE #DatabasesFinal;
 
--set compatibility mode
DECLARE @compatibility BIT;
 
--set compatibility to 1 if server version includes STRING_SPLIT
SELECT @compatibility = CASE
           WHEN SERVERPROPERTY ('productversion') >= '13.0.4001.0' AND Compatibility_Level >= 130 THEN 1
           ELSE 0
       END
FROM sys.databases
WHERE name = DB_NAME();

--select the database list into a temp table so that we can work with it
IF @compatibility = 1 --if compatibility = 1 then use STRING_SPLIT otherwise use fn_SplitString
    INSERT INTO #DatabaseList
    SELECT value
    FROM STRING_SPLIT(@databaseList, ',');
ELSE
    INSERT INTO #DatabaseList
    SELECT Item AS name
    FROM master.dbo.udf_SplitStringByDelimiter(@databaseList, ',');
-- https://github.com/ktaranov/sqlserver-kit/blob/master/User_Defined_Function/udf_SplitStringByDelimiter.sql

--get list of databases, including those covered by any wildcards
SELECT QUOTENAME(name) AS name
INTO #DatabasesFinal
FROM sys.databases databases
WHERE EXISTS
        (SELECT name
        FROM #DatabaseList
        WHERE databases.name LIKE #DatabaseList.name);

IF @listOnly = 1 --if @listOnly set then only print the affected databases
SELECT name
FROM #DatabasesFinal;
ELSE
BEGIN

    DECLARE @Databases NVARCHAR(128);

    ------------------------------------------------------------------------------------------------------
    --Loop through each database creating snapshots

    DECLARE databases_curr CURSOR
    FOR SELECT name
        FROM #DatabasesFinal;

    OPEN databases_curr;

    FETCH NEXT FROM databases_curr
    INTO @Databases;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        -- Create Snapshots
        SET @TSQLStatement = 'USE ' + @Databases + ';' + CHAR(13) +
            '
            DECLARE @DatabaseName NVARCHAR(128);
            DECLARE @SnapshotName NVARCHAR(128);
            SET @DatabaseName = DB_NAME();
            SET @SnapshotName = DB_NAME() + ''_snapshot'';
 
            --table variable to hold file list
            DECLARE @DatabaseFiles TABLE (id INT identity(1,1), name NVARCHAR(128), physical_name NVARCHAR(400));
 
            --populate table variable with file information
            INSERT INTO @DatabaseFiles (name, physical_name)
            SELECT name, physical_name
            FROM sys.database_files
            WHERE type != 1;
 
            --begin building snapshot script
            DECLARE @snapshotScript NVARCHAR(2000);
            SET @snapshotScript = ''CREATE DATABASE '' + QUOTENAME(@SnapshotName) + '' ON '';
 
            -- Loop through datafile table variable
            DECLARE @LoopCounter INT = 0;
 
            DECLARE @FileCount INT;
            SELECT @FileCount = COUNT(*)
            FROM @DatabaseFiles;
 
            WHILE @LoopCounter < @FileCount
            BEGIN
            SET @LoopCounter = @LoopCounter + 1
            SELECT @snapshotScript = @snapshotScript + ''(NAME = '' + QUOTENAME(name) + '', FILENAME = '''''' + physical_name + ''.ss''''),''
            FROM @DatabaseFiles
            WHERE id = @LoopCounter;
            END;
 
            --loop will have added an unwanted comma at the end of the script, delete this comma
            SET @snapshotScript = LEFT(@snapshotScript, LEN(@snapshotScript) -1);
 
            --add AS SNAPSHOT to script
            SET @snapshotScript = @snapshotScript + '' AS SNAPSHOT OF ['' + @DatabaseName + '']'';
 
            --Generate the snapshot
            PRINT ''Creating Snapshot for ' + @Databases + ''';
            EXEC sp_executesql @snapshotScript;';

            SET @TSQLStatement = REPLACE(@TSQLStatement, '            ', '');

            IF @debug = 1 PRINT @TSQLStatement;
            ELSE
            EXEC sp_executesql @TSQLStatement;
 
        FETCH NEXT FROM databases_curr
        INTO @Databases;
    END;
 
    CLOSE databases_curr;
    DEALLOCATE databases_curr;
END;
END;
GO
