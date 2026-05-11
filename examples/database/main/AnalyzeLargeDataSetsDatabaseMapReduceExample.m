%% Analyze Large Data in Database Using MapReduce
% This example determines the mean arrival delay of a large set of flight
% data that is stored in a database. You can access large
% data sets using a |<docid:database_ug.bufomil DatabaseDatastore>| object
% with Database Toolbox(TM). After creating a |DatabaseDatastore| object,
% you can write a MapReduce algorithm that defines the
% chunking and reduction of the data. Alternatively, you can use a tall
% array to run algorithms on large data sets.
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
% The file |airlinesmall.csv| contains a large set of flight data. Load
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
% |airlinesmall| table.

sqlquery = 'select ArrDelay from airlinesmall';

dbds = databaseDatastore(conn,sqlquery);

%% Define Mapper and Reducer Functions
% To process large data sets in chunks, you can write your own mapper
% function. For each chunk in this example, use |meanArrivalDelayMapper.m|
% to:
% 
% * Read arrival-delay data from the |DatabaseDatastore| object.
% * Determine the number of delays and the total delay in the chunk.
% * Store both values in <docid:matlab_ref.buikx8i-1 KeyValueDatastore>. 
%
% The |meanArrivalDelayMapper.m| file contains this code.
%
% <include>meanArrivalDelayMapper.m</include>
%
%%
% You also can write your own reducer function. In this example, use
% |meanArrivalDelayReducer.m| to read intermediate values for the number of
% delays and the total arrival delay. Then, determine the overall mean
% arrival delay. |mapreduce| calls this reducer function only once because
% the mapper function adds just one key to |KeyValueStore|. The
% |meanArrivalDelayReducer.m| file contains this code.
%
% <include>meanArrivalDelayReducer.m</include>
%
%% Run MapReduce Using Mapper and Reducer Functions
% To determine the mean arrival delay in the flight data, run MapReduce
% with the |DatabaseDatastore| object, mapper function, and reducer
% function.
outds = mapreduce(dbds,@meanArrivalDelayMapper,@meanArrivalDelayReducer);

%% Display Output from MapReduce
% Read the table from the output datastore using |readall|.
outtab = readall(outds)
%%
% The table has only one row containing one key-value pair.
%%
% Display the mean arrival delay from the table.
meanArrDelay = outtab.Value{1}
%% Close |DatabaseDatastore| Object and Database Connection
close(dbds)



%% 
% Copyright 2012 The MathWorks, Inc.