%% Import Data from Database Table
% Use an ODBC connection to import product data from a database table into
% MATLAB(R) using a Microsoft(R) SQL Server(R) database. Then, perform a
% simple data analysis.

%%
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.
% The database contains the table |productTable|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Import data from the database table |productTable|. The |sqlread|
% function returns a MATLAB(R) table that contains the product data.

tablename = 'productTable';
data = sqlread(conn,tablename);

%%
% Display the first few products. 

head(data,3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.