%% Restrict Panning to X-Dimension
% Plot a set of _x_ and _y_ values, and adjust the x-axis limits to narrow the 
% view of the plot. Then replace the default set of interactions with a pan 
% interaction that is restricted to the _x_-dimension. Drag within the plot to pan. 
% Notice that you cannot pan vertically.

x = linspace(-500,500,5000);
y = sin(x)./x;
plot(x,y)
xlim([-50 50])
ax = gca;
ax.Interactions = panInteraction('Dimensions','x');

% Copyright 2018 The MathWorks, Inc.