IF OBJECT_ID (N'dbo.usp_Breadth_First', 'P') IS NULL
    EXECUTE('CREATE PROCEDURE usp_Breadth_First AS SELECT 1');
GO
 
ALTER PROCEDURE dbo.usp_Breadth_First (@StartNode int, @EndNode int = NULL)
AS
/*
http://www.hansolav.net/sql/graphs.html
Runs breadth-first search from a specific node.
@StartNode: If of node to start the search at.
@EndNode: Stop the search when node with this id is found. Specify NULL
          to traverse the whole graph.

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

    -- Create a temporary table for storing the discovered nodes as the algorithm runs
    CREATE TABLE #Discovered
    (
        Id int NOT NULL PRIMARY KEY,    -- The Node Id
        Predecessor int NULL,    -- The node we came from to get to this node.
        OrderDiscovered int -- The order in which the nodes were discovered.
    )

    -- Initially, only the start node is discovered.
    INSERT INTO #Discovered (Id, Predecessor, OrderDiscovered)
    VALUES (@StartNode, NULL, 0)

    -- Add all nodes that we can get to from the current set of nodes,
    -- that are not already discovered. Run until no more nodes are discovered.
    WHILE @@ROWCOUNT > 0
    BEGIN
        -- If we have found the node we were looking for, abort now.
        IF @EndNode IS NOT NULL
            IF EXISTS (SELECT TOP 1 1 FROM #Discovered WHERE Id = @EndNode)
                BREAK    
    
        -- We need to group by ToNode and select one FromNode since multiple
        -- edges could lead us to new same node, and we only want to insert it once.
        INSERT INTO #Discovered (Id, Predecessor, OrderDiscovered)
        SELECT e.ToNode, MIN(e.FromNode), MIN(d.OrderDiscovered) + 1
        FROM #Discovered d JOIN dbo.Edge e ON d.Id = e.FromNode
        WHERE e.ToNode NOT IN (SELECT Id From #Discovered)
        GROUP BY e.ToNode
    END;
    
    -- Select the results. We use a recursive common table expression to
    -- get the full path from the start node to the current node.
    WITH BacktraceCTE(Id, Name, OrderDiscovered, Path, NamePath)
    AS
    (
        -- Anchor/base member of the recursion, this selects the start node.
        SELECT n.Id, n.Name, d.OrderDiscovered, CAST(n.Id AS varchar(MAX)),
            CAST(n.Name AS varchar(MAX))
        FROM #Discovered d JOIN dbo.Node n ON d.Id = n.Id
        WHERE d.Id = @StartNode
        
        UNION ALL
        
        -- Recursive member, select all the nodes which have the previous
        -- one as their predecessor. Concat the paths together.
        SELECT n.Id, n.Name, d.OrderDiscovered,
            CAST(cte.Path + ',' + CAST(n.Id as varchar(10)) as varchar(MAX)),
            cte.NamePath + ',' + n.Name
        FROM #Discovered d JOIN BacktraceCTE cte ON d.Predecessor = cte.Id
        JOIN dbo.Node n ON d.Id = n.Id
    )
    
    SELECT Id, Name, OrderDiscovered, Path, NamePath FROM BacktraceCTE
    WHERE Id = @EndNode OR @EndNode IS NULL -- This kind of where clause can potentially produce
    ORDER BY OrderDiscovered;               -- a bad execution plan, but I use it for simplicity here.
    
    DROP TABLE #Discovered;
    COMMIT TRAN
    RETURN 0
END
GO
