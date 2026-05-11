%% Generate Code from Function That Predicts Responses Given New Data
% Train a generalized linear model, and then generate code from a function
% that classifies new observations based on the model.  This example is based
% on the <docid:stats_ug.btwfy27-1 Use Custom-Defined Link Function> example.
%%
% Enter the sample data.
x = [2100 2300 2500 2700 2900 3100 ...
     3300 3500 3700 3900 4100 4300]';
n = [48 42 31 34 31 21 23 23 21 16 17 21]';
y = [1 2 0 3 8 8 14 17 19 15 17 21]';
%%
% Suppose that the inverse normal pdf is an appropriate link function for
% the problem.
%%
% Define a function named |myInvNorm.m| that accepts values of $X\beta$
% and returns corresponding values of the inverse of the standard normal
% cdf.
%
% <include>myInvNorm.m</include>
%
%%
% Define another function named |myDInvNorm.m| that accepts values of
% $X\beta$ and returns corresponding values of the derivative of the link
% function.
%
% <include>myDInvNorm.m</include>
%
%%
% Define another function named |myInvInvNorm.m| that accepts values of
% $X\beta$ and returns corresponding values of the inverse of the link
% function.
%
% <include>myInvInvNorm.m</include>
%
%%
% Create a structure array that specifies each of the link functions.
% Specifically, the structure array contains fields named |'Link'|,
% |'Derivative'|, and |'Inverse'|. The corresponding values are the names
% of the functions.
link = struct('Link','myInvNorm','Derivative','myDInvNorm',...
    'Inverse','myInvInvNorm')
%%
% Fit a GLM for |y| on |x| using the link function |link|. Return the
% structure array of statistics.
[b,~,stats] = glmfit(x,[y n],'binomial','link',link);
%%
% |b| is a 2-by-1 vector of regression coefficients.  
%%
% In your current working folder, define a function called |classifyGLM.m|
% that:
%
% * Accepts measurements with columns corresponding to those in |x|,
% regression coefficients whose dimensions correspond to |b|, a link
% function, the structure of GLM statistics, and any valid |glmval|
% name-value pair argument
% * Returns predictions and confidence interval margins of error
% 
% <include>classifyGLM.m</include>
%
%%
% Generate a MEX function from |classifyGLM.m|. Because C uses static
% typing, |codegen| must determine the properties of all variables in
% MATLAB(R) files at compile time. To ensure that the MEX function can use
% the same inputs, use the |-args| argument to specify the following
% in the order given:
%
% * Regression coefficients |b| as a compile-time constant
% * In-sample observations |x|
% * Link function as a compile-time constant
% * Resulting GLM statistics as a compile-time constant
% * Name |'Confidence'| as a compile-time constant
% * Confidence level 0.9
%
% To designate arguments as compile-time constants, use |coder.Constant|.
codegen -config:mex classifyGLM -args {coder.Constant(b),x,coder.Constant(link),coder.Constant(stats),coder.Constant('Confidence'),0.9}
%%
% |codegen| generates the MEX file |classifyGLM_mex.mexw64| in your current
% folder. The file extension depends on your system platform.
%%
% Compare predictions by using |glmval| and |classifyGLM_mex|. Specify
% name-value pair arguments in the same order as in the |-args| argument in
% the call to |codegen|.
[yhat1,melo1,mehi1] = glmval(b,x,link,stats,'Confidence',0.9);
[yhat2,melo2,mehi2] = classifyGLM_mex(b,x,link,stats,'Confidence',0.9);

comp1 = (yhat1 - yhat2)'*(yhat1 - yhat2);
agree1 = comp1 < eps
comp2 = (melo1 - melo2)'*(melo1 - melo2);
agree2 = comp2 < eps
comp3 = (mehi1 - mehi2)'*(mehi1 - mehi2);
agree3 = comp3 < eps
%%
% The generated MEX function produces the same predictions as |predict|.

%% 
% Copyright 2012 The MathWorks, Inc.