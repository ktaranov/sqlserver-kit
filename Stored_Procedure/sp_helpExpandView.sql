IF OBJECT_ID('dbo.sp_helpExpandView', 'P') IS NULL
EXECUTE ('CREATE PROCEDURE dbo.sp_helpExpandView AS SELECT 1');
GO


ALTER PROCEDURE dbo.sp_helpExpandView (
    @ViewName NVARCHAR(512),
    @OutputFormat VARCHAR(15) = 'All',
    @ShowObjectCount BIT = 0,
    @Debug BIT = 0
)
AS
/*===============================================================================
-- sp_helpExpandView
-- 
-- Written By: Andy Yun
-- Created On: 2015-02-27
-- 
-- Summary:
-- This tool script was written to aid in de-constructing nested views and
-- identifying all base objects underneath.  
--
-- Supports:
--      Scalar & Table-Valued Functions
--      Schemas
--      Synonyms to other DBs
--
-- 
-- Updates:
-- Date         Developer   Remarks
-- 2015-03-02   AYun        V1: Initial Release
-- 2015-03-03   AYun        V2: Rewrote to properly handle external database 
--                          references in child objects. 
-- 2015-03-03   AYun        V2.1: Tweaked to remove duplicate results.
--                          Added sorting to output
-- 2015-03-09   AYun        V2.11: Adjusted horizontal output ORDER BY clause.
-- 2015-03-30   AYun        V2.2: New Output - List all objects referenced & count
-- 2015-05-20   AYun        V2.3: Corrected CURSOR & Database Name with space issue. 
--                          Thanks Mickey Stuewe!
---------------------------------------------------------------------------------
-- License: 
-- This code is free to use for personal, educational, and internal corporate 
-- purposes provided that this header is preserved. 
-- (c) 2015 Andy Yun
===============================================================================*/
BEGIN
BEGIN TRY
    IF OBJECT_ID(@ViewName) IS NULL
    BEGIN
        RAISERROR('@ViewName undefined or does not exist.', 11, 1);
    END

    DECLARE @BaseObject_DBName NVARCHAR(256),
        @ChildObjectsFound SMALLINT = 1,
        @HierarchyLevelToSearch TINYINT = 1,
        @MinObjectHierarchyID INT = 0,
        @TmpObjectHierarchyID INT = NULL,
        @MaxObjectHierarchyID INT = 1,
        @DBName NVARCHAR(256),
        @sqlCMD NVARCHAR(4000);

    -- sys.dm_sql_referenced_entities() dislikes brackets. Must strip out.
    SET @ViewName = REPLACE(REPLACE(@ViewName, ']', ''), '[', '');

    -- if no schema specified, append dbo
    IF CHARINDEX('.', @ViewName, 1) = 0
        SET @ViewName = 'dbo.' + @ViewName;

    IF @Debug = 1 SELECT '@ViewName', @ViewName

    -----
    -- Temp Tables
    IF OBJECT_ID('tempdb.dbo.#tmpObjectHierarchy', 'U') IS NOT NULL
        DROP TABLE #tmpObjectHierarchy;

    IF OBJECT_ID('tempdb.dbo.#tmpAllObjects', 'U') IS NOT NULL
        DROP TABLE #tmpAllObjects;

    IF OBJECT_ID('tempdb.dbo.#tmpExternalObjectsToProcess', 'U') IS NOT NULL
        DROP TABLE #tmpExternalObjectsToProcess;

    -- Create final output table containing full object hierarchy
    CREATE TABLE #tmpObjectHierarchy (
        ObjectHierarchyID INT IDENTITY(1, 1) PRIMARY KEY CLUSTERED,
        HierarchyLvl TINYINT,

        BaseObject_DBName NVARCHAR(512),
        BaseObject_FullName NVARCHAR(512),

        Child_DBName NVARCHAR(512),
        Child_SchemaName NVARCHAR(256),
        Child_ObjectName NVARCHAR(256),
        Child_FullName NVARCHAR(512),
        Child_Type CHAR(2),
        Child_ObjectID INT,
        Synonym_BaseObjectName NVARCHAR(1035),
        Synonym_BaseObjectType NVARCHAR(2),
        ParentObjectHierarchyID INT
        );

    -- Populate #tmpObjectHierarchy with base level data
    INSERT INTO #tmpObjectHierarchy (
        BaseObject_DBName,
        BaseObject_FullName,
        Child_FullName,
        Child_SchemaName,
        Child_ObjectName,
        Child_Type,
        Child_ObjectID,
        HierarchyLvl,
        Child_DBName,
        ParentObjectHierarchyID
        )
    SELECT DISTINCT
        DB_NAME(),
        @ViewName,
        COALESCE(schemas.name, dm_sql_referenced_entities.referenced_schema_name) + '.' + dm_sql_referenced_entities.referenced_entity_name, 
        COALESCE(schemas.name, dm_sql_referenced_entities.referenced_schema_name),
        dm_sql_referenced_entities.referenced_entity_name,
        COALESCE(schemas.type, NULL),
        dm_sql_referenced_entities.referenced_id,
        1 AS HierarchyLvl,
        COALESCE(dm_sql_referenced_entities.referenced_database_name, DB_NAME()),
        0 AS ParentObjectHierarchyID
    FROM sys.dm_sql_referenced_entities(@ViewName, 'OBJECT')
    LEFT OUTER JOIN (
        SELECT objects.object_id, schemas.name, objects.type
        FROM sys.objects
        INNER JOIN sys.schemas
            ON objects.schema_id = schemas.schema_id
    ) schemas
        ON dm_sql_referenced_entities.referenced_id = schemas.object_id
    WHERE referenced_minor_id = 0;

    SELECT @MaxObjectHierarchyID = MAX(ObjectHierarchyID)
    FROM #tmpObjectHierarchy;

    IF @Debug = 1 SELECT '#tmpObjectHierarchy', * FROM #tmpObjectHierarchy;

    --SELECT '1-#tmpObjectHierarchy', * FROM #tmpObjectHierarchy;

    -----
    -- Loop for each new Hierarchy Level #tmpObjectHierarchy
    WHILE @MinObjectHierarchyID < @MaxObjectHierarchyID
    BEGIN
        IF @Debug = 1 SELECT @MinObjectHierarchyID AS '@MinObjectHierarchyID', @MaxObjectHierarchyID AS '@MaxObjectHierarchyID';

        -----
        -- For each DB found in #tmpObjectHierarchy, loop through each recordset of each Database
        DECLARE cursorEachDatabase CURSOR FAST_FORWARD
        FOR
        SELECT DISTINCT Child_DBName
        FROM #tmpObjectHierarchy;

        OPEN cursorEachDatabase;

        FETCH NEXT
        FROM cursorEachDatabase
        INTO @DBName

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Debug = 1 SELECT @DBName AS '@DBName';
            
            SET @sqlCMD = N'
            INSERT INTO #tmpObjectHierarchy (
                BaseObject_DBName,
                BaseObject_FullName,
                Child_FullName,
                Child_SchemaName,
                Child_ObjectName,
                Child_ObjectID,
                Child_Type,
                HierarchyLvl,
                Child_DBName,
                ParentObjectHierarchyID
                )
            SELECT DISTINCT
                #tmpObjectHierarchy.Child_DBName,
                #tmpObjectHierarchy.Child_FullName,
                COALESCE(dm_sql_referenced_entities.referenced_schema_name, schemas.name) + ''.'' + dm_sql_referenced_entities.referenced_entity_name,
                COALESCE(dm_sql_referenced_entities.referenced_schema_name, schemas.name),
                dm_sql_referenced_entities.referenced_entity_name,
                dm_sql_referenced_entities.referenced_id,
                COALESCE(schemas.type, NULL),
                #tmpObjectHierarchy.HierarchyLvl + 1 AS HierarchyLvl,
                COALESCE(dm_sql_referenced_entities.referenced_database_name, #tmpObjectHierarchy.Child_DBName),
                #tmpObjectHierarchy.ObjectHierarchyID
            FROM #tmpObjectHierarchy
            CROSS APPLY [@DatabaseName].sys.dm_sql_referenced_entities(#tmpObjectHierarchy.Child_FullName, ''OBJECT'')
            LEFT OUTER JOIN (
                SELECT objects.object_id, schemas.name, objects.type
                FROM [@DatabaseName].sys.objects
                INNER JOIN [@DatabaseName].sys.schemas
                    ON objects.schema_id = schemas.schema_id
            ) schemas
                ON dm_sql_referenced_entities.referenced_id = schemas.object_id
            WHERE dm_sql_referenced_entities.referenced_minor_id = 0
                AND #tmpObjectHierarchy.Child_DBName = ''@DatabaseName''
                AND #tmpObjectHierarchy.ObjectHierarchyID >= @MinObjectHierarchyID;'

            SET @sqlCMD = REPLACE(@sqlCMD, '@MinObjectHierarchyID', @MinObjectHierarchyID)
            SET @sqlCMD = REPLACE(@sqlCMD, '@HierarchyLevelToSearch', @HierarchyLevelToSearch)
            SET @sqlCMD = REPLACE(@sqlCMD, '@DatabaseName', @DBName)

            IF @Debug = 1 PRINT @sqlCMD;
            
            EXECUTE sp_executesql @sqlCMD

            -- Must identify if any of these objects are synonyms.
            SET @sqlCMD = N'
            -- Update synonym objects with fully qualified base_object_name values
            UPDATE #tmpObjectHierarchy
            SET Child_Type = synonyms.type,
                Child_DBName = PARSENAME(synonyms.base_object_name, 3),
                Synonym_BaseObjectName = synonyms.base_object_name
            FROM [@DatabaseName].sys.synonyms
            INNER JOIN [@DatabaseName].sys.schemas
                ON synonyms.schema_id = schemas.schema_id
            WHERE #tmpObjectHierarchy.Child_DBName = ''@DatabaseName''
                AND #tmpObjectHierarchy.ObjectHierarchyID >= @MinObjectHierarchyID
                AND synonyms.object_id = #tmpObjectHierarchy.Child_ObjectID;';

            SET @sqlCMD = REPLACE(@sqlCMD, '@MinObjectHierarchyID', @MinObjectHierarchyID)
            SET @sqlCMD = REPLACE(@sqlCMD, '@DatabaseName', @DBName)

            IF @Debug = 1 PRINT @sqlCMD;

            EXECUTE sp_executesql @sqlCMD

            FETCH NEXT
            FROM cursorEachDatabase
            INTO @DBName
        END

        CLOSE cursorEachDatabase;
        DEALLOCATE cursorEachDatabase;

        SELECT 
            @TmpObjectHierarchyID = @MinObjectHierarchyID,
            @MinObjectHierarchyID = @MaxObjectHierarchyID + 1,
            @MaxObjectHierarchyID = MAX(ObjectHierarchyID)
        FROM #tmpObjectHierarchy;
        
        -- Serialize 
        INSERT INTO #tmpObjectHierarchy (
            BaseObject_DBName,
            BaseObject_FullName,
            Child_FullName,
            Child_SchemaName,
            Child_ObjectName,
            Child_ObjectID,
            HierarchyLvl,
            Child_DBName,
            ParentObjectHierarchyID
            )
        SELECT DISTINCT
            #tmpObjectHierarchy.BaseObject_DBName AS BaseObject_DBName,
            #tmpObjectHierarchy.Child_FullName AS BaseObject_FullName,
            PARSENAME(Synonym_BaseObjectName, 2) + '.' + PARSENAME(Synonym_BaseObjectName, 1) AS Child_FullName,
            PARSENAME(Synonym_BaseObjectName, 2) AS Child_SchemaName,
            PARSENAME(Synonym_BaseObjectName, 1) AS Child_ObjectName,
            OBJECT_ID(#tmpObjectHierarchy.Synonym_BaseObjectName) AS Child_ObjectID,
            #tmpObjectHierarchy.HierarchyLvl + 1 AS HierarchyLvl,
            #tmpObjectHierarchy.Child_DBName AS Child_DBName,
            #tmpObjectHierarchy.ObjectHierarchyID AS ParentObjectHierarchyID        
        FROM #tmpObjectHierarchy
        WHERE #tmpObjectHierarchy.Child_Type = 'SN'
            AND #tmpObjectHierarchy.ObjectHierarchyID > @TmpObjectHierarchyID;
            
        IF @Debug = 1 SELECT '2-#tmpObjectHierarchy', * FROM #tmpObjectHierarchy;
    END

    IF @Debug = 1 SELECT '3-#tmpObjectHierarchy', * FROM #tmpObjectHierarchy;
        
    -- All children of synonyms will be missing a Type.  Need to go back through all DBs and materialize these.
    IF EXISTS(SELECT 1 FROM #tmpObjectHierarchy WHERE Child_Type IS NULL)
    BEGIN

        -----
        -- For each DB found in #tmpObjectHierarchy, loop through each recordset of each Database
        DECLARE cursorEachDatabase_2 CURSOR FAST_FORWARD
        FOR
        SELECT DISTINCT Child_DBName
        FROM #tmpObjectHierarchy
        WHERE Child_Type IS NULL;

        OPEN cursorEachDatabase_2;

        FETCH NEXT
        FROM cursorEachDatabase_2
        INTO @DBName

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @Debug = 1 SELECT @DBName AS '@DBName';

            SET @sqlCMD = N'
            UPDATE #tmpObjectHierarchy
            SET Child_Type = objects.type
            FROM [@DatabaseName].sys.objects
            WHERE #tmpObjectHierarchy.Child_DBName = ''@DatabaseName''
                AND #tmpObjectHierarchy.Child_Type IS NULL
                AND #tmpObjectHierarchy.Child_ObjectID = objects.object_id;';

            SET @sqlCMD = REPLACE(@sqlCMD, '@DatabaseName', @DBName)

            IF @Debug = 1 PRINT @sqlCMD;

            EXECUTE sp_executesql @sqlCMD

            FETCH NEXT
            FROM cursorEachDatabase_2
            INTO @DBName
        END

        CLOSE cursorEachDatabase_2;
        DEALLOCATE cursorEachDatabase_2;

    END

    -----
    -- Unflattened Output
    IF (
            @OutputFormat = 'Vertical'
            OR @OutputFormat = 'All'
            )
    BEGIN
        SELECT DISTINCT
            HierarchyLvl,
            BaseObject_FullName,
            Child_DBName,
            Child_FullName,
            Child_Type,
            ObjectHierarchyID,
            ParentObjectHierarchyID
        FROM #tmpObjectHierarchy
        ORDER BY HierarchyLvl,
            BaseObject_FullName,
            Child_DBName,
            Child_FullName
    END

    -----
    -- Dynamically create flattened output
    IF (
            @OutputFormat = 'Horizontal'
            OR @OutputFormat = 'All'
            )
    BEGIN
        DECLARE @MaxHierarchyID INT,
            @HierarchyID INT = 2;

        SELECT @MaxHierarchyID = MAX(HierarchyLvl)
        FROM #tmpObjectHierarchy;

        DECLARE @sqlSelect NVARCHAR(4000) = N'
        SELECT DISTINCT
            Lvl1.BaseObject_FullName
            , Lvl1.HierarchyLvl AS Lvl_1
            , Lvl1.Child_FullName AS Obj_1
            , Lvl1.Child_Type AS Typ_1',
            @sqlFrom NVARCHAR(4000) = N'
        FROM #tmpObjectHierarchy Lvl1';

        WHILE @HierarchyID <= @MaxHierarchyID
        BEGIN
            SET @sqlSelect = @sqlSelect + N'
            , COALESCE(Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '.HierarchyLvl, ''' + CAST(@HierarchyID AS NVARCHAR(4000)) + ''') AS Lvl_' + CAST(@HierarchyID AS NVARCHAR(4000)) + '
            , COALESCE(Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '.Child_FullName, SPACE(0)) AS Obj_' + CAST(@HierarchyID AS NVARCHAR(4000)) + '
            , COALESCE(Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '.Child_Type, SPACE(0)) AS Typ_' + CAST(@HierarchyID AS NVARCHAR(4000));
            SET @sqlFrom = @sqlFrom + N'
        LEFT OUTER JOIN #tmpObjectHierarchy Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '
            ON Lvl' + CAST((@HierarchyID - 1) AS NVARCHAR(4000)) + '.ObjectHierarchyID = Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '.ParentObjectHierarchyID
            AND Lvl' + CAST(@HierarchyID AS NVARCHAR(4000)) + '.HierarchyLvl = ' + CAST(@HierarchyID AS NVARCHAR(4000));
            SET @HierarchyID = @HierarchyID + 1;
        END

        SET @sqlCMD = @sqlSelect + @sqlFrom + N'
        WHERE Lvl1.HierarchyLvl = 1
        ORDER BY Lvl1.BaseObject_FullName, Lvl1.HierarchyLvl, Lvl1.Child_FullName;';

        EXEC sp_executesql @sqlCMD;
    END

    -----
    -- If enabled, show list of all objects referenced & # of times referenced.
    IF @ShowObjectCount = 1
    BEGIN
        SELECT 
            CASE
                WHEN #tmpObjectHierarchy.Child_Type = 'U'
                    THEN 'User Table'
                WHEN #tmpObjectHierarchy.Child_Type = 'S'
                    THEN 'System Table'
                WHEN #tmpObjectHierarchy.Child_Type = 'V'
                    THEN 'View'
                WHEN #tmpObjectHierarchy.Child_Type = 'FN'
                    THEN 'Scalar Function'
                WHEN #tmpObjectHierarchy.Child_Type = 'IF'
                    THEN 'Inline Function'
                WHEN #tmpObjectHierarchy.Child_Type = 'TF'
                    THEN 'Table Valued Function'
                WHEN #tmpObjectHierarchy.Child_Type = 'P'
                    THEN 'Stored Procedure'
                WHEN #tmpObjectHierarchy.Child_Type = 'SN'
                    THEN 'Synonym'
                ELSE #tmpObjectHierarchy.Child_Type  
            END AS ObjectType,
            #tmpObjectHierarchy.Child_FullName AS Object_FullName, 
            COUNT(1) AS ReferencedCount
        FROM #tmpObjectHierarchy
        GROUP BY #tmpObjectHierarchy.Child_Type, 
            #tmpObjectHierarchy.Child_FullName
        ORDER BY ObjectType, 
            #tmpObjectHierarchy.Child_FullName
    END
END TRY
BEGIN CATCH
    IF (SELECT CURSOR_STATUS('global','cursorEachDatabase')) >= -1
    BEGIN
        DEALLOCATE cursorEachDatabase
    END

    IF (SELECT CURSOR_STATUS('global','cursorEachDatabase_2')) >= -1
    BEGIN
        DEALLOCATE cursorEachDatabase_2
    END

    DECLARE 
        @ErrorNumber INT,
        @ErrorSeverity INT,
        @ErrorState INT,
        @ErrorProcedure NVARCHAR(128),
        @ErrorLine INT,
        @ErrorMessage NVARCHAR(4000);   
        
    SELECT
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorProcedure = ERROR_PROCEDURE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorMessage = ERROR_MESSAGE();
    
    SELECT
        @ErrorNumber AS ErrorNumber,
        @ErrorSeverity AS ErrorSeverity,
        @ErrorState AS ErrorState,
        @ErrorProcedure AS ErrorProcedure,
        @ErrorLine AS ErrorLine,
        @ErrorMessage AS ErrorMessage;
END CATCH
END
GO
