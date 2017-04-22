/*
Author: Jason Brimhall
Original link: http://www.sqlservercentral.com/blogs/sqlrnnr/2016/12/23/what-agent-job-is-running-back-to-basics/
*/

SELECT p.session_id,p.program_name
    ,j.name AS JobName, js.step_name, j.description, js.step_id
    , st.Query AS JobCommand
    , js.subsystem
    FROM sys.dm_exec_sessions p
        INNER JOIN msdb.dbo.sysjobs j
            ON j.job_id = CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY(16), SUBSTRING(p.program_name,
                                                                CHARINDEX('(',
                                                                p.program_name)
                                                                + 5,
                                                                CHARINDEX(':',
                                                                p.program_name)
                                                                - CHARINDEX('(',
                                                                p.program_name)
                                                                - 6),1))
        INNER JOIN msdb.dbo.sysjobsteps js
            ON j.job_id = js.job_id
                CROSS APPLY (
                    SELECT 
                        REPLACE
                        (
                            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                            REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                                CONVERT
                                (
                                    NVARCHAR(MAX),
                                    N'--' + NCHAR(13) + NCHAR(10) + ist.command + NCHAR(13) + NCHAR(10) + N'--' COLLATE Latin1_General_Bin2
                                ),
                                NCHAR(31),N'?'),NCHAR(30),N'?'),NCHAR(29),N'?'),NCHAR(28),N'?'),NCHAR(27),N'?'),NCHAR(26),N'?'),NCHAR(25),N'?'),NCHAR(24),N'?'),NCHAR(23),N'?'),NCHAR(22),N'?'),
                                NCHAR(21),N'?'),NCHAR(20),N'?'),NCHAR(19),N'?'),NCHAR(18),N'?'),NCHAR(17),N'?'),NCHAR(16),N'?'),NCHAR(15),N'?'),NCHAR(14),N'?'),NCHAR(12),N'?'),
                                NCHAR(11),N'?'),NCHAR(8),N'?'),NCHAR(7),N'?'),NCHAR(6),N'?'),NCHAR(5),N'?'),NCHAR(4),N'?'),NCHAR(3),N'?'),NCHAR(2),N'?'),NCHAR(1),N'?'),
                            NCHAR(0),
                            N''
                        ) AS [processing-instruction(query)]
                        FROM msdb.dbo.sysjobsteps AS ist
                            WHERE ist.job_id = j.job_id
                                AND ist.step_id = SUBSTRING(p.program_name, CHARINDEX(')', p.program_name) - 2, 2)
                    FOR XML
                        PATH(''),
                        TYPE
                ) AS st(Query)
    WHERE p.program_name LIKE 'SQLAgent - TSQL JobStep (Job%'
        AND js.step_id = SUBSTRING(p.program_name, CHARINDEX(')', p.program_name) - 2, 2)
    ;