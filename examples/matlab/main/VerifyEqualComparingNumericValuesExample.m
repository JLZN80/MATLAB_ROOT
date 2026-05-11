%% Comparing Numeric Values
% Numeric values are equivalent if they are of the same class with equivalent size, complexity, and sparsity.
%
% Create a |TestCase| object for interactive testing.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% A value is equal to itself.
verifyEqual(testCase,5,5);
%%
% Values must have equal sizes.
verifyEqual(testCase,[5 5],5);
%%
% Test failed.

%% 
% Copyright 2012 The MathWorks, Inc.