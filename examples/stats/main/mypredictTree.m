function [label,score,node,cnum] = mypredictTree(x,savedmdl,varargin) %#codegen
%MYPREDICTTREE Predict iris species using classification tree
%   MYPREDICTTREE predicts iris species for the n observations in the
%   n-by-4 matrix x using the classification tree stored in the MAT-file
%   whose name is in savedmdl, and then returns the predictions in the
%   array label. Each row of x contains the lengths and widths of the petal
%   and sepal of an iris (see the fisheriris data set). For other output
%   argument descriptions, see the predict reference page.
CompactMdl = loadLearnerForCoder(savedmdl);
[label,score,node,cnum] = predict(CompactMdl,x,varargin{:});
end