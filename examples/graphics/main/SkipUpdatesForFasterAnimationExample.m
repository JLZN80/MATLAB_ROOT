%% Skip Updates for Faster Animation
% Create an animation of a line growing as it accumulates 10,000 points. Since 
% there are 10,000 points, drawing each update on the screen is slow. Create a 
% faster, smooth animation by limiting the number of updates using |drawnow limitrate|. 
% Then, display the final updates on the screen by calling |drawnow| after the 
% loop ends.

h = animatedline;
axis([0 4*pi -1 1])
x = linspace(0,4*pi,10000);

for k = 1:length(x)
    y = sin(x(k));
    addpoints(h,x(k),y);
    drawnow limitrate
end
drawnow
%% 
% Copyright 2015 The MathWorks, Inc.
