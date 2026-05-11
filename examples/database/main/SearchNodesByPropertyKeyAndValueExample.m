%% Search Nodes by Property Key and Value
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
% Search the database for nodes that have node label |Person| using the
% Neo4j(R) database connection |neo4jconn|. Filter the results further by
% the property key and value for a specific person named |User2|.
nlabel = 'Person';

nodeinfo = searchNode(neo4jconn,nlabel,'PropertyKey','name', ...
    'PropertyValue','User2')

%%
% |nodeinfo| is a |Neo4jNode| object that contains node information.

%%
% Access the node information.

nodeinfo.NodeData

%%
% The structure contains a property key and value for |User2|.

%% 
% Find the node degree of the outgoing relationships.

degree = nodeDegree(nodeinfo,'out')

%%
% There is one outgoing relationship type |knows| for |User2|.

%% 
% Copyright 2012 The MathWorks, Inc.