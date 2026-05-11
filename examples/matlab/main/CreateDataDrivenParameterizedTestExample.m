%% Use External Parameters in Parameterized Test

% Copyright 2020 The MathWorks, Inc.

%%
% You can inject variable inputs into your existing class-based test. To
% provide test data that is defined outside the test file and that should
% be used iteratively by the test (via parameterized testing), create a
% |Parameter| and use the |'ExternalParameters'| option to |TestSuite|
% creation methods such as |TestSuite.fromClass|.
%%
% Create the following function to test. The function accepts an
% array, vectorizes the array, removes 0, |Nan|, and |Inf|, and then sorts the array.	
% 
% <include>cleanData.m</include>
%
%% 
% Create the following parameterized test for the |cleanData| function. The
% test repeats each of the four test methods for the two data sets that are defined
% in the |properties| block.
%
% <include>TestClean.m</include>
%
%%
% Create and run a parameterized test suite. View the results. The
% framework runs the eight parameterized tests using the data defined in
% the test file.

import matlab.unittest.TestSuite
suite1 = TestSuite.fromClass(?TestClean);
results = suite1.run;
table(results)
%%
% Create a data set external to the test file.
A = [NaN 2 0;1 Inf 3];
%%
% Create a parameter with the external data set. The |fromData| method
% accepts the name of the parameterized property from the |properties|
% block in |TestClean| and the new data as a cell array (or struct).
import matlab.unittest.parameters.Parameter
newData = {A};
param = Parameter.fromData('Data',newData);
%%
% Create a new test suite and view the suite element names. The |fromClass| method accepts the new
% parameter.
suite2 = TestSuite.fromClass(?TestClean,'ExternalParameters',param);
{suite2.Name}'
%%
% Using the external parameter, the framework creates four suite elements.
% Since the parameters are defined as a cell array, MATLAB generates the
% parameter name (|value1|). Also, it appends the characters |#ext| to the
% end of the parameter name, indicating the parameter is defined
% externally.
%
% To assign meaningful parameter names (instead of |valueN|), define the
% parameter using a struct. View the suite element names and run the tests.
newData = struct('commandLineData',A);
param = Parameter.fromData('Data',newData);
suite2 = TestSuite.fromClass(?TestClean,'ExternalParameters',param);
{suite2.Name}'
results = suite2.run;
%%
% Create another data set that is stored in an ASCII-delimited file.
B = rand(3);
B(2,4) = 0;
dlmwrite('myFile.dat',B)
clear B
%%
% Create a parameter with the stored data set and |A|.
newData = struct('commandLineData',A,'storedData',dlmread('myFile.dat'));
param2 = Parameter.fromData('Data',newData);
suite3 = TestSuite.fromClass(?TestClean,'ExternalParameters',param2);
%%
% To run the tests using parameters defined in the test file and
% externally, concatenate test suites. View the suite element names and run
% the tests.
suite = [suite1 suite3];
{suite.Name}'
results = suite.run;