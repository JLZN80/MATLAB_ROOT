%% Append Data into Existing Table
% Use an ODBC connection to append product data from a MATLAB(R) table into
% an existing table in a Microsoft(R) SQL Server(R) database. 

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
% To view the existing database table |productTable| before appending data,
% import its contents into MATLAB and display the last few rows.

tablename = 'productTable';
rows = sqlread(conn,tablename);
tail(rows,3)

%%
% Create a MATLAB table that contains the data for one product. 

data = table(30,500000,1000,25,"Rubik's Cube", ...
    'VariableNames',{'productNumber' 'stockNumber' ...
    'supplierNumber' 'unitCost' 'productDescription'});

%%
% Append the product data into the database table |productTable|. 

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