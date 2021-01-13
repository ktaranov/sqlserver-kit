SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'Description' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SqlMinorVersion' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@SqlMinorVersion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SqlMajorVersion' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@SqlMajorVersion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@ExtendedPropertyName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@ExtendedPropertyName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@DatabaseName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@DatabaseName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@LimitStoredProcLength' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@LimitStoredProcLength' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@Emojis' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@Emojis' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@Verbose' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_doc', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@Verbose' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
	END
GO

/***************************/
/* Create stored procedure */
/***************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_doc]') AND [type] IN (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_doc] AS';
END
GO

ALTER PROCEDURE [dbo].[sp_doc]
	@DatabaseName SYSNAME = NULL
	,@ExtendedPropertyName SYSNAME = 'Description'
	,@LimitStoredProcLength BIT = 1
	,@Emojis BIT = 0
	,@Verbose BIT = 1
	/* Parameters defined here for testing only */
	,@SqlMajorVersion TINYINT = 0
	,@SqlMinorVersion SMALLINT = 0
WITH RECOMPILE
AS

/*
sp_doc - Always have current documentation by generating it on the fly in markdown.

Part of the DBA MultiTool http://dba-multitool.org

Version: 20201221

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

=========

Example:

	EXEC sp_doc @DatabaseName = 'WideWorldImporters';

*/

BEGIN
	SET NOCOUNT ON;

	DECLARE @Sql NVARCHAR(MAX)
		,@ParmDefinition NVARCHAR(500)
		,@QuotedDatabaseName SYSNAME
		,@Msg NVARCHAR(MAX)
		,@SensitivityClassification BIT
		-- Variables used for Emoji mode
		,@Yes VARCHAR(20) = 'yes'
		,@No VARCHAR(20) = 'no'
		,@PK VARCHAR(20) = NULL
		,@FK VARCHAR(20) = NULL
		,@Column VARCHAR(20) = NULL;

	-- Find Version
	IF (@SqlMajorVersion = 0)
		BEGIN;
			SET @SqlMajorVersion = CAST(SERVERPROPERTY('ProductMajorVersion') AS TINYINT);
		END;
	IF (@SqlMinorVersion = 0)
		BEGIN;
			SET @SqlMinorVersion = CAST(SERVERPROPERTY('ProductMinorVersion') AS TINYINT);
		END;

	-- Validate Version
	IF (@SqlMajorVersion < 11)
		BEGIN;
			SET @Msg = 'SQL Server versions below 2012 are not supported, sorry!';
			RAISERROR(@Msg, 16, 1);
		END;

	-- Check database name
	IF (@DatabaseName IS NULL)
		BEGIN
			SET @DatabaseName = DB_NAME();
			IF (@Verbose = 1)
				BEGIN;
					SET @Msg = 'No database provided, assuming current database.';
					RAISERROR(@Msg, 10, 1) WITH NOWAIT;
				END;
		END
	ELSE IF (DB_ID(@DatabaseName) IS NULL)
		BEGIN;
			SET @Msg = 'Database not available.';
			RAISERROR(@Msg, 16, 1);
		END;

	SET @QuotedDatabaseName = QUOTENAME(@DatabaseName); --Avoid injections

	-- Check Emoji Mode
	IF (@Emojis = 1)
		BEGIN;
			SET @Yes = ':heavy_check_mark:';
			SET @No = ':x:';
			SET @PK = ':key: ';
			SET @FK = ':old_key: ';
			SET @Column = ':page_facing_up: ';
		END;

	-- Check for Sensitivity Classifications
	IF EXISTS (SELECT 1 FROM [sys].[system_views] WHERE [name] = 'sensitivity_classifications')
		BEGIN
			SET @Sql = N'USE ' + @QuotedDatabaseName + ';
				IF EXISTS (SELECT 1 FROM [sys].[sensitivity_classifications])
					BEGIN
						SET @SensitivityClassification = 1;
					END;
				ELSE
					BEGIN
						SET @SensitivityClassification = 0;
					END;';
			SET @ParmDefinition = N'@SensitivityClassification BIT OUTPUT';
			EXEC sp_executesql @Sql
				,@ParmDefinition
				,@SensitivityClassification OUTPUT;
		END;

	--Create table to hold EP data
	SET @Sql = N'USE ' + @QuotedDatabaseName + ';
	CREATE TABLE #markdown (
	   [id] INT IDENTITY(1,1),
	   [value] NVARCHAR(MAX));';

	/******************************
	Generate markdown for database
	******************************/
	--Database Name
	SET @Sql = @Sql + N'
	INSERT INTO #markdown (value)
	VALUES (CONCAT(''# '', @DatabaseName) COLLATE DATABASE_DEFAULT);' +

	--Database extended properties
	+ N'INSERT INTO #markdown (value)
		SELECT CONCAT(CHAR(13), CHAR(10), CAST([value] AS VARCHAR(8000)))
		FROM [sys].[extended_properties] AS [ep]
		WHERE [ep].[class] = 0
			AND [ep].[name] = @ExtendedPropertyName;' +

	--Database metadata
	+ N'INSERT INTO #markdown (value)
		VALUES (CONCAT(CHAR(13), CHAR(10), ''| Property | Value |''))
		,(''| --- | --- |'');

		INSERT INTO #markdown
		SELECT CONCAT(''| '', ''SQL Server Version'', '' | '', CAST(SERVERPROPERTY(''ProductVersion'') AS SYSNAME), '' |'')
		UNION ALL
		SELECT CONCAT(''| '', ''Compatibility Level'', '' | '', [compatibility_level], '' |'')
		FROM [sys].[databases]
		WHERE [name] = DB_NAME()
		UNION ALL
		SELECT CONCAT(''| '', ''Collation'', '' | '', [collation_name], '' |'')
		FROM [sys].[databases]
		WHERE [name] = DB_NAME();
		' +

	/****************************
	Generate markdown for tables
	****************************/
	--Variables
	+ N'DECLARE @objectid INT,
		@indexobjectid INT,
		@TrigObjectId INT,
		@CheckConstObjectId INT,
		@DefaultConstObjectId INT;

		DECLARE @key_columns NVARCHAR(MAX),
		@include_columns NVARCHAR(MAX);';

	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[tables] WHERE [type] = ''U'' AND [is_ms_shipped] = 0)
	BEGIN
		INSERT INTO #markdown (value)
		VALUES (''----'')
			,(CONCAT(CHAR(13), CHAR(10), ''## Tables''))
			,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown (value)
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[tables]
		WHERE [type] = ''U''
			AND [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[tables]
		WHERE [type] = ''U''
			AND [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid));' +

			--Extended Properties
			+ N'INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), CAST([ep].[value] AS NVARCHAR(4000)))
			FROM [sys].[tables] AS [t] WITH(NOLOCK)
				INNER JOIN [sys].[extended_properties] AS [ep] WITH(NOLOCK) ON [t].[object_id] = [ep].[major_id]
			WHERE [t].[object_id] = @objectid
				AND [ep].[minor_id] = 0 --On the table
				AND [ep].[name] = @ExtendedPropertyName;';


			IF @SensitivityClassification = 1
				BEGIN
					SET @Sql = @Sql + N'
					INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''| Column | Type | Null | Foreign Key | Default | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' | Classification |''))
					,(''| --- | --- | --- | --- | --- | --- | --- |'');';
				END
			ELSE
				BEGIN
				SET @Sql = @Sql + N'
					INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''| Column | Type | Null | Foreign Key | Default | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' |''))
					,(''| --- | --- | --- | --- | --- | --- |'');';
				END;

			--Columns
			SET @Sql = @Sql + N'
			INSERT INTO #markdown
			SELECT CONCAT(''| ''
                    ,CASE
                        WHEN [ic].[object_id] IS NOT NULL
                        THEN CONCAT(@PK, ''**'',[c].[name],''**'')
						WHEN [fk].[parent_object_id] IS NOT NULL
						THEN CONCAT(@FK, [c].[name])
                        ELSE CONCAT(@Column, [c].[name])
                    END
					,'' | ''
					,CONCAT(UPPER(TYPE_NAME([user_type_id]))
					,CASE
							WHEN TYPE_NAME([user_type_id]) IN (N''decimal'',N''numeric'')
							THEN CONCAT(N''('',CAST(precision AS varchar(5)), N'','',CAST(scale AS varchar(5)), N'')'')
							WHEN TYPE_NAME([user_type_id]) IN (''varchar'', ''char'', ''varbinary'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
								END
							WHEN TYPE_NAME([user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
							THEN QUOTENAME(CAST(scale AS varchar(5)), ''('')
							WHEN TYPE_NAME([user_type_id]) in (N''float'')
							THEN CASE
									WHEN [c].precision = 53
									THEN N''''
									ELSE CONCAT(N''('',CAST([c].precision AS varchar(5)),N'')'')
								END
							WHEN TYPE_NAME([c].user_type_id) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
								N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
								N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'')
							THEN N''''
							WHEN TYPE_NAME([user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length]/2 AS VARCHAR(10)), ''('')
								END
							ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
					END)
					,'' | ''
					,CASE [c].[is_nullable]
						WHEN 1
						THEN @Yes
						ELSE @No
						END
					,'' | ''
					,CASE
						WHEN [fk].[parent_object_id] IS NOT NULL
						THEN CONCAT(''['',QUOTENAME(OBJECT_SCHEMA_NAME([fk].[referenced_object_id])), ''.'', QUOTENAME(OBJECT_NAME([fk].[referenced_object_id])), ''.'', QUOTENAME(COL_NAME([fk].[referenced_object_id], [fk].[referenced_column_id])),'']'',''(#'',LOWER(OBJECT_SCHEMA_NAME([fk].[referenced_object_id])), LOWER(OBJECT_NAME([fk].[referenced_object_id])), '')'')
						ELSE ''''
                    END
					,'' | ''
					,OBJECT_DEFINITION([dc].[object_id])
					,'' | ''
					,CAST([ep].[value] AS NVARCHAR(4000))
					,'' |''';
					IF @SensitivityClassification = 1
						BEGIN
							SET @Sql = @Sql + N'
							,CASE
								WHEN [sc].[label] IS NOT NULL
								THEN CONCAT('' Label: '', CAST([sc].[Label] AS SYSNAME), '' <br /> '', ''Type: '', CAST([sc].[Information_Type] AS SYSNAME), '' <br /> '', ''Rank: '', CAST([Rank_Desc] AS SYSNAME), '' <br /> '')
								ELSE '' ''
							END
							,'' |''';
						END
					SET @Sql = @Sql + N')';
			SET @Sql = @Sql + N'
			FROM [sys].[tables] AS [t] WITH(NOLOCK)
				INNER JOIN [sys].[columns] AS [c] WITH(NOLOCK) ON [t].[object_id] = [c].[object_id]
				LEFT JOIN [sys].[extended_properties] AS [ep] WITH(NOLOCK) ON [t].[object_id] = [ep].[major_id]
					AND [ep].[minor_id] > 0
					AND [ep].[minor_id] = [c].[column_id]
					AND [ep].[class] = 1 --Object/col
					AND [ep].[name] = @ExtendedPropertyName
				LEFT JOIN [sys].[foreign_key_columns] AS [fk] WITH(NOLOCK) ON [fk].[parent_object_id] = [c].[object_id]
					AND [fk].[parent_column_id] = [c].[column_id]
				LEFT JOIN [sys].[default_constraints] AS [dc] WITH(NOLOCK) ON [dc].[parent_object_id] = [c].[object_id]
					AND [dc].[parent_column_id] = [c].[column_id]
				LEFT JOIN [sys].[indexes] AS [pk] WITH(NOLOCK) ON [pk].[object_id] = [t].[object_id]
					AND [pk].[is_primary_key] = 1
				LEFT JOIN [sys].[index_columns] AS [ic] WITH(NOLOCK) ON [ic].[index_id] = [pk].[index_id]
					AND [ic].[object_id] = [t].[object_id]
					AND [ic].[column_id] = [c].[column_id]';

			IF @SensitivityClassification = 1
				BEGIN
					SET @Sql = @Sql + N'
				LEFT JOIN [sys].[sensitivity_classifications] AS [sc] WITH(NOLOCK) ON [sc].[major_id] = [t].[object_id]
					AND [sc].[minor_id] = [c].[column_id]';
				END;

			SET @Sql = @Sql + N'
			WHERE [t].[object_id] = @objectid;' +

			--Indexes
			+ N'IF EXISTS (SELECT 1 FROM [sys].[indexes] WHERE [object_id] = @objectid AND [type] > 0)
			BEGIN
				INSERT INTO #markdown
				SELECT CONCAT(CHAR(13), CHAR(10), ''#### '', ''Indexes'')
				DECLARE [index_cursor] CURSOR
				LOCAL STATIC READ_ONLY FORWARD_ONLY
				FOR
				SELECT [ind].[index_id]
				FROM [sys].[indexes] AS [ind]
				WHERE [ind].[object_id] = @objectId
					AND [ind].[type] > 0 -- Not heap
				ORDER BY [ind].[is_primary_key] DESC, [ind].[is_unique_constraint] DESC, [ind].[name] DESC

				INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''| Name | Type | Key Columns | Include Columns | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' |''))
					,(''| --- | --- | --- | --- | --- |'');

				OPEN [index_cursor]
				FETCH NEXT FROM [index_cursor] INTO @indexobjectid
				WHILE @@FETCH_STATUS = 0
				BEGIN
				' +

					-- Get key columns as a csv list
					+ N'SELECT @key_columns = STUFF((
							SELECT CONCAT('', '', QUOTENAME([col].[name]))
							FROM [sys].[indexes] AS [ind]
								INNER JOIN [sys].[index_columns] AS [ic] ON [ind].[object_id] = [ic].[object_id]
									AND [ic].[index_id] = [ind].[index_id]
								INNER JOIN [sys].[columns] AS [col] ON [ic].[object_id] = [col].[object_id]
									AND [ic].[column_id] = [col].[column_id]
							WHERE [ind].[object_id] = @objectid
								AND [ind].[index_id] = @indexobjectid
								AND [ic].[is_included_column] = 0
							FOR XML PATH('''')
						), 1, 2, ''''); ' +

					-- Get included columns as a csv list
					+ N'SELECT @include_columns = STUFF((
							SELECT CONCAT('', '', QUOTENAME([col].[name]))
							FROM [sys].[indexes] AS [ind]
								INNER JOIN [sys].[index_columns] AS [ic] ON [ind].[object_id] = [ic].[object_id]
									AND [ic].[index_id] = [ind].[index_id]
								INNER JOIN [sys].[columns] AS [col] ON [ic].[object_id] = [col].[object_id]
									AND [ic].[column_id] = [col].[column_id]
							WHERE [ind].[object_id] = @objectid
								AND [ind].[index_id] = @indexobjectid
								AND [ic].[is_included_column] = 1
							FOR XML PATH('''')
						), 1, 2, '''');

					INSERT INTO #markdown (value)
					SELECT CONCAT(''| ''
						,CASE
							WHEN [ind].[is_primary_key] = 1
                        	THEN CONCAT(@PK, ''**'',[ind].[name],''**'')
							ELSE [ind].[name]
						END
						, '' | ''
						, LOWER([ind].[type_desc]) COLLATE DATABASE_DEFAULT
						, '' | ''
						, @key_columns COLLATE DATABASE_DEFAULT
						, '' | ''
						, @include_columns COLLATE DATABASE_DEFAULT
						, '' | ''
						, CAST([ep].[value] AS NVARCHAR(4000)) COLLATE DATABASE_DEFAULT
						, '' |'')
					FROM [sys].[indexes] AS [ind]
						LEFT JOIN [sys].[extended_properties] AS [ep] ON [ind].[object_id] = [ep].[major_id]
							AND [ep].[minor_id] = [ind].[index_id]
							AND [ep].[class] = 7 -- Index
							AND [ep].[name] = @ExtendedPropertyName
					WHERE [ind].[object_id] = @objectid
						AND [ind].[index_id] = @indexobjectid;

					FETCH NEXT FROM [index_cursor] INTO @indexobjectid;
				END;

				CLOSE [index_cursor];
				DEALLOCATE [index_cursor];
			END;
			' +

			--Triggers
			+ N'IF EXISTS (SELECT * FROM [sys].[triggers] WHERE [parent_id] = @objectid)
			BEGIN
				INSERT INTO #markdown
				SELECT CONCAT(CHAR(13), CHAR(10), ''#### '', ''Triggers'')
				DECLARE [trig_cursor] CURSOR
				LOCAL STATIC READ_ONLY FORWARD_ONLY
				FOR
				SELECT [object_id]
				FROM [sys].[triggers]
				WHERE [parent_id] = @objectId
				ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

				OPEN [trig_cursor]
				FETCH NEXT FROM [trig_cursor] INTO @TrigObjectId
				WHILE @@FETCH_STATUS = 0
				BEGIN
					INSERT INTO #markdown (value)
					VALUES (CONCAT(''##### '', OBJECT_SCHEMA_NAME(@TrigObjectId), ''.'', OBJECT_NAME(@TrigObjectId)))
						,(CONCAT(''###### '', ''Definition''))
						,(CONCAT(''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));' +

					--Object definition
					+ N'INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
						CHAR(13), CHAR(10), OBJECT_DEFINITION(@CheckConstObjectId)))
						,(''```'');

					INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))

					FETCH NEXT FROM [trig_cursor] INTO @TrigObjectId;
				END;

				CLOSE [trig_cursor];
				DEALLOCATE [trig_cursor];
			END;' +

			--Check Constraints
			+ N'IF EXISTS (SELECT 1 FROM [sys].[check_constraints] WHERE [parent_object_id] = @objectid)
			BEGIN
				INSERT INTO #markdown
				SELECT CONCAT(CHAR(13), CHAR(10), ''#### '', ''Check Constraints'')
				DECLARE [check_cursor] CURSOR
				LOCAL STATIC READ_ONLY FORWARD_ONLY
				FOR
				SELECT [object_id]
				FROM [sys].[check_constraints]
				WHERE [parent_object_id] = @objectid
				ORDER BY OBJECT_SCHEMA_NAME(object_id), [name] ASC;

				OPEN [check_cursor]
				FETCH NEXT FROM [check_cursor] INTO @CheckConstObjectId
				WHILE @@FETCH_STATUS = 0
				BEGIN
					INSERT INTO #markdown
					VALUES (CONCAT(CHAR(13), CHAR(10),''##### '', OBJECT_SCHEMA_NAME(@CheckConstObjectId), ''.'', OBJECT_NAME(@CheckConstObjectId)))
						,(CONCAT(CHAR(13), CHAR(10),''###### '', ''Definition''))
						,(CONCAT(CHAR(13), CHAR(10),''<details><summary>Click to expand</summary>''));' +

					--Object definition
					+ N'INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
						CHAR(13), CHAR(10), OBJECT_DEFINITION(@CheckConstObjectId)))
						,(''```'');

					INSERT INTO #markdown
					VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))

					FETCH NEXT FROM [check_cursor] INTO @CheckConstObjectId;
				END;

				CLOSE [check_cursor];
				DEALLOCATE [check_cursor];
			END;' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''))

			FETCH NEXT FROM obj_cursor INTO @objectid;

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible table section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for tables

	/***************************
	Generate markdown for views
	***************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[views] WHERE [is_ms_shipped] = 0)
	BEGIN;
		INSERT INTO #markdown (value)
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## Views'')) ,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown (value)
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[views]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[views]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid));' +

			--Extended Properties
			+ N'INSERT INTO #markdown
			SELECT CAST([ep].[value] AS NVARCHAR(4000))
			FROM [sys].[views] AS [v]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [v].[object_id] = [ep].[major_id]
			WHERE [v].[object_id] = @objectid
				AND [ep].[minor_id] = 0
				AND [ep].[name] = @ExtendedPropertyName;

			INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''| Column | Type | Null | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' |''))
				,(''| --- | ---| --- | --- |'');' +

			--Projected columns
			+ N'INSERT INTO #markdown
			SELECT CONCAT(''| '', [c].[name]
					,'' | ''
					,CONCAT(UPPER(TYPE_NAME([user_type_id]))
					,CASE
						WHEN TYPE_NAME([user_type_id]) IN (N''decimal'',N''numeric'')
						THEN CONCAT(N''('',CAST(precision AS varchar(5)), N'','',CAST(scale AS varchar(5)), N'')'')
						WHEN TYPE_NAME([user_type_id]) IN (''varchar'', ''char'', ''varbinary'')
						THEN CASE
								WHEN [max_length] = -1
								THEN N''(MAX)''
								ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
							END
						WHEN TYPE_NAME([user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
						THEN QUOTENAME(CAST(scale AS varchar(5)), ''('')
						WHEN TYPE_NAME([user_type_id]) in (N''float'')
						THEN CASE
								WHEN [c].precision = 53
								THEN N''''
								ELSE CONCAT(N''('',CAST([c].precision AS varchar(5)),N'')'')
							END
						WHEN TYPE_NAME([c].user_type_id) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
							N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
							N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'')
						THEN N''''
						WHEN TYPE_NAME([user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
						THEN CASE
								WHEN [max_length] = -1
								THEN N''(MAX)''
								ELSE QUOTENAME(CAST([max_length]/2 AS VARCHAR(10)), ''('')
							END
						ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
					END)
					,'' | ''
					,CASE [c].[is_nullable]
						WHEN 1
						THEN @Yes
						ELSE @No
						END
					,'' | ''
					,CAST([ep].[value] AS NVARCHAR(4000))
					,'' |'')
			FROM [sys].[views] AS [o]
				INNER JOIN [sys].[columns] AS [c] ON [o].[object_id] = [c].[object_id]
				LEFT JOIN [sys].[extended_properties] AS [ep] ON [o].[object_id] = [ep].[major_id]
					AND [ep].[minor_id] = [c].[column_id]
					AND [ep].[name] = @ExtendedPropertyName
			WHERE [o].[is_ms_shipped] = 0	-- User objects only
				AND [o].[type] = ''V''		-- VIEW
				AND [o].[object_id] = @objectid
			ORDER BY SCHEMA_NAME([o].[schema_id]), [o].[type_desc], OBJECT_NAME([ep].major_id);

			INSERT INTO #markdown (value)
			VALUES(CONCAT(CHAR(13), CHAR(10), ''#### Definition''))
				,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>''));' +

			--Object definition
			+ N'INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
				CHAR(13), CHAR(10), OBJECT_DEFINITION(@objectid)))
				,(''```'');' +

			--Indexes
			+ N'IF EXISTS (SELECT 1 FROM [sys].[indexes] WHERE [object_id] = @objectid)
			BEGIN
				INSERT INTO #markdown
				SELECT CONCAT(CHAR(13), CHAR(10), ''#### '', ''Indexes'')
				DECLARE [index_cursor] CURSOR
				LOCAL STATIC READ_ONLY FORWARD_ONLY
				FOR
				SELECT [ind].[index_id]
				FROM [sys].[indexes] AS [ind]
				WHERE [ind].[object_id] = @objectId
					AND [ind].[type] > 0 -- Not heap
				ORDER BY [ind].[is_primary_key] DESC, [ind].[is_unique_constraint] DESC, [ind].[name] DESC

				INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''| Name | Type | Key Columns | Include Columns | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' |''))
					,(''| --- | --- | --- | --- | --- |'');

				OPEN [index_cursor]
				FETCH NEXT FROM [index_cursor] INTO @indexobjectid
				WHILE @@FETCH_STATUS = 0
				BEGIN
				' +
					-- Get key columns as a csv list
					+ N'SELECT @key_columns = STUFF((
							SELECT CONCAT('', '', QUOTENAME([col].[name]))
							FROM [sys].[indexes] AS [ind]
								INNER JOIN [sys].[index_columns] AS [ic] ON [ind].[object_id] = [ic].[object_id]
									AND [ic].[index_id] = [ind].[index_id]
								INNER JOIN [sys].[columns] AS [col] ON [ic].[object_id] = [col].[object_id]
									AND [ic].[column_id] = [col].[column_id]
							WHERE [ind].[object_id] = @objectid
								AND [ind].[index_id] = @indexobjectid
								AND [ic].[is_included_column] = 0
							FOR XML PATH('''')
						), 1, 2, ''''); ' +

					-- Get included columns as a csv list
					+ N'SELECT @include_columns = STUFF((
							SELECT CONCAT('', '', QUOTENAME([col].[name]))
							FROM [sys].[indexes] AS [ind]
								INNER JOIN [sys].[index_columns] AS [ic] ON [ind].[object_id] = [ic].[object_id]
									AND [ic].[index_id] = [ind].[index_id]
								INNER JOIN [sys].[columns] AS [col] ON [ic].[object_id] = [col].[object_id]
									AND [ic].[column_id] = [col].[column_id]
							WHERE [ind].[object_id] = @objectid
								AND [ind].[index_id] = @indexobjectid
								AND [ic].[is_included_column] = 1
							FOR XML PATH('''')
						), 1, 2, '''');

					INSERT INTO #markdown (value)
					SELECT CONCAT(''| ''
						,CASE
							WHEN [ind].[is_primary_key] = 1
                        	THEN CONCAT(@PK, ''**'',[ind].[name],''**'')
							ELSE [ind].[name]
						END
						, '' | ''
						, LOWER([ind].[type_desc]) COLLATE DATABASE_DEFAULT
						, '' | ''
						, @key_columns COLLATE DATABASE_DEFAULT
						, '' | ''
						, @include_columns COLLATE DATABASE_DEFAULT
						, '' | ''
						, CAST([ep].[value] AS NVARCHAR(4000)) COLLATE DATABASE_DEFAULT
						, '' |'')
					FROM [sys].[indexes] AS [ind]
						LEFT JOIN [sys].[extended_properties] AS [ep] ON [ind].[object_id] = [ep].[major_id]
							AND [ep].[minor_id] = [ind].[index_id]
							AND [ep].[class] = 7 -- Index
							AND [ep].[name] = @ExtendedPropertyName
					WHERE [ind].[object_id] = @objectid
						AND [ind].[index_id] = @indexobjectid;

					FETCH NEXT FROM [index_cursor] INTO @indexobjectid;
				END;

				CLOSE [index_cursor];
				DEALLOCATE [index_cursor];
			END;
			' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))
				,(CONCAT(CHAR(13), CHAR(10), ''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''));

			FETCH NEXT FROM obj_cursor INTO @objectid;

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible view section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for views

	/**************************************
	Generate markdown for stored procedures
	**************************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[procedures] WHERE [is_ms_shipped] = 0)
	BEGIN;
		INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## Stored Procedures'')) ,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[procedures]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME(object_id), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[procedures]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid));' +

			--Extended properties
			+ N'INSERT INTO #markdown
			SELECT CAST([ep].[value] AS NVARCHAR(4000))
			FROM [sys].[procedures] AS [p]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [p].[object_id] = [ep].[major_id]
			WHERE [p].[object_id] = @objectid
				AND [ep].[minor_id] = 0
				AND [ep].[name] = @ExtendedPropertyName;' +

			--Check for parameters
			+ N'IF EXISTS (SELECT * FROM [sys].[parameters] AS [param] WHERE [param].[object_id] = @objectid)
			BEGIN
				INSERT INTO #markdown (value)
				VALUES (CONCAT(CHAR(13), CHAR(10), ''| Parameter | Type | Output | Description |''))
						,(''| --- | --- | --- | --- |'');

				INSERT INTO #markdown
				select CONCAT(''| '', CASE WHEN LEN([param].[name]) = 0 THEN ''*Output*'' ELSE [param].[name] END
						,'' | ''
						,CONCAT(UPPER(TYPE_NAME([user_type_id]))
						,CASE
							WHEN TYPE_NAME([user_type_id]) IN (N''decimal'',N''numeric'')
							THEN CONCAT(N''('',CAST(precision AS varchar(5)), N'','',CAST(scale AS varchar(5)), N'')'')
							WHEN TYPE_NAME([user_type_id]) IN (''varchar'', ''char'', ''varbinary'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
								END
							WHEN TYPE_NAME([user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
							THEN QUOTENAME(CAST(scale AS varchar(5)), ''('')
							WHEN TYPE_NAME([user_type_id]) in (N''float'')
							THEN CASE
									WHEN [param].precision = 53
									THEN N''''
									ELSE CONCAT(N''('',CAST([param].precision AS varchar(5)),N'')'')
								END
							WHEN TYPE_NAME([param].user_type_id) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
								N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
								N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'') OR [is_readonly] = 1
							THEN N''''
							WHEN TYPE_NAME([user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length]/2 AS VARCHAR(10)), ''('')
								END
							ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
						END)
						,'' | ''
						,CASE [is_output]
							WHEN 1
							THEN @Yes
							ELSE @No
						END
						,'' | ''
						,CAST([ep].[value] AS NVARCHAR(4000))
						, '' |'')
				FROM [sys].[procedures] AS [proc]
					INNER JOIN [sys].[parameters] AS [param] ON [param].[object_id] = [proc].[object_id]
					LEFT JOIN [sys].[extended_properties] AS [ep] ON [proc].[object_id] = [ep].[major_id]
						AND [ep].[name] = [param].[name]
				WHERE [proc].[object_id] = @objectid
				ORDER BY [param].[parameter_id] ASC;
			END

			INSERT INTO #markdown (value)
			VALUES(CONCAT(CHAR(13), CHAR(10), ''#### Definition''))
				,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>''));' +

			--Object definition
			+ N'
			IF (@LimitStoredProcLength = 1 AND LEN(OBJECT_DEFINITION(@objectid)) > 8000)
				BEGIN;
					INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
					CHAR(13), CHAR(10), CAST(OBJECT_DEFINITION(@objectid) AS VARCHAR(8000))))
					,(''/************************************************************************************************/'')
					,(''/* sp_doc: Max 8000 characters reached. Set @LimitStoredProcLength = 0 to show full definition. */'')
					,(''/************************************************************************************************/'')
					,(''```'');
				END;
			ELSE
				BEGIN;
					INSERT INTO #markdown (value)
					VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
					CHAR(13), CHAR(10), OBJECT_DEFINITION(@objectid)))
					,(''```'');
				END;' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))
				,(CONCAT(CHAR(13), CHAR(10), ''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''));

			FETCH NEXT FROM obj_cursor INTO @objectid

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible stored procedure section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for stored procedures

	/*************************************
	Generate markdown for scalar functions
	*************************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[objects] WHERE [is_ms_shipped] = 0 AND [type] = ''FN'')
	BEGIN;
		INSERT INTO #markdown (value)
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## Scalar Functions'')) ,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[objects]
		WHERE [is_ms_shipped] = 0
			AND [type] = ''FN'' --SQL_SCALAR_FUNCTION
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[objects]
		WHERE [is_ms_shipped] = 0
			AND [type] = ''FN'' --SQL_SCALAR_FUNCTION
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid));' +

			--Extended properties
			+ N'INSERT INTO #markdown
			SELECT CAST([ep].[value] AS NVARCHAR(4000))
			FROM [sys].[objects] AS [o]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [o].[object_id] = [ep].[major_id]
			WHERE [o].[object_id] = @objectid
				AND [ep].[minor_id] = 0
				AND [ep].[name] = @ExtendedPropertyName;' +

			--Check for parameters
			+ N'IF EXISTS (SELECT * FROM [sys].[parameters] AS [param] WHERE [param].[object_id] = @objectid)
			BEGIN
				INSERT INTO #markdown (value)
				VALUES (CONCAT(CHAR(13), CHAR(10), ''| Parameter | Type | Output | Description |''))
					,(''| --- | --- | --- | --- |'');

				INSERT INTO #markdown
				select CONCAT(''| '', CASE WHEN LEN([param].[name]) = 0 THEN ''*Output*'' ELSE [param].[name] END
						,'' | ''
						,CONCAT(UPPER(TYPE_NAME([user_type_id]))
						,CASE
							WHEN TYPE_NAME([user_type_id]) IN (N''decimal'',N''numeric'')
							THEN CONCAT(N''('',CAST(precision AS varchar(5)), N'','',CAST(scale AS varchar(5)), N'')'')
							WHEN TYPE_NAME([user_type_id]) IN (''varchar'', ''char'', ''varbinary'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
								END
							WHEN TYPE_NAME([user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
							THEN QUOTENAME(CAST(scale AS varchar(5)), ''('')
							WHEN TYPE_NAME([user_type_id]) in (N''float'')
							THEN CASE
									WHEN [param].precision = 53
									THEN N''''
									ELSE CONCAT(N''('',CAST([param].precision AS varchar(5)),N'')'')
								END
							WHEN TYPE_NAME([param].user_type_id) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
								N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
								N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'') OR [is_readonly] = 1
							THEN N''''
							WHEN TYPE_NAME([user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
							THEN CASE
									WHEN [max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([max_length]/2 AS VARCHAR(10)), ''('')
								END
							ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
						END)
						,'' | ''
						,CASE [is_output]
							WHEN 1
							THEN @Yes
							ELSE @No
							END
						,'' | ''
						,CAST([ep].[value] AS NVARCHAR(4000))
						, '' |'')
				FROM [sys].[objects] AS [o]
					INNER JOIN [sys].[parameters] AS [param] ON [param].[object_id] = [o].[object_id]
					LEFT JOIN [sys].[extended_properties] AS [ep] ON [o].[object_id] = [ep].[major_id]
						AND [ep].[name] = [param].[name]
				WHERE [o].[object_id] = @objectid
				ORDER BY [param].[parameter_id] ASC;
			END;

			INSERT INTO #markdown (value)
			VALUES(CONCAT(CHAR(13), CHAR(10), ''#### Definition''))
				,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>''));' +

			--Object definition
			+ N'INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
				CHAR(13), CHAR(10), OBJECT_DEFINITION(@objectid)))
				,(''```'');' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))
				,(CONCAT(CHAR(13), CHAR(10), ''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''));

			FETCH NEXT FROM obj_cursor INTO @objectid;

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible scalar functions section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for scalar functions

	/************************************
	Generate markdown for table functions
	************************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[objects] WHERE [is_ms_shipped] = 0 AND [type] = ''IF'')
	BEGIN;
		INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## Table Functions'')) ,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[objects]
		WHERE [is_ms_shipped] = 0
			AND [type] = ''IF'' --SQL_INLINE_TABLE_VALUED_FUNCTION
		ORDER BY OBJECT_SCHEMA_NAME(object_id), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[objects]
		WHERE [is_ms_shipped] = 0
			AND [type] = ''IF'' --SQL_INLINE_TABLE_VALUED_FUNCTION
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid));' +

			--Extended properties
			+ N'INSERT INTO #markdown
			SELECT CAST([ep].[value] AS NVARCHAR(4000))
			FROM [sys].[objects] AS [o]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [o].[object_id] = [ep].[major_id]
			WHERE [o].[object_id] = @objectid
				AND [ep].[minor_id] = 0
				AND [ep].[name] = @ExtendedPropertyName;' +

			--Check for parameters
			+ N'IF EXISTS (SELECT * FROM [sys].[parameters] AS [param] WHERE [param].[object_id] = @objectid)
			BEGIN
				INSERT INTO #markdown (value)
				VALUES (CONCAT(CHAR(13), CHAR(10), ''| Parameter | Type | Output | Description |''))
						,(''| --- | --- | --- | --- |'');

				INSERT INTO #markdown
				select CONCAT(''| '', CASE WHEN LEN([param].[name]) = 0 THEN ''*Output*'' ELSE [param].[name] END
						,'' | ''
						,CONCAT(UPPER(TYPE_NAME([user_type_id]))
						,CASE
							WHEN TYPE_NAME([user_type_id]) IN (N''decimal'',N''numeric'')
							THEN CONCAT(N''('',CAST(precision AS varchar(5)), N'','',CAST(scale AS varchar(5)), N'')'')
							WHEN TYPE_NAME([user_type_id]) IN (''varchar'', ''char'')
							THEN QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
							WHEN TYPE_NAME([user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
							THEN QUOTENAME(CAST(scale AS varchar(5)), ''('')
							WHEN TYPE_NAME([user_type_id]) in (N''float'')
							THEN CASE
								WHEN precision = 53
								THEN N''''
								ELSE QUOTENAME(CAST(precision AS varchar(5)),''('') END
							WHEN TYPE_NAME([user_type_id]) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
								N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
								N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'')
							THEN N''''
							ELSE CASE
								WHEN [is_readonly] = 1 --User defined table type
								THEN N''''
								WHEN [max_length] = -1
								THEN N''(MAX)''
								WHEN TYPE_NAME([user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
								THEN QUOTENAME(CAST([max_length]/2 AS VARCHAR(10)), ''('')
								ELSE QUOTENAME(CAST([max_length] AS VARCHAR(10)), ''('')
								END
						END)
						,'' | ''
						,CASE [is_output]
							WHEN 1
							THEN @Yes
							ELSE @No
							END
						,'' | ''
						,CAST([ep].[value] AS NVARCHAR(4000))
						, '' |'')
				FROM [sys].[objects] AS [o]
					INNER JOIN [sys].[parameters] AS [param] ON [param].[object_id] = [o].[object_id]
					LEFT JOIN [sys].[extended_properties] AS [ep] ON [o].[object_id] = [ep].[major_id]
						AND [ep].[name] = [param].[name]
				WHERE [o].[object_id] = @objectid
				ORDER BY [param].[parameter_id] ASC;
			END;

			INSERT INTO #markdown (value)
			VALUES(CONCAT(CHAR(13), CHAR(10), ''#### Definition''))
				,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>''));' +

			--Object definition
			+ N'INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''```sql'',
				CHAR(13), CHAR(10), OBJECT_DEFINITION(@objectid)))
				,(''```'');' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''))
				,(CONCAT(CHAR(13), CHAR(10),''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''));

			FETCH NEXT FROM obj_cursor INTO @objectid;

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible table functions section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for table functions

	/******************************
	Generate markdown for synonyms
	******************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[synonyms] WHERE [is_ms_shipped] = 0)
	BEGIN;
		INSERT INTO #markdown ([value])
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## Synonyms'')) ,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>''));
		' +

		+ N'INSERT INTO #markdown
		SELECT CONCAT(''* ['', OBJECT_SCHEMA_NAME(object_id), ''.'', OBJECT_NAME(object_id), ''](#'', REPLACE(LOWER(OBJECT_SCHEMA_NAME(object_id)), '' '', ''-''), REPLACE(LOWER(OBJECT_NAME(object_id)), '' '', ''-''), '')'')
		FROM [sys].[synonyms]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [object_id]
		FROM [sys].[synonyms]
		WHERE [is_ms_shipped] = 0
		ORDER BY OBJECT_SCHEMA_NAME([object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', OBJECT_SCHEMA_NAME(@objectid), ''.'', OBJECT_NAME(@objectid), CHAR(13), CHAR(10)); ' +

			--Extended properties
			+ N'INSERT INTO #markdown
			SELECT CAST([ep].[value] AS NVARCHAR(4000))
			FROM [sys].[synonyms] AS [s]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [s].[object_id] = [ep].[major_id]
			WHERE [s].[object_id] = @objectid
				AND [ep].[minor_id] = 0
				AND [ep].[name] = @ExtendedPropertyName;

			INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''| Synonym | Base Object |''))
					,(''| --- | --- |'');' +

			--Object mapping
			+ N'INSERT INTO #markdown
			SELECT CONCAT(''| '', OBJECT_SCHEMA_NAME([syn].[object_id]), ''.'', OBJECT_NAME([syn].[object_id])
					,'' | ''
					,CASE WHEN PARSENAME([base_object_name], 3) = DB_NAME()
						THEN CONCAT(''['', PARSENAME([base_object_name], 3), ''.'', PARSENAME([base_object_name], 2), ''.'', PARSENAME([base_object_name], 1), '']'', ''(#'', PARSENAME([base_object_name], 2), ''.'', PARSENAME([base_object_name], 1), '')'')
						ELSE CONCAT(PARSENAME([base_object_name], 3), PARSENAME([base_object_name], 2), PARSENAME([base_object_name], 1))
					END
					,'' |'')
				FROM [sys].[synonyms] AS [syn]
				WHERE [syn].[object_id] = @objectid;' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10),''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''));

			FETCH NEXT FROM obj_cursor INTO @objectid

		END
		CLOSE obj_cursor
		DEALLOCATE obj_cursor;' +

		--End collapsible synonyms section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for synonyms

	/***********************************************
	Generate markdown for user defined table types
	***********************************************/
	--Build table of contents
	SET @Sql = @Sql + N'
	IF EXISTS (SELECT 1 FROM [sys].[table_types] WHERE [is_user_defined] = 1)
	BEGIN
		INSERT INTO #markdown (value)
		VALUES (CONCAT(CHAR(13), CHAR(10), ''## User Defined Table Types''))
			,(CONCAT(CHAR(13), CHAR(10), ''<details><summary>Click to expand</summary>'', CHAR(13), CHAR(10)));
		' +

		+ N'INSERT INTO #markdown (value)
		SELECT CONCAT(''* ['', SCHEMA_NAME([schema_id]), ''.'', [name], ''](#'', REPLACE(LOWER(SCHEMA_NAME([schema_id])), '' '', ''-''), REPLACE(LOWER([name]), '' '', ''-''), '')'')
		FROM [sys].[table_types]
		WHERE [is_user_defined] = 1
		ORDER BY OBJECT_SCHEMA_NAME([type_table_object_id]), [name] ASC;' +

		--Object details
		+ N'DECLARE obj_cursor CURSOR
		LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR
		SELECT [type_table_object_id]
		FROM [sys].[table_types]
		WHERE [is_user_defined] = 1
		ORDER BY OBJECT_SCHEMA_NAME([type_table_object_id]), [name] ASC;

		OPEN obj_cursor
		FETCH NEXT FROM obj_cursor INTO @objectid
		WHILE @@FETCH_STATUS = 0
		BEGIN

			INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), ''### '', SCHEMA_NAME([schema_id]), ''.'', [name])
			FROM [sys].[table_types]
			WHERE [type_table_object_id] = @objectid
				AND [is_user_defined] = 1;' +

			--Extended Properties
			+ N'INSERT INTO #markdown
			SELECT CONCAT(CHAR(13), CHAR(10), CAST([ep].[value] AS NVARCHAR(4000)))
			FROM [sys].[table_types] AS [tt]
				INNER JOIN [sys].[extended_properties] AS [ep] ON [tt].[type_table_object_id] = [ep].[major_id]
			WHERE [tt].[type_table_object_id] = @objectid
				AND [ep].[minor_id] = 0 --On the table
				AND [ep].[name] = @ExtendedPropertyName
				AND [tt].[is_user_defined] = 1;

			INSERT INTO #markdown (value)
			VALUES (CONCAT(CHAR(13), CHAR(10), ''| Column | Type | Null | Default | '', @ExtendedPropertyName COLLATE DATABASE_DEFAULT, '' |''))
				,(''| --- | ---| --- | --- | --- |'');' +

			--Columns
			+ N'INSERT INTO #markdown
			SELECT CONCAT(''| ''
                    ,CASE
                        WHEN [ic].[object_id] IS NOT NULL
                        THEN ISNULL(CONCAT(''**'',[c].[name],''**''), ''N/A'')
                        ELSE ISNULL([c].[name], ''N/A'')
                    END
					,'' | ''
					,CONCAT(UPPER(TYPE_NAME([c].[user_type_id]))
					,CASE
							WHEN TYPE_NAME([c].[user_type_id]) IN (N''decimal'',N''numeric'')
							THEN CONCAT(N''('',CAST([c].[precision] AS VARCHAR(5)), N'','',CAST([c].[scale] AS varchar(5)), N'')'')
							WHEN TYPE_NAME([c].[user_type_id]) IN (''varchar'', ''char'', ''varbinary'')
							THEN CASE
									WHEN [c].[max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([c].[max_length] AS VARCHAR(10)), ''('')
								END
							WHEN TYPE_NAME([c].[user_type_id]) IN (N''time'',N''datetime2'',N''datetimeoffset'')
							THEN QUOTENAME(CAST([c].[scale] AS VARCHAR(5)), ''('')
							WHEN TYPE_NAME([c].[user_type_id]) in (N''float'')
							THEN CASE
									WHEN [c].precision = 53
									THEN N''''
									ELSE CONCAT(N''('',CAST([c].[precision] AS VARCHAR(5)),N'')'')
								END
							WHEN TYPE_NAME([c].[user_type_id]) IN (N''int'',N''bigint'',N''smallint'',N''tinyint'',N''money'',N''smallmoney'',
								N''real'',N''datetime'',N''smalldatetime'',N''bit'',N''image'',N''text'',N''uniqueidentifier'',
								N''date'',N''ntext'',N''sql_variant'',N''hierarchyid'',''geography'',N''timestamp'',N''xml'')
							THEN N''''
							WHEN TYPE_NAME([c].[user_type_id]) IN (N''nvarchar'',N''nchar'', N''sysname'')
							THEN CASE
									WHEN [c].[max_length] = -1
									THEN N''(MAX)''
									ELSE QUOTENAME(CAST([c].[max_length]/2 AS VARCHAR(10)), ''('')
								END
							ELSE QUOTENAME(CAST([c].[max_length] AS VARCHAR(10)), ''('')
					END)
					,'' | ''
					,CASE [c].[is_nullable]
						WHEN 1
						THEN @Yes
						ELSE @No
						END
					,'' | ''
					,OBJECT_DEFINITION([dc].[object_id])
					,'' | ''
					,CAST([ep].[value] AS NVARCHAR(4000))
					,'' |'')
			FROM [sys].[table_types] AS [tt]
				INNER JOIN [sys].[columns] AS [c] ON [tt].[type_table_object_id] = [c].[object_id]
				LEFT JOIN [sys].[extended_properties] AS [ep] ON [tt].[type_table_object_id] = [ep].[major_id]
					AND [ep].[minor_id] > 0
					AND [ep].[minor_id] = [c].[column_id]
					AND [ep].[class] = 1 --Object/col
				--	AND [ep].[name] = @ExtendedPropertyName
				LEFT JOIN [sys].[foreign_key_columns] AS [fk] ON [fk].[parent_object_id] = [c].[object_id]
					AND [fk].[parent_column_id] = [c].[column_id]
				LEFT JOIN [sys].[default_constraints] [dc] ON [dc].[parent_object_id] = [c].[object_id]
					AND [dc].[parent_column_id] = [c].[column_id]
				LEFT JOIN [sys].[indexes] AS [pk] ON [pk].[object_id] = [tt].[type_table_object_id]
					AND [pk].[is_primary_key] = 1
				LEFT JOIN [sys].[index_columns] AS [ic] ON [ic].[index_id] = [pk].[index_id]
					AND [ic].[object_id] = [tt].[type_table_object_id]
					AND [ic].[column_id] = [c].[column_id]
			WHERE [tt].[type_table_object_id] = @objectid
				AND [tt].[is_user_defined] = 1;' +

			--Back to top
			+ N'INSERT INTO #markdown
			VALUES (CONCAT(CHAR(13), CHAR(10), ''[Back to top](#'', LOWER(@DatabaseName COLLATE DATABASE_DEFAULT), '')''))

			FETCH NEXT FROM obj_cursor INTO @objectid;

		END;
		CLOSE obj_cursor;
		DEALLOCATE obj_cursor;' +

		--End collapsible table section
		+ N'INSERT INTO #markdown
		VALUES (CONCAT(CHAR(13), CHAR(10), ''</details>''));
	END;'; --End markdown for user defined table types

	--Attribution
	SET @Sql = @Sql + N'INSERT INTO #markdown
	VALUES (CONCAT(CHAR(13), CHAR(10), ''----''))
		,(CONCAT(CHAR(13), CHAR(10), ''*Markdown generated by [sp_doc](http://dba-multitool.org)''))
		,(CONCAT('' at '', SYSDATETIMEOFFSET(), ''.*''));';

	--Return all data
	SET @Sql = @Sql + N'
	SELECT [value]
	FROM #markdown
	ORDER BY [ID] ASC;';

	SET @ParmDefinition = N'@ExtendedPropertyName SYSNAME, @DatabaseName SYSNAME, @LimitStoredProcLength BIT, @Yes VARCHAR(20), @No VARCHAR(20), @PK VARCHAR(20), @FK VARCHAR(20), @Column VARCHAR(20)';
	EXEC sp_executesql @Sql
		,@ParmDefinition
		,@ExtendedPropertyName
		,@DatabaseName
		,@LimitStoredProcLength
		,@Yes
		,@No
		,@PK
		,@FK
		,@Column;
END;
GO

EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Generate on the fly database documentation in markdown. Documentation at https://expresssql.lowlydba.com' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@DatabaseName', @value=N'Target database to document. Default is the stored procedure''s database.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@ExtendedPropertyName', @value=N'Key for extended properties on objects. Default is ''Description''.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@SqlMajorVersion', @value=N'Used for unit testing purposes only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@SqlMinorVersion', @value=N'Used for unit testing purposes only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@LimitStoredProcLength', @value=N'Limit stored procedure contents to 8000 characters, to avoid memory issues with some IDEs. Default is 1.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@Emojis', @value=N'Use emojis when generating documentation. Default is 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

EXEC sys.sp_addextendedproperty @name=N'@Verbose', @value=N'Whether or not to print additional information during the script run. Default is 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_doc';
GO

