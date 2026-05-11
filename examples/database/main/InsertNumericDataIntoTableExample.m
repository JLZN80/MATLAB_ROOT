%% Insert Numeric Data into Table
% First, connect to the Microsoft(R) SQL Server(R) database. Then, export
% numeric data from MATLAB(R) into the database and close the
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
% Define the numeric matrix |numdata| that contains sales volume data.

numdata = [777666,0,350,400,450,250,450,500,515,235,100,300,600];
    
%%
% Select and display data in the |salesVolume| table before insertion.
% Import data using the |select| function.

selectquery = 'SELECT * FROM salesVolume';
data = select(conn,selectquery)

%%
% Store the column names of |salesVolume| in a cell array.

tablename = 'salesVolume';
colnames = {'stockNumber','January','February','March','April','May', ...
    'June','July','August','September','October','November', ...
    'December'};

%%
% Insert data into the table.

fastinsert(conn,tablename,colnames,numdata)

%%
% Select and display data in the |salesVolume| table again.
  
data = select(conn,selectquery)

%%
% A new row appears in |salesVolume| with data from |numdata|.

%%
% Close the database connection.

close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.