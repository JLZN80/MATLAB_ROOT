
% Copyright 2015 The MathWorks, Inc.

function setup(testCase)
testCase.TestData.Figure = openfig(testCase.TestData.figName);
testCase.TestData.Axes = findobj(testCase.TestData.Figure,...
    'Type','Axes');
end

function teardown(testCase)
close(testCase.TestData.Figure)
end