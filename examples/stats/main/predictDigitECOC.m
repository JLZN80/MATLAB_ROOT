function label = predictDigitECOC(X) %#codegen
%PREDICTDIGITECOC Classify digit in image using ECOC Model 
%   PREDICTDIGITECOC classifies the 28-by-28 images in the rows of X using
%   the compact ECOC model in the file DigitImagesECOC.mat, and then
%   returns class labels in label.
CompactMdl = loadLearnerForCoder('DigitImagesECOC.mat');
label = predict(CompactMdl,X); 
end
