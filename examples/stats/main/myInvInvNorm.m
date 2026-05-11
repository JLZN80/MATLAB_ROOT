function iin = myInvInvNorm(mu) %#codegen
%myInvInvNorm Standard normal cdf for code generation
%   myInvInvNorm is the inverse of the GLM link function myInvNorm.
%   myInvInvNorm accepts a numeric vector mu, and returns iin, which is a
%   numeric vector of corresponding values of the standard normal cdf.
% 
iin = normcdf(mu);
end

