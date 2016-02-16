IF NOT EXISTS (select * from sys.objects WHERE name = 'DBA_sysjobhistory_config')
BEGIN
	CREATE TABLE DBA_sysjobhistory_config (
		JobName  varchar(256), --(name of the job for this retention setting)
		CategoryName varchar(256), --(only JobName or CategoryName should be completed)
		NumDaysToRetain int , --(number of days to retain for this entry)
		NumFailureDaysToRetain int --(number of days to retain for failure entries)
	);
END
GO

IF EXISTS (select * from sys.objects WHERE name = 'v_sysjobs')
BEGIN
	DROP VIEW v_sysjobs
END;
GO
CREATE VIEW v_sysjobs
AS 
SELECT 
	CASE c.category_id WHEN 0 THEN NULL ELSE c.name END AS CategoryName,
	j.job_id AS job_id,
	j.name AS JobName
FROM msdb..sysjobs j
JOIN msdb..syscategories c
	ON j.category_id = c.category_id
GO


IF EXISTS (select * from sys.objects WHERE name = 'v_sysjobhistory')
BEGIN
	DROP VIEW v_sysjobhistory
END;
GO
CREATE VIEW v_sysjobhistory
AS 
	SELECT 
		instance_id,
		job_id,
		run_date,
		run_time,
		run_status
	FROM msdb..sysjobhistory
GO


