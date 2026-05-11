function [yhat,lo,hi] = classifyGLM(b,x,link,varargin) %#codegen
%CLASSIFYGLM Classify measurements using GLM model 
%   CLASSIFYGLM classifies the n observations in the n-by-1 vector x using
%   the GLM model with regression coefficients b and link function link,
%   and then returns the n-by-1 vector of predicted values in yhat.
%   CLASSIFYGLM also returns margins of error for the predictions using
%   additional information in the GLM statistics structure stats.
narginchk(3,Inf);
if(isstruct(varargin{1}))
    stats = varargin{1};
    [yhat,lo,hi] = glmval(b,x,link,stats,varargin{2:end});
else
    yhat = glmval(b,x,link,varargin{:});
end
end
