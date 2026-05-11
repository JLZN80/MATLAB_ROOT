%% Quadratic Programming for Portfolio Optimization, Problem-Based
% This example shows how to solve portfolio optimization problems using the 
% problem-based approach. For the solver-based approach, see
% <docid:optim_ug.mw_77a68b16-ab47-4689-adc9-5e72ead3ea3a>.

%   Copyright 2010-2018 The MathWorks, Inc.
%% The Quadratic Model
% Suppose that a portfolio contains $n$ different assets. The rate of
% return of asset $i$ is a random variable with expected value $m_i$. The
% problem is to find what fraction $x_i$ to invest in each asset $i$ in
% order to minimize risk, subject to a specified minimum expected rate of
% return.
%
% Let $C$ denote the covariance matrix of rates of asset returns.
%
% The classical mean-variance model consists of minimizing portfolio risk, as 
% measured by
%
% $$\frac{1}{2}x^T C x$$
%
% subject to a set of constraints.
%
% The expected return should be no less than a minimal rate of portfolio return 
% $r$ that the investor desires,
%
% $$\sum_{i=1}^n m_i \; x_i \ge r,$$
%
% the sum of the investment fractions $x_i$'s should add up to a total of one,
%
% $$\sum_{i=1}^n x_i = 1,$$
%
% and, being fractions (or percentages), they should be numbers between zero 
% and one,
%
% $$0 \le x_i \le 1, \;\;\; i = 1 \ldots n.$$
%
% Since the objective to minimize portfolio risk is quadratic, and the 
% constraints are linear, the resulting optimization problem is a quadratic 
% program, or QP.

%% 225-Asset Problem
% Let us now solve the QP with 225 assets. The dataset is from the OR-Library 
% [Chang, T.-J., Meade, N., Beasley, J.E. and Sharaiha, Y.M., "Heuristics for 
% cardinality constrained portfolio optimisation" Computers & Operations 
% Research 27 (2000) 1271-1302].
%
% We load the dataset and then set up the constraints for the problem-based
% approach. In this dataset the rates of return $m_i$ range between
% -0.008489 and 0.003971; we pick a desired return $r$ in between, e.g.,
% 0.002 (0.2 percent).
%
% Load dataset stored in a MAT-file.
load('port5.mat','Correlation','stdDev_return','mean_return')
%%
% Calculate the covariance matrix from correlation matrix.
Covariance = Correlation .* (stdDev_return * stdDev_return');
nAssets = numel(mean_return); r = 0.002;     % number of assets and desired return

%% Create Optimization Problem, Objective, and Constraints
% Create an optimization problem for minimization.
portprob = optimproblem;
%%
% Create an optimization vector variable |'x'| with |nAssets| elements.
% This variable represents the fraction of wealth invested in each asset,
% so should lie between 0 and 1.
x = optimvar('x',nAssets,'LowerBound',0,'UpperBound',1);
%%
% The objective function is |1/2*x'*Covariance*x|. Include this objective
% into the problem.
objective = 1/2*x'*Covariance*x;
portprob.Objective = objective;
%%
% The sum of the variables is 1, meaning the entire portfolio is invested.
% Express this as a constraint and place it in the problem.
sumcons = sum(x) == 1;
portprob.Constraints.sumcons = sumcons;
%%
% The average return must be greater than |r|. Express this as a constraint
% and place it in the problem.
averagereturn = dot(mean_return,x) >= r;
portprob.Constraints.averagereturn = averagereturn;

%% Solve 225-Asset Problem
% Set some options, and call the solver.
%
% Set options to turn on iterative display, and set a tighter optimality termination tolerance.
options = optimoptions('quadprog','Display','iter','TolFun',1e-10);
%%
% Call solver and measure wall-clock time.
tic
[x1,fval1] = solve(portprob,'Options',options); 
toc
%%
% Plot results.
plotPortfDemoStandardModel(x1.x)

%% 225-Asset Problem with Group Constraints
% We now add to the model group constraints that require that 30% of the 
% investor's money has to be invested in assets 1 to 75, 30% in assets 76 
% to 150, and 30% in assets 151 to 225. Each of these groups of assets could
% be, for instance, different industries such as technology, automotive,
% and pharmaceutical. The constraints that capture this new requirement are
%
% $$\sum_{i=1}^{75}    x_i \ge 0.3, \qquad$$
% $$\sum_{i=76}^{150}  x_i \ge 0.3, \qquad$$
% $$\sum_{i=151}^{225} x_i \ge 0.3.$$
%
% Add group constraints to existing equalities. 
grp1 = sum(x(1:75)) >= 0.3;
grp2 = sum(x(76:150)) >= 0.3;
grp3 = sum(x(151:225)) >= 0.3;
portprob.Constraints.grp1 = grp1;
portprob.Constraints.grp2 = grp2;
portprob.Constraints.grp3 = grp3;

%%
% Call solver and measure wall-clock time.
tic
[x2,fval2] = solve(portprob,'Options',options);
toc
%%
% Plot results, superimposed on results from previous problem.
plotPortfDemoGroupModel(x1.x,x2.x);

%% Summary of Results So Far
% We see from the second bar plot that, as a result of the additional group 
% constraints, the portfolio is now more evenly distributed across the three 
% asset groups than the first portfolio. This imposed diversification also 
% resulted in a slight increase in the risk, as measured by the objective 
% function (see column labeled "f(x)" for the last iteration in the iterative 
% display for both runs).

%% 1000-Asset Problem Using Random Data
% In order to show how the solver behaves on a
% larger problem, we'll use a 1000-asset randomly generated dataset.
% We generate a random correlation matrix (symmetric, positive-semidefinite, 
% with ones on the diagonal) using the |gallery| function in MATLAB(R).
%
% Reset random stream for reproducibility.
rng(0,'twister');
nAssets = 1000; % desired number of assets
%% Create Random Data
% Generate means of returns between -0.1 and 0.4.
a = -0.1; b = 0.4;
mean_return = a + (b-a).*rand(nAssets,1);
r = 0.15;                                     % desired return

%%
% Generate standard deviations of returns between 0.08 and 0.6.
a = 0.08; b = 0.6;
stdDev_return = a + (b-a).*rand(nAssets,1);
%%
% Load the correlation matrix, which was generated using |Correlation =
% gallery('randcorr',nAssets)|. (Generating a correlation matrix of this
% size takes a while, so load the pre-generated one instead.)
load('correlationMatrixDemo.mat','Correlation');
%%
% Calculate the covariance matrix from correlation matrix.
Covariance = Correlation .* (stdDev_return * stdDev_return');
%% Create Optimization Problem, Objective, and Constraints
% Create an optimization problem for minimization.
portprob2 = optimproblem;
%%
% Create the optimization vector variable |'x'| with |nAssets| elements.
x = optimvar('x',nAssets,'LowerBound',0,'UpperBound',1);
%%
% Include the objective function into the problem.
objective = 1/2*x'*Covariance*x;
portprob2.Objective = objective;
%%
% Include the constraints that the sum of the variables is 1 and the
% average return is greater than |r|.
sumcons = sum(x) == 1;
portprob2.Constraints.sumcons = sumcons;
averagereturn = dot(mean_return,x) >= r;
portprob2.Constraints.averagereturn = averagereturn;

%% Solve 1000-Asset Problem
% Call solver and measure wall-clock time.
tic
x3 = solve(portprob2,'Options',options);
toc

%% Summary
% This example illustrates how to use problem-based approach on a portfolio
% optimization problem, and shows the algorithm running times on quadratic
% problems of different sizes.
% 
% More elaborate analyses are possible by using features specifically designed 
% for portfolio optimization in Financial Toolbox(TM).
