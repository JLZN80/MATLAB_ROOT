%% Read All Data in |DatabaseDatastore| Object
% Create a database connection using a JDBC driver. To create this
% connection, you must configure a JDBC data source. For more information,
% see the |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function. Then, create a |DatabaseDatastore|
% object and read all data stored in the object.
%
% Create a database connection to the JDBC data source
% |MSSQLServerJDBCAuth|. This data source configures a JDBC driver to a
% Microsoft(R) SQL Server(R) database with Windows(R) authentication.
% Specify a blank user name and password. 

datasource = "MSSQLServerJDBCAuth";
username = "";
password = "";
conn = database(datasource,username,password);

%% 
% Create a |DatabaseDatastore| object using the database connection and an
% SQL query. This SQL query reads all data from the |airlinesmall| table.

sqlquery = 'select * from airlinesmall';

dbds = databaseDatastore(conn,sqlquery);

%%
% Read all data in the |DatabaseDatastore| object.

data = readall(dbds);

%%
% |data| contains the query results.

%%
% Display the first three rows of query results.

data(1:3,:)

%%
% Close the |DatabaseDatastore| object and the database connection.

close(dbds)

%% 
% Copyright 2018 The MathWorks, Inc.