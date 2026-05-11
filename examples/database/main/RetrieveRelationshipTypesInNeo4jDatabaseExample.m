%% Retrieve Relationship Types in Neo4j(R) Database
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
% Retrieve all relationship types using the Neo4j(R) database connection
% |neo4jconn|.

rtypes = relationTypes(neo4jconn)

%%
% The cell array |rtypes| contains a character vector for the one
% relationship type in the Neo4j(R) database.

%% 
% Copyright 2012 The MathWorks, Inc.