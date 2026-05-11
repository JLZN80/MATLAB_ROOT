%% Retrieve Equity Screening Data for Screen
% Create a Bloomberg(R) connection, and then retrieve frontier
% market stock data. 
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.

%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |eqs| function
% returns data as a cell array.

c.DataReturnFormat = 'table';

%%
% Retrieve equity screening data for the screen named |Frontier Market
% Stocks with 1 billion USD Market Caps|.

sname = 'Frontier Market Stocks with 1 billion USD Market Caps';
d = eqs(c,sname);

%%
% Display the first three rows in the returned data |d|.

d(1:3,:)

%%
% The columns in d are:
%
% * Country name
% * Company name
% * Industry name
% * Market capitalization
% * Price
% * Price-to-book ratio
% * Price-earnings ratio
% * Earnings per share

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.