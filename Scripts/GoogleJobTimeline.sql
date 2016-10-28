/*
Author: Theo Ekelmans
Original link: http://www.sqlservercentral.com/articles/Agent+jobs/127346/
*/

--****************************************************************************************
-- This script returns a (graphical) timeline for all SQL jobs using google graph
--****************************************************************************************
-- Version: 1.1
-- Author:	Theo Ekelmans
-- Email:	theo@ekelmans.com
-- Date:	2015-06-24

-- Version: 1.2
-- Author:	Theo Ekelmans
-- Email:	theo@ekelmans.com
-- Date:	2015-07-28
-- Change:	Updated using feedback from the SqlServerCentralCommunity
--****************************************************************************************
set nocount on 

declare @DT datetime 
declare @StartDT datetime 
declare @EndDT datetime 
declare @MinRuntimeInSec int
declare @SendMail int
declare @ReturnRecocordset int
declare @Emailprofilename varchar(50)
declare @EmailRecipients varchar(50)

--***************************************************************************************
-- Set variables
--***************************************************************************************
set @StartDT = getdate() - 1
set @EndDT = getdate()
set @MinRuntimeInSec = 60 --Ignore jobs with runtime smaller then this

set @ReturnRecocordset = 0 
set @SendMail = 1
set @Emailprofilename = '<ProfileName>'
set @EmailRecipients = '<email>'

--***************************************************************************************
-- Pre-run cleanup (just in case)
--***************************************************************************************
IF OBJECT_ID('tempdb..#JobRuntime') IS NOT NULL DROP TABLE #JobRuntime;
IF OBJECT_ID('tempdb..##GoogleGraph') IS NOT NULL DROP TABLE ##GoogleGraph;

--***************************************************************************************
-- Create a table for HTML assembly
--***************************************************************************************
create table ##GoogleGraph ([ID] [int] IDENTITY(1,1) NOT NULL,
							[HTML] [varchar](8000) NULL)

--***************************************************************************************
-- Create the Job Runtime information table
--***************************************************************************************
select	job.name as JobName
		,cat.name as CatName
		,CONVERT(DATETIME, CONVERT(CHAR(8), run_date, 112) + ' ' + STUFF(STUFF(RIGHT('000000' + CONVERT(VARCHAR(8), run_time), 6), 5, 0, ':'), 3, 0, ':'), 120) as SDT
		,dateadd(	s,
					((run_duration/10000)%100 * 3600) + ((run_duration/100)%100 * 60) + run_duration%100 ,
					CONVERT(DATETIME, CONVERT(CHAR(8), run_date, 112) + ' ' + STUFF(STUFF(RIGHT('000000' + CONVERT(VARCHAR(8), run_time), 6), 5, 0, ':'), 3, 0, ':'), 120) 
				) as EDT
into	#JobRuntime
FROM	msdb.dbo.sysjobs job 
			left JOIN msdb.dbo.sysjobhistory his
				ON his.job_id = job.job_id
			INNER JOIN msdb.dbo.syscategories cat
				ON job.category_id = cat.category_id
where	CONVERT(DATETIME, CONVERT(CHAR(8), run_date, 112) + ' ' + STUFF(STUFF(RIGHT('000000' + CONVERT(VARCHAR(8), run_time), 6), 5, 0, ':'), 3, 0, ':'), 120) between @StartDT and @EndDT
and		step_id = 0 -- step_id = 0 is the entire job, step_id > 0 is actual step number
and		((run_duration/10000)%100 * 3600) + ((run_duration/100)%100 * 60) + run_duration%100 > @MinRuntimeInSec  -- Ignore trivial runtimes
order by SDT

if not exists (select 1 from #JobRuntime) 
	goto NothingToDo

--***************************************************************************************
-- Format for google graph - Header 
-- (Split into multiple inserts because the default text result setting is 256 chars)
--***************************************************************************************
insert into ##GoogleGraph (HTML) 
select '<html>
	<head>
	<!--<META HTTP-EQUIV="refresh" CONTENT="3">-->
	<script type="text/javascript" src="https://www.google.com/jsapi?autoload={''modules'':[{''name'':''visualization'', ''version'':''1'',''packages'':[''timeline'']}]}"></script>'
insert into ##GoogleGraph (HTML) 
select '    <script type="text/javascript">
	google.setOnLoadCallback(drawChart);
	function drawChart() {'
insert into ##GoogleGraph (HTML) 
select '	var container = document.getElementById(''JobTimeline'');
	var chart = new google.visualization.Timeline(container);
	var dataTable = new google.visualization.DataTable();'
insert into ##GoogleGraph (HTML) 
select '	dataTable.addColumn({ type: ''string'', id: ''Position'' });
	dataTable.addColumn({ type: ''string'', id: ''Name'' });
	dataTable.addColumn({ type: ''date'', id: ''Start'' });
	dataTable.addColumn({ type: ''date'', id: ''End'' });
	dataTable.addRows([
'

--***************************************************************************************
-- Format for google graph - Data
--***************************************************************************************
insert into ##GoogleGraph (HTML) 
SELECT  '		[ ' 
		+'''' + CatName  + ''', '
		+'''' + JobName  + ''', '
		+'new Date('
		+     cast(DATEPART(year ,  SDT) as varchar(4))
		+', '+cast(DATEPART(month,  SDT) -1 as varchar(4)) --Java months count from 0
		+', '+cast(DATEPART(day,    SDT) as varchar(4))
		+', '+cast(DATEPART(hour,   SDT) as varchar(4))
		+', '+cast(DATEPART(minute, SDT) as varchar(4))
		+', '+cast(DATEPART(second, SDT) as varchar(4)) 
		+'), '

		+'new Date('
		+     cast(DATEPART(year,   EDT) as varchar(4))
		+', '+cast(DATEPART(month,  EDT) -1 as varchar(4)) --Java months count from 0
		+', '+cast(DATEPART(day,    EDT) as varchar(4))
		+', '+cast(DATEPART(hour,   EDT) as varchar(4))
		+', '+cast(DATEPART(minute, EDT) as varchar(4))
		+', '+cast(DATEPART(second, EDT) as varchar(4)) 
		+ ') ],' --+ char(10)
from	#JobRuntime 

--***************************************************************************************
-- Format for google graph - Footer
--***************************************************************************************
insert into ##GoogleGraph (HTML) 
select '	]);

	var options = 
	{
		timeline: 	{ 
					groupByRowLabel: true,
					colorByRowLabel: false,
					singleColor: false,
					rowLabelStyle: {fontName: ''Helvetica'', fontSize: 14 },
					barLabelStyle: {fontName: ''Helvetica'', fontSize: 14 }					
					}
	};

	chart.draw(dataTable, options);

}'
insert into ##GoogleGraph (HTML) 
select '
	</script>
	</head>
	<body>'
	+'<font face="Helvetica" size="3" >'
	+'Job timeline on: '+@@servername
	+' from '+convert(varchar(20), @StartDT, 120)
	+' until '+convert(varchar(20), @EndDT, 120)
	+case when @MinRuntimeInSec = 0 then '' else ' (hiding jobs with runtime < '+cast(@MinRuntimeInSec as varchar(10))+' seconds)' end
	+'</font>
		<div id="JobTimeline" style="width: 1885px; height: 900px;"></div>
	</body>
</html>'

--***************************************************************************************
-- Output HTML page - copy output & paste to a .HTML file and open with google chrome
--***************************************************************************************
if @ReturnRecocordset = 1 
	select html from ##GoogleGraph order by ID

--***************************************************************************************
-- Send Email - 
--***************************************************************************************
if @SendMail = 1 
	execute msdb.dbo.sp_send_dbmail	
		 @profile_name = @Emailprofilename
		,@recipients = @EmailRecipients
		,@subject = 'JobTimeline'
		,@body = 'See attachment for JobTimeline, open with Google Chrome!' 
		,@body_format = 'HTML' -- or TEXT
		,@importance = 'Normal' --Low Normal High
		,@sensitivity = 'Normal' --Normal Personal Private Confidential
		,@execute_query_database = 'master'
		,@query_result_header = 1
		,@query = 'set nocount on; SELECT HTML FROM ##GoogleGraph'
		,@query_result_no_padding = 1  -- prevent SQL adding padding spaces in the result
		--,@query_no_truncate= 1       -- mutually exclusive with @query_result_no_padding 
		,@attach_query_result_as_file = 1
		,@query_attachment_filename= 'JobTimeline.HTML'


goto Cleanup

--***************************************************************************************
-- Just in case....
--***************************************************************************************
NothingToDo:

print 'No job runtime info found....'

--***************************************************************************************
-- Cleanup
--***************************************************************************************
Cleanup:
IF OBJECT_ID('tempdb..#JobRuntime') IS NOT NULL DROP TABLE #JobRuntime;
IF OBJECT_ID('tempdb..##GoogleGraph') IS NOT NULL DROP TABLE ##GoogleGraph;
