%% Reset |DatabaseDatastore| Object to Initial State
% Create a database connection using a JDBC driver. To create this
% connection, you must configure a JDBC data source. For more information,
% see the |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function. Then, create a |DatabaseDatastore|
% object, read the data stored in the object, and reset the object to
% its original state.
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
% SQL query. This SQL query retrieves all data from the |airlinesmall|
% table. Specify reading a maximum of 10 records from the executed SQL
% query.

sqlquery = 'select * from airlinesmall';

dbds = databaseDatastore(conn,sqlquery,'ReadSize',10);

%%
% Read data from the start of the data set.

read(dbds)

%%
% |read| returns the first 10 records in the data set. 

%%
% Reset the |DatabaseDatastore| object to its original state, where no data
% has been read from it. Resetting allows you to reread from the same
% |DatabaseDatastore| object.

reset(dbds)

%%
% Read data from the start of the data set.

read(dbds)

%%
% |read| again returns the first 10 records in the data set. 

%%
% Close the |DatabaseDatastore| object and the database connection.
close(dbds)

%% 
% Copyright 2018 The MathWorks, Inc.