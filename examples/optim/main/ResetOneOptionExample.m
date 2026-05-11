%% Reset One Option
% Create options with some nondefault settings. Examine the |MaxIterations|
% setting.
options = optimoptions('fmincon','Algorithm','sqp','MaxIterations',2e4,...
    'SpecifyObjectiveGradient',true);
options.MaxIterations
%%
% Reset the |MaxIterations| option to its default value.
options2 = resetoptions(options,'MaxIterations');
options2.MaxIterations
%%
% The default value of the |MaxIterations| option is 400 for the |'sqp'|
% algorithm.

%% 
% Copyright 2012 The MathWorks, Inc.