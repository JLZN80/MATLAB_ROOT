%% Test Table Equality with |TableComparator|
% Create a test case for interactive testing.
testCase = matlab.unittest.TestCase.forInteractiveUse;
%%
% Create two equal tables.
LastName = {'Williams';'Jones';'Brown'};
Age = [38;40;49];
Height = [64;67;64];
Weight = [131;133;119];
BloodPressure = [125 83; 117 75; 122 80];

T1 = table(Age,Height,Weight,BloodPressure, ... 
    'RowNames',LastName);
T2 = T1;
%%
% Test that the tables are equal.  Check the columns of the tables with a
% numeric comparator.
import matlab.unittest.constraints.TableComparator
import matlab.unittest.constraints.NumericComparator
import matlab.unittest.constraints.IsEqualTo
testCase.verifyThat(T1,IsEqualTo(T2, ...
    'Using',TableComparator(NumericComparator)))
%%
% Change the age of the last person to 50 and compare the tables again.
T2.Age(end) = 50;
testCase.verifyThat(T1,IsEqualTo(T2, ...
    'Using',TableComparator(NumericComparator)))

%% 
% Copyright 2012 The MathWorks, Inc.