%% Insert |NULL| String into Table
% Use an ODBC connection to insert product data from MATLAB(R) into an
% existing table in a Microsoft(R) SQL Server(R) database. Insert a |NULL|
% string into the existing database table.

%%
% Create an ODBC database connection to a Microsoft SQL Server
% database with Windows(R) authentication. Specify a blank user name and
% password. The database contains the table |productTable|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Create a MATLAB table that contains data for one product and includes a
% |NULL| value in the |productDescription| variable.

data = table([30],[500000],[1000],[25], ...
    ["null"],'VariableNames',{'productNumber' ...
    'stockNumber' 'supplierNumber' 'unitCost' 'productDescription'});

%%
% Convert the |null| value in the |productDescription| variable to |""|.
% The |sqlwrite| function does not accept |null| values as valid missing
% data for insertion.

data.productDescription(1) = "";

%%
% Import the contents of the existing database table |productTable| into
% MATLAB and display the last few rows.

tablename = 'productTable';
rows = sqlread(conn,tablename);
tail(rows,3)
%%
% Insert the product data into the database table |productTable|. 

sqlwrite(conn,tablename,data)  

%%
% Import the contents of the database table into MATLAB again and display
% the last few rows. The results contain a new row for the inserted
% product.

rows = sqlread(conn,tablename);
tail(rows,4)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.