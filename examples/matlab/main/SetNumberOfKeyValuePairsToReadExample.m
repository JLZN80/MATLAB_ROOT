%% Set Number of Key-Value Pairs to Read
% Create a datastore from the sample file, |mapredout.mat|, which is an
% output file of the |mapreduce| function.
ds = datastore('mapredout.mat')

%%
% Set the |ReadSize| property to |8| so that each call to read reads at
% most |8| key-value pairs.
ds.ReadSize = 8


%%
% Read 8 key-value pairs at a time using the |read| function in a |while| loop.
% The loop executes until there is no more data available to read and
% |hasdata(ds)| returns |false|.

while hasdata(ds)
    T = read(ds);
end

%%
% Show the last set of key-value pairs read.
T

%% 
% Copyright 2012 The MathWorks, Inc.