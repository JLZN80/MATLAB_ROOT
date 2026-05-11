%% fsurfht

origPwd = pwd;
cd(fullfile(matlabroot,'toolbox/stats/statsdemos'))
fsurfht('peaks',[-3 3],[-3 3])
cd(origPwd)

%% 
% Copyright 2012 The MathWorks, Inc.