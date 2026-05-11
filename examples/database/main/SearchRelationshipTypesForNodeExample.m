%% Search Relationship Types for Node
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
% Search the database for the node with node identifier |2| using the
% Neo4j(R) database connection |neo4jconn|.

nodeid = 2;

node = searchNodeByID(neo4jconn,nodeid);

%%
% Search for all incoming relationships for the node. 

nodereltypes = nodeRelationTypes(node,'in')

%%
% |nodereltypes| returns a list of the relationship types.

%% 
% Copyright 2012 The MathWorks, Inc.