%% Request Interactive Brokers(R) Contract Details
%
% Create the IB Trader Workstation&#8480; connection |ib| on the local
% machine using port number |7496|.

ib = ibtws('',7496);

%% 
% Create the IB Trader Workstation&#8480; |IContract| object |ibContract|.
% This object describes a security with these property values:
%%
% * Google(R) symbol
% * Stock security type
% * Aggregate exchange
% * Primary exchange
% * USD currency
%
% |IEX| is a sample primary exchange name. Substitute your primary exchange
% name for |ibContract.primaryExchange|.

ibContract = ib.Handle.createContract;
ibContract.symbol = 'GOOG';
ibContract.secType = 'STK';
ibContract.exchange = 'SMART';
ibContract.primaryExchange = 'IEX';
ibContract.currency = 'USD';

%%
% For details about the |IContract| object, see the 
% <https://www.interactivebrokers.com/en/software/api/api.htm _Interactive
% Brokers(R) API Reference Guide_>.

%%
% Request contract details data using |ib| and |ibContract|. 

[d,reqid] = contractdetails(ib,ibContract);

%%
% |d| is a structure containing the contract details data. For details
% about this data, see the
% <https://www.interactivebrokers.com/en/software/api/api.htm _Interactive
% Brokers(R) API Reference Guide_>.
%
% |reqid| is a number that Interactive Brokers(R) uses to track this 
% contract details data request.
%%
% Display the market name from the contract details data.

d.marketName

%%
% Display the request identifier.

reqid

%%
% Close the IB Trader Workstation&#8480; connection.

close(ib)


%% 
% Copyright 2012 The MathWorks, Inc.