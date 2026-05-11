%% Import and Access Data Immediately
% Import data from a database in one step using the |select| function.
% You can access data and perform immediate data analysis.
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
% This example uses a Microsoft(R) SQL Server(R) Version 11.00.2100
% database and the Microsoft(R) SQL Server(R) Driver 11.00.5058.
%
% Create a database connection to a Microsoft(R) SQL Server(R) database
% with Windows(R) authentication. Specify a blank user name and password.

datasource = 'MS SQL Server Auth';
conn = database(datasource,'','');

%%
% Import all data from the |Patients| table by executing the SQL |SELECT|
% statement using the |select| function. |data| is a table that contains
% the imported data.

selectquery = 'SELECT * FROM Patients';

data = select(conn,selectquery)

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