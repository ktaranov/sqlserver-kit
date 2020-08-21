-- Script Name: Recover_Deleted_Data_Proc
-- Script Type : Recovery Procedure 
-- Develop By: Muhammad Imran
-- Date Created: 15 Oct 2011
-- Modify Date: 22 Aug 2012
-- Version    : 3.1
-- Notes : Included BLOB data types for recovery.& Compatibile with Default , CS collation , Arabic_CI_AS.
 
--DROP PROCEDURE Recover_Deleted_Data_Proc
--GO
Create PROCEDURE Recover_Deleted_Data_Proc
@Database_Name NVARCHAR(MAX),
@SchemaName_n_TableName NVARCHAR(Max),
@Date_From DATETIME='1900/01/01',
@Date_To DATETIME ='9999/12/31'
AS
 
DECLARE @RowLogContents VARBINARY(8000)
DECLARE @TransactionID NVARCHAR(Max)
DECLARE @AllocUnitID BIGINT
DECLARE @AllocUnitName NVARCHAR(Max)
DECLARE @SQL NVARCHAR(Max)
DECLARE @Compatibility_Level INT
 
 
SELECT @Compatibility_Level=dtb.compatibility_level
FROM
master.sys.databases AS dtb WHERE dtb.name=@Database_Name
 
IF ISNULL(@Compatibility_Level,0)<=80
BEGIN
    RAISERROR('The compatibility level should be equal to or greater SQL SERVER 2005 (90)',16,1)
    RETURN
END
 
IF (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE [TABLE_SCHEMA]+'.'+[TABLE_NAME]=@SchemaName_n_TableName)=0
BEGIN
    RAISERROR('Could not found the table in the defined database',16,1)
    RETURN
END
 
DECLARE @bitTable TABLE
(
  [ID] INT,
  [Bitvalue] INT
)
--Create table to set the bit position of one byte.
 
INSERT INTO @bitTable
SELECT 0,2 UNION ALL
SELECT 1,2 UNION ALL
SELECT 2,4 UNION ALL
SELECT 3,8 UNION ALL
SELECT 4,16 UNION ALL
SELECT 5,32 UNION ALL
SELECT 6,64 UNION ALL
SELECT 7,128
 
--Create table to collect the row data.
DECLARE @DeletedRecords TABLE
(
    [Row ID]            INT IDENTITY(1,1),
    [RowLogContents]    VARBINARY(8000),
    [AllocUnitID]       BIGINT,
    [Transaction ID]    NVARCHAR(Max),
    [FixedLengthData]   SMALLINT,
    [TotalNoOfCols]     SMALLINT,
    [NullBitMapLength]  SMALLINT,
    [NullBytes]         VARBINARY(8000),
    [TotalNoofVarCols]  SMALLINT,
    [ColumnOffsetArray] VARBINARY(8000),
    [VarColumnStart]    SMALLINT,
    [Slot ID]           INT,
    [NullBitMap]        VARCHAR(MAX)
     
)
--Create a common table expression to get all the row data plus how many bytes we have for each row.
;WITH RowData AS (
SELECT
 
[RowLog Contents 0] AS [RowLogContents] 
 
,[AllocUnitID] AS [AllocUnitID] 
 
,[Transaction ID] AS [Transaction ID]  
 
--[Fixed Length Data] = Substring (RowLog content 0, Status Bit A+ Status Bit B + 1,2 bytes)
,CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) AS [FixedLengthData]  --@FixedLengthData
 
-- [TotalnoOfCols] =  Substring (RowLog content 0, [Fixed Length Data] + 1,2 bytes)
,CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2)))) as  [TotalNoOfCols]
 
--[NullBitMapLength]=ceiling([Total No of Columns] /8.0)
,CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)) as [NullBitMapLength] 
 
--[Null Bytes] = Substring (RowLog content 0, Status Bit A+ Status Bit B + [Fixed Length Data] +1, [NullBitMapLength] )
,SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 3,
CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0))) as [NullBytes]
 
--[TotalNoofVarCols] = Substring (RowLog content 0, Status Bit A+ Status Bit B + [Fixed Length Data] +1, [Null Bitmap length] + 2 )
,(CASE WHEN SUBSTRING([RowLog Contents 0], 1, 1) In (0x10,0x30,0x70) THEN
CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0],
CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 3
+ CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)), 2))))  ELSE null  END) AS [TotalNoofVarCols] 
 
--[ColumnOffsetArray]= Substring (RowLog content 0, Status Bit A+ Status Bit B + [Fixed Length Data] +1, [Null Bitmap length] + 2 , [TotalNoofVarCols]*2 )
,(CASE WHEN SUBSTRING([RowLog Contents 0], 1, 1) In (0x10,0x30,0x70) THEN
SUBSTRING([RowLog Contents 0]
, CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 3
+ CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)) + 2
, (CASE WHEN SUBSTRING([RowLog Contents 0], 1, 1) In (0x10,0x30,0x70) THEN
CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0],
CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 3
+ CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)), 2))))  ELSE null  END)
* 2)  ELSE null  END) AS [ColumnOffsetArray] 
 
--  Variable column Start = Status Bit A+ Status Bit B + [Fixed Length Data] + [Null Bitmap length] + 2+([TotalNoofVarCols]*2)
,CASE WHEN SUBSTRING([RowLog Contents 0], 1, 1)In (0x10,0x30,0x70)
THEN  (
CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 4 
 
+ CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)) 
 
+ ((CASE WHEN SUBSTRING([RowLog Contents 0], 1, 1) In (0x10,0x30,0x70) THEN
CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0],
CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 3
+ CONVERT(INT, ceiling(CONVERT(INT, CONVERT(BINARY(2), REVERSE(SUBSTRING([RowLog Contents 0], CONVERT(SMALLINT, CONVERT(BINARY(2)
,REVERSE(SUBSTRING([RowLog Contents 0], 2 + 1, 2)))) + 1, 2))))/8.0)), 2))))  ELSE null  END) * 2)) 
 
ELSE null End AS [VarColumnStart]
,[Slot ID]
FROM sys.fn_dblog(NULL, NULL)
WHERE
AllocUnitId IN
(SELECT [Allocation_unit_id] FROM sys.allocation_units allocunits
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3)  
AND partitions.hobt_id = allocunits.container_id) OR (allocunits.type = 2 
AND partitions.partition_id = allocunits.container_id)  
WHERE object_id=object_ID('' + @SchemaName_n_TableName + ''))
 
AND Context IN ('LCX_MARK_AS_GHOST', 'LCX_HEAP') AND Operation in ('LOP_DELETE_ROWS') 
And SUBSTRING([RowLog Contents 0], 1, 1)In (0x10,0x30,0x70)
 
/*Use this subquery to filter the date*/
AND [TRANSACTION ID] IN (SELECT DISTINCT [TRANSACTION ID] FROM    sys.fn_dblog(NULL, NULL) 
WHERE Context IN ('LCX_NULL') AND Operation in ('LOP_BEGIN_XACT')  
And [Transaction Name] In ('DELETE','user_transaction')
And  CONVERT(NVARCHAR(11),[Begin Time]) BETWEEN @Date_From AND @Date_To)),
 
--Use this technique to repeate the row till the no of bytes of the row.
N1 (n) AS (SELECT 1 UNION ALL SELECT 1),
N2 (n) AS (SELECT 1 FROM N1 AS X, N1 AS Y),
N3 (n) AS (SELECT 1 FROM N2 AS X, N2 AS Y),
N4 (n) AS (SELECT ROW_NUMBER() OVER(ORDER BY X.n)
           FROM N3 AS X, N3 AS Y)
 
 
 
INSERT INTO @DeletedRecords
SELECT  RowLogContents
        ,[AllocUnitID]
        ,[Transaction ID]
        ,[FixedLengthData]
        ,[TotalNoOfCols]
        ,[NullBitMapLength]
        ,[NullBytes]
        ,[TotalNoofVarCols]
        ,[ColumnOffsetArray]
        ,[VarColumnStart]
        ,[Slot ID]
         ---Get the Null value against each column (1 means null zero means not null)
        ,[NullBitMap]=(REPLACE(STUFF((SELECT ',' +
        (CASE WHEN [ID]=0 THEN CONVERT(NVARCHAR(1),(SUBSTRING(NullBytes, n, 1) % 2))  ELSE CONVERT(NVARCHAR(1),((SUBSTRING(NullBytes, n, 1) / [Bitvalue]) % 2)) END) --as [nullBitMap]
         
FROM
N4 AS Nums
Join RowData AS C ON n<=NullBitMapLength
Cross Join @bitTable WHERE C.[RowLogContents]=D.[RowLogContents] ORDER BY [RowLogContents],n ASC FOR XML PATH('')),1,1,''),',',''))
FROM RowData D
 
IF (SELECT COUNT(*) FROM @DeletedRecords)=0
BEGIN
    RAISERROR('There is no data in the log as per the search criteria',16,1)
    RETURN
END
 
DECLARE @ColumnNameAndData TABLE
(
 [Row ID]           int,
 [Rowlogcontents]   varbinary(Max),
 [NAME]             sysname,
 [nullbit]          smallint,
 [leaf_offset]      smallint,
 [length]           smallint,
 [system_type_id]   tinyint,
 [bitpos]           tinyint,
 [xprec]            tinyint,
 [xscale]           tinyint,
 [is_null]          int,
 [Column value Size]int,
 [Column Length]    int,
 [hex_Value]        varbinary(max),
 [Slot ID]          int,
 [Update]           int
)
 
--Create common table expression and join it with the rowdata table
-- to get each column details
/*This part is for variable data columns*/
--@RowLogContents, 
--(col.columnOffValue - col.columnLength) + 1,
--col.columnLength
--)
INSERT INTO @ColumnNameAndData
SELECT
[Row ID],
Rowlogcontents,
NAME ,
cols.leaf_null_bit AS nullbit,
leaf_offset,
ISNULL(syscolumns.length, cols.max_length) AS [length],
cols.system_type_id,
cols.leaf_bit_position AS bitpos,
ISNULL(syscolumns.xprec, cols.precision) AS xprec,
ISNULL(syscolumns.xscale, cols.scale) AS xscale,
SUBSTRING([nullBitMap], cols.leaf_null_bit, 1) AS is_null,
(CASE WHEN leaf_offset<1 and SUBSTRING([nullBitMap], cols.leaf_null_bit, 1)=0 
THEN
(Case When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000
THEN
CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) - POWER(2, 15)
ELSE
CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
END)
END)  AS [Column value Size],
 
(CASE WHEN leaf_offset<1 and SUBSTRING([nullBitMap], cols.leaf_null_bit, 1)=0  THEN
(Case
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
THEN  (Case When [System_type_id]In (35,34,99) Then 16 else 24  end)
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
THEN  (Case When [System_type_id]In (35,34,99) Then 16 else 24  end) --24 
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
THEN (CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart]))
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
 
THEN POWER(2, 15) +CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])
 
END)
 
END) AS [Column Length]
 
,(CASE WHEN SUBSTRING([nullBitMap], cols.leaf_null_bit, 1)=1 THEN  NULL ELSE
 SUBSTRING
 (
 Rowlogcontents, 
 (
 
(Case When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000
THEN
CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) - POWER(2, 15)
ELSE
CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
END)
 
 - 
(Case When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
 
THEN  (Case When [System_type_id]In (35,34,99) Then 16 else 24  end) --24 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
 
THEN  (Case When [System_type_id]In (35,34,99) Then 16 else 24  end) --24 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
 
THEN CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
 
THEN POWER(2, 15) +CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])
 
END)
 
) + 1,
(Case When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
 
THEN  (Case When [System_type_id] In (35,34,99) Then 16 else 24  end) --24 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) >30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
 
THEN  (Case When [System_type_id] In (35,34,99) Then 16 else 24  end) --24 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])<30000
 
THEN ABS(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart]))
 
When CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2)))) <30000 And
ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])>30000
 
THEN POWER(2, 15) +CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * leaf_offset*-1) - 1, 2))))
- ISNULL(NULLIF(CONVERT(INT, CONVERT(BINARY(2), REVERSE (SUBSTRING ([ColumnOffsetArray], (2 * ((leaf_offset*-1) - 1)) - 1, 2)))), 0), [varColumnStart])
 
END)
)
 
END) AS hex_Value
,[Slot ID]
,0
FROM @DeletedRecords A
Inner Join sys.allocation_units allocunits On A.[AllocUnitId]=allocunits.[Allocation_Unit_Id]
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3)
AND partitions.hobt_id = allocunits.container_id) OR (allocunits.type = 2 AND partitions.partition_id = allocunits.container_id)
INNER JOIN sys.system_internals_partition_columns cols ON cols.partition_id = partitions.partition_id
LEFT OUTER JOIN syscolumns ON syscolumns.id = partitions.object_id AND syscolumns.colid = cols.partition_column_id
WHERE leaf_offset<0
UNION
/*This part is for fixed data columns*/
SELECT 
[Row ID],
Rowlogcontents,
NAME ,
cols.leaf_null_bit AS nullbit,
leaf_offset,
ISNULL(syscolumns.length, cols.max_length) AS [length],
cols.system_type_id,
cols.leaf_bit_position AS bitpos,
ISNULL(syscolumns.xprec, cols.precision) AS xprec,
ISNULL(syscolumns.xscale, cols.scale) AS xscale,
SUBSTRING([nullBitMap], cols.leaf_null_bit, 1) AS is_null,
(SELECT TOP 1 ISNULL(SUM(CASE WHEN C.leaf_offset >1 THEN max_length ELSE 0 END),0) FROM
sys.system_internals_partition_columns C WHERE cols.partition_id =C.partition_id And C.leaf_null_bit<cols.leaf_null_bit)+5 AS [Column value Size],
syscolumns.length AS [Column Length]
 
,CASE WHEN SUBSTRING([nullBitMap], cols.leaf_null_bit, 1)=1 THEN NULL ELSE
SUBSTRING
(
Rowlogcontents,(SELECT TOP 1 ISNULL(SUM(CASE WHEN C.leaf_offset >1 And C.leaf_bit_position=0 THEN max_length ELSE 0 END),0) FROM
sys.system_internals_partition_columns C where cols.partition_id =C.partition_id And C.leaf_null_bit<cols.leaf_null_bit)+5
,syscolumns.length) END AS hex_Value
,[Slot ID]
,0
FROM @DeletedRecords A
Inner Join sys.allocation_units allocunits ON A.[AllocUnitId]=allocunits.[Allocation_Unit_Id]
INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3)
AND partitions.hobt_id = allocunits.container_id) OR (allocunits.type = 2 AND partitions.partition_id = allocunits.container_id)
INNER JOIN sys.system_internals_partition_columns cols ON cols.partition_id = partitions.partition_id
LEFT OUTER JOIN syscolumns ON syscolumns.id = partitions.object_id AND syscolumns.colid = cols.partition_column_id
WHERE leaf_offset>0
Order By nullbit
 
Declare @BitColumnByte as int
Select @BitColumnByte=CONVERT(INT, ceiling( Count(*)/8.0)) from @ColumnNameAndData Where [System_Type_id]=104
 
;With N1 (n) AS (SELECT 1 UNION ALL SELECT 1),
N2 (n) AS (SELECT 1 FROM N1 AS X, N1 AS Y),
N3 (n) AS (SELECT 1 FROM N2 AS X, N2 AS Y),
N4 (n) AS (SELECT ROW_NUMBER() OVER(ORDER BY X.n)
           FROM N3 AS X, N3 AS Y),
CTE As(
Select RowLogContents,[nullbit]
        ,[BitMap]=Convert(varbinary(1),Convert(int,Substring((REPLACE(STUFF((SELECT ',' +
        (CASE WHEN [ID]=0 THEN CONVERT(NVARCHAR(1),(SUBSTRING(hex_Value, n, 1) % 2))  ELSE CONVERT(NVARCHAR(1),((SUBSTRING(hex_Value, n, 1) / [Bitvalue]) % 2)) END) --as [nullBitMap]
 
from N4 AS Nums
Join @ColumnNameAndData AS C ON n<=@BitColumnByte And [System_Type_id]=104 And bitpos=0
Cross Join @bitTable WHERE C.[RowLogContents]=D.[RowLogContents] ORDER BY [RowLogContents],n ASC FOR XML PATH('')),1,1,''),',','')),bitpos+1,1)))
FROM @ColumnNameAndData D Where  [System_Type_id]=104)
 
Update A Set [hex_Value]=[BitMap]
from @ColumnNameAndData  A
Inner Join CTE B On A.[RowLogContents]=B.[RowLogContents]
And A.[nullbit]=B.[nullbit]
 
 
/**************Check for BLOB DATA TYPES******************************/
DECLARE @Fileid INT
DECLARE @Pageid INT
DECLARE @Slotid INT
DECLARE @CurrentLSN INT
DECLARE @LinkID INT
DECLARE @Context VARCHAR(50)
DECLARE @ConsolidatedPageID VARCHAR(MAX)
DECLARE @LCX_TEXT_MIX VARBINARY(MAX)
 
declare @temppagedata table
(
[ParentObject] sysname,
[Object] sysname,
[Field] sysname,
[Value] sysname)
 
declare @pagedata table
(
[Page ID] sysname,
[File IDS] int,
[Page IDS] int,
[AllocUnitId] bigint,
[ParentObject] sysname,
[Object] sysname,
[Field] sysname,
[Value] sysname)
 
DECLARE @ModifiedRawData TABLE
(
  [ID] INT IDENTITY(1,1),
  [PAGE ID] VARCHAR(MAX),
  [FILE IDS] INT,
  [PAGE IDS] INT,
  [Slot ID]  INT,
  [AllocUnitId] BIGINT,
  [RowLog Contents 0_var] VARCHAR(Max),
  [RowLog Length] VARCHAR(50),
  [RowLog Len] INT,
  [RowLog Contents 0] VARBINARY(Max),
  [Link ID] INT default (0),
  [Update] INT
)
 
            DECLARE Page_Data_Cursor CURSOR FOR
            /*We need to filter LOP_MODIFY_ROW,LOP_MODIFY_COLUMNS from log for deleted records of BLOB data type& Get its Slot No, Page ID & AllocUnit ID*/
            SELECT LTRIM(RTRIM(Replace([Description],'Deallocated',''))) AS [PAGE ID]
            ,[Slot ID],[AllocUnitId],NULL AS [RowLog Contents 0],NULL AS [RowLog Contents 0],Context
            FROM    sys.fn_dblog(NULL, NULL)  
            WHERE   
            AllocUnitId IN
            (SELECT [Allocation_unit_id] FROM sys.allocation_units allocunits
            INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3)  
            AND partitions.hobt_id = allocunits.container_id) OR (allocunits.type = 2 
            AND partitions.partition_id = allocunits.container_id)  
            WHERE object_id=object_ID('' + @SchemaName_n_TableName + ''))
            AND Operation IN ('LOP_MODIFY_ROW') AND [Context] IN ('LCX_PFS') 
            AND Description Like '%Deallocated%'
            /*Use this subquery to filter the date*/
            AND [TRANSACTION ID] IN (SELECT DISTINCT [TRANSACTION ID] FROM    sys.fn_dblog(NULL, NULL) 
            WHERE Context IN ('LCX_NULL') AND Operation in ('LOP_BEGIN_XACT')  
            AND [Transaction Name]='DELETE'
            AND  CONVERT(NVARCHAR(11),[Begin Time]) BETWEEN @Date_From AND @Date_To)
            GROUP BY [Description],[Slot ID],[AllocUnitId],Context
 
            UNION
 
            SELECT [PAGE ID],[Slot ID],[AllocUnitId]
            ,Substring([RowLog Contents 0],15,LEN([RowLog Contents 0])) AS [RowLog Contents 0]
            ,CONVERT(INT,Substring([RowLog Contents 0],7,2)),Context --,CAST(RIGHT([Current LSN],4) AS INT) AS [Current LSN]
            FROM    sys.fn_dblog(NULL, NULL)  
            WHERE  
             AllocUnitId IN
            (SELECT [Allocation_unit_id] FROM sys.allocation_units allocunits
            INNER JOIN sys.partitions partitions ON (allocunits.type IN (1, 3)  
            AND partitions.hobt_id = allocunits.container_id) OR (allocunits.type = 2 
            AND partitions.partition_id = allocunits.container_id)  
            WHERE object_id=object_ID('' + @SchemaName_n_TableName + ''))
            AND Context IN ('LCX_TEXT_MIX') AND Operation in ('LOP_DELETE_ROWS') 
            /*Use this subquery to filter the date*/
            AND [TRANSACTION ID] IN (SELECT DISTINCT [TRANSACTION ID] FROM    sys.fn_dblog(NULL, NULL) 
            WHERE Context IN ('LCX_NULL') AND Operation in ('LOP_BEGIN_XACT')  
            And [Transaction Name]='DELETE'
            And  CONVERT(NVARCHAR(11),[Begin Time]) BETWEEN @Date_From AND @Date_To)
                         
            /****************************************/
 
        OPEN Page_Data_Cursor
 
        FETCH NEXT FROM Page_Data_Cursor INTO @ConsolidatedPageID, @Slotid,@AllocUnitID,@LCX_TEXT_MIX,@LinkID,@Context
 
        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @hex_pageid AS VARCHAR(Max)
            /*Page ID contains File Number and page number It looks like 0001:00000130.
              In this example 0001 is file Number &  00000130 is Page Number & These numbers are in Hex format*/
            SET @Fileid=SUBSTRING(@ConsolidatedPageID,0,CHARINDEX(':',@ConsolidatedPageID)) -- Seperate File ID from Page ID
         
            SET @hex_pageid ='0x'+ SUBSTRING(@ConsolidatedPageID,CHARINDEX(':',@ConsolidatedPageID)+1,Len(@ConsolidatedPageID))  ---Seperate the page ID
            SELECT @Pageid=Convert(INT,cast('' AS XML).value('xs:hexBinary(substring(sql:variable("@hex_pageid"),sql:column("t.pos")) )', 'varbinary(max)')) -- Convert Page ID from hex to integer
            FROM (SELECT CASE substring(@hex_pageid, 1, 2) WHEN '0x' THEN 3 ELSE 0 END) AS t(pos) 
             
            IF @Context='LCX_PFS'    
              BEGIN
                        DELETE @temppagedata
                        INSERT INTO @temppagedata EXEC( 'DBCC PAGE(' + @DataBase_Name + ', ' + @fileid + ', ' + @pageid + ', 1) with tableresults,no_infomsgs;'); 
                        INSERT INTO @pagedata SELECT @ConsolidatedPageID,@fileid,@pageid,@AllocUnitID,[ParentObject],[Object],[Field] ,[Value] FROM @temppagedata
              END
            ELSE IF @Context='LCX_TEXT_MIX'
              BEGIN
                        INSERT INTO  @ModifiedRawData SELECT @ConsolidatedPageID,@fileid,@pageid,@Slotid,@AllocUnitID,NULL,0,CONVERT(INT,CONVERT(VARBINARY,REVERSE(SUBSTRING(@LCX_TEXT_MIX,11,2)))),@LCX_TEXT_MIX,@LinkID,0
              END    
            FETCH NEXT FROM Page_Data_Cursor INTO  @ConsolidatedPageID, @Slotid,@AllocUnitID,@LCX_TEXT_MIX,@LinkID,@Context
        END
     
    CLOSE Page_Data_Cursor
    DEALLOCATE Page_Data_Cursor
 
    DECLARE @Newhexstring VARCHAR(MAX);
 
    --The data is in multiple rows in the page, so we need to convert it into one row as a single hex value.
    --This hex value is in string format
    INSERT INTO @ModifiedRawData ([PAGE ID],[FILE IDS],[PAGE IDS],[Slot ID],[AllocUnitId]
    ,[RowLog Contents 0_var]
    , [RowLog Length])
    SELECT [Page ID],[FILE IDS],[PAGE IDS],Substring([ParentObject],CHARINDEX('Slot', [ParentObject])+4, (CHARINDEX('Offset', [ParentObject])-(CHARINDEX('Slot', [ParentObject])+4))-2 ) as [Slot ID]
    ,[AllocUnitId]
    ,Substring((
    SELECT
    REPLACE(STUFF((SELECT REPLACE(SUBSTRING([Value],CHARINDEX(':',[Value])+1,CHARINDEX('†',[Value])-CHARINDEX(':',[Value])),'†','')
    FROM @pagedata C  WHERE B.[Page ID]= C.[Page ID] And Substring(B.[ParentObject],CHARINDEX('Slot', B.[ParentObject])+4, (CHARINDEX('Offset', B.[ParentObject])-(CHARINDEX('Slot', B.[ParentObject])+4)) )=Substring(C.[ParentObject],CHARINDEX('Slot', C.[ParentObject])+4, (CHARINDEX('Offset', C.[ParentObject])-(CHARINDEX('Slot', C.[ParentObject])+4)) ) And
    [Object] Like '%Memory Dump%'  Order By '0x'+ LEFT([Value],CHARINDEX(':',[Value])-1)
    FOR XML PATH('') ),1,1,'') ,' ','')
    ),1,20000) AS [Value]
     
    ,
     Substring((
    SELECT '0x' +REPLACE(STUFF((SELECT REPLACE(SUBSTRING([Value],CHARINDEX(':',[Value])+1,CHARINDEX('†',[Value])-CHARINDEX(':',[Value])),'†','')
    FROM @pagedata C  WHERE B.[Page ID]= C.[Page ID] And Substring(B.[ParentObject],CHARINDEX('Slot', B.[ParentObject])+4, (CHARINDEX('Offset', B.[ParentObject])-(CHARINDEX('Slot', B.[ParentObject])+4)) )=Substring(C.[ParentObject],CHARINDEX('Slot', C.[ParentObject])+4, (CHARINDEX('Offset', C.[ParentObject])-(CHARINDEX('Slot', C.[ParentObject])+4)) ) And
    [Object] Like '%Memory Dump%'  Order By '0x'+ LEFT([Value],CHARINDEX(':',[Value])-1)
    FOR XML PATH('') ),1,1,'') ,' ','')
    ),7,4) AS [Length]
     
    From @pagedata B
    Where [Object] Like '%Memory Dump%'
    Group By [Page ID],[FILE IDS],[PAGE IDS],[ParentObject],[AllocUnitId]--,[Current LSN]
    Order By [Slot ID]
 
    UPDATE @ModifiedRawData  SET [RowLog Len] = CONVERT(VARBINARY(8000),REVERSE(cast('' AS XML).value('xs:hexBinary(substring(sql:column("[RowLog Length]"),0))', 'varbinary(Max)')))
    FROM @ModifiedRawData Where [LINK ID]=0
 
    UPDATE @ModifiedRawData  SET [RowLog Contents 0] =cast('' AS XML).value('xs:hexBinary(substring(sql:column("[RowLog Contents 0_var]"),0))', 'varbinary(Max)')  
    FROM @ModifiedRawData Where [LINK ID]=0
 
    Update B Set B.[RowLog Contents 0] =
    (CASE WHEN A.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  A.[RowLog Contents 0]+C.[RowLog Contents 0] 
        WHEN A.[RowLog Contents 0] IS NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  C.[RowLog Contents 0]
        WHEN A.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NULL THEN  A.[RowLog Contents 0]  
        END)
    ,B.[Update]=ISNULL(B.[Update],0)+1
    from @ModifiedRawData B
    LEFT Join @ModifiedRawData A On A.[Page IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],15+14,2))))
    And A.[File IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],19+14,2)))) 
    And A.[Link ID]=B.[Link ID]
    LEFT Join @ModifiedRawData C On C.[Page IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],27+14,2))))
    And C.[File IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],31+14,2))))
    And C.[Link ID]=B.[Link ID]
    Where  (A.[RowLog Contents 0] IS NOT NULL OR C.[RowLog Contents 0] IS NOT NULL)
 
 
    Update B Set B.[RowLog Contents 0] =
    (CASE WHEN A.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  A.[RowLog Contents 0]+C.[RowLog Contents 0] 
        WHEN A.[RowLog Contents 0] IS NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  C.[RowLog Contents 0]
        WHEN A.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NULL THEN  A.[RowLog Contents 0]  
        END)
    --,B.[Update]=ISNULL(B.[Update],0)+1
    from @ModifiedRawData B
    LEFT Join @ModifiedRawData A On A.[Page IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],15+14,2))))
    And A.[File IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],19+14,2)))) 
    And A.[Link ID]<>B.[Link ID] And B.[Update]=0
    LEFT Join @ModifiedRawData C On C.[Page IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],27+14,2))))
    And C.[File IDS]=Convert(int,Convert(Varbinary(Max),Reverse(Substring(B.[RowLog Contents 0],31+14,2))))
    And C.[Link ID]<>B.[Link ID] And B.[Update]=0
    Where  (A.[RowLog Contents 0] IS NOT NULL OR C.[RowLog Contents 0] IS NOT NULL)
 
    UPDATE @ModifiedRawData  SET [RowLog Contents 0] =  
    (Case When [RowLog Len]>=8000 Then
    Substring([RowLog Contents 0] ,15,[RowLog Len]) 
    When [RowLog Len]<8000 Then
    SUBSTRING([RowLog Contents 0],15+6,Convert(int,Convert(varbinary(max),REVERSE(Substring([RowLog Contents 0],15,6)))))
    End)
    FROM @ModifiedRawData Where [LINK ID]=0
 
    UPDATE @ColumnNameAndData SET [hex_Value]=[RowLog Contents 0] 
    --,A.[Update]=A.[Update]+1
    FROM @ColumnNameAndData A
    INNER JOIN @ModifiedRawData B ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],17,4))))=[PAGE IDS]
    AND  Convert(int,Substring([hex_value],9,2)) =B.[Link ID] 
    Where [System_Type_Id] In (99,167,175,231,239,241,165,98) And [Link ID] <>0 
 
    UPDATE @ColumnNameAndData SET [hex_Value]=
    (CASE WHEN B.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  B.[RowLog Contents 0]+C.[RowLog Contents 0] 
    WHEN B.[RowLog Contents 0] IS NULL AND C.[RowLog Contents 0] IS NOT NULL THEN  C.[RowLog Contents 0]
    WHEN B.[RowLog Contents 0] IS NOT NULL AND C.[RowLog Contents 0] IS NULL THEN  B.[RowLog Contents 0]  
    END)
    --,A.[Update]=A.[Update]+1
    FROM @ColumnNameAndData A
    LEFT JOIN @ModifiedRawData B ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],5,4))))=B.[PAGE IDS]  And B.[Link ID] =0 
    LEFT JOIN @ModifiedRawData C ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],17,4))))=C.[PAGE IDS]  And C.[Link ID] =0 
    Where [System_Type_Id] In (99,167,175,231,239,241,165,98)  And (B.[RowLog Contents 0] IS NOT NULL OR C.[RowLog Contents 0] IS NOT NULL)
 
    UPDATE @ColumnNameAndData SET [hex_Value]=[RowLog Contents 0] 
    --,A.[Update]=A.[Update]+1
    FROM @ColumnNameAndData A
    INNER JOIN @ModifiedRawData B ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],9,4))))=[PAGE IDS]
    And Convert(int,Substring([hex_value],3,2))=[Link ID]
    Where [System_Type_Id] In (35,34,99) And [Link ID] <>0 
     
    UPDATE @ColumnNameAndData SET [hex_Value]=[RowLog Contents 0]
    --,A.[Update]=A.[Update]+10
    FROM @ColumnNameAndData A
    INNER JOIN @ModifiedRawData B ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],9,4))))=[PAGE IDS]
    Where [System_Type_Id] In (35,34,99) And [Link ID] =0
 
    UPDATE @ColumnNameAndData SET [hex_Value]=[RowLog Contents 0] 
    --,A.[Update]=A.[Update]+1
    FROM @ColumnNameAndData A
    INNER JOIN @ModifiedRawData B ON
    Convert(int,Convert(Varbinary(Max),Reverse(Substring([hex_value],15,4))))=[PAGE IDS]
    Where [System_Type_Id] In (35,34,99) And [Link ID] =0
 
    Update @ColumnNameAndData set [hex_value]= 0xFFFE + Substring([hex_value],9,LEN([hex_value]))
    --,[Update]=[Update]+1
    Where [system_type_id]=241
 
CREATE TABLE [#temp_Data]
(
    [FieldName]  VARCHAR(MAX),
    [FieldValue] NVARCHAR(MAX),
    [Rowlogcontents] VARBINARY(8000),
    [Row ID] int
)
 
INSERT INTO #temp_Data
SELECT NAME,
CASE
 WHEN system_type_id IN (231, 239) THEN  LTRIM(RTRIM(CONVERT(NVARCHAR(max),hex_Value)))  --NVARCHAR ,NCHAR
 WHEN system_type_id IN (167,175) THEN  LTRIM(RTRIM(CONVERT(VARCHAR(max),hex_Value)))  --VARCHAR,CHAR
 WHEN system_type_id IN (35) THEN  LTRIM(RTRIM(CONVERT(VARCHAR(max),hex_Value))) --Text
 WHEN system_type_id IN (99) THEN  LTRIM(RTRIM(CONVERT(NVARCHAR(max),hex_Value))) --nText 
 WHEN system_type_id = 48 THEN CONVERT(VARCHAR(MAX), CONVERT(TINYINT, CONVERT(BINARY(1), REVERSE (hex_Value)))) --TINY INTEGER
 WHEN system_type_id = 52 THEN CONVERT(VARCHAR(MAX), CONVERT(SMALLINT, CONVERT(BINARY(2), REVERSE (hex_Value)))) --SMALL INTEGER
 WHEN system_type_id = 56 THEN CONVERT(VARCHAR(MAX), CONVERT(INT, CONVERT(BINARY(4), REVERSE(hex_Value)))) -- INTEGER
 WHEN system_type_id = 127 THEN CONVERT(VARCHAR(MAX), CONVERT(BIGINT, CONVERT(BINARY(8), REVERSE(hex_Value))))-- BIG INTEGER
 WHEN system_type_id = 61 Then CONVERT(VARCHAR(MAX),CONVERT(DATETIME,CONVERT(VARBINARY(8000),REVERSE (hex_Value))),100) --DATETIME
 WHEN system_type_id =58 Then CONVERT(VARCHAR(MAX),CONVERT(SMALLDATETIME,CONVERT(VARBINARY(8000),REVERSE(hex_Value))),100) --SMALL DATETIME
 WHEN system_type_id = 108 THEN CONVERT(VARCHAR(MAX),CONVERT(NUMERIC(38,20), CONVERT(VARBINARY,CONVERT(VARBINARY(1),xprec)+CONVERT(VARBINARY(1),xscale))+CONVERT(VARBINARY(1),0) + hex_Value)) --- NUMERIC
 WHEN system_type_id =106 THEN CONVERT(VARCHAR(MAX), CONVERT(DECIMAL(38,20), CONVERT(VARBINARY,Convert(VARBINARY(1),xprec)+CONVERT(VARBINARY(1),xscale))+CONVERT(VARBINARY(1),0) + hex_Value)) --- DECIMAL
 WHEN system_type_id In(60,122) THEN CONVERT(VARCHAR(MAX),Convert(MONEY,Convert(VARBINARY(8000),Reverse(hex_Value))),2) --MONEY,SMALLMONEY
 WHEN system_type_id = 104 THEN CONVERT(VARCHAR(MAX),CONVERT (BIT,CONVERT(BINARY(1), hex_Value)%2))  -- BIT
 WHEN system_type_id =62 THEN  RTRIM(LTRIM(STR(CONVERT(FLOAT,SIGN(CAST(CONVERT(VARBINARY(8000),Reverse(hex_Value)) AS BIGINT)) * (1.0 + (CAST(CONVERT(VARBINARY(8000),Reverse(hex_Value)) AS BIGINT) & 0x000FFFFFFFFFFFFF) * POWER(CAST(2 AS FLOAT), -52)) * POWER(CAST(2 AS FLOAT),((CAST(CONVERT(VARBINARY(8000),Reverse(hex_Value)) AS BIGINT) & 0x7ff0000000000000) / EXP(52 * LOG(2))-1023))),53,LEN(hex_Value)))) --- FLOAT
 When system_type_id =59 THEN  Left(LTRIM(STR(CAST(SIGN(CAST(Convert(VARBINARY(8000),REVERSE(hex_Value)) AS BIGINT))* (1.0 + (CAST(CONVERT(VARBINARY(8000),Reverse(hex_Value)) AS BIGINT) & 0x007FFFFF) * POWER(CAST(2 AS Real), -23)) * POWER(CAST(2 AS Real),(((CAST(CONVERT(VARBINARY(8000),Reverse(hex_Value)) AS INT) )& 0x7f800000)/ EXP(23 * LOG(2))-127))AS REAL),23,23)),8) --Real
 WHEN system_type_id In (165,173) THEN (CASE WHEN CHARINDEX(0x,cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'VARBINARY(8000)')) = 0 THEN '0x' ELSE '' END) +cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'varchar(max)') -- BINARY,VARBINARY
 WHEN system_type_id =34 THEN (CASE WHEN CHARINDEX(0x,cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'VARBINARY(8000)')) = 0 THEN '0x' ELSE '' END) +cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'varchar(max)')  --IMAGE
 WHEN system_type_id =36 THEN CONVERT(VARCHAR(MAX),CONVERT(UNIQUEIDENTIFIER,hex_Value)) --UNIQUEIDENTIFIER
 WHEN system_type_id =231 THEN CONVERT(VARCHAR(MAX),CONVERT(sysname,hex_Value)) --SYSNAME
 WHEN system_type_id =241 THEN CONVERT(VARCHAR(MAX),CONVERT(xml,hex_Value)) --XML
 
 WHEN system_type_id =189 THEN (CASE WHEN CHARINDEX(0x,cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'VARBINARY(8000)')) = 0 THEN '0x' ELSE '' END) +cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'varchar(max)') --TIMESTAMP
 WHEN system_type_id=98 THEN (CASE
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=56 THEN CONVERT(VARCHAR(MAX), CONVERT(INT, CONVERT(BINARY(4), REVERSE(Substring(hex_Value,3,Len(hex_Value))))))  -- INTEGER
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=108 THEN CONVERT(VARCHAR(MAX),CONVERT(numeric(38,20),CONVERT(VARBINARY(1),Substring(hex_Value,3,1)) +CONVERT(VARBINARY(1),Substring(hex_Value,4,1))+CONVERT(VARBINARY(1),0) + Substring(hex_Value,5,Len(hex_Value)))) --- NUMERIC
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=167 THEN LTRIM(RTRIM(CONVERT(VARCHAR(max),Substring(hex_Value,9,Len(hex_Value))))) --VARCHAR,CHAR
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=36 THEN CONVERT(VARCHAR(MAX),CONVERT(UNIQUEIDENTIFIER,Substring((hex_Value),3,20))) --UNIQUEIDENTIFIER
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=61 THEN CONVERT(VARCHAR(MAX),CONVERT(DATETIME,CONVERT(VARBINARY(8000),REVERSE (Substring(hex_Value,3,LEN(hex_Value)) ))),100) --DATETIME
 WHEN CONVERT(INT,SUBSTRING(hex_Value,1,1))=165 THEN '0x'+ SUBSTRING((CASE WHEN CHARINDEX(0x,cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'VARBINARY(8000)')) = 0 THEN '0x' ELSE '' END) +cast('' AS XML).value('xs:hexBinary(sql:column("hex_Value"))', 'varchar(max)'),11,LEN(hex_Value)) -- BINARY,VARBINARY
 END)
  
END AS FieldValue
,[Rowlogcontents]
,[Row ID]
FROM @ColumnNameAndData ORDER BY nullbit
 
--Create the column name in the same order to do pivot table.
 
DECLARE @FieldName VARCHAR(max)
SET @FieldName = STUFF(
(
    SELECT ',' + CAST(QUOTENAME([Name]) AS VARCHAR(MAX)) FROM syscolumns WHERE id=object_id('' + @SchemaName_n_TableName + '')
    FOR XML PATH('')), 1, 1, '')
 
--Finally did pivot table and get the data back in the same format.
 
SET @sql = 'SELECT ' + @FieldName  + ' FROM #temp_Data PIVOT (Min([FieldValue]) FOR FieldName IN (' + @FieldName  + ')) AS pvt'
EXEC sp_executesql @sql
 
GO
--Execute the procedure like
--Recover_Deleted_Data_Proc 'Database Name','Schema.table name'
--EXAMPLE #1 : FOR ALL DELETED RECORDS
EXEC Recover_Deleted_Data_Proc 'test','dbo.Test_table'
GO
--EXAMPLE #2 : FOR ANY SPECIFIC DATE RANGE
EXEC Recover_Deleted_Data_Proc 'test','dbo.Test_Table' ,'2011/12/01','2012/01/30'
--It will give you the result of all deleted records.