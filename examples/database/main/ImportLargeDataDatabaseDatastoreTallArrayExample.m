%% Analyze Large Data in Database Using Tall Arrays
% This example determines the minimum arrival delay of a large set of
% flight data that is stored in a database. You can access large data sets
% and create a tall array using a |DatabaseDatastore| object with Database
% Toolbox(TM). Once a tall array exists, you can visualize data in the tall
% array. Alternatively, you can write a MapReduce algorithm that defines
% the chunking and reduction of the data.
%
% The |DatabaseDatastore| object does not support using a parallel pool
% with Parallel Computing Toolbox(TM) installed. To analyze data using tall
% arrays or run MapReduce algorithms, set the global execution environment
% to be the local MATLAB(R) session.
%
% This example uses a preconfigured JDBC data source to create the database
% connection. For more information, see the
% |<docid:database_ug.mw_d352a952-94c7-43ca-9504-2982f16c0204
% configureJDBCDataSource>| function.
%% Create |DatabaseDatastore| Object
% Set the global execution environment to be the local MATLAB(R) session.
mapreducer(0);

%%
% The file |airlinesmall.csv| contains the large set of flight data. Load
% this file into the Microsoft(R) SQL Server(R) database table
% |airlinesmall|. This table contains 123,523 records.

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
% Create a |DatabaseDatastore| object using the database connection and an
% SQL query. This SQL query retrieves arrival-delay data from the
% |airlinesmall| table. |databaseDatastore| executes the SQL query.

sqlquery = 'select ArrDelay from airlinesmall';

dbds = databaseDatastore(conn,sqlquery,'ReadSize',50000);

%% Find Minimum Arrival Delay Using Tall Array
% Because the |DatabaseDatastore| object returns a table, create a tall
% table.
tt = tall(dbds);

%%
% Find the minimum arrival delay. 
minArrDelay = min(tt.ArrDelay); 

%%
% |minArrDelay| contains the unevaluated minimum arrival delay. To return
% the output value, use |gather|. For details, see
% <docid:import_export.bvciqpo>.
minArrDelayValue = gather(minArrDelay)

%%
% In addition to determining a minimum, tall arrays support many other
% functions. For details, see <docid:import_export#bvexb2c>.

%% Close |DatabaseDatastore| Object and Database Connection
close(dbds)

%% 
% Copyright 2018 The MathWorks, Inc.