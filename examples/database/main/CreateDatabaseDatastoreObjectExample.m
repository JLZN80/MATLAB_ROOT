%% Create |DatabaseDatastore| Object Using SQL Query Results
% Create a database connection using a JDBC driver. To create this
% connection, you must configure a JDBC data source. For more information,
% see the |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function. Then, create a |DatabaseDatastore|
% object using the results from an SQL query and preview a large data set.
%% 
% Create a database connection to the JDBC data source
% |MSSQLServerJDBCAuth|. This data source configures a JDBC driver to a
% Microsoft(R) SQL Server(R) database with Windows(R) authentication.
% Specify a blank user name and password. 

datasource = "MSSQLServerJDBCAuth";
username = "";
password = "";
conn = database(datasource,username,password);

%% 
% Create a |DatabaseDatastore| object using a database connection and an
% SQL query. This SQL query retrieves all flight data from the
% |airlinesmall| table. |databaseDatastore| executes the SQL query.

sqlquery = 'select * from airlinesmall';

dbds = databaseDatastore(conn,sqlquery)

%%
% |dbds| is a |DatabaseDatastore| object with these properties:
%%
% * |Connection| -- Database connection object
% * |Query| -- Executed SQL query
% * |VariableNames| -- List of column names from the executed SQL query
% * |ReadSize| -- Maximum number of records to read from the executed SQL
% query

%%
% Display the database connection property.
dbds.Connection

%%
% The |Message| property is blank when the database connection is
% successful.

%%
% Preview the first eight records in the large data set returned by
% executing the SQL query in the |DatabaseDatastore| object.

preview(dbds)

%% 
% Close the |DatabaseDatastore| object and the database connection.
close(dbds)

%% 
% Copyright 2012 The MathWorks, Inc.