function in = myInvNorm(mu) %#codegen
%myInvNorm Inverse of standard normal cdf for code generation
%   myInvNorm is a GLM link function that accepts a numeric vector mu, and
%   returns in, which is a numeric vector of corresponding values of the
%   inverse of the standard normal cdf.
%   
in = norminv(mu);
end

