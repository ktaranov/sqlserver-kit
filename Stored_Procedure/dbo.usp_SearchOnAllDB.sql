IF Object_id('dbo.usp_SearchOnAllDB', 'P') IS NULL
  EXECUTE ('CREATE PROCEDURE dbo.usp_SearchOnAllDB AS SELECT 1');
GO

ALTER PROCEDURE dbo.usp_SearchOnAllDB(@phrase         VARCHAR(8000),
                                     @OutFullRecords BIT = 0)
AS
    /*
       To apply so:
          exec  sp_SearchOnAllDB 'Arme%'
          exec  sp_SearchOnAllDB '%soft%'
          exec  sp_SearchOnAllDB '_5234_57%', 1
          exec  sp_SearchOnAllDB M_cro_oft
    */
    DECLARE @sql NVARCHAR(max);
    DECLARE @schema SYSNAME;
    DECLARE @tbl SYSNAME;
    DECLARE @col SYSNAME;
    DECLARE @id_present BIT
    DECLARE @is_char_phrase BIT
    DECLARE @min_len INT
    DECLARE @loop_idx INT
    DECLARE @loop_chr CHAR(1)

    SET nocount ON

    IF Isnull(@phrase, '') = ''
      BEGIN
          RAISERROR('Phrase is absent',16,-1)

          RETURN
      END

    -- Handle Quotes passed in the search string
    SET @phrase = Replace(@phrase, '''', '''''')

    SELECT @loop_idx = 1,
           @is_char_phrase = 0,
           @min_len = 0

    WHILE @loop_idx <= Len(@phrase)
      BEGIN
          SET @loop_chr = Substring(@phrase, @loop_idx, 1)

          IF @loop_chr NOT IN ( '%', '_' )
            SET @min_len = @min_len + 1

          IF @is_char_phrase = 0
             AND @loop_chr NOT IN ( '%', '_', '0', '1',
                                    '2', '3', '4', '5',
                                    '6', '7', '8', '9', '.' )
            SET @is_char_phrase = 1

          SET @loop_idx = @loop_idx + 1
      END

    CREATE TABLE #tbl_res
      (
         SchemaName  SYSNAME NOT NULL,
         TableName   SYSNAME NOT NULL,
         ColumnName  SYSNAME NOT NULL,
         Id          INT NULL,
         ColumnValue NVARCHAR(max) NOT NULL
      );

    CREATE TABLE #tbl_res2
      (
         SchemaName  SYSNAME NOT NULL,
         TableName   SYSNAME NOT NULL,
         ColumnName  SYSNAME NOT NULL,
         Id          INT NULL,
         ColumnValue NVARCHAR(max) NOT NULL
      );

    DECLARE crr CURSOR local fast_forward FOR
      SELECT s.NAME AS SchemaName,
             t.NAME AS TableName,
             c.NAME AS ColumnName,
             1      AS id_present
      FROM   sys.objects t
             INNER JOIN sys.syscolumns c
                     ON c.id = t.object_id
             INNER JOIN sys.schemas AS s
                     ON t.schema_id = s.schema_id
      WHERE  t.type = 'U'
             AND c.status&0x80 = 0 -- Not IDENTITY
             AND EXISTS (SELECT *
                         FROM   syscolumns c2
                         WHERE  t.object_id = c2.id
                                AND c2.status&0x80 = 0x80
                                AND c2.xtype IN ( 48, 52, 56 ))
             AND ( ( @is_char_phrase = 1
                     AND c.xtype IN ( 175, 239, 99, 231,
                                      35, 167 )
                     AND c.length >= @min_len ) -- char only
                    OR ( @is_char_phrase = 0
                         AND c.xtype NOT IN ( 34, 165, 173, 189,
                                              61, 58, 36 ) ) )
      -- char and numeric
      UNION
      SELECT s.name,
             t.name,
             c.name,
             0
      FROM   sys.objects t
             INNER JOIN sys.syscolumns c
                     ON c.id = t.object_id
             INNER JOIN sys.schemas AS s
                     ON t.schema_id = s.schema_id
      WHERE  t.type = 'U'
             AND NOT EXISTS (SELECT *
                             FROM   syscolumns c2
                             WHERE  t.object_id = c2.id
                                    AND c2.status&0x80 = 0x80
                                    AND c2.xtype IN ( 48, 52, 56 ))
             AND ( ( @is_char_phrase = 1
                     AND c.xtype IN ( 175, 239, 99, 231,
                                      35, 167 )
                     AND c.length >= @min_len ) -- char only
                    OR ( @is_char_phrase = 0
                         AND c.xtype NOT IN ( 34, 165, 173, 189,
                                              61, 58, 36 ) ) )
      -- char and numeric
      ORDER  BY 1,
                2;

    OPEN crr
    FETCH crr INTO @schema, @tbl, @col, @id_present
    WHILE @@FETCH_STATUS = 0
      BEGIN
          IF @OutFullRecords = 0
            BEGIN
                SET @sql =
    'insert into #tbl_res (SchemaName, TableName, ColumnName, Id, ColumnValue) '
    + 'select ''[' + @schema + ']'', ''[' + @tbl
    + ']'', ''[' + @col + ']'', '

    IF @id_present = 1
      SET @sql = @sql + 'IDENTITYCOL, '
    ELSE
      SET @sql = @sql + 'NULL, '

    SET @sql = @sql + 'convert(NVARCHAR(MAX), [' + @col + ']) '
               + 'from [' + @schema + '].[' + @tbl + '] (nolock) '
               + 'where convert(varchar(8000), [' + @col
               + ']) like ''' + @phrase + ''' '
    END

    IF @OutFullRecords = 1
      BEGIN
          SET @sql = 'if exists (select * from [' + @tbl
                     + '] (nolock) '
                     + 'where convert(varchar(8000), [' + @col
                     + ']) like ''' + @phrase + ''') ' + 'select ''['
                     + @tbl + ']'' TableName, ''[' + @col
                     + ']'' ColumnName, * ' + 'from [' + @tbl
                     + '] (nolock) where convert(varchar(8000), ['
                     + @col + ']) like ''' + @phrase + ''';'
      END
    EXEC(@sql);

    FETCH crr INTO @schema, @tbl, @col, @id_present;
    END

    CLOSE crr;
    DEALLOCATE crr;

    IF @OutFullRecords = 0
      BEGIN
          INSERT #tbl_res2
          SELECT SchemaName,
                 TableName,
                 ColumnName,
                 Id,
                 CONVERT(VARCHAR(255), ColumnValue) ColumnValue
          FROM   #tbl_res;
      END
    SELECT SchemaName,
           TableName,
           ColumnName,
           ColumnValue
    FROM   #tbl_res2
    GROUP  BY SchemaName,
              TableName,
              ColumnName,
              ColumnValue
    ORDER  BY SchemaName,
              TableName;
GO 