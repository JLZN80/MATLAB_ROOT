%% Refit NCA Model for Classification with Modified Settings
%%
% Generate checkerboard data using the |generateCheckerBoardData.m|
% function.
rng(2016,'twister'); % For reproducibility
pps = 1375;
[X,y] = generateCheckerBoardData(pps);
X = X + 2;
%%
% Plot the data.
figure
plot(X(y==1,1),X(y==1,2),'rx')
hold on
plot(X(y==-1,1),X(y==-1,2),'bx')

[n,p] = size(X)

%%
% Add irrelevant predictors to the data.
Q = 98;
Xrnd = unifrnd(0,4,n,Q);
Xobs = [X,Xrnd];

%%
% This piece of code creates 98 additional predictors, all uniformly
% distributed between 0 and 4.
%%
% Partition the data into training and test sets. To create stratified
% partitions, so that each partition has similar proportion of classes, use
% |y| instead of |length(y)| as the partitioning criteria.
cvp = cvpartition(y,'holdout',2000);

%%
% |cvpartition| randomly chooses 2000 of the observations to add to the
% test set and the rest of the data to add to the training set. Create the
% training and validation sets using the assignments stored in the
% |cvpartition| object |cvp| .

Xtrain = Xobs(cvp.training(1),:);
ytrain = y(cvp.training(1),:);

Xval = Xobs(cvp.test(1),:);
yval = y(cvp.test(1),:);

%%
% Compute the misclassification error without feature selection.
nca = fscnca(Xtrain,ytrain,'FitMethod','none','Standardize',true, ...
    'Solver','lbfgs');
loss_nofs = loss(nca,Xval,yval)

%%
% |'FitMethod','none'| option uses the default weights (all 1s), which
% means all features are equally important.
%%
% This time, perform feature selection using neighborhood component
% analysis for classification, with $\lambda = 1/n$.
w0 = rand(100,1);
n = length(ytrain)
lambda = 1/n;
nca = refit(nca,'InitialFeatureWeights',w0,'FitMethod','exact', ...
       'Lambda',lambda,'solver','sgd');
   
%%
% Plot the objective function value versus the iteration number.
figure()
plot(nca.FitInfo.Iteration,nca.FitInfo.Objective,'ro')
hold on
plot(nca.FitInfo.Iteration,movmean(nca.FitInfo.Objective,10),'k.-')
xlabel('Iteration number')
ylabel('Objective value')
%%
% Compute the misclassification error with feature selection.
loss_withfs = loss(nca,Xval,yval)

%%
% Plot the selected features.
figure
semilogx(nca.FeatureWeights,'ro')
xlabel('Feature index')
ylabel('Feature weight')
grid on

%%
% Select features using the feature weights and a relative threshold.
tol = 0.15;
selidx = find(nca.FeatureWeights > tol*max(1,max(nca.FeatureWeights)))

%%
% Feature selection improves the results and |fscnca| detects the
% correct two features as relevant.






%% 
% Copyright 2012 The MathWorks, Inc.