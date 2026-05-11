%% Insert Cell Array into Table
% Use an ODBC connection to insert product data from MATLAB(R) into a new
% table in a Microsoft(R) SQL Server(R) database. Insert data stored as a
% cell array into the new database table.

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
% Create a cell array that contains data for two products. 

c = {30,500000,1000,25,"Rubik's Cube";40,600000,2000,30,"Doll House"};

%%
% Convert the cell array to a MATLAB table by specifying the column names.
colnames = {'productNumber' 'stockNumber' 'supplierNumber' 'unitCost' ... 
    'productDescription'};
data = cell2table(c,'VariableNames',colnames);

%%
% Insert the product data into a new database table |toyTable|. 
tablename = 'toyTable';
sqlwrite(conn,tablename,data)

%%
% Import the contents of the database table into MATLAB and display the
% rows. The results contain two rows for the inserted products.

rows = sqlread(conn,tablename)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.