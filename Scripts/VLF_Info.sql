/*
https://gallery.technet.microsoft.com/scriptcenter/SQL-Script-to-list-VLF-e6315249
Kev Riley
*/

--variables to hold each 'iteration'  
declare @query varchar(100)  
declare @dbname sysname  
declare @vlfs int  
  
--table variable used to 'loop' over databases  
declare @databases table (dbname sysname)  
insert into @databases  
--only choose online databases  
select name from sys.databases where state = 0  
  
--table variable to hold results  
declare @vlfcounts table  
    (dbname sysname,  
    vlfcount int)  
  
 
 
--table variable to capture DBCC loginfo output  
--changes in the output of DBCC loginfo from SQL2012 mean we have to determine the version 
 
declare @MajorVersion tinyint  
set @MajorVersion = LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)),CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(max)))-1) 
 
if @MajorVersion < 11 -- pre-SQL2012 
begin 
    declare @dbccloginfo table  
    (  
        fileid smallint,  
        file_size bigint,  
        start_offset bigint,  
        fseqno int,  
        [status] tinyint,  
        parity tinyint,  
        create_lsn numeric(25,0)  
    )  
  
    while exists(select top 1 dbname from @databases)  
    begin  
  
        set @dbname = (select top 1 dbname from @databases)  
        set @query = 'dbcc loginfo (' + '''' + @dbname + ''') '  
  
        insert into @dbccloginfo  
        exec (@query)  
  
        set @vlfs = @@rowcount  
  
        insert @vlfcounts  
        values(@dbname, @vlfs)  
  
        delete from @databases where dbname = @dbname  
  
    end --while 
end 
else 
begin 
    declare @dbccloginfo2012 table  
    (  
        RecoveryUnitId int, 
        fileid smallint,  
        file_size bigint,  
        start_offset bigint,  
        fseqno int,  
        [status] tinyint,  
        parity tinyint,  
        create_lsn numeric(25,0)  
    )  
  
    while exists(select top 1 dbname from @databases)  
    begin  
  
        set @dbname = (select top 1 dbname from @databases)  
        set @query = 'dbcc loginfo (' + '''' + @dbname + ''') '  
  
        insert into @dbccloginfo2012  
        exec (@query)  
  
        set @vlfs = @@rowcount  
  
        insert @vlfcounts  
        values(@dbname, @vlfs)  
  
        delete from @databases where dbname = @dbname  
  
    end --while 
end 
  
--output the full list  
select dbname, vlfcount  
from @vlfcounts  
order by dbname
