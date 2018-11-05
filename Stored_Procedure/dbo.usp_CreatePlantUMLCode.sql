/*
Author: Phil Factor
Original link: https://www.simple-talk.com/sql/sql-tools/automatically-creating-uml-database-diagrams-for-sql-server/
*/
 /* we are just using this for chopping up a space-delimited list of database objects. If you
have embedded spaces in your object names then tough. You'll have to do it differently*/
 
IF EXISTS (Select * from sys.xml_schema_collections where name like 'ObjectListParameter')
  DROP XML SCHEMA COLLECTION ObjectListParameter
GO
CREATE XML SCHEMA COLLECTION ObjectListParameter as '
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="Object">
       <xs:simpleType>
              <xs:list itemType="xs:string" />
       </xs:simpleType>
</xs:element>
</xs:schema>'
GO

    -- does a particular procedure  exist
IF EXISTS ( SELECT 1 FROM sys.objects
              WHERE  object_ID= object_ID('dbo.usp_CreatePlantUMLCode'))
  SET NOEXEC ON
GO

-- if the routine exists this isn't executed
CREATE PROCEDURE dbo.usp_CreatePlantUMLCode
AS Select 'created, but not implemented yet.'--just anything will do
GO
-- the following section will be always executed
SET NOEXEC OFF
GO

Alter procedure usp_CreatePlantUMLCode
@ObjectsToShow NVarchar(400)=null, -- space-delimited list of database objects
@dependenciesOf NVarchar(400)=null, --show the first order objects that reference or otherwise depend on it
@dependsOn  NVarchar(400)=null, --show the objects that it depends on
@MyPlantUMLStatement varchar(max) output --the code to use for the diagram
/*
Examples of use:
Declare @ThePlantUMLCode Varchar(max)
execute usp_CreatePlantUMLCode @ObjectsToShow='HumanResources.employee person.person',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
Declare @ThePlantUMLCode Varchar(max)
execute usp_CreatePlantUMLCode @DependsOn='person.address',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
Declare @ThePlantUMLCode Varchar(max)
execute usp_CreatePlantUMLCode @DependenciesOf='person.address',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
Declare @ThePlantUMLCode Varchar(max)
execute usp_CreatePlantUMLCode @ObjectsToShow='HumanResources.employee person.person HumanResources.vEmployeeDepartmentHistory  dbo.ufnGetContactInformation',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
execute usp_CreatePlantUMLCode @ObjectsToShow='dbo.ufnGetContactInformation',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
Declare @ThePlantUMLCode Varchar(max)
execute usp_CreatePlantUMLCode @ObjectsToShow='HumanResources.employee person.person HumanResources.vEmployeeDepartmentHistory ',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
 
execute usp_CreatePlantUMLCode @ObjectsToShow='HumanResources.vEmployeeDepartmentHistory  dbo.ufnGetContactInformation',
       @MyPlantUMLStatement=@ThePlantUMLCode output
select @ThePlantUMLCode
*/
as
--has the user given us a list of objects?
Declare @ObjectsToDo table(Object_ID int primary key) --check only specified once!
declare @xml_data xml(ObjectListParameter)
set @xml_data='<Object>'+ @ObjectsToShow +'</Object>'
Declare @ii int
Select @ii=0 --what has been specified in the parameters
if (@ObjectsToShow is not null) set @ii=@ii+1
if (@DependenciesOf is not null) set @ii=@ii+1
if (@DependsOn is not null) set @ii=@ii+1
if (@ii<1)
  begin raiserror('Sorry, but you''ll need  to specify what to draw!', 16,1);return;end
if (@ii>1)
  begin raiserror('Sorry, only one parameter can be used at a time', 16,1);return;end
/* if he has given a list, then we need to parse the list and find the IDs of reach
database object that has been specified */
if  @ObjectsToShow is not null
       begin
       insert into @ObjectsToDo
         select object_ID(T.ref.value('.', 'sysname'))
        from (Select @xml_data.query('
                     for $i in data(/Object) return
                     element item { $i }
              '))  A(list)
        cross apply A.List.nodes('/item') T(ref)
       end
--does the user want to see the dependencies
if @DependenciesOf is not null
       begin --get all the foreign key references
       insert into @ObjectsToDo
         Select referenced_object_ID
           from sys.foreign_keys
           where parent_object_id=object_ID(@DependenciesOf)
       union all --and all the objects that refer to it
         Select referenced_ID from sys.sql_expression_dependencies
           where referencing_id=object_ID(@DependenciesOf)
             and referenced_ID is not null
             and is_schema_bound_reference =0
    union --and insert the object itself
         Select object_ID(@DependenciesOf)
       end
if @DependsOn is not null
       begin --does the user want a diagram of all the objects that the object depends on?
       insert into @ObjectsToDo --insert all the foreign key relationships
      Select parent_object_ID
        from sys.foreign_keys
        where referenced_Object_id=object_ID(@DependsOn)
      union all --and all the references this object makes
      Select referencing_ID from sys.sql_expression_dependencies
        where referenced_id=object_ID(@DependsOn)
          and is_schema_bound_reference =0
    union
         Select object_ID(@DependsOn) --and add the object itself
       end
 
Select @MyPlantUMLStatement='!define table(x) class x << (T,mistyrose) >> 
!define view(x) class x << (V,lightblue) >> 
!define table(x) class x << (T,mistyrose) >>
!define tr(x) class x << (R,red) >>
!define tf(x) class x << (F,darkorange) >> 
!define af(x) class x << (F,white) >> 
!define fn(x) class x << (F,plum) >> 
!define fs(x) class x << (F,tan) >> 
!define ft(x) class x << (F,wheat) >> 
!define if(x) class x << (F,gaisboro) >> 
!define p(x) class x << (P,indianred) >> 
!define pc(x) class x << (P,lemonshiffon) >> 
!define x(x) class x << (P,linen) >>
 
hide methods 
hide stereotypes
skinparam classarrowcolor gray
 
'
/* firstly, we'll create all the UML table diagrams. */
Select @MyPlantUMLStatement=@MyPlantUMLStatement+ 'table('+object_schema_name(AllTables.object_ID)+'.'+Name+') {
' +(Select c.name+': '+t.name+ case when PrimaryKeyColumns.Object_ID is not null
             then ' <<pk>>' else '' end
                      + case when fk.parent_Object_ID is not null
                      then ' <<fk>>' else '' end+'
'
from sys.columns c --give the column names and the data types but no dimensions
 inner join sys.types t
  on c.user_type_id= t.user_type_id
 Left outer join [sys].[foreign_key_columns] fk
       on parent_object_ID=c.object_ID
       and parent_column_ID=c.column_ID
 Left outer join --the primary keys are a bit awkward to get
         (Select i.object_ID, column_ID
           from sys.indexes i
            inner join sys.index_columns ic
             on ic.object_ID=i.object_ID
              and ic.index_ID=i.index_ID
            inner join sys.key_constraints k
             on k.parent_object_id=ic.object_ID
              and i.index_ID=k.unique_index_ID
                  where ic.object_ID = AllTables.object_ID
           and k.type='pk')PrimaryKeyColumns(Object_ID,Column_ID)
   on c.object_ID=PrimaryKeyColumns.Object_ID
    and c.column_ID=PrimaryKeyColumns.column_ID
  where c.object_ID = AllTables.object_ID
FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'varchar(max)')
/* so now we can add any triggers. We could do indexes as well
but I somehow felt this wasn't appropriate*/
 + coalesce('__ trigger __
'+ (Select name +'
'from sys.triggers where parent_ID=AllTables.object_ID
        FOR XML PATH(''), TYPE).value('.', 'varchar(max)'),'')+'}
'
from sys.tables allTables
inner join @ObjectsToDo ObjectsToDo
on alltables.object_ID = ObjectsTodo.object_id
 
/* now let's do the views */
 
Select @MyPlantUMLStatement=@MyPlantUMLStatement
+ 'view('+object_schema_name(Allviews.object_ID)+'.'+Name+') {
' +(Select  c.name+': '+t.name +'
'
 from sys.columns c
 inner join sys.types t
  on c.user_type_id= t.user_type_id
 where c.object_ID = AllViews.object_ID
FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'varchar(max)')+'}
'
from sys.views allViews
inner join @ObjectsToDo ObjectsToDo
on allViews.object_ID = ObjectsTodo.object_id
/* now we do anything that is capable of having parameters */
Select @MyPlantUMLStatement=@MyPlantUMLStatement+
 rtrim(lower(AllRoutines.type))+'('+object_schema_name(AllRoutines.object_ID)+'.'+AllRoutines.Name+') {
'
/* note, a routine can exist without a parameter */
+ coalesce((Select  p.name+': '+TYPE_NAME(p.user_type_id) +'
'
 FROM sys.objects AS o
INNER JOIN sys.parameters AS p ON o.object_id = p.object_id
where o.object_ID = AllRoutines.object_ID
FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'varchar(max)'),'')+'}
'
from sys.objects  Allroutines
inner join @ObjectsToDo ObjectsToDo
on  Allroutines.object_ID = ObjectsTodo.object_id
and type in ('AF','FN','FS','FT','IF','P','PC','TF','X');
/* just the types that can have parameters */
/* and now that we have a class diagram for every object,
we now do the arrows.*/
Select @MyPlantUMLStatement= @MyPlantUMLStatement+
coalesce((Select
          coalesce(object_schema_name(referencing_ID)+'.','')
     + object_name(referencing_ID) +' -|> '
        + referenced_schema_name+'.'+Referenced_Entity_name
        + ':References
'
           --AS reference
  FROM  sys.sql_expression_dependencies
inner join @ObjectsToDo ObjectsToDo
on referencing_ID = ObjectsTodo.object_id
inner join @ObjectsToDo ObjectsToDo2
on referenced_ID = ObjectsTodo2.object_id
where is_schema_bound_reference =0
FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'varchar(max)'),'')
 
Select @MyPlantUMLStatement= @MyPlantUMLStatement+
coalesce((Select Object_schema_name(parent_object_ID)+'.'+object_name(parent_object_ID)+' -|> '
  + Object_schema_name(referenced_object_ID)+'.'+object_name(referenced_object_ID)+':FK
'
from sys.foreign_keys
inner join @ObjectsToDo ObjectsToDo
on parent_object_ID  =  ObjectsTodo.object_id
inner join @ObjectsToDo ObjectsToDo2
on referenced_object_ID = ObjectsTodo2.object_id
FOR XML PATH(''), TYPE).value(N'(./text())[1]',N'varchar(max)'),'')
GO
