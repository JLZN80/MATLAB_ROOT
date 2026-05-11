%% Historical Data as Table with Dates
% Create a Bloomberg(R) connection, and then retrieve closing prices
% for a historical date range. The |history| function returns data for
% dates as a |datetime| array.

%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of
% the connection object. If you do not set this property, the |history|
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
% Retrieve historical closing prices for IBM(R) from August 1, 2010 through
% August 10, 2010. |d| is a table that contains dates as a |datetime|
% array.

[d,sec] = history(c,'IBM US Equity','LAST_PRICE', ...
    '8/01/2010','8/10/2010')

%%
% Access dates in the returned data.

d.DATE

%%
% Close the Bloomberg connection.

close(c)



%% 
% Copyright 2012 The MathWorks, Inc.