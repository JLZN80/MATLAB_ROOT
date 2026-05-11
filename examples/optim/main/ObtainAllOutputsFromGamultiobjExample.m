%% Obtain All Outputs from |gamultiobj|
% Run a simple multiobjective problem and obtain all available outputs.
%%
% Set the random number generator for reproducibility.
rng default
%%
% Set the fitness functions to |kur_multiobjective|, a function that has
% three control variables and returns two fitness function values.
fitnessfcn = @kur_multiobjective;
nvars = 3;
%%
% The |kur_multiobjective| function has the following code.
%
% <include>kur_multiobjective.m</include>
%
%%
% Set lower and upper bounds on all variables.
ub = [5 5 5];
lb = -ub;
%%
% Find the Pareto front and all other outputs for this problem.
[x,fval,exitflag,output,population,scores] = gamultiobj(fitnessfcn,nvars, ...
    [],[],[],[],lb,ub);
%%
% Examine the sizes of some of the returned variables.
sizex = size(x)
sizepopulation = size(population)
sizescores = size(scores)
%%
% The returned Pareto front contains 18 points. There are 50 members of the
% final population. Each |population| row has three dimensions,
% corresponding to the three decision variables. Each |scores| row has two
% dimensions, corresponding to the two fitness functions.
%%
% Copyright 2017 The MathWorks, Inc.