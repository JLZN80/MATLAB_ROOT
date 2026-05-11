function [label,score] = myknnEnsemblePredict(X,fileName,varargin) %#codegen
CompactMdl = loadLearnerForCoder(fileName);
[label,score] = predict(CompactMdl,X,varargin{:});
end