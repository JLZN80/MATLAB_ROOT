%% Test a Function Handle
% These interactive tests verify function handles, specified as a meta.class instance, |?function_handle|.
%
% Create a |TestCase| object.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%% 
% Create a function handle.
fh = @sin;
verifyClass(testCase, fh, ?function_handle);
%% 
% Test the function name.
fh = 'sin';
verifyClass(testCase, fh, ?function_handle);
%% 
% Test fails.

%% 
% Copyright 2012 The MathWorks, Inc.