%% Reset Multiple Options
% Create options with some nondefault settings. Examine the |MaxIterations|
% setting.
options = optimoptions('fmincon','Algorithm','sqp','MaxIterations',2e4,...
    'SpecifyObjectiveGradient',true);
options.MaxIterations
%%
% Reset the |MaxIterations| and |Algorithm| options to their default
% values. Examine the |MaxIterations| setting.
multiopts = {'MaxIterations','Algorithm'};
options2 = resetoptions(options,multiopts);
options2.MaxIterations
%%
% The default value of the |MaxIterations| option is 1000 for the default
% |'interior-point'| algorithm.

%% 
% Copyright 2012 The MathWorks, Inc.