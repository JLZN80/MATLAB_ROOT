%% Create an Order Using IB Trader Workstation 
% Create a connection to the IB Trader Workstation&#8480; and create a
% market order based on historical and current data for a security. You can
% also create orders for a different instrument, such as a futures
% contract.
%
% Before creating the connection, you must enter your credentials and run
% the IB Trader Workstation&#8480; application.
%
% To run this example, you must have the Financial Toolbox(TM) installed.

%% Run IB Trader Workstation&#8480; Application
% Ensure the IB Trader Workstation&#8480; application is running, and that
% API connections are enabled. Follow these steps in IB Trader
% Workstation&#8480;.
%%
% # To open the Trader Workstation Configuration (Simulated Trading) dialog
% box, select *File* > *Global Configuration*. 
% # Select *API* > *Settings*. 
% # Ensure that the *Enable ActiveX and Socket Clients* check box
% is selected.

%% Connect to IB Trader Workstation&#8480;
% Connect to the IB Trader Workstation&#8480; and create connection |ib|
% using the local host and default port number |7496|.

ib = ibtws('',7496);
%%
% When the |Accept incoming connection attempt| message appears in the IB
% Trader Workstation&#8480;, click *Yes*.

%% Retrieve Historical and Current Data
% Create the IB Trader Workstation&#8480; |IContract| object |ibContract|.
% This object specifies the security. Retrieve data for Microsoft(R)
% stock. Specifying |SMART| as the exchange lets Interactive Brokers(R)
% determine which venue to use for data retrieval. To clarify any
% ambiguity, set the primary exchange for the destination to |NASDAQ|. To
% retrieve dollar-denominated stock, set the currency type to |USD|.
% Setting currency type is useful when stocks are dual-listed or
% multi-listed across different jurisdictions.
ibContract = ib.Handle.createContract;
ibContract.symbol = 'MSFT';
ibContract.secType = 'STK';
ibContract.exchange = 'SMART';
ibContract.primaryExchange = 'NASDAQ';
ibContract.currency = 'USD';

%%
% Define the date range for the last 20 business days, excluding today.
% To calculate the appropriate start and end dates, this code uses the
% |daysadd| function from Financial Toolbox(TM).
bizDayConvention = 13; % i.e. BUS/252
currentdate = today;
startDate = daysadd(currentdate,-20,bizDayConvention);
endDate = daysadd(currentdate,-1,bizDayConvention);

%%
% Retrieve historical data for the last 20 business days.
histTradeData = history(ib,ibContract,startDate,endDate);

%%
% The |history| function accepts additional parameters that let you obtain
% other historical data such as option-implied volatility, historical
% volatility, bid prices, ask prices, or midpoints. If you do not specify
% anything, last traded prices return by default.

%%
% Retrieve current price data from the contract.
currentData = getdata(ib,ibContract)

%% Create Trade Market Order 
% The IB Trader Workstation&#8480; supports various order types, including
% basic types such as limit orders, stop orders, and market orders. 
%
% Create the IB Trader Workstation&#8480; |Iorder| object |ibMktOrder|.
% This object specifies the order. To buy shares, specify the action |BUY|.
% To specify buying 100 shares, set |totalQuantity| to 100. To create a
% market order, specify the order type as |MKT|.
ibMktOrder = ib.Handle.createOrder;
ibMktOrder.action = 'BUY';
ibMktOrder.totalQuantity = 100;
ibMktOrder.orderType = 'MKT';

%%
% Set a unique order identifier and send the order to Interactive
% Brokers(R).
id = orderid(ib);

result = createOrder(ib,ibContract,ibMktOrder,id)

%% Specify Different Instrument
% You can trade various instruments using the IB Trader Workstation&#8480;
% API, including equities, futures, options, futures options, and foreign
% currencies.
%
% |ibFutures| is the E-mini Standard and Poor's 500 futures contract on the
% CME Globex with a December 2013 expiry. Specify the symbol as |ES|, the
% security type as a futures contract |FUT|, the expiry as a |YYYYMM| date
% format, the exchange as |GLOBEX|, and the currency as |USD|.
ibFutures = ib.Handle.createContract;
ibFutures.symbol = 'ES';
ibFutures.secType = 'FUT';
ibFutures.expiry = '201312'; % Dec 2013
ibFutures.exchange = 'GLOBEX';
ibFutures.currency = 'USD';

%%
% Retrieve futures data and send orders using the |getdata| and
% |createOrder| functions.

%% Close IB Trader Workstation&#8480; Connection
close(ib)


%% 
% Copyright 2012 The MathWorks, Inc.