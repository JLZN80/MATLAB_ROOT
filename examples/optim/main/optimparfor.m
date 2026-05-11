%% Minimizing an Expensive Optimization Problem Using Parallel Computing Toolbox(TM)
% This example shows how to speed up the minimization of an expensive
% optimization problem using functions in Optimization Toolbox(TM) and
% Global Optimization Toolbox. In the first part of the example we solve
% the optimization problem by evaluating functions in a serial fashion, and
% in the second part of the example we solve the same problem using the
% parallel for loop (|parfor|) feature by evaluating functions in parallel.
% We compare the time taken by the optimization function in both cases.

%   Copyright 2007-2016 The MathWorks, Inc.

%% Expensive Optimization Problem
% For the purpose of this example, we solve a problem in four variables,
% where the objective and constraint functions are made artificially
% expensive by pausing.
%
% <include>expensive_objfun.m</include>
%
% <include>expensive_confun.m</include>
%
%% Minimizing Using |fmincon|
% We are interested in measuring the time taken by |fmincon| in serial so
% that we can compare it to the parallel time.

startPoint = [-1 1 1 -1];
options = optimoptions('fmincon','Display','iter','Algorithm','interior-point');
startTime = tic;
xsol = fmincon(@expensive_objfun,startPoint,[],[],[],[],[],[],@expensive_confun,options);
time_fmincon_sequential = toc(startTime);
fprintf('Serial FMINCON optimization takes %g seconds.\n',time_fmincon_sequential);

%% Minimizing Using Genetic Algorithm
% Since |ga| usually takes many more function evaluations than |fmincon|,
% we remove the expensive constraint from this problem and perform
% unconstrained optimization instead. Pass empty matrices |[]| for
% constraints. In addition, we limit the maximum number of generations to
% 15 for |ga| so that |ga| can terminate in a reasonable amount of time. We
% are interested in measuring the time taken by |ga| so that we can compare
% it to the parallel |ga| evaluation. Note that running |ga| requires
% Global Optimization Toolbox.

rng default % for reproducibility
try
    gaAvailable = false;
    nvar = 4;
    gaoptions = optimoptions('ga','MaxGenerations',15,'Display','iter');
    startTime = tic;
    gasol = ga(@expensive_objfun,nvar,[],[],[],[],[],[],[],gaoptions);
    time_ga_sequential = toc(startTime);
    fprintf('Serial GA optimization takes %g seconds.\n',time_ga_sequential);
    gaAvailable = true;
catch ME
    warning(message('optimdemos:optimparfor:gaNotFound'));
end

%% Setting Parallel Computing Toolbox
% The finite differencing used by the functions in Optimization Toolbox to
% approximate derivatives is done in parallel using the |parfor| feature if
% Parallel Computing Toolbox is available and there is a parallel pool of
% workers. Similarly, |ga|, |gamultiobj|, and |patternsearch| solvers in
% Global Optimization Toolbox evaluate functions in parallel. To use the
% |parfor| feature, we use the |parpool| function to set up the parallel
% environment. The computer on which this example is published has four
% cores, so |parpool| starts four MATLAB(R) workers. If there is already a
% parallel pool when you run this example, we use that pool; see the
% documentation for |parpool| for more information.

if max(size(gcp)) == 0 % parallel pool needed
    parpool % create the parallel pool
end

%% Minimizing Using Parallel |fmincon|
% To minimize our expensive optimization problem using the parallel
% |fmincon| function, we need to explicitly indicate that our objective and
% constraint functions can be evaluated in parallel and that we want
% |fmincon| to use its parallel functionality wherever possible. Currently,
% finite differencing can be done in parallel. We are interested in
% measuring the time taken by |fmincon| so that we can compare it to the
% serial |fmincon| run.

options = optimoptions(options,'UseParallel',true);
startTime = tic;
xsol = fmincon(@expensive_objfun,startPoint,[],[],[],[],[],[],@expensive_confun,options);
time_fmincon_parallel = toc(startTime);
fprintf('Parallel FMINCON optimization takes %g seconds.\n',time_fmincon_parallel);

%% Minimizing Using Parallel Genetic Algorithm
% To minimize our expensive optimization problem using the |ga| function,
% we need to explicitly indicate that our objective function can be
% evaluated in parallel and that we want |ga| to use its parallel
% functionality wherever possible. To use the parallel |ga| we also require
% that the 'Vectorized' option be set to the default (i.e., 'off'). We are
% again interested in measuring the time taken by |ga| so that we can
% compare it to the serial |ga| run. Though this run may be different from
% the serial one because |ga| uses a random number generator, the number of
% expensive function evaluations is the same in both runs. Note that
% running |ga| requires Global Optimization Toolbox.

rng default % to get the same evaluations as the previous run
if gaAvailable
    gaoptions = optimoptions(gaoptions,'UseParallel',true);
    startTime = tic;
    gasol = ga(@expensive_objfun,nvar,[],[],[],[],[],[],[],gaoptions);
    time_ga_parallel = toc(startTime);
    fprintf('Parallel GA optimization takes %g seconds.\n',time_ga_parallel);
end

%% Compare Serial and Parallel Time

X = [time_fmincon_sequential time_fmincon_parallel];
Y = [time_ga_sequential time_ga_parallel];
t = [0 1];
plot(t,X,'r--',t,Y,'k-')
ylabel('Time in seconds')
legend('fmincon','ga')
ax = gca;
ax.XTick = [0 1];
ax.XTickLabel = {'Serial' 'Parallel'};
axis([0 1 0 ceil(max([X Y]))])
title('Serial Vs. Parallel Times')

%%
% Utilizing parallel function evaluation via |parfor| improved the
% efficiency of both |fmincon| and |ga|. The improvement is typically
% better for expensive objective and constraint functions.
