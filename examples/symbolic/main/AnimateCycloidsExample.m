%% Create Animation of Cycloids
% Animate two cycloids in separate axes. A cycloid is the curve traced by a
% fixed point on a circle as the circle moves along a straight line without
% slipping.
% Copyright 2018 The MathWorks, Inc.

%%
% First, create two symbolic variables |x| and |t|. Create a figure with
% two subplots and return the first axes object as |ax1|. Create a moving
% circle animation object in |ax1| and add a fixed point on the rim of the
% circle. Set the _x_-axis and _y_-axis to be equal length.
syms x t
ax1 = subplot(2,1,1);
fanimator(ax1, @fplot, cos(x)+t, sin(x)+1, [-pi pi])
axis equal
hold on
fanimator(ax1, @(t) plot(t-sin(t), 1-cos(t), 'r*'))

%%
% To trace the cycloid, use a time variable in the plotting interval. The
% <docid:symbolic_ug#buzhss4> function plots a curve within the interval
% |[0 t]|. Create the cycloid animation object. By default, |fanimator|
% creates stop-motion frames within the range of |t| from 0 to 10 seconds.
% |fanimator| plots the first frame at |t| equal to 0.
fanimator(ax1, @fplot, x-sin(x), 1-cos(x), [0 t], 'k')
hold off

%%
% Next, create another cycloid on the second axes object |ax2|. Trace the
% curve created by a fixed point at a distance of 1/2 from the center of
% the circle. Set the _x_-axis and _y_-axis to be equal length. 
ax2 = subplot(2,1,2);
fanimator(ax2, @fplot, cos(x)+t, sin(x)+1, [-pi pi])
axis equal
hold on
fanimator(ax2, @(t) plot(t-sin(t)/2, 1-cos(t)/2, 'r*'))
fanimator(ax2, @fplot, x-sin(x)/2, 1-cos(x)/2, [0 t], 'k')
hold off

%%
% Enter the command
% <docid:symbolic_ug#mw_d05e2de0-3c10-4ca8-93b5-a3e4a5107b51> to play the
% animation.
%
% <<../fanimatorEx3_Cycloids.gif>>