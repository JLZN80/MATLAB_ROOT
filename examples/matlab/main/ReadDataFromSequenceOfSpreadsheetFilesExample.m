%% Read Data from Sequence of Spreadsheet Files
% Read multiple spreadsheet files from a collection and organize the data
% into a MATLAB(R) structure. To import the data, first get a complete list
% of  file names and then read the files one at a time.
%
% <<../data_preview_sequence.jpg>>


%% 
% If the folder _C:\Data_ contains a collection of files, then use the
% _dir_ command to gather the list of file names and display the number of
% files in the collection. Your results will differ based on your files and
% data.

list = dir('C:\Data\*.xlsx');
numFiles = length(list) 

%%
% Import the data one file at a time, using readtable in an for loop. The
% readtable function reads and returns the tabular data from the first
% sheet of the spreadsheet file.
% 
for iFile = 1:numFiles
  FileName = list(iFile).name; 
  Data(iFile).FileName = FileName;
  Data(iFile).T = readtable(FileName);
end

%%
% If your data is located in specific worksheet or range, then when calling
% readtable use the 'Sheet' or 'Range' name-value pair to specify the data
% location. For more information, see the readtable documentation.

%%
% Display the file name and the imported table, for _File01.xlsx_ from
% Data. Your results will differ based on your files and data.
Data(1).FileName
Data(1).T


%% 
% Copyright 2012 The MathWorks, Inc.