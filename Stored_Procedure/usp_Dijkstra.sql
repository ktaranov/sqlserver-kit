IF OBJECT_ID (N'dbo.usp_Dijkstra', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE usp_Dijkstra AS SELECT 1');
GO
 
ALTER PROCEDURE dbo.usp_Dijkstra (@StartNode int, @EndNode int = NULL)
AS
/*
http://www.hansolav.net/sql/graphs.html
Runs Dijkstras algorithm from the specified node.
@StartNode: Id of node to start from.
@EndNode: Stop the search when the shortest path to this node is found.
          Specify NULL find shortest path to all nodes.

CREATE TABLE dbo.Node
( 
    Id int NOT NULL PRIMARY KEY, 
    Name varchar(50) NULL
)

CREATE TABLE dbo.Edge
(
    FromNode int NOT NULL REFERENCES dbo.Node (Id), 
    ToNode int NOT NULL REFERENCES dbo.Node (Id), 
    [Weight] decimal (10, 3) NULL,
    PRIMARY KEY CLUSTERED (FromNode ASC, ToNode ASC)
) 
*/
BEGIN
    -- Automatically rollback the transaction if something goes wrong.
    SET XACT_ABORT ON    
    BEGIN TRAN
    
    -- Increase performance and do not intefere with the results.
    SET NOCOUNT ON;

    -- Create a temporary table for storing the estimates as the algorithm runs
    CREATE TABLE #Nodes
    (
        Id int NOT NULL PRIMARY KEY,    -- The Node Id
        Estimate decimal(10,3) NOT NULL,    -- What is the distance to this node, so far?
        Predecessor int NULL,    -- The node we came from to get to this node with this distance.
        Done bit NOT NULL        -- Are we done with this node yet (is the estimate the final distance)?
    )

    -- Fill the temporary table with initial data
    INSERT INTO #Nodes (Id, Estimate, Predecessor, Done)
    SELECT Id, 9999999.999, NULL, 0 FROM dbo.Node
    
    -- Set the estimate for the node we start in to be 0.
    UPDATE #Nodes SET Estimate = 0 WHERE Id = @StartNode
    IF @@rowcount <> 1
    BEGIN
        DROP TABLE #Nodes
        RAISERROR ('Could not set start node', 11, 1) 
        ROLLBACK TRAN        
        RETURN 1
    END

    DECLARE @FromNode int, @CurrentEstimate int

    -- Run the algorithm until we decide that we are finished
    WHILE 1 = 1
    BEGIN
        -- Reset the variable, so we can detect getting no records in the next step.
        SELECT @FromNode = NULL

        -- Select the Id and current estimate for a node not done, with the lowest estimate.
        SELECT TOP 1 @FromNode = Id, @CurrentEstimate = Estimate
        FROM #Nodes WHERE Done = 0 AND Estimate < 9999999.999
        ORDER BY Estimate
        
        -- Stop if we have no more unvisited, reachable nodes.
        IF @FromNode IS NULL OR @FromNode = @EndNode BREAK

        -- We are now done with this node.
        UPDATE #Nodes SET Done = 1 WHERE Id = @FromNode

        -- Update the estimates to all neighbour node of this one (all the nodes
        -- there are edges to from this node). Only update the estimate if the new
        -- proposal (to go via the current node) is better (lower).
        UPDATE #Nodes
        SET Estimate = @CurrentEstimate + e.Weight, Predecessor = @FromNode
        FROM #Nodes n INNER JOIN dbo.Edge e ON n.Id = e.ToNode
        WHERE Done = 0 AND e.FromNode = @FromNode AND (@CurrentEstimate + e.Weight) < n.Estimate
        
    END;
    
    -- Select the results. We use a recursive common table expression to
    -- get the full path from the start node to the current node.
    WITH BacktraceCTE(Id, Name, Distance, Path, NamePath)
    AS
    (
        -- Anchor/base member of the recursion, this selects the start node.
        SELECT n.Id, node.Name, n.Estimate, CAST(n.Id AS varchar(8000)),
            CAST(node.Name AS varchar(8000))
        FROM #Nodes n JOIN dbo.Node node ON n.Id = node.Id
        WHERE n.Id = @StartNode
        
        UNION ALL
        
        -- Recursive member, select all the nodes which have the previous
        -- one as their predecessor. Concat the paths together.
        SELECT n.Id, node.Name, n.Estimate,
            CAST(cte.Path + ',' + CAST(n.Id as varchar(10)) as varchar(8000)),
            CAST(cte.NamePath + ',' + node.Name AS varchar(8000))
        FROM #Nodes n JOIN BacktraceCTE cte ON n.Predecessor = cte.Id
        JOIN dbo.Node node ON n.Id = node.Id
    )
    SELECT Id, Name, Distance, Path, NamePath FROM BacktraceCTE
    WHERE Id = @EndNode OR @EndNode IS NULL -- This kind of where clause can potentially produce
    ORDER BY Id                             -- a bad execution plan, but I use it for simplicity here.
    
    DROP TABLE #Nodes
    COMMIT TRAN
    RETURN 0
END
GO
