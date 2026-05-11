%% Drag Between Points on Axes

% Copyright 2020 The MathWorks, Inc.

%% 
% Create an axes within a UI figure and then plot a line into the axes. 
% In this example, the plot sets both _x_- and _y_-axis limits to [1 10].
%%
f = uifigure;
ax = axes(f);
plot(ax,1:10) 
%%
% Create an interactive test case and drag from the point (3, 2) to the 
% point (4, 2). A blue dot representing the programmatic drag gesture appears 
% at the start value and then disappears when it reaches the stop value. The 
% axis limits are updated based on the difference between
% the start and stop values.
%%
tc = matlab.uitest.TestCase.forInteractiveUse;
tc.drag(ax,[3 2],[4 2])
%%
% Verify that the drag gesture reduced the _x_-axis limits 
% by one unit. Since the framework mimics a user manipulating the component, 
% using a tolerance to compare the actual and expected values is the 
% recommended practice.
%%
tc.verifyEqual(ax.XLim,[0 9],'AbsTol',0.1)
