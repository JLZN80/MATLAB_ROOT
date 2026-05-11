function y = myrandomGLM(x,varargin) %#codegen
%MYRANDOMGLM Simulate responses using GLM model 
%   MYRANDOMGLM simulates responses for the n observations in the n-by-1
%   vector x using the GLM model stored in the MAT-file GLMMdl.mat, and
%   then returns the simulations in the n-by-1 vector y.
CompactMdl = loadLearnerForCoder('GLMMdl');
narginchk(1,Inf);
y = random(CompactMdl,x,varargin{:});
end

