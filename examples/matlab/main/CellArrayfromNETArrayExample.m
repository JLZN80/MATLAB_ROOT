%% Cell Array from .NET Array  

%% 
% Convert a .NET array of |System.Double| objects into a cell array. 
N = NET.createArray('System.Double[]',2);
N(1) = [13 7 30];
N(2) = 42;
D = cell(N)   



%% 
% Copyright 2012 The MathWorks, Inc.