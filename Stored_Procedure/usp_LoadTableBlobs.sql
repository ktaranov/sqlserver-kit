IF (OBJECT_ID('dbo.usp_LoadTableBlobs') IS NULL) EXEC('CREATE PROCEDURE dbo.usp_LoadTableBlobs AS --')
GO
/*

Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source: http://sqlsunday.com/downloads/

DISCLAIMER: This script may not be suitable to run in a production
            environment. I cannot assume any responsibility regarding
            the accuracy of the output information, performance
            impacts on your server, or any other consequence. If
            your juristiction does not allow for this kind of
            waiver/disclaimer, or if you do not accept these terms,
            you are NOT allowed to store, distribute or use this
            code in any way.

VERSION:    2016-06-16

DESCRIPTION: This procedure will insert a blob of table rows, generated
            with SELECT ... FOR XML AUTO into all of the respective tables
            referenced. If possible, it will figure out the insert order,
            based on foreign key constraints between those tables, and it
            also gives you the option of first deleting any existing rows
            and/or using IDENTITY_INSERT.
            Typical use case: scripting and copying meta-data from multiple
            related tables from a production database to a test/dev database.

USAGE:      --- 1. Collect one or more tables' contents as an XML AUTO blob:
            DECLARE @xml xml=(
                SELECT (SELECT * FROM dbo.A FOR XML AUTO, TYPE),
                       (SELECT * FROM dbo.B FOR XML AUTO, TYPE),
                       (SELECT * FROM dbo.C FOR XML AUTO, TYPE)
                FOR XML PATH(''));

            --- 2. Then, on the target database (with identical, existing tables),
            ---    run the procedure, passing the XML blob as argument:
            EXECUTE dbo.usp_LoadTableBlobs
                @blob=@xml,
                @use_identity_insert=0,  --- If you need IDENTITY_INSERT ON
                @truncate_table=0,       --- If you want to empty the target table(s) before inserting
                @print_only=0            --- If you want a "dry run" that only prints the T-SQL code

*/
ALTER PROCEDURE dbo.usp_LoadTableBlobs
    @blob                   xml=NULL,
    @use_identity_insert    bit=0,
    @truncate_table         bit=0,
    @print_only             bit=0
AS

SET NOCOUNT, XACT_ABORT ON;

IF (@blob IS NULL) BEGIN;
    PRINT N'How to use this procedure:

--- 1. Collect one or more tables'' contents as a XML AUTO blob:
DECLARE @xml xml=(
    SELECT (SELECT * FROM dbo.A FOR XML AUTO, TYPE),
           (SELECT * FROM dbo.B FOR XML AUTO, TYPE),
           (SELECT * FROM dbo.C FOR XML AUTO, TYPE)
    FOR XML PATH(''''));

RETURN;

--- 2. Then, on the target database (with identical, existing tables),
---    run the procedure, passing the XML blob as argument:
EXECUTE '+OBJECT_SCHEMA_NAME(@@PROCID)+'.'+OBJECT_NAME(@@PROCID)+'
    @blob=@xml,
    @use_identity_insert=0,     --- If you need IDENTITY_INSERT ON
    @truncate_table=0,          --- If you want to empty the target table(s) before inserting
    @print_only=0               --- If you want a "dry run" that only prints the T-SQL code
';
    RETURN;
END;

DECLARE @table_order TABLE (
    ord                 int NOT NULL,
    [object_id]         int NOT NULL,
    PRIMARY KEY CLUSTERED (ord)
);

DECLARE @updates TABLE (
    parent_object_id        int NOT NULL,
    referenced_object_id    int NOT NULL,
    [sql]                   nvarchar(max) NOT NULL,
    [index]                 nvarchar(max) NOT NULL,
    PRIMARY KEY CLUSTERED (referenced_object_id, parent_object_id)
);

DECLARE @msg                    nvarchar(max),
        @offset                 int,
        @sql                    nvarchar(max)=N'',
        @print                  nvarchar(max);

--- Check input data for tables that don't exist:
SELECT TOP 1 @msg=N'Could not find a table or view named '+sub.name+N'.'+
       (CASE WHEN sub.name NOT LIKE '%.%' THEN N' All table names in @blob need to include schema.' ELSE N'' END)
FROM (
    SELECT DISTINCT x.n.value('fn:local-name(.)', 'sysname') AS name
    FROM @blob.nodes('//*') AS x(n)
    ) AS sub
WHERE sub.name NOT IN (SELECT s.name+N'.'+o.name
                       FROM sys.objects AS o
                       INNER JOIN sys.schemas AS s ON o.[schema_id]=s.[schema_id]
                       WHERE o.[type] IN ('U', 'V'));

IF (@msg IS NOT NULL) BEGIN;
    RAISERROR(@msg, 16, 1);
    RETURN;
END;


--- All tables:
WITH tbl AS (
    SELECT o.[object_id], s.name+'.'+o.name AS name
    FROM sys.tables AS o
    INNER JOIN sys.schemas AS s ON o.[schema_id]=s.[schema_id]),

--- All foreign key constraints:
refs AS (
    SELECT DISTINCT fk.parent_object_id, fk.referenced_object_id
    FROM sys.foreign_key_columns AS fk
    WHERE fk.parent_object_id!=fk.referenced_object_id),

--- Recurse from referenced tables up to their parents
rcte AS (
    SELECT 1 AS lvl, tbl.[object_id], tbl.name
    FROM tbl
    WHERE tbl.[object_id] NOT IN (SELECT parent_object_id FROM refs) AND
          tbl.[object_id] IN (SELECT referenced_object_id FROM refs)

    UNION ALL

    SELECT 10000 AS lvl, tbl.[object_id], tbl.name
    FROM tbl
    WHERE tbl.[object_id] NOT IN (SELECT parent_object_id FROM refs) AND
          tbl.[object_id] NOT IN (SELECT referenced_object_id FROM refs)

    UNION ALL

    --- Recursion happens here:
    SELECT rcte.lvl+1, tbl.[object_id], tbl.name
    FROM rcte
    INNER JOIN refs ON refs.referenced_object_id=rcte.[object_id]
    INNER JOIN tbl ON refs.parent_object_id=tbl.[object_id])

INSERT INTO @table_order (ord, [object_id])
SELECT ROW_NUMBER() OVER (ORDER BY MAX(lvl)) AS ord, [object_id]
FROM rcte
WHERE name IN (
    --- These are the distinct element names in the blob, i.e.
    --- a list of all the table names:
    SELECT DISTINCT x.n.value('fn:local-name(.)', 'sysname')
    FROM @blob.nodes('//*') AS x(n))
GROUP BY [object_id];

--- Generate dynamic T-SQL code to create the temp tables:
-------------------------------------------------------------------------------
SELECT @sql=@sql+
    (CASE WHEN LAG(c.column_id, 1, 0) OVER (PARTITION BY x.ord ORDER BY c.column_id)=0 THEN N'
--- Worker table for '+s.name+N'.'+o.name+N'
SELECT'

    ELSE ',' END)+'
    t.r.value(''@'+REPLACE(c.name, ' ', '_')+N''', '''+t.name+(CASE
            WHEN t.name LIKE 'n%char' OR t.name LIKE 'n%binary' THEN N'('+ISNULL(CAST(NULLIF(c.max_length, -1)/2 AS varchar(10)), N'max')+N')'
            WHEN t.name LIKE '%char' OR t.name LIKE '%binary' THEN N'('+ISNULL(CAST(NULLIF(c.max_length, -1) AS varchar(10)), N'max')+N')'
            WHEN t.name IN ('datetime2' ,'time', 'datetimeoffset') THEN N'('+CAST(c.scale AS varchar(10))+N')'
            WHEN t.name IN ('decimal', 'numeric') THEN N'('+CAST(c.[precision] AS varchar(10))+N', '+CAST(c.scale AS varchar(10))+N')'
            ELSE N'' END)+N''') AS ['+c.name+']'
    
    +(CASE WHEN LEAD(c.column_id, 1, 0) OVER (PARTITION BY x.ord ORDER BY c.column_id)=0 THEN N'
INTO
    [#'+s.name+N'.'+o.name+']
FROM
    @xml.nodes(''/'+s.name+N'.'+o.name+N''') AS t(r);
' ELSE '' END)
FROM sys.schemas AS s
INNER JOIN sys.objects AS o ON s.[schema_id]=o.[schema_id]
LEFT JOIN sys.identity_columns AS id ON o.[object_id]=id.[object_id]
INNER JOIN sys.columns AS c ON o.[object_id]=c.[object_id]
INNER JOIN sys.types AS t ON c.system_type_id=t.user_type_id
INNER JOIN @table_order AS x ON o.[object_id]=x.[object_id]
ORDER BY x.ord, c.column_id;

--- Build dynamic T-SQL to map inserted identity values to any
--- dependent (referencing) target tables:
-------------------------------------------------------------------------------

IF (@use_identity_insert=0) BEGIN;
    WITH cols AS (
        SELECT fk.parent_object_id, pc.name AS parent_column, fk.referenced_object_id, rc.name AS referenced_identity_column
        FROM @table_order AS p
        INNER JOIN sys.columns AS pc ON p.[object_id]=pc.[object_id]
        INNER JOIN sys.foreign_key_columns AS fk ON pc.[object_id]=fk.parent_object_id AND pc.column_id=fk.parent_column_id
        INNER JOIN @table_order AS r ON fk.referenced_object_id=r.[object_id]
        INNER JOIN sys.identity_columns AS rc ON fk.referenced_object_id=rc.[object_id] AND fk.referenced_column_id=rc.column_id),

         natural_keys AS (
        SELECT x.[object_id], SUBSTRING(CAST(
               (SELECT (CASE is_nullable
                        WHEN 1 THEN N' AND (old.['+name+N']=new.['+name+N'] OR old.['+name+N'] IS NULL AND new.['+name+N'] IS NULL)'
                        WHEN 0 THEN N' AND old.['+name+N']=new.['+name+N']'
                        END)
                FROM (
                    SELECT [object_id], index_id, name, is_nullable,
                           DENSE_RANK() OVER (PARTITION BY [object_id] ORDER BY column_count, index_id) AS prio
                    FROM (
                        SELECT i.[object_id], i.index_id, c.name, c.is_nullable,
                               SIGN(MAX(ISNULL(id.column_id, 0)) OVER (PARTITION BY i.[object_id], i.index_id)) AS includes_identity,
                               COUNT(*) OVER (PARTITION BY i.[object_id], i.index_id) AS column_count
                        FROM @table_order AS x
                        INNER JOIN sys.indexes AS i ON x.[object_id]=i.[object_id]
                        INNER JOIN sys.index_columns AS ic ON i.[object_id]=ic.[object_id] AND i.index_id=ic.index_id AND ic.is_included_column=0
                        INNER JOIN sys.columns AS c ON ic.[object_id]=c.[object_id] AND ic.column_id=c.column_id
                        LEFT JOIN sys.identity_columns AS id ON i.[object_id]=id.[object_id] AND ic.column_id=id.column_id
                        WHERE i.is_unique=1 AND i.has_filter=0 AND i.is_disabled=0
                        ) AS sub
                    WHERE includes_identity=0
                    ) AS sub
                WHERE prio=1 AND [object_id]=x.[object_id]
                FOR XML PATH(''), TYPE) AS nvarchar(max)), 6, 10000) AS [join], SUBSTRING(CAST(
               (SELECT N', ['+name+N']'
                FROM (
                    SELECT [object_id], index_id, name, is_nullable,
                           DENSE_RANK() OVER (PARTITION BY [object_id] ORDER BY column_count, index_id) AS prio
                    FROM (
                        SELECT i.[object_id], i.index_id, c.name, c.is_nullable,
                               SIGN(MAX(ISNULL(id.column_id, 0)) OVER (PARTITION BY i.[object_id], i.index_id)) AS includes_identity,
                               COUNT(*) OVER (PARTITION BY i.[object_id], i.index_id) AS column_count
                        FROM @table_order AS x
                        INNER JOIN sys.indexes AS i ON x.[object_id]=i.[object_id]
                        INNER JOIN sys.index_columns AS ic ON i.[object_id]=ic.[object_id] AND i.index_id=ic.index_id AND ic.is_included_column=0
                        INNER JOIN sys.columns AS c ON ic.[object_id]=c.[object_id] AND ic.column_id=c.column_id
                        LEFT JOIN sys.identity_columns AS id ON i.[object_id]=id.[object_id] AND ic.column_id=id.column_id
                        WHERE i.is_unique=1 AND i.has_filter=0 AND i.is_disabled=0
                        ) AS sub
                    WHERE includes_identity=0
                    ) AS sub
                WHERE prio=1 AND [object_id]=x.[object_id]
                FOR XML PATH(''), TYPE) AS nvarchar(max)), 3, 10000) AS index_cols
        FROM @table_order AS x)

    INSERT INTO @updates (parent_object_id, referenced_object_id, [sql], [index])
    SELECT cols.parent_object_id, cols.referenced_object_id, N'
    UPDATE t
    SET t.['+cols.parent_column+N']=new.['+cols.referenced_identity_column+N']
    FROM [#'+ps.name+N'.'+p.name+N'] AS t
    INNER JOIN [#'+rs.name+N'.'+r.name+N'] AS old ON t.['+cols.parent_column+N']=old.['+cols.referenced_identity_column+N']
    INNER JOIN '+rs.name+N'.'+r.name+N' AS new ON '+nk.[join]+N';
' AS [sql], N'CREATE UNIQUE CLUSTERED INDEX NK ON [#'+rs.name+N'.'+r.name+N'] ('+nk.index_cols+N');'
    FROM natural_keys AS nk
    INNER JOIN cols AS cols ON cols.referenced_object_id=nk.[object_id]
    INNER JOIN sys.objects AS p ON cols.parent_object_id=p.[object_id]
    INNER JOIN sys.schemas AS ps ON p.[schema_id]=ps.[schema_id]
    INNER JOIN sys.objects AS r ON cols.referenced_object_id=r.[object_id]
    INNER JOIN sys.schemas AS rs ON r.[schema_id]=rs.[schema_id]
    WHERE nk.[join] IS NOT NULL;

    --- Sanity check:
    SELECT TOP 1 @msg='Error: There is no unique index on non-identity column(s) in table '+s.name+'.'+o.name+'. The table has an identity column as a primary key, which is referenced by one or more foreign key constraints. The procedure needs this information to map the inserted IDENTITY column ids. Add a unique index on a natural key in '+s.name+'.'+o.name+' OR set @use_identity_insert=1.'
    FROM @table_order AS p
    INNER JOIN sys.columns AS pc ON p.[object_id]=pc.[object_id]
    INNER JOIN sys.foreign_key_columns AS fk ON pc.[object_id]=fk.parent_object_id AND pc.column_id=fk.parent_column_id
    INNER JOIN @table_order AS r ON fk.referenced_object_id=r.[object_id]
    INNER JOIN sys.identity_columns AS rc ON fk.referenced_object_id=rc.[object_id] AND fk.referenced_column_id=rc.column_id
    INNER JOIN sys.objects AS o ON r.[object_id]=o.[object_id]
    INNER JOIN sys.schemas AS s ON o.[schema_id]=s.[schema_id]
    LEFT JOIN @updates AS u ON u.parent_object_id=fk.parent_object_id AND u.referenced_object_id=fk.referenced_object_id
    WHERE u.parent_object_id IS NULL;

    IF (@msg IS NOT NULL) BEGIN;
        RAISERROR(@msg, 16, 1);
        RETURN;
    END;

END;

--- Create indexes on the temp tables:
-------------------------------------------------------------------------------
SELECT @sql=@sql+N'
--- Unique index on natural key, used to look up IDENTITY values.
'+[index]+N'
'
FROM (
    SELECT DISTINCT [index]
    FROM @updates
    ) AS sub;

--- Begin transaction:
-------------------------------------------------------------------------------
SET @sql=@sql+N'


BEGIN TRANSACTION;
';

--- T-SQL code to delete existing rows from target tables:
-------------------------------------------------------------------------------
IF (@truncate_table=1)
    SELECT @sql=@sql+N'
    --- Delete any rows in '+s.name+N'.'+o.name+N'
    DELETE FROM '+s.name+N'.'+o.name+';

    PRINT ''Deleted ''+CAST(@@ROWCOUNT AS varchar(10))+'' row(s) from table '+s.name+N'.'+o.name+N'.'';
'
    FROM sys.schemas AS s
    INNER JOIN sys.objects AS o ON s.[schema_id]=o.[schema_id]
    INNER JOIN @table_order AS x ON o.[object_id]=x.[object_id]
    ORDER BY x.ord DESC;

--- T-SQL code to a) insert rows into target tables, then b) map inserted
--- identity values to referencing target tables:
-------------------------------------------------------------------------------

SELECT @sql=@sql+
       (CASE WHEN p.pass=1 AND LAG(c.column_id, 1, 0) OVER (PARTITION BY x.ord, p.pass ORDER BY c.column_id)=0 THEN N'
    --- '+s.name+N'.'+o.name+N':'+(CASE WHEN @use_identity_insert=1 AND id.[object_id] IS NOT NULL THEN N'
    SET IDENTITY_INSERT '+s.name+N'.'+o.name+N' ON;
' ELSE N'' END)+N'
    INSERT INTO '+s.name+N'.'+o.name+N' ('
             WHEN p.pass=2 AND LAG(c.column_id, 1, 0) OVER (PARTITION BY x.ord, p.pass ORDER BY c.column_id)=0 THEN N'
    SELECT '
             WHEN p.pass=3 AND LAG(c.column_id, 1, 0) OVER (PARTITION BY x.ord, p.pass ORDER BY c.column_id)=0 THEN ISNULL(N'
    --- Target tables that directly reference '+s.name+N'.'+o.name+N':'+REPLACE(CAST((
             
                SELECT [sql]+N''
                FROM @updates AS upd_sql
                WHERE upd_sql.referenced_object_id=o.[object_id]
                FOR XML PATH(''), TYPE) AS varchar(max)), N'&#x0D;', N''), N'')

             WHEN p.pass=3 THEN N''

             ELSE ', ' END)+

       (CASE WHEN p.pass IN (1, 2) THEN N'['+c.name+N']'
             ELSE N'' END)+

       (CASE WHEN p.pass=1 AND LEAD(c.column_id, 1, 0) OVER (PARTITION BY x.ord, p.pass ORDER BY c.column_id)=0 THEN N')'
             WHEN p.pass=2 AND LEAD(c.column_id, 1, 0) OVER (PARTITION BY x.ord, p.pass ORDER BY c.column_id)=0 THEN N'
    FROM [#'+s.name+N'.'+o.name+N'];

    PRINT ''Inserted ''+CAST(@@ROWCOUNT AS varchar(10))+'' row(s) in table '+s.name+N'.'+o.name+N'.'';'+
            (CASE WHEN @use_identity_insert=1 AND id.[object_id] IS NOT NULL THEN N'

    SET IDENTITY_INSERT '+s.name+N'.'+o.name+N' OFF;
'                 ELSE N''
                  END)+N'
'            ELSE '' END)

FROM sys.schemas AS s
INNER JOIN sys.objects AS o ON s.[schema_id]=o.[schema_id]
INNER JOIN sys.columns AS c ON o.[object_id]=c.[object_id]
LEFT JOIN sys.identity_columns AS id ON c.[object_id]=id.[object_id]
INNER JOIN @table_order AS x ON o.[object_id]=x.[object_id]
CROSS APPLY (VALUES (1), (2), (3)) AS p(pass)
WHERE @use_identity_insert=1 AND p.pass IN (1, 2) OR
      @use_identity_insert=0 AND c.column_id!=ISNULL(id.column_id, 0)
ORDER BY x.ord, p.pass;


--- Ready to run:
-------------------------------------------------------------------------------

SET @sql=@sql+N'
COMMIT TRANSACTION;';



--- Sharing is caring: here's the T-SQL code:
SET @print=@sql;
WHILE (@print!='') BEGIN;
    SET @offset=4000-CHARINDEX('
', REVERSE(LEFT(@print, 4000)));

    PRINT LEFT(@print, @offset);
    SET @print=SUBSTRING(@print, @offset+1, LEN(@print));
END;



--- The big-time:
IF (@print_only=0)
    EXECUTE sys.sp_executesql @sql, N'@xml xml', @xml=@blob;



GO
