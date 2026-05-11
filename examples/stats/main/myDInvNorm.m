function din = myDInvNorm(mu) %#codegen
%myDInvNorm Derivative of inverse of standard normal cdf for code
%generation
%   myDInvNorm corresponds to the derivative of the GLM link function
%   myInvNorm. myDInvNorm accepts a numeric vector mu, and returns din,
%   which is a numeric vector of corresponding derivatives of the inverse
%   of the standard normal cdf.
%   
din = 1./normpdf(norminv(mu));
end

