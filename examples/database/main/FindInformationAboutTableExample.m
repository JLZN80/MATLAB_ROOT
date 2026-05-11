%% Find Information About Table
% Use an ODBC connection to find information about a database table in a
% Microsoft(R) SQL Server(R) database.

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
% Find information about any tables that contain the pattern |product| in
% the table name. The |sqlfind| function returns information about the
% table |productTable|.

pattern = 'product';
data = sqlfind(conn,pattern)

%%
% |data| contains these variables:
%
% * Catalog name
% * Schema name
% * Table name
% * Columns in the database table
% * Table type

%%
% Display the column names in |productTable|.

data.Columns{:}

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.