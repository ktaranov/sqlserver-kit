/*
Author: Jason Brimhall
Source link: http://www.sqlservercentral.com/blogs/sqlrnnr/2017/10/27/drop-that-schema/
*/

DECLARE @schemaname SYSNAME = 'dbo';
IF ( SELECT OBJECT_ID('tempdb.dbo.#dropschema')
    ) IS NOT NULL
    BEGIN
        DROP TABLE #dropschema;
    END;
SELECT s.name AS SchName
        , o.name AS ObjName
        , o.create_date
        , o.type_desc
        , o.type
        , o.parent_object_id
        , CASE	WHEN o.type IN ( 'F', 'D', 'UQ' )
                THEN 'ALTER TABLE [' + s.name + '].['
                        + OBJECT_NAME(o.parent_object_id)
                        + '] DROP CONSTRAINT [' + o.name + '];'
                WHEN o.type IN ( 'P', 'PC' )
                THEN 'DROP PROCEDURE [' + s.name + '].[' + o.name + '];'
                WHEN o.type IN ( 'FT', 'FN', 'TF', 'AF', 'FS', 'IF' )
                THEN 'DROP FUNCTION [' + s.name + '].[' + o.name + '];'
                WHEN o.type = 'V'
                THEN 'DROP VIEW [' + s.name + '].[' + o.name + '];'
                WHEN o.type = 'SO'
                THEN 'DROP SEQUENCE [' + s.name + '].[' + o.name + '];'
                WHEN o.type = 'U'
                THEN 'DROP TABLE [' + s.name + '].[' + o.name + '];'
                WHEN o.type = 'PG'
                THEN 'EXEC sp_control_plan_guide N''DROP'', N''' + o.name
                        + ''';'
            END AS 'DropText'
        , CASE	WHEN o.type IN ( 'P', 'FN', 'FT', 'TF', 'PC', 'FS', 'AF', 'IF' )
                THEN 1
                WHEN o.type = 'V' THEN 2
                WHEN o.type IN ( 'F', 'D' ) THEN 3
                WHEN o.type = 'SO' THEN 4
                WHEN o.type = 'UQ' THEN 5
                WHEN o.type = 'PG' THEN 6
                WHEN o.type = 'U' THEN 7
            END AS ProcessOrder
    INTO #dropschema
    FROM sys.objects o
        INNER JOIN sys.schemas s
            ON o.schema_id = s.schema_id
        --left outer join sys.default_constraints dc
        --	on o.object_id = dc.parent_object_id
    WHERE o.type NOT IN ( 'PK', 'IT', 'S' )
        AND s.name = @schemaname
    ORDER BY o.parent_object_id DESC
        , o.type;

IF EXISTS ( SELECT 1 / 0
                FROM #dropschema
                WHERE type IN ( 'PC', 'FS', 'AF', 'FT' ) )
    BEGIN
        INSERT INTO #dropschema
                ( SchName
                    , ObjName
                    , create_date
                    , type_desc
                    , type
                    , parent_object_id
                    , DropText
                    , ProcessOrder
                )
                SELECT '' AS ScheName
                        , ass.name AS ObjName
                        , ass.create_date
                        , 'Assembly'
                        , 'AS'
                        , asm.assembly_id
                        , 'DROP ASSEMBLY [' + ass.name + '];' AS DropText
                        , 4 AS ProcessOrder
                    FROM sys.assemblies ass
                        INNER JOIN sys.assembly_modules asm
                            ON ass.assembly_id = asm.assembly_id
                        INNER JOIN sys.objects o
                            ON asm.object_id = o.object_id;
    END;

INSERT INTO #dropschema
        ( DropText
            , ProcessOrder
            , SchName
            , ObjName
            , create_date
            , parent_object_id
        )
    VALUES
        ( 'DROP SCHEMA ' + QUOTENAME(@schemaname) + ';'
            , 99
            , ''
            , ''
            , ''
            , ''
        );

SELECT *
    FROM #dropschema
    ORDER BY ProcessOrder ASC;
