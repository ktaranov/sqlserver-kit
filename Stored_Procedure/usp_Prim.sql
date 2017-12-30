IF OBJECT_ID (N'dbo.usp_Prim', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE usp_Prim AS SELECT 1');
GO
 
ALTER PROCEDURE dbo.usp_Prim
AS
/*
http://www.hansolav.net/sql/graphs.html
Computes a minimum spanning tree using Prim's algorithm.

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
    
    -- Increase performance and don't intefere with the results.
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
    
    -- Set the estimate for start node to be 0.
    UPDATE TOP (1) #Nodes SET Estimate = 0

    DECLARE @FromNode int

    -- Run the algorithm until we decide that we are finished
    WHILE 1 = 1
    BEGIN
        -- Reset the variable, so we can detect getting no records in the next step.
        SELECT @FromNode = NULL

        -- Select the Id for a node not done, with the lowest estimate.
        SELECT TOP 1 @FromNode = Id
        FROM #Nodes WHERE Done = 0 AND Estimate < 9999999.999
        ORDER BY Estimate
        
        -- Stop if we have no more unvisited, reachable nodes.
        IF @FromNode IS NULL BREAK

        -- We are now done with this node.
        UPDATE #Nodes SET Done = 1 WHERE Id = @FromNode

        -- Update the estimates to all neighbour nodes of this one (all the nodes
        -- there are edges to from this node). Only update the estimate if the new
        -- proposal (to go via the current node) is better (lower).
        UPDATE #Nodes
        SET Estimate = e.Weight, Predecessor = @FromNode
        FROM #Nodes n INNER JOIN dbo.Edge e ON n.Id = e.ToNode
        WHERE Done = 0 AND e.FromNode = @FromNode AND e.Weight < n.Estimate
        
    END
   
    -- Verify that we have enough edges to connect the whole graph.
    IF EXISTS (SELECT TOP 1 1 FROM #Nodes WHERE Done = 0)
    BEGIN
        DROP TABLE #Nodes
        RAISERROR('Error: The graph is not connected.', 1, 1)
        ROLLBACK TRAN
        RETURN 1
    END
    
    -- Select the results. WHERE Predecessor IS NOT NULL filters away
    -- the one row with represents the starting node.
    SELECT n.Predecessor AS FromNode, n.Id AS ToNode,
        node1.Name AS FromName, node2.Name AS ToName
    FROM #Nodes n
    JOIN dbo.Node node1 ON n.Predecessor = node1.Id
    JOIN dbo.Node node2 ON n.Id = node2.id
    WHERE n.Predecessor IS NOT NULL
    ORDER BY n.Predecessor, n.id

    DROP TABLE #Nodes
    COMMIT TRAN
    RETURN 0
END
GO
