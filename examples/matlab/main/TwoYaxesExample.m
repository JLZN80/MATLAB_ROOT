%% Creating Plots with Two y-Axes
% This example shows how to create and customize plots with two y-axes.

%   Copyright 2014 The MathWorks, Inc.

%% The |plotyy| Function
% To create a plot with two y-axes use the |plotyy| function.  The function
% takes two sets of _x,y_ data.  The first set of _x,y_ data is plotted against
% the y-axis on the left and the second set of _x,y_ data is plotted against
% the y-axis on the right.

x1 = 0:0.01:20;                     % data for the left y-axis
y1 = 200*exp(-0.05*x1).*sin(x1);

x2 = 0:0.05:20;                     % data for the right y-axis
y2 = 0.8*exp(-0.5*x2).*sin(10*x2);

figure
plotyy(x1,y1,x2,y2)

%% Change Axes Properties
% The |plotyy| function creates two y-axes.  To get the two axes objects,
% call the function with one output argument. The value returned by the
% function is an array containing the two axes objects.

ax = plotyy(x1,y1,x2,y2)

%%
% To customize the look of your plot, change property values of either axis
% using dot notation syntax |object.PropertyName|.

ax(1).YTick = [-200 -100 0 100 200];    % change the ticks for the left y-axis
ax(2).YGrid = 'on';                     % turn on the grid for the right y-axis

%% Select Plotting Function for Each Axes
% The |plotyy| function has optional arguments that allow you to specify
% the type of function to use when plotting the data for each y-axis.

x = 1:11;
data1 = [4889 5273 5382 5173 4860 4675 4313 4059 3855 3608 3297];
data2 = [16.4 17.4 17.4 16.5 15.4 14.7 13.5 12.5 11.7 10.8 9.7];

plotyy(x,data1,x,data2,'bar','plot')    % left y-axis with bar, right y-axis with plot

%% Modify Properties of Objects Plotted
% The second and third output arguments for |plotyy| are the objects
% created for the left and right axes, respectively. In the example below,
% the second output is a bar object created for the left y-axis and the
% third output is a line object created for the right y-axis.

[ax,h1,h2] = plotyy(x,data1,x,data2,'bar','plot')
%%
% Once you have the objects, you can set their properties to customize the
% look of the plot.

h1.FaceColor = [0.8, 0.8, 0.8];    % change the bar colors to light gray
h2.LineWidth = 2;                  % change the thickness of the line
