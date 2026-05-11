%% Create Symbolic Matrices
% Create a 3-by-4 symbolic matrix with automatically generated elements.
% The elements are of the form |Ai_j|, which generates the elements
% |A1_1|, ..., |A3_4|.
A = sym('A',[3 4])
%%
% Create a 4-by-4 matrix with the element names |x_1_1|, ..., |x_4_4| by
% using a format character vector as the first argument. |sym| replaces
% |%d| in the format character vector with the index of the element to
% generate the element names.
B = sym('x_%d_%d',4)
%%
% This syntax does not create symbolic variables
% |A1_1|, ..., |A3_4|, |x_1_1|, ..., |x_4_4| in the MATLAB workspace. To
% access an element of a matrix, use parentheses.
A(2,3)
B(4,2)

% Copyright 2019 The MathWorks, Inc.