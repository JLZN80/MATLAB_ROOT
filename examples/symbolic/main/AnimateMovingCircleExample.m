%% Animate Moving Circle
% First, create an animation object of a moving circle using
% <docid:symbolic_ug#mw_50c42eff-e177-477e-ac88-e209c15b0819>.
% Copyright 2018 The MathWorks, Inc.

%%
% Create two symbolic variables, |t| and |x|. The variable |t| defines the
% time parameter of the animation. Use |t| to set the center of the circle
% at |(t,1)| and |x| to parameterize the perimeter of the circle within the
% range |[-pi pi]|. Set the _x_-axis and _y_-axis to be equal length.
syms t x
fanimator(@fplot,cos(x)+t,sin(x)+1,[-pi pi])
axis equal

%%
% Next, enter the command |playAnimation| to play the animation.
%
% <<../playAnimationEx1_Circle.gif>>

%%
% By default, |playAnimation| plays an animation with 10 generated frames
% per unit time within the range of |t| from 0 to 10.