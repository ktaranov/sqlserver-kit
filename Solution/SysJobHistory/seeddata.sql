IF NOT EXISTS (select * from DBA_PM_sysjobhistory_config)
BEGIN
	--insert base seed data, but only if this is the first run of SFU installer
	INSERT INTO DBA_sysjobhistory_config	VALUES (NULL,'ETL',1,90)
	INSERT INTO DBA_sysjobhistory_config	VALUES ('(default)','(default)',3,90)
	INSERT INTO DBA_sysjobhistory_config	VALUES (NULL,'SFU TOOL',1,90)
END;
