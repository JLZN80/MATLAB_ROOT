%% Axes with Rotate and Data Tip Interactions
% Create a surface plot. Get the current axes and replace the default interactions with the 
% rotate and data tip interactions. Then hover over the 
% surface to display data tips. Drag to rotate the plot.

surf(peaks)
ax = gca;
ax.Interactions = [rotateInteraction dataTipInteraction];

% Copyright 2018 The MathWorks, Inc.