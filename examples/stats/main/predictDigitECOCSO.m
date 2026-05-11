function label = predictDigitECOCSO(X) %#codegen
%PREDICTDIGITECOCSO Classify digit in image using ECOC Model System object
%   PREDICTDIGITECOCSO classifies the 28-by-28 images in the rows of X
%   using the compact ECOC model in the System object ECOCClassifier, and
%   then returns class labels in label.
classifier = ECOCClassifier;
label = step(classifier,X); 
end
