%% Create Animation of Circle with Timer
% Animate a circle with a timer.
%
% Copyright 2018 The MathWorks, Inc.

%%
% First, create a function that plots a unit circle and save it in a file 
% named |circ.m|. The function uses |fplot| to plot
% a unit circle centered at |(t,1)|, and the local symbolic variable |x| to
% parameterize the perimeter of the circle.
%
% <include>circ.m</include>
%

%%
% Use |fanimator| to create a unit circle animation object. Set the
% animation range of the time parameter to |[2 4.5]| and the frame rate per
% unit time to 4. Set the _x_-axis and _y_-axis to be equal length.
fanimator(@circ,'AnimationRange',[2 4.5],'FrameRate',4)
axis equal

%%
% Next, add a timer animation object. Create a piece of text to count the
% elapsed time by using the <docid:matlab_ref#f68-481090> function. Use
% <docid:matlab_ref#btfaj9t-1> to convert the time parameter to a string.
% Set the animation range of the timer to |[0 4.5]|.
hold on
fanimator(@(t) text(4.5,2.5,"Timer: "+num2str(t,2)),'AnimationRange',[0 4.5])
hold off

%%
% Enter the command
% <docid:symbolic_ug#mw_d05e2de0-3c10-4ca8-93b5-a3e4a5107b51> to play the
% animation. The timer counts the elapsed time from 0 to 4.5 seconds. The
% moving circle starts at 2 seconds and stops at 4.5 seconds.
%
% <<../fanimatorEx2_CircleAndTimer.gif>>