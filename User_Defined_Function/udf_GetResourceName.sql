IF EXISTS (SELECT *
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[udf_GetResourceName]')
        AND type IN (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
    DROP FUNCTION [dbo].[udf_GetResourceName]
END;
GO


CREATE FUNCTION dbo.udf_GetResourceName(
    @waitResource AS nvarchar(128)
  , @paramName as sysname          =NULL
)
RETURNS nvarchar(max) --we will return t-sql
AS
/*
Author: Darko Martinovic
Original link: http://www.sqlservercentral.com/scripts/T-SQL/153452/
Description: Getting resource name from blocked process report
-- =============================================
-- Get resource name from wait info
-- KEY: 6:72057594041991168 (ce52f92a058c)
-- OBJECT: 10:1730105204:0 databaseId + objectId + lockPartition
-- PAGE: 7:1:422000 databaseId + fileId + pageId
-- FILE: 8:0
-- =============================================
*/
BEGIN
    DECLARE @blockingType AS nvarchar(20);
    --type of blockin KEY,OBJECT,PAGE
    DECLARE @retValue AS nvarchar(max);
    DECLARE @dbId bigint;
    DECLARE @blockingKey AS nvarchar(256);

    SET @retValue = '';

    SET @blockingType = RTRIM(SUBSTRING(@waitResource, 1, CHARINDEX(':', @waitResource) - 1));
    SET @blockingKey = SUBSTRING(@waitResource, CHARINDEX(':', @waitResource) + 1, LEN(@waitResource) - CHARINDEX(':', @waitResource));
    SET @dbId = SUBSTRING(@blockingKey, 1, CHARINDEX(':', @blockingKey) - 1);


    IF @blockingType = 'KEY'
    BEGIN

        DECLARE @hobId AS bigint;
        SET @hobId = RTRIM(SUBSTRING(@blockingKey, CHARINDEX(':', @blockingKey) + 1, CHARINDEX('(', @blockingKey) - CHARINDEX(':', @blockingKey) - 1));

        IF @paramName IS NOT NULL
        BEGIN
            SET @retValue = 'SET ' + @paramName + ' = (';
        END
        SET @retValue = @retValue +
        'SELECT sc.name + ''.'' +so.name +  ''('' + si.name + '')''
                           FROM ' + DB_NAME(@dbId) + '.sys.partitions AS p
                           JOIN ' + DB_NAME(@dbId) + '.sys.objects AS so
                              ON p.object_id = so.object_id
                           JOIN ' + DB_NAME(@dbId) + '.sys.indexes AS si
                              ON p.index_id = si.index_id
                              AND p.object_id = si.object_id
                           JOIN ' + DB_NAME(@dbId) + '.sys.schemas AS sc
                              ON so.schema_id = sc.schema_id
                           WHERE p.hobt_id = ' + CAST(@hobId AS NVARCHAR(MAX));
        IF @paramName IS NOT NULL
        BEGIN
            SET @retValue = @retValue + ')'
        END
    END
    ELSE
        IF @blockingType = 'OBJECT'
        BEGIN
            DECLARE @pos AS INT;
            DECLARE @helper AS NVARCHAR(50);
            DECLARE @objectId AS BIGINT;

            SET @pos = CHARINDEX(':', @blockingKey) + 1;
            SET @helper = SUBSTRING(@blockingKey, @pos, 100);
            SET @objectId = SUBSTRING(@helper, 1, CHARINDEX(':', @helper) - 1);
            --SET @retValue = N'USE ' + DB_NAME(@dbId) + CHAR(13) + CHAR(10);
            SET @retValue = N'';

            IF @paramName IS NOT NULL
            BEGIN
                SET @retValue = 'SET ' + @paramName + ' = (';
            END
            SET @retValue = @retValue +
            'SELECT TOP 1 s.name + ''.'' + o.name 
FROM ' + DB_NAME(@dbid) +' .sys.objects o 
INNER JOIN ' + DB_NAME(@dbid) + '.sys.partitions p 
    ON p.object_id = o.object_id
INNER JOIN ' + DB_NAME(@dbid) +'.sys.schemas s 
    ON s.schema_id = o.schema_id
WHERE p.OBJECT_ID = ' + CAST(@objectId AS NVARCHAR(MAX));
            IF @paramName IS NOT NULL
            BEGIN
                SET @retValue = @retValue + ')'
            END

        END;

        ELSE
            IF @blockingType = 'PAGE'
            BEGIN
                --PAGE 7:1:422000
                DECLARE @pos1 AS INT;
                DECLARE @helper1 AS NVARCHAR(50);
                DECLARE @fileId AS BIGINT;
                DECLARE @pageId AS BIGINT;

                SET @pos1 = CHARINDEX(':', @blockingKey) + 1;
                SET @helper1 = SUBSTRING(@blockingKey, @pos1, 100);
                SET @fileId = SUBSTRING(@helper1, 1, CHARINDEX(':', @helper1) - 1);
                SET @pageId = CAST(SUBSTRING(@helper1, CHARINDEX(':', @helper1) + 1, LEN(@helper1) - CHARINDEX(':', @helper1)) AS BIGINT)
                SET @retValue = 'DECLARE @objectId as bigint

IF OBJECT_ID(''tempdb..#pagedata'') IS NOT NULL
BEGIN
DROP TABLE #pagedata
END;

CREATE TABLE #pagedata
( 
             ParentObject varchar(1000) NULL, Object varchar(4000) NULL, Field varchar(1000) NULL, ObjectValue varchar(max) NULL
);

 ' +
                'DBCC traceon (3604); ' + CHAR(13) + CHAR(10) +
                'SET NOCOUNT ON ;' + CHAR(13) + CHAR(10) +
                'INSERT INTO #pagedata( ParentObject, Object, Field, ObjectValue )' + CHAR(13) + CHAR(10) +
                'EXEC (''DBCC page (' + CAST(@dbId AS NVARCHAR(20)) + ', ' + CAST(@fileId AS NVARCHAR(10)) + ', ' + CAST(@pageId AS NVARCHAR(MAX)) + ') WITH TABLERESULTS '')
SELECT @objectId=objectvalue
FROM #pagedata
WHERE field LIKE ''Metadata: ObjectId%'';'

                IF @paramName IS NOT NULL
                BEGIN
                    SET @retValue = @retValue + 'SET ' + @paramName + ' = (';
                END

                SET @retValue = @retValue + 'SELECT TOP 1 s.name + ''.'' + o.name 
FROM ' + DB_NAME(@dbid) +' .sys.objects o 
INNER JOIN ' + DB_NAME(@dbid) + '.sys.partitions p 
    ON p.object_id = o.object_id
INNER JOIN ' + DB_NAME(@dbid) +'.sys.schemas s 
    ON s.schema_id = o.schema_id
WHERE p.OBJECT_ID = @objectId ';
                IF @paramName IS NOT NULL
                BEGIN
                    SET @retValue = @retValue + ')'
                END

            END;

    RETURN @retvalue;
END;
GO
