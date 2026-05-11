%% Axes with Pan and Data Tip Interactions
% Create a surface plot. Get the current axes and replace the default interactions with the pan 
% and data tip interactions. Then hover over the surface to 
% display data tips. Click and drag or tap and drag to pan.

surf(peaks)
ax = gca;
ax.Interactions = [panInteraction dataTipInteraction];

% Copyright 2018 The MathWorks, Inc.
