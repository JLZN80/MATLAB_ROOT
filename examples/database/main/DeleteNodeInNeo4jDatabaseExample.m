%% Delete Node in Neo4j Database
% Create a single node in a Neo4j(R) database and delete the node.
%
%%
% Create a Neo4j database connection using the URL
% |http://localhost:7474/db/data|, user name |neo4j|, and password
% |matlab|.
url = 'http://localhost:7474/db/data';
username = 'neo4j';
password = 'matlab';

neo4jconn = neo4j(url,username,password);

%%
% Check the |Message| property of the Neo4j connection object
% |neo4jconn|. The blank |Message| property indicates a successful
% connection.

neo4jconn.Message

%%
% Create a single node in the Neo4j database using the Neo4j database
% connection. 

node = createNode(neo4jconn)

%%
% |node| is a |Neo4jNode| object with these properties:
%
% * Node identifier
% * Node data
% * Node labels

%%
% Delete the node using the Neo4j database connection.

deleteNode(neo4jconn,node)


%% 
% Copyright 2012 The MathWorks, Inc.