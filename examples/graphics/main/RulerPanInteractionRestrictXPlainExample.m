%% Restrict Ruler Panning to X-Dimension
% Create _x_ and _y_ values, and plot them using custom _x_-axis limits. 
% Replace the default set of interactions with a ruler-pan interaction that
% is restricted to the _x_-dimension. Then drag the _x_-axis to pan. 
% Notice that you cannot pan the _y_-axis. 

x = linspace(-500,500,5000);
y = sin(x)./x;
plot(x,y)
xlim([-50 50])
ax = gca;
ax.Interactions = rulerPanInteraction('Dimensions','x');

% Copyright 2018 The MathWorks, Inc.