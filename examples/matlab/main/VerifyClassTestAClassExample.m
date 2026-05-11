%% Test a Class
% These interactive tests verify the class of the number, 5.
%
% Create a |TestCase| object and the value to test.
testCase = matlab.unittest.TestCase.forInteractiveUse;
actvalue = 5;
%% 
% Verify class of |actvalue| is double.
verifyClass(testCase, actvalue, 'double');
%% 
% Verify class of |actvalue| is char.
verifyClass(testCase, actvalue, 'char');
%% 
% Test fails.

%% 
% Copyright 2012 The MathWorks, Inc.