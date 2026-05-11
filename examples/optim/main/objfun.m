function f = objfun(x,y)
%OBJFUN Objective function.
% Documentation example.

%   Copyright 2018 The MathWorks, Inc.

f = exp(x) * (4*x^2 + 2*y^2 + 4*x*y + 2*y + 1);
