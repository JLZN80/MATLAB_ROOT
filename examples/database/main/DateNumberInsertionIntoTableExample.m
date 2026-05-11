%% Insert Date Number into Table 
% Use an ODBC connection to insert inventory data from MATLAB(R) into an
% existing table in a Microsoft(R) SQL Server(R) database. Insert a date
% stored as a date number into the existing database table.

%%
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.
% The database contains the table |inventoryTable|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Create a numeric array that contains inventory data for a specific
% product, including the date number |731011|. Specify the column names for
% the existing database table |inventoryTable|.

n = [25 1000 50 731011];
colnames = {'productNumber' 'Quantity' 'Price' 'inventoryDate'};

%%
% Convert the numeric array to a MATLAB table.
data = array2table(n,'VariableNames',colnames);

%%
% Convert the date value in the inventory data to a |datetime| array. The
% |sqlwrite| function does not accept date numbers as a valid data type
% for insertion.

n = data.inventoryDate;
data.inventoryDate = datetime(n,'ConvertFrom','datenum');

%%
% Import the contents of the database table |inventoryTable| into MATLAB
% and display the last few rows.

tablename = 'inventoryTable';
rows = sqlread(conn,tablename);
tail(rows,3)

%%
% Insert the inventory data into the database table |inventoryTable|.
% Specify the schema where the table is stored by using the |'Schema'|
% name-value pair argument.

sqlwrite(conn,tablename,data,'Schema','dbo')

%%
% Import the contents of the database table into MATLAB again and display
% the last few rows. The results contain a new row for the inserted
% inventory data.

rows = sqlread(conn,tablename);
tail(rows,4)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.