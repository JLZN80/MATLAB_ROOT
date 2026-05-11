%% Examine Solution Using Extra Outputs  
% To easily examine the quality of a solution, request the |exitflag| and
% |output| outputs.   

% Copyright 2015 The MathWorks, Inc.


%% 
% Set up the problem of minimizing Rosenbrock's function on the unit disk,
% $||x||^2 \le 1$. First create a function that represents the nonlinear
% constraint. Save this as a file named |unitdisk.m| on your MATLAB(R)
% path.
%
% <include>unitdisk.m</include>
%
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
% Call |fmincon| using the |fval|, |exitflag|, and |output| outputs. 
[x,fval,exitflag,output] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon)  

%%  
%  
% * The |exitflag| value |1| indicates that the solution is a local minimum.  
% * The |output| structure reports several statistics about the solution
% process. In particular, it gives the number of iterations in |output.iterations|,
% number of function evaluations in |output.funcCount|, and the feasibility
% in |output.constrviolation|.     

