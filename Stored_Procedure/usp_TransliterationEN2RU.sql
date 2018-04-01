IF OBJECT_ID('dbo.usp_TransliterationEN2RU', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.usp_TransliterationEN2RU AS SELECT 1;');
GO


ALTER PROCEDURE usp_TransliterationEN2RU
(
    @inputString NVARCHAR(MAX),
    @transid     INT = NULL
) as
/*
.EXAMPLE
  EXEC usp_TransliterationEN2RU @inputString = 'Шрамко Александр';

.NOTE
  Version: 2.0
  Modified: 218-04-01 23:40:00 UTC+3 by Konstantin Taranov
  Author: Shramko Aleksandr https://github.com/shramko/mssql/blob/master/transliteration.sql
  Link: https://github.com/ktaranov/sqlserver-kit/blob/master/Stored_Procedure/usp_TransliterationEN2RU.sql
*/
BEGIN TRY
    /*
        @transid - ид варианта транслитерации. сейчас используются следующие
        1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 http://rosadvokat.ru/open.php?id=11800742_1
        2 - в соответствии с ГОСТ Р 52535.1-2006 http://www.complexdoc.ru/pdf/%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0%2052535.1-2006/gost_r_52535.1-2006.pdf
        3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10] в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) http://www.icao.int/publications/Documents/9303_p1_v1_cons_ru.pdf

    */

    DECLARE
         @outputstring NVARCHAR(MAX)
        ,@counter      INT
        ,@ch1          NVARCHAR(10)
        ,@ch2          NVARCHAR(10)
        ,@ch3          NVARCHAR(10);
    
    DECLARE @result_table TABLE (id int, translate NVARCHAR(MAX))

    ------------------------------------------------------------------
    ------- 1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 ------------------
     select
         @counter = 1
        ,@outputstring = ''
    
    --подготовка случаев: С - между двумя гласными выражается - ss - Goussev.
    DECLARE @t1 TABLE (ch NCHAR(1));
    INSERT INTO @t1
              SELECT N'А'
        UNION SELECT N'Е'
        UNION SELECT N'Ё'
        UNION SELECT N'И'
        UNION SELECT N'О'
        UNION SELECT N'У'
        UNION SELECT N'Ы'
        UNION SELECT N'Э'
        UNION SELECT N'Ю'
        UNION SELECT N'Я';
    
    DECLARE @t2 TABLE (ch NCHAR(1))
    INSERT INTO @t2
        SELECT N'С';
    
    DECLARE @str NVARCHAR(4000) = N'';
    SELECT @str = @str + t1.ch + t2.ch + t3.ch + N'|'
      FROM @t1 t1, @t2 t2, @t1 t3
    -----------------------------------------------------------------------------
    -- exec transliteration 'ВаСиньин еГЕпа. ксения чьё ю вася мясо шняжка ' , 1
    WHILE (@counter <= LEN(@inputString))
    BEGIN

        SET @ch1 = SUBSTRING(@inputString, @counter, 1);
        SET @ch2 = SUBSTRING(@inputString, @counter, 2);
            PRINT(@counter);

        SELECT
            @outputstring = @outputstring +
                CASE
                    WHEN J8 > 0 THEN
                                    CASE
                                        WHEN @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then'INE'
                                        ELSE 'ine'
                                    END
                    when J7 > 0 THEN 
                                    case 
                                        when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then'IE'
                                        else 'ie'
                                    end
                    when J6 > 0 then 
                                    case 
                                        when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then'X'
                                        else 'x'
                                    end
                    when J5 > 0 then 
                                    case 
                                        when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'SS'
                                        else 'ss'
                                    end
                    when J4 > 0 then 
                                    case
                                        when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then 'GUIA'
                                        when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'Guia'
                                        ELSE 'guia'
                                    end
                    when J3 > 0 then 
                                    case
                                        when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then 'GUIOU'
                                        when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'Guiou'
                                        else 'guiou'
                                    end
                    when J2 > 0 then replace(substring(
                                                        case
                                                            when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then '|GUE|GUE|GUI|GUI|GUY'
                                                            when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then '|Gue|Gue|Gui|Gui|Guy'
                                                            else '|gue|gue|gui|gui|guy'
                                                        end, J2 + 1, 3), '|', '')
                    when J1 > 0 then substring(
                                                case 
                                                    when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then 'OUKHTSCHIA'
                                                    when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'OuKhTsChIa'
                                                    else 'oukhtschia'
                                                end, J1*2 - 1, 2)
                    when J11 > 0 then substring(
                                                case 
                                                    when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then 'TCHIOU'
                                                    when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'TchIou'
                                                    else 'tchiou'
                                                end, J11*J11, 3) 
                    when J0 > 0 then substring(
                                                CASE 
                                                    WHEN @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then 'ABVGDEEJZIYKLMNOPRSTFYE'
                                                    ELSE 'abvgdeejziyklmnoprstfye'
                                                END, J0, 1)
                    ELSE CASE 
                            WHEN @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then replace(@ch1,'Щ','SHTCH')
                            WHEN @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then replace(@ch1,'Щ','Shtch')
                            ELSE REPLACE(@ch1,'щ','shtch')
                         END
                END
            ,@counter = @counter + 
                CASE
                    WHEN J2 + J3 + J4 + J6 + J7 + J8 > 0 then 2
                    ELSE 1
                END
        FROM (
            SELECT
                 PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 3) + '|%','|ИН |ИН,|ИН.|ИН;|ИН:|' )    AS J8 -- Фамилия на "ин" пишутся с "e" - Vassine - Васин.
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2) + '|%','|ЬЕ|ЬЁ|' )                  AS J7 -- Если в фамилии после "ь" следует "e", то пишется "ie"
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2) + '|%','|КС|' )                     AS J6 -- Сочетание "кс" во французском тексте пишется как "х"
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter - 1,3) + '|%','|'+ @str )               AS J5 -- С - между двумя гласными выражается - ss
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2) + '|%','|ГЯ|' )                     AS J4 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2) + '|%','|ГЮ|' )                     AS J3 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%|' + SUBSTRING(UPPER(@inputString), @counter, 2) + '|%','|ГЕ||ГЭ||ГИ||ГЙ||ГЫ|')      AS J2 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1) +  '%','УХЦШЯ')                     AS J1
                ,PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1) +  '%','ЧЮ')                        AS J11
                ,PATINDEX('%'  + SUBSTRING(UPPER(@inputString), @counter, 1) +  '%','АБВГДЕЁЖЗИЙКЛМНОПРСТФЫЭЪЬ') AS J0
            ) J
    END;

    INSERT INTO @result_table
    SELECT 1, @outputstring;


    ------------------------------------------------------------------	
    ------- 2 - в соответствии с ГОСТ Р 52535.1-2006 ------------------
     SELECT
         @counter = 1
        ,@outputstring = '';

    WHILE (@counter <= len(@inputString))
    BEGIN
        SELECT @ch1 = SUBSTRING(@inputString, @counter, 1)
        SELECT @ch2 = SUBSTRING(@inputString, @counter, 2)
        SELECT
            @outputstring = @outputstring + 
                CASE
                    
                    WHEN J1 > 0 THEN SUBSTRING(CASE
                                                    WHEN @ch2 COLLATE Cyrillic_General_CS_AS = upper(@ch2) THEN 'ZHKHTCCHSHIAIU'
                                                    WHEN @ch1 COLLATE Cyrillic_General_CS_AS = upper(@ch1) THEN 'ZhKhTcChShIaIu'
                                                    ELSE 'zhkhtcchshiaiu'
                                                END, J1*2 - 1, 2)

                    WHEN J0 > 0 THEN substring(CASE
                                                    WHEN @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) THEN 'ABVGDEEZIIKLMNOPRSTUFYE'
                                                    ELSE 'abvgdeeziiklmnoprstufye'
                                                END, J0, 1)

                    ELSE CASE
                            WHEN @ch2 COLLATE Cyrillic_General_CS_AS = UPPER(@ch2) then REPLACE(@ch1,'Щ','SHCH')
                            WHEN @ch1 COLLATE Cyrillic_General_CS_AS = UPPER(@ch1) then REPLACE(@ch1,'Щ','Shch')
                            ELSE REPLACE(@ch1,'щ','shch')
                         END
                end
            ,@counter = @counter + 1
        FROM (
                SELECT
                     PATINDEX('%' + UPPER(@ch1) + '%','ЖХЦЧШЯЮ') as J1
                    ,PATINDEX('%' + UPPER(@ch1) + '%','АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЪЬ') as J0
              ) J
    END;

    insert into @result_table (id, translate)
        select 2, @outputstring
    

    ------------------------------------------------------------------
    ------- 3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10]
    ------- в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) ------------------
     SELECT
         @counter = 1
        ,@outputstring = '';

    WHILE (@counter <= len(@inputString))
    BEGIN
        SELECT @ch1 = substring(@inputString,@counter,1);
        SELECT @ch2 = substring(@inputString,@counter,2);

        SELECT
            @outputstring = @outputstring + 
                CASE
                    WHEN J1 > 0 THEN substring( case 
                                                    when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) THEN 'ZHKHTSCHSHIAIUIE'
                                                    else 'zhkhtschshiaiuie'
                                                end, J1*2 - 1, 2)

                    WHEN J0 > 0 THEN substring(CASE
                                                    WHEN @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) THEN 'ABVGDEEZIYKLMNOPRSTUFYE'
                                                    ELSE 'abvgdeeziyklmnoprstufye'
                                                END, J0, 1)

                    ELSE CASE
                            WHEN @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then replace(@ch1,'Щ','SHCH')
                            WHEN @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) then replace(@ch1,'Щ','Shch')
                            ELSE replace(@ch1,'щ','shch')
                         END
                END
            ,@counter = @counter + 1
        FROM (
                SELECT
                     PATINDEX('%' + UPPER(@ch1) + '%','ЖХЦЧШЯЮЪ') as J1
                    ,PATINDEX('%' + UPPER(@ch1) + '%','АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЬ'       ) as J0
              ) J
    END;

    insert into @result_table (id, translate)
        select 3, @outputstring;

    --------выводим результат------------------------	
    SELECT *
    FROM
        @result_table
    WHERE
        (@transid IS NOT NULL AND id = @transid)
        OR (id IS NOT NULL AND @transid IS NULL);

END TRY

BEGIN CATCH
    THROW
    PRINT 'Error: '       + CONVERT(varchar(50), ERROR_NUMBER()) +
          ', Severity: '  + CONVERT(varchar(5), ERROR_SEVERITY()) +
          ', State: '     + CONVERT(varchar(5), ERROR_STATE()) +
          ', Procedure: ' + ISNULL(ERROR_PROCEDURE(), '-') +
          ', Line: '      + CONVERT(varchar(5), ERROR_LINE()) +
          ', User name: ' + CONVERT(sysname, ORIGINAL_LOGIN());
    PRINT ERROR_MESSAGE();
END CATCH;


GO
