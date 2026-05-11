%% Delete Relationship from Neo4j Database
% Create a single relationship between two nodes in a Neo4j(R) database.
% Then, delete the relationship and the corresponding nodes.

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
% Create two nodes in the Neo4j database using the Neo4j database
% connection. Use the |'Labels'| name-value pair argument to
% specify the |Person| node label for each node.

label = 'Person';
startnode = createNode(neo4jconn,'Labels',label);
endnode = createNode(neo4jconn,'Labels',label);

%%
% Create a relationship between the two nodes using the Neo4j database
% connection. These nodes represent two colleagues who work together.
% Specify the relationship type as |works with|.

relationtype = 'works with';
relation = createRelation(neo4jconn,startnode,endnode,relationtype)

%%
% |relation| is a |Neo4jRelation| object with these properties:
%
% * Relationship identifier
% * Relationship data
% * Start node identifier
% * Relationship type
% * End node identifier

%%
% Delete the relationship.

deleteRelation(neo4jconn,relation)

%%
% Delete the two nodes by using a |Neo4jNode| object array.

nodes = [startnode,endnode];
deleteNode(neo4jconn,nodes)

%% 
% Copyright 2012 The MathWorks, Inc.