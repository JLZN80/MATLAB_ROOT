%% Search for Relationships in Neo4j Database 
% Search for a single relationship or multiple relationships by using
% relationship identifiers in the Neo4j database.
%
% Assume that you have graph data stored in a Neo4j database that
% represents a social neighborhood. This database has seven nodes and eight
% relationships. Each node has only one unique property key |name| with
% values |User1| through |User7|. Each relationship has the type |knows|.
%%
% Create a Neo4j(R) database connection using the URL
% |http://localhost:7474/db/data|, user name |neo4j|, and password |matlab|.
url = 'http://localhost:7474/db/data';
username = 'neo4j';
password = 'matlab';

neo4jconn = neo4j(url,username,password); 

%%
% Check the |Message| property of the Neo4j(R) connection object
% |neo4jconn|. The blank |Message| property indicates a successful
% connection.

neo4jconn.Message

%% 
% Search for the relationship with the identifier |8| by using the Neo4j
% database connection.

relationid = 8;
relationinfo = searchRelationByID(neo4jconn,relationid)

%%
% |relationinfo| is a |Neo4jRelation| object with these properties:
%
% * Relationship identifier
% * Relationship data
% * Start node identifier
% * Relationship type
% * End node identifier

%%
% Display the relationship type.

relationinfo.RelationType

%%
% Search for multiple relationships with the identifiers |4|, |5|, and |6|
% by using the Neo4j database connection.

relationid = [4,5,6];
relationinfo = searchRelationByID(neo4jconn,relationid)

%%
% |relationinfo| is a table with these variables:
%
% * Start node identifier
% * Relationship type
% * End node identifier
% * Relationship properties
% * |Neo4jRelation| object



%% 
% Copyright 2012 The MathWorks, Inc.