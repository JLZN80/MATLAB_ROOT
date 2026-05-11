%% Search Neo4j(R) Database by Node Identifier
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
% Search the database for the node with the node identifier |2| by using
% the Neo4j database connection |neo4jconn|.
nodeid = 2;

nodeinfo = searchNodeByID(neo4jconn,nodeid)

%%
% |nodeinfo| is a |Neo4jNode| object with these properties:
%%
% * Node identifier 
% * Node data
% * Node labels

%%
% Access the property keys and values of the node using the property
% |NodeData|.

nodeinfo.NodeData

%% 
% Copyright 2012 The MathWorks, Inc.