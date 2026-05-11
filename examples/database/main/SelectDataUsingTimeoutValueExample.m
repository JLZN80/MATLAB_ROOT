%% Select Data Using Timeout Value
% Use an ODBC connection with a timeout value to import product data from a
% Microsoft(R) SQL Server(R) database into MATLAB(R). Then, determine the
% highest unit cost among products.
%
%%
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
% Select all data from the table |productTable| using the |connection|
% object. Specify a timeout value of 10 seconds. The timeout value
% specifies the maximum amount of time the |exec| function tries to execute
% the SQL |SELECT| statement. Assign the SQL |SELECT| statement to the
% variable |sqlquery|. The |cursor| object contains the executed SQL query.

sqlquery = 'SELECT * FROM productTable';
qTimeOut = 10;
curs = exec(conn,sqlquery,qTimeOut)

%% 
% Import data from the table into MATLAB(R). 

curs = fetch(curs);
data = curs.Data;

%%
% Determine the highest unit cost in the table.

max(data.unitCost)

%%
% After you finish working with the |cursor| object, close it. Close the
% database connection.

close(curs)
close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.