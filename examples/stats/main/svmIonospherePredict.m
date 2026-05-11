function [label,score] = svmIonospherePredict(X) %#codegen
%svmIonospherePredict Predict radar-return quality using SVM model
%   svmIonospherePredict predicts labels and estimates classification
%   scores of the radar returns in the numeric matrix of predictor data X
%   using the compact SVM model in the file SVMIonosphere.mat.  Rows of X
%   correspond to observations and columns to predictor variables.  label
%   is the predicted label and score is the confidence measure for
%   classifying the radar-return quality as good.
%
% Copyright 2016 The MathWorks Inc.
Mdl = loadLearnerForCoder('SVMIonosphere');
[label,bothscores] = predict(Mdl,X);
score = bothscores(:,2);
end
