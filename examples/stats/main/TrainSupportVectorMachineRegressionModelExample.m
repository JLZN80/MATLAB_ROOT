%% Train Support Vector Machine Regression Model
% Train a support vector machine regression model using the abalone data
% from the UCI Machine Learning Repository.
%%
% Download the data and save it in your current folder with the name
% |'abalone.csv'|.
url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data';
websave('abalone.csv',url);
%%
% Read the data into a table. Specify the variable names.
varnames = {'Sex'; 'Length'; 'Diameter'; 'Height'; 'Whole_weight';...
    'Shucked_weight'; 'Viscera_weight'; 'Shell_weight'; 'Rings'};
Tbl = readtable('abalone.csv','Filetype','text','ReadVariableNames',false);
Tbl.Properties.VariableNames = varnames;
%%
% The sample data contains 4177 observations. All the predictor variables
% are continuous except for |Sex|, which is a categorical variable with
% possible values |'M'| (for males), |'F'| (for females), and |'I'| (for
% infants). The goal is to predict the number of rings (stored in |Rings|)
% on the abalone and determine its age using physical measurements. 
%%
% Train an SVM regression model, using a Gaussian kernel function with an
% automatic kernel scale. Standardize the data.
rng default  % For reproducibility
Mdl = fitrsvm(Tbl,'Rings','KernelFunction','gaussian','KernelScale','auto',...
    'Standardize',true)
%%
% The Command Window shows that |Mdl| is a trained |RegressionSVM| model
% and displays a property list.
%%
% Display the properties of |Mdl| using dot notation. For example, check to
% confirm whether the model converged and how many iterations it completed.
conv = Mdl.ConvergenceInfo.Converged
iter = Mdl.NumIterations
%%
% The returned results indicate that the model converged after 2759
% iterations.

%% 
% Copyright 2012 The MathWorks, Inc.