%% Apply Function with Multiple Outputs to Rows
% Define and apply a geometric Brownian motion model to a range of parameters.
%
% Create a function in a file named |gbmSim.m| that contains the following code.
%
% <include>gbmSim.m</include>
%
%%
% |gbmSim| accepts two inputs, |mu| and |sigma|, and returns four outputs, |m|, 
% |mtrue|, |s|, and |strue|.
%
% Define the table, |params|, containing the parameters to input to the Brownian 
% Motion Model.
mu = [-.5; -.25; 0; .25; .5];
sigma = [.1; .2; .3; .2; .1];

params = table(mu,sigma)

%%
% Apply the function, |gbmSim|, to the rows of the table, |params|.
stats = rowfun(@gbmSim,params,...
    'OutputVariableNames',...
    {'simulatedMean' 'trueMean' 'simulatedStd' 'trueStd'})

%%
% The four variable names specified by the |'OutputVariableNames'| name-value 
% pair argument indicate that |rowfun| should obtain four outputs from |gbmSim|. 
% You can specify fewer output variable names to return fewer outputs from |gbmSim|.
%
% Append the function output, |stats|, to the input, |params|.
[params stats]

%% 
% Copyright 2012 The MathWorks, Inc.