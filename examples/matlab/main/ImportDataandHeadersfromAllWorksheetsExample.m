%% Import Data and Headers from All Worksheets  
% This example shows how to read numeric data and text headers from all
% worksheets in an Excel(R) file into a nested structure array, using the
% |importadata| function.   

%% 
% This example uses a sample spreadsheet file, |testdata.xlsx|, that contains
% the following data in the first worksheet, and similar data in the second
% worksheet. 
% 
%     Time    Temp
%        12     98
%        13     99
%        14     97  

%% 
% Write a sample file, |testdata.xlsx|, for reading. Write an array of sample
% data, |d1|, to the first worksheet in the file and a second array, |d2|,
% to the second worksheet. 
d1 = {'Time','Temp';
     12 98;
     13 99;
     14 97};
 
d2 = {'Time','Temp';
     12 78;
     13 77;
     14 78};

xlswrite('testdata.xlsx',d1,1);
xlswrite('testdata.xlsx',d2,2);  

%% 
% Read the data from all worksheets in |testdata.xlsx|. 
climate = importdata('testdata.xlsx') 

%%
% |importdata| returns a nested structure array, |climate|, with three fields,
% |data|, |textdata|, and |colheaders|. Structures created from Excel files
% with row headers include the field |rowheaders| instead of |colheaders|.  

%% 
% View the contents of the structure array named |data|. 
climate.data 

%%
% |climate.data| contains one field for each worksheet with numeric data.  

%% 
% View the data in the worksheet named |Sheet1|. 
climate.data.Sheet1 

%%
% The field, |Sheet1|, contains the numeric data from the first worksheet
% in the file.  

%% 
% View the column headers in each sheet. 
headers = climate.colheaders 

%%
% Both the worksheets named |Sheet1| and |Sheet2| have the column headers,
% |Time| and |Temp|.   



%% 
% Copyright 2012 The MathWorks, Inc.