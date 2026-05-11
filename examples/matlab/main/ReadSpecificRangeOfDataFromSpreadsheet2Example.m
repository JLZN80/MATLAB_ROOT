%% Read Specific Range of Data from Spreadsheet  
% Create a table using data from a specified region of the spreadsheet |patients.xls|.
% Use the data from the 5-by-3 rectangular region between the corners |C2|
% and |E6|. Do not use the first row of this region as variable names.    

%%  
T = readtable('patients.xls',...
    'Range','C2:E6',...
    'ReadVariableNames',false) 

%%
% |T| contains default variable names.   



%% 
% Copyright 2012 The MathWorks, Inc.