IF OBJECT_ID('dbo.usp_TransliterationEN2RU', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.usp_TransliterationEN2RU AS SELECT 1;');
GO

ALTER PROCEDURE usp_TransliterationEN2RU (
      @inputString NVARCHAR(MAX)
    , @transid INT = NULL
    )
/*
.SYNOPSIS
    Процедура транслитерации кирилицы в латинский и французский алфавиты.

.DESCRIPTION
    По умолчанию процедура возвращает все 3 типа разных транслитераций, но с помощью параметра @transid можно вернуть только один необходимый.

.PARAMETER @inputString
  Текст кириллицей со знаками препинания, тип данных NVARCHAR(MAX)

.PARAMETER @transid
    Варианты транслитерации:
    1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 http://legalacts.ru/doc/prikaz-mvd-rf-ot-26051997-n-310/ ОБРАЗЦЫ НАПИСАНИЯ ФАМИЛИЙ, ИМЕН И ДРУГИХ ДАННЫХ НА ФРАНЦУЗСКОМ ЯЗЫКЕ
    2 - в соответствии с ГОСТ Р 52535.1-2006 http://docs.cntd.ru/document/1200045268 Приложение А (обязательное). Транслитерация кириллицы для русского алфавита
    3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10] в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) http://www.icao.int/publications/Documents/9303_p1_v1_cons_ru.pdf

.EXAMPLE
    EXEC usp_TransliterationEN2RU @inputString = 'Шрамко Александр';

.EXAMPLE
    EXEC usp_TransliterationEN2RU @inputString = 'ВаСиньин еГЕпа. ксения чьё ю вася мясо шняжка !!!' , @transid = 1;

.NOTE
    Version: 3.0
    Modified: 218-04-02 23:05:21 UTC+3 by Konstantin Taranov
    Author: Shramko Aleksandr https://github.com/shramko/mssql/blob/master/transliteration.sql
    Link: https://github.com/ktaranov/sqlserver-kit/blob/master/Stored_Procedure/usp_TransliterationEN2RU.sql
*/
AS
BEGIN TRY

    DECLARE @outputstring NVARCHAR(MAX)
          , @counter INT
          , @ch1 NVARCHAR(10)
          , @ch2 NVARCHAR(10)
          , @ch3 NVARCHAR(10);
    DECLARE @result_table TABLE (
        id INT
        ,translate NVARCHAR(MAX)
        )

    ------------------------------------------------------------------
    ------- 1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 ------------------
    SELECT @counter = 1
        ,@outputstring = '';

    --подготовка случаев: С - между двумя гласными выражается - ss - Goussev.
    DECLARE @t1 TABLE (ch NCHAR(1));

    INSERT INTO @t1
    SELECT N'А'
    UNION ALL
    SELECT N'Е'
    UNION ALL
    SELECT N'Ё'
    UNION ALL
    SELECT N'И'
    UNION ALL
    SELECT N'О'
    UNION ALL
    SELECT N'У'
    UNION ALL
    SELECT N'Ы'
    UNION ALL
    SELECT N'Э'
    UNION ALL
    SELECT N'Ю'
    UNION ALL
    SELECT N'Я';

    DECLARE @t2 TABLE (ch NCHAR(1));

    INSERT INTO @t2
    SELECT N'С';

    DECLARE @str NVARCHAR(4000) = N'';

    SELECT @str = @str + t1.ch + t2.ch + t3.ch + N'|'
      FROM @t1 t1
         , @t2 t2
         , @t1 t3;

    WHILE (@counter <= LEN(@inputString))
    BEGIN
        SET @ch1 = SUBSTRING(@inputString, @counter, 1);
        SET @ch2 = SUBSTRING(@inputString, @counter, 2);

        PRINT (@counter);

        SELECT @outputstring = @outputstring + CASE 
                WHEN J8 > 0
                    THEN CASE 
                            WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                THEN 'INE'
                            ELSE 'ine'
                            END
                WHEN J7 > 0
                    THEN CASE 
                            WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                THEN 'IE'
                            ELSE 'ie'
                            END
                WHEN J6 > 0
                    THEN CASE 
                            WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                THEN 'X'
                            ELSE 'x'
                            END
                WHEN J5 > 0
                    THEN CASE 
                            WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                THEN 'SS'
                            ELSE 'ss'
                            END
                WHEN J4 > 0
                    THEN CASE 
                            WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                THEN 'GUIA'
                            WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                THEN 'Guia'
                            ELSE 'guia'
                            END
                WHEN J3 > 0
                    THEN CASE 
                            WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                THEN 'GUIOU'
                            WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                THEN 'Guiou'
                            ELSE 'guiou'
                            END
                WHEN J2 > 0
                    THEN REPLACE(SUBSTRING(CASE 
                                    WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                        THEN '|GUE|GUE|GUI|GUI|GUY'
                                    WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                        THEN '|Gue|Gue|Gui|Gui|Guy'
                                    ELSE '|gue|gue|gui|gui|guy'
                                    END, J2 + 1, 3), '|', '')
                WHEN J1 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                    THEN 'OUKHTSCHIA'
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'OuKhTsChIa'
                                ELSE 'oukhtschia'
                                END, J1 * 2 - 1, 2)
                WHEN J11 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                    THEN 'TCHIOU'
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'TchIou'
                                ELSE 'tchiou'
                                END, J11 * J11, 3)
                WHEN J0 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'ABVGDEEJZIYKLMNOPRSTFYE'
                                ELSE 'abvgdeejziyklmnoprstfye'
                                END, J0, 1)
                ELSE CASE 
                        WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                            THEN REPLACE(@ch1, 'Щ', 'SHTCH')
                        WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                            THEN REPLACE(@ch1, 'Щ', 'Shtch')
                        ELSE REPLACE(@ch1, 'щ', 'shtch')
                        END
                END
            ,@counter = @counter + CASE 
                WHEN J2 + J3 + J4 + J6 + J7 + J8 > 0
                    THEN 2
                ELSE 1
                END
        FROM (
            SELECT PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 3    ) + '|%', '|ИН |ИН,|ИН.|ИН;|ИН:|')    AS J8 -- Фамилия на "ин" пишутся с "e" - Vassine - Васин.
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2    ) + '|%', '|ЬЕ|ЬЁ|')                  AS J7 -- Если в фамилии после "ь" следует "e", то пишется "ie"
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2    ) + '|%', '|КС|')                     AS J6 -- Сочетание "кс" во французском тексте пишется как "х"
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter - 1, 3) + '|%', '|' + @str)                 AS J5 -- С - между двумя гласными выражается - ss
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2)     + '|%', '|ГЯ|')                     AS J4 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2)     + '|%', '|ГЮ|')                     AS J3 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                 , PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2)     + '|%', '|ГЕ||ГЭ||ГИ||ГЙ||ГЫ|')     AS J2 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                 , PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1)     + '%', 'УХЦШЯ')                     AS J1
                 , PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1)     + '%', 'ЧЮ')                        AS J11
                 , PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1)     + '%', 'АБВГДЕЁЖЗИЙКЛМНОПРСТФЫЭЪЬ') AS J0
            ) J
    END;

    INSERT INTO @result_table
    SELECT 1
        ,@outputstring;

    /*------ 2 - в соответствии с ГОСТ Р 52535.1-2006 -----------------*/
    SELECT @counter = 1
        ,@outputstring = '';

    WHILE (@counter <= len(@inputString))
    BEGIN
        SELECT @ch1 = SUBSTRING(@inputString, @counter, 1)

        SELECT @ch2 = SUBSTRING(@inputString, @counter, 2)

        SELECT @outputstring = @outputstring + CASE 
                WHEN J1 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                                    THEN 'ZHKHTCCHSHIAIU'
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'ZhKhTcChShIaIu'
                                ELSE 'zhkhtcchshiaiu'
                                END, J1 * 2 - 1, 2)
                WHEN J0 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'ABVGDEEZIIKLMNOPRSTUFYE'
                                ELSE 'abvgdeeziiklmnoprstufye'
                                END, J0, 1)
                ELSE CASE 
                        WHEN @ch2 COLLATE Cyrillic_General_CS_AS = UPPER(@ch2)
                            THEN REPLACE(@ch1, 'Щ', 'SHCH')
                        WHEN @ch1 COLLATE Cyrillic_General_CS_AS = UPPER(@ch1)
                            THEN REPLACE(@ch1, 'Щ', 'Shch')
                        ELSE REPLACE(@ch1, 'щ', 'shch')
                        END
                END
            ,@counter = @counter + 1
        FROM (
            SELECT PATINDEX('%' + UPPER(@ch1) + '%', 'ЖХЦЧШЯЮ') AS J1
                ,PATINDEX('%' + UPPER(@ch1) + '%', 'АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЪЬ') AS J0
            ) J
    END;

    INSERT INTO @result_table (
        id
        ,translate
        )
    SELECT 2
        ,@outputstring

    /* 3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10]
     в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) */
    SELECT @counter = 1
        ,@outputstring = '';

    WHILE (@counter <= len(@inputString))
    BEGIN
        SELECT @ch1 = SUBSTRING(@inputString, @counter, 1);

        SELECT @ch2 = SUBSTRING(@inputString, @counter, 2);

        SELECT @outputstring = @outputstring + CASE 
                WHEN J1 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'ZHKHTSCHSHIAIUIE'
                                ELSE 'zhkhtschshiaiuie'
                                END, J1 * 2 - 1, 2)
                WHEN J0 > 0
                    THEN SUBSTRING(CASE 
                                WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                                    THEN 'ABVGDEEZIYKLMNOPRSTUFYE'
                                ELSE 'abvgdeeziyklmnoprstufye'
                                END, J0, 1)
                ELSE CASE 
                        WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2)
                            THEN REPLACE(@ch1, 'Щ', 'SHCH')
                        WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1)
                            THEN REPLACE(@ch1, 'Щ', 'Shch')
                        ELSE REPLACE(@ch1, 'щ', 'shch')
                        END
                END
            ,@counter = @counter + 1
        FROM (
            SELECT PATINDEX('%' + UPPER(@ch1) + '%', 'ЖХЦЧШЯЮЪ') AS J1
                ,PATINDEX('%' + UPPER(@ch1) + '%', 'АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЬ') AS J0
            ) J
    END;

    INSERT INTO @result_table (
        id
        ,translate
        )
    SELECT 3
        ,@outputstring;

    -------- вывод результата ------------------------
    SELECT *
    FROM @result_table
    WHERE (
            @transid IS NOT NULL
            AND id = @transid
            )
        OR (
            id IS NOT NULL
            AND @transid IS NULL
            );
END TRY

BEGIN CATCH
    THROW

    PRINT 'Error: ' + CONVERT(VARCHAR(50), ERROR_NUMBER()) +
        ', Severity: ' + CONVERT(VARCHAR(5), ERROR_SEVERITY()) +
        ', State: ' + CONVERT(VARCHAR(5), ERROR_STATE()) +
        ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
        ', Line: ' + CONVERT(VARCHAR(5), ERROR_LINE()) +
        ', User name: ' + CONVERT(SYSNAME, ORIGINAL_LOGIN());
    PRINT ERROR_MESSAGE();
END CATCH;
GO
