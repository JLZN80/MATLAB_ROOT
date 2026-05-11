%% Find Information About Table Types in Catalog and Schema
% Use an ODBC connection to find information about all database table types
% in a Microsoft(R) SQL Server(R) database. Specify the database catalog
% and schema to search.

%%
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Find information about all table types in the |toy_store| database
% catalog and the |dbo| database schema. Use the |'Catalog'| name-value
% pair argument to specify the catalog. Use the |'Schema'| name-value pair
% argument to specify the schema. 
%
% |data| is a table that contains information about all the table types in
% the specified catalog and schema.

data = sqlfind(conn,'','Catalog','toy_store','Schema','dbo');

%%
% Display the first eight table types.

head(data)

%%
% |data| contains these variables:
%
% * Catalog name
% * Schema name
% * Table name
% * Columns in the database table
% * Table type

%%
% Display the column names in the fourth table type.

data.Columns{4}

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.