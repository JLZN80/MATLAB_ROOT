
% Copyright 2015 The MathWorks, Inc.

function testDefaultXLim(testCase)
xlim = testCase.TestData.Axes.XLim;
verifyLessThanOrEqual(testCase, xlim(1), -10,...
    'Minimum x-limit was not small enough')
verifyGreaterThanOrEqual(testCase, xlim(2), 10,...
    'Maximum x-limit was not big enough')
end