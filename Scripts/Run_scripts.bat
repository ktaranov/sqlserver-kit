REM  Author: Manu Mohanan
REM  Original link: http://www.sqlservercentral.com/articles/SQLCMD/131634/


@@echo off

del errors /f /s /q

rd Errors

md Errors

FOR %%A IN (*.SQL) DO ( sqlcmd -S SERVERNAME -d DATABASE1 -U username -P password -i "%%A" -o "Errors\%%AError_DB1.txt" -I )

FOR %%A IN (*.SQL) DO ( sqlcmd -S SERVERNAME -d DATABASE2 -U username -P password -i "%%A" -o "Errors\%%AError_DB2.txt" -I )
