IF OBJECT_ID('dbo.udf_CalculateDistanceBetween2Coordinates', 'FN') IS NULL
EXECUTE ('CREATE FUNCTION dbo.udf_CalculateDistanceBetween2Coordinates() RETURNS INT AS BEGIN RETURN 1 END;');
GO

CREATE FUNCTION dbo.udf_CalculateDistanceBetween2Coordinates
(
      @Lat1  Float(18),
      @Long1 Float(18),
      @Lat2  Float(18),
      @Long2 Float(18),
      @ReturnType VarChar(10)
)

Returns Float(18)

AS
/*
Note
    Author: Vignesh Arulmani
    Original link: http://www.sqlservercentral.com/scripts/Calculate+Distance/118083/
Examples
    select dbo.udf_CalculateDistanceBetween2Coordinates('37.7749300 ','-122.4194200','34.0522222','-118.2427778','Miles');
    select dbo.udf_CalculateDistanceBetween2Coordinates('37.7749300 ','-122.4194200','34.0522222','-118.2427778','Kilometers');
    select dbo.udf_CalculateDistanceBetween2Coordinates('37.7749300 ','-122.4194200','34.0522222','-118.2427778','Meters');
    select dbo.udf_CalculateDistanceBetween2Coordinates('37.7749300 ','-122.4194200','34.0522222','-118.2427778','Feet');
*/
Begin

  Declare @R Float(8);
  Declare @dLat Float(18);
  Declare @dLon Float(18);
  Declare @a Float(18);
  Declare @c Float(18);
  Declare @d Float(18);

  Set @R = 
        Case @ReturnType
        When 'Miles' Then 3956.55 
        When 'Kilometers' Then 6367.45
        When 'Feet' Then 20890584
        When 'Meters' Then 6367450
        Else 20890584
        End

  Set @dLat = Radians(@lat2 - @lat1);

  Set @dLon = Radians(@long2 - @long1);

  Set @a = Sin(@dLat / 2)
             * Sin(@dLat / 2)
             + Cos(Radians(@lat1))
             * Cos(Radians(@lat2))
             * Sin(@dLon / 2)
             * Sin(@dLon / 2);
  Set @c = 2 * Atn2(sqrt(@a),sqrt(1-@a));

  Set @d = @R * @c;
  Return @d;

End;
Go
