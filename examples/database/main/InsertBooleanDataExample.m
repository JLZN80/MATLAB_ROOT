%% Insert Boolean Data into Table 
% First, connect to the Microsoft(R) SQL Server(R) database. Then, export
% Boolean data from MATLAB(R) into the database. Close the database
% connection.
%
% Create an ODBC database connection to a Microsoft(R) SQL Server(R)
% database with Windows(R) authentication. Specify a blank user name and
% password. 

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% This database contains the table |Invoice| with these columns: 
%
% * |InvoiceNumber| 
% * |InvoiceDate|
% * |productNumber|
% * |Paid|
% * |Receipt|

%%
% Check the database connection. If the |Message| property is
% empty, then the connection is successful.

conn.Message

%%
% Display the data in the |Invoice| table before insertion.

selectquery = 'SELECT * FROM Invoice';
data = select(conn,selectquery)

%%
% Create the variable |insertdata| as a structure containing the invoice
% number |2105|, product number |11|, and the Boolean data |false| to
% signify unpaid. Boolean data is represented as the MATLAB(R) data type
% |logical|. This code assumes that the receipt image is missing.

insertdata.InvoiceNumber{1} = 2105;
insertdata.InvoiceDate{1} = datestr(now,'yyyy-mm-dd HH:MM:SS');
insertdata.productNumber{1} = 11;
insertdata.Paid{1} = false;

%%
% Insert the paid invoice data into the |Invoice| table with column names
% |colnames| using the database connection.

colnames = {'InvoiceNumber';'InvoiceDate';'productNumber';'Paid'};
tablename = 'Invoice';

fastinsert(conn,tablename,colnames,insertdata)

%%
% View the new record in the database to verify that the |Paid| column
% value is Boolean. In some databases, the MATLAB(R) logical value |false|
% shows as a Boolean |false|, |No|, or a cleared check box.

data = select(conn,selectquery)

%%
% The last row contains the Boolean data |false|.

%%
% Close the database connection.

close(conn)

%% 
% Copyright 2012 The MathWorks, Inc.