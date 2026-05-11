function [pd_truncated,st] = myEvaluateDist(pd,truncation_limits,x) %#codegen
% Truncate pd.
pd_truncated = truncate(pd,truncation_limits(1),truncation_limits(2));

% Compute the mean of the truncated pd.
mean_val = mean(pd_truncated);

% Compute the cdf and pdf, evaluated at x.
cdf_val = cdf(pd_truncated,x);
pdf_val = pdf(pd_truncated,x);

% Create a structure array containing the mean, cdf, and pdf values.
st = struct('mean', mean_val,'cdf',cdf_val,'pdf',pdf_val);
end