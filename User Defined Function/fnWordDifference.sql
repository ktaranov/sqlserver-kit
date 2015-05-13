CREATE FUNCTION [dbo].[fnWordDifference] (
	 @First		VarChar(256)
	,@Second	VarChar(256)
	,@Difference	TinyInt	= NULL
) RETURNS TABLE AS RETURN	-- SELECT * FROM dbo.fnWordDifference('012345679012','012456789012',3)
WITH Shift(Position,[Left],[Right],[Difference]) AS (
	SELECT	 0
		,@First
		,@Second
		,0
	WHERE	@Difference >= 0 OR @Difference IS NULL
UNION ALL
	SELECT	 Position + 1
		,[Left]
		,[Right]
		,[Difference]
	FROM	Shift
	WHERE	    Position <= Len([Left] )
		AND Position <= Len([Right])
		AND SubString([Left] ,Position + 1,1)
		  = SubString([Right],Position + 1,1)
UNION ALL
	SELECT	 Position
		,Convert(VarChar(256),Stuff([Left],Position + 1,1,''))
		,[Right]
		,[Difference] + 1
	FROM	Shift
	WHERE	    Position <= Len([Left] )
		AND Position <= Len([Right])
		AND SubString([Left]  + ' ',Position + 1,1)
		 != SubString([Right] + ' ',Position + 1,1)
		AND([Difference] < @Difference OR @Difference IS NULL)
UNION ALL
	SELECT	 Position
		,[Left]
		,Convert(VarChar(256),Stuff([Right],Position + 1,1,''))
		,[Difference] + 1
	FROM	Shift
	WHERE	    Position <= Len([Left] )
		AND Position <= Len([Right])
		AND SubString([Left] + ' ',Position + 1,1)
		 != SubString([Right]+ ' ',Position + 1,1)
		AND([Difference] < @Difference OR @Difference IS NULL)
)	SELECT	Top(1)
		 @First		AS [First]
		,@Second	AS [Second]
		,[Left]		AS [Root]
		,[Difference]
	FROM	Shift
	WHERE	[Left] = [Right] AND Position = Len([Left])
	ORDER BY [Difference]
