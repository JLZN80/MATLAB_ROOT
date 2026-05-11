function [rho,DS] = getStates(Data,n,N)

% Reference: Machine Learning in Computational Finance
%            Part II: Feature Engineering and Model Development

% Data

t = Data.t;
I = Data.I;
S = Data.S;

% Hyperparameters

dI = N;
dS = N;
numBins = n;

% Smoothed imbalance bins

sI = smoothdata(I,'movmean',[dI 0]);
binEdges = linspace(-1,1,numBins+1);
rho = discretize(sI,binEdges);

% Price changes

DS = NaN(size(S));
shiftS = S(dS+1:end);
DS(1:end-dS) = sign(shiftS-S(1:end-dS));