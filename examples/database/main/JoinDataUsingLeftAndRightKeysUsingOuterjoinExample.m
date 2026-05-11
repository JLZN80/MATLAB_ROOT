%% Join Data Using Left and Right Keys 
% Use an ODBC connection to import employee data from an outer join between
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
% |data| is a table that contains the matched and unmatched rows from the
% two tables.

lefttable = 'employees';
righttable = 'departments';
data = sqlouterjoin(conn,lefttable,righttable,'LeftKeys','MANAGER_ID', ...
    'RightKeys','DEPT_MANAGER_ID');

%%
% Display the last three unmatched rows of joined data. Display the last
% five variables of the joined data.

tail(data(:,end-4:end),3)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.