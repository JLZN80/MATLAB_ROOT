classdef PathFixtureTest < matlab.unittest.TestCase
    methods(Test)
        function test1(testCase)
            import matlab.unittest.fixtures.PathFixture
            import matlab.unittest.constraints.ContainsSubstring
            f = testCase.applyFixture(PathFixture(["folderA","folderB"]));
            testCase.assertThat(path,ContainsSubstring(f.Folders(1)))
            testCase.assertThat(path,ContainsSubstring(f.Folders(2)))
        end
    end
end