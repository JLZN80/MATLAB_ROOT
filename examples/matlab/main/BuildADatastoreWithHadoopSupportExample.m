%% Build a Datastore with Hadoop Support
% Build a datastore with parallel processing and Hadoop(R) support and use it to bring
% your custom or proprietary data into MATLAB(R).

%%
% The data set used in this example is collection of 15 binary (|.bin|)
% files where each file contains a column (|1| variable) and |10000| rows
% (records) of unsigned integers. This simple dataset is used to illustrate
% a workflow that you can use to build a custom datastore for your own
% data.

dir('*.bin')

%%
% Implement your Custom Datastore In your working folder, or a folder that
% is on the MATLAB(R) path, create a new script, |MyDatastoreHadoop.m| that
% contains the code implementing your custom datastore. The name of the
% script file must be the same as the name of your object constructor
% function. For example, if you want your constructor function has the name
% MyDatastoreHadoop, then the name of the script file must be 
% |MyDatastoreHadoop.m|. The script must contain the following steps:
%
% * Step 1: Inherit from the datastore classes
% * Step 2: Define the constructor and the required methods
% * Step 3: Define your custom file reading function
%
% <include>MyDatastoreHadoop.m</include>
%
%%
% Your custom datastore is ready to use for creating a datastore object
% with data from a Hadoop(R) server.


%% 
% Copyright 2012 The MathWorks, Inc.