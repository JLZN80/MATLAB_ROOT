%% Example: App that Displays a Table Array
% This app shows how to display a |Table| UI component in an app that uses table array data. 
% The table array contains |numeric|, |logical|, |categorical|, and multicolumn variables.
%
% The |StartupFcn| callback loads a spreadsheet into a table array. Then a subset of the data
% displays and is plotted in the app. One plot displays the original table data.
% The other plot initially shows the same table data, and then updates when the user edits
% a value or sorts a column in the |Table| UI component.
%
% <<../table_app_screenshot.png>>
%
% Copyright 2018 The MathWorks, Inc.