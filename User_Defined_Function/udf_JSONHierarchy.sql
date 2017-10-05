IF (SELECT Compatibility_level FROM sys.databases WHERE name LIKE Db_Name())<130
  ALTER DATABASE MyDatabase SET COMPATIBILITY_LEVEL = 130;

IF EXISTS (SELECT * FROM sys.types WHERE name LIKE 'Hierarchy')
SET NOEXEC On;
GO
CREATE TYPE dbo.Hierarchy AS TABLE
/*Markup languages such as JSON and XML all represent object data as hierarchies. Although it looks very different to the entity-relational model, it isn't. It is rather more a different perspective on the same model. The first trick is to represent it as a Adjacency list hierarchy in a table, and then use the contents of this table to update the database. This Adjacency list is really the Database equivalent of any of the nested data structures that are used for the interchange of serialized information with the application, and can be used to create XML, OSX Property lists, Python nested structures or YAML as easily as JSON.
Adjacency list tables have the same structure whatever the data in them. This means that you can define a single Table-Valued  Type and pass data structures around between stored procedures. However, they are best held at arms-length from the data, since they are not relational tables, but something more like the dreaded EAV (Entity-Attribute-Value) tables. Converting the data from its Hierarchical table form will be different for each application, but is easy with a CTE. You can, alternatively, convert the hierarchical table into XML and interrogate that with XQuery
*/
(
   element_id INT primary key, /* internal surrogate primary key gives the order of parsing and the list order */
   sequenceNo [int] NULL, /* the place in the sequence for the element */
   parent_ID INT,/* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
   Object_ID INT,/* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
   NAME NVARCHAR(2000),/* the name of the object, null if it hasn't got one */
   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
)
GO
SET NOEXEC OFF
GO

IF Object_Id('dbo.udf_JSONHierarchy', 'TF') IS NOT NULL
    CREATE FUNCTION dbo.udf_JSONHierarchy 
GO

ALTER FUNCTION dbo.udf_JSONHierarchy
  (
  @JSONData VARCHAR(MAX),
  @Parent_object_ID INT = NULL,
  @MaxObject_id INT = 0,
  @type INT = null
  )
/*
Author: Phil Factor
Source link: https://www.red-gate.com/simple-talk/blogs/consuming-hierarchical-json-documents-sql-server-using-openjson/
Description: Consuming hierarchical JSON documents in SQL Server using OpenJSON

SELECT * FROM dbo.JSONHierarchy('{    "Person": 
    {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
       {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
       },
       "PhoneNumbers": 
       {
          "home":"212 555-1234",
          "fax":"646 555-4567"
       }
    }
  }'
  ,DEFAULT,DEFAULT,DEFAULT)
*/
RETURNS @ReturnTable TABLE
  (
  Element_ID INT IDENTITY(1, 1) PRIMARY KEY, /* internal surrogate primary key gives the order of parsing and the list order */
  SequenceNo INT NULL, /* the sequence number in a list */
  Parent_ID INT, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
  Object_ID INT, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
  Name NVARCHAR(2000), /* the name of the object */
  StringValue NVARCHAR(MAX) NOT NULL, /*the string representation of the value of the element. */
  ValueType VARCHAR(10) NOT NULL /* the declared type of the value represented as a string in StringValue*/
  )
AS
  BEGIN
        --the types of JSON
    DECLARE @null INT =
      0, @string INT = 1, @int INT = 2, @boolean INT = 3, @array INT = 4, @object INT = 5;
 
    DECLARE @OpenJSONData TABLE
      (
      sequence INT IDENTITY(1, 1),
      [key] VARCHAR(200),
      Value VARCHAR(MAX),
      type INT
      );
 
    DECLARE @key VARCHAR(200), @Value VARCHAR(MAX), @Thetype INT, @ii INT, @iiMax INT,
      @NewObject INT, @firstchar CHAR(1);
 
    INSERT INTO @OpenJSONData
      ([key], Value, type)
      SELECT [Key], Value, Type FROM OpenJson(@JSONData);
        SELECT @ii = 1, @iiMax = Scope_Identity()
    SELECT  @Firstchar= --the first character to see if it is an object or an array
          Substring(@JSONData,PatIndex('%[^'+CHAR(0)+'- '+CHAR(160)+']%',' '+@JSONData+'!' collate SQL_Latin1_General_CP850_Bin)-1,1)
    IF @type IS NULL AND @firstchar IN ('[','{')
                begin
           INSERT INTO @returnTable
            (SequenceNo,Parent_ID,Object_ID,Name,StringValue,ValueType)
                        SELECT 1,NULL,1,'-','', 
                           CASE @firstchar WHEN '[' THEN 'array' ELSE 'object' END
        SELECT @type=CASE @firstchar WHEN '[' THEN @array ELSE @object END,
                @Parent_object_ID  = 1, @MaxObject_id=Coalesce(@MaxObject_id, 1) + 1;
                END       
        WHILE(@ii <= @iiMax)
      BEGIN
          --OpenJSON renames list items with 0-nn which confuses the consumers of the table
        SELECT @key = CASE WHEN [key] LIKE '[0-9]%' THEN NULL ELSE [key] end , @Value = Value, @Thetype = type
          FROM @OpenJSONData
          WHERE sequence = @ii;
 
        IF @Thetype IN (@array, @object) --if we have been returned an array or object
          BEGIN
            SELECT @MaxObject_id = Coalesce(@MaxObject_id, 1) + 1;
                        --just in case we have an object or array returned
            INSERT INTO @ReturnTable --record the object itself
              (SequenceNo, Parent_ID, Object_ID, Name, StringValue, ValueType)
              SELECT @ii, @Parent_object_ID, @MaxObject_id, @key, '',
                CASE @Thetype WHEN @array THEN 'array' ELSE 'object' END;
 
            INSERT INTO @ReturnTable --and return all its children
              (SequenceNo, Parent_ID, Object_ID, [Name],  StringValue, ValueType)
                          SELECT SequenceNo, Parent_ID, Object_ID, 
                                [Name],
                                StringValue,
                                ValueType
              FROM dbo.udf_JSONHierarchy(@Value, @MaxObject_id, @MaxObject_id, @type);
                        SELECT @MaxObject_id=Max(Object_id)+1 FROM @ReturnTable
                  END;
        ELSE
          INSERT INTO @ReturnTable
            (SequenceNo, Parent_ID, Object_ID, Name, StringValue, ValueType)
            SELECT @ii, @Parent_object_ID, NULL, @key, @Value,
              CASE @Thetype WHEN @string THEN 'string'
                WHEN @null THEN 'null'
                WHEN @int THEN 'int'
                WHEN @boolean THEN 'boolean' ELSE 'int' END;
 
        SELECT @ii = @ii + 1;
      END;
 
    RETURN;
  END;
GO
