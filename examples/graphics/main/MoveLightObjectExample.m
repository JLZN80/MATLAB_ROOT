%% Move Light Object
% Create a light positioned to the left of the camera and then reposition the 
% light each time the camera moves.

surf(peaks)
axis vis3d
h = camlight('left');
for i = 1:20
   camorbit(10,0)
   camlight(h,'left')
   pause(.1)
end

%% 
% Copyright 2012 The MathWorks, Inc.