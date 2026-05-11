%% Include Gradient  
% Include gradient evaluation in the objective function for faster or more
% reliable computations.   

%% 
% Include the gradient evaluation as a conditionalized output in the objective
% function file. For details, see <docid:optim_ug.bsj1e55 Including Gradients and Hessians>. The objective
% function is Rosenbrock's function,
%
% $$ f(x) = 100{\left( {{x_2} - x_1^2} \right)^2} +
% {(1 - {x_1})^2},$$
%
% which has gradient
%
% $$\nabla f(x) = \left[ {\begin{array}{*{20}{c}}
% { - 400\left( {{x_2} - x_1^2} \right){x_1} - 2\left( {1 - {x_1}} \right)}\\
% {200\left( {{x_2} - x_1^2} \right)}
% \end{array}} \right].$$
%
% <include>rosenbrockwithgrad.m</include>
%
% Save this code as a file named |rosenbrockwithgrad.m| on your MATLAB(R) path.  
%
% Create options to use the objective function gradient. 
options = optimoptions('fmincon','SpecifyObjectiveGradient',true);  

%% 
% Create the other inputs for the problem. Then call |fmincon|. 
fun = @rosenbrockwithgrad;
x0 = [-1,2];
A = [];
b = [];
Aeq = [];
beq = [];
lb = [-2,-2];
ub = [2,2];
nonlcon = [];
x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)   



%% 
% Copyright 2012 The MathWorks, Inc.