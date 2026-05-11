%% Date and Time Range with Interval
% Use Bloomberg(R) to retrieve raw trade tick data by specifying a time
% range for each day in a specific date range. Specify the time interval
% for the tick data.

%% 
% Create the Bloomberg(R) connection.
c = blp;

%%
% Alternatively, you can connect to Bloomberg(R) Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg(R) B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.

%%
% Retrieve the trade tick series for the |'F US Equity'| security for the
% last two days. Use the time range from the beginning of the trading day
% through noon. Retrieve tick data aggregated into 5-minute intervals. |d|
% is a numeric matrix.

s = 'F US Equity';
startdate = datetime('today')-1;
enddate = datetime('today');
starttime = "09:30:00";
endtime = "12:00:00";
interval = 5;

d = timeseries(c,s,{startdate:enddate,starttime,endtime},interval);

%% 
% Set the display output for currency.
format bank

%%
% Display the first three ticks.
d(1:3,:)

%%
% The columns in |d| are:
%%
% * Numeric representation of date and time
% * Open price
% * High price
% * Low price
% * Closing price
% * Volume of ticks
% * Number of ticks
% * Total tick value in the bar
% 

%%
% The first row shows tick data at the start time of the time range. The
% next row shows tick data for 5 minutes later.

%% 
% Determine the maximum high price for the last two days.

highprices = d(:,3);
m = max(highprices)

%%
% Close the Bloomberg(R) connection.
close(c)


%% 
% Copyright 2012 The MathWorks, Inc.