USE master;
GO
IF (OBJECT_ID('dbo.sp_help_permissions') IS NULL) EXEC('CREATE PROCEDURE dbo.sp_help_permissions AS --');
GO
/*

This script lists all permissions by principal, securable and permission.
Optionally, you can filter these objects using the @principal, @securable,
and/or @permission parameters (using T-SQL wildcards).

The output can be tabular with permissions grouped as comma-separated lists
(using @permission_list=1) or one row for each permission (@permission_list=0).
You can also return the result as an xml OUTPUT variable, using @output_xml=1
and collecting the output from the @xml parameter.

Copyright Daniel Hutmacher under Creative Commons 4.0 license with attribution.
http://creativecommons.org/licenses/by/4.0/

Source: http://sqlsunday.com/downloads/

VERSION: 2017-09-26

DISCLAIMER: This script does not make any modifications to the database
            apart from installing and registering a stored procedure
        in the master database, but may still not be suitable to run in
        a production environment. I cannot assume any responsibility
        with regards to the accuracy of the output information, any
        performance impact on your server, or any other consequence.
        It's free software, so you assume responsibility.
        If your juristiction does not allow for this kind of
        waiver/disclaimer, or if you do not accept these terms, you are
        NOT allowed to store, distribute or use this code in any manner.

*/
ALTER PROCEDURE dbo.sp_help_permissions
    @principal                  sysname=NULL,
    @securable                  sysname=NULL,
    @permission                 sysname=NULL,
    @permission_list            bit=0,
    @output_xml                 bit=0,
    @hide_system_principals     bit=1,
    @xml                        xml=NULL OUTPUT
WITH EXECUTE AS CALLER
AS

SET NOCOUNT ON;
SET STATISTICS XML, TIME, IO OFF;
SET DEADLOCK_PRIORITY LOW;

IF (@output_xml=1) SET @permission_list=0;



-------------------------------------------------------------------------------
--- Variables and work table declarations
-------------------------------------------------------------------------------



DECLARE @name sysname;

DECLARE @xp_logininfo TABLE (
    account_name            sysname NOT NULL,
    [type]                  varchar(100) NULL,
    privilege               varchar(100) NULL,
    mapped_login_name       sysname NOT NULL,
    permission_path         sysname NOT NULL,
    _id                     int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (permission_path, mapped_login_name)
);
 
DECLARE @srv_principals TABLE (
    principal_id            int NOT NULL,
    [type_desc]             nvarchar(60) NOT NULL,
    [sid]                   varbinary(85) NULL,
    [name]                  sysname NOT NULL,
    PRIMARY KEY (principal_id)
);
 
DECLARE @srv_members TABLE (
    role_principal_id       int NOT NULL,
    member_principal_id     int NOT NULL,
    PRIMARY KEY CLUSTERED (role_principal_id, member_principal_id)
);
 
DECLARE @db_principals TABLE (
    principal_id            int NOT NULL,
    [type_desc]             nvarchar(60) NOT NULL,
    [sid]                   varbinary(85) NOT NULL,
    [name]                  sysname NOT NULL,
    member_of               int NULL,
    PRIMARY KEY (principal_id)
);
 
DECLARE @db_members TABLE (
    role_principal_id       int NOT NULL,
    member_principal_id     int NOT NULL,
    PRIMARY KEY CLUSTERED (role_principal_id, member_principal_id)
);
 
DECLARE @principals TABLE (
    declared_principal_id       int NOT NULL,
    declared_type_desc          nvarchar(60) NOT NULL,
    declared_sid                    varbinary(85) NOT NULL,
    declared_name               sysname NOT NULL,
    declared_is_server_lvl      bit NOT NULL,
    effective_principal_id      int NOT NULL,
    effective_type_desc         nvarchar(60) NOT NULL,
    effective_sid               varbinary(85) NOT NULL,
    effective_name              sysname NOT NULL,
    effective_is_server_lvl     bit NOT NULL,
    [level]                     tinyint NOT NULL,
    [path]                      nvarchar(max) NOT NULL,
    _id                         int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (declared_type_desc, declared_principal_id, effective_type_desc, effective_principal_id, _id)
);
 
DECLARE @s_public int=(SELECT principal_id FROM sys.server_principals WHERE [name]=N'public');
DECLARE @d_public int=(SELECT principal_id FROM sys.database_principals WHERE [name]=N'public');
DECLARE @sysadmin int=(SELECT principal_id FROM sys.server_principals WHERE [name]=N'sysadmin');
 
DECLARE @builtin_permissions TABLE (
    class                   nvarchar(60) NOT NULL,
    permission              nvarchar(60) NOT NULL,
    declared_class          nvarchar(60) NULL,
    declared_permission     nvarchar(60) NULL,
    UNIQUE CLUSTERED (declared_class, declared_permission, class, permission),
    UNIQUE (class, permission, declared_class, declared_permission)
);
 
DECLARE @permissions_temp TABLE (
    declared_class          nvarchar(60) COLLATE database_default NOT NULL,
    declared_permission     nvarchar(60) COLLATE database_default NOT NULL,
    class                   nvarchar(60) COLLATE database_default NOT NULL,
    permission              nvarchar(60) COLLATE database_default NOT NULL,
    [path]                  nvarchar(max) COLLATE database_default NOT NULL,
    [level]                 tinyint NOT NULL,
    _id                     int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (class, declared_class, declared_permission, [level], _id),
    UNIQUE (permission, _id)
);
 
DECLARE @permissions TABLE (
    declared_class           nvarchar(60) COLLATE database_default NOT NULL,
    declared_permission      nvarchar(60) COLLATE database_default NOT NULL,
    class                    nvarchar(60) COLLATE database_default NOT NULL,
    permission               nvarchar(4000) COLLATE database_default NOT NULL,
    [path]                   nvarchar(max) COLLATE database_default NOT NULL,
    [level]                  tinyint NOT NULL,
    _id                      int IDENTITY(1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED (class, declared_class, declared_permission, [level], _id)
);
 
DECLARE @securables_temp TABLE (
    parent_class        int NULL,
    parent_major_id     int NULL,
    class               int NOT NULL,
    major_id            int NOT NULL,
    principal_id        int NULL,
    class_desc          nvarchar(22) NOT NULL,
    qualified_name      nvarchar(max) NULL,
    is_server_lvl       int NOT NULL,
    PRIMARY KEY CLUSTERED (class, major_id)
);
 
DECLARE @securables TABLE (
    parent_class            int NOT NULL,
    parent_major_id         int NOT NULL,
    parent_qualified_name   nvarchar(255) NULL,
    class                   int NOT NULL,
    class_desc              nvarchar(60) NOT NULL,
    major_id                int NOT NULL,
    qualified_name          nvarchar(255) NULL,
    principal_id            int NULL,
    is_server_lvl           bit NOT NULL,
    [path]                  nvarchar(max) NOT NULL,
    PRIMARY KEY CLUSTERED (parent_class, parent_major_id, class, major_id)
);
 
DECLARE @rules TABLE (
    _id                     int IDENTITY(1, 1) NOT NULL,
    class                   tinyint NOT NULL,
    class_desc              nvarchar(60) NOT NULL,
    major_id                int NOT NULL,
    minor_id                int NOT NULL,
    grantee_principal_id    int NOT NULL,
    grantee_is_server_lvl   bit NOT NULL,
    [permission_name]       nvarchar(128) NOT NULL,
    [state]                 char(1) NOT NULL,
    state_desc              nvarchar(60) NOT NULL,
    inheritance             varchar(100) NULL,
    PRIMARY KEY CLUSTERED (class_desc, major_id, minor_id, grantee_is_server_lvl, _id)
);
 
 
 
-------------------------------------------------------------------------------
--- PRINCIPALS
-------------------------------------------------------------------------------
 
 
 
--- Server principals:
INSERT INTO @srv_principals
SELECT principal_id, [type_desc], [sid], [name]
FROM sys.server_principals
WHERE [sid] IS NOT NULL AND (
    @hide_system_principals=0 OR
    @hide_system_principals=1 AND [type]!='C' AND UPPER([name]) NOT LIKE N'NT SERVICE\%');
 
--- Windows users that are members of Windows group logins can be
--- resolved using xp_logininfo:
BEGIN TRANSACTION;
 
    DECLARE logincur CURSOR LOCAL FOR SELECT [name] FROM @srv_principals WHERE [type_desc]=N'WINDOWS_GROUP';
    OPEN logincur;
 
    FETCH NEXT FROM logincur INTO @name;
    WHILE (@@FETCH_STATUS=0) BEGIN;
         
        INSERT INTO @xp_logininfo
        EXECUTE sys.xp_logininfo @acctname=@name, @option='members';
 
        FETCH NEXT FROM logincur INTO @name;
    END;
 
    CLOSE logincur;
    DEALLOCATE logincur;
 
COMMIT TRANSACTION;
 
INSERT INTO @srv_principals (principal_id, [type_desc], [sid], [name])
SELECT DISTINCT -DENSE_RANK() OVER (ORDER BY account_name) AS principal_id, N'WINDOWS_LOGIN', NEWID(), account_name
FROM @xp_logininfo
WHERE account_name NOT IN (SELECT [name] FROM @srv_principals WHERE [type_desc]=N'WINDOWS_LOGIN');
 
--- Server role members:
INSERT INTO @srv_members
SELECT role_principal_id, member_principal_id
FROM sys.server_role_members;
 
--- All users are also members of the fixed server role "public":
INSERT INTO @srv_members (role_principal_id, member_principal_id)
SELECT r.principal_id, m.principal_id
FROM @srv_principals AS r
INNER JOIN @srv_principals AS m ON m.[type_desc]!='SERVER_ROLE'
WHERE r.[name]='public' AND m.principal_id>=0;
 
--- User memberships implicit from their WINDOWS_GROUP logins:
INSERT INTO @srv_members (role_principal_id, member_principal_id)
SELECT r.principal_id, m.principal_id
FROM @xp_logininfo AS xp
INNER JOIN @srv_principals AS r ON xp.permission_path=r.[name]
INNER JOIN @srv_principals AS m ON xp.account_name=m.[name];
 
--- All local database principals:
INSERT INTO @db_principals (principal_id, [type_desc], [sid], [name])
SELECT dp.principal_id, dp.[type_desc], dp.[sid], dp.[name]
FROM sys.database_principals AS dp
WHERE dp.[sid] IS NOT NULL;         --- Don't include "INFORMATION_SCHEMA" and "sys"
 
--- Implicit database principals inherited from their respective server principals:
INSERT INTO @db_principals (principal_id, [type_desc], [sid], [name])
SELECT wl.principal_id, N'WINDOWS_USER' AS [type_desc], wl.[sid], wl.[name]
FROM @srv_principals AS wg
INNER JOIN @srv_members AS m ON wg.principal_id=m.role_principal_id AND m.member_principal_id<0
INNER JOIN @srv_principals AS wl ON m.member_principal_id=wl.principal_id
INNER JOIN @db_principals AS dp ON dp.[sid]=wg.[sid];
 
--- Logins with sysadmin, except those who already have users:
INSERT INTO @db_principals (principal_id, [type_desc], [sid], [name], member_of)
SELECT (SELECT MAX(principal_id) FROM @db_principals)+
       ROW_NUMBER() OVER (ORDER BY sp.principal_id) AS principal_id,
       'USER', sp.[sid], sp.[name], dbo.principal_id
FROM @srv_principals AS sp
LEFT JOIN @db_principals AS db ON sp.[sid]=db.[sid]
INNER JOIN @db_principals AS dbo ON dbo.[name]=N'dbo'
WHERE db.[sid] IS NULL AND (
      sp.principal_id IN (SELECT grantee_principal_id FROM sys.server_permissions WHERE [permission_name]=N'CONTROL SERVER') OR
      sp.principal_id=(SELECT owner_sid FROM sys.databases WHERE database_id=DB_ID()) OR
      sp.principal_id IN (SELECT member_principal_id FROM sys.server_role_members WHERE role_principal_id=@sysadmin)
    );
 
--- All users are members of the fixed database role public:
INSERT INTO @db_members (role_principal_id, member_principal_id)
SELECT r.principal_id, m.principal_id
FROM @db_principals AS r
INNER JOIN @db_principals AS m ON m.[type_desc]!='DATABASE_ROLE'
WHERE r.[name]='public';
 
--- Database role memberships:
INSERT INTO @db_members
SELECT role_principal_id, member_principal_id
FROM sys.database_role_members;
 
--- Administrative users and the owner of the database are "members" of "dbo":
INSERT INTO @db_members
SELECT member_of, principal_id
FROM @db_principals
WHERE member_of IS NOT NULL AND member_of!=principal_id;
 
--- Putting it all together:
WITH s_cte AS (
        --- Server principals (anchor)
        SELECT principal_id AS declared_principal_id,
               [type_desc] AS declared_type_desc,
               [sid] AS declared_sid,
               [name] AS declared_name,
               principal_id AS effective_principal_id,
               [type_desc] AS effective_type_desc,
               [sid] AS effective_sid,
               [name] AS effective_name,
               0 AS [level],
               CAST((CASE WHEN [name] IN ('sa') THEN N'"'+[name]+N'"' ELSE LOWER(REPLACE([type_desc], N'_', N' ')) COLLATE database_default+N' "'+[name]+N'"' END) AS nvarchar(max)) AS [path]
        FROM @srv_principals AS p
 
        UNION ALL
 
        --- (recursion)
        SELECT s_cte.declared_principal_id,
               s_cte.declared_type_desc,
               s_cte.declared_sid,
               s_cte.declared_name,
               sp.principal_id AS effective_principal_id,
               sp.[type_desc] AS effective_type_desc,
               sp.[sid] AS effective_sid,
               sp.[name] AS effective_name,
               s_cte.[level]+1,
               s_cte.[path]+' -> '+CAST((CASE WHEN sp.[name] IN ('sa') THEN N'"'+sp.[name]+N'"' ELSE LOWER(REPLACE(sp.[type_desc], N'_', N' ')) COLLATE database_default+N' "'+sp.[name]+N'"' END) AS nvarchar(max)) AS [path]
        FROM @srv_members AS srm
        INNER JOIN s_cte ON s_cte.effective_principal_id=srm.role_principal_id
        INNER JOIN @srv_principals AS sp ON srm.member_principal_id=sp.principal_id),
 
    d_cte AS (
        --- Database principals (anchor)
        SELECT principal_id AS declared_principal_id,
               [type_desc] AS declared_type_desc,
               [sid] AS declared_sid,
               [name] AS declared_name,
               principal_id AS effective_principal_id,
               [type_desc] AS effective_type_desc,
               [sid] AS effective_sid,
               [name] AS effective_name,
               0 AS [level],
               CAST((CASE WHEN [name] IN ('dbo') THEN N'"'+[name]+N'"' ELSE LOWER(REPLACE([type_desc], N'_', N' ')) COLLATE database_default+N' "'+[name]+N'"' END) AS nvarchar(max)) AS [path]
        FROM @db_principals
 
        UNION ALL
 
        --- (recursion)
        SELECT d_cte.declared_principal_id,
               d_cte.declared_type_desc,
               d_cte.declared_sid,
               d_cte.declared_name,
               dp.principal_id AS effective_principal_id,
               dp.[type_desc] AS effective_type_desc,
               dp.[sid] AS effective_sid,
               dp.[name] AS effective_name,
               d_cte.[level]+1,
               d_cte.[path]+' -> '+CAST((CASE WHEN dp.[name] IN ('dbo') THEN N'"'+dp.[name]+N'"' ELSE LOWER(REPLACE(dp.[type_desc], N'_', N' ')) COLLATE database_default+N' "'+dp.[name]+N'"' END) AS nvarchar(max)) AS [path]
        FROM @db_members AS drm
        INNER JOIN d_cte ON d_cte.effective_principal_id=drm.role_principal_id
        INNER JOIN @db_principals AS dp ON drm.member_principal_id=dp.principal_id),
 
    cte AS (
        --- Server principal hierarchy
        SELECT declared_principal_id,
               declared_type_desc,
               declared_sid,
               declared_name,
               1 AS declared_is_server_lvl,
               effective_principal_id,
               effective_type_desc,
               effective_sid,
               effective_name,
               1 AS effective_is_server_lvl,
               [level],
               [path]
        FROM s_cte
 
        UNION ALL
 
        --- Database principal hierarchy
        SELECT declared_principal_id,
               declared_type_desc,
               declared_sid,
               declared_name,
               0 AS declared_is_server_lvl,
               effective_principal_id,
               effective_type_desc,
               effective_sid,
               effective_name,
               0 AS effective_is_server_lvl,
               [level],
               CAST([path] AS nvarchar(max)) AS [path]
        FROM d_cte
 
        UNION ALL
 
        --- Connecting the server and database principal hierarchies
        SELECT s_cte.declared_principal_id,
               s_cte.declared_type_desc,
               s_cte.declared_sid,
               s_cte.declared_name,
               1 AS declared_is_server_lvl,
               d_cte.effective_principal_id,
               d_cte.effective_type_desc,
               d_cte.effective_sid,
               d_cte.effective_name,
               0 AS effective_is_server_lvl,
               s_cte.[level]+d_cte.[level]+1,
               s_cte.[path]+N' --> '+d_cte.[path] AS [path]
        FROM s_cte
        INNER JOIN d_cte ON s_cte.effective_sid=d_cte.declared_sid
        )
 
INSERT INTO @principals
SELECT * FROM cte
WHERE @principal IS NULL OR
      [path] LIKE N'%'+@principal+N'%';
 
 
 
-------------------------------------------------------------------------------
--- Permissions
-------------------------------------------------------------------------------
 
 
 
INSERT INTO @builtin_permissions (class, permission, declared_class, declared_permission)
SELECT bip.class_desc AS class, bip.[permission_name] AS permission,
       x.declared_class, x.declared_permission_name
FROM sys.fn_builtin_permissions(DEFAULT) AS bip
OUTER APPLY (
    --- Every permission can inherit permissions from up to two
    --- other permissions: from a parent class, as well as from
    --- other permissions in the same class:
    SELECT bip.parent_class_desc,
            bip.parent_covering_permission_name
    WHERE bip.parent_covering_permission_name!=''
    UNION ALL
    SELECT bip.class_desc,
            bip.covering_permission_name
    WHERE bip.covering_permission_name!=''
    ) AS x(declared_class, declared_permission_name);
 
WITH cte AS (
    --- Anchor:
    SELECT class,
           permission,
           class AS declared_class,
           permission AS declared_permission,
           CAST(permission+N' on '+class AS nvarchar(max)) AS [path],
           0 AS [level]
    FROM @builtin_permissions AS p
    GROUP BY class, permission
 
    UNION ALL
 
    --- Recursion: inherited permissions:
    SELECT p.class,
           p.permission,
           cte.declared_class,
           cte.declared_permission,
           CAST(cte.[path]+N' -> '+(CASE WHEN p.permission=p.declared_permission OR @permission_list=1 THEN N'' ELSE p.permission+N' on ' END)+p.class AS nvarchar(max)) AS [path],
           cte.[level]+1
    FROM @builtin_permissions AS p
    INNER JOIN cte ON
        p.declared_class=cte.class AND
        p.declared_permission=cte.permission)
 
--- Save the results into temporary work table:
INSERT INTO @permissions_temp (class, permission, declared_class, declared_permission, [path], [level])
SELECT class, permission, declared_class, declared_permission, [path], [level]
FROM (
    SELECT class, permission, declared_class, declared_permission, [path], [level],
           ROW_NUMBER() OVER (PARTITION BY class, permission, declared_class, declared_permission ORDER BY [level]) AS _rn
    FROM cte
    WHERE @permission IS NULL OR
          [path] LIKE N'%'+@permission+N'%' OR
          permission LIKE N'%'+@permission+N'%'
    ) AS sub
WHERE _rn=1;
 
 
 
--- If @permission_list is 0, dump the results into @permissions, and we're done.
INSERT INTO @permissions (class, permission, declared_class, declared_permission, [path], [level])
SELECT class, permission, declared_class, declared_permission, [path], [level]
FROM @permissions_temp
WHERE @permission_list=0;
 
 
 
--- If @permission_list is 1, compile a comma-separated list of permissions for
--- from the work table and insert into @permissions:
INSERT INTO @permissions (class, permission, declared_class, declared_permission, [path], [level])
SELECT class, SUBSTRING(CAST((SELECT N', '+x.permission
                              FROM @permissions_temp AS x
                              WHERE x.declared_class=cte.declared_class AND
                                    x.declared_permission=cte.declared_permission AND
                                    x.class=cte.class
                              ORDER BY x.permission
                              FOR XML PATH(''), TYPE
              ) AS nvarchar(max)), 3, 4000) AS permission, declared_class, declared_permission, MIN([path]),
       DENSE_RANK() OVER (PARTITION BY class, declared_class, declared_permission ORDER BY MIN([level])) AS [level]
FROM @permissions_temp AS cte
WHERE @permission_list=1 AND (
          @permission IS NULL OR
          [path] LIKE N'%'+@permission+N'%')
GROUP BY class, declared_class, declared_permission;
 
 
 
-------------------------------------------------------------------------------
--- Securables
-------------------------------------------------------------------------------
 
 
 
--- Insert all server-level and database-level securables into a working table:
WITH s(parent_class, parent_major_id, class, major_id, principal_id, class_desc, qualified_name, is_server_lvl) AS (
    -- SERVER
    SELECT NULL AS parent_class, CAST(NULL AS int) AS parent_major_id, 100 AS class, 0 AS major_id, CAST(NULL AS int) AS principal_id, 'SERVER' AS class_desc, CAST(NULL AS nvarchar(max)) AS qualified_name, 1 AS is_server_lvl
    UNION ALL
    -- AVAILABILITY GROUP
    SELECT 100 AS parent_class, 0 AS parent_major_id, 108 AS class, agr.replica_metadata_id AS major_id, NULL, 'AVAILABILITY GROUP', N'AVAILABILITY GROUP::'+QUOTENAME(ag.[name]), 1 AS is_server_lvl
    FROM sys.availability_groups AS ag
    INNER JOIN sys.availability_replicas agr on agr.group_id=ag.group_id
    INNER JOIN sys.dm_hadr_availability_replica_states AS agrs ON agrs.replica_id=agr.replica_id AND agrs.is_local=1
    UNION ALL
    -- ENDPOINT
    SELECT 100 AS parent_class, 0 AS parent_major_id, 105 AS class, endpoint_id AS major_id, NULL, 'ENDPOINT', N'ENDPOINT::'+QUOTENAME([name]), 1 AS is_server_lvl
    FROM master.sys.endpoints
    UNION ALL
    -- LOGIN, SERVER ROLE
    SELECT 100 AS parent_class, 0 AS parent_major_id, 101 AS class, principal_id AS major_id, owning_principal_id,
           (CASE [type] WHEN 'R' THEN N'SERVER ROLE' ELSE N'LOGIN' END),
           (CASE [type] WHEN 'R' THEN N'SERVER ROLE' ELSE N'LOGIN' END)+N'::'+QUOTENAME([name]), 1 AS is_server_lvl
    FROM master.sys.server_principals
    UNION ALL
    -- SEARCH PROPERTY LIST
    SELECT 0 AS parent_class, 0 AS parent_major_id, 31 AS class, property_list_id AS major_id, principal_id, 'SEARCH PROPERTY LIST', N'SEARCH PROPERTY LIST::'+QUOTENAME([name]) COLLATE database_default, 0 AS is_server_lvl
    FROM sys.registered_search_property_lists
    UNION ALL
    -- DATABASE
    SELECT 100 AS parent_class, 0 AS parent_major_id, 0 AS class, 0 AS major_id, p.principal_id, 'DATABASE' AS class_desc, N'DATABASE::'+QUOTENAME(DB_NAME()), 0 AS is_server_lvl
    FROM sys.databases AS db
    LEFT JOIN sys.database_principals AS p ON db.owner_sid=p.[sid]
    WHERE db.database_id=DB_ID()
    UNION ALL
    -- SCHEMA
    SELECT 0 AS parent_class, 0 AS parent_major_id, 3 AS class, [schema_id] AS major_id, principal_id, 'SCHEMA' AS class_desc, N'SCHEMA::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.schemas
    UNION ALL
    --- OBJECT
    SELECT 3 AS parent_class, o.[schema_id] AS parent_major_id, 1 AS class, o.[object_id] AS major_id, o.principal_id, 'OBJECT' AS class_desc, QUOTENAME(s.[name])+N'.'+QUOTENAME(o.[name]), 0 AS is_server_lvl
    FROM sys.schemas AS s
    INNER JOIN sys.objects AS o ON s.[schema_id]=o.[schema_id]
    WHERE o.[type] NOT IN ('AF', 'C', 'D', 'F', 'IT', 'PG', 'PK', 'R', 'RF', 'S', 'SN', 'TA', 'TR', 'UQ', 'X')
    UNION ALL
    -- USER, ROLE
    SELECT 0 AS parent_class, 0 AS parent_major_id, 4 AS class, principal_id AS major_id, owning_principal_id AS principal_id,
           (CASE [type] WHEN 'A' THEN N'APPLICATION ROLE' WHEN 'R' THEN N'ROLE' ELSE N'USER' END),
           (CASE [type] WHEN 'A' THEN N'APPLICATION ROLE' WHEN 'R' THEN N'ROLE' ELSE N'USER' END)+N'::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.database_principals
    UNION ALL
    -- ASSEMBLY
    SELECT 0 AS parent_class, 0 AS parent_major_id, 5 AS class, assembly_id AS major_id, principal_id, 'ASSEMBLY', N'ASSEMBLY::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.assemblies
    UNION ALL
    -- TYPE
    SELECT 3 AS parent_class, t.[schema_id] AS parent_major_id, 6 AS class, t.user_type_id AS major_id, t.principal_id, 'TYPE' AS class_desc, N'TYPE::'+QUOTENAME(s.[name])+N'.'+QUOTENAME(t.[name]), 0 AS is_server_lvl
    FROM sys.schemas AS s
    INNER JOIN sys.types AS t ON s.[schema_id]=t.[schema_id]
    WHERE t.is_user_defined=1
    UNION ALL
    -- XML_SCHEMA_COLLECTION
    SELECT 3 AS parent_class, x.[schema_id] AS parent_major_id, 10 AS class, x.xml_collection_id AS major_id, x.principal_id, 'XML SCHEMA COLLECTION' AS class_desc, N'XML SCHEMA COLLECTION::'+QUOTENAME(s.[name])+N'.'+QUOTENAME(x.[name]), 0 AS is_server_lvl
    FROM sys.schemas AS s
    INNER JOIN sys.xml_schema_collections AS x ON s.[schema_id]=x.[schema_id]
    UNION ALL
    -- MESSAGE_TYPE
    SELECT 0 AS parent_class, 0 AS parent_major_id, 15 AS class, message_type_id AS major_id, principal_id, 'MESSAGE TYPE', N'MESSAGE TYPE::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.service_message_types
    UNION ALL
    -- SERVICE_CONTRACT
    SELECT 0 AS parent_class, 0 AS parent_major_id, 16 AS class, service_contract_id AS major_id, principal_id, 'SERVICE CONTRACT', N'SERVICE CONTRACT::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.service_contracts
    UNION ALL
    -- SERVICE
    SELECT 0 AS parent_class, 0 AS parent_major_id, 17 AS class, service_id AS major_id, principal_id, 'SERVICE', N'SERVICE::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.services
    UNION ALL
    -- REMOTE_SERVICE_BINDING
    SELECT 0 AS parent_class, 0 AS parent_major_id, 18 AS class, remote_service_binding_id AS major_id, principal_id, 'REMOTE SERVICE BINDING', N'REMOTE SERVICE BINDING::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.remote_service_bindings
    UNION ALL
    -- ROUTE
    SELECT 0 AS parent_class, 0 AS parent_major_id, 19 AS class, route_id AS major_id, principal_id, 'ROUTE', N'ROUTE::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.routes
    UNION ALL
    -- FULLTEXT CATALOG
    SELECT 0 AS parent_class, 0 AS parent_major_id, 23 AS class, fulltext_catalog_id AS major_id, principal_id, 'FULLTEXT CATALOG', N'CATALOG::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.fulltext_catalogs
    UNION ALL
    -- FULLTEXT STOPLIST
    SELECT 0 AS parent_class, 0 AS parent_major_id, 23 AS class, stoplist_id AS major_id, principal_id, 'FULLTEXT STOPLIST', N'STOPLIST::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.fulltext_stoplists
    UNION ALL
    -- SYMMETRIC KEY
    SELECT 0 AS parent_class, 0 AS parent_major_id, 24 AS class, symmetric_key_id AS major_id, principal_id, 'SYMMETRIC KEY', N'SYMMETRIC KEY::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.symmetric_keys
    UNION ALL
    -- CERTIFICATE
    SELECT 0 AS parent_class, 0 AS parent_major_id, 25 AS class, certificate_id AS major_id, principal_id, 'CERTIFICATE', N'CERTIFICATE::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.certificates
    UNION ALL
    -- ASYMMETRIC_KEY
    SELECT 0 AS parent_class, 0 AS parent_major_id, 26 AS class, asymmetric_key_id AS major_id, principal_id, 'CERTIFICATE', N'CERTIFICATE::'+QUOTENAME([name]), 0 AS is_server_lvl
    FROM sys.asymmetric_keys)
 
INSERT INTO @securables_temp (parent_class, parent_major_id, class, major_id, principal_id, class_desc, qualified_name, is_server_lvl)
SELECT parent_class, parent_major_id, class, major_id, principal_id, class_desc, qualified_name, is_server_lvl
FROM s;
 
--- Build a hierarchy of @securables_temp, using a recursive CTE:
WITH cte AS (
    SELECT class AS parent_class, major_id AS parent_major_id, ISNULL(qualified_name, N'SERVER') AS parent_qualified_name,
           class, class_desc, major_id, qualified_name, principal_id, is_server_lvl, 0 AS [level], CAST(ISNULL(qualified_name, 'SERVER') AS nvarchar(max)) AS [path]
    FROM @securables_temp AS s
     
    UNION ALL
     
    SELECT cte.parent_class, cte.parent_major_id, cte.parent_qualified_name,
           s.class, s.class_desc, s.major_id, s.qualified_name, s.principal_id, s.is_server_lvl, cte.[level]+1, CAST(cte.[path]+N' -> '+s.qualified_name AS nvarchar(max))
    FROM cte
    INNER JOIN @securables_temp AS s ON cte.class=s.parent_class AND cte.major_id=s.parent_major_id)
 
--- Eliminate duplicates and insert all parent-child paths into @securables:
INSERT INTO @securables (parent_class, parent_major_id, parent_qualified_name, class, class_desc, major_id, qualified_name, principal_id, is_server_lvl, [path])
SELECT parent_class, parent_major_id, parent_qualified_name, class, class_desc, major_id, qualified_name, principal_id, is_server_lvl, [path]
FROM (
    SELECT parent_class, parent_major_id, parent_qualified_name, class, class_desc, major_id, qualified_name, principal_id, is_server_lvl, [path],
           ROW_NUMBER() OVER (PARTITION BY parent_class, parent_major_id, class, major_id ORDER BY [level], [path]) AS _rn
    FROM cte
    WHERE @securable IS NULL OR
          REPLACE(REPLACE(qualified_name, N']', N''), N'[', N'') LIKE REPLACE(REPLACE(@securable, N']', N''), N'[', N'')
) AS sub
WHERE _rn=1;
 
 
 
-------------------------------------------------------------------------------
--- Rules (the intersection of principals, securables and permissions)
-------------------------------------------------------------------------------
 
 
 
--- Explicit server-level permissions:
INSERT INTO @rules (class, class_desc, major_id, minor_id, grantee_principal_id, grantee_is_server_lvl, [permission_name], [state], state_desc, inheritance)
SELECT class,
       class_desc,
       major_id,
       minor_id,
       grantee_principal_id,
       1 AS grantee_is_server_lvl,
       [permission_name],
       [state],
       state_desc,
       CAST(NULL AS varchar(100)) AS inheritance
FROM sys.server_permissions;
 
--- Explicit database-level permissions:
INSERT INTO @rules (class, class_desc, major_id, minor_id, grantee_principal_id, grantee_is_server_lvl, [permission_name], [state], state_desc, inheritance)
SELECT class,
       class_desc,
       major_id,
       minor_id,
       grantee_principal_id,
       0 AS grantee_is_server_lvl,
       [permission_name],
       [state],
       state_desc,
       CAST(NULL AS varchar(100)) AS inheritance
FROM sys.database_permissions;
 
--- Implicit CONTROL permissions on class objects as a result of ownership:
INSERT INTO @rules (class, class_desc, major_id, minor_id, grantee_principal_id, grantee_is_server_lvl, [permission_name], [state], state_desc, inheritance)
SELECT class,
       class_desc,
       major_id,
       0 AS minor_id,
       principal_id AS grantee_principal_id,
       is_server_lvl AS grantee_is_server_lvl,
       'CONTROL' AS [permission_name],
       'W' AS [state],
       'GRANT_WITH_GRANT_OPTION' AS [state_desc],
       'OWNER' AS inheritance
FROM @securables
WHERE parent_class=class AND parent_major_id=major_id AND principal_id IS NOT NULL;
 
--- Fixed server role permissions:
INSERT INTO @rules (class, class_desc, major_id, minor_id, grantee_principal_id, grantee_is_server_lvl, [permission_name], [state], state_desc, inheritance)
SELECT 100 AS class,
       N'SERVER' AS class_desc,
       0 AS major_id,
       0 AS minor_id,
       sp.principal_id AS grantee_principal_id,
       1 AS grantee_is_server_lvl,
       p.[permission_name],
       'G' AS [state],
       'GRANT' AS state_desc,
       NULL AS inheritance
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
WHERE sp.is_fixed_role=1;
 
--- Fixed database role permissions:
INSERT INTO @rules (class, class_desc, major_id, minor_id, grantee_principal_id, grantee_is_server_lvl, [permission_name], [state], state_desc, inheritance)
SELECT 0 AS class,
       'DATABASE' AS class_desc,
       0 AS major_id,
       0 AS minor_id,
       dp.principal_id AS grantee_principal_id,
       0 AS grantee_is_server_lvl,
       p.[permission_name],
       s.[state],
       s.state_desc,
       NULL AS inheritance
FROM sys.database_principals AS dp
CROSS JOIN (
    VALUES ('G', 'GRANT'),
           ('D', 'DENY')) AS s([state], state_desc)
INNER JOIN sys.fn_builtin_permissions('DATABASE') AS p ON
      dp.[name]='db_accessadmin' AND s.[state]='G' AND
      p.[permission_name] IN ('ALTER ANY USER', 'CREATE SCHEMA') OR

      dp.[name]='db_backupoperator' AND s.[state]='G' AND
      p.[permission_name] IN ('BACKUP DATABASE', 'BACKUP LOG', 'CHECKPOINT') OR

      dp.[name]='db_datareader' AND s.[state]='G' AND
      p.[permission_name]='SELECT' OR

      dp.[name]='db_datawriter' AND s.[state]='G' AND
      p.[permission_name] IN ('INSERT', 'DELETE', 'UPDATE') OR

      dp.[name]='db_denydatareader' AND s.[state]='D' AND
      p.[permission_name]='SELECT' OR

      dp.[name]='db_denydatawriter' AND s.[state]='D' AND
      p.[permission_name] IN ('INSERT', 'DELETE', 'UPDATE') OR

      dp.[name]='db_ddladmin' AND s.[state]='G' AND
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

      dp.[name]='db_owner' AND s.[state]='G' AND
      p.[permission_name]='CONTROL' OR

      dp.[name]='db_securityadmin' AND s.[state]='G' AND
      p.[permission_name] IN ('ALTER ANY APPLICATION ROLE', 'ALTER ANY ROLE',
                              'CREATE SCHEMA', 'VIEW DEFINITION')

WHERE dp.[type]='R' AND
      dp.is_fixed_role=1;



-------------------------------------------------------------------------------
--- Output:
-------------------------------------------------------------------------------



--- If @output_xml=1, use the OUTPUT variable @xml to return a blob:
IF (@output_xml=1)
    SELECT @xml=(
        SELECT perms.state_desc AS [@state],
 
               --- Permission hierarchy:
               (SELECT p.permission AS [@name],
                       p.class as [@class],
                       (CASE WHEN p.[level]=0 THEN 'declared' ELSE 'effective' END) AS [@inheritance]
                FROM @permissions AS p
                WHERE perms.class_desc COLLATE database_default=p.declared_class AND
                      perms.[permission_name] COLLATE database_default=p.declared_permission
                FOR XML PATH('permission'), TYPE
                ) AS [permissions],
 
               --- Securables hierarchy:
               (SELECT sec.class_desc AS [@class],
                       sec.major_id AS [@major_id],
                       NULLIF(perms.minor_id, 0) AS [@minor_id],
                       sec.qualified_name+ISNULL(N'('+QUOTENAME(col.[name] COLLATE database_default)+N')', N'') AS [@name],
                       (CASE WHEN sec.class=sec.parent_class AND sec.major_id=sec.parent_major_id THEN 'declared' ELSE 'effective' END) AS [@inheritance]
                FROM @securables AS sec
                WHERE perms.class=sec.parent_class AND
                      perms.major_id=sec.parent_major_id
                FOR XML PATH('securable'), TYPE
                ) AS securables,

               --- Principals hierarchy:
               (SELECT grantee.effective_principal_id AS [@principal_id],
                       grantee.effective_type_desc AS [@type],
                       grantee.effective_name AS [@name],
                       (CASE WHEN grantee.[level]=0 THEN 'declared' ELSE 'effective' END) AS [@inheritance]
                FROM @principals AS grantee
                WHERE grantee.declared_is_server_lvl=perms.grantee_is_server_lvl AND
                      grantee.declared_principal_id=perms.grantee_principal_id
                ORDER BY grantee.[level]
                FOR XML PATH('principal'), TYPE
                ) AS principals,

               --- The SQL statement of the declared permission:
               (CASE
                     --- Explicit GRANT/DENY:
                     WHEN perms.inheritance IS NULL THEN
                       (CASE perms.[state] WHEN 'W' THEN N'GRANT' ELSE perms.state_desc END)+
                             N' '+perms.[permission_name] COLLATE database_default+
                             ISNULL(N' ON '+NULLIF(def_sec.parent_qualified_name, N'SERVER')+ISNULL(N'('+QUOTENAME(col.[name] COLLATE database_default)+N')', N''), N'')+
                             N' TO '+QUOTENAME(def_grantee.declared_name)+
                             (CASE WHEN perms.[state]='W' THEN N' WITH GRANT OPTION' ELSE N'' END)

                     --- Inferred CONTROL by ownership: ALTER AUTHORIZATION
                     WHEN perms.inheritance='OWNER' THEN
                       N'ALTER AUTHORIZATION '+
                       ISNULL(N' ON '+def_sec.parent_qualified_name, N'')+
                       N' TO '+QUOTENAME(def_grantee.declared_name) COLLATE database_default
                     END) AS [declared_permission/@sql]
        FROM @rules AS perms
        INNER JOIN @principals AS def_grantee ON
            def_grantee.declared_is_server_lvl=perms.grantee_is_server_lvl AND
            def_grantee.declared_principal_id=perms.grantee_principal_id AND
            def_grantee.[level]=0
        INNER JOIN @permissions AS def_p ON
            perms.class_desc COLLATE database_default=(CASE WHEN def_p.declared_class IN (N'USER', N'ROLE') THEN N'DATABASE_PRINCIPAL' ELSE def_p.declared_class END) AND
            perms.[permission_name] COLLATE database_default=def_p.declared_permission AND
            def_p.[level]=0
        INNER JOIN @securables AS def_sec ON
            perms.class=def_sec.parent_class AND
            perms.major_id=def_sec.parent_major_id AND
            def_p.class=def_sec.class_desc AND
            def_sec.class=def_sec.parent_class AND
            def_sec.major_id=def_sec.parent_major_id
        LEFT JOIN sys.columns AS col ON
            perms.grantee_is_server_lvl=0 AND
            perms.class_desc='OBJECT' AND
            perms.major_id=col.[object_id] AND
            perms.minor_id=col.column_id
        WHERE (@principal IS NULL OR def_grantee.effective_name LIKE @principal) AND
              (@securable IS NULL OR def_sec.qualified_name LIKE @securable) AND
              (@permission IS NULL OR perms.[permission_name] LIKE @permission)
        FOR XML PATH('permission'), TYPE);

--- If @output_xml=0, return a tabular resultset with all inherited permutations:
IF (@output_xml=0)
    SELECT perms.state_desc AS [state],
           perms.[permission_name] AS permission,
           sec.parent_qualified_name AS securable,
           grantee.declared_name AS principal,

           --- The SQL statement of the declared permission:
           (CASE
                 --- Explicit GRANT/DENY:
                 WHEN perms.inheritance IS NULL THEN
                   (CASE perms.[state] WHEN 'W' THEN N'GRANT' ELSE perms.state_desc END)+
                         N' '+perms.[permission_name] COLLATE database_default+
                         ISNULL(N' ON '+NULLIF(sec.parent_qualified_name, N'SERVER')+ISNULL(N'('+QUOTENAME(col.[name] COLLATE database_default)+N')', N''), N'')+
                         N' TO '+QUOTENAME(grantee.declared_name)+
                         (CASE WHEN perms.[state]='W' THEN N' WITH GRANT OPTION' ELSE N'' END)

                 --- Inferred CONTROL by ownership: ALTER AUTHORIZATION
                 WHEN perms.inheritance='OWNER' THEN
                   N'ALTER AUTHORIZATION '+
                   ISNULL(N' ON '+sec.parent_qualified_name, N'')+
                   N' TO '+QUOTENAME(grantee.declared_name) COLLATE database_default
                 END) AS declared_permission,

           --- Effective permissions:
           (CASE MIN((CASE WHEN [state]='D' THEN 0 ELSE 1 END)) OVER (PARTITION BY sec.class, sec.major_id, perms.minor_id, p.permission) WHEN 0 THEN N'DENY' ELSE N'GRANT' END) AS effective_state,
           p.permission AS effective_permission,
           sec.qualified_name AS effective_securable,
           grantee.effective_name AS effective_principal,

           --- Paths (the explanation for the effective permissions)
           p.[path] AS permission_path,
           sec.[path] AS securable_path,
           grantee.[path] AS principal_path
    FROM @rules AS perms
    INNER JOIN @principals AS grantee ON
        grantee.declared_is_server_lvl=perms.grantee_is_server_lvl AND
        grantee.declared_principal_id=perms.grantee_principal_id
    LEFT JOIN sys.columns AS col ON
        perms.grantee_is_server_lvl=0 AND
        perms.class_desc='OBJECT' AND
        perms.major_id=col.[object_id] AND
        perms.minor_id=col.column_id
    INNER JOIN @permissions AS p ON
        perms.class_desc COLLATE database_default=(CASE WHEN p.declared_class IN (N'USER', N'ROLE') THEN N'DATABASE_PRINCIPAL' ELSE p.declared_class END) AND
        perms.[permission_name] COLLATE database_default=p.declared_permission AND
        (   p.class IN ('SERVER', 'SERVER_PRINCIPAL', 'ENDPOINT') AND grantee.effective_is_server_lvl=1 OR
            p.class NOT IN ('SERVER', 'SERVER_PRINCIPAL', 'ENDPOINT') AND grantee.effective_is_server_lvl=0)
    INNER JOIN @securables AS sec ON
        perms.class=sec.parent_class AND
        perms.major_id=sec.parent_major_id AND
        p.class=sec.class_desc
    WHERE (@principal IS NULL OR grantee.effective_name LIKE @principal) AND
          (@securable IS NULL OR sec.qualified_name LIKE @securable) AND
          (@permission IS NULL OR perms.[permission_name] LIKE @permission OR p.permission LIKE @permission)
    ORDER BY sec.parent_class,
             sec.parent_qualified_name,
             p.declared_permission,
             perms.state_desc,
             grantee.declared_name,
             p.permission,
             sec.qualified_name,
             grantee.effective_name;
GO


--- This marks master.dbo.sp_help_permissions as a "system object", which makes
--- it accessible from any database without the "master." prefix. It
--- also sets the execution context of the procedure to the database
--- where it was called.
---
--- Not available on Azure SQL Database.
---
--- NOTE: sp_MS_marksystemobject is an undocumented, unsupported
---       feature of SQL Server.

IF (DB_NAME()='master' AND CAST(SERVERPROPERTY('Edition') AS varchar(100)) NOT LIKE '%Azure%')
    EXECUTE sys.sp_MS_marksystemobject @objname=N'sp_help_permissions';
GO
