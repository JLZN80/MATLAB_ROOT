function label = mySVMPredict(X) %#codegen
Mdl = loadLearnerForCoder('SVMClassifier');
label = predict(Mdl,X);
end