%% Retrieve Information for Last Price Field
% Create a Bloomberg(R) connection, and then retrieve information
% for the last price field.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.

%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |fieldinfo|
% function returns data as a cell array.

c.DataReturnFormat = 'table';

%%
% Retrieve the Bloomberg field information for the |LAST_PRICE| field.

f = 'LAST_PRICE';
d = fieldinfo(c,f);

%%
% Display the last four columns in the returned Bloomberg information.

d(:,2:5)

%%
% The columns in |d| are:
%
% * Field identifier
% * Field mnemonic
% * Field name 
% * Field data type
%
% You can also access the Bloomberg help information in the first column.

%%
% Close the Bloomberg connection.

close(c)

%% 
% Copyright 2012 The MathWorks, Inc.