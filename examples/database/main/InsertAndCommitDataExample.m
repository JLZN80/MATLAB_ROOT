%% Insert and Commit Data in Table
% First, connect to the Microsoft(R) SQL Server(R) database. Then, export
% data from MATLAB(R) into the database and commit the insert transaction.
% Close the database connection.
%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password. Use the name-value pair argument |AutoCommit| to specify
% manually committing transactions to the database.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','','AutoCommit','off');

%%
% Check the database connection. If the |Message| property is
% empty, the connection is successful.

conn.Message

%%
% Insert the cell array |data| into the table |inventoryTable| with column
% names |colnames|.

data = {157,358,740.00,datestr(now,'yyyy-mm-dd HH:MM:SS')};
colnames = {'productNumber','Quantity','Price','inventoryDate'};
tablename = 'inventoryTable';

fastinsert(conn,tablename,colnames,data)

%%
% Commit the insert transaction.

commit(conn)

%%
% Close the database connection.

close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.