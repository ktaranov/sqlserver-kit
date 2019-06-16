/*
Author: David Stein
Original link: http://www.made2mentor.com/2019/06/generating-biml-scripts-using-t-sql/
*/

DECLARE @SrcQuery nvarchar(4000);
DECLARE @FeedName nvarchar(25);


SELECT @SrcQuery = 'SELECT TOP(100) FROM sys.objects;', @FeedName = 'Objects';
 
IF OBJECT_ID('tempdb..#FileFormatMetadata') IS NOT NULL DROP TABLE #FileFormatMetadata;
 
SELECT
 t.[Column Name]
,t.[SQL DT]
,CASE
WHEN t.[SQL DT] in ('char', 'varchar','text') THEN (t.max_length)
WHEN t.[SQL DT] in ('nchar', 'nvarchar','ntext') THEN (t.max_length/2)
ELSE 0 END [Length]
,CASE
WHEN t.[SQL DT] = 'smallint' THEN 'Int16'
WHEN t.[SQL DT] = 'tinyint' THEN 'Byte'
WHEN t.[SQL DT] = 'int' THEN 'Int32'
WHEN t.[SQL DT] = 'bigint' THEN 'Int64'
WHEN t.[SQL DT] = 'char' THEN 'AnsiStringFixedLength'
WHEN t.[SQL DT] = 'varchar' THEN 'AnsiString'
WHEN t.[SQL DT] = 'nchar' THEN 'StringFixedLength'
WHEN t.[SQL DT] = 'nvarchar' THEN 'String'
WHEN t.[SQL DT] = 'date' THEN 'Date'
WHEN t.[SQL DT] = 'datetime' THEN 'DateTime'
WHEN t.[SQL DT] = 'datetime2' THEN 'DateTime2'
WHEN t.[SQL DT] = 'datetimeoffset' THEN 'DateTimeOffset'
WHEN t.[SQL DT] = 'smalldatetime' THEN 'DateTime'
WHEN t.[SQL DT] = 'time' THEN 'Time'
WHEN t.[SQL DT] = 'decimal' THEN 'Decimal'
WHEN t.[SQL DT] = 'numeric' THEN 'Decimal'
WHEN t.[SQL DT] = 'bit' THEN 'Boolean'
WHEN t.[SQL DT] = 'float' THEN 'Double'
WHEN t.[SQL DT] = 'real' THEN 'Single'
WHEN t.[SQL DT] = 'money' THEN 'Currency'
WHEN t.[SQL DT] = 'smallmoney' THEN 'Currency'
WHEN t.[SQL DT] = 'text' THEN 'AnsiString'
WHEN t.[SQL DT] = 'ntext' THEN 'String'
ELSE NULL END [Biml Data Type]
,t.ColumnOrdinal
,@FeedName FeedName
INTO #FileFormatMetadata 
FROM (SELECT name [Column Name]
 ,CASE WHEN CHARINDEX('(',system_type_name) = 0 THEN system_type_name
  ELSE left(system_type_name, CHARINDEX('(',system_type_name) - 1)
  END [SQL DT]
 ,max_length
 ,column_ordinal ColumnOrdinal
   FROM sys.dm_exec_describe_first_result_set(@SrcQuery, NULL, 1) where [name] is not NULL  and is_hidden = 0) t
 
SELECT CAST(REPLACE(CAST( (
   SELECT
   (SELECT 'conn_ff_' + @FeedName "@Name"
    ,'C:\FileExport\' + @FeedName + '.csv' "@FilePath"
    ,'fff_' + @FeedName "@FileFormat"
    FOR XML PATH('FlatFileConnection'), type, root('Connections'))
    ,(SELECT 'Export ' + @FeedName "@Name"
    , 'Linear' "@ConstraintMode"
    ,'DontSaveSensitive' "@ProtectionLevel"
        ,(SELECT    
        'DFT Load File' "@Name"
        ,'OLE_SRC ' + @FeedName "Transformations/OleDbSourceName/@Name"
        ,'connNorthwind' "Transformations/OleDbSourceName/@ConnectionName"
        ,@SrcQuery "Transformations/OleDbSourceName/DirectInput"
        ,'FF_DEST ' + @FeedName "Transformations/FlatFileDestination/@Name"
        ,'conn_ff_ ' + @FeedName "Transformations/FlatFileDestination/@ConnectionName"
        ,'true'  "Transformations/FlatFileDestination/@Overwrite"
        ,'false'  "Transformations/FlatFileDestination/@ValidateExternalMetadata"
        FOR XML PATH('Dataflow'),TYPE, root('Tasks'))
    FOR XML PATH('Package'), TYPE,ROOT('Packages'))
    ,(SELECT 'fff_' + @FeedName "@Name"
    , 'Delmited' "@FlatFileType"
    ,'true' "@ColumnNamesInFirstDataRow"
    ,'_x0022_' "@TextQualifier"
        ,(SELECT [Column Name] "@Name"
        ,[Biml Data Type] "@DataType"
        ,Length "@Length"
        ,CASE WHEN ColumnOrdinal = (SELECT MAX(ColumnOrdinal) FROM #FileFormatMetadata) THEN 'CRLF'
        ELSE 'Comma' END "@Delimiter" 
        from #FileFormatMetadata
        FOR XML PATH('Column'), type, root('Columns'))
    FOR XML PATH('FlatFileFormat'), type, root('FileFormats'))
FOR XML PATH ('Biml')
) AS nvarchar(MAX)), '<Biml>', '<Biml xmlns="http://schemas.varigence.com/biml.xsd">') AS XML);
