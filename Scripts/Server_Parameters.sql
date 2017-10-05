/*
Author: SSMS Default report
*/

BEGIN try
DECLARE @configurations_option_table table (
        name nvarchar(128)
,       run_value bigint
,       default_value bigint 
);
DECLARE @sp_configure_table table (
        name nvarchar(128)
,       minimum bigint
,       maximum bigint
,       config_value bigint
,       run_value bigint 
);
DECLARE @tracestatus table(
        TraceFlag nvarchar(40)
,       Status tinyint
,       Global tinyint
,       Session tinyint
);

INSERT INTO @sp_configure_table 
SELECT NAME
,       convert(bigint,minimum)
,       convert(bigint,maximum)
,       convert(bigint,value)
,       convert(bigint,value_in_use) 
FROM sys.configurations;

INSERT INTO @configurations_option_table VALUES('Ad Hoc Distributed Queries',0,0);
INSERT INTO @configurations_option_table VALUES('affinity I/O mask',0,0);
INSERT INTO @configurations_option_table VALUES('affinity mask',0,0);
INSERT INTO @configurations_option_table VALUES('Agent XPs',0,0);
INSERT INTO @configurations_option_table VALUES('allow updates',0,0);
INSERT INTO @configurations_option_table VALUES('awe enabled',0,0);
INSERT INTO @configurations_option_table VALUES('blocked process threshold',0,0);
INSERT INTO @configurations_option_table VALUES('c2 audit mode',0,0);
INSERT INTO @configurations_option_table VALUES('clr enabled',0,0);
INSERT INTO @configurations_option_table VALUES('cost threshold for parallelism',5,5);
INSERT INTO @configurations_option_table VALUES('cross db ownership chaining',0,0);
INSERT INTO @configurations_option_table VALUES('cursor threshold',-1,-1);
INSERT INTO @configurations_option_table VALUES('Database Mail XPs',0,0);
INSERT INTO @configurations_option_table VALUES('default full-text language',1033,1033);
INSERT INTO @configurations_option_table VALUES('default language',0,0);
INSERT INTO @configurations_option_table VALUES('default trace enabled',1,1);
INSERT INTO @configurations_option_table VALUES('disallow results from triggers',0,0);
INSERT INTO @configurations_option_table VALUES('fill factor (%);',0,0);
INSERT INTO @configurations_option_table VALUES('ft crawl bandwidth (max);',100,100);
INSERT INTO @configurations_option_table VALUES('ft crawl bandwidth (min);',0,0);
INSERT INTO @configurations_option_table VALUES('ft notify bandwidth (max);',100,100);
INSERT INTO @configurations_option_table VALUES('ft notify bandwidth (min);',0,0);
INSERT INTO @configurations_option_table VALUES('index create memory (KB);',0,0);
INSERT INTO @configurations_option_table VALUES('in-doubt xact resolution',0,0);
INSERT INTO @configurations_option_table VALUES('lightweight pooling',0,0);
INSERT INTO @configurations_option_table VALUES('locks',0,0);
INSERT INTO @configurations_option_table VALUES('max degree of parallelism',0,0);
INSERT INTO @configurations_option_table VALUES('max full-text crawl range',4,4);
INSERT INTO @configurations_option_table VALUES('max server memory (MB);',2147483647,2147483647);
INSERT INTO @configurations_option_table VALUES('max text repl size (B);',65536,65536);
INSERT INTO @configurations_option_table VALUES('max worker threads',0,0);
INSERT INTO @configurations_option_table VALUES('media retention',0,0);
INSERT INTO @configurations_option_table VALUES('min memory per query (KB);',1024,1024);
INSERT INTO @configurations_option_table VALUES('min server memory (MB);',0,0);
INSERT INTO @configurations_option_table VALUES('nested triggers',1,1);
INSERT INTO @configurations_option_table VALUES('network packet size (B);',4096,4096);
INSERT INTO @configurations_option_table VALUES('Ole Automation Procedures',0,0);
INSERT INTO @configurations_option_table VALUES('open objects',0,0);
INSERT INTO @configurations_option_table VALUES('PH timeout (s);',60,60);
INSERT INTO @configurations_option_table VALUES('precompute rank',0,0);
INSERT INTO @configurations_option_table VALUES('priority boost',0,0);
INSERT INTO @configurations_option_table VALUES('query governor cost limit',0,0);
INSERT INTO @configurations_option_table VALUES('query wait (s);',-1,-1);
INSERT INTO @configurations_option_table VALUES('recovery interval (min);',0,0);
INSERT INTO @configurations_option_table VALUES('remote access',1,1);
INSERT INTO @configurations_option_table VALUES('remote admin connections',0,0);
INSERT INTO @configurations_option_table VALUES('remote login timeout (s);',20,20);
INSERT INTO @configurations_option_table VALUES('remote proc trans',0,0);
INSERT INTO @configurations_option_table VALUES('remote query timeout (s);',600,600);
INSERT INTO @configurations_option_table VALUES('Replication XPs',0,0);
INSERT INTO @configurations_option_table VALUES('RPC parameter data validation',0,0);
INSERT INTO @configurations_option_table VALUES('scan for startup procs',0,0);
INSERT INTO @configurations_option_table VALUES('server trigger recursion',1,1);
INSERT INTO @configurations_option_table VALUES('set working set size',0,0);
INSERT INTO @configurations_option_table VALUES('show advanced options',0,0);
INSERT INTO @configurations_option_table VALUES('SMO and DMO XPs',1,1);
INSERT INTO @configurations_option_table VALUES('SQL Mail XPs',0,0);
INSERT INTO @configurations_option_table VALUES('transform noise words',0,0);
INSERT INTO @configurations_option_table VALUES('two digit year cutoff',2049,2049);
INSERT INTO @configurations_option_table VALUES('user connections',0,0);
INSERT INTO @configurations_option_table VALUES('user options',0,0);
INSERT INTO @configurations_option_table VALUES('Web Assistant Procedures',0,0);
INSERT INTO @configurations_option_table VALUES('xp_cmdshell',0,0);

INSERT INTO @tracestatus exec('dbcc tracestatus');
UPDATE @tracestatus set TraceFlag = 'Traceflag ('+TraceFlag+')';

SELECT 1 as l1
,       st.name as name 
,       convert(nvarchar(15),st.run_value) as run_value
,       convert(nvarchar(15),ct.default_value) as default_value
,       1 as msg  
FROM @configurations_option_table ct 
LEFT join  @sp_configure_table st on (ct.name = st.name  and ct.default_value != st.run_value)
UNION
SELECT 1 as l1
,       TraceFlag as name
,       convert(nvarchar(15), Status) as run_value
,       '0' as default_value
,       1 as msg  
FROM @tracestatus
WHERE Global=1
ORDER BY name;
END try

BEGIN catch
SELECT -100 as l1
,       ERROR_NUMBER() as name
,       ERROR_SEVERITY() as run_value
,       ERROR_STATE() as default_value
,       ERROR_MESSAGE() as msg
END catch
