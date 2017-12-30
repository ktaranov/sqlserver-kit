/*
Author: Bill Fellows 
Original link: http://billfellows.blogspot.ru/2017/06/rename-default-constraints.html
*/
-- Rename default constraints

DECLARE @query nvarchar(4000);
DECLARE
    CSR CURSOR
FAST_FORWARD
FOR
SELECT
    CONCAT('ALTER TABLE ', QUOTENAME(S.name), '.', QUOTENAME(T.name), ' DROP CONSTRAINT [', DC.name, '];', CHAR(10)
    , 'ALTER TABLE ', QUOTENAME(S.name), '.', QUOTENAME(T.name)
    , ' ADD CONSTRAINT [', 'DF__', (S.name), '_', (T.name), '_', C.name, ']'
    , ' DEFAULT ', DC.definition, ' FOR ', QUOTENAME(C.name)) AS Query
FROM
    sys.schemas AS S
    INNER JOIN
        sys.tables AS T
        ON T.schema_id = S.schema_id
    INNER JOIN
        sys.columns AS C
        ON C.object_id = T.object_id
    INNER JOIN
        sys.default_constraints AS DC
        ON DC.parent_object_id = T.object_id
        AND DC.object_id = C.default_object_id
WHERE
    DC.name LIKE 'DF__%'
    AND DC.name <> CONCAT('DF__', (S.name), '_', (T.name), '_', C.name);

OPEN CSR
FETCH NEXT FROM CSR INTO @query;
WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        EXECUTE sys.sp_executesql @query, N'';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        PRINT @query;
    END CATCH
    FETCH NEXT FROM CSR INTO @query;
END
CLOSE CSR;
DEALLOCATE CSR;