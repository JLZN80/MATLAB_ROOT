%% Distribution Plots
% This example shows how to create normal probability plots,
% quantile-quantile plots, cumulative distribution plots, and other
% probability plots.

% Copyright 2015 The MathWorks, Inc.


%% Normal Probability Plot of Normal Distribution
rng default;  % For reproducibility
x = normrnd(10,1,25,1);
normplot(x)

%% Normal Probability Plot of Non-Normal Distribution
x = exprnd(10,100,1);
normplot(x)

%% Quantile-Quantile Plots of Same Distributions
x = poissrnd(10,50,1);
y = poissrnd(5,100,1);
qqplot(x,y);

%% Quantile-Quantile Plot of Different Distributions
x = normrnd(5,1,100,1);
y = wblrnd(2,0.5,100,1);
qqplot(x,y);

%% Cumulative Distribution Plot
y = evrnd(0,3,100,1);
cdfplot(y)
hold on
x = -20:0.1:10;
f = evcdf(x,0,3);
plot(x,f,'m')
legend('Empirical','Theoretical','Location','NW')

%% Other Probability Plots
x1 = wblrnd(3,3,100,1);
x2 = raylrnd(3,100,1);
probplot('weibull',[x1 x2])
legend('Weibull Sample','Rayleigh Sample','Location','NW')
