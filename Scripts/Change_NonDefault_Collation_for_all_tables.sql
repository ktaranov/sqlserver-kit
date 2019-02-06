-- SSMS results to text - max length 8192 (change from default!!!)

/*******************************************************************************
*
* Created 2017-06-16 By Philip C
*
* This script will check individual columns collations and check it against the
* database default collation, where they are different it will create the scripts
* required to drop all the objects dependant on the column, change the collation
* to the database default and then recreate the dependant objects.
* Some of the code has been reused from stuff found online the majority from 
* Jayakumaur R who created scripts to drop and recreate constraints
*
*
* Modified 2019-01-11 by Hugo Kornelis
* https://sqlserverfast.com/blog/hugo/2019/01/collation-change-script/
*
* Removed double checking of recreated constraints
* Modified the order of the output to minimize number of index rebuilds (assuming primary key is most often clsutered index)
* Fixed a bug caused by unique constraints overlapping the primary key constraint
* Fixed a bug in detection of foreign key constraints to drop and recreate
* Fixed bugs with recreating multi-column UNIQUE constraints
*
*********************************************************************************/

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;
GO

-- Declare variables
DECLARE @SchemaName             sysname,
        @TableName              sysname,
        @IndexName              sysname,
        @ColumnName             sysname,
        @index_id               int,
        @is_unique              nvarchar(100),
        @IndexTypeDesc          nvarchar(100),
        @FileGroupName          sysname,
        @is_disabled            nvarchar(100),
        @IndexOptions           nvarchar(MAX),
        @IndexColumnId          int,
        @IsDescendingKey        int,
        @IsIncludedColumn       int,
        @TSQLScripCreationIndex nvarchar(MAX),
        @TSQLScripDisableIndex  nvarchar(MAX),
        @object_id              int,
        @has_key_constraint     int,
        @has_index              int,
        @has_foreign_key        int,
        @has_stats              int,
        @stats_id               int,
        @FK_objectid            int,
        @FK_name                sysname,
        @UQ_objectid            int,
        @UQ_name                sysname,
        @UQ_index_id            int,
        @has_unique_constraint  int,
        @DatabaseCollation      sysname,
        @IndexColumns           nvarchar(MAX),
        @IncludedColumns        nvarchar(MAX);

-- Temporary table for generated script
CREATE TABLE #tempscriptstore
    (ScriptType varchar(20),
     script     nvarchar(MAX));

-- Get dataabse default collation
SELECT  @DatabaseCollation = collation_name
FROM    sys.databases
WHERE   database_id = DB_ID();

/************************************************************************************************************************************
*   Iterate over all the tables that have at least one colmun where collation doesn't match the database default.                   *
*   Also checks for PRIMARY KEY, UNIQUE, and (referencing) FOREIGN KEY constraints, indexes, and manually created statistics.       *
*   (Note that the counts are not accurate counts due to duplication, these should only be tested for zero or non-zero)             *
************************************************************************************************************************************/
DECLARE collationfix CURSOR LOCAL FORWARD_ONLY READ_ONLY STATIC FOR
SELECT      t.object_id,
            OBJECT_SCHEMA_NAME(t.object_id) AS schemaname,
            OBJECT_NAME(t.object_id)        AS tablename,
            COUNT(kc.object_id)             AS has_key_constraint,
            COUNT(ic.index_id)              AS has_index,
            COUNT(fk.constraint_object_id)  AS has_foreign_key,
            COUNT(st.stats_id)              AS has_stats,
            COUNT(uq.object_id)             AS has_unique_constraint
FROM        sys.tables              AS t
INNER JOIN  sys.columns             AS c
   ON       c.object_id         = t.object_id
   AND      c.collation_name    <> @DatabaseCollation -- Table needs to have columns with "wrong" collation
INNER JOIN  sys.types               AS ty
   ON       ty.system_type_id   = c.system_type_id
   AND      ty.name             <> N'sysname' -- Exclusion retained from Philip C's original script
LEFT JOIN   sys.index_columns       AS ic -- Find indexes on any of the affected columns
  ON        ic.object_id        = c.object_id
  AND       ic.column_id        = c.column_id
LEFT JOIN   sys.key_constraints     AS kc -- Find primary key constraints related to an affected index
  ON        kc.parent_object_id = c.object_id
  AND       kc.unique_index_id  = ic.index_id
  AND       kc.type             = 'PK'
LEFT JOIN   sys.key_constraints     AS uq -- Find unique constraints related to an affected index
  ON        uq.parent_object_id = c.object_id
  AND       uq.unique_index_id  = ic.index_id
  AND       uq.type             = 'UQ'
LEFT JOIN   sys.foreign_key_columns AS fk -- Find foreign key constraints on any of the affected columns
  ON        fk.parent_object_id = c.object_id
  AND       fk.parent_column_id = c.column_id
LEFT JOIN   sys.stats_columns       AS st -- Find statistics on any of the affected columns
  ON        st.object_id        = c.object_id
  AND       st.column_id        = c.column_id
  AND       st.stats_column_id  <> 1 -- Retained from Philip C's original script, no idea why this is in the query
WHERE       t.is_ms_shipped = 0 -- Exclude Microsoft-shipped tables
GROUP BY    t.object_id;

OPEN collationfix;
FETCH NEXT FROM collationfix
INTO @object_id,
     @SchemaName,
     @TableName,
     @has_key_constraint,
     @has_index,
     @has_foreign_key,
     @has_stats,
     @has_unique_constraint;

WHILE (@@FETCH_STATUS = 0)
BEGIN;

    /************************************************************************************************************************************
    *   Generates the code to update the colation for all affected columns in the table                                                 *
    ************************************************************************************************************************************/
    INSERT INTO #tempscriptstore (ScriptType,
                                  script)
    SELECT      'AlterCollation',
                N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' ALTER COLUMN '
                + QUOTENAME(c.name) + ' '
                + CASE WHEN ty.name = N'ntext'
                           THEN ty.name + N' COLLATE ' + @DatabaseCollation + ' '
                       ELSE ty.name + N'(' + CASE WHEN c.max_length = -1
                                                      THEN N'MAX'
                                                  ELSE CASE WHEN ty.name = N'nvarchar'
                                                                THEN CAST(c.max_length / 2 AS nvarchar(20))
                                                            ELSE CAST(c.max_length AS nvarchar(20))
                                                       END
                                             END + N') COLLATE ' + @DatabaseCollation
                  END + CASE WHEN c.is_nullable = 1 THEN N' NULL;' ELSE N' NOT NULL;' END
    FROM        sys.columns AS c
    INNER JOIN  sys.types   AS ty
       ON       ty.system_type_id = c.system_type_id
       AND      ty.name           <> N'sysname'
    WHERE       c.object_id = @object_id
    AND         c.collation_name    <> @DatabaseCollation;

    /************************************************************************************************************************************
    *   If the table has affected indexes, this creates the drop and recreate index scripts                                             *
    ************************************************************************************************************************************/
    IF @has_index > 0
    BEGIN;
        -- Process indexes on affected columns, one by one
        DECLARE CursorIndex CURSOR LOCAL FORWARD_ONLY READ_ONLY STATIC FOR
        SELECT  ix.index_id,
                ix.name,
                CASE WHEN ix.is_unique = 1 THEN N'UNIQUE ' ELSE N'' END,
                ix.type_desc,
                CASE WHEN ix.is_padded = 1
                         THEN N'PAD_INDEX = ON, '
                     ELSE N'PAD_INDEX = OFF, '
                END + CASE WHEN ix.allow_page_locks = 1
                               THEN N'ALLOW_PAGE_LOCKS = ON, '
                           ELSE N'ALLOW_PAGE_LOCKS = OFF, '
                      END + CASE WHEN ix.allow_row_locks = 1
                                     THEN N'ALLOW_ROW_LOCKS = ON, '
                                 ELSE N'ALLOW_ROW_LOCKS = OFF, '
                            END + CASE WHEN INDEXPROPERTY(ix.object_id, ix.name, 'IsStatistics') = 1
                                           THEN N'STATISTICS_NORECOMPUTE = ON, '
                                       ELSE N'STATISTICS_NORECOMPUTE = OFF, '
                                  END + CASE WHEN ix.ignore_dup_key = 1
                                                 THEN N'IGNORE_DUP_KEY = ON, '
                                             ELSE N'IGNORE_DUP_KEY = OFF, '
                                        END + N'SORT_IN_TEMPDB = OFF, FILLFACTOR ='
                + CASE WHEN ix.fill_factor = 0
                           THEN CAST(100 AS nvarchar(3))
                       ELSE CAST(ix.fill_factor AS nvarchar(3))
                  END                            AS IndexOptions,
                ix.is_disabled,
                FILEGROUP_NAME(ix.data_space_id) AS FileGroupName
        FROM    sys.indexes AS ix
        WHERE   ix.object_id        = @object_id
        AND     ix.type                 <> 0 -- Exclude heaps
        AND     ix.is_primary_key       = 0 -- Exclude primary key constraints (handled separately)
        AND     ix.is_unique_constraint = 0 -- Exclude unique constraints (handled separately)
        AND     EXISTS (SELECT      *   -- Has to constrain at least one column with wrong collation
                        FROM        sys.index_columns AS ic
                        INNER JOIN  sys.columns       AS c
                           ON       c.object_id       = ic.object_id
                           AND      c.column_id       = ic.column_id
                           AND      c.collation_name  <> @DatabaseCollation
                        INNER JOIN  sys.types         AS ty
                           ON       ty.system_type_id = c.system_type_id
                           AND      ty.name           <> N'sysname'
                        WHERE       ic.index_id = ix.index_id
                        AND         ic.object_id        = ix.object_id);

        OPEN CursorIndex;
        FETCH NEXT FROM CursorIndex
        INTO @index_id,
             @IndexName,
             @is_unique,
             @IndexTypeDesc,
             @IndexOptions,
             @is_disabled,
             @FileGroupName;

        WHILE (@@FETCH_STATUS = 0)
        BEGIN;
            -- For each index, use a nested cursor to build lists of indexed and inclued columns
            SET @IndexColumns = N'';
            SET @IncludedColumns = N'';

            DECLARE CursorIndexColumn CURSOR FOR
            SELECT      c.name,
                        ic.is_descending_key,
                        ic.is_included_column
            FROM        sys.index_columns AS ic
            INNER JOIN  sys.columns       AS c
               ON       c.object_id = ic.object_id
               AND      c.column_id = ic.column_id
            WHERE       ic.object_id = @object_id
            AND         ic.index_id          = @index_id
            ORDER BY    ic.index_column_id;

            OPEN CursorIndexColumn;
            FETCH NEXT FROM CursorIndexColumn
            INTO @ColumnName,
                 @IsDescendingKey,
                 @IsIncludedColumn;

            WHILE (@@FETCH_STATUS = 0)
            BEGIN;
                IF @IsIncludedColumn = 0
                    SET @IndexColumns += @ColumnName
                                         + CASE WHEN @IsDescendingKey = 1 THEN N' DESC, ' ELSE N' ASC, ' END;
                ELSE
                    SET @IncludedColumns += @ColumnName + N', ';

                FETCH NEXT FROM CursorIndexColumn
                INTO @ColumnName,
                     @IsDescendingKey,
                     @IsIncludedColumn;
            END;

            CLOSE CursorIndexColumn;
            DEALLOCATE CursorIndexColumn;

            -- Remove trailing comma
            SET @IndexColumns = SUBSTRING(@IndexColumns, 1, LEN(@IndexColumns) - 1);
            IF @IncludedColumns <> N''
                SET @IncludedColumns = SUBSTRING(@IncludedColumns, 1, LEN(@IncludedColumns) - 1);

            -- Generate DROP INDEX statement
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  'DropIndex',
                    N'DROP INDEX ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + '.' + QUOTENAME(@IndexName)
                    + N';';

            -- Generate CREATE INDEX statement
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  'CreateIndex',
                    N'CREATE ' + @is_unique + @IndexTypeDesc + N' INDEX ' + QUOTENAME(@IndexName) + N' ON '
                    + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N'(' + @IndexColumns + N') '
                    + CASE WHEN @IncludedColumns <> N''
                               THEN N'INCLUDE (' + @IncludedColumns + N')'
                           ELSE N''
                      END + N' WITH (' + @IndexOptions + N') ON ' + QUOTENAME(@FileGroupName) + N';';

            -- Generate script to (re)disable disabled index after creating it
            IF @is_disabled = 1
                INSERT INTO #tempscriptstore (ScriptType,
                                              script)
                SELECT  'DisableIndex',
                        N'ALTER INDEX ' + QUOTENAME(@IndexName) + N' ON ' + QUOTENAME(@SchemaName) + N'.'
                        + QUOTENAME(@TableName) + N' DISABLE;';

            FETCH NEXT FROM CursorIndex
            INTO @index_id,
                 @IndexName,
                 @is_unique,
                 @IndexTypeDesc,
                 @IndexOptions,
                 @is_disabled,
                 @FileGroupName;
        END;

        CLOSE CursorIndex;
        DEALLOCATE CursorIndex;
    END;

    /************************************************************************************************************************************
    *   If the table has an affected primary key constraint, this creates the drop and recreate constraint script                       *
    *   this has been taken and adapted from a script found online created by Jayakumaur R                                              *
    ************************************************************************************************************************************/
    IF @has_key_constraint > 0
    BEGIN;
        -- Find columns and other metadata for primary key
        SELECT      kc.object_id                                                                          AS constid,
                    kc.name                                                                               AS constraint_name,   -- PK name
                    QUOTENAME(c.name) + CASE WHEN ic.is_descending_key = 1 THEN N' DESC' ELSE N' ASC' END AS pk_col,
                    ic.key_ordinal,
                    i.name                                                                                AS index_name,
                    i.type_desc                                                                           AS index_type,
                    QUOTENAME(fg.name)                                                                    AS filegroup_name,
                    N' WITH (PAD_INDEX = ' + CASE WHEN i.is_padded = 0 THEN N'OFF' ELSE N'ON' END + N', IGNORE_DUP_KEY = '
                    + CASE WHEN i.ignore_dup_key = 0 THEN N'OFF' ELSE N'ON' END + N', ALLOW_ROW_LOCKS = '
                    + CASE WHEN i.allow_row_locks = 0 THEN N'OFF' ELSE N'ON' END + ', ALLOW_PAGE_LOCKS = '
                    + CASE WHEN i.allow_page_locks = 0 THEN N'OFF)' ELSE N'ON)' END                       AS index_property
        INTO        #temp_pk
        FROM        sys.key_constraints AS kc
        INNER JOIN  sys.indexes         AS i
           ON       i.object_id      = kc.parent_object_id
           AND      i.is_primary_key = 1
        INNER JOIN  sys.index_columns   AS ic
           ON       ic.object_id     = i.object_id
           AND      ic.index_id      = i.index_id
        INNER JOIN  sys.columns         AS c
           ON       c.object_id      = ic.object_id
           AND      c.column_id      = ic.column_id
        INNER JOIN  sys.filegroups      AS fg
           ON       fg.data_space_id = i.data_space_id
        WHERE       kc.type     = 'PK'
        AND         kc.parent_object_id = @object_id;

        -- Generate DROP CONSTRAINT statement
        INSERT INTO #tempscriptstore (ScriptType,
                                      script)
        SELECT  TOP (1) -- One DROP statement, even if there are multiple columns
                'DropPrimaryKey',
                N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' DROP CONSTRAINT '
                + QUOTENAME(constraint_name) + N';'
        FROM    #temp_pk;

        -- Generate CREATE CONSTRAINT statement
        INSERT INTO #tempscriptstore (ScriptType,
                                      script)
        SELECT  TOP (1) -- One CREATE statement, even if there are multiple columns
                'AddPrimaryKey',
                N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' ADD CONSTRAINT '
                + QUOTENAME(p.constraint_name) + N' PRIMARY KEY ' + CAST(p.index_type AS nvarchar(100)) + N' ('
                + STUFF((SELECT     N', ' + pk_col  -- This generates a comma-separated list of the columns, in order
                         FROM       #temp_pk
                         ORDER BY   key_ordinal
                        FOR XML PATH('')),
                        1,
                        2,
                        N'') + N')' + p.index_property + N' ON ' + p.filegroup_name + N';'
        FROM    #temp_pk AS p;

        DROP TABLE #temp_pk;
    END;

    /************************************************************************************************************************************
    *   If the table has a foreign key constraint on an affected column, this creates the drop and recreate constraint script           *
    *   this has been taken and adapted from a script found online cretaed by Jayakumaur R                                              *
    ************************************************************************************************************************************/
    IF @has_foreign_key > 0
    BEGIN;
        -- Process foreign key constraints on affected columns, one by one
        DECLARE foreignkeycursor CURSOR FOR
        SELECT  fk.object_id,
                fk.name
        FROM    sys.foreign_keys AS fk
        WHERE   fk.parent_object_id = @object_id
        AND     EXISTS (SELECT      *   -- Has to constrain at least one column with wrong collation
                        FROM        sys.foreign_key_columns AS fkc
                        INNER JOIN  sys.columns             AS c
                           ON       c.object_id       = fkc.parent_object_id
                           AND      c.column_id       = fkc.parent_column_id
                           AND      c.collation_name  <> @DatabaseCollation
                        INNER JOIN  sys.types               AS ty
                           ON       ty.system_type_id = c.system_type_id
                           AND      ty.name           <> N'sysname'
                        WHERE       fkc.parent_object_id = fk.parent_object_id
                        AND         fkc.constraint_object_id     = fk.object_id);

        OPEN foreignkeycursor;
        FETCH NEXT FROM foreignkeycursor
        INTO @FK_objectid,
             @FK_name;

        WHILE (@@FETCH_STATUS = 0)
        BEGIN;
            -- Find columns and other metadata for foreign key
            SELECT      fk.object_id                                      AS constid,
                        fk.name                                           AS constraint_name,   -- FK name
                        fkc.constraint_column_id                          AS column_ordinal,
                        QUOTENAME(c1.name)                                AS key_col,
                        QUOTENAME(OBJECT_SCHEMA_NAME(fk.referenced_object_id)) + N'.'
                        + QUOTENAME(OBJECT_NAME(fk.referenced_object_id)) AS ref_table,
                        QUOTENAME(c2.name)                                AS ref_col,
                        CASE WHEN fk.delete_referential_action <> 0 -- No action
                                 THEN N' ON DELETE ' + fk.delete_referential_action_desc
                             ELSE N''
                        END                                               AS delete_cascade,
                        CASE WHEN fk.update_referential_action <> 0 -- No action
                                 THEN N' ON UPDATE ' + fk.update_referential_action_desc
                             ELSE N''
                        END                                               AS update_cascade,
                        fk.is_not_trusted,
                        fk.is_disabled
            INTO        #temp_fk
            FROM        sys.foreign_keys        AS fk
            INNER JOIN  sys.foreign_key_columns AS fkc
               ON       fkc.parent_object_id     = fk.parent_object_id
               AND      fkc.constraint_object_id = fk.object_id
            INNER JOIN  sys.columns             AS c1
               ON       c1.object_id             = fkc.parent_object_id
               AND      c1.column_id             = fkc.parent_column_id
            INNER JOIN  sys.columns             AS c2
               ON       c2.object_id             = fkc.referenced_object_id
               AND      c2.column_id             = fkc.referenced_column_id
            WHERE       fk.object_id = @FK_objectid;

            -- Generate DROP CONSTRAINT statement
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  'DropForeignKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' DROP CONSTRAINT '
                    + QUOTENAME(@FK_name) + N';';

            -- Generate CREATE CONSTRAINT statement (always as ënabled, "not trusted"; status is changed later in script)
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  TOP (1) -- One CREATE statement, even if there are multiple columns
                    'AddForeignKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName)
                    + N' WITH NOCHECK ADD CONSTRAINT ' + QUOTENAME(constraint_name) + N' FOREIGN KEY ('
                    + STUFF(
                      (SELECT       N', ' + key_col -- This generates a comma-separated list of the constrained columns, in order
                       FROM         #temp_fk
                       ORDER BY     column_ordinal
                      FOR XML PATH('')),
                      1,
                      2,
                      N'') + N') REFERENCES ' + ref_table + N'('
                    + STUFF(
                      (SELECT       N', ' + ref_col -- This generates a comma-separated list of the referencedcolumns, in order
                       FROM         #temp_fk
                       ORDER BY     column_ordinal
                      FOR XML PATH('')),
                      1,
                      2,
                      N'') + N')' + delete_cascade + update_cascade + ';'
            FROM    #temp_fk;

            -- If constraint was disabled, add code to disable it again
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  TOP (1) -- One CREATE statement, even if there are multiple columns
                    'DisableForeignKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' NOCHECK CONSTRAINT '
                    + QUOTENAME(constraint_name) + N';'
            FROM    #temp_fk
            WHERE   is_disabled = 1;

            -- If constraint was trusted, add code to force re-check so it's trudsted again
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  TOP (1) -- One CREATE statement, even if there are multiple columns
                    'CheckForeignKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName)
                    + N' WITH CHECK CHECK CONSTRAINT ' + QUOTENAME(constraint_name) + N';'
            FROM    #temp_fk
            WHERE   is_not_trusted = 0;

            DROP TABLE #temp_fk;

            FETCH NEXT FROM foreignkeycursor
            INTO @FK_objectid,
                 @FK_name;
        END;
        CLOSE foreignkeycursor;
        DEALLOCATE foreignkeycursor;
    END;

    /*
-- DROP and CREATE statistics for manual statistics has been disabled for now
    /************************************************************************************************************************************
    *   If the column has statistics that aren't part of an index this creates the drop and recreate scripts                            *
    ************************************************************************************************************************************/
    IF  @has_stats > 0
    AND @has_index = 0
    BEGIN
        DECLARE stats_cursor CURSOR FOR
            SELECT  sc.stats_id
            FROM    sys.stats_columns AS sc
            JOIN    sys.stats         AS s
              ON    s.object_id    = sc.object_id
              AND   s.stats_id     = sc.stats_id
              AND   s.user_created = 1
            WHERE   sc.object_id = @object_id
            AND     sc.column_id     = @Collation_columnid;
        OPEN stats_cursor;
        FETCH NEXT FROM stats_cursor
        INTO @stats_id;
        WHILE (@@FETCH_STATUS = 0)
        BEGIN
            --Create DROP Statistics Statement
            INSERT INTO #tempscriptstore
                (ScriptType,
                 script)
            SELECT  'DropStatistics',
                    'DROP STATISTICS ' + QUOTENAME(OBJECT_SCHEMA_NAME(s.object_id)) + '.'
                    + QUOTENAME(OBJECT_NAME(s.object_id)) + '.' + QUOTENAME(s.name)
            FROM    sys.stats AS s
            WHERE   s.object_id = @object_id
            AND     s.stats_id      = @stats_id;

            --Building the CREATE statistics statement

            --Obtaining all the information
            SELECT  QUOTENAME(OBJECT_SCHEMA_NAME(sc.object_id)) + '.' + QUOTENAME(OBJECT_NAME(sc.object_id)) AS st_table,
                    QUOTENAME(s.name)                                                                        AS st_name,
                    QUOTENAME(c.name)                                                                        AS st_column,
                    sc.object_id,
                    sc.stats_id,
                    sc.stats_column_id
            INTO    #temp_stats
            FROM    sys.stats_columns AS sc
            JOIN    sys.stats         AS s
              ON    s.stats_id  = sc.stats_id
              AND   s.object_id = sc.object_id
            JOIN    sys.columns       AS c
              ON    c.object_id = sc.object_id
              AND   c.column_id = sc.column_id
            WHERE   sc.object_id = @object_id
            AND     sc.stats_id      = @stats_id;
            WITH
            cte AS
                (SELECT DISTINCT ts.st_table,
                                 ts.st_name,
                                 SUBSTRING((SELECT      ',' + st_column
                                            FROM        #temp_stats
                                            WHERE       stats_id = ts.stats_id
                                            ORDER BY    stats_column_id ASC
                                           FOR XML PATH('')),
                                           2,
                                           99999) AS st_col_list
                 FROM   #temp_stats AS ts)
            --Constructing the statement
            INSERT INTO #tempscriptstore
                (ScriptType,
                 script)
            SELECT  'AddStatistics',
                    'CREATE STATISTICS ' + cte.st_name + ' ON ' + cte.st_table + '(' + cte.st_col_list + ')'
            FROM    cte;
            DROP TABLE #temp_stats;
            FETCH NEXT FROM stats_cursor
            INTO @stats_id;
        END;
        CLOSE stats_cursor;
        DEALLOCATE stats_cursor;
    END;
*/

    /************************************************************************************************************************************
    *   If the table has unique constraints on affected columns, this creates the drop and recreate scripts                             *
    ************************************************************************************************************************************/
    IF @has_unique_constraint > 0
    BEGIN;
        -- Process unique constraints on affected columns, one by one
        DECLARE uniquecursor CURSOR FOR
        SELECT  kc.object_id,
                kc.name,
                kc.unique_index_id
        FROM    sys.key_constraints AS kc
        WHERE   kc.parent_object_id = @object_id
        AND     kc.type                 = 'UQ'
        AND     EXISTS (SELECT      *   -- Has to constrain at least one column with wrong collation
                        FROM        sys.index_columns AS ic
                        INNER JOIN  sys.columns       AS c
                           ON       c.object_id       = ic.object_id
                           AND      c.column_id       = ic.column_id
                           AND      c.collation_name  <> @DatabaseCollation
                        INNER JOIN  sys.types         AS ty
                           ON       ty.system_type_id = c.system_type_id
                           AND      ty.name           <> N'sysname'
                        WHERE       ic.object_id = kc.parent_object_id
                        AND         ic.index_id          = kc.unique_index_id);

        OPEN uniquecursor;
        FETCH NEXT FROM uniquecursor
        INTO @UQ_objectid,
             @UQ_name,
             @UQ_index_id;

        WHILE (@@FETCH_STATUS = 0)
        BEGIN;
            -- Find columns and other metadata for unique constraint
            SELECT      QUOTENAME(c.name) + CASE WHEN ic.is_descending_key = 1 THEN N' DESC' ELSE N' ASC' END     AS uq_col,
                        ic.key_ordinal,
                        i.name                                                                                    AS index_name,
                        i.type_desc                                                                               AS index_type,
                        QUOTENAME(fg.name)                                                                        AS filegroup_name,
                        N' WITH (PAD_INDEX = ' + CASE WHEN i.is_padded = 0 THEN N'OFF' ELSE N'ON' END
                        + N', IGNORE_DUP_KEY = ' + CASE WHEN i.ignore_dup_key = 0 THEN N'OFF' ELSE N'ON' END
                        + N', ALLOW_ROW_LOCKS = ' + CASE WHEN i.allow_row_locks = 0 THEN N'OFF' ELSE N'ON' END
                        + ', ALLOW_PAGE_LOCKS = ' + CASE WHEN i.allow_page_locks = 0 THEN N'OFF)' ELSE N'ON)' END AS index_property
            INTO        #temp_uq
            FROM        sys.indexes       AS i
            INNER JOIN  sys.index_columns AS ic
               ON       ic.object_id     = i.object_id
               AND      ic.index_id      = i.index_id
            INNER JOIN  sys.columns       AS c
               ON       c.object_id      = ic.object_id
               AND      c.column_id      = ic.column_id
            INNER JOIN  sys.filegroups    AS fg
               ON       fg.data_space_id = i.data_space_id
            WHERE       i.object_id    = @object_id
            AND         i.index_id             = @UQ_index_id
            AND         i.is_unique_constraint = 1;

            -- Generate DROP CONSTRAINT statement
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  'DropUniqueKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' DROP CONSTRAINT '
                    + QUOTENAME(@UQ_name) + N';';

            -- Generate CREATE CONSTRAINT statement
            INSERT INTO #tempscriptstore (ScriptType,
                                          script)
            SELECT  TOP (1) -- One CREATE statement, even if there are multiple columns
                    'AddUniqueKey',
                    N'ALTER TABLE ' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName) + N' ADD CONSTRAINT '
                    + QUOTENAME(@UQ_name) + N' UNIQUE ' + CAST(index_type AS nvarchar(100)) + N' ('
                    + STUFF((SELECT     N', ' + uq_col  -- This generates a comma-separated list of the columns, in order
                             FROM       #temp_uq
                             ORDER BY   key_ordinal
                            FOR XML PATH('')),
                            1,
                            2,
                            N'') + N')' + index_property + N' ON ' + filegroup_name + N';'
            FROM    #temp_uq;

            DROP TABLE #temp_uq;

            FETCH NEXT FROM uniquecursor
            INTO @UQ_objectid,
                 @UQ_name,
                 @UQ_index_id;
        END;
        CLOSE uniquecursor;
        DEALLOCATE uniquecursor;
    END;

    FETCH NEXT FROM collationfix
    INTO @object_id,
         @SchemaName,
         @TableName,
         @has_key_constraint,
         @has_index,
         @has_foreign_key,
         @has_stats,
         @has_unique_constraint;
END;
CLOSE collationfix;
DEALLOCATE collationfix;

/************************************************************************************************************************************
*   Returns all the created scripts in the correct order for running                                                                *
*   Also add GO in between some sections so the entire script can execute at once                                                   *
************************************************************************************************************************************/
WITH ScriptInput
  AS (SELECT    script,
                CASE WHEN ScriptType = 'DropForeignKey'
                         THEN 1
                     WHEN ScriptType = 'DropIndex'
                         THEN 2
                     WHEN ScriptType = 'DropUniqueKey'
                         THEN 3
                     WHEN ScriptType = 'DropPrimaryKey'
                         THEN 4
                     WHEN ScriptType = 'DropStatistics'
                         THEN 5
                     WHEN ScriptType = 'AlterCollation'
                         THEN 7
                     WHEN ScriptType = 'AddPrimaryKey'
                         THEN 9
                     WHEN ScriptType = 'AddUniqueKey'
                         THEN 10
                     WHEN ScriptType = 'CreateIndex'
                         THEN 11
                     WHEN ScriptType = 'AddStatistics'
                         THEN 12
                     WHEN ScriptType = 'AddForeignKey'
                         THEN 13
                     WHEN ScriptType = 'DisableForeignKey'
                         THEN 15
                     WHEN ScriptType = 'CheckForeignKey'
                         THEN 16
                     WHEN ScriptType = 'DisableIndex'
                         THEN 17
                     ELSE 99
                END AS SortOrder
      FROM      #tempscriptstore
      UNION ALL
      SELECT    'GO',
                n.num
      FROM      (VALUES (6),    -- After dropping objects, before changing collations
                        (8),    -- After chaning collations, before re-creating objects
                        (14),   -- After creating objects, before checking and disabling foreign keys and indexes
                        (18)    -- End of script
      ) AS n (num) )
SELECT      ScriptInput.script
FROM        ScriptInput
ORDER BY    ScriptInput.SortOrder;

DROP TABLE #tempscriptstore;
