-- MS SQL Server function LEN() does not count trailing spaces!
DECLARE @pattern varchar(20) = 'Ted ';
DECLARE @columnToSearch VARCHAR(1000) = 'Ted is Ted because Ted is awesome!';

SELECT (DATALENGTH(@columnToSearch) - DATALENGTH(REPLACE(@columnToSearch, @pattern, ''))) / DATALENGTH(@pattern) DatalengthNumberOfMatches
     , (LEN(@columnToSearch) - LEN(REPLACE(@columnToSearch, @pattern, ''))) / Len(@pattern) AS LenNumberOfMatches
     , (LEN(@columnToSearch) - LEN(REPLACE(@columnToSearch, @pattern, ''))) AS LenPattern
     , LEN(@pattern) AS Len@pattern
     , DATALENGTH(@pattern) AS Datalength@pattern;
