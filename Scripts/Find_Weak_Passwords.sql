/*
<documentation>
  <summary>Find weak passwords in sys.sql_logins</summary>
  <returns>1 data set: select query.</returns>
  <issues>No</issues>
  <author>Mitch Wheat</author>
  <created>2019-07-21</created>
  <modified>2019-08-16 by Konstantin Taranov</modified>
  <version>1.1</version>
  <sourceLink>https://github.com/ktaranov/sqlserver-kit/blob/master/Scripts/Find_Weak_Passwords.sql</sourceLink>
  <originalLink>https://mitchwheat.com/2019/07/21/sql-server-security-find-users-with-weak-passwords/</originalLink>
</documentation>
*/

SET NOCOUNT ON;

IF OBJECT_ID('tempdb..#CommonPasswords') IS NOT NULL
    DROP TABLE #CommonPasswords;
 
CREATE TABLE #CommonPasswords(Password varchar(30) not null primary key);
 
INSERT INTO #CommonPasswords(Password) VALUES
(''),
('123'),
('1234'),
('12345'),
('123456'),
('1234567'),
('12345678'),
('123456789'),
('1234567890'),
('qwerty'),
('qwerty123'),
('password'),
('password1'),
('password123'),
('111111'),
('1111111'),
('abc123'),
('666666'),
('7777777'),
('654321'),
('123123'),
('123321'),
('iloveyou'),
('admin'),
('nimda'),
('welcome'),
('!@#$%^&*'),
('aa123456'),
('sunshine'),
('princess' ),
('football'),
('monkey'),
('charlie'),
('donald'),
('dragon'),
('passw0rd'),
('trustno1'),
('letmein'),
('whatever'),
('hello'),
('freedom'),
('master'),
('starwars'),
('qwertyuiop'),
('qazwsx'),
('login');
 
SELECT
    name,
    create_date,
    is_disabled
FROM
    sys.sql_logins sl (nolock)
    cross apply #CommonPasswords cp
WHERE
    PWDCOMPARE(cp.Password, sl.password_hash) = 1
 UNION ALL
 SELECT
    name,
    create_date,
    is_disabled
FROM
    sys.sql_logins sl (nolock)
WHERE
    PWDCOMPARE(sl.name, sl.password_hash) = 1; -- password same as username
