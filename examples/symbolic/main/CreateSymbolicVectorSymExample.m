%% Create Symbolic Vector
% Create a 1-by-4 symbolic vector |a| with automatically generated elements
% |a1|, ..., |a4|.
a = sym('a',[1 4])
%%
% Format the names of elements of |a| by using a format character vector as
% the first argument. |sym| replaces |%d| in the format character vector
% with the index of the element to generate the element names.
a = sym('x_%d',[1 4])
%%
% This syntax does not create symbolic variables |x_1|, ..., |x_4| in the 
% MATLAB workspace. Access elements of |a| using standard indexing methods.
a(1)
a(2:3)

% Copyright 2019 The MathWorks, Inc.
