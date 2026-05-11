%% Insert Structure into Table 
% Use an ODBC connection to insert product data from MATLAB(R) into a new
% table in a Microsoft(R) SQL Server(R) database. Insert data stored as a
% structure into the new database table.

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
% Create a structure array that contains data for two products. 

s(1).productNumber = 30;
s(1).stockNumber = 500000;
s(1).supplierNumber = 1000;
s(1).unitCost = 25;
s(1).productDescription = "Rubik's Cube";

s(2).productNumber = 40;
s(2).stockNumber = 600000;
s(2).supplierNumber = 2000;
s(2).unitCost = 30;
s(2).productDescription = "Doll House";

%%
% Convert the structure to a MATLAB table.
data = struct2table(s);

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