%% Determine the Parameter Value for Custom Kernel Function
% This example shows how to determine the better parameter value for a
% custom kernel function in a classifier using the ROC curves.
%%
% Generate a random set of points within the unit circle. 
rng(1);  % For reproducibility
n = 100; % Number of points per quadrant

r1 = sqrt(rand(2*n,1));                     % Random radii
t1 = [pi/2*rand(n,1); (pi/2*rand(n,1)+pi)]; % Random angles for Q1 and Q3
X1 = [r1.*cos(t1) r1.*sin(t1)];             % Polar-to-Cartesian conversion

r2 = sqrt(rand(2*n,1));
t2 = [pi/2*rand(n,1)+pi/2; (pi/2*rand(n,1)-pi/2)]; % Random angles for Q2 and Q4
X2 = [r2.*cos(t2) r2.*sin(t2)];

%%
% Define the predictor variables. Label points in the first and third
% quadrants as belonging to the positive class, and those in the second and
% fourth quadrants in the negative class.
pred = [X1; X2];      
resp = ones(4*n,1);
resp(2*n + 1:end) = -1; % Labels 

%%
% Create the function |mysigmoid.m| , which accepts two matrices in the
% feature space as inputs, and transforms them into a Gram matrix using the
% sigmoid kernel.
%
% <include>mysigmoid.m</include>
%
 
%%
% Train an SVM classifier using the sigmoid kernel function. It is good
% practice to standardize the data.
SVMModel1 = fitcsvm(pred,resp,'KernelFunction','mysigmoid',...
				'Standardize',true);
SVMModel1 = fitPosterior(SVMModel1);
[~,scores1] = resubPredict(SVMModel1);

%%
% Set |gamma = 0.5| ; within |mysigmoid.m| and save as |mysigmoid2.m|.
% And, train an SVM classifier using the adjusted sigmoid kernel.
%
% <include>mysigmoid2.m</include>
%
SVMModel2 = fitcsvm(pred,resp,'KernelFunction','mysigmoid2',...
				'Standardize',true);
SVMModel2 = fitPosterior(SVMModel2);
[~,scores2] = resubPredict(SVMModel2);

%%
% Compute the ROC curves and the area under the curve (AUC) for both models.
[x1,y1,~,auc1] = perfcurve(resp,scores1(:,2),1);
[x2,y2,~,auc2] = perfcurve(resp,scores2(:,2),1);

%%
% Plot the ROC curves.
plot(x1,y1)
hold on
plot(x2,y2)
hold off
legend('gamma = 1','gamma = 0.5','Location','SE');
xlabel('False positive rate'); ylabel('True positive rate');
title('ROC for classification by SVM');

%%
% The kernel function with the gamma parameter set to 0.5 gives better in-sample results.

%%
% Compare the AUC measures.
auc1
auc2

%%
% The area under the curve for gamma set to 0.5 is higher than that for
% gamma set to 1. This also confirms that gamma parameter value of 0.5
% produces better results. For visual comparison of the classification
% performance with these two gamma parameter values, see
% <docid:stats_ug.buax656-1 Train SVM Classifier Using Custom Kernel>.

%% 
% Copyright 2012 The MathWorks, Inc.