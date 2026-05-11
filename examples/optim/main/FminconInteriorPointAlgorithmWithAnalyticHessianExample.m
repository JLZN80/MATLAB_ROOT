%% fmincon Interior-Point Algorithm with Analytic Hessian
% This example shows how to supply an analytic Hessian to the |fmincon|
% |'interior-point'| algorithm in order to obtain a faster, more accurate
% solution to a constrained minimization problem.
%
% The constraint set for this example is the intersection of the interior
% of two cones, one pointing up, and one pointing down. The constraint
% function |c| is a two-component vector, one component for each cone.
% Since this is a three-dimensional example, the gradient of the constraint
% |c| is a 3-by-2 matrix.
%
% <include>twocone.m</include>
%
% Here is a plot of the problem. The shading represents the value of the
% objective function. You can see that the objective function is minimized
% near |x = [-6.5,0,-3.5]|. For speed, the objective function |bigtoleft2|
% is vectorized. The objective function grows rapidly negative as the
% |x(1)| coordinate becomes negative. Its gradient is a three-element
% vector.
%
% <include>bigtoleft2.m</include>

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
view([-63.5 18])
grid on
hold on

% Set up polar coordinates and two cones
r = 0:.1:6.5;
th = 2*pi*(0:.01:1);
x = r'*cos(th);
y = r'*sin(th);
z = -10 + sqrt(x.^2+y.^2);
zz = 3 - sqrt(x.^2+y.^2);

% Evaluate objective function on cone surfaces
newxf = reshape(bigtoleft2([reshape(x,6666,1),reshape(y,6666,1),reshape(z,6666,1)]),66,101)/3000;
newxg = reshape(bigtoleft2([reshape(x,6666,1),reshape(y,6666,1),reshape(zz,6666,1)]),66,101)/3000;

% Create lower surf with color set by objective
surf(x,y,z,newxf,'Parent',axes1,'EdgeAlpha',0.25)

% Create upper surf with color set by objective
surf(x,y,zz,newxg,'Parent',axes1,'EdgeAlpha',0.25)
%%
% The Hessian of the Lagrangian is given by the equation
%
% $$\nabla _{xx}^2L(x,\lambda ) = {\nabla ^2}f(x) + \sum {{\lambda _i}{\nabla ^2}{c_i}(x)}
% + \sum {{\lambda _i}{\nabla ^2}ce{q_i}(x)} .$$
%
% The following function computes the Hessian at a point |x| with Lagrange
% multiplier structure |lambda|.
%
% <include>hessinterior.m</include>
%
% To perform the minimization at the command line:
%% 
% 1. Set |options| as follows.
options = optimoptions(@fmincon,'Algorithm','interior-point',...
        'Display','off','GradObj','on','GradConstr','on',...
        'Hessian','user-supplied','HessFcn',@hessinterior);
%%
% 2. Run |fmincon| with starting point |[1,1,1]|, using the |options|
% structure.
[x,fval,mflag,output] = fmincon(@bigtoleft2,[-1,-1,-1],...
           [],[],[],[],[],[],@twocone,options)
%%
% If you do not use a Hessian function, |fmincon| takes 9 iterations to
% converge, instead of 6:
options = optimoptions(@fmincon,'Algorithm','interior-point',...
        'Display','off','GradObj','on','GradConstr','on');

[x,fval,mflag,output] = fmincon(@bigtoleft2,[-1,-1,-1],...
           [],[],[],[],[],[],@twocone,options)
%%
% Both runs lead to similar solutions, but |funcCount| and |iterations| are
% lower when using an analytic Hessian.

%% 
% Copyright 2012 The MathWorks, Inc.