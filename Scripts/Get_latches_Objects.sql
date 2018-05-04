IF OBJECT_ID('tempdb..#owt', 'U') IS NOT NULL DROP TABLE #owt;

CREATE TABLE #owt
  (
     session_id       INT NOT NULL,
     wait_type        NVARCHAR(100) NOT NULL,
     wait_duration_ms BIGINT NOT NULL,
     rd               NVARCHAR(100) NOT NULL,
     database_num     INT NOT NULL,
     file_num         INT NOT NULL,
     page_num         INT NOT NULL,
     resource_type    NVARCHAR(100) NOT NULL
  );

INSERT INTO #owt
            (session_id,
             wait_type,
             wait_duration_ms,
             owt.rd,
             database_num,
             file_num,
             page_num,
             resource_type)
SELECT session_id,
       owt.wait_type,
       owt.wait_duration_ms,
       owt.rd,
       LEFT(owt.rd, owt.pos1 - 1)                                             AS
       database_num,
       Substring(owt.rd, owt.pos1 + 1, Len(owt.rd) - ( owt.pos1 + owt.pos2 )) AS
       file_num,
       RIGHT(owt.rd, owt.pos2 - 1)                                            AS
       page_num,
       CASE
         WHEN RIGHT(owt.rd, owt.pos2 - 1) - 1 % 8088 = 0 THEN 'Is PFS Page'
         WHEN RIGHT(owt.rd, owt.pos2 - 1) - 2 % 511232 = 0 THEN 'Is GAM Page'
         WHEN RIGHT(owt.rd, owt.pos2 - 1) - 3 % 511232 = 0 THEN 'Is SGAM Page'
         ELSE 'Is Not PFS, GAM, or SGAM page'
       END                                                                    AS
       resource_type
FROM   (SELECT owt.session_id,
               owt.wait_type,
               owt.wait_duration_ms,
               owt.blocking_session_id,
               owt.resource_description                          AS rd,
               Charindex(':', owt.resource_description)          AS pos1,
               Charindex(':', Reverse(owt.resource_description)) AS pos2,
               Len(owt.resource_description)                     AS ln
        FROM   sys.dm_os_waiting_tasks owt
        WHERE  owt.wait_type LIKE 'PAGELATCH%') owt

SELECT *
FROM   #owt

IF EXISTS(SELECT 1 FROM #owt)
  BEGIN
      SELECT owt.session_id,
             owt.wait_type,
             owt.wait_duration_ms,
             owt.rd,
             owt.resource_type,
             s.NAME + '.' + o.NAME AS table_name,
             i.NAME                AS index_name,
             obd.page_level,
             obd.row_count
      FROM   sys.dm_os_buffer_descriptors obd
             INNER JOIN #owt owt
                     ON obd.database_id = owt.database_num
                        AND obd.[file_id] = owt.file_num
                        AND obd.page_id = owt.page_num
             INNER JOIN sys.allocation_units au
                     ON obd.allocation_unit_id = au.allocation_unit_id
             INNER JOIN sys.partitions p
                     ON au.container_id = p.[partition_id]
             INNER JOIN sys.indexes i
                     ON p.index_id = i.index_id
                        AND p.[object_id] = i.[object_id]
             INNER JOIN sys.objects o
                     ON i.[object_id] = o.[object_id]
             INNER JOIN sys.schemas s
                     ON o.[schema_id] = s.[schema_id]
      OPTION(force ORDER)
  END;
