%% Nondefault Options  
% Set options to view iterations as they occur and to use a different algorithm.   

% Copyright 2015 The MathWorks, Inc.


%% 
% To observe the |fmincon| solution process, set the |Display| option to
% |'iter'|. Also, try the |'sqp'| algorithm, which is sometimes faster or
% more accurate than the default |'interior-point'| algorithm. 
options = optimoptions('fmincon','Display','iter','Algorithm','sqp');  

%% 
% Find the minimum of Rosenbrock's function on the unit disk, $||x||^2
% \le 1$. First create a function that represents the nonlinear
% constraint. Save this as a file named |unitdisk.m| on your MATLAB(R) path. 
%
% <include>unitdisk.m</include>

%% 
% Create the remaining problem specifications. Then run |fmincon|. 
fun = @(x)100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
nonlcon = @unitdisk;
x0 = [0,0];
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)   

