function TurnoverPlot(P)
% TURNOVERPLOT: A helper function for showing turnover with an efficient
% frontier.
%
% This function accepts a Portfolio P (with constraints and initial
% holdings already defined), generates an efficient frontier, and plots the
% frontier with turnover from the initial portfolio shown in the third
% dimension.
% Copyright 2020 The MathWorks, Inc.

% How smooth of an efficient frontier do we want?
numPorts = 30;

% Generate frontier and estimate all moments
[Wts, Buys, Sells] = P.estimateFrontier(numPorts);
[Risks, Returns]   = P.estimatePortMoments(Wts);
[Risk0, Return0]   = P.estimatePortMoments(P.InitPort);

% Calculate turnovers
Turnovers = 0.5*sum(Buys + Sells);

% Reshape the data for plotting and plot it: a surface plot for the
% frontier, a point for the initial portfolio.
Turnovers = [zeros(size(Turnovers')) Turnovers'];
surf([Risks Risks], [Returns Returns], Turnovers)

scatter3(Risk0, Return0, 0, 40, 'g', 'filled')

hold on
colormap([0 0 1])
surf([Risks Risks], [Returns Returns], Turnovers)
hold off

% A convenient viewing angle
view(29,26)

title(P.Name)
xlabel('Standard Deviation of Portfolio Returns')
ylabel('Mean of Portfolio Returns')
zlabel('Turnover from Initial Portfolio')
legend('Initial Portfolio', 'Efficient Frontier', 'Location', 'East')