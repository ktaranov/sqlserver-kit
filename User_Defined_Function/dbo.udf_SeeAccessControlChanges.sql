IF OBJECT_ID('dbo.udf_SeeAccessControlChanges') IS NULL
  EXEC('CREATE FUNCTION dbo.udf_SeeAccessControlChanges() RETURNS TABLE WITH SCHEMABINDING AS RETURN SELECT 1 AS A;');
GO


ALTER FUNCTION dbo.udf_SeeAccessControlChanges(
    @Start DATETIME2,--the start of the period
    @Finish DATETIME2--the end of the period
    )
  RETURNS TABLE
   --WITH ENCRYPTION|SCHEMABINDING, ..
  AS
/**
  Summary: >
    This function gives you a list
    of security events concerning users, roles and logins
    from the default trace
  Author: Phil Factor
  Date: 2018-10-04
  Original link: https://www.red-gate.com/hub/product-learning/sql-monitor/monitoring-changes-permissions-users-roles-logins
  Source link: https://github.com/ktaranov/sqlserver-kit/blob/master/User_Defined_Function/dbo.udf_SeeAccessControlChanges.sql
  Modified: 2019-01-29 by Konstantin Taranov
  Examples:
     - SELECT * FROM dbo.udf_SeeAccessControlChanges(DateAdd(day, -1, SysDateTime()), SysDateTime())
  columns: datetime_local, action, data, hostname, ApplicationName, LoginName, traceName, spid, EventClass, objectName, rolename, TargetLoginName, category_id, ObjectType
  Returns: >
        datetime_local datetime2(7)
        action nvarchar(816)
        data ntext
        hostname nvarchar(256)
        ApplicationName nvarchar(256)
        LoginName nvarchar(256)
        traceName nvarchar(128)
        spid int
        EventClass int
        objectName nvarchar(256)
        rolename nvarchar(256)
        TargetLoginName nvarchar(256)
        category_id smallint
        ObjectType nvarchar(128)
**/
  RETURN
    (
    SELECT
        CONVERT(
          DATETIME2,
         SWITCHOFFSET(CONVERT(datetimeoffset, StartTime), DATENAME(TzOffset, SYSDATETIMEOFFSET()))
               )  AS datetime_local, 'User '+Coalesce( LoginName+ ' ','unknown ')+
        CASE EventSubClass --interpret the subclass for these traces
          WHEN 1 THEN 'added ' WHEN 2 THEN 'dropped ' WHEN 3 THEN 'granted database access for '
          WHEN 4 THEN 'revoked database access from ' ELSE 'did something to ' END+ Coalesce(TargetLoginName,'')
        + Coalesce( CASE EventSubclass WHEN 1 THEN ' to object ' ELSE ' from object ' end+objectname, '') AS action,
        Coalesce(TextData,'') AS [data], hostname, ApplicationName, LoginName, TE.name AS traceName, spid,
        EventClass, objectName, rolename, TargetLoginName, TE.category_id,
      SysTSV.subclass_name AS ObjectType
       FROM::fn_trace_gettable(--just use the latest trace
           (SELECT TOP 1 traces.path FROM sys.traces
              WHERE is_default = 1), DEFAULT) AS DT
        LEFT OUTER JOIN sys.trace_events AS TE
          ON DT.EventClass = TE.trace_event_id
        LEFT OUTER JOIN sys.trace_subclass_values AS SysTSV
          ON DT.EventClass = SysTSV.trace_event_id
         AND DT.ObjectType = SysTSV.subclass_value
      WHERE StartTime BETWEEN @Start AND @Finish
      AND TargetLoginName IS NOT NULL
    );
  GO
