%% Delete Node and Its Relationship
% Create a single relationship between two nodes in a Neo4j(R) database.
% Then, delete one of the nodes and the relationship.
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
% Create two nodes in the Neo4j database using the Neo4j database
% connection. Use the |'Labels'| name-value pair argument to
% specify the |Person| node label for each node.

label = 'Person';
startnode = createNode(neo4jconn,'Labels',label);
endnode = createNode(neo4jconn,'Labels',label);

%%
% Create a relationship between two nodes using the Neo4j database
% connection. Specify the relationship type as |works with|.

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
% Delete the first node and the associated relationship. Use this syntax to
% delete the node and relationship without throwing an error.

deleteNode(neo4jconn,startnode,'DeleteRelations',true)

%% 
% Copyright 2012 The MathWorks, Inc.