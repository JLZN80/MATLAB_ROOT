%% polytool

origPwd = pwd;
cd(fullfile(matlabroot,'toolbox/stats/statsdemos'))
polytool((1:10)',[ones(10,1) (1:10)' (1:10)'.*(1:10)']*[50;4;-0.75]+randn(10,1))';
cd(origPwd)

%% 
% Copyright 2012 The MathWorks, Inc.