%% Create Directed Graph Using Node Names
% Create a Neo4j(R) database connection using the URL
% |http://localhost:7474/db/data|, user name |neo4j|, and password |matlab|.
url = 'http://localhost:7474/db/data';
username = 'neo4j';
password = 'matlab';

neo4jconn = neo4j(url,username,password);

%%
% Check the |Message| property of the Neo4j(R) connection object
% |neo4jconn|.

neo4jconn.Message

%%
% The blank |Message| property indicates a successful connection.

%%
% Search for a subgraph using the Neo4j(R) database connection |neo4jconn|
% and node label |nlabel|.

nlabel = {'Person'};

graphinfo = searchGraph(neo4jconn,nlabel);

%%
% Convert the graph information into a directed graph using the node names
% in the subgraph. Convert node names into a cell array of character
% vectors |nodenames|.

names = [graphinfo.Nodes.NodeData{:}];
nodenames = {names(:).name};

G = neo4jStruct2Digraph(graphinfo,'NodeNames',nodenames)

%%
% |G| is a <docid:matlab_ref.bun70tf digraph> object that contains two tables for
% edges and nodes.

%%
% Access the table of edges.

G.Edges

%%
% Access the table of nodes.

G.Nodes

%%
% Find the shortest path between all nodes in |G|.

d = distances(G)


%% 
% Copyright 2012 The MathWorks, Inc.