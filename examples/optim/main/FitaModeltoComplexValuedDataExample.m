%% Fit a Model to Complex-Valued Data  
% This example shows how to perform nonlinear fitting of complex-valued
% data. While most Optimization Toolbox(TM) solvers and algorithms operate
% only on real-valued data, least-squares solvers and |fsolve| can work on
% both real-valued and complex-valued data for unconstrained problems. The
% objective function must be analytic in the complex function sense.
%
% Do not set the |FunValCheck| option to |'on'| when using complex data.
% The solver errors.   

%% Data Model 
% The data model is a simple exponential:
%
% $$y(x) = v_1 + v_2 e^{v_3 x}.$$
%
% The $x$ is input data, $y$ is the response, and $v$ is a complex-valued
% vector of coefficients. The goal is to estimate $v$ from $x$ and noisy
% observations $y$. The data model is analytic, so you can use it in a
% complex solution.

%% Artificial Data with Noise 
% Generate artificial data for the model. Take the complex coefficient vector
% $v$ as |[2;3+4i;-.5+.4i]|. Take the observations $x$ as exponentially
% distributed. Add complex-valued noise to the responses $y$. 
rng default % for reproducibility
N = 100; % number of observations
v0 = [2;3+4i;-.5+.4i]; % coefficient vector
xdata = -log(rand(N,1)); % exponentially distributed
noisedata = randn(N,1).*exp((1i*randn(N,1))); % complex noise
cplxydata = v0(1) + v0(2).*exp(v0(3)*xdata) + noisedata;  

%% Fit the Model to Recover the Coefficient Vector 
% The difference between the response predicted by the data model and an
% observation (|xdata| for $x$ and response |cplxydata| for $y$) is: 
objfcn = @(v)v(1)+v(2)*exp(v(3)*xdata) - cplxydata;  

%% 
% Use either |lsqnonlin| or |lsqcurvefit| to fit the model to the data.
% This example first uses |lsqnonlin|. 
opts = optimoptions(@lsqnonlin,'Display','off');
x0 = (1+1i)*[1;1;1]; % arbitrary initial guess
[vestimated,resnorm,residuals,exitflag,output] = lsqnonlin(objfcn,x0,[],[],opts);
vestimated,resnorm,exitflag,output.firstorderopt 

%%
% |lsqnonlin| recovers the complex coefficient vector to about one significant
% digit. The norm of the residual is sizable, indicating that the noise
% keeps the model from fitting all the observations. The exit flag is |3|,
% not the preferable |1|, because the first-order optimality measure is
% about |1e-3|, not below |1e-6|.  

%% Alternative: Use lsqcurvefit 
% To fit using |lsqcurvefit|, write the model to give just the responses,
% not the responses minus the response data. 
objfcn = @(v,xdata)v(1)+v(2)*exp(v(3)*xdata);  

%% 
% Use |lsqcurvefit| options and syntax. 
opts = optimoptions(@lsqcurvefit,opts); % reuse the options
[vestimated,resnorm] = lsqcurvefit(objfcn,x0,xdata,cplxydata,[],[],opts) 

%%
% The results match those from |lsqnonlin|, because the underlying algorithms
% are identical. Use whichever solver you find more convenient.  

%% Alternative: Split Real and Imaginary Parts 
% To include bounds, or simply to stay completely within real values, you
% can split the real and complex parts of the coefficients into separate
% variables. For this problem, split the coefficients as follows:
%
% $$ \begin{array}{l}
% y = {v_1} + i{v_2} + ({v_3} + i{v_4})\exp \left( {({v_5} + i{v_6})x} \right)\\
% \ \  = \left( {{v_1} + {v_3}\exp ({v_5}x)\cos ({v_6}x) - {v_4}\exp ({v_5}x)\sin ({v_6}x)} \right)\\
% \ \ + i \left( {{v_2} + {v_4}\exp ({v_5}x)\cos ({v_6}x) + {v_3}\exp ({v_5}x)\sin ({v_6}x)} \right). 
% \end{array}$$
%
% Write the response function for |lsqcurvefit|.
%
% <include>cplxreal.m</include>
%
%%
% Save this code as the file |cplxreal.m| on your MATLAB(R) path.  

%% 
% Split the response data into its real and imaginary parts. 
ydata2 = [real(cplxydata),imag(cplxydata)];  

%% 
% The coefficient vector |v| now has six dimensions. Initialize it as all
% ones, and solve the problem using |lsqcurvefit|. 
x0 = ones(6,1);
[vestimated,resnorm,residuals,exitflag,output] = ...
    lsqcurvefit(@cplxreal,x0,xdata,ydata2);
vestimated,resnorm,exitflag,output.firstorderopt 

%%
% Interpret the six-element vector |vestimated| as a three-element complex
% vector, and you see that the solution is virtually the same as the previous
% solutions.   



%% 
% Copyright 2012 The MathWorks, Inc.