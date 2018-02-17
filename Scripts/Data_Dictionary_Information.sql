/*--------------------------------------------------------------------------------------------------
Name:		DataDictionarySelect.sql
Purpose:	Display information for every column in every table of a database.
Author:		Patrick Slesicki
Created:	3/16/2008
Notes: Select the database to run against and execute.
http://www.sqlservercentral.com/scripts/Data+Dictionary/167354/
----------------------------------------------------------------------------------------------------
PRELIMINAIRES
*/--------------------------------------------------------------------------------------------------
DECLARE
	@InstanceName AS nvarchar(128) = @@SERVERNAME
	,@DatabaseName AS nvarchar(128) = DB_NAME()

SELECT
	InstanceName = @InstanceName
	,DatabaseName = @DatabaseName
    ,ObjectType = o.type_desc
    ,SchemaName = s.name
    ,ObjectName = o.name
    ,ColumnID = c.column_id
    ,ColumnName = c.name
	,SQLServerDataType = CASE
		--Variable length fields
		WHEN st.name IN('binary', 'char', 'text', 'varbinary', 'varchar') AND c.max_length > -1 THEN st.name + '(' + CONVERT(varchar(6), c.max_length) + ')'
		--Unicode fields require twice the storage as standard variable length fields
		WHEN st.name IN('nchar', 'ntext', 'nvarchar') AND c.max_length > -1 THEN st.name + '(' + CONVERT(varchar(6), c.max_length / 2) + ')'
		--Scale based lengths for date and time fields
		WHEN st.name IN('datetime2', 'datetimeoffset', 'time') THEN st.name + '(' + CONVERT(varchar(3), c.scale) + ')'
		--Numeric fields with precision and scale
		WHEN st.name IN('decimal', 'numeric') THEN st.name + '(' + CONVERT(varchar(3), c.precision) + ', ' + CONVERT(varchar(3), c.scale) + ')'
		--Large Object types (LOB)
		WHEN st.name NOT IN('geography', 'geometry', 'xml') AND c.max_length = -1 THEN st.name + '(MAX)'
		--Everything else
		ELSE st.name
		END
	,CustomDataTypeName = CASE ut.name
		WHEN st.name THEN ''
		ELSE ut.name
		END
	,Length = c.max_length
	,Precision = c.precision
	,Scale = c.scale
	,IsNullable = c.is_nullable
	,IsIdentity = c.is_identity
    ,PrimaryKeyType = ISNULL
		(
			(
			SELECT TOP (1) i.type_desc
			FROM sys.indexes AS i
			JOIN sys.index_columns AS ic
				ON i.object_id = ic.object_id
				AND i.index_id = ic.index_id
			WHERE
				ic.object_id = c.object_id
				AND ic.column_id = c.column_id
				AND i.is_primary_key = 1
			)
		,''
		)
	,ForeignKeySource = ISNULL
		(
			(
			SELECT TOP (1) QUOTENAME(ss.name) + '.' + QUOTENAME(so.name) + '.' + QUOTENAME(c.name)
			FROM sys.foreign_keys AS fk
			JOIN sys.foreign_key_columns AS fkc
				ON fk.object_id = fkc.constraint_object_id
			JOIN sys.objects AS so
				ON fkc.referenced_object_id = so.object_id
			JOIN sys.schemas AS ss
				ON so.schema_id = ss.schema_id
			WHERE
				fkc.parent_object_id = c.object_id
				AND fkc.parent_column_id = c.column_id
			)
		,''
		)
	,DependentForeignKeyCount =
		(
		SELECT COUNT(*)
		FROM sys.foreign_key_columns AS fkc
		WHERE
			c.object_id = fkc.referenced_object_id
			AND c.column_id = fkc.referenced_column_id
		)
	,DefaultValue = ISNULL
		(
			(
			SELECT TOP (1) dc.definition
			FROM sys.default_constraints AS dc
			WHERE
				c.object_id = dc.parent_object_id
				AND c.column_id = dc.parent_column_id
			)
		,''
		)
	,UniqueConstraintName = ISNULL
		(
			(
			SELECT TOP (1) i.name
			FROM sys.indexes AS i
			JOIN sys.index_columns AS ic
				ON i.object_id = ic.object_id
				AND i.index_id = ic.index_id
			WHERE
				ic.object_id = c.object_id
				AND ic.column_id = c.column_id
				AND i.is_unique_constraint = 1
			)
		,''
		)
	,CheckConstraintDefinition = ISNULL
		(
			(
			SELECT TOP (1) dc.definition
			FROM sys.check_constraints AS dc
			WHERE
				c.object_id = dc.parent_object_id
				AND c.column_id = dc.parent_column_id
			)
		,''
		)
FROM sys.schemas AS s
JOIN sys.objects AS o
	ON s.schema_id = o.schema_id
JOIN sys.columns AS c
	ON o.object_id = c.object_id
JOIN sys.types AS ut
	ON c.user_type_id = ut.user_type_id
JOIN sys.types AS st
	ON ut.system_type_id = st.user_type_id
WHERE
	o.type_desc NOT IN('INTERNAL_TABLE', 'SYSTEM_TABLE')
	AND s.name NOT IN('cdc', 'sys')
	AND o.name NOT LIKE 'MSp%'
	AND o.name NOT LIKE 'sys%'
	AND o.name NOT LIKE 'SYNC_%'

ORDER BY
	CASE o.type_desc
		WHEN 'USER_TABLE' THEN 1
		WHEN 'VIEW' THEN 2
		WHEN 'SQL_INLINE_TABLE_VALUED_FUNCTION' THEN 3
		WHEN 'SQL_TABLE_VALUED_FUNCTION' THEN 4
		ELSE 5
		END
	,s.name
	,o.name
    ,c.column_id

/*--------------------------------------------------------------------------------------------------
END
*/--------------------------------------------------------------------------------------------------
