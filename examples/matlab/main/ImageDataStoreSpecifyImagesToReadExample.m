%% Specify Images to Read  

%% 
% Create an |ImageDatastore| object containing four images, and preview
% the first image. 
imds = imageDatastore({'street1.jpg','street2.jpg','peppers.png','corn.tif'})  

%%  
imshow(preview(imds));     

%% 
% Read only the second and third images, one at a time. 
for i = 2:3
    img = readimage(imds,i);
end  

%% 
% Read all four images and view the third image.
imgs = readall(imds);
imshow(imgs{3})      



%% 
% Copyright 2012 The MathWorks, Inc.