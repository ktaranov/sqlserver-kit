# Microsoft SQL Server sysjobhistory solution

Original link: http://git.davewentzel.com/dwentzel/sqlscripts/tree/master/sysjobhistoryPurge
Author: David Wentzel

A utility that customizes what gets purged via sysjobhistory.

Allows far more flexibility than what Microsoft provides natively. Also, the purge is "smart" and will not cause blocking and concurrency problems on instances with many, frequent SQL Agent jobs. Includes tsqlt unit tests.

`seeddata.sql` is the only file that should need to be customized. You place your jobs and categories and their custom retention settings here.

`DBA_sysjobhistory_config_tbl.sql` builds the table that handles the custom sysjobhistory retention configuration.

`DBA_sysjobhistory_driver.sql` configures SQL Agent for unlimited history retention, since we'll be handling that now. It then examines each job in turn and runs `DBA_sp_jobhistory_row_limiter` to retain the custom settings for this job/category. This procedure should be scheduled to run every day (or so, depending on your requirements).

`DBA_sp_jobhistory_row_limiter.sql` is more or less a copy of MS-provided sp_jobhistory_row_limiter with our custom logic.

`DBA_sysjobhistory_driver_Tests.sql` is the tsqlt unit tests for this feature.
