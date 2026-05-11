%% Specify Column Types When Inserting Data into New Table
% Use an ODBC connection to insert product data from MATLAB(R) into a new
% table in a Microsoft(R) SQL Server(R) database. Specify the data types of
% the columns in the new database table.

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
% Create a MATLAB table that contains data for two products. 

data = table([30;40],[500000;600000],[1000;2000],[25;30], ...
    ["Rubik's Cube";"Doll House"],'VariableNames',{'productNumber' ...
    'stockNumber' 'supplierNumber' 'unitCost' 'productDescription'});

%%
% Insert the product data into a new database table |toyTable|. Use the
% |'ColumnType'| name-value pair argument and a string array to specify the
% data types of all the columns in the database table.

tablename = 'toyTable';
coltypes = ["numeric" "numeric" "numeric" "numeric" "varchar(255)"];
sqlwrite(conn,tablename,data,'ColumnType',coltypes)

%%
% Import the contents of the database table into MATLAB and display the
% rows. The results contain two rows for the inserted products.

rows = sqlread(conn,tablename)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.