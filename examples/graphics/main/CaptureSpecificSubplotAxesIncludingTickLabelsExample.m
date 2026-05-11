%% Automatically Calculate Margin to Include Title and Labels

% Copyright 2015 The MathWorks, Inc.


%% Can't embed yet
% Automatically calculate a margin around the axes so that the captured
% image data includes the title, axis labels, and tick labels. 
% 
% Create a plot with a title and an _x_-axis label.

plot(rand(5))
xlabel('x values')
title('Plot of Random Data')

%%
% Change the axes units to pixels and store the |Position| and |TightInset|
% property values for the axes. The |TighInset| property is a
% four-element vector that contains the margins used around the axes for
% the tick values and text labels.

ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
ti = ax.TightInset;

%%
% Create a four-element vector, |rect|, that defines a rectangular area
% covering the axes plus the automatically calculated margin. The first two
% elements of |rect| specify the lower-left corner of the rectangle
% relative to the lower-left corner of the axes. The last two elements of
% |rect| specify the width and height of the rectangle.

rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
F = getframe(ax,rect);

%%
% Use |imshow| to display the captured image data. 

%% Embed this section
figure
imshow(F.cdata)