function pd = myFitDist(data,dist) %#codegen
% Fit probability distribution object to data.
pd = fitdist(data,dist);
end