%% Limit Number of Rows in Imported Data
% Import a limited number of rows from a database in one step using the
% |select| function. Database Toolbox(TM) imports the data using MATLAB(R)
% numeric data types that correspond to data types in the database table.
% After importing data, you can access data and perform immediate data
% analysis.
%							
% The code assumes that you have a database table |Patients| stored on a
% Microsoft(R) SQL Server(R) database. This table contains patient data in
% 10 columns and rows. The table definition is:
%
%   CREATE TABLE Patients(
%         LastName VARCHAR(50),
%         Gender VARCHAR(10), 
%         Age TINYINT, 
%         Location VARCHAR(300), 
%         Height SMALLINT, 
%         Weight SMALLINT,
%         Smoker BIT, 
%         Systolic FLOAT,
%         Diastolic NUMERIC,
%         SelfAssessedHealthStatus VARCHAR(20))
%
% Here, connect to a Microsoft(R) SQL Server(R) Version 11.00.2100 database
% using the Microsoft(R) SQL Server(R) Driver 11.00.5058.
%
%%
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Import data from the |Patients| table by executing the SQL |SELECT|
% statement using the |select| function. Limit the number of imported rows
% using the name-value pair argument |'MaxRows'|.
%
% |data| is a table. The MATLAB(R) data types in the table correspond to
% the data types in the database. Here, |Age| has data type |uint8| that
% corresponds to |TINYINT| in the table definition.
%
% |metadata| is a table that contains additional information about each 
% variable in |data|.
%
% * |VariableType| -- MATLAB(R) data type 
% * |MissingValue| -- |NULL| value representation 
% * |MissingRows| -- Vector of row indices that contain a missing value

selectquery = 'SELECT * FROM Patients';

[data,metadata] = select(conn,selectquery,'MaxRows',5)

%%
% Determine the number of male patients by immediately accessing the data.
% Use the |count| function to find occurrences in the gender data of the
% character vector that represents a male. Determine the total number of
% occurrences.

males = count(data.Gender,'Male');
sum(males)

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.