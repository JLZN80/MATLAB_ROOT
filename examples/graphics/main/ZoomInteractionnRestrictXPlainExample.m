%% Restrict Zooming to X-Dimension
% Use the |sphere| function to define vectors |x|, |y|, and |z|. Then create a scatter plot using 
% those vectors. Replace the default set of interactions with a zoom interaction 
% that is restricted to the _x_-dimension. Then scroll or pinch within the plot to zoom.

[X,Y,Z] = sphere(16);
x = [0.5*X(:); 0.75*X(:); X(:)];
y = [0.5*Y(:); 0.75*Y(:); Y(:)];
z = [0.5*Z(:); 0.75*Z(:); Z(:)];
scatter3(x,y,z)
xlabel('X')
ylabel('Y')
zlabel('Z')
ax = gca;
ax.Interactions = zoomInteraction('Dimensions','x');

% Copyright 2018 The MathWorks, Inc.