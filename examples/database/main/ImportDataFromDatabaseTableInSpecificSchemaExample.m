%% Import Data from Database Table in Specific Schema
% Use an ODBC connection to import product data from a database table into
% MATLAB(R) using a Microsoft(R) SQL Server(R) database. Specify the schema
% where the database table is stored. Then, sort and filter the rows in the
% imported data and perform a simple data analysis.

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
% Import data from the table |productTable|. Specify the database schema
% |dbo|. The |data| table contains the product data.

tablename = 'productTable';
data = sqlread(conn,tablename,'Schema','dbo');

%%
% Display the first few products. 

data(1:3,:)

%%
% Display the first few product descriptions.

data.productDescription(1:3)

%%
% Sort the rows in |data| by the product description column in alphabetical
% order.

column = 'productDescription';
data = sortrows(data,column);

%%
% Display the first few product descriptions after sorting.

data.productDescription(1:3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.