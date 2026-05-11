%% Write Test Using Setup and Teardown Functions  
% This example shows how to write a unit test for a couple of MATLAB(R)
% figure axes properties using fresh fixtures and file fixtures.   

% Copyright 2015 The MathWorks, Inc.


%% Create axesPropertiesTest File 
% Create a file containing the main function that tests figure axes properties
% and include two test functions. One function verifies that the x-axis
% limits are correct, and the other one verifies that the face color of
% a surface is correct. 
%
% In a folder on your MATLAB path, create |axesPropertiesTest.m|. In the
% main function of this file, have |functiontests| create an array of tests
% from each local function in |axesPropertiesTest.m| with a call to the
% |localfunctions| function. 
%
% <include>axesPropertiesTest_1.m</include>
%

%% Create File Fixture Functions 
% File fixture functions are setup and teardown code that runs a single
% time in your test file. These fixtures are shared across the test file.
% In this example, the file fixture functions create a temporary folder
% and set it as the current working folder. They also create and save a
% new figure for testing. After tests are complete, the framework reinstates
% the original working folder and deletes the temporary folder and saved
% figure. 
%
% In this example, a helper function creates a simple figure &#8212; a red cylinder.
% In a more realistic scenario, this code is part of the product under test
% and is computationally expensive, thus motivating the intent to create
% the figure only once and to load independent copies of the result for
% each test function. For this example, however, you want to create this
% helper function as a local function to |axesPropertiesTest|. Note that
% the test array does not include the function because its name does not
% start or end with &#8216;test&#8217;. 
%
% Write a helper function that creates a simple red cylinder and add it
% as a local function to |axesPropertiesTest|. 
%
% <include>axesPropertiesTest_2.m</include>
%
%%
% You must name the setup and teardown functions of a file test fixture
% |setupOnce| and |teardownOnce|, respectively. These functions take a single
% input argument, |testCase|, into which the test framework automatically
% passes a function test case object. This test case object contains a |TestData|
% structure that allows data to pass between setup, test, and teardown functions.
% In this example, the |TestData| structure uses assigned fields to store
% the original path, the temporary folder name, and the figure file name. 

%%
% Create the setup and teardown functions as a local functions to |axesPropertiesTest|. 
%
% <include>axesPropertiesTest_3.m</include>
%
%% Create Fresh Fixture Functions 
% Fresh fixtures are function level setup and teardown code that runs before
% and after each test function in your file. In this example, the functions
% open the saved figure and find the handles. After testing, the framework
% closes the figure. 
%
% You must name fresh fixture functions |setup| and |teardown|, respectively.
% Similar to the file fixture functions, these functions take a single input
% argument, |testCase|. In this example, these functions create a new field
% in the |TestData| structure that includes handles to the figure and to
% the axes. This allows information to pass between setup, test, and teardown
% functions. 
%
% Create the setup and teardown functions as a local functions to |axesPropertiesTest|.
% Open the saved figure for each test to ensure test independence. 
%
% <include>axesPropertiesTest_4.m</include>
%
%%
% In addition to custom setup and teardown code, the Unit Testing Framework
% provides some classes for creating fixtures. For more information see
% |matlab.unittest.fixtures|.  

%% Create Test Functions 
% Each test is a local function that follows the naming convention of having
% &#8216;test&#8217; at the beginning or end of the function name. The test array does
% not include local functions that do not follow this convention. Similar
% to setup and teardown functions, individual test functions must accept
% a single input argument, |testCase|. Use this test case object for verifications,
% assertions, assumptions, and fatal assertions functions. 
%
% The |testDefaultXLim| function test verifies that the x-axis limits
% are large enough to display the cylinder. The lower limit needs to be
% less than |-10|, and the upper limit needs to be greater than |10|. These
% values come from the figure generated in the helper function &#8212; a cylinder
% with a |10| unit radius centered on the origin. This test function opens
% the figure created and saved in the |setupOnce| function, queries the
% axes limit, and verifies the limits are correct. The qualification functions,
% |verifyLessThanOrEqual| and |verifyGreaterThanOrEqual|, takes the test
% case, the actual value, the expected value, and optional diagnostic information
% to display in the case of failure as inputs. 
%
% Create the |testDefaultXLim| function as local function to |axesPropertiesTest|. 
%
% <include>axesPropertiesTest_5.m</include>
%
%%
% The |surfaceColorTest| function accesses the figure that you created and
% saved in the |setupOnce| function. |surfaceColorTest| queries the face
% color of the cylinder and verifies that it is red. The color red has an
% RGB value of |[1 0 0]|. The qualification function, |verifyEqual|, takes
% as inputs the test case, the actual value, the expected value, and optional
% diagnostic information to display in the case of failure. Typically when
% using |verifyEqual| on floating point-values, you specify a tolerance
% for the comparison. For more information, see |matlab.unittest.constraints|. 

%%
% Create the |surfaceColorTest| function as local function to |axesPropertiesTest|. 
%
% <include>axesPropertiesTest_6.m</include>
%
%%
% Now the |axesPropertiesTest.m| file is complete with a main function,
% file fixture functions, fresh fixture functions, and two local test functions.
% You are ready to run the tests.  

%% Run Tests 
% The next step is to run the tests using the |runtests| function. In this
% example, the call to |runtests| results in the following steps:
%
% # The main function creates a test array.  
% # The file fixture records the working folder, creates a temporary folder,
% sets the temporary folder as the working folder, then generates and saves
% a figure.  
% # The fresh fixture setup opens the saved figure and finds the handles.  
% # The |testDefaultXLim| test is run.  
% # The fresh fixture teardown closes the figure.  
% # The fresh fixture setup opens the saved figure and finds the handles.  
% # The |surfaceColorTest| test is run.  
% # The fresh fixture teardown closes the figure.  
% # The file fixture teardown deletes the saved figure, changes back to
% the original path and deletes the temporary folder.    
%
% At the command prompt, generate and run the test suite. 
results = runtests('axesPropertiesTest.m')  

%% Create Table of Test Results 
% To access functionality available to tables, create one from the |TestResult|
% object. 
rt = table(results)  
%%
% Export test results to an Excel(R) spreadsheet.
%
% |writetable(rt,'myTestResults.xls')|
%% 
% Sort the test results by increasing duration. 
sortrows(rt,'Duration')   
