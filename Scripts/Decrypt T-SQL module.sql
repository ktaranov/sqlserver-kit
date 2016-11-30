/*
Author: Daniel Hutmacher
Original link: https://sqlsunday.com/2013/03/24/decrypting-sql-objects/

-- Enable Dedicated Administrator Connection
EXEC sp_configure 'remote admin connections', 1;
GO
RECONFIGURE
GO

-- Who using the Dedicated Admin Connection
SELECT
    CASE
    WHEN ses.session_id= @@SPID THEN 'It''s me! '
    ELSE '' END
    + coalesce(ses.login_name,'???') as WhosGotTheDAC,
    ses.session_id,
    ses.login_time,
    ses.status,
    ses.original_login_name
FROM sys.endpoints as en
INNER JOIN sys.dm_exec_sessions ses ON en.endpoint_id=ses.endpoint_id
WHERE en.name='Dedicated Admin Connection';
*/


SET NOCOUNT ON
DECLARE @owner sysname='dbo', @name sysname='sp_someprocedure';

-----------------------------------------------------------
--- Declarations:

DECLARE @offset            int=1;
DECLARE @datalength        int;
DECLARE @encrypted_object  nvarchar(max);
DECLARE @decrypted_object  nvarchar(max)=N'';
DECLARE @fake_object       nvarchar(max);
DECLARE @fake_encrypted_object nvarchar(max);
DECLARE @lf                nvarchar(max)=NCHAR(13)+NCHAR(10);
DECLARE @type              varchar(128);
DECLARE @object_id         int=OBJECT_ID('['+@owner+'].['+@name+']');
DECLARE @a int, @b int, @c int;

--- Check that the object exists
IF (@object_id IS NULL) BEGIN;
    RAISERROR('Object does not exist.', 16, 1);
    RETURN;
END;

--- Check that the object really is encrypted.
IF (NOT EXISTS (SELECT TOP 1 * FROM sys.sql_modules
        WHERE [object_id]=@object_id AND [definition] IS NULL)) BEGIN;
    RAISERROR('Object is not encrypted.', 16, 1);
    RETURN;
END;

--- Store the SQL type name of the object in @type
SELECT @type=(CASE [type]
    WHEN 'P' THEN 'PROCEDURE'
    WHEN 'TR' THEN 'TRIGGER'
    WHEN 'V' THEN 'VIEW'
    ELSE 'FUNCTION' END)
FROM sys.objects
WHERE [object_id]=@object_id;

--- @encrypted_object is the encrypted, binary, version of the code:
SELECT TOP 1 @encrypted_object=imageval
FROM sys.sysobjvalues
WHERE [objid]=@object_id AND valclass=1 and subobjid=1;

SET @datalength=DATALENGTH(@encrypted_object)/2;


--- We're going to ALTER the existing object to a "known plaintext"
--- with encryption. That way, we can reverse-engineer the encryption
--- key, using the new encrypted object.
--- All of this is done in a transaction that we'll roll back when
--- we're done with it.
SET @fake_object=N'ALTER '+@type+N' ['+@owner+N'].['+@name+N']
WITH ENCRYPTION AS
';

--- Fill the fake object with dashes ("-") until it's as long as
--- the encrypted object.
WHILE (DATALENGTH(@fake_object)/2<@datalength) BEGIN;
    IF (DATALENGTH(@fake_object)/2+4000<@datalength)
        SET @fake_object=@fake_object+REPLICATE(N'-', 4000);
    ELSE
        SET @fake_object=@fake_object+REPLICATE(N'-',
            @datalength-(DATALENGTH(@fake_object)/2));
END;

BEGIN TRANSACTION;
    --- Implement the fake encrypted object:
    EXEC(@fake_object);

    --- Retrieve the encrypted version of the "known plaintext".
    SELECT TOP 1 @fake_encrypted_object=imageval
    FROM sys.sysobjvalues
    WHERE [objid]=@object_id AND valclass=1 and subobjid=1;

    --- Now that we have the encrypted fake object, roll back
    --- the transaction, so we don't break the original object.
ROLLBACK TRANSACTION;


--- Change the @fake_object from ALTER to CREATE (because this is
--- how the encrypted objects are stored in the database!)
SET @fake_object='CREATE'+SUBSTRING(@fake_object, 6, LEN(@fake_object));

-----------------------------------------------------------
--- Perform decryption using the three versions: the encrypted
--- code, the plaintext fake code and the encrypted fake code.

WHILE (@offset<=@datalength) BEGIN;

    SELECT
        @a=UNICODE(SUBSTRING(@encrypted_object,      @offset, 1)),
        @b=UNICODE(SUBSTRING(@fake_object,           @offset, 1)),
        @c=UNICODE(SUBSTRING(@fake_encrypted_object, @offset, 1));

    SELECT @decrypted_object=@decrypted_object+NCHAR(@a^(@b^@c)),
        @offset=@offset+1;
END;


-----------------------------------------------------------
--- Print the results:

WHILE (@decrypted_object IS NOT NULL) BEGIN;
    PRINT LEFT(@decrypted_object,
        CHARINDEX(@lf, @decrypted_object+@lf)-1);

    SET @decrypted_object=NULLIF(
        SUBSTRING(@decrypted_object,
        CHARINDEX(@lf, @decrypted_object+@lf)+LEN(@lf),
            LEN(@decrypted_object)), '');
END;
GO
