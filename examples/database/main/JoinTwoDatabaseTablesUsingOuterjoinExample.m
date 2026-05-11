%% Join Two Database Tables
% Use an ODBC connection to import product data from an outer join between
% two Microsoft(R) SQL Server(R) database tables into MATLAB(R). 
%%
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.
% The database contains the tables |productTable| and |suppliers|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Join two database tables, |productTable| and |suppliers|. The
% |productTable| table is the left table of the join, and the
% |suppliers| table is the right table of the join. The
% |sqlouterjoin| function automatically detects the shared column between
% the tables. 
% 
% |data| is a table that contains the matched and unmatched rows from the
% two tables.

lefttable = 'productTable';
righttable = 'suppliers';
data = sqlouterjoin(conn,lefttable,righttable);

%%
% Display the first three rows of joined data. The columns from the right
% table appear to the right of the columns from the left table.

head(data,3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.