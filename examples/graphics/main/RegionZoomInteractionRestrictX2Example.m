%% Restrict Region Zooming to X-Dimension
% Create a scatter plot of normally distributed random data. 
% Replace the default set of interactions with a region-zoom interaction 
% that operates only in the _x_-dimension. Then drag within the plot to 
% zoom into a region of interest.

x = linspace(-1,1,1000);
y = randn(1,1000);
scatter(x,y,'.')
ax = gca;
ax.Interactions = regionZoomInteraction('Dimensions','x');

% Copyright 2018 The MathWorks, Inc.