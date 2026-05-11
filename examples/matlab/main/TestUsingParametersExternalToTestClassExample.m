%% Test Using Parameters External to Test Class
% In your working folder, create |testZeros.m|. This class contains five
% test methods, resulting in eleven parameterized tests.
% 
% <include>testZeros.m</include>
%
%%
% Redefine the |type| parameter so that the test uses |uint64| and |int64|
% data types in the parameterization instead of |single|, |double|, and
% |uint16|. Create parameters.
import matlab.unittest.parameters.Parameter
newType = {'int64','uint64'};
param = Parameter.fromData('type',newType);
%%
% Create a test suite that injects the |param| parameters. View the names
% of the tests in the suite. The injected parameters are indicated by |#ext|.
import matlab.unittest.TestSuite
suite = TestSuite.fromClass(?testZeros,'ExternalParameters',param);
{suite.Name}'
%%
% Run the suite. 
results = suite.run;
%%
% Redefine the |outSize| parameter so that the test parameterizes for 1-d
% and 4-d arrays. Create parameters from |newType| and |newSize|.
newSize = struct('s2d',[5 3],'s4d',[2 3 2 4]);
param = Parameter.fromData('type',newType,'outSize',newSize);
%%
% Create a test suite that injects the |param| parameters. View the names
% of the tests in the suite. The injected parameters are indicated by |#ext|.
import matlab.unittest.TestSuite
suite = TestSuite.fromClass(?testZeros,'ExternalParameters',param);
{suite.Name}'
%%
% Run the suite.
results = suite.run;



