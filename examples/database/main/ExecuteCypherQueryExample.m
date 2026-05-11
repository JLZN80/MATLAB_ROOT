%% Execute Cypher(R) Query in Neo4j(R) Database
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
% Create the Cypher(R) query that searches for the names of all nodes with
% the node label |Person|.

query = 'MATCH (node:Person) RETURN node.name';

%%
% Execute the query and display the results using the Neo4j(R) database
% connection |neo4jconn|.

results = executeCypher(neo4jconn,query)

%%
% |results| is a table that contains the column |node_name|. This column
% has the names of each node in the Neo4j(R) database.


%% 
% Copyright 2012 The MathWorks, Inc.