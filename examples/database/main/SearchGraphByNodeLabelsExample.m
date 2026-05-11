%% Search Graph by Node Labels
% Search for graph information in a Neo4j(R) database by using node
% labels and display the information.

%%
% Create a Neo4j database connection using the URL
% |http://localhost:7474/db/data|, user name |neo4j|, and password |matlab|.
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
% Search the graph for all nodes with the label |'Person'| using the
% Neo4j database connection.

nlabel = {'Person'};

graphinfo = searchGraph(neo4jconn,nlabel)

%%
% |graphinfo| is a structure that contains the results of the search:
%
% * All start and end nodes that denote each matched relationship
% * All matched relationships

%%
% Access the table of nodes.

graphinfo.Nodes

%%
% Access property keys for the first node.

graphinfo.Nodes.NodeData{1}

%%
% Access the table of relationships.

graphinfo.Relations

%%
% Access property keys for the first relationship. The first relationship
% has no property keys.

graphinfo.Relations.RelationData{1}

%%
% Search the graph for all node labels in the database.

allnodes = nodeLabels(neo4jconn);

graphinfo = searchGraph(neo4jconn,allnodes);


%% 
% Copyright 2012 The MathWorks, Inc.