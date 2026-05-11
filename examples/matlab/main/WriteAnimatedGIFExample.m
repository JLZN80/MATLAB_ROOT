%% Write Animated GIF
% Draw a series of plots, capture them as images, and write
% them into one animated GIF file.

%%
% Plot $y = x^{n}$ for $n = 3$.
x = 0:0.01:1;
n = 3;
y = x.^n;
plot(x,y,'LineWidth',3)
title(['y = x^n,  n = ' num2str(n) ])

%%
% Capture a series of plots for increasing values of $n$.
n = 1:0.5:5;
nImages = length(n);

fig = figure;
for idx = 1:nImages
    y = x.^n(idx);
    plot(x,y,'LineWidth',3)
    title(['y = x^n,  n = ' num2str( n(idx)) ])
    drawnow
    frame = getframe(fig);
    im{idx} = frame2im(frame);
end
close;

%%
% Display the series of images in one figure.
figure;
for idx = 1:nImages
    subplot(3,3,idx)
    imshow(im{idx});
end

%%
% Save the nine images into a GIF file.  Because
% three-dimensional data is not supported for GIF files, call |rgb2ind| to
% convert the RGB data in the image to an indexed image |A|
% with a colormap |map|. To append multiple images to the first image, call |imwrite| with the name-value pair argument
% |'WriteMode','append'|.

filename = 'testAnimated.gif'; % Specify the output file name
for idx = 1:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end


%%
% |imwrite| writes the GIF file to your current folder. Name-value pair
% |'LoopCount',Inf| causes the animation to continuously loop.
% |'DelayTime',1| specifies a 1-second delay between the display of each
% image in the animation.



%% 
% Copyright 2012 The MathWorks, Inc.