%% GUIDE Example: Share Data Between Two Apps 
% Here is a prebuilt GUIDE app that uses application data and the |guidata|
% function to share data between two dialog boxes. When you enter text in
% the second dialog box and click *OK*, the button label changes in 
% the first dialog box.
%
% <<../guide_2apps_share.png>>
%%
% In |changeme_main.m|, the |buttonChangeMe_Callback| function executes this 
% command to display the second dialog box:
%%
% |changeme_dialog('changeme_main', handles.figure)|
%%
% The |handles.figure| input argument is the |Figure| object for the *changeme_main* dialog box.

%%
% The |changeme_dialog| function retrieves the |handles| 
% structure from the |Figure| object. Thus, the entire set of components in the 
% *changeme_main* dialog box is available to the second dialog box. 




%% 
% Copyright 2012 The MathWorks, Inc.