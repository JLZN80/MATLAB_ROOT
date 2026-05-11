%% Axes with Ruler Pan and Data Tip Interactions
% Create a surface plot. Get the current axes and replace the default interactions with the ruler-pan 
% and data tip interactions. Then hover over the surface to 
% display data tips. Drag any axis to pan the limits. 

surf(peaks)
ax = gca;
ax.Interactions = [rulerPanInteraction dataTipInteraction];

% Copyright 2018 The MathWorks, Inc.