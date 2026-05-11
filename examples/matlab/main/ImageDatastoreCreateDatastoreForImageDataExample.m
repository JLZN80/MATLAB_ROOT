%% Create ImageDatastore Object 
% Create an |ImageDatastore| object associated with all |.tif| files in the MATLAB(R) path and
% its subfolders.  Use the folder names as label names.

%%  
imds = imageDatastore(fullfile(matlabroot,'toolbox','matlab'),...
'IncludeSubfolders',true,'FileExtensions','.tif','LabelSource','foldernames')   



%% 
% Copyright 2012 The MathWorks, Inc.