%% Capture Axes Plus 30 Pixel Border
% Capture the interior of an axes plus a margin of 30 pixels in each
% direction.

% Copyright 2015 The MathWorks, Inc.


%% Can't embed yet
% Create a plot of random data. 

plot(rand(5))

%%
% Change the axes units to pixels and return the current axes position. The
% third and fourth elements of the position vector specify the axes width
% and height in pixels.
set(gca,'Units','pixels')
pos = get(gca,'Position')

%%
% Create a four-element vector, |rect|, that defines a rectangular area
% covering the axes plus the desired margin. The first two elements of
% |rect| specify the lower-left corner of the rectangle relative to the
% lower-left corner of the axes. The last two elements of |rect| specify
% the width and height of the rectangle.

marg = 30;
rect = [-marg, -marg, pos(3)+2*marg, pos(4)+2*marg];
F = getframe(gca,rect);

%%
% Use |imshow| to display the captured image data. 

%% Embed this section
figure
imshow(F.cdata)