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
 Purpose:
 Given a string (@String) and a pattern (@Pattern) of characters to remove,
 remove the patterned characters from the string.

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
