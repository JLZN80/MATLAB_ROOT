%% Insert Row into Table Using ODBC Driver
% First, connect to the Microsoft(R) SQL Server(R) database. Then, export
% data from MATLAB(R) into the database and close the database connection.
%
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, the connection is successful.

conn.Message

%%
% Select and display all rows in the table sorted by the product number
% using the |select| function.

selectquery = 'SELECT * FROM productTable ORDER BY productNumber';

data = select(conn,selectquery)

%%
% Store the column names of |productTable| in a cell array.

tablename = 'productTable';
colnames = {'productNumber','stockNumber','supplierNumber', ...
    'unitCost','productDescription'};
                
%%
% Store the data for the insert in a cell array that contains
% these values:
%
% * |productNumber| equal to 4
% * |stockNumber| equal to 500565
% * |supplierNumber| equal to 1010
% * |unitCost| equal to $20
% * |productDescription| equal to |'Cooking Set'|
%
% Then, convert the cell array to a table.

insertdata = {4,500565,1010,20,'Cooking Set'};
insertdata = cell2table(insertdata,'VariableNames',colnames)

%%
% Insert data into the table.

fastinsert(conn,tablename,colnames,insertdata)

%%
% Select and display all rows in the table again.

data = select(conn,selectquery)

%%
% A new row appears in the |productTable| with data from |insertdata|.

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.