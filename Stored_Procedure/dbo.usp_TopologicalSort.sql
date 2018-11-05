IF OBJECT_ID (N'dbo.usp_TopologicalSort', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE usp_TopologicalSort AS SELECT 1');
GO
 
ALTER PROCEDURE dbo.usp_TopologicalSort
AS
/*
http://www.hansolav.net/sql/graphs.html
Determines a topological ordering or reports that the graph is not a DAG.

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
    
    -- Create a temporary table for building the topological ordering
    CREATE TABLE #Order
    (
        NodeId int PRIMARY KEY, -- The Node Id
        Ordinal int NULL        -- Defines the topological ordering. NULL for nodes that are
    )                           -- not yet processed. Will be set as nodes are processed in topological order.
    
    -- Create a temporary copy of the edges in the graph that we can work on.
    CREATE TABLE #TempEdges
    (
        FromNode int,   -- From Node Id
        ToNode int,     -- To Node Id
        PRIMARY KEY (FromNode, ToNode)
    )

    -- Grab a copy of all the edges in the graph, as we will
    -- be deleting edges as the algorithm runs.
    INSERT INTO #TempEdges (FromNode, ToNode)
    SELECT e.FromNode, e.ToNode
    FROM dbo.Edge e

    -- Start by inserting all the nodes that have no incoming edges, is it
    -- is guaranteed that no other nodes should come before them in the ordering.
    -- Insert with NULL for Ordinal, as we will set this when we process the node.
    INSERT INTO #Order (NodeId, Ordinal)
    SELECT n.Id, NULL
    FROM dbo.Node n
    WHERE NOT EXISTS (
        SELECT TOP 1 1 FROM dbo.Edge e WHERE e.ToNode = n.Id)

    DECLARE @CurrentNode int,   -- The current node being processed.
            @Counter int = 0    -- Counter to assign values to the Ordinal column.

    -- Loop until we are done.
    WHILE 1 = 1
    BEGIN
        -- Reset the variable, so we can detect getting no records in the next step.
        SET @CurrentNode = NULL

        -- Select the id of any node with Ordinal IS NULL that is currently in our
        -- Order table, as all nodes with Ordinal IS NULL in this table has either
        -- no incoming edges or any nodes with edges to it have already been processed.
        SELECT TOP 1 @CurrentNode = NodeId
        FROM #Order WHERE Ordinal IS NULL
        
        -- If there are no more such nodes, we are done
        IF @CurrentNode IS NULL BREAK
        
        -- We are processing this node, so set the Ordinal column of this node to the
        -- counter value and increase the counter.
        UPDATE #Order SET Ordinal = @Counter, @Counter = @Counter + 1
        WHERE NodeId = @CurrentNode
        
        -- This is the complex part. Select all nodes that has exactly ONE incoming
        -- edge - the edge from @CurrentNode. Those nodes can follow @CurrentNode
        -- in the topological ordering because the must not come after any other nodes,
        -- or those nodes have already been processed and inserted earlier in the
        -- ordering and had their outgoing edges removed in the next step.
        INSERT #Order (NodeId, Ordinal)
        SELECT Id, NULL
        FROM dbo.Node n
        JOIN #TempEdges e1 ON n.Id = e1.ToNode  -- Join on edge destination
        WHERE e1.FromNode = @CurrentNode AND    -- Edge starts in @CurrentNode
            NOT EXISTS (                            -- Make sure there are no edges to this node
                SELECT TOP 1 1 FROM #TempEdges e2   -- other then the one from @CurrentNode.
                WHERE e2.ToNode = n.Id AND e2.FromNode <> @CurrentNode)
        
        -- Last step. We are done with @CurrentNode, so remove all outgoing edges from it.
        -- This will "free up" any nodes it has edges into to be inserted into the topological ordering.
        DELETE FROM #TempEdges WHERE FromNode = @CurrentNode
    END

    -- If there are edges left in our graph after the algorithm is done, it
    -- means that it could not reach all nodes to eliminate all edges, which
    -- means that the graph must have cycles and no topological ordering can be produced.
    IF EXISTS (SELECT TOP 1 1 FROM #TempEdges)
    BEGIN
        SELECT 'The graph contains cycles and no topological ordering can
                be produced. This is the set of edges I could not remove:'
        SELECT FromNode, ToNode FROM #TempEdges
    END
    ELSE
        -- Select the nodes ordered by the topological ordering we produced.
        SELECT n.Id, n.Name
        FROM dbo.Node n
        JOIN #Order o ON n.Id = o.NodeId
        ORDER BY o.Ordinal

    -- Clean up, commit and return.
    DROP TABLE #TempEdges
    DROP TABLE #Order
    COMMIT TRAN
    RETURN 0
END
GO
