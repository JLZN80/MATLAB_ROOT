function maxProdNum = importAndAnalyzeDataFromDatabase
%  IMPORTANDANALYZEDATAFROMDATABASE The importAndAnalyzeDataFromDatabase
%  function connects to a Microsoft® SQL Server® database using a JDBC
%  driver, imports data from the database into MATLAB®, performs a simple
%  data analysis, and closes the database connection.

%%
% Connect to the database by using the |Vendor| name-value pair argument of
% the database function to specify a connection to an |SQLServer| database.
% Set the |AuthType| name-value pair argument to |Server|. For example,
% this code assumes that you are connecting to a database named |dbname|,
% on a database server named |sname|, with the user name |username|, the
% password |pwd|, and the port number |123456|.
conn = database('dbname','username','pwd', ...
    'Vendor','Microsoft SQL Server','Server','sname', ...
    'AuthType','Server','PortNumber',123456);
%%
% Import data from the |productTable| database table.
tablename = 'productTable';
data = sqlread(conn,tablename);
%%
% Determine the highest product number among products.
prodNums = data.productnumber;
maxProdNum = max(prodNums);
%%
% Close the database connection.
close(conn)
end