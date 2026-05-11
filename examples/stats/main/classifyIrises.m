function label = classifyIrises(X) %#codegen
%CLASSIFYIRISES Classify iris species using SVM Model
%   CLASSIFYIRISES classifies the iris flower measurements in X using the
%   compact SVM model in the file SVMIris.mat, and then returns class
%   labels in label.
CompactMdl = loadCompactModel('SVMIris');
label = predict(CompactMdl,X);
end
