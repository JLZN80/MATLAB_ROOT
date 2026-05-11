%% Import Numeric Data from All Worksheets  
% This example shows how to import worksheets in an Excel(R) file that contains
% only numeric data (no row or column headers, and no inner cells with text)
% into a structure array, using the |importdata| function.   

%% 
% Create a sample spreadsheet file for importing by writing an array of
% numeric data to the first and second worksheets in a file called |numdata.xlsx|. 
xlswrite('numdata.xlsx',rand(5,5),1);
xlswrite('numdata.xlsx',rand(5,6),2);  

%% 
% Import the data from all worksheets in |numdata.xlsx|. 
S = importdata('numdata.xlsx') 

%%
% |importdata| returns a structure array, |S|, with one field for each worksheet
% with data.   



%% 
% Copyright 2012 The MathWorks, Inc.