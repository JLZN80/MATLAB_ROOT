%% Plot After Optimization
% This example shows how to plot the error model and the best objective
% trace after the optimization has finished. The objective function for
% this example throws an error for points with norm larger than 2.
%
% <include>makeanerror.m</include>
%
fun = @makeanerror;
%%
% Create the variables for optimization.
var1 = optimizableVariable('x1',[-5,5]);
var2 = optimizableVariable('x2',[-5,5]);
vars = [var1,var2];
%%
% Run the optimization without any plots. For reproducibility, set the
% random seed and use the 'expected-improvement-plus' acquisition function.
% Optimize for 60 iterations so the error model becomes well-trained.
rng default
results = bayesopt(fun,vars,'MaxObjectiveEvaluations',60,...
    'AcquisitionFunctionName','expected-improvement-plus',...
    'PlotFcn',[],'Verbose',0);
%%
% Plot the error model and the best objective trace.
plot(results,@plotConstraintModels,@plotMinObjective)

%% 
% Copyright 2012 The MathWorks, Inc.