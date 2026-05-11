%% Bayesian Optimization with Coupled Constraints
% A coupled constraint is one that can be evaluated only by evaluating the
% objective function. In this case, the objective function is the
% cross-validated loss of an SVM model. The coupled constraint is that the
% number of support vectors is no more than 100. The model details are in
% <docid:stats_ug.bvan2wn-1 Optimize a Cross-Validated SVM Classifier Using bayesopt>.
%%
% Create the data for classification.
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
% partition |c|. The coupled constraint is the number of support vectors
% minus 100.5. This ensures that 100 support vectors give a negative
% constraint value, but 101 support vectors give a positive value. The
% model has 200 data points, so the coupled constraint values range from
% -99.5 (there is always at least one support vector) to 99.5. Positive
% values mean the constraint is not satisfied.
%
% <include>mysvmfun.m</include>
%
% Pass the partition |c| and fitting data |cdata| and |grp| to the
% objective function |fun| by creating |fun| as an anonymous function that
% incorporates this data. See <docid:matlab_math.bsgprpq-5 Parameterizing Functions>.
fun = @(x)mysvmfun(x,cdata,grp,c);
%%
% Set the |NumCoupledConstraints| to |1| so the optimizer knows that there
% is a coupled constraint. Set options to plot the constraint model.

results = bayesopt(fun,[sigma,box],'IsObjectiveDeterministic',true,...
    'NumCoupledConstraints',1,'PlotFcn',...
    {@plotMinObjective,@plotConstraintModels},...
    'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
%%
% Most points lead to an infeasible number of support vectors.

%% 
% Copyright 2012 The MathWorks, Inc.