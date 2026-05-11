%%  Current Data and Dates as Table with Datetime
% Create a Bloomberg(R) connection, and then request current data
% for specific fields. The |getdata| function returns data for dates as a
% |datetime| array.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of the
% connection object. If you do not set this property, the |getdata|
% function returns data as a structure.
%
% Return dates as a |datetime| array by setting the |DatetimeType| property
% of the connection object. In this case, the table contains dates in
% variables that are |datetime| arrays.

c.DataReturnFormat = 'table';
c.DatetimeType = 'datetime';

%%
% Request current data for these fields:
%
% * Last update date
% * Last price
% * Number of trades
% * Previous real-time trading date

s = 'IBM US Equity';
f = {'LAST_UPDATE_DT','LAST_PRICE', ...
    'NUM_TRADES_RT','PREV_TRADING_DT_REALTIME'};
d = getdata(c,s,f)

%%
% Display the last update date. This date is a |datetime| array.

d.LAST_UPDATE_DT

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.