%% Saving and Loading MAT Files
% This example shows how to save and load a MAT file.
%
% Copyright 2018 The MathWorks, Inc.
%%
% Create variable matVar1 with a 2-by-3 matrix of uniformly distributed random numbers between 0 and 1.
disp('Create variable matVar1:')
matVar1 = rand(2, 3)
%%
% Create variable matVar2 with a 3-by-3 matrix constructed from the integers 1 through 9 with equal row and column sums.
disp('Create variable matVar2:')
matVar2 = magic(3)
%%
% Create variable matVar3 with a table constructed by 3 rows and 2 columns.
disp('Create variable matVar3:')
matVar3 = table([10; 20; 30], {'M'; 'F'; 'F'}, 'VariableNames', {'Age', 'Gender'})
%%
% List the names of variables in the current workspace that start with matVar.
disp('List variables starting with matVar.')
who('matVar*')
%%
% Save variables matVar1, matVar2, and matVar3 in a MATLAB formatted binary file (MAT-file) called 'example.mat'.
disp('Save variables to MAT-file:')
disp('>> save example.mat matVar1 matVar2 matVar3')
save example.mat matVar1 matVar2 matVar3;
%%
% Remove variables matVar1 and matVar2 from the current workspace.
disp(' ')
disp('Remove matVar1 and matVar2 from the current workspace:')
disp('>> clear matVar1 matVar2')
clear matVar1 matVar2;
%%
% List the names of the variables in the current workspace that start with matVar.
disp(' ')
disp('List variables starting with matVar.')
who('matVar*')
%%
% Load the variables in the MAT-File 'example.mat' into the current workspace.
disp('Load variables from example.mat:')
disp('>> load example.mat')
load example.mat;
%%
% List the names of the variables in the current workspace that start with 'matVar'.
disp(' ')
disp('List variables starting with matVar.')
who('matVar*')
%%
% Display any variable by typing the variable name.
disp('Display variable matVar1:')
disp('>> matVar1')
matVar1 