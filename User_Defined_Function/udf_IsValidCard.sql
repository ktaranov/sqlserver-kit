/*
Original link: https://www.simple-talk.com/blogs/2016/02/16/the-luhn-algorithm-in-sql/
Author: Phil Factor
Description: The Luhn test is used by most credit card companies to check the basic validity of a credit card number. It is not an anti-fraud measure but a quick check on data corruption. It still allows any digits that are odd or even to be switched in the sequence. Most credit cards are compatible with Luhn algorithm.
1. It is often applied to SSNs, company organization numbers, and OCR numbers for internet payments. The algorithm is simple.
2. Take out the spaces from the string containing the credit card numbers
3. Reverse the string containing the credit card numbers.
4. Sum every digit whose order in the sequence is an odd number (1,3,5,7 …) to create a partial sum s1
5. Multiply each even digit by two, and then sum the digits of the number if the answer is greater than nine. (e,g if digit is 8 then 8*2=16, then add the resulting digits: 1+6=7).
6. Sum the partial sums of the even digits to form s2
7. if s1 + s2 ends in zero then the original number is in the form of a valid credit card number as verified by the Luhn test.
*/
IF OBJECT_ID(N'dbo.udf_IsValidCard', N'FN') IS NULL
EXECUTE('CREATE FUNCTION dbo.udf_IsValidCard() RETURNS INT AS BEGIN RETURN 1 END;');
GO

ALTER FUNCTION dbo.udf_IsValidCard(
    @TheCard VARCHAR(20)
)
RETURNS TINYINT
AS
/*
SELECT dbo.udf_Is16digitValidCard('5019710710103742')
*/
BEGIN
       RETURN (SELECT CASE
              WHEN Card LIKE '%[^0-9]%' THEN 0
              WHEN Card IS NULL THEN 0
              WHEN   (
                     + 2 * cast(substring(Card, 1, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 1, 1) AS TINYINT) % 10
                     + cast(substring(Card, 2, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 3, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 3, 1) AS TINYINT) % 10
                     + cast(substring(Card, 4, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 5, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 5, 1) AS TINYINT) % 10
                     + cast(substring(Card, 6, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 7, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 7, 1) AS TINYINT) % 10
                     + cast(substring(Card, 8, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 9, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 9, 1) AS TINYINT) % 10
                     + cast(substring(Card, 10, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 11, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 11, 1) AS TINYINT) % 10
                     + cast(substring(Card, 12, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 13, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 13, 1) AS TINYINT) % 10
                     + cast(substring(Card, 14, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 15, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 15, 1) AS TINYINT) % 10
                     + cast(substring(Card, 16, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 17, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 17, 1) AS TINYINT) % 10
                     + cast(substring(Card, 18, 1) AS TINYINT)
                     + 2 * cast(substring(Card, 19, 1) AS TINYINT) / 10
                     + 2 * cast(substring(Card, 19, 1) AS TINYINT) % 10
                     + cast(substring(Card, 20, 1) AS TINYINT)
              ) % 10 = 0 THEN 1
              ELSE 0
       END FROM (
             VALUES (
                  convert(CHAR(20),
                  CASE WHEN len(@TheCard)%2=1 THEN '0' ELSE '' END
                     +@TheCard+'00000000'
                     )
                )
           )f(card));
END;
GO
