%% Return Tick Data as Table with Dates
% Create a Bloomberg(R) connection, and then return intraday tick
% data. The |timeseries| function returns data for dates as a |datetime|
% array.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of
% the connection object. If you do not set this property, the |timeseries|
% function returns data as a numeric array.
%
% Return dates as a |datetime| array by setting the |DatetimeType| property
% of the connection object. In this case, the table contains dates in
% variables that are |datetime| arrays.

c.DataReturnFormat = 'table';
c.DatetimeType = 'datetime';

%%
% Adjust the display format of the returned data for currency.
format bank

%%
% Retrieve the trade tick series for the IBM(R) security aggregated into
% 5-minute intervals for today. |d| is a table that contains the tick
% series data.

s = 'IBM US Equity';
date = floor(now);
interval = 5;
field = 'Trade';

d = timeseries(c,s,date,interval,field);

%%
% Access the first three ticks of data.

d(1:3,:)

%%
% |d| contains columns with the following data:
%
% * Date
% * Open price
% * High price 
% * Low price
% * Closing price
% * Volume
% * Number of ticks
% * Total tick value in the bar

%%
% Access the first three dates in the |DATE| column.

d.DATE(1:3)

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.