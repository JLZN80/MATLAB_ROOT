function label = classifyIrisSingle(X) %#codegen
% CLASSIFYIRISSINGLE Classify iris species using single-precision naive
% Bayes model
% CLASSIFYIRISSINGLE classifies the iris flower measurements in X using the
% single-precision naive Bayes model in the file naiveBayesIris.mat, and
% then returns the predicted labels in label.
Mdl = loadLearnerForCoder('naiveBayesIris','DataType','single');
label = predict(Mdl,X);
end