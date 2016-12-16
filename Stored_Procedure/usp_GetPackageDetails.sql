/*
Author: Divya Agrawal
Original link: http://www.sqlservercentral.com/articles/Integration+Services+(SSIS)/128862/
*/


ALTER PROCEDURE [dbo].[usp_GetPackageDetails] @Path VARCHAR(8000) = 'C:\Packages1'
AS
/*
exec [usp_GetPackageDetails]   'C:\Packages1' 

exec sp_configure 'show advanced options',1
reconfigure with override
go
exec sp_configure 'xp_cmdshell',1
reconfigure with override
*/
BEGIN
    SET NOCOUNT ON;

    --------------------drop all temp tables------------------------------------
    IF OBJECT_id('pkgStats') IS NOT NULL
        DROP TABLE pkgStats;

    IF OBJECT_id('ConnectionDetails') IS NOT NULL
        DROP TABLE ConnectionDetails;

    IF OBJECT_id('PackageAnalysis') IS NOT NULL
        DROP TABLE PackageAnalysis;

    IF OBJECT_id('TblPrecedenceConstraint') IS NOT NULL
        DROP TABLE TblPrecedenceConstraint;

    IF OBJECT_id('TblControlFlowDetails') IS NOT NULL
        DROP TABLE TblControlFlowDetails;

    IF OBJECT_id('TblScriptTaskdetails') IS NOT NULL
        DROP TABLE TblScriptTaskdetails;

    IF OBJECT_id('TblExecutePackageTaskDetails') IS NOT NULL
        DROP TABLE TblExecutePackageTaskDetails;

    IF OBJECT_id('TblSQLTaskDetails') IS NOT NULL
        DROP TABLE TblSQLTaskDetails;

    IF OBJECT_id('TblDFTTaskDetails') IS NOT NULL
        DROP TABLE TblDFTTaskDetails;

    IF OBJECT_id('TblSrcDestDetails') IS NOT NULL
        DROP TABLE TblSrcDestDetails;

    IF OBJECT_id('TblDerivedTaskDetails') IS NOT NULL
        DROP TABLE TblDerivedTaskDetails;

    IF OBJECT_id('TblLookupTaskDetails') IS NOT NULL
        DROP TABLE TblLookupTaskDetails;

    IF OBJECT_id('TblVariableDetails') IS NOT NULL
        DROP TABLE TblVariableDetails;
    IF OBJECT_id('TblParameterDetails') IS NOT NULL
        DROP TABLE TblParameterDetails;
    IF OBJECT_id('tempdb.dbo.#tempprecedence1') IS NOT NULL
        DROP TABLE #tempprecedence1;

    IF OBJECT_id('tempdb.dbo.#tempprecedence2') IS NOT NULL
        DROP TABLE #tempprecedence2;

    IF OBJECT_id('tempdb.dbo.#tempprecedence3') IS NOT NULL
        DROP TABLE #tempprecedence3;

    IF OBJECT_id('tempdb.dbo.#tempprecedence5') IS NOT NULL
        DROP TABLE #tempprecedence5;
    IF OBJECT_id('tempdb.dbo.#tempprecedence5_Hierarchy') IS NOT NULL
            DROP TABLE #tempprecedence5_Hierarchy;

    IF OBJECT_id('tempdb.dbo.#tempprecedence4') IS NOT NULL
        DROP TABLE #tempprecedence4;

    IF OBJECT_id('tempdb.dbo.#tempprecedence6') IS NOT NULL
        DROP TABLE #tempprecedence6;

    -------------------drop all temp tables------------------------------------
    ------------------create all tables-------------------------------------------
    CREATE TABLE pkgStats (
        RowID INT identity(1, 1) NOT NULL PRIMARY KEY
        ,PackagePath VARCHAR(8000) NOT NULL
        ,PackageXML XML NOT NULL
        ,PackageCreatorName VARCHAR(1000) NULL
        ,PackageProtectionLevel varchar(100) null
        );

    CREATE TABLE ConnectionDetails (
        ConnectionManager VARCHAR(5000)
        ,ConnectionManagerID VARCHAR(100)
        );

    CREATE TABLE PackageAnalysis (
        TableRowID INT identity(1, 1) NOT NULL
        ,PackageSequenceNo INT
        ,SequenceNo INT
        ,RowID INT
        ,PackagePath VARCHAR(5000)
        ,PackageName VARCHAR(max)
        ,Category VARCHAR(1000)
        ,PackageCreatorName VARCHAR(1000)
        ,PackageProtectionLevel Varchar(100)
        ,TaskPath VARCHAR(max)
        ,ObjectName VARCHAR(500)
        ,ObjectType VARCHAR(max)
        ,ObjectTypeDescription VARCHAR(max)
        ,DelayValidationPropertyValue VARCHAR(10)
        ,ObjectValue VARCHAR(max)
        ,ExpressionValue VARCHAR(5000)
        ,ConnectionManager VARCHAR(5000)
        ,SourceColumn VARCHAR(5000)
        ,DestinationColumn VARCHAR(5000)
        ,SortKeyPosition varchar(10)
        ,DerivedValue VARCHAR(5000)
        ,IsDisabled VARCHAR(10)
        ,ResultSetParameterName VARCHAR(1000)
        ,ParameterBindingSequence VARCHAR(1000)
        ,ParameterBindingParameterName VARCHAR(1000)
        --,ObjectPathFrom VARCHAR(8000)
        --,ObjectPathTo VARCHAR(8000)
        ,ExecutePackageExpression VARCHAR(8000)
        ,ExecutedPackageName VARCHAR(8000)
        ,ExecutePackageConnection VARCHAR(8000)
        ,Script VARCHAR(max)
        ,Variable VARCHAR(1000)
        ,ConnectionManagerID VARCHAR(100)
        ,LookupJoins VARCHAR(8000)
        ,IsSortedProperty varchar(10)
        ,MultihashcolumnSortPosition varchar(max)
        ,RetainSameConnectionProperty varchar(100)
        );

    CREATE CLUSTERED INDEX CX_ControlFlow ON PackageAnalysis (TableRowID);

    CREATE TABLE TblPrecedenceConstraint (
        RowID INT
        ,PackagePath VARCHAR(2000)
        ,TaskFrom VARCHAR(1000)
        ,Taskto VARCHAR(1000)
        ,PrecOrder INT
        ,PrecOrder1 INT
        ,TaskType VARCHAR(1000)
        );

    CREATE TABLE TblVariableDetails (
        VariableRowID INT identity(1, 1) NOT NULL
        ,RowID INT
        ,PackagePath VARCHAR(5000)
        ,PackageName VARCHAR(max)
        ,Category VARCHAR(1000)
        ,PackageCreatorName VARCHAR(1000)
        ,TaskPath VARCHAR(max)
        ,ObjectName VARCHAR(500)
        ,ObjectType VARCHAR(max)
        ,ObjectValue VARCHAR(max)
        ,ExpressionValue VARCHAR(5000)
        ,VariableHexValue VARCHAR(1000)
        );

    CREATE CLUSTERED INDEX CX_Variable ON TblVariableDetails (VariableRowID);

        CREATE TABLE TblParameterDetails (
        ParameterRowID INT identity(1, 1) NOT NULL
        ,RowID INT
        ,PackagePath VARCHAR(5000)
        ,PackageName VARCHAR(max)
        ,Category VARCHAR(1000)
        ,PackageCreatorName VARCHAR(1000)
        ,TaskPath VARCHAR(max)
        ,ObjectName VARCHAR(500)
        ,ObjectType VARCHAR(max)
        ,ObjectValue VARCHAR(max)
        ,ExpressionValue VARCHAR(5000)
        ,ParameterHexValue VARCHAR(1000)
        );

    CREATE CLUSTERED INDEX CX_Variable ON TblParameterDetails (ParameterRowID);
    CREATE TABLE TblControlFlowDetails (
        ControlFlowDetailsRowID INT identity(1, 1) NOT NULL
        ,RowID INT
        ,TaskPath VARCHAR(8000)
        ,TaskName VARCHAR(2000)
        ,TaskTypeDescription VARCHAR(MAX)
        ,TaskType VARCHAR(5000)
        ,DelayValidationPropertyValue VARCHAR(100)
        ,DFTQuery XML
        ,SqlTaskQry XML
        ,ExecPkgTaskQry XML
        ,ScriptTaskQry XML
        ,IsDisabled VARCHAR(10)
        ,ExpressionValue VARCHAR(5000)
        );

    CREATE CLUSTERED INDEX CX_ControlFlow ON TblControlFlowDetails (
        ControlFlowDetailsRowID
        ,RowID
        );

    CREATE NONCLUSTERED INDEX NCX_ControlFlow ON TblControlFlowDetails (RowID);

    CREATE TABLE TblScriptTaskdetails (
        RowID INT
        ,ControlFlowDetailsRowID INT
        ,Script VARCHAR(max)
        );

    CREATE CLUSTERED INDEX CX_TblScriptTaskdetails ON TblScriptTaskdetails (
        ControlFlowDetailsRowID
        ,RowID
        );

    CREATE TABLE TblExecutePackageTaskDetails (
        RowID INT
        ,ControlFlowDetailsRowID INT
        ,ExecutePackageExpression VARCHAR(1000)
        ,ExecutedPackageName VARCHAR(1000)
        ,ExecutePackageConnection VARCHAR(1000)
        );

    CREATE CLUSTERED INDEX CX_TblExecutePackageTaskDetails ON TblExecutePackageTaskDetails (
        ControlFlowDetailsRowID
        ,RowID
        );

    CREATE TABLE TblSQLTaskDetails (
        RowID INT
        ,ControlFlowDetailsRowID INT
        ,ResultSetParameterName VARCHAR(1000)
        ,ParameterBindingSequence VARCHAR(1000)
        ,ParameterBindingParameterName VARCHAR(1000)
        );

    CREATE CLUSTERED INDEX CX_TblSQLTaskDetails ON TblSQLTaskDetails (
        ControlFlowDetailsRowID
        ,RowID
        );

    CREATE TABLE TblDFTTaskDetails (
        DataFlowDetailsRowID INT identity(1, 1) NOT NULL
        ,RowID INT
        ,DFTTaskName VARCHAR(max)
        ,DFTTasksPath VARCHAR(max)
        ,DFTTaskType VARCHAR(max)
        ,DFTTaskType1 VARCHAR(max)
        ,DFTRowSet VARCHAR(max)
        ,ParameterBindingParameterName VARCHAR(2000)
        ,DFTSQLCommand VARCHAR(max)
        ,DFTConnectionManager VARCHAR(max)
        ,Variable VARCHAR(max)
        ,InputQry XML
        ,OutputQry XML
        ,IsSortedProperty VARCHAR(10)
            ,MultihashcolumnSortPosition varchar(max)
        );

    CREATE CLUSTERED INDEX CX_TblDFTTaskDetails ON TblDFTTaskDetails (
        DataFlowDetailsRowID
        ,RowID
        );

    CREATE NONCLUSTERED INDEX NCX_TblDFTTaskDetails ON TblDFTTaskDetails (RowID);

    CREATE TABLE TblSrcDestDetails (
        DataFlowDetailsRowID INT
        ,RowID INT
        ,SourceColumn VARCHAR(8000)
        ,DestinationColumn VARCHAR(8000)
        ,SortKeyPosition varchar(10)
    
        );

    CREATE CLUSTERED INDEX CX_TblSrcDestDetails ON TblSrcDestDetails (
        DataFlowDetailsRowID
        ,RowID
        );

    CREATE TABLE TblDerivedTaskDetails (
        DataFlowDetailsRowID INT
        ,RowID INT
        ,DerivedValue VARCHAR(8000)
        ,SourceColumn VARCHAR(8000)
        ,DestinationColumn VARCHAR(8000)
        );

    CREATE CLUSTERED INDEX CX_TblDerivedTaskDetails ON TblDerivedTaskDetails (
        DataFlowDetailsRowID
        ,RowID
        );

    CREATE TABLE TblLookupTaskDetails (
        DataFlowDetailsRowID INT
        ,RowID INT
        ,LookupJoins VARCHAR(8000)
        ,SourceColumn VARCHAR(8000)
        ,DestinationColumn VARCHAR(8000)
        );

    CREATE CLUSTERED INDEX CX_TblLookupTaskDetails ON TblLookupTaskDetails (
        DataFlowDetailsRowID
        ,RowID
        );
--------------------------create all tables-------------------------------------------
    -------------------Iterate over all dtsx files from folder------------------------------
    SET @Path = @Path + '\*.dtsx';

    DECLARE @MyFiles TABLE (
        MyID INT IDENTITY(1, 1) PRIMARY KEY
        ,FullPath VARCHAR(8000)
        );
    DECLARE @CommandLine VARCHAR(8000);

    SELECT @CommandLine = LEFT('dir "' + @Path + '" /A-D /B /S ', 8000);

    INSERT INTO @MyFiles (FullPath)
    EXECUTE xp_cmdshell @CommandLine;

    DELETE
    FROM @MyFiles
    WHERE FullPath IS NULL
        OR FullPath = 'File Not Found'
        OR FullPath = 'The system cannot find the path specified.'
        OR FullPath = 'The system cannot find the file specified.';

    --select * from @MyFiles
    DECLARE @FullPath VARCHAR(2000);
    DECLARE @counter INT = 0
        ,@totalpkgcount INT;

    SELECT @totalpkgcount = COUNT(*)
    FROM @MyFiles;

    WHILE @counter <= @totalpkgcount
    BEGIN
        SELECT @FullPath = FullPath
        FROM @MyFiles
        WHERE MyID = @counter;

        DECLARE @sql NVARCHAR(max);

        SET @sql = '
        INSERT  INTO pkgStats (PackagePath,PackageXML)
        select  ''@FullPath'' as PackagePath
        ,       cast(BulkColumn as XML) as PackageXML
        from    openrowset(bulk ''@FullPath'',
                                single_blob) as pkgColumn';

        SELECT @sql = REPLACE(@sql, '@FullPath', @FullPath);

        EXEC sp_executesql @sql;

        SET @counter = @counter + 1;
    END
            -------------------Iterate over all dtsx files from folder------------------------------        
            --select * from pkgStats
            ------------add package creator name---------------------------
            ;

    WITH CTE_PkgLevel
    AS (
        SELECT RowID
            ,PackagePath
            ,PackageXML.value('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    /DTS:Executable[1]/@DTS:CreatorName', 'nvarchar(500)') AS PackageCreatorName
            ,PackageXML.value('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    /DTS:Executable[1]/@DTS:ProtectionLevel', 'nvarchar(500)')   AS PackageProtectionLevel
        FROM pkgStats pkg
        )
    UPDATE P
    SET PackageCreatorName = C.PackageCreatorName,
        PackageProtectionLevel = C.PackageProtectionLevel
    FROM pkgStats P
    INNER JOIN CTE_PkgLevel C ON P.RowID = C.RowID;


    ------------add package creator name---------------------------
    PRINT '---------------Get all connections-----------------------------------';

    WITH CTE_PkgLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ObjectName[1]', 'varchar(max)') AS ConnectionManagerName
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:CreationName[1]', 'varchar(max)') AS ConnectionManagerType
            --, cfnodes1.y.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ConnectionString[1]', 'varchar(max)') 
            ,cfnodes.x.query('.').query('declare namespace p1="www.microsoft.com/SqlServer/Dts";./p1:ConnectionManager/p1:ObjectData/p1:ConnectionManager') AS ConnectionStringQry
            ,cfnodes.x.query('.').query('declare namespace p1="www.microsoft.com/SqlServer/Dts";./p1:ConnectionManager/p1:PropertyExpression') AS ExpressionQry
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:DTSID[1]', 'varchar(100)') AS ConnectionManagerID
            ,pkg.PackageCreatorName
            
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";(//DTS:Executable/DTS:ConnectionManagers/*)') AS cfnodes(x)
        )
        ,CTE_PkgConLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,pkg.ConnectionManagerName
            ,pkg.ConnectionManagerType
            ,ConnectionManagerID
            --,pkg.ConnectionStringQry
            ,(
                SELECT TOP 1 cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";@p1:ConnectionString[1]', 'nvarchar(max)') AS ConnectionString
                FROM pkg.ConnectionStringQry.nodes('./*') AS cfnodes(x)
                ) AS ConnectionString
            ,(
                SELECT TOP 1 cfnodes.x.value('.', 'nvarchar(max)') AS ExpressionValue
                FROM pkg.ExpressionQry.nodes('./*') AS cfnodes(x)
                ) AS ExpressionValue
            ,PackageCreatorName
            ,(
                SELECT TOP 1 cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";@p1:Retain[1]', 'nvarchar(max)') AS RetainSameConnectionProperty
                FROM pkg.ConnectionStringQry.nodes('./*') AS cfnodes(x)
                ) AS RetainSameConnectionProperty
        FROM CTE_PkgLevel pkg
        )
    INSERT INTO PackageAnalysis (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
        ,ConnectionManagerID
        ,RetainSameConnectionProperty
        )
    SELECT DISTINCT pkg.RowID
        ,pkg.PackagePath
        ,REPLACE(pkg.PackagePath, REPLACE(@Path, '*.dtsx', ''), '') PackageName
        ,'Connection' AS CategoryC
        ,pkg.PackageCreatorName
        ,cast(pkg.ConnectionManagerName AS VARCHAR(max)) AS ObjectName
        ,cast(pkg.ConnectionManagerType AS VARCHAR(max)) AS ObjectType
        ,'NA' AS DelayValidationPropertyValue
        ,cast(pkg.ConnectionString AS VARCHAR(max)) AS ObjectValue
        ,cast(ExpressionValue AS VARCHAR(max)) AS ExpressionValue
        ,ConnectionManagerID
        ,RetainSameConnectionProperty
    FROM CTE_PkgConLevel pkg;

    PRINT '---------------Get all connections-----------------------------------';
    PRINT '------------------------Get all variable details-------------------------------------';

    WITH CTE_PkgLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ObjectName[1]', 'varchar(max)') AS VariableName
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:DTSID[1]', 'varchar(max)') AS VariableHexValue
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:Expression[1]', 'varchar(max)') AS ExpressionValue
            ,cfnodes.x.query('.').query('declare namespace p1="www.microsoft.com/SqlServer/Dts";./p1:Variable/p1:VariableValue') AS VariableQry
            ,PackageCreatorName
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";(//DTS:Executable/DTS:Variables/*)') AS cfnodes(x)
        )
        --select * from CTE_PkgLevel
        ,CTE_PkgVarLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,pkg.VariableName
            ,pkg.ExpressionValue
            ,VariableHexValue
            ,(
                SELECT TOP 1 cfnodes.x.value('.', 'nvarchar(max)') AS VariableValue
                FROM pkg.VariableQry.nodes('./*') AS cfnodes(x)
                ) AS VariableValue
            --,pkg.ConnectionStringQry
            ,(
                SELECT TOP 1 cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";@p1:DataType[1]', 'nvarchar(max)') AS DataType
                FROM pkg.VariableQry.nodes('./*') AS cfnodes(x)
                ) AS VariableDataType
            ,PackageCreatorName
        FROM CTE_PkgLevel pkg
        )
    INSERT INTO TblVariableDetails (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,ObjectValue
        ,ExpressionValue
        ,VariableHexValue
        )
    SELECT DISTINCT Tblvar.RowID
        ,Tblvar.PackagePath
        ,REPLACE(Tblvar.PackagePath, REPLACE(@Path, '*.dtsx', ''), '') PackageName
        ,'Variable' AS Category
        ,Tblvar.PackageCreatorName
        ,cast(Tblvar.VariableName AS VARCHAR(max)) AS TaskName
        ,cast(Tblvar.VariableDataType AS VARCHAR(max)) AS TaskType
        ,isnull(cast(Tblvar.VariableValue AS VARCHAR(max)), '') AS VariableValue
        ,isnull(cast(tblvar.ExpressionValue AS VARCHAR(max)), '') ExpressionValue
        ,VariableHexValue
    FROM CTE_PkgVarLevel Tblvar;

    INSERT INTO PackageAnalysis (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
        )
    SELECT DISTINCT Tblvar.RowID
        ,Tblvar.PackagePath
        ,PackageName
        ,'Variable' AS Category
        ,Tblvar.PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,'NA' AS DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
    FROM TblVariableDetails Tblvar;

    PRINT '------------------------Get all variable details-------------------------------------';

        PRINT '------------------------Get all parameter details-------------------------------------';

    WITH CTE_PkgLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ObjectName[1]', 'varchar(max)') AS ParameterName
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:DTSID[1]', 'varchar(max)') AS ParameterHexValue
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:Expression[1]', 'varchar(max)') AS ExpressionValue
            ,cfnodes.x.query('.').query('declare namespace p1="www.microsoft.com/SqlServer/Dts";./p1:PackageParameter/p1:Property') AS ParameterQry
            ,PackageCreatorName
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";(//DTS:Executable/DTS:PackageParameters/*)') AS cfnodes(x)
        )
        --select * from CTE_PkgLevel
        ,CTE_PkgVarLevel
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,pkg.ParameterName
            ,pkg.ExpressionValue
            ,ParameterHexValue
            ,(
                SELECT TOP 1 cfnodes.x.value('.', 'nvarchar(max)') AS ParameterValue
                FROM pkg.ParameterQry.nodes('./*') AS cfnodes(x)
                ) AS ParameterValue
            --,pkg.ConnectionStringQry
            ,(
                SELECT TOP 1 cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";@p1:DataType[1]', 'nvarchar(max)') AS DataType
                FROM pkg.ParameterQry.nodes('./*') AS cfnodes(x)
                ) AS ParameterDataType
            ,PackageCreatorName
        FROM CTE_PkgLevel pkg
        )
    INSERT INTO tblParameterDetails(
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,ObjectValue
        ,ExpressionValue
        ,ParameterHexValue
        )
    SELECT DISTINCT Tblvar.RowID
        ,Tblvar.PackagePath
        ,REPLACE(Tblvar.PackagePath, REPLACE(@Path, '*.dtsx', ''), '') PackageName
        ,'Variable' AS Category
        ,Tblvar.PackageCreatorName
        ,cast(Tblvar.ParameterName AS VARCHAR(max)) AS TaskName
        ,cast(Tblvar.ParameterDataType AS VARCHAR(max)) AS TaskType
        ,isnull(cast(Tblvar.ParameterValue AS VARCHAR(max)), '') AS ParameterValue
        ,isnull(cast(tblvar.ExpressionValue AS VARCHAR(max)), '') ExpressionValue
        ,ParameterHexValue
    FROM CTE_PkgVarLevel Tblvar;

    INSERT INTO PackageAnalysis (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
        )
    SELECT DISTINCT Tblvar.RowID
        ,Tblvar.PackagePath
        ,PackageName
        ,'Parameter' AS Category
        ,Tblvar.PackageCreatorName
        ,ObjectName
        ,ObjectType
        ,'NA' AS DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
    FROM tblParameterDetails Tblvar;

    PRINT '------------------------Get all parameter details-------------------------------------';
    PRINT '----------------Get  precedence constraint details------------------------------';

    WITH CTE_CFPrec
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:From[1]', 'varchar(max)') AS TaskFrom
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:To[1]', 'nvarchar(max)') AS TaskTo
        --,dft.x.value('@refId[1]','varchar(max)')
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";//DTS:Executable/DTS:PrecedenceConstraints/*') AS cfnodes(x)
        )
        ,CTE_DFTPrec
    AS (
        SELECT pkg.RowID
            ,pkg.PackagePath
            ,cfnodes.x.value('./@startId[1]', 'varchar(max)') AS TaskFrom
            ,cfnodes.x.value('./@endId[1]', 'nvarchar(max)') AS TaskTo
        --,dft.x.value('@refId[1]','varchar(max)')
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";//DTS:Executable/DTS:ObjectData/pipeline/paths/*') AS cfnodes(x)
        )
    INSERT INTO TblPrecedenceConstraint (
        RowID
        ,PackagePath
        ,TaskFrom
        ,Taskto
        ,TaskType
        )
    SELECT RowID
        ,PackagePath
        ,TaskFrom
        ,TaskTo
        ,TaskType
    FROM (
        SELECT RowID
            ,PackagePath
            ,TaskFrom
            ,TaskTo
            ,'Control Flow' AS TaskType
        FROM CTE_CFPrec
        
        UNION ALL
        
        SELECT RowID
            ,PackagePath
            ,substring(TaskFrom, 1, charindex('.', TaskFrom) - 1) AS TaskFrom
            ,substring(TaskTo, 1, CHARINDEX('.', TaskTo) - 1)
            ,'Data Flow'
        FROM CTE_DFTPrec
        ) t;
    CREATE CLUSTERED INDEX CIX_TblPrecedenceConstraint ON TblPrecedenceConstraint (RowID);

    CREATE NONCLUSTERED INDEX NCIX_TblPrecedenceConstraint ON TblPrecedenceConstraint (
        TaskFrom
        ,TaskTo
        );
SELECT DISTINCT RowID,TaskFrom,IsParentLevel,Row_number() OVER (
            PARTITION BY  rowid ORDER BY level) level INTO #tempprecedence1
FROM
(
    SELECT  distinct t1.Rowid
        ,t1.TaskFrom
        ,1 AS isparentlevel
        , len(t1.TaskFrom) - len(replace(t1.TaskFrom, '\', '')) AS level         
    
    FROM TblPrecedenceConstraint t1
    LEFT JOIN TblPrecedenceConstraint t2 ON t1.rowid = t2.RowID
        AND t1.TaskFrom = t2.taskTo
    WHERE t2.taskto IS NULL 
)T
 

    CREATE CLUSTERED INDEX CIX_TblPrecedenceConstraint1 ON #tempprecedence1 (RowID);

    CREATE NONCLUSTERED INDEX NCIX_TblPrecedenceConstraint1 ON #tempprecedence1 (level);

    CREATE TABLE #tempprecedence2 (
        ROWID INT
        ,TaskFrom VARCHAR(1000)
        ,task VARCHAR(1000)
        ,parentlevel INT
        ,LEVEL INT
        );

    DECLARE @cntlevel INT
        ,@cnt INT = 1;

    SELECT @cntlevel = count(*)
    FROM #tempprecedence1;
    WHILE @cnt <= @cntlevel
    BEGIN
            ;

        WITH cte
        AS (
            SELECT rowid
                ,taskfrom
                ,taskfrom AS task
                ,LEVEL
                ,1 AS cnt
            FROM #tempprecedence1
            WHERE LEVEL = @cnt
            
            UNION ALL
            
            SELECT c.rowid
                ,c.taskfrom
                ,t.taskto
                ,LEVEL
                ,cnt + 1
            FROM TblPrecedenceConstraint t
            INNER JOIN cte c ON t.RowID = c.RowID
                AND c.task = t.taskfrom
            )
        INSERT INTO #tempprecedence2 (
            rowid
            ,taskfrom
            ,task
            ,parentlevel
            ,LEVEL
            )
        SELECT rowid
            ,taskfrom
            ,task
            ,@cnt
            ,cnt
        FROM cte;
        SELECT @cnt = @cnt + 1;
    END
    SELECT rowid
        ,task
        ,parentlevel
        ,LEVEL
        ,row_number() OVER (
            PARTITION BY rowid ORDER BY parentlevel
                ,LEVEL
            ) trank
    INTO #tempprecedence3
    FROM #tempprecedence2;
    CREATE CLUSTERED INDEX CIX_TblPrecedenceConstraint1 ON #tempprecedence3 (RowID);

    CREATE NONCLUSTERED INDEX NCIX_TblPrecedenceConstraint1 ON #tempprecedence3 (task);
  SELECT t.rowid
        ,isnull(t1.task,t.task) as task
        ,t.LEVEL tlevel
        ,isnull(max(t1.LEVEL),max(t.level)) level
        ,isnull(max(t1.trank),max(t.trank)) trank
    INTO #tempprecedence4
    FROM #tempprecedence3 t
    LEFT JOIN #tempprecedence3 t1 ON t.rowid = t1.rowid
        AND t1.task LIKE '%' + t.task + '\%'
    GROUP BY t.rowid
        ,t1.task
        ,t.task
        ,t.LEVEL
        --,t1.LEVEL
    ORDER BY LEVEL
        ,trank;
     
 
    --select t.rowid,t1.task,t.level tlevel,t1.level, (t1.trank) trank into #tempprecedence4
    --from #tempprecedence3 t
    --join #tempprecedence3 t1
    --on t.rowid = t1.rowid
    --and t1.task like '%'+t.task+'%'
    -- order by trank

    SELECT t.rowid
        ,t.task
        ,replace(replace(replace((
                        SELECT   tlevel
                        FROM #tempprecedence4 t1
                        WHERE t1.rowid = t.rowid
                            AND t1.task = t.task
                        FOR XML path('') 
                        ), '</tlevel><tlevel>', '/'), '</tlevel>', '/'), '<tlevel>', '')  sequenceno,trank
    INTO #tempprecedence5
    FROM #tempprecedence4 t
    GROUP BY t.rowid
        ,t.task
        ,t.trank
    ORDER BY rowid
        ,trank;
 
  
 SELECT rowid,task, sequenceno, cast('/1/'+sequenceno+ cast(trank as varchar)+'/' as hierarchyid)rid into #tempprecedence5_Hierarchy FROM #tempprecedence5
    SELECT rowid
        ,task
        ,row_number() OVER (
            PARTITION BY rowid ORDER BY rid
            ) sequenceno
    INTO #tempprecedence6
    FROM #tempprecedence5_Hierarchy;
    CREATE CLUSTERED INDEX CIX_TblPrecedenceConstraint1 ON #tempprecedence6 (RowID);

    CREATE NONCLUSTERED INDEX NCIX_TblPrecedenceConstraint1 ON #tempprecedence6 (task);
    /*

   select t1.task,t1.parentlevel,t.task as t1,row_number() over(partition by t1.rowid order by t.level) level,t.rowid into #tempprecedence3
  from #tempprecedence2 t
  join #tempprecedence2 t1
  on charindex(t.task, t1.taskFrom)>0  
  and t1.parentlevel >1 and t.parentlevel =1
  and t.rowid =t1.rowid
    order by t.rowid, t1.parentlevel ,t.level 

     select  rowid, task,row_number() over(partition by rowid order by max(sequenceno)) sequenceno into #tempprecedence4
  from(
    select distinct t1.rowid,isnull(t2.task,t1.task) Task,row_number() over(partition by t1.rowid order by t1.parentlevel,t1.level,isnull(t2.level,1)) sequenceno  
  from #tempprecedence2 t1
  left join #tempprecedence3 t2
  on t1.rowid = t2.rowid
  and t1.task = t2.t1
   where t1.parentlevel =1  )t
   group by rowid,task 

   
 */
    PRINT '----------------Get  precedence constraint details------------------------------';
    PRINT '----------------Get all Control flow tasks details------------------------------';
    PRINT '----------------Get all  data flow tasks details------------------------------';

    WITH CTE_CFLevel
    AS (
        SELECT pkg.RowID
            ,cfnodes.x.query('.').query('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    ./DTS:Executable[@DTS:ExecutableType=''SSIS.Pipeline.3'']/DTS:ObjectData/pipeline/components/component') DFTQuery
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:refId[1]', 'varchar(max)') AS TaskPath
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ObjectName[1]', 'nvarchar(max)') AS TaskName
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:Description', 'nvarchar(max)') AS TaskTypeDescription
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:ExecutableType', 'nvarchar(max)') AS TaskType
            ,cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:DelayValidation', 'nvarchar(max)') AS DelayValidationPropertyValue
            ,ISNULL(cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:Disabled', 'nvarchar(max)'), 'False') AS IsDisabled
            ,'EvalExpression = ' + cfnodes.x.value('declare namespace p1="www.microsoft.com/SqlServer/Dts";./@p1:EvalExpression', 'nvarchar(max)') AS ForloopEvalExpression
            ,cfnodes.x.query('.').query('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    ./DTS:Executable[@DTS:ExecutableType=''Microsoft.SqlServer.Dts.Tasks.ExecuteSQLTask.ExecuteSQLTask, Microsoft.SqlServer.SQLTask, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91'']/DTS:ObjectData/*') AS SqlTaskQry
            ,cfnodes.x.query('.').query('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    ./DTS:Executable[@DTS:ExecutableType=''SSIS.ExecutePackageTask.3'']/*') ExecPkgTaskQry
            ,cfnodes.x.query('.').query('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    ./DTS:Executable[@DTS:ExecutableType=''Microsoft.SqlServer.Dts.Tasks.ScriptTask.ScriptTask, Microsoft.SqlServer.ScriptTask, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91'']/DTS:ObjectData/ScriptProject/*') ScriptTaskQry
        FROM pkgStats pkg
        CROSS APPLY pkg.PackageXML.nodes('declare namespace DTS="www.microsoft.com/SqlServer/Dts";//DTS:Executable/DTS:Executables/*') AS cfnodes(x)
        )
    INSERT INTO TblControlFlowDetails (
        RowID
        ,TaskPath
        ,TaskName
        ,TaskTypeDescription
        ,TaskType
        ,DelayValidationPropertyValue
        ,DFTQuery
        ,SqlTaskQry
        ,ExecPkgTaskQry
        ,ScriptTaskQry
        ,IsDisabled
        ,ExpressionValue
        )
    SELECT RowID
        ,TaskPath
        ,TaskName
        ,TaskTypeDescription
        ,TaskType
        ,DelayValidationPropertyValue
        ,DFTQuery
        ,SqlTaskQry
        ,ExecPkgTaskQry
        ,ScriptTaskQry
        ,IsDisabled
        ,ForloopEvalExpression
    FROM CTE_CFLevel;

    PRINT '---------- Insert Script task details-----------------------';

    INSERT INTO TblScriptTaskdetails (
        RowID
        ,ControlFlowDetailsRowID
        ,Script
        )
    SELECT RowID
        ,CF.ControlFlowDetailsRowID
        ,cfnodes1.x.value('./ProjectItem[@Name=''ScriptMain.cs''][1]', 'varchar(max)') Script
    FROM TblControlFlowDetails cf
    CROSS APPLY Cf.ScriptTaskQry.nodes('.') AS cfnodes1(x);

    PRINT '---------- Insert Execute package task details-----------------------';

    INSERT INTO TblExecutePackageTaskDetails (
        RowID
        ,ControlFlowDetailsRowID
        ,ExecutePackageExpression
        ,ExecutedPackageName
        ,ExecutePackageConnection
        )
    SELECT RowID
        ,cf.ControlFlowDetailsRowID
        ,cfnodes1.x.value('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
                    ./DTS:PropertyExpression[1]', 'varchar(1000)') ExecutePackageExpression
        ,cfnodes1.x.value('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
            (./DTS:ObjectData/ExecutePackageTask/PackageName)[1]', 'varchar(1000)') ExecutedPackageName
        ,cfnodes1.x.value('declare namespace DTS="www.microsoft.com/SqlServer/Dts";
            (./DTS:ObjectData/ExecutePackageTask/Connection)[1]', 'varchar(1000)') ExecutePackageConnection
    FROM TblControlFlowDetails cf
    CROSS APPLY Cf.ExecPkgTaskQry.nodes('.') AS cfnodes1(x);

    UPDATE execpkg
    SET ExecutePackageConnection = pkg.ObjectValue
    FROM TblExecutePackageTaskDetails execpkg
    INNER JOIN packageanalysis pkg ON execpkg.RowID = pkg.RowID
        AND pkg.category = 'Connection'
        AND pkg.ConnectionManagerID = execpkg.ExecutePackageConnection;

    PRINT '---------- Insert Execute SQL task details-----------------------';

    INSERT INTO TblSQLTaskDetails (
        RowID
        ,ControlFlowDetailsRowID
        ,ParameterBindingSequence
        ,ParameterBindingParameterName
        )
    SELECT DISTINCT cf.RowID
        ,cf.ControlFlowDetailsRowID
        --,cfnodes1.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask"; (./@SQLTask:DtsVariableName)','varchar(1000)') as ResultSetParameterName
        ,cfnodes.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask"; (./@SQLTask:ParameterName)', 'varchar(1000)') AS ParameterBindingSequence
        ,cfnodes.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask"; (./@SQLTask:DtsVariableName)', 'varchar(1000)') AS ParameterBindingParameterName
    FROM TblControlFlowDetails cf
    OUTER APPLY Cf.SqlTaskQry.nodes('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask";./SQLTask:SqlTaskData/SQLTask:ParameterBinding') AS cfnodes(x)
    ORDER BY 1
        ,2
        ,3;

    UPDATE sqltsk
    SET ResultSetParameterName = CF.ResultSetParameterName
    FROM TblSQLTaskDetails sqltsk
    INNER JOIN (
        SELECT DISTINCT cf.RowID
            ,cf.ControlFlowDetailsRowID
            ,cast(ROW_NUMBER() OVER (
                    PARTITION BY cf.ControlFlowDetailsRowID ORDER BY (
                            SELECT 1
                            )
                    ) - 1 AS VARCHAR) rid
            ,cfnodes1.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask"; (./@SQLTask:DtsVariableName)', 'varchar(1000)') AS ResultSetParameterName
        FROM TblControlFlowDetails cf
        OUTER APPLY Cf.SqlTaskQry.nodes('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask";./SQLTask:SqlTaskData/SQLTask:ResultBinding') AS cfnodes1(x)
        ) CF ON sqltsk.ControlFlowDetailsRowID = CF.ControlFlowDetailsRowID
        AND cf.rid = ISNULL(sqltsk.ParameterBindingSequence, 0)

    PRINT '---------- Insert DFT details-----------------------';

    INSERT INTO TblDFTTaskDetails (
        RowID
        ,DFTTasksPath
        ,DFTTaskName
        ,DFTTaskType
        ,DFTTaskType1
        ,DFTRowSet
        ,ParameterBindingParameterName
        ,DFTSQLCommand
        ,DFTConnectionManager
        ,Variable
        ,IsSortedProperty
        ,InputQry
        ,OutputQry
        ,MultihashcolumnSortPosition
        )
    SELECT RowID
        ,dftnodes.x.value('@refId[1]', 'varchar(max)') AS DFTTasksPath
        ,dftnodes.x.value('@name[1]', 'varchar(max)') AS DFTTaskName
        ,dftnodes.x.value('@description[1]', 'varchar(max)') AS DFTTaskType
        ,dftnodes.x.value('@contactInfo[1]', 'varchar(max)') AS DFTTaskType1
        ,dftnodes.x.value('data(./properties/property[@name=''OpenRowset''] )[1]', 'varchar(max)') DFTRowSet
        ,dftnodes.x.value('data(./properties/property[@name=''ParameterMapping'']   )[1]', 'varchar(max)') ParameterBindingParameterName
        ,CASE 
            WHEN isnull(dftnodes.x.value('data(./properties/property[@name=''SqlCommand''])[1]', 'varchar(max)'), '') = ''
                THEN isnull(dftnodes.x.value('data(./properties/property[@name=''SqlCommandVariable''])[1]', 'varchar(max)'), '')
            ELSE isnull(dftnodes.x.value('data(./properties/property[@name=''SqlCommand''])[1]', 'varchar(max)'), '')
            END DFTSQLCommand
        ,dftnodes.x.value('data(./connections/connection/@connectionManagerID)[1]', 'varchar(max)') DFTConnectionManager
        ,dftnodes.x.value('data(./properties/property[@name=''VariableName'']   )[1]', 'varchar(max)') Variable
        ,dftnodes.x.value('data(./outputs/output/@isSorted)[1]', 'varchar(10)') IsSortedProperty

        ,lineage.x.query('.') InputQry
        ,outputvalue.x.query('.') OutputQry
        ,outputvalue.x.value('data(./properties/property[@name=''InputColumnLineageIDs'']   )[1]', 'varchar(max)')  as MultihashcolumnSortPosition

    FROM TblControlFlowDetails pkglvl
    CROSS APPLY pkglvl.DFTQuery.nodes('./*') AS dftnodes(x)
    OUTER APPLY dftnodes.x.nodes('./inputs/input/inputColumns/*') AS lineage(x)
    OUTER APPLY dftnodes.x.nodes('./outputs/output/outputColumns/*') AS outputvalue(x);

    PRINT '---------- Insert DFT details-----------------------';
    PRINT '---------- Insert DFT Source and destination details-----------------------';

    INSERT INTO TblSrcDestDetails (
        RowID
        ,DataFlowDetailsRowID
        ,SourceColumn
        ,DestinationColumn
        ,SortKeyPosition
        )
    SELECT RowID
        ,DataFlowDetailsRowID
        ,lineage.x.value('./@lineageId[1]', 'varchar(max)') AS SourceColumn
        ,COALESCE(lineage.x.value('./@name[1]', 'varchar(max)'),lineage.x.value('./@externalMetadataColumnId[1]', 'varchar(max)'), lineage.x.value('./@refId[1]', 'varchar(max)')) DestinationColumn
        ,lineage.x.value('./@sortKeyPosition[1]', 'varchar(200)') SortKeyPosition
        
    FROM TblDFTTaskDetails pkglvl
    CROSS APPLY pkglvl.InputQry.nodes('./*') AS lineage(x);

    INSERT INTO TblSrcDestDetails (
        RowID
        ,DataFlowDetailsRowID
        ,SourceColumn
        ,DestinationColumn
        ,SortKeyPosition
        )
    SELECT RowID
        ,DataFlowDetailsRowID
        ,lineage.x.value('./@lineageId[1]', 'varchar(max)') SourceColumn
        ,COALESCE(lineage.x.value('./@name[1]', 'varchar(max)'),lineage.x.value('./@externalMetadataColumnId[1]', 'varchar(max)'), lineage.x.value('./@refId[1]', 'varchar(max)')) DestinationColumn
        ,lineage.x.value('./@sortKeyPosition[1]', 'varchar(200)') SortKeyPosition
    FROM TblDFTTaskDetails pkglvl
    CROSS APPLY pkglvl.OutputQry.nodes('./*') AS lineage(x);

    PRINT '---------- Insert DFT Source and destination details-----------------------';
    PRINT '---------- Insert DFT Derived task  details-----------------------';

    INSERT INTO TblDerivedTaskDetails (
        RowID
        ,DataFlowDetailsRowID
        ,DerivedValue
        ,SourceColumn
        ,DestinationColumn
        )
    SELECT DISTINCT RowID
        ,DataFlowDetailsRowID
        ,ISNULL(inputvalue.x.value('data(./properties/property[@description =''Derived Column Friendly Expression''])[1]', 'varchar(max)'), inputvalue.x.value('data(./properties/property[@name =''FriendlyExpression''])[1]', 'varchar(max)')) DerivedValue
        ,inputvalue.x.value('./@lineageId[1]', 'varchar(max)') SourceColumn
        ,inputvalue.x.value('./@refId[1]', 'varchar(max)') DestinationColumn
    FROM TblDFTTaskDetails pkglvl
    CROSS APPLY pkglvl.InputQry.nodes('./*') AS inputvalue(x)
    
    UNION ALL
    
    SELECT DISTINCT RowID
        ,DataFlowDetailsRowID
        ,ISNULL(outputvalue.x1.value('data(./properties/property[@description =''Derived Column Friendly Expression''])[1]', 'varchar(max)'), outputvalue.x1.value('data(./properties/property[@name =''FriendlyExpression''])[1]', 'varchar(max)')) DerivedValue
        ,outputvalue.x1.value('./@lineageId[1]', 'varchar(max)') SourceColumn
        ,outputvalue.x1.value('./@refId[1]', 'varchar(max)') DestinationColumn
    FROM TblDFTTaskDetails pkglvl
    CROSS APPLY pkglvl.OutputQry.nodes('./*') AS outputvalue(x1)
    WHERE DFTTASKTYPE1 LIKE '%DERIVED%';

    PRINT '---------- Insert DFT Derived task  details-----------------------';
    PRINT '---------- Insert DFT lookup task  details-----------------------';

    INSERT INTO TblLookupTaskDetails (
        RowID
        ,DataFlowDetailsRowID
        ,LookupJoins
        ,SourceColumn
        ,DestinationColumn
        )
    SELECT RowID
        ,DataFlowDetailsRowID
        ,outputvalue.x.value('./@lineageId[1]', 'varchar(max)') + '----->' + outputvalue.x.value('data(./properties/property[@name =''JoinToReferenceColumn''])[1]', 'varchar(max)') LookupJoins
        ,outputvalue1.x.value('data(./properties/property[@name =''CopyFromReferenceColumn''])[1]', 'varchar(max)') SourceColumn
        ,outputvalue1.x.value('./@refId[1]', 'varchar(max)') DestinationColumn
    FROM TblDFTTaskDetails pkglvl
    CROSS APPLY pkglvl.InputQry.nodes('./*') AS outputvalue(x)
    CROSS APPLY pkglvl.OutputQry.nodes('./*') AS outputvalue1(x)
    WHERE DFTTaskType = 'Lookup'
        OR DFTTaskType1 LIKE '%Lookup%';

    DELETE
    FROM TblLookupTaskDetails
    WHERE DestinationColumn LIKE '%Lookup Error Output%';
    PRINT '---------- Insert DFT lookup task  details-----------------------';
    PRINT '---------- Insert DFT  details in final table-----------------------';

    INSERT INTO PackageAnalysis (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,TaskPath
        ,ObjectName
        ,ObjectType
        ,ObjectTypeDescription
        ,DelayValidationPropertyValue
        ,ObjectValue
        ,ExpressionValue
        ,ConnectionManager
        ,SourceColumn
        ,DestinationColumn
        ,DerivedValue
        ,Variable
        ,LookupJoins
        ,ParameterBindingParameterName
        ,SortKeyPosition
        ,IsSortedProperty
        ,MultihashcolumnSortPosition
        )
    SELECT DISTINCT dftlvl.RowID
        ,Pkg.PackagePath
        ,REPLACE(pkg.PackagePath, REPLACE(@Path, '*.dtsx', ''), '') PackageName
        ,cast('Data Flow Task' AS VARCHAR(max)) AS Category
        ,pkg.PackageCreatorName
        ,DFTLVL.DFTTasksPath AS TaskPath
        ,DFTTaskName AS TaskName
        ,CASE 
            WHEN cast(CHARINDEX(';', LEFT(DFTTaskType1, 8000)) AS VARCHAR(1000)) BETWEEN 4
                    AND 100
                THEN LEFT(cast(DFTTaskType1 AS VARCHAR(8000)), CHARINDEX(';', LEFT(DFTTaskType1, 8000)) - 1)
            ELSE DFTTaskType1
            END AS TaskType
        ,cast('' AS VARCHAR(max)) AS ObjectTypeDescription
        ,'NA' AS DelayValidationPropertyValue
        ,CASE 
            WHEN ISNULL(DFTlvl.DFTSQLCommand, '') <> ''
                THEN ISNULL(DFTlvl.DFTSQLCommand, '')
            ELSE ISNULL(DFTlvl.DFTRowSet, '')
            END AS ConnectionString
        ,cast('' AS VARCHAR(max)) AS ExpressionValue
        ,DFTConnectionManager AS ConnectionManager
        ,ISNULL(Der.SourceColumn, SrcDest.SourceColumn)
        ,ISNULL(Der.DestinationColumn, SrcDest.DestinationColumn)
        ,Der.DerivedValue
        ,Variable
        ,Lkup.LookupJoins
        ,DFTlvl.ParameterBindingParameterName
        ,SrcDest.SortKeyPosition
        ,DFTlvl.IsSortedProperty
        ,DFTlvl.MultihashcolumnSortPosition
    FROM TblDFTTaskDetails DFTlvl
    INNER JOIN pkgStats PKG ON DFTlvl.RowID = Pkg.RowID
    LEFT JOIN TblSrcDestDetails SrcDest ON DFTlvl.RowID = SrcDest.RowID
        AND DFTlvl.DataFlowDetailsRowID = SrcDest.DataFlowDetailsRowID
    LEFT JOIN TblDerivedTaskDetails Der ON DFTlvl.RowID = Der.RowID
        AND DFTlvl.DataFlowDetailsRowID = Der.DataFlowDetailsRowID
    LEFT JOIN TblLookupTaskDetails Lkup ON DFTlvl.RowID = Lkup.RowID
        AND DFTlvl.DataFlowDetailsRowID = Lkup.DataFlowDetailsRowID;

         
    PRINT '---------- Insert DFT  details in final table-----------------------';
    PRINT '-------------Insert control flow details in final table----------';

    INSERT INTO PackageAnalysis (
        RowID
        ,PackagePath
        ,PackageName
        ,Category
        ,PackageCreatorName
        ,TaskPath
        ,ObjectName
        ,ObjectType
        ,ObjectTypeDescription
        ,DelayValidationPropertyValue
        ,ObjectValue
        ,ResultSetParameterName
        ,ParameterBindingSequence
        ,ParameterBindingParameterName
        ,ExecutePackageExpression
        ,ExecutedPackageName
        ,ExecutePackageConnection
        ,Script
        ,ConnectionManagerID
        ,IsDisabled
        ,ExpressionValue
        )
    SELECT cflvl.RowID
        ,Pkg.PackagePath
        ,REPLACE(Pkg.PackagePath, REPLACE(@Path, '*.dtsx', ''), '') PackageName
        ,cast('Control Flow Task' AS VARCHAR(max)) AS Category
        ,Pkg.PackageCreatorName
        ,cflvl.TaskPath
        ,CAST(cflvl.TaskName AS VARCHAR(max)) AS TaskName
        ,CAST(TaskType AS VARCHAR(max)) AS TaskType
        ,cast(cflvl.TaskTypeDescription AS VARCHAR(max)) AS ObjectTypeDescription
        ,ISNULL(NULLIF(DelayValidationPropertyValue, ''), 'False') DelayValidationPropertyValue
        ,(
            SELECT TOP 1 cfnodes.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask";@SQLTask:SqlStatementSource[1]', 'nvarchar(max)') AS ConnectionString
            FROM cflvl.SqlTaskQry.nodes('./*') AS cfnodes(x)
            ) AS ConnectionString
        ,SQLTask.ResultSetParameterName
        ,SQLTask.ParameterBindingSequence
        ,SQLTask.ParameterBindingParameterName
        ,ExecPkgTask.ExecutePackageExpression
        ,ExecPkgTask.ExecutedPackageName
        ,ExecPkgTask.ExecutePackageConnection
        ,ScriptTsk.Script
        ,(
            SELECT TOP 1 cfnodes.x.value('declare namespace SQLTask="www.microsoft.com/sqlserver/dts/tasks/sqltask";@SQLTask:Connection[1]', 'nvarchar(max)') AS ConnectionString
            FROM cflvl.SqlTaskQry.nodes('./*') AS cfnodes(x)
            ) AS ConnectionString
        ,ISNULL(cflvl.IsDisabled, 'False')
        ,cflvl.ExpressionValue
    FROM TblControlFlowDetails cflvl
    INNER JOIN pkgStats PKG ON cflvl.RowID = Pkg.RowID
    LEFT JOIN TblSQLTaskDetails SQLTask ON cflvl.RowID = SQLTask.RowID
        AND cflvl.ControlFlowDetailsRowID = SQLTask.ControlFlowDetailsRowID
    LEFT JOIN TblExecutePackageTaskDetails ExecPkgTask ON cflvl.RowID = ExecPkgTask.RowID
        AND cflvl.ControlFlowDetailsRowID = ExecPkgTask.ControlFlowDetailsRowID
    LEFT JOIN TblScriptTaskdetails ScriptTsk ON cflvl.RowID = ScriptTsk.RowID
        AND cflvl.ControlFlowDetailsRowID = ScriptTsk.ControlFlowDetailsRowID;

    PRINT '-------------Insert control flow details in final table----------';
    PRINT '-------------Insert Connection details in  table----------';

    INSERT INTO ConnectionDetails (
        ConnectionManager
        ,ConnectionManagerID
        )
    SELECT DISTINCT ObjectName
        ,ConnectionManagerID
    FROM PackageAnalysis
    WHERE Category = 'Connection';

    PRINT '-------------Insert Connection  details in  table----------';
    PRINT '-------------Update sequence of task----------';

    UPDATE PA
    SET SequenceNo = TblPrecCon.sequenceno
    FROM PackageAnalysis PA
    INNER JOIN #tempprecedence6 TblPrecCon ON PA.RowID = TblPrecCon.RowID
        AND PA.TaskPath = TblPrecCon.Task;

    --LEFT JOIN @TblPrecedenceConstraint1 TblPrec
    --ON Final.RowID = TblPrec.RowID
    --AND Final.PackagePath = TblPrec.PackagePath
    --AND Final.TaskPath = TblPrec.TaskName
    --ORDER BY TblPrec.RowID,TblPrec.PrecOrder
    PRINT '--------------------update objecttype-------------------';

    UPDATE PackageAnalysis
    SET ObjectType = 'Sequence Container'
    WHERE ObjectType LIKE '%STOCK:SEQUENCE%'
        OR ObjectType LIKE '%(Sequence Container)%'
        OR ObjectType LIKE '%(Container)%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Data Flow Task'
    WHERE ObjectType LIKE 'SSIS.Pipeline.3'
        OR ObjectType LIKE '%(Data Flow Task)%';

    UPDATE PackageAnalysis
    SET ObjectType = 'For Loop Container'
    WHERE ObjectType LIKE '%(For Loop Container)%'
        OR ObjectType LIKE 'STOCK:FORLOOP';

    UPDATE PackageAnalysis
    SET ObjectType = 'Script Task'
    WHERE ObjectType LIKE '%(Script Task)%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Execute SQL Task'
    WHERE ObjectType LIKE '%(Execute SQL Task)%'
        OR ObjectType LIKE '%ExecuteSQLTask%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Execute Package Task'
    WHERE ObjectType LIKE '%(Execute Package Task)%'
        OR ObjectType LIKE '%ExecutePackageTask%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Foreach Loop Container'
    WHERE ObjectType LIKE '%(Foreach Loop Container)%'
        OR ObjectType LIKE 'STOCK:FOREACHLOOP';

    UPDATE PackageAnalysis
    SET ObjectType = 'File System Task'
    WHERE ObjectType LIKE '%FileSystemTask%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Script Task'
    WHERE ObjectType LIKE '%ScriptTask%';

    UPDATE PackageAnalysis
    SET ObjectType = 'Send Mail Task'
    WHERE ObjectType LIKE '%SendMailTask%';

    UPDATE PackageAnalysis
    SET ObjectType = 'ADO.NET:System.Data.SqlClient.SqlConnection'
    WHERE objecttype = 'ADO.NET:System.Data.SqlClient.SqlConnection, System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';

    UPDATE PackageAnalysis
    SET ObjectType = 'ADO.NET:System.Data.Odbc.OdbcConnection'
    WHERE objecttype = 'ADO.NET:System.Data.Odbc.OdbcConnection, System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';

    UPDATE PackageAnalysis
    SET ObjectType = 'Script Component'
    WHERE ObjectType LIKE 'Hosts user-defined data transformations, source and destination adapters'
        OR ObjectType = 'Executes a custom script.';

    UPDATE PackageAnalysis
    SET ObjectType = 'INT16'
    WHERE objecttype = '2' --OR objecttype = '0'
        ;

    UPDATE PackageAnalysis
    SET ObjectType = 'INT32'
    WHERE objecttype = '3';

    UPDATE PackageAnalysis
    SET ObjectType = 'BYTE'
    WHERE objecttype = '17';

    UPDATE PackageAnalysis
    SET ObjectType = 'BOOLEAN'
    WHERE objecttype = '11';

    UPDATE PackageAnalysis
    SET ObjectType = 'OBJECT'
    WHERE objecttype = '13';

    UPDATE PackageAnalysis
    SET ObjectType = 'STRING'
    WHERE objecttype = '8';

    UPDATE PackageAnalysis
    SET ObjectType = 'DOUBLE'
    WHERE objecttype = '5';

    UPDATE PackageAnalysis
    SET ObjectType = 'DATETIME'
    WHERE objecttype = '7';

    UPDATE PackageAnalysis
    SET ObjectType = 'INT64'
    WHERE objecttype = '20';

    UPDATE PackageAnalysis
    SET ObjectType = 'ADO NET Source'
    WHERE objecttype = 'Extracts data from a relational database by using a .NET provider.';

    UPDATE PackageAnalysis
    SET ObjectValue = Variable
    WHERE objecttype = 'Row count';

    UPDATE PackageAnalysis
    SET PackageAnalysis.ConnectionManager = ConnectionDetails.ConnectionManager
    FROM PackageAnalysis
    INNER JOIN ConnectionDetails ON PackageAnalysis.ConnectionManagerID = ConnectionDetails.ConnectionManagerID;

    UPDATE PackageAnalysis
    SET PackageAnalysis.IsDisabled = ISNULL(IsDisabled, 'False');


    DELETE
    FROM PackageAnalysis
    WHERE SourceColumn LIKE '%OLE DB Source Error Output%'
    AND (ObjectType LIKE '%Source%' OR ObjectType LIKE '%Destination%');


    DELETE
    FROM PackageAnalysis
    WHERE SourceColumn LIKE '%Derived Column Error Output%';

    DECLARE @tblparameters TABLE (
        rowid INT
        ,ParameterBindingParameterName VARCHAR(1000)
        ,taskpath VARCHAR(2000)
        ,SplitParameterBindingParameterName VARCHAR(1000)
        ,NewParameterBindingParameterName VARCHAR(1000)
        );

    INSERT INTO @tblparameters (
        rowid
        ,ParameterBindingParameterName
        ,taskpath
        ,SplitParameterBindingParameterName
        )
    SELECT DISTINCT rowid
        ,ParameterBindingParameterName
        ,taskpath
        ,O.ParameterBindingParameterNameSplit
    FROM (
        SELECT rowid
            ,ParameterBindingParameterName
            ,taskpath
            ,cast('<X>' + replace(ParameterBindingParameterName, ';', '</X><X>') + '</X>' AS XML) AS ParameterBindingParameterNameSep
        FROM PackageAnalysis
        WHERE Category = 'Data Flow Task'
            AND ParameterBindingParameterName IS NOT NULL
        ) F1
    CROSS APPLY (
        SELECT fdata.D.value('.', 'varchar(1000)') AS ParameterBindingParameterNameSplit
        FROM f1.ParameterBindingParameterNameSep.nodes('X') AS fdata(D)
        ) O
    WHERE O.ParameterBindingParameterNameSplit <> '';

    UPDATE P
    SET P.NewParameterBindingParameterName = REPLACE(SplitParameterBindingParameterName, V.VariableHexValue, 'VariableName = ' + V.ObjectName) + ',Value = ' + v.ObjectValue
    FROM @tblparameters P
    INNER JOIN TblVariableDetails v ON P.Rowid = v.Rowid
        AND CHARINDEX(V.VariableHexValue, SplitParameterBindingParameterName) > 0;

    UPDATE p
    SET ParameterBindingParameterName = t.NewParameterBindingParameterName
    FROM packageanalysis p
    INNER JOIN (
        SELECT rowid
            ,taskpath
            ,ParameterBindingParameterName
            ,stuff((
                    SELECT ';' + NewParameterBindingParameterName
                    FROM @tblparameters
                    WHERE rowid = t.rowid
                        AND taskpath = t.taskpath
                    FOR XML PATH('')
                        ,TYPE
                        ,ROOT
                    ).value('root[1]', 'nvarchar(max)'), 1, 1, '') AS NewParameterBindingParameterName
        FROM @tblparameters t
        ) t ON p.rowid = t.rowid
        AND p.taskpath = t.taskpath
        AND p.ParameterBindingParameterName = t.ParameterBindingParameterName

    CREATE NONCLUSTERED INDEX NCIX ON PackageAnalysis (
        Rowid
        ,SequenceNo
        );



    UPDATE pkg
    SET PackageSequenceNo = NewTableRowID
    FROM PackageAnalysis pkg
    JOIN 
    (SELECT  ROW_number() OVER(PARTITION BY RowID ORDER BY ISNULL(SequenceNo,-1)) as NewTableRowID,      
                SequenceNo                         ,  
                RowID,
                TableRowID
    FROM PackageAnalysis   ) newpkg
    ON pkg.RowID = newpkg.RowID
    and pkg.TableRowID = newpkg.TableRowID

    UPDATE pkg
    SET PackageProtectionLevel = CASE WHEN Stats.PackageProtectionLevel IS Null THEN 'EncryptSensitiveWithUserKey'
                                        WHEN Stats.PackageProtectionLevel = '0' THEN 'DontSaveSensitive'
                                        WHEN Stats.PackageProtectionLevel = '2' THEN 'EncryptSensitiveWithPassword'
                                        ELSE Stats.PackageProtectionLevel END
    FROM PackageAnalysis pkg
    JOIN pkgStats Stats
    ON pkg.RowID = Stats.RowID
     
    SELECT  
                RowID                              ,  
                PackageSequenceNo ,      
                SequenceNo                         ,  
            '"'+    PackagePath                          +'"' PackagePath,  
            '"'+    PackageName                          +'"' PackageName,  
            '"'+    ISNULL(IsDisabled,'')                           +'"' IsDisabled,  

            '"'+    ISNULL(Category                         ,'')     +'"' Category,  
            '"'+    ISNULL(PackageCreatorName               ,'')     +'"' PackageCreatorName,  
            '"'+    ISNULL(PackageProtectionLevel           ,'')    +'"' PackageProtectionLevel,
            '"'+    ISNULL(TaskPath                         ,'')     +'"' TaskPath,  
            '"'+    ISNULL(ObjectName                       ,'')     +'"' ObjectName,  
            '"'+    ISNULL(ObjectType                       ,'')     +'"' ObjectType,  
            '"'+    ISNULL(ObjectTypeDescription            ,'')     +'"' ObjectTypeDescription,  
            '"'+    ISNULL(DelayValidationPropertyValue     ,'')     +'"' DelayValidationPropertyValue,  
            '"'+    ISNULL(ObjectValue                      ,'')     +'"' ObjectValue,  
            '"'+    ISNULL(RetainSameConnectionProperty                      ,'')     +'"' RetainSameConnectionProperty,  
            
            '"'+    ISNULL(IsSortedProperty                 ,'')     +'"' IsSortedProperty,  
            '"'+    ISNULL(ExpressionValue                  ,'')     +'"' ExpressionValue,  
            '"'+    ISNULL(ConnectionManager                ,'')     +'"' ConnectionManager,  
            '"'+    ISNULL(SourceColumn                     ,'')     +'"' SourceColumn,  
            '"'+    ISNULL(DestinationColumn                ,'')     +'"' DestinationColumn,  
            '"'+    ISNULL(SortKeyPosition                  ,'')     +'"' SortKeyPosition,  
            '"'+    ISNULL(MultihashcolumnSortPosition                  ,'')     +'"' MultihashcolumnSortPosition,  
            
            '"'+    ISNULL(DerivedValue                     ,'')     +'"' DerivedValue,  
            '"'+    ISNULL(ResultSetParameterName           ,'')     +'"' ResultSetParameterName,  
            '"'+    ISNULL(ParameterBindingSequence         ,'')     +'"' ParameterBindingSequence,  
            '"'+    ISNULL(ParameterBindingParameterName    ,'')     +'"' ParameterBindingParameterName,  
            '"'+    ISNULL(ExecutePackageExpression         ,'')     +'"' ExecutePackageExpression,  
            '"'+    ISNULL(ExecutedPackageName              ,'')     +'"' ExecutedPackageName,  
            '"'+    ISNULL(ExecutePackageConnection         ,'')     +'"' ExecutePackageConnection,  
            '"'+    ISNULL(Script                           ,'')     +'"' Script,  
            '"'+    ISNULL(Variable                         ,'')     +'"' Variable,  
            '"'+    ISNULL(LookupJoins                      ,'')     +'"' LookupJoins
    FROM PackageAnalysis
    ORDER BY 3
        ,1;
END;
GO
