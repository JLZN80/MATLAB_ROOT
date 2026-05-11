%% Resume a Bayesian Optimization
% This example shows how to resume a Bayesian optimization. The
% optimization is for a deterministic function known as Rosenbrock's
% function, which is a well-known test case for nonlinear optimization. The
% function has a global minimum value of |0| at the point |[1,1]|.
%%
% Create two real variables bounded by |-5| and |5|.
x1 = optimizableVariable('x1',[-5,5]);
x2 = optimizableVariable('x2',[-5,5]);
vars = [x1,x2];
%%
% Create the objective function.
%
% <include>rosenbrocks.m</include>
%
fun = @rosenbrocks;
%%
% For reproducibility, set the random seed, and set the acquisition
% function to |'expected-improvement-plus'| in the optimization.
rng default
results = bayesopt(fun,vars,'Verbose',0,...
    'AcquisitionFunctionName','expected-improvement-plus');
%%
% View the best point found and the best modeled objective.
results.XAtMinObjective
results.MinEstimatedObjective
%%
% The best point is somewhat close to the optimum, but the function model
% is inaccurate. Resume the optimization for 30 more points (a total of 60
% points), this time telling the optimizer that the objective function is
% deterministic.
newresults = resume(results,'IsObjectiveDeterministic',true,'MaxObjectiveEvaluations',30);
newresults.XAtMinObjective
newresults.MinEstimatedObjective
%%
% The objective function model is much closer to the true function this
% time. The best point is closer to the true optimum.

%% 
% Copyright 2012 The MathWorks, Inc.