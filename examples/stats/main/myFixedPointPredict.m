function [label,score] = myFixedPointPredict(X,T) %#codegen
Mdl = loadLearnerForCoder('myMdl','DataType',T);
[label,score] = predict(Mdl,X);
end