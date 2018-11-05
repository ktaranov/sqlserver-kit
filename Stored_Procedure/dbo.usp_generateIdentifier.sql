/*
Author: Remus Rusanu
Original link: https://stackoverflow.com/questions/1324063/generating-random-strings-with-t-sql/1324390#1324390
Desctiption: Generating random strings with T-SQL
*/

IF OBJECT_ID('dbo.usp_generateIdentifier', 'P') IS NULL
EXECUTE('CREATE PROCEDURE dbo.usp_generateIdentifier as SELECT 1');
GO

alter procedure dbo.usp_generateIdentifier
    @minLen int = 1
    , @maxLen int = 256
    , @seed int output
    , @string varchar(8000) output
as
begin
    set nocount on;
    declare @length int;
    declare @alpha varchar(8000)
        , @digit varchar(8000)
        , @specials varchar(8000)
        , @first varchar(8000)
    declare @step bigint = rand(@seed) * 2147483647;

    select @alpha = 'qwertyuiopasdfghjklzxcvbnm'
        , @digit = '1234567890'
        , @specials = '_@# '
    select @first = @alpha + '_@';

    set  @seed = (rand((@seed+@step)%2147483647)*2147483647);

    select @length = @minLen + rand(@seed) * (@maxLen-@minLen)
        , @seed = (rand((@seed+@step)%2147483647)*2147483647);

    declare @dice int;
    select @dice = rand(@seed) * len(@first),
        @seed = (rand((@seed+@step)%2147483647)*2147483647);
    select @string = substring(@first, @dice, 1);

    while 0 < @length 
    begin
        select @dice = rand(@seed) * 100
            , @seed = (rand((@seed+@step)%2147483647)*2147483647);
        if (@dice < 10) -- 10% special chars
        begin
            select @dice = rand(@seed) * len(@specials)+1
                , @seed = (rand((@seed+@step)%2147483647)*2147483647);
            select @string = @string + substring(@specials, @dice, 1);
        end
        else if (@dice < 10+10) -- 10% digits
        begin
            select @dice = rand(@seed) * len(@digit)+1
                , @seed = (rand((@seed+@step)%2147483647)*2147483647);
            select @string = @string + substring(@digit, @dice, 1);
        end
        else -- rest 80% alpha
        begin
            declare @preseed int = @seed;
            select @dice = rand(@seed) * len(@alpha)+1
                , @seed = (rand((@seed+@step)%2147483647)*2147483647);

            select @string = @string + substring(@alpha, @dice, 1);
        end

        select @length = @length - 1;   
    end
end
go

/*
When running the tests the caller generates a random seed it associates with the test run (saves it in the results table), then passed along the seed, similar to this:

declare @seed int;
declare @string varchar(256);

select @seed = 1234; -- saved start seed

exec usp_generateIdentifier 
    @seed = @seed output
    , @string = @string output;
print @string;  
exec usp_generateIdentifier 
    @seed = @seed output
    , @string = @string output;
print @string;  
exec usp_generateIdentifier 
    @seed = @seed output
    , @string = @string output;
print @string;  
*/
