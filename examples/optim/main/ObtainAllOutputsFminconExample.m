%% Obtain All Outputs  
% |fmincon| optionally returns several outputs that you can use for analyzing
% the reported solution.   

%% 
% Set up the problem of minimizing Rosenbrock's function on the unit disk.
% First create a function that represents the nonlinear constraint. Save
% this as a file named |unitdisk.m| on your MATLAB(R) path. 
%
% <include>unitdisk.m</include>
%
%% 
% Create the remaining problem specifications. 
fun = @(x)100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
nonlcon = @unitdisk;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
x0 = [0,0];  

%% 
% Request all |fmincon| outputs. 
[x,fval,exitflag,output,lambda,grad,hessian] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon)  

%%  
%  
% * The |lambda.ineqnonlin| output shows that the nonlinear constraint is
% active at the solution, and gives the value of the associated Lagrange
% multiplier.  
% * The |grad| output gives the value of the gradient of the objective function
% at the solution |x|.  
% * The |hessian| output is described in <docid:optim_ug.bsapedt fmincon Hessian>.     



%% 
% Copyright 2012 The MathWorks, Inc.