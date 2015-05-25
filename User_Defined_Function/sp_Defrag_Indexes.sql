use DBMonitor
go

if exists (select * from sys.objects where object_id = object_id(N'[dbo].[sp_Defrag_Indexes]') and type in (N'P', N'PC'))
	drop procedure [dbo].[sp_Defrag_Indexes]
go

use DBMonitor
go

/****** Object:  StoredProcedure [dbo].[sp_Defrag_Indexes]    Script Date: 08/30/2011 07:45:00 ******/
set ansi_nulls on
go

set quoted_identifier on
go


/***********************************************************************************************************************

	SP for rebuilding, reorging indexes and updating statistics
	
	SQL 2005 or greater

		VERSION HISTORY:
		Version 1.0
			19 Aug 2010

		Version 1.01
			Added fragmentation before -- Fragmentation after is too resource instensive, and should be close to zero
			31 Aug 2010

		Version 1.2
			Added UpdateStats option
			Added elapsed time on a database level
			Check for the existance of the index (to allow for dropped indexes that were dropped after the start of the SP)
				This allows to a maintenance window on a database where the index may no longer exist after the indexes for defragmentation were chosen
				Obviously some indexes can take a long time to rebuild/org, so there is the possibility that not all the chosen indexes remain in the
				databases at the time of execution
			Checks for read-only and off-line databases
			Checks for the database being principal in a mirror (mirror's can not change recovery model)
			Checks for 2005 or later -(90)- compatibility level (2000 compatibility DB's [on a 2005/2008 server] don't support the use of DMV's)
			Exclude TempDB and Model
			21 Sept 2010

		Version 1.21
			Resolved issue with blank DB Name -- I'm uncertain how @DBName is blank, but the SP no longer executes a statement that will error out.
				--It may be an issue with the cursor going past the last database
			Added page count to display the number of pages in the index
			Minor formatting changes
			21 Oct 2010

		Version 1.22
			Added @ExecAlter -- This flag will determine if the SP executes the statements or just prints them
			Resolved further issues with the blank @DBName returned in cursor
			29 Nov 2010

		Version 1.3
			Added option for updating stats only (no re-indexing)
			Added option for resampling stats
			Minor formatting changes
			Added check for database currently being restored
			Added database exclusion for upto three databases (the code can be modified to offer any number)
			Added verification that the database exists, is online, and is updatable for cases when *all* databases are being reindexed
			Displays total execution time for the entire SP; not just the individual components
			Created check for database name = 'all'
			Displays information concerning the details of the SP (create/modify)
			Added exclusion for msdb, DBAdmin, and AuditDB (now exclude all system DB's)
			25 Feb 2011

		Version 1.31
			Fixed bug with Enterprise Edition 64-bit
			15 Mar 2011 {The foreboding Ides of the month of March}

		Version 1.32
			Added Try/Catch to the execution of the rebuild/re-org
				*Catches indexes that cannot be built online (Only caught when executed, will not work for non-execution [@Exec = false] mode)
			Effective detection on BLOB
			25 Apr 2011

		Version 1.4
			Added catch for single_user databases, as the reindex SP is not guarenteed to be the single_user, therefore excluded
			Removed MSDB from exclusion
			Added date/time to alter index statement
			Fixed spelling error with @ParititionNum, now partitions (>= 2) execute
			Removed fillfactor for partitioned indexes, removed sort in TempDB, forced partitions to re-org
				'fillfactor' is not a recognized ALTER INDEX REBUILD PARTITION option.
			Added option for all database in simple recovery model
			Added Unhandled Error count
			Added @Wait
			02 Jun 2011

		Version 1.41
			Removed option for all database in simple recovery model
			Listed out all 80 or earlier compatibility databases
			15 Aug 2011

		Version 1.42
			Displays Handled Errors in addition to Unhandled Errors
			Uses IsGUID function to not defrag DB's with GUID's in name (errors in object name appear if a GUID is in the DB name)
				Requires the function IsGUID to run
				Function available at http://weblogs.sqlteam.com/mladenp/archive/2005/08/16/7545.aspx
				**Basically, if a DB name ends in a GUID (like many sharepoint related DB's), there is something in my
					logic that is causing both the Schema Name and the Object Name to be returned as null.  This problem
					does not appear to be releated to hyphens in the database name.  Yes, the errors are always hyphens,
					but I have tested by restore anothe database with several underscores and changing them to hyphens,
					the database defragged nicely with the hyphens and the underscores.  This problem seems solely related
					to damned GUIDs.  To hell with sharepoint!
			10 Oct 2011

		Version 1.43
			Fixed the cursor name typo that lists out SQL2000 databases
			08 Nov 2011

		Version 1.44
			Check for bracked DB Names in input parameters, SSMS 2012 adds brackets if db names are dragged/dropped
			07 Dec 2011

		Version 1.45
			Fixes Error 1943 -- "The index <Name> on table <Table> cannot be reorganized because page level locking is disabled."
				Results in ignoring index
			08 Dec 2011

		Version 1.46
			Asthetic Improvements
			10 May 2012

		Version 1.47
			Changed online rebuilds for SQL 2005 Developers Editions (not a supported feature)
			29 May 2012

		Version 1.48
			Added handling for errors:
				9002: The transaction log for database 'XXX' is full.
				1101: Could not allocate a new page for database 'XXX' because of insufficient disk space in filegroup 'XXX'.
			26 Jul 2012

		Version 1.49
			Fixed GUID error (sort of, at least got the SP to skip the GUID DB and move on to the next DB)
			Trapped for error:
				1088: Cannot find the object "SharePoint_AdminContent_462fed6b-f17c-4d00-8c46-b1d01a728fae.dbo.sysssislog" because it does not exist or you do not have permissions.
			Commented out section of code dealing with GUID's
			07 Aug 2012

		Version 1.50
			Added handling for columnstore indexes (error 35352), columnstore indexes are new to SQL 2012.  This error handling
				does not effect functionality with SQL 2005/2008.  If a table contains a columnstore index at all, no online
				operations may be performed on any other index on the table, therefore, online must be set to off.
			15 Aug 2012

		Version 1.51
			Fixed error where if database name had a space in it the SP would ungracefully exit with an error.  DB Names should not have spaces, that's what underscores are for, but some apparently do have spaces.
			Included print @ErrorTxt for DB's that are offline, read-only, single user.  This should have been printed before, oversight on my part.
			Checked to see if cursor's are open.
			21 Aug 2012

		Gregory Ferdinandsen
		greg@ferdinandsen.com
		gregory.ferdinandsen@recall.com

		Parameters:
			@DB = Either 'All' or the name of a single DB.  If 'All' all databases on the server are examined; otherwise the name of a single DB.
			@Exclude = One databases to exclude; by default master, model, and TempDB are already excluded.  Default is NULL.
				Primarily used in conjunction with all for @DB.  Supports one database.
			@Exclude2 = One databases to exclude; by default master, model, and TempDB are already excluded.  Default is NULL.
				Primarily used in conjunction with all for @DB.  Supports one database.
			@Exclude3 = One databases to exclude; by default master, model, and TempDB are already excluded.  Default is NULL.
				Primarily used in conjunction with all for @DB.  Supports one database.
				***NB: For @Exlude[n], this does *not* have to be a valid database name and there are no checks to indicate that the database does not exist
			@Stats = Statistical Sampling Method (Limited, Sampled, or Detailed) for determining what index will be impacted.
				--LIMITED - It is the fastest mode and scans the smallest number of pages. 
						For an index, only the parent-level pages of the B-tree (that is, the pages above the leaf level) are scanned
				--SAMPLED - It returns statistics based on a 1 percent sample of all the pages in the index or heap. 
						If the index or heap has fewer than 10,000 pages, DETAILED mode is used instead of SAMPLED.
				--DETAILED - It scans all pages and returns all statistics.
			@MinPageCount = Since index with few pages usually don't defrag (and a table scan is preferred), ignores small indexes
			@MaxPageCount = Maximum number of index pages to be considered.  This can preclude very large indexes
			@Fill Factor = Specifies a percentage that indicates how full the Database Engine should make the leaf level of each index page 
				during index creation or alteration. fillfactor must be an integer value from 1 to 100. The default is 0.
			@PAD_Index = The percentage of free space that is specified by FILLFACTOR is applied to the intermediate-level pages of the index. 
				If FILLFACTOR is not specified at the same time PAD_INDEX is set to ON, the fill factor value stored in sys.indexes is used.
			@SortInTempDB = The intermediate sort results that are used to build the index are stored in tempdb. 
				If tempdb is on a different set of disks than the user database, this may reduce the time needed to create an index. 
				However, this increases the amount of disk space that is used during the index build.
			@OnlineReq = Online rebuild (sometimes slower), for editions that support online rebuild (for editions that do not support online rebuild, this is ignored)
			@ReBuildTheshold = The threshold for deciding to rebuild v reorg (MSFT recommend's 30)
			@ReOrgThreshold = The threshold for deciding to rebuild v reorg (MSFT recommend's 5)
			@MaxFrag = The maximum amount of fragmentation to defrag (i.e. if you don't want to defrag an index over 80%)
			@ChangeRecoveryModel = Set's the DB's in simple recovery mode prior to starting, reverts back to original mode on completion.
				NB: Is ignored if @ExecAlter = 'false'
			@UpdateStats = Will update statistics for DB where needed
			@ResampleStats = Determines if stats will be resampled
			@UpdateStatsOnly = Will not alter indexes, will just update stats.  The only other parameters that are used is @DB and @ExecAlter;
				however, all other parameters are parsed for validity, even though they are not in use.
			@Wait = Wait time (in seconds) between alter index statements; allows the server and tran logs to catch up
			@ExecAlter = Will execute the alter statement statement and/or update stats SP -- similar to debug mode

			NB:
			@Fill_Factor, @PAD_Index will only be applied to index that are rebuilt (Fragmentation >= @ReBuildTheshold)
			***There is a possible issue with database names containing GUID's***

			Unfortunatly, I would prefer to simply have one @Exclude, but creating the dynamic SQL would cause more errors than the added
				functionality would enhance.

			It is recommended that as part of a job, you create an appended text file output for this SP.  It provides detailed information
				and is useful in troubleshooting any bugs.  The @WHiteSpace that is appended for most output is designed to hide
				the "[SQLSTATE 01000]" that appears at the end of all lines of text outputs of SQL Server Agent Jobs.


			Alter Index -- http://technet.microsoft.com/en-us/library/ms188388.aspx
			sys.dm_db_index_physical_stats -- http://msdn.microsoft.com/en-us/library/ms188917.aspx
			sp_updatestats -- http://msdn.microsoft.com/en-us/library/ms173804.aspx

		examples:
			Simple Execution (All default parameters; ie all databases, default thresholds, etc):
				exec DBMonitor..sp_Defrag_Indexes

			More Complex Exections:
				exec DBMonitor..sp_Defrag_Indexes @FillFactor = 75, @Stats = 'Detailed'

			exec DBMonitor..sp_Defrag_Indexes
				@DB = 'sysutility_mdw',
				@Stats = 'Sampled',
				@MinPageCount = 150,
				@FillFactor = 65,
				@PAD_Index = 'true',
				@SortInTempDB = 'true',
				@OnlineReq = 'true',
				@ReBuildTheshold = 25,
				@ReOrgThreshold = 5,
				@ExecAlter = 'true'

			Execution Specifying most Parameters:
				exec DBMonitor..sp_Defrag_Indexes
					@DB = 'changepoint',
					@Exclude = 'sysutility_mdw',
					@Exclude2 = 'msdb',
					@Exclude3 = 'ZZZ',
					@Stats = 'Sampled',
					@MinPageCount = 150,
					@FillFactor = 65,
					@PAD_Index = 'true',
					@SortInTempDB = 'true',
					@OnlineReq = 'true',
					@ReBuildTheshold = 25,
					@ReOrgThreshold = 5,
					@ChangeRecoveryModel = 'false',
					@UpdateStats = 'false',
					@ResampleStats = 'true',
					@UpdateStatsOnly = 'false',
					@Wait = 0,
					@ExecAlter = 'true'
***********************************************************************************************************************/

create procedure [dbo].[sp_Defrag_Indexes]
	(
	@DB varchar(256) = 'all',
	@Exclude varchar(256) = NULL,
	@Exclude2 varchar(256) = NULL,
	@Exclude3 varchar(256) = NULL,
	@Stats varchar(8) = 'sampled',
	@MinPageCount int = 24, --As a general rule, indexes with less than 24 pages are rarely used, SQL usually performs a table scan in that case.  This can be checked by looking at the query plan.
	@MaxPageCount float = 1000000000000000, --A very large default number (few index would be this large, therefore we can think of this as approaching infinity)
	@FillFactor int = NULL, --null defaults to what the index was originally built with
	@PAD_Index varchar(8) = 'true',
	@SortInTempDB varchar(8) = 'true',
	@OnlineReq varchar(8) = 'true',
	@ReBuildTheshold real = 30.0, --MSFT recommendation
	@ReOrgThreshold real = 5.0, --MSFT recommendation
	@MaxFrag real = 100.0,
	@ChangeRecoveryModel varchar(8) = 'false',
	@UpdateStats varchar(8) = 'false',
	@ResampleStats varchar(8) = 'false',
	@UpdateStatsOnly varchar(8) = 'false',
	@Wait int = 0,
	@ExecAlter varchar(8) = 'true' --If set to false, there will be no executions on the DB, it will just print out what should be executed
	)

	as

	declare @SQLCmd as varchar (8000)
	declare @SQLCmdBk as varchar(4096)
	declare @SQLCmdWith as varchar(4096)
	declare @SQLCmdFill as varchar(1024)
	declare @SQLCmdOnline as varchar(1024)
	declare @SQLCmdPad as varchar(1024)
	declare @SQLCmdSort as varchar(1024)
	declare @SQLCmdRecovery as varchar(2048)
	declare @SQLCmdStats as varchar(1024)
	declare @SQLCmdExist as nvarchar(2048)
	declare @exit as varchar(8)
	declare @PrintExclude as varchar(2048)
	declare @ErrorTxt as varchar(128)
	declare @SQLEdition as varchar(64)
	declare @SQLVersion as varchar(128)
	declare @Online as varchar(8)
	declare @RestoringStatus as varchar(64)
	declare @DBName as varchar(512)
	declare @ObjectID as int
	declare @IndexID as int
	declare @PartitionNum as bigint
	declare @Frag as float
	declare @FragOld as float
	declare @FragTxt as varchar(2048)
	declare @PageCount as bigint
	declare @PartitionCount as bigint
	declare @ParititionNum as bigint
	declare @IndexName as varchar(256)
	declare @SchemaName as varchar(256)
	declare @ObjectName as varchar(256)
	declare @ParmDef as nvarchar(1024)
	declare @SQLCmdID as nvarchar(2048)
	declare @RecoveryModel as varchar(16)
	declare @IndexNameExists as varchar (256)
	declare @PDExist as nvarchar(1024)
	declare @IndexExists as nvarchar(256)
	declare @Start as datetime
	declare @Finish as datetime
	declare @Total as varchar(64)
	declare @RO as varchar(256)
	declare @CompatibilityLevel as varchar(64)
	declare @Mirrored as varchar(8)
	declare @SingleUser as varchar(32)
	declare @TotalIndexes as int
	declare @DBStatus as varchar(128)
	declare @StartTimeIndex as datetime
	declare @FinishTimeIndex as datetime
	declare @TotalTimeIndex as varchar(64)
	declare @StartTimeStats as datetime
	declare @FinishTimeStats as datetime
	declare @TotalTimeStats as varchar(64)
	declare @StartTimeJob as datetime
	declare @FinishTimeJob as datetime
	declare @TotalTimeJob as varchar(64)
	declare @TotalTimeJobFormatted as varchar(32)
	declare @DBNameError as varchar(8)
	declare @SPName as varchar(256)
	declare @SPMod as datetime
	declare @SPCreate as datetime
	declare @SvrName as varchar(512)
	declare @Alloc_Unit as varchar(128)
	declare @CatchErrTxt as varchar(512)
	declare @HandledError as int
	declare @UnhandledErrors as int
	declare @WhiteSpace as varchar(128)
	declare @WaitFormatted as varchar(16)
	declare @Listof2000DBs as varchar(2048)
	declare @DBName2000 as varchar(256)
	declare @DBNameGUID as varchar(512)
	declare @CurStatus as smallint

	--Get the start time of the job
	set @UnhandledErrors = 0
	set @HandledError = 0
	set @SvrName = @@servername
	set @StartTimeJob = getdate()
	set @WhiteSpace = '																			'

	--Check that SSMS did not bracket DB Names, common in SSMS 2012 if you drag and drop DB Names
	if left(@DB, 1) = '[' and right(@db, 1) = ']' set @DB = substring(@DB, 2, (len(@DB) -1))

	--Check that cursor's are not left open from a previous interupted run
	/*************************************************************************************************************
				http://msdn.microsoft.com/en-us/library/ms177609.aspx
				@CurStatus results
				1 = Open
				0 = Open but but empty
				-1 = Cursor is closed
				-2 = N/A
				-3 = Does Not Exist
	*************************************************************************************************************/
	set @CurStatus = cursor_status('global', 'DatabaseNames')
	if @CurStatus in (0, 1)
		begin
			close DatabaseNames
			deallocate DatabaseNames
		end

	set @CurStatus = cursor_status('global', 'DatabaseName80')
	if @CurStatus in (0, 1)
		begin
			close DatabaseName80
			deallocate DatabaseName80
		end

	if left(@Exclude, 1) = '[' and right(@Exclude, 1) = ']' set @Exclude = substring(@Exclude, 2, (len(@Exclude) -1))
	if left(@Exclude2, 1) = '[' and right(@Exclude2, 1) = ']' set @Exclude2 = substring(@Exclude2, 2, (len(@Exclude2) -1))
	if left(@Exclude3, 1) = '[' and right(@Exclude3, 1) = ']' set @Exclude3 = substring(@Exclude3, 2, (len(@Exclude3) -1))

	--Check for the off-chance possibility that a database name is 'all'.  If a database exists named 'all', then exit SP
	if @DB = 'all'
		begin
			if exists (select name from sys.databases where name = @DB)
				begin
					print 'A database exists with the name "all"; this SP is designed with tha @DB parameter to specify either a single database name or "all".'
					print @WhiteSpace
					print 'Where "all" would represent every database in the system catalogue.  This SP cannot execute if a database in sys.databases is named "all".'
					print @WhiteSpace
					print 'You will need to modify the SP code and choose a replacement for term "all".'
					print '		e.g., do a find and replace on "all" with "-all-" or another suitable term.'
					print @WhiteSpace
					print 'Further execution of this SP has been halted.'
					print @WhiteSpace
					set @ErrorTxt = 'Database named "all".  Execution of SP halted.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end
		end

	--Verify that proper parameters were passed to SP
	if lower(@Stats) not in ('limited', 'sampled', 'detailed')
		begin
			RaisError ('@Stats must be "limited", "sampled", or "detailed".', 16, 1)
			return
		end

	if lower(@PAD_Index) not in ('true', 'false')
		begin
			RaisError ('@PAD_Index must be "true" or "false".', 16, 1)
			return
		end

	if lower(@SortInTempDB) not in ('true', 'false')
		begin
			RaisError ('@SortInTempDB must be "true" or "false".', 16, 1)
			return
		end

	if lower(@OnlineReq) not in ('true', 'false')
		begin
			RaisError ('@OnlineReq must be "true" or "false".', 16, 1)
			return
		end

	if lower(@ExecAlter) not in ('true', 'false')
		begin
			RaisError ('@ExecAlter must be "true" or "false".', 16, 1)
			return
		end

	if lower(@ResampleStats) not in ('true', 'false')
		begin
			RaisError ('@ResampleStats must be "true" or "false".', 16, 1)
			return
		end

	if lower(@UpdateStatsOnly) not in ('true', 'false')
		begin
			RaisError ('@UpdateStatsOnly must be "true" or "false".', 16, 1)
			return
		end

	if @FillFactor not between 1 and 100
		begin
			RaisError ('@FillFactor must be between 1 and 100.', 16, 1)
			return
		end

	if @ReBuildTheshold not between 1 and 99.999
		begin
			RaisError ('@ReBuildTheshold must be between 1 and 99.999.', 16, 1)
			return
		end

	if @ReOrgThreshold not between .1 and 99.5
		begin
			RaisError ('@ReOrgThreshold must be between .1 and 99.5.', 16, 1)
			return
		end

	--You can't have rebuild be at a lower level than reorg
	if @ReBuildTheshold <= @ReOrgThreshold set @ReOrgThreshold = @ReBuildTheshold - 0.01

	--There would be nothing returned if MaxFrag was less than the reorg threshold.
	if @MaxFrag not between @ReOrgThreshold and 100
		begin
			RaisError ('@MaxFrag must be between the @ReOrgThreshold value (default of 5) and 100.', 16, 1)
			return
		end

	if @MinPageCount < 1
		begin
			RaisError ('@MinPageCount must be positive.', 16, 1)
			return
		end

	if @MaxPageCount < 10
		begin
			RaisError ('@MaxPageCount must be greater than 10.', 16, 1)
			return
		end

	if lower(@ChangeRecoveryModel) not in ('true', 'false')
		begin
			RaisError ('@ChangeRecoveryModel must be "true" or "false".', 16, 1)
			return
		end

	if lower(@UpdateStats) not in ('true', 'false')
		begin
			RaisError ('@UpdateStats must be in "true" or "false".', 16, 1)
			return
		end

	if @MinPageCount >= @MaxPageCount
		begin
			RaisError ('@MinPageCount cannot be greater than @MaxPageCount.', 16, 1)
			return
		end

	if ((@Wait > 59) or (@Wait < 0))
		begin
			RaisError ('@Wait must be between 0 and 59 [seconds].', 16, 1)
			return
		end

	--Format the waitfor into proper SQL format [hh:mm:ss]
	if @Wait <= 9 set @WaitFormatted = '00:00:0' + cast(@Wait as varchar)
		else set @WaitFormatted = '00:00:' + cast(@Wait as varchar)

	if @UpdateStatsOnly = 'true' set @UpdateStats = 'true'

	--Do not change recovery model unless actually running
	if @ExecAlter = 'false' set @ChangeRecoveryModel = 'false'

	--Pull list of databases in 2000 (80) compatability mode
	if @DB = 'all'
		begin
			set concat_null_yields_null off
			declare DatabaseName80 cursor
				for select name from sys.databases
					where compatibility_level < 90
					order by name

				open DatabaseName80
				fetch next from DatabaseName80 into @DBName2000

				while @@fetch_status <> -1
					begin
						set @Listof2000DBs = @Listof2000DBs + ', ' + @DBName2000
						fetch next from DatabaseName80 into @DBName2000
					end --DatabaseNames80 [Cursor]
			close DatabaseName80
			deallocate DatabaseName80

			if right(@Listof2000DBs, 1) = ','
				set @Listof2000DBs = left(@Listof2000DBs, len(@Listof2000DBs) - 1)
			if @Listof2000DBs is null set @Listof2000DBs = 'N/A'
		else set @Listof2000DBs = 'N/A'
		end

/*********************************************************************************************************************

	Make checks for individual databases (Valid Name, On-Line, not Read-Only, 2005 or Later Compatibility Level)
	NB: these check only apply if the database name is specified; it does not apply to all database.
		When all databases are selected into the cursor, it only selects those which meet this criteria

*********************************************************************************************************************/
	if lower(@DB) <> 'all'
		begin
			if not exists (select name from sys.databases where name = @DB)
				begin
					set @ErrorTxt = 'The supplied database (' + @DB + ') does not exist.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end

			--DB has been verified to exist; now make sure it's able to be defragged
			--Granted the restoring check is redundant since the SP checks for ONLINE; however, during one job execution it failed because the DB was restoring
			set @SingleUser = lower(cast(DatabasePropertyEx(@DB, 'UserAccess') as varchar(128)))
			set @RO = lower(cast(DatabasePropertyEx(@DB, 'Updateability') as varchar(128)))
			set @DBStatus = lower(cast(DatabasePropertyEx(@DB, 'Status') as varchar(128)))
			set @RestoringStatus = lower(cast(DatabasePropertyEx(@DB, 'Status') as varchar(128)))
			select @CompatibilityLevel = compatibility_level from sys.databases where name = @DB

			if @SingleUser = 'single_user'
				begin
					set @ErrorTxt = 'Database ' + @DB + ' is Single User Mode only.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end

			if @DBStatus <> 'online'
				begin
					set @ErrorTxt = 'Database ' + @DB + ' is not online.  The database is currently ' + @DBStatus + '.  No operations can be performed.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end

			if @RO = 'read_only'
				begin
					set @ErrorTxt = 'Database ' + @DB + ' is read only.  No operations can be performed.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end

			if @CompatibilityLevel < 90
				begin
					set @ErrorTxt = 'Database ' + @DB + ' is in an older compatibility mode and is not compatibile with this SP.  ' +
						'Compatibility Level = ' + @CompatibilityLevel
					RaisError (@ErrorTxt, 16, 1)
					return
				end

			if lower(@RestoringStatus) = 'restoring'
				begin
					set @ErrorTxt = 'Database ' + @DB + ' is currently being restored.  Reindexing will be aborted.'
					RaisError (@ErrorTxt, 16, 1)
					return
				end
		end --lower(@DB) <> 'all'

	--Determine SQL Edition (for online rebuild -- Data Center, Enterprise, and Developer support online rebuild)
	set @SQLEdition = cast(ServerProperty('Edition') as varchar)
	set @SQLEdition =
		case
			when left(@SQLEdition, 11) = 'Data Center' then 'Data Center'
			when left(@SQLEdition, 10) = 'Enterprise' then 'Enterprise'
			when left(@SQLEdition, 9) = 'Developer' then 'Developer'
			when left(@SQLEdition, 8) = 'Standard' then 'Standard'
		end

	set @SQLVersion = cast(ServerProperty('ProductVersion') as varchar)
	set @SQLVersion =
		case
			when left(@SQLVersion, 2) = '11' then '2012'
			when left(@SQLVersion, 2) = '10' then '2008'
			when left(@SQLVersion, 1) = '9' then '2005'
			when left(@SQLVersion, 1) = '8' then '2000'
		end

	--This variable only indicates that the edition supports online rebuilds, not that the rebuild will necessarily be done online
	if @SQLEdition in ('Data Center', 'Enterprise', 'Developer')
		begin
			set @Online = 'true'
		end
	else set @Online = 'false'

	--SQL 2005 Developers Edition does not support on-line rebuilds
	if @SQLEdition = 'Developer' and @SQLVersion = '2005'
		begin
			set @Online = 'false'
		end

	--Text to display for the output showing what database(s) is/are excluded
	set concat_null_yields_null off
	if @Exclude is not null and @Exclude2 is not null and @Exclude3 is not null set @PrintExclude = @Exclude + ', ' + @Exclude2 + ', ' + @Exclude3
	if @Exclude is not null and @Exclude2 is not null and @Exclude3 is null set @PrintExclude = @Exclude + ', ' + @Exclude2
	if @Exclude is not null and @Exclude2 is null and @Exclude3 is null set @PrintExclude = @Exclude
	if @Exclude is null and @Exclude2 is null and @Exclude3 is null set @PrintExclude = 'None Selected'
	if @DB <> 'all' set @PrintExclude = 'N/A'

/*********************************************************************************************************************

	If only one db is specified, make sure that it is not excluded
	If blank spaces are put in @Exclude, simply set to junk name (eg, change @DB to ZZZ); if no parameter is passed, set a value
	There is no need for this to be a valid database name.  Since the select is encapsulated within a NOT IN statement, it won't return anything
		i.e. a database name that does not exist, it won't be the results of the select statement, hence the not in

*********************************************************************************************************************/

	if @DB <> 'all'
		begin
			if ((@Exclude = @DB) or (@Exclude2 = @DB) or (@Exclude3 = @DB))
				begin
					set @ErrorTxt = 'You can not exclude the only database to have operations performed upon it'
					RaisError (@ErrorTxt, 16, 1)
					return
				end
		end

	if @Exclude is not null
		begin
			if len(ltrim(rtrim(@Exclude))) = 0 set @Exclude = 'ZZZ'
		end
	else set @Exclude = 'OldZZZ'

	if @Exclude2 is not null
		begin
			if len(ltrim(rtrim(@Exclude2))) = 0 set @Exclude2 = 'ZZZ'
		end
	else set @Exclude2 = 'OldZZZ'

	if @Exclude3 is not null
		begin
			if len(ltrim(rtrim(@Exclude3))) = 0 set @Exclude3 = 'ZZZ'
		end
	else set @Exclude3 = 'OldZZZ'

	--Determine SP information
	set @SPName = object_name(@@procid)
	select @SPCreate = create_date from sys.objects where name = @SPName
	select @SPMod = modify_date from sys.objects where name = @SPName

/*********************************************************************************************************************

	Since I set up the job to run this SP with output to a text file (appended) it is very helpful to have
	large sections replete with formatted spacing to indicate the start of various functions:
				1: Start of the job with datetime
				2: Name of the database on which the operation is being performed
				3: Updating indexes
				4: Updating stats
				5: Completion of the SP (hence completion of the job) with datetime

*********************************************************************************************************************/
	print '¤¤¤¤																												 '
	print '¤¤¤¤¤¤¤¤¤¤¤¤																										 '
	print '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤																						 '
	print '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤																	 '
	print '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
	print '******************************************************************************************************************'
	print '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
	print @WhiteSpace
	print @WhiteSpace
	print '										Indexing/Stats Job For: ' + cast(getdate() as varchar) + @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
	print '******************************************************************************************************************'
	print '°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°'
	print '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤																	 '
	print '¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤																						 '
	print '¤¤¤¤¤¤¤¤¤¤¤¤																										 '
	print '¤¤¤¤																												 '
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace

	--For scheduled jobs, show the options that the SP was executed with (NB: only useful if outputed to a text file)
		--Not all options are printed, just the major choices (some are self evident in the print of the alter index statements)
	print 'Options:' + @WhiteSpace
	print '   Server: ' + lower(@SvrName) + @WhiteSpace
	print '   SP Name: ' + lower(@SPName) + @WhiteSpace
	print '   SP Create Date: ' + cast(@SPCreate as varchar(32)) + @WhiteSpace
	print '   SP Modify Date: ' + cast(@SPMod as varchar(32)) + @WhiteSpace
	print @WhiteSpace
	print '   Database(s): ' + lower(@DB) + @WhiteSpace
	print '   Exclude Database(s): ' + @PrintExclude + @WhiteSpace
	print '   Excluding Version 80/2000 or Earlier Databases: ' + @Listof2000DBs + @WhiteSpace
	print '   Stats Level (Index): ' + @Stats + @WhiteSpace
	print '   Min Index Pages: ' + cast(@MinPageCount as varchar(32)) + @WhiteSpace
	print '   ReOrg Threshold: ' + cast(@ReOrgThreshold as varchar(8)) + @WhiteSpace
	print '   ReBuild Threshold: ' + cast(@ReBuildTheshold as varchar(8)) + @WhiteSpace
	print '   Change Recovery Model: ' + lower(@ChangeRecoveryModel) + @WhiteSpace
	print '   SQL Edition: SQL' + @SQLVersion + ' ' + @SQLEdition + ' Edition ' + @WhiteSpace
	print '   Online Operation: ' + lower(@OnlineReq) + @WhiteSpace
	print '   Update Statistics: ' + lower(@UpdateStats) + @WhiteSpace
	print '   Resample Statistics: ' + lower(@ResampleStats) + @WhiteSpace
	print '   Update Statistics Only (no index rebuilds): ' + lower(@UpdateStatsOnly) + @WhiteSpace
	print @WhiteSpace
	print '   Exec Alter (debug): ' + lower(@ExecAlter) + @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print '										Begin Operations on Database(s)' + @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace

	--If only one database, then go to the inner cursor (The Index Cursor) then exit that cursor before without executing the fetch next command
	set @Exit = 'false'
	If @DB <> 'All'
		begin
			set @Exit = 'true'
			set @DBName = @DB
			goto ExecuteForEachDatabase
		end

	/*********************************************************************************************************************

															Outer Cursor [for DBName]

	*********************************************************************************************************************/
	--By default we exclude system db's, single_user, offline, etc...
	declare DatabaseNames cursor
		for select name from sys.databases
			where state_desc = 'ONLINE' and is_read_only = 0 and compatibility_level >= 90 and state = 0 
				and user_access_desc <> 'SINGLE_USER'
				and name not in ('TempDB', 'Model', 'Master', @Exclude, @Exclude2, @Exclude3)
				--and recovery_model_desc in ('Simple', @RecoveryModelDescTemp, @RecoveryModelDescTemp2)
			order by name

		open DatabaseNames
		fetch next from DatabaseNames into @DBName

		while @@fetch_status <> -1
			begin
ExecuteForEachDatabase:
				print '//////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\'
				print @WhiteSpace
				print '											' + @DBName + @WhiteSpace
				print @WhiteSpace
				print '\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////////////////////'

				set @Start = getdate()
				set @StartTimeIndex = @Start

				/*****************************************************************************************

						Check that the database does not end in a GUID

						If the DBName end's in a GUID, abort processing on that database
							I hope to figure out why I cannot process databases ending in GUID's, this is just a work-around.
							I can find no rhyme nor reason for this problem, hyphens alone cannot explain it; it simply has
							something to do with databases ending in GUIDs


						ERROR:
							Msg 102, Level 15, State 1, Line 1
							Incorrect syntax near '-'.

						***The function IsGUID must exist for this section of code to properly execute***
						Function available at http://weblogs.sqlteam.com/mladenp/archive/2005/08/16/7545.aspx

				*****************************************************************************************/
				if len(@DBName) >= 38
					begin
						set @DBNameGUID = right(@DBName, 36)
						if ((dbo.IsGUID(@DBNameGUID) = 1) and (@DB = 'all'))
							begin
								set @HandledError = @HandledError + 1

								print '' + @WhiteSpace
								print '' + @WhiteSpace
								print '' + @WhiteSpace
								print '' + @WhiteSpace
								print 'ERROR: ' + @WhiteSpace
								print '		Cannot defragment databases ending in GUIDs.' + @WhiteSpace
								print '		Continuing to next database...' + @WhiteSpace
								print '' + @WhiteSpace
								goto NextDB
							end
							else if ((dbo.IsGUID(@DBNameGUID) = 1) and (@DB <> 'all'))
								begin
									set @HandledError = @HandledError + 1

									print '' + @WhiteSpace
									print '' + @WhiteSpace
									print '' + @WhiteSpace
									print '' + @WhiteSpace
									print 'ERROR: ' + @WhiteSpace
									print '		The Database Name contains an invalid set of characters (GUID at end of DB Name).' + @WhiteSpace
									print '		Aborting defragmentation process...' + @WhiteSpace
									print '' + @WhiteSpace
									goto Finish
								end
					end

				--Check for the existance of the #tmpTable, if it exists, then delete the #tmpTable (In case the SP exited ugly w/out deleting the table)
				if exists (select * from tempdb.sys.objects where name = '#Fragmentation' and type in('U'))
					begin
						drop table #Fragmentation
					end

				--Determine Mirrored Status, Recovery Model (If DB is mirrored, recovery model cannot be changed)
				set @Mirrored = 'false'
				if exists (select db_id(@DBName) from sys.database_mirroring where mirroring_state is not null) set @Mirrored = 'true'
					else set @Mirrored = 'false'

				set @RecoveryModel = cast(DatabasePropertyEx(@DBName, 'Recovery') as varchar(16))
				if upper(@RecoveryModel) in ('FULL', 'BULK_LOGGED') and @ChangeRecoveryModel = 'true' and @Mirrored = 'false'
					begin
						set @SQLCmdRecovery = 'alter database ' + quotename(@DBName) + ' set recovery SIMPLE with no_wait'
						print @DBName + ' recovery model set to simple. -- {' + @SQLCmdRecovery + '}'
						exec (@SQLCmdRecovery)
					end

				if upper(@RecoveryModel) in ('FULL', 'BULK_LOGGED') and @ChangeRecoveryModel = 'true' and @Mirrored = 'true'
					begin
						print 'The database ' + @DBName + ' is currently mirrored, changing the recovery model is not supported.'
						print 'Reindex will continue without changing recovery model...'
						print @WhiteSpace
					end

				/*********************************************************************************************************************

					Check to see that the DB is online (Read Only, Single User).
						When the databases were inserted into the cursor, that is a static view at that point in time.
						A database that may have been online at 1:45AM, may be offline by 4:15AM.
						Since the cursor sequentially goes through each database, and some databases may take an hour to run, verify that the current DB is still good.
						At the same time, check to make sure it was not dropped.

				*********************************************************************************************************************/
				set @DBStatus = lower(cast(DatabasePropertyEx(@DBName, 'Status') as varchar(128)))
				set @RO = lower(cast(DatabasePropertyEx(@DBName, 'Updateability') as varchar(128)))
				set @SingleUser = lower(cast(DatabasePropertyEx(@DBName, 'UserAccess') as varchar(128)))

				if lower(@DBStatus) <> 'online'
					begin
						set @ErrorTxt = 'Database ' + @DBName + ' is not online.  The database is currently ' + @DBStatus + '.  No operations can be performed.                           '
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						print 'Continuing on to next database...' + @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						goto NextDB
					end

				if @RO = 'read_only'
					begin
						set @ErrorTxt = 'Database ' + @DBName + ' is read only.  No operations can be performed.' + @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						print 'Continuing on to next database...' + @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						goto NextDB
					end

				if @SingleUser = 'single_user'
					begin
						set @ErrorTxt = 'Database ' + @DBName + ' is in Single User only mode.  No operations can be performed.' + @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						print 'Continuing on to next database...' + @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						goto NextDB
					end

				--Verify that selected DB still exists/that it has not been dropped/renamed/etc...
				if not exists (select name from sys.databases where name = @DBName)
					begin
						set @ErrorTxt = 'Database ' + @DBName + ' no longer exists.' + @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						print 'Continuing on to next database...' + @WhiteSpace
						print @ErrorTxt + @WhiteSpace
						goto NextDB
					end

				--if only updating stats and not altering indexes, go directly to the stats portions of the code
				if @UpdateStatsOnly = 'true' goto UpdateStatsOnly

				--index_ID of 0 is a heap index, no need to defrag
				--index_type_desc should be clustered/non-clustered
				select object_id as ObjectID, index_id as IndexID, partition_number as PartitionNum, avg_fragmentation_in_percent as Frag, page_count as Pages, alloc_unit_type_desc
					into #Fragmentation
					from sys.dm_db_index_physical_stats (db_id(@DBName), null, null , null, @Stats)
					where avg_fragmentation_in_percent >= @ReOrgThreshold and avg_fragmentation_in_percent <= @MaxFrag
						and index_id > 0 and Page_Count >= @MinPageCount and Page_Count <= @MaxPageCount
						--and index_type_desc in ('CLUSTERED INDEX', 'NONCLUSTERED INDEX')
						and avg_fragmentation_in_percent <> 0 and avg_fragmentation_in_percent is not null
						order by avg_fragmentation_in_percent desc

				select @TotalIndexes = count(*) from #Fragmentation
				print @WhiteSpace
				print 'Total indexes to be altered in ' + @DBName + ': ' + cast(@TotalIndexes as varchar) + @WhiteSpace
				print @WhiteSpace

				/*********************************************************************************************************************

															Inner Cursor [for Index Objects]

				*********************************************************************************************************************/
				declare curPartitions cursor
					for select * from #Fragmentation

					open curPartitions
					fetch next from curPartitions into @ObjectID, @IndexID, @ParititionNum, @Frag, @PageCount, @Alloc_Unit

					while @@fetch_status <> -1
						begin
							/*********************************************************************************************************************

													Display the select in a formatted way (commented out); it's difficult to read what
														is being done by the sp_executesql

							*********************************************************************************************************************/

							--select @ObjectName = quotename(obj.name), @SchemaName = quotename(sch.name)
							--	from sys.objects as obj
							--	join sys.schemas as sch on sch.schema_id = obj.schema_id
							--	where obj.object_id = @ObjectID
							set @SQLCmdID = 'select @ObjectName = quotename(obj.name), @SchemaName = quotename(sch.name) from ' + quotename(@DBName) + 
								'.sys.objects as obj join ' + quotename(@DBName) + '.sys.schemas as sch on sch.schema_id = obj.schema_id where obj.object_id = @ObjectID'
							set @ParmDef = N'@ObjectID int, @ObjectName sysname output, @SchemaName sysname output'
							begin try
								exec sp_executesql @SQLCmdID, @ParmDef, @ObjectID = @ObjectID, @ObjectName = @ObjectName output, @SchemaName = @SchemaName output
							end try

							begin catch
								print 'Error:' + @WhiteSpace
								print error_number() + @WhiteSpace
								print error_message() + @WhiteSpace
								print @WhiteSpace
							end catch

							--select @IndexName = quotename(name)
							--	from sys.indexes
							--	where object_id = @ObjectID and index_id = @IndexID
							set @SQLCmdID = 'select @IndexName = quotename(name) from ' + quotename(@DBName) + '.sys.indexes where object_id = @ObjectID and index_id = @IndexID'
							set @ParmDef = N'@ObjectId int, @IndexId int, @IndexName sysname output'
							begin try
								exec sp_executesql @SQLCmdID, @ParmDef, @ObjectId = @ObjectId, @IndexId = @IndexId, @IndexName = @IndexName output
							end try

							begin catch
								print 'Error:' + @WhiteSpace
								print error_number() + @WhiteSpace
								print error_message() + @WhiteSpace
								print @WhiteSpace
							end catch

							--select @PartitionCount = count (*)
							--	from sys.partitions
							--	where object_id = @ObjectID and index_id = @IndexID
							set @SQLCmdID = 'select @PartitionCount = count (*) from ' + quotename(@DBName) + '.sys.partitions where object_id = @ObjectID and index_id = @IndexID'
							set @ParmDef = N'@ObjectId int, @IndexId int, @PartitionCount int output'
							begin try
								exec sp_executesql @SQLCmdID, @ParmDef, @ObjectId = @ObjectId, @IndexId = @IndexId, @PartitionCount = @PartitionCount output
							end try

							begin catch
								print 'Error:' + @WhiteSpace
								print error_number() + @WhiteSpace
								print error_message() + @WhiteSpace
								print @WhiteSpace
							end catch

							--ReOrg/ReBuild Command
							if @frag < @ReBuildTheshold
								begin
									set @SQLCmdBk = 'alter index ' + @IndexName + ' on ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + ' reorganize'
								end
							if @frag >= @ReBuildTheshold
								begin
									set @SQLCmdBk = 'alter index ' + @IndexName + ' on ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + ' rebuild'
								end

							--set options (Partitions > 1 cannot have a fill factor, etc, therefore set all with statements to null)
							if @PartitionCount = 1
								begin
									if @FillFactor is not null set @SQLCmdFill = 'fillfactor = ' + cast(@FillFactor as varchar(3)) + ', '
									if ((@Online = 'true') and (@OnlineReq = 'true')) set @SQLCmdOnline = 'online = on, '
									if @PAD_Index = 'true' set @SQLCmdPad = 'PAD_Index = on, '
									if @SortInTempDB = 'true' set @SQLCmdSort = 'Sort_in_TempDB = on, '
								end
								else --Index is partitioned
									begin
										set @SQLCmdOnline = null
										set @SQLCmdFill = null
										set @SQLCmdPad = null
										set @SortInTempDB = null
									end

							if @PartitionCount > 1 set @SQLCmdBk = @SQLCmdBk + ' partition = ' + cast(@ParititionNum as varchar(10))

							set @SQLCmdWith = ' with ('

							--With options only apply to rebuilds, not to re-org
							if @frag >= @ReBuildTheshold
								begin
									if @SQLCmdFill is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdFill
									if @SQLCmdOnline is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdOnline
									if @SQLCmdPad is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdPad
									if @SQLCmdSort is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdSort
								end

							--The len - 1 is to get rid of any trailing commas that may exist (each component is created with a trailing comma, so it's assured that there is a trailing comma)
							if @SQLCmdWith <> ' with (' set @SQLCmdWith = left(@SQLCmdWith, len(@SQLCmdWith) - 1) + ')'
							if @SQLCmdWith <> ' with (' set @SQLCmd = @SQLCmdBk + @SQLCmdWith
							else set @SQLCmd = @SQLCmdBk

							--Determine old fragmentation levels and page count; it can be assumed that current fragmentation is close to zero
							set @FragOld = @Frag
							set @FragTxt = '       ---» Fragmentation had been: ' + cast(cast((cast((@FragOld * 100) as int)) as real) / 100 as varchar)
								 + '% <<--->> Index Page Count = ' + cast(@PageCount as varchar) + ' <<<----->>> @ ' + cast(getdate() as varchar) + @WhiteSpace

							/*********************************************************************************************************************

							Check to find out that index still exists (eliminates the possibility of dynamic index creation/dropped)
								This will also cover a CR executed during this time to drop/rename an object
								In very few cases, I have seen the DMV return a corrupt name, this should also eliminate that possibility

							*********************************************************************************************************************/
							--Get rid of the brackets :<-->: [IndexName] --> IndexName
							set @IndexNameExists = substring(@IndexName, 2, len(@IndexName) - 2)
							set @SQLCmdExist = N'select @IndexExists = name from ' + @DBName + '.sys.indexes where name = ''' + @IndexNameExists + ''''
							set @PDExist = N'@IndexExists varchar(128) output'
							exec sp_executesql @SQLCmdExist, @PDExist, @IndexExists output

							/*********************************************************************************************************************

							An issue exists where the db name is blank, it may be filled with unprintable characters, this will resolve the issue
								by going to the next database in the cursor.  Without this statement, SQL wil be unable to find the object.
								The exact causes of this condition are unknown, this is just a work-around until a proper resolution is found.
									NB: Do not modify the number of blank spaces, it needs to be 128/129

							*********************************************************************************************************************/
							if quotename(@DBName) = '[                                                                                                                                ]'
								begin
									print '--	*****ERROR: Database name is blank'
									drop table #Fragmentation
									close CurPartitions
									deallocate CurPartitions
									goto NextDB
								end

							/*********************************************************************************************************************

																			BEGIN INDEX OPERATION

								If the index is still there, then print and execute (catch statement should get all errors that have not yet been accounted for)
								NB: @IndexExists is the name of the Index (from sys.indexes), it should be greater than two characters
								NB: The catch statement only looks for indexes with LOB's in online mode, other errors are shown as unhandled
									As errors are encountered, specific handling should be written for the error

							*********************************************************************************************************************/
							if ((len(@IndexExists) > 2) or (len(ltrim(rtrim(@DBName))) = 0))
								begin
									print @SQLCmd + @FragTxt
									if @ExecAlter = 'true'
										begin try
											exec (@SQLCmd)
										end try

										begin catch
											--Index cannot be built online, so rebuild rebuild statement as offline
											if error_number() = 2725
												begin
													set @HandledError = @HandledError + 1
													print '--*****ERROR: cannot build online index for data type text, ntext, image, varchar(max), nvarchar(max), varbinary(max), xml, or large CLR type.' + @WhiteSpace
													print '--*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print '--*****Setting to offline rebuild for index ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													set @SQLCmdWith = ' with ('

													--With options only apply to rebuilds, not to re-org
													if @frag >= @ReBuildTheshold and @PartitionCount = 1
														begin
															if @SQLCmdFill is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdFill
															if @SQLCmdOnline is not null set @SQLCmdWith = @SQLCmdWith + 'online = off, '
															if @SQLCmdPad is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdPad
															if @SQLCmdSort is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdSort
														end
														else
															begin
																if @PartitionCount > 1
																	begin
																		set @SQLCmdOnline = null
																		set @SQLCmdFill = null
																		set @SQLCmdPad = null
																		set @SortInTempDB = null
																	end
															end

													--The len - 1 is to get rid of any trailing commas
													if @SQLCmdWith <> ' with (' set @SQLCmdWith = left(@SQLCmdWith, len(@SQLCmdWith) - 1) + ')'
													if @SQLCmdWith <> ' with (' set @SQLCmd = @SQLCmdBk + @SQLCmdWith
													else set @SQLCmd = @SQLCmdBk

													print @WhiteSpace
													print (@SQLCmd) + ' --*****ERROR RESOLVED (err: 2725)***** --> OFFLINE Operation Required' + @WhiteSpace
													exec (@SQLCmd)
												end --error 2725

											--ALTER INDEX failed because the following SET options have incorrect settings: 'CONCAT_NULL_YIELDS_NULL'.  Verify that SET options are correct for use with indexed views and/or indexes on computed columns and/or filtered indexes and/or query notifications and/or XML data type methods and/or spatial index operations.
											--See http://blogs.msdn.com/b/karthick_pk/archive/2009/03/20/error-1934-returned-when-you-run-update-statistics-from-a-job-against-table-that-has-index-on-computed-column.aspx
											if error_number() = 1934
												begin
													set @HandledError = @HandledError + 1
													set concat_null_yields_null on
													print '	--*****Handled Error Number 1934' + @WhiteSpace
													print ' --*****ERROR RESOLVED (err: 1934)***** --> "set set concat_null_yields_null on"' + @WhiteSpace
													print ' --*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print ' --*****Error Code: ' + @SQLCmd + @WhiteSpace
													print ' --*****Executing defrag operation with concat_null_yields_null set to on'
													print 'set concat_null_yields_null on'
													print @SQLCmd + @FragTxt
													print 'set concat_null_yields_null off'
													exec (@SQLCmd)
													set concat_null_yields_null off
												end --error 1934

											--The index "IX_FACT_ITEM_TRANSACTION_Add_Date_Id" on table "FACT_ITEM_TRANSACTION" cannot be reorganized because page level locking is disabled.
											if error_number() = 1943
												begin
													set @HandledError = @HandledError + 1
													print @WhiteSpace

													print '	--*****Handled Error Number 1943' + @WhiteSpace
													print ' --*****The index cannot be reorganized or rebuilt because page level locking is disabled.' + @WhiteSpace
													print ' --*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print ' --*****Error Code: ' + @SQLCmd + @WhiteSpace

													--Execute as a rebuild, not an alter; rebuilds do not have errors [no options for the sake of simplicity]
													set @SQLCmd = 'alter index ' + @IndexName + ' on ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + ' rebuild'
													exec (@SQLCmd)
													print @WhiteSpace
												end -- error 1943

											--Cannot find the object "SharePoint_AdminContent_462fed6b-f17c-4d00-8c46-b1d01a728fae.dbo.sysssislog" because it does not exist or you do not have permissions.
											if error_number() = 1088
												begin
													set @HandledError = @HandledError + 1
													print @WhiteSpace

													print '	--*****Handled Error Number 9002' + @WhiteSpace
													print '	--*****Error: ' + error_message() + @WhiteSpace
													print ' --*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print ' --*****Error Code: ' + @SQLCmd + @WhiteSpace
													print @WhiteSpace
												end --error 1088

											--The transaction log for database 'BOA' is full. To find out why space in the log cannot be reused, see the log_reuse_wait_desc column in sys.databases
											if error_number() = 9002
												begin
													set @HandledError = @HandledError + 1
													print @WhiteSpace

													print '	--*****Handled Error Number 9002' + @WhiteSpace
													print '	--*****Error: ' + error_message() + @WhiteSpace
													print ' --*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print ' --*****Error Code: ' + @SQLCmd + @WhiteSpace
													print @WhiteSpace
												end --error 9002

											--Could not allocate a new page for database 'BOA' because of insufficient disk space in filegroup 'PRIMARY'. Create the necessary space by dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup.
											if error_number() = 1101
												begin
													set @HandledError = @HandledError + 1
													print @WhiteSpace

													print '	--*****Handled Error Number 1101' + @WhiteSpace
													print '	--*****Error: ' + error_message() + @WhiteSpace
													print ' --*****Index Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print ' --*****Error Code: ' + @SQLCmd + @WhiteSpace
													print @WhiteSpace
												end --error 1101

											--alter statement failed because the operation cannot be performed online on a table with a columnstore index. Perform the operation without specifying the ONLINE option or drop (or disable) the columnstore index before performing the operation using the ONLINE option.
											if error_number() = 35352

												begin
													set @HandledError = @HandledError + 1
													print @WhiteSpace

													print '	--*****Handled Error Number 35352' + @WhiteSpace
													print '	--*****Error: ' + error_message() + @WhiteSpace
													print ' --*****Continuing with offline operation' + @WhiteSpace

													set @SQLCmdWith = ' with ('

													--With options only apply to rebuilds, not to re-org
													if @frag >= @ReBuildTheshold and @PartitionCount = 1
														begin
															if @SQLCmdFill is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdFill
															if @SQLCmdOnline is not null set @SQLCmdWith = @SQLCmdWith + 'online = off, '
															if @SQLCmdPad is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdPad
															if @SQLCmdSort is not null set @SQLCmdWith = @SQLCmdWith + @SQLCmdSort
														end
														else
															begin
																if @PartitionCount > 1
																	begin
																		set @SQLCmdOnline = null
																		set @SQLCmdFill = null
																		set @SQLCmdPad = null
																		set @SortInTempDB = null
																	end
															end

													--The len - 1 is to get rid of any trailing commas
													if @SQLCmdWith <> ' with (' set @SQLCmdWith = left(@SQLCmdWith, len(@SQLCmdWith) - 1) + ')'
													if @SQLCmdWith <> ' with (' set @SQLCmd = @SQLCmdBk + @SQLCmdWith
													else set @SQLCmd = @SQLCmdBk

													print @WhiteSpace
													print (@SQLCmd) + ' --*****ERROR RESOLVED (err: 35352)***** --> OFFLINE Operation Required' + @WhiteSpace
													exec (@SQLCmd)
												end --error 35352

											--Unhandled Errors
											if (error_number() not in (2725, 1934, 1943, 9002, 1101, 1088, 35352))
												begin
													set @UnhandledErrors = @UnhandledErrors + 1

													print @WhiteSpace
													print '--*****ERROR: Unhandled error in execution of index defrag*****'
													print '		--*****Error Number: ' + cast(error_number() as varchar)
													print '		--*****Error: ' + error_message() + @WhiteSpace
													print '		--*****Object Name: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + @WhiteSpace
													print '		--*****Error Code: ' + @SQLCmd + @WhiteSpace
													print @WhiteSpace
												end --error unspecified
										end catch
								end --Index name is valid
								else
									begin
										--Index name is not valid
										set @UnhandledErrors = @UnhandledErrors + 1
										print '--*****ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR*****'
										print 'Index Name Error: ' + quotename(@DBName) + '.' + @SchemaName + '.' + @ObjectName + '.' + @IndexName

										--Check for null or blank indexes
										if ((len(@SchemaName) = 0) and (len(@ObjectName) = 0)) or ((@SchemaName is null) and (@ObjectName is null))
											print '	Error: Index Name and Schema Name are both blank.'

										if @DBName = 'all' goto NextDB
										if @DBName <> 'all' goto Finish
									end

							waitfor delay @WaitFormatted
							fetch next from CurPartitions into @ObjectID, @IndexID, @ParititionNum, @Frag, @PageCount, @Alloc_Unit
						end --CurPartitions
					close curPartitions
					deallocate curPartitions
					drop table #Fragmentation

					set @FinishTimeIndex = getdate()
					set @TotalTimeIndex = datediff(second, @StartTimeIndex, @FinishTimeIndex)
					print ''

					--If DB was in Full or Bulk_Logged and t-logging was disabled, then re-enable
					if upper(@RecoveryModel) in ('FULL', 'BULK_LOGGED') and @ChangeRecoveryModel = 'true' and @Mirrored <> 'true'
						begin
							set @SQLCmdRecovery = 'alter database ' + quotename(@DBName) + ' set recovery ' + @RecoveryModel + ' with no_wait'
							print @DBName + ' recovery model set to ' + lower(@RecoveryModel) + '. -- {' + @SQLCmdRecovery + '}'
							exec (@SQLCmdRecovery)
						end

					--Update Statistics
UpdateStatsOnly:
					if @UpdateStats = 'true'
						begin
							set @StartTimeStats = getdate()
							set @SQLCmdStats = 'exec ' + quotename(@DBName) + '..sp_updatestats'

							if @ResampleStats = 'true'
								begin
									set @SQLCmdStats = @SQLCmdStats + ' @resample = ' + '''resample'''
								end

							print @WhiteSpace
							print '¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶'
							print '¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶'
							print @WhiteSpace
							print '											Updating Stats for ' + @DBName + @WhiteSpace
							print @WhiteSpace
							print '¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶'
							print '¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶'
							print @WhiteSpace
							print @SQLCmdStats
							print @WhiteSpace
							print @WhiteSpace
							if @ExecAlter = 'true' exec (@SQLCmdStats)
							print @WhiteSpace
							print @WhiteSpace
							set @FinishTimeStats = getdate()
							set @TotalTimeStats = datediff(second, @StartTimeStats, @FinishTimeStats)
						end

					--Display total elapsed time per database
					set @Finish = getdate()
					set @Total = datediff(second, @Start, @Finish)
					print @WhiteSpace
					print 'Total Time Elapsed For ' + @DBName + ' = ' + @Total + ' second(s) {' +
						 cast((@Total / 3600) as varchar(32)) + ' hour(s) ' + 
						cast((@Total %3600 / 60) as varchar(32)) + ' min(s) ' + 
						cast((@Total %60) as varchar(32)) + ' sec(s)}' +
						@WhiteSpace
					print @WhiteSpace
					print cast(getdate() as varchar) + @WhiteSpace
					print @WhiteSpace
					--If stats are updated, break down time by index and stats
					if @UpdateStats = 'true'
						begin
							print @WhiteSpace
							print 'Total Index Time = ' + @TotalTimeIndex + ' second(s)'
							print 'Total Stats Time = ' + @TotalTimeStats + ' second(s)'
						end
					print @WhiteSpace
					print @WhiteSpace
					print @WhiteSpace

					--If only defragging a single database {@DBName has a value other than 'All'}, then return out of the SP, otherwise fetch next
					if @Exit = 'true' 
						begin
							--Determine and format the finishing time for the jobk
							set @FinishTimeJob = getdate()
							set @TotalTimeJob = datediff(second, @StartTimeJob, @FinishTimeJob)
							set @TotalTimeJobFormatted = cast((@TotalTimeJob / 3600) as varchar(32)) + ' hour(s) ' + 
								cast((@TotalTimeJob %3600 / 60) as varchar(32)) + ' min(s) ' + 
								cast((@TotalTimeJob %60) as varchar(32)) + ' sec(s)'

							print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
							print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
							print @WhiteSpace
							print '													Indexing/Stats Complete														   '
							print '													' + cast(getdate() as varchar) + '											   '
							print @WhiteSpace
							print '													Total Execution Time for Job: ' + @TotalTimeJobFormatted + '				   '
							print @WhiteSpace
							print @WhiteSpace
							print '													Unhandled Errors: ' + cast(@UnhandledErrors as varchar) + '					   '
							print '													Handled Errors: ' + cast(@HandledError as varchar) + '					       '
							print @WhiteSpace
							print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
							print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
							print @WhiteSpace
							print @WhiteSpace
							print @WhiteSpace
							print @WhiteSpace
							print @WhiteSpace
							print @WhiteSpace

							--exit SP
							return
						end
NextDB:
				--This exits out of the DB objects cursor and fetches the next database.
				fetch next from DatabaseNames into @DBName
			end --DatabaseNames [Cursor]
	close DatabaseNames
	deallocate DatabaseNames

Finish:
	--Determine and format the finishing time for the job
	set @FinishTimeJob = getdate()
	set @TotalTimeJob = datediff(second, @StartTimeJob, @FinishTimeJob)
	set @TotalTimeJobFormatted = cast((@TotalTimeJob / 3600) as varchar(32)) + ' hour(s) ' + 
		cast((@TotalTimeJob % 3600 / 60) as varchar(32)) + ' min(s) ' + 
		cast((@TotalTimeJob % 60) as varchar(32)) + ' sec(s)'

	print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
	print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
	print @WhiteSpace
	print '															Indexing/Stats Complete														   '
	print '															' + cast(getdate() as varchar) + '											   '
	print @WhiteSpace
	print '															Total Execution Time for Job: ' + @TotalTimeJobFormatted + '				   '
	print @WhiteSpace
	print @WhiteSpace
	print '															Unhandled Errors: ' + cast(@UnhandledErrors as varchar) + '					   '
	print '															Handled Errors: ' + cast(@HandledError as varchar) + '					       '
	print @WhiteSpace
	print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
	print '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  '
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
	print @WhiteSpace
go
