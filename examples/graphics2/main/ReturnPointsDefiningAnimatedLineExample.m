%% Return Points for Animated Line
% Set the maximum number of points so that the line only stores the last 10 
% points.

h = animatedline('MaximumNumPoints',10);
axis([0,4*pi,-1,1])

totalpoints = 100;
x = linspace(0,4*pi,totalpoints);
for k = 1:totalpoints
    y = sin(x(k));
    addpoints(h,x(k),y)
    drawnow 
end
%% 
% Return the values of the 10 last points added to the animated line.
%%
[x,y] = getpoints(h)
%% 
% Copyright 2015 The MathWorks, Inc.
