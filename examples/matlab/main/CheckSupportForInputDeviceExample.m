%% Check Support for Input Device
% Check if the input audio device identified by the |ID| value, |0|,
% supports a sample rate of |44100| hertz, with |16| bits per sample, and
% two channels.

support = audiodevinfo(1,0,44100,16,2)

%%
% The input device supports the specified sample rate, number of bits and
% number of channels. Note that results on your system might vary.


%% 
% Copyright 2012 The MathWorks, Inc.