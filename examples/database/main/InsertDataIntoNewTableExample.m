%% Insert Data into New Table
% Use an ODBC connection to insert product data from MATLAB(R) into a new
% table in a Microsoft(R) SQL Server(R) database.

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