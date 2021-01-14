SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'Description' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_helpme', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SqlMinorVersion' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_helpme', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@SqlMinorVersion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@SqlMajorVersion' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_helpme', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@SqlMajorVersion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@ExtendedPropertyName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_helpme', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@ExtendedPropertyName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
	END
GO

IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'@ObjectName' , N'SCHEMA',N'dbo', N'PROCEDURE',N'sp_helpme', NULL,NULL))
	BEGIN;
		EXEC sys.sp_dropextendedproperty @name=N'@ObjectName' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
	END
GO

/***************************/
/* Create stored procedure */
/***************************/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_helpme]') AND [type] IN (N'P', N'PC'))
	BEGIN;
		EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_helpme] AS';
	END
GO

ALTER PROCEDURE [dbo].[sp_helpme]
	@ObjectName SYSNAME = NULL
	,@ExtendedPropertyName SYSNAME = 'Description'
	/* Parameters defined here for testing only */
	,@SqlMajorVersion TINYINT = 0
	,@SqlMinorVersion SMALLINT = 0
AS

/*
sp_helpme - A drop-in modern alternative to sp_help.

Part of the DBA MultiTool http://dba-multitool.org

Version: Version: 20201008

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

	EXEC sp_helpme 'dbo.Sales';

*/ 

BEGIN
	SET NOCOUNT ON;

	DECLARE	@DbName	SYSNAME
		,@ObjShortName SYSNAME = N''
		,@No VARCHAR(5)	= 'no'
		,@Yes VARCHAR(5) = 'yes'
		,@None VARCHAR(5) = 'none'
		,@SysObj_Type CHAR(2)
		,@ObjID INT
		,@HasParam INT = 0
		,@HasDepen BIT = 0
		,@HasHidden BIT = 0
		,@HasMasked BIT = 0
		,@SQLString NVARCHAR(MAX) = N''
		,@Msg NVARCHAR(MAX) = N''
		,@ParmDefinition NVARCHAR(500);

	/* Find Version */
	IF (@SqlMajorVersion = 0)
		BEGIN;
			SET @SqlMajorVersion = CAST(SERVERPROPERTY('ProductMajorVersion') AS TINYINT);
		END;
	IF (@SqlMinorVersion = 0)
		BEGIN;
			SET @SqlMinorVersion = CAST(SERVERPROPERTY('ProductMinorVersion') AS TINYINT);
		END;

	/* Validate Version */
	IF (@SqlMajorVersion < 11)
		BEGIN;
			SET @Msg = 'SQL Server versions below 2012 are not supported, sorry!';
			RAISERROR(@Msg, 16, 1);
		END;

	/* Check for Hidden Columns feature */
	IF 1 = (SELECT COUNT(*) FROM sys.all_columns AS ac WHERE ac.name = 'is_hidden' AND OBJECT_NAME(ac.object_id) = 'all_columns')
		BEGIN
			SET @HasHidden = 1;
		END;

	/* Check for Masked Columns feature */
	IF 1 = (SELECT COUNT(*) FROM sys.all_columns AS ac WHERE ac.name = 'is_masked' AND OBJECT_NAME(ac.object_id) = 'all_columns')
		BEGIN
			SET @HasMasked = 1;
		END;

	-- If no @ObjectName given, give a little info about all objects.
	IF (@ObjectName IS NULL)
	BEGIN;
		SET @SQLString = N'SELECT
				[Name] = [o].[name],
				[Owner] = USER_NAME(OBJECTPROPERTY([object_id], ''ownerid'')),
				[Object_type] = LOWER(REPLACE([o].[type_desc], ''_'', '' '')),
				[Create_datetime] = [o].[create_date],
				[Modify_datetime] = [o].[modify_date],
				[ExtendedProperty] = [ep].[value]
			FROM [sys].[all_objects] [o]
				LEFT JOIN [sys].[extended_properties] [ep] ON [ep].[major_id] = [o].[object_id]
					and [ep].[name] = @ExtendedPropertyName
					AND [ep].[minor_id] = 0
					AND [ep].[class] = 1 
			ORDER BY [Owner] ASC, [Object_type] DESC, [name] ASC;';
		SET @ParmDefinition = N'@ExtendedPropertyName SYSNAME';

		EXEC sp_executesql @SQLString
			,@ParmDefinition
			,@ExtendedPropertyName;

		-- Display all user types
		SET @SQLString = N'SELECT
			[User_type]		= [name],
			[Storage_type]	= TYPE_NAME(system_type_id),
			[Length]		= max_length,
			[Prec]			= [precision],
			[Scale]			= [scale],
			[Nullable]		= CASE WHEN is_nullable = 1 THEN @Yes ELSE @No END,
			[Default_name]	= ISNULL(OBJECT_NAME(default_object_id), @None),
			[Rule_name]		= ISNULL(OBJECT_NAME(rule_object_id), @None),
			[Collation]		= collation_name
		FROM sys.types
		WHERE user_type_id > 256
		ORDER BY [name];';
		SET @ParmDefinition = N'@Yes VARCHAR(5), @No VARCHAR(5), @None VARCHAR(5)';

		EXEC sp_executesql @SQLString
			,@ParmDefinition
			,@Yes
			,@No
			,@None;

		RETURN(0);
	END -- End all Sysobjects

	-- Make sure the @ObjectName is local to the current database.
	SELECT @ObjShortName = PARSENAME(@ObjectName,1);
	SELECT @DbName = PARSENAME(@ObjectName,3);
	IF @DbName IS NULL
		SELECT @DbName = DB_NAME();
	ELSE IF @DbName <> DB_NAME()
		BEGIN
			RAISERROR(15250,-1,-1);
		END

	-- @ObjectName must be either sysobjects or systypes: first look in sysobjects
	SET @SQLString = N'SELECT @ObjID			= object_id
							, @SysObj_Type		= type 
						FROM sys.all_objects 
						WHERE object_id = OBJECT_ID(@ObjectName);';  
	SET @ParmDefinition = N'@ObjectName SYSNAME
						,@ObjID INT OUTPUT
						,@SysObj_Type VARCHAR(5) OUTPUT';

	EXEC sp_executesql @SQLString
		,@ParmDefinition
		,@ObjectName
		,@ObjID OUTPUT
		,@SysObj_Type OUTPUT;

	-- If @ObjectName not in sysobjects, try systypes
	IF @ObjID IS NULL
	BEGIN
		SET @SQLSTring = N'SELECT @ObjID = user_type_id
							FROM sys.types
							WHERE name = PARSENAME(@ObjectName,1);';
		SET @ParmDefinition = N'@ObjectName SYSNAME
							,@ObjID INT OUTPUT';
							
		EXEC sp_executesql @SQLString
			,@ParmDefinition
			,@ObjectName
			,@ObjID OUTPUT;

		-- If not in systypes, return
		IF @ObjID IS NULL
		BEGIN
			RAISERROR(15009,-1,-1,@ObjectName,@DbName);
		END

		-- Data Type help (prec/scale only valid for numerics)
		SET @SQLString = N'SELECT
						[Type_name]			= t.name,
						[Storage_type]		= type_name(system_type_id),
						[Length]			= max_length,
						[Prec]				= [precision],
						[Scale]				= [scale],
						[Nullable]			= case when is_nullable=1 then @Yes else @No end,
						[Default_name]		= isnull(object_name(default_object_id), @None),
						[Rule_name]			= isnull(object_name(rule_object_id), @None),
						[Collation]			= collation_name,
						[ExtendedProperty]	= ep.[value]
					FROM [sys].[types] AS [t]
						LEFT JOIN [sys].[extended_properties] AS [ep] ON [ep].[major_id] = [t].[user_type_id]
							AND [ep].[name] = @ExtendedPropertyName
							AND [ep].[minor_id] = 0
							AND [ep].[class] = 6
					WHERE [user_type_id] = @ObjID';
		SET @ParmDefinition = N'@ObjID INT, @Yes VARCHAR(5), @No VARCHAR(5), @None VARCHAR(5), @ExtendedPropertyName SYSNAME';

		EXECUTE sp_executesql @SQLString
			,@ParmDefinition
			,@ObjID
			,@Yes
			,@No
			,@None
			,@ExtendedPropertyName;

		RETURN(0);
	END --Systypes

	-- FOUND IT IN SYSOBJECT, SO GIVE OBJECT INFO
	SET @SQLString = N'SELECT
		[Name]					= [o].[name],
		[Owner]					= USER_NAME(ObjectProperty([o].[object_id], ''ownerid'')),
		[Type]					= LOWER(REPLACE([o].[type_desc], ''_'', '' '')),
		[Created_datetime]		= [o].[create_date],
		[Modify_datetime]		= [o].[modify_date],
		[ExtendedProperty]		= [ep].[value]
	FROM [sys].[all_objects] [o]
		LEFT JOIN [sys].[extended_properties] [ep] ON [ep].[major_id] = [o].[object_id]
			AND [ep].[name] = @ExtendedPropertyName
			AND [ep].[minor_id] = 0
			AND [ep].[class] = 1 
	WHERE [o].[object_id] = @ObjID;';

	SET @ParmDefinition = N'@ObjID INT, @ExtendedPropertyName SYSNAME';

	EXEC sp_executesql @SQLString
		,@ParmDefinition
		,@ObjID
		,@ExtendedPropertyName;

	-- Display column metadata if table / view
	SET @SQLString = N'
	IF EXISTS (select * from sys.all_columns where object_id = @ObjID)
	BEGIN;

		-- SET UP NUMERIC TYPES: THESE WILL HAVE NON-BLANK PREC/SCALE
		-- There must be a '','' immediately after each type name (including last one),
		-- because that''s what we''ll search for in charindex later.
		DECLARE @precscaletypes NVARCHAR(150);
		SELECT @precscaletypes = N''tinyint,smallint,decimal,int,bigint,real,money,float,numeric,smallmoney,date,time,datetime2,datetimeoffset,''

		-- INFO FOR EACH COLUMN
		select
			[Column_name]			= ac.name,
			[Type]					= type_name([ac].[user_type_id]),
			[Computed]				= case when ColumnProperty(object_id, [ac].[name], ''IsComputed'') = 0 then ''no'' else ''yes'' end,
			[Length]				= convert(int, [ac].[max_length]),
			-- for prec/scale, only show for those types that have valid precision/scale
			-- Search for type name + '','', because ''datetime'' is actually a substring of ''datetime2'' and ''datetimeoffset''
			[Prec]					= case when charindex(type_name([ac].[system_type_id]) + '','', '''') > 0
										then convert(char(5),ColumnProperty(object_id, ac.name, ''precision''))
										else ''     '' end,
			[Scale]					= case when charindex(type_name([ac].[system_type_id]) + '','', '''') > 0
										then convert(char(5),OdbcScale([ac].[system_type_id],[ac].[scale]))
										else ''     '' end,
			[Nullable]				= case when [ac].[is_nullable] = 0 then ''no'' else ''yes'' end, ';

			--Only include if they exist on the current version
			IF @HasMasked = 1
				BEGIN
					SET @SQLString = @SQLString +  N'[Masked] = case when is_masked = 0 then ''no'' else ''yes'' end, ';
				END
				
			SET @SQLString = @SQLString + N'[Sparse] = case when is_sparse = 0 then ''no'' else ''yes'' end, ';

			IF @HasHidden = 1
				BEGIN
					SET @SQLString = @SQLString +  N'[Hidden] = case when is_hidden = 0 then ''no'' else ''yes'' end, ';
				END
			
			SET @SQLString = @SQLString + N'
			[Identity]				= case when is_identity = 0 then ''no'' else ''yes'' end,
			[TrimTrailingBlanks]	= case ColumnProperty(object_id, ac.name, ''UsesAnsiTrim'')
										when 1 then ''no''
										when 0 then ''yes''
										else ''(n/a)'' end,
			[FixedLenNullInSource]	= case
										when type_name([ac].[system_type_id]) not in (''varbinary'',''varchar'',''binary'',''char'')
											then ''(n/a)''
										when [ac].[is_nullable] = 0 then ''no'' else ''yes'' end,
			[Collation]				= [ac].[collation_name],
			[ExtendedProperty]		= [ep].[value]
		FROM [sys].[all_columns] AS [ac]
			INNER JOIN [sys].[types] AS [typ] ON [typ].[system_type_id] = [ac].[system_type_id]
			LEFT JOIN sys.extended_properties ep ON ep.minor_id = ac.column_id
				AND ep.major_id = ac.[object_id]
				AND ep.[name] = @ExtendedPropertyName
				AND ep.class = 1
		WHERE [object_id] = @ObjID
	END';
	SET @ParmDefinition = N'@ObjID INT, @ExtendedPropertyName SYSNAME';  
	EXEC sp_executesql @SQLString, @ParmDefinition, @ObjID = @ObjID, @ExtendedPropertyName = @ExtendedPropertyName;

	-- Identity & rowguid columns
	IF @SysObj_Type IN ('S ','U ','V ','TF')
	BEGIN
		DECLARE @colname SYSNAME = NULL;
		SET @SQLString = N'SELECT @colname = COL_NAME(@ObjID, column_id)
						FROM sys.identity_columns
						WHERE object_id = @ObjID;';
		SET @ParmDefinition = N'@ObjID INT, @colname SYSNAME OUTPUT';

		EXEC sp_executesql @SQLString
			,@ParmDefinition
			,@ObjID
			,@colname OUTPUT;

		--Identity
		IF (@colname IS NOT NULL)
			SELECT
				'Identity'				= @colname,
				'Seed'					= IDENT_SEED(@ObjectName),
				'Increment'				= IDENT_INCR(@ObjectName),
				'Not For Replication'	= COLUMNPROPERTY(@ObjID, @colname, 'IsIDNotForRepl');
		ELSE
			BEGIN
				SET @Msg = 'No identity is defined on object %ls.';
				RAISERROR(@Msg, 10, 1, @ObjectName) WITH NOWAIT;
			END

		-- Rowguid
		SET @colname = NULL;
		SET @SQLString = N'SELECT @colname = [name]
						FROM sys.all_columns
						WHERE [object_id] = @ObjID AND is_rowguidcol = 1;';
		SET @ParmDefinition = N'@ObjID INT, @colname SYSNAME OUTPUT';

		EXEC sp_executesql @SQLString
			,@ParmDefinition
			,@ObjID
			,@colname OUTPUT;

		IF (@colname IS NOT NULL)
			SELECT 'RowGuidCol' = @colname;
		ELSE
			BEGIN
				SET @Msg = 'No rowguid is defined on object %ls.';
				RAISERROR(@Msg, 10, 1, @ObjectName) WITH NOWAIT;
			END
	END

	-- Display any procedure parameters
	SET @SQLString = N'SELECT TOP (1) @HasParam = 1 FROM sys.all_parameters WHERE object_id = @ObjID';
	SET @ParmDefinition = N'@ObjID INT, @HasParam BIT OUTPUT';

	EXEC sp_executesql @SQLString
		,@ParmDefinition
		,@ObjID
		,@HasParam OUTPUT;

	--If parameters exist, show them
	IF @HasParam = 1
	BEGIN
		SET @SQLString = N'SELECT
			[Parameter_name]	= [name],
			[Type]				= TYPE_NAME(user_type_id),
			[Length]			= max_length,
			[Prec]				= CASE WHEN TYPE_NAME(system_type_id) = ''uniqueidentifier'' THEN [precision]
									ELSE OdbcPrec(system_type_id, max_length, [precision]) END,
			[Scale]				= ODBCSCALE(system_type_id, scale),
			[Param_order]		= parameter_id,
			[Collation]			= CONVERT([sysname], CASE WHEN system_type_id in (35, 99, 167, 175, 231, 239)
															THEN SERVERPROPERTY(''collation'') END)
		FROM sys.all_parameters
		WHERE [object_id] = @ObjID;';
		SET @ParmDefinition = N'@ObjID INT';

		EXEC sp_executesql  @SQLString
			,@ParmDefinition
			,@ObjID;
	END

	-- DISPLAY TABLE INDEXES & CONSTRAINTS
	IF @SysObj_Type IN ('S ','U ')
	BEGIN
		EXEC sys.sp_objectfilegroup @ObjID;
		EXEC sys.sp_helpindex @ObjectName;
		EXEC sys.sp_helpconstraint @ObjectName,'nomsg';

		SET @SQLString = N'SELECT @HasDepen = COUNT(*)
			FROM sys.objects obj, sysdepends deps
			WHERE obj.[type] =''V''
				AND obj.[object_id] = deps.id
				AND deps.depid = @ObjID
				AND deps.deptype = 1;';
		SET @ParmDefinition = N'@ObjID INT, @HasDepen INT OUTPUT';

		EXEC sp_executeSQL @SQLString
			,@ParmDefinition
			,@ObjID
			,@HasDepen OUTPUT;

		IF @HasDepen = 0
		BEGIN
			RAISERROR(15647,-1,-1,@ObjectName); -- No views with schemabinding for reference table '%ls'.
		END
		ELSE
		BEGIN
			SET @SQLString = N'SELECT DISTINCT [Table is referenced by views] = OBJECT_SCHEMA_NAME(obj.object_id) + ''.'' + obj.[name] 
				FROM sys.objects obj
					INNER JOIN sysdepends deps ON obj.object_id = deps.id
				WHERE obj.[type] =''V''
					AND deps.depid = @ObjID
					AND deps.deptype = 1
				GROUP BY obj.[name], obj.object_id;';
			SET @ParmDefinition = N'@ObjID INT';

			EXEC sp_executesql @SQLString
				,@ParmDefinition
				,@ObjID;
		END
	END
END;
GO

EXEC sys.sp_addextendedproperty @name=N'Description', @value=N'Drop-in alternative to sp_help. Documentation at https://expresssql.lowlydba.com' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
GO

EXEC sys.sp_addextendedproperty @name=N'@ObjectName', @value=N'Target object. Default is all objects.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
GO

EXEC sys.sp_addextendedproperty @name=N'@ExtendedPropertyName', @value=N'Key for extended properties on objects. Default is ''Description''.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
GO

EXEC sys.sp_addextendedproperty @name=N'@SqlMajorVersion', @value=N'Used for unit testing purposes only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
GO

EXEC sys.sp_addextendedproperty @name=N'@SqlMinorVersion', @value=N'Used for unit testing purposes only.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'sp_helpme';
GO
