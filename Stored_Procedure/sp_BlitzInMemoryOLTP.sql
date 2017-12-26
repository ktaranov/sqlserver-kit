USE master;
GO

IF OBJECT_ID('dbo.sp_BlitzInMemoryOLTP', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.sp_BlitzInMemoryOLTP AS SELECT 1;');
GO

ALTER PROCEDURE dbo.sp_BlitzInMemoryOLTP(
        @instanceLevelOnly BIT            = 0
      , @dbName            NVARCHAR(4000) = N'ALL'
      , @tableName         NVARCHAR(4000) = NULL
      , @debug             BIT            = 0
)
/*
.SYNOPSIS
    Get detailed information about In-Memory SQL Server objects

.DESCRIPTION
    Get detailed information about In-Memory SQL Server objects
    Tested on SQL Server: 2014, 2016, 2017
	NOT tested on Azure SQL Database

.PARAMETER @instanceLevelOnly
    Only check instance In-Memory related information

.PARAMETER @dbName
    Check database In-Memory objects for specified database

.PARAMETER @tableName
    Check database In-Memory objects for specified tablename

.PARAMETER @debug
    Only PRINT dynamic sql statements without executing it

.EXAMPLE
    EXEC sp_BlitzInMemoryOLTP;
    -- Get all In-memory information

.EXAMPLE
    EXEC sp_BlitzInMemoryOLTP @instanceLevelOnly = 1;
    -- Get only instance In-Memory information

.EXAMPLE
    EXEC sp_BlitzInMemoryOLTP @debug = 1;
    -- PRINT dynamic sql statements without executing it

.LICENSE MIT
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

.NOTE
    Author: Ned Otter
    Original link: http://nedotter.com/archive/2017/10/in-memory-oltp-diagnostic-script/
    Version: 1.0

    Modified: 2017-12-06
    Author: Aleksey Nagorskiy
    Version: 1.1

    Modified: 2017-12-13
    Author: Konstantin Taranov
    Version: 1.2

    Modified: 2017-12-14
    Author: Konstantin Taranov
    Version: 1.3

    Modified: 2017-12-14
    Author: Aleksey Nagorskiy
    Version: 1.4

    Modified: 2017-12-18
    Author: Konstantin Taranov
    Version: 1.5

    Modified: 2017-12-19
    Author: Ned Otter
    Version: 1.6

    Modified: 2017-12-23
    Author: Ned Otter
    Version: 1.7

    Modified: 2017-12-25
    Author: Ned Otter
    Version: 1.8

*/
AS BEGIN TRY

    SET NOCOUNT ON;
	DECLARE @rowCount INT

    DECLARE @crlf VARCHAR(10) = CHAR(10);

    DECLARE @VersionString NVARCHAR(MAX) = CAST(SERVERPROPERTY('ProductVersion') AS NVARCHAR(128))
	      , @Edition NVARCHAR(MAX) = CAST(SERVERPROPERTY('Edition') AS NVARCHAR(128))
          , @errorMessage  NVARCHAR(512);

    DECLARE @Version INT = CONVERT(INT, SUBSTRING(@VersionString, 1, CHARINDEX('.', @VersionString) - 1));

    IF @debug = 1 PRINT('--@Version = ' + CAST(@Version AS VARCHAR(30)));

    IF @Version < 12
    BEGIN
        SET @errorMessage = CONCAT('In-Memory OLTP is not supported if SQL Server version is less than 2014. You are running SQL Server version  ', @Version);
        THROW 55000, @errorMessage, 1;
    END;

    /*
    ###################################################
        if we get here, we are running at least SQL 2014, but that version 
		only runs In-Memory if we are using Enterprise Edition
    ###################################################
    */

    IF @Version = 12 AND (@Edition NOT LIKE 'Enterprise%' OR @Edition NOT LIKE 'Developer%')
    BEGIN
        SET @errorMessage = CONCAT('For SQL 2014, In-Memory OLTP is only suppported on Enterprise Edition. You are running SQL Server edition  ', @Edition);
        THROW 55000, @errorMessage, 1;
    END;

    /*
    ######################################################################################################################
        DATABASE LEVEL
    ######################################################################################################################
    */

    IF OBJECT_ID('tempdb..#inmemDatabases') IS NOT NULL DROP TABLE #inmemDatabases;
    SELECT QUOTENAME(name) AS name
         , database_id
         , ROW_NUMBER() OVER (ORDER BY name ASC) AS rowNumber
    INTO #inmemDatabases
    FROM sys.databases
    WHERE name NOT IN ( 'master', 'model', 'tempdb', 'distribution', 'msdb', 'SSISDB')
        AND (name = @dbName OR @dbName = 'ALL')
        AND state_desc = 'ONLINE';

    IF @debug = 1 SELECT 'All ONLINE user databases' AS AllDatabases, * FROM #inmemDatabases;

    IF @dbName IS NULL AND @instanceLevelOnly = 0
    BEGIN
        SET @errorMessage = '@dbName IS NULL, please specify database name or ALL';
        THROW 55001, @errorMessage, 1;
        RETURN;
    END;

    IF (@dbName IS NOT NULL AND @dbName <> 'ALL') 
         AND (NOT EXISTS (SELECT 1 FROM #inmemDatabases WHERE name = QUOTENAME(@dbName)) AND @instanceLevelOnly = 0)
    BEGIN
        SET @errorMessage = '@dbName not found in sys.databases';
        THROW 55002, @errorMessage, 1;
        RETURN;
    END;

    IF @dbName = 'ALL' AND NOT EXISTS (SELECT 1 FROM #inmemDatabases)
    BEGIN
        SET @errorMessage = 'ALL was specified, but no memory-optimized databases were found';
        THROW 55002, @errorMessage, 1;
        RETURN;
    END;

    IF OBJECT_ID('tempdb..#moduleSplit') IS NOT NULL DROP TABLE #moduleSplit;

    CREATE TABLE #moduleSplit
    (
         rowNumber INT IDENTITY PRIMARY KEY
        ,value NVARCHAR(MAX) NULL
    );

    DECLARE @loadedModules TABLE
    (
         rowNumber INT IDENTITY PRIMARY KEY
        ,name NVARCHAR(MAX) NULL
    );

    INSERT @loadedModules
    (
        name
    )
    SELECT name
    FROM sys.dm_os_loaded_modules AS a
    WHERE description = 'XTP Native DLL'
        AND PATINDEX('%[_]p[_]%', name) > 0;

    DECLARE @maxLoadedModules INT = (SELECT COUNT(*) FROM @loadedModules);
    DECLARE @moduleCounter INT = 1;
    DECLARE @loadedmoduleName NVARCHAR(MAX) = '';

    SET @moduleCounter = 1;

    WHILE @moduleCounter <= @maxLoadedModules
    BEGIN

        SELECT @loadedmoduleName = name
        FROM @loadedModules
        WHERE rowNumber = @moduleCounter;

        DECLARE @xml XML
              , @delimiter NVARCHAR(10);
        SET @delimiter = '_';
        SET @xml = CAST(('<X>'+REPLACE(@loadedmoduleName, @delimiter, '</X><X>')+'</X>') AS XML);

        INSERT #moduleSplit
        (
            value
        )
        SELECT C.value('.', 'NVARCHAR(1000)') AS value FROM @xml.nodes('X') as X(C);

        SELECT @moduleCounter += 1;

    END

    IF @instanceLevelOnly = 0
    BEGIN

        /*
        ####################################################
            Determine which databases are memory-optimized
        ####################################################
        */
        DECLARE @sql     NVARCHAR(MAX) = ''
              , @counter INT = 1
              , @MaxRows INT = (SELECT COUNT(*) FROM #inmemDatabases);

        WHILE @counter <= @MaxRows
        BEGIN

            IF @debug = 1 PRINT('--@counter = ' + CAST(@counter AS VARCHAR(30)) + ';' + @crlf);

            IF @counter = 1
            BEGIN
                SELECT @sql += ';WITH InMemDatabases AS (';
            END

            SELECT @sql +=
            CASE 
                WHEN @counter = 1 THEN ''  -- there is exactly 1 database for the entire instance
                ELSE @crlf + ' UNION ALL ' + @crlf
            END;

            SELECT @sql +=
                CONCAT
                (
                        @crlf
                    ,'SELECT DISTINCT '
                    , 'N'''
                    ,  name
                    , ''' AS databaseName,' + @crlf
                    , database_id
                    , ' AS database_id' + @crlf+ ' FROM '
                    , name
                    , '.sys.database_files' + @crlf + ' INNER JOIN '
                    , name
                    , '.sys.filegroups ON database_files.data_space_id = filegroups.data_space_id WHERE filegroups.type = ''FX'''
                )
            FROM #inmemDatabases
            WHERE rowNumber = @counter;

            --IF @debug = 1 PRINT(@sql);

            SELECT @counter += 1;
        END;

        -- post-processing
        SELECT @sql += 
            CONCAT
            (
                    ')'
                ,@crlf
                ,'SELECT InMemDatabases.*, sys.databases.log_reuse_wait_desc'
                ,@crlf
                ,'FROM InMemDatabases '
                ,@crlf
                ,'INNER JOIN sys.databases ON '
                ,'QUOTENAME(sys.databases.name) = InMemDatabases.databaseName;'
            );

        IF @debug = 1
            PRINT('--Determine which databases are memory-optimized' + @crlf + @sql + @crlf);

        DECLARE @RowCount INT = (SELECT COUNT(*) FROM #inmemDatabases);

        IF @RowCount <> 0
        BEGIN

            IF OBJECT_ID('tempdb..#MemoryOptimizedDatabases') IS NOT NULL DROP TABLE #MemoryOptimizedDatabases;

            CREATE TABLE #MemoryOptimizedDatabases
            (
                 rowNumber           INT IDENTITY
               , dbName              NVARCHAR(256) NOT NULL
               , database_id         INT NULL
               , log_reuse_wait_desc NVARCHAR(256)
            );

            INSERT #MemoryOptimizedDatabases
            (
                dbName
               ,database_id
               ,log_reuse_wait_desc
            )
            EXECUTE sp_executesql @sql;

            IF @debug = 1 PRINT(@sql + @crlf)
            ELSE
            BEGIN
                SELECT 'Memory-optimized database(s)' AS databases
                      ,dbName
                      ,database_id
                      ,log_reuse_wait_desc
                FROM #MemoryOptimizedDatabases
                ORDER BY dbName;
            END
        END;


        IF OBJECT_ID('tempdb..#NativeModules') IS NOT NULL DROP TABLE #NativeModules;

        CREATE TABLE #NativeModules
        (
            moduleKey INT IDENTITY NOT NULL
           ,moduleID INT NOT NULL
           ,moduleName NVARCHAR(256) NOT NULL
           ,collectionStatus BIT NULL
        );

        SELECT @sql = '';
        DECLARE @dbCounter INT = 1;
        SELECT @MaxRows = COUNT(*) FROM #MemoryOptimizedDatabases;
        DECLARE @databaseID INT = 1;


        /*
        ###################################################
            This is the loop that processes each db
        ###################################################
        */

        WHILE @dbCounter <= @MaxRows
        BEGIN

            /*
            ###################################################
                List memory-optimized tables in this database
            ###################################################
            */
            SELECT @sql = 
                CONCAT
                (
                    'SELECT TOP 1'
                    ,'''Memory optimized tables'''
                    , ' AS objects,'
                    , ' N'''
                    ,dbName
                    ,''' AS databaseName'
                    ,', b.name AS tableName 
                    , p.rows AS [rowCount]
                    ,durability_desc'
                    , CASE WHEN @Version > 12 THEN ',temporal_type_desc' ELSE NULL END
                    ,',FORMAT(memory_allocated_for_table_kb, ''###,###,###'') AS memoryAllocatedForTableKB
                    ,FORMAT(memory_used_by_table_kb, ''###,###,###'') AS memoryUsedByTableKB
                    ,FORMAT(memory_allocated_for_indexes_kb, ''###,###,###'') AS memoryAllocatedForIndexesKB
                    ,FORMAT(memory_used_by_indexes_kb, ''###,###,###'') AS memoryUsedByIndexesKB
                     FROM '
                    , dbName
                    ,'.sys.dm_db_xtp_table_memory_stats a'
                    ,' INNER JOIN '
                    , dbName
                    ,'.sys.tables b ON b.object_id = a.object_id'
                    ,' INNER JOIN '
                    ,dbName
                    ,'.sys.partitions p'
                    ,' ON p.[object_id] = b.[object_id]'
                    ,' INNER JOIN '
                    ,dbName
                    ,'.sys.schemas s'
                    ,' ON b.[schema_id] = s.[schema_id]'
                    ,' WHERE p.index_id = 2'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

			IF @tableName IS NOT NULL
			BEGIN
				SELECT @sql += CONCAT(' AND b.name = ', '''', @tableName, '''');
			END;

            IF @debug = 1
            PRINT('--List memory-optimized tables in this database' + @crlf + @sql + @crlf)
            ELSE 
			BEGIN
				DECLARE @ResultsTables TABLE
				(
					 [objects] NVARCHAR(MAX)
					,databaseName NVARCHAR(MAX)
					,tableName NVARCHAR(MAX)
					,[rowCount] INT
					,durability_desc NVARCHAR(MAX)
					,temporal_type_desc NVARCHAR(MAX)
					,memoryAllocatedForTableKB INT
					,memoryUsedByTableKB INT
					,memoryAllocatedForIndexesKB INT
					,memoryUsedByIndexesKB INT
				);

				INSERT @ResultsTables
				EXECUTE sp_executesql @sql;

				IF EXISTS(SELECT 1 FROM @ResultsTables)
					SELECT * FROM @ResultsTables;

			END;

            /*
            ##############################################################
                List indexes on memory-optimized tables in this database
            ##############################################################
            */
            SELECT @sql = 
                CONCAT
                (
                        'SELECT '
                        ,'''List indexes on memory-optimized tables in this database'' AS objects,'
                        ,' N'''
                        ,dbName
                        ,''''
                        ,' AS databaseName
                        ,t.name AS tableName
                        ,i.name AS indexName
                        ,c.memory_consumer_id
                        ,c.memory_consumer_type_desc AS consumerType
                        ,c.memory_consumer_desc AS description
                        ,c.allocation_count AS allocations
                        ,FORMAT(c.allocated_bytes / 1024.0, ''###,###,###,###'') AS allocatedBytesMB
                        ,FORMAT(c.used_bytes / 1024.00, ''###,###,###,###.###'') AS usedBytesMB
                    FROM '
                    ,dbName 
                    ,'.sys.dm_db_xtp_memory_consumers c
                    INNER JOIN '
                    ,dbName
                    ,'.sys.tables t ON t.object_id = c.object_id'
                    ,CASE WHEN @Version > 12 THEN ' INNER JOIN sys.memory_optimized_tables_internal_attributes a ON a.object_id = c.object_id
                                                                            AND a.xtp_object_id = c.xtp_object_id' ELSE NULL END
                    ,@crlf + ' LEFT JOIN '
                    ,dbName 
                    ,'.sys.indexes i ON c.object_id = i.object_id
                                                    AND c.index_id = i.index_id '
                                                    ,CASE WHEN @Version > 12 THEN 'AND a.minor_id = 0' ELSE NULL END
                    ,@crlf + ' WHERE t.type = '
                    , '''u'''
                    , '   AND t.is_memory_optimized = 1 '
                    ,' AND i.index_id IS NOT NULL'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

			IF @tableName IS NOT NULL
			BEGIN
				SELECT @sql += CONCAT(' AND t.name = ', '''', @tableName, '''');
			END;

			SELECT @sql += ' ORDER BY tableName, indexName;'

            IF @debug = 1
            PRINT('--List indexes on memory-optimized tables in this database' + @crlf + @sql + @crlf)
            ELSE 
				BEGIN
					DECLARE @ResultsIndexes TABLE
					(
						[objects] NVARCHAR(MAX)
					   ,databaseName NVARCHAR(MAX)
					   ,tableName NVARCHAR(MAX)
					   ,indexName INT
					   ,memory_consumer_id INT
					   ,consumerType NVARCHAR(MAX)
					   ,description NVARCHAR(MAX)
					   ,allocations INT
					   ,allocatedBytesMB INT
					   ,usedBytesMB NVARCHAR(MAX)
					);

					INSERT @ResultsIndexes
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsIndexes)
						SELECT * FROM @ResultsIndexes;

				END;

            /*
            #########################################################
                verify avg_chain_length for HASH indexes

                From BOL:

                Empty buckets:
                    33% is a good target value, but a larger percentage (even 90%) is usually fine.
                    When the bucket count equals the number of distinct key values, approximately 33% of the buckets are empty.
                    A value below 10% is too low.

                Chains within buckets:
                    An average chain length of 1 is ideal in case there are no duplicate index key values. Chain lengths up to 10 are usually acceptable.
                    If the average chain length is greater than 10, and the empty bucket percent is greater than 10%, 
                    the data has so many duplicates that a hash index might not be the most appropriate type.

            #########################################################
            */
        
            SELECT @sql = 
                CONCAT
                (
                       'SELECT '
                       ,'''avg_chain_length for HASH indexes'''
                       ,' AS objects,'''
                       ,dbName
                       ,''''
                       ,' AS databaseName'
                       ,', sch.name AS [Schema] '
                       ,', t.name AS tableName 
                         ,i.name AS [indexName]
                         ,h.total_bucket_count AS totalBucketCount
                         ,h.empty_bucket_count AS emptyBucketCount
                         ,FLOOR((CAST(h.empty_bucket_count AS FLOAT) / h.total_bucket_count) * 100) AS [emptybBucketPercent]
                         ,h.avg_chain_length AS avg_ChainLength
                         ,h.max_chain_length AS maxChainLength
                         ,IIF(FLOOR((CAST(h.empty_bucket_count AS FLOAT) / h.total_bucket_count) * 100) < 33, ''Free buckets % is low!'', '''') AS [Free buckets status]
                         ,IIF(h.avg_chain_length > 10 AND FLOOR((CAST(h.empty_bucket_count AS FLOAT) / h.total_bucket_count) * 100) > 10, ''avg_chain_length has many collisions!'', '''') AS [avg_chain_length status]
                     FROM '
                    ,dbName 
                    ,'.sys.dm_db_xtp_hash_index_stats AS h 
                    INNER JOIN '
                    ,dbName
                    ,'.sys.indexes AS i ON h.object_id = i.object_id AND h.index_id = i.index_id'
                    ,CASE WHEN @Version > 12 THEN
                    CONCAT(' INNER JOIN ', dbName ,'.sys.memory_optimized_tables_internal_attributes ia ON h.xtp_object_id = ia.xtp_object_id') ELSE NULL END
                    ,' INNER JOIN '
                    ,dbName
                    ,'.sys.tables t ON h.object_id = t.object_id'
                    ,' INNER JOIN '
                    ,dbName
                    ,'.sys.schemas sch ON sch.schema_id = t.schema_id '
                    ,CASE WHEN @Version > 12 THEN 'WHERE ia.type = 1' ELSE NULL END
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

			IF @tableName IS NOT NULL
			BEGIN
				SELECT @sql += CONCAT(' AND t.name = ', '''', @tableName, '''');
			END;

			SELECT @sql += ' ORDER BY sch.name
                                     ,t.name
                                     ,i.name;';

            IF @debug = 1
            PRINT('--Verify avg_chain_length for HASH indexes' + @crlf + @sql + @crlf)
            ELSE 
			BEGIN
			
				DECLARE @ResultsHashBuckets TABLE
				(
					 [objects] NVARCHAR(MAX)
					,databaseName NVARCHAR(MAX)
					,[Schema] NVARCHAR(MAX)
					,TableName NVARCHAR(MAX)
					,indexName NVARCHAR(MAX)
					,totalBucketCount BIGINT
					,emptyBucketCount BIGINT
					,emptyBucketPercent INT
					,avg_ChainLength INT
					,max_ChainLength BIGINT
					,[Free buckets status] NVARCHAR(MAX)
					,[avg_chain_length status] BIGINT
				);

				INSERT @ResultsHashBuckets
				EXECUTE sp_executesql @sql;
;
				IF EXISTS(SELECT 1 FROM @ResultsHashBuckets)
					SELECT * FROM @ResultsHashBuckets;

			END;			
			

            /*
            #########################################################
                Count of indexes per table in this database
            #########################################################
            */

            SELECT @sql = 
                CONCAT
                (
                    'SELECT '
                    ,'''Number of indexes per table'' AS objects,'
                    ,' N'''
                    ,dbName
                    ,''''
                    ,' AS databaseName
                    ,t.name AS tableName
                    ,COUNT(DISTINCT i.index_id) AS indexCount
                    FROM '
                    ,dbName 
                    ,'.sys.dm_db_xtp_memory_consumers c
                    INNER JOIN '
                    ,dbName
                    ,'.sys.tables t ON t.object_id = c.object_id'
                    ,CASE WHEN @Version > 12 THEN
                    CONCAT(' INNER JOIN ', dbName ,'.sys.memory_optimized_tables_internal_attributes a ON a.object_id = c.object_id
                                                                        AND a.xtp_object_id = c.xtp_object_id') ELSE NULL END 
                    ,' LEFT JOIN '
                    ,dbName 
                    ,'.sys.indexes i ON c.object_id = i.object_id
                                                    AND c.index_id = i.index_id '
                                                    ,CASE WHEN @Version > 12 THEN ' AND a.minor_id = 0' ELSE NULL END
                    ,' WHERE t.type = '
                    , '''u'''
                    , '   AND t.is_memory_optimized = 1 '
                    ,' AND i.index_id IS NOT NULL'
                    --,' GROUP BY t.name
                    --    ORDER BY t.name'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

			IF @tableName IS NOT NULL
			BEGIN
				SELECT @sql += CONCAT(' AND t.name = ', '''', @tableName, '''');
			END;

			SELECT @sql +=
                     ' GROUP BY t.name
                       ORDER BY t.name';

            IF @debug = 1
            PRINT('--Count of indexes per table in this database' + @crlf + @sql + @crlf)
            ELSE 
			BEGIN
				DECLARE @ResultsIndexCount TABLE
				(
					 [objects] NVARCHAR(MAX)
					,databaseName NVARCHAR(MAX)
					,tableName NVARCHAR(MAX)
					,indexCount INT
				);

				INSERT @ResultsIndexCount
				EXECUTE sp_executesql @sql;

				IF EXISTS(SELECT 1 FROM @ResultsIndexCount)
					SELECT * FROM @ResultsIndexCount;

			END;


            /*
            #####################################################
                List natively compiled modules in this database
            #####################################################
            */
			/*

				FN = SQL scalar function
				IF = SQL inline table-valued function
				TF = SQL table-valued-function
				TR = SQL DML trigger
			*/

			IF @tableName IS NULL
			BEGIN

				SELECT @sql = 
					CONCAT
					(
						'SELECT ''Natively compiled modules'' AS objects,'
						,' N'''
						,dbName
						,''''
						,' AS databaseName
						 ,A.name
						 ,CASE A.type
							WHEN ''FN'' THEN ''Function''
							WHEN ''P'' THEN ''Procedure''
							WHEN ''TR'' THEN ''Trigger''
						   END AS type
						 ,B.definition AS [definition]
						 FROM '
						, dbName
						,'.sys.all_objects AS A
						 INNER JOIN '
						,dbName
						,'.sys.sql_modules AS B ON B.object_id = A.object_id
						WHERE UPPER(B.definition) LIKE ''%NATIVE_COMPILATION%''
						ORDER BY A.type, A.name'
					)
				FROM #MemoryOptimizedDatabases
				WHERE rowNumber = @dbCounter;

				IF @debug = 1
				PRINT('--List natively compiled modules in this database' + @crlf + @sql + @crlf)
				ELSE 
				BEGIN
					DECLARE @ResultsNativeModules TABLE
					(
						 [objects] NVARCHAR(MAX)
						,Name NVARCHAR(MAX)
						,databaseName NVARCHAR(MAX)
						,[type] NVARCHAR(MAX)
						,[definition] NVARCHAR(MAX)
					);

					INSERT @ResultsNativeModules
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsNativeModules)
						SELECT * FROM @ResultsNativeModules;

				END;
			END;

            /*
            #####################################################
                List *loaded* natively compiled modules in this database, i.e. executed at least 1x
            #####################################################
            */

            /*
                the format for checkpoint files changed from SQL 2014 to SQL 2016

                SQL 2014 format:
                database_id = 5
                object_id = 309576141

                H:\SQLDATA\xtp\5\xtp_p_5_309576141.dll

                SQL 2016+ format
                database_id = 9
                object_id = 1600880920

                H:\SQLDATA\xtp\9\xtp_p_9_1600880920_185048689287400_1.dll

                the following code should handle all versions
            */
            IF @tableName IS NULL
			BEGIN
               SELECT @sql =
                    CONCAT
                    (
                        ';WITH nativeModuleObjectID AS
                         (
                            SELECT DISTINCT REPLACE(value, ''.dll'', '''') AS object_id
                            FROM #moduleSplit
                            WHERE rowNumber % ' 
                     ,CASE WHEN @Version = 12 THEN ' 4 = 0'
                           ELSE ' 6 = 4'  -- @Version >= 13 
                      END 
                        ,')'
                    );

                SELECT @sql += 
                    CONCAT
                    (
                        'SELECT ''Loaded natively compiled modules'' AS objects,'
                        ,' N'''
                        ,dbName
                        ,''''
                        ,' AS databaseName
                       ,name AS moduleName
                       ,procedures.object_id
                        FROM '
                        ,dbName
                        ,'.sys.all_sql_modules
                        INNER JOIN '
                        ,dbName
                        ,'.sys.procedures ON procedures.object_id = all_sql_modules.object_id
                        INNER JOIN nativeModuleObjectID ON nativeModuleObjectID.object_id = procedures.object_id'
                    )
                FROM #MemoryOptimizedDatabases
                WHERE rowNumber = @dbCounter;

                IF @debug = 1
                PRINT('--List loaded natively compiled modules in this database (@Version >= 13)' + @crlf + @sql + @crlf)
                ELSE 
				BEGIN
					DECLARE @ResultsNativeLoaded TABLE
					(
						[objects] NVARCHAR(MAX)
					   ,databaseName NVARCHAR(MAX)
					   ,moduleName NVARCHAR(MAX)
					   ,object_id INT
					);

					INSERT @ResultsNativeLoaded
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsNativeLoaded)
						SELECT * FROM @ResultsNativeLoaded;

				END;				
			END;

            /*
            #########################################################
                Count of natively compiled modules in this database
            #########################################################
            */
			IF @tableName IS NULL
			BEGIN
				SELECT @sql = 
					CONCAT
					(
						'SELECT ''Count of natively compiled modules'' AS objects,'
						,' N'''
						,dbName
						,' '''
						,' AS databaseName
						, COUNT(*) AS [Number of modules]
						FROM '
						, dbName
						,'.sys.all_sql_modules
						 INNER JOIN '
						,dbName
						,'.sys.procedures ON procedures.object_id = all_sql_modules.object_id
						WHERE uses_native_compilation = 1
						ORDER BY 1'
					)
				FROM #MemoryOptimizedDatabases
				WHERE rowNumber = @dbCounter;
				IF @debug = 1
				PRINT('--Count of natively compiled modules in this database' + @crlf + @sql + @crlf)
				ELSE EXECUTE sp_executesql @sql;
			END;

            /*
            ############################################################
                Display memory consumption for temporal/internal tables
            ############################################################
            */

            -- temporal is supported in SQL 2016+
            IF @Version >= 13
            BEGIN

                SELECT @sql = 
                    CONCAT
                    (
                        ';WITH InMemoryTemporalTables
                        AS
                        (
                            SELECT '
                            ,'N'''
                            ,dbName
                            ,'''' 
                            ,' AS databaseName'
                            ,',sch.name AS temporalTableSchema
                                  ,T1.OBJECT_ID AS temporalTableObjectId
                                  ,IT.OBJECT_ID AS internalTableObjectId
                                  ,T1.name AS temporalTableName
                                  ,IT.Name AS internalHistoryTableName
                            FROM '
                            ,dbName
                            ,'.sys.internal_tables IT 
                            INNER JOIN '
                            ,dbName
                            ,'.sys.tables T1 ON IT.parent_OBJECT_ID = T1.OBJECT_ID 
                            INNER JOIN '
                            ,dbName
                            ,'.sys.schemas sch ON sch.schema_id = T1.schema_id
                            WHERE T1.is_memory_optimized = 1 
                              AND T1.temporal_type = 2
                        )
                        ,DetailedConsumption
                        AS
                        (
                            SELECT databaseName
                                  ,temporalTableSchema
                                  ,T.temporalTableName
                                  ,T.internalHistoryTableName
                                  ,CASE
                                      WHEN C.object_id = T.temporalTableObjectId
                                      THEN ''Temporal Table''
                                      ELSE ''Internal Table''
                                   END AS ConsumedBy
                                  ,C.allocated_bytes
                                  ,C.used_bytes
                            FROM '
                            ,dbName
                            ,'.sys.dm_db_xtp_memory_consumers C
                            INNER JOIN InMemoryTemporalTables T
                            ON C.object_id = T.temporalTableObjectId OR C.object_id = T.internalTableObjectId
                            WHERE C.allocated_bytes > 0
                              AND C.object_id <> T.temporalTableObjectId
                        )
                        SELECT DISTINCT databaseName
                              ,temporalTableSchema
                              ,temporalTableName
                              ,internalHistoryTableName
                              ,SUM(allocated_bytes) OVER (PARTITION BY temporalTableName ORDER BY temporalTableName) AS allocatedBytesForInternalHistoryTable
                              ,SUM(used_bytes) OVER (PARTITION BY temporalTableName ORDER BY temporalTableName) AS usedBytesForInternalHistoryTable
                        FROM DetailedConsumption'
                    )
                FROM #MemoryOptimizedDatabases
                WHERE rowNumber = @dbCounter;

				IF @tableName IS NOT NULL
				BEGIN
					SELECT @sql += CONCAT(' WHERE temporalTableName = ', '''', @tableName, '''');
				END;

                IF @debug = 1
                PRINT('--Display memory consumption for temporal/internal tables' + @crlf + @sql + @crlf)
				ELSE
				BEGIN
					DECLARE @ResultsTemporal TABLE
					(
						databaseName NVARCHAR(MAX)
					   ,temporalTableSchema NVARCHAR(MAX)
					   ,temporalTableName NVARCHAR(MAX)
					   ,internalHistoryTableName NVARCHAR(MAX)
					   ,allocatedBytesForInternalHistoryTable BIGINT
					   ,usedBytesForInternalHistoryTable BIGINT
					);

					INSERT @ResultsTemporal
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsTemporal)
						SELECT * FROM @ResultsTemporal;

				END;
            END; -- display memory consumption for temporal/internal tables

            /*
            #########################################################
                Display memory structures for LOB columns (off-row)
                for SQL 2016+
            #########################################################
            */

            IF @Version >= 13
            BEGIN
    
                SELECT @sql = 
                    CONCAT
                    (
                        'SELECT DISTINCT '
                        ,'''LOB/Off-row data '' AS objects,'
                        ,' N'''
                        ,dbName
                        ,'''' 
                        ,' AS databaseName'
                        ,', OBJECT_NAME(a.object_id) AS tableName
                        ,cols.name AS columnName
                        ,a.type_desc AS typeDescription
                        ,c.memory_consumer_type_desc AS memoryConsumerTypeDescription
                        ,c.memory_consumer_desc AS memoryConsumerDescription
                        ,c.allocated_bytes AS allocatedBytes
                        ,c.used_bytes AS usedBytes
                         FROM '
                        ,dbName
                        ,'.sys.dm_db_xtp_memory_consumers c
                        INNER JOIN '
                        ,dbName
                        ,'.sys.memory_optimized_tables_internal_attributes a ON a.object_id = c.object_id
                                                                                AND a.xtp_object_id = c.xtp_object_id '
                                    ,' INNER JOIN '
                        ,dbName
                        ,'.sys.objects AS b ON b.object_id = a.object_id '
                        ,' INNER JOIN '
                        ,dbName
                        ,'.sys.syscolumns AS cols ON cols.id = b.object_id
                           WHERE a.type_desc = '
                        ,''''
                        ,'INTERNAL OFF-ROW DATA TABLE'
                        ,''''
                        ,' AND c.memory_consumer_desc = ''Table heap'''
                        --,' ORDER BY databaseName, tableName, columnName'
                    )
                FROM #MemoryOptimizedDatabases
                WHERE rowNumber = @dbCounter;

				IF @tableName IS NOT NULL
				BEGIN
					SELECT @sql += CONCAT(' AND OBJECT_NAME(a.object_id) = ', '''', @tableName, '''');
				END;

				SELECT @sql += ' ORDER BY databaseName, tableName, columnName';

                IF @debug = 1
                PRINT('--Display memory structures for LOB columns (off-row)' + @crlf + @sql + @crlf)
                ELSE 
				BEGIN
					DECLARE @ResultsMemoryConsumerForLOBs TABLE
					(
						[objects] NVARCHAR(MAX)
					   ,databaseName NVARCHAR(MAX)
					   ,tableName NVARCHAR(MAX)
					   ,columnName NVARCHAR(MAX)
					   ,typeDescription NVARCHAR(MAX)
					   ,memoryConsumerTypeDescription NVARCHAR(MAX)
					   ,memoryConsumerDescription NVARCHAR(MAX)
					   ,allocatedBytes INT
					   ,usedBytes INT
					);

					INSERT @ResultsMemoryConsumerForLOBs
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsMemoryConsumerForLOBs)
						SELECT * FROM @ResultsMemoryConsumerForLOBs;

				END;

            END;

            /*
            #######################################################
                Display memory-optimized table types
            #######################################################
            */
			IF @tableName IS NULL
			BEGIN 
                SELECT @sql = 
                    CONCAT
                    (
                        'SELECT '
                        ,'''Memory optimized table types'' AS objects,'
                        ,' N'''
                        ,dbName
                        ,''' AS databaseName,' 
                        ,'SCHEMA_NAME(tt.schema_id) AS [Schema]
                              ,tt.name AS [Name]
                        FROM '
                        ,dbName
                        ,'.sys.table_types AS tt
                        INNER JOIN '
                        ,dbName
                        ,'.sys.schemas AS stt ON stt.schema_id = tt.schema_id
                        WHERE tt.is_memory_optimized = 1
                        ORDER BY [Schema], tt.name '
                    )
                FROM #MemoryOptimizedDatabases
                WHERE rowNumber = @dbCounter;

				IF @debug = 1
				PRINT('--Display memory-optimized table types' + @crlf + @sql + @crlf)
				ELSE 
				BEGIN
					DECLARE @ResultsTableTypes TABLE
					(
						 [objects] NVARCHAR(MAX)
						,databaseName NVARCHAR(MAX)
						,[Schema] NVARCHAR(MAX)
						,[Name] NVARCHAR(MAX)
					);

					INSERT @ResultsTableTypes
					EXECUTE sp_executesql @sql;

					IF EXISTS(SELECT 1 FROM @ResultsTableTypes)
						SELECT * FROM @ResultsTableTypes;

				END;

			END;

            /*
            ##################################################################
                ALL database files, including container name, size, location
            ##################################################################
            */

            SELECT @sql = 
                CONCAT
                (
                    'SELECT '
                    ,'''Database layout'' AS objects,'
                    ,' N'''
                    ,dbName
                    ,'''' 
                    ,' AS databaseName'
                    ,',filegroups.name AS fileGroupName
                      ,physical_name AS fileName
                      --,database_files.name AS [containerName/fileType]
                      ,database_files.name AS [Name]
                      ,filegroups.type AS fileGroupType
                      ,IsContainer = IIF(filegroups.type = ''FX'', ''Yes'', ''No'')
                      ,filegroups.type_desc AS fileGroupDescription
                      ,database_files.state_desc AS fileGroupState
                      ,FORMAT(database_files.size * CONVERT(BIGINT, 8192) / 1024, ''###,###,###,###'') AS sizeKB
                      ,FORMAT(database_files.size * CONVERT(BIGINT, 8192) / 1048576.0, ''###,###,###,###'') AS sizeMB
                      ,FORMAT(database_files.size * CONVERT(BIGINT, 8192) / 1073741824.0, ''###,###,###,###.##'') AS sizeGB
                      ,FORMAT(SUM(database_files.size / 128.0) OVER(), ''###,###,###,###'') AS totalSizeMB
                    FROM '
                    ,dbName
                    ,'.sys.database_files
                    LEFT JOIN '
                    ,dbName
                    ,'.sys.filegroups ON database_files.data_space_id = filegroups.data_space_id
                    ORDER BY filegroups.type, filegroups.name, database_files.name'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

            IF @debug = 1
            PRINT('--ALL database files, including container name, size, location' + @crlf + @sql + @crlf)
            ELSE EXECUTE sp_executesql @sql;

            /*
            ##################################################################
                container name, size, number of files
            ##################################################################
            */

            SELECT @sql = 
                CONCAT
                (
                     ';WITH ContainerDetails AS
                     (
                             SELECT '
                             ,' container_id
                               ,SUM(ISNULL(file_size_in_bytes, 0)) AS sizeinBytes
                               ,COUNT(*) AS fileCount
                               ,MAX(container_guid) AS container_guid
                         FROM ' 
                     ,dbName
                     ,'.sys.dm_db_xtp_checkpoint_files
                         GROUP BY container_id
                     )
                     SELECT 
                          ''Container details by container name'' AS object,'
                         ,' N'''
                         ,dbName
                         ,'''' 
                         ,' AS databaseName
                         ,database_files.name AS containerName
                         ,ContainerDetails.container_id
                         ,FORMAT(ContainerDetails.sizeinBytes / 1048576., ''###,###,###'') AS sizeMB
                         ,ContainerDetails.fileCount
                     FROM ContainerDetails
                     INNER JOIN '
                     ,dbName
                     ,'.sys.database_files ON ContainerDetails.container_guid = database_files.file_guid'
                 )
             FROM #MemoryOptimizedDatabases
             WHERE rowNumber = @dbCounter;

            IF @debug = 1
            PRINT('--container name, size, number of files' + @crlf + @sql + @crlf)
            ELSE EXECUTE sp_executesql @sql;

            /*
            ##################################################################
                container file summary
            ##################################################################
            */

            SELECT @sql = 
                CONCAT
                (
                    ';WITH ContainerFileSummary AS
                    (
                            SELECT '
                            ,' 
                                   SUM(ISNULL(file_size_in_bytes, 0)) AS sizeinBytes
                                  ,MAX(ISNULL(file_type_desc, '''')) AS fileType
                              ,COUNT(*) AS fileCount
                              ,MAX(state_desc) AS fileState
                              ,MAX(container_guid) AS container_guid
                        FROM ' 
                    ,dbName
                    ,'.sys.dm_db_xtp_checkpoint_files
                        GROUP BY file_type_desc, state_desc
                    )
                    SELECT 
                         ''Container details by fileType and fileState'' AS object,'
                        ,' N'''
                        ,dbName
                        ,'''' 
                        ,' AS databaseName
                        ,ContainerFileSummary.fileType
                        ,ContainerFileSummary.fileState
                        ,FORMAT(ContainerFileSummary.sizeinBytes, ''###,###,###'') AS sizeBytes
                        ,FORMAT(ContainerFileSummary.sizeinBytes / 1048576., ''###,###,###'') AS sizeMB
                        ,ContainerFileSummary.fileCount
                        ,database_files.state_desc AS fileGroupState
                        FROM ContainerFileSummary
                    INNER JOIN '
                    ,dbName
                    ,'.sys.database_files ON ContainerFileSummary.container_guid = database_files.file_guid'
                    ,' ORDER BY ContainerFileSummary.fileType, ContainerFileSummary.fileState;'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

            IF @debug = 1
            PRINT('--container file summary' + @crlf + @sql + @crlf)
            ELSE EXECUTE sp_executesql @sql;

            /*
            ##################################################################
                container details
            ##################################################################
            */

            SELECT @sql = 
                CONCAT
                (
                    ';WITH ContainerFileDetails AS
                    (
                        SELECT 
                        container_id
                      --,SUM(file_size_in_bytes) OVER (PARTITION BY container_id ORDER BY container_id) AS fileSizeinBytes
                      ,SUM(ISNULL(file_size_in_bytes, 0)) AS sizeinBytes
                      ,MAX(ISNULL(file_type_desc, '''')) AS fileType
                      ,COUNT(*) AS fileCount
                      ,MAX(state_desc) AS fileState
                      ,MAX(container_guid) AS container_guid
                    FROM '
                        ,dbName
                    ,'.sys.dm_db_xtp_checkpoint_files
                        GROUP BY container_id, file_type_desc, state_desc
                    )
                    SELECT '
                    ,'''Container file details by container_id, fileType and fileState'' AS object,'
                    ,' N'''
                    ,dbName
                    ,'''' 
                    ,' AS databaseName
                    ,database_files.name AS containerName
                    ,ContainerFileDetails.container_id
                    ,ContainerFileDetails.fileType
                    ,ContainerFileDetails.fileState
                    ,FORMAT(ContainerFileDetails.sizeinBytes, ''###,###,###'') AS sizeBytes
                    ,FORMAT(ContainerFileDetails.sizeinBytes / 1048576., ''###,###,###'') AS sizeGB
                    ,ContainerFileDetails.fileCount
                    ,database_files.state_desc AS fileGroupState
                    FROM ContainerFileDetails
                    INNER JOIN '
                    ,dbName
                    ,'.sys.database_files ON ContainerFileDetails.container_guid = database_files.file_guid'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

            IF @debug = 1
            PRINT('--container details' + @crlf + @sql + @crlf)
            ELSE EXECUTE sp_executesql @sql;

            /*

            ###########################################################
                Report on whether or not execution statistics 
                for natively compiled procedures is enabled
            ###########################################################
            */
            SELECT @sql = 
                CONCAT
                (
                    'INSERT #NativeModules
                    (
                         moduleID
                        ,moduleName
                    )
                    SELECT '
                    ,dbName
                    ,'.sys.all_sql_modules.Object_ID AS ObjectID 
                    ,name AS moduleName
                    FROM '
                    ,dbName
                    ,'.sys.all_sql_modules
                     INNER JOIN '
                    ,dbName
                    ,'.sys.procedures ON procedures.object_id = all_sql_modules.object_id'
                    ,' WHERE uses_native_compilation = 1'
                )
            FROM #MemoryOptimizedDatabases
            WHERE rowNumber = @dbCounter;

            EXECUTE sp_executesql @sql;

            IF EXISTS (SELECT 1 FROM #NativeModules)
            BEGIN
                DECLARE @procCounter INT = 1;
                DECLARE @MaxModules INT = (SELECT COUNT(*) FROM #NativeModules);
                DECLARE @dbID INT = (SELECT database_id FROM #MemoryOptimizedDatabases  WHERE rowNumber = @dbCounter);
                DECLARE @moduleID INT;
                DECLARE @ModuleStatus BIT;
                DECLARE @moduleName NVARCHAR(256);

                /*
                ########################################################
                    This is the loop that processes each native module
                ########################################################
                */
                WHILE @procCounter <= @MaxModules
                BEGIN
    
                    SELECT @moduleID = moduleID
                          ,@moduleName = moduleName
                    FROM #NativeModules
                    WHERE moduleKey = @procCounter;

                    PRINT CONCAT('Verifying collection stats of ', @moduleName);

                    SELECT @ModuleStatus = 0;

                    /*#############################################################################################

                        If the module we are verifying collection status for has not been executed at least once,
                        error 41377 will be returned, and will terminate the WHILE loop (so we trap it in a CATCH block, 
                        in order to determine the correct status for this specific proc).

                        Msg 41377, Level 16, State 2, Procedure sp_xtp_control_query_exec_stats_internal, Line 1 [Batch Start Line 0]
                        The natively compiled module with database ID 27 and object ID 1973582069 has not been executed. 
                        Query execution statistics collection can only be enabled if the module has been executed at least once since creation or last database restart.
                    #############################################################################################
                    */

                BEGIN TRY
                    EXEC sys.sp_xtp_control_query_exec_stats
                        @database_id = @dbID
                       ,@xtp_object_id = @moduleID
                       ,@old_collection_value = @ModuleStatus OUTPUT;
                END TRY
                BEGIN CATCH
                    SELECT
                        @ModuleStatus = 0;
                END CATCH;

                    IF @ModuleStatus = 1
                    BEGIN
                        UPDATE #NativeModules
                        SET collectionStatus = 1
                        WHERE moduleKey = @procCounter;
                    END;

                    SELECT @procCounter += 1;
                END; -- -- This is the loop that processes each native module

                IF EXISTS(SELECT * FROM #NativeModules WHERE collectionStatus = 1)
                    SELECT 'Native execution statistics' AS Objects
                          ,moduleName
                          ,moduleID
                         ,CASE 
                               WHEN collectionStatus = 1 THEN 'YES' 
                               WHEN collectionStatus IS NULL THEN 'NO' 
                               ELSE 'NO' 
                          END AS CollectionStatsEnabled
                    FROM #NativeModules
                    WHERE collectionStatus = 1
                    ORDER BY moduleName;
                ELSE
                BEGIN
                    PRINT '--No modules found that have collection stats enabled';
                END;

            END; --IF EXISTS (SELECT 1 FROM #NativeModules)

            SELECT @dbCounter += 1;

        END; -- This is the loop that processes each database
    END;


    IF OBJECT_ID('#NativeModules', 'U') IS NOT NULL DROP TABLE #NativeModules;

    /*
    ######################################################################################################################
        INSTANCE LEVEL
    ######################################################################################################################
    */


    /*
    ###################################################
        Because SQL 2016/SP1 brings In-Memory OLTP to 
        editions other Enterprise, we must check
        @@version
    ###################################################
    */
    IF @instanceLevelOnly = 1 AND @Version >= 12
    BEGIN

        SELECT @@version AS Version;

        SELECT name
              ,value AS configValue
              ,value_in_use AS runValue
        FROM sys.configurations
        WHERE name like 'max server memory%'
        ORDER BY name OPTION (RECOMPILE);

		-- from Mark Wilkinson
		/*
			If memory is being used it should be in here.

			Memory that is reported as being consumed here for XTP was missing in 
			the other XTP DMVs. We should simply look to see what the highest consumer is.

			SELECT * FROM sys.dm_xtp_system_memory_consumers

			SELECT * FROM sys.dm_db_xtp_memory_consumers 

		*/
		select * from sys.dm_os_memory_clerks

		SELECT type AS object_type
			  ,SUM(pages_kb) /1024.0 /1024.0 AS pages_mb
		FROM sys.dm_os_memory_clerks
		WHERE type LIKE '%XTP%'
		GROUP BY type

		SELECT memory_consumer_type_desc AS object_type,
			 SUM(allocated_bytes) /1024.0 /1024.0 AS pagesAllocatedMB
			,SUM(allocated_bytes) /1024.0 /1024.0 AS pagesUsedMB
		FROM sys.dm_xtp_system_memory_consumers
		GROUP BY memory_consumer_type_desc 
		ORDER BY memory_consumer_type_desc 

		SELECT memory_consumer_type_desc AS object_type,
			 SUM(allocated_bytes) /1024.0 /1024.0 AS pagesAllocatedMB
			,SUM(allocated_bytes) /1024.0 /1024.0 AS pagesUsedMB
		FROM sys.dm_db_xtp_memory_consumers
		GROUP BY memory_consumer_type_desc 
		ORDER BY memory_consumer_type_desc 


        SELECT FORMAT(committed_target_kb, '###,###,###,###,###') AS committedTargetKB
              ,FORMAT(committed_target_kb / 1024, '###,###,###,###,###') AS committedTargetMB
              ,FORMAT(committed_target_kb / 1048576, '###,###,###,###,###') AS committedTargetGB
        FROM sys.dm_os_sys_info;

        IF OBJECT_ID('#TraceFlags', 'U') IS NOT NULL DROP TABLE #TraceFlags;

        CREATE TABLE #TraceFlags
        (
             TraceFlag INT NOT NULL
            ,Status TINYINT NOT NULL
            ,Global TINYINT NOT NULL
            ,Session TINYINT NOT NULL
        );
        SET @sql = 'DBCC TRACESTATUS';

        INSERT #TraceFlags
    
        EXECUTE sp_executesql @sql
        IF @debug = 1
        PRINT(@crlf + @sql + @crlf)

        DECLARE @msg NVARCHAR(MAX);

        IF EXISTS (SELECT 1 FROM #TraceFlags WHERE TraceFlag = 10316) -- allows custom indexing on hidden staging table for temporal tables
        BEGIN

            SELECT @msg = 'TraceFlag 10316 is enabled'

            SELECT @msg
                  ,TraceFlag
                  ,Status
                  ,Global
                  ,Session
            FROM #TraceFlags
            WHERE TraceFlag = 10316 
            ORDER BY TraceFlag;

        END;

        /*
        #############################################################################################
            Verify if collection statistics are enabled for:
            1. specific native modules
            2. all native modules (instance-wide config)
    
            Having collection statistics enabled can severely impact performance of native modules.
        #############################################################################################
        */

        -- instance level
        DECLARE @InstancecollectionStatus BIT;

        EXEC sys.sp_xtp_control_query_exec_stats
        @old_collection_value = @InstancecollectionStatus OUTPUT;

        SELECT
            CASE 
                WHEN @InstancecollectionStatus = 1 THEN 'YES' 
                ELSE 'NO'
            END AS [instance-level collection of execution statistics for Native Modules enabled];

        /*
        ####################################################################################
            List any databases that are bound to resource pools
    
            NOTE #1: if there are memory optimized databases that do NOT appear
            in this list, they consume memory from the 'default' pool, where 
            all other SQL Server memory is allocated from. 
    
            If the memory-optimized footprint grows, from either addition of rows, 
            or row versions, it can put pressure on the buffer pool, cause it to shrink,
            and affect performance for harddrive-based tables. 

            NOTE #2: if you want to bind a memory-optimized database to resource pool, 
            the database must be taken OFFLINE/ONINE for the binding to take effect. 
            This will cause all durable data to be removed from memory, and re(streamed)
            from checkpoint file pairs.
    
        ####################################################################################
        */

        IF EXISTS (
            SELECT 1
            FROM sys.databases d
            INNER JOIN sys.dm_resource_governor_resource_pools AS Pools ON Pools.pool_id = d.resource_pool_id
        )
        SELECT 'Resource pool' AS objects
                ,Pools.name AS poolName
                ,d.name AS databaseName
                ,min_memory_percent AS minMemoryPercent
                ,max_memory_percent AS maxMemoryPercent
                ,used_memory_kb / 1024 AS usedMemoryMB
                ,max_memory_kb / 1024 AS maxMemoryMB
                ,FORMAT(((used_memory_kb * 1.0) / (max_memory_kb  * 1.0) * 100), '###.##') AS percentUsed
                ,target_memory_kb / 1024 AS targetMemoryMB
        FROM sys.databases d
        INNER JOIN sys.dm_resource_governor_resource_pools AS Pools ON Pools.pool_id = d.resource_pool_id
        ORDER BY poolName, databaseName;

        /*
        ###########################################################
            Memory breakdown
        ###########################################################
        */

        ;WITH clerksAggregated AS
        (
            SELECT clerks.[type] AS clerkType
                  ,CONVERT(CHAR(20)
                  ,SUM(clerks.pages_kb) / 1024.0) AS clerkTypeUsageMB
            FROM sys.dm_os_memory_clerks AS clerks WITH (NOLOCK)
            WHERE clerks.pages_kb <> 0
            AND clerks.type IN ('MEMORYCLERK_SQLBUFFERPOOL', 'MEMORYCLERK_XTP')
            GROUP BY clerks.[type]
        )
        ,clerksAggregatedString AS
        (
            SELECT clerkType
                  ,clerkTypeUsageMB
                  ,PATINDEX('%.%', clerkTypeUsageMB) AS decimalPoint
            FROM clerksAggregated
        )
        SELECT clerkType
              ,memUsageMB = 
              CASE 
                  WHEN decimalPoint > 1 THEN SUBSTRING(clerkTypeUsageMB, 1, PATINDEX('%.%', clerkTypeUsageMB) -1)
                  ELSE clerkTypeUsageMB
              END 
        FROM clerksAggregatedString;

        -- total memory allocated for in-memory engine
        SELECT type clerk_type
             , name
             , memory_node_id
             , pages_kb/1024 pages_mb 
        FROM sys.dm_os_memory_clerks 
        WHERE type LIKE '%xtp%';


        /*
        #################################################################
            Oldest xtp transactions, they might prevent 
            garbage collection from cleaning up row versions
        #################################################################
        */

        SELECT TOP 10 'Oldest xtp transactions' AS Objects
              ,xtp_transaction_id
              ,transaction_id
              ,session_id
              ,begin_tsn
              ,end_tsn
              ,state_desc
              ,result_desc
        FROM sys.dm_db_xtp_transactions
        ORDER BY begin_tsn DESC;

        /*
        #################################################################
            Is event notification defined at the serverdb level?
            If so, errors will be generated, as EN is not 
            supported for memory-optimized objects, and causes problems
        #################################################################
        */

        IF EXISTS(
            SELECT 1
            FROM sys.event_notifications
        )
        BEGIN 
            SELECT 'Event notifications are listed below';
            SELECT *
            FROM sys.event_notifications;
        END;
    END;
END TRY

BEGIN CATCH
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
          ', User name: ' + CONVERT(sysname, CURRENT_USER);
    PRINT ERROR_MESSAGE();
END CATCH;
GO
