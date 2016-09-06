DECLARE @startLoop  INTEGER          = 1960;
DECLARE @endLoop    INTEGER          = 2012;
DECLARE @columnMask NVARCHAR( 1000 ) = '';
DECLARE @columns    NVARCHAR( MAX )  = '';
DECLARE @step       INTEGER          = 1;
DECLARE @debug      BIT              = 0;

WHILE( @startLoop <= @endLoop )
BEGIN
       SET @columns = @columns + QUOTENAME( @columnMask + CAST( @startLoop AS NVARCHAR ) ) + ',';
       IF @debug    = 1
       PRINT @columns;
       SET @startLoop = @startLoop + @step;
       IF @debug      = 1
       PRINT @startLoop;
END

PRINT LEFT( @columns, LEN( @columns ) - 1 );