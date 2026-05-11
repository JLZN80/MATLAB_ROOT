%% Append Variable to MAT-File Without Compression
% Save two variables to a MAT-file. Then, append a third variable, without
% compression, to the same file.

%%
% Create two variables |A| and |B| and save them to a MAT-file Version
% |7| or |7.3|. By default,  the |save| function compresses variables |A| and |B|
% before saving them to |myFile.mat|.
A = rand(5);
B = magic(10);
save('myFile.mat','A','B','-v7.3')

%% 
% View the contents of the MAT-file.
whos('-file','myFile.mat')

%% 
% Create a new variable |C| and append it, without compression, to
% |myFile.mat|.
C = 5;
save('myFile.mat','C','-append','-nocompression')

%% 
% View the contents of the MAT-file.
whos('-file','myFile.mat')


%% 
% Copyright 2012 The MathWorks, Inc.