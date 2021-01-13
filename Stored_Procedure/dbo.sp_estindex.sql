SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'Description' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@TableName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@TableName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SqlMajorVersion' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@SqlMajorVersion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SchemaName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@SchemaName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@IsUnique' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@IsUnique' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@IndexColumns' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@IndexColumns' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@IncludeColumns' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@IncludeColumns' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@Filter' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@Filter' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@FillFactor' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@FillFactor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@DatabaseName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@DatabaseName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@Verbose' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_estindex', NULL,NULL))
    BEGIN;
        EXEC sys.sp_dropextendedproperty @name=N'@Verbose' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
    END;
GO

/***************************/
/* Create stored procedure */
/***************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_estindex]') AND [type] IN (N'P', N'PC'))
	BEGIN;
		EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_estindex] AS';
	END
GO

ALTER PROCEDURE [dbo].[sp_estindex]
    @SchemaName SYSNAME = NULL
    ,@TableName SYSNAME
    ,@DatabaseName SYSNAME = NULL
    ,@IndexColumns NVARCHAR(2048)
    ,@IncludeColumns NVARCHAR(2048) = NULL
    ,@IsUnique BIT = 0
    ,@Filter NVARCHAR(2048) = ''
    ,@FillFactor TINYINT = 100
    ,@Verbose BIT = 0
    -- Unit testing only
    ,@SqlMajorVersion TINYINT = 0
AS
BEGIN

SET NOCOUNT ON;

/*
sp_estindex - Estimate a new index's size and statistics.

Part of the DBA MultiTool http://dba-multitool.org

Version: 2020121

MIT License

Copyright (c) 2020 John McCall

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial 
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

-- TODO: 
    -- Handle clustered indexes - https://docs.microsoft.com/en-us/sql/relational-databases/databases/estimate-the-size-of-a-clustered-index?view=sql-server-ver15

=========

Example:

    EXEC dbo.sp_estindex @SchemaName = 'dbo', @tableName = 'Marathon', @IndexColumns = 'racer_id, finish_time, is_disqualified';

    EXEC dbo.sp_estindex @tableName = 'Marathon', @IndexColumns = 'racer_id, finish_time, is_disqualified', @Filter = 'WHERE racer_id IS NOT NULL', @FillFactor = 90;

*/

DECLARE @Sql NVARCHAR(MAX) = N''
    ,@QualifiedTable NVARCHAR(257)
    ,@IndexName SYSNAME = CONCAT('sp_estindex_hypothetical_idx_', DATEDIFF(SECOND,'1970-01-01 00:08:46', GETUTCDATE()))
    ,@DropIndexSql NVARCHAR(MAX)
    ,@Msg NVARCHAR(MAX) = N''
    ,@IndexType SYSNAME = 'NONCLUSTERED'
    ,@IsHeap BIT
    ,@IsClusterUnique BIT
    ,@ObjectID INT
    ,@IndexID INT
    ,@ParmDefinition NVARCHAR(MAX) = N''
    ,@NumRows BIGINT
    ,@UseDatabase NVARCHAR(200)
    ,@UniqueSql VARCHAR(10)
    ,@IncludeSql VARCHAR(2048)
    ,@PageSize BIGINT = 8192
    ,@FreeBytesPerPage BIGINT = 8096;

BEGIN TRY 
    -- Find Version
	IF (@SqlMajorVersion = 0)
		BEGIN;
			SET @SqlMajorVersion = CAST(SERVERPROPERTY('ProductMajorVersion') AS TINYINT);
		END;

    /* Validate Version */
	IF (@SqlMajorVersion < 11)
		BEGIN;
			SET @Msg = 'SQL Server versions below 2012 are not supported, sorry!';
			RAISERROR(@Msg, 16, 1);
		END;

    /* Validate Fill Factor */
    IF (@FillFactor > 100 OR @FillFactor < 1)
        BEGIN;
            SET @Msg = 'Fill factor must be between 1 and 100.';
            THROW 51000, @Msg, 1;
        END;

    /* Validate Database */
    IF (@DatabaseName IS NULL)
        BEGIN;
            SET @DatabaseName = DB_NAME();
            IF (@Verbose = 1)
                BEGIN;
                    SET @Msg = 'No database provided, assuming current database.';
                    RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                END;
        END;
    ELSE IF (DB_ID(@DatabaseName) IS NULL)
        BEGIN;
            SET @DatabaseName = DB_NAME();
            SET @Msg = 'Database does not exist.';
            RAISERROR(@Msg, 16, 1);
        END;

    /* Validate Schema */
    IF (@SchemaName IS NULL)
        BEGIN;
            SET @SchemaName = 'dbo';
            IF (@Verbose = 1)
                BEGIN;
                    SET @Msg = 'No schema provided, assuming dbo.';
                    RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                END;
        END;

    -- Set variables with validated params
    SET @QualifiedTable = CONCAT(QUOTENAME(@SchemaName), '.', QUOTENAME(@TableName));
    SET @UseDatabase = N'USE ' + QUOTENAME(@DatabaseName) + '; ';
    IF (@IsUnique = 1)
        BEGIN;
            SET @UniqueSql = ' UNIQUE ';
        END;
    IF (@IncludeColumns IS NOT NULL)
        BEGIN;
            SET @IncludeSql = CONCAT(' INCLUDE(', @IncludeColumns, ') ');
        END;

    -- Find object id
    SET @Sql = CONCAT(@UseDatabase,
        N'SELECT @ObjectID = [object_id]
        FROM [sys].[all_objects]
        WHERE [object_id] = OBJECT_ID(@QualifiedTable)');
	SET @ParmDefinition = N'@QualifiedTable NVARCHAR(257)
						,@ObjectID INT OUTPUT';
    EXEC sp_executesql @Sql
    ,@ParmDefinition
    ,@QualifiedTable
    ,@ObjectID OUTPUT;

    -- Determine Heap or Clustered
    SET @Sql = CONCAT(@UseDatabase,
        N'SELECT @IsHeap = CASE [type] WHEN 0 THEN 1 ELSE 0 END
            ,@IsClusterUnique = [is_unique]
         FROM [sys].[indexes] 
         WHERE [object_id] = OBJECT_ID(@QualifiedTable) 
         AND [type] IN (1, 0)');
	SET @ParmDefinition = N'@QualifiedTable NVARCHAR(257), @IsHeap BIT OUTPUT, @IsClusterUnique BIT OUTPUT';
	EXEC sp_executesql @Sql
		,@ParmDefinition
		,@QualifiedTable
		,@IsHeap OUTPUT
        ,@IsClusterUnique OUTPUT;

    -- Safety check for leftover index from previous run
    SET @DropIndexSql = CONCAT(@UseDatabase, 
    N'IF EXISTS (SELECT 1 FROM [sys].[indexes] WHERE [object_id] = OBJECT_ID(''',@QualifiedTable,''') AND [name] = ''',@IndexName,''')
        DROP INDEX ', QUOTENAME(@IndexName), ' ON ', @QualifiedTable); 
    EXEC sp_executesql @DropIndexSql;

    -- Fetch missing index stats before creation
    IF OBJECT_ID('tempdb..##TempMissingIndex') IS NOT NULL 
        BEGIN;
            DROP TABLE ##TempMissingIndex;
        END;
        
    SET @Sql = CONCAT(@UseDatabase,
    N'SELECT [id].[statement] 
        ,[id].[equality_columns] 
        ,[id].[inequality_columns] 
        ,[id].[included_columns] 
        ,[gs].[unique_compiles] 
        ,[gs].[user_seeks]
        ,[gs].[user_scans] 
        ,[gs].[avg_total_user_cost] -- Average cost of the user queries that could be reduced
        ,[gs].[avg_user_impact]  -- %
    INTO ##TempMissingIndex
    FROM [sys].[dm_db_missing_index_group_stats] [gs]
    INNER JOIN [sys].[dm_db_missing_index_groups] [ig] ON [gs].[group_handle] = [ig].[index_group_handle]
    INNER JOIN [sys].[dm_db_missing_index_details] [id] ON [ig].[index_handle] = [id].[index_handle]
    WHERE [id].[database_id] = DB_ID()
        AND [id].[object_id] = @ObjectID
    OPTION (RECOMPILE);');
    SET @ParmDefinition = N'@ObjectID INT';
	EXEC sp_executesql @Sql
		,@ParmDefinition
        ,@ObjectID;

    -- Create the hypothetical index
    SET @Sql = CONCAT(@UseDatabase, 'CREATE ', @UniqueSql, @IndexType, ' INDEX ', QUOTENAME(@IndexName), ' ON ', @QualifiedTable, ' (', @IndexColumns, ') ',@IncludeSql, @Filter, ' WITH (STATISTICS_ONLY = -1)');
    EXEC sp_executesql @Sql;
    
    /*******************/
    /* Get index stats */
    /*******************/
    -- Use DBCC to avoid various inconsistencies 
    -- in equivalent DMVs between 2012-2016
    SET @Sql = CONCAT(@UseDatabase, 'DBCC SHOW_STATISTICS ("', @QualifiedTable,'", ', QUOTENAME(@IndexName), ')');
    EXEC sp_executesql @Sql;

    /***************************/
    /* Get missing index stats */
    /***************************/
    DECLARE @QuotedKeyColumns NVARCHAR(2048)
        ,@QuotedInclColumns NVARCHAR(2048);

    --Get index columns in same format as dmv table
    SET @Sql = CONCAT(@UseDatabase,
    N'SELECT    @QuotedKeyColumns = CASE WHEN [ic].[is_included_column] = 0 
									THEN CONCAT(COALESCE(@QuotedKeyColumns COLLATE DATABASE_DEFAULT + '', '', ''''), QUOTENAME([ac].[name]))
									ELSE @QuotedKeyColumns
                                    END,
	            @QuotedInclColumns = CASE WHEN [ic].[is_included_column] = 1
									THEN CONCAT(COALESCE(@QuotedInclColumns COLLATE DATABASE_DEFAULT + '', '', ''''), QUOTENAME([ac].[name]))
									ELSE @QuotedInclColumns
                                    END 
    FROM [sys].[indexes] AS [i] 
        INNER JOIN [sys].[index_columns] AS [ic] ON [i].[index_id] = [ic].[index_id]
            AND [ic].object_id = [i].object_id
        INNER JOIN [sys].[all_columns] AS [ac] ON [ac].[object_id] = [ic].[object_id]
            AND [ac].[column_id] = [ic].[column_id]
    WHERE [i].[name] = @IndexName
        AND [i].[object_id] = @ObjectID 
        AND [i].[is_hypothetical] = 1;');
    SET @ParmDefinition = N'@IndexName SYSNAME, @ObjectID INT, @QuotedKeyColumns NVARCHAR(2048) OUTPUT, @QuotedInclColumns NVARCHAR(2048) OUTPUT';
	EXEC sp_executesql @Sql
		,@ParmDefinition
		,@IndexName
        ,@ObjectID
        ,@QuotedKeyColumns OUTPUT
        ,@QuotedInclColumns OUTPUT;

    -- Search missing index dmv for a match
    SELECT 'Missing index stats' AS [description]
        ,[statement] 
        ,[equality_columns] 
        ,[inequality_columns] 
        ,[included_columns] 
        ,[unique_compiles] 
        ,[user_seeks]
        ,[user_scans] 
        ,[avg_total_user_cost]
        ,[avg_user_impact] 
    FROM ##TempMissingIndex
    WHERE COALESCE([equality_columns] + ', ', '') + [inequality_columns] = @QuotedKeyColumns
        AND ([included_columns] = @QuotedInclColumns OR [included_columns] IS NULL);

    IF (SELECT COUNT(*) FROM ##TempMissingIndex) = 0 AND (@Verbose = 1)
        BEGIN;
            SET @Msg = 'No matching missing index statistics found.';
            RAISERROR(@Msg, 10, 1) WITH NOWAIT;
        END;

    DROP TABLE ##TempMissingIndex;

    /************************************************/
    /* Estimate index size - does NOT consider:     */
    /* Partitioning, allocation pages, LOB values,  */
    /* compression, or sparse columns               */
    /************************************************/ 
    IF (@IndexType = 'NONCLUSTERED') -- http://dba-multitool.org/est-nonclustered-index-size
    BEGIN;
        DECLARE @NumVariableKeyCols INT = 0
            ,@MaxVarKeySize BIGINT = 0
            ,@NumFixedKeyCols INT = 0
            ,@FixedKeySize BIGINT = 0
            ,@NumKeyCols INT = 0
            ,@NullCols INT = 0
            ,@IndexNullBitmap BIGINT = 0
            ,@VariableKeySize BIGINT = 0
            ,@TotalFixedKeySize BIGINT = 0
            ,@IndexRowSize BIGINT = 0
            ,@IndexRowsPerPage BIGINT = 0
            ,@ClusterNumVarKeyCols INT = 0
            ,@MaxClusterVarKeySize BIGINT = 0
            ,@ClusterNumFixedKeyCols INT = 0
            ,@MaxClusterFixedKeySize BIGINT = 0
            ,@ClusterNullCols INT = 0;

        /**************************/
        /* 1. Calculate variables */
        /**************************/
        -- Row count
        SET @Sql = CONCAT(@UseDatabase,
        N'SELECT @NumRows = [sp].[rows] -- Accounts for index filter if in use
        FROM [sys].[objects] AS [o]   
            INNER JOIN [sys].[stats] AS [stat] ON [stat].[object_id] = [o].[object_id]  
            CROSS APPLY [sys].[dm_db_stats_properties]([stat].[object_id], [stat].[stats_id]) AS [sp]  
        WHERE [o].[object_id] = @ObjectID
            AND [stat].[name] = @IndexName;');
        SET @ParmDefinition = N'@ObjectID INT, @IndexName SYSNAME, @NumRows BIGINT OUTPUT';
	    EXEC sp_executesql @Sql
		,@ParmDefinition
		,@ObjectID
        ,@IndexName
        ,@NumRows OUTPUT;

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('NumRows: ', @NumRows);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        --Key types and sizes
        SET @Sql = CONCAT(@UseDatabase,
        N'SELECT @NumVariableKeyCols = ISNULL(SUM(CASE
                    WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                    THEN 1
                    ELSE 0
                END), 0),
            @MaxVarKeySize = ISNULL(SUM(CASE
                    WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                    THEN CASE [ac].[max_length]
                                WHEN -1
                                THEN(4000 + 2) -- use same estimation as the query engine for max lenths
                                ELSE COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                            END
                    ELSE 0
                END), 0), 
            @NumFixedKeyCols = ISNULL(SUM(CASE
                    WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                    THEN 1
                    ELSE 0
                END), 0), 
            @FixedKeySize = ISNULL(SUM(CASE
                    WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                    THEN COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                    ELSE 0
                END), 0),
            @NullCols = ISNULL(SUM(CAST([ac].[is_nullable] AS TINYINT)),0)
        FROM [sys].[indexes] AS [i]
            INNER JOIN [sys].[index_columns] AS [ic] ON [i].[index_id] = [ic].[index_id]
                AND [ic].object_id = [i].object_id
            INNER JOIN [sys].[all_columns] AS [ac] ON [ac].object_id = [ic].object_id
                AND [ac].[column_id] = [ic].[column_id]
        WHERE [i].[name] = @IndexName
            AND [i].[object_id] = @ObjectID
            AND [i].[is_hypothetical] = 1
            AND [ic].[is_included_column] = 0');
        SET @ParmDefinition = N'@IndexName SYSNAME, @ObjectID INT, @NumVariableKeyCols INT OUTPUT,
            @MaxVarKeySize BIGINT OUTPUT, @NumFixedKeyCols INT OUTPUT, @FixedKeySize BIGINT OUTPUT,
            @NullCols INT OUTPUT';
	    EXEC sp_executesql @Sql
		,@ParmDefinition
		,@IndexName
        ,@ObjectID
        ,@NumVariableKeyCols OUTPUT
        ,@MaxVarKeySize OUTPUT
        ,@NumFixedKeyCols OUTPUT
        ,@FixedKeySize OUTPUT
        ,@NullCols OUTPUT;

        SET @NumKeyCols = @NumVariableKeyCols + @NumFixedKeyCols;

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('NumVariableKeyCols: ', @NumVariableKeyCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('MaxVarKeySize: ', @MaxVarKeySize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NumFixedKeyCols: ', @NumFixedKeyCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('FixedKeySize: ', @FixedKeySize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NullCols: ', @NullCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NumKeyCols: ', @NumKeyCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Account for data row locator for non-unique
        IF (@IsHeap = 1 AND @IsUnique = 0)
            BEGIN;
                SET @NumKeyCols = @NumKeyCols + 1;
                SET @NumVariableKeyCols = @NumVariableKeyCols + 1;
                SET @MaxVarKeySize = @MaxVarKeySize + 8; --heap RID
            END;
        ELSE IF (@IsHeap = 0 AND @IsUnique = 0)
            BEGIN;
                --Clustered keys and sizes not included in the new index
                SET @Sql = CONCAT(@UseDatabase,
                N'WITH NewIndexCol AS (
                    SELECT [ac].[name]
                    FROM [sys].[indexes] AS [i]
                        INNER JOIN [sys].[index_columns] AS [ic] ON [i].[index_id] = [ic].[index_id]
                            AND [ic].object_id = [i].object_id
                        INNER JOIN [sys].[all_columns] AS [ac] ON [ac].object_id = [ic].object_id
                            AND [ac].[column_id] = [ic].[column_id]
                    WHERE [i].[name] = @IndexName
                        AND [i].[object_id] = @ObjectID
                        AND [i].[is_hypothetical] = 1
                        AND [ic].[is_included_column] = 0
                )
                SELECT @ClusterNumVarKeyCols = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN 1
                            ELSE 0
                        END), 0),
                    @MaxClusterVarKeySize = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN CASE [ac].[max_length]
                                        WHEN -1
                                        THEN(4000 + 2) -- use same estimation as the query engine for max lenths
                                        ELSE COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                                    END
                            ELSE 0
                        END), 0), 
                    @ClusterNumFixedKeyCols = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN 1
                            ELSE 0
                        END), 0), 
                    @MaxClusterFixedKeySize = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                            ELSE 0
                        END), 0),
                    @ClusterNullCols = ISNULL(SUM(CAST([ac].[is_nullable] AS TINYINT)),0)
                FROM [sys].[indexes] AS [i]
                    INNER JOIN [sys].[index_columns] AS [ic] ON [i].[index_id] = [ic].[index_id]
                        AND [ic].object_id = [i].object_id
                    INNER JOIN [sys].[all_columns] AS [ac] ON [ac].object_id = [ic].object_id
                        AND [ac].[column_id] = [ic].[column_id]
                WHERE [i].[type] = 1 --Clustered
                    AND [i].[object_id] = @ObjectID
                    AND [ac].[name] NOT IN (SELECT [name] FROM [NewIndexCol]);');
                SET @ParmDefinition = N'@IndexName SYSNAME, @ObjectID INT, @ClusterNumVarKeyCols INT OUTPUT,
                    @MaxClusterVarKeySize BIGINT OUTPUT, @ClusterNumFixedKeyCols INT OUTPUT,
                    @MaxClusterFixedKeySize BIGINT OUTPUT, @ClusterNullCols INT OUTPUT';
                EXEC sp_executesql @Sql
                ,@ParmDefinition
                ,@IndexName
                ,@ObjectID
                ,@ClusterNumVarKeyCols OUTPUT
                ,@MaxClusterVarKeySize OUTPUT
                ,@ClusterNumFixedKeyCols OUTPUT
                ,@MaxClusterFixedKeySize OUTPUT
                ,@ClusterNullCols OUTPUT;

                IF (@Verbose = 1)
                    BEGIN
                        SET @Msg = CONCAT('ClusterNumVarKeyCols: ', @ClusterNumVarKeyCols);
                        RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                        SET @Msg = CONCAT('ClusterNumFixedKeyCols: ', @ClusterNumFixedKeyCols);
                        RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                        SET @Msg = CONCAT('MaxClusterVarKeySize: ', @MaxClusterVarKeySize);
                        RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                        SET @Msg = CONCAT('MaxClusterFixedKeySize: ', @MaxClusterFixedKeySize);
                        RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                        SET @Msg = CONCAT('ClusterNullCols: ', @ClusterNullCols);
                        RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                    END;

                -- Add counts from clustered index cols 
                SET @NumKeyCols = @NumKeyCols + (@ClusterNumVarKeyCols + @ClusterNumFixedKeyCols);
                SET @FixedKeySize = @FixedKeySize + @MaxClusterFixedKeySize;
                SET @NumVariableKeyCols = @NumVariableKeyCols + @ClusterNumVarKeyCols;
                SET @MaxVarKeySize = @MaxVarKeySize + @MaxClusterVarKeySize;
                SET @NullCols = @NullCols + @ClusterNullCols;

                IF (@IsClusterUnique = 0)
                    BEGIN;
                        SET @MaxVarKeySize = @MaxVarKeySize + 4;
                        SET @NumVariableKeyCols = @NumVariableKeyCols + 1;
                        SET @NumKeyCols = @NumKeyCols + 1;
                    END;
            END;

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('FixedKeySize: ', @FixedKeySize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NumVariableKeyCols: ', @NumVariableKeyCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NumKeyCols: ', @NumKeyCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('MaxVarKeySize: ', @MaxVarKeySize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NullCols: ', @NullCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Account for index null bitmap
        IF (@NullCols > 0)
            BEGIN;
                SET @IndexNullBitmap = 2 + ((@NullCols + 7) / 8);
            END;
 
        -- Calculate variable length data size
        -- Assumes each col is 100% full
        IF (@NumVariableKeyCols > 0)
            BEGIN;
                SET @VariableKeySize = 2 + (@NumVariableKeyCols * 2) + @MaxVarKeySize; --The bytes added to @MaxVarKeySize are for tracking each variable column.
            END;

        -- Calculate index row size
        SET @IndexRowSize = @FixedKeySize + @VariableKeySize + @IndexNullBitmap + 1 + 6; -- + 1 (for row header overhead of an index row) + 6 (for the child page ID pointer)

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('IndexRowSize: ', @IndexRowSize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        --Calculate number of index rows / page
        SET @IndexRowsPerPage = FLOOR(@FreeBytesPerPage / (@IndexRowSize + 2)); -- + 2 for the row's entry in the page's slot array.

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('IndexRowsPerPage: ', @IndexRowsPerPage);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        /****************************************************************************/
        /* 2. Calculate the Space Used to Store Index Information in the Leaf Level */
        /****************************************************************************/
        -- Specify the number of fixed-length and variable-length columns at the leaf level
        -- and calculate the space that is required for their storage
        DECLARE @NumLeafCols INT = @NumKeyCols
            ,@FixedLeafSize BIGINT = @FixedKeySize
            ,@NumVariableLeafCols INT = @NumVariableKeyCols
            ,@MaxVarLeafSize BIGINT = @MaxVarKeySize
            ,@LeafNullBitmap BIGINT = 0
            ,@VariableLeafSize BIGINT = 0
            ,@LeafRowSize BIGINT = 0
            ,@LeafRowsPerPage BIGINT = 0
            ,@FreeRowsPerPage BIGINT = 0
            ,@NumLeafPages BIGINT = 0
            ,@LeafSpaceUsed BIGINT = 0;

        IF (@IncludeColumns IS NOT NULL)
            BEGIN;
                DECLARE @NumVariableInclCols INT = 0
                    ,@MaxVarInclSize BIGINT = 0
                    ,@NumFixedInclCols INT = 0
                    ,@FixedInclSize BIGINT = 0;

                --Incl types and sizes
                SET @Sql = CONCAT(@UseDatabase,
                N'SELECT @NumVariableInclCols = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN 1
                            ELSE 0
                        END), 0),
                    @MaxVarInclSize = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN CASE [ac].[max_length]
                                        WHEN -1
                                        THEN (4000 + 2) -- use same estimation as the query engine for max lenths
                                        ELSE COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                                    END
                            ELSE 0
                        END), 0), 
                    @NumFixedInclCols = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN 1
                            ELSE 0
                        END), 0), 
                    @FixedInclSize = ISNULL(SUM(CASE
                            WHEN TYPE_NAME([ac].[user_type_id]) NOT IN(''varchar'', ''nvarchar'', ''text'', ''ntext'', ''image'', ''varbinary'', ''xml'')
                            THEN COL_LENGTH(OBJECT_NAME([i].object_id), [ac].[name])
                            ELSE 0
                        END), 0)
                FROM [sys].[indexes] AS [i]
                    INNER JOIN [sys].[index_columns] AS [ic] ON [i].[index_id] = [ic].[index_id]
                        AND [ic].object_id = [i].object_id
                    INNER JOIN [sys].[all_columns] AS [ac] ON [ac].object_id = [ic].object_id
                        AND [ac].[column_id] = [ic].[column_id]
                WHERE [i].[name] = @IndexName
                    AND [i].[object_id] = @ObjectID
                    AND [i].[is_hypothetical] = 1
                    AND [ic].[is_included_column] = 1;');
                SET @ParmDefinition = N'@IndexName SYSNAME, @ObjectID INT, @NumVariableInclCols INT OUTPUT,
                    @MaxVarInclSize BIGINT OUTPUT, @NumFixedInclCols INT OUTPUT, @FixedInclSize BIGINT OUTPUT';
                EXEC sp_executesql @Sql
                ,@ParmDefinition
                ,@IndexName
                ,@ObjectID
                ,@NumVariableInclCols OUTPUT
                ,@MaxVarInclSize OUTPUT
                ,@NumFixedInclCols OUTPUT
                ,@FixedInclSize OUTPUT;

                -- Add included columns to rolling totals
                SET @NumLeafCols = @NumLeafCols + (@NumVariableInclCols + @NumFixedInclCols);
                SET @FixedLeafSize = @FixedLeafSize + @FixedInclSize;
                SET @NumVariableLeafCols = @NumVariableLeafCols + @NumVariableInclCols;
                SET @MaxVarLeafSize = @MaxVarLeafSize + @MaxVarInclSize;
            END;
        
        -- Account for data row locator for unique indexes
        -- If non-unique, already accounted for above
        IF (@IsUnique = 1)
            BEGIN;
                IF (@IsHeap = 1)
                    BEGIN;
                        SET @NumLeafCols = @NumLeafCols + 1;
                        SET @NumVariableLeafCols = @NumVariableLeafCols + 1;
                        SET @MaxVarLeafSize = @MaxVarLeafSize + 8; -- the data row locator is the heap RID (size 8 bytes).
                    END;
                ELSE -- Clustered
                    BEGIN;
                        SET @NumLeafCols = @NumLeafCols + (@ClusterNumVarKeyCols + @ClusterNumFixedKeyCols);
                        SET @FixedLeafSize = @FixedLeafSize + @ClusterNumFixedKeyCols;
                        SET @NumVariableLeafCols = @NumVariableLeafCols + @ClusterNumVarKeyCols;
                        SET @MaxVarLeafSize = @MaxVarLeafSize + @MaxClusterVarKeySize;

                        IF (@IsClusterUnique = 0)
                            BEGIN;
                                SET @NumLeafCols = @NumLeafCols + 1;
                                SET @NumVariableLeafCols = @NumVariableLeafCols + 1;
                                SET @MaxVarLeafSize = @MaxVarLeafSize + 4;
                            END;
                    END;
            END; 

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('NumLeafCols: ', @NumLeafCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('FixedLeafSize: ', @FixedLeafSize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('NumVariableLeafCols: ', @NumVariableLeafCols);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
                SET @Msg = CONCAT('MaxVarLeafSize: ', @MaxVarLeafSize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;
        
        -- Account for index null bitmap
        SET @LeafNullBitmap = 2 + ((@NumLeafCols + 7) / 8);

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('LeafNullBitmap: ', @LeafNullBitmap);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate variable length data size
        -- Assumes each col is 100% full
        IF (@NumVariableLeafCols > 0)
            BEGIN;
                SET @VariableLeafSize = 2 + (@NumVariableLeafCols * 2) + @MaxVarLeafSize;
            END;

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('VariableLeafSize: ', @VariableLeafSize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate index row size
        SET @LeafRowSize = @FixedLeafSize + @VariableLeafSize + @LeafNullBitmap + 1; -- +1 for row header overhead of an index row)

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('LeafRowSize: ', @LeafRowSize);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate number of index rows / page
        SET @LeafRowsPerPage = FLOOR(@FreeBytesPerPage / (@LeafRowSize + 2)); -- + 2 for the row's entry in the page's slot array.

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('LeafRowsPerPage: ', @LeafRowsPerPage);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate free rows / page
        SET @FreeRowsPerPage = @FreeBytesPerPage * (( 100 - @FillFactor) / 100) / (@LeafRowSize + 2); -- + 2 for the row's entry in the page's slot array.

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('FreeRowsPerPage: ', @FreeRowsPerPage);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate pages for all rows
        SET @NumLeafPages = CEILING(@NumRows / (@LeafRowsPerPage - @FreeRowsPerPage));

        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('NumLeafPages: ', @NumLeafPages);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        -- Calculate size of index at leaf level
        SET @LeafSpaceUsed = @PageSize * @NumLeafPages;

        /*********************************************************************************/
        /* 3. Calculate the Space Used to Store Index Information in the Non-leaf Levels */
        /*********************************************************************************/
        DECLARE @NonLeafLevels BIGINT = 0,
            @NumIndexPages BIGINT = 0,
            @IndexSpaceUsed BIGINT = 0;

        -- Calculate the number of non-leaf levels in the index
        SET @NonLeafLevels = CEILING(1 + LOG(@IndexRowsPerPage) * (@NumLeafPages / @IndexRowsPerPage));
        
        IF (@Verbose = 1)
            BEGIN
                SET @Msg = CONCAT('NonLeafLevels: ', @NonLeafLevels);
                RAISERROR(@Msg, 10, 1) WITH NOWAIT;
            END;

        --Formula: IndexPages = Summation (Num_Leaf_Pages/Index_Rows_Per_Page^Level)where 1 <= Level <= Levels
        WHILE (@NonLeafLevels > 1)
            BEGIN
                DECLARE @TempIndexPages FLOAT(30);

                -- TempIndexPages may be exceedingly small, so catch any arith overflows and call it 0
                BEGIN TRY;
                    SET @TempIndexPages = @NumLeafPages / POWER(@IndexRowsPerPage, @NonLeafLevels);
                    SET @NumIndexPages = @NumIndexPages + @TempIndexPages;
                    SET @NonLeafLevels = @NonLeafLevels - 1;
                END TRY
                BEGIN CATCH;
                    SET @NonLeafLevels = @NonLeafLevels - 1;
                END CATCH;
            END;
        
        -- Calculate size of the index
        SET @IndexSpaceUsed = @PageSize * @NumIndexPages;

        /**************************************/
        /* 4. Total index and leaf space used */
        /**************************************/
        DECLARE @Total BIGINT = 0;

        SET @Total = @LeafSpaceUsed + @IndexSpaceUsed;

        SELECT @Total/1024 AS [Est. KB]
            ,CAST(ROUND(@Total/1024.0/1024.0,2,1) AS DECIMAL(30,2)) AS [Est. MB]
            ,CAST(ROUND(@Total/1024.0/1024.0/1024.0,2,1) AS DECIMAL(30,4)) AS [Est. GB];
    END;

    --Cleanup
    EXEC sp_executesql @DropIndexSql;

END TRY
BEGIN CATCH;
    BEGIN;
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorLine INT = ERROR_LINE();
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        EXEC sp_executesql @DropIndexSql;

        SET @ErrorMessage = CONCAT(QUOTENAME(OBJECT_NAME(@@PROCID)), ': ', @ErrorMessage);
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState) WITH NOWAIT;
    END;
END CATCH;

END;
GO

EXEC sys.sp_addextendedproperty @name=N'@DatabaseName', @value=N'Target database of the index''s table.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@FillFactor', @value=N'Optional fill factor for the index. Default is 100.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@Filter', @value=N'Optional filter for the index.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@IncludeColumns', @value=N'Optional comma separated list of include columns.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@IndexColumns', @value=N'Comma separated list of key columns.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@IsUnique', @value=N'Whether or not the index is UNIQUE. Default is 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@SchemaName', @value=N'Target schema of the index''s table. Default is ''dbo''.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@SqlMajorVersion', @value=N'For unit testing only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@TableName', @value=N'Target table for the index. Default is current database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Estimate a new index''s size and statistics.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO

EXEC sys.sp_addextendedproperty @name=N'@Verbose', @value=N'Show intermediate variables used in size calculations. Default is 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_estindex';
GO
