%% Test Numeric Tolerances
% Test if 4.95 is equal to 5.
testCase = matlab.unittest.TestCase.forInteractiveUse;
verifyEqual(testCase,4.95,5);
%%
% Test failed.
verifyEqual(testCase,1.5,2,'AbsTol',1)
%% 
verifyEqual(testCase,1.5,2,'RelTol',0.1, ...
    'Difference between actual and expected exceeds relative tolerance')
%% 
% Test failed.

%% 
% Copyright 2012 The MathWorks, Inc.