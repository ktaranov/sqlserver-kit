USE [master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* 
This procedure takes in a login name, windows or SQL, and will generate
the access and authorities for the login across the SQL instance. The script 
captures any server roles the logins may have, database access and roles that have been 
granted, and any specific permissions granted on the database and 
authorities granted on objects.

This procedure uses the stroed procedure sp_hexidecimal and Aaron Bertrand's sp_foreachdb stored procedure

This has been tested on SQL Server 2005 and SQL Server 2008 R2.  Please note that some facets 
on each of these SQL versions have not been tested due to lack of availability.

If the login name is not provided, an error will be generated

EX - sp_capture_login_auths 'domain name\snooze' 

EX - sp_capture_login_auths 'snooze'

*/

IF OBJECT_ID ('sp_foreachdb') IS NOT NULL
  DROP PROCEDURE sp_foreachdb
GO
CREATE PROCEDURE dbo.sp_foreachdb
   @command             NVARCHAR(MAX),
   @replace_character   NCHAR(1)       = N'?',
   @print_dbname        BIT            = 0,
   @print_command_only  BIT            = 0,
   @suppress_quotename  BIT            = 0,
   @system_only         BIT            = NULL,
   @user_only           BIT            = NULL,
   @name_pattern        NVARCHAR(300)  = N'%', 
   @database_list       NVARCHAR(MAX)  = NULL,
   @recovery_model_desc NVARCHAR(120)  = NULL,
   @compatibility_level TINYINT        = NULL,
   @state_desc          NVARCHAR(120)  = N'ONLINE',
   @is_read_only        BIT            = 0,
   @is_auto_close_on    BIT            = NULL,
   @is_auto_shrink_on   BIT            = NULL,
   @is_broker_enabled   BIT            = NULL
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE
       @sql    NVARCHAR(MAX),
       @dblist NVARCHAR(MAX),
       @db     NVARCHAR(300),
       @i      INT;

   IF @database_list > N''
   BEGIN
       ;WITH n(n) AS 
       (
           SELECT ROW_NUMBER() OVER (ORDER BY s1.name) - 1
            FROM sys.objects AS s1 
            CROSS JOIN sys.objects AS s2
       )
       SELECT @dblist = REPLACE(REPLACE(REPLACE(x,'</x><x>',','),
           '</x>',''),'<x>','')
       FROM 
       (
           SELECT DISTINCT x = 'N''' + LTRIM(RTRIM(SUBSTRING(
            @database_list, n,
            CHARINDEX(',', @database_list + ',', n) - n))) + ''''
            FROM n WHERE n <= LEN(@database_list)
            AND SUBSTRING(',' + @database_list, n, 1) = ','
            FOR XML PATH('')
       ) AS y(x);
   END

   CREATE TABLE #x(db NVARCHAR(300));

   SET @sql = N'SELECT name FROM sys.databases WHERE 1=1'
       + CASE WHEN @system_only = 1 THEN 
           ' AND database_id IN (1,2,3,4)' 
           ELSE '' END
       + CASE WHEN @user_only = 1 THEN 
           ' AND database_id NOT IN (1,2,3,4)' 
           ELSE '' END
       + CASE WHEN @name_pattern <> N'%' THEN 
           ' AND name LIKE N''%' + REPLACE(@name_pattern, '''', '''''') + '%''' 
           ELSE '' END
       + CASE WHEN @dblist IS NOT NULL THEN 
           ' AND name IN (' + @dblist + ')' 
           ELSE '' END
       + CASE WHEN @recovery_model_desc IS NOT NULL THEN
           ' AND recovery_model_desc = N''' + @recovery_model_desc + ''''
           ELSE '' END
       + CASE WHEN @compatibility_level IS NOT NULL THEN
           ' AND compatibility_level = ' + RTRIM(@compatibility_level)
           ELSE '' END
       + CASE WHEN @state_desc IS NOT NULL THEN
           ' AND state_desc = N''' + @state_desc + ''''
           ELSE '' END
       + CASE WHEN @is_read_only IS NOT NULL THEN
           ' AND is_read_only = ' + RTRIM(@is_read_only)
           ELSE '' END
       + CASE WHEN @is_auto_close_on IS NOT NULL THEN
           ' AND is_auto_close_on = ' + RTRIM(@is_auto_close_on)
           ELSE '' END
       + CASE WHEN @is_auto_shrink_on IS NOT NULL THEN
           ' AND is_auto_shrink_on = ' + RTRIM(@is_auto_shrink_on)
           ELSE '' END
       + CASE WHEN @is_broker_enabled IS NOT NULL THEN
           ' AND is_broker_enabled = ' + RTRIM(@is_broker_enabled)
           ELSE '' END;

   INSERT #x EXEC sp_executesql @sql;

   DECLARE c CURSOR 
       LOCAL FORWARD_ONLY STATIC READ_ONLY
       FOR SELECT CASE WHEN @suppress_quotename = 1 THEN 
              db
           ELSE
              QUOTENAME(db)
           END 
       FROM #x ORDER BY db;

   OPEN c;

   FETCH NEXT FROM c INTO @db;

   WHILE @@FETCH_STATUS = 0
   BEGIN
       SET @sql = REPLACE(@command, @replace_character, @db);

       IF @print_command_only = 1
       BEGIN
           PRINT '/* For ' + @db + ': */'
               + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
               + @sql 
               + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10);
       END
       ELSE
       BEGIN
           IF @print_dbname = 1
           BEGIN
               PRINT '/* ' + @db + ' */';
           END

           EXEC sp_executesql @sql;
       END

       FETCH NEXT FROM c INTO @db;
   END

   CLOSE c;
   DEALLOCATE c;
END
GO 

--------------------------------------------------------------------------------

IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
  DROP PROCEDURE sp_hexadecimal
GO
CREATE PROCEDURE sp_hexadecimal
    @binvalue varbinary(256),
    @hexvalue varchar (514) OUTPUT
AS
DECLARE @charvalue varchar (514)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF'
WHILE (@i <= @length)
BEGIN
  DECLARE @tempint int
  DECLARE @firstint int
  DECLARE @secondint int
  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
  SELECT @firstint = FLOOR(@tempint/16)
  SELECT @secondint = @tempint - (@firstint*16)
  SELECT @charvalue = @charvalue +
    SUBSTRING(@hexstring, @firstint+1, 1) +
    SUBSTRING(@hexstring, @secondint+1, 1)
  SELECT @i = @i + 1
END

SELECT @hexvalue = @charvalue
GO
-------------------------------------------------------------------------------

IF OBJECT_ID ('sp_capture_login_auths') IS NOT NULL
  DROP PROCEDURE sp_capture_login_auths
GO
CREATE PROCEDURE [dbo].[sp_capture_login_auths] @user sysname = NULL AS
--ALTER PROCEDURE [dbo].[sp_capture_login_auths] @user sysname = NULL AS
DECLARE @name sysname
DECLARE @role_string varchar(50)
DECLARE @deflt_dbid smallint
deCLARE @auth_name sysname
deCLARE @type varchar (1)
DECLARE @hasaccess int
DECLARE @denylogin int
DECLARE @is_disabled int
DECLARE @PWD_varbinary varbinary (256)
DECLARE @PWD_string varchar (514)
DECLARE @SID_varbinary varbinary (85)
DECLARE @SID_string varchar (514)
DECLARE @tmpstr varchar (1024)
DECLARE @is_policy_checked varchar (3)
DECLARE @is_expiration_checked varchar (3)
declare @defaultdb NVARCHAR(128)

Declare @usrname varchar(50),
@dbname NVARCHAR(128),
@savedb NVARCHAR(128),
@dbrole varchar(50),
@svrrole varchar(50)

DECLARE @RoleName VARCHAR(50), 
@UserName VARCHAR(50), 
@CMD nVARCHAR(4000),
@SQL NVARCHAR(4000) 

SET NOCOUNT ON


IF (@user IS NULL)
BEGIN
PRINT 'No user specified.'
-- RETURN -1
END 


DECLARE login_curs CURSOR FOR

SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin 
FROM sys.server_principals p LEFT JOIN sys.syslogins l
ON ( l.name = p.name ) 
WHERE p.type IN ( 'S', 'G', 'U' )
AND p.name = @user


OPEN login_curs 
FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
IF (@@fetch_status = -1)
BEGIN
PRINT 'No login(s) found.'
CLOSE login_curs
DEALLOCATE login_curs
RETURN -1
END

SET @tmpstr = '/* sp_help_revlogin script '
PRINT @tmpstr
SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
PRINT @tmpstr
PRINT ''

WHILE (@@fetch_status = 0)
BEGIN

PRINT ''
SET @tmpstr = '-- Login: ' + @name
PRINT @tmpstr
IF (@type IN ( 'G', 'U'))
BEGIN -- NT authenticated account/group
SELECT @tmpstr = 'USE MASTER'
PRINT @tmpstr
SELECT @tmpstr = 'GO'
PRINT @Tmpstr 
SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'
END
ELSE 
BEGIN -- SQL Server authentication
-- obtain password and sid
SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT

-- obtain password policy state
SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
SELECT @tmpstr = 'USE MASTER'
PRINT @tmpstr
SELECT @tmpstr = 'GO'
PRINT @Tmpstr
SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'
END

IF ( @is_policy_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
END

IF ( @is_expiration_checked IS NOT NULL )
BEGIN
SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
END
--END

IF (@denylogin = 1)
BEGIN -- login is denied access
SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
END
ELSE
IF (@hasaccess = 0)
BEGIN -- login exists but does not have access
SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
END

IF (@is_disabled = 1)
BEGIN -- login is disabled
SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
END
PRINT @tmpstr
--END


-- CAPTURE SERVER ROLES 


DECLARE @svrrole_cnt int 
SET @svrrole_cnt = 0

CREATE TABLE #svrrolemember_kk 
( 
svrrole VARCHAR(100), 
membername VARCHAR(100), 
membersid VARBINARY(2048) 
) 

SET @CMD = 'truncate table #svrRoleMember_kk insert into #svrRoleMember_kk exec sp_helpsrvrolemember ' 

EXEC (@CMD)


DECLARE svrrole_curs CURSOR FOR 
Select [svrrole],
membername
FROM #svrrolemember_kk 
Where [membername] = @user


OPEN svrrole_curs
FETCH NEXT FROM svrrole_curs INTO @svrrole, @usrname

WHILE (@@FETCH_STATUS = 0)
BEGIN 
IF @svrrole_cnt = 0
BEGIN 
SET @tmpstr = ' '
PRINT @tmpstr
SET @tmpstr = '-- ********************'
PRINT @tmpstr
SET @tmpstr = '-- SERVER ROLES'
Print @tmpstr
SET @tmpstr = '-- ********************'
PRINT @tmpstr
SET @tmpstr = ''
SET @tmpstr = 'EXEC master..sp_addsrvrolemember @loginame = ''' + @usrname + ''' , @rolename = ''' + @svrrole + '''' 
PRINT @tmpstr
SET @svrrole_cnt = @svrrole_cnt + 1
END
ELSE
BEGIN
SET @tmpstr = 'EXEC master..sp_addsrvrolemember @loginame = ''' + @usrname + ''' , @rolename = ''' + @svrrole + '''' 
PRINT @tmpstr 
END

FETCH NEXT FROM svrrole_curs INTO @svrrole, @usrname 
END

DROP TABLE #svrrolemember_kk 
CLOSE svrRole_curs
DEALLOCATE svrrole_curs 



--DATABASE ACCESS INCUDING DEFAULT DB AND OTHER DATABASES

	DECLARE @Set_Create_User varchar(1)
	SET @Set_Create_User = 'N'
	
	SET @tmpstr = ' '
	PRINT @tmpstr
	SET @tmpstr = ' '
	PRINT @tmpstr
	SET @tmpstr = '-- **************************'
	PRINT @tmpstr
	SET @tmpstr = '-- DATABASE ACCESS and ROLES'
	Print @tmpstr
	SET @tmpstr = '-- **************************'
	PRINT @tmpstr
	SET @tmpstr = ''

	CREATE TABLE #permission 
	( 
	user_name VARCHAR(128), 
	databasename NVARCHAR(128), 
	role VARCHAR(128) 
	) 

	DECLARE longspcur CURSOR FOR 
	SELECT name 
	FROM sys.server_principals 
	WHERE type IN ( 'S', 'U', 'G' ) 
	AND name = @name

	OPEN longspcur 

	FETCH next FROM longspcur INTO @UserName 

	WHILE @@FETCH_STATUS = 0 
		BEGIN 
			CREATE TABLE #userroles_kk 
			( 
			databasename NVARCHAR(128), 
			role VARCHAR(50) 
			) 

			CREATE TABLE #rolemember_kk 
			( 
			dbrole VARCHAR(100), 
			membername VARCHAR(100), 
			membersid VARBINARY(2048) 
			) 

			SET @CMD = 'use ? truncate table #RoleMember_kk insert into #RoleMember_kk exec sp_helprolemember insert into #UserRoles_kk (DatabaseName, Role) select db_name(), dbRole from #RoleMember_kk where MemberName = ''' + @UserName + '''' 

			EXEC Sp_foreachdb 
			@CMD 

			INSERT INTO #permission 
			SELECT @UserName 'user', 
					b.name, 
					u.role 
			FROM sys.sysdatabases b 
			LEFT OUTER JOIN #userroles_kk u 
			ON u.databasename = b.name 
			ORDER BY 1 

			DROP TABLE #userroles_kk; 

			DROP TABLE #rolemember_kk; 

		FETCH next FROM longspcur INTO @UserName 
		END 

	CLOSE longspcur 

	DEALLOCATE longspcur 


	SET @savedb = '' 

	DECLARE role_curs CURSOR FOR 
	Select [user_name],
	databasename,
	[role]
	FROM #Permission
	Where [role] is not null
	AND [user_name] = @name 
	ORDER BY databasename 


	OPEN role_curs
	FETCH NEXT FROM role_curs INTO @usrname, @dbname, @dbrole

	WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF @dbname <> @savedb 
				BEGIN
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = 'USE [' + @dbname + ']'
					PRINT @tmpstr
					SET @tmpstr = 'GO'
					PRINT @tmpstr
					SET @tmpstr = 'CREATE USER [' + @usrname + '] FOR LOGIN [' + @usrname + ']'
					PRINT @tmpstr
					SET @tmpstr = 'EXEC sp_addrolemember ''' + @dbrole + ''', '''+ @usrname + ''''
					PRINT @tmpstr
					SET @savedb = @dbname
					SET @Set_Create_User = 'Y'
				END
			ELSE 
				BEGIN
					SET @tmpstr = 'EXEC sp_addrolemember ''' + @dbrole + ''', '''+ @usrname + ''''
					PRINT @tmpstr
				END 

		FETCH NEXT FROM role_curs INTO @usrname, @dbname, @dbrole
		END 

	CLOSE Role_curs
	DEALLOCATE role_curs 

--DROP TABLE #Permission 
--FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin

--END
--CLOSE login_curs
--DEALLOCATE login_curs



-- DATABASE PERMISSIONS AND OBJECT AUTHORITIES


	DECLARE @DBNAME_AUTH NVARCHAR(128),
	@DBUSRNAME NVARCHAR(128),
	@PERMISSION_NAME NVARCHAR(128),
	@OBJECT_OWNER NVARCHAR(128), 
	@OBJECT_TYPE NVARCHAR(128),
	@OBJECT_NAME NVARCHAR(128),
	@COLUMN_NAME NVARCHAR(128),
	@SAVED_DBNAME NVARCHAR(128),
	@DBObjAuth_CNT INT

	CREATE TABLE #DB_Auths (
	#DBNAME_AUTH NVARCHAR(128),
	#DBUSRNAME NVARCHAR(128),
	#PERMISSION_NAME NVARCHAR(128),
	#OBJECT_OWNER NVARCHAR(128),
	#OBJECT_TYPE NVARCHAR(128),
	#OBJECT_NAME NVARCHAR(128),
	#COLUMN_NAME NVARCHAR(128))

	SET @SAVED_DBNAME = ''
	SET @DBObjAuth_CNT = 0

	SET @CMD = 
	'use ? INSERT INTO #DB_Auths 
		SELECT 
		[DatabaseName] = (Select db_name()), 
		[DatabaseUserName] = princ.[name], 
		[PermissionType] = perm.[permission_name], 
		[ObjectOwner] = sch.name, 
		[ObjectType] = CASE perm.[class] 
		WHEN 1 THEN obj.type_desc -- Schema-contained objects
		ELSE perm.[class_desc] -- Higher-level objects
		END, 
		[ObjectName] = CASE perm.[class] 
		WHEN 1 THEN OBJECT_NAME(perm.major_id) -- General objects
		WHEN 3 THEN schem.[name] -- Schemas
		WHEN 4 THEN imp.[name] -- Impersonations
		END,
		[ColumnName] = col.[name]
		FROM 
		--database user
		sys.database_principals princ 
		LEFT JOIN 
		--Login accounts
		sys.server_principals ulogin on princ.[sid] = ulogin.[sid]
		LEFT JOIN 
		--Permissions
		sys.database_permissions perm ON perm.[grantee_principal_id] = princ.[principal_id]
		LEFT JOIN 
		--Table columns
		sys.columns col ON col.[object_id] = perm.major_id 
		AND col.[column_id] = perm.[minor_id]
		LEFT JOIN 
		sys.objects obj ON perm.[major_id] = obj.[object_id]
		LEFT JOIN 
		sys.schemas schem ON schem.[schema_id] = perm.[major_id]
		LEFT JOIN 
		sys.database_principals imp ON imp.[principal_id] = perm.[major_id]
		LEFT JOIN 
		sys.schemas sch ON obj.schema_id = sch.schema_id 
		WHERE 
		princ.[type] IN (''S'',''U'',''G'') AND
		-- No need for these system accounts
		princ.[name] NOT IN (''sys'', ''INFORMATION_SCHEMA'')
		AND ulogin.name = ''' + @name + '''' 


	EXEC Sp_foreachdb 
	@CMD 


	DECLARE DB_AUTH_CURSOR CURSOR 
	FOR SELECT #DBname_AUTH, #DBUSRNAME, #PERMISSION_NAME, #OBJECT_OWNER, #OBJECT_TYPE, #OBJECT_NAME, #COLUMN_NAME
	FROM #DB_AUTHS 
	ORDER BY #DBname_Auth, #Object_Type 

	OPEN DB_AUTH_CURSOR 
	FETCH NEXT FROM DB_AUTH_CURSOR
	INTO @DBNAME_AUTH, @DBUSRNAME, @PERMISSION_NAME, @OBJECT_OWNER, @OBJECT_TYPE, @OBJECT_NAME, @COLUMN_NAME 

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @DBNAME_AUTH <> @SAVED_DBNAME AND @OBJECT_TYPE = 'DATABASE'
				BEGIN
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = '-- **************************************'
					PRINT @tmpstr
					SET @tmpstr = ('-- DATABASE PERMISSIONS [' + @DBNAME_AUTH + ']')
					Print @tmpstr
					SET @tmpstr = '-- **************************************'
					PRINT @tmpstr
					SET @tmpstr = ''
					PRINT @tmpstr
					SET @tmpstr = '--Login: ' + @DBUSRNAME
					PRINT @tmpstr
					SET @tmpstr = ''
					PRINT @tmpstr
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = 'USE [' + @DBNAME_AUTH + ']'
					PRINT @tmpstr
					SET @tmpstr = 'GO'
					PRINT @tmpstr
					IF @Set_Create_User = 'N'
						BEGIN
							SET @tmpstr = 'CREATE USER [' + @DBUSRNAME + '] FOR LOGIN [' + @DBUSRNAME + ']'
							PRINT @tmpstr
						END	
					SET @tmpstr = 'GRANT ' + @PERMISSION_NAME + ' TO ' + @DBUSRNAME 
					PRINT @tmpstr
					SET @SAVED_DBNAME = @DBNAME_AUTH
					SET @DBObjAuth_CNT = 0
				END
			ELSE
				IF @DBNAME_AUTH = @SAVED_DBNAME AND @OBJECT_TYPE = 'DATABASE'
					BEGIN
						SET @tmpstr = 'GRANT ' + @PERMISSION_NAME + ' TO ' + @DBUSRNAME 
						PRINT @tmpstr
					END


			IF @DBNAME_AUTH <> @SAVED_DBNAME AND @OBJECT_TYPE <> 'DATABASE'
				BEGIN
					SET @DBObjAuth_CNT = @DBObjAuth_CNT + 1
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = '--                     *********************************************'
					PRINT @tmpstr
					SET @tmpstr = ('--                    DATABASE OBJECT AUTHORITIES [' + @DBNAME_AUTH + ']')
					Print @tmpstr
					SET @tmpstr = '--                     *********************************************'
					PRINT @tmpstr
					SET @tmpstr = ' '
					PRINT @tmpstr
					SET @tmpstr = ' GRANT '+ @PERMISSION_NAME + ' ON [' + @OBJECT_OWNER + '].[' + @OBJECT_NAME + ']' + ' TO ' + @DBUSRNAME 
					PRINT @tmpstr
					SET @SAVED_DBNAME = @DBNAME_AUTH
				END
			ELSE
				IF @DBNAME_AUTH = @SAVED_DBNAME AND @OBJECT_TYPE <> 'DATABASE'
					BEGIN
						SET @DBObjAuth_CNT = @DBObjAuth_CNT + 1
							IF @DBObjAuth_CNT = 1
								BEGIN
									SET @tmpstr = ' '
									PRINT @tmpstr
									SET @tmpstr = ' '
									PRINT @tmpstr 
									SET @tmpstr = '--                     *********************************************'
									PRINT @tmpstr
									SET @tmpstr = ('--                     DATABASE OBJECT AUTHORIES [' + @DBNAME_AUTH +']')
									Print @tmpstr
									SET @tmpstr = '--                     *********************************************'
									PRINT @tmpstr
									SET @tmpstr = ' '
									PRINT @tmpstr
									SET @tmpstr = '                       USE [' + @DBNAME_AUTH + ']'
									PRINT @tmpstr
									SET @tmpstr = '                       GO'
									PRINT @tmpstr
									SET @tmpstr = ' ' 
									SET @tmpstr = '                       GRANT '+ @PERMISSION_NAME + ' ON [' + @OBJECT_OWNER + '].[' + @OBJECT_NAME + ']' + ' TO ' + @DBUSRNAME 
									PRINT @tmpstr
								END
							ELSE
								IF @DBObjAuth_CNT > 1
									BEGIN
										SET @tmpstr = '                       GRANT '+ @PERMISSION_NAME + ' ON [' + @OBJECT_OWNER + '].[' + @OBJECT_NAME + ']' + ' TO ' + @DBUSRNAME 
										PRINT @tmpstr
									END 
					END 

		FETCH NEXT FROM DB_AUTH_CURSOR
		INTO @DBNAME_AUTH, @DBUSRNAME, @PERMISSION_NAME, @OBJECT_OWNER, @OBJECT_TYPE, @OBJECT_NAME, @COLUMN_NAME
		
		END
		
	CLOSE DB_AUTH_CURSOR
	DEALLOCATE DB_AUTH_CURSOR

	DROP TABLE #DB_Auths 

	DROP TABLE #Permission 

END
CLOSE login_curs
DEALLOCATE login_curs

RETURN 0
