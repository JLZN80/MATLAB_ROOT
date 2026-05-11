%% Axes with Region Zoom and Data Tip Interactions
% Create a plot of fifty random numbers. Get the current axes, and replace the default interactions with the
% region-zoom and data tip interactions. 
% Then hover over the plotted points to display data tips. 
% Drag to zoom into a region of the plot. 
plot(rand(1,50),'-o')
ax = gca;
ax.Interactions = [regionZoomInteraction dataTipInteraction];
% Copyright 2018 The MathWorks, Inc.