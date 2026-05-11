%% Connect to Microsoft(R) SQL Server(R) Using JDBC Driver with Additional Options
% Connect to the Microsoft(R) SQL Server(R) database. Then, import
% data from the database into MATLAB(R), perform simple data analysis, and
% then close the database connection. 
%
% This example assumes that you are connecting to a Microsoft(R) SQL
% Server(R) Version 11.00.2100 database using the Microsoft(R) SQL
% Server(R) JDBC Driver 4.0.2206.100.
%
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication and a login timeout of 5 seconds. Specify
% a blank user name and password.

databasename = 'toy_store';
conn = database(databasename,'','','Vendor','Microsoft SQL Server', ...
    'Server','dbtb04','AuthType','Windows','PortNumber',54317, ...
    'LoginTimeout',5)

%%
% |conn| has an empty |Message| property, which indicates a successful
% connection.
%
% The property sections of the |conn| object are:
%
% * |Database Properties| -- Information about the database configuration
% * |Catalog and Schema Information| -- Names of catalogs and schemas in
% the database
% * |Database and Driver Information| -- Names and versions of the database
% and driver

%%
% Import all data from the table |inventoryTable| into MATLAB(R) using
% the |select| function. Display the first three rows of data.

selectquery = 'SELECT * FROM inventoryTable';
data = select(conn,selectquery);
data(1:3,:)

%%
% Determine the highest quantity in the table.

max(data.Quantity)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.