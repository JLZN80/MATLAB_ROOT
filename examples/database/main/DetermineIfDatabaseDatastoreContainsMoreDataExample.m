%% Determine If |DatabaseDatastore| Object Contains Data
% Create a database connection using a JDBC driver. To create this
% connection, you must configure a JDBC data source. For more information,
% see the |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function. Then, create a |DatabaseDatastore|
% object and read the data stored in the object until no more data remains.
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
% Create a |DatabaseDatastore| object using the database connection
% and an SQL query. This SQL query reads the first 30 rows
% of data from the |airlinesmall| table.

sqlquery = 'select top 30 * from airlinesmall';

dbds = databaseDatastore(conn,sqlquery);

%%
% Read the first 10 rows.

dbds.ReadSize = 10;
read(dbds)

%%
% Determine if the |DatabaseDatastore| object has additional data.

hasdata(dbds)

%%
% When more data is available in |dbds|, |hasdata| returns |1|.

%%
% Read the rest of the data in |dbds|, 10 rows at a time.

while(hasdata(dbds))
     read(dbds)
end

%%
% When no more data remains in |dbds|, |hasdata| returns logical |0| and
% the |while| loop stops.

%%
% Close the |DatabaseDatastore| object and the database connection.

close(dbds)

%% 
% Copyright 2018 The MathWorks, Inc.