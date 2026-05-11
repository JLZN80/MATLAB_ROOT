%% Feature Extraction Workflow
% This example shows a complete workflow for feature extraction from image
% data.
%% Obtain Data
% This example uses the MNIST image data [1], which consists of images of
% handwritten digits. The images are 28-by-28 pixels in gray scale. Each
% image has an associated label from 0 through 9, which is the digit that
% the image represents.
%
% Begin by obtaining image and label data from
%
% http://yann.lecun.com/exdb/mnist/
%
% Unzip the files. For better performance on this long example, use the
% test data as training data and the training data as test data.
imageFileName = 't10k-images.idx3-ubyte';
labelFileName = 't10k-labels.idx1-ubyte';
%%
% Process the files to load them in the workspace. The code for this
% processing function appears at the end of this example.
[Xtrain,LabelTrain] = processMNISTdata(imageFileName,labelFileName);
%%
% View a few of the images.
rng('default') % For reproducibility
numrows = size(Xtrain,1);
ims = randi(numrows,4,1);
imgs = Xtrain(ims,:);
for i = 1:4
    pp{i} = reshape(imgs(i,:),28,28);
end
ppf = [pp{1},pp{2};pp{3},pp{4}];
imshow(ppf);
%% Choose New Feature Dimensions
% There are several considerations in choosing the number of features to
% extract:
%
% * More features use more memory and computational time.
% * Fewer features can produce a poor classifier.
%
% For this example, choose 100 features.
q = 100;
%% Extract Features
% There are two feature extraction functions, |sparsefilt| and |rica|.
% Begin with the |sparsefilt| function. Set the number of iterations to 10
% so that the extraction does not take too long.
%
% Typically, you get good results by running the |sparsefilt| algorithm for
% a few iterations to a few hundred iterations. Running the algorithm for
% too many iterations can lead to decreased classification accuracy, a type
% of overfitting problem.
%
% Use |sparsefilt| to obtain the sparse filtering model while using 10
% iterations.
Mdl = sparsefilt(Xtrain,q,'IterationLimit',10);
%%
% |sparsefilt| warns that the internal LBFGS optimizer did not converge.
% The optimizer did not converge because you set the iteration limit to 10.
% Nevertheless, you can use the result to train a classifier.
%% Create Classifier
% Transform the original data into the new feature representation.
NewX = transform(Mdl,Xtrain);
%%
% Train a linear classifier based on the transformed data and the correct
% classification labels in |LabelTrain|. The accuracy of the learned model
% is sensitive to the |fitcecoc| regularization parameter |Lambda|. Try to
% find the best value for |Lambda| by using the |OptimizeHyperparameters|
% name-value pair. Be aware that this optimization takes time. If you have
% a Parallel Computing Toolbox(TM) license, use parallel computing for
% faster execution. If you don't have a parallel license, remove the
% |UseParallel| calls before running this script.
t = templateLinear('Solver','lbfgs');
options = struct('UseParallel',true);
Cmdl = fitcecoc(NewX,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
%% Evaluate Classifier
% Check the error of the classifier when applied to test data. First, load
% the test data.
imageFileName = 'train-images.idx3-ubyte';
labelFileName = 'train-labels.idx1-ubyte';
[Xtest,LabelTest] = processMNISTdata(imageFileName,labelFileName);
%%
% Calculate the classification loss when applying the classifier to the
% test data.
TestX = transform(Mdl,Xtest);
Loss = loss(Cmdl,TestX,LabelTest)
%%
% Did this transformation result in a better classifier than one trained on
% the original data? Create a classifier based on the original training
% data and evaluate its loss.
Omdl = fitcecoc(Xtrain,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
Losso = loss(Omdl,Xtest,LabelTest)
%%
% The classifier based on sparse filtering has a somewhat higher loss than
% the classifier based on the original data. However, the classifier uses
% only 100 features rather than the 784 features in the original data, and
% is much faster to create. Try to make a better sparse filtering
% classifier by increasing |q| from 100 to 200, which is still far less
% than 784.
q = 200;
Mdl2 = sparsefilt(Xtrain,q,'IterationLimit',10);
NewX = transform(Mdl2,Xtrain);
TestX = transform(Mdl2,Xtest);
Cmdl = fitcecoc(NewX,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
Loss2 = loss(Cmdl,TestX,LabelTest)
%%
% This time the classification loss is lower than that of the original
% data classifier.
%% Try RICA
% Try the other feature extraction function, |rica|. Extract 200 features,
% create a classifier, and examine its loss on the test data. Use more
% iterations for the |rica| function, because |rica| can perform better
% with more iterations than |sparsefilt| uses.
%
% Often prior to feature extraction, you "prewhiten" the input data as a
% data preprocessing step. The prewhitening step includes two transforms,
% decorrelation and standardization, which make the predictors have zero
% mean and identity covariance. |rica| supports only the standardization
% transform. You use the |Standardize| name-value pair argument to make the
% predictors have zero mean and unit variance. Alternatively, you can
% transform images for contrast normalization individually by applying the
% |zscore| transformation before calling |sparsefilt| or |rica|.
Mdl3 = rica(Xtrain,q,'IterationLimit',400,'Standardize',true);
NewX = transform(Mdl3,Xtrain);
TestX = transform(Mdl3,Xtest);
Cmdl = fitcecoc(NewX,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
Loss3 = loss(Cmdl,TestX,LabelTest)
%%
% The |rica|-based classifier has somewhat higher test loss compared to the
% sparse filtering classifier.
%% Try More Features
% The feature extraction functions have few tuning parameters. One
% parameter that can affect results is the number of requested features.
% See how well classifiers work when based on 1000 features, rather than
% the 200 features previously tried, or the 784 features in the original
% data. Using more features than appear in the original data is called
% "overcomplete" learning. Conversely, using fewer features is called
% "undercomplete" learning. Overcomplete learning can lead to increased
% classification accuracy, while undercomplete learning can save memory and
% time.
q = 1000;
Mdl4 = sparsefilt(Xtrain,q,'IterationLimit',10);
NewX = transform(Mdl4,Xtrain);
TestX = transform(Mdl4,Xtest);
Cmdl = fitcecoc(NewX,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
Loss4 = loss(Cmdl,TestX,LabelTest)
%%
% The classifier based on overcomplete sparse filtering with 1000 extracted
% features has the lowest test loss of any classifier yet tested.
%%
Mdl5 = rica(Xtrain,q,'IterationLimit',400,'Standardize',true);
NewX = transform(Mdl5,Xtrain);
TestX = transform(Mdl5,Xtest);
Cmdl = fitcecoc(NewX,LabelTrain,'Learners',t, ...
    'OptimizeHyperparameters',{'Lambda'}, ...
    'HyperparameterOptimizationOptions',options);
Loss5 = loss(Cmdl,TestX,LabelTest)
%%
% The classifier based on RICA with 1000 extracted features has a similar
% test loss to the RICA classifier based on 200 extracted features.
%% Optimize Hyperparameters by Using |bayesopt|
% Feature extraction functions have these tuning parameters:
%
% * Iteration limit
% * Function, either |rica| or |sparsefilt|
% * Parameter |Lambda|
% * Number of learned features |q|
%
% The |fitcecoc| regularization parameter also affects the accuracy of the
% learned classifier. Include that parameter in the list of hyperparameters
% as well.
%
% To search among the available parameters effectively, try |bayesopt|. Use
% the following objective function, which includes parameters passed from
% the workspace.
%
% <include>filterica.m</include>
%
%%
% To remove sources of variation, fix an initial transform weight matrix.
W = randn(1e4,1e3);
%%
% Create hyperparameters for the objective function.
iterlim = optimizableVariable('iterlim',[5,500],'Type','integer');
lambda = optimizableVariable('lambda',[0,10]);
solver = optimizableVariable('solver',{'r','s'},'Type','categorical');
qvar = optimizableVariable('q',[10,1000],'Type','integer');
lambdareg = optimizableVariable('lambdareg',[1e-6,1],'Transform','log');
vars = [iterlim,lambda,solver,qvar,lambdareg];
%%
% Run the optimization without the warnings that occur when the internal
% optimizations do not run to completion. Run for 60 iterations instead of
% the default 30 to give the optimization a better chance of locating a
% good value.
warning('off','stats:classreg:learning:fsutils:Solver:LBFGSUnableToConverge');
results = bayesopt(@(x) filterica(x,Xtrain,Xtest,LabelTrain,LabelTest,W),vars, ...
    'UseParallel',true,'MaxObjectiveEvaluations',60);
warning('on','stats:classreg:learning:fsutils:Solver:LBFGSUnableToConverge');
%%
% The resulting classifier does not have better (lower) loss than the
% classifier using |sparsefilt| for 1000 features, trained for 10
% iterations.
%
% View the filter coefficients for the best hyperparameters that |bayesopt|
% found. The resulting images show the shapes of the extracted features.
% These shapes are recognizable as portions of handwritten digits.
Xtbl = results.XAtMinObjective;
Q = Xtbl.q;
initW = W(1:size(Xtrain,2),1:Q);
if char(Xtbl.solver) == 'r'
    Mdl = rica(Xtrain,Q,'Lambda',Xtbl.lambda,'IterationLimit',Xtbl.iterlim, ...
        'InitialTransformWeights',initW,'Standardize',true);
else
    Mdl = sparsefilt(Xtrain,Q,'Lambda',Xtbl.lambda,'IterationLimit',Xtbl.iterlim, ...
        'InitialTransformWeights',initW);
end
Wts = Mdl.TransformWeights;
Wts = reshape(Wts,[28,28,Q]);
[dx,dy,~,~] = size(Wts);
for f = 1:Q
    Wvec = Wts(:,:,f);
    Wvec = Wvec(:);
    Wvec =(Wvec - min(Wvec))/(max(Wvec) - min(Wvec));
    Wts(:,:,f) = reshape(Wvec,dx,dy);
end
m   = ceil(sqrt(Q));
n   = m;
img = zeros(m*dx,n*dy);
f   = 1;
for i = 1:m
    for j = 1:n
        if (f <= Q)
            img((i-1)*dx+1:i*dx,(j-1)*dy+1:j*dy,:) = Wts(:,:,f);
            f = f+1;
        end
    end
end
imshow(img);

%% Code for Reading MNIST Data
% The code of the function that reads the data into the workspace is:
%
% <include>processMNISTdata.m</include>
%
%% References
% [1] Yann LeCun (Courant Institute, NYU) and Corinna Cortes (Google Labs,
% New York) hold the copyright of MNIST dataset, which is a derivative work
% from original NIST datasets. MNIST dataset is made available under the
% terms of the Creative Commons Attribution-Share Alike 3.0 license,
% https://creativecommons.org/licenses/by-sa/3.0/

%% 
% Copyright 2012-2019 The MathWorks, Inc.