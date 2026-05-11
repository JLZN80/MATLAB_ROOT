%% Import Data from Database Table Using |sqlread| Function
% This example shows how to import data from a table in a Microsoft(R)
% Access(TM) database into the MATLAB(R) workspace using the |sqlread|
% function. The example then shows how to use an SQL script to import data
% from an SQL query that contains multiple joins.
%
%% Connect to Database
% Create a Microsoft Access database connection with the data source name
% |dbdemo| using an ODBC driver and a blank user name and password. This
% database contains the table |producttable|.

conn = database('dbdemo','','');

%%
% If you are connecting to a database using a JDBC connection, then specify
% a different syntax for the database function.

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%% Import Data from Database Table
% Import product data from the database table |producttable| by using the
% |sqlread| function and the database connection. This function imports
% data as a MATLAB table.

tablename = 'producttable';
data = sqlread(conn,tablename);

%% 
% Display the product number and description in the imported data.
data(:,[1 5])

%% Import Data Using Multiple Joins in SQL Query
% Create an SQL script file named |salesvolume.sql| with the following SQL
% query. This SQL query uses multiple joins to join these tables in the
% |dbdemo| database:
% 
% * |producttable|
% * |salesvolume|
% * |suppliers|
%
% The purpose of the query is to import sales volume data for suppliers
% located in the United States.
% 
% <include>salesvolume.sql</include>
%
%%
% Run the |salesvolume.sql| file by using the |executeSQLScript| function.
% |results| is a structure array with the data returned from running the
% SQL query in the SQL script file.

results = executeSQLScript(conn,'salesvolume.sql');

%%
% Display the first three rows in the |Data| table. Access this table as a
% field of the structure array by using dot notation.

head(results(1).Data,3)

%% Close Database Connection

close(conn)

%%
% Copyright 2018 The MathWorks, Inc.