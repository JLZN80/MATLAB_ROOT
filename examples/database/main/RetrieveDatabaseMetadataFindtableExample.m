%% Retrieve Database Metadata
% This example shows how to retrieve database information using the
% |connection| object and the |sqlfind| function.
%
% The example assumes that you are connecting to a Microsoft(R) SQL
% Server(R) database that contains a table named |productTable|.

%% Connect to Database
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%% Find Catalogs and Schemas
% Display the catalogs in the database by using the |Catalogs| property of
% the |connection| object.

conn.Catalogs

%%
% Display the first three schemas in the database by using the |Schemas|
% property of the |connection| object.

conn.Schemas{1:3}

%% Find Table Types
% Find all table types in the database by using the |sqlfind| function
% with the |connection| object.

tables = sqlfind(conn,'');

%%
% Display the first three table types.

tables(1:3,:)

%%
% Find the table type of the table |productTable|.

tablename = 'productTable';
data = sqlfind(conn,tablename);
data.Type

%% Find Table Columns
% Find all columns in the database table |productTable| and display them.

data = sqlfind(conn,tablename);
data.Columns{:}

%% Close Database Connection

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.