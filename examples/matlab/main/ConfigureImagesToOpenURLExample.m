%% Configure Image to Perform Action When Clicked
% Create an image and a callback that executes when the image is clicked.
% In this case, the image opens the MathWorks(R) website.
%%%
% This program file, called |imagetoURL.m|, shows you how to:
%
% * Create an image component with an |ImageClickedFcn| callback.
% * Use the <docid:matlab_ref#btigyx_ |web|> function within the callback to
% open an external URL in your system browser.
% * Create a tooltip that appears when you hover over the image.
%%%
% When you run the program file, click the image to open the MathWorks(R) 
% website. 
%%
function imagetoURL
fig = uifigure('Visible','off');
fig.Position(3:4) = [333 239];

im = uiimage(fig);
im.Position = [20 120 100 100];
im.ImageSource = 'membrane.png';
im.ImageClickedFcn = @ImageClicked;
im.Tooltip = 'Go to www.mathworks.com';
    
    function ImageClicked(src,event)
        url = 'https://www.mathworks.com/';
        web(url);
    end

fig.Visible = 'on';
end
%%%
% 
% <<../imagetoURL_screenshot.png>>
% 
% Copyright 2018 The MathWorks, Inc.