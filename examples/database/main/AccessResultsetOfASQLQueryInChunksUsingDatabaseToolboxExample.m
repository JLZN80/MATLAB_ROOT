%% Access Large Data from SQL Query Using Database Toolbox(TM)
% Determine the minimum arrival delay using a large set of flight data
% stored in a database. Access the database in a serial MATLAB(R)
% environment.
%
% Using the |splitsqlquery| function, you can split the original SQL query
% into multiple SQL page queries. Then, you can access large data in
% chunks by using the |fetch| function.
%
% To run this example, you must configure a JDBC data source. For more
% information, see the
% |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function.

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
% Define an SQL query to select all columns from the |airlinesmall|
% table, which contains 123,523 rows and 29 columns.
sqlquery = 'SELECT * FROM airlinesmall';

%%
% Split the original SQL query into multiple page queries and display them.
querybasket = splitsqlquery(conn,sqlquery)

%%
% The query basket contains the page queries in a string array. The
% |splitsqlquery| function splits the queries using the default
% number of rows (100,000).

%%
% Define the |airlinesdata| variable.
airlinesdata = [];

%%
% Define the minimum arrival delay |minArrDelay| variable.
minArrDelay = [];

%%
% Execute the SQL page queries in |querybasket| by using a |for| loop, and
% import the data in chunks. Execute SQL page queries in the query basket,
% and import large data using the |fetch| function. Find and store the
% local minimum arrival delay for each chunk.
for i = 1: length(querybasket)
    
    local_airlinesdata = fetch(conn,querybasket(i));
    
    local_minArrDelay = min(local_airlinesdata.ArrDelay);
    
    minArrDelay = [minArrDelay; local_minArrDelay];
    
end

%%
% Find the minimum arrival delay from all the stored delays.
minArrDelay = min(minArrDelay)

%% 
% Close the database connection.
close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.