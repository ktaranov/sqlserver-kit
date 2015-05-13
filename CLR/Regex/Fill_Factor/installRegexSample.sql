sp_configure 'clr enabled', 1
RECONFIGURE WITH OVERRIDE


IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExOptionEnumeration') ) 
   DROP FUNCTION dbo.RegExOptionEnumeration

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExSplit') ) 
   DROP FUNCTION dbo.RegExSplit
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExEscape') ) 
   DROP FUNCTION dbo.RegExEscape
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExReplace') ) 
   DROP FUNCTION dbo.RegExReplace
go
IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExReplacex') ) 
   DROP FUNCTION dbo.RegExReplacex
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExIndex') ) 
   DROP FUNCTION dbo.RegExIndex
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExIsMatch') ) 
   DROP FUNCTION dbo.RegExIsMatch
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExMatch') ) 
   DROP FUNCTION dbo.RegExMatch
go

IF EXISTS ( SELECT   1
            FROM     sys.objects
            WHERE    object_id = OBJECT_ID(N'dbo.RegExMatches') ) 
   DROP FUNCTION dbo.RegExMatches
go

IF EXISTS ( SELECT   1
            FROM     sys.assemblies asms
            WHERE    asms.name = N'RegexFunction ' ) 
   DROP ASSEMBLY [RegexFunction]

CREATE ASSEMBLY RegexFunction 
		FROM '%FILE%'--Change this to the filename and path of your DLL
GO


CREATE FUNCTION RegExOptionEnumeration
	(
	@IgnoreCase bit,
        @MultiLine bit,
        @ExplicitCapture bit,
        @Compiled  bit,
        @SingleLine  bit,
        @IgnorePatternWhitespace  bit,
        @RightToLeft  bit,
        @ECMAScript  bit,
        @CultureInvariant  bit
        )
returns int
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExOptionEnumeration

go

CREATE FUNCTION RegExIsMatch
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
   )
RETURNS BIT
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExIsMatch
GO

CREATE FUNCTION RegExIndex
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
   )
RETURNS int
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExIndex
GO

CREATE FUNCTION RegExMatch
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
 )
RETURNS NVARCHAR(MAX)
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExMatch
GO

CREATE FUNCTION RegExEscape
   (
    @Input NVARCHAR(MAX)
   )
RETURNS NVARCHAR(MAX)
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExEscape
GO


CREATE FUNCTION [dbo].[RegExSplit]
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
   )
RETURNS TABLE (Match NVARCHAR(MAX))
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExSplit
GO

CREATE FUNCTION [dbo].[RegExReplace]
   (
    @Input NVARCHAR(MAX),
    @Pattern NVARCHAR(4000),
    @Repacement NVARCHAR(MAX)
   )
RETURNS  NVARCHAR(MAX)
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExReplace
GO
CREATE FUNCTION [dbo].[RegExReplaceX]
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Repacement NVARCHAR(MAX),
    @Options int
   )   
   
RETURNS  NVARCHAR(MAX)
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExReplacex
GO

CREATE FUNCTION [dbo].[RegExMatches]
   (
    @Pattern NVARCHAR(4000),
    @Input NVARCHAR(MAX),
    @Options int
   )
RETURNS TABLE (Match NVARCHAR(MAX), MatchIndex INT, MatchLength INT)
AS EXTERNAL NAME 
   RegexFunction.[SimpleTalk.Phil.Factor.RegularExpressionFunctions].RegExMatches
GO







