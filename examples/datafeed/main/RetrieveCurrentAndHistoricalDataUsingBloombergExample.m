%% Retrieve Current and Historical Data Using Bloomberg 
% This example shows how to connect to Bloomberg(R) and retrieve current
% and historical Bloomberg(R) market data. For details about Bloomberg(R)
% connection requirements, see <docid:datafeed_ug.bq4htf5 Data Server Connection Requirements>. To ensure a
% successful Bloomberg connection, perform the required steps before
% executing a connection function. For details, see
% <docid:datafeed_ug.bu78as5 Installing Bloomberg and Configuring Connections>.

%% Connect to Bloomberg(R)
% Create a Bloomberg(R) Desktop connection.

c = blp;

%%
% Alternatively, you can connect to the Bloomberg(R) Server using
% <docid:datafeed_ug.buh1qu6-1 blpsrv> or Bloomberg(R) B-PIPE(R) using
% <docid:datafeed_ug.bue5d9y-1 bpipe>.

%% Retrieve Current Data
% Format MATLAB(R) data display for currency.

format bank

%%
% Retrieve closing and open prices for Microsoft(R).

sec = 'MSFT US Equity';
fields = {'LAST_PRICE';'OPEN'}; % closing and open prices

[d,sec] = getdata(c,sec,fields)

%%
% |d| contains the Bloomberg(R) closing and open prices. |sec| contains the
% Bloomberg(R) security name for Microsoft(R).

%% Retrieve Historical Data
% Retrieve monthly closing and open price data from January 1, 2012 through
% December 31, 2012 for Microsoft(R).

fromdate = '1/01/2012'; % beginning of date range for historical data
todate = '12/31/2012'; % ending of date range for historical data
period = 'monthly'; % retrieve monthly data

[d,sec] = history(c,sec,fields,fromdate,todate,period)

%%
% |d| contains the numeric representation of the date in the first column,
% closing price in the second column, and open price in the third column.
% Each row represents data for one month in the date range. |sec| contains
% the Bloomberg(R) security name for Microsoft(R).

%% Find Maximum Open Price in Date Range
% Calculate the maximum open price for the year 2012. 

openprices = d(:,3); % retrieve all open prices in date range
max(openprices) % calculate maximum open price

%% Close Bloomberg(R) Connection

close(c)


%% 
% Copyright 2012 The MathWorks, Inc.