%% Creating Matrices and Arrays
% This example shows basic techniques for creating arrays and matrices using MATLAB. Matrices and arrays are the fundamental representation of information and data in MATLAB.
%
% Copyright 2018 The MathWorks, Inc.
%%
% To create an array with multiple elements in a single row, separate the elements with either a comma ',' or a space.
% This type of array is called a row vector.
disp('Create an array with four elements in a single row:')
disp('>> a = [1 2 3 4]')
a = [1 2 3 4]
%%
% To create an array with multiple elements in a single column, separate the elements with semicolons ';'.
% This type of array is called a column vector.
disp('Create an array with four elements in a single column:')
disp('>> a = [1; 2; 3; 4]')
a = [1; 2; 3; 4]
%%
% To create a matrix that has multiple rows, separate the rows with semicolons.
disp('Create a matrix with three rows and three columns:')
disp('>> a = [1 2 3; 4 5 6; 7 8 9]')
a = [1 2 3; 4 5 6; 7 8 9]
%%
% To create an evenly spaced array, specify the start and end point by using the ':' operator.
disp('Create an array that starts at 1, ends at 9, with each element separated by 2:')
disp('>> x = 1:2:9')
x = 1:2:9
%%
% Another way to create a matrix is to use a function, such as ones, zeros or rand.
disp('Create a 1-by-5 matrix of 0''s:')
disp('>> z = zeros(1, 5)')
z = zeros(1, 5) 