%% Display a Picture
%%%
% Create an image component within a figure. The default image displays.
% 
fig = uifigure;
im = uiimage(fig);
%%%
% <<../uiimage_ex_default.png>>
%%%
% Now, add a picture to the image component.
%
im.ImageSource = 'peppers.png';
%%%
% <<../uiimage_ex_peppers.png>>
% 
% Copyright 2018 The MathWorks, Inc.