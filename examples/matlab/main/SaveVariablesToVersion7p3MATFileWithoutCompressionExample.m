%% Save Variables to MAT-File Without Compression
% Create two variables and save them, without compression, to a Version 
% |7| or |7.3| MAT-file called |myFile.mat|. 

A = rand(5);
B = magic(10);
save('myFile.mat','A','B','-v7.3','-nocompression')

%% 
% Alternatively, use the command syntax for the |save| operation. 
save myFile.mat A B -v7.3 -nocompression

%%
% The |'-nocompression'| flag facilitates a faster save for those variables
% that are larger than |2| GB or those that do not benefit from compression. 

%% 
% Copyright 2012 The MathWorks, Inc.