/*
Original link: https://sqlundercover.com/2017/08/18/undercover-toolbox-sp_changedatabaseownership-producing-statements-to-alter-authorisation/
*/

USE [master]
go
 
/**********************************************
--Procedure Name: sp_ChangeDatabaseOwnerShip
--Author: Adrian Buckman
--Create Date: 17/08/2017
 
--Description: Produce a script that will provide ALTER statements to change the database
--ownership to the new owner and also ALTER statements to revert back to the old owner
 
--Revision History:
.
 
**********************************************/
 
CREATE PROCEDURE sp_ChangeDatabaseOwnerShip
(
@DBOwner NVARCHAR(128) = NULL,
@Help BIT = 0
)
AS
 
IF @Help = 1
BEGIN
PRINT 'Parameters:
@DBOwner NVARCHAR(128) - Set the new owner name here'
END
 
IF @Help = 0
BEGIN
DECLARE @UserSid VARBINARY = SUSER_SID(@DBOwner)
 
IF @UserSid IS NOT NULL
BEGIN
 
SELECT DISTINCT
sys.databases.Name AS Databasename,
COALESCE(SUSER_SNAME(sys.databases.owner_sid),'') AS CurrentOwner,
'ALTER AUTHORIZATION ON DATABASE::['+sys.databases.name +'] TO ['+@DBOwner+'];' AS ChangeToNewOwner,
'ALTER AUTHORIZATION ON DATABASE::['+sys.databases.name +'] TO ['+COALESCE(SUSER_SNAME(sys.databases.owner_sid),'')+'];' AS RevertToOriginalOwner
FROM
sys.databases
LEFT JOIN sys.availability_databases_cluster ADC ON sys.databases.name = ADC.database_name
LEFT JOIN sys.dm_hadr_availability_group_states st ON st.group_id = ADC.group_id
LEFT JOIN master.sys.availability_groups ag ON st.group_id = AG.group_id
WHERE (primary_replica = @@Servername
AND sys.databases.owner_sid != @UserSid)
OR (sys.databases.owner_sid != @UserSid
AND sys.databases.state = 0
AND sys.databases.source_database_id IS NULL
AND sys.databases.replica_id IS NULL)
 
END
ELSE
BEGIN
RAISERROR('No SID found for the owner name you have provided - please check the owner name and try again',11,1)
END
 
END