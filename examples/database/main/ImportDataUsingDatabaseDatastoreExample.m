%% Import Large Data Using |DatabaseDatastore| Object
% This example shows how to create a |<docid:database_ug.bufomil
% DatabaseDatastore>| object for accessing collections of data stored in a
% relational database. After creating a |DatabaseDatastore| object, you can
% preview data, read data in chunks, and read every record in the data set.
%
% To analyze large data, you can run algorithms on large data sets using a
% tall array. 
%
% Alternatively, you can write a MapReduce algorithm that defines the
% chunking and reduction of the data. 
%
% This example uses a preconfigured JDBC data source to create the database
% connection. For more information, see the
% |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function.
%% Create |DatabaseDatastore| Object
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
% table.

sqlquery = 'select * from airlinesmall';

dbds = databaseDatastore(conn,sqlquery);

%% Preview Data in |DatabaseDatastore| Object
% Preview the first eight records in the data set returned by executing
% the SQL query.

preview(dbds)

%% Read Data in |DatabaseDatastore| Object
% Read the first 10 records.

dbds.ReadSize = 10;

read(dbds)

%%
% Read the |DatabaseDatastore| object two more times by using counter |n|.
% Read 10 records at a time.

n = 0;

while(hasdata(dbds) && n~=2)
     read(dbds)
     n = n+1;
end

%% Reset |DatabaseDatastore| Object
% Reset the |DatabaseDatastore| object to its original state, where no data
% has been read from it. Resetting allows you to reread from the same
% |DatabaseDatastore| object.

reset(dbds)

%% Read Every Record in |DatabaseDatastore| Object
% Read every record in the |DatabaseDatastore| object in increments of
% 50,000 records at a time.
dbds.ReadSize = 50000;
data = readall(dbds);

%%
% Display the first three records of the full data set.
data(1:3,:)

%% Close |DatabaseDatastore| Object and Database Connection

close(dbds)

%% 
% Copyright 2012 The MathWorks, Inc.