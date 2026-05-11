%% Import All Data Using |connection| Object
% Import all product data from a Microsoft(R) SQL Server(R) database table
% into MATLAB(R) by using the |connection| object. Then, determine the
% highest unit cost among products in the table.
%
%%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password. The database contains the table |productTable|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Import all the data from |productTable| by using the |connection| object
% and SQL query, and display the imported data.

sqlquery = 'SELECT * FROM productTable';
results = fetch(conn,sqlquery)

%% 
% Determine the highest unit cost for all products in the table.

max(results.unitCost)

%%
% Close the database connection.

close(conn)

%%
% Copyright 2016 The MathWorks, Inc.
