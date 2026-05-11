%% Test for Empty Cell Arrays
% Test empty cell array.
testCase = matlab.unittest.TestCase.forInteractiveUse;
verifyEmpty(testCase,{},'Cell array is not empty.');
%%
% A cell array of empty arrays is not empty.
verifyEmpty(testCase,{[],[],[]},'Cell array is not empty.');

%% 
% Copyright 2012 The MathWorks, Inc.