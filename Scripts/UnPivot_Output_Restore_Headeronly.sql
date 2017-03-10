--UnPivot The Output Of RESTORE HEADERONLY
--Author: Dave Mason
--Link:http://itsalljustelectrons.blogspot.ru/2017/02/Unpivot-Output-Of-RESTORE-HEADERONLY.html

--create a reusable TABLE TYPE
CREATE TYPE dbo.Header_Only AS TABLE (
    BackupName nvarchar(128),
    BackupDescription nvarchar(255),
    BackupType smallint,
    ExpirationDate datetime,
    Compressed BIT,
    Position smallint,
    DeviceType tinyint,
    UserName nvarchar(128),
    ServerName nvarchar(128),
    DatabaseName nvarchar(128),
    DatabaseVersion int,
    DatabaseCreationDate datetime,
    BackupSize numeric(20,0),
    FirstLSN numeric(25,0),
    LastLSN numeric(25,0),
    CheckpointLSN numeric(25,0),
    DatabaseBackupLSN numeric(25,0),
    BackupStartDate datetime,
    BackupFinishDate datetime,
    SortOrder smallint,
    CodePage smallint,
    UnicodeLocaleId int,
    UnicodeComparisonStyle int,
    CompatibilityLevel tinyint,
    SoftwareVendorId int,
    SoftwareVersionMajor int,
    SoftwareVersionMinor int,
    SoftwareVersionBuild int,
    MachineName nvarchar(128),
    Flags int,
    BindingID uniqueidentifier,
    RecoveryForkID uniqueidentifier,
    Collation nvarchar(128),
    FamilyGUID uniqueidentifier,
    HasBulkLoggedData bit,
    IsSnapshot bit,
    IsReadOnly bit,
    IsSingleUser bit,
    HasBackupChecksums bit,
    IsDamaged bit,
    BeginsLogChain bit,
    HasIncompleteMetaData bit,
    IsForceOffline bit,
    IsCopyOnly bit,
    FirstRecoveryForkID uniqueidentifier,
    ForkPointLSN numeric(25,0) NULL,
    RecoveryModel nvarchar(60),
    DifferentialBaseLSN numeric(25,0) NULL,
    DifferentialBaseGUID uniqueidentifier,
    BackupTypeDescription nvarchar(60),
    BackupSetGUID uniqueidentifier NULL,
    CompressedBackupSize bigint,
    containment tinyint not NULL
)
GO

--create a temp table, and insert the output of the RESTORE HEADERONLY statement into it via EXEC and a "RESTORE" string
DECLARE @HO AS dbo.Header_Only;

SELECT *
INTO #HO
FROM @HO
WHERE 1 = 2

INSERT INTO #HO
EXEC ('RESTORE HEADERONLY FROM DISK = N''D:\Backup\SomeApp9_Template.bak'' ')


-- build a dynamic T-SQL query by iterating through the column names of the temp table (well, actually of the table type).
--The end result is a bunch of queries that select a static string (field name) and a single column (field value) from the temp table, UNION'ed together.
--The last "UNION ALL" is trimmed from the string. And the string is executed
DECLARE @TSql VARCHAR(MAX) = '';
SELECT 
 @TSql = @TSql + 'SELECT ''' + c.name + ''' AS [Field], CAST([' + c.name + '] AS VARCHAR(MAX)) AS [Value] FROM #HO UNION ALL' + CHAR(13) + CHAR(10)
FROM sys.table_types t
JOIN sys.columns c 
 on c.object_id = t.type_table_object_id
WHERE t.name = 'Header_Only'
ORDER BY c.column_id

SET @TSql = LEFT(@TSql, LEN(@TSql) - 11) + CHAR(13) + CHAR(10)

EXEC (@TSql)

DROP TABLE #HO