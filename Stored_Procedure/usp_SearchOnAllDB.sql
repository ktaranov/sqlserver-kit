/*************************************************************************/
/*         Procedure of search of a phrase on all database               */
/*            Originally developed by Oufimtsev Gleb, MCSE               */
/*                                                                       */
/*            Updated by David Musgrave, Microsoft                       */
/*            from feedback from Eduardo Barbosa & Marc K                */
/*                                                                       */
/*            Last Modified: 26-Jul-2013                                 */
/*                                                                       */
/*  Search for spSearchOnAllDB at http://aka.ms/Dev4DynGP for more info  */
/*                                                                       */
/*************************************************************************/

if exists (select * from sysobjects where id = object_id('dbo.spSearchOnAllDB') )
	drop procedure dbo.spSearchOnAllDB
GO

CREATE PROCEDURE spSearchOnAllDB @phrase varchar(8000), @OutFullRecords bit = 0 AS

/*
   To apply so: 
      exec  spSearchOnAllDB 'Sugar%'
      exec  spSearchOnAllDB '%soft%'
      exec  spSearchOnAllDB '_5234_57%', 1
      exec  spSearchOnAllDB M_cro_oft
*/

declare @sql varchar(8000)
declare @tbl varchar(128) 
declare @col varchar(128)
declare @id_present bit

declare @is_char_phrase bit
declare @min_len int
declare @loop_idx int
declare @loop_chr char(1)

set nocount on

if IsNull(@phrase, '') = '' begin
	raiserror('Phrase is absent', 16, -1)
	return
end

-- Handle Quotes passed in the search string
set @phrase = replace(@phrase, '''', '''''')

select @loop_idx = 1, @is_char_phrase = 0, @min_len = 0 

while @loop_idx <= LEN(@phrase) begin
	set @loop_chr = SUBSTRING(@phrase, @loop_idx,1)
	if @loop_chr not in ('%', '_') 
		set @min_len = @min_len + 1
	if @is_char_phrase = 0 and @loop_chr not in ('%', '_', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.')  
		set @is_char_phrase = 1
	set @loop_idx = @loop_idx + 1
end 

create table #tbl_res 
			(TableName		varchar(128) not NULL,
			 ColumnName		varchar(128) not NULL,
			 Id				int NULL,
			 ColumnValue	varchar(7500) not NULL)

create table #tbl_res2 
			(TableName		varchar(128) not NULL,
			 ColumnName		varchar(128) not NULL,
			 Id				int NULL,
			 ColumnValue	varchar(7500) not NULL)

declare CRR cursor local fast_forward for
	select t.name, c.name, 1 
	from sysobjects t, syscolumns c 
	where t.type = 'U'
	and c.id = t.id
	and c.status&0x80 = 0 -- Not IDENTITY
	and exists (select * from syscolumns c2 where t.id = c2.id and c2.status&0x80 = 0x80 and c2.xtype in (48, 52, 56))
	and (  (@is_char_phrase = 1 and c.xtype in (175, 239, 99, 231, 35, 167) and c.length >= @min_len) -- char only
		or (@is_char_phrase = 0 and c.xtype not in (34, 165, 173, 189, 61, 58, 36))) -- char and numeric
	union 
	select t.name, c.name, 0 
	from sysobjects t, syscolumns c 
	where t.type = 'U'
	and c.id = t.id
	and not exists (select * from syscolumns c2 where t.id=c2.id and c2.status&0x80 = 0x80 and c2.xtype in (48, 52, 56))
	and (  (@is_char_phrase = 1 and c.xtype in (175, 239, 99, 231, 35, 167) and c.length >= @min_len) -- char only
		or (@is_char_phrase = 0 and c.xtype not in (34, 165, 173, 189, 61, 58, 36))) -- char and numeric
	order by 1, 2

open CRR
fetch CRR into @tbl, @col, @id_present
while @@FETCH_STATUS = 0 begin
	if @OutFullRecords = 0 begin
		set @sql = 'insert into #tbl_res (TableName, ColumnName, Id, ColumnValue) '
					+ 'select ''[' + @tbl + ']'', ''[' + @col + ']'', '
		if @id_present = 1
			set @sql = @sql + 'IDENTITYCOL, '
		else 
			set @sql = @sql + 'NULL, ' 
		set @sql = @sql + 'convert(varchar(7500), [' + @col + ']) '
						+ 'from [' + @tbl + '] (nolock) '
						+ 'where convert(varchar(8000), [' + @col + ']) like ''' + @phrase + ''' '
	end
	if @OutFullRecords = 1 begin
		set @sql = 'if exists (select * from [' + @tbl + '] (nolock) '
				 + 'where convert(varchar(8000), [' + @col + ']) like ''' + @phrase + ''') '
				 + 'select ''[' + @tbl + ']'' TableName, ''[' + @col+ ']'' ColumnName, * '
				 + 'from [' + @tbl + '] (nolock) where convert(varchar(8000), [' + @col + ']) like ''' + @phrase + ''' '
	end
	exec(@sql)
	fetch CRR into @tbl, @col, @id_present
end
close CRR
deallocate CRR

if @OutFullRecords = 0 begin
	-- For the clients supporting new types:
	--exec('select * from #tbl_res order by 1,2,3')

	-- For the clients who are not supporting new types:
	INSERT #tbl_res2
	select TableName, ColumnName, Id, convert(varchar(255),ColumnValue) ColumnValue from #tbl_res

	/** exec('select TableName, ColumnName, Id, convert(varchar(255),ColumnValue) ColumnValue from #tbl_res order by 1,2,3')**/
end
  
drop table #tbl_res 

/***Select Statement to show tables***/

select TableName, ColumnName, ColumnValue from #tbl_res2 group by TableName, ColumnName, ColumnValue
	order by TableName

truncate table #tbl_res2
drop table #tbl_res2
RETURN

GO

--GRANT EXECUTE ON dbo.spSearchOnAllDB TO DYNGRP

/* Copyright © Microsoft Corporation.  All Rights Reserved.                     */
/* This code released under the terms of the                                    */
/* Microsoft Public License (MS-PL, http://opensource.org/licenses/ms-pl.html.) */

--exec  spSearchOnAllDB '100XL%', 1
--exec  spSearchOnAllDB '%''%', 0
