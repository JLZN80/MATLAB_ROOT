%% Create Animation of Moving Point and Circle
% Animate a point and a circle that move along a straight line.
%
% First, create a function to plot a point at |(t,1)|. The variable |t|
% defines the time parameter of the animation.
% Copyright 2018 The MathWorks, Inc.
f = @(t) plot(t,1,'r*');

%%
% Create a stop-motion animation object defined by |f|.
fanimator(f)

%%
% Next, create a function handle by using <docid:symbolic_ug#buzhss4> to
% plot a unit circle. The circle is a function of two variables.
%
% Create two symbolic variables |t| and |x|. Use |t| to set the center of
% the circle at |(t,1)| and |x| to parameterize the perimeter of the circle
% within the range |[-pi pi]|. Add the circle animation object to the
% existing plot. Set the _x_-axis and _y_-axis to be equal length.
syms t x
hold on
fanimator(@fplot,cos(x)+t,sin(x)+1,[-pi pi])
axis equal
hold off

%%
% Enter the command
% <docid:symbolic_ug#mw_d05e2de0-3c10-4ca8-93b5-a3e4a5107b51> to play the 
% animation. By default, |fanimator| creates an animation object,
% generating 10 frames per unit time within the range of |t| from 0 to 10.
%
% <<../fanimatorEx1_PointAndCircle.gif>>