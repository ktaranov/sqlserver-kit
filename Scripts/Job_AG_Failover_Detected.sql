/*
<documentation>
  <summary>Use this event to run a job when the replica becomes primary</summary>
  <returns>Create job to resume AG database data movement for suspended databases.</returns>
  <created>2020-08-06 by Wayne Sheffield</created>
  <version>1.0</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Job_AG_Failover_Detected.sql</sourceLink>
  <originalLink>https://blog.waynesheffield.com/wayne/archive/2020/08/availability-group-issues-fixed-with-alerts/</originalLink>
</documentation>
*/

/*
Use this event to run a job when the replica becomes primary
*/
USE msdb;
GO
EXEC msdb.dbo.sp_add_alert @name=N'AG Failover Detected - Now Primary',
@message_id=1480,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=0,
@event_description_keyword=N'"RESOLVING" to "PRIMARY"',
@job_id=N'00000000-0000-0000-0000-000000000000';
GO
/*
Use this event to run a job when the replica becomes secondary
*/
USE msdb;
GO
EXEC msdb.dbo.sp_add_alert @name=N'AG Failover Detected - Now Secondary',
@message_id=1480,
@severity=0,
@enabled=1,
@delay_between_responses=0,
@include_event_description_in=0,
@event_description_keyword=N'"RESOLVING" to "SECONDARY"',
@job_id=N'00000000-0000-0000-0000-000000000000';
GO
