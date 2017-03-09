/*============================================================================
  File:     sp_SQLskills_ExposeColsInIndexLevels

  Summary:  This procedure lists columns in the key vs. those in the leaf level
			of a nonclustered index. This is dependent on whether or not the 
			nonclustered is UNIQUE as well as whether or not the table has a 
			clustered index. It also changes based on whether or not the 
			clustering key is UNIQUE.
			
  Date:     May 2010

  Version:	SQL Server 2005/2008
------------------------------------------------------------------------------
  Written by Paul S. Randal and Kimberly L. Tripp, SQLskills.com

  For more scripts and sample code, check out 
    http://www.SQLskills.com

  This script is intended only as a supplement to demos and lectures
  given by SQLskills instructors.  
  
  THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
  ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
  TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
  PARTICULAR PURPOSE.
============================================================================*/

USE master
go

if OBJECTPROPERTY(OBJECT_ID('sp_SQLskills_ExposeColsInIndexLevels'), 'IsProcedure') = 1
	drop procedure sp_SQLskills_ExposeColsInIndexLevels
go

create procedure sp_SQLskills_ExposeColsInIndexLevels 
(
	@object_id int,
	@index_id int,
	@ColsInTree nvarchar(2126) OUTPUT,
	@ColsInLeaf nvarchar(max) OUTPUT
)
AS
BEGIN
	declare @nonclus_uniq int
			, @column_id int
			, @column_name nvarchar(260)
			, @col_descending bit
			, @colstr	nvarchar (max);

	-- Get clustered index keys (id and name)
	select sic.column_id, QUOTENAME(sc.name, N']') AS column_name, is_descending_key
	into #clus_keys 
	from sys.index_columns AS sic
		JOIN sys.columns AS sc
			ON sic.column_id = sc.column_id AND sc.object_id = sic.object_id
	where sic.[object_id] = @object_id
	and [index_id] = 1;
	
	-- Get nonclustered index keys
	select sic.column_id, sic.is_included_column, QUOTENAME(sc.name, N']') AS column_name, is_descending_key
	into #nonclus_keys 
	from sys.index_columns AS sic
		JOIN sys.columns AS sc
			ON sic.column_id = sc.column_id 
				AND sc.object_id = sic.object_id
	where sic.[object_id] = @object_id
		and sic.[index_id] = @index_id;
		
	-- Is the nonclustered unique?
	select @nonclus_uniq = is_unique 
	from sys.indexes
	where [object_id] = @object_id
		and [index_id] = @index_id;

	if (@nonclus_uniq = 0)
	begin
		-- Case 1: nonunique nonclustered index

		-- cursor for nonclus columns not included and
		-- nonclus columns included but also clus keys
		declare mycursor cursor for
			select column_id, column_name, is_descending_key  
			from #nonclus_keys
			where is_included_column = 0
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;
		
		-- cursor over clus_keys if clustered
		declare mycursor cursor for
			select column_id, column_name, is_descending_key from #clus_keys
			where column_id not in (select column_id from #nonclus_keys
				where is_included_column = 0)
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;	
		
		select @ColsInTree = substring(@colstr, 1, LEN(@colstr) -1);
			
		-- find columns not in the nc and not in cl - that are still left to be included.
		declare mycursor cursor for
			select column_id, column_name, is_descending_key from #nonclus_keys
			where column_id not in (select column_id from #clus_keys UNION select column_id from #nonclus_keys where is_included_column = 0)
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;	
		
		select @ColsInLeaf = substring(@colstr, 1, LEN(@colstr) -1);
		
	end

	-- Case 2: unique nonclustered
	else
	begin
		-- cursor over nonclus_keys that are not includes
		select @colstr = ''
		declare mycursor cursor for
			select column_id, column_name, is_descending_key from #nonclus_keys
			where is_included_column = 0
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;
		
		select @ColsInTree = substring(@colstr, 1, LEN(@colstr) -1);
	
		-- start with the @ColsInTree and add remaining columns not present...
		declare mycursor cursor for
			select column_id, column_name, is_descending_key from #nonclus_keys 
			WHERE is_included_column = 1;
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;

		-- get remaining clustered column as long as they're not already in the nonclustered
		declare mycursor cursor for
			select column_id, column_name, is_descending_key from #clus_keys
			where column_id not in (select column_id from #nonclus_keys)
		open mycursor;
		fetch next from mycursor into @column_id, @column_name, @col_descending;
		WHILE @@FETCH_STATUS = 0
		begin
			select @colstr = ISNULL(@colstr, N'') + @column_name + CASE WHEN @col_descending = 1 THEN '(-)' ELSE N'' END + N', ';
			fetch next from mycursor into @column_id, @column_name, @col_descending;
		end
		close mycursor;
		deallocate mycursor;	

		select @ColsInLeaf = substring(@colstr, 1, LEN(@colstr) -1);
		select @colstr = ''
	
	end
	-- Cleanup
	drop table #clus_keys;
	drop table #nonclus_keys;
	
END;
GO

exec sys.sp_MS_marksystemobject 'sp_SQLskills_ExposeColsInIndexLevels'
go

