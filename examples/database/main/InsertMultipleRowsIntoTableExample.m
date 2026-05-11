%% Insert Multiple Rows into Table
% First, connect to the Microsoft(R) SQL Server(R) database. Then, export
% multiple rows of data from MATLAB(R) into the database and close the
% database connection.
%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, the connection is successful.

conn.Message

%%
% Select and display data in the table |inventoryTable|. Import data using
% the |select| function.

selectquery = 'SELECT * FROM inventoryTable';
data = select(conn,selectquery)

%%
% Assign multiple rows of data to the cell array |insertdata|. Each row
% contains data for the columns in |inventoryTable|. The first row of data
% contains:
%
% * Product number is 11
% * Quantity is 125
% * Price is $23.00
% * Inventory date is the current date

insertdata = {11,125,23.00,datestr(now,'yyyy-mm-dd'); ...
    12,1160,14.7,datestr(now,'yyyy-mm-dd'); ...
    13,150,54.5,datestr(now,'yyyy-mm-dd')};
   
%%
% Store the column names of |inventoryTable| in a cell array.

tablename = 'inventoryTable';
colnames = {'productNumber','Quantity','Price','inventoryDate'};

%%
% Insert data into the table.

fastinsert(conn,tablename,colnames,insertdata)

%%
% Select and display data in the table |inventoryTable| again. 

data = select(conn,selectquery)

%%
% Three new rows appear in |inventoryTable| with data from |insertdata|.

%%
% Close the database connection.

close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.