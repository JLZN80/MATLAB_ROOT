%% Axes with Data Tip and Pan Interactions
% Create a surface plot. Get the current axes and replace the default interactions with the 
% data tip and pan interactions. Then hover over the 
% surface to display data tips. Click and drag or tap and drag to pan.

surf(peaks)
ax = gca;
ax.Interactions = [dataTipInteraction panInteraction];

% Copyright 2018 The MathWorks, Inc.