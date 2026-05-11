%% Create Animation of Changing Line
% Animate a line that changes vertical length and line width. You can
% animate a specific graphics property by setting its value to depend on
% the animation time parameter. By default, the variable |t| is the time
% parameter of the animation.
%
% Copyright 2018 The MathWorks, Inc.

%%
% Create two symbolic variables, |y| and |t|. Plot a line with |y|
% coordinates within the interval |[0 t]| by using
% <docid:symbolic_ug#buzhss4>. Use the |fanimator| function to create the
% line animation object. |fanimator| changes the line vertical length
% by increasing the value of |t| from 0 to 10.
syms y t
fanimator(@fplot,1,y,[0 t])

%%
% Enter the command
% <docid:symbolic_ug#mw_d05e2de0-3c10-4ca8-93b5-a3e4a5107b51> to play the
% animation.
%
% <<../fanimatorEx2p5_LineLength.gif>>

%%
% Now plot a line with |y| coordinates within the interval |[0 2]| by using
% |fplot|. Set the |'LineWidth'| property value to |t+1|. Use the 
% |fanimator| function to create the line animation object. |fanimator|
% changes the line width by increasing the value of |t| from 0 to 10.
fanimator(@fplot,1,y,[0 2],'LineWidth',t+1)

%%
% Enter the command |playAnimation| to play the animation.
%
% <<../fanimatorEx2p5_LineWidth.gif>>