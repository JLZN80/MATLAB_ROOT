%% Read Video Files
% This example shows how to read a video one frame at a time. You can read
% all frames in a file, or only a portion of the file.

%% Read All Frames in Video File 
% Read and store data from all frames
% in a video file, display one frame, and then play all frames at the
% video's frame rate.
%%
% Construct a |VideoReader| object associated with the sample file,
% |'xylophone.mp4'|.
vidObj = VideoReader('xylophone.mp4');
%%
% Determine the height and width of the frames.
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
%%
% Create a MATLAB(R) movie structure
% array, |s|.
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
%%        
% Read one frame at a time using |readFrame| until the end of the file is reached. Append data from
% each video frame to the structure array.
k = 1;
while hasFrame(vidObj)
    s(k).cdata = readFrame(vidObj);
    k = k+1;
end
%%
% Get information about the movie structure array, |s|.
whos s
%%
% |s| is a 1-by-141 structure array, containing data from the 141 frames in
% the video file.
%%
% Display the fifth frame stored in |s|.
image(s(5).cdata)
%%
% Resize the current figure and axes based on the video's width and height.
% Then, play the movie once at the video's frame rate using the |movie|
% function.
% set(gcf,'position',[150 150 vidObj.Width vidObj.Height]);
% set(gca,'units','pixels');
% set(gca,'position',[0 0 vidObj.Width vidObj.Height]);
% movie(s,1,vidObj.FrameRate);
%%
% Close the figure.
% close
%% Read All Frames Beginning at Specified Time 
% Read part of a video file starting 0.5 second from the beginning of the
% file.
%%
% Construct a |VideoReader| object associated with the sample file,
% |'xylophone.mp4'|.
vidObj = VideoReader('xylophone.mp4');
%% 
% Specify that reading should begin 0.5 second from the beginning of
% the file by setting the |CurrentTime| property.
vidObj.CurrentTime = 0.5;


%%        
% Create an axes to display the video. Then, read video frames until the end of the file is reached.
currAxes = axes;
while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    image(vidFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    pause(1/vidObj.FrameRate);
end
%% Read Video Frames Within Specified Time Interval
% Read part of a video file from 0.6 to 0.9 second.
%%
% Construct a |VideoReader| object associated with the sample file,
% |'xylophone.mp4'|.
vidObj = VideoReader('xylophone.mp4');

%%
% Create a MATLAB(R) movie structure
% array, |s|.
s = struct('cdata',zeros(vidObj.Height,vidObj.Width,3,'uint8'),...
    'colormap',[]);

%% 
% Specify that reading should begin 0.6 second from the beginning of
% the file by setting the |CurrentTime| property.
vidObj.CurrentTime = 0.6;
%%
% Read one frame at a time until the |CurrentTime| reaches 0.9 second.
% Append data from each video frame to the structure array, |s|.
k = 1;
while vidObj.CurrentTime <= 0.9
    s(k).cdata = readFrame(vidObj);
    k = k+1;     
end
%%
% View the number of frames in |s|.
whos s
%%
% |s| is a 1-by-10 structure showing that 10 frames were read.
%%
% View the |CurrentTime| property of the |VideoReader| object.
vidObj.CurrentTime

%%
% The |CurrentTime| property is now greater than |0.9|.
%% Display Indexed Video Frame with Colormap
% For indexed video, you can apply a colormap. The following code reads one
% RGB24 frame from a video file, converts it to an indexed image with a
% colormap, and then displays the image with a new colormap.
%%
% Construct a multimedia reader object associated with the sample file, 'xylophone.mp4'.
vidObj = VideoReader('xylophone.mp4');
%%
% Query the video format of the sample file.
info = get(vidObj,'VideoFormat')
%%
% The file contains RGB24 video.
%%
% Read the first frame in the video file using |readFrame|.
A = readFrame(vidObj);
%%
% Convert the data in the frame to an indexed image |X| with colormap |map|
% containing at most 32 colors. Then, display the indexed image with the
% associated colormap.
[X,map] = rgb2ind(A,32);
image(X);
colormap(map);
%%
% Redisplay the image with a different colormap, in this case, the built-in
% MATLAB colormap, |jet|.
colormap('jet')

%% 
% Copyright 2012 The MathWorks, Inc.