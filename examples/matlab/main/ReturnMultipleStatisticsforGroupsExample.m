%% Return Multiple Statistics for Groups  
% Calculate the minimum, mean, and maximum heights for groups of patients
% and return results in a table.

%% 
% Define a function in a file named |multiStats.m| that accepts an input
% vector and returns the minimum, mean, and maximum values of the vector. 
%
% <include>multiStats.m</include>
%
%% 
% Load patient data into a table. 
load patients
T = table(Gender,Height);
summary(T)  

%% 
% Group patient heights by gender. Create a table that contains the outputs
% from |multiStats| for each group. 
[G,gender] = findgroups(T.Gender);
[minHeight,meanHeight,maxHeight] = splitapply(@multiStats,T.Height,G);
result = table(gender,minHeight,meanHeight,maxHeight)

%% 
% Copyright 2012 The MathWorks, Inc.