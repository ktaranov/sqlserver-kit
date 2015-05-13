set transaction isolation level read uncommitted
set nocount on


-----------------------------------------------------------------------------------------------------------------------------
--	eRROR tRAPPING: cHECK iF pROCEDURE aLREADY eXISTS aND cREATE sHELL iF aPPLICABLE
-----------------------------------------------------------------------------------------------------------------------------

if object_id (n'DBO.USP_sql_sERVER_sYSTEM_rEPORT', n'p') is null
begin

	execute ('create procedure DBO.USP_sql_sERVER_sYSTEM_rEPORT as select 1 as SHELL')

end
go


-----------------------------------------------------------------------------------------------------------------------------
--	sTORED pROCEDURE dETAILS: lISTING oF sTANDARD dETAILS rELATED tO tHE sTORED pROCEDURE
-----------------------------------------------------------------------------------------------------------------------------

--	pURPOSE: sql sERVER sYSTEM rEPORT
--	cREATE dATE (mm/dd/yyyy): 05/12/2010
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


-----------------------------------------------------------------------------------------------------------------------------
--	mODIFICATION hISTORY: lISTING oF aLL mODIFICATIONS sINCE oRIGINAL iMPLEMENTATION
-----------------------------------------------------------------------------------------------------------------------------

--	dESCRIPTION: aDDED "@oUTPUT_mODE" aND "@uNUSED_iNDEX_dAYS" iNPUT pARAMETERS
--	           : cODE rESTRUCTURING fOR bETTER qUERY pERFORMANCE
--	           : mINOR cHANGES tO cODE sTYLE
--	           : aDDED "CONNECTIONS""FIRST_DAY_OF_WEEK", "IS_CLUSTERED", aND "WINDOWS_VERSION" tO "iNSTANCE iNFORMATION" sECTION
--	dATE (mm/dd/yyyy): 12/22/2011
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


--	dESCRIPTION: aDDED "CREATE_DATE" aND "FILE_NAME" tO "dATABASE dETAILS" sECTION
--	           : aDDED "BACKUP_FINISH_DATE", "DATABASE_VERSION", "MACHINE_NAME", aND "SERVER_NAME" tO "lAST bACKUP sET dETAILS" sECTION
--	           : "lAST bACKUP sET dETAILS" sECTION nOW oNLY sHOWS iNFORMATION fOR dATABASES cURRENTLY oN tHE iNSTANCE
--	           : aDDED "SCHEMA_NAME" tO "uNUSED iNDEXES" sECTION
--	           : eXTENDED "convert" cHARACTER lENGTH tO dEAL wITH "mSG 234" eRROR
--	           : rEWROTE tIME cALCULATION lOGIC
--	dATE (mm/dd/yyyy): 01/18/2012
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


--	dESCRIPTION: aDDED aDDITIONAL iNPUT pARAMETERS
--	           : rEFORMATTED cODE
--	           : bUG fIXES
--	           : aDDED "iNSTANCE sETTINGS", "iNDEX fRAGMENTATION", "mISSING iNDEXES" sECTIONS
--	dATE (mm/dd/yyyy): 09/20/2013
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


--	dESCRIPTION: rENAMED sOME hEADINGS / vARIABLES / tEMP tABLES
--	           : bUG fIXES
--	           : eNHANCED html oUTPUT
--	           : "iNDEX" oUPUTS nOW iNCLUDE iNDEXED vIEWS
--	           : aDDED "INSTANCE_NAME", "PRODUCT_NAME", aND "SERVER_MEMORY_MB" tO "iNSTANCE iNFORMATION" sECTION
--	           : aDDED "AUTHENTICATION", "DATE_FORMAT", "FILL_FACTOR_PERCENTAGE", "IS_COMPRESSED_BACKUPS_ENABLED", "IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED""IS_SCAN_FOR_STARTUP_PROCS_ENABLED", "IS_SQL_MAIL_ENABLED", "LANGUAGE", aND "LOCALE_ID" tO "iNSTANCE sETTINGS" sECTION
--	           : aDDED "CACHED_MB" tO "dATABASE sUMMARY" sECTION
--	           : aDDED "DATABASE_OWNER", "DRIVE_LETTER", "FILE_NAME", "FILE_PATH", "FILE_READ_MB", "FILE_READS", "FILE_WRITES", "FILE_WRITTEN_MB", "IO_WAIT_TIME_READS", aND "IO_WAIT_TIME_WRITES" tO "dATABASE dETAILS" sECTION
--	           : aDDED "PHYSICAL_DEVICE_NAME" tO "lAST bACKUP sET dETAILS" sECTION
--	           : aDDED "CATEGORY", "CLASS", "DATE_CREATED", "DATE_MODIFIED", "JOB_OWNER", "TYPE", aND "VERSION" tO "sql sERVER aGENT jOBS (lAST 24 hOURS)" sECTION
--	           : aDDED "FILTER_DEFINITION", "INCLUDE_KEY", "OBJECT_TYPE", aND "ROW_COUNT" tO "iNDEX fRAGMENTATION" sECTION
--	           : aDDED "OBJECT_TYPE" aND "ROW_COUNT" tO "mISSING iNDEXES" sECTION
--	           : aDDED "FILTER_DEFINITION", "INCLUDE_KEY", "OBJECT_TYPE", aND "ROW_COUNT" tO "uNUSED iNDEXES" sECTION
--	dATE (mm/dd/yyyy): 12/11/2013
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


--	dESCRIPTION: mAJOR rEVAMP oF "dATABASE sUMMARY" aND "dATABASE dETAILS" sECTIONS
--	dATE (mm/dd/yyyy): 07/11/2014
--	dEVELOPER: sEAN sMITH (S.SMITH.SQL at GMAIL dot COM)
--	aDDITIONAL nOTES: n/a


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY: cREATE pROCEDURE
-----------------------------------------------------------------------------------------------------------------------------

alter procedure DBO.USP_sql_sERVER_sYSTEM_rEPORT

	 @oUTPUT_mODE as char (1) = null
	,@uNUSED_iNDEX_dAYS as int = 7
	,@rECIPIENTS as varchar (max) = null
	,@cOPY_rECIPIENTS as varchar (max) = null
	,@iNSTANCE_iNFORMATION as bit = 1
	,@iNSTANCE_sETTINGS as bit = 1
	,@dRIVES_sPACE as bit = 1
	,@dATABASE_sUMMARY as bit = 1
	,@dATABASE_dETAILS as bit = 1
	,@lAST_bACKUP as bit = 1
	,@aGENT_jOBS as bit = 1
	,@fRAGMENTATION as bit = 1
	,@mISSING_iNDEXES as bit = 1
	,@uNUSED_iNDEXES as bit = 1

as

set transaction isolation level read uncommitted
set nocount on
set ansi_warnings off
set arithabort off
set arithignore on
set textsize 2147483647


declare
	 @aVOID_tRUNCATION as nvarchar (max)
	,@bODY as nvarchar (max)
	,@dATABASE_id as int
	,@dATABASE_nAME_lOOP as nvarchar (500)
	,@dATE_24_hOURS_aGO as datetime
	,@dATE_nOW as datetime
	,@fILTER_dEFINITION_sTRING as nvarchar (50)
	,@sERVER_mEMORY_mb as bigint
	,@sql_sERVER_sTART_tIME as datetime
	,@sql_sTRING as nvarchar (max)
	,@sUBJECT as nvarchar (255)
	,@xml_sTRING as nvarchar (max)


declare @fIXED_dRIVES_fREE_sPACE as table

	(
		 DRIVE_LETTER varchar (5) primary key clustered
		,FREE_SPACE_MB bigint
	)


set @aVOID_tRUNCATION = n''
set @bODY = n''
set @dATE_24_hOURS_aGO = getdate () - 1
set @dATE_nOW = @dATE_24_hOURS_aGO + 1
set @sUBJECT = n'sql sERVER sYSTEM rEPORT: ' + @@servername
set @xml_sTRING = n''


if exists (select * from MASTER.SYS.ALL_COLUMNS ac where ac.[OBJECT_ID] = object_id (n'MASTER.SYS.DM_OS_SYS_INFO', n'v') and ac.NAME = n'SQLSERVER_START_TIME')
begin

	set @sql_sTRING =

		n'
			select
				@sql_sERVER_sTART_tIME = dosi.SQLSERVER_START_TIME
			from
				MASTER.SYS.DM_OS_SYS_INFO dosi
		 '


	execute SYS.SP_EXECUTESQL

		 @sql_sTRING
		,n'
			@sql_sERVER_sTART_tIME as datetime output
		  '
		,@sql_sERVER_sTART_tIME output

end
else begin

	set @sql_sERVER_sTART_tIME =

		(
			select
				db.CREATE_DATE
			from
				MASTER.SYS.DATABASES db
			where
				db.NAME = n'TEMPDB'
		)

end


if datediff (second, @sql_sERVER_sTART_tIME, getdate ()) < (@uNUSED_iNDEX_dAYS * 86400)
begin

	set @uNUSED_iNDEXES = 0

end


if exists (select * from MASTER.SYS.ALL_COLUMNS ac where ac.[OBJECT_ID] = object_id (n'MASTER.SYS.DM_OS_SYS_INFO', n'v') and ac.NAME = n'PHYSICAL_MEMORY_KB')
begin

	set @sql_sTRING =

		n'
			select
				@sERVER_mEMORY_mb = dosi.PHYSICAL_MEMORY_KB / 1024
			from
				MASTER.SYS.DM_OS_SYS_INFO dosi
		 '

end
else begin

	set @sql_sTRING =

		n'
			select
				@sERVER_mEMORY_mb = dosi.PHYSICAL_MEMORY_IN_BYTES / 1048576
			from
				MASTER.SYS.DM_OS_SYS_INFO dosi
		 '

end


execute SYS.SP_EXECUTESQL

	 @sql_sTRING
	,n'
		@sERVER_mEMORY_mb as bigint output
	  '
	,@sERVER_mEMORY_mb output


if exists (select * from MASTER.SYS.ALL_COLUMNS ac where ac.[OBJECT_ID] = object_id (n'MASTER.SYS.INDEXES', n'v') and ac.NAME = n'FILTER_DEFINITION')
begin

	set @fILTER_dEFINITION_sTRING = n'isnull (i.FILTER_DEFINITION, n'''')'

end
else begin

	set @fILTER_dEFINITION_sTRING = n''''''

end


-----------------------------------------------------------------------------------------------------------------------------
--	eRROR tRAPPING: cHECK iF tEMP tABLE(S) aLREADY eXIST(S) aND dROP iF aPPLICABLE
-----------------------------------------------------------------------------------------------------------------------------

if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASES

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_ROW_COUNTS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_ROW_COUNTS

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INSTANCE_INFORMATION', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INSTANCE_INFORMATION

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INSTANCE_SETTINGS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INSTANCE_SETTINGS

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASE_SUMMARY', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASE_SUMMARY

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASE_DETAILS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASE_DETAILS

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_LAST_BACKUP_SET', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_LAST_BACKUP_SET

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_AGENT_JOBS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_AGENT_JOBS

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INDEX_FRAGMENTATION', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INDEX_FRAGMENTATION

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_MISSING_INDEXES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_MISSING_INDEXES

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_UNUSED_INDEXES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_UNUSED_INDEXES

end


-----------------------------------------------------------------------------------------------------------------------------
--	tEMP tABLE: dATABASE lIST
-----------------------------------------------------------------------------------------------------------------------------

create table DBO.#TEMP_SSSR_DATABASES

	(
		 DATABASE_NAME nvarchar (128) primary key clustered
		,DATABASE_OWNER nvarchar (128)
		,RECOVERY_MODEL nvarchar (60)
		,[COMPATIBILITY_LEVEL] varchar (3)
		,CREATE_DATE datetime
		,COLLATION_NAME nvarchar (128)
	)


insert into DBO.#TEMP_SSSR_DATABASES

	(
		 DATABASE_NAME
		,DATABASE_OWNER
		,RECOVERY_MODEL
		,[COMPATIBILITY_LEVEL]
		,CREATE_DATE
		,COLLATION_NAME
	)

select
	 db.NAME as DATABASE_NAME
	,suser_sname (db.OWNER_SID) as DATABASE_OWNER
	,db.RECOVERY_MODEL_DESC as RECOVERY_MODEL
	,db.[COMPATIBILITY_LEVEL]
	,db.CREATE_DATE
	,db.COLLATION_NAME
from
	MASTER.SYS.DATABASES db
where
	db.[STATE] = 0
	and db.IS_READ_ONLY = 0
	and db.IS_IN_STANDBY = 0
	and db.SOURCE_DATABASE_ID is null


-----------------------------------------------------------------------------------------------------------------------------
--	tEMP tABLE: rOW cOUNTS pER tABLE pER dATABASE
-----------------------------------------------------------------------------------------------------------------------------

if (@fRAGMENTATION = 1 or @mISSING_iNDEXES = 1 or @uNUSED_iNDEXES = 1)
begin

	create table DBO.#TEMP_SSSR_ROW_COUNTS

		(
			 DATABASE_ID int not null
			,[OBJECT_ID] int not null
			,[ROWS] bigint
		)


	set @dATABASE_nAME_lOOP =

		(
			select top (1)
				x.DATABASE_NAME
			from
				DBO.#TEMP_SSSR_DATABASES x
			order by
				x.DATABASE_NAME
		)


	while @dATABASE_nAME_lOOP is not null
	begin

		set @sql_sTRING = @aVOID_tRUNCATION +

			n'
				use [' + @dATABASE_nAME_lOOP + n']


				insert into DBO.#TEMP_SSSR_ROW_COUNTS

					(
						 DATABASE_ID
						,[OBJECT_ID]
						,[ROWS]
					)

				select
					 db_id () as DATABASE_ID
					,p.[OBJECT_ID]
					,sum (p.[ROWS]) as TOTAL_ROWS
				from
					SYS.PARTITIONS p
				where
					p.INDEX_ID in (0, 1)
				group by
					p.[OBJECT_ID]
			 '


		execute (@sql_sTRING)


		set @dATABASE_nAME_lOOP =

			(
				select top (1)
					x.DATABASE_NAME
				from
					DBO.#TEMP_SSSR_DATABASES x
				where
					x.DATABASE_NAME > @dATABASE_nAME_lOOP
				order by
					x.DATABASE_NAME
			)

	end


	alter table DBO.#TEMP_SSSR_ROW_COUNTS add primary key clustered (DATABASE_ID, [OBJECT_ID])

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY i: iNSTANCE iNFORMATION
-----------------------------------------------------------------------------------------------------------------------------

if @iNSTANCE_iNFORMATION = 0
begin

	goto sKIP_iNSTANCE_iNFORMATION

end


select
	 serverproperty (n'cOMPUTERnAMEpHYSICALnETbios') as NETBIOS_NAME
	,@@servername as SERVER_NAME
	,isnull (serverproperty (n'iNSTANCEnAME'), n'dEFAULT iNSTANCE') as INSTANCE_NAME
	,replace (replace (CJpnl.PRODUCT_NAME, n' (' + CJpnl.[LEVEL] + n')', n''), n'mICROSOFT ', n'') as PRODUCT_NAME
	,replace (convert (nvarchar (128), serverproperty (n'eDITION')), n' eDITION', n'') as EDITION
	,serverproperty (n'pRODUCTvERSION') as [VERSION]
	,CJpnl.[LEVEL]
	,(case serverproperty (n'iScLUSTERED')
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_CLUSTERED
	,convert (nvarchar (19), @sql_sERVER_sTART_tIME, 120) as ONLINE_SINCE
	,(case
		when OAdsr.TOTAL_DAYS = '0' then '_'
		else OAdsr.TOTAL_DAYS
		end) + ' dAY(S) ' + (case
								when OAdsr.SECONDS_REMAINING = 0 then '__:__:__'
								when OAdsr.SECONDS_REMAINING < 60 then '__:__:' + right (OAdsr.TOTAL_SECONDS, 2)
								when OAdsr.SECONDS_REMAINING < 3600 then '__:' + right (OAdsr.TOTAL_SECONDS, 5)
								else OAdsr.TOTAL_SECONDS
								end) as UPTIME
	,serverproperty (n'pROCESSid') as PROCESS_ID
	,reverse (substring (reverse (convert (varchar (23), convert (money, @@connections), 1)), 4, 23)) as CONNECTIONS
	,reverse (substring (reverse (convert (varchar (23), convert (money, @@total_read), 1)), 4, 23)) as READS
	,reverse (substring (reverse (convert (varchar (23), convert (money, @@total_write), 1)), 4, 23)) as WRITES
	,reverse (substring (reverse (convert (varchar (23), convert (money, dosi.CPU_COUNT), 1)), 4, 23)) as LOGICAL_CPU_COUNT
	,reverse (substring (reverse (convert (varchar (23), convert (money, dosi.CPU_COUNT / dosi.HYPERTHREAD_RATIO), 1)), 4, 23)) as PHYSICAL_CPU_COUNT
	,reverse (substring (reverse (convert (varchar (23), convert (money, @sERVER_mEMORY_mb), 1)), 4, 23)) as SERVER_MEMORY_MB
	,replace (replace (replace (replace (replace (right (@@version, charindex (reverse (n' ON wINDOWS '), reverse (@@version)) - 1), n'sERVICE pACK ', n'sp'), n'(', n''), n')', n''), n'<', n'('), n'>', n')') as WINDOWS_VERSION
into
	DBO.#TEMP_SSSR_INSTANCE_INFORMATION
from
	MASTER.SYS.DM_OS_SYS_INFO dosi
	cross join

		(
			select
				 left (@@version, charindex (n' - ', @@version) - 1) as PRODUCT_NAME
				,convert (nvarchar (128), serverproperty (n'pRODUCTlEVEL')) as [LEVEL]
		) CJpnl

	cross join

		(
			select
				datediff (second, @sql_sERVER_sTART_tIME, getdate ()) as UPTIME_SECONDS
		) SQuts

	outer apply

		(
			select
				 convert (varchar (5), SQuts.UPTIME_SECONDS / 86400) as TOTAL_DAYS
				,convert (char (8), dateadd (second, SQuts.UPTIME_SECONDS % 86400, 0), 108) as TOTAL_SECONDS
				,SQuts.UPTIME_SECONDS % 86400 as SECONDS_REMAINING
		) OAdsr


if @@rowcount = 0
begin

	goto sKIP_iNSTANCE_iNFORMATION

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.NETBIOS_NAME as 'TD'
					,'',x.SERVER_NAME as 'TD'
					,'',x.INSTANCE_NAME as 'TD'
					,'',x.PRODUCT_NAME as 'TD'
					,'',x.EDITION as 'TD'
					,'',x.[VERSION] as 'TD'
					,'',x.[LEVEL] as 'TD'
					,'',x.IS_CLUSTERED as 'TD'
					,'',x.ONLINE_SINCE as 'TD'
					,'',x.UPTIME as 'TD'
					,'',x.PROCESS_ID as 'TD'
					,'','RIGHT_ALIGN' + x.CONNECTIONS as 'TD'
					,'','RIGHT_ALIGN' + x.READS as 'TD'
					,'','RIGHT_ALIGN' + x.WRITES as 'TD'
					,'','RIGHT_ALIGN' + x.LOGICAL_CPU_COUNT as 'TD'
					,'','RIGHT_ALIGN' + x.PHYSICAL_CPU_COUNT as 'TD'
					,'','RIGHT_ALIGN' + x.SERVER_MEMORY_MB as 'TD'
					,'',x.WINDOWS_VERSION as 'TD'
				from
					DBO.#TEMP_SSSR_INSTANCE_INFORMATION x
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>iNSTANCE iNFORMATION</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>nETbios nAME</TH>
						<TH NOWRAP>sERVER nAME</TH>
						<TH NOWRAP>iNSTANCE nAME</TH>
						<TH NOWRAP>pRODUCT nAME</TH>
						<TH NOWRAP>eDITION</TH>
						<TH NOWRAP>vERSION</TH>
						<TH NOWRAP>lEVEL</TH>
						<TH NOWRAP>cLUSTERED</TH>
						<TH NOWRAP>oNLINE sINCE</TH>
						<TH NOWRAP>uPTIME</TH>
						<TH NOWRAP>pROCESS id</TH>
						<TH NOWRAP>cONNECTIONS</TH>
						<TH NOWRAP>rEADS</TH>
						<TH NOWRAP>wRITES</TH>
						<TH NOWRAP>lOGICAL cpu cOUNT</TH>
						<TH NOWRAP>pHYSICAL cpu cOUNT</TH>
						<TH NOWRAP>sERVER mEMORY (mb)</TH>
						<TH NOWRAP>wINDOWS vERSION</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.NETBIOS_NAME
		,x.SERVER_NAME
		,x.INSTANCE_NAME
		,x.PRODUCT_NAME
		,x.EDITION
		,x.[VERSION]
		,x.[LEVEL]
		,x.IS_CLUSTERED as [CLUSTERED]
		,x.ONLINE_SINCE
		,x.UPTIME
		,x.PROCESS_ID
		,x.CONNECTIONS
		,x.READS
		,x.WRITES
		,x.LOGICAL_CPU_COUNT
		,x.PHYSICAL_CPU_COUNT
		,x.SERVER_MEMORY_MB
		,x.WINDOWS_VERSION
	from
		DBO.#TEMP_SSSR_INSTANCE_INFORMATION x

end


sKIP_iNSTANCE_iNFORMATION:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INSTANCE_INFORMATION', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INSTANCE_INFORMATION

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY ii: iNSTANCE sETTINGS
-----------------------------------------------------------------------------------------------------------------------------

if @iNSTANCE_sETTINGS = 0
begin

	goto sKIP_iNSTANCE_sETTINGS

end


select
	 (case serverproperty (n'iSiNTEGRATEDsECURITYoNLY')
		when 0 then 'mIXED mODE'
		when 1 then 'wINDOWS'
		else 'n/a'
		end) as [AUTHENTICATION]
	,sl.ALIAS + n': ' + sl.NAME as [LANGUAGE]
	,sl.LCID as LOCALE_ID
	,serverproperty (n'cOLLATION') as COLLATION
	,sl.[DATEFORMAT] as DATE_FORMAT
	,(case sl.[DATEFIRST]
		when 1 then 'mONDAY'
		when 2 then 'tUESDAY'
		when 3 then 'wEDNESDAY'
		when 4 then 'tHURSDAY'
		when 5 then 'fRIDAY'
		when 6 then 'sATURDAY'
		when 7 then 'sUNDAY'
		else 'n/a'
		end) as FIRST_DAY_OF_WEEK
	,(case serverproperty (n'iSfULLtEXTiNSTALLED')
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_FULL_TEXT_INSTALLED
	,(case CJcfg.IS_SHOW_ADVANCED_OPTIONS_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_SHOW_ADVANCED_OPTIONS_ENABLED
	,(case CJcfg.IS_CLR_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_CLR_ENABLED
	,(case CJcfg.IS_COMPRESSED_BACKUPS_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_COMPRESSED_BACKUPS_ENABLED
	,(case CJcfg.IS_SCAN_FOR_STARTUP_PROCS_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_SCAN_FOR_STARTUP_PROCS_ENABLED
	,(case CJcfg.IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED
	,(case CJcfg.IS_XP_CMDSHELL_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_XP_CMDSHELL_ENABLED
	,(case CJcfg.IS_SQL_MAIL_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_SQL_MAIL_ENABLED
	,(case CJcfg.IS_DATABASE_MAIL_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_DATABASE_MAIL_ENABLED
	,(case CJcfg.IS_DEFAULT_TRACE_ENABLED
		when 0 then 'nO'
		when 1 then 'yES'
		else 'n/a'
		end) as IS_DEFAULT_TRACE_ENABLED
	,convert (varchar (3), (case
								when CJcfg.FILL_FACTOR_PERCENTAGE = 0 then 100
								else CJcfg.FILL_FACTOR_PERCENTAGE
								end)) as FILL_FACTOR_PERCENTAGE
	,reverse (substring (reverse (convert (varchar (23), convert (money, CJcfg.MIN_SERVER_MEMORY_MB), 1)), 4, 23)) as MIN_SERVER_MEMORY_MB
	,reverse (substring (reverse (convert (varchar (23), convert (money, CJcfg.MAX_SERVER_MEMORY_MB), 1)), 4, 23)) as MAX_SERVER_MEMORY_MB
into
	#TEMP_SSSR_INSTANCE_SETTINGS
from
	MASTER.SYS.SYSLANGUAGES sl
	cross join

		(
			select
				 max (case
						when cfg.CONFIGURATION_ID = 518 then cfg.VALUE
						end) as IS_SHOW_ADVANCED_OPTIONS_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 1562 then cfg.VALUE
						end) as IS_CLR_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 1579 then cfg.VALUE
						end) as IS_COMPRESSED_BACKUPS_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 1547 then cfg.VALUE
						end) as IS_SCAN_FOR_STARTUP_PROCS_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 1581 then cfg.VALUE
						end) as IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 16390 then cfg.VALUE
						end) as IS_XP_CMDSHELL_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 16385 then cfg.VALUE
						end) as IS_SQL_MAIL_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 16386 then cfg.VALUE
						end) as IS_DATABASE_MAIL_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 1568 then cfg.VALUE
						end) as IS_DEFAULT_TRACE_ENABLED
				,max (case
						when cfg.CONFIGURATION_ID = 109 then cfg.VALUE
						end) as FILL_FACTOR_PERCENTAGE
				,max (case
						when cfg.CONFIGURATION_ID = 1543 then cfg.VALUE
						end) as MIN_SERVER_MEMORY_MB
				,max (case
						when cfg.CONFIGURATION_ID = 1544 then cfg.VALUE
						end) as MAX_SERVER_MEMORY_MB
			from
				MASTER.SYS.CONFIGURATIONS cfg
			where
				cfg.CONFIGURATION_ID in (109, 518, 1543, 1544, 1547, 1562, 1568, 1579, 1581, 16385, 16386, 16390)
		) CJcfg

where
	sl.LCID = serverproperty (n'lcid')


if @@rowcount = 0
begin

	goto sKIP_iNSTANCE_sETTINGS

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.[AUTHENTICATION] as 'TD'
					,'',x.[LANGUAGE] as 'TD'
					,'',x.LOCALE_ID as 'TD'
					,'',x.COLLATION as 'TD'
					,'',x.DATE_FORMAT as 'TD'
					,'',x.FIRST_DAY_OF_WEEK as 'TD'
					,'',x.IS_FULL_TEXT_INSTALLED as 'TD'
					,'',x.IS_SHOW_ADVANCED_OPTIONS_ENABLED as 'TD'
					,'',x.IS_CLR_ENABLED as 'TD'
					,'',x.IS_COMPRESSED_BACKUPS_ENABLED as 'TD'
					,'',x.IS_SCAN_FOR_STARTUP_PROCS_ENABLED as 'TD'
					,'',x.IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED as 'TD'
					,'',x.IS_XP_CMDSHELL_ENABLED as 'TD'
					,'',x.IS_SQL_MAIL_ENABLED as 'TD'
					,'',x.IS_DATABASE_MAIL_ENABLED as 'TD'
					,'',x.IS_DEFAULT_TRACE_ENABLED as 'TD'
					,'','RIGHT_ALIGN' + x.FILL_FACTOR_PERCENTAGE as 'TD'
					,'','RIGHT_ALIGN' + x.MIN_SERVER_MEMORY_MB as 'TD'
					,'','RIGHT_ALIGN' + x.MAX_SERVER_MEMORY_MB as 'TD'
				from
					DBO.#TEMP_SSSR_INSTANCE_SETTINGS x
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>iNSTANCE sETTINGS</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>aUTHENTICATION</TH>
						<TH NOWRAP>lANGUAGE</TH>
						<TH NOWRAP>lOCALE id</TH>
						<TH NOWRAP>cOLLATION</TH>
						<TH NOWRAP>dATE fORMAT</TH>
						<TH NOWRAP>fIRST dAY oF wEEK</TH>
						<TH NOWRAP>fULL-tEXT iNSTALLED</TH>
						<TH NOWRAP>aDVANCED oPTIONS eNABLED</TH>
						<TH NOWRAP>clr eNABLED</TH>
						<TH NOWRAP>cOMPRESS bACKUPS</TH>
						<TH NOWRAP>sCAN fOR sTARTUP pROCS</TH>
						<TH NOWRAP>oPTIMIZE fOR aD hOCS</TH>
						<TH NOWRAP>cOMMAND sHELL eNABLED</TH>
						<TH NOWRAP>sql mAIL eNABLED</TH>
						<TH NOWRAP>dATABASE mAIL eNABLED</TH>
						<TH NOWRAP>dEFAULT tRACE eNABLED</TH>
						<TH NOWRAP>fILL fACTOR %</TH>
						<TH NOWRAP>mINIMUM mEMORY (mb)</TH>
						<TH NOWRAP>mAXIMUM mEMORY (mb)</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.[AUTHENTICATION]
		,x.[LANGUAGE]
		,x.LOCALE_ID
		,x.COLLATION
		,x.DATE_FORMAT
		,x.FIRST_DAY_OF_WEEK
		,x.IS_FULL_TEXT_INSTALLED as FULL_TEXT_INSTALLED
		,x.IS_SHOW_ADVANCED_OPTIONS_ENABLED as ADVANCED_OPTIONS_ENABLED
		,x.IS_CLR_ENABLED as CLR_ENABLED
		,x.IS_COMPRESSED_BACKUPS_ENABLED as COMPRESS_BACKUPS
		,x.IS_SCAN_FOR_STARTUP_PROCS_ENABLED as SCAN_FOR_STARTUP_PROCS
		,x.IS_OPTIMIZE_FOR_AD_HOC_WORKLOADS_ENABLED as OPTIMIZE_FOR_AD_HOCS
		,x.IS_XP_CMDSHELL_ENABLED as COMMAND_SHELL_ENABLED
		,x.IS_SQL_MAIL_ENABLED as SQL_MAIL_ENABLED
		,x.IS_DATABASE_MAIL_ENABLED as DATABASE_MAIL_ENABLED
		,x.IS_DEFAULT_TRACE_ENABLED as DEFAULT_TRACE_ENABLED
		,x.FILL_FACTOR_PERCENTAGE as FILL_FACTOR_PCT
		,x.MIN_SERVER_MEMORY_MB as MINIMUM_MEMORY_MB
		,x.MAX_SERVER_MEMORY_MB as MAXIMUM_MEMORY_MB
	from
		DBO.#TEMP_SSSR_INSTANCE_SETTINGS x

end


sKIP_iNSTANCE_sETTINGS:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INSTANCE_SETTINGS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INSTANCE_SETTINGS

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY iii: fIXED dRIVES fREE sPACE
-----------------------------------------------------------------------------------------------------------------------------

if @dRIVES_sPACE = 0
begin

	goto sKIP_fIXED_dRIVES_fREE_sPACE

end


insert into @fIXED_dRIVES_fREE_sPACE

	(
		 DRIVE_LETTER
		,FREE_SPACE_MB
	)

execute MASTER.DBO.XP_FIXEDDRIVES


if @@rowcount = 0
begin

	goto sKIP_fIXED_dRIVES_fREE_sPACE

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.DRIVE_LETTER + ':' as 'TD'
					,'','RIGHT_ALIGN' + reverse (substring (reverse (convert (varchar (23), convert (money, x.FREE_SPACE_MB), 1)), 4, 23)) as 'TD'
				from
					@fIXED_dRIVES_fREE_sPACE x
				order by
					x.DRIVE_LETTER
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>fIXED dRIVES fREE sPACE</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>dRIVE lETTER</TH>
						<TH NOWRAP>fREE sPACE (mb)</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.DRIVE_LETTER + ':' as DRIVE_LETTER
		,reverse (substring (reverse (convert (varchar (23), convert (money, x.FREE_SPACE_MB), 1)), 4, 23)) as FREE_SPACE_MB
	from
		@fIXED_dRIVES_fREE_sPACE x
	order by
		x.DRIVE_LETTER

end


sKIP_fIXED_dRIVES_fREE_sPACE:


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY iv: dATABASE sUMMARY
-----------------------------------------------------------------------------------------------------------------------------

if @dATABASE_sUMMARY = 0
begin

	goto sKIP_dATABASE_sUMMARY

end


create table DBO.#TEMP_SSSR_DATABASE_SUMMARY

	(
		 DATABASE_NAME nvarchar (128)
		,DATABASE_OWNER nvarchar (128)
		,RECOVERY_MODEL nvarchar (60)
		,[COMPATIBILITY_LEVEL] varchar (3)
		,CREATE_DATE nvarchar (19)
		,COLLATION_NAME nvarchar (128)
		,IS_CASE_SENSITIVE varchar (3)
		,TOTAL_SIZE_MB varchar (23)
		,UNALLOCATED_MB varchar (23)
		,RESERVED_MB varchar (23)
		,DATA_MB varchar (23)
		,INDEX_MB varchar (23)
		,UNUSED_MB varchar (23)
		,CACHED_MB varchar (23)
	)


set @dATABASE_nAME_lOOP =

	(
		select top (1)
			x.DATABASE_NAME
		from
			DBO.#TEMP_SSSR_DATABASES x
		order by
			x.DATABASE_NAME
	)


while @dATABASE_nAME_lOOP is not null
begin

	set @sql_sTRING = @aVOID_tRUNCATION +

		n'
			use [' + @dATABASE_nAME_lOOP + n']


			insert into DBO.#TEMP_SSSR_DATABASE_SUMMARY

				(
					 DATABASE_NAME
					,DATABASE_OWNER
					,RECOVERY_MODEL
					,[COMPATIBILITY_LEVEL]
					,CREATE_DATE
					,COLLATION_NAME
					,IS_CASE_SENSITIVE
					,TOTAL_SIZE_MB
					,UNALLOCATED_MB
					,RESERVED_MB
					,DATA_MB
					,INDEX_MB
					,UNUSED_MB
				)

			select
				 x.DATABASE_NAME
				,isnull (x.DATABASE_OWNER, n''???'') as DATABASE_OWNER
				,x.RECOVERY_MODEL
				,isnull (convert (varchar (3), x.[COMPATIBILITY_LEVEL]), ''n/a'') as [COMPATIBILITY_LEVEL]
				,convert (nvarchar (19), x.CREATE_DATE, 120) as CREATE_DATE
				,x.COLLATION_NAME
				,(case
					when ''A'' = ''a'' then ''nO''
					else ''yES''
					end) as IS_CASE_SENSITIVE
				,reverse (substring (reverse (convert (varchar (23), convert (money, round ((SQdbf.TOTAL_SIZE * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as TOTAL_SIZE_MB
				,(case
					when SQdbf.DATABASE_SIZE >= CJpgs.TOTAL_PAGES then reverse (substring (reverse (convert (varchar (23), convert (money, round (((SQdbf.DATABASE_SIZE - CJpgs.TOTAL_PAGES) * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23))
					else ''0''
					end) as UNALLOCATED_MB
				,reverse (substring (reverse (convert (varchar (23), convert (money, round ((CJpgs.TOTAL_PAGES * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as RESERVED_MB
				,reverse (substring (reverse (convert (varchar (23), convert (money, round ((CJpgs.PAGES * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as DATA_MB
				,reverse (substring (reverse (convert (varchar (23), convert (money, round (((CJpgs.USED_PAGES - CJpgs.PAGES) * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as INDEX_MB
				,reverse (substring (reverse (convert (varchar (23), convert (money, round (((CJpgs.TOTAL_PAGES - CJpgs.USED_PAGES) * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as UNUSED_MB
			from
				DBO.#TEMP_SSSR_DATABASES x
				cross join

					(
						select
							 sum (case
									when dbf.[TYPE] = 0 then dbf.SIZE
									else 0
									end) as DATABASE_SIZE
							,sum (dbf.SIZE) as TOTAL_SIZE
						from
							SYS.DATABASE_FILES as dbf
						where
							dbf.[TYPE] in (0, 1)
					) SQdbf

				cross join

					(
						select
							 sum (au.TOTAL_PAGES) as TOTAL_PAGES
							,sum (au.USED_PAGES) as USED_PAGES
							,sum (case
									when it.INTERNAL_TYPE in (202, 204) then 0
									when au.[TYPE] <> 1 then au.USED_PAGES
									when p.INDEX_ID <= 1 then au.DATA_PAGES
									else 0
									end) as PAGES
						from
							SYS.PARTITIONS p
							inner join SYS.ALLOCATION_UNITS au on au.CONTAINER_ID = p.PARTITION_ID
							left join SYS.INTERNAL_TABLES it on it.[OBJECT_ID] = p.[OBJECT_ID]
					) CJpgs

			where
				x.DATABASE_NAME = ''' + @dATABASE_nAME_lOOP + n'''
		 '


	execute (@sql_sTRING)


	set @dATABASE_nAME_lOOP =

		(
			select top (1)
				x.DATABASE_NAME
			from
				DBO.#TEMP_SSSR_DATABASES x
			where
				x.DATABASE_NAME > @dATABASE_nAME_lOOP
			order by
				x.DATABASE_NAME
		)

end


if not exists (select * from DBO.#TEMP_SSSR_DATABASE_SUMMARY x)
begin

	goto sKIP_dATABASE_sUMMARY

end


update
	x
set
	x.CACHED_MB = SQcm.CACHED_MB
from
	DBO.#TEMP_SSSR_DATABASE_SUMMARY x
	left join

		(
			select
				 db_name (dobd.DATABASE_ID) as DATABASE_NAME
				,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, (count (*) * 8) / 1024.0), 1)), 4, 23)), '0.00') as CACHED_MB
			from
				MASTER.SYS.DM_OS_BUFFER_DESCRIPTORS dobd
			group by
				db_name (dobd.DATABASE_ID)
		) SQcm on SQcm.DATABASE_NAME = x.DATABASE_NAME


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.DATABASE_NAME as 'TD'
					,'',x.DATABASE_OWNER as 'TD'
					,'',x.RECOVERY_MODEL as 'TD'
					,'',x.[COMPATIBILITY_LEVEL] as 'TD'
					,'',x.CREATE_DATE as 'TD'
					,'',x.COLLATION_NAME as 'TD'
					,'',x.IS_CASE_SENSITIVE as 'TD'
					,'','RIGHT_ALIGN' + x.TOTAL_SIZE_MB as 'TD'
					,'','RIGHT_ALIGN' + x.UNALLOCATED_MB as 'TD'
					,'','RIGHT_ALIGN' + x.RESERVED_MB as 'TD'
					,'','RIGHT_ALIGN' + x.DATA_MB as 'TD'
					,'','RIGHT_ALIGN' + x.INDEX_MB as 'TD'
					,'','RIGHT_ALIGN' + x.UNUSED_MB as 'TD'
					,'','RIGHT_ALIGN' + x.CACHED_MB as 'TD'
				from
					DBO.#TEMP_SSSR_DATABASE_SUMMARY x
				order by
					x.DATABASE_NAME
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>dATABASE sUMMARY</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>dATABASE oWNER</TH>
						<TH NOWRAP>rECOVERY mODEL</TH>
						<TH NOWRAP>cOMPATIBILITY</TH>
						<TH NOWRAP>cREATE dATE</TH>
						<TH NOWRAP>cOLLATION</TH>
						<TH NOWRAP>cASE sENSITIVE</TH>
						<TH NOWRAP>tOTAL sIZE (mb)</TH>
						<TH NOWRAP>uNALLOCATED (mb)</TH>
						<TH NOWRAP>rESERVED (mb)</TH>
						<TH NOWRAP>dATA (mb)</TH>
						<TH NOWRAP>iNDEX (mb)</TH>
						<TH NOWRAP>uNUSED (mb)</TH>
						<TH NOWRAP>cACHED (mb)</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.DATABASE_NAME
		,x.DATABASE_OWNER
		,x.RECOVERY_MODEL
		,x.[COMPATIBILITY_LEVEL]
		,x.CREATE_DATE
		,x.COLLATION_NAME as COLLATION
		,x.IS_CASE_SENSITIVE as CASE_SENSITIVE
		,x.TOTAL_SIZE_MB
		,x.UNALLOCATED_MB
		,x.RESERVED_MB
		,x.DATA_MB
		,x.INDEX_MB
		,x.UNUSED_MB
		,x.CACHED_MB
	from
		DBO.#TEMP_SSSR_DATABASE_SUMMARY x
	order by
		x.DATABASE_NAME

end


sKIP_dATABASE_sUMMARY:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASE_SUMMARY', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASE_SUMMARY

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY v: dATABASE dETAILS
-----------------------------------------------------------------------------------------------------------------------------

if @dATABASE_dETAILS = 0
begin

	goto sKIP_dATABASE_dETAILS

end


select
	 db_name (mf.DATABASE_ID) as DATABASE_NAME
	,convert (nvarchar (10), left (upper (mf.TYPE_DESC), 1) + lower (substring (mf.TYPE_DESC, 2, 250))) as FILE_TYPE
	,mf.NAME as LOGICAL_NAME
	,upper (left (mf.PHYSICAL_NAME, 2)) as DRIVE_LETTER
	,(case
		when len (mf.PHYSICAL_NAME) - len (replace (mf.PHYSICAL_NAME, n'\', n'')) < 2 then n'<dRIVE rOOT>'
		else substring (mf.PHYSICAL_NAME, 4, len (mf.PHYSICAL_NAME) - charindex (n'\', reverse (mf.PHYSICAL_NAME)) - 3)
		end) as FILE_PATH
	,right (mf.PHYSICAL_NAME, charindex (n'\', reverse (mf.PHYSICAL_NAME)) - 1) as [FILE_NAME]
	,reverse (substring (reverse (convert (varchar (23), convert (money, round ((mf.SIZE * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) as FILE_SIZE_MB
	,right ((case
				when mf.GROWTH = 0 then 'fIXED sIZE'
				when mf.MAX_SIZE = -1 then 'uNRESTRICTED'
				when mf.MAX_SIZE = 0 then 'nONE'
				when mf.MAX_SIZE = 268435456 then '2 tb'
				else reverse (substring (reverse (convert (varchar (23), convert (money, round ((mf.MAX_SIZE * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) + ' mb'
				end), 15) as MAX_SIZE
	,right ((case
				when mf.GROWTH = 0 then 'n/a'
				when mf.IS_PERCENT_GROWTH = 1 then reverse (substring (reverse (convert (varchar (23), convert (money, mf.GROWTH), 1)), 4, 23)) + ' %'
				else reverse (substring (reverse (convert (varchar (23), convert (money, round ((mf.GROWTH * convert (bigint, 8192)) / 1048576.0, 0)), 1)), 4, 23)) + ' mb'
				end), 15) as GROWTH_INCREMENT
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, divfs.NUM_OF_READS), 1)), 4, 23)), '0') as FILE_READS
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, divfs.NUM_OF_WRITES), 1)), 4, 23)), '0') as FILE_WRITES
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, round (divfs.NUM_OF_BYTES_READ / 1048576.0, 0)), 1)), 4, 23)), '0.00') as FILE_READ_MB
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, round (divfs.NUM_OF_BYTES_WRITTEN / 1048576.0, 0)), 1)), 4, 23)), '0.00') as FILE_WRITTEN_MB
	,isnull ((case
				when OAdsr.TOTAL_DAYS_READS = '0' then replicate ('_', CJdlm.DAY_LENGTH_MAX_READS)
				else replicate ('0', CJdlm.DAY_LENGTH_MAX_READS - len (OAdsr.TOTAL_DAYS_READS)) + OAdsr.TOTAL_DAYS_READS
				end) + ' dAY(S) ' + (case
										when OAdsr.SECONDS_REMAINING_READS = 0 then '__:__:__'
										when OAdsr.SECONDS_REMAINING_READS < 60 then '__:__:' + right (OAdsr.TOTAL_SECONDS_READS, 2)
										when OAdsr.SECONDS_REMAINING_READS < 3600 then '__:' + right (OAdsr.TOTAL_SECONDS_READS, 5)
										else OAdsr.TOTAL_SECONDS_READS
										end), replicate ('_', CJdlm.DAY_LENGTH_MAX_READS) + ' dAY(S) ' + '__:__:__') as IO_WAIT_TIME_READS
	,isnull ((case
				when OAdsr.TOTAL_DAYS_WRITES = '0' then replicate ('_', CJdlm.DAY_LENGTH_MAX_WRITES)
				else replicate ('0', CJdlm.DAY_LENGTH_MAX_WRITES - len (OAdsr.TOTAL_DAYS_WRITES)) + OAdsr.TOTAL_DAYS_WRITES
				end) + ' dAY(S) ' + (case
										when OAdsr.SECONDS_REMAINING_WRITES = 0 then '__:__:__'
										when OAdsr.SECONDS_REMAINING_WRITES < 60 then '__:__:' + right (OAdsr.TOTAL_SECONDS_WRITES, 2)
										when OAdsr.SECONDS_REMAINING_WRITES < 3600 then '__:' + right (OAdsr.TOTAL_SECONDS_WRITES, 5)
										else OAdsr.TOTAL_SECONDS_WRITES
										end), replicate ('_', CJdlm.DAY_LENGTH_MAX_WRITES) + ' dAY(S) ' + '__:__:__') as IO_WAIT_TIME_WRITES
	,row_number () over
						(
							partition by
								mf.DATABASE_ID
							order by
								 mf.[TYPE]
								,(case
									when mf.[FILE_ID] = 1 then 10
									else 99
									end)
								,mf.NAME
						) as DATABASE_FILTER_ID
into
	DBO.#TEMP_SSSR_DATABASE_DETAILS
from
	MASTER.SYS.MASTER_FILES mf
	left join MASTER.SYS.DM_IO_VIRTUAL_FILE_STATS (null, null) divfs on divfs.DATABASE_ID = mf.DATABASE_ID
		and divfs.[FILE_ID] = mf.[FILE_ID]
	cross join

		(
			select
				 max (len ((xdivfs.IO_STALL_READ_MS / 1000) / 86400)) as DAY_LENGTH_MAX_READS
				,max (len ((xdivfs.IO_STALL_WRITE_MS / 1000) / 86400)) as DAY_LENGTH_MAX_WRITES
			from
				MASTER.SYS.DM_IO_VIRTUAL_FILE_STATS (null, null) xdivfs
		) CJdlm

	outer apply

		(
			select
				 convert (varchar (5), (divfs.IO_STALL_READ_MS / 1000) / 86400) as TOTAL_DAYS_READS
				,convert (char (8), dateadd (second, (divfs.IO_STALL_READ_MS / 1000) % 86400, 0), 108) as TOTAL_SECONDS_READS
				,(divfs.IO_STALL_READ_MS / 1000) % 86400 as SECONDS_REMAINING_READS
				,convert (varchar (5), (divfs.IO_STALL_WRITE_MS / 1000) / 86400) as TOTAL_DAYS_WRITES
				,convert (char (8), dateadd (second, (divfs.IO_STALL_WRITE_MS / 1000) % 86400, 0), 108) as TOTAL_SECONDS_WRITES
				,(divfs.IO_STALL_WRITE_MS / 1000) % 86400 as SECONDS_REMAINING_WRITES
		) OAdsr


if @@rowcount = 0
begin

	goto sKIP_dATABASE_dETAILS

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',(case
							when x.DATABASE_FILTER_ID = 1 then x.DATABASE_NAME
							else ''
							end) as 'TD'
					,'',x.FILE_TYPE as 'TD'
					,'',x.LOGICAL_NAME as 'TD'
					,'',x.DRIVE_LETTER as 'TD'
					,'',x.FILE_PATH as 'TD'
					,'',x.[FILE_NAME] as 'TD'
					,'','RIGHT_ALIGN' + x.FILE_SIZE_MB as 'TD'
					,'','RIGHT_ALIGN' + x.MAX_SIZE as 'TD'
					,'','RIGHT_ALIGN' + x.GROWTH_INCREMENT as 'TD'
					,'','RIGHT_ALIGN' + x.FILE_READS as 'TD'
					,'','RIGHT_ALIGN' + x.FILE_WRITES as 'TD'
					,'','RIGHT_ALIGN' + x.FILE_READ_MB as 'TD'
					,'','RIGHT_ALIGN' + x.FILE_WRITTEN_MB as 'TD'
					,'',x.IO_WAIT_TIME_READS as 'TD'
					,'',x.IO_WAIT_TIME_WRITES as 'TD'
				from
					DBO.#TEMP_SSSR_DATABASE_DETAILS x
				order by
					 x.DATABASE_NAME
					,x.DATABASE_FILTER_ID
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>dATABASE dETAILS</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>fILE tYPE</TH>
						<TH NOWRAP>lOGICAL nAME</TH>
						<TH NOWRAP>dRIVE lETTER</TH>
						<TH NOWRAP>fILE pATH</TH>
						<TH NOWRAP>fILE nAME</TH>
						<TH NOWRAP>fILE sIZE (mb)</TH>
						<TH NOWRAP>mAX sIZE</TH>
						<TH NOWRAP>gROWTH iNCREMENT</TH>
						<TH NOWRAP>fILE rEADS</TH>
						<TH NOWRAP>fILE wRITES</TH>
						<TH NOWRAP>fILE rEAD (mb)</TH>
						<TH NOWRAP>fILE wRITTEN (mb)</TH>
						<TH NOWRAP>i/o wAIT tIME rEADS</TH>
						<TH NOWRAP>i/o wAIT tIME wRITES</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 (case
			when x.DATABASE_FILTER_ID = 1 then x.DATABASE_NAME
			else ''
			end) as DATABASE_NAME
		,x.FILE_TYPE
		,x.LOGICAL_NAME
		,x.DRIVE_LETTER
		,x.FILE_PATH
		,x.[FILE_NAME]
		,x.FILE_SIZE_MB
		,x.MAX_SIZE
		,x.GROWTH_INCREMENT
		,x.FILE_READS
		,x.FILE_WRITES
		,x.FILE_READ_MB
		,x.FILE_WRITTEN_MB
		,x.IO_WAIT_TIME_READS
		,x.IO_WAIT_TIME_WRITES
	from
		DBO.#TEMP_SSSR_DATABASE_DETAILS x
	order by
		 x.DATABASE_NAME
		,x.DATABASE_FILTER_ID

end


sKIP_dATABASE_dETAILS:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASE_DETAILS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASE_DETAILS

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY vi: lAST bACKUP sET dETAILS
-----------------------------------------------------------------------------------------------------------------------------

if @lAST_bACKUP = 0
begin

	goto sKIP_lAST_bACKUP_sET

end


select
	 x.DATABASE_NAME
	,isnull (convert (varchar (10), SQbs.BACKUP_SET_ID), 'none') as BACKUP_SET_ID
	,(case SQbs.[TYPE]
		when 'd' then 'dATABASE'
		when 'f' then 'fILE oR fILEGROUP'
		when 'g' then 'dIFFERENTIAL fILE'
		when 'i' then 'dIFFERENTIAL dATABASE'
		when 'l' then 'lOG'
		when 'p' then 'pARTIAL'
		when 'q' then 'dIFFERENTIAL pARTIAL'
		else 'n/a'
		end) as BACKUP_TYPE
	,isnull (convert (varchar (10), SQbs.DATABASE_VERSION), 'n/a') as DATABASE_VERSION
	,isnull (SQbs.SERVER_NAME, 'n/a') as SERVER_NAME
	,isnull (SQbs.MACHINE_NAME, 'n/a') as MACHINE_NAME
	,isnull (SQbs.PHYSICAL_DEVICE_NAME, 'n/a') as PHYSICAL_DEVICE_NAME
	,isnull (convert (varchar (34), SQbs.BACKUP_START_DATE, 120), 'n/a') as BACKUP_START_DATE
	,isnull (convert (varchar (34), SQbs.BACKUP_FINISH_DATE, 120), 'n/a') as BACKUP_FINISH_DATE
	,isnull ((case
				when SQbs.TOTAL_DAYS = '0' then replicate ('_', SQbs.DAY_LENGTH_MAX)
				else replicate ('0', SQbs.DAY_LENGTH_MAX - len (SQbs.TOTAL_DAYS)) + SQbs.TOTAL_DAYS
				end) + ' dAY(S) ' + (case
										when SQbs.SECONDS_REMAINING = 0 then '__:__:__'
										when SQbs.SECONDS_REMAINING < 60 then '__:__:' + right (SQbs.TOTAL_SECONDS, 2)
										when SQbs.SECONDS_REMAINING < 3600 then '__:' + right (SQbs.TOTAL_SECONDS, 5)
										else SQbs.TOTAL_SECONDS
										end), 'n/a') as DURATION
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, round (SQbs.BACKUP_SIZE / 1048576.0, 0)), 1)), 4, 23)), 'n/a') as BACKUP_SIZE_MB
	,isnull (reverse (substring (reverse (convert (varchar (23), convert (money, datediff (day, SQbs.BACKUP_START_DATE, getdate ())), 1)), 4, 23)), 'n/a') as DAYS_AGO
	,row_number () over
						(
							partition by
								x.DATABASE_NAME
							order by
								SQbs.[TYPE]
						) as DATABASE_FILTER_ID
into
	DBO.#TEMP_SSSR_LAST_BACKUP_SET
from
	DBO.#TEMP_SSSR_DATABASES x
	left join

		(
			select
				 bs.DATABASE_NAME
				,bs.BACKUP_SET_ID
				,bs.[TYPE]
				,bs.DATABASE_VERSION
				,bs.SERVER_NAME
				,bs.MACHINE_NAME
				,bmf.PHYSICAL_DEVICE_NAME
				,bs.BACKUP_START_DATE
				,bs.BACKUP_FINISH_DATE
				,bs.BACKUP_SIZE
				,CJdlm.DAY_LENGTH_MAX
				,OAdsr.SECONDS_REMAINING
				,OAdsr.TOTAL_DAYS
				,OAdsr.TOTAL_SECONDS
			from
				MSDB.DBO.BACKUPSET bs
				inner join MSDB.DBO.BACKUPMEDIAFAMILY bmf on bmf.MEDIA_SET_ID = bs.MEDIA_SET_ID
				inner join

					(
						select
							max (xbs.BACKUP_SET_ID) as BACKUP_SET_ID_MAX
						from
							MSDB.DBO.BACKUPSET xbs
						group by
							 xbs.DATABASE_NAME
							,xbs.[TYPE]
					) SQmbs on SQmbs.BACKUP_SET_ID_MAX = bs.BACKUP_SET_ID

				cross join

					(
						select
							max (len (datediff (day, ybs.BACKUP_START_DATE, ybs.BACKUP_FINISH_DATE))) as DAY_LENGTH_MAX
						from
							MSDB.DBO.BACKUPSET ybs
					) CJdlm

				outer apply

					(
						select
							datediff (second, bs.BACKUP_START_DATE, bs.BACKUP_FINISH_DATE) as DURATION_SECONDS
					) OAds

				outer apply

					(
						select
							 convert (varchar (5), OAds.DURATION_SECONDS / 86400) as TOTAL_DAYS
							,convert (char (8), dateadd (second, OAds.DURATION_SECONDS % 86400, 0), 108) as TOTAL_SECONDS
							,OAds.DURATION_SECONDS % 86400 as SECONDS_REMAINING
					) OAdsr

		) SQbs on SQbs.DATABASE_NAME = x.DATABASE_NAME

where
	x.DATABASE_NAME <> n'TEMPDB'


if @@rowcount = 0
begin

	goto sKIP_lAST_bACKUP_sET

end


if exists (select * from DBO.#TEMP_SSSR_LAST_BACKUP_SET x where x.BACKUP_SET_ID = 'none')
begin

	update
		DBO.#TEMP_SSSR_LAST_BACKUP_SET
	set
		 BACKUP_TYPE = replicate ('.', BACKUP_TYPE_LENGTH_MAX * 2)
		,DATABASE_VERSION = replicate ('.', DATABASE_VERSION_LENGTH_MAX * 2)
		,SERVER_NAME = replicate ('.', SERVER_NAME_LENGTH_MAX * 2)
		,MACHINE_NAME = replicate ('.', MACHINE_NAME_LENGTH_MAX * 2)
		,BACKUP_START_DATE = replicate ('.', 34)
		,BACKUP_FINISH_DATE = replicate ('.', 34)
		,DURATION = replicate ('.', (DURATION_LENGTH_MAX * 2) - 4)
		,BACKUP_SIZE_MB = replicate ('.', BACKUP_SIZE_MB_LENGTH_MAX * 2)
	from

		(
			select
				 max (len (x.BACKUP_TYPE)) as BACKUP_TYPE_LENGTH_MAX
				,max (len (x.DATABASE_VERSION)) as DATABASE_VERSION_LENGTH_MAX
				,max (len (x.SERVER_NAME)) as SERVER_NAME_LENGTH_MAX
				,max (len (x.MACHINE_NAME)) as MACHINE_NAME_LENGTH_MAX
				,max (len (x.DURATION)) as DURATION_LENGTH_MAX
				,max (len (x.BACKUP_SIZE_MB)) as BACKUP_SIZE_MB_LENGTH_MAX
			from
				DBO.#TEMP_SSSR_LAST_BACKUP_SET x
		) SQx

	where
		DBO.#TEMP_SSSR_LAST_BACKUP_SET.BACKUP_SET_ID = 'none'

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',(case
							when x.DATABASE_FILTER_ID = 1 then x.DATABASE_NAME
							else ''
							end) as 'TD'
					,'',x.BACKUP_SET_ID as 'TD'
					,'',x.BACKUP_TYPE as 'TD'
					,'',x.DATABASE_VERSION as 'TD'
					,'',x.SERVER_NAME as 'TD'
					,'',x.MACHINE_NAME as 'TD'
					,'',x.PHYSICAL_DEVICE_NAME as 'TD'
					,'',x.BACKUP_START_DATE as 'TD'
					,'',x.BACKUP_FINISH_DATE as 'TD'
					,'',x.DURATION as 'TD'
					,'','RIGHT_ALIGN' + x.BACKUP_SIZE_MB as 'TD'
					,'','RIGHT_ALIGN' + x.DAYS_AGO as 'TD'
				from
					DBO.#TEMP_SSSR_LAST_BACKUP_SET x
				order by
					 x.DATABASE_NAME
					,x.DATABASE_FILTER_ID
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>lAST bACKUP sET dETAILS</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>bACKUP sET id</TH>
						<TH NOWRAP>bACKUP tYPE</TH>
						<TH NOWRAP>dATABASE vERSION</TH>
						<TH NOWRAP>sERVER nAME</TH>
						<TH NOWRAP>mACHINE nAME</TH>
						<TH NOWRAP>pHYSICAL dEVICE nAME</TH>
						<TH NOWRAP>bACKUP sTART dATE</TH>
						<TH NOWRAP>bACKUP fINISH dATE</TH>
						<TH NOWRAP>dURATION</TH>
						<TH NOWRAP>bACKUP sIZE (mb)</TH>
						<TH NOWRAP>dAYS aGO</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 (case
			when x.DATABASE_FILTER_ID = 1 then x.DATABASE_NAME
			else ''
			end) as DATABASE_NAME
		,x.BACKUP_SET_ID
		,x.BACKUP_TYPE
		,x.DATABASE_VERSION
		,x.SERVER_NAME
		,x.MACHINE_NAME
		,x.PHYSICAL_DEVICE_NAME
		,x.BACKUP_START_DATE
		,x.BACKUP_FINISH_DATE
		,x.DURATION
		,x.BACKUP_SIZE_MB
		,x.DAYS_AGO
	from
		DBO.#TEMP_SSSR_LAST_BACKUP_SET x
	order by
		 x.DATABASE_NAME
		,x.DATABASE_FILTER_ID

end


sKIP_lAST_bACKUP_sET:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_LAST_BACKUP_SET', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_LAST_BACKUP_SET

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY vii: sql sERVER aGENT jOBS (lAST 24 hOURS)
-----------------------------------------------------------------------------------------------------------------------------

if @aGENT_jOBS = 0
begin

	goto sKIP_aGENT_jOBS

end


select
	 sj.NAME as JOB_NAME
	,suser_sname (sj.OWNER_SID) as JOB_OWNER
	,convert (varchar (19), sj.DATE_CREATED, 120) as DATE_CREATED
	,convert (varchar (19), sj.DATE_MODIFIED, 120) as DATE_MODIFIED
	,reverse (substring (reverse (convert (varchar (23), convert (money, sj.VERSION_NUMBER), 1)), 4, 23)) as [VERSION]
	,sc.NAME as CATEGORY
	,(case sc.CATEGORY_CLASS
		when 1 then 'jOB'
		when 2 then 'aLERT'
		when 3 then 'oPERATOR'
		else 'n/a'
		end) as CLASS
	,(case sc.CATEGORY_TYPE
		when 1 then 'lOCAL'
		when 2 then 'mULTISERVER'
		when 3 then 'nONE'
		else 'n/a'
		end) as [TYPE]
	,convert (varchar (19), CAlrdt.LAST_RUN_DATE_TIME, 120) as LAST_RUN_DATE_TIME
	,(case sjh.RUN_STATUS
		when 0 then 'fAILED'
		when 1 then 'sUCCEEDED'
		when 2 then 'rETRY'
		when 3 then 'cANCELED'
		when 4 then 'iN pROGRESS'
		end) as LAST_STATUS
	,(case
		when sjh.RUN_DURATION = 0 then '__:__:__'
		when len (sjh.RUN_DURATION) <= 2 then '__:__:' + right ('0' + convert (varchar (2), sjh.RUN_DURATION), 2)
		when len (sjh.RUN_DURATION) <= 4 then '__:' + stuff (right ('0' + convert (varchar (4), sjh.RUN_DURATION), 4), 3, 0, ':')
		else stuff (stuff (right ('0' + convert (varchar (6), sjh.RUN_DURATION), 6), 5, 0, ':'), 3, 0, ':')
		end) as DURATION
	,isnull ((case
				when sj.[ENABLED] = 1 then convert (varchar (19), SQnrdt.NEXT_RUN_DATE_TIME, 120)
				end), '___________________') as NEXT_RUN_DATE_TIME
	,isnull ((case
				when sj.[ENABLED] = 1 then reverse (substring (reverse (convert (varchar (23), convert (money, datediff (day, getdate (), SQnrdt.NEXT_RUN_DATE_TIME)), 1)), 4, 23))
				end), 'n/a') as DAYS_AWAY
into
	DBO.#TEMP_SSSR_AGENT_JOBS
from
	MSDB.DBO.SYSJOBS sj
	inner join MSDB.DBO.SYSJOBHISTORY sjh on sjh.JOB_ID = sj.JOB_ID
	inner join MSDB.DBO.SYSCATEGORIES sc on sc.CATEGORY_ID = sj.CATEGORY_ID
	inner join

		(
			select
				max (xsj.INSTANCE_ID) as INSTANCE_ID_MAX
			from
				MSDB.DBO.SYSJOBHISTORY xsj
			group by
				xsj.JOB_ID
		) SQiim on SQiim.INSTANCE_ID_MAX = sjh.INSTANCE_ID

	left join

		(
			select
				 sjs.JOB_ID
				,min (convert (datetime, convert (varchar (8), sjs.NEXT_RUN_DATE) + ' ' + stuff (stuff (right ('000000' + convert (varchar (6), sjs.NEXT_RUN_TIME), 6), 5, 0, ':'), 3, 0, ':'))) as NEXT_RUN_DATE_TIME
			from
				MSDB.DBO.SYSJOBSCHEDULES sjs
				inner join MSDB.DBO.SYSSCHEDULES ss on ss.SCHEDULE_ID = sjs.SCHEDULE_ID
					and ss.[ENABLED] = 1
			where
				sjs.NEXT_RUN_DATE > 0
			group by
				sjs.JOB_ID
		) SQnrdt on SQnrdt.JOB_ID = sj.JOB_ID

	cross apply

		(
			select
				convert (datetime, convert (varchar (8), sjh.RUN_DATE) + ' ' + stuff (stuff (right ('000000' + convert (varchar (6), sjh.RUN_TIME), 6), 5, 0, ':'), 3, 0, ':')) as LAST_RUN_DATE_TIME
		) CAlrdt

where
	CAlrdt.LAST_RUN_DATE_TIME >= @dATE_24_hOURS_aGO


if @@rowcount = 0
begin

	goto sKIP_aGENT_jOBS

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.JOB_NAME as 'TD'
					,'',x.JOB_OWNER as 'TD'
					,'',x.DATE_CREATED as 'TD'
					,'',x.DATE_MODIFIED as 'TD'
					,'','RIGHT_ALIGN' + x.[VERSION] as 'TD'
					,'',x.CATEGORY as 'TD'
					,'',x.CLASS as 'TD'
					,'',x.[TYPE] as 'TD'
					,'',x.LAST_RUN_DATE_TIME as 'TD'
					,'',x.LAST_STATUS as 'TD'
					,'',x.DURATION as 'TD'
					,'',x.NEXT_RUN_DATE_TIME as 'TD'
					,'','RIGHT_ALIGN' + x.DAYS_AWAY as 'TD'
				from
					DBO.#TEMP_SSSR_AGENT_JOBS x
				order by
					x.JOB_NAME
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>sql sERVER aGENT jOBS (lAST 24 hOURS)</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>jOB nAME</TH>
						<TH NOWRAP>jOB oWNER</TH>
						<TH NOWRAP>dATE cREATED</TH>
						<TH NOWRAP>dATE mODIFIED</TH>
						<TH NOWRAP>vERSION</TH>
						<TH NOWRAP>cATEGORY</TH>
						<TH NOWRAP>cLASS</TH>
						<TH NOWRAP>tYPE</TH>
						<TH NOWRAP>lAST rUN dATE / tIME</TH>
						<TH NOWRAP>lAST sTATUS</TH>
						<TH NOWRAP>dURATION</TH>
						<TH NOWRAP>nEXT rUN dATE / tIME</TH>
						<TH NOWRAP>dAYS aWAY</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.JOB_NAME
		,x.JOB_OWNER
		,x.DATE_CREATED
		,x.DATE_MODIFIED
		,x.[VERSION]
		,x.CATEGORY
		,x.CLASS
		,x.[TYPE]
		,x.LAST_RUN_DATE_TIME
		,x.LAST_STATUS
		,x.DURATION
		,x.NEXT_RUN_DATE_TIME
		,x.DAYS_AWAY
	from
		DBO.#TEMP_SSSR_AGENT_JOBS x
	order by
		x.JOB_NAME

end


sKIP_aGENT_jOBS:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_AGENT_JOBS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_AGENT_JOBS

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY viii: iNDEX fRAGMENTATION
-----------------------------------------------------------------------------------------------------------------------------

if @fRAGMENTATION = 0
begin

	goto sKIP_iNDEX_fRAGMENTATION

end


create table DBO.#TEMP_SSSR_INDEX_FRAGMENTATION

	(
		 OBJECT_TYPE char (2)
		,DATABASE_NAME nvarchar (128)
		,[SCHEMA_NAME] sysname
		,[OBJECT_NAME] sysname
		,INDEX_NAME sysname
		,INDEX_KEY nvarchar (max)
		,INCLUDE_KEY nvarchar (max)
		,FILTER_DEFINITION nvarchar (max)
		,FRAGMENTATION varchar (23)
		,INDEX_TYPE nvarchar (120)
		,IS_PK varchar (3)
		,IS_UNIQUE varchar (3)
		,RECOMMENDATION varchar (10)
		,ROW_COUNT varchar (23)
		,ALTER_INDEX_STATEMENT nvarchar (4000)
	)


set @dATABASE_nAME_lOOP =

	(
		select top (1)
			x.DATABASE_NAME
		from
			DBO.#TEMP_SSSR_DATABASES x
		where
			x.DATABASE_NAME <> n'TEMPDB'
		order by
			x.DATABASE_NAME
	)


while @dATABASE_nAME_lOOP is not null
begin

	set @dATABASE_id = db_id (@dATABASE_nAME_lOOP)


	set @sql_sTRING = @aVOID_tRUNCATION +

		n'
			use [' + @dATABASE_nAME_lOOP + n']


			insert into DBO.#TEMP_SSSR_INDEX_FRAGMENTATION

				(
					 OBJECT_TYPE
					,DATABASE_NAME
					,[SCHEMA_NAME]
					,[OBJECT_NAME]
					,INDEX_NAME
					,INDEX_KEY
					,INCLUDE_KEY
					,FILTER_DEFINITION
					,FRAGMENTATION
					,INDEX_TYPE
					,IS_PK
					,IS_UNIQUE
					,RECOMMENDATION
					,ROW_COUNT
					,ALTER_INDEX_STATEMENT
				)

			select
				 SQif.[TYPE] as OBJECT_TYPE
				,db_name () as DATABASE_NAME
				,schema_name (SQif.[SCHEMA_ID]) as [SCHEMA_NAME]
				,SQif.[OBJECT_NAME]
				,SQif.INDEX_NAME
				,SQif.INDEX_KEY
				,SQif.INCLUDE_KEY
				,SQif.FILTER_DEFINITION
				,reverse (substring (reverse (convert (varchar (23), convert (money, SQif.AVG_FRAGMENTATION_IN_PERCENT), 1)), 1, 23)) as FRAGMENTATION
				,SQif.TYPE_DESC as INDEX_TYPE
				,(case SQif.IS_PRIMARY_KEY
					when 0 then ''nO''
					when 1 then ''yES''
					else ''n/a''
					end) as IS_PK
				,(case SQif.IS_UNIQUE
					when 0 then ''nO''
					when 1 then ''yES''
					else ''n/a''
					end) as IS_UNIQUE
				,CArec.RECOMMENDATION
				,reverse (substring (reverse (convert (varchar (23), convert (money, SQif.[ROWS]), 1)), 4, 23)) as ROW_COUNT
				,n''use [''
				 + db_name ()
				 + n'']; alter index [''
				 + SQif.INDEX_NAME
				 + n''] on [''
				 + schema_name (SQif.[SCHEMA_ID])
				 + n''].[''
				 + SQif.[OBJECT_NAME]
				 + n''] ''
				 + CArec.RECOMMENDATION
				 + (case CArec.RECOMMENDATION
						when ''rebuild'' then n'' with (maxdop = 1)''
						else n''''
						end)
				 + n'';'' as ALTER_INDEX_STATEMENT
			from

				(
					select
						 o.[TYPE]
						,o.[SCHEMA_ID]
						,o.NAME as [OBJECT_NAME]
						,i.NAME as INDEX_NAME
						,stuff (convert (nvarchar (max), (CAiif.INDEX_KEY)), 1, 2, n'''') as INDEX_KEY
						,isnull (stuff (convert (nvarchar (max), (CAiif.INCLUDE_KEY)), 1, 2, n''''), n'''') as INCLUDE_KEY
						,' + @fILTER_dEFINITION_sTRING + n' as FILTER_DEFINITION
						,ddips.AVG_FRAGMENTATION_IN_PERCENT
						,i.TYPE_DESC
						,i.IS_PRIMARY_KEY
						,i.IS_UNIQUE
						,TTsrc.[ROWS]
						,row_number () over
										(
											partition by
												i.NAME
											order by
												ddips.AVG_FRAGMENTATION_IN_PERCENT desc
										) as ROW_NUMBER_ID
					from
						SYS.DM_DB_INDEX_PHYSICAL_STATS (' + convert (nvarchar (11), @dATABASE_id) + n', null, null, null, n''limited'') ddips
						inner join SYS.OBJECTS o on o.[OBJECT_ID] = ddips.[OBJECT_ID]
							and o.[TYPE] in (''u'', ''v'')
							and o.IS_MS_SHIPPED = 0
							and not

								(
									schema_name (o.[SCHEMA_ID]) = n''DBO''
									and o.NAME = n''SYSDIAGRAMS''
									and o.[TYPE] = ''u''
								)

						inner join SYS.INDEXES i on i.[OBJECT_ID] = ddips.[OBJECT_ID]
							and i.INDEX_ID = ddips.INDEX_ID
							and i.IS_DISABLED <> 1
							and i.IS_HYPOTHETICAL <> 1
						inner join DBO.#TEMP_SSSR_ROW_COUNTS TTsrc on TTsrc.[OBJECT_ID] = ddips.[OBJECT_ID]
							and TTsrc.DATABASE_ID = db_id ()
						cross apply

							(
								select
									 (
										select
											  n'', ''
											+ c.NAME as [TEXT()]
										from
											SYS.INDEX_COLUMNS ic
											inner join SYS.COLUMNS c on c.[OBJECT_ID] = ic.[OBJECT_ID]
												and c.COLUMN_ID = ic.COLUMN_ID
										where
											ic.IS_INCLUDED_COLUMN = 0
											and ic.[OBJECT_ID] = i.[OBJECT_ID]
											and ic.INDEX_ID = i.INDEX_ID
										order by
											ic.KEY_ORDINAL
										for
											 xml path ('''')
											,type
									 ) as INDEX_KEY
									,(
										select
											  n'', ''
											+ c.NAME as [TEXT()]
										from
											SYS.INDEX_COLUMNS ic
											inner join SYS.COLUMNS c on c.[OBJECT_ID] = ic.[OBJECT_ID]
												and c.COLUMN_ID = ic.COLUMN_ID
										where
											ic.IS_INCLUDED_COLUMN = 1
											and ic.[OBJECT_ID] = i.[OBJECT_ID]
											and ic.INDEX_ID = i.INDEX_ID
										order by
											ic.KEY_ORDINAL
										for
											 xml path ('''')
											,type
									 ) as INCLUDE_KEY
							) CAiif

					where
						ddips.INDEX_ID <> 0
						and ddips.AVG_FRAGMENTATION_IN_PERCENT > 5
				) SQif

				cross apply

					(
						select
							(case
								when SQif.AVG_FRAGMENTATION_IN_PERCENT <= 30.0 then ''reorganize''
								else ''rebuild''
								end) as RECOMMENDATION
					) CArec

			where
				SQif.ROW_NUMBER_ID = 1
		 '


	execute (@sql_sTRING)


	set @dATABASE_nAME_lOOP =

		(
			select top (1)
				x.DATABASE_NAME
			from
				DBO.#TEMP_SSSR_DATABASES x
			where
				x.DATABASE_NAME <> n'TEMPDB'
				and x.DATABASE_NAME > @dATABASE_nAME_lOOP
			order by
				x.DATABASE_NAME
		)

end


if not exists (select * from DBO.#TEMP_SSSR_INDEX_FRAGMENTATION x)
begin

	goto sKIP_iNDEX_fRAGMENTATION

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.OBJECT_TYPE as 'TD'
					,'',x.DATABASE_NAME as 'TD'
					,'',x.[SCHEMA_NAME] as 'TD'
					,'',x.[OBJECT_NAME] as 'TD'
					,'',x.INDEX_NAME as 'TD'
					,'',x.INDEX_KEY as 'TD'
					,'',x.INCLUDE_KEY as 'TD'
					,'',x.FILTER_DEFINITION as 'TD'
					,'','RIGHT_ALIGN' + x.FRAGMENTATION as 'TD'
					,'',x.INDEX_TYPE as 'TD'
					,'',x.IS_PK as 'TD'
					,'',x.IS_UNIQUE as 'TD'
					,'',x.RECOMMENDATION as 'TD'
					,'','RIGHT_ALIGN' + x.ROW_COUNT as 'TD'
					,'',x.ALTER_INDEX_STATEMENT as 'TD'
				from
					DBO.#TEMP_SSSR_INDEX_FRAGMENTATION x
				order by
					 x.OBJECT_TYPE
					,x.DATABASE_NAME
					,x.[SCHEMA_NAME]
					,x.[OBJECT_NAME]
					,x.INDEX_NAME
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>iNDEX fRAGMENTATION</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>oBJECT tYPE</TH>
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>sCHEMA nAME</TH>
						<TH NOWRAP>oBJECT nAME</TH>
						<TH NOWRAP>iNDEX nAME</TH>
						<TH NOWRAP>iNDEX kEY</TH>
						<TH NOWRAP>iNCLUDE kEY</TH>
						<TH NOWRAP>fILTER dEFINITION</TH>
						<TH NOWRAP>fRAGMENTATION</TH>
						<TH NOWRAP>iNDEX tYPE</TH>
						<TH NOWRAP>pk</TH>
						<TH NOWRAP>uNIQUE</TH>
						<TH NOWRAP>rECOMMENDATION</TH>
						<TH NOWRAP>rOW cOUNT</TH>
						<TH NOWRAP>aLTER iNDEX sTATEMENT</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.INDEX_NAME
		,x.INDEX_KEY
		,x.INCLUDE_KEY
		,x.FILTER_DEFINITION
		,x.FRAGMENTATION
		,x.INDEX_TYPE
		,x.IS_PK as PK
		,x.IS_UNIQUE as [UNIQUE]
		,x.RECOMMENDATION
		,x.ROW_COUNT
		,x.ALTER_INDEX_STATEMENT
	from
		DBO.#TEMP_SSSR_INDEX_FRAGMENTATION x
	order by
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.INDEX_NAME

end


sKIP_iNDEX_fRAGMENTATION:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_INDEX_FRAGMENTATION', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_INDEX_FRAGMENTATION

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY ix: mISSING iNDEXES
-----------------------------------------------------------------------------------------------------------------------------

if @mISSING_iNDEXES = 0
begin

	goto sKIP_mISSING_iNDEXES

end


create table DBO.#TEMP_SSSR_MISSING_INDEXES

	(
		 OBJECT_TYPE char (2)
		,DATABASE_NAME nvarchar (128)
		,[SCHEMA_NAME] sysname
		,[OBJECT_NAME] sysname
		,UNIQUE_COMPILES varchar (23)
		,USER_SEEKS varchar (23)
		,USER_SCANS varchar (23)
		,AVG_TOTAL_USER_COST varchar (23)
		,AVG_USER_IMPACT varchar (23)
		,OVERALL_IMPACT varchar (23)
		,IMPACT_RANK varchar (23)
		,INDEX_KEY nvarchar (max)
		,INCLUDE_KEY nvarchar (max)
		,TABLE_COLUMN_COUNT varchar (23)
		,INDEX_COLUMN_COUNT varchar (23)
		,INCLUDE_COLUMN_COUNT varchar (23)
		,INDEX_PCT_OF_COLUMNS varchar (23)
		,INCLUDE_PCT_OF_COLUMNS varchar (23)
		,TOTAL_PCT_OF_COLUMNS varchar (23)
		,ROW_COUNT varchar (23)
		,CREATE_INDEX_STATEMENT nvarchar (max)
	)


set @dATABASE_nAME_lOOP =

	(
		select top (1)
			x.DATABASE_NAME
		from
			DBO.#TEMP_SSSR_DATABASES x
		where
			x.DATABASE_NAME <> n'TEMPDB'
		order by
			x.DATABASE_NAME
	)


while @dATABASE_nAME_lOOP is not null
begin

	set @sql_sTRING = @aVOID_tRUNCATION +

		n'
			use [' + @dATABASE_nAME_lOOP + n']


			insert into DBO.#TEMP_SSSR_MISSING_INDEXES

				(
					 OBJECT_TYPE
					,DATABASE_NAME
					,[SCHEMA_NAME]
					,[OBJECT_NAME]
					,UNIQUE_COMPILES
					,USER_SEEKS
					,USER_SCANS
					,AVG_TOTAL_USER_COST
					,AVG_USER_IMPACT
					,OVERALL_IMPACT
					,IMPACT_RANK
					,INDEX_KEY
					,INCLUDE_KEY
					,TABLE_COLUMN_COUNT
					,INDEX_COLUMN_COUNT
					,INCLUDE_COLUMN_COUNT
					,INDEX_PCT_OF_COLUMNS
					,INCLUDE_PCT_OF_COLUMNS
					,TOTAL_PCT_OF_COLUMNS
					,ROW_COUNT
					,CREATE_INDEX_STATEMENT
				)


			select
				 o.[TYPE] as OBJECT_TYPE
				,db_name () as DATABASE_NAME
				,schema_name (o.[SCHEMA_ID]) as [SCHEMA_NAME]
				,o.NAME as [OBJECT_NAME]
				,reverse (substring (reverse (convert (varchar (23), convert (money, ddmigs.UNIQUE_COMPILES), 1)), 4, 23)) as UNIQUE_COMPILES
				,reverse (substring (reverse (convert (varchar (23), convert (money, ddmigs.USER_SEEKS), 1)), 4, 23)) as USER_SEEKS
				,reverse (substring (reverse (convert (varchar (23), convert (money, ddmigs.USER_SCANS), 1)), 4, 23)) as USER_SCANS
				,reverse (substring (reverse (convert (varchar (23), convert (money, ddmigs.AVG_TOTAL_USER_COST), 1)), 1, 23)) as AVG_TOTAL_USER_COST
				,reverse (substring (reverse (convert (varchar (23), convert (money, ddmigs.AVG_USER_IMPACT), 1)), 1, 23)) as AVG_USER_IMPACT
				,reverse (substring (reverse (convert (varchar (23), convert (money, CAic.OVERALL_IMPACT), 1)), 1, 23)) as OVERALL_IMPACT
				,reverse (substring (reverse (convert (varchar (23), convert (money, dense_rank () over
																										(
																											order by
																												CAic.OVERALL_IMPACT desc
																										)), 1)), 4, 23)) as IMPACT_RANK
				,isnull (ddmid.EQUALITY_COLUMNS + CAic.COMMA_OR_NOT, n'''') + isnull (ddmid.INEQUALITY_COLUMNS, n'''') as INDEX_KEY
				,isnull (ddmid.INCLUDED_COLUMNS, n'''') as INCLUDE_KEY
				,reverse (substring (reverse (convert (varchar (23), convert (money, SQcc.TABLE_COLUMN_COUNT), 1)), 4, 23)) as TABLE_COLUMN_COUNT
				,reverse (substring (reverse (convert (varchar (23), convert (money, CAic.INDEX_COLUMN_COUNT), 1)), 4, 23)) as INDEX_COLUMN_COUNT
				,reverse (substring (reverse (convert (varchar (23), convert (money, CAic.INCLUDE_COLUMN_COUNT), 1)), 4, 23)) as INCLUDE_COLUMN_COUNT
				,reverse (substring (reverse (convert (varchar (23), convert (money, (CAic.INDEX_COLUMN_COUNT / SQcc.TABLE_COLUMN_COUNT) * 100), 1)), 1, 23)) as INDEX_PCT_OF_COLUMNS
				,reverse (substring (reverse (convert (varchar (23), convert (money, (CAic.INCLUDE_COLUMN_COUNT / SQcc.TABLE_COLUMN_COUNT) * 100), 1)), 1, 23)) as INCLUDE_PCT_OF_COLUMNS
				,reverse (substring (reverse (convert (varchar (23), convert (money, ((CAic.INDEX_COLUMN_COUNT + CAic.INCLUDE_COLUMN_COUNT) / SQcc.TABLE_COLUMN_COUNT) * 100), 1)), 1, 23)) as TOTAL_PCT_OF_COLUMNS
				,reverse (substring (reverse (convert (varchar (23), convert (money, TTsrc.[ROWS]), 1)), 4, 23)) as ROW_COUNT
				,CAcis.CREATE_INDEX_STATEMENT
			from
				SYS.OBJECTS o
				inner join SYS.DM_DB_MISSING_INDEX_DETAILS ddmid on ddmid.[OBJECT_ID] = o.[OBJECT_ID]
					and ddmid.DATABASE_ID = db_id ()
				inner join SYS.DM_DB_MISSING_INDEX_GROUPS ddmig on ddmig.INDEX_HANDLE = ddmid.INDEX_HANDLE
				inner join SYS.DM_DB_MISSING_INDEX_GROUP_STATS ddmigs on ddmigs.GROUP_HANDLE = ddmig.INDEX_GROUP_HANDLE
				inner join

					(
						select
							 c.[OBJECT_ID]
							,count (*) + .0 as TABLE_COLUMN_COUNT
						from
							SYS.COLUMNS c
						group by
							c.[OBJECT_ID]
					) SQcc on SQcc.[OBJECT_ID] = o.[OBJECT_ID]

				inner join DBO.#TEMP_SSSR_ROW_COUNTS TTsrc on TTsrc.[OBJECT_ID] = o.[OBJECT_ID]
					and TTsrc.DATABASE_ID = db_id ()
				cross apply

					(
						select
							 convert (decimal (18, 2), (ddmigs.USER_SEEKS + ddmigs.USER_SCANS) * (ddmigs.AVG_TOTAL_USER_COST * ddmigs.AVG_USER_IMPACT)) as OVERALL_IMPACT
							,isnull ((len (ddmid.EQUALITY_COLUMNS) - len (replace (ddmid.EQUALITY_COLUMNS, n'','', n''''))) + 1, 0) + isnull ((len (ddmid.INEQUALITY_COLUMNS) - len (replace (ddmid.INEQUALITY_COLUMNS, n'','', n''''))) + 1, 0) as INDEX_COLUMN_COUNT
							,isnull ((len (ddmid.INCLUDED_COLUMNS) - len (replace (ddmid.INCLUDED_COLUMNS, n'','', n''''))) + 1, 0) as INCLUDE_COLUMN_COUNT
							,(case
								when ddmid.INEQUALITY_COLUMNS is not null then n'', ''
								else n''''
								end) as COMMA_OR_NOT
							,n''ix_''
							 + o.NAME
							 + n''_''
							 + isnull (replace (substring (substring (ddmid.EQUALITY_COLUMNS, 1, len (ddmid.EQUALITY_COLUMNS) - 1), 2, len (ddmid.EQUALITY_COLUMNS) - 1), n''], ['', n''_'')
							 + (case
									when ddmid.INEQUALITY_COLUMNS is not null then n''_''
									else n''''
									end), n'''')
							 + isnull (replace (substring (substring (ddmid.INEQUALITY_COLUMNS, 1, len (ddmid.INEQUALITY_COLUMNS) - 1), 2, len (ddmid.INEQUALITY_COLUMNS) - 1), n''], ['', n''_''), n'''')
							 + isnull (n''_I_'' + replace (substring (substring (ddmid.INCLUDED_COLUMNS, 1, len (ddmid.INCLUDED_COLUMNS) - 1), 2, len (ddmid.INCLUDED_COLUMNS) - 1), n''], ['', n''_''), n'''') as INDEX_BASE_STRING
					) CAic

				cross apply

					(
						select
							n''create nonclustered index ''
							+ (case
									when len (CAic.INDEX_BASE_STRING collate database_default) > 128 then n''<index name>''
									else n''['' + CAic.INDEX_BASE_STRING + n'']''
									end)
							+ n'' on ''
							+ n''[''
							+ db_name ()
							+ n'']''
							+ n''.''
							+ n''[''
							+ schema_name (o.[SCHEMA_ID])
							+ n'']''
							+ n''.''
							+ n''[''
							+ o.NAME
							+ n'']''
							+ n'' (''
							+ isnull (ddmid.EQUALITY_COLUMNS + CAic.COMMA_OR_NOT, n'''')
							+ isnull (ddmid.INEQUALITY_COLUMNS, n'''')
							+ n'')''
							+ isnull (n'' include ('' + ddmid.INCLUDED_COLUMNS + n'')'', n'''')
							+ n'';'' as CREATE_INDEX_STATEMENT
					) CAcis

			where
				o.[TYPE] in (''u'', ''v'')
				and o.IS_MS_SHIPPED = 0
				and not

					(
						schema_name (o.[SCHEMA_ID]) = n''DBO''
						and o.NAME = n''SYSDIAGRAMS''
						and o.[TYPE] = ''u''
					)
		 '


	execute (@sql_sTRING)


	set @dATABASE_nAME_lOOP =

		(
			select top (1)
				x.DATABASE_NAME
			from
				DBO.#TEMP_SSSR_DATABASES x
			where
				x.DATABASE_NAME <> n'TEMPDB'
				and x.DATABASE_NAME > @dATABASE_nAME_lOOP
			order by
				x.DATABASE_NAME
		)

end


if not exists (select * from DBO.#TEMP_SSSR_MISSING_INDEXES x)
begin

	goto sKIP_mISSING_iNDEXES

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.OBJECT_TYPE as 'TD'
					,'',x.DATABASE_NAME as 'TD'
					,'',x.[SCHEMA_NAME] as 'TD'
					,'',x.[OBJECT_NAME] as 'TD'
					,'','RIGHT_ALIGN' + x.UNIQUE_COMPILES as 'TD'
					,'','RIGHT_ALIGN' + x.USER_SEEKS as 'TD'
					,'','RIGHT_ALIGN' + x.USER_SCANS as 'TD'
					,'','RIGHT_ALIGN' + x.AVG_TOTAL_USER_COST as 'TD'
					,'','RIGHT_ALIGN' + x.AVG_USER_IMPACT as 'TD'
					,'','RIGHT_ALIGN' + x.OVERALL_IMPACT as 'TD'
					,'','RIGHT_ALIGN' + x.IMPACT_RANK as 'TD'
					,'',x.INDEX_KEY as 'TD'
					,'',x.INCLUDE_KEY as 'TD'
					,'','RIGHT_ALIGN' + x.TABLE_COLUMN_COUNT as 'TD'
					,'','RIGHT_ALIGN' + x.INDEX_COLUMN_COUNT as 'TD'
					,'','RIGHT_ALIGN' + x.INCLUDE_COLUMN_COUNT as 'TD'
					,'','RIGHT_ALIGN' + x.INDEX_PCT_OF_COLUMNS as 'TD'
					,'','RIGHT_ALIGN' + x.INCLUDE_PCT_OF_COLUMNS as 'TD'
					,'','RIGHT_ALIGN' + x.TOTAL_PCT_OF_COLUMNS as 'TD'
					,'','RIGHT_ALIGN' + x.ROW_COUNT as 'TD'
					,'',x.CREATE_INDEX_STATEMENT as 'TD'
				from
					DBO.#TEMP_SSSR_MISSING_INDEXES x
				order by
					 x.OBJECT_TYPE
					,x.DATABASE_NAME
					,x.[SCHEMA_NAME]
					,x.[OBJECT_NAME]
					,x.IMPACT_RANK
					,x.INDEX_KEY
					,x.INCLUDE_KEY
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>mISSING iNDEXES</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>oBJECT tYPE</TH>
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>sCHEMA nAME</TH>
						<TH NOWRAP>oBJECT nAME</TH>
						<TH NOWRAP>uNIQUE cOMPILES</TH>
						<TH NOWRAP>uSER sEEKS</TH>
						<TH NOWRAP>uSER sCANS</TH>
						<TH NOWRAP>aVG uSER cOST</TH>
						<TH NOWRAP>aVG uSER iMPACT</TH>
						<TH NOWRAP>oVERALL iMPACT</TH>
						<TH NOWRAP>iMPACT rANK</TH>
						<TH NOWRAP>iNDEX kEY</TH>
						<TH NOWRAP>iNCLUDE kEY</TH>
						<TH NOWRAP>tABLE cOLUMN cOUNT</TH>
						<TH NOWRAP>iNDEX cOLUMN cOUNT</TH>
						<TH NOWRAP>iNCLUDE cOLUMN cOUNT</TH>
						<TH NOWRAP>iNDEX % oF cOLUMNS</TH>
						<TH NOWRAP>iNCLUDE % oF cOLUMNS</TH>
						<TH NOWRAP>tOTAL % oF cOLUMNS</TH>
						<TH NOWRAP>rOW cOUNT</TH>
						<TH NOWRAP>cREATE iNDEX sTATEMENT</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.UNIQUE_COMPILES
		,x.USER_SEEKS
		,x.USER_SCANS
		,x.AVG_TOTAL_USER_COST as AVG_USER_COST
		,x.AVG_USER_IMPACT
		,x.OVERALL_IMPACT
		,x.IMPACT_RANK
		,x.INDEX_KEY
		,x.INCLUDE_KEY
		,x.TABLE_COLUMN_COUNT
		,x.INDEX_COLUMN_COUNT
		,x.INCLUDE_COLUMN_COUNT
		,x.INDEX_PCT_OF_COLUMNS
		,x.INCLUDE_PCT_OF_COLUMNS
		,x.TOTAL_PCT_OF_COLUMNS
		,x.ROW_COUNT
		,x.CREATE_INDEX_STATEMENT
	from
		DBO.#TEMP_SSSR_MISSING_INDEXES x
	order by
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.IMPACT_RANK
		,x.INDEX_KEY
		,x.INCLUDE_KEY

end


sKIP_mISSING_iNDEXES:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_MISSING_INDEXES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_MISSING_INDEXES

end


-----------------------------------------------------------------------------------------------------------------------------
--	mAIN qUERY x: uNUSED iNDEXES
-----------------------------------------------------------------------------------------------------------------------------

if @uNUSED_iNDEXES = 0
begin

	goto sKIP_uNUSED_iNDEXES

end


create table DBO.#TEMP_SSSR_UNUSED_INDEXES

	(
		 OBJECT_TYPE char (2)
		,DATABASE_NAME nvarchar (128)
		,[SCHEMA_NAME] sysname
		,[OBJECT_NAME] sysname
		,INDEX_NAME sysname
		,INDEX_KEY nvarchar (max)
		,INCLUDE_KEY nvarchar (max)
		,FILTER_DEFINITION nvarchar (max)
		,[DISABLED] varchar (3)
		,HYPOTHETICAL varchar (3)
		,ROW_COUNT varchar (23)
		,DROP_INDEX_STATEMENT nvarchar (4000)
	)


set @dATABASE_nAME_lOOP =

	(
		select top (1)
			x.DATABASE_NAME
		from
			DBO.#TEMP_SSSR_DATABASES x
		where
			x.DATABASE_NAME <> n'TEMPDB'
		order by
			x.DATABASE_NAME
	)


while @dATABASE_nAME_lOOP is not null
begin

	set @sql_sTRING = @aVOID_tRUNCATION +

		n'
			use [' + @dATABASE_nAME_lOOP + n']


			insert into DBO.#TEMP_SSSR_UNUSED_INDEXES

				(
					 OBJECT_TYPE
					,DATABASE_NAME
					,[SCHEMA_NAME]
					,[OBJECT_NAME]
					,INDEX_NAME
					,INDEX_KEY
					,INCLUDE_KEY
					,FILTER_DEFINITION
					,[DISABLED]
					,HYPOTHETICAL
					,ROW_COUNT
					,DROP_INDEX_STATEMENT
				)

			select
				 o.[TYPE] as OBJECT_TYPE
				,db_name () as DATABASE_NAME
				,schema_name (o.SCHEMA_ID) as [SCHEMA_NAME]
				,o.NAME as [OBJECT_NAME]
				,i.NAME as INDEX_NAME
				,stuff (convert (nvarchar (max), (CAiif.INDEX_KEY)), 1, 2, n'''') as INDEX_KEY
				,isnull (stuff (convert (nvarchar (max), (CAiif.INCLUDE_KEY)), 1, 2, n''''), n'''') as INCLUDE_KEY
				,' + @fILTER_dEFINITION_sTRING + n' as FILTER_DEFINITION
				,(case
					when i.IS_DISABLED = 1 then ''yES''
					else ''nO''
					end) as [DISABLED]
				,(case
					when i.IS_HYPOTHETICAL = 1 then ''yES''
					else ''nO''
					end) as HYPOTHETICAL
				,reverse (substring (reverse (convert (varchar (23), convert (money, TTsrc.[ROWS]), 1)), 4, 23)) as ROW_COUNT
				,n''use [''
				 + db_name ()
				 + n'']; if exists (select * from SYS.INDEXES i where i.[OBJECT_ID] = ''
				 + convert (varchar (11), i.[OBJECT_ID])
				 + n'' and i.INDEX_ID = ''
				 + convert (varchar (11), i.INDEX_ID)
				 + n'') begin drop index [''
				 + i.NAME
				 + n''] on [''
				 + schema_name (o.SCHEMA_ID)
				 + n''].[''
				 + o.NAME
				 + n''] end;'' as DROP_INDEX_STATEMENT
			from
				SYS.INDEXES i
				inner join SYS.OBJECTS o on o.[OBJECT_ID] = i.[OBJECT_ID]
					and o.[TYPE] in (''u'', ''v'')
					and o.IS_MS_SHIPPED = 0
					and not

						(
							schema_name (o.[SCHEMA_ID]) = n''DBO''
							and o.NAME = n''SYSDIAGRAMS''
							and o.[TYPE] = ''u''
						)

				inner join DBO.#TEMP_SSSR_ROW_COUNTS TTsrc on TTsrc.[OBJECT_ID] = i.[OBJECT_ID]
					and TTsrc.DATABASE_ID = db_id ()
				cross apply

					(
						select
							 (
								select
									  n'', ''
									+ c.NAME as [TEXT()]
								from
									SYS.INDEX_COLUMNS ic
									inner join SYS.COLUMNS c on c.[OBJECT_ID] = ic.[OBJECT_ID]
										and c.COLUMN_ID = ic.COLUMN_ID
								where
									ic.IS_INCLUDED_COLUMN = 0
									and ic.[OBJECT_ID] = i.[OBJECT_ID]
									and ic.INDEX_ID = i.INDEX_ID
								order by
									ic.KEY_ORDINAL
								for
									 xml path ('''')
									,type
							 ) as INDEX_KEY
							,(
								select
									  n'', ''
									+ c.NAME as [TEXT()]
								from
									SYS.INDEX_COLUMNS ic
									inner join SYS.COLUMNS c on c.[OBJECT_ID] = ic.[OBJECT_ID]
										and c.COLUMN_ID = ic.COLUMN_ID
								where
									ic.IS_INCLUDED_COLUMN = 1
									and ic.[OBJECT_ID] = i.[OBJECT_ID]
									and ic.INDEX_ID = i.INDEX_ID
								order by
									ic.KEY_ORDINAL
								for
									 xml path ('''')
									,type
							 ) as INCLUDE_KEY
					) CAiif

			where
				i.[TYPE] = 2
				and i.IS_PRIMARY_KEY = 0
				and i.IS_UNIQUE = 0
				and not exists

					(
						select
							*
						from
							SYS.INDEX_COLUMNS xic
							inner join SYS.FOREIGN_KEY_COLUMNS fkc on fkc.PARENT_OBJECT_ID = xic.[OBJECT_ID]
								and fkc.PARENT_COLUMN_ID = xic.COLUMN_ID
						where
							xic.[OBJECT_ID] = i.[OBJECT_ID]
							and xic.INDEX_ID = i.INDEX_ID
					)

				and not exists

					(
						select
							*
						from
							MASTER.SYS.DM_DB_INDEX_USAGE_STATS ddius
						where
							ddius.DATABASE_ID = db_id ()
							and ddius.[OBJECT_ID] = i.[OBJECT_ID]
							and ddius.INDEX_ID = i.INDEX_ID
					)
		 '


	execute (@sql_sTRING)


	set @dATABASE_nAME_lOOP =

		(
			select top (1)
				x.DATABASE_NAME
			from
				DBO.#TEMP_SSSR_DATABASES x
			where
				x.DATABASE_NAME <> n'TEMPDB'
				and x.DATABASE_NAME > @dATABASE_nAME_lOOP
			order by
				x.DATABASE_NAME
		)

end


if not exists (select * from DBO.#TEMP_SSSR_UNUSED_INDEXES x)
begin

	goto sKIP_uNUSED_iNDEXES

end


if @oUTPUT_mODE = 'e'
begin

	set @xml_sTRING =

		convert (nvarchar (max),
			(
				select
					 '',x.OBJECT_TYPE as 'TD'
					,'',x.DATABASE_NAME as 'TD'
					,'',x.[SCHEMA_NAME] as 'TD'
					,'',x.[OBJECT_NAME] as 'TD'
					,'',x.INDEX_NAME as 'TD'
					,'',x.INDEX_KEY as 'TD'
					,'',x.INCLUDE_KEY as 'TD'
					,'',x.FILTER_DEFINITION as 'TD'
					,'',x.[DISABLED] as 'TD'
					,'',x.HYPOTHETICAL as 'TD'
					,'','RIGHT_ALIGN' + x.ROW_COUNT as 'TD'
					,'',x.DROP_INDEX_STATEMENT as 'TD'
				from
					DBO.#TEMP_SSSR_UNUSED_INDEXES x
				order by
					 x.OBJECT_TYPE
					,x.DATABASE_NAME
					,x.[SCHEMA_NAME]
					,x.[OBJECT_NAME]
					,x.INDEX_NAME
				for
					xml path ('TR')
			)
		)


	set @bODY = @bODY +

		n'
			<BR>
			<H3><CENTER>uNUSED iNDEXES</CENTER></H3>
			<CENTER>
				<TABLE FRAME=BOX BORDER=1 CELLPADDING=2>
					<TR STYLE="COLOR: WHITE; BACKGROUND-COLOR: BLACK">
						<TH NOWRAP>oBJECT tYPE</TH>
						<TH NOWRAP>dATABASE nAME</TH>
						<TH NOWRAP>sCHEMA nAME</TH>
						<TH NOWRAP>oBJECT nAME</TH>
						<TH NOWRAP>iNDEX nAME</TH>
						<TH NOWRAP>iNDEX kEY</TH>
						<TH NOWRAP>iNCLUDE kEY</TH>
						<TH NOWRAP>fILTER dEFINITION</TH>
						<TH NOWRAP>dISABLED</TH>
						<TH NOWRAP>hYPOTHETICAL</TH>
						<TH NOWRAP>rOW cOUNT</TH>
						<TH NOWRAP>dROP iNDEX sTATEMENT</TH>
					</TR>
		 '


	set @bODY = @bODY + @xml_sTRING +

		n'
				</TABLE>
			</CENTER>
		 '

end
else begin

	select
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.INDEX_NAME
		,x.INDEX_KEY
		,x.INCLUDE_KEY
		,x.FILTER_DEFINITION
		,x.[DISABLED]
		,x.HYPOTHETICAL
		,x.ROW_COUNT
		,x.DROP_INDEX_STATEMENT
	from
		DBO.#TEMP_SSSR_UNUSED_INDEXES x
	order by
		 x.OBJECT_TYPE
		,x.DATABASE_NAME
		,x.[SCHEMA_NAME]
		,x.[OBJECT_NAME]
		,x.INDEX_NAME

end


sKIP_uNUSED_iNDEXES:


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_UNUSED_INDEXES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_UNUSED_INDEXES

end


-----------------------------------------------------------------------------------------------------------------------------
--	vARIABLE uPDATE: fINALIZE "@bODY" vARIABLE cONTENTS
-----------------------------------------------------------------------------------------------------------------------------

if @oUTPUT_mODE = 'e'
begin

	set @bODY =

		n'
			<HTML>
				<BODY>
				<STYLE TYPE="TEXT/CSS">
					TABLE {FONT-SIZE: 8.0PT; FONT-FAMILY: aRIAL; TEXT-ALIGN: LEFT; WHITE-SPACE: NOWRAP; EMPTY-CELLS: SHOW}
					TBODY TR:NTH-CHILD(ODD) {BACKGROUND-COLOR: #CCC;}
					TR {TEXT-ALIGN: LEFT;}
				</STYLE>
		 '

		+ substring (@bODY, 10, len (@bODY) - 10) +

		n'
				</BODY>
			</HTML>
		 '


	set @bODY = replace (replace (@bODY, n'<TD>', n'<TD NOWRAP>'), n'<TD NOWRAP>RIGHT_ALIGN', n'<TD NOWRAP ALIGN="RIGHT">')

end


-----------------------------------------------------------------------------------------------------------------------------
--	SP_SEND_DBMAIL: dELIVER rESULTS / nOTIFICATION tO eND uSER(S)
-----------------------------------------------------------------------------------------------------------------------------

if @oUTPUT_mODE = 'e'
begin

	execute MSDB.DBO.SP_SEND_DBMAIL

		 @RECIPIENTS = @rECIPIENTS
		,@COPY_RECIPIENTS = @cOPY_rECIPIENTS
		,@SUBJECT = @sUBJECT
		,@BODY = @bODY
		,@BODY_FORMAT = 'html'

end


-----------------------------------------------------------------------------------------------------------------------------
--	cLEANUP: dROP aNY rEMAINING tEMP tABLES
-----------------------------------------------------------------------------------------------------------------------------

if object_id (n'TEMPDB.DBO.#TEMP_SSSR_DATABASES', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_DATABASES

end


if object_id (n'TEMPDB.DBO.#TEMP_SSSR_ROW_COUNTS', n'u') is not null
begin

	drop table DBO.#TEMP_SSSR_ROW_COUNTS

end
go