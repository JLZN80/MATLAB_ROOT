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