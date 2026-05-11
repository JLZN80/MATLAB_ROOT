%% Insert |NULL| Number into Table 
% Use an ODBC connection to insert sales volume data from MATLAB(R) into an
% existing table in a Microsoft(R) SQL Server(R) database. Insert |NULL|
% numbers into the existing database table.

%%
% Create an ODBC database connection to a Microsoft SQL Server
% database with Windows(R) authentication. Specify a blank user name and
% password. The database contains the table |salesVolume|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Create a numeric array that contains monthly sales volume data for a
% specific stock number, and includes a |NULL| number. The value |Inf|
% indicates a |NULL| value. Specify the column names for the existing
% database table |salesVolume|.

n = [100000 Inf 0 2000 500 3000 450 600 700 750 1450 0 0];
colnames = {'StockNumber' 'January' 'February' 'March' 'April' 'May' ... 
    'June' 'July' 'August' 'September' 'October' 'November' 'December'};

%%
% Convert the numeric array to a MATLAB table.
data = array2table(n,'VariableNames',colnames);

%%
% Convert the |Inf| value in the |January| variable to |NaN|. The
% |sqlwrite| function does not accept |Inf| values as valid missing data
% for insertion.

data.January = NaN;

%%
% Import the contents of the database table |salesVolume| into MATLAB and
% display the last few rows.

tablename = 'salesVolume';
rows = sqlread(conn,tablename);
tail(rows,3)

%%
% Insert the sales volume data into the database table |salesVolume|.

sqlwrite(conn,tablename,data)

%%
% Import the contents of the database table into MATLAB again and display
% the last few rows. The results contain a new row for the inserted sales
% volume data.

rows = sqlread(conn,tablename);
tail(rows,4)

%%
% Close the database connection.

close(conn) 


%% 
% Copyright 2012 The MathWorks, Inc.