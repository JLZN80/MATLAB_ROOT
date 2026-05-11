%% Models with Correlated and Uncorrelated Random Effects  

%% 
% Load the sample data. 
load carbig  

%% 
% Fit a linear mixed-effects model for miles per gallon (MPG), with fixed
% effects for acceleration, horsepower, and the cylinders, and potentially
% correlated random effects for intercept and acceleration grouped by model
% year. 
%
% First, prepare the design matrices. 
X = [ones(406,1) Acceleration Horsepower];
Z = [ones(406,1) Acceleration];
Model_Year = nominal(Model_Year);
G = Model_Year;  

%% 
% Now, fit the model using |fitlmematrix| with the defined design matrices
% and grouping variables. 
lme = fitlmematrix(X,MPG,Z,G,'FixedEffectPredictors',....
{'Intercept','Acceleration','Horsepower'},'RandomEffectPredictors',...
{{'Intercept','Acceleration'}},'RandomEffectGroups',{'Model_Year'});  

%% 
% Refit the model with uncorrelated random effects for intercept and
% acceleration. First prepare the random effects design and the random
% effects grouping variables.
Z = {ones(406,1),Acceleration};
G = {Model_Year,Model_Year};

lme2 = fitlmematrix(X,MPG,Z,G,'FixedEffectPredictors',....
{'Intercept','Acceleration','Horsepower'},'RandomEffectPredictors',...
{{'Intercept'},{'Acceleration'}},'RandomEffectGroups',...
{'Model_Year','Model_Year'});  

%% 
% Compare |lme| and |lme2| using the simulated likelihood ratio test. 
compare(lme2,lme,'CheckNesting',true,'NSim',1000) 

%%
% The high $p$-value indicates that |lme2| is not a significantly better
% fit than |lme|.



%% 
% Copyright 2012 The MathWorks, Inc.