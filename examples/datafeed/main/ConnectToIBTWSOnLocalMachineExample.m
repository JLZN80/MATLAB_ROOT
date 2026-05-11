%% Connect to IB Trader Workstation on Local Machine 
% Create an IB Trader Workstation&#8480; connection on the local machine and
% request current data for the IBM(R) security.  
%
% Connect to the IB Trader Workstation using port number |7496|.

ib = ibtws('',7496)

%%
% MATLAB(R) returns |ib| as the IB Trader Workstation connection with the
% Interactive Brokers(R) ActiveX(R) object, local host, and specified port
% number.

%%
% Display the |Handle| property of |ib|.

ib.Handle

%% 
% Create the IB Trader Workstation |IContract| object for IBM.
% This object describes a security with values for these properties:
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
% Format output data for currency.

format bank

%%
% Request current data using |ibContract|.

d = getdata(ib,ibContract)

%%
% Display the data in the |BID_PRICE| field of the structure |d|.

d.BID_PRICE

%%
% Close the IB Trader Workstation connection.

close(ib)

%% 
% Copyright 2012 The MathWorks, Inc.