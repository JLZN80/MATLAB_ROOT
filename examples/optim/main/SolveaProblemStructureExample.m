%% Solve a Problem Structure  
% Create a problem structure for |fsolve| and solve the problem.   

%% 
% Solve the same problem as in <docid:optim_ug.butc7f0-1 Solution with Nondefault Options>, but formulate
% the problem using a problem structure. 
%
% Set options for the problem to have no display and a plot function that
% displays the first-order optimality, which should converge to 0 as the
% algorithm iterates. 
problem.options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);  
%%
% The equations in the nonlinear system are
%
% $$\begin{array}{c}
% {e^{ - {e^{ - ({x_1} + {x_2})}}}} = {x_2}\left( {1 + x_1^2} \right)\\
% {x_1}\cos \left( {{x_2}} \right) + {x_2}\sin \left( {{x_1}} \right) = \frac{1}{2}.
% \end{array} $$
%%
% Convert the equations to the form $F(x) = \bf{0}$.
%
% $$\begin{array}{c}
% {e^{ - {e^{ - ({x_1} + {x_2})}}}} - {x_2}\left( {1 + x_1^2} \right) = 0\\
% {x_1}\cos \left( {{x_2}} \right) + {x_2}\sin \left( {{x_1}} \right)
% - \frac{1}{2} = 0. \end{array} $$
%%
% Write a function that computes the left-hand side of these two equations.
%
% <include>root2d.m</include>
%
% Save this code as a file named |root2d.m| on your MATLAB(R) path.  

%% 
% Create the remaining fields in the problem structure. 
problem.objective = @root2d;
problem.x0 = [0,0];
problem.solver = 'fsolve';  

%% 
% Solve the problem. 
x = fsolve(problem)


%% 
% Copyright 2012 The MathWorks, Inc.