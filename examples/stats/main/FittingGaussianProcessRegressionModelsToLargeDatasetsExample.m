%% Fit GPR Models Using BCD Approximation
% This example shows fitting a Gaussian Process Regression
% (GPR) model to data with a large number of observations, using the
% Block Coordinate Descent (BCD) Approximation.
%% Small n - |PredictMethod| |'exact'| and |'bcd'| Produce the Same Results
%%
% Generate a small sample dataset.

    rng(0,'twister');       
    n = 1000;    
    X = linspace(0,1,n)';
    X = [X,X.^2];    
    y = 1 + X*[1;2] + sin(20*X*[1;-2])./(X(:,1)+1) + 0.2*randn(n,1);

%%
% Create a GPR model using |'FitMethod','exact'| and |'PredictMethod','exact'|.

    gpr = fitrgp(X,y,'KernelFunction','squaredexponential',...
        'FitMethod','exact','PredictMethod','exact');    
    
%%
% Create another GPR model using |'FitMethod','exact'| and
% |'PredictMethod','bcd'|.

    gprbcd = fitrgp(X,y,'KernelFunction','squaredexponential',...
        'FitMethod','exact','PredictMethod','bcd','BlockSize',200);    
    
%%
% |'PredictMethod','exact'| and |'PredictMethod','bcd'| should be
% equivalent. They compute the same $\hat{\alpha}$ but just in
% different ways. You can also see the iterations by using the |'Verbose',1|
% name-value pair argument in the call to |fitrgp| .
%% 
% Compute the fitted values using the two methods and compare them:

    ypred    = resubPredict(gpr);
    ypredbcd = resubPredict(gprbcd);

    max(abs(ypred-ypredbcd))
    
%%
% The fitted values are close to each other. 
%%
% Now, plot the data along with fitted values for |'PredictMethod','exact'|
% and |'PredictMethod','bcd'|.
    figure;
    plot(y,'k.');
    hold on;
    plot(ypred,'b-','LineWidth',2);
    plot(ypredbcd,'m--','LineWidth',2);
    legend('Data','PredictMethod Exact','PredictMethod BCD','Location','Best');
    xlabel('Observation index');
    ylabel('Response value');    
    
%%    
% It can be seen that |'PredictMethod','exact'| and |'PredictMethod','bcd'|
% produce nearly identical fits.
    
%% Large n - Use |'FitMethod','sd'| and |'PredictMethod','bcd'|

%%
% Generate a bigger dataset similar to the previous one.

    rng(0,'twister');        
    n = 50000;    
    X = linspace(0,1,n)';
    X = [X,X.^2];    
    y = 1 + X*[1;2] + sin(20*X*[1;-2])./(X(:,1)+1) + 0.2*randn(n,1);

%%
% For _n_ = 50000, the matrix _K_(_X_, _X_) would be 50000-by-50000.
% Storing _K_(_X_, _X_) in memory would require around 20 GB of RAM. To fit a
% GPR model to this dataset, use |'FitMethod','sd'| with a random subset
% of _m_ = 2000 points. The |'ActiveSetSize'| name-value pair argument in the call to
% |fitrgp| specifies the active set size _m_. For computing $\alpha$ use
% |'PredictMethod','bcd'| with a |'BlockSize'| of 5000. The |'BlockSize'|
% name-value pair argument in |fitrgp| specifies the number of elements of the
% $\alpha$ vector that the software optimizes at each iteration. A |'BlockSize'| of
% 5000 assumes that the computer you use can store a 5000-by-5000 matrix in memory.
 
   gprbcd = fitrgp(X,y,'KernelFunction','squaredexponential',...,
        'FitMethod','sd','ActiveSetSize',2000,'PredictMethod','bcd','BlockSize',5000); 
      
%%
% Plot the data and the fitted values. 
   
    figure;
    plot(y,'k.');
    hold on;    
    plot(resubPredict(gprbcd),'m-','LineWidth',2);
    legend('Data','PredictMethod BCD','Location','Best');
    xlabel('Observation index');
    ylabel('Response value');
    
%%
% The plot is similar to the one for smaller _n_ .

%% 
% Copyright 2012 The MathWorks, Inc.