%% Create Datastore for Image Data  
% Create a datastore containing all |.tif| files in the MATLAB(R) path and
% its subfolders.  

%%  
ds = datastore(fullfile(matlabroot, 'toolbox', 'matlab'),...
'IncludeSubfolders', true,'FileExtensions', '.tif','Type', 'image')   



%% 
% Copyright 2012 The MathWorks, Inc.