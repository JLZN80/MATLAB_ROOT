%% Axes with Zoom Interaction
% Create a surface plot. Get the current axes and replace the default interactions with just 
% the zoom interaction. Then scroll or pinch to zoom in or out.

surf(peaks)
ax = gca;
ax.Interactions = zoomInteraction;

% Copyright 2018 The MathWorks, Inc.