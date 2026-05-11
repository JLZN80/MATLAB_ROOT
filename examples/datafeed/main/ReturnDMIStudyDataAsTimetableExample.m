%% Return DMI Study Data as Timetable 
% Create a Bloomberg(R) connection, and then return data for a DMI
% study. The |tahistory| function returns data as a |timetable|.
%%
% Create the Bloomberg connection.

c = blp; 

%%
% Alternatively, you can connect to the Bloomberg Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.
%%
% Return data as a table by setting the |DataReturnFormat| property of
% the connection object. If you do not set this property, the |tahistory|
% function returns data as a structure.

c.DataReturnFormat = 'timetable';

%%
% Adjust the display format of the returned data for currency.
format bank

%%
% Run the DMI study for the IBM(R) security from June 12, 2017 through June
% 16, 2017 with |period| equal to 14, the high price, the low price, and
% the closing price. 

d = tahistory(c,'IBM US Equity','6/12/2017','6/16/2017','dmi', ...
    'all_calendar_days','period',14,'priceSourceHigh','PX_HIGH', ...
    'priceSourceLow','PX_LOW','priceSourceClose','PX_LAST');

%%
% Access the DMI study data for the first three dates.

d(1:3,:)

%%
% |d| is a |timetable| that contains these columns:
%
% * |date| -- Date
% * |DMI_PLUS| -- Prices in plus DI line
% * |DMI_MINUS| -- Prices in minus DI line 
% * |ADX| -- Average Directional Index values
% * |ADXR| -- Average Directional Movement Index Rating values

%%
% Close the Bloomberg connection.

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.