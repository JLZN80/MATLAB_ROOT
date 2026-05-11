%% Change Missing Values in Imported Data Using Vector Indexing
% Import data from a database in one step using the |select| function.
% During import, the |select| function sets default values for missing data
% in each row. Use the information about the imported data to change
% default values by indexing into the vector.
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
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Import all data from the |Patients| table by executing the SQL |SELECT|
% statement using the |select| function.
%
% |data| is a table that contains the imported data.
%
% |metadata| is a table that contains additional information about each 
% variable in |data|.
%
% * |VariableType| -- MATLAB(R) data type 
% * |MissingValue| -- |NULL| value representation 
% * |MissingRows| -- Vector of row indices that indicate the location of
% missing values

selectquery = 'SELECT * FROM Patients';

[data,metadata] = select(conn,selectquery)

%%
% Retrieve indices that indicate the location of missing values in the
% |Height| variable using the |metadata| output argument.

values = metadata(5,3)
valuesindex = values.MissingRows{1}

%%
% Change the default value for missing data from |-32768| to |0|
% using vector indexing. 

data.Height(valuesindex) = 0;

%%
% View the imported data. 

data.Height

%%
% Missing values appear as |0|.

%%
% Close the database connection.

close(conn)


%% 
% Copyright 2012 The MathWorks, Inc.