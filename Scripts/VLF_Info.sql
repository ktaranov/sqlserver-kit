/*
https://gallery.technet.microsoft.com/scriptcenter/SQL-Script-to-list-VLF-e6315249
Kev Riley
*/

SET NOCOUNT ON;

/* variables to hold each 'iteration' */
DECLARE @query  nvarchar(200);
DECLARE @dbname sysname;
DECLARE @vlfs   bigint;

/* table variable used to 'loop' over databases */
DECLARE @databases TABLE (dbname sysname);
/* only choose online databases */
INSERT INTO @databases
SELECT [name] FROM sys.databases WHERE [state] = 0;

/* table variable to hold results */
declare @vlfcounts table(
    dbname   sysname
  , vlfcount int);

--table variable to capture DBCC loginfo output
--changes in the output of DBCC loginfo from SQL2012 mean we have to determine the version

DECLARE @majorVersion tinyint;
SET @majorVersion = LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),
                         CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max))) - 1);

/* pre-SQL2012 */
IF @majorVersion < 11
BEGIN

    DECLARE @dbccloginfo table(
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

        SET @dbname = (select top 1 dbname from @databases);
        SET @query = N'DBCC LOGINFO (N' + N'''' + @dbname + N''');';

        INSERT INTO @dbccloginfo(
             fileid
           , file_size
           , start_offset
           , fseqno
           , [status]
           , parity
           , create_lsn
        )
        EXEC sp_executesql @query;
        SET @vlfs = @@rowcount;

        UPDATE @dbccloginfo
        SET    DBName = @dbname
             , DBID  = DB_ID(@dbname)
        WHERE DBName IS NULL;

        INSERT @vlfcounts(dbname, vlfcount) VALUES(@dbname, @vlfs);

        DELETE FROM @databases WHERE dbname = @dbname;

    END; /* WHILE */
END;
ELSE
BEGIN
    DECLARE @dbccloginfo2012 table(
        RecoveryUnitId int           NOT NULL,
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

        INSERT INTO @dbccloginfo2012(
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
        SET @vlfs = @@rowcount;

        UPDATE @dbccloginfo2012
        SET    DBName = @dbname
             , DBID  = DB_ID(@dbname)
        WHERE DBName IS NULL;

        INSERT @vlfcounts(dbname, vlfcount) VALUES(@dbname, @vlfs);

        DELETE FROM @databases WHERE dbname = @dbname;

    END; /* WHILE */
END;

/* output the full list */
SELECT dbname, vlfcount
FROM   @vlfcounts
ORDER BY vlfcount DESC;

SELECT * FROM @dbccloginfo2012;
