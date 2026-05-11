%% Search for Bloomberg Last Price Field
% Create a Bloomberg(R) connection, and then request the category
% description of the last price field.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |category|
% function returns data as a cell array.

c.DataReturnFormat = 'table';

%%
% Request the Bloomberg category description of the last price field.

f = 'LAST_PRICE';
d = category(c,f);

%%
% Display the first three rows of the Bloomberg category description data
% in |d|.

d(1:3,:)

%%
% The columns in |d| are:
%
% * Category
% * Field identifier
% * Field mnemonic
% * Field name
% * Field data type

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.