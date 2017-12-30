/*
Author: SQL Undercover
Source link: https://sqlundercover.com/2017/09/13/undercover-toolbox-checking-your-backup-paths-exist-and-automatically-creating-them-if-they-dont/
*/

--variable to hold directory to check
DECLARE @Path NVARCHAR(300) = N'C:\Test\Backups';

IF OBJECT_ID('tempdb..#xp_fileexist_Results') IS NOT NULL DROP TABLE #xp_fileexist_Results;

CREATE TABLE #xp_fileexist_Results (
File_Exists int,
File_is_a_Directory int,
Parent_Directory_Exists int
);

--check if directory exists
INSERT INTO #xp_fileexist_Results
(File_Exists, File_is_a_Directory, Parent_Directory_Exists)
EXEC master.dbo.xp_fileexist @Path;

IF EXISTS (SELECT 1 FROM #xp_fileexist_Results WHERE File_is_a_Directory = 1) --if exists PRINT 'Directory Exists'
    PRINT 'Directory Exists'
ELSE  --if directory doesn't exist, attempt to create it
BEGIN
    EXEC xp_create_subdir @Path;
 
    --perform another existance check to make sure that the directory was actually created
    TRUNCATE TABLE #xp_fileexist_Results;
 
    INSERT INTO #xp_fileexist_Results(File_Exists, File_is_a_Directory, Parent_Directory_Exists)
    EXEC master.dbo.xp_fileexist @Path;
 
    IF EXISTS (SELECT 1 FROM #xp_fileexist_Results WHERE File_is_a_Directory = 1) --if new directory exists PRINT 'Directory Created'
        PRINT 'Directory Created'
    ELSE
        PRINT 'Error Creating Folder' --if new directory doesn't exist then there must have been a problem creating it
END;
GO
