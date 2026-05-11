function [yhat,ci] = mypredictGLM(x,varargin) %#codegen
%MYPREDICTGLM Predict responses using GLM model
%   MYPREDICTGLM predicts responses for the n observations in the n-by-1
%   vector x using the GLM model stored in the MAT-file GLMMdl.mat,
%   and then returns the predictions in the n-by-1 vector yhat.
%   MYPREDICTGLM also returns confidence interval bounds for the
%   predictions in the n-by-2 vector ci.
CompactMdl = loadLearnerForCoder('GLMMdl');
narginchk(1,Inf);
[yhat,ci] = predict(CompactMdl,x,varargin{:});
end
