%% Run SQL Script in Row Increments
% First, connect to the Microsoft(R) SQL Server(R) database. Then, run two
% SQL |SELECT| statements from a SQL script file. Import data in one-row
% increments. Perform simple sales data analysis. Close the database
% connection.
%
% To find the SQL script file, navigate to
% |\toolbox\database\dbdemos\compare_sales.sql| in your MATLAB(R) root
% folder. Copy and paste the path into your current working folder.
%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password. 

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Run the SQL script and specify one-row increments. The SQL script has two
% queries. When the SQL script executes, it returns two |cursor| objects
% that contain the imported data from each query in a |cursor| object
% array.

results = runsqlscript(conn,'compare_sales.sql','RowInc',1)

%%
% Display the imported data for the second query. 

results(2).Data

%%
% Because of the one-row increment specification, only the first row of
% data is displayed.

%%
% Import the next row of data using the |fetch| function and display it.

curs = fetch(results(2),1);
curs.Data

%%
% Determine the highest sales amount among the months of January, February,
% and March.

data = curs.Data;
max([data.Jan_Sales data.Feb_Sales data.Mar_Sales])

%%
% Close the |cursor| object array, |cursor| object, and database
% connection.

close(results)
close(curs)
close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.