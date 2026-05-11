%% Display Updates After Each Loop Iteration
% Use |drawnow| to display the updates after each iteration through the loop. 

t = 0:pi/100:2*pi;
y = exp(sin(t));
h = plot(t,y,'YDataSource','y');
for k = 1:0.01:10
   y = exp(sin(t.*k));
   refreshdata(h,'caller') 
   drawnow
end
%% 
% Copyright 2015 The MathWorks, Inc.
