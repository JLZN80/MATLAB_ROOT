%% Determine If Database Connection Is Open
% Connect to a Microsoft(R) SQL Server(R) database and verify the
% database connection. Then, import data from the database into MATLAB(R).
% Determine the highest unit cost among the retrieved products in the
% table. Close the database connection.
%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password. The database contains the table |productTable|.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Check the database connection. If the |Message| property is
% empty, the connection is successful.

conn.Message

%%
% Determine if the database connection is open. The |isopen| function
% returns the numeric scalar |1|, which means the database connection is
% open.

i = isopen(conn)

%%
% Select all the data from |productTable| and sort it by the product
% number. |data| is a table containing the imported data that results from
% executing the SQL |SELECT| statement.

selectquery = 'SELECT * FROM productTable ORDER BY productNumber';
data = select(conn,selectquery);

%%
% Display the first three rows of data.

data(1:3,:)

%%
% Determine the highest unit cost in the table.

max(data.unitCost)

%%
% Close the database connection.

close(conn)

%%
% Determine if the database connection is closed. The |isopen| function
% returns the numeric scalar |0|, which means the database connection is
% closed. If the database connection is invalid, the |isopen| function
% returns the same result.

i = isopen(conn)
