%% Tune NCA Model for Classification
%%
% Load the sample data.
load('twodimclassdata.mat');
%%
% This data set is simulated using the scheme described in [1]. This is a
% two-class classification problem in two dimensions. Data from the first
% class (class &ndash;1) are drawn from two bivariate normal distributions
% $N(\mu_1,\Sigma)$ or $N(\mu_2,\Sigma)$ with equal probability, where
% $\mu_1 = [-0.75,-1.5]$, $\mu_2 = [0.75,1.5]$, and $\Sigma = I_2$.
% Similarly, data from the second class (class 1) are drawn from two
% bivariate normal distributions $N(\mu_3,\Sigma)$ or $N(\mu_4,\Sigma)$
% with equal probability, where $\mu_3 = [1.5,-1.5]$, $\mu_4 = [-1.5,1.5]$,
% and $\Sigma = I_2$. The normal distribution parameters used to create
% this data set result in tighter clusters in data than the data used in
% [1].

%%
% Create a scatter plot of the data grouped by the class.
figure
gscatter(X(:,1),X(:,2),y)
xlabel('x1')
ylabel('x2')
    
%% 
% Add 100 irrelevant features to $X$. First generate data from a Normal
% distribution with a mean of 0 and a variance of 20.
n = size(X,1);
rng('default')
XwithBadFeatures = [X,randn(n,100)*sqrt(20)];

%%
% Normalize the data so that all points are between 0 and 1.
XwithBadFeatures = bsxfun(@rdivide,...
    bsxfun(@minus,XwithBadFeatures,min(XwithBadFeatures,[],1)), ...
    range(XwithBadFeatures,1));
X = XwithBadFeatures;

%%
% Fit a neighborhood component analysis (NCA) model to the data using the
% default |Lambda| (regularization parameter, $\lambda$) value. Use the
% LBFGS solver and display the convergence information.
ncaMdl = fscnca(X,y,'FitMethod','exact','Verbose',1, ...
              'Solver','lbfgs');

%%
% Plot the feature weights. The weights of the irrelevant features should
% be very close to zero.
figure
semilogx(ncaMdl.FeatureWeights,'ro')
xlabel('Feature index')
ylabel('Feature weight')    
grid on

%%
% Predict the classes using the NCA model and compute the confusion matrix.
ypred = predict(ncaMdl,X);
confusionchart(y,ypred)

%%
% Confusion matrix shows that 40 of the data that are in class &ndash;1 are
% predicted as belonging to class &ndash;1. 60 of the data from class
% &ndash;1 are predicted to be in class 1. Similarly, 94 of the data from
% class 1 are predicted to be from class 1 and 6 of them are predicted to
% be from class &ndash;1. The prediction accuracy for class &ndash;1 is not
% good.

%%
% All weights are very close to zero, which indicates that the value of
% $\lambda$ used in training the model is too large. When $\lambda \to
% \infty$, all features weights approach to zero. Hence, it is important to
% tune the regularization parameter in most cases to detect the relevant
% features.
%% 
% Use five-fold cross-validation to tune $\lambda$ for feature selection by
% using |fscnca|. Tuning $\lambda$ means finding the $\lambda$ value that
% will produce the minimum classification loss. To tune $\lambda$ using
% cross-validation:
%
% 1. Partition the data into five folds. For each fold, |cvpartition|
% assigns four-fifths of the data as a training set and one-fifth of the
% data as a test set. Again for each fold, |cvpartition| creates a
% stratified partition, where each partition has roughly the same
% proportion of classes.
cvp = cvpartition(y,'kfold',5);
numtestsets = cvp.NumTestSets;
lambdavalues = linspace(0,2,20)/length(y); 
lossvalues = zeros(length(lambdavalues),numtestsets);

%%
% 2. Train the neighborhood component analysis (nca) model for each
% $\lambda$ value using the training set in each fold.
%
% 3. Compute the classification loss for the corresponding test set in the
% fold using the nca model. Record the loss value.
%
% 4. Repeat this process for all folds and all $\lambda$ values.
for i = 1:length(lambdavalues)                
    for k = 1:numtestsets
        
        % Extract the training set from the partition object
        Xtrain = X(cvp.training(k),:);
        ytrain = y(cvp.training(k),:);
        
        % Extract the test set from the partition object
        Xtest  = X(cvp.test(k),:);
        ytest  = y(cvp.test(k),:);
        
        % Train an NCA model for classification using the training set
        ncaMdl = fscnca(Xtrain,ytrain,'FitMethod','exact', ...
            'Solver','lbfgs','Lambda',lambdavalues(i));
        
        % Compute the classification loss for the test set using the NCA
        % model
        lossvalues(i,k) = loss(ncaMdl,Xtest,ytest, ...
            'LossFunction','quadratic');   
   
    end                          
end
           
%%
% Plot the average loss values of the folds versus the $\lambda$ values. If
% the $\lambda$ value that corresponds to the minimum loss falls on the
% boundary of the tested $\lambda$ values, the range of $\lambda$ values
% should be reconsidered.
figure
plot(lambdavalues,mean(lossvalues,2),'ro-')
xlabel('Lambda values')
ylabel('Loss values')
grid on

%%
% Find the $\lambda$ value that corresponds to the minimum average loss.
[~,idx] = min(mean(lossvalues,2)); % Find the index
bestlambda = lambdavalues(idx) % Find the best lambda value
    
%%
% Fit the NCA model to all of the data using the best $\lambda$ value. Use
% the LBFGS solver and display the convergence information.
ncaMdl = fscnca(X,y,'FitMethod','exact','Verbose',1, ...
        'Solver','lbfgs','Lambda',bestlambda);
 
%%
% Plot the feature weights.
figure
semilogx(ncaMdl.FeatureWeights,'ro')
xlabel('Feature index')
ylabel('Feature weight')    
grid on
    
%%
% |fscnca| correctly figures out that the first two features are relevant
% and that the rest are not. The first two features are not individually
% informative, but when taken together result in an accurate classification
% model.

%%
% Predict the classes using the new model and compute the accuracy.
ypred = predict(ncaMdl,X);
confusionchart(y,ypred)

%%
% Confusion matrix shows that prediction accuracy for class &ndash;1 has
% improved. 88 of the data from class &ndash;1 are predicted to be from
% &ndash;1, and 12 of them are predicted to be from class 1. 92 of the data
% from class 1 are predicted to be from class 1 and 8 of them are predicted
% to be from class &ndash;1.

%% 
% *References*
%
% [1] Yang, W., K. Wang, W. Zuo. "Neighborhood Component Feature Selection
% for High-Dimensional Data." _Journal of Computers_. Vol. 7, Number 1,
% January, 2012.

%% 
% Copyright 2012 The MathWorks, Inc.