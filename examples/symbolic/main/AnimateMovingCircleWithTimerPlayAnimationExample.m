%% Animate Moving Circle with Timer
% Create two symbolic variables, |t| and |x|. The variable |t| defines the
% time parameter of the animation.
% Copyright 2018 The MathWorks, Inc.
syms t x

%%
% Create a circle animation object using
% <docid:symbolic_ug#mw_50c42eff-e177-477e-ac88-e209c15b0819>. Use |t| to
% set the center of the circle at |(t,1)| and |x| to parameterize the
% perimeter of the circle within the range |[-pi pi]|. Set the _x_-axis and
% _y_-axis to be equal length.
fanimator(@fplot,cos(x)+t,sin(x)+1,[-pi pi])
axis equal

%%
% Add a piece of text to count the elapsed time by using the
% <docid:matlab_ref#f68-481090> function. Use <docid:matlab_ref#btfaj9t-1>
% to convert the time parameter to a string.
hold on
fanimator(@(t) text(9,3,"Timer: "+num2str(t,2)))
hold off

%%
% By default, |playAnimation| plays the animation with 10 generated frames
% per unit time within the range of |t| from 0 to 10. Change the range of
% the time parameter to |[4 8]| using the |'AnimationRange'| property.
% Change the frame rate per unit time to 4 using the |'FrameRate'|
% property. Play the animation in the current figure by entering the
% following command.
%
% |playAnimation(gcf,'AnimationRange',[4 8],'FrameRate',4)|
%
% <<../playAnimationEx2_CircleAndTimer.gif>>