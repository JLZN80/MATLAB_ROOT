%% Transforming Objects Independently
% This example creates two transform objects to illustrate how to transform 
% each independently within the same axes. A translation transformation moves 
% one transform object away from the origin.
% 
% Create and set up the axes object that will be the parent of both transform 
% objects. Set the limits to accommodate the translated object.

ax = axes('XLim',[-3 1],'YLim',[-3 1],'ZLim',[-1 1]);
view(3)
grid on
%% 
% Create the surface objects to group.
%%
[x,y,z] = cylinder([.3 0]);
h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(x,y,-z,'FaceColor','green');
h(3) = surface(z,x,y,'FaceColor','blue');
h(4) = surface(-z,x,y,'FaceColor','cyan');
h(5) = surface(y,z,x,'FaceColor','magenta');
h(6) = surface(y,-z,x,'FaceColor','yellow');
%% 
% Create the transform objects and parent them to the same axes. Then, parent 
% the surfaces to transform t1. Copy the surface objects and parent the copies 
% to transform t2. This figure should not change.
%%
t1 = hgtransform('Parent',ax);
t2 = hgtransform('Parent',ax);

set(h,'Parent',t1)
h2 = copyobj(h,t2);
%% 
% Translate the second transform object away from the first transform object 
% and display the result.
%%
Txy = makehgtform('translate',[-1.5 -1.5 0]);
set(t2,'Matrix',Txy)
drawnow
%% 
% Rotate both transform objects in opposite directions. 
%%
% Rotate 10 times (2pi radians = 1 rotation)
for r = 1:.1:20*pi
    % Form z-axis rotation matrix
    Rz = makehgtform('zrotate',r);
    % Set transforms for both transform objects
    set(t1,'Matrix',Rz)
    set(t2,'Matrix',Txy*inv(Rz))
    drawnow
end
%% 
% Copyright 2015 The MathWorks, Inc.
