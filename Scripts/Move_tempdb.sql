/*
Author: Brent Ozar
Original link: https://www.brentozar.com/archive/2017/11/move-tempdb-another-drive-folder/
*/

SELECT 'ALTER DATABASE tempdb MODIFY FILE (NAME = [' + f.name + '],'
    + ' FILENAME = ''Z:\MSSQL\DATA\' + f.name
    + CASE WHEN f.type = 1 THEN '.ldf' ELSE '.mdf' END
    + ''');'
FROM sys.master_files f
WHERE f.database_id = DB_ID(N'tempdb');
