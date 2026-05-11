%% Read Spreadsheet File
% Create a |SpreadsheetDatastore| object containing the file
% |airlinesmall_subset.xlsx|.
ssds = spreadsheetDatastore('airlinesmall_subset.xlsx')

%% 
% Display the sheet names for the file.  The file contains one sheet per
% year.
sheetnames(ssds,1)

%%
% Specify the variable |FlightNum| in the second sheet as the data of
% interest, and preview the first eight rows.
ssds.Sheets = 2; 
ssds.SelectedVariableNames = 'FlightNum';
preview(ssds)

%%
% Read only the first three rows of variables |DepTime| and |ArrTime| in
% the first sheet.
ssds.ReadSize = 3;
ssds.Sheets = 1;
ssds.SelectedVariableNames = {'DepTime','ArrTime'};
read(ssds)

%%
% Read all of sheets four, five, and six.
ssds.Sheets = 4:6;
readall(ssds);


%% 
% Copyright 2012 The MathWorks, Inc.