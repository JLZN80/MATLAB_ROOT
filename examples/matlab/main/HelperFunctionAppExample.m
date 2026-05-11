%% Example: Helper Function that Initializes Plots and Displays Updated Data
% This app shows how to create a helper function that initializes two
% plots and updates one of them in a component callback.
% The app calls the |updateplot| function at the end of the |StartupFcn|
% callback when the app starts up. The |UITableDisplayDataChanged| callback calls 
% the same function to update one of the plots when the user sorts columns
% or changes a value in the table.
%
% <<../table_app_screenshot.png>>

%% 
% Copyright 2012 The MathWorks, Inc.