/*
Author: Tim Ford
Original link: http://sqlmag.com/database-administration/how-set-sql-server-database-mail-one-easy-script
*/

====================================
-- DATABASE MAIL CONFIGURATION
--================================================================
--==========================================================
-- Create a Database Mail account
--==========================================================
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = '<account_name, DBM account name, Database Mail Primary Account>',
    @description = '<description, , SQL Server Notification Service>',
    @email_address = '<email_address, email address for DBM. Does not need a valid mail account ,>',
    @replyto_address = '<replyto_address, reply email address for DBM. Does not need a valid mail account ,>',
    @display_name = '<display_name, friendly name for emails sent via DBM, Database Mail Account>',
    @mailserver_name = '<mailserver_name, smtp mail server name,>',
        @port = <port_number, port number of the mailserver, 25>;



--==========================================================
-- Create a Database Mail Profile
--==========================================================
DECLARE @profile_id INT, @profile_description sysname;
SELECT @profile_id = COALESCE(MAX(profile_id),1) FROM msdb.dbo.sysmail_profile
SELECT @profile_description = 'Database Mail Profile for ' + @@servername 


EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = '<profile_name, DBM profile name, Database Mail Primary Profile>',
    @description = @profile_description;

-- Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = '<profile_name, DBM profile name, Database Mail Primary Profile>',
    @account_name = '<account_name, DBM account name, Database Mail Primary Account>',
    @sequence_number = @profile_id;

-- Grant access to the profile to the DBMailUsers role
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = '<profile_name, DBM profile name, Database Mail Primary Profile>',
    @principal_id = 0,
    @is_default = 1 ;


--==========================================================
-- Enable Database Mail
--==========================================================
USE master;
GO

sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE
GO 


--EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', N'DatabaseMailProfile', N'REG_SZ', N''
--EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', N'UseDatabaseMail', N'REG_DWORD', 1
--GO

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder = 0
GO


--==========================================================
-- Review Outcomes
--==========================================================
SELECT * FROM msdb.dbo.sysmail_profile;
SELECT * FROM msdb.dbo.sysmail_account;
GO


--==========================================================
-- Test Database Mail
--==========================================================
DECLARE @sub VARCHAR(100)
DECLARE @body_text NVARCHAR(MAX)
SELECT @sub = 'Test from New SQL install on ' + @@servername
SELECT @body_text = N'This is a test of Database Mail.' + CHAR(13) + CHAR(13) + 'SQL Server Version Info: ' + CAST(@@version AS VARCHAR(500))

EXEC msdb.dbo.[sp_send_dbmail] 
    @profile_name = '<profile_name, DBM profile name, Database Mail Primary Profile>'
  , @recipients = '<test_email_address, email address to send test email,>'
  , @subject = @sub
  , @body = @body_text





--================================================================
-- SQL Agent Properties Configuration
--================================================================
EXEC msdb.dbo.sp_set_sqlagent_properties 
        @databasemail_profile = '<profile_name, DBM profile name, Database Mail Primary Profile>'
        , @use_databasemail=1
GO