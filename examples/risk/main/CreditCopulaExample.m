%% Modeling Correlated Defaults with Copulas
%
% This example explores how to simulate correlated counterparty defaults
% using a multifactor copula model.
%
% Potential losses are estimated for a portfolio of counterparties, given
% their exposure at default, default probability, and loss given default
% information. A |creditDefaultCopula| object is used to model each
% obligor's credit worthiness with latent variables.  Latent variables are
% composed of a series of weighted underlying credit factors, as well as,
% each obligor's idiosyncratic credit factor. The latent variables are
% mapped to an obligor's default or nondefault state for each scenario
% based on their probability of default. Portfolio risk measures, risk
% contributions at a counterparty level, and simulation convergence
% information are supported in the |creditDefaultCopula| object.
%
% This example also explores the sensitivity of the risk measures to the
% type of copula (Gaussian copula versus _t_ copula) used for the simulation.


%% Load and Examine Portfolio Data
%
% The portfolio contains 100 counterparties and their associated credit
% exposures at default (|EAD|), probability of default (|PD|), and loss
% given default (|LGD|).  Using a |creditDefaultCopula| object, you can
% simulate defaults and losses over some fixed time period (for example,
% one year). The |EAD|, |PD|, and |LGD| inputs must be specific to a
% particular time horizon.
%
% In this example, each counterparty is mapped onto two underlying credit
% factors with a set of weights.  The |Weights2F| variable is a
% |NumCounterparties-by-3| matrix, where each row contains the weights for
% a single counterparty.  The first two columns are the weights for the two
% credit factors and the last column is the idiosyncratic weights for each
% counterparty. A correlation matrix for the two underlying factors is also
% provided in this example (|FactorCorr2F|).

load CreditPortfolioData.mat
whos EAD PD LGD Weights2F FactorCorr2F

%%
% Initialize the |creditDefaultCopula| object with the portfolio
% information and the factor correlation.

rng('default');
cc = creditDefaultCopula(EAD,PD,LGD,Weights2F,'FactorCorrelation',FactorCorr2F);

% Change the VaR level to 99%.
cc.VaRLevel = 0.99;

disp(cc)

%%

cc.Portfolio(1:5,:)


%% Simulate the Model and Plot Potential Losses
%
% Simulate the multifactor model using the |simulate| function. By default,
% a Gaussian copula is used. This function internally maps realized latent
% variables to default states and computes the corresponding losses.  After
% the simulation, the |creditDefaultCopula| object populates the
% |PortfolioLosses| and |CounterpartyLosses| properties with the simulation
% results.

cc = simulate(cc,1e5);
disp(cc)

%%
% The |portfolioRisk| function returns risk measures for the total
% portfolio loss distribution, and optionally, their respective confidence
% intervals.  The value-at-risk (VaR) and conditional value-at-risk (CVaR)
% are reported at the level set in the |VaRLevel| property for the
% |creditDefaultCopula| object.

[pr,pr_ci] = portfolioRisk(cc);

fprintf('Portfolio risk measures:\n');
disp(pr)

fprintf('\n\nConfidence intervals for the risk measures:\n');
disp(pr_ci)

%%
% Look at the distribution of portfolio losses. The expected loss (EL),
% VaR, and CVaR are marked as the vertical lines. The economic capital,
% given by the difference between the VaR and the EL, is shown as the
% shaded area between the EL and the VaR.

histogram(cc.PortfolioLosses)
title('Portfolio Losses');
xlabel('Losses ($)')
ylabel('Frequency')
hold on

% Overlay the risk measures on the histogram.
xlim([0 1.1 * pr.CVaR])
plotline = @(x,color) plot([x x],ylim,'LineWidth',2,'Color',color);
plotline(pr.EL,'b');
plotline(pr.VaR,'r');
cvarline = plotline(pr.CVaR,'m');

% Shade the areas of expected loss and economic capital.
plotband = @(x,color) patch([x fliplr(x)],[0 0 repmat(max(ylim),1,2)],...
    color,'FaceAlpha',0.15);
elband = plotband([0 pr.EL],'blue');
ulband = plotband([pr.EL pr.VaR],'red');
legend([elband,ulband,cvarline],...
    {'Expected Loss','Economic Capital','CVaR (99%)'},...
    'Location','north');


%% Find Concentration Risk for Counterparties
%
% Find the concentration risk in the portfolio using the |riskContribution|
% function. |riskContribution| returns the contribution of each
% counterparty to the portfolio EL and CVaR.  These additive contributions
% sum to the corresponding total portfolio risk measure.

rc = riskContribution(cc);

% Risk contributions are reported for EL and CVaR.
rc(1:5,:)

%%
% Find the riskiest counterparties by their CVaR contributions.

[rc_sorted,idx] = sortrows(rc,'CVaR','descend');
rc_sorted(1:5,:)

%%
% Plot the counterparty exposures and CVaR contributions.  The
% counterparties with the highest CVaR contributions are plotted in red and
% orange.

figure;
pointSize = 50;
colorVector = rc_sorted.CVaR;
scatter(cc.Portfolio(idx,:).EAD, rc_sorted.CVaR,...
    pointSize,colorVector,'filled')
colormap('jet')
title('CVaR Contribution vs. Exposure')
xlabel('Exposure')
ylabel('CVaR Contribution')
grid on


%% Investigate Simulation Convergence with Confidence Bands
%
% Use the |confidenceBands| function to investigate the convergence of the
% simulation. By default, the CVaR confidence bands are reported, but
% confidence bands for all risk measures are supported using the optional
% |RiskMeasure| argument.

cb = confidenceBands(cc);

% The confidence bands are stored in a table.
cb(1:5,:)

%%
% Plot the confidence bands to see how quickly the estimates converge.

figure;
plot(...
    cb.NumScenarios,...
    cb{:,{'Upper' 'CVaR' 'Lower'}},...
    'LineWidth',2);

title('CVaR: 95% Confidence Interval vs. # of Scenarios');
xlabel('# of Scenarios');
ylabel('CVaR + 95% CI')
legend('Upper Band','CVaR','Lower Band');
grid on

%%
% Find the necessary number of scenarios to achieve a particular width of
% the confidence bands.

width = (cb.Upper - cb.Lower) ./ cb.CVaR;

figure;
plot(cb.NumScenarios,width * 100,'LineWidth',2);
title('CVaR: 95% Confidence Interval Width vs. # of Scenarios');
xlabel('# of Scenarios');
ylabel('Width of CI as %ile of Value')
grid on

% Find point at which the confidence bands are within 1% (two sided) of the
% CVaR.
thresh = 0.02;

scenIdx = find(width <= thresh,1,'first');
scenValue = cb.NumScenarios(scenIdx);
widthValue = width(scenIdx);
hold on
plot(xlim,100 * [widthValue widthValue],...
    [scenValue scenValue], ylim,...
    'LineWidth',2);
title('Scenarios Required for Confidence Interval with 2% Width');


%% Compare Tail Risk for Gaussian and _t_ Copulas
%
% Switching to a _t_ copula increases the default correlation between
% counterparties.  This results in a fatter tail distribution of portfolio
% losses, and in higher potential losses in stressed scenarios.
%
% Rerun the simulation using a _t_ copula and compute the new portfolio
% risk measures. The default degrees of freedom (dof) for the _t_ copula is
% five.

cc_t = simulate(cc,1e5,'Copula','t');
pr_t = portfolioRisk(cc_t);

%%
% See how the portfolio risk changes with the _t_ copula.

fprintf('Portfolio risk with Gaussian copula:\n');
disp(pr)

fprintf('\n\nPortfolio risk with t copula (dof = 5):\n');
disp(pr_t)


%%
% Compare the tail losses of each model.

% Plot the Gaussian copula tail.
figure;
subplot(2,1,1)
p1 = histogram(cc.PortfolioLosses);
hold on
plotline(pr.VaR,[1 0.5 0.5])
plotline(pr.CVaR,[1 0 0])
xlim([0.8 * pr.VaR  1.2 * pr_t.CVaR]);
ylim([0 1000]);
grid on
legend('Loss Distribution','VaR','CVaR')
title('Portfolio Losses with Gaussian Copula');
xlabel('Losses ($)');
ylabel('Frequency');

% Plot the t copula tail.
subplot(2,1,2)
p2 = histogram(cc_t.PortfolioLosses);
hold on
plotline(pr_t.VaR,[1 0.5 0.5])
plotline(pr_t.CVaR,[1 0 0])
xlim([0.8 * pr.VaR  1.2 * pr_t.CVaR]);
ylim([0 1000]);
grid on
legend('Loss Distribution','VaR','CVaR');
title('Portfolio Losses with t Copula (dof = 5)');
xlabel('Losses ($)');
ylabel('Frequency');

%%
% The tail risk measures VaR and CVaR are significantly higher using the
% _t_ copula with five degrees of freedom. The default correlations are
% higher with _t_ copulas, therefore there are more scenarios where
% multiple counterparties default. The number of degrees of freedom plays a
% significant role. For very high degrees of freedom, the results with the
% _t_ copula are similar to the results with the Gaussian copula. Five is a
% very low number of degrees of freedom and, consequentially, the results
% show striking differences. Furthermore, these results highlight that the
% potential for extreme losses are very sensitive to the choice of copula
% and the number of degrees of freedom.


%% 
% Copyright 2012 The MathWorks, Inc.