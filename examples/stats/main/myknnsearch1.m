function idx = myknnsearch1(Y) %#codegen
Mdl = loadLearnerForCoder('searcherModel');
idx = knnsearch(Mdl,Y);
end