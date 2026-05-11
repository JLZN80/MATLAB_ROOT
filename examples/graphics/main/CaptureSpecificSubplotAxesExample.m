%% Capture Specific Subplot Axes

% Copyright 2015 The MathWorks, Inc.


%% Can't embed yet
% Create a figure with two subplots. In the upper subplot, plot a blue
% line. In the lower subplot, plot a red line.

ax1 = subplot(2,1,1);
plot(1:10,'b')
ax2 = subplot(2,1,2);
plot(1:10,'r')

%%
% Capture the contents of the lower subplot. |getframe| captures the
% interior and border of the subplot. It does not capture tick values or
% labels that extend beyond the outline of the subplot.

F = getframe(ax2);

%%
% Use |imshow| to display the captured image data.  

%% Embed this section
figure
imshow(F.cdata)