classdef Add5Test < matlab.unittest.TestCase
    methods (Test)
        function testDoubleOut(testCase)
            actOutput = add5(1);
            testCase.verifyClass(actOutput,'double')
        end
        function testNonNumericInput(testCase)
            testCase.verifyError(@()add5('0'),'add5:InputMustBeNumeric')
        end
    end
end