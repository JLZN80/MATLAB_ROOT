function distance = findShortestPathBetweenPeople(userA,userB)

%  FINDSHORTESTPATHBETWEENPEOPLE The findShortestPathBetweenPeople function
%  connects to a Neo4j® database, imports data from the database into
%  MATLAB®, finds the shortest path between two people, and closes the
%  database connection.

%%
% Create a Neo4j connection object |neo4jconn| using the URL
% |http://localhost:7474/db/data|, user name |neo4j|, and password
% |matlab|.

url = 'http://localhost:7474/db/data';
username = 'neo4j';
password = 'matlab';

neo4jconn = neo4j(url,username,password);

%%
% Find all the |Person| nodes and all the relationships associated with
% each |Person| node using |searchGraph|.

social_graphdata = searchGraph(neo4jconn,{'Person'});

%%
% Using the table |social_graphdata.Nodes|, access the |name| property for
% each node that appears in the |NodeData| variable of the table.
%
% Assign the table |social_graphdata.Nodes| to |nodestable|.

nodestable = social_graphdata.Nodes;

%%
% Assign the row names for each row in the table |nodestable| to
% |rownames|.

rownames = nodestable.Properties.RowNames;

%%
% Access the |NodeData| variable from |nodestable| for each row. |nodedata|
% contains an array of structures.

nodedata = [nodestable.NodeData{rownames}];

%%
% To retrieve the |name| field from each structure, index into the array.
% |nodenames| is a cell array of character vectors that contains node names.

nodenames = {nodedata(:).name};

%%
% Create the |digraph| object |social_graph| using the
% |neo4jStruct2Digraph| function with the graph data stored in
% |social_graphdata| and the node names stored in |nodenames|.

social_graph = neo4jStruct2Digraph(social_graphdata,'NodeNames',nodenames);

%%
% Find the shortest path between |UserA| and |UserB| using |shortestpath|.

[~,distance] = shortestpath(social_graph,userA,userB);

%%
% Close the database connection.
close(neo4jconn)
