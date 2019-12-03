/*
<documentation>
  <summary>Get table column min, max and other parameters</summary>
  <returns>1 data set</returns>
  <issues>No</issues>
  <author>Konstantin Taranov</author>
  <created>2019-11-20</created>
  <modified>2019-11-30 by Konstantin Taranov</modified>
  <version>1.2</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Get_Coulmn_Statistics_By_Name.sql</sourceLink>
</documentation>
*/

DECLARE @columnName sysname       = N'ModifiedDate';
DECLARE @tsql       nvarchar(max) = N'';
DECLARE @sep        nvarchar(50)  = N' UNION ALL ';
DECLARE @crlf       nvarchar(10)  = CHAR(13) + CHAR(10);
DECLARE @debug      bit           = 0;
DECLARE @errMsg     nvarchar(900) = N'In using database "' + DB_NAME() +
                                    '" no tables with colum name equal "' +  @columnName +
                                    '". Choose another database or fix @columnName variable.';


IF NOT EXISTS (SELECT 1 FROM sys.all_columns WHERE "name" = @columnName)
BEGIN
    PRINT(@errMsg);
END
ELSE
BEGIN
    SELECT     -- TOP(2)
               @tsql = @tsql + N'SELECT MAX(_C_) AS _C_Max, MIN(_C_) _C_Min, COUNT(_C_) AS _C_Count, ''' +
               SCHEMA_NAME(o.schema_id) + ''' AS SchemaName,''' +
               OBJECT_NAME(allc.object_id) + ''' AS TableName' +
               ' FROM ' +
               SCHEMA_NAME(o.schema_id) + '.' + OBJECT_NAME(allc.object_id) +
               @crlf + @sep
    FROM       sys.all_columns AS allc
    INNER JOIN sys.objects     AS o
            ON allc.object_id = o.object_id
    WHERE      allc."name" = 'ModifiedDate';

    SET @tsql = REPLACE(@tsql, N'_C_', @columnName);
    SET @tsql = LEFT(@tsql, (DATALENGTH(@tsql) - DATALENGTH(@sep)) / 2) + ' ORDER BY 1 DESC';

    IF @debug = 1
    SELECT @tsql;
    ELSE
    EXEC sp_executesql @tsql;
END;
