%% Retrieve Column Names in Database Table 
% Using a JDBC driver, create a database connection |conn| to a
% Microsoft(R) SQL Server(R) database with Windows(R) authentication.
% Specify a blank user name and password. The code assumes that you
% are connecting to a database |toy_store|, a database server |dbtb04|, and
% port number |54317|.

conn = database('toy_store','','','Vendor','Microsoft SQL Server', ...
    'Server','dbtb04','PortNumber',54317,'AuthType','Windows');

%%
% Retrieve database metadata using the database connection |conn|.

dbmeta = dmd(conn);

%%
% |dbmeta| is the database metadata object. 

%%
% Retrieve and display columns names in the database table |productTable| 
% using |dbmeta|. Specify the catalog and schema names.

catalog = 'toy_store';
schema = 'dbo';
tablename = 'productTable';
colnames = columns(dbmeta,catalog,schema,tablename)

%%
% Close the database connection.

close(conn)




%% 
% Copyright 2012 The MathWorks, Inc.