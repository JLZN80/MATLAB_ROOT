%% GUIDE Example: Share Data Among Three Apps
% Here is a prebuilt GUIDE app that uses |guidata| and |UserData|
% to share data among three app windows. The large window is an icon editor that 
% accepts information from the tool palette and color palette windows.
%
% <<../guide_3apps_share.png>>
%%
% In |guide_inconeditor.m|, the function |guide_iconeditor_OpeningFcn|
% contains this command:
%%
% |colorPalette = guide_colorpalette('iconEditor', hObject)|
%%
% The arguments are:
%
% * |'iconEditor'| specifies that a callback in the *guide_iconEditor* window 
% triggered the execution of the function.
% * |hObject| is the |Figure| object for the *guide_iconEditor* window.
% * |colorPalette| is the |Figure| object for the *guide_colorPalette* window.
% 
% Similarly, |guide_iconeditor_OpeningFcn| calls the |guide_toolpalette|
% function with similar input and output arguments. 
% 
% Passing the |Figure| object between these functions allows the 
% *guide_iconEditor* window to access the |handles| structure of the other two
% windows. Likewise, the other two windows can access the 
% |handles| structure for the *guide_iconEditor* window. 



%% 
% Copyright 2012 The MathWorks, Inc.