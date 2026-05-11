%% Join Two Database Tables in Catalog and Schema
% Use an ODBC connection to import product data from an inner join between
% two Microsoft(R) SQL Server(R) database tables into MATLAB(R). Specify
% the database catalog and schema where the tables are stored. 

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
% |sqlinnerjoin| function automatically detects the shared column between
% the tables. Specify the |toy_store| catalog and the |dbo| schema for
% both the left and right tables. Use the |'LeftCatalog'| and
% |'LeftSchema'| name-value pair arguments for the left table, and the
% |'RightCatalog'| and |'RightSchema'| name-value pair arguments for the
% right table.
% 
% |data| is a table that contains the matched rows from the two tables.

lefttable = 'productTable';
righttable = 'suppliers';
data = sqlinnerjoin(conn,lefttable,righttable,'LeftCatalog','toy_store', ...
    'LeftSchema','dbo','RightCatalog','toy_store','RightSchema','dbo');

%%
% Display the first three rows of matched data. The columns from the right
% table appear to the right of the columns from the left table.

head(data,3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.