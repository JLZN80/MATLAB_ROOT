function incrementalModel = myFitIncrLearn(incrementalModel,X,Y) %#codegen
% MYFITINCRLEARN Fit model to new data
      incrementalModel = fit(incrementalModel,X,Y); 
end