%% Link Axes So They Rotate Simultaneously
% Link properties of two axes so that rotating one axes automatically rotates 
% the other.
% 
% Create a figure with two axes and store the axes handles. Add plots to both 
% axes.

figure
ax1 = subplot(2,1,1);
[X1,Y1,Z1] = peaks;
surf(X1,Y1,Z1)

ax2 = subplot(2,1,2);
[X2,Y2,Z2] = peaks(10);
surf(X2,Y2,Z2)
%%
% Link the |CameraPosition| and |CameraUpVector| properties of the axes and 
% return the link object handle. Then, enable interactive rotation and use the 
% mouse to rotate either axes. Rotating one axes automatically rotates the other 
% in the same manner.

hlink = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector'}); 
rotate3d on
%%
% To disable interactive rotation, use |rotate3d off|.
% 
% Link an additional property by passing the link object handle and the property 
% name to |addprop|.

addprop(hlink,'PlotBoxAspectRatio')
%%
% Copyright 2020 The MathWorks, Inc.

