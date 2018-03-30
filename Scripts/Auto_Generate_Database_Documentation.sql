/*
.EXAMPLE
    Connect SSMS to the database in which you wish to create extended properties and hit F5.

.DESCRIPTION:
    This script will not create the extended properties, but auto generate the commands to do so.
    The actual value (@value parameter) of the extended property still has to be manually input.
    This script will automatically add the user and date to the extended property value.

.NOTE
    Version: 1.1
    Modified: 2018-03-30 23:40:00 UTC+3 Konstantin Taranov
    Link: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Auto_Generate_Database_Documentation.sql
    Created: 2015-11-25
    Author: (C) Andy Jones mailto:andrew@aejsoftware.co.uk
*/
DECLARE @Parameter TABLE
   (
     [type_desc] sysname NOT NULL,
     parameter sysname NOT NULL,
     val NVARCHAR(100) NOT NULL,
     PRIMARY KEY ( [type_desc], parameter )
   );


/*set up the data for each object type specifying the correct value for each parameter.*/
INSERT  INTO @Parameter
       ( [type_desc], parameter, val )
VALUES  ( N'CHECK_CONSTRAINT', N'value', N'_replace_value' ),
       ( N'CHECK_CONSTRAINT', N'level0type', N'SCHEMA' ),
       ( N'CHECK_CONSTRAINT', N'level0name', N'_replace_schemaname' ),
       ( N'CHECK_CONSTRAINT', N'level1type', N'TABLE' ),
       ( N'CHECK_CONSTRAINT', N'level1name', N'_replace_parentname' ),
       ( N'CHECK_CONSTRAINT', N'level2type', N'CONSTRAINT' ),
       ( N'CHECK_CONSTRAINT', N'level2name', N'_replace_name' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'value', N'_replace_value' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level0type', N'SCHEMA' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level0name', N'_replace_schemaname' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level1type', N'TABLE' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level1name', N'_replace_parentname' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level2type', N'CONSTRAINT' ),
       ( N'FOREIGN_KEY_CONSTRAINT', N'level2name', N'_replace_name' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'value', N'_replace_value' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level0type', N'SCHEMA' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level0name', N'_replace_schemaname' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level1type', N'TABLE' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level1name', N'_replace_parentname' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level2type', N'CONSTRAINT' ),
       ( N'PRIMARY_KEY_CONSTRAINT', N'level2name', N'_replace_name' ),
       ( N'UNIQUE_CONSTRAINT', N'value', N'_replace_value' ),
       ( N'UNIQUE_CONSTRAINT', N'level0type', N'SCHEMA' ),
       ( N'UNIQUE_CONSTRAINT', N'level0name', N'_replace_schemaname' ),
       ( N'UNIQUE_CONSTRAINT', N'level1type', N'TABLE' ),
       ( N'UNIQUE_CONSTRAINT', N'level1name', N'_replace_parentname' ),
       ( N'UNIQUE_CONSTRAINT', N'level2type', N'CONSTRAINT' ),
       ( N'UNIQUE_CONSTRAINT', N'level2name', N'_replace_name' ),
       ( N'SQL_STORED_PROCEDURE', N'value', N'_replace_value' ),
       ( N'SQL_STORED_PROCEDURE', N'level0type', N'SCHEMA' ),
       ( N'SQL_STORED_PROCEDURE', N'level0name', N'_replace_schemaname' ),
       ( N'SQL_STORED_PROCEDURE', N'level1type', N'PROCEDURE' ),
       ( N'SQL_STORED_PROCEDURE', N'level1name', N'_replace_name' ),
       ( N'SQL_STORED_PROCEDURE', N'level2type', N'NULL' ),
       ( N'SQL_STORED_PROCEDURE', N'level2name', N'NULL' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'value', N'_replace_value' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level0type', N'SCHEMA' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level0name',
         N'_replace_schemaname' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level1type', N'FUNCTION' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level1name', N'_replace_name' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level2type', N'NULL' ),
       ( N'SQL_INLINE_TABLE_VALUED_FUNCTION', N'level2name', N'NULL' ),
       ( N'SQL_SCALAR_FUNCTION', N'value', N'_replace_value' ),
       ( N'SQL_SCALAR_FUNCTION', N'level0type', N'SCHEMA' ),
       ( N'SQL_SCALAR_FUNCTION', N'level0name', N'_replace_schemaname' ),
       ( N'SQL_SCALAR_FUNCTION', N'level1type', N'FUNCTION' ),
       ( N'SQL_SCALAR_FUNCTION', N'level1name', N'_replace_name' ),
       ( N'SQL_SCALAR_FUNCTION', N'level2type', N'NULL' ),
       ( N'SQL_SCALAR_FUNCTION', N'level2name', N'NULL' ),
       ( N'USER_TABLE', N'value', N'_replace_value' ),
       ( N'USER_TABLE', N'level0type', N'SCHEMA' ),
       ( N'USER_TABLE', N'level0name', N'_replace_schemaname' ),
       ( N'USER_TABLE', N'level1type', N'TABLE' ),
       ( N'USER_TABLE', N'level1name', N'_replace_name' ),
       ( N'USER_TABLE', N'level2type', N'NULL' ),
       ( N'USER_TABLE', N'level2name', N'NULL' ),
       ( N'INDEX', N'value', N'_replace_value' ),
       ( N'INDEX', N'level0type', N'SCHEMA' ),
       ( N'INDEX', N'level0name', N'_replace_schemaname' ),
       ( N'INDEX', N'level1type', N'TABLE' ),
       ( N'INDEX', N'level1name', N'_replace_parentname' ),
       ( N'INDEX', N'level2type', N'INDEX' ),
       ( N'INDEX', N'level2name', N'_replace_name' ),
       ( N'COLUMN', N'value', N'_replace_value' ),
       ( N'COLUMN', N'level0type', N'SCHEMA' ),
       ( N'COLUMN', N'level0name', N'_replace_schemaname' ),
       ( N'COLUMN', N'level1type', N'TABLE' ),
       ( N'COLUMN', N'level1name', N'_replace_parentname' ),
       ( N'COLUMN', N'level2type', N'COLUMN' ),
       ( N'COLUMN', N'level2name', N'_replace_name' );


WITH    Obj /*union all objects on which to create extended properties. Objects, columns and indexes.*/
         AS ( SELECT   parentname = COALESCE(OBJECT_NAME(obj.parent_object_id),
                                             obj.name) ,
                       name = obj.name ,
                       schemaname = SCHEMA_NAME(obj.[schema_id]) ,
                       [type_desc] = obj.[type_desc] ,
                       major_id = obj.[object_id] ,
                       minor_id = 0,
class_desc = N'OBJECT_OR_COLUMN'
              FROM     sys.objects AS obj
              WHERE    obj.is_ms_shipped = 0
              UNION ALL
              SELECT   parentname = OBJECT_NAME(c.[object_id]) ,
                       name = c.name ,
                       schemaname = OBJECT_SCHEMA_NAME(c.[object_id]) ,
                       [type_desc] = N'COLUMN' ,
                       major_id = c.[object_id] ,
                       minor_id = c.column_id,
class_desc = N'OBJECT_OR_COLUMN'
              FROM     sys.columns AS c
              WHERE    OBJECTPROPERTYEX(c.[object_id], 'IsMSShipped') = 0
                       AND OBJECTPROPERTYEX(c.[object_id], 'IsUserTable') = 1 --only document table columns, not views/functions. Remove predicate if required.
              UNION ALL
              SELECT   parentname = OBJECT_NAME(i.[object_id]) ,
                       name = i.name ,
                       schemaname = OBJECT_SCHEMA_NAME(i.[object_id]) ,
                       [type_desc] = N'INDEX' ,
                       major_id = i.[object_id] ,
                       minor_id = i.index_id,
class_desc = N'INDEX'
              FROM     sys.indexes AS i
              WHERE    OBJECTPROPERTYEX(i.[object_id], 'IsMSShipped') = 0
                       AND i.is_primary_key = 0 --the constraint is already documented, don't document the index too. Remove predicate if required.
                       AND i.is_unique_constraint = 0 --the constraint is already documented, don't document the index too. Remove predicate if required.
AND i.[type_desc] <> N'HEAP' --the table is already documented, don't document the heap index row too.
            ),
/*Join objects on which to create extended properties to the parameters, performing string replacement where necessary.*/
       Parameter_Value
         AS ( SELECT   o.major_id ,
                       o.minor_id ,
o.class_desc,
                       p.parameter ,
[name] = N'MS_Description',
                       val = CASE p.val
                               WHEN N'_replace_schemaname' THEN o.schemaname
                               WHEN N'_replace_parentname' THEN o.parentname
                               WHEN N'_replace_name' THEN o.name
                               WHEN N'_replace_value'
                               THEN SYSTEM_USER + N' '
                                    + CONVERT(CHAR(10), CURRENT_TIMESTAMP, 103)
                                    + N': ' + p.val
                               ELSE p.val
                             END
              FROM     @Parameter AS p
                       INNER JOIN Obj AS o ON o.[type_desc] = p.[type_desc] COLLATE DATABASE_DEFAULT
            )
/*pivot the result set so we have one correctly formatted extended property create statement per object.*/
   SELECT  Add_Extended_Property = N'EXECUTE sp_addextendedproperty'
           + N' @name = ''' + [name] + N''', @value = ' + [value]
           + N', @level0type = ' + [level0type] + N', @level0name = '
           + [level0name] + N', @level1type = ' + [level1type]
           + N', @level1name = ' + [level1name] + N', @level2type = '
           + [level2type] + N', @level2name = ' + [level2name] + N';'
   FROM    ( SELECT    pv.major_id ,
                       pv.minor_id ,
pv.class_desc,
pv.[name],
                       pv.parameter ,
                       val = CASE pv.val
                               WHEN N'NULL' THEN pv.val
                               ELSE '''' + pv.val + ''''
                             END
             FROM      Parameter_Value AS pv
             WHERE     NOT EXISTS ( SELECT *
                                    FROM   sys.extended_properties AS ep
                                    WHERE  ep.major_id = pv.major_id
                                           AND ep.minor_id = pv.minor_id
AND ep.class_desc = pv.class_desc
AND ep.[name] = pv.[name] )
           ) AS SourceTable PIVOT
( MIN(val) FOR parameter IN (  [value], [level0type], [level0name],
                             [level1type], [level1name], [level2type],
                             [level2name] ) ) AS PivotTable
   ORDER BY Add_Extended_Property;
