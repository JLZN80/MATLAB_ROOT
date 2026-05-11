%% Write Vector to Spreadsheet  
% Write a 7-element vector to a file that Microsoft(R) Excel(R) can read.   

%%  
filename = 'testdata.csv';
A = [12.7 5.02 -98 63.9 0 -.2 56];
xlswrite(filename,A)   



%% 
% Copyright 2012 The MathWorks, Inc.