%% Compute Pairwise Distance with Missing Elements Using a Custom Distance Function
% Define a custom distance function that ignores coordinates with |NaN|
% values, and compute pairwise distance by using the custom distance
% function.
%%
% Create two matrices with three observations and three variables.
rng('default') % For reproducibility
X = rand(3,3)
Y = [X(:,1:2) rand(3,1)]

%% 
% The first two columns of X and Y are identical. Assume that |X(1,1)| is
% missing.
% 
X(1,1) = NaN

%%
% Compute the Hamming distance.
D1 = pdist2(X,Y,'hamming')

%%
% If observation |i| in |X| or observation |j| in |Y| contains |NaN|
% values, the function |pdist2| returns |NaN| for the pairwise distance
% between |i| and |j|. Therefore, D1(1,1), D1(1,2), and D1(1,3) are |NaN|
% values.
%%
% Define a custom distance function |nanhamdist| that ignores coordinates
% with |NaN| values and computes the Hamming distance. When working with a
% large number of observations, you can compute the distance more quickly
% by looping over coordinates of the data.
%
% <include>nanhamdist.m</include>
%

%%
% Compute the distance with |nanhamdist| by passing the function handle as
% an input argument of |pdist2|.
D2 = pdist2(X,Y,@nanhamdist)




%% 
% Copyright 2012 The MathWorks, Inc.