%% Predict Coupled Constraints
% This example shows how to predict the coupled constraints of an optimized
% SVM model. For details of this model, see <docid:stats_ug.bvan2wn-1 Optimize a Cross-Validated SVM Classifier Using bayesopt>.
rng default
grnpop = mvnrnd([1,0],eye(2),10);
redpop = mvnrnd([0,1],eye(2),10);
redpts = zeros(100,2);
grnpts = redpts;
for i = 1:100
    grnpts(i,:) = mvnrnd(grnpop(randi(10),:),eye(2)*0.02);
    redpts(i,:) = mvnrnd(redpop(randi(10),:),eye(2)*0.02);
end
cdata = [grnpts;redpts];
grp = ones(200,1);
grp(101:200) = -1;
c = cvpartition(200,'KFold',10);
sigma = optimizableVariable('sigma',[1e-5,1e5],'Transform','log');
box = optimizableVariable('box',[1e-5,1e5],'Transform','log');
%%
% The objective function is the cross-validation loss of the SVM model for
% the partition |c|. The coupled constraint is the number of support
% vectors in the model minus 100. The model has 200 data points, so the
% coupled constraint values range from -100 to 100. Positive values mean
% the constraint is not satisfied.
%
% <include>mysvmfun.m</include>
%
% Call the optimizer using this function and its one coupled constraint.
fun = @(x)mysvmfun(x,cdata,grp,c);
results = bayesopt(fun,[sigma,box],'IsObjectiveDeterministic',true,...
    'NumCoupledConstraints',1,'PlotFcn',...
    {@plotMinObjective,@plotConstraintModels,@plotObjectiveModel},...
    'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
%%
% The constraint model plot shows that most parameters in the range are
% infeasible, and are feasible only for relatively high values of the |box|
% parameter and a small range of the |sigma| parameter. Predict the coupled
% constraint values for several values of the control variables |box| and
% |sigma|.
sigma = logspace(-2,2,11)';
box = logspace(0,5,11)';
XTable = table(sigma,box);
cons = predictConstraints(results,XTable);
[XTable,table(cons)]

%% 
% Copyright 2012 The MathWorks, Inc.