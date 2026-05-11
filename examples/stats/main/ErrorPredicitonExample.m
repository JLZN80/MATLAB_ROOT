%% Error Prediction
% This example shows optimizing a function that throws an error when the
% evaluation point has norm larger than |2|. The error model for the
% objective function learns this behavior.
%%
% Create variables named |x1| and |x2| that range from |-5| to |5|.
var1 = optimizableVariable('x1',[-5,5]);
var2 = optimizableVariable('x2',[-5,5]);
vars = [var1,var2];
%%
% The following objective function throws an error when the norm of |x =
% [x1,x2]| exceeds 2:
%
% <include>makeanerror.m</include>
%
fun = @makeanerror;
%%
% Plot the error model and minimum objective as the optimization proceeds.
% Optimize for 60 iterations so the error model becomes well-trained. For
% reproducibility, set the random seed and use the
% |'expected-improvement-plus'| acquisition function.
rng default
results = bayesopt(fun,vars,'Verbose',0,'MaxObjectiveEvaluations',60,...
    'AcquisitionFunctionName','expected-improvement-plus',...
    'PlotFcn',{@plotMinObjective,@plotConstraintModels});
%%
% Predict the error at points on the line |x1 = x2|. If the error model
% were perfect, it would have value |-1| at every point where the norm of
% |x| is no more than |2|, and value |1| at all other points.
x1 = (-5:0.5:5)';
x2 = x1;
XTable = table(x1,x2);
error = predictError(results,XTable);
normx = sqrt(x1.^2 + x2.^2);
[XTable,table(normx,error)]


%% 
% Copyright 2012 The MathWorks, Inc.