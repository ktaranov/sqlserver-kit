# Microsoft SQL Server functions
Start all functions from if exist statement:
```sql
IF OBJECT_ID('dbo.udf_FunctionName', 'FN') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_FunctionName() RETURNS INT AS BEGIN RETURN 1 END;');
GO


ALTER FUNCTION dbo.udf_FunctionName(
```

It helps to save all grants for function (analog `CREATE OR REPLACE PROCEDURE` in [Oracle](http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_6009.htm 'Offical Oracle Documentation')).


## [udf_PatExclude8K](udf_PatExclude8K.sql)
Author: Alan Burstein<br/>
Original link: http://www.sqlservercentral.com/scripts/T-SQL/117890/<br />
Tested on SQL Server version: 2008/2012/2014/2016<br />
Purpose: Given a string (@String) and a pattern (@Pattern) of characters to remove, remove the patterned characters from the string.<br />
Usage:
```sql
--===== Basic Syntax Example
 SELECT CleanedString 
 FROM dbo.udf_PatExclude8K(@String, @Pattern);

--===== Remove all but Alpha characters
 SELECT CleanedString
 FROM dbo.SomeTable st
 CROSS APPLY dbo.udf_PatExclude8K(st.SomeString,'%[^A-Za-z]%');

--===== Remove all but Numeric digits
 SELECT CleanedString
 FROM dbo.SomeTable st
 CROSS APPLY dbo.udf_PatExclude8K(st.SomeString,'%[^0-9]%');
```


## [udf_GetNumsAB](udf_GetNumsAB.sql)
Author: Alan Burstein<br/>
Original link: http://www.sqlservercentral.com/scripts/Set+Based/139370/<br />
Tested on SQL Server version: 2008/2012/2014/2016<br />
Purpose: Creates up to 100,544,625 sequential numbers beginning with @low and ending with @high. Used to replace iterative methods such as loops, cursors and recursive CTEs to solve SQL problems. Based on Itzik Ben-Gan's getnums function with some tweeks and enhancements and added functionality. The logic for getting rn to begin at 0 or 1 is based comes from Jeff Moden's fnTally function.<br />
Usage:
```sql
--===== 1. Using RN (rownumber)
 -- (1.1) The best way to get the numbers 1,2,3...@high (e.g. 1 to 5):
 SELECT RN FROM dbo.udf_GetNumsAB(1,5,1,1);

 -- (1.2) The best way to get the numbers 0,1,2...@high-1 (e.g. 0 to 5):
 SELECT RN FROM dbo.udf_GetNumsAB(0,5,1,0);

--===== 2. Using N1
 -- (2.1) To begin with numbers other than 0 or 1 use N1 (e.g. -3 to 3):
 SELECT N1 FROM dbo.udf_GetNumsAB(-3,3,1,1);

 -- (2.2) ROW_NUMBER() is built in. If you want a ROW_NUMBER() include RN:
 SELECT RN, N1 FROM dbo.udf_GetNumsAB(-3,3,1,1);

 -- (2.3) If you wanted a ROW_NUMBER() that started at 0 you would do this:
 SELECT RN, N1 FROM dbo.udf_GetNumsAB(-3,3,1,0);

--===== 3. Using N2 and @gap
 -- (3.1) To get 0,10,20,30...100, set @low to 0, @high to 100 and @gap to 10:
 SELECT N1 FROM dbo.udf_GetNumsAB(0,100,10,1);

 -- (3.2) Note that N2=N1+@gap; this allows you to create a sequence of ranges.
 --       For example, to get (0,10),(10,20),(20,30).... (90,100):
 SELECT N1, N2 FROM dbo.udf_GetNumsAB(0,90,10,1);

 -- (3.3) Remember that a rownumber is included and it can begin at 0 or 1:
 SELECT RN, N1, N2 FROM dbo.udf_GetNumsAB(0,90,10,1);

--===== (4) A real life example using RN, N1 and N2:
 -- Beginning with @StartDate, to generate ranges of weeks that occur between 
 -- @startDate & @EndDate:
```


## [udf_Is16digitValidCard](udf_Is16digitValidCard.sql)
Author: Phil Factor<br/>
Original link: https://www.simple-talk.com/blogs/2016/02/16/the-luhn-algorithm-in-sql/<br />
Tested on SQL Server version: 2008/2012/2014/2016<br />
Description: The Luhn test is used by most credit card companies to check the basic validity of a credit card number. It is not an anti-fraud measure but a quick check on data corruption. It still allows any digits that are odd or even to be switched in the sequence. Most credit cards are compatible with Luhn algorithm.
1. It is often applied to SSNs, company organization numbers, and OCR numbers for internet payments. The algorithm is simple.
2. Take out the spaces from the string containing the credit card numbers
3. Reverse the string containing the credit card numbers.
4. Sum every digit whose order in the sequence is an odd number (1,3,5,7 …) to create a partial sum s1
5. Multiply each even digit by two, and then sum the digits of the number if the answer is greater than nine. (e,g if digit is 8 then 8*2=16, then add the resulting digits: 1+6=7).
6. Sum the partial sums of the even digits to form s2
7. if s1 + s2 ends in zero then the original number is in the form of a valid credit card number as verified by the Luhn test.


## [udf_IsValidCard](udf_IsValidCard.sql)
Author: Phil Factor<br/>
Original link: https://www.simple-talk.com/blogs/2016/02/16/the-luhn-algorithm-in-sql/<br />
Tested on SQL Server version: 2008/2012/2014/2016<br />
Description: The Luhn test is used by most credit card companies to check the basic validity of a credit card number. It is not an anti-fraud measure but a quick check on data corruption. It still allows any digits that are odd or even to be switched in the sequence. Most credit cards are compatible with Luhn algorithm.
1. It is often applied to SSNs, company organization numbers, and OCR numbers for internet payments. The algorithm is simple.
2. Take out the spaces from the string containing the credit card numbers
3. Reverse the string containing the credit card numbers.
4. Sum every digit whose order in the sequence is an odd number (1,3,5,7 …) to create a partial sum s1
5. Multiply each even digit by two, and then sum the digits of the number if the answer is greater than nine. (e,g if digit is 8 then 8*2=16, then add the resulting digits: 1+6=7).
6. Sum the partial sums of the even digits to form s2
7. if s1 + s2 ends in zero then the original number is in the form of a valid credit card number as verified by the Luhn test.
