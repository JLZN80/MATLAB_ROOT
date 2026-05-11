function maxProdNum = importPostgreSQLNative
% IMPORTPOSTGRESQLNATIVE The importPostgreSQLNative function connects to a
% PostgreSQL database using the PostgreSQL native interface, imports data
% from the database into MATLAB®, performs a simple data analysis, and
% closes the database connection. The database contains a table named
% |productTable|.
%%
% Connect to the database by using name-value pair arguments of the
% |postgresql| function to specify a connection to a PostgreSQL database.
% For example, this code assumes that you are using the user name
% |username|, password |pwd|, database |dbname|, database server |sname|,
% and port number |5432|.
conn = postgresql("username","pwd", ...
    "DatabaseName","dbname", ...
    "Server","sname", ...
    "PortNumber",5432);
%%
% Import data from the |productTable| database table.
tablename = "productTable";
data = sqlread(conn,tablename);
%%
% Determine the highest product number among products.
prodNums = data.productnumber;
maxProdNum = max(prodNums);
%%
% Close the database connection.
close(conn)
end