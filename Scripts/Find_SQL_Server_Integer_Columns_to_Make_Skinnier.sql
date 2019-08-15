/*
<documentation>
  <summary>Find SQL Server Integer Columns to Make Skinnier</summary>
  <returns>1 data set: temp table #errlog.</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-07-25</created>
  <modified>2019-08-15 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Find_SQL_Server_Integer_Columns_to_Make_Skinnier.sql</sourceLink>
  <originalLink>https://www.mssqltips.com/sqlservertip/6107/find-sql-server-integer-columns-to-make-skinnier/</originalLink>
</documentation>
*/

SET NOCOUNT ON;

IF OBJECT_ID(N'dbo.floob', 'U') IS NOT NULL DROP TABLE dbo.floob;
IF OBJECT_ID(N'dbo.mort', 'U')  IS NOT NULL DROP TABLE dbo.mort;

CREATE TABLE dbo.floob(x bigint, y int, z smallint);
INSERT dbo.floob(x,y,z) VALUES(1,1,1),(32766,32766,254);
CREATE TABLE dbo.mort(a int, b tinyint);
INSERT dbo.mort(a,b) VALUES(1,1),(32768,254);	

IF OBJECT_ID(N'tempdb..#cols', 'U') IS NOT NULL DROP TABLE #cols;

DECLARE @src bigint = 2;
;WITH types AS 
(
  SELECT * FROM 
  (VALUES
    (1,0,1, 104, N'bit',      1, 0, 1),
    (2,1,1, 48,  N'tinyint',  1, 0, 255),
    (3,1,1, 52,  N'smallint', 2, -(POWER(@src,15)),       (POWER(@src,15)-1)),
    (4,1,1, 56,  N'int',      4, -(POWER(@src,31)),       (POWER(@src,31)-1)),
    (5,1,0, 127, N'bigint',   8, -(POWER(@src,62)-1)*2-2, (POWER(@src,62)-1)*2+1)
  ) AS v(seq,src,trg,type_id,[type],bytes,minval,maxval)
),
cols AS
(
  SELECT t.[object_id],
         [schema] = s.name,
         [table]  = t.name,
         [column] = QUOTENAME(c.name), 
         [type]   = styp.name + COALESCE(' (alias: ' + utyp.name + ')', ''),
         c.is_nullable,
         trgtyp.seq,
         trgtyp.type_id,
         trgtype = trgtyp.[type],
         savings = srctyp.bytes - trgtyp.bytes,
         trgtyp.minval,
         trgtyp.maxval,
         [rowcount] = (SELECT SUM([rows]) FROM sys.partitions
           WHERE object_id = t.object_id AND index_id IN (0,1))
  FROM sys.tables AS t
  INNER JOIN sys.schemas AS s
  ON s.[schema_id] = t.[schema_id]
  INNER JOIN sys.columns AS c
  ON t.[object_id] = c.[object_id]
  INNER JOIN sys.types AS styp
  ON c.system_type_id = styp.system_type_id
  AND c.system_type_id = styp.user_type_id
  LEFT OUTER JOIN sys.types AS utyp
  ON c.user_type_id = utyp.user_type_id
  AND utyp.user_type_id <> utyp.system_type_id
  INNER JOIN types AS srctyp
  ON srctyp.type_id = c.system_type_id
  INNER JOIN types AS trgtyp
  ON trgtyp.seq < srctyp.seq
  WHERE srctyp.src = 1
  AND trgtyp.trg = 1
)
SELECT * INTO #cols FROM cols;

DECLARE @sql nvarchar(max) = N';WITH x([object_id], [column], minval, maxval)
AS (',
        @core nvarchar(max) = N'
    SELECT $oid, ''$c'', MIN($c), MAX($c) FROM $obj UNION ALL';
SELECT @sql += REPLACE(REPLACE(REPLACE(@core, '$oid', RTRIM(object_id)),
  '$c',[column]),'$obj',QUOTENAME([schema]) + '.' + QUOTENAME([table]))
  FROM (SELECT [schema],[table],[column],object_id FROM #cols
  GROUP BY [schema],[table],[column],object_id) AS x;
SET @sql += N'
    SELECT NULL,NULL,NULL,NULL
  ) 
  SELECT c.[schema], c.[table], c.[column], c.is_nullable,
    current_type = c.[type], potential_type = c.trgtype,
    space_savings = c.savings * c.[rowcount], x.minval, x.maxval,
    range = RTRIM(c.minval) + '' -> '' + RTRIM(c.maxval) 
  FROM x
  INNER JOIN #cols AS c 
  ON x.[object_id] = c.[object_id]
  AND x.[column] = c.[column]
  AND x.minval >= c.minval
  AND x.maxval <= c.maxval;';

--PRINT(@sql);

DECLARE @xml xml = (SELECT @sql FOR XML path(''));
SET @sql = 
  REPLACE(REPLACE(REPLACE(REPLACE(CONVERT(nvarchar(MAX), @xml, 1), '&#x0D;', CHAR(13)), '&gt;', '>'), '&lt;', '<'), '&amp;', '&');
/* Enable in SSMS option Tools->Options->Query Results->SQL Server->Results to Grid->Return CR/LF on copy or save */
SELECT @sql AS SQL_Print;

EXEC sys.sp_executesql @sql;
