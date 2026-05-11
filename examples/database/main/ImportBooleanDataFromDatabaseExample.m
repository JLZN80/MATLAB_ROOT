%% Import Boolean Data from Database
% Import Boolean data from a database table into the MATLAB(R) workspace.
% MATLAB(R) imports Boolean data from databases into the MATLAB(R)
% workspace as data type |logical|. This data has values of |true| or
% |false|. You can store Boolean data in a table, structure, or cell array.
% Perform a simple data analysis on the imported data.
% 
% The code assumes that you have a database table |Invoice| stored in a
% Microsoft(R) SQL Server(R) database. Here, connect to a Microsoft(R) SQL
% Server(R) Version 11.00.2100 database using the Microsoft(R) SQL
% Server(R) Driver 11.00.5058.
%
%% Create Database Connection
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%% Import Boolean Data
% Select the paid data from the |Invoice| table using an SQL |SELECT|
% statement. The database stores paid data as a Boolean to specify whether
% or not an invoice has been paid. Import and display the data using the
% |select| function.

selectquery = 'SELECT Paid FROM Invoice';
data = select(conn,selectquery)

%%
% Database Toolbox(TM) imports the data into the workspace variable |data|.
% The MATLAB(R) table |data| contains |Paid| as a |logical| variable.

%% Perform Data Analysis
% Count the number of unpaid invoices.

unpaid = data.Paid == false;
sum(unpaid)

%% Close Database Connection

close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.