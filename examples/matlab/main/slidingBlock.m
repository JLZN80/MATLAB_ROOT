function res = slidingBlock(t, z, zdot, g, slope)
  % Model the dynamics of a block with mass 1 sliding down a frictionless
  % incline with input slope. This is a degree 1 DAE derived from the
  % Lagrangian:
  %
  %  L = 1/2*(xdot^2 + ydot^2) - g*y + lambda*(slope*x +y)
  %
  %  where x=z(1), xdot=z(2), y=z(3), ydot=z(4) and lambda=z(5).
  %
  % Inputs:
  %           t      unused -- required for the ode15i interface
  %           z      5x1 vector containing [x, xdot, y, ydot, lambda]
  %           zdot   5x1 vector of time derivatives of z
  %           g      gravitational constant
  %           slope  slope of the incline
  % Output:  
  %           res    residuals of the equations to be solved
  res = zeros(5,1);
  res(1) = zdot(1) - z(2);
  res(2) = zdot(2) + slope*z(5);
  res(3) = zdot(3) - z(4);
  res(4) = zdot(4) + g - z(5) ;
  res(5) = slope*z(1) - z(3);
end