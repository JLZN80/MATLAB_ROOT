%% Merged Variable as Table
% Read in a table from a spreadsheet. Display the first three rows.
T1 = readtable('outages.csv');
head(T1,3)
%%
% Merge |Cause|, |Loss|, and |RestorationTime|. Because these variables
% have different types, merge them into a table within a table.
T2 = mergevars(T1,{'Cause','Loss','RestorationTime'},...
               'NewVariableName','LossData','MergeAsTable',true);
head(T2,3)

%% 
% Copyright 2012 The MathWorks, Inc.