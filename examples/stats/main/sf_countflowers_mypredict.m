function label  = mypredict(X) %#codegen
%MYPREDICT Predict species of iris flowers using discriminant model
%   mypredict predicts species of iris flowers using the compact
%   discriminant model in the file DiscrIris.mat. Rows of X correspond to
%   observations and columns correspond to predictor variables. label is
%   the predicted species.
mdl = loadLearnerForCoder('DiscrIris');
labelTemp = predict(mdl,X);
label = IrisSpecies(labelTemp);
end