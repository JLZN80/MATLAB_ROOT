%% Access Large Data from SQL Query Using Database Toolbox and Parallel Computing Toolbox 
% Determine the minimum arrival delay using a large set of flight data
% stored in a database. Access the database using a parallel pool.
%
% To initialize a parallel pool with a JDBC database connection, you must
% configure a JDBC data source. For more information, see the
% |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function. 
%
% Using the |splitsqlquery| function, you can split the original SQL query
% into multiple SQL page queries. Then, you can access large data in chunks
% by executing each SQL page query on a separate worker in the pool.
%
% When you import large data, the performance depends on the SQL query,
% amount of data, machine specifications, and type of data analysis. To
% manage the performance, use the |splitsize| input argument of the
% |splitsqlquery| function.
%
% If you have a MATLAB(R) Parallel Server(TM) license, then
% use the |<docid:distcomp_ug.btyaatq parpool>| function with the cluster
% profile of your choice instead of the |<docid:distcomp_ug.btyezxk gcp>|
% function.

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
% Specify a split size of 10,000 rows. 
splitsize = 10000;
querybasket = splitsqlquery(conn,sqlquery,'SplitSize',splitsize)

%%
% The query basket contains the page queries in a string array. Each SQL
% query in the basket, except the last one, returns 10,000 rows.

%% 
% Close the database connection.
close(conn)
  
%%
% Start the parallel pool.
pool = gcp;

%%
% Initialize the parallel pool using the JDBC data source.

c = createConnectionForPool(pool,datasource,username,password);

%%
% Define the |airlinesdata| variable.
airlinesdata = [];

%%
% Define the minimum arrival delay |minArrDelay| variable.
minArrDelay = [];

%%
% Use the |parfor| function to parallelize data access using the query
% basket. 
%
% For each worker:
%
% * Retrieve the database connection object.
% * Execute the SQL page query from the query basket and import data
% locally.
% * Find the local minimum arrival delay.
% * Store the local minimum arrival delay.
   
parfor i = 1: length(querybasket)
    
    conn = c.Value;
    
    local_airlinesdata = fetch(conn,querybasket(i));
        
    local_minArrDelay = min(local_airlinesdata.ArrDelay);
        
    minArrDelay = [minArrDelay; local_minArrDelay];
        
end

%%
% Find the minimum arrival delay using the stored delays from each worker.
minArrDelay = min(minArrDelay)

%% 
% Close the parallel pool.
delete(pool)

%% 
% Copyright 2012 The MathWorks, Inc.