IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'IF' AND object_id = object_id('dbo.udf_ParseFilePath'))
    EXEC ('CREATE FUNCTION dbo.udf_ParseFilePath() RETURNS TABLE AS RETURN SELECT Result = ''This is a stub'';' )
GO


ALTER FUNCTION dbo.udf_ParseFilePath (@FilePath nvarchar(300))
RETURNS TABLE
/*************************************************************************************************
https://github.com/amtwo/dba-database/blob/master/functions-tvfs/dbo.ParseFilePath.sql
AUTHOR: Andy Mallon
CREATED: 20180114
    Parses a full file path into separate file & path values. 
    Also include the bare file name & file extension, because why not?
PARAMETERS:
    @FilePath - Text string of a complete file & path
EXAMPLES:
* 
**************************************************************************************************
MODIFICATIONS:
    20160218 - 
**************************************************************************************************
    This code is free to download and use for personal, educational, and internal 
    corporate purposes, provided that this header is preserved. Redistribution or sale, 
    in whole or in part, is prohibited without the author's express written consent.
    ©2014-2018 ● Andy Mallon ● am2.co
*************************************************************************************************/
AS
RETURN
    WITH ParseInfo AS(
        SELECT FilePath      = @FilePath,
               PathLen       = LEN(@FilePath),
               FinalSlashPos = CHARINDEX('\', REVERSE(@FilePath), 1)
        ),
        ParsedPaths AS (
        SELECT DirectoryPath = LEFT (FilePath, PathLen - FinalSlashPos + 1),
               FullFileName  = RIGHT(FilePath, FinalSlashPos - 1),
               FileExtension = RIGHT(FilePath, CHARINDEX('.', REVERSE(FilePath)) -1),
               *
        FROM ParseInfo
        )
    SELECT DirectoryPath,
           FullFileName,
           BareFilename = LEFT(FullFilename,LEN(FullFilename)-(LEN(FileExtension)+1)),
           FileExtension
    FROM ParsedPaths;
GO
