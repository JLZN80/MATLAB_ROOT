%% Fit a _t_ Copula to Data
%

% Copyright 2015 The MathWorks, Inc.


%%
% Load and plot simulated stock return data.
load stockreturns
x = stocks(:,1);
y = stocks(:,2);

figure;
scatterhist(x,y)

%%
% Transform the data to the copula scale (unit square) using a kernel
% estimator of the cumulative distribution function.
u = ksdensity(x,x,'function','cdf');
v = ksdensity(y,y,'function','cdf');

figure;
scatterhist(u,v)
xlabel('u')
ylabel('v')

%%
% Fit a _t_ copula to the data.
rng default  % For reproducibility
[Rho,nu] = copulafit('t',[u v],'Method','ApproximateML')

%%
% Generate a random sample from the _t_ copula.
r = copularnd('t',Rho,nu,1000);
u1 = r(:,1);
v1 = r(:,2);

figure;
scatterhist(u1,v1)
xlabel('u')
ylabel('v')
set(get(gca,'children'),'marker','.')

%%
% Transform the random sample back to the original scale of the data.
x1 = ksdensity(x,u1,'function','icdf');
y1 = ksdensity(y,v1,'function','icdf');

figure;
scatterhist(x1,y1)
set(get(gca,'children'),'marker','.')

