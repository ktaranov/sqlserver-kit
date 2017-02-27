
If Exists (Select 1 From INFORMATION_SCHEMA.ROUTINES
			Where ROUTINE_NAME = 'dba_CopyLogins'
			And ROUTINE_SCHEMA = 'dbo')
	Drop Procedure dbo.dba_CopyLogins
Go

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

Create Procedure dbo.dba_CopyLogins
	@PartnerServer sysname,
	@Debug bit = 0
As/*
Source link: http://sqlsoldier.net/wp/sqlserver/transferring-logins-to-a-database-mirrorAuthor: SQLSoldier*/
Declare @MaxID int,
	@CurrID int,
	@SQL nvarchar(max),
	@LoginName sysname,
	@IsDisabled int,
	@Type char(1),
	@SID varbinary(85),
	@SIDString nvarchar(100),
	@PasswordHash varbinary(256),
	@PasswordHashString nvarchar(300),
	@RoleName sysname,
	@Machine sysname,
	@PermState nvarchar(60),
	@PermName sysname,
	@Class tinyint,
	@MajorID int,
	@ErrNumber int,
	@ErrSeverity int,
	@ErrState int,
	@ErrProcedure sysname,
	@ErrLine int,
	@ErrMsg nvarchar(2048)
Declare @Logins Table (LoginID int identity(1, 1) not null primary key,
						[Name] sysname not null,
						[SID] varbinary(85) not null,
						IsDisabled int not null,
						[Type] char(1) not null,
						PasswordHash varbinary(256) null)
Declare @Roles Table (RoleID int identity(1, 1) not null primary key,
					RoleName sysname not null,
					LoginName sysname not null)
Declare @Perms Table (PermID int identity(1, 1) not null primary key,
					LoginName sysname not null,
					PermState nvarchar(60) not null,
					PermName sysname not null,
					Class tinyint not null,
					ClassDesc nvarchar(60) not null,
					MajorID int not null,
					SubLoginName sysname null,
					SubEndPointName sysname null)

Set NoCount On;

If CharIndex('\', @PartnerServer) > 0
  Begin
	Set @Machine = LEFT(@PartnerServer, CharIndex('\', @PartnerServer) - 1);
  End
Else
  Begin
	Set @Machine = @PartnerServer;
  End

-- Get all Windows logins from principal server
Set @SQL = 'Select P.name, P.sid, P.is_disabled, P.type, L.password_hash' + CHAR(10) +
		'From ' + QUOTENAME(@PartnerServer) + '.master.sys.server_principals P' + CHAR(10) +
		'Left Join ' + QUOTENAME(@PartnerServer) + '.master.sys.sql_logins L On L.principal_id = P.principal_id' + CHAR(10) +
		'Where P.type In (''U'', ''G'', ''S'')' + CHAR(10) +
		'And P.name <> ''sa''' + CHAR(10) +
		'And P.name Not Like ''##%''' + CHAR(10) +
		'And CharIndex(''' + @Machine + '\'', P.name) = 0;';

Insert Into @Logins (Name, SID, IsDisabled, Type, PasswordHash)
Exec sp_executesql @SQL;

-- Get all roles from principal server
Set @SQL = 'Select RoleP.name, LoginP.name' + CHAR(10) +
		'From ' + QUOTENAME(@PartnerServer) + '.master.sys.server_role_members RM' + CHAR(10) +
		'Inner Join ' + QUOTENAME(@PartnerServer) + '.master.sys.server_principals RoleP' +
		CHAR(10) + char(9) + 'On RoleP.principal_id = RM.role_principal_id' + CHAR(10) +
		'Inner Join ' + QUOTENAME(@PartnerServer) + '.master.sys.server_principals LoginP' +
		CHAR(10) + char(9) + 'On LoginP.principal_id = RM.member_principal_id' + CHAR(10) +
		'Where LoginP.type In (''U'', ''G'', ''S'')' + CHAR(10) +
		'And LoginP.name <> ''sa''' + CHAR(10) +
		'And LoginP.name Not Like ''##%''' + CHAR(10) +
		'And RoleP.type = ''R''' + CHAR(10) +
		'And CharIndex(''' + @Machine + '\'', LoginP.name) = 0;';

Insert Into @Roles (RoleName, LoginName)
Exec sp_executesql @SQL;

-- Get all explicitly granted permissions
Set @SQL = 'Select P.name Collate database_default,' + CHAR(10) +
		'	SP.state_desc, SP.permission_name, SP.class, SP.class_desc, SP.major_id,' + CHAR(10) +
		'	SubP.name Collate database_default,' + CHAR(10) +
		'	SubEP.name Collate database_default' + CHAR(10) +
		'From ' + QUOTENAME(@PartnerServer) + '.master.sys.server_principals P' + CHAR(10) +
		'Inner Join ' + QUOTENAME(@PartnerServer) + '.master.sys.server_permissions SP' + CHAR(10) +
		CHAR(9) + 'On SP.grantee_principal_id = P.principal_id' + CHAR(10) +
		'Left Join ' + QUOTENAME(@PartnerServer) + '.master.sys.server_principals SubP' + CHAR(10) +
		CHAR(9) + 'On SubP.principal_id = SP.major_id And SP.class = 101' + CHAR(10) +
		'Left Join ' + QUOTENAME(@PartnerServer) + '.master.sys.endpoints SubEP' + CHAR(10) +
		CHAR(9) + 'On SubEP.endpoint_id = SP.major_id And SP.class = 105' + CHAR(10) +
		'Where P.type In (''U'', ''G'', ''S'')' + CHAR(10) +
		'And P.name <> ''sa''' + CHAR(10) +
		'And P.name Not Like ''##%''' + CHAR(10) +
		'And CharIndex(''' + @Machine + '\'', P.name) = 0;'

Insert Into @Perms (LoginName, PermState, PermName, Class, ClassDesc, MajorID, SubLoginName, SubEndPointName)
Exec sp_executesql @SQL;

Select @MaxID = Max(LoginID), @CurrID = 1
From @Logins;

While @CurrID <= @MaxID
  Begin
	Select @LoginName = Name,
		@IsDisabled = IsDisabled,
		@Type = [Type],
		@SID = [SID],
		@PasswordHash = PasswordHash
	From @Logins
	Where LoginID = @CurrID;
	
	If Not Exists (Select 1 From sys.server_principals
				Where name = @LoginName)
	  Begin
		Set @SQL = 'Create Login ' + quotename(@LoginName)
		If @Type In ('U', 'G')
		  Begin
			Set @SQL = @SQL + ' From Windows;'
		  End
		Else
		  Begin
			Set @PasswordHashString = '0x' +
				Cast('' As XML).value('xs:hexBinary(sql:variable("@PasswordHash"))', 'nvarchar(300)');
			
			Set @SQL = @SQL + ' With Password = ' + @PasswordHashString + ' HASHED, ';
			
			Set @SIDString = '0x' +
				Cast('' As XML).value('xs:hexBinary(sql:variable("@SID"))', 'nvarchar(100)');
			Set @SQL = @SQL + 'SID = ' + @SIDString + ';';
		  End

		If @Debug = 0
		  Begin
			Begin Try
				Exec sp_executesql @SQL;
			End Try
			Begin Catch
				Set @ErrNumber = ERROR_NUMBER();
				Set @ErrSeverity = ERROR_SEVERITY();
				Set @ErrState = ERROR_STATE();
				Set @ErrProcedure = ERROR_PROCEDURE();
				Set @ErrLine = ERROR_LINE();
				Set @ErrMsg = ERROR_MESSAGE();
				RaisError(@ErrMsg, 1, 1);
			End Catch
		  End
		Else
		  Begin
			Print @SQL;
		  End
		
		If @IsDisabled = 1
		  Begin
			Set @SQL = 'Alter Login ' + quotename(@LoginName) + ' Disable;'
			If @Debug = 0
			  Begin
				Begin Try
					Exec sp_executesql @SQL;
				End Try
				Begin Catch
					Set @ErrNumber = ERROR_NUMBER();
					Set @ErrSeverity = ERROR_SEVERITY();
					Set @ErrState = ERROR_STATE();
					Set @ErrProcedure = ERROR_PROCEDURE();
					Set @ErrLine = ERROR_LINE();
					Set @ErrMsg = ERROR_MESSAGE();
					RaisError(@ErrMsg, 1, 1);
				End Catch
			  End
			Else
			  Begin
				Print @SQL;
			  End
		  End
		End
	Set @CurrID = @CurrID + 1;
  End

Select @MaxID = Max(RoleID), @CurrID = 1
From @Roles;

While @CurrID <= @MaxID
  Begin
	Select @LoginName = LoginName,
		@RoleName = RoleName
	From @Roles
	Where RoleID = @CurrID;

	If Not Exists (Select 1 From sys.server_role_members RM
				Inner Join sys.server_principals RoleP
					On RoleP.principal_id = RM.role_principal_id
				Inner Join sys.server_principals LoginP
					On LoginP.principal_id = RM.member_principal_id
				Where LoginP.type In ('U', 'G', 'S')
				And RoleP.type = 'R'
				And RoleP.name = @RoleName
				And LoginP.name = @LoginName)
	  Begin
		If @Debug = 0
		  Begin
			Exec sp_addsrvrolemember @rolename = @RoleName,
							@loginame = @LoginName;
		  End
		Else
		  Begin
			Print 'Exec sp_addsrvrolemember @rolename = ''' + @RoleName + ''',';
			Print '		@loginame = ''' + @LoginName + ''';';
		  End
	  End

	Set @CurrID = @CurrID + 1;
  End

Select @MaxID = Max(PermID), @CurrID = 1
From @Perms;

While @CurrID <= @MaxID
  Begin
	Select @PermState = PermState,
		@PermName = PermName,
		@Class = Class,
		@LoginName = LoginName,
		@MajorID = MajorID,
		@SQL = PermState + space(1) + PermName + SPACE(1) +
			Case Class When 101 Then 'On Login::' + QUOTENAME(SubLoginName)
					When 105 Then 'On ' + ClassDesc + '::' + QUOTENAME(SubEndPointName)
					Else '' End +
			' To ' + QUOTENAME(LoginName) + ';'
	From @Perms
	Where PermID = @CurrID;
	
	If Not Exists (Select 1 From sys.server_principals P
				Inner Join sys.server_permissions SP On SP.grantee_principal_id = P.principal_id
				Where SP.state_desc = @PermState
				And SP.permission_name = @PermName
				And SP.class = @Class
				And P.name = @LoginName
				And SP.major_id = @MajorID)
	  Begin
		If @Debug = 0
		  Begin
			Begin Try
				Exec sp_executesql @SQL;
			End Try
			Begin Catch
				Set @ErrNumber = ERROR_NUMBER();
				Set @ErrSeverity = ERROR_SEVERITY();
				Set @ErrState = ERROR_STATE();
				Set @ErrProcedure = ERROR_PROCEDURE();
				Set @ErrLine = ERROR_LINE();
				Set @ErrMsg = ERROR_MESSAGE();
				RaisError(@ErrMsg, 1, 1);
			End Catch
		  End
		Else
		  Begin
			Print @SQL;
		  End
	  End

	Set @CurrID = @CurrID + 1;
  End

Set NoCount Off;
