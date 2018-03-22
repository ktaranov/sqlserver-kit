IF OBJECT_ID('dbo.usp_TransliterationEN2RU', 'P') IS NULL
    EXECUTE ('CREATE PROCEDURE dbo.usp_TransliterationEN2RU AS SELECT 1;');
GO


ALTER PROCEDURE usp_TransliterationEN2RU
(
    @inputstring varchar(8000),
    @transid int = null
) as
/*
.EXAMPLE
  EXEC usp_TransliterationEN2RU @inputstring = 'Шрамко Александр';

.NOTE
  Author: Шрамко Александр
  Original link: https://github.com/shramko/mssql/blob/master/transliteration.sql
*/
BEGIN
    /*
        @transid - ид варианта транслитерации. сейчас используются следующие
        1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 http://rosadvokat.ru/open.php?id=11800742_1
        2 - в соответствии с ГОСТ Р 52535.1-2006 http://www.complexdoc.ru/pdf/%D0%93%D0%9E%D0%A1%D0%A2%20%D0%A0%2052535.1-2006/gost_r_52535.1-2006.pdf
        3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10] в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) http://www.icao.int/publications/Documents/9303_p1_v1_cons_ru.pdf

    */

SET @inputstring = UPPER(@inputstring);

    DECLARE
         @outputstring VARCHAR(8000)
        ,@counter      INT
        ,@ch1          VARCHAR(10)
        ,@ch2          VARCHAR(10)
        ,@ch3          VARCHAR(10);
    
    declare 
        @result_table table (id int, translate varchar(8000))

    ------------------------------------------------------------------	
    ------- 1 - в соответствии с приложением 6 приказа МВД России от 26 мая 1997 г. N 310 ------------------	 	 
     select  
         @counter = 1
        ,@outputstring = ''
    
    --подготовка случаев: С - между двумя гласными выражается - ss - Goussev.
    declare @t1 table (ch char)
    insert into @t1
              select 'А'
        union select 'Е'
        union select 'Ё'
        union select 'И'
        union select 'О'
        union select 'У'
        union select 'Ы'
        union select 'Э'
        union select 'Ю'
        union select 'Я'
    
    declare @t2 table (ch char)
    insert into @t2
        select 'С';
    
    declare @str varchar(4000) = '';
    select @str = @str + t1.ch + t2.ch + t3.ch + '|' from @t1 t1, @t2 t2, @t1 t3
    -----------------------------------------------------------------------------
    -- exec transliteration 'ВаСиньин еГЕпа. ксения чьё ю вася мясо шняжка ' , 1
    while (@counter <= len(@inputstring))
    begin
        select @ch1 = substring(@inputstring,@counter,1)
        select @ch2 = substring(@inputstring,@counter,2)


        select  
            @outputstring = @outputstring + 
                case
                    when J8 > 0 then 
                                    case 
                                        when @ch2 collate Cyrillic_General_CS_AS = upper(@ch2) then'INE'
                                        else 'ine'
                                    end
                    when J7 > 0 then 
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
                                        else 'guia'
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
                            ELSE replace(@ch1,'щ','shtch')
                         END 
                end
            ,@counter = @counter + 
                case					
                    when J2 + J3 + J4 + J6 + J7 + J8 >0 then 2
                    else 1
                end
        FROM (
            SELECT
                 PATINDEX('%|' + SUBSTRING(@inputstring,@counter,3) + '|%','|ИН |ИН,|ИН.|ИН;|ИН:|' )    AS J8 -- Фамилия на "ин" пишутся с "e" - Vassine - Васин.
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter,2) + '|%','|ЬЕ|ЬЁ|' )                  AS J7 -- Если в фамилии после "ь" следует "e", то пишется "ie"
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter,2) + '|%','|КС|' )                     AS J6 -- Сочетание "кс" во французском тексте пишется как "х"
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter-1,3) + '|%','|'+ @str )                AS J5 -- С - между двумя гласными выражается - ss
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter,2) + '|%','|ГЯ|' )                     AS J4 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter,2) + '|%','|ГЮ|' )                     AS J3 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%|' + SUBSTRING(@inputstring,@counter,2) + '|%','|ГЕ||ГЭ||ГИ||ГЙ||ГЫ|')      AS J2 --G,g перед e, i, у пишется с "u" (gue, gui, guy)
                ,PATINDEX('%'  + SUBSTRING(@inputstring,@counter,1) +  '%','УХЦШЯ')                     AS J1
                ,PATINDEX('%'  + SUBSTRING(@inputstring,@counter,1)  +  '%','ЧЮ')                        AS J11
                ,PATINDEX('%'  + SUBSTRING(@inputstring,@counter,1) +  '%','АБВГДЕЁЖЗИЙКЛМНОПРСТФЫЭЪЬ') AS J0
            ) J
    END;

    insert into @result_table
    select 1, @outputstring;


    ------------------------------------------------------------------	
    ------- 2 - в соответствии с ГОСТ Р 52535.1-2006 ------------------	 
     SELECT
         @counter = 1
        ,@outputstring = '';

    WHILE (@counter <= len(@inputstring))
    BEGIN
        SELECT @ch1 = SUBSTRING(@inputstring,@counter,1)
        SELECT @ch2 = SUBSTRING(@inputstring,@counter,2)
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
                     PATINDEX('%' + @ch1 + '%','ЖХЦЧШЯЮ') as J1
                    ,PATINDEX('%' + @ch1 + '%','АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЪЬ') as J0
              ) J
    end

    insert into @result_table (id, translate)
        select 2, @outputstring
    

    ------------------------------------------------------------------	
    ------- 3 - в соответствии с п. 97 приказа ФМС России N 320 от 15 октября 2012 г.[10] в соответствии с рекомендованным ИКАО международным стандартом (Doc 9303, часть 1, добавлении 9 к разделу IV) ------------------	 
     select  		 
         @counter = 1
        ,@outputstring = ''
         
    WHILE (@counter <= len(@inputstring))
    BEGIN
        SELECT @ch1 = substring(@inputstring,@counter,1);
        SELECT @ch2 = substring(@inputstring,@counter,2);

        SELECT
            @outputstring = @outputstring + 
                CASE
                    WHEN J1 > 0 THEN substring( case 
                                                    when @ch1 collate Cyrillic_General_CS_AS = upper(@ch1) THEN 'ZHKHTSCHSHIAIUIE'
                                                    else 'zhkhtschshiaiuie'
                                                end	, J1*2 - 1, 2)				

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
                     PATINDEX('%' + @ch1 + '%','ЖХЦЧШЯЮЪ') as J1
                    ,PATINDEX('%' + @ch1 + '%','АБВГДЕЁЗИЙКЛМНОПРСТУФЫЭЬ'       ) as J0
              ) J
    END;

    insert into @result_table (id, translate)
        select 3, @outputstring;

    --------выводим результат------------------------	
    SELECT *
    FROM
        @result_table
    WHERE
        (@transid is not null and id = @transid)
        or (id is not null and @transid is null);

END;
GO
