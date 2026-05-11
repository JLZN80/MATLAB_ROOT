%% Search Nodes by Node Label
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
% Neo4j(R) database connection |neo4jconn|.
nlabel = 'Person';

nodeinfo = searchNode(neo4jconn,nlabel)

%%
% |nodeinfo| is a table that contains information for each database node:
%%
% * Each row name is a node identifier.
% * Variable |NodeLabels| is the node label. 
% * Variable |NodeData| is the node information.
% * Variable |NodeObject| is the |Neo4jNode| object.

%%
% Access the node information for the first node in the table.

node = nodeinfo.NodeData(1);
node{1}

%%
% The structure contains one property key and value.

%%
% Access the node information using the row name as an index.

nodeinfo.NodeData{'0'}

%%
% The structure contains one property key and value.

%% 
% Find the node degree for the first database node in the table. Specify
% outgoing relationships.

degree = nodeDegree(nodeinfo.NodeObject(1),'out')

%%
% There are two outgoing relationships from the first node in the table
% with relationship type |knows|.



%% 
% Copyright 2012 The MathWorks, Inc.