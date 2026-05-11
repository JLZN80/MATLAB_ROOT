function label = predictDigitRFSO(X) %#codegen
%PREDICTDIGITRFSO Classify digit in image using RF Model System object
%   PREDICTDIGITRFSO classifies the 28-by-28 images in the rows of X
%   using the compact random forest in the System object RFClassifier, and
%   then returns class labels in label.
classifier = RFClassifier;
label = step(classifier,X); 
end
