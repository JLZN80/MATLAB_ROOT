%% Solve Implicit Equations for Block Sliding Down an Inclined Plane
% A block with mass 1 kg slides down a frictionless, inclined plane with
% slope $s = -y/x$. The block starts from rest at the origin.
%
% The equations of motion are the solution of
%
% $$\ddot{x} = -s \lambda$$
%
% $$\ddot{y} = \lambda - g$$
% 
% $$s x - y = 0,$$
%
% where $g$ is the gravitational constant and $\lambda$ represents the
% force of constraint.
%
% To solve these equations with |ode15i| it is first necessary to transform
% them to a first-order state space model. This transformation results in a
% system of differential algebraic equations in implicit form.
%
% $$0  = \dot{z_1} - z_@$$
%
% $$0 = \dot{z_2} + s \lambda$$
%
% $$0 = \dot{z_3} - z_4$$
%
% $$0 = \dot{z_4} + g - \lambda$$
%
% $$0 = s z_1 - z_3$$
%

%%
% The function |slidingBlock| encodes the system of equations.
%
% <include>slidingBlock</include>
%

%%
% Since |slidingBlock| requires values for |g| and |slope|, define these
% parameters and embed them in the call to the function using a function
% handle.
slope = -2;
g = 9.81;  
odefun = @(t,z,zdot) slidingBlock(t, z, zdot, g, slope);

%%
% Use |decic| to compute a consistent set of initial conditions, fixing
% only the value $z_1 = 0$.
t0 = 0;
z0 = [0;0;0;0;0];
zp0 = [0;0;0;0;0];
[z0,zp0] = decic(odefun, t0, z0, [1;0;0;0;0], zp0, []);

%%
% Use the computed initial conditions to solve the equations using
% |ode15i|.
tspan = [0 10];
[t,z] = ode15i(odefun, tspan, z0, zp0);

%%
% Plot the solution components.
plot(t,z)
title('Block movement down a plane as computed by ODE15I')
legend('x','x''','y','y''','\lambda','Location','Best')

%% 
% Copyright 2012 The MathWorks, Inc.