%% Accessing Array Elements
% This example shows how to access selected elements of an array using indexing.
%
% Copyright 2018 The MathWorks, Inc.
%%
% Create a magic square matrix constructed from the integers 1 through 16 with equal row and column sums.
disp('Create 4-by-4 magic square a:')
disp('>> a = magic(4)')
a = magic(4)
%%
% To reference a particular element in an array, specify its row and column number using the following syntax, where A is the matrix variable. 
% Always specify the row first and column second.
disp('Reference element in row 4, column 2:')
disp('>> a(4, 2)')
a(4, 2)
%%
% To refer to multiple elements of an array, use the colon ':' operator, which allows you to specify a range of elements using the form 'start:end'.
disp('List the elements in the first three rows and the second column of a:')
disp('>> a(1:3, 2)')
a(1:3, 2)
%%
% The colon alone, without start or end values, specifies all the elements in that dimension.
disp('Select all the columns in the third row of a:')
disp('>> a(3, :)')
a(3, :)