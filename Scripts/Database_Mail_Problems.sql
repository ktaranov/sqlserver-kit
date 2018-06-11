/*
Author: Kenneth Fisher
Original link: https://sqlstudies.com/2013/07/29/notes-on-debugging-database-mail-problems/
*/

USE msdb;
GO
 
-- Check that the service broker is enabled on MSDB. 
-- Is_broker_enabled must be 1 to use database mail.
SELECT is_broker_enabled FROM sys.databases WHERE name = 'msdb';
-- Check that Database mail is turned on. 
-- Run_value must be 1 to use database mail.
-- If you need to change it this option does not require
-- a server restart to take effect.
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'Database Mail XPs';
 
-- Check the Mail queues
-- This system stored procedure lists the two Database Mail queues.
-- The optional @queue_type parameter tells it to only list that queue.
-- The list contains the length of the queue (number of emails waiting),
-- the state of the queue (INACTIVE, NOTIFIED, RECEIVES_OCCURRING, the 
-- last time the queue was empty and the last time the queue was active.
EXEC msdb.dbo.sysmail_help_queue_sp -- @queue_type = 'Mail' ;
 
-- Check the status (STARTED or STOPPED) of the sysmail database queues
-- EXEC msdb.dbo.sysmail_start_sp -- Start the queue
-- EXEC msdb.dbo.sysmail_stop_sp -- Stop the queue
EXEC msdb.dbo.sysmail_help_status_sp;
 
-- Check the different database mail settings.
-- These are system stored procedures that list the general
-- settings, accounts, profiles, links between the accounts
-- and profiles and the link between database principles and
-- database mail profiles.
-- These are generally controlled by the database mail wizard.
 
EXEC msdb.dbo.sysmail_help_configure_sp;
EXEC msdb.dbo.sysmail_help_account_sp;
--  Check that your server name and server type are correct in the
--      account you are using.
--  Check that your email_address is correct in the account you are
--      using.
EXEC msdb.dbo.sysmail_help_profile_sp;
--  Check that you are using a valid profile in your dbmail command.
EXEC msdb.dbo.sysmail_help_profileaccount_sp;
--  Check that your account and profile are joined together
--      correctly in sysmail_help_profileaccount_sp.
EXEC msdb.dbo.sysmail_help_principalprofile_sp;
 
-- I’m doing a TOP 100 on these next several queries as they tend
-- to contain a great deal of data.  Obviously if you need to get
-- more than 100 rows this can be changed.
-- Check the database mail event log.
-- Particularly for the event_type of "error".  These are where you
-- will find the actual sending error.
SELECT TOP 100 * 
FROM msdb.dbo.sysmail_event_log 
ORDER BY last_mod_date DESC;
 
-- Check the actual emails queued
-- Look at sent_status to see 'failed' or 'unsent' emails.
SELECT TOP 100 * 
FROM msdb.dbo.sysmail_allitems 
ORDER BY last_mod_date DESC;
 
-- Check the emails that actually got sent. 
-- This is a view on sysmail_allitems WHERE sent_status = 'sent'
SELECT TOP 100 * 
FROM msdb.dbo.sysmail_sentitems 
ORDER BY last_mod_date DESC;
 
-- Check the emails that failed to be sent.
-- This is a view on sysmail_allitems WHERE sent_status = 'failed'
SELECT TOP 100 * 
FROM msdb.dbo.sysmail_faileditems 
ORDER BY last_mod_date DESC
 
-- Clean out unsent emails
-- Usually I do this before releasing the queue again after fixing the problem.
-- Assuming of course that I don't want to send out potentially thousands of 
-- emails that are who knows how old.
-- Obviously can be used to clean out emails of any status.
EXEC msdb.dbo.sysmail_delete_mailitems_sp
    @sent_before =  GETDATE() - 30,
    @sent_status = 'unsent';
