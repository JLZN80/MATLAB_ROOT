%% Using Functions That Depend on Data Order
% Create a vector of data, |val|, and a matrix of subscripts, |subs|.
val = 1:5;
subs = [1 2; 1 1; 1 2; 1 1; 2 3]

%%
% The subscripts in |subs| define a 2-by-3 matrix for the output, but are
% unsorted with respect to the linear indices in the output, |A|.

%%
% Group the values in |val| into a cell array by specifying |fun = @(x)
% {x}|.
A = accumarray(subs,val,[],@(x) {x})

%%
% The result is a 2-by-3 cell array. 

%%
% Examine the vector in |A{1,2}|. 
A{1,2}

%%
% The elements of the |A{1,2}| vector are in a different order than in
% |val|. The first element of the vector is 3 instead of 1. If the
% subscripts in |subs| are not sorted with respect to their linear indices,
% then |accumarray| might not always preserve the order of the data in
% |val| when it passes them to |fun|. In the unusual case that |fun|
% requires that its input values be in the same order as they appear in
% |val|, sort the indices in |subs| with respect to the linear indices of the
% output.

%%
% In this case, use the |sortrows| function with two inputs and two outputs
% to reorder |subs| and |val| concurrently with respect to the linear
% indices of the output.
[S,I] = sortrows(subs,[2,1]);
A = accumarray(S,val(I),[],@(x) {x});
A{1,2}

%%
% The elements of the |A{1,2}| vector are now in sorted order.


%% 
% Copyright 2012 The MathWorks, Inc.