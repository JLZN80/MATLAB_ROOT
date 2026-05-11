%% Matrix Operations
% This example shows how to use arithmetic operators on matrices. You can use these arithmetic operations to perform numeric computations.
%
% Copyright 2018 The MathWorks, Inc.
%%
% MATLAB allows you to process all the values in a matrix using a single arithmetic operator or function.
%
% Create a 3-by-3 matrix.
disp('Create 3-by-3 matrix a:')
disp('>> a = [1 2 3; 4 5 6; 7 8 10]')
a = [1 2 3; 4 5 6; 7 8 10]
%%
% You can add a scalar to each element of the matrix with a single operator.
disp('Add 10 to each matrix value:')
disp('>> a + 10')
a + 10
%%
% You can calculate the sine for each of those values using a single function.
disp('Calculate sine for each value of a:')
disp('>> sin(a)')
sin(a)
%%
% To transpose a matrix, use a single quote (').
disp('Transpose a:')
disp('>> a''')
a'
%%
% You can also perform standard matrix multiplication, which computes the inner products between rows and columns, using the multiplication '*' operator. 
% This example confirms that a matrix multiplied by its inverse returns the identity matrix.
disp('Multiply matrix a by its inverse:')
disp('>> p = a*inv(a)')
p = a*inv(a)
%%
% To perform multiplication on each individual element, use the element-wise multiplication '.*' operator.
disp('Multiply matrix a by itself (element-wise):')
disp('>> p = a.*a')
p = a.*a  