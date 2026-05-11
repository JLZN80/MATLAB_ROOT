%% Test for Empty Arrays
% An array with any zero dimension is empty.
testCase = matlab.unittest.TestCase.forInteractiveUse;
verifyEmpty(testCase, ones(2, 5, 0, 3));
%%
verifyEmpty(testCase, [2 3], 'Array is not empty.');
%%
% Test failed.

%% 
% Copyright 2012 The MathWorks, Inc.