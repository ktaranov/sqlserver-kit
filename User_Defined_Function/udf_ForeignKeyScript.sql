/*
Author: Louis Davidson
Original link: http://sqlblog.com/blogs/louis_davidson/archive/2017/05/24/utility-to-script-a-foreign-key-constraint.aspx
*/


CREATE FUNCTION udf_ForeignKeyScript(
    @schema_name sysname,
    @foreign_key_name sysname,
    @constraint_status VARCHAR(20) = 'AS_WAS' --ENABLED, UNTRUSTED, DISABLED
                                              --ANY OTHER VALUES RETURN NULL
)

RETURNS NVARCHAR(MAX)
AS
BEGIN
    --based on code to gen list of FK constraints from this article by Aaron Bertrand 
    --https://www.mssqltips.com/sqlservertip/3347/drop-and-recreate-all-foreign-key-constraints-in-sql-server/

    --and code from John Paul Cook:
    --https://social.technet.microsoft.com/wiki/contents/articles/2958.script-to-create-all-foreign-keys.aspx
 
    DECLARE @script NVARCHAR(MAX);
 
    IF @constraint_status NOT IN ('AS_WAS','ENABLED','UNTRUSTED','DISABLED')
        RETURN NULL;
 
    SELECT @script
        =  N'ALTER TABLE ' + QUOTENAME(cs.name) + '.' + QUOTENAME(ct.name) + CHAR(13) + CHAR(10) + '   '
            --code added to set the constraint's status if it is not to be checked (and
            --in the case of disabled, you create it not trusted and disable it
          + CASE
                WHEN(is_not_trusted = 1
                     OR fk.is_disabled = 1
                     OR @constraint_status IN ( 'UNTRUSTED', 'DISABLED' ))
                    --not forcing it to be enabled
                    AND @constraint_status <> 'ENABLED' THEN
                    'WITH NOCHECK '
                ELSE
                    ''
            END
          + 'ADD CONSTRAINT ' + QUOTENAME(fk.name) + CHAR(13) + CHAR(10) + 
          '      FOREIGN KEY ('
          + STUFF((SELECT   ',' + QUOTENAME(c.name)
                   -- get all the columns in the constraint table 
                   FROM     sys.columns c
                            INNER JOIN sys.foreign_key_columns fkc
                                ON fkc.parent_column_id = c.column_id
                                   AND fkc.parent_object_id = c.object_id
                   WHERE    fkc.constraint_object_id = fk.object_id
                   ORDER BY fkc.constraint_column_id
        FOR XML PATH(N''), TYPE).value(N'.[1]', N'nvarchar(max)'),1,1,N'') 
          + ')' + CHAR(13) + CHAR(10) + '         REFERENCES ' + QUOTENAME(rs.name) + '.' + QUOTENAME(rt.name) 
          + '('
          + STUFF((SELECT   ',' + QUOTENAME(c.name)
                   -- get all the referenced columns 
                   FROM     sys.columns c
                            INNER JOIN sys.foreign_key_columns fkc
                                ON fkc.referenced_column_id = c.column_id
                                   AND fkc.referenced_object_id = c.object_id
                   WHERE    fkc.constraint_object_id = fk.object_id
                   ORDER BY fkc.constraint_column_id
        FOR XML PATH(N''), TYPE).value(N'.[1]', N'nvarchar(max)'),1,1, N'') 
         + CASE fk.update_referential_action
                WHEN 1 THEN CHAR(13) + CHAR(10) + '         ON UPDATE CASCADE '
                WHEN 2 THEN CHAR(13) + CHAR(10) + '         ON UPDATE SET NULL '
                WHEN 3 THEN CHAR(13) + CHAR(10) + '         ON UPDATE SET DEFAULT '
                ELSE '' --could also say "no action" which is the default
           END
          + CASE fk.delete_referential_action
                WHEN 1 THEN CHAR(13) + CHAR(10) + '         ON DELETE CASCADE '
                WHEN 2 THEN CHAR(13) + CHAR(10) + '         ON DELETE SET NULL '
                WHEN 3 THEN CHAR(13) + CHAR(10) + '         ON DELETE SET DEFAULT '
                ELSE '' --could also say "no action" which is the default
            END
          + CASE fk.is_not_for_replication
                WHEN 1 THEN CHAR(13) + CHAR(10) + '         NOT FOR REPLICATION '
                ELSE ''
            END
          + ');'
          + CASE
                WHEN(fk.is_disabled = 1 AND @constraint_status IN ( 'DISABLED', 'AS_WAS' ))
                     OR @constraint_status = 'DISABLED'
                     THEN CHAR(13) + CHAR(10)+  CHAR(13) + CHAR(10)+   'ALTER TABLE ' + QUOTENAME(cs.name) + '.' + QUOTENAME(ct.name) + CHAR(13) + CHAR(10)
                                   + '   NOCHECK CONSTRAINT ' + QUOTENAME(fk.name) + ';'
                ELSE
                    ''
            END
    FROM   sys.foreign_keys fk
           INNER JOIN sys.tables rt
               -- referenced table 
               ON fk.referenced_object_id = rt.object_id
           INNER JOIN sys.schemas rs
               ON rt.schema_id = rs.schema_id
           INNER JOIN sys.tables ct
               -- constraint table 
               ON fk.parent_object_id = ct.object_id
           INNER JOIN sys.schemas cs
               ON ct.schema_id = cs.schema_id
    WHERE  OBJECT_SCHEMA_NAME(fk.object_id) = @schema_name
           AND fk.name = @foreign_key_name;
    RETURN @script;
END;
GO
