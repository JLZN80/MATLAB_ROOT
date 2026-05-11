%% Performance Tests from Select Unit Tests
% In your current working folder, create a class-based test,
% |preallocationTest.m|, that compares different methods of preallocation.
%
% <include>preallocationTest.m</include>
%%
% The measurement boundary for the |preallocationTest| class is the test
% method. The time measurement for each test method includes all the code
% in method. For information on designating measurement boundaries, see the
% |startMeasuring| and |stopMeasuring| methods of |matlab.perftest.TestCase|.
%%
% Run performance tests for all the elements that contain |'Indexing'| in the
% name. Your results might vary, and you might see a warning if |runperf|
% doesn't meet statistical objectives.
results = runperf('preallocationTest','Name','*Indexing*')
%%
% Display the mean measured time for each of the tests. Concatenate the
% values from the |Samples| field across the two elements in the |results|
% array. Then use |varfun| to group the table entries by name and compute the
% mean.
fullTable = vertcat(results.Samples);
varfun(@mean,fullTable,'InputVariables','MeasuredTime','GroupingVariables','Name')

%% 
% Copyright 2012 The MathWorks, Inc.