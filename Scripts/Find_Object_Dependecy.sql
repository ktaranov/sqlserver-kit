 /*
Author: Konstantin Taranov
Source: https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Find_Object_Dependecy.sql
*/
DECLARE @objectName SYSNAME = 'ObjectName';
DECLARE @schemaName SYSNAME = 'SchemaName';

IF Object_id('tempdb..#tempdep', 'U') IS NOT NULL
  DROP TABLE #tempdep;

IF Object_id('tempdb..#t1', 'U') IS NOT NULL
  DROP TABLE #t1;

IF Object_id('tempdb..#t2', 'U') IS NOT NULL
  DROP TABLE #t2;

CREATE TABLE #tempdep
  (
     objid      INT NOT NULL
     ,objname   SYSNAME NOT NULL
     ,objschema SYSNAME NULL
     ,objdb     SYSNAME NOT NULL
     ,objtype   SMALLINT NOT NULL
  );

EXEC sp_executesql
  N'INSERT INTO #tempdep
    SELECT tbl.object_id AS [ID], tbl.name AS [Name], SCHEMA_NAME(tbl.schema_id) AS [Schema], db_name(), 3
    FROM sys.tables AS tbl
    WHERE (tbl.name=@_msparam_0 and SCHEMA_NAME(tbl.schema_id)=@_msparam_1)',
  N'@_msparam_0 nvarchar(4000),@_msparam_1 nvarchar(4000)',
  @_msparam_0=@objectName,
  @_msparam_1=@schemaName;

DECLARE @find_referencing_objects INT;

SET @find_referencing_objects = 1;

-- parameters:
-- 1. create table #tempdep (objid int NOT NULL, objtype smallint NOT NULL)
--    contains source objects
-- 2. @find_referencing_objects defines ordering
--    1 order for drop
--    0 order for script
DECLARE @must_set_nocount_off BIT;

SET @must_set_nocount_off = 0;

IF @@OPTIONS & 512 = 0
  SET @must_set_nocount_off = 1;

SET nocount ON;

DECLARE @u INT;
DECLARE @udf INT;
DECLARE @v INT;
DECLARE @sp INT;
DECLARE @def INT;
DECLARE @rule INT;
DECLARE @tr INT;
DECLARE @uda INT;
DECLARE @uddt INT;
DECLARE @xml INT;
DECLARE @udt INT;
DECLARE @assm INT;
DECLARE @part_sch INT;
DECLARE @part_func INT;
DECLARE @synonym INT;
DECLARE @sequence INT;
DECLARE @udtt INT;
DECLARE @ddltr INT;
DECLARE @unknown INT;
DECLARE @pg INT;

SET @u = 3;
SET @udf = 0;
SET @v = 2;
SET @sp = 4;
SET @def = 6;
SET @rule = 7;
SET @tr = 8;
SET @uda = 11;
SET @synonym = 12;
SET @sequence = 13;
-- above 100 -> not in sys.objects
SET @uddt = 101;
SET @xml = 102;
SET @udt = 103;
SET @assm = 1000;
SET @part_sch = 201;
SET @part_func = 202;
SET @udtt = 104;
SET @ddltr = 203;
SET @unknown = 1001;
SET @pg = 204;

-- variables for referenced type obtained from sys.sql_expression_dependencies
DECLARE @obj INT;

SET @obj = 20;

DECLARE @type INT;

SET @type = 21;

-- variables for xml and part_func are already there
CREATE TABLE #t1
  (
     object_id        INT NULL
     ,object_name     SYSNAME COLLATE database_default NULL
     ,object_schema   SYSNAME COLLATE database_default NULL
     ,object_db       SYSNAME NULL
     ,object_svr      SYSNAME NULL
     ,object_type     SMALLINT NOT NULL
     ,relative_id     INT NOT NULL
     ,relative_name   SYSNAME COLLATE database_default NOT NULL
     ,relative_schema SYSNAME COLLATE database_default NULL
     ,relative_db     SYSNAME NULL
     ,relative_svr    SYSNAME NULL
     ,relative_type   SMALLINT NOT NULL
     ,schema_bound    BIT NOT NULL
     ,rank            SMALLINT NULL
     ,degree          INT NULL
  );

-- we need to create another temporary table to store the dependencies from sys.sql_expression_dependencies till the updated values are inserted finally into #t1
CREATE TABLE #t2
  (
     object_id        INT NULL
     ,object_name     SYSNAME COLLATE database_default NULL
     ,object_schema   SYSNAME COLLATE database_default NULL
     ,object_db       SYSNAME NULL
     ,object_svr      SYSNAME NULL
     ,object_type     SMALLINT NOT NULL
     ,relative_id     INT NOT NULL
     ,relative_name   SYSNAME COLLATE database_default NOT NULL
     ,relative_schema SYSNAME COLLATE database_default NULL
     ,relative_db     SYSNAME NULL
     ,relative_svr    SYSNAME NULL
     ,relative_type   SMALLINT NOT NULL
     ,schema_bound    BIT NOT NULL
     ,rank            SMALLINT NULL
  );

-- This index will ensure that we have unique parent-child relationship
CREATE UNIQUE CLUSTERED INDEX i1
  ON #t1(object_name, object_schema, object_db, object_svr, object_type, relative_name, relative_schema, relative_type)
  WITH ignore_dup_key;

DECLARE @iter_no INT;
SET @iter_no = 1;

DECLARE @rows INT;
SET @rows = 1;

INSERT #t1
       (object_id
        ,object_name
        ,object_schema
        ,object_db
        ,object_type
        ,relative_id
        ,relative_name
        ,relative_schema
        ,relative_db
        ,relative_type
        ,schema_bound
        ,rank)
SELECT l.objid
       ,l.objname
       ,l.objschema
       ,l.objdb
       ,l.objtype
       ,l.objid
       ,l.objname
       ,l.objschema
       ,l.objdb
       ,l.objtype
       ,1
       ,@iter_no
FROM   #tempdep l;

-- change the object_id of table types to their user_defined_id
UPDATE #t1
SET    object_id = tt.user_type_id
       ,relative_id = tt.user_type_id
FROM   sys.table_types AS tt
WHERE  tt.type_table_object_id = #t1.object_id
       AND object_type = @udtt;

WHILE @rows > 0
  BEGIN
      SET @rows = 0

      IF ( 1 = @find_referencing_objects )
        BEGIN
            -- HARD DEPENDENCIES
            -- these dependencies have to be in the same database only
            -- tables that reference uddts or udts
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tbl.object_id
                   ,tbl.name
                   ,Schema_name(tbl.schema_id)
                   ,t.object_db
                   ,@u
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS c
                     ON c.user_type_id = t.object_id
                   JOIN sys.tables AS tbl
                     ON tbl.object_id = c.object_id
            WHERE  @iter_no = t.rank
                   AND ( t.object_type = @uddt
                          OR t.object_type = @udt )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- udtts that reference uddts or udts
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tt.user_type_id
                   ,tt.name
                   ,Schema_name(tt.schema_id)
                   ,t.object_db
                   ,@udtt
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS c
                     ON c.user_type_id = t.object_id
                   JOIN sys.table_types AS tt
                     ON tt.type_table_object_id = c.object_id
            WHERE  @iter_no = t.rank
                   AND ( t.object_type = @uddt
                          OR t.object_type = @udt )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- tables/views that reference triggers
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,@tr
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.objects AS o
                     ON o.parent_object_id = t.object_id
                        AND o.type = 'TR'
            WHERE  @iter_no = t.rank
                   AND ( t.object_type = @u
                          OR t.object_type = @v )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- tables that reference defaults (only default objects)
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,@u
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS clmns
                     ON clmns.default_object_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = clmns.object_id
                        AND 0 = ISNULL(o.parent_object_id, 0)
            WHERE  @iter_no = t.rank
                   AND t.object_type = @def
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- types that reference defaults (only default objects)
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tp.user_type_id
                   ,tp.name
                   ,Schema_name(tp.schema_id)
                   ,t.object_db
                   ,@uddt
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.types AS tp
                     ON tp.default_object_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = t.object_id
                        AND 0 = ISNULL(o.parent_object_id, 0)
            WHERE  @iter_no = t.rank
                   AND t.object_type = @def
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- tables that reference rules
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tbl.object_id
                   ,tbl.name
                   ,Schema_name(tbl.schema_id)
                   ,t.object_db
                   ,@u
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS clmns
                     ON clmns.rule_object_id = t.object_id
                   JOIN sys.tables AS tbl
                     ON tbl.object_id = clmns.object_id
            WHERE  @iter_no = t.rank
                   AND t.relative_type = @rule
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- types that reference rules
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tp.user_type_id
                   ,tp.name
                   ,Schema_name(tp.schema_id)
                   ,t.object_db
                   ,@uddt
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.types AS tp
                     ON tp.rule_object_id = t.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @rule
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- tables that reference XmlSchemaCollections
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tbl.object_id
                   ,tbl.name
                   ,Schema_name(tbl.schema_id)
                   ,t.object_db
                   ,@u
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS c
                     ON c.xml_collection_id = t.object_id
                   JOIN sys.tables AS tbl
                     ON tbl.object_id = c.object_id -- eliminate views
            WHERE  @iter_no = t.rank
                   AND t.object_type = @xml
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- table types that reference XmlSchemaCollections
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tt.user_type_id
                   ,tt.name
                   ,Schema_name(tt.schema_id)
                   ,t.object_db
                   ,@udtt
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.columns AS c
                     ON c.xml_collection_id = t.object_id
                   JOIN sys.table_types AS tt
                     ON tt.type_table_object_id = c.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @xml
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- procedures that reference XmlSchemaCollections
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,( CASE
                        WHEN o.type IN ( 'P', 'RF', 'PC' ) THEN @sp
                        ELSE @udf
                      END )
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.parameters AS c
                     ON c.xml_collection_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = c.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @xml
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- udf, sp, uda, trigger all that reference assembly
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,( CASE o.type
                        WHEN 'AF' THEN @uda
                        WHEN 'PC' THEN @sp
                        WHEN 'FS' THEN @udf
                        WHEN 'FT' THEN @udf
                        WHEN 'TA' THEN @tr
                        ELSE @udf
                      END )
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.assembly_modules AS am
                     ON ( ( am.assembly_id = t.object_id )
                          AND ( am.assembly_id >= 65536 ) )
                   JOIN sys.objects AS o
                     ON am.object_id = o.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @assm
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- udt that reference assembly
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT at.user_type_id
                   ,at.name
                   ,Schema_name(at.schema_id)
                   ,t.object_db
                   ,@udt
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.assembly_types AS at
                     ON ( ( at.assembly_id = t.object_id )
                          AND ( at.is_user_defined = 1 ) )
            WHERE  @iter_no = t.rank
                   AND t.object_type = @assm
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- assembly that reference assembly
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT asm.assembly_id
                   ,asm.name
                   ,t.object_db
                   ,@assm
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.assembly_references AS ar
                     ON ( ( ar.referenced_assembly_id = t.object_id )
                          AND ( ar.referenced_assembly_id >= 65536 ) )
                   JOIN sys.assemblies AS asm
                     ON asm.assembly_id = ar.assembly_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @assm
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- table references table
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT tbl.object_id
                   ,tbl.name
                   ,Schema_name(tbl.schema_id)
                   ,t.object_db
                   ,@u
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.foreign_keys AS fk
                     ON fk.referenced_object_id = t.object_id
                   JOIN sys.tables AS tbl
                     ON tbl.object_id = fk.parent_object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @u
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- uda references types
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,@uda
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.parameters AS p
                     ON p.user_type_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = p.object_id
                        AND o.type = 'AF'
            WHERE  @iter_no = t.rank
                   AND t.object_type IN ( @udt, @uddt, @udtt )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            -- table,view references partition scheme
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT o.object_id
                   ,o.name
                   ,Schema_name(o.schema_id)
                   ,t.object_db
                   ,( CASE o.type
                        WHEN 'V' THEN @v
                        ELSE @u
                      END )
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.indexes AS idx
                     ON idx.data_space_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = idx.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @part_sch
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- partition scheme references partition function
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT ps.data_space_id
                   ,ps.name
                   ,t.object_db
                   ,@part_sch
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.partition_schemes AS ps
                     ON ps.function_id = t.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type = @part_func
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- plan guide references sp, udf, triggers
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT pg.plan_guide_id
                   ,pg.name
                   ,t.object_db
                   ,@pg
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,1
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.plan_guides AS pg
                     ON pg.scope_object_id = t.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_type IN ( @sp, @udf, @tr )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- synonym refrences object
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT s.object_id
                   ,s.name
                   ,Schema_name(s.schema_id)
                   ,t.object_db
                   ,@synonym
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,0
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.synonyms AS s
                     ON Object_id(s.base_object_name) = t.object_id
            WHERE  @iter_no = t.rank
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            --  sequences that reference uddts
            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT s.object_id
                   ,s.name
                   ,Schema_name(s.schema_id)
                   ,t.object_db
                   ,@sequence
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,0
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.sequences AS s
                     ON s.user_type_id = t.object_id
            WHERE  @iter_no = t.rank
                   AND ( t.object_type = @uddt )
                   AND ( t.object_svr IS NULL
                         AND t.object_db = DB_NAME() );

            SET @rows = @rows + @@rowcount;

            -- SOFT DEPENDENCIES
            DECLARE name_cursor CURSOR FOR
              SELECT DISTINCT t.object_id
                              ,t.object_name
                              ,t.object_schema
                              ,t.object_type
              FROM   #t1 AS t
              WHERE  @iter_no = t.rank
                     AND ( t.object_svr IS NULL
                           AND t.object_db = DB_NAME() )
                     AND t.object_type NOT IN ( @part_sch, @assm, @tr, @ddltr );

            OPEN name_cursor;

            DECLARE @objid INT;
            DECLARE @objname SYSNAME;
            DECLARE @objschema SYSNAME;
            DECLARE @objtype SMALLINT;
            DECLARE @fullname SYSNAME;
            DECLARE @objecttype SYSNAME;

            FETCH next FROM name_cursor INTO @objid, @objname, @objschema, @objtype;

            WHILE ( @@FETCH_STATUS <> -1 )
              BEGIN
                  SET @fullname = CASE
                                    WHEN @objschema IS NULL THEN
                                    QUOTENAME(@objname)
                                    ELSE QUOTENAME(@objschema) + '.' + QUOTENAME(@objname)
                                  END;
                  SET @objecttype = CASE
                                      WHEN @objtype IN ( @uddt, @udt, @udtt )
                                    THEN
                                      'TYPE'
                                      WHEN @objtype = @xml THEN
                                      'XML_SCHEMA_COLLECTION'
                                      WHEN @objtype = @part_func THEN
                                      'PARTITION_FUNCTION'
                                      ELSE 'OBJECT'
                                    END;

                  INSERT #t2
                         (object_type
                          ,object_id
                          ,object_name
                          ,object_schema
                          ,object_db
                          ,object_svr
                          ,relative_id
                          ,relative_name
                          ,relative_schema
                          ,relative_db
                          ,relative_type
                          ,schema_bound
                          ,rank)
                  SELECT CASE dep.referencing_class
                           WHEN 1 THEN (SELECT CASE
                                                 WHEN obj.type = 'U' THEN @u
                                                 WHEN obj.type = 'V' THEN @v
                                                 WHEN obj.type = 'TR' THEN @tr
                                                 WHEN obj.type IN (
                                                      'P', 'RF', 'PC' )
                                               THEN
                                                 @sp
                                                 WHEN obj.type IN ( 'AF' ) THEN
                                                 @uda
                                                 WHEN obj.type IN (
                                                      'TF', 'FN', 'IF',
                                                      'FS',
                                                      'FT' )
                                               THEN
                                                 @udf
                                                 WHEN obj.type = 'D' THEN @def
                                                 WHEN obj.type = 'SN' THEN
                                                 @synonym
                                                 WHEN obj.type = 'SO' THEN
                                                 @sequence
                                                 ELSE @obj
                                               END
                                        FROM   sys.objects AS obj
                                        WHERE
                           obj.object_id = dep.referencing_id)
                           WHEN 6 THEN (SELECT CASE
                                                 WHEN ( tp.is_assembly_type = 1
                                                      )
                                               THEN
                                                 @udt
                                                 WHEN ( tp.is_table_type = 1 )
                                               THEN
                                                 @udtt
                                                 ELSE @uddt
                                               END
                                        FROM   sys.types AS tp
                                        WHERE
                           tp.user_type_id = dep.referencing_id)
                           WHEN 7 THEN @u
                           WHEN 9 THEN @u
                           WHEN 10 THEN @xml
                           WHEN 12 THEN @ddltr
                           WHEN 21 THEN @part_func
                         END
                         ,dep.referencing_id
                         ,dep.referencing_entity_name
                         ,dep.referencing_schema_name
                         ,DB_NAME()
                         ,NULL
                         ,@objid
                         ,@objname
                         ,@objschema
                         ,DB_NAME()
                         ,@objtype
                         ,0
                         ,@iter_no + 1
                  FROM   sys.dm_sql_referencing_entities(@fullname, @objecttype) AS dep;

                  FETCH NEXT FROM name_cursor INTO @objid, @objname, @objschema, @objtype;
              END

            CLOSE name_cursor;
            DEALLOCATE name_cursor;

            UPDATE #t2
            SET    object_id = obj.object_id
                   ,object_name = obj.name
                   ,object_schema = Schema_name(obj.schema_id)
                   ,object_type = CASE
                                    WHEN obj.type = 'U' THEN @u
                                    WHEN obj.type = 'V' THEN @v
                                  END
            FROM   sys.objects AS o
                   JOIN sys.objects AS obj
                     ON obj.object_id = o.parent_object_id
            WHERE  o.object_id = #t2.object_id
                   AND ( #t2.object_type = @obj
                          OR o.parent_object_id != 0 )
                   AND #t2.rank = @iter_no + 1;

            INSERT #t1
                   (object_id
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_svr
                    ,object_type
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_svr
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT object_id
                   ,object_name
                   ,object_schema
                   ,object_db
                   ,object_svr
                   ,object_type
                   ,relative_id
                   ,relative_name
                   ,relative_schema
                   ,relative_db
                   ,relative_svr
                   ,relative_type
                   ,schema_bound
                   ,rank
            FROM   #t2
            WHERE  @iter_no + 1 = rank
                   AND #t2.object_id != #t2.relative_id;

            SET @rows = @rows + @@rowcount;
        END
      ELSE
        BEGIN
            -- SOFT DEPENDENCIES
            -- insert all values from sys.sql_expression_dependencies for the corresponding object
            -- first insert them in #t2, update them and THEN finally insert them in #t1
            INSERT #t2
                   (object_type
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_svr
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT CASE dep.referenced_class
                     WHEN 1 THEN @obj
                     WHEN 6 THEN @type
                     WHEN 7 THEN @u
                     WHEN 9 THEN @u
                     WHEN 10 THEN @xml
                     WHEN 21 THEN @part_func
                   END
                   ,dep.referenced_entity_name
                   ,dep.referenced_schema_name
                   ,dep.referenced_database_name
                   ,dep.referenced_server_name
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,dep.is_schema_bound_reference
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.sql_expression_dependencies AS dep
                     ON dep.referencing_id = t.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_svr IS NULL
                   AND t.object_db = DB_NAME();

            -- insert all the dependency values in case of a table that references a check
            INSERT #t2
                   (object_type
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_svr
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT CASE dep.referenced_class
                     WHEN 1 THEN @obj
                     WHEN 6 THEN @type
                     WHEN 7 THEN @u
                     WHEN 9 THEN @u
                     WHEN 10 THEN @xml
                     WHEN 21 THEN @part_func
                   END
                   ,dep.referenced_entity_name
                   ,dep.referenced_schema_name
                   ,dep.referenced_database_name
                   ,dep.referenced_server_name
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,dep.is_schema_bound_reference
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.sql_expression_dependencies AS d
                     ON d.referenced_id = t.object_id
                   JOIN sys.objects AS o
                     ON o.object_id = d.referencing_id
                        AND o.type = 'C'
                   JOIN sys.sql_expression_dependencies AS dep
                     ON dep.referencing_id = d.referencing_id
                        AND dep.referenced_id != t.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_svr IS NULL
                   AND t.object_db = DB_NAME()
                   AND t.object_type = @u;

            -- insert all the dependency values in case of an object that belongs to another object whose dependencies are being found
            INSERT #t2
                   (object_type
                    ,object_name
                    ,object_schema
                    ,object_db
                    ,object_svr
                    ,relative_id
                    ,relative_name
                    ,relative_schema
                    ,relative_db
                    ,relative_type
                    ,schema_bound
                    ,rank)
            SELECT CASE dep.referenced_class
                     WHEN 1  THEN @obj
                     WHEN 6  THEN @type
                     WHEN 7  THEN @u
                     WHEN 9  THEN @u
                     WHEN 10 THEN @xml
                     WHEN 21 THEN @part_func
                   END
                   ,dep.referenced_entity_name
                   ,dep.referenced_schema_name
                   ,dep.referenced_database_name
                   ,dep.referenced_server_name
                   ,t.object_id
                   ,t.object_name
                   ,t.object_schema
                   ,t.object_db
                   ,t.object_type
                   ,dep.is_schema_bound_reference
                   ,@iter_no + 1
            FROM   #t1 AS t
                   JOIN sys.objects AS o
                     ON o.parent_object_id = t.object_id
                   JOIN sys.sql_expression_dependencies AS dep
                     ON dep.referencing_id = o.object_id
            WHERE  @iter_no = t.rank
                   AND t.object_svr IS NULL
                   AND t.object_db = DB_NAME();

            -- queries for objects with object_id null and object_svr null - resolve them
            -- we will build the query to resolve the objects
            -- increase @rows as we bind the objects
            DECLARE db_cursor CURSOR FOR
              SELECT DISTINCT ISNULL(object_db, DB_NAME())
              FROM   #t2 AS t
              WHERE  t.rank = ( @iter_no + 1 )
                     AND t.object_id IS NULL
                     AND t.object_svr IS NULL;

            OPEN db_cursor;

            DECLARE @dbname SYSNAME;
            DECLARE @quote_quoted_dbname SYSNAME;
            DECLARE @bracket_quoted_dbname SYSNAME;

            FETCH next FROM db_cursor INTO @dbname;

            WHILE ( @@FETCH_STATUS <> -1 )
              BEGIN
                  IF ( DB_ID(@dbname) IS NULL )
                    BEGIN
                        FETCH next FROM db_cursor INTO @dbname;

                        CONTINUE;
                    END

                  SET @quote_quoted_dbname = QUOTENAME(@dbname, '''');
                  SET @bracket_quoted_dbname = QUOTENAME(@dbname, ']');

                  DECLARE @query NVARCHAR(max);

                  -- WHEN schema is not null 
                  -- @obj
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = obj.object_id, object_type = case WHEN obj.type = ''U'' THEN '
                               + CAST(@u AS NVARCHAR(8))
                               + ' WHEN obj.type = ''V'' THEN '
                               + CAST(@v AS NVARCHAR(8))
                               + ' WHEN obj.type = ''TR'' THEN '
                               + CAST(@tr AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''P'', ''RF'', ''PC'' ) THEN '
                               + CAST(@sp AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''AF'' ) THEN '
                               + CAST(@uda AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''TF'', ''FN'', ''IF'', ''FS'', ''FT'' ) THEN '
                               + CAST(@udf AS NVARCHAR(8))
                               + ' WHEN obj.type = ''D'' THEN '
                               + CAST(@def AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SN'' THEN '
                               + CAST(@synonym AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SO'' THEN '
                               + CAST(@sequence AS NVARCHAR(8)) + ' ELSE '
                               + CAST(@unknown AS NVARCHAR(8))
                               + ' END FROM '
                               + @bracket_quoted_dbname
                               + '.sys.objects as obj JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = obj.schema_id
                                  WHERE obj.name = #t2.object_name collate database_default AND
                                        sch.name = #t2.object_schema collate database_default AND
                                        #t2.object_type = '
                               + CAST(@obj AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NOT NULL AND (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL and #t2.object_svr IS NULL;'

                  EXEC sp_executesql @query;

                  -- @type
                  SET @query = 'update #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = t.user_type_id, object_type = case WHEN t.is_assembly_type = 1 THEN '
                               + CAST(@udt AS NVARCHAR(8))
                               + ' WHEN t.is_table_type = 1 THEN '
                               + CAST(@udtt AS NVARCHAR(8)) + ' ELSE '
                               + CAST(@uddt AS NVARCHAR(8))
                               + ' END FROM '
                               + @bracket_quoted_dbname
                               + '.sys.types AS t JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = t.schema_id
                                  WHERE t.name = #t2.object_name collate database_default AND
                                        sch.name = #t2.object_schema collate database_default AND
                                        #t2.object_type = '
                               + CAST(@type AS NVARCHAR(8))
                               + ' and #t2.object_schema IS NOT NULL AND (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL and #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;
                  
                  -- @xml
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = x.xml_collection_id FROM '
                               + @bracket_quoted_dbname
                               + '.sys.xml_schema_collections AS x JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = x.schema_id
                                  WHERE x.name = #t2.object_name collate database_default AND
                                        sch.name = #t2.object_schema collate database_default AND
                                        #t2.object_type = '
                               + CAST(@xml AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NOT NULL AND (#t2.object_db IS NULL OR #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL and #t2.object_svr IS NULL;';
                  
                  EXEC sp_executesql @query;

                  -- @part_func - schema is always null
                  -- @schema is null
                  -- consider schema as 'dbo'
                  -- @obj
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = obj.object_id, object_schema = SCHEMA_NAME(obj.schema_id), object_type = CASE WHEN obj.type = ''U'' THEN '
                               + CAST(@u AS NVARCHAR(8))
                               + ' WHEN obj.type = ''V'' THEN '
                               + CAST(@v AS NVARCHAR(8))
                               + ' WHEN obj.type = ''TR'' THEN '
                               + CAST(@tr AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''P'', ''RF'', ''PC'' ) THEN '
                               + CAST(@sp AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''AF'' ) THEN '
                               + CAST(@uda AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''TF'', ''FN'', ''IF'', ''FS'', ''FT'' ) THEN '
                               + CAST(@udf AS NVARCHAR(8))
                               + ' WHEN obj.type = ''D'' THEN '
                               + CAST(@def AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SN'' THEN '
                               + CAST(@synonym AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SO'' THEN '
                               + CAST(@sequence AS NVARCHAR(8)) + ' ELSE '
                               + CAST(@unknown AS NVARCHAR(8))
                               + ' END FROM '
                               + @bracket_quoted_dbname
                               + '.sys.objects as obj
                                  WHERE obj.name = #t2.object_name collate database_default AND
                                        SCHEMA_NAME(obj.schema_id) = ''dbo'' AND 
                                        #t2.object_type = '
                               + CAST(@obj AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NULL AND (#t2.object_db IS NULL OR #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL and #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;

                  -- @type
                  SET @query = 'update #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = t.user_type_id, object_schema = SCHEMA_NAME(t.schema_id), object_type = case WHEN t.is_assembly_type = 1 THEN '
                               + CAST(@udt AS NVARCHAR(8))
                               + ' WHEN t.is_table_type = 1 THEN '
                               + CAST(@udtt AS NVARCHAR(8)) + ' else '
                               + CAST(@uddt AS NVARCHAR(8))
                               + ' end                 from '
                               + @bracket_quoted_dbname
                               + '.sys.types AS t
                                   where t.name = #t2.object_name collate database_default AND
                                         SCHEMA_NAME(t.schema_id) = ''dbo'' AND
                                         #t2.object_type = '
                               + CAST(@type AS NVARCHAR(8))
                               + ' and #t2.object_schema IS NULL AND (#t2.object_db IS NULL OR #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL AND #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;

                  -- @xml
                  SET @query = 'update #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = x.xml_collection_id, object_schema = SCHEMA_NAME(x.schema_id) FROM '
                               + @bracket_quoted_dbname
                               + '.sys.xml_schema_collections as x 
                                  WHERE x.name = #t2.object_name collate database_default AND
                                        SCHEMA_NAME(x.schema_id) = ''dbo'' AND
                                        #t2.object_type = '
                               + CAST(@xml AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NULL AND (#t2.object_db IS NULL OR #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ')                 and #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) and #t2.object_id IS NULL and #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;

                  -- consider schema as t.relative_schema
                  -- the parent object will have the default schema of user in case of dynamic schema binding
                  -- @obj
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = obj.object_id, object_schema = SCHEMA_NAME(obj.schema_id), object_type = CASE WHEN obj.type = ''U'' THEN '
                               + CAST(@u AS NVARCHAR(8))
                               + ' WHEN obj.type = ''V'' THEN '
                               + CAST(@v AS NVARCHAR(8))
                               + ' WHEN obj.type = ''TR'' THEN '
                               + CAST(@tr AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''P'', ''RF'', ''PC'' ) THEN '
                               + CAST(@sp AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''AF'' ) THEN '
                               + CAST(@uda AS NVARCHAR(8))
                               + ' WHEN obj.type in ( ''TF'', ''FN'', ''IF'', ''FS'', ''FT'' ) THEN '
                               + CAST(@udf AS NVARCHAR(8))
                               + ' WHEN obj.type = ''D'' THEN '
                               + CAST(@def AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SN'' THEN '
                               + CAST(@synonym AS NVARCHAR(8))
                               + ' WHEN obj.type = ''SO'' THEN '
                               + CAST(@sequence AS NVARCHAR(8)) + ' else '
                               + CAST(@unknown AS NVARCHAR(8))
                               + ' end                 from '
                               + @bracket_quoted_dbname
                               + '.sys.objects as obj JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = obj.schema_id
                                   WHERE obj.name = #t2.object_name collate database_default AND
                                         sch.name = #t2.relative_schema collate database_default AND
                                         #t2.object_type = '
                               + CAST(@obj AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NULL AND (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL AND #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;

                  -- @type
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = t.user_type_id, object_schema = SCHEMA_NAME(t.schema_id), object_type = case WHEN t.is_assembly_type = 1 THEN '
                               + CAST(@udt AS NVARCHAR(8))
                               + ' WHEN t.is_table_type = 1 THEN '
                               + CAST(@udtt AS NVARCHAR(8)) + ' else '
                               + CAST(@uddt AS NVARCHAR(8))
                               + ' END FROM '
                               + @bracket_quoted_dbname
                               + '.sys.types as t JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = t.schema_id
                                  WHERE t.name   = #t2.object_name collate database_default AND 
                                        sch.name = #t2.relative_schema collate database_default AND
                                        #t2.object_type = '
                               + CAST(@type AS NVARCHAR(8))
                               + ' and #t2.object_schema IS NULL AND (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL AND #t2.object_svr IS NULL;'

                  EXEC sp_executesql @query;

                  -- @xml
                  SET @query = 'UPDATE #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = x.xml_collection_id, object_schema = SCHEMA_NAME(x.schema_id) FROM '
                               + @bracket_quoted_dbname
                               + '.sys.xml_schema_collections as x JOIN '
                               + @bracket_quoted_dbname
                               + '.sys.schemas as sch on sch.schema_id = x.schema_id
                                  WHERE x.name = #t2.object_name collate database_default AND
                                        sch.name = #t2.relative_schema collate database_default AND
                                        #t2.object_type = '
                               + CAST(@xml AS NVARCHAR(8))
                               + ' AND #t2.object_schema IS NULL AND (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ') AND #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) and #t2.object_id IS NULL AND #t2.object_svr IS NULL;';

                  EXEC sp_executesql @query;

                  -- @part_func always have schema as null
                  SET @query = 'update #t2 set object_db = N'
                               + @quote_quoted_dbname
                               + ', object_id = p.function_id FROM '
                               + @bracket_quoted_dbname
                               + '.sys.partition_functions as p
                                  WHERE p.name = #t2.object_name collate database_default AND
                                       #t2.object_type = '
                               + CAST(@part_func AS NVARCHAR(8))
                               + ' and (#t2.object_db IS NULL or #t2.object_db = N'
                               + @quote_quoted_dbname
                               + ')                 and #t2.rank = ('
                               + CAST(@iter_no AS NVARCHAR(8))
                               + '+1) AND #t2.object_id IS NULL and #t2.object_svr IS NULL';

                  EXEC sp_executesql @query;

                  -- update the shared object if any (schema is not null)
                  UPDATE #t2
                  SET    object_db = 'master'
                         ,object_id = o.object_id
                         ,object_type = @sp
                  FROM   master.sys.objects AS o
                         JOIN master.sys.schemas AS sch
                           ON sch.schema_id = o.schema_id
                  WHERE  o.name = #t2.object_name COLLATE database_default
                         AND sch.name = #t2.object_schema COLLATE database_default
                         AND o.type IN ( 'P', 'RF', 'PC' )
                         AND #t2.object_id IS NULL
                         AND #t2.object_name LIKE 'sp/_%' ESCAPE '/'
                         AND #t2.object_db IS NULL
                         AND #t2.object_svr IS NULL;

                  -- update the shared object if any (schema is null)
                  UPDATE #t2
                  SET    object_db = 'master'
                         ,object_id = o.object_id
                         ,object_schema = Schema_name(o.schema_id)
                         ,object_type = @sp
                  FROM   master.sys.objects AS o
                  WHERE  o.name = #t2.object_name COLLATE database_default
                         AND Schema_name(o.schema_id) = 'dbo' COLLATE database_default
                         AND o.type IN ( 'P', 'RF', 'PC' )
                         AND #t2.object_schema IS NULL
                         AND #t2.object_id IS NULL
                         AND #t2.object_name LIKE 'sp/_%' ESCAPE '/'
                         AND #t2.object_db IS NULL
                         AND #t2.object_svr IS NULL;

                FETCH next FROM db_cursor INTO @dbname;
    END;

            CLOSE db_cursor;
            DEALLOCATE db_cursor;

    UPDATE #t2
    SET    object_type = @unknown
    WHERE  object_id IS NULL;

    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_svr
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_svr
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT object_id
           ,object_name
           ,object_schema
           ,object_db
           ,object_svr
           ,object_type
           ,relative_id
           ,relative_name
           ,relative_schema
           ,relative_db
           ,relative_svr
           ,relative_type
           ,schema_bound
           ,rank
    FROM   #t2
    WHERE  @iter_no + 1 = rank;

    SET @rows = @rows + @@rowcount;

    -- HARD DEPENDENCIES
    -- uddt or udt referenced by table
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT tp.user_type_id
           ,tp.name
           ,Schema_name(tp.schema_id)
           ,t.object_db
           ,CASE tp.is_assembly_type
              WHEN 1 THEN @udt
              ELSE @uddt
            END
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.columns AS col
             ON col.object_id = t.object_id
           JOIN sys.types AS tp
             ON tp.user_type_id = col.user_type_id
                AND tp.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type = @u
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- uddt or udt referenced by table type
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT tp.user_type_id
           ,tp.name
           ,Schema_name(tp.schema_id)
           ,t.object_db
           ,CASE tp.is_assembly_type
              WHEN 1 THEN @udt
              ELSE @uddt
            END
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.table_types AS tt
             ON tt.user_type_id = t.object_id
           JOIN sys.columns AS col
             ON col.object_id = tt.type_table_object_id
           JOIN sys.types AS tp
             ON tp.user_type_id = col.user_type_id
                AND tp.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type = @udtt
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- table or view referenced by trigger
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,CASE o.type
              WHEN 'V' THEN @v
              ELSE @u
            END
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.triggers AS tr
             ON tr.object_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = tr.parent_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @tr
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- defaults (only default objects) referenced by tables
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,@def
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.columns AS clmns
             ON clmns.object_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = clmns.default_object_id
                AND 0 = ISNULL(o.parent_object_id, 0)
    WHERE  @iter_no = t.rank
           AND t.object_type = @u
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- defaults (only default objects) referenced by types
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,@def
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.types AS tp
             ON tp.user_type_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = tp.default_object_id
                AND 0 = ISNULL(o.parent_object_id, 0)
    WHERE  @iter_no = t.rank
           AND t.object_type = @uddt
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- rules referenced by tables
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,@rule
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.columns AS clmns
             ON clmns.object_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = clmns.rule_object_id
                AND 0 = ISNULL(o.parent_object_id, 0)
    WHERE  @iter_no = t.rank
           AND t.relative_type = @u
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- rules referenced by types
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,@rule
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.types AS tp
             ON tp.user_type_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = tp.rule_object_id
                AND 0 = ISNULL(o.parent_object_id, 0)
    WHERE  @iter_no = t.rank
           AND t.relative_type = @uddt
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- XmlSchemaCollections referenced by tables
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT x.xml_collection_id
           ,x.name
           ,Schema_name(x.schema_id)
           ,t.object_db
           ,@xml
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.columns AS c
             ON c.object_id = t.object_id
           JOIN sys.xml_schema_collections AS x
             ON x.xml_collection_id = c.xml_collection_id
                AND x.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type = @u
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- XmlSchemaCollections referenced by tabletypes
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT x.xml_collection_id
           ,x.name
           ,Schema_name(x.schema_id)
           ,t.object_db
           ,@xml
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.table_types AS tt
             ON tt.user_type_id = t.object_id
           JOIN sys.columns AS c
             ON c.object_id = tt.type_table_object_id
           JOIN sys.xml_schema_collections AS x
             ON x.xml_collection_id = c.xml_collection_id
                AND x.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type = @udtt
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- XmlSchemaCollections referenced by procedures
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT x.xml_collection_id
           ,x.name
           ,Schema_name(x.schema_id)
           ,t.object_db
           ,@xml
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.parameters AS c
             ON c.object_id = t.object_id
           JOIN sys.xml_schema_collections AS x
             ON x.xml_collection_id = c.xml_collection_id
                AND x.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type IN ( @sp, @udf )
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- table referenced by table
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT tbl.object_id
           ,tbl.name
           ,Schema_name(tbl.schema_id)
           ,t.object_db
           ,@u
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.foreign_keys AS fk
             ON fk.parent_object_id = t.object_id
           JOIN sys.tables AS tbl
             ON tbl.object_id = fk.referenced_object_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @u
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- uddts referenced by uda
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT tp.user_type_id
           ,tp.name
           ,Schema_name(tp.schema_id)
           ,t.object_db
           ,CASE
              WHEN tp.is_table_type = 1 THEN @udtt
              WHEN tp.is_assembly_type = 1 THEN @udt
              ELSE @uddt
            END
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.parameters AS p
             ON p.object_id = t.object_id
           JOIN sys.types AS tp
             ON tp.user_type_id = p.user_type_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @uda
           AND t.object_type = @uda
           AND tp.user_type_id > 256;

    SET @rows = @rows + @@rowcount;

    -- assembly referenced by assembly
    INSERT #t1
           (object_id
            ,object_name
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT asm.assembly_id
           ,asm.name
           ,t.object_db
           ,@assm
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.assembly_references AS ar
             ON ( ( ar.assembly_id = t.object_id )
                  AND ( ar.referenced_assembly_id >= 65536 ) )
           JOIN sys.assemblies AS asm
             ON asm.assembly_id = ar.referenced_assembly_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @assm
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- assembly referenced by udt
    INSERT #t1
           (object_id
            ,object_name
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT asm.assembly_id
           ,asm.name
           ,t.object_db
           ,@assm
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.assembly_types AS at
             ON ( ( at.user_type_id = t.object_id )
                  AND ( at.is_user_defined = 1 ) )
           JOIN sys.assemblies AS asm
             ON asm.assembly_id = at.assembly_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @udt
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- assembly referenced by udf, sp, uda, trigger
    INSERT #t1
           (object_id
            ,object_name
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT asm.assembly_id
           ,asm.name
           ,t.object_db
           ,@assm
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.assembly_modules AS am
             ON ( ( am.object_id = t.object_id )
                  AND ( am.assembly_id >= 65536 ) )
           JOIN sys.assemblies AS asm
             ON asm.assembly_id = am.assembly_id
    WHERE  @iter_no = t.rank
           AND t.object_type IN ( @udf, @sp, @uda, @tr )
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- Partition Schemes referenced by tables/views
    INSERT #t1
           (object_id
            ,object_name
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT ps.data_space_id
           ,ps.name
           ,t.object_db
           ,@part_sch
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.indexes AS idx
             ON idx.object_id = t.object_id
           JOIN sys.partition_schemes AS ps
             ON ps.data_space_id = idx.data_space_id
    WHERE  @iter_no = t.rank
           AND t.object_type IN ( @u, @v )
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- Partition Function referenced by Partition Schemes
    INSERT #t1
           (object_id
            ,object_name
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT pf.function_id
           ,pf.name
           ,t.object_db
           ,@part_func
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.partition_schemes AS ps
             ON ps.data_space_id = t.object_id
           JOIN sys.partition_functions AS pf
             ON pf.function_id = ps.function_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @part_sch
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- sp, udf, triggers referenced by plan guide
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,( CASE o.type
                WHEN 'P' THEN @sp
                WHEN 'TR' THEN @tr
                ELSE @udf
              END )
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.plan_guides AS pg
             ON pg.plan_guide_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = pg.scope_object_id
    WHERE  @iter_no = t.rank
           AND t.object_type = @pg
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- objects referenced by synonym
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT o.object_id
           ,o.name
           ,Schema_name(o.schema_id)
           ,t.object_db
           ,( CASE
                WHEN o.type = 'U' THEN @u
                WHEN o.type = 'V' THEN @v
                WHEN o.type IN ( 'P', 'RF', 'PC' ) THEN @sp
                WHEN o.type = 'AF' THEN @uda
                ELSE @udf
              END )
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,0
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.synonyms AS s
             ON s.object_id = t.object_id
           JOIN sys.objects AS o
             ON o.object_id = Object_id(s.base_object_name)
                AND o.type IN ( 'U', 'V', 'P', 'RF', 'PC', 'AF', 'TF', 'FN', 'IF', 'FS', 'FT' )
    WHERE  @iter_no = t.rank
           AND t.object_type = @synonym
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;

    -- uddt referenced by sequence. Used to find UDDT that is in sequence dependencies.
    INSERT #t1
           (object_id
            ,object_name
            ,object_schema
            ,object_db
            ,object_type
            ,relative_id
            ,relative_name
            ,relative_schema
            ,relative_db
            ,relative_type
            ,schema_bound
            ,rank)
    SELECT tp.user_type_id
           ,tp.name
           ,Schema_name(tp.schema_id)
           ,t.object_db
           ,CASE tp.is_assembly_type
              WHEN 1 THEN @udt
              ELSE @uddt
            END
           ,t.object_id
           ,t.object_name
           ,t.object_schema
           ,t.object_db
           ,t.object_type
           ,1
           ,@iter_no + 1
    FROM   #t1 AS t
           JOIN sys.sequences AS s
             ON s.object_id = t.object_id
           JOIN sys.types AS tp
             ON tp.user_type_id = s.user_type_id
                AND tp.schema_id != 4
    WHERE  @iter_no = t.rank
           AND t.object_type = @sequence
           AND ( t.object_svr IS NULL
                 AND t.object_db = DB_NAME() );

    SET @rows = @rows + @@rowcount;
END

    SET @iter_no = @iter_no + 1;
END

UPDATE #t1
SET    rank = 0;

-- computing the degree of the nodes
UPDATE #t1
SET    degree = (SELECT Count(*)
                 FROM   #t1 t
                 WHERE  t.relative_id = #t1.object_id
                        AND t.object_id != t.relative_id);

-- perform the topological sorting
SET @iter_no = 1;

WHILE 1 = 1
  BEGIN
      UPDATE #t1
      SET    rank = @iter_no
      WHERE  degree = 0;

      -- end the loop if no more rows left to process
      IF ( @@rowcount = 0 )
        BREAK;

      UPDATE #t1
      SET    degree = NULL
      WHERE  rank = @iter_no

      UPDATE #t1
      SET    degree = (SELECT COUNT(*)
                       FROM   #t1 t
                       WHERE  t.relative_id = #t1.object_id
                              AND t.object_id != t.relative_id
                              AND t.object_id IN (SELECT tt.object_id
                                                  FROM   #t1 tt
                                                  WHERE  tt.rank = 0))
      WHERE  degree IS NOT NULL;

      SET @iter_no = @iter_no + 1;
  END

--correcting naming mistakes of objects present in current database 
--This part need to be removed once SMO's URN comparision gets fixed
DECLARE @collation SYSNAME;
DECLARE db_cursor CURSOR FOR
  SELECT DISTINCT ISNULL(object_db, DB_NAME())
  FROM   #t1 AS t
  WHERE  t.object_id IS NOT NULL
         AND t.object_svr IS NULL;

OPEN db_cursor;

FETCH next FROM db_cursor INTO @dbname;

WHILE ( @@FETCH_STATUS <> -1 )
  BEGIN
      IF ( DB_ID(@dbname) IS NULL )
        BEGIN
            FETCH next FROM db_cursor INTO @dbname;

            CONTINUE;
        END

      SET @collation = (SELECT CONVERT(SYSNAME, Databasepropertyex(@dbname, 'Collation')));
      SET @query =
                  'UPDATE #t1 set #t1.object_name = o.name,#t1.object_schema = sch.name from #t1  inner join '
                  + QUOTENAME(@dbname)
                  + '.sys.objects as o on #t1.object_id = o.object_id INNER JOIN '
                  + QUOTENAME(@dbname)
                  + '.sys.schemas as sch on sch.schema_id = o.schema_id  where o.name = #t1.object_name collate '
                  + @collation
                  + ' AND sch.name = #t1.object_schema collate '
                  + @collation;

    EXEC sp_executesql @query;

    FETCH next FROM db_cursor INTO @dbname;
END

CLOSE db_cursor;

DEALLOCATE db_cursor;

--final select
SELECT ISNULL(t.object_id, 0)                AS [object_id]
       ,t.object_name
       ,ISNULL(t.object_schema, '')          AS [object_schema]
       ,ISNULL(t.object_db, '')              AS [object_db]
       ,ISNULL(t.object_svr, '')             AS [object_svr]
       ,t.object_type
       ,ISNULL(t.relative_id, 0)             AS [relative_id]
       ,t.relative_name
       ,ISNULL(t.relative_schema, '')        AS [relative_schema]
       ,relative_db
       ,ISNULL(t.relative_svr, '')           AS [relative_svr]
       ,t.relative_type
       ,t.schema_bound
       ,ISNULL(CASE
                 WHEN p.type = 'U' THEN @u
                 WHEN p.type = 'V' THEN @v
               END, 0)                       AS [ptype]
       ,ISNULL(p.name, '')                   AS [pname]
       ,ISNULL(Schema_name(p.schema_id), '') AS [pschema]
       ,t.rank
FROM   #t1 AS t
       LEFT JOIN sys.objects AS o
              ON ( t.object_type = @tr
                   AND o.object_id = t.object_id )
                  OR ( t.relative_type = @tr
                       AND o.object_id = t.relative_id )
       LEFT JOIN sys.objects AS p
              ON p.object_id = o.parent_object_id
ORDER  BY rank DESC;

DROP TABLE #t1;
DROP TABLE #t2;
DROP TABLE #tempdep;

IF @must_set_nocount_off > 0
  SET nocount OFF;
