%% Insert Data into Database Table
% This example shows how to import data from a database into MATLAB(R),
% perform calculations on the data, and export the results to a database
% table.
%
% The example assumes that you are connecting to a Microsoft(R) Access(TM)
% database that contains tables named |salesvolume| and |yearlysales|.
% Also, the example assumes that you start MATLAB as an administrator. The
% |salesvolume| table contains the column names for each month. The
% |yearlysales| table contains the column names |month| and |salestotal|.

%% Connect to Database
% Create a database connection to the Microsoft Access database. For
% example, this code assumes that you are connecting to a data source named
% |dbdemo| with a blank user name and password.

conn = database('dbdemo','','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%% Calculate Sum of Sales Volume for One Month
% Import sales volume data for the month of March using the database
% connection. The |salesvolume| database table contains sales volume data.

tablename = 'salesvolume';
data = sqlread(conn,tablename);

%%
% Display the first three rows of sales volume data. The fourth variable
% contains the data for the month of March.

head(data(:,4),3)

%%
% Calculate the sum of the March sales. Assign the result to the MATLAB
% workspace variable |total| and display the result.

total = sum(data.march)

%% Insert Total Sales for One Month into Database
% Retrieve the name of the month from the sales volume data.

month = data.Properties.VariableNames(4);

%%
% Define the names of the columns for the data to insert as a cell array of
% character vectors.

colnames = {'month' 'salestotal'};

%%
% Create a MATLAB table that stores the data to export.

results = table(month,total,'VariableNames',colnames);

%%
% Determine the status of the |AutoCommit| database flag. This status
% determines whether or not the insert action can be undone.

conn.AutoCommit

%%
% The |AutoCommit| flag is set to |on|. The database commits the exported
% data automatically to the database, and this action cannot be undone.

%%
% Insert the sum of sales for the month of March into the |yearlysales|
% table.

tablename = 'yearlysales';
sqlwrite(conn,tablename,results)

%%
% Import the data from the |yearlysales| table. This data contains the
% calculated result.

data = sqlread(conn,tablename)

%% Close Database Connection

close(conn)
