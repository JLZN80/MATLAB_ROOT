%% Nonlinear Mixed-Effects Model with Stochastic EM Algorithm
% Load the sample data.

% Copyright 2015 The MathWorks, Inc.

load indomethacin
%%
% Fit a model to data on concentrations of the drug indomethacin in the
% bloodstream of six subjects over eight hours.
model = @(phi,t)(phi(:,1).*exp(-phi(:,2).*t)+phi(:,3).*exp(-phi(:,4).*t));
phi0 = [1 1 1 1];
xform = [0 1 0 1]; % log transform for 2nd and 4th parameters
[beta,PSI,stats,br] = nlmefitsa(time,concentration,...
   subject,[],model,phi0,'ParamTransform',xform)
%%
% Plot the data along with an overall population fit
clf 
phi = [beta(1), exp(beta(2)), beta(3), exp(beta(4))]; 
h = gscatter(time,concentration,subject);
xlabel('Time (hours)')
ylabel('Concentration (mcg/ml)')
title('{\bf Indomethacin Elimination}')
xx = linspace(0,8);
line(xx,model(phi,xx),'linewidth',2,'color','k')
%%
% Plot individual curves based on random-effect estimates.
for j=1:6
    phir = [beta(1)+br(1,j), exp(beta(2)+br(2,j)), ...
            beta(3)+br(3,j), exp(beta(4)+br(4,j))];
    line(xx,model(phir,xx),'color',get(h(j),'color'))
end