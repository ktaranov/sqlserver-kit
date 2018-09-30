/*
Author: Jeremy
Modified by: John Zabroski
Original link: https://stackoverflow.com/a/52320673/2298061

Security Audit Report
1) List all access provisioned to a sql user or windows user/group directly 
2) List all access provisioned to a sql user or windows user/group through a database or application role
3) List all access provisioned to the public role

Columns Returned:
UserName         : SQL or Windows/Active Directory user account.  This could also be an Active Directory group.
UserType         : Value will be either 'SQL User' or 'Windows User'.  This reflects the type of user defined for the 
                  SQL Server user account.
PrinciaplUserName: if UserName is not blank, then UserName else DatabaseUserName
PrincipalType    : Possible values are 'SQL User', 'Windows User', 'Database Role', 'Windows Group'
DatabaseUserName : Name of the associated user as defined in the database user account.  The database user may not be the
                   same as the server user.
Role             : The role name.  This will be null if the associated permissions to the object are defined at directly
                   on the user account, otherwise this will be the name of the role that the user is a member of.
PermissionType   : Type of permissions the user/role has on an object. Examples could include CONNECT, EXECUTE, SELECT
                   DELETE, INSERT, ALTER, CONTROL, TAKE OWNERSHIP, VIEW DEFINITION, etc.
                   This value may not be populated for all roles.  Some built in roles have implicit permission
                   definitions.
PermissionState  : Reflects the state of the permission type, examples could include GRANT, DENY, etc.
                   This value may not be populated for all roles.  Some built in roles have implicit permission
                   definitions.
ObjectType       : Type of object the user/role is assigned permissions on.  Examples could include USER_TABLE, 
                   SQL_SCALAR_FUNCTION, SQL_INLINE_TABLE_VALUED_FUNCTION, SQL_STORED_PROCEDURE, VIEW, etc.   
                   This value may not be populated for all roles.  Some built in roles have implicit permission
                   definitions.          
ObjectName       : Name of the object that the user/role is assigned permissions on.  
                   This value may not be populated for all roles.  Some built in roles have implicit permission
                   definitions.
ColumnName       : Name of the column of the object that the user/role is assigned permissions on. This value
                   is only populated if the object is a table, view or a table value function.                 
*/

DECLARE @HideDatabaseDiagrams BIT = 1;

--List all access provisioned to a sql user or windows user/group directly 
SELECT  
    [UserName] = CASE princ.[type]
                    WHEN 'S' THEN princ.[name]
                    WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                    WHEN 'R' THEN NULL -- Database Role
                    WHEN 'G' THEN NULL -- Windows Group
                    ELSE NULL
                 END,
    [UserType] = CASE princ.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                    WHEN 'R' THEN NULL -- Database Role
                    WHEN 'G' THEN NULL -- Windows Group
                    ELSE princ.[type]
                 END,
    [PrincipalUserName] = COALESCE(
                    CASE princ.[type]
                        WHEN 'S' THEN princ.[name]
                        WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                        WHEN 'R' THEN NULL -- Database Role
                        WHEN 'G' THEN NULL -- Windows Group
                        ELSE NULL
                     END,
                     princ.[name]
                 ),
    [PrincipalType] = CASE princ.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                    WHEN 'R' THEN 'Database Role'
                    WHEN 'G' THEN 'Windows Group'
                 END, 
    [DatabaseUserName] = princ.[name],
    [Role] = null,
    [PermissionType] = perm.[permission_name],
    [PermissionState] = perm.[state_desc],
    [ObjectType] = obj.type_desc,--perm.[class_desc],
    [ObjectSchema] = OBJECT_SCHEMA_NAME(perm.major_id),
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --database user
    sys.database_principals princ
LEFT JOIN
    --Login accounts
    sys.login_token ulogin on princ.[sid] = ulogin.[sid]
LEFT JOIN        
    --Permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = princ.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col ON col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
LEFT JOIN
    sys.objects obj ON perm.[major_id] = obj.[object_id]
WHERE 
    princ.[type] in ('S','U')
    AND CASE
        WHEN @HideDatabaseDiagrams = 1 AND
        princ.[name] = 'guest'
        AND (
            (
                obj.type_desc = 'SQL_SCALAR_FUNCTION'
                AND OBJECT_NAME(perm.major_id) = 'fn_diagramobjects'
            )
            OR (
                obj.type_desc = 'SQL_STORED_PROCEDURE'
                AND OBJECT_NAME(perm.major_id) IN
                (
                    N'sp_alterdiagram',
                    N'sp_creatediagram',
                    N'sp_dropdiagram',
                    N'sp_helpdiagramdefinition',
                    N'sp_helpdiagrams',
                    N'sp_renamediagram'
                )
            )
        )
        THEN 0
        ELSE 1
    END = 1
UNION
--List all access provisioned to a sql user or windows user/group through a database or application role
SELECT  
    [UserName] = CASE memberprinc.[type] 
                    WHEN 'S' THEN memberprinc.[name]
                    WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                    WHEN 'R' THEN NULL -- Database Role
                    WHEN 'G' THEN NULL -- Windows Group
                    ELSE NULL
                 END,
    [UserType] = CASE memberprinc.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                    WHEN 'R' THEN NULL -- Database Role
                    WHEN 'G' THEN NULL -- Windows Group
                 END, 
    [PrincipalUserName] = COALESCE(
                    CASE memberprinc.[type] 
                        WHEN 'S' THEN memberprinc.[name]
                        WHEN 'U' THEN ulogin.[name] COLLATE Latin1_General_CI_AI
                        WHEN 'R' THEN NULL -- Database Role
                        WHEN 'G' THEN NULL -- Windows Group
                        ELSE NULL
                     END,
                     memberprinc.[name]
                 ),
    [PrincipalType] = CASE memberprinc.[type]
                    WHEN 'S' THEN 'SQL User'
                    WHEN 'U' THEN 'Windows User'
                    WHEN 'R' THEN 'Database Role'
                    WHEN 'G' THEN 'Windows Group'
                 END, 
    [DatabaseUserName] = memberprinc.[name],
    [Role] = roleprinc.[name],
    [PermissionType] = perm.[permission_name],
    [PermissionState] = perm.[state_desc],
    [ObjectType] = obj.type_desc,--perm.[class_desc],
    [ObjectSchema] = OBJECT_SCHEMA_NAME(perm.major_id),
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --Role/member associations
    sys.database_role_members members
JOIN
    --Roles
    sys.database_principals roleprinc ON roleprinc.[principal_id] = members.[role_principal_id]
JOIN
    --Role members (database users)
    sys.database_principals memberprinc ON memberprinc.[principal_id] = members.[member_principal_id]
LEFT JOIN
    --Login accounts
    sys.login_token ulogin on memberprinc.[sid] = ulogin.[sid]
LEFT JOIN        
    --Permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = roleprinc.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col on col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
LEFT JOIN
    sys.objects obj ON perm.[major_id] = obj.[object_id]
WHERE    
    CASE
        WHEN @HideDatabaseDiagrams = 1 AND
        memberprinc.[name] = 'guest'
        AND (
            (
                obj.type_desc = 'SQL_SCALAR_FUNCTION'
                AND OBJECT_NAME(perm.major_id) = 'fn_diagramobjects'
            )
            OR (
                obj.type_desc = 'SQL_STORED_PROCEDURE'
                AND OBJECT_NAME(perm.major_id) IN
                (
                    N'sp_alterdiagram',
                    N'sp_creatediagram',
                    N'sp_dropdiagram',
                    N'sp_helpdiagramdefinition',
                    N'sp_helpdiagrams',
                    N'sp_renamediagram'
                )
            )
        )
        THEN 0
        ELSE 1
    END = 1
UNION
--List all access provisioned to the public role, which everyone gets by default
SELECT  
    [UserName] = '{All Users}',
    [UserType] = '{All Users}',
    [PrincipalUserName] = '{All Users}',
    [PrincipalType] = '{All Users}',
    [DatabaseUserName] = '{All Users}',
    [Role] = roleprinc.[name],
    [PermissionType] = perm.[permission_name],
    [PermissionState] = perm.[state_desc],
    [ObjectType] = obj.type_desc,--perm.[class_desc],
    [ObjectSchema] = OBJECT_SCHEMA_NAME(perm.major_id),
    [ObjectName] = OBJECT_NAME(perm.major_id),
    [ColumnName] = col.[name]
FROM    
    --Roles
    sys.database_principals roleprinc
LEFT JOIN        
    --Role permissions
    sys.database_permissions perm ON perm.[grantee_principal_id] = roleprinc.[principal_id]
LEFT JOIN
    --Table columns
    sys.columns col on col.[object_id] = perm.major_id 
                    AND col.[column_id] = perm.[minor_id]
JOIN 
    --All objects   
    sys.objects obj ON obj.[object_id] = perm.[major_id]
WHERE
    --Only roles
    roleprinc.[type] = 'R' AND
    --Only public role
    roleprinc.[name] = 'public' AND
    --Only objects of ours, not the MS objects
    obj.is_ms_shipped = 0
    AND CASE
        WHEN @HideDatabaseDiagrams = 1 AND
        roleprinc.[name] = 'public'
        AND (
            (
                obj.type_desc = 'SQL_SCALAR_FUNCTION'
                AND OBJECT_NAME(perm.major_id) = 'fn_diagramobjects'
            )
            OR (
                obj.type_desc = 'SQL_STORED_PROCEDURE'
                AND OBJECT_NAME(perm.major_id) IN
                (
                    N'sp_alterdiagram',
                    N'sp_creatediagram',
                    N'sp_dropdiagram',
                    N'sp_helpdiagramdefinition',
                    N'sp_helpdiagrams',
                    N'sp_renamediagram'
                )
            )
        )
        THEN 0
        ELSE 1
    END = 1
ORDER BY
    princ.[name],
    OBJECT_NAME(perm.major_id),
    col.[name],
    perm.[permission_name],
    perm.[state_desc],
    obj.type_desc;
