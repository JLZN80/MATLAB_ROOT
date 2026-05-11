function [c, ceq] = confun(x)
%CONFUN Nonlinear inequality constraints.
% Documentation example.

%   Copyright 1990-2008 The MathWorks, Inc.

c = [1.5 + x(1)*x(2) - x(1) - x(2); 
     -x(1)*x(2) - 10];
% No nonlinear equality constraints:
ceq = [];
