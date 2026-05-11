%% Transforming a Group of Objects
% This example shows how to create a 3-D star with a group of surface objects 
% parented to a single transform object. The transform object then rotates the 
% object about the z-axis while scaling its size.
% 
% Create an axes and adjust the view. Set the axes limits to prevent auto 
% limit selection during scaling.

ax = axes('XLim',[-1.5 1.5],'YLim',[-1.5 1.5],'ZLim',[-1.5 1.5]);
view(3)
grid on
%% 
% Create the objects you want to parent to the transform object.
%%
[x,y,z] = cylinder([.2 0]);
h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(x,y,-z,'FaceColor','green');
h(3) = surface(z,x,y,'FaceColor','blue');
h(4) = surface(-z,x,y,'FaceColor','cyan');
h(5) = surface(y,z,x,'FaceColor','magenta');
h(6) = surface(y,-z,x,'FaceColor','yellow');
%% 
% Create a transform object and parent the surface objects to it. Initialize 
% the rotation and scaling matrix to the identity matrix (eye).
%%
t = hgtransform('Parent',ax);
set(h,'Parent',t)

Rz = eye(4);
Sxy = Rz;
%% 
% Form the _z_-axis rotation matrix and the scaling matrix. Rotate group 
% and scale by using the increasing values of |r|.
%%
for r = 1:.1:2*pi
    % Z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    % Scaling matrix
    Sxy = makehgtform('scale',r/4);
    % Concatenate the transforms and
    % set the transform Matrix property
    set(t,'Matrix',Rz*Sxy)
    drawnow
end
pause(1)
%% 
% Reset to the original orientation and size using the identity matrix.
%%
set(t,'Matrix',eye(4))
%% 
% Copyright 2015 The MathWorks, Inc.
