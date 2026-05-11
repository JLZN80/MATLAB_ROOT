%% Recreate |tall| Arrays from Files Saved Using |write| Function 
% Use |TallDatastore| objects to reconstruct tall arrays directly from
% files on disk rather than re-executing all of the commands that produced
% the tall array. Create a tall array and save it to disk using |write|
% function. Retrieve the |tall| array using |datastore| and then convert
% it back to |tall|.

%%
% Create a simple tall double.
t = tall(rand(500,1))

%%
% Save the results to a new folder named |ExampleData| on the |C:\| disk. (You
% might want to specify a different write location, especially if you are
% not using a Windows(R) computer.)
location = 'C:\ExampleData';
write(location, t);

%%
% To recover the |tall| array that was written to disk, first create a new
% datastore that references the same directory. Then convert the datastore
% into a |tall| array.
tds = datastore(location);
t1 = tall(tds)



%% 
% Copyright 2012 The MathWorks, Inc.