function label = classifyIris(X) %#codegen
%CLASSIFYIRIS Classify iris species using SVM Model
%   CLASSIFYIRIS classifies the iris flower measurements in X using the SVM
%   model in the file SVMIris.mat, and then returns class labels in label.
Mdl = loadLearnerForCoder('SVMIris');
label = predict(Mdl,X);
end