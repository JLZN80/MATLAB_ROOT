classdef TestProperties < matlab.unittest.TestCase
    properties (ClassSetupParameter)
        ClassToTest = {'ClassA', 'ClassB', 'ClassC'};
    end

    properties (TestParameter)
        PropertyToTest
    end
    
    properties
        ObjectToTest
    end

    methods (TestParameterDefinition, Static)
        function PropertyToTest = initializeProperty(ClassToTest)
            PropertyToTest = properties(ClassToTest);
        end
    end

    methods (TestClassSetup)
        function classSetup(testCase,ClassToTest)
            constructor = str2func(ClassToTest);
            testCase.ObjectToTest = constructor();
        end
    end

    methods (Test)
        function testProperty(testCase,PropertyToTest)
            value = testCase.ObjectToTest.(PropertyToTest);
            testCase.verifyNotEmpty(value)
        end
    end
end