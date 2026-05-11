%% Invert Nested Tables
% Load and display a timetable, |T1|, that has nested tables containing
% stock information. The nested tables |AAPL| and |MSFT| are the variables
% of |T1|. Each nested table has the stock prices at the open and close of
% trading, and the volume, for a different company.
load nestedTables
T1

%%
% To group the |Open|, |Close|, and |Volume| variables together in nested
% tables of their own, use the |inner2outer| function.
T2 = inner2outer(T1)

%%
% Some calculations are more convenient with data from each stock grouped
% in the nested tables of |T2|. For example, you can calculate the
% normalized volume for all stocks using |T2.Volume|.
%
% Use the |Variables| property of |T2| to convert |T2.Volume| into a
% matrix. Then subtract the mean of |T2.Volume| from |T2.Volume| and return
% the result as a matrix.
normVolume = T2.Volume.Variables - mean(T2.Volume.Variables)

%%
% You also can use table functions on the nested tables. Calculate the mean
% closing price of all stocks using the |varfun| function, returning the
% means in a table.
meanClose = varfun(@mean,T2.Close)

%% 
% Copyright 2012 The MathWorks, Inc.