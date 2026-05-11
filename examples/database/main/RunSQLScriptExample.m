%% Run SQL Script
% First, connect to the Microsoft(R) SQL Server(R) database. Then, run two
% SQL |SELECT| statements from a SQL script file. Perform simple sales data
% analysis. Close the database connection.
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
% Run the SQL script. The SQL script has two queries. When the SQL script
% executes, it returns two |cursor| objects that contain the imported
% data from each query in a |cursor| object array.

scriptfile = 'compare_sales.sql';

results = runsqlscript(conn,scriptfile)

%%
% Display the |cursor| object for the second query.

results(2)

%%
% Display the imported data for the second query.

data = results(2).Data

%%
% Retrieve the column names for the second query.

names = columnnames(results(2))

%%
% Determine the highest sales amount in January.

max(data.Jan_Sales)

%%
% Close the |cursor| object array and database connection.

close(results)
close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.