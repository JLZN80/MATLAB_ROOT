%% Search Relationships by Type and Distance
% Search for information about relationships in a Neo4j(R) database and
% display the information. Specify the relationship type and distance to
% search.
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
% |neo4jconn|.

neo4jconn.Message

%%
% The blank |Message| property indicates a successful connection.

%% 
% Retrieve the origin node |nodeinfo| using the Neo4j(R) database
% connection and the node identifier |3|.

nodeid = 3;

nodeinfo = searchNodeByID(neo4jconn,nodeid);

%%
% Search for incoming relationships using the Neo4j(R) database connection
% and the origin node |nodeinfo|. Refine the search by filtering
% for the relationship type |knows| and for nodes at a distance of two or
% fewer.

direction = 'in';
reltypes = {'knows'};

relinfo = searchRelation(neo4jconn,nodeinfo,direction, ...
    'RelationTypes',reltypes,'Distance',2) 

%%
% |relinfo| is a structure that contains the results of the search:
%%
% * |Origin| -- The node identifier for the specified origin node
% * |Nodes| -- A table containing all start and end nodes for each
% matched relationship
% * |Relations| -- A table containing all matched relationships

%%
% Access the table of nodes.

relinfo.Nodes

%%
% Access the table of relationships.

relinfo.Relations


%% 
% Copyright 2012 The MathWorks, Inc.