%% Search Node Degree for Node
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
% Search for the degree of all incoming relationships for the node. 

degree = nodeDegree(node,'in')

%%
% |degree| returns a structure with the in-degree for each relationship
% type.


%% 
% Copyright 2012 The MathWorks, Inc.