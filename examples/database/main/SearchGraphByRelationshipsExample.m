%% Search Graph by Relationships
% Search for graph information in a Neo4j(R) database by using the
% relationship type and display the information.

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
% Search the graph for the relationship type |'knows'| using the Neo4j
% database connection.

reltype = {'knows'};

graphinfo = searchGraph(neo4jconn,reltype)

%%
% |graphinfo| is a structure that contains the results of the search:
%
% * All start and end nodes that denote each matched relationship
% * All matched relationships

%%
% Access the table of nodes.

graphinfo.Nodes

%%
% Access the table of relationships.

graphinfo.Relations

%%
% Search the graph for all relationship types in the database.

allreltypes = relationTypes(neo4jconn);

graphinfo = searchGraph(neo4jconn,allreltypes);

%% 
% Copyright 2012 The MathWorks, Inc.