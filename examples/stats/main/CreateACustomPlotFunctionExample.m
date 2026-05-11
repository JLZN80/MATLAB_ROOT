%% Create a Custom Plot Function
% This example shows how to create a custom plot function for |bayesopt|.
% It further shows how to use information in the |UserData| property of a
% |BayesianOptimization| object.
%% Problem Statement
% The problem is to find parameters of a Support Vector Machine (SVM)
% classification to minimize the cross-validated loss. The specific model
% is the same as in <docid:stats_ug.bvan2wn-1 Optimize a Cross-Validated SVM Classifier Using bayesopt>. Therefore, the objective
% function is essentially the same, except it also computes |UserData|, in
% this case the number of support vectors in an SVM model fitted to the
% current parameters.
%
% Create a custom plot function that plots the number of support vectors in
% the SVM model as the optimization progresses. To give the plot function
% access to the number of support vectors, create a third output,
% |UserData|, to return the number of support vectors.
%% Objective Function
% Create an objective function that computes the cross-validation loss for
% a fixed cross-validation partition, and that returns the number of
% support vectors in the resulting model.
%
% <include>mysvmminfn.m</include>
%
%% Custom Plot Function
% Create a custom plot function that uses the information computed in
% |UserData|. Have the function plot both the current number of constraints
% and the number of constraints for the model with the best objective
% function found.
%
% <include>svmsuppvec.m</include>
%
%% Set Up the Model
% Generate ten base points for each class. 
rng default
grnpop = mvnrnd([1,0],eye(2),10);
redpop = mvnrnd([0,1],eye(2),10);
%%
% Generate 100 data points of each class.
redpts = zeros(100,2);grnpts = redpts;
for i = 1:100
    grnpts(i,:) = mvnrnd(grnpop(randi(10),:),eye(2)*0.02);
    redpts(i,:) = mvnrnd(redpop(randi(10),:),eye(2)*0.02);
end
%%
% Put the data into one matrix, and make a vector |grp| that labels the
% class of each point.
cdata = [grnpts;redpts];
grp = ones(200,1);
% Green label 1, red label -1
grp(101:200) = -1;
%%
% Check the basic classification of all the data using the default SVM
% parameters.
SVMModel = fitcsvm(cdata,grp,'KernelFunction','rbf','ClassNames',[-1 1]);
%%
% Set up a partition to fix the cross validation. Without this step, the
% cross validation is random, so the objective function is not
% deterministic.
c = cvpartition(200,'KFold',10);
%%
% Check the cross-validation accuracy of the original fitted model.
loss = kfoldLoss(fitcsvm(cdata,grp,'CVPartition',c,...
    'KernelFunction','rbf','BoxConstraint',SVMModel.BoxConstraints(1),...
    'KernelScale',SVMModel.KernelParameters.Scale))
%% Prepare Variables for Optimization
% The objective function takes an input |z = [rbf_sigma,boxconstraint]| and
% returns the cross-validation loss value of |z|. Take the components of
% |z| as positive, log-transformed variables between |1e-5| and |1e5|.
% Choose a wide range because you do not know which values are likely to be
% good.
sigma = optimizableVariable('sigma',[1e-5,1e5],'Transform','log');
box = optimizableVariable('box',[1e-5,1e5],'Transform','log');
%% Set Plot Function and Call the Optimizer
% Search for the best parameters |[sigma,box]| using |bayesopt|. For
% reproducibility, choose the |'expected-improvement-plus'| acquisition
% function. The default acquisition function depends on run time, so it can
% give varying results.
%
% Plot the number of support vectors as a function of the iteration number,
% and plot the number of support vectors for the best parameters found.
obj = @(x)mysvmminfn(x,cdata,grp,c);
results = bayesopt(obj,[sigma,box],...
    'IsObjectiveDeterministic',true,'Verbose',0,...
    'AcquisitionFunctionName','expected-improvement-plus',...
    'PlotFcn',{@svmsuppvec,@plotObjectiveModel,@plotMinObjective})

%% 
% Copyright 2012 The MathWorks, Inc.