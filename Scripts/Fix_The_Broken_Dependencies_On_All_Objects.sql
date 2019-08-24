/*
Author:  Karthick P.K.
Source link: https://mssqlwiki.com/2012/05/04/copy-database-wizard-or-replication-setup-might-fail-due-to-broken-dependency/
*/

--Below script will fix the broken dependencies on all the objects
----------------------------------------------------------------------------
--List of objects for which referenced objects are missing.
--ex: View created on table XYZ and table XYZ is dropped
----------------------------------------------------------------------------
SELECT OBJECT_NAME (referencing_id),referenced_database_name, referenced_schema_name, referenced_entity_name
FROM sys.sql_expression_dependencies
WHERE referenced_entity_name not in (select name from sysobjects)
 
create table #t_excluded_modules (module_name sysname)
go
 
create table #t_modules_refreshed_in_end (module_name sysname)
 
go
 
------------------------------------------------------------------------------
--
-- get the list of modules whose dependencies have to be refreshed
--
-- Comment:
-- in the list we're not considering procedures or triggers because
-- because they can be created in any order, which means they can be refreshed
-- in any order
--
------------------------------------------------------------------------------
create table #t_user_views_or_tables (module_id int)
insert into #t_user_views_or_tables(module_id)
        select object_id from sys.objects where
            type in ('V', 'FN', 'IF', 'TF')
            and name not like 'MSMerge%'
            and is_ms_shipped <> 1
            and name not in (select * from #t_modules_refreshed_in_end)
            and name not in (select * from #t_excluded_modules)
 
insert into #t_user_views_or_tables(module_id)
        select object_id from sys.objects where
            name in (select * from #t_modules_refreshed_in_end)
 
----------------------------------------
--
-- get the dependency table
-- |---------------------------------|
-- |  referencing_id | referenced_id |
-- | ----------------|---------------|
-- |      XXX        |     XXX       |
-- | ----------------|---------------|
--
----------------------------------------
Declare @module int, @message varchar(1000), @str nvarchar(1000)
create table #t_dependency_table (referencing_id int, referenced_id int)
DECLARE modules_cursor CURSOR FOR SELECT module_id FROM #t_user_views_or_tables
open modules_cursor
fetch next from modules_cursor into @module
 
IF @@FETCH_STATUS <> 0
    PRINT '            <<None>> No module to refresh'
 
while @@FETCH_STATUS = 0
    begin
        select @str = quotename(schema_name(objectproperty(@module, 'schemaid'))) + '.' + quotename(object_name(@module))
        select @message = '            trying to refresh ' + @str
        print @message
        exec sys.sp_refreshsqlmodule @str
        select @message = '            ' + @str + ' was refreshed'
        print @message
 
        insert into #t_dependency_table (referencing_id, referenced_id)
            select distinct object_id as referencing_id, referenced_major_id as referenced_id
                from sys.sql_dependencies
                where object_id <> referenced_major_id      -- to avoid self recursion for functions
                      and object_id = @module
 
        fetch next from modules_cursor into @module
    end
 
close modules_cursor
deallocate modules_cursor
 
-------------------------------------------------------------------------------------------
--
-- get the the bottom of the dependency list i.e. independent modules
-- i.e.
-- get the list of referenced_ids in the dependency table which
-- don't occur in the referencing_ids column
--
-- Comment:
-- if there are circular dependencies then the few modules which form a circular dependency
-- would be ignored in the independent modules list
--
-------------------------------------------------------------------------------------------
create table #t_independent_modules (modules int)
 
insert into #t_independent_modules (modules)
    select #t_dependency_table.referenced_id from
            #t_dependency_table left outer join #t_dependency_table t2
            on #t_dependency_table.referenced_id = t2.referencing_id
    where
            t2.referencing_id is NULL
 
-------------------------------------------------------------------------------------------
--
-- build the ordered list of dependencies starting with the independent modules
-- in the beginning first few rows, ones dependent on it in the following rows and so on...
--
-- there can be tricky cases of dependencies such as
-- V1 -> V2 -> V3
--  |           ^
--  +-----------+
--
-- in the above example the refresh order would be V3, V1, V2, V1.
-- note that V1 is being refreshed twice, the last refresh of V1 after V2 is important.
--
-------------------------------------------------------------------------------------------
create table #t_final_dependency_list (id_num int IDENTITY(1,1), modules int)
 
while exists (select * from #t_independent_modules)
    begin
        -- append the set of independent modules into a list
        insert into #t_final_dependency_list select * from #t_independent_modules
 
        -- get the set of dependent modules
        select distinct #t_dependency_table.referencing_id into #temp_table
            from #t_dependency_table
            where #t_dependency_table.referenced_id in (select * from #t_independent_modules)
 
        -- clear up the list of independent modules
        truncate table #t_independent_modules
 
        -- the dependent modules now become the independent modules
        insert into #t_independent_modules select * from #temp_table
 
        -- delete the dependent modules list
        drop table #temp_table
    end
 
-----------------------------------------------------------
--
-- refresh the modules once more but in the right order now
--
-----------------------------------------------------------
declare modules_cursor_final cursor for
    select modules from #t_final_dependency_list order by #t_final_dependency_list.id_num
 
open modules_cursor_final
fetch next from modules_cursor_final into @module
 
IF @@FETCH_STATUS <> 0
    PRINT '            <<None>> No module to refresh'
 
while @@FETCH_STATUS = 0
    begin
        if (select type from sys.objects where object_id = @module) in ('V', 'FN', 'IF', 'TF')
            and (select is_schema_bound from sys.sql_modules where object_id = @module) = 0
            begin
                select @str = quotename(schema_name(objectproperty(@module, 'schemaid'))) + '.' + quotename(object_name(@module))
                select @message = '            trying to finally, once more, refresh ' + @str
                print @message
                exec sys.sp_refreshsqlmodule @str
                select @message = '            ' + @str + ' was finally refreshed once again'
                print @message
            end
 
        fetch next from modules_cursor_final into @module
    end
 
close modules_cursor_final
DEALLOCATE modules_cursor_final;
 
-----------
--
-- cleanup
--
-----------
drop table #t_excluded_modules;
drop table #t_modules_refreshed_in_end;
drop table #t_user_views_or_tables;
drop table #t_dependency_table;
drop table #t_independent_modules;
drop table #t_final_dependency_list;
