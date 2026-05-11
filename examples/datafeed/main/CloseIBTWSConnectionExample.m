%% Close IB Trader Workstation&#8480; Connection 
% Create an IB Trader Workstation&#8480; connection on the local machine,
% request current data for a security, and close the connection.
%
% Connect to the IB Trader Workstation&#8480; using port number |7496|.

ib = ibtws('',7496)

%%
% MATLAB(R) returns |ib| as the IB Trader Workstation&#8480; connection
% with the Interactive Brokers(R) ActiveX(R) object, the local host, and
% the specified port number.

%%
% Display the |Handle| property of |ib|.

ib.Handle

%% 
% Create the IB Trader Workstation&#8480; |IContract| object for IBM(R).
% This object describes a security with these property values:
%%
% * Security symbol
% * Stock security type
% * Aggregate exchange
% * Primary exchange
% * USD currency

ibContract = ib.Handle.createContract;
ibContract.symbol = 'IBM';
ibContract.secType = 'STK';
ibContract.exchange = 'SMART';
ibContract.primaryExchange = 'IEX';
ibContract.currency = 'USD';

%%
% Request current data using |ibContract|.

d = getdata(ib,ibContract)

%%
% |d| is a structure containing these fields: 
%%
% * BID_PRICE -- Bid price
% * BID_SIZE -- Bid size
% * ASK_PRICE -- Ask price
% * ASK_SIZE -- Ask size
% * LAST_PRICE -- Last price
% * LAST_SIZE -- Last size
% * VOLUME -- Volume

%%
% Display the data in the |BID_PRICE| field of |d|.

d.BID_PRICE

%%
% Close the IB Trader Workstation&#8480; connection.

close(ib)


%% 
% Copyright 2012 The MathWorks, Inc.