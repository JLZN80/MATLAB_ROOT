%% Bayesian Optimization Output Function
% This example shows how to use a custom output function with Bayesian
% optimization. The output function halts the optimization when the
% objective function, which is the cross-validation error rate, drops below
% 13%. The output function also plots the time for each iteration.
%
% <include>outputfun.m</include>
%
%%
% The objective function is the cross validation loss of the KNN
% classification of the |ionosphere| data. Load the data and, for
% reproducibility, set the default random stream.
load ionosphere
rng default
%%
% Optimize over neighborhood size from 1 through 30, and for three
% distance metrics.
num = optimizableVariable('n',[1,30],'Type','integer');
dst = optimizableVariable('dst',{'chebychev','euclidean','minkowski'},'Type','categorical');
vars = [num,dst];
%%
% Set the cross-validation partition and objective function. For
% reproducibility, set the |AcquisitionFunctionName| to
% |'expected-improvement-plus'|. Run the optimization.
c = cvpartition(351,'Kfold',5);
fun = @(x)kfoldLoss(fitcknn(X,Y,'CVPartition',c,'NumNeighbors',x.n,...
    'Distance',char(x.dst),'NSMethod','exhaustive'));
results = bayesopt(fun,vars,'OutputFcn',@outputfun,...
    'AcquisitionFunctionName','expected-improvement-plus');


%% 
% Copyright 2012 The MathWorks, Inc.