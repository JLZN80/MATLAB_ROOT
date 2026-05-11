%% Find Information About Table Types in Database
% Use an ODBC connection to find information about all database table types
% in a Microsoft(R) SQL Server(R) database.

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
% Find information about all table types in the database. 

data = sqlfind(conn,'');

%%
% Display information about the first three table types.

data(1:3,:)

%%
% |data| contains these variables:
%
% * Catalog name
% * Schema name
% * Table name
% * Columns in the table type
% * Table type

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.