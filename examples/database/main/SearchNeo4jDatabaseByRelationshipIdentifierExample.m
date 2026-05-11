%% Search Neo4j Database by Relationship Identifier
% Search for information about a |Neo4jRelation| object in a Neo4j(R)
% database and display the information. 
%
% Assume that you have graph data stored in a Neo4j database that
% represents a social neighborhood. This database has seven nodes and eight
% relationships. Each node has only one unique property key |name| with
% values |User1| through |User7|. Each relationship has the type |knows|.
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
% Search the database for the relationship with the identifier |3| by using
% the Neo4j database connection.
relationid = 3;

relinfo = searchRelationByID(neo4jconn,relationid)

%%
% |relinfo| is a |Neo4jRelation| object with these properties:
%%
% * Relationship identifier 
% * Relationship data
% * Start node identifier
% * Relationship type
% * End node identifier

%%
% Access the property keys and values of the relationship using the
% property |RelationData|. Here, the relationship does not contain
% properties, so the structure has no fields.

relinfo.RelationData


%% 
% Copyright 2012 The MathWorks, Inc.