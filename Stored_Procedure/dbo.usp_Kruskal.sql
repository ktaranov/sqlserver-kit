IF OBJECT_ID (N'dbo.usp_Kruskal', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE usp_Kruskal AS SELECT 1');
GO
 
ALTER PROCEDURE dbo.usp_Kruskal
AS
/*
http://www.hansolav.net/sql/graphs.html
Computes a minimum spanning tree using Kruskal's algorithm.

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
    SET NOCOUNT ON

    CREATE TABLE #MSTNodes(Id int PRIMARY KEY, ClusterNum int) -- Temp table for clusters
    CREATE TABLE #MST (FromNode int, ToNode int PRIMARY KEY (FromNode, ToNode)) -- Result accumulator
    DECLARE @FromNode int, @ToNode int,     -- Start and end point for the current edge
            @EdgeCount int = 0, @NodeCount int, -- Edge count along the way, total node count
            @FromCluster int, @ToCluster int    -- Start and end cluster for the current edge
    
    -- First, create one cluster for each of the nodes
    INSERT #MSTNodes (Id, ClusterNum)   
    SELECT Id, Id FROM dbo.Node

    -- Get the total node count
    SELECT @NodeCount = COUNT(*) FROM #MSTNodes
    
    -- Get a cursor iterating through all the edges sorted increasing on weight.
    DECLARE EdgeCursor CURSOR READ_ONLY FOR 
        SELECT FromNode, ToNode
        FROM dbo.Edge
        WHERE FromNode < ToNode -- Don't get self loops, they are not part of the tree.
        ORDER BY Weight
    OPEN EdgeCursor

    -- Get the first edge
    FETCH NEXT FROM EdgeCursor INTO @FromNode, @ToNode  

    -- Loop until we have no more edges or we have Nodes - 1 edges (this is enough).
    WHILE @@FETCH_STATUS = 0 AND @EdgeCount < @NodeCount - 1
    BEGIN
        -- Get the clusters for this edge
        SELECT @FromCluster = ClusterNum FROM #MSTNodes WHERE Id = @FromNode
        SELECT @ToCluster = ClusterNum FROM #MSTNodes WHERE Id = @ToNode

        -- If the edge ends in different clusters, the edge is safe, so add it to the MST.
        IF (@FromCluster <> @ToCluster)
        BEGIN
            -- Merge the two clusters by updating the cluster number of the "to cluster" to the
            -- cluster number of the "from cluster".
            UPDATE #MSTNodes
            SET ClusterNum = @FromCluster
            WHERE ClusterNum = @ToCluster

            -- Insert the edge into the result and increment the edge count
            INSERT #MST VALUES (@FromNode, @ToNode)
            SET @EdgeCount = @EdgeCount + 1
        END

        -- Get the next edge
        FETCH NEXT FROM EdgeCursor INTO @FromNode, @ToNode  
    END

    -- Close and deallocate the cursor
    CLOSE EdgeCursor
    DEALLOCATE EdgeCursor

    -- Verify that we have enough edges to connect the whole graph.
    IF (SELECT COUNT(*) FROM #MST) < @NodeCount - 1
    BEGIN
        DROP TABLE #MSTNodes
        DROP TABLE #MST
        RAISERROR('Error: The graph is not connected.', 1, 1)
        ROLLBACK TRAN
        RETURN 1
    END
        
    -- Select the results.
    SELECT mst.FromNode, mst.ToNode,
        node1.Name AS FromName, node2.Name AS ToName
    FROM #MST mst
    JOIN dbo.Node node1 ON mst.FromNode = node1.Id
    JOIN dbo.Node node2 ON mst.ToNode = node2.id
    ORDER BY mst.FromNode, mst.ToNode
    
    DROP TABLE #MSTNodes
    DROP TABLE #MST 
    COMMIT TRAN
    RETURN 0
END
GO
