%% Join Data Using Left and Right Keys
% Use an ODBC connection to import employee data from an inner join between
% two Microsoft(R) SQL Server(R) database tables into MATLAB(R). Specify
% the left and right keys for the join.

%%
% Create an ODBC database connection to a Microsoft SQL Server database
% with Windows(R) authentication. Specify a blank user name and password.
% The database contains the tables |employees| and |departments|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Join two database tables, |employees| and |departments|, to find the
% managers for particular departments. The |employees| table is
% the left table of the join, and the |departments| table is the right
% table of the join. Here, the column names of the keys are different.
% Specify the |MANAGER_ID| key in the left table using the |'LeftKeys'|
% name-value pair argument. Specify the |DEPT_MANAGER_ID| key in the right
% table using the |'RightKeys'| name-value pair argument.
%
% |data| is a table that contains the matched rows from the two tables.

lefttable = 'employees';
righttable = 'departments';
data = sqlinnerjoin(conn,lefttable,righttable,'LeftKeys','MANAGER_ID', ...
    'RightKeys','DEPT_MANAGER_ID');

%%
% Display the first three rows of joined data. The columns from the right
% table appear to the right of the columns from the left table.

head(data,3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.