/*

This script lists all permissions given to all principals on all
database objects. Optionally, you can filter by a single user or object
using the @singleUser and/or @singleObject variables:

*/

DECLARE @singleUser sysname=NULL,
        @singleObject sysname=NULL;

/*

Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source: http://sqlsunday.com/downloads/



DISCLAIMER: This script does not make any modifications to the database, but
            may still not be suitable to run in a production environment. I
	    cannot assume any responsibility regarding the accuracy of the
	    output information, any performance impact on your server, or any
	    other consequence. This script will not show you every potential
	    security flaw in your database, you still need to apply common
	    sense. If your juristiction does not allow for this kind of
	    waiver/disclaimer, or if you do not accept these terms, you are
	    NOT allowed to store, distribute or use this code in any manner.

*/


-------------------------------------------------------------------------------

DECLARE @principals TABLE (
        [sid]            varbinary(85) NULL,
        srv_member_of    int NULL,
        srv_principal_id int NULL,
        loginName        sysname NULL,
        type_desc        nvarchar(120) NOT NULL,
        db_member_of     int NULL,
        db_principal_id  int NULL,
        userName         sysname NULL,
        inheritance      varchar(1000) NULL,
        UNIQUE CLUSTERED (srv_member_of, srv_principal_id,
                          db_member_of, db_principal_id)
);

DECLARE @serverRoles TABLE (
        srv_principal_id    int NOT NULL,
        [permission_name]   nvarchar(150) NOT NULL,
        PRIMARY KEY CLUSTERED (srv_principal_id, [permission_name])
);

DECLARE @databaseRoles TABLE (
        db_principal_id     int NOT NULL,
        [permission_name]   nvarchar(150) NOT NULL,
        PRIMARY KEY CLUSTERED (db_principal_id, [permission_name])
);

--- Lists all users and roles. This CTE also recurses through database role
--- memberships, so each user will appear once for each database role that it
--- is a member of.
-------------------------------------------------------------------------------

WITH db_principals (member_of_principal_id, principal_id, principal_name,
                    type_desc, [sid], inheritance)
AS (--- 1. Plain-vanilla users and groups:
    SELECT principal_id, principal_id, [name],
           type_desc, [sid], CAST(NULL AS varchar(100))
    FROM sys.database_principals
    WHERE [type] IN ('A', 'G', 'R', 'S', 'U') AND
          [name] NOT IN ('INFORMATION_SCHEMA', 'sys')

    UNION ALL

    --- 2. Every user and role is a member of "public":
    SELECT 0, principal_id, [name],
           type_desc, [sid], CAST('ROLE public' AS varchar(100))
    FROM sys.database_principals
    WHERE [type] IN ('A', 'G', 'S', 'U') AND
          [name] NOT IN ('INFORMATION_SCHEMA', 'sys')

    UNION ALL

    --- 3. Database role memberships:
    SELECT drm.role_principal_id, dbp.principal_id,
           dbp.[name], dbp.type_desc, dbp.[sid],
           'ROLE '+p.[name]
    FROM sys.database_principals AS dbp
    INNER JOIN sys.database_role_members AS drm ON
        drm.member_principal_id=dbp.principal_id
    INNER JOIN sys.database_principals AS p ON
        drm.role_principal_id=p.principal_id),



--- Server principals and server fixed role memberships:
-------------------------------------------------------------------------------

     srv_principals (member_of_principal_id, principal_id,
                     principal_name, type_desc, [sid], inheritance)
AS (
    --- 1. Logins
    SELECT principal_id, principal_id, [name],
           type_desc, [sid], CAST(NULL AS varchar(100))
    FROM sys.server_principals
    WHERE [type] IN ('A', 'G', 'R', 'S', 'U')

    UNION ALL

    --- 2. Every user and group is a member of "public":
    SELECT [public].principal_id, p.principal_id, p.[name],
           p.type_desc, p.[sid], CAST('public' AS varchar(100))
    FROM sys.server_principals AS p
    INNER JOIN sys.server_principals AS [public] ON
        [public].[name]='public'
    WHERE p.[type] IN ('A', 'G', 'S', 'U')

    UNION ALL

    --- 3. Recursion through fixed server role memberships:
    SELECT srm.role_principal_id, sp.principal_id,
           sp.[name], sp.type_desc, sp.[sid],
           'SERVER ROLE '+p.[name] COLLATE database_default
    FROM sys.server_principals AS sp
    INNER JOIN sys.server_role_members AS srm ON
        srm.member_principal_id=sp.principal_id
    INNER JOIN sys.server_principals AS p ON
        srm.role_principal_id=p.principal_id),



--- Merge server principals and database principals:
-------------------------------------------------------------------------------

     principals ([sid], srv_member_of, srv_principal_id,
                 loginName, type_desc, db_member_of,
                 db_principal_id, userName, inheritance)
AS (
    --- JOIN by db_member_of:
    SELECT ISNULL(sp.[sid], dp.[sid]) AS [sid],
           NULL AS srv_member_of, sp.principal_id AS srv_principal_id,
           sp.principal_name COLLATE database_default AS loginName,
           ISNULL(sp.type_desc, dp.type_desc) COLLATE database_default AS type_desc,
           dp.member_of_principal_id AS db_member_of,
           dp.principal_id AS db_principal_id,
           dp.principal_name AS userName,
           dp.inheritance
    FROM srv_principals AS sp
    FULL JOIN db_principals AS dp ON sp.[sid]=dp.[sid]

    UNION

    --- JOIN by srv_member_of:
    SELECT ISNULL(sp.[sid], dp.[sid]) AS [sid],
           sp.member_of_principal_id AS srv_member_of,
           sp.principal_id AS srv_principal_id,
           sp.principal_name COLLATE database_default AS loginName,
           ISNULL(sp.type_desc, dp.type_desc) COLLATE database_default AS type_desc,
           NULL AS db_member_of,
           dp.principal_id AS db_principal_id,
           dp.principal_name AS userName,
           sp.inheritance
    FROM srv_principals AS sp
    FULL JOIN db_principals AS dp ON sp.[sid]=dp.[sid])

INSERT INTO @principals ([sid], srv_member_of, srv_principal_id,
       loginName, type_desc, db_member_of, db_principal_id,
       userName, inheritance)
SELECT [sid], srv_member_of, srv_principal_id, loginName,
       type_desc, db_member_of, db_principal_id, userName,
       inheritance
FROM principals;

--- Built-in permissions for fixed server roles:
-------------------------------------------------------------------------------
INSERT INTO @serverRoles (srv_principal_id, [permission_name])
SELECT sp.principal_id AS srv_principal_id, p.[permission_name]
FROM sys.server_principals AS sp
INNER JOIN sys.fn_builtin_permissions('SERVER') AS p ON
      sp.[name]='bulkadmin' AND
      p.[permission_name]='ADMINISTER BULK OPERATIONS' OR

      sp.[name]='dbcreator' AND
      p.[permission_name]='CREATE ANY DATABASE' OR

      sp.[name]='diskadmin' AND
      p.[permission_name]='ALTER RESOURCES' OR

      sp.[name]='processadmin' AND
      p.[permission_name] IN ('ALTER ANY CONNECTION',
                              'ALTER SERVER STATE') OR
      sp.[name]='sysadmin' AND
      p.[permission_name]='CONTROL SERVER' OR

      sp.[name]='securityadmin' AND
      p.[permission_name]='ALTER ANY LOGIN' OR

      sp.[name]='serveradmin'  AND
      p.[permission_name] IN ('ALTER ANY ENDPOINT', 'ALTER RESOURCES',
                              'ALTER SERVER STATE', 'ALTER SETTINGS',
			      'SHUTDOWN', 'VIEW SERVER STATE') OR

      sp.[name]='setupadmin' AND
      p.[permission_name]='ALTER ANY LINKED SERVER'
WHERE sp.[type]='R';



--- Built-in permissions for fixed database roles:
-------------------------------------------------------------------------------
INSERT INTO @databaseRoles (db_principal_id, [permission_name])
SELECT dp.principal_id AS db_principal_id, p.[permission_name]
FROM sys.database_principals AS dp
INNER JOIN sys.fn_builtin_permissions('DATABASE') AS p ON
      dp.[name]='db_accessadmin' AND
      p.[permission_name] IN ('ALTER ANY USER', 'CREATE SCHEMA') OR

      dp.[name]='db_backupoperator' AND
      p.[permission_name] IN ('BACKUP DATABASE', 'BACKUP LOG', 'CHECKPOINT') OR

      dp.[name] IN ('db_datareader', 'db_denydatareader') AND
      p.[permission_name]='SELECT' OR

      dp.[name] IN ('db_datawriter', 'db_denydatawriter') AND
      p.[permission_name] IN ('INSERT', 'DELETE', 'UPDATE') OR

      dp.[name]='db_ddladmin' AND
      p.[permission_name] IN ('ALTER ANY ASSEMBLY', 'ALTER ANY ASYMMETRIC KEY',
                              'ALTER ANY CERTIFICATE', 'ALTER ANY CONTRACT',
                              'ALTER ANY DATABASE DDL TRIGGER', 'ALTER ANY DATABASE EVENT',
                              'NOTIFICATION', 'ALTER ANY DATASPACE', 'ALTER ANY FULLTEXT CATALOG',
                              'ALTER ANY MESSAGE TYPE', 'ALTER ANY REMOTE SERVICE BINDING',
                              'ALTER ANY ROUTE', 'ALTER ANY SCHEMA', 'ALTER ANY SERVICE',
                              'ALTER ANY SYMMETRIC KEY', 'CHECKPOINT', 'CREATE AGGREGATE',
                              'CREATE DEFAULT', 'CREATE FUNCTION', 'CREATE PROCEDURE',
                              'CREATE QUEUE', 'CREATE RULE', 'CREATE SYNONYM', 'CREATE TABLE',
                              'CREATE TYPE', 'CREATE VIEW', 'CREATE XML SCHEMA COLLECTION',
                              'REFERENCES') OR

      dp.[name]='db_owner' AND
      p.[permission_name]='CONTROL' OR

      dp.[name]='db_securityadmin' AND
      p.[permission_name] IN ('ALTER ANY APPLICATION ROLE', 'ALTER ANY ROLE',
                              'CREATE SCHEMA', 'VIEW DEFINITION')

WHERE dp.[type]='R' AND
      dp.is_fixed_role=1;












--- Permissions lead to other implicit permissions, either
--- within the same object class or from one class to the
--- next:
-------------------------------------------------------------------------------
WITH permissionTree (class_desc, [permission_name],
                     implicit_class_desc, implicit_permission_name)
AS (
    --- Every type of permission there is:
    SELECT class_desc COLLATE database_default, [permission_name],
           class_desc, [permission_name]
    FROM sys.fn_builtin_permissions(DEFAULT)

    UNION ALL

    --- Object/schema OWNER is the same thing as CONTROL:
    SELECT 'SCHEMA', 'OWNER', 'OBJECT', 'CONTROL' UNION ALL
    SELECT 'OBJECT', 'OWNER', 'OBJECT', 'CONTROL'

    UNION ALL

    --- Do not recurse from CONTROL SERVER, DATABASE or
    --- SCHEMA, but jump directly to OBJECT:
    SELECT 'SERVER',   'CONTROL SERVER', 'OBJECT', 'CONTROL SERVER*'   UNION ALL
    SELECT 'DATABASE', 'CONTROL',        'OBJECT', 'CONTROL DATABASE*' UNION ALL
    SELECT 'SCHEMA',   'CONTROL',        'OBJECT', 'CONTROL SCHEMA*'

    UNION ALL

    --- If you can take ownership, it cascades to underlying objects:
    SELECT DISTINCT class_desc COLLATE database_default, [permission_name], 'OBJECT', 'TAKE OWNERSHIP'
    FROM sys.fn_builtin_permissions(DEFAULT)
    WHERE [permission_name]='TAKE OWNERSHIP' AND
          class_desc IN ('DATABASE', 'SCHEMA')

    UNION ALL

    --- .. and a recursion to find all implicit permissions
    --- of all these permissions:
    ---
    --- Do not recurse CONTROL SERVER, CONTROL DATABASE or
    --- CONTROL SCHEMA - those are handled separately.
    SELECT tree.class_desc, tree.[permission_name],
           fn.class_desc, fn.[permission_name]
    FROM sys.fn_builtin_permissions(DEFAULT) AS fn
    INNER JOIN permissionTree AS tree ON

        --- Scenario 1: Covering permission in same class
        tree.implicit_class_desc=fn.class_desc AND
        tree.implicit_permission_name=fn.covering_permission_name AND
        NOT (fn.class_desc='SERVER' AND fn.covering_permission_name='CONTROL SERVER' OR
             fn.class_desc='DATABASE' AND fn.covering_permission_name='CONTROL' OR
             fn.class_desc='SCHEMA' AND fn.covering_permission_name='CONTROL' OR
             fn.class_desc='OBJECT' AND fn.covering_permission_name='CONTROL') OR

        --- Scenario 2: Covering permission in parent class
        tree.implicit_class_desc=fn.parent_class_desc AND
        tree.implicit_permission_name=fn.parent_covering_permission_name AND
        NOT (fn.parent_class_desc='SERVER' AND fn.parent_covering_permission_name='CONTROL SERVER' OR
             fn.parent_class_desc='DATABASE' AND fn.parent_covering_permission_name='CONTROL' OR
             fn.parent_class_desc='SCHEMA' AND fn.parent_covering_permission_name='CONTROL' OR
             fn.parent_class_desc='OBJECT' AND fn.parent_covering_permission_name='CONTROL')),




--- A simple UNION ALL of database and server permissions:
-------------------------------------------------------------------------------
     db_and_server_permissions (class, class_desc, major_id,
             minor_id, db_principal_id, srv_principal_id,
             [permission_name], [state], inheritance)
AS (
    --- Database permissions:
    SELECT p.class, p.class_desc, p.major_id, p.minor_id,
           u.db_principal_id, u.srv_principal_id,
           p.[permission_name] COLLATE database_default, p.[state], u.inheritance
    FROM sys.database_permissions AS p
    INNER JOIN @principals AS u ON
        p.grantee_principal_id=u.db_member_of

    UNION ALL

    --- Server-wide permissions:
    SELECT p.class, p.class_desc, p.major_id, p.minor_id,
           u.db_principal_id, u.srv_principal_id,
           p.[permission_name], p.[state], u.inheritance
    FROM sys.server_permissions AS p
    INNER JOIN @principals AS u ON
        p.grantee_principal_id=u.srv_member_of

    UNION ALL

    --- Fixed server role permissions:
    SELECT DISTINCT 100, 'SERVER', 0, 0, pr.db_principal_id,
           pr.srv_principal_id, sp.[permission_name],
           'G', 'SERVER ROLE '+pr.loginName
    FROM @serverRoles AS sp
    INNER JOIN @principals AS pr ON
        sp.srv_principal_id=pr.srv_member_of
    WHERE sp.srv_principal_id!=pr.srv_principal_id

    UNION ALL

    --- Fixed permissions for fixed database roles:
    --- * db_owner has CONTROL DATABASE.
    --- * db_datareader has SELECT on all user objects
    --- * db_datawriter has INSERT, DELETE, UPDATE on all user objects
    --- * db_deny* is equivalent to DENY on the previous two.
    SELECT DISTINCT 0, 'DATABASE', 0, 0, pr.db_principal_id,
           pr.srv_principal_id, dp.[permission_name],
           (CASE WHEN pr.userName LIKE '%deny%' THEN 'D'
            ELSE 'G' END), pr.userName
    FROM @databaseRoles AS dp
    INNER JOIN @principals AS pr ON
        dp.db_principal_id=pr.db_member_of
    WHERE dp.db_principal_id!=pr.db_principal_id

    UNION ALL

    --- Owning principals have CONTROL SCHEMA for owned schemas:
    SELECT 3, 'SCHEMA', sch.[schema_id], 0, p.db_principal_id,
           p.srv_principal_id, 'OWNER', 'G', p.inheritance
    FROM @principals AS p
    INNER JOIN sys.schemas AS sch ON
        p.db_principal_id=sch.principal_id AND
        p.db_principal_id=p.db_member_of

    UNION ALL

    --- Owning principals have CONTROL for owned objects:
    SELECT 1, 'OBJECT_OR_COLUMN', obj.[object_id], 0, p.db_principal_id,
           p.srv_principal_id, 'OWNER', 'G', p.inheritance
    FROM @principals AS p
    INNER JOIN sys.objects AS obj ON
        p.db_principal_id=obj.principal_id AND
        p.db_principal_id=p.db_member_of)



--- Regular object-based permissions:
SELECT DISTINCT
       ISNULL(sp.type_desc COLLATE database_default,
              dp.type_desc) AS principalType,
       ISNULL(sp.[name], '') AS serverLoginName,
       ISNULL(dp.[name], '') AS databaseUserName,
       obj.type_desc AS objectType,
       sch.[name]+'.'+obj.[name]+ISNULL('('+col.[name]+')', '') AS objectName,
       DENSE_RANK() OVER(
           PARTITION BY ISNULL(sp.[sid], dp.[sid]), obj.[object_id], tree.implicit_permission_name
           ORDER BY p.[state], p.inheritance
	   ) AS [row],
       p.[state],
       (CASE MIN((CASE p.[state] WHEN 'D' THEN 0 WHEN 'W' THEN 1 WHEN 'G' THEN 2 END))
           OVER (
                 PARTITION BY ISNULL(sp.[sid], dp.[sid]), obj.[object_id],
                              ISNULL(NULLIF(p.minor_id, 0), col.column_id),
                              tree.implicit_permission_name)
               WHEN 0 THEN 'DENY'
               WHEN 1 THEN 'GRANT w/ delegation'
               WHEN 2 THEN 'GRANT'
           END) AS effectiveState,
       tree.implicit_permission_name AS permission,
       REPLACE(REPLACE(ISNULL(NULLIF(ISNULL(p.inheritance+
               (CASE p.[state] WHEN 'D' THEN ' denied ' ELSE ' has ' END), '')+
                         p.[permission_name]+ISNULL(' on '+NULLIF(p.class_desc, 'OBJECT_OR_COLUMN'), ''),
                         tree.implicit_permission_name), ''),
                     ' has OWNER', ' is owner'),
                 'OWNER on ', 'owner of ') AS inheritance,
       (CASE WHEN tree.implicit_permission_name='TAKE OWNERSHIP' AND p.[state]!='D' THEN 'Can take ownership, which grants CONTROL'
             WHEN tree.[permission_name] LIKE 'ALTER%SCHEMA' AND p.[state]!='D' THEN 'Can assign SCHEMA ownership to anyone'
             WHEN tree.implicit_permission_name LIKE 'ALTER%SCHEMA' AND p.[state]!='D' THEN 'Can assign SCHEMA ownership to anyone'
             ELSE '' END) AS elevationRisk

FROM sys.database_principals AS dp
RIGHT JOIN db_and_server_permissions AS p ON dp.principal_id=p.db_principal_id
LEFT JOIN sys.server_principals AS sp ON sp.principal_id=p.srv_principal_id
INNER JOIN permissionTree AS tree ON
    REPLACE(p.class_desc, 'OBJECT_OR_COLUMN', 'OBJECT')=tree.class_desc AND
    p.[permission_name]=tree.[permission_name] AND tree.implicit_class_desc='OBJECT'
INNER JOIN sys.objects AS obj ON
     p.class=1 AND p.major_id=obj.[object_id] OR
    (p.class=3 AND p.major_id=obj.[schema_id] OR p.class IN (0, 100)) AND
         obj.[type] NOT IN ('C', 'D', 'F', 'PK', 'R', 'TA', 'TR', 'UQ')
INNER JOIN sys.schemas AS sch ON obj.[schema_id]=sch.[schema_id]
LEFT JOIN sys.columns AS col ON
    p.class=1 AND p.minor_id>0 AND
    obj.[object_id]=col.[object_id] AND
    col.column_id=p.minor_id
WHERE ISNULL(sp.[name], '') NOT IN ('sa', '##MS_PolicyTsqlExecutionLogin##') AND
      --- Don't bother with service queues, system tables and internal tables:
      obj.[type] NOT IN ('S', 'IT', 'SQ') AND (
      @singleUser IS NULL OR
      @singleUser IN (p.inheritance, dp.[name], sp.[name])) AND (
      @singleObject IS NULL OR
      @singleObject=sch.[name]+'.'+obj.[name])



UNION ALL



--- ALTER ANY LOGIN may allow user to assign permissions to others:
SELECT DISTINCT
    pr.type_desc AS principalType,
    ISNULL(pr.loginName, ''),
    ISNULL(pr.userName, ''),
    '' AS objectType,
    '' AS objectName,
    DENSE_RANK() OVER (
        PARTITION BY pr.type_desc, pr.loginName, pr.userName
        ORDER BY p.[state], p.inheritance) AS [row],
    p.[state],
    (CASE MIN((CASE p.[state] WHEN 'D' THEN 0 WHEN 'W' THEN 1 WHEN 'G' THEN 2 END))
                OVER (PARTITION BY pr.[sid], p.[permission_name])
            WHEN 0 THEN 'DENY'
            WHEN 1 THEN 'GRANT w/ delegation'
            WHEN 2 THEN 'GRANT'
        END) AS effectiveState,
    p.[permission_name] AS permission,
    ISNULL(p.inheritance+
           ISNULL(' has '+
                  NULLIF(p.[permission_name], tree.implicit_permission_name),
           ''), '') AS inheritance,
    'Can elevate permissions on users' AS elevationRisk
FROM db_and_server_permissions AS p
INNER JOIN permissionTree AS tree ON p.[permission_name]=tree.implicit_permission_name
INNER JOIN @principals AS pr ON
    p.db_principal_id=pr.db_member_of OR
    p.srv_principal_id=pr.srv_member_of
WHERE p.[permission_name]='ALTER ANY LOGIN' AND (
      @singleUser IS NULL OR
      @singleUser IN (pr.loginName, pr.userName))



UNION ALL



--- IMPERSONATE permissions, on USER and LOGIN:
SELECT DISTINCT
    pr.type_desc AS principalType,
    ISNULL(pr.loginName, ''),
    ISNULL(pr.userName, ''),
    (CASE WHEN dbp.[name] IS NOT NULL THEN 'USER'
          WHEN sp.[name] IS NOT NULL THEN 'LOGIN'
          ELSE '?' END) AS objectType,
    COALESCE('USER::'+dbp.[name],
             'LOGIN::'+sp.[name] COLLATE database_default, '') AS objectName,
    DENSE_RANK() OVER (
        PARTITION BY pr.type_desc, pr.loginName, pr.userName
        ORDER BY p.[state], p.inheritance) AS [row],
    p.[state],
    (CASE MIN((CASE p.[state] WHEN 'D' THEN 0 WHEN 'W' THEN 1 WHEN 'G' THEN 2 END))
                 OVER (PARTITION BY pr.[sid], p.[permission_name])
             WHEN 0 THEN 'DENY'
             WHEN 1 THEN 'GRANT w/ delegation'
             WHEN 2 THEN 'GRANT'
        END) AS effectiveState,
    p.[permission_name] AS permission,
    ISNULL(p.inheritance+' has IMPERSONATE on this principal', '') AS inheritance,
    'Can impersonate a user with potentially higher privileges' AS elevationRisk
FROM db_and_server_permissions AS p
INNER JOIN @principals AS pr ON
    p.db_principal_id=pr.db_member_of OR
    p.srv_principal_id=pr.srv_member_of
LEFT JOIN sys.database_principals AS dbp ON
    p.class_desc='DATABASE_PRINCIPAL' AND
    p.major_id=dbp.principal_id
LEFT JOIN sys.server_principals AS sp ON
    p.class_desc='SERVER_PRINCIPAL' AND
    p.major_id=sp.principal_id
WHERE p.[permission_name]='IMPERSONATE' AND (
      @singleUser IS NULL OR
      @singleUser IN (pr.loginName, pr.userName, dbp.[name], sp.[name]))



ORDER BY serverLoginName, databaseUserName, objectName, implicit_permission_name, [state], inheritance;
