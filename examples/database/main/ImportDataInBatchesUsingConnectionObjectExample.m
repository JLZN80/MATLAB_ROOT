%% Import Data in Batches Using |connection| Object
% Use the |connection| object to import product data in batches from a
% Microsoft(R) SQL Server(R) database table into MATLAB(R). Then, determine
% the highest unit cost among products in the table.
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
% Import all data from |productTable| using the |connection| object and SQL
% query in batches of five rows at a time. Display the imported data.

sqlquery = 'SELECT * FROM productTable';
fetchbatchsize = 5;
results = fetch(conn,sqlquery,fetchbatchsize)

%% 
% Determine the highest unit cost for all products in the table.

max(results.unitCost)

%%
% Close the database connection.

close(conn) 


%% 
% Copyright 2012 The MathWorks, Inc.