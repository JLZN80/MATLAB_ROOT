%% Estimate Posterior Class Probabilities
% ECOC models composed of linear classification models return posterior
% probabilities for logistic regression learners only.  This example
% requires the Parallel Computing Toolbox(TM) and the Optimization
% Toolbox(TM)
%%
% Load the NLP data set and preprocess the data as in
% <docid:stats_ug.bu7wtha-1 Specify Custom Binary Loss>.
load nlpdata
X = X';
Y(~(ismember(Y,{'simulink','dsp','comm'}))) = 'others';
%%
% Create a set of 5 logarithmically-spaced regularization strengths from
% $10^{-5}$ through $10^{-0.5}$.
Lambda = logspace(-6,-0.5,5); 
%%
% Create a linear classification model template that specifies optimizing
% the objective function using SpaRSA and to use logistic regression
% learners.
t = templateLinear('Solver','sparsa','Learner','logistic','Lambda',Lambda);
%%
% Cross-validate an ECOC model of linear classification models using 5-fold
% cross-validation.  Specify that the predictor observations correspond to
% columns, and to use parallel computing.
rng(1); % For reproducibility 
Options = statset('UseParallel',true);
CVMdl = fitcecoc(X,Y,'Learners',t,'KFold',5,'ObservationsIn','columns',...
    'Options',Options);
%%
% Predict the cross-validated posterior class probabilities.  Specify to
% use parallel computing and to estimate posterior probabilities using
% quadratic programming.
[label,~,~,Posterior] = kfoldPredict(CVMdl,'Options',Options,...
    'PosteriorMethod','qp');
size(label)
label(3,4)
size(Posterior)
Posterior(3,:,4)
%%
% Because there are five regularization strengths:
%
% * |label| is a 31572-by-5 categorical array.  |label(3,4)| is the
% predicted, cross-validated label for observation 3 using the model
% trained with regularization strength |Lambda(4)|.
% * |Posterior| is a 31572-by-4-by-5 matrix. |Posterior(3,:,4)| is the
% vector of all estimated, posterior class probabilities for observation 3
% using the model trained with regularization strength |Lambda(4)|. The
% order of the second dimension corresponds to |CVMdl.ClassNames|. 
% Display a random set of 10 posterior class probabilities.
%
%%
% Display a random sample of cross-validated labels and posterior
% probabilities for the model trained using |Lambda(4)|.
idx = randsample(size(label,1),10);
table(Y(idx),label(idx,4),Posterior(idx,1,4),Posterior(idx,2,4),...
    Posterior(idx,3,4),Posterior(idx,4,4),...
    'VariableNames',[{'True'};{'Predicted'};categories(CVMdl.ClassNames)])

%% 
% Copyright 2012 The MathWorks, Inc.