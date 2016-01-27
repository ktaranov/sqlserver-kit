USE master
GO
IF OBJECT_ID('dbo.sp_DBPermissions') IS NULL
    EXEC sp_executesql N'CREATE PROCEDURE dbo.sp_DBPermissions AS PRINT ''Stub'';'
GO
/*********************************************************************************************
sp_DBPermissions V6.0
Kenneth Fisher
  
http://www.sqlstudies.com
  
This stored procedure returns 3 data sets.  The first dataset is the list of database
principals, the second is role membership, and the third is object and database level
permissions.
     
The final 2 columns of each query are "Un-Do"/"Do" scripts.  For example removing a member
from a role or adding them to a role.  I am fairly confident in the role scripts, however, 
the scripts in the database principals query and database/object permissions query are 
works in progress.  In particular certificates, keys and column level permissions are not
scripted out.  Also while the scripts have worked flawlessly on the systems I've tested 
them on, these systems are fairly similar when it comes to security so I can't say that 
in a more complicated system there won't be the odd bug.
     
Standard disclaimer: You use scripts off of the web at your own risk.  I fully expect this
     script to work without issue but I've been known to be wrong before.
     
Parameters:
    @DBName
        If NULL use the current database, otherwise give permissions based on the parameter.
     
        There is a special case where you pass in ALL to the @DBName.  In this case the SP
        will loop through (yes I'm using a cursor) all of the DBs in sysdatabases and run
        the queries into temp tables before returning the results.  WARNINGS: If you use
        this option and have a large number of databases it will be SLOW.  If you use this
        option and don't specify any other parameters (say a specific @Principal) and have
        even a medium number of databases it will be SLOW.  Also the undo/do scripts do 
        not have USE statements in them so please take that into account.
    @Principal
        If NOT NULL then all three queries only pull for that database principal.  @Principal
        is a pattern check.  The queries check for any row where the passed in value exists.
        It uses the pattern '%' + @Principal + '%'
    @Role
        If NOT NULL then the roles query will pull members of the role.  If it is NOT NULL and
        @DBName is NULL then DB principal and permissions query will pull the principal row for
        the role and the permissions for the role.  @Role is a pattern check.  The queries 
        check for any row where the passed in value exists.  It uses the pattern '%' + @Role +
        '%'
    @Type
        If NOT NULL then all three queries will only pull principals of that type.  
        S = SQL login
        U = Windows login
        G = Windows group
        R = Server role
        C = Login mapped to a certificate
        K = Login mapped to an asymmetric key
    @ObjectName
        If NOT NULL then the third query will display permissions specific to the object 
        specified and the first two queries will display only those users with those specific
        permissions.  Unfortunately at this point only objects in sys.all_objects will work.
        This parameter uses the pattern '%' + @ObjectName + '%'
    @Permission
        If NOT NULL then the third query will display only permissions that match what is in
        the parameter.  The first two queries will display only those users with that specific
        permission.
    @LoginName
        If NOT NULL then each of the queries will only pull back database principals that
        have the same SID as a login that matches the pattern '%' + @LoginName + '%'
    @UseLikeSearch
        When this is set to 1 (the default) then the search parameters will use LIKE (and
        %'s will be added around the @Principal, @Role, @ObjectName, and @LoginName parameters).  
        When set to 0 searchs will use =.
    @IncludeMSShipped
        When this is set to 1 (the default) then all principals will be included.  When set 
        to 0 the fixed server roles and SA and Public principals will be excluded.
    @Print
        Defaults to 0, but if a 1 is passed in then the queries are not run but printed
        out instead.  This is primarily for debugging.
     
Data is ordered as follows
    1st result set: DBPrincipal
    2nd result set: RoleName, UserName if the parameter @Role is used else
                    UserName, RoleName
    3rd result set: ObjectName then Grantee_Name if the parameter @ObjectName
                    is used otherwise Grantee_Name, ObjectName
     
-- V2.0
-- 8/18/2013 – Create a stub if the SP doesn’t exist, then always do an alter
-- 8/18/2013 - Use instance collation for all concatenated strings
-- 9/04/2013 - dbo can’t be added or removed from roles.  Don’t script.
-- 9/04/2013 - Fix scripts for schema level permissions.
-- 9/04/2013 – Change print option to show values of variables not the 
--             Variable names.
-- V3.0
-- 10/5/2013 - Added @Type parameter to pull only principals of a given type.
-- 10/10/2013 - Added @ObjectName parameter to pull only permissions for a given object.
-- V4.0
-- 11/18/2013 - Added parameter names to sp_addrolemember and sp_droprolemember.
-- 11/19/2013 - Added an ORDER BY to each of the result sets.  See above for details.
-- 01/04/2014 - Add an ALL option to the DBName parameter.
-- V4.1
-- 02/07/2014 - Fix bug scripting permissions where object and schema have the same ID
-- 02/15/2014 - Add support for user defined types
-- 02/15/2014 - Fix: Add schema to object GRANT and REVOKE scripts
-- V5.0
-- 4/29/2014 - Fix: Removed extra print statements
-- 4/29/2014 - Fix: Added SET NOCOUNT ON
-- 4/29/2014 - Added a USE statement to the scripts when using the @DBName = 'All' option
-- 5/01/2014 - Added @Permission parameter
-- 5/14/2014 - Added additional permissions based on information from Kendal Van Dyke's
        post http://www.kendalvandyke.com/2014/02/using-sysobjects-when-scripting.html
-- 6/02/2014 - Added @LoginName parameter
-- V5.5
-- 7/15/2014 - Bunch of changes recommended by @SQLSoldier/"https://twitter.com/SQLSoldier"
                Primarily changing the strings to unicode & adding QUOTENAME in a few places
                I'd missed it.
-- V6.0
-- 10/19/2014 - Add @UserLikeSearch and @IncludeMSShipped parameters. 
*********************************************************************************************/
     
ALTER PROCEDURE dbo.sp_DBPermissions 
(
    @DBName sysname = NULL, 
    @Principal sysname = NULL, 
    @Role sysname = NULL, 
    @Type nvarchar(30) = NULL,
    @ObjectName sysname = NULL,
    @Permission sysname = NULL,
    @LoginName sysname = NULL,
    @UseLikeSearch bit = 1,
    @IncludeMSShipped bit = 1,
    @Print bit = 0
)
AS
   
SET NOCOUNT ON
     
DECLARE @Collation nvarchar(75) 
SET @Collation = N' COLLATE ' + CAST(SERVERPROPERTY('Collation') AS nvarchar(50))
     
DECLARE @sql nvarchar(max)
DECLARE @sql2 nvarchar(max)
DECLARE @ObjectList nvarchar(max)
DECLARE @use nvarchar(500)
DECLARE @AllDBNames sysname
     
IF @DBName IS NULL OR @DBName = N'All'
    BEGIN
        SET @use = ''
        IF @DBName IS NULL
            SET @DBName = DB_NAME()
            --SELECT @DBName = db_name(database_id) 
            --FROM sys.dm_exec_requests 
            --WHERE session_id = @@SPID
    END
ELSE
--    IF EXISTS (SELECT 1 FROM sys.databases WHERE name = @DBName)
    IF db_id(@DBName) IS NOT NULL
        SET @use = N'USE ' + QUOTENAME(@DBName) + N';' + NCHAR(13)
    ELSE
        BEGIN
            RAISERROR (N'%s is not a valid database name.',
                            16, 
                            1,
                            @DBName)
            RETURN
        END
 
DECLARE @LikeOperator nvarchar(4)
 
IF @UseLikeSearch = 1
    SET @LikeOperator = N'LIKE'
ELSE 
    SET @LikeOperator = N'='
     
IF @UseLikeSearch = 1
BEGIN 
    IF LEN(ISNULL(@Principal,'')) > 0
        SET @Principal = N'%' + @Principal + N'%'
         
    IF LEN(ISNULL(@Role,'')) > 0
        SET @Role = N'%' + @Role + N'%'
     
    IF LEN(ISNULL(@ObjectName,'')) > 0
        SET @ObjectName = N'%' + @ObjectName + N'%'
   
    IF LEN(ISNULL(@LoginName,'')) > 0
        SET @LoginName = N'%' + @LoginName + N'%'
END
   
IF @Print = 1 AND @DBName = N'All'
    BEGIN
        PRINT 'DECLARE @AllDBNames sysname'
        PRINT 'SET @AllDBNames = ''master'''
        PRINT ''
    END
   
     
--=========================================================================
-- Database Principals
SET @sql = 
    @use +
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + 
    N' DBPrincipals.name AS DBPrincipal, SrvPrincipals.name AS SrvPrincipal, DBPrincipals.sid, ' + NCHAR(13) + 
    N'   DBPrincipals.type, DBPrincipals.type_desc, DBPrincipals.default_schema_name, ' + NCHAR(13) + 
    N'   DBPrincipals.create_date, DBPrincipals.modify_date, DBPrincipals.is_fixed_role, ' + NCHAR(13) +
    N'   Authorizations.name AS Role_Authorization, ' + NCHAR(13) +  
    N'   CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' +NCHAR(13) ELSE N'' END + 
    N'           ''DROP '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''K'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''R'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'               WHEN ''A'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'               ELSE ''USER'' END + ' + NCHAR(13) + 
    N'           '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') + '';'' ELSE NULL END AS Drop_Script, ' + NCHAR(13) + 
    N'   CASE WHEN DBPrincipals.is_fixed_role = 0 AND DBPrincipals.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' +NCHAR(13) ELSE N'' END + 
    N'           ''CREATE '' + CASE DBPrincipals.[type] WHEN ''C'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''K'' THEN NULL ' + NCHAR(13) + 
    N'               WHEN ''R'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'               WHEN ''A'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'               ELSE ''USER'' END + ' + NCHAR(13) + 
    N'           '' ''+QUOTENAME(DBPrincipals.name' + @Collation + N') END + ' + NCHAR(13) + 
    N'           CASE WHEN DBPrincipals.[type] = ''R'' THEN ' + NCHAR(13) + 
    N'               ISNULL('' AUTHORIZATION ''+QUOTENAME(Authorizations.name' + @Collation + N'),'''') ' + NCHAR(13) + 
    N'               WHEN DBPrincipals.[type] = ''A'' THEN ' + NCHAR(13) + 
    N'                   ''''  ' + NCHAR(13) + 
    N'               WHEN DBPrincipals.[type] NOT IN (''C'',''K'') THEN ' + NCHAR(13) + 
    N'                   ISNULL('' FOR LOGIN '' + 
                            QUOTENAME(SrvPrincipals.name' + @Collation + N'),'' WITHOUT LOGIN'') +  ' + NCHAR(13) + 
    N'                   ISNULL('' WITH DEFAULT_SCHEMA =  ''+
                            QUOTENAME(DBPrincipals.default_schema_name' + @Collation + N'),'''') ' + NCHAR(13) + 
    N'           ELSE '''' ' + NCHAR(13) + 
    N'           END + '';'' +  ' + NCHAR(13) + 
    N'           CASE WHEN DBPrincipals.[type] NOT IN (''C'',''K'',''R'',''A'') ' + NCHAR(13) + 
    N'               AND SrvPrincipals.name IS NULL ' + NCHAR(13) + 
    N'               AND DBPrincipals.sid IS NOT NULL ' + NCHAR(13) + 
    N'               AND DBPrincipals.sid NOT IN (0x00, 0x01)  ' + NCHAR(13) + 
    N'               THEN '' -- Possible missing server principal''  ' + NCHAR(13) + 
    N'               ELSE '''' END ' + NCHAR(13) + 
    N'       AS Create_Script ' + NCHAR(13) + 
    N'FROM sys.database_principals DBPrincipals ' + NCHAR(13) + 
    N'LEFT OUTER JOIN sys.database_principals Authorizations ' + NCHAR(13) + 
    N'   ON DBPrincipals.owning_principal_id = Authorizations.principal_id ' + NCHAR(13) + 
    N'LEFT OUTER JOIN sys.server_principals SrvPrincipals ' + NCHAR(13) + 
    N'   ON DBPrincipals.sid = SrvPrincipals.sid ' + NCHAR(13) + 
    N'   AND DBPrincipals.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
    N'WHERE 1=1 '
     
IF LEN(ISNULL(@Principal,@Role)) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ' + 
            ISNULL(QUOTENAME(@Principal,N''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
     
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.type ' + @LikeOperator + N' @Type'
     
IF LEN(@LoginName) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = DBPrincipals.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
        SET @sql = @sql + N')'
    END
 
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND DBPrincipals.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND DBPrincipals.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
 
SET @sql = @sql + NCHAR(13) +
    N'ORDER BY DBPrincipals.name '
     
IF @Print = 1
    PRINT N'-- Database Principals' + NCHAR(13) + CAST(@sql AS nvarchar(max)) + NCHAR(13) + NCHAR(13)
ELSE
    IF @DBName = 'All'
        BEGIN
            -- Create temp table to store the data in
            CREATE TABLE #DBPrincipals (
                DBName sysname NULL,
                DBPrincipal sysname NULL,
                SrvPrincipal sysname NULL,
                sid varbinary(85) NULL,
                type char(1) NULL,
                type_desc nchar(60) NULL,
                default_schema_name sysname NULL,
                create_date datetime NULL,
                modify_date datetime NULL,
                is_fixed_role bit NULL,
                Role_Authorization sysname NULL,
                Drop_Script nvarchar(max) NULL,
                Create_Script nvarchar(max) NULL
                )
     
            -- Add insert statement to @sql
            SET @sql =  N'INSERT INTO #DBPrincipals ' + NCHAR(13) + 
                        @sql
     
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = N'USE ' + QUOTENAME(@AllDBNames) + N';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                        @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
            SELECT * FROM #DBPrincipals
            DROP TABLE #DBPrincipals
        END
    ELSE
        EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
            @ObjectName sysname, @Permission sysname, @LoginName sysname', 
            @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
     
--=========================================================================
-- Database Role Members
SET @sql = 
    @use + 
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + 
    N' Users.name AS UserName, Roles.name AS RoleName, ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN ' + NCHAR(13) + 
    N'   ''EXEC sp_droprolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
                N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
                ELSE Users.name END' + @Collation + 
                N','''''''')+'';'' END AS Drop_Script, ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Users.is_fixed_role = 0 AND Users.name <> ''dbo'' THEN ' + NCHAR(13) + 
    N'   ''EXEC sp_addrolemember @rolename = ''+QUOTENAME(Roles.name' + @Collation + 
                N','''''''')+'', @membername = ''+QUOTENAME(CASE WHEN Users.name = ''dbo'' THEN NULL
                ELSE Users.name END' + @Collation + 
                N','''''''')+'';'' END AS Add_Script ' + NCHAR(13) + 
    N'FROM sys.database_role_members RoleMembers ' + NCHAR(13) + 
    N'JOIN sys.database_principals Users ' + NCHAR(13) + 
    N'   ON RoleMembers.member_principal_id = Users.principal_id ' + NCHAR(13) + 
    N'JOIN sys.database_principals Roles ' + NCHAR(13) + 
    N'   ON RoleMembers.role_principal_id = Roles.principal_id ' + NCHAR(13) + 
    N'WHERE 1=1 '
         
IF LEN(ISNULL(@Principal,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' '+QUOTENAME(@Principal,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.name ' + @LikeOperator + N' @Principal'
     
IF LEN(ISNULL(@Role,'')) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' '+QUOTENAME(@Role,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Roles.name ' + @LikeOperator + N' @Role'
     
IF LEN(@Type) > 0 
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Users.type ' + @LikeOperator + N' @Type'
   
IF LEN(@LoginName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.server_principals SrvPrincipals ' + NCHAR(13) + 
        N'               WHERE Users.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
        N'                 AND SrvPrincipals.sid = Users.sid ' + NCHAR(13) + 
        N'                 AND Users.type NOT IN (''R'') ' + NCHAR(13) 
        IF @Print = 1
            SET @sql = @sql + NCHAR(13) + '  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
        ELSE
            SET @sql = @sql + NCHAR(13) + '  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@ObjectName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.all_objects [Objects] ' + NCHAR(13) + 
        N'               INNER JOIN sys.database_permissions Permission ' + NCHAR(13) +  
        N'                   ON Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'               WHERE Permission.major_id = [Objects].object_id ' + NCHAR(13) + 
        N'                 AND Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
        ELSE
            SET @sql = @sql + N'                 AND [Objects].name ' + @LikeOperator + N' @ObjectName'
   
        SET @sql = @sql + N')'
    END
   
IF LEN(@Permission) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.database_permissions Permission ' + NCHAR(13) +  
        N'               WHERE Permission.grantee_principal_id = Users.principal_id ' + NCHAR(13)
           
        IF @Print = 1
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''') 
        ELSE
            SET @sql = @sql + N'                 AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
        SET @sql = @sql + N')'
    END
   
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND Users.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND Users.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
 
IF LEN(@Role) > 0
    SET @sql = @sql + NCHAR(13) +
        N'ORDER BY Roles.name, Users.name '
ELSE
    SET @sql = @sql + NCHAR(13) +
        N'ORDER BY Users.name, Roles.name '
     
IF @Print = 1
    PRINT N'-- Database Role Members' + NCHAR(13) + CAST(@sql AS nvarchar(max)) + NCHAR(13) + NCHAR(13)
ELSE
    IF @DBName = 'All'
        BEGIN
            -- Create temp table to store the data in
            CREATE TABLE #DBRoles (
                DBName sysname NULL,
                UserName sysname NULL,
                RoleName sysname NULL,
                Drop_Script nvarchar(max) NULL,
                Add_Script nvarchar(max) NULL
                )
     
            -- Add insert statement to @sql
            SET @sql =  'INSERT INTO #DBRoles ' + NCHAR(13) + 
                        @sql
     
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = 'USE ' + QUOTENAME(@AllDBNames) + ';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                        @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
            SELECT * FROM #DBRoles
            DROP TABLE #DBRoles
        END
    ELSE
        EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
            @ObjectName sysname, @Permission sysname, @LoginName sysname', 
            @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
     
--=========================================================================
-- Database & object Permissions
SET @ObjectList =
    N'; WITH ObjectList AS (' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName , ' + NCHAR(13) + 
    N'       name ' + @Collation + ' AS name, ' + NCHAR(13) + 
    N'       database_id AS id, ' + NCHAR(13) + 
    N'       ''DATABASE'' AS class_desc,' + NCHAR(13) + 
    N'       '''' AS class ' + NCHAR(13) + 
    N'   FROM master.sys.databases' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT SCHEMA_NAME(sys.all_objects.schema_id) ' + @Collation + N' AS SchemaName,' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       object_id AS id, ' + NCHAR(13) + 
    N'       ''OBJECT_OR_COLUMN'' AS class_desc,' + NCHAR(13) + 
    N'       ''OBJECT'' AS class ' + NCHAR(13) + 
    N'   FROM sys.all_objects' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT name ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       NULL AS name, ' + NCHAR(13) + 
    N'       schema_id AS id, ' + NCHAR(13) + 
    N'       ''SCHEMA'' AS class_desc,' + NCHAR(13) + 
    N'       ''SCHEMA'' AS class ' + NCHAR(13) + 
    N'   FROM sys.schemas' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       principal_id AS id, ' + NCHAR(13) + 
    N'       ''DATABASE_PRINCIPAL'' AS class_desc,' + NCHAR(13) + 
    N'       CASE type_desc ' + NCHAR(13) + 
    N'           WHEN ''APPLICATION_ROLE'' THEN ''APPLICATION ROLE'' ' + NCHAR(13) + 
    N'           WHEN ''DATABASE_ROLE'' THEN ''ROLE'' ' + NCHAR(13) + 
    N'           ELSE ''USER'' END AS class ' + NCHAR(13) + 
    N'   FROM sys.database_principals' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       assembly_id AS id, ' + NCHAR(13) + 
    N'       ''ASSEMBLY'' AS class_desc,' + NCHAR(13) + 
    N'       ''ASSEMBLY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.assemblies' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) 
 
SET @ObjectList = @ObjectList + 
    N'   SELECT SCHEMA_NAME(sys.types.schema_id) ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       user_type_id AS id, ' + NCHAR(13) + 
    N'       ''TYPE'' AS class_desc,' + NCHAR(13) + 
    N'       ''TYPE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.types' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT SCHEMA_NAME(schema_id) ' + @Collation + N' AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       xml_collection_id AS id, ' + NCHAR(13) + 
    N'       ''XML_SCHEMA_COLLECTION'' AS class_desc,' + NCHAR(13) + 
    N'       ''XML SCHEMA COLLECTION'' AS class ' + NCHAR(13) + 
    N'   FROM sys.xml_schema_collections' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       message_type_id AS id, ' + NCHAR(13) + 
    N'       ''MESSAGE_TYPE'' AS class_desc,' + NCHAR(13) + 
    N'       ''MESSAGE TYPE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.service_message_types' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       service_contract_id AS id, ' + NCHAR(13) + 
    N'       ''SERVICE_CONTRACT'' AS class_desc,' + NCHAR(13) + 
    N'       ''CONTRACT'' AS class ' + NCHAR(13) + 
    N'   FROM sys.service_contracts' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       service_id AS id, ' + NCHAR(13) + 
    N'       ''SERVICE'' AS class_desc,' + NCHAR(13) + 
    N'       ''SERVICE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.services' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       remote_service_binding_id AS id, ' + NCHAR(13) + 
    N'       ''REMOTE_SERVICE_BINDING'' AS class_desc,' + NCHAR(13) + 
    N'       ''REMOTE SERVICE BINDING'' AS class ' + NCHAR(13) + 
    N'   FROM sys.remote_service_bindings' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       route_id AS id, ' + NCHAR(13) + 
    N'       ''ROUTE'' AS class_desc,' + NCHAR(13) + 
    N'       ''ROUTE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.routes' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       fulltext_catalog_id AS id, ' + NCHAR(13) + 
    N'       ''FULLTEXT_CATALOG'' AS class_desc,' + NCHAR(13) + 
    N'       ''FULLTEXT CATALOG'' AS class ' + NCHAR(13) + 
    N'   FROM sys.fulltext_catalogs' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       symmetric_key_id AS id, ' + NCHAR(13) + 
    N'       ''SYMMETRIC_KEY'' AS class_desc,' + NCHAR(13) + 
    N'       ''SYMMETRIC KEY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.symmetric_keys' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       certificate_id AS id, ' + NCHAR(13) + 
    N'       ''CERTIFICATE'' AS class_desc,' + NCHAR(13) + 
    N'       ''CERTIFICATE'' AS class ' + NCHAR(13) + 
    N'   FROM sys.certificates' + NCHAR(13) + 
    N'   UNION ALL' + NCHAR(13) + 
    N'   SELECT NULL AS SchemaName, ' + NCHAR(13) + 
    N'       name ' + @Collation + N' AS name, ' + NCHAR(13) + 
    N'       asymmetric_key_id AS id, ' + NCHAR(13) + 
    N'       ''ASYMMETRIC_KEY'' AS class_desc,' + NCHAR(13) + 
    N'       ''ASYMMETRIC KEY'' AS class ' + NCHAR(13) + 
    N'   FROM sys.asymmetric_keys' + NCHAR(13) +  
    N'   ) ' + NCHAR(13)
   
    SET @sql =
    N'SELECT ' + CASE WHEN @DBName = 'All' THEN N'@AllDBNames' ELSE N'''' + @DBName + N'''' END + N' AS DBName,' + NCHAR(13) + 
    N' Grantee.name AS Grantee_Name, Grantor.name AS Grantor_Name, ' + NCHAR(13) + 
    N'   Permission.class_desc, Permission.permission_name, ' + NCHAR(13) + 
    N'   ObjectList.name AS ObjectName, ' + NCHAR(13) + 
    N'   ObjectList.SchemaName, ' + NCHAR(13) + 
    N'   Permission.state_desc,  ' + NCHAR(13) + 
    N'   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   ''REVOKE '' + ' + NCHAR(13) + 
    N'   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT OPTION FOR '' ELSE '''' END + ' + NCHAR(13) + 
    N'   '' '' + Permission.permission_name' + @Collation + N' +  ' + NCHAR(13) + 
    N'       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + ' + NCHAR(13) + 
    N'           ObjectList.class + ''::'' +  ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + ' + NCHAR(13) + 
    N'           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.name),'''') ' + NCHAR(13) + 
    N'           ' + @Collation + ' + '' '' ELSE '''' END + ' + NCHAR(13) + 
    N'       '' FROM '' + QUOTENAME(Grantee.name' + @Collation + N')  + ''; '' END AS Revoke_Statement, ' + NCHAR(13) + 
    N'   CASE WHEN Grantee.is_fixed_role = 0 AND Grantee.name <> ''dbo'' THEN ' + NCHAR(13) + 
    CASE WHEN @DBName = 'All' THEN N'   ''USE '' + QUOTENAME(@AllDBNames) + ''; '' + ' + NCHAR(13) ELSE N'' END + 
    N'   CASE WHEN Permission.[state]  = ''W'' THEN ''GRANT'' ELSE Permission.state_desc' + @Collation + 
            N' END + ' + NCHAR(13) + 
    N'       '' '' + Permission.permission_name' + @Collation + N' + ' + NCHAR(13) + 
    N'       CASE WHEN Permission.major_id <> 0 THEN '' ON '' + ' + NCHAR(13) + 
    N'           ObjectList.class + ''::'' +  ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.SchemaName),'''') + ' + NCHAR(13) + 
    N'           CASE WHEN ObjectList.SchemaName + ObjectList.name IS NULL THEN '''' ELSE ''.'' END + ' + NCHAR(13) + 
    N'           ISNULL(QUOTENAME(ObjectList.name),'''') ' + NCHAR(13) + 
    N'           ' + @Collation + N' + '' '' ELSE '''' END + ' + NCHAR(13) + 
    N'       '' TO '' + QUOTENAME(Grantee.name' + @Collation + N')  + '' '' +  ' + NCHAR(13) + 
    N'       CASE WHEN Permission.[state]  = ''W'' THEN '' WITH GRANT OPTION '' ELSE '''' END +  ' + NCHAR(13) + 
    N'       '' AS ''+ QUOTENAME(Grantor.name' + @Collation + N')+'';'' END AS Grant_Statement ' + NCHAR(13) + 
    N'FROM sys.database_permissions Permission ' + NCHAR(13) + 
    N'JOIN sys.database_principals Grantee ' + NCHAR(13) + 
    N'   ON Permission.grantee_principal_id = Grantee.principal_id ' + NCHAR(13) + 
    N'JOIN sys.database_principals Grantor ' + NCHAR(13) + 
    N'   ON Permission.grantor_principal_id = Grantor.principal_id ' + NCHAR(13) + 
    N'LEFT OUTER JOIN ObjectList ' + NCHAR(13) + 
    N'   ON Permission.major_id = ObjectList.id ' + NCHAR(13) + 
    N'   AND Permission.class_desc = ObjectList.class_desc ' + NCHAR(13) + 
    N'WHERE 1=1 '
     
IF LEN(ISNULL(@Principal,@Role)) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ' + ISNULL(QUOTENAME(@Principal,''''),QUOTENAME(@Role,'''')) 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.name ' + @LikeOperator + N' ISNULL(@Principal,@Role) '
             
IF LEN(@Type) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' ' + QUOTENAME(@Type,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Grantee.type ' + @LikeOperator + N' @Type'
     
IF LEN(@ObjectName) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' ' + QUOTENAME(@ObjectName,'''') 
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND ObjectList.name ' + @LikeOperator + N' @ObjectName '
     
IF LEN(@Permission) > 0
    IF @Print = 1
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' ' + QUOTENAME(@Permission,'''')
    ELSE
        SET @sql = @sql + NCHAR(13) + N'  AND Permission.permission_name ' + @LikeOperator + N' @Permission'
   
IF LEN(@LoginName) > 0
    BEGIN
        SET @sql = @sql + NCHAR(13) + 
        N'   AND EXISTS (SELECT 1 ' + NCHAR(13) + 
        N'               FROM sys.server_principals SrvPrincipals ' + NCHAR(13) + 
        N'               WHERE SrvPrincipals.sid = Grantee.sid ' + NCHAR(13) + 
        N'                 AND Grantee.sid NOT IN (0x00, 0x01) ' + NCHAR(13) + 
        N'                 AND Grantee.type NOT IN (''R'') ' + NCHAR(13) 
        IF @Print = 1
            SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' ' + QUOTENAME(@LoginName,'''')
        ELSE
            SET @sql = @sql + NCHAR(13) + N'  AND SrvPrincipals.name ' + @LikeOperator + N' @LoginName'
   
        SET @sql = @sql + ')'
    END
 
IF @IncludeMSShipped = 0
    SET @sql = @sql + NCHAR(13) + N'  AND Grantee.is_fixed_role = 0 ' + NCHAR(13) + 
                '  AND Grantee.name NOT IN (''dbo'',''public'',''INFORMATION_SCHEMA'',''guest'',''sys'') '
   
IF LEN(@ObjectName) > 0
    SET @sql = @sql + NCHAR(13) +
        N'ORDER BY ObjectList.name, Grantee.name '
ELSE
    SET @sql = @sql + NCHAR(13) +
        N'ORDER BY Grantee.name, ObjectList.name '
     
IF @Print = 1
    BEGIN
        SET @sql = @use+@ObjectList+@sql
        PRINT '-- Database & object Permissions' 
        PRINT CAST(@sql AS nvarchar(max))
    END
ELSE
    IF @DBName = 'All'
        BEGIN
            -- Create temp table to store the data in
            CREATE TABLE #DBPermissions (
                DBName sysname NULL,
                Grantee_Name sysname NULL,
                Grantor_Name sysname NULL,
                class_desc nvarchar(60) NULL,
                permission_name nvarchar(128) NULL,
                ObjectName sysname NULL,
                SchemaName sysname NULL,
                state_desc nvarchar(60) NULL,
                Revoke_Script nvarchar(max) NULL,
                Grant_Script nvarchar(max) NULL
                )
     
            -- Add insert statement to @sql
            SET @sql =  @use + @ObjectList + 
                        N'INSERT INTO #DBPermissions ' + NCHAR(13) + 
                        @sql
     
            -- Declare a READ_ONLY cursor to loop through the databases
            DECLARE cur_DBList CURSOR
            READ_ONLY
            FOR SELECT name FROM sys.databases ORDER BY name
     
            OPEN cur_DBList
     
            FETCH NEXT FROM cur_DBList INTO @AllDBNames
            WHILE (@@fetch_status <> -1)
            BEGIN
                IF (@@fetch_status <> -2)
                BEGIN
                    SET @sql2 = 'USE ' + QUOTENAME(@AllDBNames) + ';' + NCHAR(13) + @sql
                    EXEC sp_executesql @sql2, 
                        N'@Principal sysname, @Role sysname, @Type nvarchar(30), @ObjectName sysname, 
                            @AllDBNames sysname, @Permission sysname, @LoginName sysname', 
                        @Principal, @Role, @Type, @ObjectName, @AllDBNames, @Permission, @LoginName
                    -- PRINT @sql2
                END
                FETCH NEXT FROM cur_DBList INTO @AllDBNames
            END
     
            CLOSE cur_DBList
            DEALLOCATE cur_DBList
            SELECT * FROM #DBPermissions
            DROP TABLE #DBPermissions
        END
    ELSE
        BEGIN
            SET @sql = @use + @ObjectList + @sql
            EXEC sp_executesql @sql, N'@Principal sysname, @Role sysname, @Type nvarchar(30), 
                @ObjectName sysname, @Permission sysname, @LoginName sysname', 
                @Principal, @Role, @Type, @ObjectName, @Permission, @LoginName
        END
GO
