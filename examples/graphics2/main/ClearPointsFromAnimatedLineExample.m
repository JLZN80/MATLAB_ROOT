%% Clear Points from Animated Line
% First, create an animated line.

h = animatedline;
axis([0,4*pi,-1,1])

numpoints = 10000;
x = linspace(0,4*pi,numpoints);
for k = 1:numpoints
    y = sin(x(k));
    addpoints(h,x(k),y)
    drawnow limitrate
end
%% 
% Now, clear the points from the animated line. To see the update on the 
% screen, use |drawnow|. 
%%
clearpoints(h)
drawnow
%% 
% Copyright 2015 The MathWorks, Inc.
