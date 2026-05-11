
% Copyright 2015 The MathWorks, Inc.

function surfaceColorTest(testCase)
h = findobj(testCase.TestData.Axes,'Type','surface');
co = h.FaceColor;
verifyEqual(testCase, co, [1 0 0],'FaceColor is incorrect')
end