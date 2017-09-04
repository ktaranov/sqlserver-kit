/*
Author: Bert Wagner
Source link: https://blog.bertwagner.com/warning-are-your-queries-vulnerable-to-sql-injection-db914fb39668
*/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT
      ROUTINE_CATALOG
    , ROUTINE_SCHEMA
    , ROUTINE_NAME
    , ROUTINE_TYPE
    , ROUTINE_DEFINITION
FROM
    INFORMATION_SCHEMA.ROUTINES
WHERE
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ROUTINE_DEFINITION,CHAR(0),''),CHAR(9),''),CHAR(10),''),CHAR(11),''),CHAR(12),''),CHAR(13),''),CHAR(14),''),CHAR(160),''),' ','')
        LIKE '%+@%'
    AND 
    ( -- Only if executes a dynamic string
        ROUTINE_DEFINITION LIKE '%EXEC(%'
        OR ROUTINE_DEFINITION LIKE '%EXECUTE%'
        OR ROUTINE_DEFINITION LIKE '%sp_executesql%'
    );
