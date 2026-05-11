function [labels,scores] = myPredictIncrLearn(incrementalModel,X) %#codegen
% MYPREDICTINCRLEARN Predict labels and classification scores on new data
      [labels,scores] = predict(incrementalModel,X); 
end