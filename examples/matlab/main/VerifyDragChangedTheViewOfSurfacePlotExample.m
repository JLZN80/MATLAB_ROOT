%% Verify Drag Changed View of Surface Plot

% Copyright 2020 The MathWorks, Inc.

%% 
% Create an axes within a UI figure and plot a surface into the axes using
% the |peaks| function. Then, call the |view| function to save the azimuth
% and elevation angles of the camera's line of sight for the axes. 
%%
f = uifigure;
ax = axes(f);
surf(ax,peaks)
xlabel(ax,'X')
ylabel(ax,'Y')
zlabel(ax,'Z')
[caz_before,cel_before] = view(ax);
%% 
% Create an interactive test case and drag from the point (2, 2, -10) to the
% point (4, 4, 10). A blue dot representing the programmatic drag gesture
% appears at the start value and then disappears when it reaches the stop
% value. The view of the surface plot changes with the drag.
%%
tc = matlab.uitest.TestCase.forInteractiveUse;
tc.drag(ax,[2 2 -10],[4 4 10])
%%
% Verify that the drag gesture changed the view of the surface plot.
%%
[caz_after,cel_after] = view(ax);
tc.verifyNotEqual([caz_after cel_after],[caz_before cel_before])


