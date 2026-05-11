%% View Information About Audio Devices
% Call |audiodevinfo| with no inputs to view information about the input and output audio devices on a system.
% |audiodevinfo| returns a structure containing two fields, |input| and |output|.
info = audiodevinfo

%% 
% The input field contains audio device names, driver used, and device identifiers.
info.input

%%
% Display the information on the first input device. 
info.input(1)

%%
% Display the information on the second input device. 
info.input(2)

%%
% The values on your system might differ from this example.

%% 
% Copyright 2012 The MathWorks, Inc.