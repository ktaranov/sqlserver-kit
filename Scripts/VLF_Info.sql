/*
<documentation>
  <summary>Detailed information about VLF files.</summary>
  <returns>2 data sets: first with agregated vlf information and second with detailed info.</returns>
  <issues>No</issues>
  <author>Kev Riley</author>
  <created>2016-12-07</created>
  <modified>2019-06-25 by Konstantin Taranov</modified>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/VLF_Info.sql</sourceLink>
  <originalLink>https://gallery.technet.microsoft.com/scriptcenter/SQL-Script-to-list-VLF-e6315249</originalLink>
</documentation>
*/

SET NOCOUNT ON;

/* variables to hold each 'iteration' */
DECLARE @query  nvarchar(200);
DECLARE @dbname sysname;

/* table variable used to 'loop' over databases */
DECLARE @databases TABLE (dbname sysname);
/* only choose online databases */
INSERT INTO @databases
SELECT [name] FROM sys.databases WHERE [state] = 0;

DECLARE @majorVersion tinyint;
SET @majorVersion = LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),
                         CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1);


BEGIN
    DECLARE @DbccLogInfo TABLE(
        RecoveryUnitId int               NULL,
        fileid         smallint      NOT NULL,
        file_size      bigint        NOT NULL,
        start_offset   bigint        NOT NULL,
        fseqno         int           NOT NULL,
        [status]       tinyint       NOT NULL,
        parity         tinyint       NOT NULL,
        create_lsn     numeric(25,0) NOT NULL,
        DBName         sysname NULL,
        DBID           int     NULL
    );

    WHILE EXISTS(SELECT TOP(1) dbname FROM @databases)
    BEGIN

        SET @dbname = (SELECT TOP(1) dbname FROM @databases);
        SET @query = N'DBCC LOGINFO (N' + N'''' + @dbname + N''') WITH NO_INFOMSGS;';

        IF @majorVersion < 11 /* pre SQL 2012 versions */
        BEGIN
            INSERT INTO @DbccLogInfo(
                 fileid
               , file_size
               , start_offset
               , fseqno
               , [status]
               , parity
               , create_lsn
            )
            EXEC sp_executesql @query;
        END;
        ELSE
        BEGIN
            INSERT INTO @DbccLogInfo(
                 RecoveryUnitId
               , fileid
               , file_size
               , start_offset
               , fseqno
               , [status]
               , parity
               , create_lsn
            )
            EXEC sp_executesql @query;
        END;

        UPDATE @DbccLogInfo
        SET    DBName = @dbname
             , DBID  = DB_ID(@dbname)
        WHERE DBName IS NULL;

        DELETE FROM @databases WHERE dbname = @dbname;

    END; /* WHILE */
END;

/* output the full list */
WITH CTE_VLF AS (
    SELECT dc.DBID
         , dc.DBName
         , MIN(dc.file_size) / 1024 / 1024 AS FileSizeMbMIN
         , MAX(dc.file_size) / 1024 / 1024 AS FileSizeMbMAX
         , AVG(dc.file_size) / 1024 / 1024 AS FileSizeMbAVG
         , SUM(dc.file_size) / 1024 / 1024 AS FileSizeMbSUM
         , COUNT(dc.fileid)                AS VLFCount
     FROM  @DbccLogInfo AS dc
     GROUP BY dc.DBID
            , dc.DBName
)
SELECT   CTE_VLF.*
       , CASE WHEN VLFCount >= 1000 THEN 'Check your VLF count, maybee you nedd reduce'
              WHEN FileSizeMbAVG >= 500 THEN 'Check your VLF size, maybe you need decrease it'
              ELSE 'Maybee it is ok'
         END Warnings
FROM     CTE_VLF
ORDER BY VLFCount DESC;

SELECT * FROM @DbccLogInfo;
