%% Test a Derived Class
% Verify that a derived class is not the same class as its base class.
%
% Create a class, |BaseExample|.
% 
% <include>BaseExample.m</include>
% 
% Create a derived class, |DerivedExample|.
% 
% <include>DerivedExample.m</include>
% 
% Verify the classes are not equal.
testCase = matlab.unittest.TestCase.forInteractiveUse;
verifyClass(testCase, DerivedExample(), ?BaseExample);
%%
% Test fails.

%% 
% Copyright 2012 The MathWorks, Inc.